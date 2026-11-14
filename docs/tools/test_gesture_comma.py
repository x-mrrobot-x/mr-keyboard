#!/usr/bin/env python3
"""Tests what happens to a punctuation key typed right after a word written by gesture typing.

Run it from the project root:  python3 -I docs/tools/test_gesture_comma.py

It runs the REAL smali of LatinIME (pickSuggestionManually, handleSeparator, swapPunctuationAndSpace, isSentenceSeparator, abortCorrection)
and of TextEntryState in the mini Dalvik interpreter (dalvik_mini.py), over a fake text field that keeps the text. The word is written the
way MrGestureInput.write does it: a space when the text needs one, then LatinIME.pickSuggestionManually(-1, word) (the same call as a tap
on a suggestion). The rest of LatinIME (dictionaries, shift state, strip) is a stub that records what it was asked.

Since the usual swap did not happen on the device (it depends on the state of TextEntryState and on what the editor says about the text it has just
received), MrGestureInput.onKey calls LatinIME.mrGlue for it; the last tests run that real method.

The rule: after a word written by gesture (and its automatic space), a comma or another sentence separator is written glued to the word and
followed by the space: "olá ," becomes "olá, " (swapPunctuationAndSpace), as after a suggestion tapped on the strip.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
TES = "Lcom/mrkeyboard/app/TextEntryState;"
ENUM = "Lcom/mrkeyboard/app/TextEntryState$State;"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def enum_names():
    src = open(os.path.join(APP, "TextEntryState$State.smali"), encoding="utf-8").read()
    return re.findall(r"\.field public static final enum (\w+)", src)


def switch_map(file):
    """{State name: index} of a javac switch map class (TextEntryState$1 or LatinIME$5), read from its smali."""
    src = open(os.path.join(APP, file), encoding="utf-8").read()
    out = {}
    for m in re.finditer(r"->(\w+):Lcom/mrkeyboard/app/TextEntryState\$State;\s+invoke-virtual \{v1\}[^\n]*\n\s+move-result v1\s+(?:const/\d+ v2, (0x[0-9a-f]+))", src):
        out[m.group(1)] = int(m.group(2), 16)
    return out


NAMES = enum_names()
MAP_TES = switch_map("TextEntryState$1.smali")
MAP_IME = switch_map("LatinIME$5.smali")


class Builder:
    def __init__(self):
        self.parts = []


class World:
    def __init__(self, recorrection=0):
        self.text = ""
        self.log = []
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;")
        self.enum = {n: dm.Obj(ENUM, name=n) for n in NAMES}
        self.tes = dm.VM(TES, dm.parse_methods(os.path.join(APP, "TextEntryState.smali")), TesHost(self))
        self.tes.statics["sState"] = self.enum["UNKNOWN"]
        self.tes.run("reset()V", [])
        self.stubs = {
            "postUpdateSuggestions": None, "pickDefaultSuggestion": 0, "commitTyped": None, "doubleSpace": None,
            "isPredictionOn": 0, "removeTrailingSpace": None, "reswapPeriodAndSpace": None, "updateShiftKeyState": None,
            "addToBigramDictionary": None, "addToDictionaries": None, "setNextSuggestions": None, "clearSuggestions": None,
            "postUpdateOldSuggestions": None, "postUpdateShiftKeyState": None, "isSuggestedPunctuation": 0,
            "isWordSeparator": lambda a: 1 if chr(a[1]) in " .,!?);:-'\"(/@_\n" else 0, "mrAfterWord": 0,
            "processMultiKey": 0, "changeSheet": None, "isShiftMod": 0,
        }
        self.ime_methods = dm.parse_methods(os.path.join(APP, "LatinIME.smali"))
        self.vm = ImeVM(self.ime_methods, self)
        self.this = dm.Obj(
            IME, mCandidateView=dm.Obj("Lcom/mrkeyboard/app/CandidateView;"), mCompletionOn=0, mCompletions=None, mAutoSpace=1,
            mCorrectionMode=0, mComposing="", mJustAccepted=0, mSuggest=dm.Obj("s"), mPredicting=0, mAutoCorrectOn=0,
            mJustRevertedSeparator=None, mAutoCorrectEnabled=0, mJustAddedAutoSpace=0, mSentenceSeparators=".,!?);:",
            mReCorrectionEnabled=recorrection, mLastSelectionStart=0, mLastSelectionEnd=0, mExpectingUpdateSelection=0,
            mLastKeyTime=0, mDeleteCount=0, mKeyboardSwitcher=dm.Obj("Lcom/mrkeyboard/app/KeyboardSwitcher;"), mComposeMode=0,
            mDeadKeysActive=0, mEnteredText=None, mModAlt=0, mModCtrl=0, mModMeta=0, mModFn=0, mMrSepAt=0, mMrSepHit=0,
            mHandler=None, mMrEchoDefer=0,
        )

    # ---- the field
    def commit(self, s):
        self.text += str(s)

    def state(self):
        return self.tes.statics["sState"].f["name"]

    def gesture_word(self, word, space):
        """What MrGestureInput.write does."""
        self.commit(" ") if space else None
        self.vm.run("pickSuggestionManually(ILjava/lang/CharSequence;)V", [self.this, -1, word])

    def key(self, code):
        """A separator key as LatinIME.onKeyOrig handles it: any key but Enter clears mJustAddedAutoSpace, then handleSeparator."""
        if code != 10:
            self.this.f["mJustAddedAutoSpace"] = 0
        self.vm.run("handleSeparator(I)V", [self.this, code])

    def selection_changed(self):
        n = len(self.text)
        self.vm.run("onUpdateSelection(IIIIII)V", [self.this, n - 5, n - 5, n, n, -1, -1])

    # ---- host of the LatinIME VM
    def sget(self, cls, name):
        if cls == ENUM:
            return self.enum[name]
        if cls == "Lcom/mrkeyboard/app/LatinIME$5;" and name.startswith("$SwitchMap"):
            return switch_array(MAP_IME, self.enum)
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sRedirect":
            return None
        raise AssertionError("static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        if cls == "Ljava/lang/StringBuilder;":
            return dm.Obj(cls, parts=[])
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        short = cls.split("/")[-1].rstrip(";") + "." + mem.split("(")[0]
        if cls == TES:
            return self.tes.run(mem, args)
        if cls == ENUM and mem.startswith("ordinal"):
            return NAMES.index(args[0].f["name"])
        if short.startswith("InputMethodService."):
            return None
        if short == "InputConnection.beginBatchEdit" or short == "InputConnection.endBatchEdit" or short == "InputConnection.finishComposingText":
            return 1
        if short == "InputConnection.commitText":
            self.commit(args[1])
            return 1
        if short == "InputConnection.deleteSurroundingText":
            self.text = self.text[:len(self.text) - args[1]]
            return 1
        if short == "InputConnection.getTextBeforeCursor":
            return self.text[-args[1]:] if args[1] > 0 else ""
        if short == "InputConnection.getTextAfterCursor":
            return ""
        if short in ("CharSequence.length", "String.length"):
            return len(args[0])
        if short == "CharSequence.charAt":
            return ord(args[0][args[1]])
        if short == "String.valueOf":
            return chr(args[0])
        if short == "String.concat":
            return str(args[0]) + str(args[1])
        if short == "String.contains":
            return 1 if str(args[1]) in args[0] else 0
        if short == "StringBuilder.<init>":
            return None
        if short == "StringBuilder.append":
            args[0].f["parts"].append(chr(args[1]) if isinstance(args[1], int) else str(args[1]))
            return args[0]
        if short == "StringBuilder.toString":
            return args[0] if isinstance(args[0], str) else "".join(args[0].f["parts"]) if isinstance(args[0], dm.Obj) else str(args[0])
        if short in ("MrPacks.onPick", "MrGestureInput.onPick"):
            return 0
        if short == "CandidateView.getSuggestions":
            return []
        if short == "CandidateView.dismissAddToDictionaryHint":
            return 0
        if short == "LatinIME.getCurrentInputConnection" or mem.startswith("getCurrentInputConnection"):
            return self.ic
        if mem.startswith("getCurrentInputEditorInfo"):
            return dm.Obj("Landroid/view/inputmethod/EditorInfo;")
        if short == "Handler.removeMessages":
            return None
        if short == "SystemClock.uptimeMillis":
            self.clock = getattr(self, "clock", 1000) + 700
            return self.clock
        if short == "LatinIMEUtil$RingCharBuffer.getInstance":
            return dm.Obj("ring")
        if short == "KeyboardSwitcher.hasDistinctMultitouch":
            return 0
        self.log.append(short)
        return None


class TesHost:
    def __init__(self, world):
        self.w = world

    def sget(self, cls, name):
        if cls == ENUM:
            return self.w.enum[name]
        if cls == "Lcom/mrkeyboard/app/TextEntryState$1;":
            return switch_array(MAP_TES, self.w.enum)
        raise AssertionError("TES static: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if cls == ENUM and mem.startswith("ordinal"):
            return NAMES.index(args[0].f["name"])
        if mem.startswith("equals") or cls.endswith("Object;"):
            return 1 if args[0] == args[1] else 0
        return None


def switch_array(mapping, enum):
    arr = [0] * len(NAMES)
    for name, idx in mapping.items():
        arr[NAMES.index(name)] = idx
    return arr


class ImeVM(dm.VM):
    def __init__(self, methods, world):
        super().__init__(IME, methods, world)
        self.w = world

    def run(self, key, args):
        name = key.split("(")[0]
        w = self.w
        if name == "pickSuggestion":
            w.commit(args[1])                       # LatinIME.pickSuggestion: writes the word
            return None
        if name in ("sendSpace",):
            w.commit(" ")
            return None
        if name == "sendModifiableKeyChar":
            w.commit(chr(args[1]))
            return None
        if name == "getCurrentInputConnection":
            return w.ic
        if name in w.stubs:
            v = w.stubs[name]
            return v(args) if callable(v) else v
        return super().run(key, args)


# ---------------------------------------------------------------- a word tapped on the strip (the reference)
w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
check("the word is written with its automatic space", w.text == "bom dia ", repr(w.text))
check("the state after the word: a space after a picked suggestion", w.state() == "SPACE_AFTER_PICKED", w.state())
w.key(ord(","))
check("a comma right after: glued to the word, followed by the space", w.text == "bom dia, ", repr(w.text))

# ---------------------------------------------------------------- the other separators
for ch in ".!?;:)":
    w = World()
    w.text = "bom"
    w.gesture_word("dia", space=True)
    w.key(ord(ch))
    check("%r right after a gesture word: glued, then the space" % ch, w.text == "bom dia%s " % ch, repr(w.text))

# ---------------------------------------------------------------- with the field telling the keyboard the cursor moved (onUpdateSelection)
w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
w.selection_changed()
w.key(ord(","))
check("the editor reports the new cursor before the comma: still glued", w.text == "bom dia, ", (w.text, w.state()))

# ---------------------------------------------------------------- the first word of the text (no leading space)
w = World()
w.gesture_word("olá", space=False)
w.key(ord(","))
check("first word of the text: glued", w.text == "olá, ", repr(w.text))

# ---------------------------------------------------------------- the editor reports the cursor twice (some apps do)
w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
w.selection_changed()
w.selection_changed()
w.key(ord(","))
check("two cursor reports before the comma: still glued", w.text == "bom dia, ", (w.text, w.state()))

# ---------------------------------------------------------------- two gesture words, a comma between them
w = World()
w.text = "oi"
w.gesture_word("tudo", space=True)
w.key(ord(","))
w.gesture_word("bem", space=False)
w.key(ord("?"))
check("gesture, comma, gesture, question mark", w.text == "oi tudo, bem? ", repr(w.text))

# ---------------------------------------------------------------- the space was already there (text ends with a space): no leading space
w = World()
w.text = "oi "
w.gesture_word("tudo", space=False)
w.key(ord(","))
check("text that already ended with a space", w.text == "oi tudo, ", repr(w.text))

# ---------------------------------------------------------------- without a word picked before (a fresh state) nothing is swapped
w = World()
w.text = "oi tudo "
w.tes.run("reset()V", [])
w.key(ord(","))
check("no gesture word before: the comma is just typed after the space", w.text == "oi tudo ,", repr(w.text))

# ---------------------------------------------------------------- LatinIME.mrGlue: what MrGestureInput.onKey calls (it does not depend on the state)
def glue(w, ch):
    return w.vm.run("mrGlue(I)Z", [w.this, ord(ch)])


w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
r = glue(w, ",")
check("mrGlue: the sign takes the place of the automatic space, then the space", r == 1 and w.text == "bom dia, ", (r, w.text))
check("mrGlue: the state is the one of a sign after a word", w.state() == "PUNCTUATION_AFTER_ACCEPTED", w.state())
check("mrGlue: the space is the automatic one (Enter takes it away)", w.this.f["mJustAddedAutoSpace"] == 1)

for ch in ".!?;:)":
    w = World()
    w.text = "bom"
    w.gesture_word("dia", space=True)
    check("mrGlue %r: glued, then the space" % ch, glue(w, ch) == 1 and w.text == "bom dia%s " % ch, w.text)

# the state of TextEntryState (and the reports of the editor) do not matter: this is what the swap of handleSeparator depends on
w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
w.tes.run("reset()V", [])
check("mrGlue: with the state reset it still glues", glue(w, ",") == 1 and w.text == "bom dia, ", (w.text, w.state()))

w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
w.selection_changed()
w.selection_changed()
check("mrGlue: after two reports of the cursor it still glues", glue(w, ",") == 1 and w.text == "bom dia, ", (w.text, w.state()))

# a modifier on: nothing is written, the sign goes the usual way
for mod in ("mModCtrl", "mModAlt", "mModMeta"):
    w = World()
    w.text = "bom"
    w.gesture_word("dia", space=True)
    w.this.f[mod] = 1
    check("mrGlue with %s on: nothing is written" % mod, glue(w, ",") == 0 and w.text == "bom dia ", (w.text,))

w = World()
w.text = "bom"
w.gesture_word("dia", space=True)
w.stubs["isShiftMod"] = 1
check("mrGlue with Shift held or locked: nothing is written", glue(w, ",") == 0 and w.text == "bom dia ", (w.text,))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
