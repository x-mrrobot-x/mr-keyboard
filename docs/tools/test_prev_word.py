#!/usr/bin/env python3
"""Tests of how LatinIME uses MrPrevWord and MrSurround (stage 6, part 5 of docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_prev_word.py

The two classes themselves (the answers, the questions counted on a fake app, random texts) are tested in Java:
docs/tools/prevword_test/PrevWordTest.java. What is tested here is the part that only the smali can get wrong: that the keyboard
forgets what MrPrevWord kept at EVERY place where the word being typed starts, ends or is reopened, and that the suggestions
use MrPrevWord and nothing else asks for the previous word.

MrPrevWord keeps, for the word being typed, the text that was before it. It is used only for the same word grown by letters, so the
places where the word changes have to drop it:
  - every write of mPredicting in LatinIME (the word starts or ends);
  - WordComposer.reset (a word composer that starts again);
  - a backspace, a separator, a text written by the keyboard (onText), a new field and the end of the input.
Stage 7 adds two things the smali has to get right:
  - the separator HOLDS what was known about the word for that one key (MrPrevWord.hold, first thing in handleSeparator) so that the learning of
    the pair (checkAddToDictionary) can work out the word before it with no question, and RELEASES it before the key returns;
  - the end of the input, the hidden window, the hidden input view and the destroyed service RESET everything (the word and what was held),
    so no text typed in one field is left in memory for another;
  - doubleSpace (the three characters before the cursor) is not asked when this key committed a word that ends with a character that is not
    white space: the character before the space about to be sent cannot be a space.
The text MrSurround keeps for the next-word prediction lives only inside the reaction to one report of the selection (see
test_echo_questions.py for its hooks in onUpdateSelection, mrSepEcho and mrSepClear); here: new field, end of input.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
JAVA = os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app")
CLEAR = "invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->clear()V"
RESET = "invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->reset()V"
RELEASE = "invoke-static {}, Lcom/mrkeyboard/app/MrPrevWord;->release()V"
HOLD = "invoke-static {v0}, Lcom/mrkeyboard/app/MrPrevWord;->hold(Ljava/lang/CharSequence;)V"
ENDS_PLAIN = "Lcom/mrkeyboard/app/MrPrevWord;->endsPlain(Ljava/lang/CharSequence;)Z"
FIELD = "invoke-static {}, Lcom/mrkeyboard/app/MrSurround;->fieldChanged()V"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(path):
    return open(path, encoding="utf-8").read()


def code_of(src, head):
    """The instructions of the method whose .method line contains `head` (labels, directives, comments and annotations left out)."""
    lines = src.split("\n")
    s = next(i for i, l in enumerate(lines) if l.startswith(".method ") and head in l)
    e = next(i for i in range(s, len(lines)) if lines[i].startswith(".end method"))
    out, in_ann = [], False
    for l in lines[s:e]:
        t = l.strip()
        if t.startswith(".annotation"):
            in_ann = True
        elif t.startswith(".end annotation"):
            in_ann = False
        elif t and not in_ann and not t.startswith(("#", ".", ":")):
            out.append(t)
    return out


ime = read(os.path.join(APP, "LatinIME.smali"))

# 1. every write of mPredicting is followed by the clear
all_code = [l.strip() for l in ime.split("\n") if l.strip() and not l.strip().startswith(("#", ".", ":"))]
puts = [i for i, l in enumerate(all_code) if re.match(r"iput-boolean \S+, p0, Lcom/mrkeyboard/app/LatinIME;->mPredicting:Z$", l)]
check("LatinIME writes mPredicting in 7 places or more (the count the hooks were made for)", len(puts) >= 7, len(puts))
bad = [all_code[i] for i in puts if all_code[i + 1] != CLEAR]
check("every write of mPredicting is followed, in the very next instruction, by MrPrevWord.clear", not bad, bad[:2])
others = [l for l in all_code if "mPredicting:Z" in l and l.startswith(("iput", "sput")) and "p0" not in l]
check("... and the field is not written through another object", not others, others[:2])

# 2. the suggestions use MrPrevWord and nothing else asks for the previous word
c = code_of(ime, "private showSuggestions(Lcom/mrkeyboard/app/WordComposer;)V")
gets = [i for i, l in enumerate(c) if "MrPrevWord;->get(" in l]
check("showSuggestions asks MrPrevWord.get(ic, separators, mComposing)",
      len(gets) == 1 and c[gets[0]].startswith("invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrPrevWord;->get("
                                                "Landroid/view/inputmethod/InputConnection;Ljava/lang/String;Ljava/lang/CharSequence;)"
                                                "Ljava/lang/CharSequence;")
      and c[gets[0] - 1].startswith("iget-object v2, p0, Lcom/mrkeyboard/app/LatinIME;->mComposing:Ljava/lang/StringBuilder;")
      and c[gets[0] - 2].startswith("iget-object v1, p0, Lcom/mrkeyboard/app/LatinIME;->mWordSeparators:Ljava/lang/String;"), c[:8])
users = {}
for f in sorted(os.listdir(APP)):
    if f.endswith(".smali") and f != "EditingUtil.smali":
        n = len(re.findall(r"invoke-static [^\n]*EditingUtil;->getPreviousWord\(", read(os.path.join(APP, f))))
        if n:
            users[f] = n
c = code_of(ime, "private checkAddToDictionary(Ljava/lang/CharSequence;IZ)V")
check("nobody asks EditingUtil.getPreviousWord any more: the suggestions and the learning of the pairs go through MrPrevWord", users == {}, users)
calls = [i for i, l in enumerate(c) if "MrPrevWord;->previousForLearning(" in l]
check("checkAddToDictionary gets the word before the committed one from MrPrevWord.previousForLearning(ic, sentence separators, mCommittedLength)",
      len(calls) == 1 and c[calls[0]].startswith("invoke-static {p2, p3, v0}, Lcom/mrkeyboard/app/MrPrevWord;->previousForLearning("
                                                 "Landroid/view/inputmethod/InputConnection;Ljava/lang/String;I)Ljava/lang/CharSequence;")
      and c[calls[0] - 1] == "iget v0, p0, Lcom/mrkeyboard/app/LatinIME;->mCommittedLength:I"
      and c[calls[0] - 2].startswith("iget-object p3, p0, Lcom/mrkeyboard/app/LatinIME;->mSentenceSeparators:Ljava/lang/String;"), c[calls[0] - 3:calls[0] + 1] if calls else c)
check("... and that call is after the guards of the learning (incognito, prediction off, a suggestion with a space)",
      calls and next(i for i, l in enumerate(c) if "MrText;->learnable(" in l) < calls[0] and next(i for i, l in enumerate(c) if "mMrNoLearn" in l) < calls[0])
check("MrPrevWord has no other user than the suggestions", sorted(f for f in os.listdir(APP) if f.endswith(".smali") and f.startswith("LatinIME")
      and "MrPrevWord;->get(" in read(os.path.join(APP, f))) == ["LatinIME.smali"])

# 3. the other places where the word being typed changes
for head, what in (("private handleBackspace()V", "a backspace"),
                   ("public onText(Ljava/lang/CharSequence;)V", "a text written by the keyboard")):
    c = code_of(ime, head)
    check("%s forgets the word kept (MrPrevWord.clear)" % what, CLEAR in c, c[:3])
c = code_of(ime, "private handleSeparator(I)V")
check("a separator holds what is known about the word and forgets it (MrPrevWord.hold(mComposing), right after the cancel of the delayed echo)",
      c[0] == "invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIME;->mrEchoCancel()V"
      and c[1] == "iget-object v0, p0, Lcom/mrkeyboard/app/LatinIME;->mComposing:Ljava/lang/StringBuilder;" and c[2] == HOLD and CLEAR not in c, c[:4])
check("... and releases it as the last thing before the key returns (every path ends there: one return)",
      c.count("return-void") == 1 and c[-1] == "return-void" and c[-2] == RELEASE and c.count(RELEASE) == 1, c[-3:])
for head, what in (("public onStartInputView(", "a new field"), ("public onFinishInput()V", "the end of the input"),
                   ("public onFinishInputView(Z)V", "the input view going away (the keyboard closed)"),
                   ("public onWindowHidden()V", "the window hidden (leaving the app, the keyboard closed, another keyboard)"),
                   ("public onDestroy()V", "the service destroyed")):
    c = code_of(ime, head)
    check("%s forgets everything, the word kept and what was held (MrPrevWord.reset)" % what, c.count(RESET) == 1 and CLEAR not in c, c[:3])
for head in ("public onStartInputView(", "public onFinishInput()V"):
    c = code_of(ime, head)
    check("%s forgets that the app does not answer getSurroundingText (MrSurround.fieldChanged)" % head.split("(")[0].split()[-1], FIELD in c)
c = code_of(ime, "public onFinishInput()V")
check("onFinishInput: the hooks come after the call to the super class (the framework's own work runs first)",
      next(i for i, l in enumerate(c) if l.startswith("invoke-super")) < c.index(RESET) < c.index(FIELD), c[:6])
c = code_of(ime, "private handleBackspace()V")
check("handleBackspace: the word is forgotten before anything is asked or deleted",
      c.index(CLEAR) < next(i for i, l in enumerate(c) if "getCurrentInputConnection" in l), c[:6])
c = code_of(ime, "private handleSeparator(I)V")
check("handleSeparator: the word is held and forgotten before the separator is sent", c.index(HOLD) < next(i for i, l in enumerate(c) if "sendModifiableKeyChar" in l), c[:6])
check("handleSeparator: what was held is taken before the word is committed (commitTyped, pickDefaultSuggestion) so the learning can use it",
      c.index(HOLD) < next(i for i, l in enumerate(c) if "commitTyped(" in l) and c.index(HOLD) < next(i for i, l in enumerate(c) if "pickDefaultSuggestion()Z" in l))

# 3b. doubleSpace: not asked after a word committed by this key
dbl = [i for i, l in enumerate(c) if l.endswith("LatinIME;->doubleSpace()V")]
check("handleSeparator calls doubleSpace in one place", len(dbl) == 1, dbl)
pre = c[:dbl[0]] if dbl else []
ends = [i for i, l in enumerate(pre) if ENDS_PLAIN in l]
check("doubleSpace question cut: handleSeparator asks MrPrevWord.endsPlain of the word typed (mComposing) when a word is being predicted, and of "
      "the word picked (mBestWord) when one is picked", len(ends) == 2
      and pre[ends[0] - 1] == "iget-object v5, p0, Lcom/mrkeyboard/app/LatinIME;->mComposing:Ljava/lang/StringBuilder;"
      and pre[ends[1] - 1] == "iget-object v1, p0, Lcom/mrkeyboard/app/LatinIME;->mBestWord:Ljava/lang/CharSequence;", ends)
# the flag is false unless a word is being predicted: set before the branch on mPredicting, taken from endsPlain after it
i_pred = next(i for i, l in enumerate(c) if l.endswith("LatinIME;->mPredicting:Z") and l.startswith("iget-boolean v2"))
i_zero = next(i for i, l in enumerate(c) if l == "const/4 v8, 0x0")
check("... v8 (the word committed ends plain) starts false before the branch on mPredicting, so every path to doubleSpace has it set",
      i_pred < i_zero < next(i for i, l in enumerate(c) if l == "if-eqz v2, :cond_5") < ends[0], (i_pred, i_zero))
writers = [l for l in c if re.match(r"(const\S*|move\S*|iget\S*|invoke-\S+ \{v8\})\s+v8\b", l) or re.match(r"move-result\S* v8$", l)]
check("... v8 is the answer of the first endsPlain and nothing else writes it", c[ends[0] + 1] == "move-result v8" and writers == ["const/4 v8, 0x0", "move-result v8"], writers)
tail = c[dbl[0] - 12:dbl[0]] if dbl else []
check("... the call is skipped when v8 is true and (the typed word was committed as it is, or the picked word ends plain); otherwise doubleSpace asks as before",
      tail[:1] == ["if-eqz v8, :cond_mr_ask_double"] or "if-eqz v8, :cond_mr_ask_double" in tail, tail)
c = code_of(ime, "public onText(Ljava/lang/CharSequence;)V")
check("onText: the word is forgotten before the text is inserted", c.index(CLEAR) < next(i for i, l in enumerate(c) if "onTextOrig" in l), c)

# 4. WordComposer.reset: run for real
wc = dm.parse_methods(os.path.join(APP, "WordComposer.smali"))
KEY = "reset()V"
c = code_of(read(os.path.join(APP, "WordComposer.smali")), "public reset()V")
check("WordComposer.reset: the first instruction forgets the word kept", c[0] == CLEAR, c[:2])


class Host:
    def __init__(self):
        self.calls = []

    def sget(self, cls, name):
        return None

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return False

    def invoke(self, vm, op, target, args):
        self.calls.append(target.split("->")[0].split("/")[-1].rstrip(";") + "." + target.split("->")[1].split("(")[0])
        return None


h = Host()
vm = dm.VM("Lcom/mrkeyboard/app/WordComposer;", {KEY: wc[KEY]}, h)
obj = dm.Obj("Lcom/mrkeyboard/app/WordComposer;", mCodes=dm.Obj("Ljava/util/ArrayList;"), mIsFirstCharCapitalized=1, mPreferredWord="x",
             mTypedWord=dm.Obj("Ljava/lang/StringBuilder;"), mCapsCount=3)
vm.run(KEY, [obj])
check("... run for real: reset() calls MrPrevWord.clear once and still empties the word",
      h.calls.count("MrPrevWord.clear") == 1 and obj.f["mCapsCount"] == 0 and obj.f["mIsFirstCharCapitalized"] == 0 and not obj.f["mPreferredWord"], (h.calls, obj.f))

# 4b. the real smali of handleSeparator and checkAddToDictionary, run in the mini Dalvik with a fake keyboard around them
IME = "Lcom/mrkeyboard/app/LatinIME;"
ALLM = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
SEP = "handleSeparator(I)V"
CHK = "checkAddToDictionary(Ljava/lang/CharSequence;IZ)V"


class KHost:
    """Everything around the method under test: the calls are written down, the answers are the ones of a keyboard that learns words."""

    def __init__(self, picked=0):
        self.calls, self.args = [], {}
        self.picked = picked
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")
        self.state = dm.Obj("Lcom/mrkeyboard/app/TextEntryState$State;")

    def sget(self, cls, name):
        return dm.Obj(cls + "." + name)

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return False

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        who = cls.split("/")[-1].rstrip(";") + "." + name
        self.calls.append(who)
        self.args.setdefault(who, []).append(args)
        if name == "getCurrentInputConnection":
            return self.ic
        if name in ("dismissAddToDictionaryHint", "suggestionsSuspended"):
            return 0
        if name == "pickDefaultSuggestion":
            return self.picked
        if name in ("isPredictionOn", "learnable"):
            return 1
        if name == "getState":
            return self.state
        if name == "endsPlain":                       # the real one is tested in Java (PrevWordTest)
            return 1 if args[0] and not args[0][-1].isspace() else 0
        if name == "isValidWord":
            return 1
        if name == "previousForLearning":
            return "dois"
        if name == "isEmpty":
            return 1 if not args[0] else 0
        if name == "toString":
            return args[0]
        if name == "length":
            return len(args[0])
        return None


def run_separator(code, composing, predicting, picked=0, best="", autocorrect=0):
    h = KHost(picked)
    vm = dm.VM(IME, {SEP: ALLM[SEP]}, h)
    ime = dm.Obj(IME, mComposing=composing, mPredicting=1 if predicting else 0, mAutoCorrectOn=autocorrect, mAutoCorrectEnabled=1,
                 mJustRevertedSeparator=None, mJustAddedAutoSpace=0, mBestWord=best, mWord=dm.Obj("Lcom/mrkeyboard/app/WordComposer;"),
                 mCandidateView=dm.Obj("Candidate"))
    vm.run(SEP, [ime, ord(code)])
    return h


def asks_double_space(h):
    return h.calls.count("LatinIME.doubleSpace") == 1


h = run_separator(" ", "casa", True)
check("run: a space that commits the word typed (autocorrect off): doubleSpace is NOT called, so the app is not asked the three characters",
      not asks_double_space(h) and h.calls.count("LatinIME.commitTyped") == 1, h.calls)
check("run: ... and the key holds the word with the composing text, releases it, and sends the space",
      h.args["MrPrevWord.hold"] == [["casa"]] and h.calls.count("MrPrevWord.release") == 1 and h.calls.count("LatinIME.sendModifiableKeyChar") == 1
      and h.calls.index("MrPrevWord.hold") < h.calls.index("LatinIME.commitTyped") < h.calls.index("LatinIME.sendModifiableKeyChar") < h.calls.index("MrPrevWord.release"), h.calls)
h = run_separator(" ", "casa", True, picked=1, best="casa", autocorrect=1)
check("run: a space that picks the default suggestion (it ends with a letter): doubleSpace is NOT called",
      not asks_double_space(h) and h.calls.count("LatinIME.pickDefaultSuggestion") == 1, h.calls)
h = run_separator(" ", "casa", True, picked=1, best="a casa ", autocorrect=1)
check("run: a picked suggestion that ends with a space: doubleSpace asks as before (a second space could be there)", asks_double_space(h), h.calls)
h = run_separator(" ", "", False)
check("run: a space with no word being typed (the second space of two): doubleSpace asks as before", asks_double_space(h), h.calls)
h = run_separator(" ", "", True)
check("run: a word being predicted but empty (nothing to commit): doubleSpace asks as before", asks_double_space(h), h.calls)
h = run_separator(" ", "casa ", True)
check("run: a typed word that somehow ends with a space: doubleSpace asks as before", asks_double_space(h), h.calls)
h = run_separator(",", "casa", True)
check("run: a comma never called doubleSpace (as before)", not asks_double_space(h), h.calls)
for code in " ,.!":
    for pred in (True, False):
        h = run_separator(code, "casa" if pred else "", pred)
        check("run: separator %r, predicting=%s: hold once, release once, release is the last call of the key" % (code, pred),
              h.calls.count("MrPrevWord.hold") == 1 and h.calls.count("MrPrevWord.release") == 1 and h.calls[-1] == "MrPrevWord.release", h.calls[-3:])

# checkAddToDictionary: the word before, from MrPrevWord, and the pair learned with it
h = KHost()
vm = dm.VM(IME, {CHK: ALLM[CHK]}, h)
ime = dm.Obj(IME, mMrNoLearn=0, mSuggest=dm.Obj("Suggest"), mAutoDictionary=dm.Obj("Auto"), mUserBigramDictionary=dm.Obj("Bigram"),
             mSentenceSeparators=".!?", mCommittedLength=4)
vm.run(CHK, [ime, "tres", 1, 0])
check("run: checkAddToDictionary asks MrPrevWord.previousForLearning(ic, '.!?', 4) once and no EditingUtil",
      h.args.get("MrPrevWord.previousForLearning") == [[h.ic, ".!?", 4]] and "EditingUtil.getPreviousWord" not in h.calls, h.args.get("MrPrevWord.previousForLearning"))
check("run: ... and learns the pair with the answer: ('dois', 'tres')",
      [a[1:] for a in h.args.get("UserBigramDictionary.addBigrams", [])] == [["dois", "tres"]], h.args.get("UserBigramDictionary.addBigrams"))
h = KHost()
vm = dm.VM(IME, {CHK: ALLM[CHK]}, h)
ime = dm.Obj(IME, mMrNoLearn=1, mSuggest=dm.Obj("Suggest"), mAutoDictionary=dm.Obj("Auto"), mUserBigramDictionary=dm.Obj("Bigram"),
             mSentenceSeparators=".!?", mCommittedLength=4)
vm.run(CHK, [ime, "tres", 1, 0])
check("run: in incognito mode nothing is learned and nothing is asked", "MrPrevWord.previousForLearning" not in h.calls and "UserBigramDictionary.addBigrams" not in h.calls, h.calls)

# 5. the Java side the smali relies on
pred = read(os.path.join(JAVA, "MrPredict.java"))
check("MrPredict.list uses the text kept by MrSurround before asking the app (and asks only when there is none)",
      "MrSurround.takeBefore()" in pred and pred.index("MrSurround.takeBefore()") < pred.index("ic.getTextBeforeCursor(LOOKBACK, 0)")
      and "if (before == null)" in pred[pred.index("MrSurround.takeBefore()"):pred.index("ic.getTextBeforeCursor(LOOKBACK, 0)")], "")
pw = read(os.path.join(JAVA, "MrPrevWord.java"))
sv = read(os.path.join(JAVA, "MrSurround.java"))
check("MrPrevWord: the window is the 15 characters of EditingUtil.getPreviousWord and the answer rule is its own (split on spaces, second to last)",
      "WINDOW = 15" in pw and 'Pattern.compile("\\\\s+")' in pw and "words[n - 2]" in pw)
check("MrSurround: Android 12 or later only, and the SurroundingText class lives in a nested class (Android 8 to 11 never load it)",
      "Build.VERSION.SDK_INT < 31" in sv and "static final class Api31" in sv and sv.count("SurroundingText st") == 1
      and sv.index("Api31.echo(ic)") < sv.index("class Api31"))
check("MrSurround asks getSurroundingText for the same 96 characters MrPredict.list reads, and one character after the cursor",
      "getSurroundingText(MrPredict.LOOKBACK, 1, 0)" in sv)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
