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

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
