#!/usr/bin/env python3
"""Tests that the suggestions flow stops while a tool uses the toolbar row or a font style is on, and the space after a suggestion
(LatinIME.suggestionsSuspended, updateSuggestions, setNextSuggestions, setOldSuggestions, postUpdateOldSuggestions, mrEndWord, mrAtTextEnd,
pickSuggestionManually).

Run it from the project root:  python3 -I docs/tools/test_suggestions_suspended.py

It runs the REAL smali of those methods of LatinIME in the mini Dalvik interpreter (dalvik_mini.py). The rest of LatinIME and the Android classes are
fakes that record what was called, so what is checked is which calls each method makes in each state:
  - with a tool on the toolbar row (MrTools.rowOwned) or a font style on (MrFonts.styleOn): no dictionary search, no next-word search, no re-correction
    of the word under the cursor (not even the 300 ms wait), and the strip is emptied; without either, everything runs as before;
  - mrEndWord (called before a styled letter is written) commits the word typed so far, lets go of a reopened word and empties the strip;
  - a suggestion picked for a word the re-correction reopened adds the space when there is no text after the cursor (the person is typing at the
    end), and does not when there is text after it (a word corrected in the middle), as before.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


IME = "Lcom/mrkeyboard/app/LatinIME;"


class Fake:
    """Methods of LatinIME that are replaced: they record the call and answer what the test says."""

    def __init__(self):
        self.calls = []
        self.answers = {}

    def key(self, k):
        return k.split("(")[0]


class VM(dm.VM):
    def __init__(self, methods, host, stubs):
        super().__init__(IME, methods, host)
        self.stubs = stubs
        self.host = host
        self.log = host.log

    def run(self, key, args):
        name = key.split("(")[0]
        if name == "getCurrentInputConnection":     # LatinIME's own (it honours the redirect of the tools): the field of the test
            return self.host.ic
        if name in self.stubs:
            self.log.append(name)
            return self.stubs[name]
        return super().run(key, args)


class Host:
    def __init__(self):
        self.log = []
        self.row = 0            # MrTools.rowOwned
        self.style = 0          # MrFonts.styleOn
        self.correcting = 0     # TextEntryState.isCorrecting
        self.after = ""         # the text after the cursor (None: the editor does not say)
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")

    def sget(self, cls, name):
        raise AssertionError("static of another class: %s.%s" % (cls, name))

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
        if short == "TextEntryState.isCorrecting":
            return self.correcting
        if short == "InputConnection.getTextAfterCursor":
            return self.after
        if short == "CharSequence.length":
            return len(args[0])
        if short == "InputMethodService.getCurrentInputEditorInfo" or mem.startswith("getCurrentInputEditorInfo"):
            return dm.Obj("Landroid/view/inputmethod/EditorInfo;")
        if mem.startswith("getCurrentInputConnection"):
            return self.ic
        if short in ("MrPacks.onPick", "MrGestureInput.onPick"):
            return 0
        if short == "KeyboardSwitcher.getInputView":
            return dm.Obj("view")
        if short == "LatinKeyboardView.getKeyboard":
            return dm.Obj("kbd")
        if short == "CandidateView.getSuggestions":
            return []
        if short == "Handler.removeMessages" or short == "Handler.sendMessageDelayed" or short == "Handler.obtainMessage":
            self.log.append(short)
            return dm.Obj("msg") if short == "Handler.obtainMessage" else 1
        # everything else is just recorded (setPreferredLetters, begin/endBatchEdit, finishComposingText, typedCharacter...)
        self.log.append(short)
        return 1 if short.endswith(("Edit", "ComposingText")) else None


def load():
    return dm.parse_methods(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "LatinIME.smali"))


METHODS = load()


def make(stubs, **fields):
    host = Host()
    vm = VM(METHODS, host, stubs)
    this = dm.Obj(IME, **fields)
    return vm, host, this


def calls(host):
    return host.log


# ---------------------------------------------------------------- suggestionsSuspended
for row, style, want in ((0, 0, 0), (1, 0, 1), (0, 1, 1), (1, 1, 1)):
    vm, host, this = make({})
    host.row, host.style = row, style
    got = vm.run("suggestionsSuspended()Z", [this])
    check("suspended: tool on the row=%d, font style=%d -> %d" % (row, style, want), got == want, got)

# ---------------------------------------------------------------- updateSuggestions
KEYS = dict(mKeyboardSwitcher=dm.Obj("ks"), mSuggest=dm.Obj("suggest"), mPredicting=1, mWord=dm.Obj("word"))
for row, style, name in ((1, 0, "a tool on the row"), (0, 1, "a font style on")):
    vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 1, "showSuggestions": None, "setNextSuggestions": None}, **KEYS)
    host.row, host.style = row, style
    vm.run("updateSuggestions()V", [this])
    check("%s: updateSuggestions empties the strip and searches nothing" % name,
          "clearSuggestions" in host.log and "showSuggestions" not in host.log and "setNextSuggestions" not in host.log, host.log)
for predicting, want in ((1, "showSuggestions"), (0, "setNextSuggestions")):
    vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 1, "showSuggestions": None, "setNextSuggestions": None}, **dict(KEYS, mPredicting=predicting))
    vm.run("updateSuggestions()V", [this])
    check("nothing suspended, predicting=%d: updateSuggestions runs %s as before" % (predicting, want),
          want in host.log and "clearSuggestions" not in host.log, host.log)

# ---------------------------------------------------------------- setNextSuggestions
for row, style, name in ((1, 0, "a tool on the row"), (0, 1, "a font style on")):
    vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 1, "setSuggestions": None}, mCompletionOn=0, mSuggest=dm.Obj("s"), mSuggestPuncList=[])
    host.row, host.style = row, style
    vm.run("setNextSuggestions()V", [this])
    check("%s: setNextSuggestions looks for no next word and shows no punctuation" % name,
          host.log == ["clearSuggestions"], host.log)
vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 0, "setSuggestions": None}, mCompletionOn=0, mSuggest=dm.Obj("s"), mSuggestPuncList=[])
vm.run("setNextSuggestions()V", [this])
check("nothing suspended: setNextSuggestions still shows the punctuation list", "setSuggestions" in host.log and "clearSuggestions" not in host.log, host.log)

# ---------------------------------------------------------------- setOldSuggestions (re-correction)
for row, style, name in ((1, 0, "a tool on the row"), (0, 1, "a font style on")):
    vm, host, this = make({"abortCorrection": None}, mCandidateView=None)
    host.row, host.style = row, style
    vm.run("setOldSuggestions()V", [this])
    check("%s: no word under the cursor is reopened (nothing is marked as composing)" % name, host.log == [], host.log)

# ---------------------------------------------------------------- postUpdateOldSuggestions
for row, style, name in ((1, 0, "a tool on the row"), (0, 1, "a font style on")):
    vm, host, this = make({}, mHandler=dm.Obj("handler"))
    host.row, host.style = row, style
    vm.run("postUpdateOldSuggestions()V", [this])
    check("%s: the 300 ms wait of the re-correction is not started, a pending one is cancelled" % name,
          "Handler.sendMessageDelayed" not in host.log and "Handler.removeMessages" in host.log, host.log)
vm, host, this = make({}, mHandler=dm.Obj("handler"))
vm.run("postUpdateOldSuggestions()V", [this])
check("nothing suspended: the re-correction wait is started as before", "Handler.sendMessageDelayed" in host.log, host.log)

# ---------------------------------------------------------------- mrEndWord
vm, host, this = make({"commitTyped": None, "abortCorrection": None, "clearSuggestions": None})
vm.run("mrEndWord()V", [this])
check("mrEndWord: commits the typed word, lets go of a reopened one, ends the composing text, empties the strip",
      host.log == ["commitTyped", "abortCorrection", "InputConnection.finishComposingText", "clearSuggestions"], host.log)
vm, host, this = make({"commitTyped": None})
host.ic = None
vm.run("mrEndWord()V", [this])
check("mrEndWord with no input connection does nothing", host.log == [], host.log)

# ---------------------------------------------------------------- mrAtTextEnd
for after, want in (("", 1), ("x", 0), (" ", 0), (None, 0)):
    vm, host, this = make({})
    host.after = after
    got = vm.run("mrAtTextEnd(Landroid/view/inputmethod/InputConnection;)Z", [this, host.ic])
    check("text after the cursor %r: at the end of the text = %d" % (after, want), got == want, got)

# ---------------------------------------------------------------- pickSuggestionManually: the space
PICK = dict(mCandidateView=dm.Obj("cv"), mCompletionOn=0, mCompletions=None, mAutoSpace=1, mCorrectionMode=0, mComposing="ola",
            mJustAccepted=0, mSuggest=dm.Obj("s"))
STUBS = {"isWordSeparator": 0, "isSuggestedPunctuation": 0, "pickSuggestion": None, "addToDictionaries": None,
         "addToBigramDictionary": None, "sendSpace": None, "setNextSuggestions": None, "clearSuggestions": None,
         "postUpdateOldSuggestions": None, "onKey": None}


def pick(correcting, after, index=1):
    vm, host, this = make(dict(STUBS), **PICK)
    host.correcting, host.after = correcting, after
    # mComposing is a StringBuilder in the app: the fake answers toString for it
    old = host.invoke

    def invoke(vm_, op, target, args, old=old):
        if target.startswith("Ljava/lang/StringBuilder;->toString"):
            return args[0]
        if target.startswith("Lcom/mrkeyboard/app/TextEntryState;->acceptedSuggestion") or target.startswith("Lcom/mrkeyboard/app/TextEntryState;->typedCharacter"):
            host.log.append("TextEntryState." + target.split("->")[1].split("(")[0])
            return None
        return old(vm_, op, target, args)

    host.invoke = invoke
    vm.run("pickSuggestionManually(ILjava/lang/CharSequence;)V", [this, index, "olá"])
    return host.log


log = pick(0, "x")
check("a word typed in the usual way: the pick adds the space and shows the next words", "sendSpace" in log and "setNextSuggestions" in log, log)
log = pick(1, "")
check("a reopened word, nothing after the cursor (typing at the end): the pick adds the space and shows the next words",
      "sendSpace" in log and "setNextSuggestions" in log and "postUpdateOldSuggestions" not in log, log)
log = pick(1, "x")
check("a reopened word, text after the cursor (corrected in the middle): no space, the word is offered again as before",
      "sendSpace" not in log and "postUpdateOldSuggestions" in log and "setNextSuggestions" not in log, log)
log = pick(1, None)
check("a reopened word, the editor does not say what follows: as before, no space", "sendSpace" not in log and "postUpdateOldSuggestions" in log, log)
log = pick(1, "")
check("...and the dictionary learns it as a picked word", "addToBigramDictionary" in log or "addToDictionaries" in log, log)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
