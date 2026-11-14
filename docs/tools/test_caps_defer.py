#!/usr/bin/env python3
"""Tests of the delayed caps question after a separator (LatinIME, stage 6 part 8 of docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_caps_defer.py

At the end of a separator (space, punctuation, Enter) the keyboard updates the shift state: it asks the app for the caps mode of the
cursor (getCursorCapsMode) to know whether the next letter starts a sentence. The app has just been given the separator, so that is
the first question after a change of its text, the slow one (stage 6 part 7 measured it for the echo: about 13 ms against 0.4 ms for
the second). Now, with the switch "Delay the capital-letter check" on (the default, pref_mr_caps_defer):
  - handleSeparator does not ask: mrShiftPost sends message 6 to the handler with the delay of the suggestions (100 ms) and
    LatinIME$1.handleMessage runs it (mrShiftRun) when it arrives;
  - a key (onKey), a text (onText) or a suggestion (pickSuggestionManually) that comes first asks at once (mrShiftFlush, the first
    thing in each of them, after the meter of the key starts) and removes the message, so it sees the shift state it would have seen
    with the switch off;
  - any other update of the shift state (updateShiftKeyState, the first thing it does is mrShiftCancel) replaces the one that waits;
  - the end of the field, the window hidden and the service destroyed drop it without asking (mrShiftCancel next to each
    MrPrevWord.reset);
  - with the switch off, no handler or Auto-capitalization off (the update asks the app nothing then, so nothing is worth waiting
    for), it runs at the end of the separator as before.
The answers do not change, only the moment the question is asked: the part 1 test runs the REAL smali in the mini Dalvik
interpreter (dalvik_mini.py) with a fake app that answers like TextUtils.getCapsMode and compares the shift state every key sees, the
text and the number of questions with the switch off and on, for random sentences and random timings. Part 2 reads the smali for the
shape of the change.
"""
import os
import random
import sys
import unicodedata

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
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


WANTED = ("handleCharacter(I[I)V", "handleSeparator(I)V", "getCursorCapsMode(" + IC + EI + ")I", "isCursorTouchingWord()Z",
          "mrLetterTyped(I)V", "mrLetterDone()V", "mrSepClear()V", "mrSepSent(I)V", "mrEchoCancel()V",
          "updateShiftKeyState(" + EI + ")V", "mrShiftPost(" + EI + ")V", "mrShiftRun()V", "mrShiftFlush()V", "mrShiftCancel()V")
ALL = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
assert len(METHODS) == len(WANTED), sorted(set(WANTED) - set(METHODS))

SEPARATORS = " \n.,;:!?()-\""


def caps_mode(text, off, req):
    """TextUtils.getCapsMode (what the app answers), without the abbreviation rule."""
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


class Host:
    """The fake keyboard around the methods under test, the fake handler and the fake app (a text, a cursor, a composing region)."""

    def __init__(self, defer=False, handler=True, input_type=TEXT | CAP_SENTENCES, text="", auto_cap=True):
        self.text = text
        self.cursor = len(text)
        self.comp = None
        self.questions = []                 # "before" / "after" / "caps", in order
        self.shift = None                   # the last state given to KeyboardSwitcher.setShiftState
        self.shift_calls = 0
        self.calls = []
        self.posts = []                     # (what, delay) of every message sent to the handler
        self.removed = []                   # what of every removeMessages
        self.pending = []                   # the messages that wait
        self.perf = {"capsPosted": 0, "capsRan": 0, "capsFlushed": 0, "capsForget": 0}
        self.words = []
        self.ic = dm.Obj(IC)
        self.ei = dm.Obj(EI, inputType=input_type)
        self.vm = dm.VM(IME, METHODS, self)
        self.ime = dm.Obj(IME, mLastSelectionStart=self.cursor, mLastSelectionEnd=self.cursor, mPredicting=0,
                          mModCtrl=0, mModAlt=0, mModMeta=0, mComposing=dm.Obj("Ljava/lang/StringBuilder;", s=""),
                          mBestWord="", mWord=dm.Obj("Lcom/mrkeyboard/app/WordComposer;"), mAutoCapActive=1 if auto_cap else 0,
                          mKeyboardSwitcher=dm.Obj("Lcom/mrkeyboard/app/KeyboardSwitcher;"),
                          mShiftKeyState=dm.Obj("Lcom/mrkeyboard/app/ModifierKeyState;"), mSavedShiftState=0,
                          mMrSepAt=0, mMrSepHit=0, mMrLetter=0, mMrEchoDefer=0, mAutoCorrectOn=0, mJustAddedAutoSpace=0,
                          mCandidateView=None, mJustRevertedSeparator=None, mAutoCorrectEnabled=0,
                          mHandler=dm.Obj("Landroid/os/Handler;") if handler else None,
                          mMrCapsDefer=1 if defer else 0, mMrCapsPending=0, mMrPick=0)

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
        if cls == "Landroid/os/Handler;":
            if name == "obtainMessage":
                return dm.Obj("Landroid/os/Message;", what=args[1])
            if name == "sendMessageDelayed":
                what = args[1].f["what"]
                self.posts.append((what, args[2]))
                self.pending = [w for w in self.pending if w != what] + [what]
                return 1
            if name == "removeMessages":
                self.removed.append(args[1])
                self.pending = [w for w in self.pending if w != args[1]]
                return None
            raise AssertionError("unexpected Handler call: " + name)
        if cls == "Lcom/mrkeyboard/app/MrPerf;":
            if name in self.perf:
                self.perf[name] += 1
            return None
        if cls == "Lcom/mrkeyboard/app/MrPrevWord;":
            if name == "endsPlain":
                s = str(args[0].f["s"]) if hasattr(args[0], "f") else str(args[0])
                return 1 if s and s[-1].isalpha() else 0
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
                return 0
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
            if name == "commitTyped":           # the word typed is final: the composing region ends and the keyboard forgets the word
                self.comp = None
                self.ime.f["mPredicting"] = 0
                self.ime.f["mComposing"].f["s"] = ""
                self.words = []
                return None
            if name == "getCapsOrShiftLockState":
                return 4
        self.calls.append(name)
        return None

    # --- what the keyboard does for a key (onKey: flush first, then the key) and what the handler does
    def flush(self):
        self.vm.run("mrShiftFlush()V", [self.ime])

    def letter(self, ch):
        self.flush()
        self.vm.run("handleCharacter(I[I)V", [self.ime, ord(ch), [ord(ch)]])
        self.echo()

    def sep(self, ch):
        self.flush()
        self.vm.run("handleSeparator(I)V", [self.ime, ord(ch)])
        self.echo()

    def key(self, ch):
        (self.sep if ch in SEPARATORS else self.letter)(ch)

    def fire(self):
        """The handler delivers message 6 (LatinIME$1.handleMessage -> mrShiftRun), if it still waits."""
        if 6 not in self.pending:
            return False
        self.pending.remove(6)
        self.vm.run("mrShiftRun()V", [self.ime])
        return True

    def echo(self):
        self.ime.f["mLastSelectionStart"] = self.ime.f["mLastSelectionEnd"] = self.cursor

    def reset_count(self):
        self.questions, self.calls = [], []
        self.posts, self.removed = [], []
        self.perf = {"capsPosted": 0, "capsRan": 0, "capsFlushed": 0, "capsForget": 0}


# ---------------------------------------------------------------- part 1: the real smali
def typed_word(h, word):
    for ch in word:
        h.key(ch)


# 1. the switch off: the question is asked at the end of the separator, as before
h = Host(defer=False)
typed_word(h, "casa")
h.reset_count()
shift_before = h.shift_calls
h.sep(" ")
check("switch off: the separator asks the caps mode at its end (one question) and updates the shift state, nothing is sent to the handler",
      h.questions == ["caps"] and h.shift_calls == shift_before + 1 and h.posts == [] and h.pending == [], (h.questions, h.posts))

# 2. the switch on: it waits and the message asks
h = Host(defer=True)
typed_word(h, "casa")
h.reset_count()
shift_before, state_before = h.shift_calls, h.shift
h.sep(" ")
check("switch on: the separator asks the app NOTHING and sends message 6 with the delay of the suggestions (100 ms)",
      h.questions == [] and h.posts == [(6, 100)] and h.pending == [6], (h.questions, h.posts, h.pending))
check("... the shift state is not touched yet, the flag says it waits and the meter is told", h.shift_calls == shift_before and h.shift == state_before
      and h.ime.f["mMrCapsPending"] == 1 and h.perf["capsPosted"] == 1, (h.shift_calls, h.ime.f["mMrCapsPending"], h.perf))
h.reset_count()
check("the message arrives (the app was idle): ONE question (the caps mode) and the shift state is updated",
      h.fire() and h.questions == ["caps"] and h.shift_calls == shift_before + 1 and h.ime.f["mMrCapsPending"] == 0 and h.pending == [],
      (h.questions, h.shift_calls))
check("... the meter is told it ran by the message, nothing was flushed, and the message is not delivered twice",
      h.perf["capsRan"] == 1 and h.perf["capsFlushed"] == 0 and not h.fire())

# 3. a key before the message: asked at once, the message is removed
h = Host(defer=True)
typed_word(h, "casa")
h.sep(" ")
h.reset_count()
h.flush()
check("a key comes before the message (mrShiftFlush, first thing of onKey): the question is asked at once, one question, the message is removed",
      h.questions == ["caps"] and h.removed == [6] and h.pending == [] and h.ime.f["mMrCapsPending"] == 0
      and h.perf["capsFlushed"] == 1 and h.perf["capsRan"] == 0, (h.questions, h.removed, h.perf))
h.reset_count()
h.flush()
check("... a key that finds nothing waiting asks nothing and counts nothing (every key calls the flush)",
      h.questions == [] and h.removed == [] and h.perf["capsFlushed"] == 0)

# 4. another update of the shift state replaces the one that waits
h = Host(defer=True)
typed_word(h, "casa")
h.sep(" ")
h.reset_count()
h.vm.run("updateShiftKeyState(" + EI + ")V", [h.ime, h.ei])
check("an update made by something else replaces the one that waits: asked once (by that update), the message is removed, nothing left to run",
      h.questions == ["caps"] and h.removed == [6] and h.pending == [] and h.ime.f["mMrCapsPending"] == 0 and h.perf["capsForget"] == 1
      and not h.fire(), (h.questions, h.removed, h.perf))

# 5. the end of the field
h = Host(defer=True)
typed_word(h, "casa")
h.sep(" ")
h.reset_count()
h.vm.run("mrShiftCancel()V", [h.ime])
check("the end of the field, the window hidden and the service destroyed (mrShiftCancel): the message is removed, nothing is asked, the meter forgets it",
      h.questions == [] and h.removed == [6] and h.pending == [] and h.ime.f["mMrCapsPending"] == 0 and h.perf["capsForget"] == 1
      and h.perf["capsRan"] == 0 and h.perf["capsFlushed"] == 0 and not h.fire())
h.reset_count()
h.vm.run("mrShiftCancel()V", [h.ime])
check("... nothing waiting: nothing happens", h.removed == [] and h.perf["capsForget"] == 0)

# 6. no handler: asked at once even with the switch on
h = Host(defer=True, handler=False)
typed_word(h, "casa")
h.reset_count()
h.sep(" ")
check("no handler: the question is asked at the end of the separator, as before", h.questions == ["caps"] and h.posts == [], (h.questions, h.posts))

# 6b. Auto-capitalization off: nothing to ask, so nothing waits (even with the switch on)
h = Host(defer=True, auto_cap=False)
typed_word(h, "casa")
h.reset_count()
shift_before = h.shift_calls
h.sep(" ")
check("Auto-capitalization off (switch on): the separator updates the shift state at once, sends no message, asks the app nothing and the meter sees nothing",
      h.questions == [] and h.posts == [] and h.pending == [] and h.shift_calls == shift_before + 1 and h.ime.f["mMrCapsPending"] == 0
      and h.perf["capsPosted"] == 0 and h.perf["capsRan"] == 0, (h.questions, h.posts, h.shift_calls - shift_before, h.perf))
h = Host(defer=False, auto_cap=False)
typed_word(h, "casa")
h.reset_count()
h.sep(" ")
check("... the same with the switch off", h.questions == [] and h.posts == [])

# 7. a run with nothing waiting does nothing (a late message)
h = Host(defer=True)
h.reset_count()
h.vm.run("mrShiftRun()V", [h.ime])
check("a message that finds nothing waiting asks nothing and counts nothing", h.questions == [] and h.perf["capsRan"] == 0)

# 8. the same results as with the switch off, for random sentences and random timings
random.seed(76)
ALPHABET = "abcdefgh" * 3 + "  " * 3 + ".!?,\n"


def session(keys, defer, timing):
    """Types the keys; before each one the handler delivers the message if timing says the app was idle. Returns what each key saw."""
    h = Host(defer=defer)
    seen, in_keys, in_messages = [], 0, 0
    for n, ch in enumerate(keys):
        if timing[n]:
            before = len(h.questions)
            h.fire()
            in_messages += len(h.questions) - before
        before = len(h.questions)
        h.flush()                       # what onKey does first, inside the time of the key; the state is what the key sees
        seen.append(h.shift)
        (h.sep if ch in SEPARATORS else h.letter)(ch)
        in_keys += len(h.questions) - before
    before = len(h.questions)
    h.fire()                            # the last message, when the person stops typing
    in_messages += len(h.questions) - before
    return h, seen, in_keys, in_messages


bad = []
trials = 400
caps_asked_off = caps_asked_on = 0
for _ in range(trials):
    keys = "".join(random.choice(ALPHABET) for _ in range(random.randint(6, 40)))
    off, seen_off, k_off, _ = session(keys, False, [False] * len(keys))
    timing = [random.random() < 0.5 for _ in keys]
    on, seen_on, k_on, m_on = session(keys, True, timing)
    caps_asked_off += off.questions.count("caps")
    caps_asked_on += on.questions.count("caps")
    if (seen_on != seen_off or on.text != off.text or on.shift != off.shift or on.questions.count("caps") != off.questions.count("caps")
            or on.questions.count("before") != off.questions.count("before") or on.pending or on.ime.f["mMrCapsPending"]):
        bad.append((keys, timing, seen_off, seen_on, off.shift, on.shift))
check("%d random sentences with random timings: every key sees the same shift state, the text and the final shift state are the same, and the "
      "app is asked exactly as many times as with the switch off (the questions move, none is added or lost)" % trials, not bad, bad[:1])

bad = []
for _ in range(trials):
    keys = "".join(random.choice(ALPHABET) for _ in range(random.randint(6, 40)))
    off, seen_off, k_off, _ = session(keys, False, [False] * len(keys))
    on, seen_on, k_on, m_on = session(keys, True, [True] * len(keys))
    seps = sum(1 for ch in keys if ch in SEPARATORS)
    if seen_on != seen_off or k_on != k_off - seps or m_on != seps:
        bad.append((keys, k_off, k_on, m_on, seps))
check("the app idle before every key (a pause of 100 ms or more): the separators ask nothing inside their keys (one question fewer in each), the "
      "messages ask them, and every key sees the same shift state", not bad, bad[:1])

bad = []
for _ in range(trials):
    keys = "".join(random.choice(ALPHABET) for _ in range(random.randint(6, 40)))
    off, seen_off, k_off, _ = session(keys, False, [False] * len(keys))
    on, seen_on, k_on, m_on = session(keys, True, [False] * len(keys))
    last = 1 if keys[-1] in SEPARATORS else 0       # only the last separator has no next key: its message asks when the typing stops
    if seen_on != seen_off or k_on != k_off - last or m_on != last:
        bad.append((keys, k_off, k_on, m_on))
check("a fast typist (no pause before any key): the next key asks the question inside its own time, as many as before; only the last "
      "separator, which has no next key, is asked by its message; every key sees the same shift state", not bad, bad[:1])

bad = []
for _ in range(200):
    keys = "".join(random.choice(ALPHABET) for _ in range(random.randint(6, 40)))
    def session_off(defer):
        h = Host(defer=defer, auto_cap=False)
        seen = []
        for ch in keys:
            h.flush()
            seen.append(h.shift)
            (h.sep if ch in SEPARATORS else h.letter)(ch)
        h.fire()
        return h, seen
    a, seen_a = session_off(False)
    b, seen_b = session_off(True)
    if seen_a != seen_b or a.text != b.text or a.shift != b.shift or b.posts or b.questions != a.questions or "caps" in b.questions:
        bad.append((keys, seen_a, seen_b))
check("200 random sentences with Auto-capitalization off: the switch on changes nothing (no message, no caps question, same shift states and text)",
      not bad, bad[:1])

# the sentence that starts with a capital: ". " then a letter, with and without the pause
for pause in (True, False):
    h = Host(defer=True)
    typed_word(h, "ok")
    h.sep(".")
    h.sep(" ")
    if pause:
        h.fire()
    h.flush()
    caps_state = h.shift
    h2 = Host(defer=False)
    typed_word(h2, "ok")
    h2.sep(".")
    h2.sep(" ")
    h2.flush()
    check("'ok. ' then a letter, %s: the shift state the letter sees is the one with the switch off (%s)"
          % ("after a pause" if pause else "at once", caps_state), caps_state == h2.shift and caps_state is not None, (caps_state, h2.shift))


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


FLUSH = "invoke-direct {p0}, " + IME + "->mrShiftFlush()V"
CANCEL = "invoke-direct {p0}, " + IME + "->mrShiftCancel()V"
UPDATE = "->updateShiftKeyState(" + EI + ")V"

c = code(body("LatinIME.smali", "private handleSeparator(I)V"))
check("handleSeparator: the update of the shift state at its end is mrShiftPost; the key has no other direct call to updateShiftKeyState",
      sum("mrShiftPost" in l for l in c) == 1 and not any(UPDATE in l for l in c)
      and c[[i for i, l in enumerate(c) if "mrShiftPost" in l][0]] == "invoke-direct {p0, p1}, " + IME + "->mrShiftPost(" + EI + ")V", c[-8:])
check("... mrShiftPost is the last thing before the batch of edits ends and the previous word is released",
      [i for i, l in enumerate(c) if "mrShiftPost" in l][0] < [i for i, l in enumerate(c) if "endBatchEdit" in l][0]
      < [i for i, l in enumerate(c) if "MrPrevWord;->release" in l][0])

src = open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read()
posters = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mrShiftPost(" in m.split("\n.end method")[0])
check("mrShiftPost is called by handleSeparator and by no one else (the update after a letter, a pick, a mode change... stay as they are)",
      posters == ["handleSeparator(I)V", "mrShiftPost(Landroid/view/inputmethod/EditorInfo;)V"] or posters == ["handleSeparator(I)V"], posters)

c = code(body("LatinIME.smali", "public onKey(I[III)V"))
check("onKey: the meter of the key starts first, then mrShiftFlush, before anything looks at the key (gestures, styled letters, the key itself)",
      c[0] == "invoke-static {p1}, Lcom/mrkeyboard/app/MrPerf;->keyBegin(I)V" and c[1] == FLUSH, c[:3])
c = code(body("LatinIME.smali", "public onText(Ljava/lang/CharSequence;)V"))
check("onText: mrShiftFlush right after the Tasker command check and before the note and the word kept are cleared and the text is inserted",
      FLUSH in c and c.index(FLUSH) < c.index("invoke-direct {p0}, " + IME + "->mrSepClear()V")
      and c.index(FLUSH) < c.index("invoke-direct {p0, p1}, " + IME + "->onTextOrig(Ljava/lang/CharSequence;)V"), c[:8])
c = code(body("LatinIME.smali", "public pickSuggestionManually(ILjava/lang/CharSequence;)V"))
check("pickSuggestionManually: mrShiftFlush is the first thing (a suggestion, and a word of a gesture, is written with the shift state of the text before it)",
      c[0] == FLUSH, c[:2])
c = code(body("LatinIME.smali", "public updateShiftKeyState(" + EI + ")V"))
check("updateShiftKeyState: mrShiftCancel is the first thing (an update made now says what the one that waits would say)", c[0] == CANCEL, c[:2])

for head in ("public onDestroy()V", "public onFinishInput()V", "public onWindowHidden()V", "public onFinishInputView(Z)V",
             "public onStartInputView(" + EI + "Z)V"):
    c = code(body("LatinIME.smali", head))
    r = [i for i, l in enumerate(c) if l == "invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->reset()V"]
    check("%s: what waits is dropped next to the word kept (reset, the echo's cancel, then this one)" % head.split("(")[0].split()[-1],
          len(r) == 1 and c[r[0] + 2] == CANCEL and c.count(CANCEL) == 1, [c[i + 1:i + 3] for i in r])

c = code(body("LatinIME.smali", "private mrShiftPost(" + EI + ")V"))
check("mrShiftPost: only with Auto-capitalization on (first), the switch on and a handler; message 6, the one that waits replaced, 0x64 ms (the delay of the suggestions); the flag and the meter",
      c[0] == "iget-boolean v0, p0, " + IME + "->mAutoCapActive:Z" and c[1].startswith("if-eqz v0, :cond_")
      and c[2] == "iget-boolean v0, p0, " + IME + "->mMrCapsDefer:Z" and c[3].startswith("if-eqz v0, :cond_")
      and "iget-object v0, p0, " + IME + "->mHandler:Landroid/os/Handler;" in c and "const/4 v1, 0x6" in c
      and c.count("invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V") == 1
      and "const-wide/16 v3, 0x64" in c
      and c.count("invoke-virtual {v0, v2, v3, v4}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z") == 1
      and "iput-boolean v0, p0, " + IME + "->mMrCapsPending:Z" in c and "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->capsPosted()V" in c
      and c[-2] == "invoke-virtual {p0, p1}, " + IME + UPDATE and c[-1] == "return-void", c)
c = code(body("LatinIME.smali", "public mrShiftRun()V"))
check("mrShiftRun: only when something waits; the flag goes down, the meter is told, then the update of the shift state",
      c[0] == "iget-boolean v0, p0, " + IME + "->mMrCapsPending:Z" and "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->capsRan()V" in c
      and any(UPDATE in l for l in c) and c.index("invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->capsRan()V") < [i for i, l in enumerate(c) if UPDATE in l][0], c)
c = code(body("LatinIME.smali", "private mrShiftFlush()V"))
check("mrShiftFlush: only when something waits; the flag goes down, the message is removed, the meter is told, then the update of the shift state",
      c[0] == "iget-boolean v0, p0, " + IME + "->mMrCapsPending:Z" and "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->capsFlushed()V" in c
      and c.count("invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V") == 1 and "const/4 v1, 0x6" in c
      and any(UPDATE in l for l in c), c)
c = code(body("LatinIME.smali", "private mrShiftCancel()V"))
check("mrShiftCancel: only when something waits; drops it and asks the app nothing (no question, no update of the shift state)",
      c[0] == "iget-boolean v0, p0, " + IME + "->mMrCapsPending:Z" and "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->capsForget()V" in c
      and not any(UPDATE in l or "InputConnection" in l for l in c), c)

users = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mMrCapsPending:Z" in m.split("\n.end method")[0])
check("the flag of what waits is touched only by the four methods of the delay", users == ["mrShiftCancel()V", "mrShiftFlush()V", "mrShiftPost(" + EI + ")V", "mrShiftRun()V"], users)
users = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mMrCapsDefer:Z" in m.split("\n.end method")[0])
check("the switch is written only by loadSettings and read only by mrShiftPost", users == ["loadSettings()V", "mrShiftPost(" + EI + ")V"], users)
sent = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:]
              if "Landroid/os/Handler;->obtainMessage(I)" in m.split("\n.end method")[0] and "const/4 v1, 0x6" in m.split("\n.end method")[0])
check("message 6 is sent only by mrShiftPost", sent == ["mrShiftPost(" + EI + ")V"], sent)
ls = code(body("LatinIME.smali", "private loadSettings()V"))
i = ls.index('const-string v1, "pref_mr_caps_defer"')
check("loadSettings reads pref_mr_caps_defer, on by default (the 1 kept in v3 for the line above it)",
      ls[i + 1] == "invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z"
      and ls[i + 2] == "move-result v1" and ls[i + 3] == "iput-boolean v1, p0, " + IME + "->mMrCapsDefer:Z"
      and any(l.startswith("const/4 v3, 0x1") for l in ls[:i]), ls[i:i + 4])
c = code(body("LatinIME$1.smali", "public handleMessage(Landroid/os/Message;)V"))
i = c.index("const/4 v0, 0x6")
j = c.index("invoke-virtual {p1}, " + IME + "->mrShiftRun()V")
check("the handler of messages: message 6 goes to mrShiftRun of the keyboard (messages 0, 2, 4 and 5 are as they were)",
      c[i + 1] == "if-eq p1, v0, :cond_mr_shift" and c[j - 1].startswith("iget-object p1, p0, ") and c[j + 1] == "goto :goto_0"
      and sum("mrShiftRun" in l for l in c) == 1 and sum("mrEchoRun" in l for l in c) == 1, c[i:i + 2])

# the switch on the Advanced screen, its texts and the list of Restore defaults
adv = open(os.path.join(ROOT, "res", "xml", "prefs_advanced.xml"), encoding="utf-8").read()
k = adv.index('android:key="pref_mr_caps_defer"')
tag = adv[adv.rindex("<", 0, k):adv.index("/>", k)]
check("the Advanced screen has the switch: a checkbox, saved, on by default, with its three texts, and the switch of the echo is still there",
      tag.startswith("<CheckBoxPreference") and 'android:defaultValue="true"' in tag and 'android:persistent="true"' in tag
      and "@string/mr_ui_caps_defer\"" in tag and "@string/mr_ui_caps_defer_on\"" in tag and "@string/mr_ui_caps_defer_off\"" in tag
      and adv.count("pref_mr_caps_defer") == 1 and adv.count("pref_mr_echo_defer") == 1, tag)
for loc in ("values", "values-pt-rBR", "values-es"):
    sx = open(os.path.join(ROOT, "res", loc, "mr_strings.xml"), encoding="utf-8").read()
    names = ("mr_ui_caps_defer", "mr_ui_caps_defer_on", "mr_ui_caps_defer_off", "mr_ui_perf_caps_run", "mr_ui_perf_caps_flush")
    check("the texts of the switch and of the two meter lines are in %s" % loc,
          all(sx.count('<string name="%s">' % n) == 1 and sx.split('<string name="%s">' % n)[1].split("</string>")[0].strip() for n in names),
          [n for n in names if sx.count('<string name="%s">' % n) != 1])
bools = open(os.path.join(ROOT, "res", "values", "bools.xml"), encoding="utf-8").read()
check("Auto-capitalization is on by default (default_auto_cap) and the screen takes its default from there",
      '<bool name="default_auto_cap">true</bool>' in bools
      and 'android:key="auto_cap" android:defaultValue="@bool/default_auto_cap"' in open(os.path.join(ROOT, "res", "xml", "prefs.xml"), encoding="utf-8").read())
reset = open(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrReset.java"), encoding="utf-8").read()
check("\"Restore defaults\" clears the switch and Auto-capitalization (MrReset.KEYS)", reset.count('"pref_mr_caps_defer"') == 1 and reset.count('"auto_cap"') == 1)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
