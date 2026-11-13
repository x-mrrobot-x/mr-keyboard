#!/usr/bin/env python3
"""Tests that a word typed with the suggestions flow suspended is written as typed when a separator follows
(LatinIME.handleSeparator, commitTyped, suggestionsSuspended).

Run it from the project root:  python3 -I docs/tools/test_separator_suspended.py

The flow is suspended when a tool owns the toolbar row (translator, emoji search: the keys go to a field of the keyboard) or when the toolbar row is
hidden (the grid key). Then updateSuggestions does not run, so mBestWord (the "default suggestion") is not updated: it is empty or the one of an
earlier word. The word being typed is composing text of the field. If the separator accepted that default suggestion, the typed word stayed composing
and the separator replaced it (the field was emptied) or the old word was written.

It runs the REAL smali of handleSeparator, commitTyped and suggestionsSuspended in the mini Dalvik interpreter (dalvik_mini.py), over a fake field that
keeps the text and the composing text the way an InputConnection does (commitText replaces the composing text). The rest of LatinIME is a stub.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
ENUM = "Lcom/mrkeyboard/app/TextEntryState$State;"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


METHODS = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))


class World:
    def __init__(self, composing="", best=None, row=0, bar_on=1, style=0, autocorrect=1):
        self.text = ""
        self.comp = composing           # the composing text of the field
        self.log = []
        self.row = row
        self.bar_on = bar_on
        self.style = style
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")
        self.vm = ImeVM(self)
        self.this = dm.Obj(
            IME, mCandidateView=None, mPredicting=1 if composing else 0, mAutoCorrectOn=autocorrect, mAutoCorrectEnabled=1,
            mJustRevertedSeparator=None, mJustAddedAutoSpace=0, mComposing=composing, mBestWord=best, mCommittedLength=0,
            mWord=dm.Obj("Lcom/mrkeyboard/app/WordComposer;"),
        )

    def commit(self, s):
        self.comp = ""                  # commitText replaces the composing text
        self.text += str(s)

    def shown(self):
        return self.text + self.comp

    def key(self, code):
        self.vm.run("handleSeparator(I)V", [self.this, code])

    # ---- host
    def sget(self, cls, name):
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sInited":
            return 1
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sBarOn":
            return self.bar_on
        if cls == ENUM:
            return dm.Obj(ENUM, name=name)
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        short = cls.split("/")[-1].rstrip(";") + "." + mem.split("(")[0]
        if short == "MrTools.rowOwned":
            return self.row
        if short == "MrFonts.styleOn":
            return self.style
        if short == "TextEntryState.getState":
            return dm.Obj(ENUM, name="UNKNOWN")
        if short == "InputConnection.commitText":
            self.commit(args[1])
            return 1
        if short in ("InputConnection.beginBatchEdit", "InputConnection.endBatchEdit", "InputConnection.finishComposingText"):
            return 1
        if short in ("StringBuilder.length", "CharSequence.length", "String.length"):
            return len(str(args[0]))
        if short == "CandidateView.dismissAddToDictionaryHint":
            return 0
        if mem.startswith("getCurrentInputEditorInfo"):
            return dm.Obj("Landroid/view/inputmethod/EditorInfo;")
        self.log.append(short)
        return None


class ImeVM(dm.VM):
    def __init__(self, world):
        super().__init__(IME, METHODS, world)
        self.w = world

    def run(self, key, args):
        name = key.split("(")[0]
        w = self.w
        if name == "getCurrentInputConnection":
            return w.ic
        if name == "pickDefaultSuggestion":
            # the real one accepts mBestWord when there is one: the word replaces the composing text
            w.log.append("pickDefaultSuggestion")
            best = w.this.f["mBestWord"]
            if best:
                w.commit(best)
                return 1
            return 0
        if name == "sendModifiableKeyChar":
            w.commit(chr(args[1]))                  # sendKeyChar: commitText(char, 1)
            return None
        if name in ("postUpdateSuggestions", "abortCorrection", "removeTrailingSpace", "reswapPeriodAndSpace", "doubleSpace",
                    "updateShiftKeyState", "addToDictionaries", "updateSuggestions", "swapPunctuationAndSpace"):
            w.log.append(name)
            return None
        if name == "isPredictionOn":
            return 0
        return super().run(key, args)


# ---------------------------------------------------------------- a tool owns the row (translator / emoji search field)
w = World(composing="olá", best=None, row=1)
w.key(ord(" "))
check("tool field, no default suggestion: the typed word stays, then the space", w.shown() == "olá ", repr(w.shown()))
check("tool field: the default suggestion is not even asked", "pickDefaultSuggestion" not in w.log, w.log)

w = World(composing="olá", best="casa", row=1)
w.key(ord(" "))
check("tool field, an old default suggestion: not written in place of the typed word", w.shown() == "olá ", repr(w.shown()))

w = World(composing="olá", best="casa", row=1)
w.key(ord(","))
check("tool field: a comma after the word", w.shown() == "olá,", repr(w.shown()))

w = World(composing="olá", best=None, row=1)
w.key(10)
check("tool field: Enter after the word keeps the word", w.shown() == "olá\n", repr(w.shown()))

w = World(composing="", best=None, row=1)
w.key(ord(" "))
check("tool field: a space with no word", w.shown() == " ", repr(w.shown()))

# ---------------------------------------------------------------- the row is hidden (grid key): typing in the app
w = World(composing="olá", best=None, bar_on=0)
w.key(ord(" "))
check("hidden row, no default suggestion: the typed word stays", w.shown() == "olá ", repr(w.shown()))

w = World(composing="olá", best="casa", bar_on=0)
w.key(ord(" "))
check("hidden row, an old default suggestion: not written in place of the typed word", w.shown() == "olá ", repr(w.shown()))

# ---------------------------------------------------------------- a font style is on
w = World(composing="olá", best="casa", style=1)
w.key(ord(" "))
check("font style on: the typed word stays", w.shown() == "olá ", repr(w.shown()))

# ---------------------------------------------------------------- not suspended: the flow is as before
w = World(composing="cas", best="casa", row=0, bar_on=1)
w.key(ord(" "))
check("normal flow: the default suggestion is accepted by the space", w.shown() == "casa ", repr(w.shown()))
check("normal flow: pickDefaultSuggestion is called", "pickDefaultSuggestion" in w.log, w.log)

w = World(composing="cas", best="casa", row=0, bar_on=1, autocorrect=0)
w.key(ord(" "))
check("auto-correction off: the typed word stays", w.shown() == "cas ", repr(w.shown()))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
