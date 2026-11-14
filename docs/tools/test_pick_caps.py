#!/usr/bin/env python3
"""Tests the shift state after a word picked on the strip or written by a gesture (stage 6, part 9 of docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_pick_caps.py

The report that started it: with Auto-capitalization on, the first word written by gesture in an empty field comes out with a capital (right)
and the second one too (wrong). A word written by gesture is a word picked (LatinIME.pickSuggestionManually): pickSuggestion and then the
automatic space each end with updateShiftKeyState, which asks the app for the caps mode of the cursor. Both run inside the batch edit
of MrGestureInput.write, and an app whose answers do not follow the text it has just been given (it answers with the text of before the
batch) says "capital" for the empty field, so the shift state after the first word stays on and the next word is written with a capital.

Now pickSuggestionManually sets LatinIME.mMrPick when the word ends in a letter, and getCursorCapsMode does not ask then (unless the field
asks for a capital on every word or all capitals, 0x3000): before the cursor is that letter or the space after it, and TextUtils.getCapsMode
answers 0 there for every other field. The shift state after the word no longer depends on what the app answers in the middle of the batch,
and the two questions of every picked word are gone.

It runs the REAL smali of LatinIME (pickSuggestionManually, updateShiftKeyState, getCursorCapsMode, mrGlue) in the mini Dalvik interpreter over
the harness of test_gesture_comma.py, with a fake app that answers like TextUtils.getCapsMode. Two kinds of app: one that answers with the text as
it is, and one that answers with the text of the moment the batch began (the stale one). A gesture is written the way MrGestureInput does it:
the shift state is read when the finger lifts (withCase), a space first when the text needs one, then pickSuggestionManually(-1, word) in a batch.
What the phone has to confirm is that the app of the report is of the second kind: this test shows that the cut gives the right answer with both.
"""
import os
import sys
import unicodedata

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))

# The harness of test_gesture_comma.py (the World, the real TextEntryState and the interpreter of LatinIME), up to its first test.
_SRC = open(os.path.join(ROOT, "docs", "tools", "test_gesture_comma.py"), encoding="utf-8").read()
_MARK = "# ---------------------------------------------------------------- a word tapped on the strip (the reference)"
assert _MARK in _SRC, "test_gesture_comma.py changed: the harness marker is gone"
_ns = {"__name__": "gesture_comma_head"}
exec(compile(_SRC.split(_MARK)[0], "test_gesture_comma_head", "exec"), _ns)
dm = _ns["dm"]
World = _ns["World"]
ImeVM = _ns["ImeVM"]

CAP_CHARACTERS, CAP_WORDS, CAP_SENTENCES, TEXT = 0x1000, 0x2000, 0x4000, 0x1
EI = "Landroid/view/inputmethod/EditorInfo;"
UPD = "updateShiftKeyState(" + EI + ")V"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def caps_mode(text, off, req):
    """TextUtils.getCapsMode (what the app answers), without the abbreviation rule."""
    mode = req & CAP_CHARACTERS
    if not req & (CAP_WORDS | CAP_SENTENCES):
        return mode
    i = off
    while i > 0 and (text[i - 1] in "\"'" or unicodedata.category(text[i - 1]) == "Ps"):
        i -= 1
    j = i
    while j > 0 and text[j - 1] in " \t":
        j -= 1
    if j == 0 or text[j - 1] == "\n":
        return mode | CAP_WORDS
    if not req & CAP_SENTENCES:
        return mode | (CAP_WORDS if i != j else 0)
    if i == j:
        return mode
    while j > 0 and (text[j - 1] in "\"'" or unicodedata.category(text[j - 1]) == "Pe"):
        j -= 1
    if j > 0 and text[j - 1] in ".?!":
        return mode | CAP_SENTENCES
    return mode


class Flow(ImeVM):
    """pickSuggestion and sendSpace write and then run the real updateShiftKeyState, as the real ones end with it."""

    def run(self, key, args):
        name = key.split("(")[0]
        w = self.w
        if name == "pickSuggestion":
            w.commit(args[1])
            super().run(UPD, [w.this, w.ei])
            return None
        if name == "sendSpace":
            w.commit(" ")
            super().run(UPD, [w.this, w.ei])
            return None
        return super().run(key, args)


class App(World):
    def __init__(self, stale, input_type=TEXT | CAP_SENTENCES, auto_cap=1, text=""):
        super().__init__()
        self.stale = stale
        self.shift = 0
        self.batch = 0
        self.snapshot = None
        self.questions = 0
        self.stubs.pop("updateShiftKeyState", None)
        self.stubs["getShiftState"] = lambda a: self.shift
        self.stubs["getCapsOrShiftLockState"] = 2
        self.stubs["mrShiftCancel"] = None
        self.stubs["mrShiftFlush"] = None
        self.this.f.update(mAutoCapActive=auto_cap, mShiftKeyState=dm.Obj("Lcom/mrkeyboard/app/ModifierKeyState;"), mSavedShiftState=0,
                           mMrLetter=0, mMrPick=0)
        self.vm = Flow(self.ime_methods, self)
        self.text = text
        self.ei = dm.Obj(EI, inputType=input_type)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if cls == "Landroid/view/inputmethod/InputConnection;":
            if name == "beginBatchEdit":
                if not self.batch:
                    self.snapshot = self.text
                self.batch += 1
                return 1
            if name == "endBatchEdit":
                self.batch -= 1
                return 1
            if name == "getCursorCapsMode":
                self.questions += 1
                seen = self.snapshot if (self.stale and self.batch) else self.text
                return caps_mode(seen, len(seen), args[1])
            if name == "clearMetaKeyStates":
                return 1
        if name == "getCurrentInputEditorInfo":
            return self.ei
        if cls == "Lcom/mrkeyboard/app/KeyboardSwitcher;":
            if name == "isAlphabetMode":
                return 1
            if name == "setShiftState":
                self.shift = args[1]
                return None
        if cls == "Lcom/mrkeyboard/app/ModifierKeyState;" and name == "isChording":
            return 0
        return super().invoke(vm, op, target, args)

    def update(self):
        self.vm.run(UPD, [self.this, self.ei])

    def pick_batch(self, word, space):
        """MrGestureInput.write: the space (when needed), then the pick, all in a batch edit."""
        self.invoke(self.vm, "", "Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z", [self.ic])
        if space:
            self.commit(" ")
        self.vm.run("pickSuggestionManually(ILjava/lang/CharSequence;)V", [self.this, -1, word])
        self.invoke(self.vm, "", "Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z", [self.ic])

    def gesture(self, word):
        """The shift state is read when the finger lifts (MrGestureInput.withCase), then the word is written."""
        shift = self.shift
        if shift in (2, 4):
            word = word.upper()
        elif shift in (1, 3):
            word = word[0].upper() + word[1:]
        needs = bool(self.text) and not self.text.endswith((" ", "\n"))
        self.pick_batch(word, needs)
        return word


def run_gestures(app, words):
    app.update()                       # a field opens: the shift state is the one of the empty text
    return [app.gesture(w) for w in words]


# ---------------------------------------------------------------- the report: an empty field, three gestures
for stale in (False, True):
    kind = "an app that follows the text in a batch" if not stale else "an app that answers with the text of before the batch"
    app = App(stale)
    got = run_gestures(app, ["casa", "mesa", "bonita"])
    check("%s: only the first word of the field is capitalized: %s" % (kind, got), got == ["Casa", "mesa", "bonita"] and app.text == "Casa mesa bonita ",
          (got, app.text))
    check("%s: the shift state after each word is off" % kind, app.shift == 0, app.shift)

# ---------------------------------------------------------------- the questions: the two of every picked word are gone
app = App(False)
app.update()
q0 = app.questions
app.gesture("casa")
check("a picked word with the automatic space asks the app no caps mode (it was one for the word and one for the space)", app.questions == q0, app.questions - q0)
app = App(False)
app.this.f["mAutoSpace"] = 0
app.update()
q0 = app.questions
app.gesture("casa")
check("... nor without the automatic space", app.questions == q0, app.questions - q0)

# ---------------------------------------------------------------- the capital where it is right
for stale in (False, True):
    app = App(stale, text="Bom dia. ")
    app.update()
    check("after a sentence end the shift state is capital before the gesture (the update of the key asked the app)", app.shift == 3, app.shift)
    got = app.gesture("casa")
    check("a gesture after a period gets the capital, the one after it does not (stale=%s): %s" % (stale, app.text),
          got == "Casa" and app.shift == 0 and app.gesture("mesa") == "mesa" and app.text == "Bom dia. Casa mesa ", app.text)

# a field that asks for a capital on every word still gets it (the app is asked: its answer after the space is the capital)
app = App(False, input_type=TEXT | CAP_WORDS)
got = run_gestures(app, ["casa", "mesa", "bonita"])
check("a field with a capital on every word: every word is capitalized: %s" % got, got == ["Casa", "Mesa", "Bonita"], got)
check("... and the app was asked after each word", app.questions >= 3 * 2, app.questions)

# a field that asks for all capitals still asks (the answer is not decided by the word)
app = App(False, input_type=TEXT | CAP_CHARACTERS)
q0 = app.questions
app.update()
app.gesture("casa")
check("a field with all capitals: the app is asked for the word and for the space", app.questions - q0 == 3, app.questions - q0)

# a field with no capitals asked for: no question at all
app = App(False, input_type=TEXT)
app.update()
q0 = app.questions
got = [app.gesture(w) for w in ("casa", "mesa")]
check("a field that asks for no capitals: nothing capitalized, nothing asked", got == ["casa", "mesa"] and app.questions == q0, (got, app.questions))

# auto-capitalization off: no capital, no question
app = App(False, auto_cap=0)
app.update()
got = [app.gesture(w) for w in ("casa", "mesa")]
check("auto-capitalization off: nothing capitalized, nothing asked", got == ["casa", "mesa"] and app.questions == 0, (got, app.questions))

# ---------------------------------------------------------------- the shift locked is left alone
for locked in (2, 4):
    app = App(False)
    app.shift = locked
    app.stubs["getCapsOrShiftLockState"] = locked        # the state a locked shift goes back to (LatinIME.getCapsOrShiftLockState)
    got = app.gesture("casa")
    check("shift locked (%d): the word is all capitals and the state is still locked" % locked, got == "CASA" and app.shift == locked, (got, app.shift))

# ---------------------------------------------------------------- a word that does not end in a letter keeps the question
for word in ("etc.", "ok)", "3"):
    app = App(False)
    app.update()
    q0 = app.questions
    app.pick_batch(word, False)
    check("a picked word %r (no letter at the end): the app is asked as before (2 questions)" % word, app.questions - q0 == 2, app.questions - q0)

# ---------------------------------------------------------------- a word tapped on the strip, then letters
for stale in (False, True):
    app = App(stale)
    app.update()
    app.pick_batch("Casa", False)
    check("a word tapped at the start of a field (stale=%s): the next letter is not capital" % stale, app.shift == 0, app.shift)

# ---------------------------------------------------------------- what still ends a sentence: the sign glued to the word, then the capital
for stale in (False, True):
    app = App(stale)
    app.update()
    app.gesture("casa")
    r = app.vm.run("mrGlue(I)Z", [app.this, ord("?")])
    check("a gesture word, then ? glued to it (stale=%s): the next word starts a sentence" % stale, r == 1 and app.text == "Casa? " and app.shift == 3, (r, app.text, app.shift))
    r2 = app.gesture("mesa")
    check("... and it is written with a capital, the one after it without", r2 == "Mesa" and app.gesture("bonita") == "bonita" and app.text == "Casa? Mesa bonita ", app.text)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
