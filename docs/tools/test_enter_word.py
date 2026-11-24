#!/usr/bin/env python3
"""Tests that Enter leaves no word of the line above waiting to be written again on the line below (LatinIME.handleSeparator, commitTyped).

Run it from the project root:  python3 -I docs/tools/test_enter_word.py

Enter reaches the app as a key event, not as text: it does not replace the composing text the way a space typed with commitText does. A word still
marked as composing when Enter is sent (the default suggestion was empty, so nothing accepted it) stayed on the keyboard as the word being typed
(mPredicting): the first letter typed on the new line was added to it and the whole word was written again after the line break. Enter now writes
the word being typed as typed text and ends the composing text before the key goes.

It runs the REAL smali of handleSeparator and commitTyped in the mini Dalvik interpreter (dalvik_mini.py), over a fake field that keeps the text and
the composing text the way an InputConnection does. The rest of LatinIME is a stub. Both modes of Autocompletar are covered (auto_complete on and off).
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
    def __init__(self, composing="", best=None, autocorrect=1, predicting=None):
        self.text = ""
        self.comp = composing           # the composing text of the field (at the end of the text)
        self.calls = []                 # what reached the field, in order
        self.log = []
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")
        self.vm = ImeVM(self)
        self.this = dm.Obj(
            IME, mCandidateView=None, mPredicting=(1 if composing else 0) if predicting is None else predicting, mAutoCorrectOn=autocorrect,
            mAutoCorrectEnabled=1, mJustRevertedSeparator=None, mJustAddedAutoSpace=0, mComposing=composing, mBestWord=best,
            mCommittedLength=0, mWord=dm.Obj("Lcom/mrkeyboard/app/WordComposer;"), mHandler=None, mMrEchoDefer=0, mMrCapsDefer=0,
            mMrCapsPending=0, mAutoCapActive=0, mMrPick=0,
        )

    def commit(self, s):
        self.calls.append("commit")
        self.text += self.comp if False else ""   # commitText replaces the composing text
        self.comp = ""
        self.text += str(s)

    def finish(self):
        self.calls.append("finish")
        self.text += self.comp                    # the composing text stays as text
        self.comp = ""

    def enter(self):
        # Enter is a key event: the composing text is not replaced, the line break comes after it.
        self.calls.append("enter")
        self.open_at_enter = self.comp
        self.text += self.comp + "\n"
        self.comp = ""

    def shown(self):
        return self.text + self.comp

    def key(self, code):
        self.vm.run("handleSeparator(I)V", [self.this, code])

    def next_letter(self):
        """What the field shows after the next letter is typed on the new line (handleCharacter: a word being typed takes the letter, the
        whole of it goes to the field as composing text at the cursor; no word: the letter alone)."""
        if self.this.f["mPredicting"]:
            return self.shown() + str(self.this.f["mComposing"]) + "a"
        return self.shown() + "a"

    # ---- host
    def sget(self, cls, name):
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sInited":
            return 1
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sBarOn":
            return 1
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
        if short == "MrTools.rowOwned" or short == "MrFonts.styleOn":
            return 0
        if short == "TextEntryState.getState":
            return dm.Obj(ENUM, name="UNKNOWN")
        if short == "InputConnection.commitText":
            self.commit(args[1])
            return 1
        if short == "InputConnection.finishComposingText":
            self.finish()
            return 1
        if short in ("InputConnection.beginBatchEdit", "InputConnection.endBatchEdit"):
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
            # the real one accepts mBestWord when there is one: the word replaces the composing text and the word is no longer being typed
            w.log.append("pickDefaultSuggestion")
            best = w.this.f["mBestWord"]
            if best:
                w.commit(best)
                w.this.f["mPredicting"] = 0
                return 1
            return 0
        if name == "sendModifiableKeyChar":
            if args[1] == 10:
                w.enter()
            else:
                w.commit(chr(args[1]))              # sendKeyChar: commitText(char, 1)
            return None
        if name in ("postUpdateSuggestions", "abortCorrection", "removeTrailingSpace", "reswapPeriodAndSpace", "doubleSpace",
                    "updateShiftKeyState", "addToDictionaries", "updateSuggestions", "swapPunctuationAndSpace"):
            w.log.append(name)
            return None
        if name == "isPredictionOn":
            return 0
        if name in ("mrSepSent", "mrSepClear"):     # the note of the echo of our own separator: test_echo_questions.py
            return None
        return super().run(key, args)


for label, ac in (("Autocompletar on", 1), ("Autocompletar off", 0)):
    # a word typed, a default suggestion to accept
    w = World(composing="cas", best="casa", autocorrect=ac)
    w.key(10)
    want = "casa\n" if ac else "cas\n"
    check(label + ": word + Enter: the word is written once, then the line break", w.shown() == want, repr(w.shown()))
    check(label + ": word + Enter: the word is not being typed any more", w.this.f["mPredicting"] == 0, w.this.f["mPredicting"])
    check(label + ": word + Enter: the first letter of the new line stands alone", w.next_letter() == want + "a", repr(w.next_letter()))

    # a word typed, no default suggestion at all
    for best in (None, ""):
        w = World(composing="olá", best=best, autocorrect=ac)
        w.key(10)
        check(label + ": word, empty default suggestion (%r) + Enter: written once" % (best,), w.shown() == "olá\n", repr(w.shown()))
        check(label + ": word, empty default suggestion (%r) + Enter: no composing text when the key goes" % (best,),
              w.open_at_enter == "", repr(w.open_at_enter))
        check(label + ": word, empty default suggestion (%r) + Enter: the new line starts clean" % (best,), w.next_letter() == "olá\na",
              repr(w.next_letter()))

    # Enter with no word on the keyboard side: nothing extra goes to the field
    w = World(composing="", best=None, autocorrect=ac)
    w.key(10)
    check(label + ": Enter with no word: only the key", w.calls == ["enter"], w.calls)

# the word is committed before the key, and the composing text is closed
w = World(composing="olá", best=None)
w.key(10)
check("order: the word is committed, the composing text ended, then Enter", w.calls == ["commit", "finish", "enter"], w.calls)

# a composing text with nothing typed on the keyboard side (empty word being typed): the composing text of the field is closed as well
w = World(composing="", best=None, predicting=1)
w.this.f["mComposing"] = ""
w.comp = "x"
w.key(10)
check("a stale composing mark of the field is closed before Enter", w.open_at_enter == "", repr(w.open_at_enter))

# other separators are as before
w = World(composing="cas", best="casa")
w.key(ord(" "))
check("space still accepts the default suggestion", w.shown() == "casa ", repr(w.shown()))
w = World(composing="olá", best=None)
w.key(ord(","))
check("comma with no default suggestion is unchanged by this fix", w.calls[-1] == "commit", w.calls)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
