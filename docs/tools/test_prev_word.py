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
check("the only other ask of EditingUtil.getPreviousWord is checkAddToDictionary (once per word that is learned, with the sentence "
      "separators), not the suggestions", users == {"LatinIME.smali": 1} and sum("EditingUtil;->getPreviousWord(" in l for l in c) == 1, users)
check("MrPrevWord has no other user than the suggestions", sorted(f for f in os.listdir(APP) if f.endswith(".smali") and f.startswith("LatinIME")
      and "MrPrevWord;->get(" in read(os.path.join(APP, f))) == ["LatinIME.smali"])

# 3. the other places where the word being typed changes
for head, what in (("private handleBackspace()V", "a backspace"), ("private handleSeparator(I)V", "a separator"),
                   ("public onText(Ljava/lang/CharSequence;)V", "a text written by the keyboard"),
                   ("public onStartInputView(", "a new field"), ("public onFinishInput()V", "the end of the input")):
    c = code_of(ime, head)
    check("%s forgets the word kept (MrPrevWord.clear)" % what, CLEAR in c, c[:3])
for head in ("public onStartInputView(", "public onFinishInput()V"):
    c = code_of(ime, head)
    check("%s forgets that the app does not answer getSurroundingText (MrSurround.fieldChanged)" % head.split("(")[0].split()[-1], FIELD in c)
c = code_of(ime, "public onFinishInput()V")
check("onFinishInput: the hooks come after the call to the super class (the framework's own work runs first)",
      next(i for i, l in enumerate(c) if l.startswith("invoke-super")) < c.index(CLEAR) < c.index(FIELD), c[:6])
c = code_of(ime, "private handleBackspace()V")
check("handleBackspace: the word is forgotten before anything is asked or deleted",
      c.index(CLEAR) < next(i for i, l in enumerate(c) if "getCurrentInputConnection" in l), c[:6])
c = code_of(ime, "private handleSeparator(I)V")
check("handleSeparator: the word is forgotten before the separator is sent", c.index(CLEAR) < next(i for i, l in enumerate(c) if "sendModifiableKeyChar" in l), c[:6])
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
