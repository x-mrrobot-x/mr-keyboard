#!/usr/bin/env python3
"""Tests the places where Ctrl + delete by words (MrWordDelete, 2.0.0, docs/word-delete.md) is wired into the keyboard, on the REAL smali:

  - LatinIME.handleBackspace (its hook, and what the keyboard does with the answer) and LatinKeyboardBaseView$UIHandler.cancelKeyRepeatTimer
    and .handleMessage (the repeat) run in the mini Dalvik interpreter (dalvik_mini.py) with a fake MrWordDelete;
  - PointerTracker.onDownEvent (too big to run here): the order of the calls in the branch of the keys that repeat;
  - the three methods added to LatinIME (mrCtrlOn, mrHoldsWord, mrDropComposing) run in the interpreter;
  - nobody else calls MrWordDelete, and what is called exists in the generated smali with the signature used;
  - the settings screen (next to the long-press time), the limits and default against the Java constants, the texts in the three
    languages, the keys in MrReset.

The rule of what a word is, the setting, Ctrl at the touch, the interval and the word being typed are in WordDelTest.java (docs/tools/run_java_tests.sh).

Run it from the project root:  python3 -I docs/tools/test_word_delete.py
"""
import glob
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
WD = "Lcom/mrkeyboard/app/MrWordDelete;"
IME = "Lcom/mrkeyboard/app/LatinIME;"
UI = "Lcom/mrkeyboard/app/LatinKeyboardBaseView$UIHandler;"

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


def method_body(path, header):
    """The lines of the method whose '.method' line contains `header`."""
    lines = read(path).split("\n")
    out, on = [], False
    for l in lines:
        if not on and l.startswith(".method ") and header in l:
            on = True
        if on:
            out.append(l.strip())
            if l.startswith(".end method"):
                return out
    return None


def code_lines(body):
    return [l for l in body if l and not l.startswith("#") and not l.startswith(".")]


def index_of(lines, needle, start=0):
    for i in range(start, len(lines)):
        if needle in lines[i]:
            return i
    return -1


# ---------------------------------------------------------------------------------------------- who calls MrWordDelete
calls = {}
for f in sorted(glob.glob(os.path.join(APP, "*.smali"))):
    name = os.path.basename(f)
    if name.startswith("MrWordDelete"):
        continue
    for m in re.finditer(re.escape(WD) + r"->(\w+\([^)]*\)\S+)", read(f)):
        calls.setdefault(name, set()).add(m.group(1))

expected = {
    "PointerTracker.smali": {"down(Lcom/mrkeyboard/app/Keyboard$Key;)V"},
    "LatinKeyboardBaseView$UIHandler.smali": {"up()V", "interval(I)I"},
    "LatinIME.smali": {"onBackspace(Lcom/mrkeyboard/app/LatinIME;)Z"},
}
check("calls: only the four places call MrWordDelete, with these methods", calls == expected, calls)

wd_src = read(os.path.join(APP, "MrWordDelete.smali"))
for sig in sorted({s for v in expected.values() for s in v}):
    name = sig.split("(")[0]
    check("generated smali: public static %s exists with the signature used" % name,
          re.search(r"^\.method public static " + re.escape(sig) + r"$", wd_src, re.M) is not None)

# ---------------------------------------------------------------------------------------------- PointerTracker.onDownEvent
pt = method_body(os.path.join(APP, "PointerTracker.smali"), "onDownEvent(IIJ)V")
check("PointerTracker.onDownEvent found", pt is not None)
ptc = code_lines(pt)
i_rep = index_of(ptc, "->repeatKey(I)V")
i_down = index_of(ptc, WD + "->down(")
i_get = index_of(ptc, "->getKey(I)Lcom/mrkeyboard/app/Keyboard$Key;")
i_timer = index_of(ptc, "->startKeyRepeatTimer(")
i_flag = index_of(ptc, "->repeatable:Z")
check("down: once, in the branch of the keys that repeat: after the test of `repeatable`, getKey, down, the first repeat, the timer",
      0 <= i_flag < i_get < i_down < i_rep < i_timer and sum(1 for l in ptc if WD + "->down(" in l) == 1,
      (i_flag, i_get, i_down, i_rep, i_timer))
check("down: the key given is the one getKey returned (move-result-object then down with the same register)",
      ptc[i_get + 1].startswith("move-result-object") and
      ptc[i_get + 1].split()[-1] == re.search(r"\{(\w+)\}", ptc[i_down]).group(1))

# ---------------------------------------------------------------------------------------------- the interpreter
PTK = "Lcom/mrkeyboard/app/PointerTracker;"


class Host:
    def __init__(self):
        self.log = []
        self.take = False        # what MrWordDelete.onBackspace answers
        self.factor = 1          # what MrWordDelete.interval does to the interval (the setting's, 4 = 200 ms)
        self.timer = []
        self.correcting = False  # what TextEntryState.isCorrecting answers

    def sget(self, cls, name):
        raise AssertionError("static %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        self.log.append(("WD." if cls == WD else "") + name)
        if cls == WD and name == "onBackspace":
            return 1 if self.take else 0
        if cls == WD and name == "interval":
            return args[0] * self.factor
        if cls == "Lcom/mrkeyboard/app/LatinKeyboardBaseView;" and name == "access$100":
            return 50
        if name == "startKeyRepeatTimer":
            self.timer.append((args[1], args[2]))
            return None
        if name == "getCurrentInputConnection":
            return None          # no text field: the usual delete returns at once
        if name == "length":
            return len(args[0])  # StringBuilder.length of a field that holds a str
        if name == "isCorrecting":
            return 1 if self.correcting else 0
        return None


def vm_for(path, cls, drop):
    methods = dm.parse_methods(path)
    for k in drop:
        methods.pop(k, None)     # these go to the host, to be seen, instead of running
    host = Host()
    return dm.VM(cls, methods, host), host


# 1. LatinIME.handleBackspace
vm, host = vm_for(os.path.join(APP, "LatinIME.smali"), IME, ["mrSepClear()V", "postUpdateShiftKeyState()V",
                                                                      "getCurrentInputConnection()Landroid/view/inputmethod/InputConnection;"])
this = dm.Obj(IME, mJustRevertedSeparator="separator")

host.take = True
vm.run("handleBackspace()V", [this])
check("handleBackspace: word deleted there: the shift state and the text entry state are updated, nothing else is read from the field",
      host.log == ["onBackspace", "mrSepClear", "clear", "WD.onBackspace", "postUpdateShiftKeyState", "backspace"], host.log)
check("handleBackspace: word deleted there: mJustRevertedSeparator is cleared, no composing, no key event",
      this.f.get("mJustRevertedSeparator", "?") in (None, 0) and "getCurrentInputConnection" not in host.log)

host.log.clear()
host.take = False
this = dm.Obj(IME, mJustRevertedSeparator="separator")
vm.run("handleBackspace()V", [this])
check("handleBackspace: not taken: the usual delete goes on (it asks for the field)", "getCurrentInputConnection" in host.log
      and "postUpdateShiftKeyState" not in host.log and "backspace" not in host.log, host.log)
check("handleBackspace: the hook runs after the housekeeping of the delete (the separator echo, the previous word) and before the field is read",
      host.log.index("WD.onBackspace") > host.log.index("clear") > host.log.index("mrSepClear") and host.log.index("WD.onBackspace") < host.log.index("getCurrentInputConnection"), host.log)

# 2. UIHandler.cancelKeyRepeatTimer
vm, host = vm_for(os.path.join(APP, "LatinKeyboardBaseView$UIHandler.smali"), UI, ["startKeyRepeatTimer(JILcom/mrkeyboard/app/PointerTracker;)V"])
this = dm.Obj(UI, mInKeyRepeat=True)
vm.run("cancelKeyRepeatTimer()V", [this])
check("cancelKeyRepeatTimer: the repeat messages go and MrWordDelete.up is called (the hold is forgotten)",
      host.log == ["removeMessages", "WD.up"] and not this.f["mInKeyRepeat"], host.log)

# 3. UIHandler.handleMessage: the repeat (what = 3)
view = dm.Obj("Lcom/mrkeyboard/app/LatinKeyboardBaseView;")
tracker = dm.Obj(PTK)


def repeat(factor):
    host.log.clear()
    host.timer.clear()
    host.factor = factor
    handler = dm.Obj(UI, **{"this$0": view})
    msg = dm.Obj("Landroid/os/Message;", what=3, arg1=7, obj=tracker)
    vm.run("handleMessage(Landroid/os/Message;)V", [handler, msg])


repeat(1)
check("handleMessage (repeat): the key is repeated, then the interval is asked, then the next repeat is armed with it",
      [x for x in host.log if x in ("repeatKey", "WD.interval", "startKeyRepeatTimer")] == ["repeatKey", "WD.interval", "startKeyRepeatTimer"], host.log)
check("handleMessage (repeat): the usual interval (50 ms) goes to the timer, with the key and tracker of the message", host.timer == [(50, 7)], host.timer)
repeat(4)
check("handleMessage (repeat): in a hold by words the timer gets the interval MrWordDelete answers (200 ms for 50)", host.timer == [(200, 7)], host.timer)

# ---------------------------------------------------------------------------------------------- the added methods of LatinIME
LIME = os.path.join(APP, "LatinIME.smali")
hw = code_lines(method_body(LIME, "public mrHoldsWord()Z"))
check("mrHoldsWord: a word being typed (mPredicting with something in mComposing) or one reopened by the correction (TextEntryState.isCorrecting)",
      any("->mPredicting:Z" in l for l in hw) and any("->mComposing:Ljava/lang/StringBuilder;" in l for l in hw)
      and any("StringBuilder;->length()I" in l for l in hw) and any("TextEntryState;->isCorrecting()Z" in l for l in hw), hw)


def holds(predicting, composing, correcting):
    vm2, host2 = vm_for(LIME, IME, [])
    host2.correcting = correcting
    return bool(vm2.run("mrHoldsWord()Z", [dm.Obj(IME, mPredicting=predicting, mComposing=composing)]))


check("mrHoldsWord (run): a word being typed -> true",  holds(True, "abc", False) is True)
check("mrHoldsWord (run): a word reopened by the correction (nothing in mComposing) -> true", holds(False, "", True) is True)
check("mrHoldsWord (run): predicting with nothing composed, and not correcting -> false", holds(True, "", False) is False)
check("mrHoldsWord (run): nothing held -> false", holds(False, "", False) is False)
check("mrHoldsWord (run): composing text left over with mPredicting off, not correcting -> false", holds(False, "abc", False) is False)


cc = code_lines(method_body(LIME, "public mrCtrlOn()Z"))
check("mrCtrlOn: returns mModCtrl and nothing else", len(cc) == 2 and "->mModCtrl:Z" in cc[0] and cc[1].startswith("return"), cc)
vm, host = vm_for(LIME, IME, [])
check("mrCtrlOn: true when Ctrl is on, false when it is not (run)",
      vm.run("mrCtrlOn()Z", [dm.Obj(IME, mModCtrl=True)]) in (True, 1) and vm.run("mrCtrlOn()Z", [dm.Obj(IME, mModCtrl=False)]) in (False, 0, None))

dc = code_lines(method_body(LIME, "public mrDropComposing()V"))
check("mrDropComposing: empties mComposing, turns mPredicting off, forgets the previous word, finishes a reopened word (abortCorrection), asks for the suggestions and resets the text entry state",
      any("->mComposing:Ljava/lang/StringBuilder;" in l for l in dc) and any("StringBuilder;->setLength(I)V" in l for l in dc)
      and any("->mPredicting:Z" in l and l.startswith("iput-boolean") for l in dc)
      and any("MrPrevWord;->clear()V" in l for l in dc) and any("->abortCorrection(Z)V" in l for l in dc)
      and any("->postUpdateSuggestions()V" in l for l in dc) and any("TextEntryState;->reset()V" in l for l in dc), dc)
ia = index_of(dc, "->abortCorrection(Z)V")
ir = index_of(dc, "TextEntryState;->reset()V")
check("mrDropComposing: a reopened word is finished BEFORE the text entry state is reset (abortCorrection asks whether it is correcting)", 0 <= ia < ir, (ia, ir))
check("mrDropComposing: abortCorrection is called with false in v1 (no force: it only acts when the keyboard is correcting), v1 being the 0 set at the start",
      dc[ia].startswith("invoke-direct {p0, v1}") and dc[0].startswith("iget-object v0") and "const/4 v1, 0x0" in dc[:ia]
      and sum(1 for l in dc[:ia] if re.match(r"(const|move|iget|invoke-virtual \{v1)", l) and " v1," in l and l != "const/4 v1, 0x0") == 0, dc)
check("mrDropComposing: commits nothing and writes nothing to the app itself (so the word is not learned)",
      not any(w in l for l in dc for w in ("InputConnection", "commitTyped", "commitText", "setComposingText", "finishComposingText",
                                           "deleteSurroundingText", "AutoDictionary", "UserBigram", "addWord", "ictionary", "pickSuggestion")), dc)
vm, host = vm_for(LIME, IME, ["postUpdateSuggestions()V", "abortCorrection(Z)V"])
this = dm.Obj(IME, mComposing="abc", mPredicting=True)
vm.run("mrDropComposing()V", [this])
check("mrDropComposing: runs, in this order (run)",
      host.log == ["setLength", "clear", "abortCorrection", "postUpdateSuggestions", "reset"] and this.f["mPredicting"] in (False, 0), host.log)

# the word being typed is never rewritten by this class: the keyboard and the app could disagree about where the composing text is,
# and a rewrite would then add text instead of replacing it
mwd = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrWordDelete.java"))
code_only = re.sub(r"/\*.*?\*/", "", mwd, flags=re.S)
code_only = re.sub(r"//[^\n]*", "", code_only)
check("MrWordDelete never writes composing text (no setComposingText / commitText / setComposingRegion), only deletes by position",
      not any(w in code_only for w in ("setComposingText", "commitText", "setComposingRegion", "mrEndWord", "mrCommit")), "")
check("MrWordDelete: the keyboard's word is let go of, THEN the app is told to finish its composing text, ALWAYS (not inside an if), THEN the delete by position",
      re.search(r"if \(ime\.mrHoldsWord\(\)\) ime\.mrDropComposing\(\);\s*ic\.finishComposingText\(\);\s*ic\.deleteSurroundingText\(n, 0\);", code_only) is not None)

# ---------------------------------------------------------------------------------------------- the screen, the limits, the texts
java = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrWordDelete.java"))


def const(name, text=java):
    m = re.search(r"\b" + name + r"\s*=\s*([^;]+);", text)
    return m.group(1).strip().strip('"') if m else None


prefs = read(os.path.join(ROOT, "res", "xml", "prefs.xml"))
entries = re.findall(r"<([\w.]+)\s([^>]*?)/?>", prefs)
keys = []
for tag, attrs in entries:
    k = re.search(r'android:key="([^"]+)"', attrs)
    if k:
        keys.append((k.group(1), tag, attrs))
names = [k[0] for k in keys]
at = names.index("pref_long_press_duration")
check("screen: right after the long-press time come the switch and its time, in that order",
      names[at + 1:at + 3] == ["pref_word_delete", "pref_word_delete_interval"], names[at:at + 4])
sw = keys[at + 1]
bar = keys[at + 2]
check("screen: the switch is a CheckBoxPreference, off by default, persistent",
      sw[1] == "CheckBoxPreference" and 'android:defaultValue="false"' in sw[2] and 'android:persistent="true"' in sw[2], sw)
check("screen: the interval is a seek bar that depends on the switch", bar[1] == "com.mrkeyboard.app.SeekBarPreferenceString"
      and 'android:dependency="pref_word_delete"' in bar[2], bar)
check("screen: the keys are the ones of MrWordDelete", const("PREF_ON") == "pref_word_delete" and const("PREF_INTERVAL") == "pref_word_delete_interval")


def attr(name, s):
    m = re.search(name + r'="([^"]*)"', s)
    return m.group(1) if m else None


check("screen: the limits and the default of the bar are the ones of MrWordDelete",
      float(attr("hk:minValue", bar[2])) == float(const("INTERVAL_MIN")) and float(attr("hk:maxValue", bar[2])) == float(const("INTERVAL_MAX"))
      and float(attr("android:defaultValue", bar[2])) == float(const("INTERVAL_DEFAULT")) and attr("hk:displayFormat", bar[2]) == "%.0f ms",
      (attr("hk:minValue", bar[2]), attr("hk:maxValue", bar[2]), attr("android:defaultValue", bar[2])))
check("screen: the bar moves in steps of 50 ms and every step is a value the class accepts",
      attr("hk:step", bar[2]) is not None and float(attr("hk:step", bar[2])) == 50.0
      and (int(const("INTERVAL_MAX")) - int(const("INTERVAL_MIN"))) % 50 == 0 and int(const("INTERVAL_DEFAULT")) % 50 == 0 and int(const("INTERVAL_MIN")) % 50 == 0)
integers = read(os.path.join(ROOT, "res", "values", "integers.xml"))
usual = int(re.search(r'config_key_repeat_interval">(\d+)<', integers).group(1))
check("limits: the shortest interval is longer than the usual repeat (a hold by words is never faster than a hold by letters)", int(const("INTERVAL_MIN")) > usual, usual)
check("limits: the default is inside the limits", int(const("INTERVAL_MIN")) <= int(const("INTERVAL_DEFAULT")) <= int(const("INTERVAL_MAX")))

for d in ("values", "values-es", "values-pt-rBR"):
    x = read(os.path.join(ROOT, "res", d, "mr_strings.xml"))
    for s in ("mr_word_delete_title", "mr_word_delete_summary", "mr_word_delete_interval_title"):
        m = re.search(r'<string name="%s">([^<]+)</string>' % s, x)
        check("text %s in %s" % (s, d), m is not None and len(m.group(1)) > 10, d)
for s in ("mr_word_delete_title", "mr_word_delete_summary", "mr_word_delete_interval_title"):
    check("screen uses @string/%s" % s, "@string/" + s in prefs)

reset = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrReset.java"))
check("MrReset.KEYS has both keys", '"pref_word_delete"' in reset and '"pref_word_delete_interval"' in reset)

notes = read(os.path.join(ROOT, "docs", "release-notes", "v2.0.0.md"))
check("the notes of 2.0.0 have the New / Novo line, in both languages", "- Novo: **Ctrl + apagar apaga por palavra**" in notes and "- New: **Ctrl + delete deletes by words**" in notes)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
