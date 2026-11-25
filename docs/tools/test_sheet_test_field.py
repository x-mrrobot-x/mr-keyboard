#!/usr/bin/env python3
"""Tests the hooks of the quick test field of the sheet editor in the keyboard (MrSheetTest), with the REAL smali of LatinIME.onWindowShown and
LatinIME.returnToMainSheet running in the mini Dalvik interpreter (dalvik_mini.py).

Run it from the project root:  python3 -I docs/tools/test_sheet_test_field.py

The rule: the test field of the sheet editor asks the keyboard for the sheet being edited. When the keyboard window shows, it first goes back to
ABC (as for every field) and only then MrSheetTest.show takes it to the sheet of the field; "Return to the main sheet after typing" asks
MrSheetTest.holds before it goes back to ABC, and keeps the sheet on the test field. Everywhere else nothing changes: the setting off, a key that
is not text, the keyboard already on ABC (holds is not even asked) and any other field (holds says no) behave as before. What MrSheetTest decides
(which field, which sheet) is in docs/tools/sheets_test/SheetsTest.java; onStartInputView, too long to run here, is checked there in the smali.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
METHODS = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


class World:
    def __init__(self, pref=True, sheet=2, held=False):
        self.pref = pref            # pref_sheet_return
        self.sheet = sheet          # KeyboardSwitcher.getSheet (0 = ABC)
        self.held = held            # what MrSheetTest.holds answers
        self.calls = []
        self.vm = Vm(self)
        self.this = dm.Obj(IME, mKeyboardSwitcher=dm.Obj("Lcom/mrkeyboard/app/KeyboardSwitcher;"))

    def sget(self, cls, name):
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        short = cls.split("/")[-1].rstrip(";") + "." + mem.split("(")[0]
        if short == "MrSheetTest.show":
            self.calls.append("show")
            return None
        if short == "MrSheetTest.holds":
            self.calls.append("holds")
            return 1 if self.held else 0
        if short == "KeyboardSwitcher.getSheet":
            return self.sheet
        if short in ("InputMethodService.onWindowShown", "MrBottom.bar", "MrTools.applyTranslucentBlur", "MrAiDialog.onImeWindowShown",
                     "MrAccel.onShown"):
            self.calls.append(short)
            return None
        raise AssertionError("invoke " + target)


class Vm(dm.VM):
    def __init__(self, world):
        super().__init__(IME, METHODS, world)
        self.w = world

    def run(self, key, args):
        name = key.split("(")[0]
        if name == "prefOn":
            self.w.calls.append("prefOn:" + str(args[1]))
            return 1 if self.w.pref else 0
        if name == "resetSheetToAbc":
            self.w.calls.append("abc")
            self.w.sheet = 0
            return None
        if name == "changeSheet":
            self.w.calls.append("changeSheet:%d" % args[1])
            return None
        return super().run(key, args)


def type_key(world, code):
    world.calls.clear()
    world.vm.run("returnToMainSheet(I)V", [world.this, code])
    return [c for c in world.calls if not c.startswith("prefOn")]


# ---------------------------------------------------------------- onWindowShown

w = World()
w.vm.run("onWindowShown()V", [w.this])
check("window shown: back to ABC first, then MrSheetTest.show (the test field goes to its sheet after the reset, never before)",
      "abc" in w.calls and "show" in w.calls and w.calls.index("abc") < w.calls.index("show"), w.calls)
check("window shown: MrSheetTest.show once, at the end (after the bar, the blur, the AI dialog and the acceleration log)",
      w.calls.count("show") == 1 and w.calls[-1] == "show", w.calls)

# ---------------------------------------------------------------- returnToMainSheet

w = World(pref=True, sheet=2, held=False)
calls = type_key(w, ord("a"))
check("any other field, a letter on a sheet: holds is asked, says no, and the keyboard goes back to ABC (changeSheet 1) as before",
      calls == ["holds", "changeSheet:1"], calls)

w = World(pref=True, sheet=2, held=True)
calls = type_key(w, ord("a"))
check("test field, a letter on its sheet: the keyboard stays on the sheet (no changeSheet)", calls == ["holds"], calls)

w = World(pref=True, sheet=2, held=True)
calls = type_key(w, 10)
check("test field, Enter on its sheet: stays too", calls == ["holds"], calls)

w = World(pref=False, sheet=2, held=False)
calls = type_key(w, ord("a"))
check("setting off: nothing is asked and nothing changes", calls == [], calls)

w = World(pref=True, sheet=0, held=True)
calls = type_key(w, ord("a"))
check("already on ABC: holds is not even asked", calls == [], calls)

w = World(pref=True, sheet=2, held=True)
calls = type_key(w, -5)
check("a key that is not text (delete): nothing is asked, as before", calls == [], calls)

print("ALL OK (%d checks)" % ok if fails == 0 else "%d FAILURE(S) of %d" % (fails, ok + fails))
sys.exit(1 if fails else 0)
