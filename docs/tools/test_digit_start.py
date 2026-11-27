#!/usr/bin/env python3
"""Tests the word that starts with a digit typed for its first letter ("5udo" for tudo), with the REAL smali of LatinIME.handleCharacter (and of
isAlphabet and isCursorTouchingWord) and of MrDigitStart (sent, take, lone) running in the mini Dalvik interpreter (dalvik_mini.py).

Run it from the project root:  python3 -I docs/tools/test_digit_start.py

The number row sits right above q..p, so a finger that starts a word on the top row can land on the digit above. A digit does not start a
word, and the letter after it did not either (the cursor was already touching the digit): no word, no suggestion, no correction. Now a lone
digit of the letter keyboard (after a space, at the start of the text or after an opening bracket or quote) leaves the field when a letter comes
right after it, and the word starts with both ("5u" composing, the touch of the 5 kept), so the search finds tudo. Where the field asks for a
capital (the start of a sentence) the word is marked as capitalized, so the suggestions come with it (Tudo). A number ("10h"), a digit after a
word ("a5"), a digit of the symbols sheet and typing with the prediction off behave as before. What may be replaced on its own is in
docs/tools/digit_test/DigitTest.java and S30 of docs/tools/e2e/StrategyTest.java. Both modes of Autocompletar are run (handleCharacter does not
read it: the result must be the same).
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
DIGIT = "Lcom/mrkeyboard/app/MrDigitStart;"
IME_METHODS = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
DIGIT_METHODS = dm.parse_methods(os.path.join(APP, "MrDigitStart.smali"))
SEPARATORS = " .,;:!?\n()[]*&@{}/<>_+=|\"'"
TOP, DIG = "qwertyuiop", "1234567890"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def touch(ch):
    """The codes of a touch: the key, then its neighbours (a digit: the letters under it and the digits beside it)."""
    d = DIG.find(ch)
    if d < 0:
        return [ord(ch)]
    keys = [ch] + [TOP[k] for k in (d, d - 1, d + 1) if 0 <= k < 10] + [DIG[k] for k in (d - 1, d + 1) if 0 <= k < 10]
    return [ord(k) for k in keys]


class SB:
    """java.lang.StringBuilder."""
    def __init__(self, s=""):
        self.s = s

    def __str__(self):
        return self.s


class Composer:
    """WordComposer: the codes of each touch and the two capital flags."""
    def __init__(self):
        self.codes, self.first_cap, self.auto_cap = [], 0, 0

    def reset(self):
        self.codes, self.first_cap = [], 0


class World:
    def __init__(self, before="", after="", autocorrect=1, prediction=1, caps=None):
        self.text = before            # the committed text before the cursor
        self.comp = ""                # the composing text (right before the cursor)
        self.after = after
        self.alpha = 1                # KeyboardSwitcher.isAlphabetMode
        self.prediction = prediction
        self.caps = caps              # what getCursorCapsMode answers; None = a capital at the start of the text or after ". "
        self.deleted = 0
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")
        self.switcher = dm.Obj("Lcom/mrkeyboard/app/KeyboardSwitcher;")
        self.word = Composer()
        self.ime = ImeVM(self)
        self.digit = DigitVM(self)
        self.this = dm.Obj(
            IME, mLastSelectionStart=0, mLastSelectionEnd=0, mModCtrl=0, mModAlt=0, mModMeta=0, mPredicting=0, mComposing=SB(),
            mBestWord=None, mWord=self.word, mKeyboardSwitcher=self.switcher, mAutoCorrectOn=autocorrect,
        )

    def shown(self):
        return self.text + self.comp

    def type(self, chars, alpha=1):
        self.alpha = alpha
        for ch in chars:
            self.ime.run("handleCharacter(I[I)V", [self.this, ord(ch), touch(ch)])

    # ---- host
    def sget(self, cls, name):
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        short = cls.split("/")[-1].rstrip(";") + "." + mem.split("(")[0]
        if cls == DIGIT:
            return self.digit.run(mem, args)
        if short in ("TextEntryState.isCorrecting",):
            return 0
        if short in ("TextEntryState.typedCharacter", "MrPrevWord.clear", "MrPerf.appBegin", "MrPerf.appEnd", "Object.<init>"):
            return None
        if short == "KeyboardSwitcher.getInstance":
            return self.switcher
        if short == "KeyboardSwitcher.isAlphabetMode":
            return self.alpha
        if short == "LatinIME.getCurrentInputConnection":
            return self.ic
        if short == "LatinIME.getCurrentInputEditorInfo":
            return dm.Obj("Landroid/view/inputmethod/EditorInfo;")
        if target == "[I->clone()Ljava/lang/Object;":
            return list(args[0])
        if short == "InputConnection.getTextBeforeCursor":
            s = self.shown()
            return s[max(0, len(s) - args[1]):]
        if short == "InputConnection.getTextAfterCursor":
            return self.after[:args[1]]
        if short == "InputConnection.deleteSurroundingText":
            assert self.comp == "", "a deletion while a word is composing"
            self.text = self.text[:len(self.text) - args[1]]
            self.deleted += args[1]
            return 1
        if short == "InputConnection.setComposingText":
            self.comp = str(args[1])
            return 1
        if short == "TextUtils.isEmpty":
            return 1 if args[0] is None or len(str(args[0])) == 0 else 0
        if short in ("CharSequence.length", "String.length"):
            return len(str(args[0]))
        if short in ("CharSequence.charAt", "String.charAt"):
            return ord(str(args[0])[args[1]])
        if short == "String.indexOf":
            return str(args[0]).find(chr(args[1]))
        if short == "String.valueOf":
            return chr(args[0])
        if short == "String.contains":
            return 1 if str(args[1]) in str(args[0]) else 0
        if short == "Character.isLetter":
            return 1 if chr(args[0]).isalpha() else 0
        if short == "Character.isWhitespace":
            return 1 if chr(args[0]).isspace() else 0
        if short == "Character.isLetterOrDigit":
            return 1 if chr(args[0]).isalnum() else 0
        if short == "StringBuilder.setLength":
            args[0].s = args[0].s[:args[1]]
            return None
        if short == "StringBuilder.append":
            args[0].s += chr(args[1])
            return args[0]
        if short == "StringBuilder.length":
            return len(args[0].s)
        if short == "WordComposer.reset":
            args[0].reset()
            return None
        if short == "WordComposer.add":
            args[0].codes.append((chr(args[1]), list(args[2])))
            return None
        if short == "WordComposer.size":
            return len(args[0].codes)
        if short == "WordComposer.setFirstCharCapitalized":
            args[0].first_cap = args[1]
            return None
        if short == "WordComposer.setAutoCapitalized":
            args[0].auto_cap = args[1]
            return None
        raise AssertionError("invoke " + target)


class ImeVM(dm.VM):
    def __init__(self, world):
        super().__init__(IME, IME_METHODS, world)
        self.w = world

    def run(self, key, args):
        name = key.split("(")[0]
        w = self.w
        if name == "getCurrentInputConnection":
            return w.ic
        if name == "getCurrentInputEditorInfo":
            return dm.Obj("Landroid/view/inputmethod/EditorInfo;")
        if name == "isPredictionOn":
            return w.prediction
        if name == "getWordSeparators":
            return SEPARATORS
        if name == "isSuggestedPunctuation":
            return 1 if chr(args[1]) in ".,!?" else 0
        if name == "isShiftCapsMode":
            return 0                                   # the shift went off after the digit (and is off in the middle of a sentence)
        if name == "getCursorCapsMode":
            if w.caps is not None:
                return w.caps
            return 1 if w.text == "" or w.text.endswith(". ") or w.text.endswith("\n") else 0
        if name == "sendModifiableKeyChar":
            w.text += chr(args[1])                     # outside a word the character goes to the field as it is
            return None
        if name in ("mrSepClear", "abortCorrection", "saveWordInHistory", "postUpdateSuggestions", "mrLetterTyped", "mrLetterDone",
                    "updateShiftKeyState"):
            return None
        if name == "commitTyped":
            raise AssertionError("commitTyped: no modifier is on in these cases")
        return super().run(key, args)


class DigitVM(dm.VM):
    def __init__(self, world):
        super().__init__(DIGIT, DIGIT_METHODS, world)


def letters(w):
    return "".join(c for c, _ in w.word.codes)


for label, ac in (("Autocompletar on", 1), ("Autocompletar off", 0)):
    # the start of the text: the shift was on for the 5
    w = World(autocorrect=ac)
    w.type("5")
    check(label + ": 5 alone: written as it is, no word", w.shown() == "5" and w.this.f["mPredicting"] == 0, (w.shown(), w.this.f["mPredicting"]))
    w.type("u")
    check(label + ": 5 then u: one word '5u' composing, the 5 left the committed text", w.text == "" and w.comp == "5u"
          and w.this.f["mPredicting"] == 1 and str(w.this.f["mComposing"]) == "5u", (w.text, w.comp))
    check(label + ": the word has the touch of the 5 (t under it) and of the u", w.word.codes == [("5", touch("5")), ("u", touch("u"))],
          w.word.codes)
    check(label + ": start of the text: the word is marked capitalized by the keyboard (suggestions as Tudo)",
          w.word.first_cap == 1 and w.word.auto_cap == 1, (w.word.first_cap, w.word.auto_cap))
    w.type("do")
    check(label + ": 5udo: the whole word composing, nothing else in the field", w.shown() == "5udo" and w.comp == "5udo"
          and letters(w) == "5udo", (w.text, w.comp))

    # the middle of a sentence: no capital
    w = World("eu acho que ", autocorrect=ac)
    w.type("5udo")
    check(label + ": after a space in a sentence: '5udo' composing", w.text == "eu acho que " and w.comp == "5udo", (w.text, w.comp))
    check(label + ": ... with no capital", w.word.first_cap == 0 and w.word.auto_cap == 0, (w.word.first_cap, w.word.auto_cap))

    # after an opening bracket or quote
    for opener in ("(", "\"", "¿"):
        w = World("ele disse " + opener, autocorrect=ac)
        w.type("3ntão")
        check(label + ": after %s the word starts with the digit" % opener, w.comp == "3ntão" and w.text == "ele disse " + opener,
              (w.text, w.comp))

    # a number, a digit after a word, the symbols sheet, the prediction off, text glued after the cursor: as before
    w = World("às ", autocorrect=ac)
    w.type("10h")
    check(label + ": 10h: a number stays as it is (no word, nothing deleted)", w.shown() == "às 10h" and w.comp == "" and w.deleted == 0
          and w.this.f["mPredicting"] == 0, (w.text, w.comp))
    w = World("ok ", autocorrect=ac)
    w.type("a5u")
    check(label + ": a5u: the digit inside a word stays in the word, as before", w.comp == "a5u" and w.deleted == 0, (w.text, w.comp))
    w = World("ok ", autocorrect=ac)
    w.type("5", alpha=0)
    w.type("u")
    check(label + ": a digit of the symbols sheet: the letter after it does not take it", w.shown() == "ok 5u" and w.comp == ""
          and w.deleted == 0, (w.text, w.comp))
    w = World("ok ", autocorrect=ac, prediction=0)
    w.type("5udo")
    check(label + ": prediction off: as before", w.shown() == "ok 5udo" and w.comp == "" and w.deleted == 0, (w.text, w.comp))
    w = World("ok ", after="x", autocorrect=ac)
    w.type("5u")
    check(label + ": text glued after the cursor: as before", w.shown() == "ok 5u" and w.comp == "" and w.deleted == 0, (w.text, w.comp))
    w = World("ok ", autocorrect=ac)
    w.type("5")
    w.type(",")
    w.text = w.text[:-1]                        # the comma deleted by hand: the 5 is alone again, but it was not the last thing typed
    w.type("u")
    check(label + ": a 5 that was not the last thing typed: as before", w.shown() == "ok 5u" and w.comp == "" and w.deleted == 0,
          (w.text, w.comp))
    w = World("ok ", autocorrect=ac)
    w.type("55u")
    check(label + ": 55u (two digits): as before", w.shown() == "ok 55u" and w.comp == "" and w.deleted == 0, (w.text, w.comp))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
