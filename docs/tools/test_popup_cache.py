#!/usr/bin/env python3
"""Tests that the popups of variants (the long-press popups) are kept between field opens (LatinKeyboardBaseView, stage 5 of
docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_popup_cache.py

The popup of a key is a Keyboard kept in three maps (mMiniKeyboardCacheMain/Shift/Caps), keyed by the Key. Before, every open of a
field cleared the three maps (closing() and setKeyboard()), so the first long press of each key in each field put the variants
together again. Now:
  - closing() clears them only when a setting changed since the view last looked (a number, bumped by every change of a
    preference, that each view compares with its own);
  - setKeyboard() clears them only when the keyboard is a different one from the one on the view (the same object again, the
    keyboard the field already had, keeps them) or when a setting changed;
  - a view that leaves the window (onDetachedFromWindow) clears them, so a hidden view does not hold them;
  - LatinIME.onSharedPreferenceChanged bumps the number first thing, whatever the preference.
Part 1 runs the REAL smali of these methods in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework that counts the
clear() of each map. Part 2 reads the smali for the shape of the change.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
VIEW = "Lcom/mrkeyboard/app/LatinKeyboardBaseView;"
KB = "Lcom/mrkeyboard/app/Keyboard;"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


WANTED = ("bumpPopupEpoch()V", "clearPopupCaches()V", "dropPopupCachesIfStale()V", "closing()V", "onDetachedFromWindow()V",
          "setKeyboard(" + KB + ")V")
ALL = dm.parse_methods(os.path.join(APP, "LatinKeyboardBaseView.smali"))
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
assert len(METHODS) == len(WANTED), sorted(METHODS)


class Host:
    """The fake framework: everything that is not one of the methods under test returns nothing, except what the methods read."""

    def __init__(self):
        self.vm = dm.VM(VIEW, METHODS, self)
        self.calls = []

    def new_view(self, keyboard=None):
        maps = {n: dm.Obj("Ljava/util/WeakHashMap;", cleared=0) for n in ("Main", "Shift", "Caps")}
        v = dm.Obj(VIEW, mKeyboard=keyboard, mPopupEpoch=0, mMiniKeyboardCacheMain=maps["Main"], mMiniKeyboardCacheShift=maps["Shift"],
                   mMiniKeyboardCacheCaps=maps["Caps"], mPreviewPopup=None, mHandler=dm.Obj("Handler"), mKeyDetector=dm.Obj("KeyDetector"),
                   mKeys=None, mKeyboardVerticalGap=0, mPointerTrackers=dm.Obj("Trackers"), mKeyHysteresisDistance=0.0, mLabelScale=0.0,
                   mKeyboardChanged=0, mIgnoreMove=0, mLabelMetricsCache="cache", mTextHeightCache=dm.Obj("Ljava/util/HashMap;", cleared=0))
        v.maps = maps
        return v

    # fake framework
    def sget(self, cls, name):
        if name == "sKeyboardSettings":
            return dm.Obj("Settings", labelScalePref=1.0, renderMode=0)
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return obj is not None and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if cls == "Ljava/util/WeakHashMap;" and mem == "clear()V":
            args[0].f["cleared"] += 1
            return None
        if cls == "Ljava/util/HashMap;" and mem == "clear()V":
            args[0].f["cleared"] += 1
            return None
        if cls == "Ljava/util/ArrayList;" and mem == "iterator()Ljava/util/Iterator;":
            return dm.Obj("Iterator")
        if cls == "Ljava/util/Iterator;" and mem == "hasNext()Z":
            return 0
        if cls == "Landroid/content/res/Resources;" and mem.startswith("getDimension("):
            return 0.0
        if cls == "Landroid/util/Log;" and mem.startswith("i("):
            return 0
        if cls == "Landroid/content/res/Resources;" or mem == "getResources()Landroid/content/res/Resources;":
            return dm.Obj("Landroid/content/res/Resources;")
        self.calls.append(mem.split("(")[0])
        return None

    def cleared(self, view):
        return [view.maps[n].f["cleared"] for n in ("Main", "Shift", "Caps")]

    def run(self, key, *args):
        return self.vm.run(key, list(args))


def fresh():
    h = Host()
    return h, h.new_view()


# ---------------------------------------------------------------- part 1: the real smali
h, v = fresh()
h.run("closing()V", v)
check("closing() with no setting changed: the three maps are not cleared", h.cleared(v) == [0, 0, 0], h.cleared(v))
check("... the other caches of the view (label metrics, text heights) are still dropped as before",
      v.f["mLabelMetricsCache"] in (None, 0) and v.f["mTextHeightCache"].f["cleared"] == 1)
check("... the popup of the previous field is dismissed as before", "dismissPopupKeyboard" in h.calls, h.calls)
h.run("closing()V", v); h.run("closing()V", v)
check("closing() again and again: still kept", h.cleared(v) == [0, 0, 0], h.cleared(v))

h.run("bumpPopupEpoch()V")
check("bumpPopupEpoch adds one to the number of the last change", h.vm.statics["sPopupEpoch"] == 1, h.vm.statics)
h.run("closing()V", v)
check("a setting changed: the next closing() clears the three maps, once each", h.cleared(v) == [1, 1, 1], h.cleared(v))
check("... and the view takes the new number", v.f["mPopupEpoch"] == 1, v.f["mPopupEpoch"])
h.run("closing()V", v)
check("... then they are kept again", h.cleared(v) == [1, 1, 1], h.cleared(v))
h.run("bumpPopupEpoch()V"); h.run("bumpPopupEpoch()V"); h.run("bumpPopupEpoch()V")
h.run("closing()V", v)
check("three changes before the next closing(): still one clearing", h.cleared(v) == [2, 2, 2] and v.f["mPopupEpoch"] == 4, (h.cleared(v), v.f["mPopupEpoch"]))

# two views (the keyboard view and any other) each see a change once
h, a = fresh()
b = h.new_view()
h.run("bumpPopupEpoch()V")
h.run("closing()V", a)
check("a change is seen by each view on its own: the first view cleared, the second not yet", h.cleared(a) == [1, 1, 1] and h.cleared(b) == [0, 0, 0])
h.run("closing()V", b)
h.run("closing()V", a)
check("... then the second one, and the first is not cleared again", h.cleared(a) == [1, 1, 1] and h.cleared(b) == [1, 1, 1],
      (h.cleared(a), h.cleared(b)))

# setKeyboard
kb1, kb2 = dm.Obj(KB), dm.Obj(KB)
h = Host()
v = h.new_view(keyboard=kb1)
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("setKeyboard with the keyboard the view already has: the popups are kept", h.cleared(v) == [0, 0, 0], h.cleared(v))
check("... the keyboard is still set (key detector, trackers, layout) as before",
      v.f["mKeyboard"] is kb1 and "setKeyboard" in h.calls and "requestLayout" in h.calls and "invalidateAllKeys" in h.calls
      and "computeProximityThreshold" in h.calls, h.calls)
check("... the view still ends up marked as changed", v.f["mKeyboardChanged"] == 1 and v.f["mIgnoreMove"] == 1)
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("again the same keyboard: still kept", h.cleared(v) == [0, 0, 0], h.cleared(v))
h.run("setKeyboard(" + KB + ")V", v, kb2)
check("a different keyboard (other keys): the three maps are cleared, once each", h.cleared(v) == [1, 1, 1], h.cleared(v))
check("... and the view holds the new one", v.f["mKeyboard"] is kb2)
h.run("setKeyboard(" + KB + ")V", v, kb2)
check("the new keyboard set again: kept", h.cleared(v) == [1, 1, 1], h.cleared(v))
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("back to the first keyboard: cleared (its popups are not kept across a different keyboard)", h.cleared(v) == [2, 2, 2], h.cleared(v))

h = Host()
v = h.new_view(keyboard=kb1)
h.run("bumpPopupEpoch()V")
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("the same keyboard but a setting changed: cleared, once (not twice)", h.cleared(v) == [1, 1, 1] and v.f["mPopupEpoch"] == 1,
      (h.cleared(v), v.f["mPopupEpoch"]))
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("... then kept again", h.cleared(v) == [1, 1, 1], h.cleared(v))
h.run("bumpPopupEpoch()V")
h.run("setKeyboard(" + KB + ")V", v, kb2)
check("a different keyboard and a setting changed: cleared once, not twice", h.cleared(v) == [2, 2, 2], h.cleared(v))

h = Host()
v = h.new_view(keyboard=None)
h.run("setKeyboard(" + KB + ")V", v, kb1)
check("the very first keyboard of a view: the (empty) maps are cleared, harmless", h.cleared(v) == [1, 1, 1] and v.f["mKeyboard"] is kb1,
      h.cleared(v))

# a field opens: setKeyboard(same) then closing(): the popups survive both
h = Host()
v = h.new_view(keyboard=kb1)
h.run("setKeyboard(" + KB + ")V", v, kb1)
h.run("closing()V", v)
check("a field opens with the keyboard it had (setKeyboard, then closing()): nothing cleared", h.cleared(v) == [0, 0, 0], h.cleared(v))

# leaving the window
h = Host()
v = h.new_view(keyboard=kb1)
h.run("onDetachedFromWindow()V", v)
check("the view leaves the window: the three maps are cleared even with no setting changed", h.cleared(v) == [1, 1, 1], h.cleared(v))
check("... after closing() and the super call, as before", h.calls.index("onDetachedFromWindow") < h.calls.index("dismissPopupKeyboard"), h.calls)
h.run("clearPopupCaches()V", v)
check("clearPopupCaches clears exactly the three maps and nothing else", h.cleared(v) == [2, 2, 2] and v.f["mTextHeightCache"].f["cleared"] == 1,
      (h.cleared(v), v.f["mTextHeightCache"].f["cleared"]))
h.run("bumpPopupEpoch()V"); h.run("clearPopupCaches()V", v)
check("... and the view takes the current number, so the next closing() does not clear again",
      v.f["mPopupEpoch"] == 1 and (h.run("closing()V", v) or True) and h.cleared(v) == [3, 3, 3], (v.f["mPopupEpoch"], h.cleared(v)))


# ---------------------------------------------------------------- part 2: the shape of the smali
def body(name, head):
    lines = open(os.path.join(APP, name), encoding="utf-8").read().split("\n")
    s = next(i for i, l in enumerate(lines) if l.startswith(".method ") and head in l)
    e = next(i for i in range(s, len(lines)) if lines[i].startswith(".end method"))
    out, in_ann = [], False
    for l in lines[s:e]:
        t = l.strip()
        if t.startswith(".annotation"):
            in_ann = True
        elif t.startswith(".end annotation"):
            in_ann = False
        elif t and not in_ann and not t.startswith(("#", ".line", ".prologue")):
            out.append(t)
    return out


def code(b):
    return [l for l in b if not l.startswith(".") and not l.startswith(":")]


CLEAR = "invoke-virtual {v0}, Ljava/util/WeakHashMap;->clear()V"
c = code(body("LatinKeyboardBaseView.smali", "public closing()V"))
check("closing(): no clear() of a popup map of its own any more, one call to the stale check",
      not any("mMiniKeyboardCache" in l for l in c) and c.count("invoke-direct {p0}, " + VIEW + "->dropPopupCachesIfStale()V") == 1, c)
check("closing(): the label metrics and the text heights are still dropped",
      any("mLabelMetricsCache" in l and l.startswith("iput-object") for l in c) and any("mTextHeightCache" in l for l in c))

c = code(body("LatinKeyboardBaseView.smali", "public setKeyboard(" + KB + ")V"))
check("setKeyboard: the first thing is reading the keyboard that was on the view (v4)",
      c[0] == "iget-object v4, p0, " + VIEW + "->mKeyboard:" + KB, c[:2])
i = c.index("if-eq v4, p1, :cond_mr_same_keyboard")
check("setKeyboard: a different keyboard clears the maps and skips the rest; the same one only runs the stale check",
      c[i + 1] == "invoke-direct {p0}, " + VIEW + "->clearPopupCaches()V" and c[i + 2] == "goto :cond_mr_keep_popups"
      and c[i + 3] == "invoke-direct {p0}, " + VIEW + "->dropPopupCachesIfStale()V"
      and c.count("invoke-direct {p0}, " + VIEW + "->clearPopupCaches()V") == 1
      and c.count("invoke-direct {p0}, " + VIEW + "->dropPopupCachesIfStale()V") == 1, c[i:i + 4])
check("setKeyboard: the keyboard of the view is read before it is replaced, and p1 is not used as a scratch register before the check",
      c.index("iget-object v4, p0, " + VIEW + "->mKeyboard:" + KB) < c.index("iput-object p1, p0, " + VIEW + "->mKeyboard:" + KB) < i
      and not any(re.match(r"(iget-object|sget-object|move-object|const\S*) p1\b", l) for l in c[:i]), None)
check("setKeyboard: the maps are not touched anywhere else", not any("mMiniKeyboardCache" in l for l in c), [l for l in c if "mMiniKeyboardCache" in l])

b = body("LatinKeyboardBaseView.smali", "public onDetachedFromWindow()V")
c = code(b)
check("onDetachedFromWindow: closing(), then the three maps cleared",
      c.index("invoke-virtual {p0}, " + VIEW + "->closing()V") < c.index("invoke-direct {p0}, " + VIEW + "->clearPopupCaches()V"), c)

c = code(body("LatinKeyboardBaseView.smali", "private clearPopupCaches()V"))
check("clearPopupCaches takes the current number of changes, then clears the Main, Shift and Caps maps",
      c[:2] == ["sget v0, " + VIEW + "->sPopupEpoch:I", "iput v0, p0, " + VIEW + "->mPopupEpoch:I"]
      and [l for l in c if "->mMiniKeyboardCache" in l] == [
    "iget-object v0, p0, " + VIEW + "->mMiniKeyboardCacheMain:Ljava/util/WeakHashMap;",
    "iget-object v0, p0, " + VIEW + "->mMiniKeyboardCacheShift:Ljava/util/WeakHashMap;",
    "iget-object v0, p0, " + VIEW + "->mMiniKeyboardCacheCaps:Ljava/util/WeakHashMap;"] and c.count(CLEAR) == 3, c)
src = open(os.path.join(APP, "LatinKeyboardBaseView.smali"), encoding="utf-8").read()
check("the three maps are cleared in ONE place of the class (clearPopupCaches)",
      src.count("->mMiniKeyboardCacheMain:Ljava/util/WeakHashMap;\n\n    invoke-virtual {v0}, Ljava/util/WeakHashMap;->clear()V") == 1
      and src.count("WeakHashMap;->clear()V") == 3, src.count("WeakHashMap;->clear()V"))
others = [f for f in os.listdir(APP) if f.endswith(".smali") and f != "LatinKeyboardBaseView.smali"
          and re.search(r"mMiniKeyboardCache(Main|Shift|Caps)", open(os.path.join(APP, f), encoding="utf-8").read())]
check("no other class touches the popup maps", not others, others)

check("bumpPopupEpoch is public static (LatinIME calls it) and the number is a private static int",
      ".method public static bumpPopupEpoch()V" in src and ".field private static sPopupEpoch:I" in src and ".field private mPopupEpoch:I" in src)

c = code(body("LatinIME.smali", "public onSharedPreferenceChanged("))
first_call = next(l for l in c if l.startswith("invoke-"))
check("LatinIME.onSharedPreferenceChanged: the first call is bumpPopupEpoch, before any early return",
      first_call == "invoke-static {}, " + VIEW + "->bumpPopupEpoch()V" and c.count(first_call) == 1
      and c.index(first_call) < next(i for i, l in enumerate(c) if l.startswith("return")), c[:6])
bumps = []
for f in sorted(os.listdir(APP)):
    if f.endswith(".smali") and f != "LatinKeyboardBaseView.smali":
        n = open(os.path.join(APP, f), encoding="utf-8").read().count("->bumpPopupEpoch()V")
        if n:
            bumps.append((f, n))
check("only LatinIME bumps it, once", bumps == [("LatinIME.smali", 1)], bumps)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
