#!/usr/bin/env python3
"""Tests where the popup of a long press and the balloon of a key appear: they must follow the keyboard when it moves inside the window.

Run it from the project root:  python3 -I docs/tools/test_popup_position.py

The toolbar shares the window with the keyboard, so the place of the keyboard in the window changes: the header of the emoji search is
taller than the row it replaces, a panel opens, the row is hidden or shown by the grid key. The original keyboard code read that place ONCE
(LatinKeyboardBaseView.mWindowOffset for the popup of the accents, mOffsetInWindow and mWindowY for the balloon of the key) and kept it, so
after the keyboard moved the popup of the "a" showed far above (or below) the key. Both are read at every use now.

This runs the REAL smali of LatinKeyboardBaseView.onLongPress and .showKey in the mini Dalvik interpreter (dalvik_mini.py): the Android
classes are a fake that answers where the keyboard is (getLocationInWindow / getLocationOnScreen) and records where each PopupWindow is shown.
The helpers that need the whole view (the long press keyboard, the motion event, the mini keyboard) are replaced by fakes.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


BASE = "Lcom/mrkeyboard/app/LatinKeyboardBaseView;"
APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")


class Fields(dict):
    """The fields of a fake object: one that was never written is 0 / null (as in a new Java object)."""

    def __missing__(self, key):
        return 0


def obj(cls="Ljava/lang/Object;", **kw):
    o = dm.Obj(cls)
    o.f = Fields(kw)
    return o


class World:
    """Where the keyboard is, and what the popups did."""

    def __init__(self):
        self.kbd_top = 150          # the keyboard inside the window: under the toolbar row
        self.window_top = 1000      # the window on the screen
        self.shown = []             # (what, gravity, x, y) of every PopupWindow.showAtLocation
        self.key = obj("Lcom/mrkeyboard/app/Keyboard$Key;", x=400, y=200, width=100, height=110, icon=None, label="a", codes=[97])
        self.container = obj(mw=400, mh=120)
        self.mini = obj(BASE)
        self.mini_popup = obj("Landroid/widget/PopupWindow;", name="mini")
        self.preview_popup = obj("Landroid/widget/PopupWindow;", name="preview")
        self.view = obj(BASE, mPopupLayout=1, mMiniKeyboardContainer=self.container, mMiniKeyboard=self.mini, mMiniKeyboardPopup=self.mini_popup,
                        mPreviewPopup=self.preview_popup, mPreviewText=obj(mw=80), mMiniKeyboardParent=obj(), mHandler=obj(), mPreviewHeight=100,
                        mPreviewOffset=-20, mShowPreview=0)
        self.vm = VMX(self)

    # --- the Android side
    def sget(self, cls, name):
        return None

    def new_instance(self, cls):
        return obj(cls)

    def instance_of(self, o, cls):
        return True

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        a0 = args[0] if args else None
        if mem == "getLocationInWindow([I)V":
            args[1][0], args[1][1] = 0, self.kbd_top
            return None
        if mem == "getLocationOnScreen([I)V":
            args[1][0], args[1][1] = 0, self.window_top + self.kbd_top
            return None
        if mem == "showAtLocation(Landroid/view/View;III)V":
            self.shown.append((a0.f["name"], args[2], args[3], args[4]))
            return None
        if mem == "isShowing()Z":
            return 0
        if mem == "getWidth()I" or mem == "getMeasuredWidth()I" and a0 is self.view:
            return 1080
        if mem == "getHeight()I":
            return 500
        if mem == "getMeasuredWidth()I":
            return a0.f["mw"] if isinstance(a0, dm.Obj) and "mw" in a0.f else 0
        if mem == "getMeasuredHeight()I":
            return a0.f["mh"] if isinstance(a0, dm.Obj) and "mh" in a0.f else 0
        if mem == "getKeys()Ljava/util/List;":
            return [obj("Lcom/mrkeyboard/app/Keyboard$Key;", width=100)]
        if mem == "size()I":
            return len(a0)
        if mem == "get(I)Ljava/lang/Object;":
            return a0[args[1]]
        if mem == "length()I":
            return len(a0)
        if mem == "getCaseLabel()Ljava/lang/String;":
            return a0.f["label"]
        if mem == "getKey(I)Lcom/mrkeyboard/app/Keyboard$Key;":
            return self.key
        if mem == "max(II)I":
            return max(args)
        if mem == "uptimeMillis()J":
            return 1000
        if mem == "makeMeasureSpec(II)I":
            return 0
        ret = mem[mem.rindex(")") + 1:]
        return None if ret[0] in "LV[" else 0

    def popup_y(self, who):
        return [s[3] for s in self.shown if s[0] == who][-1]

    def popup_x(self, who):
        return [s[2] for s in self.shown if s[0] == who][-1]

    def long_press(self):
        self.vm.run("onLongPress(Lcom/mrkeyboard/app/Keyboard$Key;)Z", [self.view, self.key])

    def show_key(self):
        self.vm.run("showKey(ILcom/mrkeyboard/app/PointerTracker;)V", [self.view, 0, obj()])


class VMX(dm.VM):
    """The class under test, with fakes for what needs the real view and its helpers."""
    STUBS = {
        "getLongPressKeyboard(Lcom/mrkeyboard/app/Keyboard$Key;)Lcom/mrkeyboard/app/Keyboard;": lambda a: obj("Lcom/mrkeyboard/app/Keyboard;"),
        "shouldAlignLeftmost(Lcom/mrkeyboard/app/Keyboard$Key;)Z": lambda a: 0,
        "shouldDrawLabelAndIcon(Lcom/mrkeyboard/app/Keyboard$Key;)Z": lambda a: 0,
        "getPreviewBgId(Z)I": lambda a: 1,
        "generateMiniKeyboardMotionEvent(IIIJ)Landroid/view/MotionEvent;": lambda a: obj("Landroid/view/MotionEvent;"),
        "getKeyboard()Lcom/mrkeyboard/app/Keyboard;": lambda a: obj("Lcom/mrkeyboard/app/Keyboard;"),
        "getShiftState()I": lambda a: 0,
        "setKeyboard(Lcom/mrkeyboard/app/Keyboard;)V": lambda a: None,
        "setPopupOffset(II)V": lambda a: None,
        "setShiftState(I)Z": lambda a: 0,
        "setPreviewEnabled(Z)V": lambda a: None,
        "onTouchEvent(Landroid/view/MotionEvent;)Z": lambda a: 0,
        "invalidateAllKeys()V": lambda a: None,
    }

    def __init__(self, world):
        super().__init__(BASE, dm.parse_methods(os.path.join(APP, "LatinKeyboardBaseView.smali")), world)

    def run(self, key, args):
        if key in self.STUBS:
            return self.STUBS[key](args)
        return super().run(key, args)


# ---- the popup of the long press (the accents of the "a")
w = World()
w.long_press()
y0 = w.popup_y("mini")
check("long press: the popup is shown above the key (key top + keyboard top - the height of the popup)",
      y0 == w.key.f["y"] + w.kbd_top - w.container.f["mh"], (y0, w.key.f["y"], w.kbd_top))

w.kbd_top = 150 + 460          # the header of the emoji search opens: the keyboard is taller in the window... lower inside it
w.long_press()
check("the keyboard moved down in the window (emoji search open): the popup moves down with it, it is not left where it was",
      w.popup_y("mini") == y0 + 460, (w.popup_y("mini"), y0 + 460))

w.kbd_top = 102                # the toolbar row is hidden by the grid key: the keyboard moved up
w.long_press()
check("the keyboard moved up (the row hidden): the popup moves up with it",
      w.popup_y("mini") == w.key.f["y"] + 102 - w.container.f["mh"], w.popup_y("mini"))

w.kbd_top = 150
w.long_press()
check("back where it was: the popup is where it was", w.popup_y("mini") == y0, w.popup_y("mini"))
check("the horizontal place does not depend on the vertical one", len({s[2] for s in w.shown if s[0] == "mini"}) == 1, [s[2] for s in w.shown])

# the origin the mini keyboard uses to follow the finger is the one of the same long press
w = World()
w.long_press()
oy = w.view.f["mMiniKeyboardOriginY"]
w.kbd_top = 700
w.long_press()
check("the origin of the finger over the popup (mMiniKeyboardOriginY) is that of each long press, not the first one",
      w.view.f["mMiniKeyboardOriginY"] == oy, (w.view.f["mMiniKeyboardOriginY"], oy))

# ---- the balloon of the key
w = World()
w.show_key()
b0 = w.popup_y("preview")
w.kbd_top = 150 + 460
w.show_key()
check("balloon of the key: it follows the keyboard when it moves in the window (it was read once)", w.popup_y("preview") == b0 + 460, (w.popup_y("preview"), b0))
w.kbd_top = 102
w.show_key()
check("balloon of the key: and when it moves up", w.popup_y("preview") == b0 - 48, (w.popup_y("preview"), b0))
check("the position on the screen (mWindowY) is read again too", w.view.f["mWindowY"] == w.window_top + 102, w.view.f["mWindowY"])

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
