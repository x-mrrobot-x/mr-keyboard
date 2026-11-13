#!/usr/bin/env python3
"""Tests the long-press time of the sheet key ("123", "ABC", "TSK": code -300, the key with the popup of sheets), with the REAL smali of
PointerTracker.startLongPressTimer (and getKey / isValidKeyIndex) running in the mini Dalvik interpreter (dalvik_mini.py).

Run it from the project root:  python3 -I docs/tools/test_sheet_longpress.py

The rule: the popup of sheets comes up after a fixed 150 ms; every other key keeps the long-press time of the setting (GlobalKeyboardSettings.
longpressTimeout, 200 ms by default; MrGestureInput.longPress may raise it to 300 while a touch can still become a gesture; the momentary
auto mode switch state keeps its 3x). The sheet key ignores the setting and the gesture wait.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
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


class Host:
    def __init__(self):
        self.timeout = 200       # GlobalKeyboardSettings.longpressTimeout
        self.gesture = None      # what MrGestureInput.longPress returns instead of its argument (None: the argument)
        self.momentary = 0
        self.calls = []          # (delay, key index) of UIHandler.startLongPressTimer

    def sget(self, cls, name):
        if cls == "Lcom/mrkeyboard/app/LatinIME;" and name == "sKeyboardSettings":
            return dm.Obj("Lcom/mrkeyboard/app/GlobalKeyboardSettings;", longpressTimeout=self.timeout)
        raise AssertionError("static %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if mem.startswith("isInMomentaryAutoModeSwitchState"):
            return self.momentary
        if cls == "Lcom/mrkeyboard/app/MrGestureInput;" and mem.startswith("longPress"):
            return args[0] if self.gesture is None else max(args[0], self.gesture)
        if mem.startswith("startLongPressTimer"):
            self.calls.append((args[1], args[2]))
            return None
        raise AssertionError("invoke " + target)


def key(code, *more):
    return dm.Obj("Lcom/mrkeyboard/app/Keyboard$Key;", codes=[code] + list(more))


def setup(keys):
    host = Host()
    vm = dm.VM(PT, dm.parse_methods(os.path.join(APP, "PointerTracker.smali")), host)
    this = dm.Obj(PT, mKeyboardSwitcher=dm.Obj("ks"), mHandler=dm.Obj("handler"), mKeys=keys)
    return vm, host, this


def delay(host, vm, this, index):
    host.calls.clear()
    vm.run("startLongPressTimer(I)V", [this, index])
    assert len(host.calls) == 1, host.calls
    return host.calls[0][0]


KEYS = [key(ord("a")), key(-300), key(-5), key(32), key(-300, ord("x")), dm.Obj("Lcom/mrkeyboard/app/Keyboard$Key;", codes=None),
        dm.Obj("Lcom/mrkeyboard/app/Keyboard$Key;", codes=[])]

vm, host, this = setup(KEYS)
check("a letter key: the setting (200 ms)", delay(host, vm, this, 0) == 200)
check("the sheet key (123): 150 ms", delay(host, vm, this, 1) == 150)
check("the delete key: the setting", delay(host, vm, this, 2) == 200)
check("the space bar: the setting", delay(host, vm, this, 3) == 200)
check("a sheet key with more codes: 150 ms", delay(host, vm, this, 4) == 150)
check("a key without codes (null): the setting", delay(host, vm, this, 5) == 200)
check("a key with an empty list of codes: the setting", delay(host, vm, this, 6) == 200)
check("no key under the finger (index -1): the setting", delay(host, vm, this, -1) == 200)
check("an index beyond the keys: the setting", delay(host, vm, this, 99) == 200)

host.timeout = 500
check("the setting at 500 ms: a letter waits 500 ms", delay(host, vm, this, 0) == 500)
check("the setting at 500 ms: the sheet key still 150 ms", delay(host, vm, this, 1) == 150)
host.timeout = 200

host.gesture = 250
check("a touch that may become a gesture: a letter waits 250 ms", delay(host, vm, this, 0) == 250)
check("... and the sheet key still 150 ms", delay(host, vm, this, 1) == 150)
host.gesture = None

host.momentary = 1
check("momentary auto mode switch: a letter keeps its 3x (600 ms)", delay(host, vm, this, 0) == 600)
host.momentary = 0

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
