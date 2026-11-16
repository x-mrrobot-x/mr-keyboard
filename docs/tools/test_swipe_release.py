#!/usr/bin/env python3
"""Tests of the sideways swipe that ends with the finger lifted slowly (LatinKeyboardBaseView).

Run it from the project root:  python3 -I docs/tools/test_swipe_release.py

The keyboard has two ways to see a swipe (the actions chosen in "Touch and gestures": by default left and right change the sheet):
  - the fling detector (onFling): the finger must LEAVE the screen fast (300 dp/s), without slowing down, mostly sideways and at least
    min(width/3, height/3) away from where it went down. A drag that is slow, or that slows down before the finger lifts, is no fling;
  - the release (onUpEvent): a touch that ends more than min(width/3, height/3) away, more sideways than up or down, is not typed as the
    key where the finger stopped (mrIsSwipeRelease). Before 2.0.0 that was all it did: such a drag did nothing at all.
Now the release is the swipe action too (mrSwipeAtRelease: swipeRight when the finger ended to the right of where it went down, else
swipeLeft), so the distance decides and not the speed at which the finger lifts. The fling detector stays as it was and goes first: a swipe
it takes never reaches the release.

This test runs the REAL smali of onUpEvent, mrIsSwipeRelease and mrSwipeAtRelease in the mini Dalvik interpreter (dalvik_mini.py) with a fake
view and pointer, and reads the smali for the shape of the change.
"""
import os
import random
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
VIEW = "Lcom/mrkeyboard/app/LatinKeyboardBaseView;"
PT = "Lcom/mrkeyboard/app/PointerTracker;"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


WANTED = ("onUpEvent(" + PT + "IIJ)V", "mrIsSwipeRelease(" + PT + "II)Z", "mrSwipeAtRelease(" + PT + "I)V")
SRC = os.path.join(APP, "LatinKeyboardBaseView.smali")
ALL = dm.parse_methods(SRC)
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
assert len(METHODS) == len(WANTED), sorted(set(WANTED) - set(METHODS))
text = open(SRC, encoding="utf-8").read()


class Host:
    """A fake keyboard view of w x h pixels and the fake framework around it."""

    def __init__(self, w=1080, h=800, guard=True, slide_keys=0, detector=True):
        self.w, self.h, self.guard = w, h, guard
        self.calls = []
        self.settings = dm.Obj("Lcom/mrkeyboard/app/GlobalKeyboardSettings;", sendSlideKeys=slide_keys)
        self.vm = dm.VM(VIEW, METHODS, self)
        self.view = dm.Obj(VIEW, mGestureDetector=dm.Obj("Landroid/view/GestureDetector;") if detector else None,
                           mPointerQueue=dm.Obj(VIEW[:-1] + "$PointerQueue;"))

    def tracker(self, x0, y0, start_modifier=False, end_modifier=False):
        return dm.Obj(PT, x0=x0, y0=y0, start_modifier=start_modifier, end_modifier=end_modifier)

    def sget(self, cls, name):
        if name == "sKeyboardSettings":
            return self.settings
        raise AssertionError("unexpected static " + cls + "->" + name)

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return False

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if cls == VIEW:
            if name == "getWidth":
                return self.w
            if name == "getHeight":
                return self.h
            if name == "swipeGuardEnabled":
                return 1 if self.guard else 0
            if name in ("swipeLeft", "swipeRight"):
                self.calls.append(name)
                return 1
            if name == "onCancelEvent":
                self.calls.append("cancel")
                return None
        if cls == VIEW[:-1] + "$PointerQueue;":
            if name == "lastIndexOf":
                return 0
            return None                              # releaseAllPointersExcept, releaseAllPointersOlderThan, remove
        if cls == PT:
            t = args[0]
            if name == "onUpEvent":
                self.calls.append("typed")           # the usual release: the key under the finger is typed
                return None
            if name == "getStartX":
                return t.f["x0"]
            if name == "getStartY":
                return t.f["y0"]
            if name == "isOnModifierKey":
                return 1 if t.f["start_modifier"] else 0
            if name == "isModifier":
                self.calls.append("isModifier")      # the key where the finger ended: the usual release asks, the swipe does not
                return 1 if t.f["end_modifier"] else 0
        if cls == "Ljava/lang/Math;":
            if name == "abs":
                return abs(args[0])
            if name == "min":
                return min(args[0], args[1])
        raise AssertionError("unexpected call " + target)

    def is_swipe(self, t, x, y):
        return self.vm.run("mrIsSwipeRelease(" + PT + "II)Z", [self.view, t, x, y])

    def release(self, t, x, y):
        """onUpEvent when the guard says swipe: the calls it makes, in order (the long is the time of the event)."""
        self.calls = []
        self.vm.run("onUpEvent(" + PT + "IIJ)V", [self.view, t, x, y, 1000])
        return list(self.calls)


# ---------------------------------------------------------------- the release as a swipe, with the real smali
h = Host()                      # 1080 x 800: the minimum distance is min(360, 266) = 266 px
D = 266
t = h.tracker(500, 400)
check("a drag of 300 px to the right is a swipe", h.is_swipe(t, 800, 410))
check("... and to the left", h.is_swipe(t, 200, 390))
check("exactly the distance (266 px) is not yet, one pixel more is", not h.is_swipe(t, 500 + D, 400) and h.is_swipe(t, 500 + D + 1, 400))
check("a drag of 200 px is not a swipe (the key where the finger stopped is typed, as always)", not h.is_swipe(t, 700, 400))
check("more up than sideways is not: 300 sideways with 300 up", not h.is_swipe(t, 800, 100))
check("... 300 sideways with 299 up is", h.is_swipe(t, 800, 101))
check("the finger that goes down and up in the same place is not a swipe", not h.is_swipe(t, 500, 400))
check("a swipe that starts on a modifier (Shift, Ctrl, Alt, Meta, Symbols) is not: the finger that holds one and slides is a chord",
      not h.is_swipe(h.tracker(500, 400, start_modifier=True), 900, 400))
h.calls = []
check("a swipe that ENDS on a modifier is one (a swipe to the left that stops over Shift), and the key where it ended is not asked about",
      h.is_swipe(h.tracker(500, 400, end_modifier=True), 100, 400) and "isModifier" not in h.calls)
check("with the keys sent while sliding on (sendSlideKeys), the slide is typing, not a swipe", not Host(slide_keys=1).is_swipe(t, 900, 400))
check("the extension row turns the protection off", not Host(guard=False).is_swipe(t, 900, 400))
check("no fling detector: no swipe", not Host(detector=False).is_swipe(t, 900, 400))
check("the distance is a third of the height when that is shorter (landscape: 1920 x 360, 120 px)",
      Host(w=1920, h=360).is_swipe(t, 500 + 121, 400) and not Host(w=1920, h=360).is_swipe(t, 500 + 120, 400))
check("... and a third of the width when that is shorter (a narrow, tall keyboard: 300 x 1200, 100 px)",
      Host(w=300, h=1200).is_swipe(t, 500 + 101, 400) and not Host(w=300, h=1200).is_swipe(t, 500 + 100, 400))

# onUpEvent: a swipe lets go of the key without typing it, then does the action of its side
check("a release that is a swipe to the right: the key is cancelled, then swipeRight", h.release(t, 800, 410) == ["cancel", "swipeRight"], h.calls)
check("... to the left: the key is cancelled, then swipeLeft", h.release(t, 200, 390) == ["cancel", "swipeLeft"], h.calls)
check("... a swipe from the far right edge to the middle is to the left (the side is where the finger went, not where it is)",
      h.release(h.tracker(1000, 400), 600, 400) == ["cancel", "swipeLeft"], h.calls)
check("... a swipe that ends over a modifier does the action too",
      h.release(h.tracker(500, 400, end_modifier=True), 100, 400) == ["cancel", "swipeLeft"], h.calls)
check("... in the extension row it is no swipe: the key under the finger is typed as always, no action",
      "typed" in Host(guard=False).release(t, 800, 400) and not {"swipeLeft", "swipeRight", "cancel"} & set(Host(guard=False).release(t, 800, 400)))
check("... a drag that is too short is typed as always (the key where the finger stopped), no action",
      "typed" in h.release(t, 700, 400) and not {"swipeLeft", "swipeRight", "cancel"} & set(h.release(t, 700, 400)))
check("... a swipe is never typed as a key", "typed" not in h.release(t, 800, 410) and "typed" not in h.release(t, 200, 390))
random.seed(7)
bad = 0
for _ in range(500):
    x0, y0 = random.randint(0, 1080), random.randint(0, 800)
    x1, y1 = random.randint(0, 1080), random.randint(0, 800)
    hh = Host()
    swipe = abs(x1 - x0) > D and abs(x1 - x0) > abs(y1 - y0)
    calls = hh.release(hh.tracker(x0, y0), x1, y1) if swipe else None
    want = ["cancel", "swipeRight" if x1 > x0 else "swipeLeft"]
    if swipe and calls != want:
        bad += 1
    if hh.is_swipe(hh.tracker(x0, y0), x1, y1) != (1 if swipe else 0) and hh.is_swipe(hh.tracker(x0, y0), x1, y1) != swipe:
        bad += 1
check("500 random touches: a swipe is exactly more than the distance and more sideways than up or down, and its side is where it went", bad == 0, bad)

# ---------------------------------------------------------------- the shape of the change in the smali
up = text[text.index(".method private onUpEvent("):]
up = up[:up.index(".end method")]
i_swipe = up.index("->mrIsSwipeRelease(")
i_cancel = up.index("->onCancelEvent(", i_swipe)
i_action = up.index("->mrSwipeAtRelease(", i_cancel)
i_ret = up.index("return-void", i_action)
i_not = up.index("\n    :cond_mr_not_swipe")
check("onUpEvent: the guard, then the cancel of the key, then the action, then it ends (before the usual release)", i_swipe < i_cancel < i_action < i_ret < i_not)
guard = text[text.index(".method private mrIsSwipeRelease("):]
guard = guard[:guard.index(".end method")]
check("mrIsSwipeRelease asks about the key where the swipe STARTED (isOnModifierKey) and not about where it ended (isModifier)",
      "->isOnModifierKey(" in guard and "->isModifier()" not in guard)
act = text[text.index(".method private mrSwipeAtRelease("):]
act = act[:act.index(".end method")]
check("mrSwipeAtRelease calls swipeRight and swipeLeft of the view, nothing else", re.findall(r"->(\w+)\(", act) == ["getStartX", "swipeRight", "swipeLeft"], re.findall(r"->(\w+)\(", act))
fling = open(os.path.join(APP, "LatinKeyboardBaseView$1.smali"), encoding="utf-8").read()
check("the fling detector is as it was: left and right still need the speed, the distance and the sideways direction",
      fling.count("->swipeRight()Z") == 1 and fling.count("->swipeLeft()Z") == 1 and "access$400" in fling and "access$500" in fling)
check("the fling path is as it was: one call of mrCancelSwipedPointer, in onTouchEvent",
      text.count("->mrCancelSwipedPointer(") == 1 and ".method private mrCancelSwipedPointer(" in text)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
