#!/usr/bin/env python3
"""Tests how the keyboard learns the selection when it opens in a field (LatinIME.checkReCorrectionOnStart, stage 5 of
docs/plan-performance.md).

Run it from the project root:  python3 -I docs/tools/test_open_selection.py

It runs the REAL smali of the method in the mini Dalvik interpreter (dalvik_mini.py) with a fake keyboard service, field and
InputConnection. Before, every open asked the app, synchronously, for the whole text of the field (getExtractedText with no size
limit) only to know where the cursor is. Now the selection comes from EditorInfo.initialSelStart/End, which the field already
gave when it opened:
  - a field that reports its selection (both values 0 or more): no question to the app for the text; the last selection of the
    keyboard is the reported one; with the cursor after the first character (any of the two values above 0) it checks whether the
    cursor touches a word (two small questions, as before) and, if so, offers the suggestions of the old word; with the cursor at
    the very start (0 and 0: most often an empty field) nothing is asked and nothing is offered;
  - a field that does not report it (-1 in either value) or no EditorInfo: the text is asked as before, with the same results
    (selection = start offset + selection, suggestions only when the text is not empty and the cursor touches a word);
  - nothing at all happens when re-correction is off, the prediction is off or there is no connection.
Part 2 reads the smali: the method no longer asks the text first, and the question that is left is measured by MrPerf.
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
IME = "Lcom/mrkeyboard/app/LatinIME;"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


# Only the method under test runs for real: every other call of the service (the prediction, the word under the cursor...) goes to
# the fake host, which counts it.
METHODS = {k: v for k, v in dm.parse_methods(os.path.join(APP, "LatinIME.smali")).items() if k == "checkReCorrectionOnStart()V"}
assert len(METHODS) == 1


class Host:
    def __init__(self, sel=(5, 5), prediction=True, recorrection=True, connection=True, info=True, text="hello world",
                 touching=True, extracted=True, start_offset=0, ext_sel=(5, 5)):
        self.calls = []
        self.prediction, self.touching = prediction, touching
        self.ic = dm.Obj("Landroid/view/inputmethod/InputConnection;") if connection else None
        self.ei = dm.Obj("Landroid/view/inputmethod/EditorInfo;", initialSelStart=sel[0], initialSelEnd=sel[1]) if info else None
        self.extracted = (dm.Obj("Landroid/view/inputmethod/ExtractedText;", startOffset=start_offset, selectionStart=ext_sel[0],
                                 selectionEnd=ext_sel[1], text=text) if extracted else None)
        self.this = dm.Obj(IME, mReCorrectionEnabled=1 if recorrection else 0, mLastSelectionStart=-7, mLastSelectionEnd=-7)
        self.vm = dm.VM(IME, METHODS, self)

    def run(self):
        self.vm.run("checkReCorrectionOnStart()V", [self.this])
        return self

    # fake framework
    def sget(self, cls, name):
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return obj is not None and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if cls == IME:
            name = mem.split("(")[0]
            if name == "isPredictionOn":
                return 1 if self.prediction else 0
            if name == "getCurrentInputConnection":
                return self.ic
            if name == "getCurrentInputEditorInfo":
                return self.ei
            if name == "isCursorTouchingWord":
                self.calls.append("touching")
                return 1 if self.touching else 0
            if name == "postUpdateOldSuggestions":
                self.calls.append("post")
                return None
        if cls == "Lcom/mrkeyboard/app/MrPerf;":
            self.calls.append(mem.split("(")[0])
            return None
        if cls == "Landroid/view/inputmethod/ExtractedTextRequest;" and mem == "<init>()V":
            return None
        if cls == "Landroid/view/inputmethod/InputConnection;" and mem.startswith("getExtractedText("):
            self.calls.append("getExtractedText")
            return self.extracted
        if cls == "Landroid/text/TextUtils;" and mem == "isEmpty(Ljava/lang/CharSequence;)Z":
            return 1 if args[0] is None or args[0] == "" else 0
        raise AssertionError("not faked: " + target)

    @property
    def sel(self):
        return (self.this.f["mLastSelectionStart"], self.this.f["mLastSelectionEnd"])


# ---------------------------------------------------------------- a field that reports its selection
h = Host(sel=(5, 5), touching=True).run()
check("reported 5/5, cursor touches a word: no question for the text", "getExtractedText" not in h.calls and "appBegin" not in h.calls,
      h.calls)
check("... the last selection is the reported one", h.sel == (5, 5), h.sel)
check("... the word under the cursor is checked once and its suggestions are offered", h.calls == ["touching", "post"], h.calls)

h = Host(sel=(5, 5), touching=False).run()
check("reported 5/5, cursor not touching a word: checked, nothing offered", h.calls == ["touching"] and h.sel == (5, 5), (h.calls, h.sel))

h = Host(sel=(3, 8), touching=True).run()
check("a selection 3..8 is kept as it is", h.sel == (3, 8) and h.calls == ["touching", "post"], (h.sel, h.calls))

h = Host(sel=(0, 7), touching=True).run()
check("selection from 0 to 7: the text is not empty, so it is checked", h.sel == (0, 7) and h.calls == ["touching", "post"], (h.sel, h.calls))

h = Host(sel=(7, 0), touching=True).run()
check("(end before start, as some fields report): checked all the same", h.sel == (7, 0) and h.calls == ["touching", "post"],
      (h.sel, h.calls))

h = Host(sel=(0, 0), touching=True).run()
check("cursor at the very start (0/0): nothing is asked and nothing is offered", h.calls == [], h.calls)
check("... the selection is still stored", h.sel == (0, 0), h.sel)

h = Host(sel=(1, 1), touching=True).run()
check("cursor after the first character: checked", h.calls == ["touching", "post"], h.calls)

# ---------------------------------------------------------------- a field that does not report it
for sel in ((-1, -1), (-1, 4), (4, -1)):
    h = Host(sel=sel, start_offset=0, ext_sel=(6, 9), touching=True).run()
    check("not reported %s: the text is asked once, around the question the meter counts" % (sel,),
          h.calls == ["appBegin", "getExtractedText", "appEnd", "touching", "post"], h.calls)
    check("... selection = start offset + selection of the text", h.sel == (6, 9), h.sel)

h = Host(sel=(-1, -1), start_offset=100, ext_sel=(6, 9), touching=True).run()
check("a text that starts at offset 100: offsets added", h.sel == (106, 109), h.sel)

h = Host(sel=(-1, -1), text="", ext_sel=(0, 0), touching=True).run()
check("not reported, empty text: no check, no suggestions", h.calls == ["appBegin", "getExtractedText", "appEnd"] and h.sel == (0, 0),
      (h.calls, h.sel))

h = Host(sel=(-1, -1), touching=False).run()
check("not reported, text not touching a word: checked, nothing offered",
      h.calls == ["appBegin", "getExtractedText", "appEnd", "touching"], h.calls)

h = Host(sel=(-1, -1), extracted=False).run()
check("not reported and the app gives no text: nothing changes", h.calls == ["appBegin", "getExtractedText", "appEnd"] and h.sel == (-7, -7),
      (h.calls, h.sel))

h = Host(info=False, ext_sel=(2, 2), touching=True).run()
check("no EditorInfo: the text is asked as before", h.calls == ["appBegin", "getExtractedText", "appEnd", "touching", "post"]
      and h.sel == (2, 2), (h.calls, h.sel))

# ---------------------------------------------------------------- nothing to do
h = Host(recorrection=False).run()
check("re-correction off: nothing at all", h.calls == [] and h.sel == (-7, -7), (h.calls, h.sel))
h = Host(prediction=False).run()
check("prediction off: nothing at all", h.calls == [] and h.sel == (-7, -7), (h.calls, h.sel))
h = Host(connection=False).run()
check("no connection: nothing at all", h.calls == [] and h.sel == (-7, -7), (h.calls, h.sel))

# ---------------------------------------------------------------- the smali
lines = [l.strip() for l in open(os.path.join(APP, "LatinIME.smali"), encoding="utf-8").read().split("\n")]
s = next(i for i, l in enumerate(lines) if l.startswith(".method private checkReCorrectionOnStart()V"))
e = next(i for i in range(s, len(lines)) if lines[i].startswith(".end method"))
body = [l for l in lines[s:e] if l and not l.startswith((".", ":", "#"))]
ask = [i for i, l in enumerate(body) if "getExtractedText(" in l]
sel = [i for i, l in enumerate(body) if l.endswith("EditorInfo;->initialSelStart:I")]
check("the method reads initialSelStart before it asks anything to the app", len(ask) == 1 and len(sel) == 1 and sel[0] < ask[0],
      (sel, ask))
check("the only question left is measured by the meter",
      body[ask[0] - 1] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appBegin()V"
      and body[ask[0] + 2] == "invoke-static {}, Lcom/mrkeyboard/app/MrPerf;->appEnd()V")
check("the fallback is reached only for a selection below 0 or no EditorInfo",
      sum(1 for l in body if l.startswith("if-ltz")) == 2 and any(l.startswith("if-eqz v1, :cond_text") for l in body))

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
