#!/usr/bin/env python3
"""Tests of the questions the keyboard asks the app after a separator it typed itself (LatinIME, stage 6 of
docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_echo_questions.py

Every question to the app (getTextBeforeCursor, getTextAfterCursor) blocks the main thread of the keyboard for as long as the app
takes to answer, and that time depends on the app and on the device. So the test counts the questions, not milliseconds.

Before: the app reports the new cursor after each separator (space, comma, Enter...) and the keyboard's re-correction check
(isCursorTouchingWord) asked for the character before the cursor and for the one after it: two questions per separator, both of
them blocking.

Now:
  - isCursorTouchingWord asks for the character after the cursor only when the one before it did not already answer (a letter
    before the cursor is "touching a word" whatever comes after it);
  - handleSeparator notes where the app should report the cursor after the separator (mLastSelectionStart + 1), when the cursor
    was known and nothing was selected; the first report of the selection consumes the note; if the cursor is exactly there, the
    report is the echo of our own separator, the character before the cursor is that separator, and only the character after it
    is asked (mrEchoTouchingWord / mrTouchingRight); in any other case (no note, another cursor position, a selection, any key typed
    in between) the full check runs as before.
  - on Android 12+ the one question that is left (the character after the cursor) also brings the 96 characters before it that the
    next-word prediction asks for right after (MrSurround.echo = getSurroundingText, stage 6 part 5): ONE question for the whole echo
    instead of two. MrSurround answers NONE (-2) on Android 11 or older, with an app that does not answer it and with a selection, and
    then the old question is asked, so the answers never change. The Java class has its own test (docs/tools/prevword_test).
  - stage 6 part 7 (build _75), with the switch "Delay the reaction to the echo" on (the default): the reaction to the echo of our own
    separator (the question to the app and what follows) does not run inside onUpdateSelection; it waits 100 ms in message 5 of mHandler
    (the delay of the suggestions), when the app is idle and the first question is the fast one. Any key (handleSeparator, mrSepClear
    from handleBackspace/handleCharacter/onText), a new report of the selection and every end of the field cancel it (mrEchoCancel); a
    correction in progress (TextEntryState.isCorrecting), a missing handler and the switch off run it at once, as before. When it
    runs (mrEchoRun) it looks again at what must still be true (not predicting, no reverted separator, prediction on) and then does
    exactly what onUpdateSelection did (mrEchoReact), so the answers never change, only when the question is asked.
Part 1 runs the REAL smali of these methods in the mini Dalvik interpreter (dalvik_mini.py) with a fake app that counts the
questions. Part 2 reads the smali for the shape of the change.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
IC = "Landroid/view/inputmethod/InputConnection;"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


WANTED = ("onUpdateSelection(IIIIII)V", "isCursorTouchingWord()Z", "mrSepSent(I)V", "mrSepClear()V", "mrSepEcho(II)V",
          "mrEchoTouchingWord()Z", "mrTouchingRight(" + IC + ")Z", "handleSeparator(I)V",
          "mrEchoPost()Z", "mrEchoReact()V", "mrEchoRun()V", "mrEchoCancel()V")
ALL = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
assert len(METHODS) == len(WANTED), sorted(set(WANTED) - set(METHODS))

SEPARATORS = " \n.,;:!?()-\""
PUNCT = "'"       # a "suggested punctuation" the fake app treats like the real list does: not part of a word, not a separator


class Host:
    """The fake keyboard around the methods under test and the fake app (a text and a cursor) behind the InputConnection."""

    def __init__(self, text="", cursor=None, predicting=False, defer=False):
        self.text = text
        self.cursor = len(text) if cursor is None else cursor
        self.questions = []         # "before" / "after", in order
        self.pairs = [0, 0]         # appBegin, appEnd
        self.sel = [0, 0]           # selBegin, selEnd
        self.cut = [0, 0]           # echoCutBegin, echoCutEnd (the short check)
        self.full = [0, 0]          # echoFullBegin, echoFullEnd (the full check)
        self.calls = []
        self.ic = dm.Obj(IC)
        self.state_obj = dm.Obj("Lcom/mrkeyboard/app/TextEntryState$State;")
        self.vm = dm.VM(IME, METHODS, self)
        self.ime = dm.Obj(IME, mComposing=dm.Obj("Ljava/lang/StringBuilder;"), mPredicting=1 if predicting else 0, mJustAccepted=0,
                          mJustAddedAutoSpace=0, mLastSelectionStart=self.cursor, mLastSelectionEnd=self.cursor,
                          mReCorrectionEnabled=1, mKeyboardSwitcher=dm.Obj("Switcher"), mJustRevertedSeparator=None,
                          mCandidateView=dm.Obj("Candidate"), mMrSepAt=0, mMrSepHit=0, mAutoCorrectOn=0,
                          mHandler=dm.Obj("Landroid/os/Handler;"), mMrEchoDefer=1 if defer else 0)
        self.posts = []             # (what, delay) of every message the keyboard sent to its handler
        self.removed = []           # what of every removeMessages
        self.pending = []           # the messages that wait (a message of the same what replaces the one that waits)
        self.correcting = False     # TextEntryState.isCorrecting
        self.prediction_on = True   # LatinIME.isPredictionOn
        self.echo_perf = {"echoPosted": 0, "echoRan": 0, "echoDropped": 0}
        self.redirect = None
        self.surround = "off"       # what MrSurround.echo finds: "off" (Android 11 or older), "ok" (answers), "null" (the app does not answer)
        self.surround_dead = False  # MrSurround remembers that the app does not answer (until the next field)
        self.surround_clears = 0

    # --- the fake app
    def type_text(self, s):
        self.text = self.text[:self.cursor] + s + self.text[self.cursor:]
        self.cursor += len(s)

    # --- the fake framework
    def sget(self, cls, name):
        if name == "sRedirect":
            return self.redirect
        if name.startswith("$SwitchMap"):
            return [0] * 8
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
            self.calls.append(name)
            return 1
        if cls == "Landroid/os/Handler;":
            if name == "obtainMessage":
                return dm.Obj("Landroid/os/Message;", what=args[1])
            if name == "sendMessageDelayed":
                self.posts.append((args[1].f["what"], args[2]))
                self.pending = [w for w in self.pending if w != args[1].f["what"]] + [args[1].f["what"]]
                return 1
            if name == "removeMessages":
                self.removed.append(args[1])
                self.pending = [w for w in self.pending if w != args[1]]
                return None
            raise AssertionError("unexpected Handler call: " + name)
        if cls == "Lcom/mrkeyboard/app/TextEntryState;" and name == "isCorrecting":
            return 1 if self.correcting else 0
        if cls == "Lcom/mrkeyboard/app/MrPerf;":
            if name in self.echo_perf:
                self.echo_perf[name] += 1
                return None
            idx = {"appBegin": (self.pairs, 0), "appEnd": (self.pairs, 1), "selBegin": (self.sel, 0), "selEnd": (self.sel, 1),
                   "echoCutBegin": (self.cut, 0), "echoCutEnd": (self.cut, 1), "echoFullBegin": (self.full, 0), "echoFullEnd": (self.full, 1)}
            if name in idx:
                idx[name][0][idx[name][1]] += 1
            return None
        if cls == "Lcom/mrkeyboard/app/MrSurround;":
            # The Java class has its own test (docs/tools/prevword_test); here only what the keyboard does with its three answers:
            # NONE (-2: ask as before), END (-1: nothing after the cursor) or the character after the cursor.
            if name == "clear":
                self.surround_clears += 1
                return None
            if name == "echo":
                if self.surround == "off" or self.surround_dead:
                    return -2
                self.questions.append("surround")
                if self.surround == "null":
                    self.surround_dead = True
                    return -2
                return ord(self.text[self.cursor]) if self.cursor < len(self.text) else -1
            raise AssertionError("unexpected MrSurround call: " + name)
        if cls == "Lcom/mrkeyboard/app/MrPrevWord;":
            return None
        if cls == "Landroid/text/TextUtils;" and name == "isEmpty":
            return 1 if not args[0] else 0
        if cls == "Ljava/lang/CharSequence;" and name == "charAt":
            return ord(args[0][args[1]])
        if cls == "Ljava/lang/StringBuilder;" and name == "length":
            return 0
        if cls == IME:
            if name == "isWordSeparator":
                return 1 if chr(args[1]) in SEPARATORS else 0
            if name == "isSuggestedPunctuation":
                return 1 if chr(args[1]) in PUNCT else 0
            if name == "getCurrentInputConnection":
                return self.ic
            if name == "sendModifiableKeyChar":
                self.type_text(chr(args[1]))
                return None
            if name == "isPredictionOn":
                return 1 if self.prediction_on else 0
        if cls == "Lcom/mrkeyboard/app/TextEntryState;" and name == "getState":
            return self.state_obj
        if cls == "Lcom/mrkeyboard/app/TextEntryState$State;" and name == "ordinal":
            return 0
        if cls == "Lcom/mrkeyboard/app/KeyboardSwitcher;" or name == "getInputView":
            return dm.Obj("View")
        if name == "isShown":
            return 1
        if name == "isShowingAddToDictionaryHint":
            return 0
        self.calls.append(name)
        return None

    # --- what the app does
    def echo(self, old=None, new=None, candidates=(-1, -1)):
        """The app reports the cursor: onUpdateSelection(oldStart, oldEnd, newStart, newEnd, candStart, candEnd)."""
        o = self.ime.f["mLastSelectionStart"] if old is None else old
        n = self.cursor if new is None else new
        return self.vm.run("onUpdateSelection(IIIIII)V", [self.ime, o, o, n, n, candidates[0], candidates[1]])

    def separator(self, ch):
        return self.vm.run("handleSeparator(I)V", [self.ime, ord(ch)])

    def fire(self):
        """The handler delivers message 5 (LatinIME$1.handleMessage -> mrEchoRun), if it still waits."""
        if 5 not in self.pending:
            return False
        self.pending.remove(5)
        self.vm.run("mrEchoRun()V", [self.ime])
        return True

    def reset_count(self):
        self.posts, self.removed = [], []
        self.echo_perf = {"echoPosted": 0, "echoRan": 0, "echoDropped": 0}
        self.questions, self.calls = [], []
        self.pairs, self.sel, self.cut, self.full = [0, 0], [0, 0], [0, 0], [0, 0]
        self.surround_clears = 0

    def after_echo(self):
        """What the echo did to the suggestions."""
        return ("old" if "postUpdateOldSuggestions" in self.calls else "next" if "setNextSuggestions" in self.calls else "none")


# ---------------------------------------------------------------- part 1: the real smali
# 1. a word and a space: the echo of the space asks one question, not two
h = Host("hello")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
check("the space is typed by the real handleSeparator", h.text == "hello " and h.cursor == 6, (h.text, h.cursor))
check("... it notes where the app should report the cursor", h.ime.f["mMrSepAt"] == 6, h.ime.f["mMrSepAt"])
h.reset_count()
h.echo()
check("the echo of that space: ONE question to the app (the character after the cursor)", h.questions == ["after"], h.questions)
check("... the answer is the same as before (nothing after the cursor: no word touched, next suggestions)", h.after_echo() == "next", h.calls)
check("... every question is timed (begin/end pairs) and the reaction to the selection is timed once", h.pairs == [1, 1] and h.sel == [1, 1], (h.pairs, h.sel))
check("... the note is consumed", h.ime.f["mMrSepAt"] == 0 and h.ime.f["mMrSepHit"] == 0)
check("... the meter counts it as a short check (one), not as a full one", h.cut == [1, 1] and h.full == [0, 0], (h.cut, h.full))

# 2. the same echo without the note (the keyboard did not type the separator): the full check, two questions as before
h = Host("hello ")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.reset_count()
h.echo()
check("the same echo with no note (another way of getting there): the full check, two questions, same answer",
      h.questions == ["before", "after"] and h.after_echo() == "next", (h.questions, h.after_echo()))
check("... the meter counts it as a full check (one), not as a short one", h.full == [1, 1] and h.cut == [0, 0], (h.cut, h.full))

# 3. a word after the cursor: the right check still sees it
h = Host("helloworld", cursor=5)
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.reset_count()
h.echo()
check("a space typed in front of a word: one question, and the word after the cursor is found (old suggestions)",
      h.questions == ["after"] and h.after_echo() == "old", (h.questions, h.after_echo()))
h = Host("hello world", cursor=5)
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.reset_count()
h.echo()
check("a space typed in front of another space: one question, no word after the cursor (next suggestions)",
      h.questions == ["after"] and h.after_echo() == "next", (h.questions, h.after_echo()))

# 4. punctuation, Enter and others
for ch in ",.;:!?\n()-":
    h = Host("ab")
    h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 2
    h.separator(ch)
    h.reset_count()
    h.echo()
    check("separator %r: one question after its echo" % ch, h.questions == ["after"], h.questions)

# 5. the note is only taken in the safe cases
h = Host("ab")
h.ime.f["mLastSelectionStart"], h.ime.f["mLastSelectionEnd"] = 1, 2           # a selection
h.separator(" ")
check("a selection was active when the separator was typed: no note", h.ime.f["mMrSepAt"] == 0, h.ime.f["mMrSepAt"])
h = Host("ab")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = -1           # the cursor was not known
h.separator(" ")
check("the cursor was not known: no note", h.ime.f["mMrSepAt"] == 0, h.ime.f["mMrSepAt"])
h = Host("ab")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 2
h.vm.run("mrSepSent(I)V", [h.ime, ord("a")])
check("a character that is not a separator: no note", h.ime.f["mMrSepAt"] == 0)
h.vm.run("mrSepSent(I)V", [h.ime, ord(" ")])
check("... a separator: the note is the cursor one place further", h.ime.f["mMrSepAt"] == 3, h.ime.f["mMrSepAt"])
h.vm.run("mrSepSent(I)V", [h.ime, ord("a")])
check("... a character that is not a separator drops an older note", h.ime.f["mMrSepAt"] == 0)

# 6. the report is not the echo: the full check
cases = [("another cursor position", dict(new=0)), ("the cursor further away", dict(new=9)), ]
for label, kw in cases:
    h = Host("hello")
    h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
    h.separator(" ")
    h.reset_count()
    h.echo(**kw)
    check("the app reports %s: the full check runs (the note does not apply)" % label,
          h.questions in (["before"], ["before", "after"]) and h.ime.f["mMrSepAt"] == 0, h.questions)
h = Host("hello")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.reset_count()
h.vm.run("onUpdateSelection(IIIIII)V", [h.ime, 5, 5, 4, 6, -1, -1])         # a selection of one character around the cursor
check("the app reports a selection (start != end): the note is consumed and does not apply", h.ime.f["mMrSepAt"] == 0 and h.ime.f["mMrSepHit"] == 0)

# 7. one-shot: the echo of the next report is a full check
h = Host("hello")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.echo()
h.reset_count()
h.echo(old=6, new=6)
check("a second report at the same place: no note any more, the full check (left is a separator: two questions)",
      h.questions == ["before", "after"], h.questions)

# 8. a delayed echo: the keyboard typed another separator before the first echo arrived
h = Host("hello")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.separator(" ")           # the first echo has not arrived: mLastSelectionStart is still 5, the second note is 6 again
h.reset_count()
h.echo(old=5, new=6)       # the app reports the first space (cursor 6)
q1 = list(h.questions)
check("two separators before the first echo: the note of the second is 6 and the report of the first one (6) matches it; the "
      "text before the cursor is a space in both cases, so the one question gives the same answer as the full check",
      q1 == ["after"] and h.text == "hello  ", (q1, h.text))
h.reset_count()
h.echo(old=6, new=7)       # the report of the second one: no note any more
check("... the next report is a full check", h.questions == ["before", "after"], h.questions)

# 9. letters while predicting: no questions at all
h = Host("hel", predicting=True)
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 2
h.reset_count()
h.echo(old=2, new=3)
check("a letter echoed while predicting (typing a word): no question to the app", h.questions == [], h.questions)
check("... the reaction to the selection is timed", h.sel == [1, 1], h.sel)

# 10. the tool redirect: early return, still timed, still consuming the note
h = Host("hello")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.redirect = dm.Obj("Redirect")
h.reset_count()
h.echo()
check("the input is redirected to a tool: no question, the report is timed once, the note is consumed",
      h.questions == [] and h.sel == [1, 1] and h.ime.f["mMrSepAt"] == 0, (h.questions, h.sel))

# 11. the answers of the lazy isCursorTouchingWord and of the cut are the answers of the full check, for every neighbourhood
def full_check(text, cursor):
    """The check as it was: left character not a separator nor suggested punctuation, or right one the same."""
    def word(c):
        return c is not None and c not in SEPARATORS and c not in PUNCT
    left = text[cursor - 1] if cursor > 0 else None
    right = text[cursor] if cursor < len(text) else None
    return word(left) or word(right)


chars = ["a", "Z", "5", " ", ".", ",", "\n", "'", "-", "é"]
bad = []
for left in [None] + chars:
    for right in [None] + chars:
        text = (left or "") + (right or "")
        cursor = 1 if left else 0
        h = Host(text, cursor=cursor)
        got = h.vm.run("isCursorTouchingWord()Z", [h.ime])
        n = len(h.questions)
        want = full_check(text, cursor)
        left_word = left is not None and left not in SEPARATORS and left not in PUNCT
        if bool(got) != want or h.questions != (["before"] if left_word else ["before", "after"]):
            bad.append((left, right, got, want, h.questions))
check("isCursorTouchingWord: 100 neighbourhoods, same answer as the full check; the character after is asked only when needed", not bad, bad[:3])

bad = []
for left in [c for c in chars if c in SEPARATORS]:      # the character before the cursor is the separator we typed
    for right in [None] + chars:
        text = left + (right or "")
        h = Host(text, cursor=1)
        h.ime.f["mMrSepHit"] = 1
        got = h.vm.run("mrEchoTouchingWord()Z", [h.ime])
        if bool(got) != full_check(text, 1) or h.questions != ["after"] or h.ime.f["mMrSepHit"] != 0:
            bad.append((left, right, got, h.questions))
check("after the echo of a separator: every neighbourhood gives the answer of the full check with one question", not bad, bad[:3])

h = Host("", cursor=0)
h.ime.f["mMrSepHit"] = 1
h.ic = None
check("the answer with no input connection is False, as before, with no question", h.vm.run("mrEchoTouchingWord()Z", [h.ime]) in (0, False)
      and h.questions == [], h.questions)

# 12. a typing session: "hello world, ok" letter by letter with the echoes; count what the app is asked
h = Host("")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 0
total = 0
KEYS = "hello world, ok"
for ch in KEYS:
    if ch in SEPARATORS:
        h.separator(ch)
        h.ime.f["mPredicting"] = 0
    else:
        h.type_text(ch)
        h.ime.f["mPredicting"] = 1
    h.reset_count()
    h.echo(old=h.ime.f["mLastSelectionStart"])
    total += len(h.questions)
seps = sum(1 for ch in KEYS if ch in SEPARATORS)
check("typing 'hello world, ok' (%d keys, %d separators): the echoes ask %d questions, one per separator (before: two per separator)"
      % (len(KEYS), seps, total), total == seps == 3, (total, seps))


# 13. stage 6, part 5 (B): on Android 12+ ONE question (MrSurround.echo = getSurroundingText) answers both the character after the cursor
# and the text before it that the next-word prediction needs; any other case asks as before
def after_sep_echo(mode, text="hello", cursor=5, dead=False):
    h = Host(text, cursor=cursor)
    h.surround = mode
    h.surround_dead = dead
    h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = cursor
    h.separator(" ")
    h.reset_count()
    h.echo()
    return h


h = after_sep_echo("ok")
check("Android 12+ (the app answers getSurroundingText): the echo of our separator asks the app ONE question (before: 2)",
      h.questions == ["surround"] and h.after_echo() == "next", (h.questions, h.after_echo()))
check("... every question is timed and the reaction to the selection is timed once", h.pairs == [0, 0] and h.sel == [1, 1], (h.pairs, h.sel))
h = after_sep_echo("off")
check("Android 11 or older: the same echo asks one question the old way (the character after the cursor)",
      h.questions == ["after"] and h.pairs == [1, 1], (h.questions, h.pairs))
h = after_sep_echo("null")
check("an app that does not answer: the first echo asks the surround question and then the old one (2, as it was before stage 6)",
      h.questions == ["surround", "after"] and h.after_echo() == "next", h.questions)
h.separator(" ")
h.reset_count()
h.echo(old=6)
check("... and it is not asked again in the same field: the next echo asks only the old question", h.questions == ["after"], h.questions)

bad = []
for left in [c for c in chars if c in SEPARATORS]:      # every neighbourhood: the answer with the surround question is the one of the old check
    for right in [None] + chars:
        text = left + (right or "")
        answers = []
        for mode in ("off", "ok", "null"):
            h = Host(text, cursor=1)
            h.surround = mode
            h.ime.f["mMrSepHit"] = 1
            answers.append((bool(h.vm.run("mrEchoTouchingWord()Z", [h.ime])), tuple(h.questions)))
        if not (answers[0][0] == answers[1][0] == answers[2][0] == full_check(text, 1)
                and answers[0][1] == ("after",) and answers[1][1] == ("surround",) and answers[2][1] == ("surround", "after")):
            bad.append((left, right, answers))
check("after the echo of a separator: every neighbourhood gives the same answer in the three modes (Android 12+, older, no answer)", not bad, bad[:2])

h = Host("helloworld", cursor=5)
h.surround = "ok"
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.reset_count()
h.echo()
check("a space typed in front of a word, Android 12+: the word after the cursor is found with the one question (old suggestions)",
      h.questions == ["surround"] and h.after_echo() == "old", (h.questions, h.after_echo()))
h = Host("hello ")
h.surround = "ok"
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.reset_count()
h.echo()
check("the full check (no note) does not use the surround question: two questions, as before, in every mode",
      h.questions == ["before", "after"], h.questions)
h = Host("hel", predicting=True)
h.surround = "ok"
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 2
h.reset_count()
h.echo(old=2, new=3)
check("a letter echoed while predicting: still no question, with the surround question available", h.questions == [], h.questions)
h = Host("hello")
h.surround = "ok"
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.separator(" ")
h.reset_count()
h.echo()
check("every report of the selection drops the text kept from the last one (MrSurround.clear at the start of mrSepEcho and at the exit taken)",
      h.surround_clears == 2, h.surround_clears)

# 14. the typing session of 12 again, on Android 12+: one question per separator in the echo
h = Host("")
h.surround = "ok"
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 0
total = 0
for ch in KEYS:
    if ch in SEPARATORS:
        h.separator(ch)
        h.ime.f["mPredicting"] = 0
    else:
        h.type_text(ch)
        h.ime.f["mPredicting"] = 1
    h.reset_count()
    h.echo(old=h.ime.f["mLastSelectionStart"])
    total += len(h.questions)
check("typing 'hello world, ok' on Android 12+: %d questions in the echoes, one per separator and all of them the surround one" % total, total == seps == 3, (total, seps))

# 15. stage 6 part 7: the reaction to the echo of our own separator waits for the app to be idle (switch on) and any key ends the wait
def echo_after_sep(text="hello", cursor=5, mode="off", defer=True):
    h = Host(text, cursor=cursor, defer=defer)
    h.surround = mode
    h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = cursor
    h.separator(" ")
    h.reset_count()
    h.echo()
    return h


h = echo_after_sep(defer=False)
check("switch off: the echo asks and reacts at once (one question, next suggestions), nothing is sent to the handler",
      h.questions == ["after"] and h.after_echo() == "next" and h.posts == [] and h.echo_perf["echoPosted"] == 0, (h.questions, h.posts))
h = echo_after_sep()
check("switch on: the echo of the separator asks the app NOTHING and sends one message (5) to the handler with the delay of the suggestions (100 ms)",
      h.questions == [] and h.posts == [(5, 100)] and h.pending == [5] and h.after_echo() == "none", (h.questions, h.posts, h.after_echo()))
check("... the meter is told it waits, the note of the separator is consumed and the echo mark is kept for the reaction",
      h.echo_perf["echoPosted"] == 1 and h.ime.f["mMrSepAt"] == 0 and h.ime.f["mMrSepHit"] == 1, (h.echo_perf, h.ime.f["mMrSepAt"], h.ime.f["mMrSepHit"]))
check("... the report of the selection is still timed once", h.sel == [1, 1], h.sel)
h.reset_count()
check("the message arrives (the app was idle): ONE question, the same reaction as before (next suggestions), the echo mark is used up",
      h.fire() and h.questions == ["after"] and h.after_echo() == "next" and h.ime.f["mMrSepHit"] == 0 and h.pending == [],
      (h.questions, h.after_echo(), h.ime.f["mMrSepHit"]))
check("... the meter is told it ran, the text kept after the echo is dropped, nothing is sent again",
      h.echo_perf["echoRan"] == 1 and h.surround_clears == 1 and h.posts == [], (h.echo_perf, h.surround_clears, h.posts))
check("... a message that is not waiting is not delivered twice", not h.fire())

# the same answers as before for every neighbourhood and every way the app answers: waiting only moves the question in time
bad = []
for left in [c for c in chars if c in SEPARATORS]:
    for right in [None] + chars:
        for mode in ("off", "ok", "null"):
            text = left + (right or "")
            now = Host(text, cursor=1)
            now.surround = mode
            now.ime.f["mLastSelectionStart"] = now.ime.f["mLastSelectionEnd"] = 0
            now.ime.f["mMrSepAt"] = 1
            now.reset_count()
            now.echo(old=0, new=1)
            late = Host(text, cursor=1, defer=True)
            late.surround = mode
            late.ime.f["mLastSelectionStart"] = late.ime.f["mLastSelectionEnd"] = 0
            late.ime.f["mMrSepAt"] = 1
            late.reset_count()
            late.echo(old=0, new=1)
            first = list(late.questions)
            late.fire()
            if (first != [] or late.questions != now.questions or late.after_echo() != now.after_echo()
                    or late.ime.f["mMrSepHit"] != 0 or late.pending != []):
                bad.append((left, right, mode, now.questions, now.after_echo(), first, late.questions, late.after_echo()))
check("every neighbourhood, in the three modes (Android 12+, older, no answer): waiting gives the same questions and the same suggestions as asking at once",
      not bad, bad[:2])

# a key before the message arrives ends the wait: nothing is asked, nothing is shown, the meter counts it as dropped
def pending_echo(**kw):
    h = echo_after_sep(**kw)
    assert h.pending == [5]
    h.reset_count()
    return h


h = pending_echo()
h.vm.run("mrSepClear()V", [h.ime])
check("a letter, a backspace or a text (mrSepClear) ends the wait: the message is removed, the meter counts a drop, the echo mark is cleared",
      h.pending == [] and h.removed == [5] and h.echo_perf["echoDropped"] == 1 and h.ime.f["mMrSepHit"] == 0 and not h.fire() and h.questions == [],
      (h.pending, h.removed, h.echo_perf))
h = pending_echo()
h.separator(" ")
check("another separator ends the wait too (handleSeparator, first thing) and notes its own separator", h.pending == [] and h.removed[:1] == [5]
      and h.echo_perf["echoDropped"] == 1 and h.ime.f["mMrSepAt"] != 0 and h.questions == [], (h.pending, h.removed, h.echo_perf, h.questions))
h = pending_echo()
h.echo(old=6, new=6)
check("a new report of the selection ends the old wait before anything else; the new one is a full check (no note), so it waits again as one message",
      h.removed[:1] == [5] and h.echo_perf["echoDropped"] == 1 and h.pending == [5] and h.posts == [(5, 100)] and h.questions == [],
      (h.removed, h.echo_perf, h.pending, h.posts, h.questions))
h = pending_echo()
h.vm.run("mrEchoCancel()V", [h.ime])
check("the end of the field, the window hidden and the service destroyed use the same cancel: the wait and the echo mark are gone",
      h.pending == [] and h.removed == [5] and h.ime.f["mMrSepHit"] == 0 and not h.fire())

# when the reaction does not wait
h = echo_after_sep(defer=True)
h2 = Host("hello", defer=True)
h2.correcting = True
h2.ime.f["mLastSelectionStart"] = h2.ime.f["mLastSelectionEnd"] = 5
h2.separator(" ")
h2.reset_count()
h2.echo()
check("a correction in progress (TextEntryState.isCorrecting): the reaction runs at once, as before (one question, next suggestions), nothing waits",
      h2.questions == ["after"] and h2.after_echo() == "next" and h2.posts == [] and h2.pending == [] and h2.echo_perf["echoPosted"] == 0,
      (h2.questions, h2.posts))
h2 = Host("hello", defer=True)
h2.ime.f["mHandler"] = None
h2.ime.f["mLastSelectionStart"] = h2.ime.f["mLastSelectionEnd"] = 5
h2.separator(" ")
h2.reset_count()
h2.echo()
check("no handler: the reaction runs at once, as before", h2.questions == ["after"] and h2.after_echo() == "next" and h2.posts == [], (h2.questions, h2.posts))
h2 = Host("hel", predicting=True, defer=True)
h2.ime.f["mLastSelectionStart"] = h2.ime.f["mLastSelectionEnd"] = 2
h2.reset_count()
h2.echo(old=2, new=3)
check("a letter echoed while predicting (typing a word): nothing waits, nothing is asked", h2.questions == [] and h2.posts == [] and h2.pending == [], (h2.questions, h2.posts))
h2 = Host("hello", defer=True)
h2.ime.f["mLastSelectionStart"] = h2.ime.f["mLastSelectionEnd"] = 5
h2.separator(" ")
h2.redirect = dm.Obj("Redirect")
h2.reset_count()
h2.echo()
check("the input is redirected to a tool: nothing waits, nothing is asked", h2.questions == [] and h2.posts == [] and h2.pending == [], (h2.questions, h2.posts))

# what is looked at again when the message arrives
for label, change in (("a word is being typed (mPredicting)", lambda x: x.ime.f.__setitem__("mPredicting", 1)),
                      ("a separator was just reverted", lambda x: x.ime.f.__setitem__("mJustRevertedSeparator", "x")),
                      ("the prediction was turned off", lambda x: setattr(x, "prediction_on", False))):
    h = pending_echo()
    change(h)
    h.fire()
    check("the message arrives but %s: nothing is asked, nothing is shown, the meter still counts that it ran, the kept text is dropped" % label,
          h.questions == [] and h.after_echo() == "none" and h.echo_perf["echoRan"] == 1 and h.surround_clears == 1, (h.questions, h.calls, h.echo_perf))

# a word after the cursor: the reaction that waited still finds it (old suggestions), on Android 12+ with one question
h = echo_after_sep(text="helloworld", cursor=5, mode="ok")
h.reset_count()
h.fire()
check("a space typed in front of a word, Android 12+, the reaction waited: one question (surround) and the old suggestions", h.questions == ["surround"] and h.after_echo() == "old", (h.questions, h.after_echo()))

# the typing session: fast typing (every key comes before the 100 ms) and slow typing (the app is idle after every key)
for label, idle in (("fast typing: every key comes before the message", False), ("slow typing: the message arrives before every next key", True)):
    h = Host("", defer=True)
    h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 0
    asked = dropped = ran = 0
    for ch in KEYS:
        if ch in SEPARATORS:
            h.separator(ch)
            h.ime.f["mPredicting"] = 0
        else:
            h.type_text(ch)
            h.vm.run("mrSepClear()V", [h.ime])
            h.ime.f["mPredicting"] = 1
        h.reset_count()
        h.echo(old=h.ime.f["mLastSelectionStart"])
        if idle:
            h.fire()
        asked += len(h.questions)
        ran += h.echo_perf["echoRan"]
    check("typing 'hello world, ok' with the switch on, %s: %d questions in the echoes (%d separators; before stage 6 it was 2 per separator, "
          "at once it is 1 per separator)" % (label, asked, seps), asked == (seps if idle else 0) and ran == (seps if idle else 0), (asked, ran))


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


c = code(body("LatinIME.smali", "public onUpdateSelection(IIIIII)V"))
check("onUpdateSelection: the first thing is selBegin, before the super call",
      c[0] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->selBegin()V" and c[1].startswith("invoke-super/range"), c[:2])
check("... right after the super call the wait of the delayed reaction ends (mrEchoCancel), then the report is checked against the note",
      c[2] == "invoke-direct {p0}, " + IME + "->mrEchoCancel()V" and c[3] == "invoke-direct {p0, p3, p4}, " + IME + "->mrSepEcho(II)V", c[:5])
ends = [i for i, l in enumerate(c) if l == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->selEnd()V"]
rets = [i for i, l in enumerate(c) if l == "return-void"]
check("... selEnd, then MrSurround.clear (the text kept for the next-word prediction is dropped), right before each of the two exits",
      len(rets) == 2 and ends == [i - 2 for i in rets]
      and all(c[i + 1] == "invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->clear()V" for i in ends), (ends, rets))
post_i = [i for i, l in enumerate(c) if l == "invoke-direct {p0}, " + IME + "->mrEchoPost()Z"]
react_i = [i for i, l in enumerate(c) if l == "invoke-direct {p0}, " + IME + "->mrEchoReact()V"]
check("... the reaction is mrEchoReact, and only after mrEchoPost said it does not wait (move-result, if-nez to the exit); onUpdateSelection itself asks nothing",
      len(post_i) == 1 and len(react_i) == 1 and c[post_i[0] + 1] == "move-result p1" and c[post_i[0] + 2].startswith("if-nez p1, :cond_")
      and react_i[0] == post_i[0] + 3 and not any("mrEchoTouchingWord" in l or "isCursorTouchingWord" in l for l in c), (post_i, react_i))
c = code(body("LatinIME.smali", "private mrEchoReact()V"))
check("mrEchoReact: the question to the app goes through mrEchoTouchingWord and nothing else calls isCursorTouchingWord here",
      c.count("invoke-direct {p0}, " + IME + "->mrEchoTouchingWord()Z") == 1 and not any("isCursorTouchingWord" in l for l in c))
check("... it ends the correction and shows the next-word suggestions, or asks for the old ones (the code that ran inside onUpdateSelection)",
      sum("abortCorrection" in l for l in c) == 1 and sum("setNextSuggestions" in l for l in c) == 1 and sum("postUpdateOldSuggestions" in l for l in c) == 1)

c = code(body("LatinIME.smali", "private handleSeparator(I)V"))
i = c.index("invoke-virtual {p0, v1}, " + IME + "->sendModifiableKeyChar(C)V")
check("handleSeparator: the note is taken once, right after the separator is sent, with the separator typed (p1)",
      c[i + 1] == "invoke-direct {p0, p1}, " + IME + "->mrSepSent(I)V" and sum("mrSepSent" in l for l in c) == 1
      and sum("sendModifiableKeyChar" in l for l in c) == 1, c[i:i + 2])

c = code(body("LatinIME.smali", "private handleBackspace()V"))
check("handleBackspace clears the note before anything is asked or deleted",
      c.index("invoke-direct {p0}, " + IME + "->mrSepClear()V") < c.index("invoke-virtual {p0}, " + IME + "->getCurrentInputConnection()" + IC), c[:4])
c = code(body("LatinIME.smali", "private handleCharacter(I[I)V"))
check("handleCharacter clears the note first thing", c[0] == "invoke-direct {p0}, " + IME + "->mrSepClear()V", c[:2])
c = code(body("LatinIME.smali", "public onText(Ljava/lang/CharSequence;)V"))
check("onText clears the note before inserting the text",
      c.index("invoke-direct {p0}, " + IME + "->mrSepClear()V") < c.index("invoke-direct {p0, p1}, " + IME + "->onTextOrig(Ljava/lang/CharSequence;)V"), c)

c = code(body("LatinIME.smali", "private isCursorTouchingWord()Z"))
after_q = next(i for i, l in enumerate(c) if "getTextAfterCursor" in l)
before_q = next(i for i, l in enumerate(c) if "getTextBeforeCursor" in l)
first_return_true = next(i for i, l in enumerate(c) if l == "return v2")
check("isCursorTouchingWord: the question after the cursor comes after the check of the character before it, which may return first",
      before_q < first_return_true < after_q and sum("getTextAfterCursor" in l for l in c) == 1 and sum("getTextBeforeCursor" in l for l in c) == 1, (before_q, first_return_true, after_q))
check("... each of the two questions is timed (appBegin before, appEnd after)",
      [c[before_q - 1], c[before_q + 1] if c[before_q + 1].startswith("move-result") else None] [0] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V"
      and c[after_q - 1] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V"
      and c[after_q + 2] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V", (c[after_q - 1], c[after_q + 2]))

c = code(body("LatinIME.smali", "private mrTouchingRight(" + IC + ")Z"))
check("mrTouchingRight asks only for the character after the cursor, timed, and tests it like isCursorTouchingWord",
      sum("getTextAfterCursor" in l for l in c) == 1 and not any("getTextBeforeCursor" in l for l in c)
      and c.index("invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V") < next(i for i, l in enumerate(c) if "getTextAfterCursor" in l)
      < c.index("invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V")
      and any("isWordSeparator" in l for l in c) and any("isSuggestedPunctuation" in l for l in c), c)

c = code(body("LatinIME.smali", "private mrTouchingRight(" + IC + ")Z"))
echo_i = c.index("invoke-static {p1}, Lcom/mrkeyboard/app/MrSurround;->echo(" + IC + ")I")
after_q = next(i for i, l in enumerate(c) if "getTextAfterCursor" in l)
check("mrTouchingRight: MrSurround.echo is asked first; the old question to the app comes after it and only runs when it answers NONE (-2)",
      echo_i < after_q and c[echo_i + 1] == "move-result v1" and c[echo_i + 2] == "const/4 v2, -0x2"
      and c[echo_i + 3].startswith("if-ne v1, v2, :cond_") and sum("MrSurround" in l for l in c) == 1, c[echo_i:echo_i + 4])
c = code(body("LatinIME.smali", "private mrSepEcho(II)V"))
check("mrSepEcho: MrSurround.clear is the first thing (before anything is read)", c[0] == "invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->clear()V", c[:2])
c = code(body("LatinIME.smali", "private mrSepClear()V"))
check("mrSepClear: drops the kept text too (every key that clears the note)", "invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->clear()V" in c, c)

src = open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read()
users = sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mMrSepAt:I" in m.split("\n.end method")[0])
check("the note is touched only by mrSepSent, mrSepClear and mrSepEcho, and read only by mrSepEcho",
      users == ["mrSepClear()V", "mrSepEcho(II)V", "mrSepSent(I)V"]
      and [l for l in code(body("LatinIME.smali", "private mrSepEcho(II)V")) if l.startswith("iget v")][0].endswith("->mMrSepAt:I")
      and not any(l.startswith("iget ") and "mMrSepAt" in l for n in ("mrSepSent(I)V", "mrSepClear()V")
                  for l in code(body("LatinIME.smali", "private " + n))), users)

c = code(body("LatinIME$1.smali", "public handleMessage(Landroid/os/Message;)V"))
check("the handler of messages: msgBegin first, msgEnd right before the only return",
      c[0] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->msgBegin()V" and c[-2:] == [
          "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->msgEnd()V", "return-void"], (c[:1], c[-2:]))


# ---- stage 6 part 7: the shape of the delayed reaction
CANCEL = "invoke-direct {p0}, " + IME + "->mrEchoCancel()V"
c = code(body("LatinIME.smali", "private handleSeparator(I)V"))
check("handleSeparator ends the wait before anything else (a separator is a key)", c[0] == CANCEL, c[:2])
c = code(body("LatinIME.smali", "private mrSepClear()V"))
check("mrSepClear (handleBackspace, handleCharacter, onText) ends the wait too", CANCEL in c and c.count(CANCEL) == 1, c)
for head in ("public onDestroy()V", "public onFinishInput()V", "public onWindowHidden()V", "public onFinishInputView(Z)V",
             "public onStartInputView(Landroid/view/inputmethod/EditorInfo;Z)V"):
    c = code(body("LatinIME.smali", head))
    r = [i for i, l in enumerate(c) if l == "invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->reset()V"]
    check("%s: the wait ends right where the word kept is forgotten" % head.split("(")[0].split()[-1],
          len(r) == 1 and c.count(CANCEL) == 1 and c[r[0] + 1] == CANCEL, [c[i + 1] for i in r])

c = code(body("LatinIME.smali", "private mrEchoPost()Z"))
check("mrEchoPost: waits only with the switch on, nothing being corrected and a handler; the message is 5, replaces the one that waits, "
      "after 0x64 ms (the delay of the suggestions)",
      c[0] == "iget-boolean v0, p0, " + IME + "->mMrEchoDefer:Z" and c[1].startswith("if-eqz v0, :cond_")
      and "invoke-static {}, Lcom/mrkeyboard/app/TextEntryState;->isCorrecting()Z" in c
      and c.count("invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V") == 1
      and "const/4 v1, 0x5" in c and "const-wide/16 v3, 0x64" in c
      and c.count("invoke-virtual {v0, v2, v3, v4}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z") == 1, c)
check("... and tells the meter only when it waits (the two returns: 1 after echoPosted, 0 for everything that runs at once)",
      c.index("invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->echoPosted()V") > c.index("sendMessageDelayed(Landroid/os/Message;J)Z".join(["invoke-virtual {v0, v2, v3, v4}, Landroid/os/Handler;->", ""]))
      and c.count("return v0") == 2, c)
c = code(body("LatinIME.smali", "public mrEchoRun()V"))
check("mrEchoRun: the meter first; a word being typed, a reverted separator and a prediction that is off leave nothing to do; "
      "then mrEchoReact; the kept text is dropped on every way out",
      c[0] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->echoRan()V"
      and any("mPredicting" in l for l in c) and any("mJustRevertedSeparator" in l for l in c) and any("isPredictionOn" in l for l in c)
      and c.count("invoke-direct {p0}, " + IME + "->mrEchoReact()V") == 1
      and c[-2:] == ["invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->clear()V", "return-void"], c)
c = code(body("LatinIME.smali", "private mrEchoCancel()V"))
check("mrEchoCancel: removes message 5 only when there is a handler, tells the meter and clears the echo mark; it asks the app nothing",
      c[0] == "iget-object v0, p0, " + IME + "->mHandler:Landroid/os/Handler;" and c.count("invoke-virtual {v0, v1}, Landroid/os/Handler;->removeMessages(I)V") == 1
      and "const/4 v1, 0x5" in c and "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->echoDropped()V" in c
      and "iput-boolean v0, p0, " + IME + "->mMrSepHit:Z" in c and not any("getTextBeforeCursor" in l or "getTextAfterCursor" in l for l in c), c)

src = open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read()
msgs = [m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:]
        if "Landroid/os/Handler;->obtainMessage(I)" in m.split("\n.end method")[0] and "const/4 v1, 0x5" in m.split("\n.end method")[0]]
check("message 5 is sent only by mrEchoPost and removed only by it and by mrEchoCancel; nothing else touches mMrEchoDefer but loadSettings (write) and mrEchoPost (read)",
      msgs == ["mrEchoPost()Z"]
      and sorted(m.split("\n", 1)[0].split()[-1] for m in src.split("\n.method ")[1:] if "->mMrEchoDefer:Z" in m.split("\n.end method")[0])
      == ["loadSettings()V", "mrEchoPost()Z"], msgs)
ls = code(body("LatinIME.smali", "private loadSettings()V"))
i = ls.index('const-string v1, "pref_mr_echo_defer"')
check("loadSettings reads pref_mr_echo_defer, on by default (the default is the 1 kept in v3 for the line above it)",
      ls[i + 1] == "invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z"
      and ls[i + 2] == "move-result v1" and ls[i + 3] == "iput-boolean v1, p0, " + IME + "->mMrEchoDefer:Z"
      and any(l.startswith("const/4 v3, 0x1") for l in ls[:i]), ls[i:i + 4])
c = code(body("LatinIME$1.smali", "public handleMessage(Landroid/os/Message;)V"))
i = c.index("const/4 v0, 0x5")
j = c.index("invoke-virtual {p1}, " + IME + "->mrEchoRun()V")
check("the handler of messages: message 5 goes to mrEchoRun of the keyboard (the other messages are as they were)",
      c[i + 1] == "if-eq p1, v0, :cond_mr_echo" and c[j - 1].startswith("iget-object p1, p0, ") and c[j + 1] == "goto :goto_0"
      and sum("mrEchoRun" in l for l in c) == 1, c[i:i + 2])

# the switch on the Advanced screen, and its texts in the three languages
adv = open(os.path.join(ROOT, "res", "xml", "prefs_advanced.xml"), encoding="utf-8").read()
k = adv.index('android:key="pref_mr_echo_defer"')
tag = adv[adv.rindex("<", 0, k):adv.index("/>", k)]
check("the Advanced screen has the switch: a checkbox, saved, on by default, with its three texts",
      tag.startswith("<CheckBoxPreference") and 'android:defaultValue="true"' in tag and 'android:persistent="true"' in tag
      and "@string/mr_ui_echo_defer\"" in tag and "@string/mr_ui_echo_defer_on\"" in tag and "@string/mr_ui_echo_defer_off\"" in tag
      and adv.count("pref_mr_echo_defer") == 1, tag)
for loc in ("values", "values-pt-rBR", "values-es"):
    sx = open(os.path.join(ROOT, "res", loc, "mr_strings.xml"), encoding="utf-8").read()
    names = ("mr_ui_echo_defer", "mr_ui_echo_defer_on", "mr_ui_echo_defer_off", "mr_ui_perf_echo_run", "mr_ui_perf_echo_drop")
    check("the texts of the switch and of the two meter lines are in %s" % loc,
          all(sx.count('<string name="%s">' % n) == 1 and sx.split('<string name="%s">' % n)[1].split("</string>")[0].strip() for n in names),
          [n for n in names if sx.count('<string name="%s">' % n) != 1])

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
