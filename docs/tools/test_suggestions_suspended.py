#!/usr/bin/env python3
"""Tests that the suggestions flow stops while a tool uses the toolbar row or a font style is on, and the space after a suggestion
(LatinIME.suggestionsSuspended, updateSuggestions, setNextSuggestions, setOldSuggestions, postUpdateOldSuggestions, mrEndWord, mrAfterWord,
pickSuggestionManually).

Run it from the project root:  python3 -I docs/tools/test_suggestions_suspended.py

It runs the REAL smali of those methods of LatinIME in the mini Dalvik interpreter (dalvik_mini.py). The rest of LatinIME and the Android classes are
fakes that record what was called, so what is checked is which calls each method makes in each state:
  - with a tool on the toolbar row (MrTools.rowOwned) or a font style on (MrFonts.styleOn): no dictionary search, no next-word search, no re-correction
    of the word under the cursor (not even the 300 ms wait), and the strip is emptied; without either, everything runs as before;
  - mrEndWord (called before a styled letter is written) commits the word typed so far, lets go of a reopened word and empties the strip;
  - setSuggestions tells MrSugg whether there are suggestions and whether the list is of a word being typed, corrected or swiped (mrStrip) or of the
    next word (the strip comes back on typing; the debounce of the end of the word starts on the next-word list);
  - a suggestion picked for a word the re-correction reopened is judged by what follows the word once it is written (wherever it was tapped): at the
    end of the text, or at the end of the line before a lone space, the pick adds the space and shows the next words (the space that is there is taken over,
    the cursor ends after it); with more text after the word (a word corrected in the middle) there is no space, as before.
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
            if name == "pickSuggestion":
                self.host.picked = True
            return self.stubs[name]
        return super().run(key, args)


class Host:
    def __init__(self):
        self.log = []
        self.row = 0            # MrTools.rowOwned
        self.style = 0          # MrFonts.styleOn
        self.correcting = 0     # TextEntryState.isCorrecting
        self.after = ""         # the text after the cursor once the pick is written (None: the editor does not say)
        self.before_pick = None  # the text after the cursor before the pick, when it is another one (tap in the middle of the word)
        self.picked = False
        self.onlist = []        # MrSugg.onList(has, typing) calls
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
        if short == "MrSugg.onList":
            self.onlist.append(tuple(args))
            return None
        if short == "List.isEmpty":
            return 1 if len(args[0]) == 0 else 0
        if short == "InputConnection.getTextAfterCursor":
            if not self.picked and self.before_pick is not None:
                return self.before_pick
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
    vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 1, "setSuggestions": None}, mCompletionOn=0, mSuggest=dm.Obj("s"))
    host.row, host.style = row, style
    vm.run("setNextSuggestions()V", [this])
    check("%s: setNextSuggestions looks for no next word and shows nothing" % name,
          host.log == ["clearSuggestions"], host.log)
vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 0, "setSuggestions": None}, mCompletionOn=0, mSuggest=dm.Obj("s"))
vm.run("setNextSuggestions()V", [this])
check("nothing suspended, prediction off: the strip is emptied (there is no punctuation list any more)", "clearSuggestions" in host.log and "setSuggestions" not in host.log, host.log)

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

# ---------------------------------------------------------------- pickSuggestionManually: the space
PICK = dict(mCandidateView=dm.Obj("cv"), mCompletionOn=0, mCompletions=None, mAutoSpace=1, mCorrectionMode=0, mComposing="ola",
            mJustAccepted=0, mSuggest=dm.Obj("s"))
STUBS = {"isWordSeparator": 0, "isSuggestedPunctuation": 0, "pickSuggestion": None, "addToDictionaries": None,
         "addToBigramDictionary": None, "sendSpace": None, "setNextSuggestions": None, "clearSuggestions": None,
         "postUpdateOldSuggestions": None, "onKey": None}


def pick(correcting, after, before=None, auto=1, index=1):
    """after: the text after the cursor once the word is written; before: the text after the cursor before the pick (a tap in the middle of the word)."""
    vm, host, this = make(dict(STUBS), **dict(PICK, mAutoSpace=auto))
    host.correcting, host.after, host.before_pick = correcting, after, before
    old = host.invoke

    def invoke(vm_, op, target, args, old=old):
        if target.startswith("Ljava/lang/StringBuilder;->toString"):
            return args[0]
        if target.startswith("Lcom/mrkeyboard/app/TextEntryState;->acceptedSuggestion") or target.startswith("Lcom/mrkeyboard/app/TextEntryState;->typedCharacter"):
            host.log.append("TextEntryState." + target.split("->")[1].split("(")[0])
            return None
        if target.startswith("Ljava/lang/CharSequence;->charAt"):
            return ord(args[0][args[1]])
        return old(vm_, op, target, args)

    host.invoke = invoke
    vm.run("pickSuggestionManually(ILjava/lang/CharSequence;)V", [this, index, "olá"])
    return host.log


def spaced(log):
    """The space is added (after the word) and the next words are shown, and the word is not offered again."""
    return "sendSpace" in log and "setNextSuggestions" in log and "postUpdateOldSuggestions" not in log


log = pick(0, "x")
check("a word typed in the usual way: the pick adds the space and shows the next words", "sendSpace" in log and "setNextSuggestions" in log, log)
log = pick(1, "")
check("a reopened word at the end of the text: the pick adds the space and shows the next words", spaced(log), log)
log = pick(1, "", before="do")
check("a reopened word at the end of the text, tapped in the middle of the word: the same", spaced(log), log)
log = pick(1, " ")
check("a reopened word at the end of the line with a space after it (tapped at its end): the space that is there is taken over: one char after the "
      "cursor goes, the space is added, the cursor ends after it",
      spaced(log) and log.index("InputConnection.deleteSurroundingText") < log.index("sendSpace"), log)
log = pick(1, " ", before="do ")
check("...the same when the word was tapped in the middle", spaced(log) and "InputConnection.deleteSurroundingText" in log, log)
log = pick(1, " \nnext line")
check("...the same when the line goes on below", spaced(log) and "InputConnection.deleteSurroundingText" in log, log)
log = pick(1, " ", auto=0)
check("...but with the automatic space off nothing is touched: the space there stays and none is added",
      "sendSpace" not in log and "InputConnection.deleteSurroundingText" not in log and "postUpdateOldSuggestions" in log, log)
log = pick(1, " mundo")
check("a reopened word in the middle of a line (more words after it): no space, no change, the word is offered again as before",
      "sendSpace" not in log and "InputConnection.deleteSurroundingText" not in log and "postUpdateOldSuggestions" in log and "setNextSuggestions" not in log, log)
log = pick(1, "x")
check("a reopened word followed by a letter or a sign: as before", "sendSpace" not in log and "postUpdateOldSuggestions" in log, log)
log = pick(1, None)
check("a reopened word, the editor does not say what follows: as before, no space", "sendSpace" not in log and "postUpdateOldSuggestions" in log, log)
log = pick(1, "")
check("...and the dictionary learns it as a picked word", "addToBigramDictionary" in log or "addToDictionaries" in log, log)

# ---- setSuggestions tells MrSugg whether there are suggestions and whether the list belongs to a word being typed
def set_sugg(lst, predicting=0, strip=0, correcting=0, nxt=0):
    vm, host, this = make({}, mIsShowingHint=0, mCandidateView=None, mPredicting=predicting, mMrStrip=strip, mMrNext=nxt)
    host.correcting = correcting
    vm.run("setSuggestions(Ljava/util/List;ZZZ)V", [this, lst, 0, 0, 0])
    return host.onlist


check("a list of the word being typed (mPredicting): suggestions, typing", set_sugg(["ola", "olá"], predicting=1) == [(1, 1)], set_sugg(["ola"], predicting=1))
check("a re-correction (the word under the cursor reopened): suggestions, typing", set_sugg(["ola"], correcting=1) == [(1, 1)])
check("the preview of a gesture (mrStrip): suggestions, typing", set_sugg(["ola"], strip=1) == [(1, 1)])
check("the next words after a space: suggestions, not typing", set_sugg(["de", "que"]) == [(1, 0)])
check("an empty list: no suggestions", set_sugg([]) == [(0, 0)])
check("no list: no suggestions", set_sugg(None) == [(0, 0)])
check("an empty list while typing: no suggestions, typing", set_sugg([], predicting=1) == [(0, 1)])
# the TextEntryState of a re-correction outlives it (only typing resets it): a next-word list is never typing, or the initial suggestions
# (Você, Eu, Não) shown after a paste or a cursor move would keep the strip for ever, the debounce never starting
check("the next words (setNextSuggestions) while the state still says correcting: suggestions, NOT typing",
      set_sugg(["Você", "Eu", "Não"], correcting=1, nxt=1) == [(1, 0)], set_sugg(["Você"], correcting=1, nxt=1))
check("the next words, state not correcting: suggestions, not typing", set_sugg(["Você", "Eu"], nxt=1) == [(1, 0)])
check("no next words while the state says correcting: no suggestions, not typing", set_sugg([], correcting=1, nxt=1) == [(0, 0)])
check("a re-correction's own list (not next words) is still typing", set_sugg(["ola", "olá"], correcting=1, nxt=0) == [(1, 1)])

# ---- mrStrip: the list of a gesture preview is typing, and only while it is set
vm, host, this = make({}, mCandidateView=dm.Obj("cv"), mPredicting=0, mMrStrip=0)
seen = []
real = vm.run


def spy(key, args):
    if key.startswith("setSuggestions("):
        seen.append(args[0].f["mMrStrip"])
        return None
    return real(key, args)


vm.run = spy
real("mrStrip(Ljava/util/List;)V", [this, ["casa"]])
check("mrStrip with a list: setSuggestions runs with the preview flag set, and it is cleared after", seen == [1] and this.f["mMrStrip"] == 0, (seen, this.f["mMrStrip"]))

# ---- setNextSuggestions marks its lists as the next words, only while setSuggestions runs
def next_flags(predict_list):
    # predict_list: what MrPredict.list returns (None: no prediction, the strip is emptied)
    vm, host, this = make({"clearSuggestions": None, "isPredictionOn": 1}, mCompletionOn=0, mSuggest=dm.Obj("s"), mMrNext=0)
    seen = []
    real_run = vm.run

    def spy(key, args):
        if key.startswith("setSuggestions("):
            seen.append((args[1], args[0].f["mMrNext"]))
            return None
        if key.startswith("clearSuggestions("):
            seen.append("clear")
            return None
        return real_run(key, args)

    vm.run = spy
    host.predict = predict_list
    real_run("setNextSuggestions()V", [this])
    return seen, this.f["mMrNext"]


_orig_invoke = Host.invoke


def _invoke(self, vm, op, target, args):
    if target.startswith("Lcom/mrkeyboard/app/MrPredict;->list("):
        return getattr(self, "predict", None)
    return _orig_invoke(self, vm, op, target, args)


Host.invoke = _invoke
seen, after = next_flags(["Você", "Eu", "Não"])
check("setNextSuggestions with a prediction: setSuggestions runs with the next-words flag set, cleared after", seen == [(["Você", "Eu", "Não"], 1)] and after == 0, (seen, after))
seen, after = next_flags(None)
check("setNextSuggestions with no prediction: the strip is emptied (no punctuation list), and the flag stays clear", seen == ["clear"] and after == 0, (seen, after))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
