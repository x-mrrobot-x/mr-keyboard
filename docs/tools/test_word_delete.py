#!/usr/bin/env python3
"""Tests the places where Ctrl + delete by words (MrWordDelete, 2.0.0, docs/word-delete.md) is wired into the keyboard, on the REAL smali:

  - LatinIME.handleBackspace (its hook, and what the keyboard does with the answer) and LatinKeyboardBaseView$UIHandler.cancelKeyRepeatTimer
    and .handleMessage (the repeat) run in the mini Dalvik interpreter (dalvik_mini.py) with a fake MrWordDelete;
  - PointerTracker.onDownEvent (too big to run here): the order of the calls in the branch of the keys that repeat;
  - the hook of Ctrl + Z (LatinIME.sendModifiableKeyChar: first thing, the key is not sent when the class took it) and the methods added to
    LatinIME (mrCtrlOn, mrCtrlOnly, mrHoldsWord, mrDropComposing) run in the interpreter;
  - nobody else calls MrWordDelete, and what is called exists in the generated smali with the signature used;
  - the settings screen (its own screen, PrefScreenWordDelete, opened by one row of Touch and gestures: sections, order of the rows, the texts that
    explain it, the manifest), the limits and default against the Java constants, the texts in the three
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
    "LatinIME.smali": {"onBackspace(Lcom/mrkeyboard/app/LatinIME;)Z", "onUndoRedo(Lcom/mrkeyboard/app/LatinIME;C)Z"},
    "MrTrim.smali": {"release()V"},
}
check("calls: only the five places call MrWordDelete, with these methods", calls == expected, calls)

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
        self.undo = False        # what MrWordDelete.onUndoRedo answers
        self.shift = False       # what LatinIME.isShiftMod answers

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
        if cls == WD and name == "onUndoRedo":
            return 1 if self.undo else 0
        if name == "isShiftMod":
            return 1 if self.shift else 0
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


# the hook of Ctrl + Z in sendModifiableKeyChar (every character the keyboard sends goes through it)
sm = code_lines(method_body(LIME, "public sendModifiableKeyChar(C)V"))
check("sendModifiableKeyChar: the first thing it does is ask MrWordDelete.onUndoRedo with the keyboard and the character",
      len(sm) >= 3 and sm[0] == "invoke-static {p0, p1}, " + WD + "->onUndoRedo(Lcom/mrkeyboard/app/LatinIME;C)Z" and sm[1].startswith("move-result"), sm[:3])
j_hook = index_of(sm, "if-eqz", 0)
j_orig = index_of(sm, "->isShiftMod()Z", 0)
check("sendModifiableKeyChar: when the class did not take the key, the original code goes on from where it began (the first thing it asked is isShiftMod)",
      0 < j_hook < j_orig and sm[j_hook].endswith(":cond_mr_undo") and ":cond_mr_undo" in sm[j_orig - 1], (j_hook, j_orig))
vm, host = vm_for(LIME, IME, ["handleModifierKeysUp(ZZ)V"])
host.undo = True
vm.run("sendModifiableKeyChar(C)V", [dm.Obj(IME), ord("z")])
check("sendModifiableKeyChar (run): the class took the key: the Ctrl that was on is let go the way a plain character does it (no key sent: handleModifierKeysUp(false, false)), and nothing else is done",
      host.log == ["WD.onUndoRedo", "handleModifierKeysUp"], host.log)

cs = code_lines(method_body(LIME, "public mrCtrlOnly()Z"))
check("mrCtrlOnly: Ctrl on, and Alt, Meta and Shift (isShiftMod) off, in this order", 
      [i for i, l in enumerate(cs) if "->mModCtrl:Z" in l or "->mModAlt:Z" in l or "->mModMeta:Z" in l or "->isShiftMod()Z" in l] != []
      and "->mModCtrl:Z" in cs[0] and index_of(cs, "->mModAlt:Z") < index_of(cs, "->mModMeta:Z") < index_of(cs, "->isShiftMod()Z"), cs)
vm, host = vm_for(LIME, IME, ["isShiftMod()Z"])


def only(ctrl, alt, meta, shift):
    host.shift = shift
    return bool(vm.run("mrCtrlOnly()Z", [dm.Obj(IME, mModCtrl=ctrl, mModAlt=alt, mModMeta=meta)]))


check("mrCtrlOnly (run): Ctrl alone -> true", only(True, False, False, False) is True)
check("mrCtrlOnly (run): no Ctrl -> false", only(False, False, False, False) is False)
check("mrCtrlOnly (run): Ctrl with Alt -> false", only(True, True, False, False) is False)
check("mrCtrlOnly (run): Ctrl with Meta -> false", only(True, False, True, False) is False)
check("mrCtrlOnly (run): Ctrl with Shift (the redo) -> false", only(True, False, False, True) is False)

# the word being typed is never rewritten by this class: the keyboard and the app could disagree about where the composing text is,
# and a rewrite would then add text instead of replacing it
mwd = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrWordDelete.java"))
code_only = re.sub(r"/\*.*?\*/", "", mwd, flags=re.S)
code_only = re.sub(r"//[^\n]*", "", code_only)
check("MrWordDelete never writes composing text (no setComposingText / setComposingRegion), only deletes by position",
      not any(w in code_only for w in ("setComposingText", "setComposingRegion", "mrEndWord", "mrCommit")), "")
check("MrWordDelete: the only write is commitText, once, in the Ctrl + Z (undo), and the app's composing text is finished right before it (commitText replaces composing text)",
      code_only.count("commitText") == 1 and re.search(r"ic\.finishComposingText\(\);[^;]*\n?\s*ic\.commitText\(cut\.text, 1\);", code_only) is not None)
check("MrWordDelete: what is kept expires: a lifetime in ms and a limit in words are constants, and onUndoRedo and onBackspace let the expired ones go first",
      re.search(r"UNDO_LIFETIME_MS = \d+L;", code_only) is not None and re.search(r"UNDO_MAX = \d+;", code_only) is not None
      and re.search(r"public static boolean onUndoRedo\([^)]*\) \{[^}]*?try \{\s*purge\(\);", code_only, re.S) is not None
      and re.search(r"n > 0\) \{[^{}]*?purge\(\);", code_only, re.S) is not None)
check("MrWordDelete: the keyboard's word is let go of, THEN the app is told to finish its composing text, ALWAYS (not inside an if), THEN the delete by position",
      re.search(r"if \(ime\.mrHoldsWord\(\)\) ime\.mrDropComposing\(\);\s*ic\.finishComposingText\(\);\s*ic\.deleteSurroundingText\(n, 0\);", code_only) is not None)


# Ctrl + Y: the redo takes the word out by position (never writes), after the composing text is finished, and the second list is let go with the first
check("MrWordDelete: Ctrl + Y finishes the app's composing text, then deletes by position exactly the length of the word (never writes)",
      re.search(r"if \(ime\.mrHoldsWord\(\)\) ime\.mrDropComposing\(\);\s*ic\.finishComposingText\(\);\s*ic\.deleteSurroundingText\(cut\.text\.length\(\), 0\);", code_only) is not None)
check("MrWordDelete: release() clears both lists and turning the setting off calls it",
      re.search(r"public static void release\(\) \{\s*sCuts\.clear\(\);\s*sRedo\.clear\(\);", code_only) is not None
      and re.search(r"if \(!sOn\) \{\s*sHold = false;\s*release\(\);", code_only) is not None)
trim = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrTrim.java"))
trim_code = re.sub(r"//[^\n]*", "", re.sub(r"/\*.*?\*/", "", trim, flags=re.S))
check("MrTrim.onTrim lets go of the words kept (MrWordDelete.release) at any level, before the part that can fail, so the cleanup button and the system both do it",
      re.search(r"static void onTrim\(int level\) \{\s*if \(level < MODERATE\) return;.*?MrWordDelete\.release\(\);\s*try \{\s*keyboards = KeyboardSwitcher\.dropUnused\(\);", trim_code, re.S) is not None)

# ---------------------------------------------------------------------------------------------- the screen, the limits, the texts
java = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrWordDelete.java"))


def const(name, text=java):
    m = re.search(r"\b" + name + r"\s*=\s*([^;]+);", text)
    return m.group(1).strip().strip('"') if m else None


prefs_main = read(os.path.join(ROOT, "res", "xml", "prefs.xml"))
prefs = read(os.path.join(ROOT, "res", "xml", "prefs_word_delete.xml"))
check("settings: Touch and gestures has ONE row for this, a screen that opens PREFS_WORD_DELETE (the switch and the time are not loose among the other rows)",
      re.search(r'<PreferenceScreen android:title="@string/mr_word_delete_title" android:summary="@string/mr_word_delete_row_sum">\s*<intent android:action="com.mrkeyboard.app.PREFS_WORD_DELETE"/>', prefs_main) is not None
      and "pref_word_delete" not in prefs_main.replace("PREFS_WORD_DELETE", ""))
touch = prefs_main[prefs_main.index('android:key="altchar_settings"'):prefs_main.index('android:key="general_settings"')]
check("settings: the row is in the Touch and gestures page, after the other screens (feedback, actions)",
      touch.index("PREFS_FEEDBACK") < touch.index("PREFS_ACTIONS") < touch.index("PREFS_WORD_DELETE"))

entries = re.findall(r"<([\w.]+)\s([^>]*?)/?>", prefs)
keys = []
for tag, attrs in entries:
    k = re.search(r'android:key="([^"]+)"', attrs)
    if k:
        keys.append((k.group(1), tag, attrs))
names = [k[0] for k in keys]
check("screen: two sections, each with a title and an icon, then the rows in this order: the switch, its time, how to use it; the text about undo and redo",
      names == ["word_delete_settings", "word_delete_ctrl", "pref_word_delete", "pref_word_delete_interval", "word_delete_how", "word_delete_undo", "word_delete_undo_info"]
      and all('android:title="@string/' in k[2] and 'android:icon="@drawable/' in k[2] for k in keys if k[1] == "PreferenceCategory"), names)
sw = keys[names.index("pref_word_delete")]
bar = keys[names.index("pref_word_delete_interval")]
check("screen: the switch is a CheckBoxPreference, off by default, persistent, with a summary that says what it does",
      sw[1] == "CheckBoxPreference" and 'android:defaultValue="false"' in sw[2] and 'android:persistent="true"' in sw[2] and 'android:summary="@string/mr_word_delete_summary"' in sw[2], sw)
check("screen: the interval is a seek bar that depends on the switch", bar[1] == "com.mrkeyboard.app.SeekBarPreferenceString"
      and 'android:dependency="pref_word_delete"' in bar[2], bar)
texts = [keys[names.index(n)] for n in ("word_delete_how", "word_delete_undo_info")]
check("screen: the two rows of text are not buttons (not selectable, nothing stored), have a title and a text, and go grey with the switch",
      all(t[1] == "Preference" and 'android:selectable="false"' in t[2] and 'android:persistent="false"' in t[2] and "mr_ui_pref_row_static" in t[2]
          and 'android:dependency="pref_word_delete"' in t[2] and 'android:title="@string/' in t[2] and 'android:summary="@string/' in t[2] for t in texts), texts)
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

used = sorted(set(re.findall(r"@string/(mr_word_delete\w*)", prefs + prefs_main)))
check("texts: the screen and the row use these strings (and only these ones are used)",
      used == ["mr_word_delete_cat_ctrl", "mr_word_delete_cat_undo", "mr_word_delete_how_sum", "mr_word_delete_how_title", "mr_word_delete_interval_title",
               "mr_word_delete_row_sum", "mr_word_delete_summary", "mr_word_delete_switch_title", "mr_word_delete_title", "mr_word_delete_undo_sum",
               "mr_word_delete_undo_title"], used)
for d in ("values", "values-es", "values-pt-rBR"):
    x = read(os.path.join(ROOT, "res", d, "mr_strings.xml"))
    for name in used:
        m = re.search(r'<string name="%s">([^<]+)</string>' % name, x)
        check("text %s in %s" % (name, d), m is not None and len(m.group(1)) >= 8, d)
    # the explaining rows have to fit the 4 lines of the row (about 48 characters a line on a narrow phone)
    for name in ("mr_word_delete_how_sum", "mr_word_delete_undo_sum", "mr_word_delete_summary"):
        m = re.search(r'<string name="%s">([^<]+)</string>' % name, x)
        check("text %s in %s fits the 4 lines of a row (at most 190 characters)" % (name, d), m is not None and len(m.group(1)) <= 190, len(m.group(1)) if m else 0)
    check("texts in %s: the words 'Ctrl + Z' and 'Ctrl + Y' are explained in the undo row" % d,
          "Ctrl + Z" in re.search(r'<string name="mr_word_delete_undo_sum">([^<]+)', x).group(1) and "Ctrl + Y" in re.search(r'<string name="mr_word_delete_undo_sum">([^<]+)', x).group(1))

# ---------------------------------------------------------------------------------------------- the icons of the sections
def tile(name):
    x = read(os.path.join(ROOT, "res", "drawable", name + ".xml"))
    c = re.search(r"@color/mr_ui_(\w+?)_soft", x)
    return x, (c.group(1) if c else None)


def shape_of(x):
    """Everything about the size of a section icon that is not its colour or its drawing."""
    return (re.findall(r'<corners android:radius="(\d+)dp"', x), re.findall(r'<stroke android:width="(\d+)dp"', x),
            re.findall(r'android:(?:left|top|right|bottom)="(\d+)dp"', x), re.findall(r'<vector [^>]*android:width="(\d+)dp"[^>]*android:height="(\d+)dp"', x))


icons = [a for k in keys if k[1] == "PreferenceCategory" for a in re.findall(r'android:icon="@drawable/(\w+)"', k[2])]
check("icons: the two sections have an icon, and they are two different drawables", len(icons) == 2 and icons[0] != icons[1], icons)
shapes = []
for ic in icons:
    x, col = tile(ic)
    shapes.append(shape_of(x))
    check("icon %s: a rounded tile (soft fill + thin line of one colour) with the drawing inset in it, like the icons of the pages" % ic,
          re.sub(r"<\?xml[^>]*\?>|<!--.*?-->", "", x, flags=re.S).lstrip().startswith("<layer-list") and col is not None and "@color/mr_ui_%s_line" % col in x and "@color/mr_ui_%s\"" % col in x
          and '<shape android:shape="rectangle"' in x and "<vector " in x, col)
check("icons: both sections have the same size of tile, corner, line, inset and drawing (the second is not bigger or flat)",
      len(shapes) == 2 and shapes[0] == shapes[1] and shapes[0][0] and shapes[0][2] and shapes[0][3], shapes)
page_icon = re.search(r'android:key="altchar_settings"[^>]*android:icon="@drawable/(\w+)"', prefs_main).group(1)
check("icons: the tile of the sections is the one of the pages of the settings", shape_of(tile(page_icon)[0])[:3] == shapes[0][:3], (page_icon, shape_of(tile(page_icon)[0])))

# ---------------------------------------------------------------------------------------------- the two texts of hold time and popup
longrow = re.search(r'<com\.mrkeyboard\.app\.SeekBarPreferenceString [^>]*android:key="pref_long_press_duration"[^>]*>', prefs_main).group(0)
check("settings: the hold time row has the title and the text that explains it", 'android:title="@string/title_long_press_duration"' in longrow
      and 'android:summary="@string/mr_long_press_duration_sum"' in longrow, longrow)
withsum = sorted(re.findall(r'<com\.mrkeyboard\.app\.SeekBarPreferenceString [^>]*android:summary="[^"]*"[^>]*android:key="([^"]+)"', "".join(
    read(os.path.join(ROOT, "res", "xml", f)) for f in os.listdir(os.path.join(ROOT, "res", "xml")) if f.endswith(".xml"))))
check("settings: the hold time is the only slider with a text of its own (the others still show only their value)", withsum == ["pref_long_press_duration"], withsum)
values_popup = re.findall(r"<item>(\d+)</item>", re.search(r'<string-array name="popup_content_values">(.*?)</string-array>', read(os.path.join(ROOT, "res", "values", "arrays.xml")), re.S).group(1))
check("popup: the values of the five choices are untouched (the engine reads them as flags)", values_popup == ["256", "768", "0", "3", "7"], values_popup)
old_titles = {"values": ("Long-press duration", "Popup on key press"), "values-pt-rBR": ("Duração do toque longo", "Popup ao pressionar a tecla"),
              "values-es": ("Duración del toque largo", "Popup al presionar la tecla")}
for d in ("values", "values-es", "values-pt-rBR"):
    st = read(os.path.join(ROOT, "res", d, "strings.xml"))
    t1 = re.search(r'<string name="title_long_press_duration">([^<]+)<', st).group(1)
    t2 = re.search(r'<string name="title_popup_content">([^<]+)<', st).group(1)
    check("titles in %s: both are new (not the vague ones) and say what the setting is about: holding a key, and accents and symbols" % d,
          (t1, t2) != old_titles[d] and t1 != old_titles[d][0] and t2 != old_titles[d][1] and re.search(r"(?i)segurar|hold|mantener", t1) and re.search(r"(?i)acentos|accents", t2)
          and re.search(r"(?i)segurar|hold|mantener", t2), (t1, t2))
    ms = read(os.path.join(ROOT, "res", d, "mr_strings.xml"))
    sm = re.search(r'<string name="mr_long_press_duration_sum">([^<]+)<', ms)
    check("hold time text in %s: one place for the value (%%1$s), says what opens, short enough for the row" % d,
          sm is not None and sm.group(1).count("%1$s") == 1 and "%" not in sm.group(1).replace("%1$s", "") and len(sm.group(1)) <= 110, sm.group(1) if sm else None)
    ar = read(os.path.join(ROOT, "res", d, "arrays.xml"))
    ent = re.findall(r"<item>([^<]+)</item>", re.search(r'<string-array name="popup_content_entries">(.*?)</string-array>', ar, re.S).group(1))
    check("popup choices in %s: five, none with the vague word 'popup', the first two say they are off, the last three show an example (3 and e)" % d,
          len(ent) == 5 and not any("popup" in e.lower() for e in ent) and all("⇒" in e for e in ent[2:]) and all("⇒" not in e for e in ent[:2])
          and all("3 ⇒" in e and "e ⇒" in e for e in ent[2:]) and len(set(ent)) == 5, ent)
    check("popup choices in %s: each one is only in its place (off / off + repeat / accents / + uppercase / full), so the list matches the values above" % d,
          re.search(r"(?i)desligado|off|desactivado", ent[0]) and re.search(r"(?i)repe|repit", ent[1]) and "#" not in ent[2] and "#" in ent[3] and "3#³" in ent[4], ent)
sbp = method_body(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "SeekBarPreference.smali"), "getSummary()")
sc = code_lines(sbp)
i_fmt = index_of(sc, "formatFloatDisplay")
i_sup = index_of(sc, "Landroid/preference/Preference;->getSummary()")
i_null = index_of(sc, "if-eqz v1, :cond_mr_value")
i_empty = index_of(sc, "if-eqz v2, :cond_mr_value")
tail = sc[sc.index(":cond_mr_value"):] if ":cond_mr_value" in sc else []
check("SeekBarPreference.getSummary: asks the row for its own text; with none, or an empty one, it gives the value alone as it always did",
      min(i_fmt, i_sup, i_null, i_empty) >= 0 and i_fmt < i_sup < i_null < i_empty and tail[:2] == [":cond_mr_value", "return-object v0"]
      and not any(re.match(r"(move-result-object|const-string|move-object|move) v0", l) for l in sc[i_fmt + 2:i_empty + 1]), (i_fmt, i_sup, i_null, i_empty, tail[:3]))
check("SeekBarPreference.getSummary: '%1$s' in the text is replaced by the value; a text without it goes under the value",
      'const-string v2, "%1$s"' in sbp and any("String;->contains(Ljava/lang/CharSequence;)Z" in l for l in sc) and any("String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)" in l for l in sc)
      and ":cond_mr_below" in sc and 'const-string v0, "\\n"' in sbp)

manifest = read(os.path.join(ROOT, "AndroidManifest.xml"))
m = re.search(r'<activity ([^>]*?android:name="com\.mrkeyboard\.app\.PrefScreenWordDelete"[^>]*)>(.*?)</activity>', manifest, re.S)
check("manifest: PrefScreenWordDelete is declared, not exported, with the Settings theme and the action PREFS_WORD_DELETE",
      m is not None and 'android:exported="false"' in m.group(1) and "@style/Theme.MrKeyboard.Settings" in m.group(1) and "com.mrkeyboard.app.PREFS_WORD_DELETE" in m.group(2), m.group(1) if m else None)
act = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "PrefScreenWordDelete.java"))
check("PrefScreenWordDelete: a PreferenceActivity in the language of the app that fills itself from prefs_word_delete and follows the preferences for the backup",
      "extends PreferenceActivity" in act and 'getIdentifier("prefs_word_delete", "xml"' in act and "UiLocale.wrap(base)" in act and "ListDividerFix.apply(this)" in act
      and "dataChanged()" in act)
check("the page of Touch and gestures names the new screen in its summary, in the three languages",
      all("mr_ui_cat_touch_sum" in read(os.path.join(ROOT, "res", d, "mr_strings.xml")) for d in ("values", "values-es", "values-pt-rBR"))
      and "delete by word" in read(os.path.join(ROOT, "res", "values", "mr_strings.xml")))

reset = read(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrReset.java"))
check("MrReset.KEYS has both keys", '"pref_word_delete"' in reset and '"pref_word_delete_interval"' in reset)

notes = read(os.path.join(ROOT, "docs", "release-notes", "v2.0.0.md"))
check("the notes of 2.0.0 have the New / Novo line, in both languages, and say where the screen is",
      "- Novo: **Ctrl + apagar apaga por palavra**" in notes and "- New: **Ctrl + delete deletes by words**" in notes
      and "Toque e gestos → Apagar por palavra" in notes and "Touch and gestures → Delete by word" in notes)
check("the notes of 2.0.0 tell, in both languages, that the texts of hold time and of accents and symbols are clearer",
      "- Melhorado: Em **Toque e gestos**, **Tempo para segurar a tecla**" in notes and "- Improved: In **Touch and gestures**, **Time to hold a key**" in notes
      and "**Acentos e símbolos ao segurar a tecla**" in notes and "**Accents and symbols on key hold**" in notes)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
