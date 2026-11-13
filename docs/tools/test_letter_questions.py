#!/usr/bin/env python3
"""Tests of the questions the keyboard asks the app for each letter it types (LatinIME.handleCharacter, stage 6 of
docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_letter_questions.py

Every question to the app blocks the main thread of the keyboard until the app answers, and how long that takes depends on the app
and on the phone, so the test counts the questions, not milliseconds. For each letter typed the keyboard asked:
  1. isCursorTouchingWord (the character before the cursor, and the one after it when the one before did not settle it), even when
     a word was already being predicted, where the answer cannot change anything: the block it guards also needs "not predicting";
  2. the caps mode of the cursor (updateShiftKeyState -> getCursorCapsMode), whose answer in the middle of a word is always 0
     (TextUtils.getCapsMode: with a letter before the cursor only the all-capitals flag, 0x1000, can be in the answer).
Now:
  1. handleCharacter looks at mPredicting first and asks isCursorTouchingWord only when no word is being predicted. Same decisions
     (the check has no effect of its own), fewer questions, no assumption about the app;
  2. handleCharacter notes, from the letter typed until the shift state is updated, that the character before the cursor is that
     letter (mrLetterTyped / mrLetterDone: a letter, no Ctrl/Alt/Meta); getCursorCapsMode then does not ask when the note is up and
     the field does not ask for all capitals (0x1000). In every other case it asks as before. The note never outlives the key.
Part 1 runs the REAL smali of these methods in the mini Dalvik interpreter (dalvik_mini.py) with a fake app that counts the
questions and answers like TextUtils.getCapsMode. Part 2 reads the smali for the shape of the change.
With MR_SMALI_DIR set to another smali folder (an older build) only the counts of the typed word are of interest: the checks that
describe the new behaviour fail there.
"""
import os
import sys
import unicodedata

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

OTHER = os.environ.get("MR_SMALI_DIR")
APP = OTHER or os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
IC = "Landroid/view/inputmethod/InputConnection;"
EI = "Landroid/view/inputmethod/EditorInfo;"
ok = fails = 0

CAP_CHARACTERS, CAP_WORDS, CAP_SENTENCES = 0x1000, 0x2000, 0x4000
TEXT = 0x1


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


WANTED = ("handleCharacter(I[I)V", "getCursorCapsMode(" + IC + EI + ")I", "isCursorTouchingWord()Z",
          "mrLetterTyped(I)V", "mrLetterDone()V", "mrSepClear()V", "updateShiftKeyState(" + EI + ")V")
ALL = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
if not OTHER:
    assert len(METHODS) == len(WANTED), sorted(set(WANTED) - set(METHODS))

SEPARATORS = " \n.,;:!?()-\""
PUNCT = "'"


def caps_mode(text, off, req):
    """TextUtils.getCapsMode (what the app answers), without the abbreviation rule that does not matter after a letter."""
    if off < 0:
        return 0
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


class ImeVM(dm.VM):
    """Notes the state of the "letter just typed" note each time the REAL updateShiftKeyState starts."""

    def __init__(self, methods, host):
        super().__init__(IME, methods, host)
        self.host = host

    def run(self, key, args):
        if key.startswith("updateShiftKeyState("):
            self.host.noted_during_shift.append(args[0].f["mMrLetter"])
        return super().run(key, args)


class Host:
    """The fake keyboard around the methods under test, and the fake app (a text, a cursor and a composing region)."""

    def __init__(self, text="", input_type=TEXT | CAP_SENTENCES, predicting=False, auto_cap=True):
        self.text = text
        self.cursor = len(text)
        self.comp = None                    # (start, end) of the composing text, or None
        self.questions = []                 # "before" / "after" / "caps", in order
        self.shift = None                   # the last state given to KeyboardSwitcher.setShiftState
        self.shift_calls = 0
        self.calls = []
        self.ic = dm.Obj(IC)
        self.ei = dm.Obj(EI, inputType=input_type)
        self.words = []                     # the letters of the word composer
        self.vm = ImeVM(METHODS, self)
        self.ime = dm.Obj(IME, mLastSelectionStart=self.cursor, mLastSelectionEnd=self.cursor, mPredicting=1 if predicting else 0,
                          mModCtrl=0, mModAlt=0, mModMeta=0, mComposing=dm.Obj("Ljava/lang/StringBuilder;", s=""),
                          mBestWord="", mWord=dm.Obj("Lcom/mrkeyboard/app/WordComposer;"), mAutoCapActive=1 if auto_cap else 0,
                          mKeyboardSwitcher=dm.Obj("Lcom/mrkeyboard/app/KeyboardSwitcher;"),
                          mShiftKeyState=dm.Obj("Lcom/mrkeyboard/app/ModifierKeyState;"), mSavedShiftState=0,
                          mMrSepAt=0, mMrSepHit=0, mMrLetter=0)
        self.noted_during_shift = []        # mMrLetter at the moment of each update of the shift state

    # --- the fake app
    def commit(self, s):
        a, b = self.comp if self.comp else (self.cursor, self.cursor)
        self.text = self.text[:a] + s + self.text[b:]
        self.cursor = a + len(s)
        self.comp = None

    def set_composing(self, s):
        a, b = self.comp if self.comp else (self.cursor, self.cursor)
        self.text = self.text[:a] + s + self.text[b:]
        self.cursor = a + len(s)
        self.comp = (a, a + len(s))

    # --- the fake framework
    def sget(self, cls, name):
        return dm.Obj(cls + "." + name)

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return False

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        if cls == IC:
            if name == "getTextBeforeCursor":
                self.questions.append("before")
                return self.text[max(0, self.cursor - args[1]):self.cursor]
            if name == "getTextAfterCursor":
                self.questions.append("after")
                return self.text[self.cursor:self.cursor + args[1]]
            if name == "getCursorCapsMode":
                self.questions.append("caps")
                return caps_mode(self.text, self.cursor, args[1])
            if name == "setComposingText":
                self.set_composing(str(args[1].f["s"]))
                return 1
            self.calls.append(name)
            return 1
        if cls == "Lcom/mrkeyboard/app/MrPerf;":
            return None
        if cls == "Landroid/text/TextUtils;" and name == "isEmpty":
            return 1 if not args[0] else 0
        if cls == "Ljava/lang/CharSequence;" and name == "charAt":
            return ord(args[0][args[1]])
        if cls == "Ljava/lang/Character;" and name == "isLetter":
            return 1 if chr(args[0]).isalpha() else 0
        if cls == "Ljava/lang/StringBuilder;":
            sb = args[0]
            if name == "length":
                return len(sb.f["s"])
            if name == "append":
                sb.f["s"] += chr(args[1])
                return sb
            if name == "setLength":
                sb.f["s"] = sb.f["s"][:args[1]]
                return None
        if cls == "Lcom/mrkeyboard/app/WordComposer;":
            if name == "size":
                return len(self.words)
            if name == "add":
                self.words.append(args[1])
                return None
            if name == "reset":
                self.words = []
                return None
        if cls == "Lcom/mrkeyboard/app/KeyboardSwitcher;":
            if name == "isAlphabetMode":
                return 1
            if name == "setShiftState":
                self.shift = args[1]
                self.shift_calls += 1
                return None
        if cls == "Lcom/mrkeyboard/app/ModifierKeyState;" and name == "isChording":
            return 0
        if cls == "Lcom/mrkeyboard/app/TextEntryState;":
            return 0 if name == "isCorrecting" else None
        if cls == IME:
            if name == "isWordSeparator":
                return 1 if chr(args[1]) in SEPARATORS else 0
            if name == "isSuggestedPunctuation":
                return 1 if chr(args[1]) in PUNCT else 0
            if name == "isAlphabet":
                return 1 if chr(args[1]).isalpha() else 0
            if name == "isPredictionOn":
                return 1
            if name == "getCurrentInputConnection":
                return self.ic
            if name == "getCurrentInputEditorInfo":
                return self.ei
            if name == "getShiftState":
                return 0
            if name == "isShiftCapsMode":
                return 0
            if name == "sendModifiableKeyChar":
                self.commit(chr(args[1]))
                return None
            if name == "getCapsOrShiftLockState":
                return 4
        self.calls.append(name)
        return None

    # --- the keys
    def letter(self, ch):
        return self.vm.run("handleCharacter(I[I)V", [self.ime, ord(ch), [ord(ch)]])

    def update_shift(self):
        return self.vm.run("updateShiftKeyState(" + EI + ")V", [self.ime, self.ei])

    def echo(self):
        """The app reports the cursor: what onUpdateSelection keeps."""
        self.ime.f["mLastSelectionStart"] = self.ime.f["mLastSelectionEnd"] = self.cursor

    def reset_count(self):
        self.questions, self.calls = [], []


# ---------------------------------------------------------------- part 1: the real smali
# 1. typing a word: letter by letter, with the echo of each letter in between
def type_word(word, text="", input_type=TEXT | CAP_SENTENCES):
    h = Host(text, input_type=input_type)
    per_key = []
    for ch in word:
        h.reset_count()
        h.letter(ch)
        per_key.append(list(h.questions))
        h.echo()
    return h, per_key


h, per_key = type_word("hello")
print("INFO  questions per key typing 'hello' in an empty field: " + str([len(q) for q in per_key]) + " " + str(per_key))
check("the word is typed as before (composing text, five letters)", h.text == "hello" and h.words == [104, 101, 108, 108, 111], (h.text, h.words))
check("the first letter of a word asks what it did before: before and after the cursor, and its caps mode once",
      sorted(per_key[0]) == ["after", "before", "caps"], per_key[0])
check("the next four letters of the same word ask the app NOTHING", per_key[1:] == [[], [], [], []], per_key[1:])
check("... and the shift state is still updated for each letter (5 times), with the note up each time",
      h.shift_calls == 5 and h.noted_during_shift == [1] * 5, (h.shift_calls, h.noted_during_shift))

# 2. the shift state after each letter is what the app's answer would give
h = Host("")
h.ime.f["mPredicting"] = 0
states = []
for ch in "Ola":
    h.letter(ch)
    h.echo()
    states.append(caps_mode(h.text, h.cursor, TEXT | CAP_SENTENCES))
check("(the app's own answer after each of those letters is 0: nothing to capitalize in the middle of a word)", states == [0, 0, 0], states)

# 3. the caps mode: asked or not, same answer
CONTEXTS = ["", "Hello. ", "Hello.", "hello ", "hello", "\n", "\"", "(", "Hi! ", "Dr. ", "ok?  ", "one\n", "   "]
FLAGS = [TEXT | CAP_SENTENCES, TEXT | CAP_WORDS, TEXT | CAP_CHARACTERS, TEXT, 0, TEXT | CAP_SENTENCES | CAP_CHARACTERS, 0x1002, 0x2002]
bad, asked_when_flagged, cuts = [], 0, 0
for ctx in CONTEXTS:
    for flags in FLAGS:
        for letter in "xÉ":
            text = ctx + letter                      # the letter typed by the keyboard is right before the cursor
            for note in (0, 1):
                h = Host(text, input_type=flags)
                h.ime.f["mMrLetter"] = note
                got = h.vm.run("getCursorCapsMode(" + IC + EI + ")I", [h.ime, h.ic, h.ei])
                want = caps_mode(text, len(text), flags)
                asked = len(h.questions) == 1
                must_ask = flags != 0 and ((not note) or bool(flags & CAP_CHARACTERS))
                if got != want or asked != must_ask or (not asked and h.questions):
                    bad.append((ctx, hex(flags), letter, note, got, want, h.questions))
                cuts += (not asked)
                asked_when_flagged += (asked and bool(flags & CAP_CHARACTERS) and note == 1)
check("caps mode, %d contexts x %d field types x 2 letters, with and without the note: same answer as the app's, asked exactly when the "
      "note is down or the field asks for all capitals (0x1000), and never for a field with no input type" % (len(CONTEXTS), len(FLAGS)),
      not bad, bad[:3])
check("... the cut happened (%d cases) and the all-capitals fields were still asked (%d cases)" % (cuts, asked_when_flagged),
      cuts > 0 and asked_when_flagged > 0)

h = Host("hello", input_type=TEXT | CAP_SENTENCES, auto_cap=False)
h.ime.f["mMrLetter"] = 0
check("auto capitalization off: no question, as before", h.vm.run("getCursorCapsMode(" + IC + EI + ")I", [h.ime, h.ic, h.ei]) == 0
      and h.questions == [])
h = Host("hello", input_type=0)
check("a field with no input type: no question, as before", h.vm.run("getCursorCapsMode(" + IC + EI + ")I", [h.ime, h.ic, h.ei]) == 0
      and h.questions == [])

# 4. what arms the note
for ch, mods, want in (("a", (0, 0, 0), 1), ("É", (0, 0, 0), 1), ("5", (0, 0, 0), 0), (".", (0, 0, 0), 0), ("a", (1, 0, 0), 0),
                       ("a", (0, 1, 0), 0), ("a", (0, 0, 1), 0)):
    h = Host("")
    h.ime.f["mModCtrl"], h.ime.f["mModAlt"], h.ime.f["mModMeta"] = mods
    h.vm.run("mrLetterTyped(I)V", [h.ime, ord(ch)])
    check("the note for %r with Ctrl/Alt/Meta %s: %s" % (ch, mods, "up" if want else "down"), h.ime.f["mMrLetter"] == want, h.ime.f["mMrLetter"])
h.ime.f["mMrLetter"] = 1
h.vm.run("mrLetterDone()V", [h.ime])
check("mrLetterDone puts it down", h.ime.f["mMrLetter"] == 0)

# 5. the note is up exactly while the shift state of the letter is updated, and never after the key
h = Host("")
h.letter("a")
check("after handleCharacter the note is down (it never outlives the key)", h.ime.f["mMrLetter"] == 0)
check("... it was up when the shift state was updated for that letter", h.noted_during_shift[-1:] == [1], h.noted_during_shift)
check("... and the first-letter question of the caps mode (asked before the note) was asked: one 'caps' question for the word",
      h.questions.count("caps") == 1, h.questions)
h.reset_count()
h.update_shift()
check("a later update of the shift state (a message, a field opening): asked as always, one caps question",
      h.questions == ["caps"], h.questions)

h = Host("")
h.ime.f["mModCtrl"] = 1
h.reset_count()
h.letter("a")
check("a letter with Ctrl held (a shortcut, not text): the note is never up for it, the caps mode is asked",
      h.noted_during_shift[-1:] == [0] and "caps" in h.questions, (h.noted_during_shift, h.questions))

h = Host("", input_type=TEXT | CAP_CHARACTERS)
h.letter("a")
h.echo()
h.reset_count()
h.letter("b")
check("an all-capitals field: the caps mode is still asked for every letter", h.questions == ["caps"], h.questions)

# 6. the order of the touching-a-word check
h = Host("", predicting=False)
h.reset_count()
h.letter("a")
check("no word being predicted: the first letter asks isCursorTouchingWord and starts predicting",
      h.ime.f["mPredicting"] == 1 and "before" in h.questions and "after" in h.questions, (h.ime.f["mPredicting"], h.questions))
h = Host("hello ", predicting=False)
h.reset_count()
h.letter("w")
check("... after a space (not touching a word): predicting starts, as before", h.ime.f["mPredicting"] == 1)
h = Host("hel", predicting=False)
h.cursor = 2
h.reset_count()
h.letter("x")
check("the cursor inside a word, nothing predicted: it asks, finds a word, and does NOT start predicting (as before)",
      h.ime.f["mPredicting"] == 0 and "before" in h.questions, (h.ime.f["mPredicting"], h.questions))
h = Host("hel", predicting=True)
h.reset_count()
h.letter("x")
check("a word being predicted: no touching-a-word question at all, predicting stays on", h.ime.f["mPredicting"] == 1
      and "before" not in h.questions and "after" not in h.questions, h.questions)

# 7. a longer text: "ola mundo" with the spaces handled outside (a separator ends the word)
h = Host("")
total = 0
for w in ("hello", "world", "ok"):
    h, pk = type_word(w, text=h.text + (" " if h.text else ""))
    total += sum(len(q) for q in pk)
check("three words typed: 3 + 3 + 3 questions in all (the first letter of each word), the other letters ask nothing", total == 9, total)


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


if not OTHER:
    c = code(body("LatinIME.smali", "private handleCharacter(I[I)V"))
    i_pred = next(i for i, l in enumerate(c) if i > 0 and "->mPredicting:Z" in l and l.startswith("iget-boolean"))
    i_touch = next(i for i, l in enumerate(c) if "->isCursorTouchingWord()Z" in l)
    check("handleCharacter: mPredicting is read, and left for the end of the block when set, before isCursorTouchingWord is called",
          i_pred < i_touch and c[i_pred + 1].startswith("if-nez v0, :cond_1") and sum("isCursorTouchingWord" in l for l in c) == 1,
          c[i_pred:i_touch + 1])
    i_note = next(i for i, l in enumerate(c) if "->mrLetterTyped(I)V" in l)
    i_upd = next(i for i, l in enumerate(c) if "->updateShiftKeyState(" in l)
    i_done = next(i for i, l in enumerate(c) if "->mrLetterDone()V" in l)
    check("handleCharacter: the note goes up with the letter (p1) right before updateShiftKeyState and down right after it",
          c[i_note] == "invoke-direct {p0, p1}, " + IME + "->mrLetterTyped(I)V" and i_note < i_upd < i_done
          and sum("mrLetterTyped" in l for l in c) == 1 and sum("mrLetterDone" in l for l in c) == 1, (i_note, i_upd, i_done))
    first_caps = next(i for i, l in enumerate(c) if "->getCursorCapsMode(" in l)
    check("... the question of the caps mode for the first letter of a word (before setComposingText) comes before the note goes up",
          first_caps < i_note, (first_caps, i_note))
    rets = [i for i, l in enumerate(c) if l.startswith("return")]
    check("... there is no way out of handleCharacter between the note going up and down", len(rets) == 1 and rets[0] > i_done, rets)

    c = code(body("LatinIME.smali", "private getCursorCapsMode(" + IC + EI + ")I"))
    i_note = next(i for i, l in enumerate(c) if "->mMrLetter:Z" in l)
    i_ask = next(i for i, l in enumerate(c) if "InputConnection;->getCursorCapsMode(I)I" in l)
    check("getCursorCapsMode: the note is read after the input type and before the question, 0x1000 is the all-capitals flag, and the "
          "question is still timed", c[i_note + 1].startswith("if-eqz v1") and c[i_note + 2] == "and-int/lit16 v1, p2, 0x1000"
          and c[i_note + 3].startswith("if-nez v1") and i_note < i_ask and c[i_ask - 1] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V"
          and sum("getCursorCapsMode(I)I" in l for l in c) == 1, c[i_note:i_note + 4])

    src = open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read()
    users = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mMrLetter:Z" in m.split("\n.end method")[0])
    check("the note is touched only by mrLetterTyped, mrLetterDone and read only by getCursorCapsMode",
          users == ["getCursorCapsMode(" + IC + EI + ")I", "mrLetterDone()V", "mrLetterTyped(I)V"], users)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
