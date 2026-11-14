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
    the service ends; each close alone in its try (a failing one does not stop the others), the fields are left as they are.
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
        if mem == "close()V" and cls.startswith("Lcom/mrkeyboard/app/"):
            self.calls.append("close " + cls.split("/")[-1].rstrip(";"))
            if cls in self.fail_close:
                raise dm.JavaExc("Ljava/lang/IllegalStateException;", "close failed")
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


svc = ime()
h.run("mrCloseEngine()V", svc)
check("the engine, the automatic dictionary and the bigram dictionary are closed, once each, in that order",
      h.calls == ["close Suggest", "close AutoDictionary", "close UserBigramDictionary"], h.calls)
check("... the fields are left as they are (a closed engine answers nothing; a reader of the dead service finds an engine, not a null)",
      svc.f["mSuggest"] is not None and svc.f["mAutoDictionary"] is not None and svc.f["mUserBigramDictionary"] is not None)
for name, cls in (("the engine", SUG), ("the automatic dictionary", AUTO), ("the bigram dictionary", BIG)):
    h.calls = []
    h.fail_close = {cls}
    svc = ime()
    h.run("mrCloseEngine()V", svc)
    others = [c for c in ("close Suggest", "close AutoDictionary", "close UserBigramDictionary") if not c.endswith(cls.split("/")[-1].rstrip(";"))]
    check("%s fails to close: nothing goes up and the other two are still closed" % name,
          all(o in h.calls for o in others) and len(h.calls) == 3, h.calls)
h.fail_close = set()
h.calls = []
h.run("mrCloseEngine()V", ime(suggest=False, auto=False, big=False))
check("nothing built yet (the service ended before initSuggest): no call, no error", h.calls == [], h.calls)
h.run("mrCloseEngine()V", ime(suggest=False))
check("no engine, the dictionaries are closed", h.calls == ["close AutoDictionary", "close UserBigramDictionary"], h.calls)

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

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
