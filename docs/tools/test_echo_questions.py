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
          "mrEchoTouchingWord()Z", "mrTouchingRight(" + IC + ")Z", "handleSeparator(I)V")
ALL = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
METHODS = {k: v for k, v in ALL.items() if k in WANTED}
assert len(METHODS) == len(WANTED), sorted(set(WANTED) - set(METHODS))

SEPARATORS = " \n.,;:!?()-\""
PUNCT = "'"       # a "suggested punctuation" the fake app treats like the real list does: not part of a word, not a separator


class Host:
    """The fake keyboard around the methods under test and the fake app (a text and a cursor) behind the InputConnection."""

    def __init__(self, text="", cursor=None, predicting=False):
        self.text = text
        self.cursor = len(text) if cursor is None else cursor
        self.questions = []         # "before" / "after", in order
        self.pairs = [0, 0]         # appBegin, appEnd
        self.sel = [0, 0]           # selBegin, selEnd
        self.calls = []
        self.ic = dm.Obj(IC)
        self.state_obj = dm.Obj("Lcom/mrkeyboard/app/TextEntryState$State;")
        self.vm = dm.VM(IME, METHODS, self)
        self.ime = dm.Obj(IME, mComposing=dm.Obj("Ljava/lang/StringBuilder;"), mPredicting=1 if predicting else 0, mJustAccepted=0,
                          mJustAddedAutoSpace=0, mLastSelectionStart=self.cursor, mLastSelectionEnd=self.cursor,
                          mReCorrectionEnabled=1, mKeyboardSwitcher=dm.Obj("Switcher"), mJustRevertedSeparator=None,
                          mCandidateView=dm.Obj("Candidate"), mMrSepAt=0, mMrSepHit=0, mAutoCorrectOn=0)
        self.redirect = None

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
        if cls == "Lcom/mrkeyboard/app/MrPerf;":
            idx = {"appBegin": (self.pairs, 0), "appEnd": (self.pairs, 1), "selBegin": (self.sel, 0), "selEnd": (self.sel, 1)}
            if name in idx:
                idx[name][0][idx[name][1]] += 1
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
                return 1
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

    def reset_count(self):
        self.questions, self.calls = [], []
        self.pairs, self.sel = [0, 0], [0, 0]

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

# 2. the same echo without the note (the keyboard did not type the separator): the full check, two questions as before
h = Host("hello ")
h.ime.f["mLastSelectionStart"] = h.ime.f["mLastSelectionEnd"] = 5
h.reset_count()
h.echo()
check("the same echo with no note (another way of getting there): the full check, two questions, same answer",
      h.questions == ["before", "after"] and h.after_echo() == "next", (h.questions, h.after_echo()))

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
check("... the report of the selection is checked against the note right after the super call",
      c[2] == "invoke-direct {p0, p3, p4}, " + IME + "->mrSepEcho(II)V", c[:4])
ends = [i for i, l in enumerate(c) if l == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->selEnd()V"]
rets = [i for i, l in enumerate(c) if l == "return-void"]
check("... selEnd before each of the two exits", len(rets) == 2 and ends == [i - 1 for i in rets], (ends, rets))
check("... the re-correction check goes through mrEchoTouchingWord and nothing else calls isCursorTouchingWord here",
      c.count("invoke-direct {p0}, " + IME + "->mrEchoTouchingWord()Z") == 1
      and not any("isCursorTouchingWord" in l for l in c))

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

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
