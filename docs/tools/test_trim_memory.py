#!/usr/bin/env python3
"""Tests the memory cleanup of the keyboard (stage 4 of docs/plan-performance.md): LatinIME.onTrimMemory, the closing of the engine in
LatinIME.onDestroy, KeyboardSwitcher.dropUnused and LatinKeyboardBaseView.trimCaches. (The shadows are in test_shadow_cache.py and the
decision by level in PerfTest.java: MrTrim.)

Run it from the project root:  python3 -I docs/tools/test_trim_memory.py

Part 1 runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework. Part 2 reads the smali for the shape
of the change (the order in onDestroy, that the system call goes up first and the hook never throws into it).
The rules:
  - onTrimMemory asks the system class first (super), then MrTrim.onTrim(level) alone: the levels are decided there;
  - dropUnused lets go of every keyboard but the one on screen (the map keeps that one, so what is kept for it is found again) and
    says how many it let go; with no keyboard on screen it lets go of all;
  - trimCaches clears the three maps of popups, drops the measures of the labels and the text heights, and says how many popups were
    kept; the view made them again when it needs them (the label measures are made when null);
  - onDestroy closes the engine, the automatic dictionary and the bigram dictionary after the receivers are unregistered and before
    the service ends; each close alone in its try (a failing one does not stop the others), the fields are left as they are;
  - part 2: that same closing then lets go of what the engine leaves in statics (MrFuzzy.release: the search kept for the main
    dictionary holds its direct buffer; MrGestureWords.release: the copy of the person's words), each alone in its try, even when
    there is no engine; initSuggest does the first one right after it closes the old engine, and MrTools.release (the tools'
    cleanup at the end of the service) closes the Preferences dialog before it lets go of sIme and sets up MrFonts with no view.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def methods(smali, wanted):
    allm = dm.parse_methods(os.path.join(APP, smali))
    got = {k: v for k, v in allm.items() if k in wanted}
    assert len(got) == len(wanted), (sorted(got), wanted)
    return got


class Host:
    """The fake framework: maps with size/get/put/clear, and the calls of everything else are written down."""

    def __init__(self, cls, wanted, smali):
        self.vm = dm.VM(cls, methods(smali, wanted), self)
        self.calls = []
        self.fail_close = set()     # classes whose close() throws

    def sget(self, cls, name):
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return obj is not None and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        a0 = args[0] if args else None
        if cls == "Ljava/util/HashMap;":
            d = a0.f["d"]
            if mem == "size()I":
                return len(d)
            if mem == "get(Ljava/lang/Object;)Ljava/lang/Object;":
                return d.get(args[1])
            if mem == "clear()V":
                a0.f["cleared"] = a0.f.get("cleared", 0) + 1
                d.clear()
                return None
            if mem == "put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;":
                d[args[1]] = args[2]
                return None
        if cls == "Ljava/util/WeakHashMap;":
            if mem == "size()I":
                return a0.f["n"]
            if mem == "clear()V":
                a0.f["n"] = 0
                a0.f["cleared"] = a0.f.get("cleared", 0) + 1
                return None
        if mem in ("close()V", "release()V") and cls.startswith("Lcom/mrkeyboard/app/"):
            self.calls.append(mem[:-3] + " " + cls.split("/")[-1].rstrip(";"))
            if cls in self.fail_close:
                raise dm.JavaExc("Ljava/lang/IllegalStateException;", "%s failed" % mem[:-3])
            return None
        if mem.startswith("onTrimMemory("):      # invoke-super: the first argument is the service
            self.calls.append("onTrimMemory(%s)" % ",".join(str(x) for x in args[1:]))
        elif mem.startswith("onTrim("):         # invoke-static: the level only
            self.calls.append("onTrim(%s)" % ",".join(str(x) for x in args))
        else:
            self.calls.append(mem.split("(")[0])
        return None

    def run(self, key, *args):
        return self.vm.run(key, list(args))


# ---------------------------------------------------------------- 1. KeyboardSwitcher.dropUnused
KS = "Lcom/mrkeyboard/app/KeyboardSwitcher;"
h = Host(KS, ("dropUnused()I",), "KeyboardSwitcher.smali")


def switcher(keys, current):
    m = dm.Obj("Ljava/util/HashMap;", d={k: "ref-" + k for k in keys})
    h.vm.statics["sInstance"] = dm.Obj(KS, mKeyboards=m, mCurrentId=current)
    return m


m = switcher(["abc", "sym", "num", "phone"], "abc")
n = h.run("dropUnused()I")
check("four keyboards, one on screen: three are let go", n == 3, n)
check("... the one on screen stays in the map, with its own reference", m.f["d"] == {"abc": "ref-abc"}, m.f["d"])
m = switcher(["abc"], "abc")
check("only the one on screen: nothing to let go", h.run("dropUnused()I") == 0 and m.f["d"] == {"abc": "ref-abc"})
m = switcher(["sym", "num"], "abc")
check("the one on screen is not in the map (never built, or collected): all go, and it is not put back", h.run("dropUnused()I") == 2 and m.f["d"] == {})
m = switcher(["sym", "num"], None)
check("no keyboard on screen at all: all go", h.run("dropUnused()I") == 2 and m.f["d"] == {})
m = switcher([], "abc")
check("empty map: 0", h.run("dropUnused()I") == 0 and m.f["d"] == {})

# ---------------------------------------------------------------- 2. LatinKeyboardBaseView.trimCaches
VIEW = "Lcom/mrkeyboard/app/LatinKeyboardBaseView;"
h = Host(VIEW, ("trimCaches()I", "clearPopupCaches()V"), "LatinKeyboardBaseView.smali")
h.vm.statics["sPopupEpoch"] = 7


def new_view():
    maps = {n_: dm.Obj("Ljava/util/WeakHashMap;", n=c) for n_, c in (("Main", 4), ("Shift", 2), ("Caps", 1))}
    v = dm.Obj(VIEW, mPopupEpoch=3, mMiniKeyboardCacheMain=maps["Main"], mMiniKeyboardCacheShift=maps["Shift"],
               mMiniKeyboardCacheCaps=maps["Caps"], mLabelMetricsCache="cache", mTextHeightCache=dm.Obj("Ljava/util/HashMap;", d={"a": 1}))
    v.maps = maps
    return v


v = new_view()
n = h.run("trimCaches()I", v)
check("trimCaches says how many popups were kept (4 + 2 + 1)", n == 7, n)
check("... the three maps are cleared once each", [v.maps[k].f["cleared"] for k in ("Main", "Shift", "Caps")] == [1, 1, 1])
check("... the measures of the labels are dropped (made again when null)", v.f["mLabelMetricsCache"] in (None, 0), v.f["mLabelMetricsCache"])
check("... the text heights are cleared", v.f["mTextHeightCache"].f["d"] == {})
check("... the view takes the number of the last change of the settings (the popups it has are of it)", v.f["mPopupEpoch"] == 7, v.f["mPopupEpoch"])
check("a second trim on the empty view: 0 popups, still no error", h.run("trimCaches()I", v) == 0)

# ---------------------------------------------------------------- 3. LatinIME.mrCloseEngine and onTrimMemory
IME = "Lcom/mrkeyboard/app/LatinIME;"
h = Host(IME, ("mrCloseEngine()V", "onTrimMemory(I)V"), "LatinIME.smali")
SUG, AUTO, BIG = "Lcom/mrkeyboard/app/Suggest;", "Lcom/mrkeyboard/app/AutoDictionary;", "Lcom/mrkeyboard/app/UserBigramDictionary;"


def ime(suggest=True, auto=True, big=True):
    return dm.Obj(IME, mSuggest=dm.Obj(SUG) if suggest else None, mAutoDictionary=dm.Obj(AUTO) if auto else None,
                  mUserBigramDictionary=dm.Obj(BIG) if big else None)


FUZZY, WORDS = "Lcom/mrkeyboard/app/MrFuzzy;", "Lcom/mrkeyboard/app/MrGestureWords;"
CLOSES = ["close Suggest", "close AutoDictionary", "close UserBigramDictionary"]
RELEASES = ["release MrFuzzy", "release MrGestureWords"]

svc = ime()
h.run("mrCloseEngine()V", svc)
check("the engine, the automatic dictionary and the bigram dictionary are closed, once each, in that order",
      h.calls[:3] == CLOSES, h.calls)
check("... then what the engine leaves in statics is let go: the search kept for the dictionary, the copy of the person's words",
      h.calls == CLOSES + RELEASES, h.calls)
check("... the fields are left as they are (a closed engine answers nothing; a reader of the dead service finds an engine, not a null)",
      svc.f["mSuggest"] is not None and svc.f["mAutoDictionary"] is not None and svc.f["mUserBigramDictionary"] is not None)
for name, cls in (("the engine", SUG), ("the automatic dictionary", AUTO), ("the bigram dictionary", BIG)):
    h.calls = []
    h.fail_close = {cls}
    svc = ime()
    h.run("mrCloseEngine()V", svc)
    others = [c for c in CLOSES if not c.endswith(cls.split("/")[-1].rstrip(";"))]
    check("%s fails to close: nothing goes up, the other two are still closed and the statics still let go" % name,
          all(o in h.calls for o in others + RELEASES) and len(h.calls) == 5, h.calls)
for name, cls in (("the search kept for the dictionary", FUZZY), ("the copy of the words", WORDS)):
    h.calls = []
    h.fail_close = {cls}
    svc = ime()
    h.run("mrCloseEngine()V", svc)
    check("%s fails to let go: nothing goes up and the other one is let go as well" % name,
          h.calls == CLOSES + RELEASES, h.calls)
h.fail_close = set()
h.calls = []
h.run("mrCloseEngine()V", ime(suggest=False, auto=False, big=False))
check("nothing built yet (the service ended before initSuggest): nothing to close, the statics are let go all the same, no error",
      h.calls == RELEASES, h.calls)
h.calls = []
h.run("mrCloseEngine()V", ime(suggest=False))
check("no engine, the dictionaries are closed and the statics let go", h.calls == CLOSES[1:] + RELEASES, h.calls)

h.calls = []
h.run("onTrimMemory(I)V", ime(), 40)
check("onTrimMemory: the system class first, then MrTrim.onTrim with the level", h.calls == ["onTrimMemory(40)", "onTrim(40)"], h.calls)

# ---------------------------------------------------------------- 4. the shape of the smali
src = open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read()


def body(name):
    m = re.search(r"^\.method [^\n]*" + re.escape(name) + r"\n(.*?)^\.end method", src, re.S | re.M)
    assert m, name
    return [l.strip() for l in m.group(1).split("\n") if l.strip() and not l.strip().startswith(("#", ".line"))]


d = body("onDestroy()V")
idx = {k: next(i for i, l in enumerate(d) if k in l) for k in ("mUserDictionary:Lcom/mrkeyboard/app/UserDictionary;", "mReceiver", "mPluginManager",
                                                                 "mrCloseEngine", "InputMethodService;->onDestroy()V")}
check("onDestroy: the engine is closed after the receivers are unregistered and right before the service ends",
      idx["mReceiver"] < idx["mPluginManager"] < idx["mrCloseEngine"] < idx["InputMethodService;->onDestroy()V"]
      and sum("mrCloseEngine" in l for l in d) == 1, idx)
check("... the user dictionary is still closed as before", sum("UserDictionary;->close()V" in l for l in d) == 1)
t = body("onTrimMemory(I)V")
check("onTrimMemory is public, calls the system class and then only MrTrim.onTrim(I)V",
      re.search(r"^\.method public onTrimMemory\(I\)V", src, re.M) is not None
      and [l for l in t if l.startswith("invoke")] == ["invoke-super {p0, p1}, Landroid/inputmethodservice/InputMethodService;->onTrimMemory(I)V",
                                                        "invoke-static {p1}, Lcom/mrkeyboard/app/MrTrim;->onTrim(I)V"], t)
check("the engine is closed in only one place besides initSuggest (the new helper)",
      len(re.findall(r"Lcom/mrkeyboard/app/Suggest;->close\(\)V", src)) == 2, len(re.findall(r"Suggest;->close\(\)V", src)))

# initSuggest: the search kept for the old dictionary goes right after the old engine is closed, alone in a try that never stops it
s = body("initSuggest(Ljava/lang/String;)V")
ic = next(i for i, l in enumerate(s) if l.endswith("Lcom/mrkeyboard/app/Suggest;->close()V"))
fz = [i for i, l in enumerate(s) if l.endswith("Lcom/mrkeyboard/app/MrFuzzy;->release()V")]
check("initSuggest: MrFuzzy.release() once, right after the old engine is closed, inside a try that catches Throwable",
      len(fz) == 1 and fz[0] == ic + 2 and s[ic + 1] == ":try_fuzzy" and s[fz[0] + 1] == ":try_fuzzy_end"
      and s[fz[0] + 2] == ".catch Ljava/lang/Throwable; {:try_fuzzy .. :try_fuzzy_end} :catch_fuzzy", (ic, fz))
cc = next(i for i, l in enumerate(s) if l == ":catch_fuzzy")
check("... a failure there lands before the code that goes on (:cond_0) and the normal path jumps over the handler",
      s[fz[0] + 3] == "goto :cond_0" and s[cc + 1].startswith("move-exception") and s[cc + 2] == ":cond_0", s[fz[0] + 3:cc + 3])
check("... and the two releases of mrCloseEngine come after its three closes and before it returns",
      [l.split(", ")[-1] for l in body("mrCloseEngine()V") if "->release()V" in l or "->close()V" in l]
      == ["Lcom/mrkeyboard/app/Suggest;->close()V", "Lcom/mrkeyboard/app/AutoDictionary;->close()V",
          "Lcom/mrkeyboard/app/UserBigramDictionary;->close()V", "Lcom/mrkeyboard/app/MrFuzzy;->release()V",
          "Lcom/mrkeyboard/app/MrGestureWords;->release()V"])

# MrTools.release: the Preferences dialog is closed first (it needs sIme), then everything is let go; fonts last, with no view
tools = open(os.path.join(APP, "MrTools.smali"), encoding="utf-8").read()
m = re.search(r"^\.method static release\(Lcom/mrkeyboard/app/LatinIME;\)V\n(.*?)^\.end method", tools, re.S | re.M)
assert m
r = [l.strip() for l in m.group(1).split("\n") if l.strip() and not l.strip().startswith(("#", ".line"))]
first_ime_put = next(i for i, l in enumerate(r) if l.endswith("Lcom/mrkeyboard/app/MrTools;->sIme:Lcom/mrkeyboard/app/LatinIME;") and l.startswith("sput"))
guard = next(i for i, l in enumerate(r) if l.startswith("if-ne v0, p0, :done"))
dd = [i for i, l in enumerate(r) if l.endswith("Lcom/mrkeyboard/app/MrTune;->dismissDialog()V")]
check("MrTools.release: the Preferences dialog is closed once, right after the guard of the service and before sIme is let go",
      len(dd) == 1 and dd[0] == guard + 1 and dd[0] < first_ime_put, (guard, dd, first_ime_put))
mf = [i for i, l in enumerate(r) if l.endswith("Lcom/mrkeyboard/app/MrFonts;->setup(Landroid/view/View;)V")]
zero = max(i for i, l in enumerate(r) if l == "const/4 v0, 0x0")
check("MrTools.release: fonts are set up with no view (v0, still the zero constant) after the emoji search and before the end",
      len(mf) == 1 and mf[0] > zero and r[mf[0]].startswith("invoke-static {v0},")
      and all(not re.match(r"^(const\S*|sget\S*|move\S*|new-\S+|iget\S*|add-\S+) v0\b", l) for l in r[zero + 1:mf[0]])
      and any(l.endswith("MrEmojiSearch;->setup(Landroid/view/View;)V") for l in r[zero + 1:mf[0]]) and r[-1] == "return-void", (zero, mf))

# MrLive (build _84): the service and the input view are registered where they are made, and the row that frees memory counts after its collection
live_calls = {}
for f in sorted(os.listdir(APP)):
    if f.endswith(".smali") and f != "MrLive.smali":
        t_ = open(os.path.join(APP, f), encoding="utf-8").read()
        for what in ("service", "view", "measure", "forget"):
            n_ = t_.count("Lcom/mrkeyboard/app/MrLive;->%s(" % what)
            if n_:
                live_calls.setdefault(what, []).append((f, n_))
check("MrLive: the service is registered in one place only, LatinIME.onCreate; the view in KeyboardSwitcher; measure in MrPerf$Trim; forget in MrPerf",
      live_calls == {"service": [("LatinIME.smali", 1)], "view": [("KeyboardSwitcher.smali", 1)], "measure": [("MrPerf$Trim.smali", 1)],
                     "forget": [("MrPerf.smali", 1)]}, live_calls)
oc = body("onCreate()V")
i_put = next(i for i, l in enumerate(oc) if l == "sput-object p0, Lcom/mrkeyboard/app/LatinIME;->sInstance:Lcom/mrkeyboard/app/LatinIME;")
check("LatinIME.onCreate: the service is registered with no register used (p0), right after the instance is set, so it is a live service",
      oc[i_put + 1] == "invoke-static {p0}, Lcom/mrkeyboard/app/MrLive;->service(Ljava/lang/Object;)V"
      and oc.index("invoke-static {p0}, Lcom/mrkeyboard/app/MrLive;->service(Ljava/lang/Object;)V") == i_put + 1, oc[i_put:i_put + 3])
ks = open(os.path.join(APP, "KeyboardSwitcher.smali"), encoding="utf-8").read()
mk = re.search(r"^\.method private changeLatinKeyboardView\(IZ\)V\n(.*?)^\.end method", ks, re.S | re.M)
assert mk
kb = [l.strip() for l in mk.group(1).split("\n") if l.strip() and not l.strip().startswith(("#", ".line"))]
i_view = next(i for i, l in enumerate(kb) if l == "iput-object v1, p0, Lcom/mrkeyboard/app/KeyboardSwitcher;->mInputView:Lcom/mrkeyboard/app/LatinKeyboardView;")
check("KeyboardSwitcher: the input view just inflated (v1) is registered right after it is stored, still inside the try of the inflation",
      kb[i_view + 1] == "invoke-static {v1}, Lcom/mrkeyboard/app/MrLive;->view(Ljava/lang/Object;)V" and kb[i_view + 2] == ":try_end_0", kb[i_view:i_view + 3])
tr = open(os.path.join(APP, "MrPerf$Trim.smali"), encoding="utf-8").read()
mt = re.search(r"^\.method public onPreferenceClick\(Landroid/preference/Preference;\)Z\n(.*?)^\.end method", tr, re.S | re.M)
assert mt
tc = [l.strip().split(", ")[-1] for l in mt.group(1).split("\n") if l.strip().startswith("invoke-")]
check("MrPerf$Trim: the cleanup, the collection, the count of what is alive, and only then the meter is shown again",
      [x for x in tc if "MrTrim;->onTrim" in x or "System;->gc" in x or "MrLive;->measure" in x or "MrPerf;->summary" in x] == [
          "Lcom/mrkeyboard/app/MrTrim;->onTrim(I)V", "Ljava/lang/System;->gc()V", "Lcom/mrkeyboard/app/MrLive;->measure()V",
          "Lcom/mrkeyboard/app/MrPerf;->summary(Landroid/content/Context;)Ljava/lang/String;"], tc)
lv = open(os.path.join(APP, "MrLive.smali"), encoding="utf-8").read()
check("MrLive holds the objects only by weak references (so it cannot be what keeps them alive)",
      "Ljava/lang/ref/WeakReference;" in lv and ".field private static final sServiceRefs:Ljava/util/ArrayList;" in lv
      and ".field private static final sViewRefs:Ljava/util/ArrayList;" in lv
      and all(".method static declared-synchronized %s(" % m in lv for m in ("service", "view", "measure", "forget")), None)

# ---------------------------------------------------------------- 5. build _85: what a service that ended points to (LatinIME.mrDropViews)
# The system can keep a service that ended alive for a while; what the service points to stays with it: the keyboard in the input frame of
# its window, the strip of suggestions. The service lets go of both at the end of onDestroy, after the super.
VIEW = "Landroid/view/View;"


class DropHost(Host):
    fail_set = False

    def invoke(self, vm, op, target, args):
        if target.endswith("InputMethodService;->setInputView(Landroid/view/View;)V"):
            self.calls.append(("setInputView", op, args[1].cls if args[1] is not None else None))
            if self.fail_set:
                raise dm.JavaExc("Ljava/lang/IllegalStateException;", "no input frame")
            return None
        return Host.invoke(self, vm, op, target, args)


dh = DropHost(IME, ("mrDropViews()V",), "LatinIME.smali")
svc = dm.Obj(IME, mCandidateView=dm.Obj("Lcom/mrkeyboard/app/CandidateView;"), mCandidateViewContainer=dm.Obj("Landroid/widget/LinearLayout;"))
dh.run("mrDropViews()V", svc)
check("mrDropViews: the strip of suggestions and its container are let go", svc.f["mCandidateView"] in (None, 0) and svc.f["mCandidateViewContainer"] in (None, 0),
      (svc.f["mCandidateView"], svc.f["mCandidateViewContainer"]))
check("... and the input view is replaced by an empty View, through the super's setInputView (the override would wrap it again)",
      dh.calls == ["<init>", ("setInputView", "invoke-super", VIEW)], dh.calls)
dh.calls = []
dh.fail_set = True
svc = dm.Obj(IME, mCandidateView=dm.Obj("Lcom/mrkeyboard/app/CandidateView;"), mCandidateViewContainer=dm.Obj("Landroid/widget/LinearLayout;"))
dh.run("mrDropViews()V", svc)
check("a system version that refuses setInputView after the end: nothing goes up (the end of the service is never stopped)",
      svc.f["mCandidateView"] in (None, 0) and svc.f["mCandidateViewContainer"] in (None, 0) and dh.calls[-1][0] == "setInputView", dh.calls)
d = body("onDestroy()V")
call = [i for i, l in enumerate(d) if l.endswith("LatinIME;->mrDropViews()V")]
check("onDestroy: mrDropViews is called once, after the super's onDestroy (the window is gone) and right before it returns",
      len(call) == 1 and call[0] == idx["InputMethodService;->onDestroy()V"] + 1 and d[call[0] + 1] == "return-void", (call, idx))
check("... and mrDropViews is private, with the try that catches Throwable around the only call that leaves the app",
      re.search(r"^\.method private mrDropViews\(\)V", src, re.M) is not None
      and [l for l in body("mrDropViews()V") if l.startswith(".catch")] == [".catch Ljava/lang/Throwable; {:try_drop .. :try_drop_end} :catch_drop"], None)

# the classes MrLive starts its search from (ROOTS) are all the classes of the app that have a static variable that holds an object:
# one that is missing would be a place the search never looks at, so a holder in it would be reported as "the system"
roots_java = open(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrLive.java"), encoding="utf-8").read()
declared = set(re.findall(r'"([A-Za-z0-9_$]+)"', re.search(r"ROOTS = \{(.*?)\};", roots_java, re.S).group(1)))
skip_types = {"Ljava/lang/String;", "Ljava/lang/Integer;", "Ljava/lang/Long;", "Ljava/lang/Boolean;", "Ljava/lang/Float;", "Ljava/lang/Double;",
              "Ljava/lang/Class;", "Ljava/util/regex/Pattern;", "Ljava/util/Locale;", "Ljava/lang/CharSequence;", "Ljava/lang/Character;",
              "Ljava/lang/Short;", "Ljava/lang/Byte;"}
needed = set()
for f in sorted(os.listdir(APP)):
    if not f.endswith(".smali"):
        continue
    t_ = open(os.path.join(APP, f), encoding="utf-8").read()
    for fm in re.finditer(r"^\.field ([\w ]*?)(\w+):(\S+)", t_, re.M):
        ty = fm.group(3)
        if "static" in fm.group(1).split() and ty[0] in "L[" and ty not in skip_types and not re.match(r"^\[+[ZBSCIJFD]$", ty):
            needed.add(f[:-6])
check("MrLive.ROOTS lists every class of the app with a static variable that holds an object, and nothing else",
      declared == needed, ("missing:", sorted(needed - declared), "extra:", sorted(declared - needed)))

# the search of MrLive is the one place allowed to use reflection (docs/tools/res_check.py, REFLECT_READ_OK): it may only READ fields, and only of
# classes of the app; nothing is written, and no framework class is opened
srch = open(os.path.join(APP, "MrLive$Search.smali"), encoding="utf-8").read()
used = sorted(set(re.findall(r"Ljava/lang/reflect/Field;->(\w+)", srch)))
check("MrLive$Search uses reflection only to read (get, getModifiers, getName, getType, setAccessible), never to write a field",
      used == ["get", "getModifiers", "getName", "getType", "setAccessible"], used)
check("... and it reads the instance fields only of classes whose name starts with com.mrkeyboard. (the framework ones are left alone)",
      'const-string v1, "com.mrkeyboard."' in srch or '"com.mrkeyboard."' in srch and srch.count("startsWith") >= 2, srch.count("startsWith"))

# build _86: the gate of the learned words (MrLearned.sGate) is a static; the callback it is given (the Suggest, and through it the whole service) is
# kept only while AutoDictionary.getWords runs. The phone showed "Retido por: MrLearned.sGate > to:Suggest > mAutoDictionary > mIme:LatinIME"
# with one more service and one more keyboard alive after each switch of keyboard.
ad = open(os.path.join(APP, "AutoDictionary.smali"), encoding="utf-8").read()
gw = re.search(r"^\.method public getWords\(Lcom/mrkeyboard/app/WordComposer;[^\n]*\n(.*?)^\.end method", ad, re.S | re.M)
gl = [l.strip() for l in gw.group(1).split("\n") if l.strip() and not l.strip().startswith(("#", ".line"))]
i_gate = next(i for i, l in enumerate(gl) if "MrLearned;->gate(" in l)
i_try = gl.index(":try_start_0")
i_super = next(i for i, l in enumerate(gl) if "invoke-super" in l and "ExpandableDictionary;->getWords(" in l)
i_end = gl.index(":try_end_0")
ends = [i for i, l in enumerate(gl) if "MrLearned;->gateEnd()V" in l]
check("AutoDictionary.getWords: gate, then the search alone in a try, then gateEnd on the way out and again in the handler before it throws",
      i_gate < i_try < i_super < i_end and gl[i_super + 1] == ":try_end_0" and gl[i_end + 1].startswith(".catchall {:try_start_0 .. :try_end_0}")
      and len(ends) == 2 and ends[0] > i_end and ends[1] > ends[0] and gl[-1] == "throw v1" and gl[ends[1] + 1] == "throw v1", gl)
ml = open(os.path.join(APP, "MrLearned.smali"), encoding="utf-8").read()
ge = re.search(r"^\.method public static gateEnd\(\)V\n(.*?)^\.end method", ml, re.S | re.M)
gel = [l.strip() for l in ge.group(1).split("\n") if l.strip() and not l.strip().startswith(("#", ".line", ".prologue", ".locals"))]
check("MrLearned.gateEnd puts null in the callback of the gate (Gate.to) and does nothing else",
      gel == ["sget-object v0, Lcom/mrkeyboard/app/MrLearned;->sGate:Lcom/mrkeyboard/app/MrLearned$Gate;", "const/4 v1, 0x0",
              "iput-object v1, v0, Lcom/mrkeyboard/app/MrLearned$Gate;->to:Lcom/mrkeyboard/app/Dictionary$WordCallback;", "return-void"], gel)
sets = []
for f in sorted(os.listdir(APP)):
    if f.endswith(".smali"):
        t_ = open(os.path.join(APP, f), encoding="utf-8").read()
        sets += [f for l in t_.split("\n") if "MrLearned$Gate;->to:" in l and "iput-object" in l]
check("the callback of the gate is written only in MrLearned (gate puts it, gateEnd takes it away)", sorted(set(sets)) == ["MrLearned$Gate.smali", "MrLearned.smali"]
      or sorted(set(sets)) == ["MrLearned.smali"], sorted(set(sets)))
callers = [f for f in sorted(os.listdir(APP)) if f.endswith(".smali") and f != "MrLearned.smali" and
           "MrLearned;->gate(" in open(os.path.join(APP, f), encoding="utf-8").read()]
check("MrLearned.gate is used in one place only, AutoDictionary.getWords (the one that calls gateEnd)", callers == ["AutoDictionary.smali"], callers)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
