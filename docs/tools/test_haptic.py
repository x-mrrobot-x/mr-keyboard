#!/usr/bin/env python3
"""Tests the vibration of a key press (MrHaptic.smali) and the slider that sets it (VibratePreference.onChange).

Run it from the project root:  python3 -I docs/tools/test_haptic.py

Runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with a fake phone: a vibrator that records what it is asked to play (an effect
of the composition, a predefined one, a one-shot, with or without the usage "touch"), a keyboard view that records the system haptic, and an Android
version (Build.VERSION.SDK_INT) that the test chooses. The rules (docs/haptics.md):
  - the strength is 1..100 %; what is out of it is brought into it;
  - each device takes the first it can do: primitives (API 30+ with TICK and CLICK supported: TICK at strength/50 up to 50 %, CLICK at strength/100
    above), a predefined effect (API 29+: TICK up to 50 %, CLICK up to 80 %, HEAVY_CLICK above), the system haptic of the view (KEYBOARD_TAP, with
    the flag "ignore the global setting" before API 33), a 15 ms one-shot (only with no view; the amplitude follows the strength);
  - an effect that cannot be built (an exception) goes down to the next tier; the effect of a strength is built once and reused;
  - from API 33 the vibration carries the usage "touch" (0x12), made once;
  - no motor: no vibration, the system haptic of the view only.
Also: the setting is read as a fraction kept as text and brought to 1..100 (50 when it is missing or unreadable); the slider hands the strength
to LatinIME.vibrate in per cent; nothing of the old duration setting is left, and the key is the same in the xml, in MrHaptic and in MrReset.
"""
import math
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
HAPTIC = "Lcom/mrkeyboard/app/MrHaptic;"
PREF = "Lcom/mrkeyboard/app/VibratePreference;"
PLAY = "play(Landroid/content/Context;ILandroid/view/View;)V"
LEVEL = "level(Landroid/content/SharedPreferences;)I"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def jround(x):
    """Math.round(float): half up, NaN is 0."""
    x = dm.fv(x)
    return 0 if math.isnan(x) else math.floor(x + 0.5)


class Phone:
    """The fake phone. sdk: Build.VERSION.SDK_INT. has: the vibrator has a motor. prims: it supports TICK and CLICK. amp: amplitude control.
    fail: the names of the calls that throw (createPredefined, startComposition)."""

    def __init__(self, sdk, has=True, prims=False, amp=False, fail=(), no_service=False):
        self.sdk, self.has, self.prims, self.amp, self.fail, self.no_service = sdk, has, prims, amp, set(fail), no_service
        self.played = []          # what the vibrator was asked to play: ('effect', kind, ..., attrs usage or None)
        self.haptic = []          # performHapticFeedback calls of the view: (constant, flags or None)
        self.calls = []           # every call made on the framework, by name (to count the effects built)
        self.vib = dm.Obj("Landroid/os/Vibrator;")
        self.view = dm.Obj("Landroid/view/View;")
        self.ctx = dm.Obj("Landroid/content/Context;")
        self.vm = dm.VM(HAPTIC, dm.parse_methods(os.path.join(APP, "MrHaptic.smali")), self)

    def play(self, strength, view=True):
        return self.vm.run(PLAY, [self.ctx, strength, self.view if view else None])

    # --- the host of the interpreter
    def sget(self, cls, name):
        if (cls, name) == ("Landroid/os/Build$VERSION;", "SDK_INT"):
            return self.sdk
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        self.calls.append(mem.split("(")[0])
        a0 = args[0] if args else None
        if mem == "getSystemService(Ljava/lang/String;)Ljava/lang/Object;":
            assert args[1] == "vibrator"
            return None if self.no_service else self.vib
        if cls == "Landroid/os/Vibrator;":
            if mem == "hasVibrator()Z":
                return 1 if self.has else 0
            if mem == "hasAmplitudeControl()Z":
                return 1 if self.amp else 0
            if mem == "areAllPrimitivesSupported([I)Z":
                assert sorted(args[1]) == [1, 7], args[1]          # CLICK and TICK, nothing else
                return 1 if self.prims else 0
            if mem == "vibrate(Landroid/os/VibrationEffect;)V":
                self.played.append(args[1].f["what"] + (None,))
                return None
            if mem == "vibrate(Landroid/os/VibrationEffect;Landroid/os/VibrationAttributes;)V":
                self.played.append(args[1].f["what"] + (args[2].f["usage"],))
                return None
        if cls == "Landroid/os/VibrationEffect;":
            if mem == "startComposition()Landroid/os/VibrationEffect$Composition;":
                if "startComposition" in self.fail:
                    raise dm.JavaExc("Ljava/lang/IllegalArgumentException;", "composition")
                return dm.Obj("Landroid/os/VibrationEffect$Composition;", prims=[])
            if mem == "createPredefined(I)Landroid/os/VibrationEffect;":
                if "createPredefined" in self.fail:
                    raise dm.JavaExc("Ljava/lang/IllegalArgumentException;", "predefined")
                return dm.Obj("Landroid/os/VibrationEffect;", what=("predefined", args[0]))
            if mem == "createOneShot(JI)Landroid/os/VibrationEffect;":
                return dm.Obj("Landroid/os/VibrationEffect;", what=("oneshot", args[0], args[1]))
        if cls == "Landroid/os/VibrationEffect$Composition;":
            if mem == "addPrimitive(IF)Landroid/os/VibrationEffect$Composition;":
                a0.f["prims"].append((args[1], dm.fv(args[2])))
                return a0
            if mem == "compose()Landroid/os/VibrationEffect;":
                return dm.Obj("Landroid/os/VibrationEffect;", what=("composition", tuple(a0.f["prims"])))
        if cls == "Landroid/os/VibrationAttributes;" and mem == "createForUsage(I)Landroid/os/VibrationAttributes;":
            return dm.Obj("Landroid/os/VibrationAttributes;", usage=args[0])
        if cls == "Landroid/view/View;":
            if mem == "performHapticFeedback(I)Z":
                self.haptic.append((args[1], None))
                return 1
            if mem == "performHapticFeedback(II)Z":
                self.haptic.append((args[1], args[2]))
                return 1
        if cls == "Ljava/lang/Float;" and mem == "parseFloat(Ljava/lang/String;)F":
            if args[0] is None:
                raise dm.JavaExc("Ljava/lang/NullPointerException;")
            try:
                return dm.f32(float(args[0]))
            except ValueError:
                raise dm.JavaExc("Ljava/lang/NumberFormatException;", args[0])
        if cls == "Ljava/lang/Math;" and mem == "round(F)I":
            return jround(args[0])
        if cls == "Landroid/content/SharedPreferences;" and mem == "getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;":
            return a0.f["data"].get(args[1], args[2])
        raise AssertionError("not faked: " + target)


def effect_of(p):
    """The one effect the vibrator played (the last), or None."""
    return p.played[-1] if p.played else None


def f32(x):
    return dm.f32(x)


# ------------------------------------------------------------------ tier 1: primitives (API 30+)
for sdk in (30, 33, 36):
    p = Phone(sdk, prims=True)
    p.play(50)
    usage = None if sdk < 33 else 0x12
    check("API %d with primitives: 50 %% is a TICK at full scale%s" % (sdk, "" if sdk < 33 else ", with the usage touch"),
          effect_of(p) == ("composition", ((7, 1.0),), usage), p.played)
    check("API %d with primitives: no system haptic, no predefined effect" % sdk, p.haptic == [] and "createPredefined" not in p.calls, (p.haptic, p.calls))

for s in (1, 10, 25, 33, 49, 50):
    p = Phone(34, prims=True)
    p.play(s)
    check("primitives: %d %% is a TICK at %d/50" % (s, s), effect_of(p) == ("composition", ((7, f32(s / 50)),), 0x12), p.played)
for s in (51, 60, 75, 99, 100):
    p = Phone(34, prims=True)
    p.play(s)
    check("primitives: %d %% is a CLICK at %d/100" % (s, s), effect_of(p) == ("composition", ((1, f32(s / 100)),), 0x12), p.played)

# ------------------------------------------------------------------ tier 2: predefined effects (API 29+)
for s, kind, name in ((1, 2, "TICK"), (50, 2, "TICK"), (51, 0, "CLICK"), (80, 0, "CLICK"), (81, 5, "HEAVY_CLICK"), (100, 5, "HEAVY_CLICK")):
    p = Phone(34, prims=False)
    p.play(s)
    check("no primitives: %d %% is the effect %s" % (s, name), effect_of(p) == ("predefined", kind, 0x12), p.played)
    check("  (the composition was not even tried: it was not supported)", "startComposition" not in p.calls, p.calls)

p = Phone(29, prims=True)          # the primitives came with API 30: on API 29 only the predefined effects
p.play(70)
check("API 29 does not touch the composition, even if the vibrator says it supports it", effect_of(p) == ("predefined", 0, None) and "startComposition" not in p.calls
      and "areAllPrimitivesSupported" not in p.calls, (p.played, p.calls))

p = Phone(31, prims=True, fail=("startComposition",))
p.play(50)
check("a composition that throws falls to the predefined effect", effect_of(p) == ("predefined", 2, None), p.played)

# ------------------------------------------------------------------ tier 3: the system haptic
for sdk, flags in ((26, 2), (28, 2), (32, 2), (33, None), (34, None)):
    p = Phone(sdk, prims=False)
    p.play(50)
    if sdk >= 29:
        check("API %d: the predefined effect comes before the system haptic" % sdk, p.haptic == [] and effect_of(p) is not None, (p.played, p.haptic))
    else:
        check("API %d: no effect to play, the system haptic (KEYBOARD_TAP) is asked%s" % (sdk, " with the flag ignore-global-setting" if flags else ""),
              p.haptic == [(3, flags)] and p.played == [], (p.haptic, p.played))

p = Phone(34, prims=True, fail=("startComposition", "createPredefined"))
p.play(50)
check("both effects fail: the system haptic of the view (API 33+: no flag)", p.haptic == [(3, None)] and p.played == [], (p.haptic, p.played))
p = Phone(30, prims=True, fail=("startComposition", "createPredefined"))
p.play(50)
check("... and below API 33 with the flag", p.haptic == [(3, 2)] and p.played == [], (p.haptic, p.played))

# ------------------------------------------------------------------ tier 4: the short one-shot (no view)
for strength, amp, want in ((50, True, 127), (100, True, 255), (1, True, 2), (50, False, -1)):
    p = Phone(28, amp=amp)
    p.play(strength, view=False)
    check("no view, API 28, %s: a 15 ms one-shot at amplitude %d (%d %%)" % ("amplitude control" if amp else "no amplitude control", want, strength),
          effect_of(p) == ("oneshot", 15, want, None), p.played)
p = Phone(28)
p.play(50, view=True)
check("with a view the one-shot is never used (the system haptic is)", p.played == [] and p.haptic == [(3, 2)], (p.played, p.haptic))
p = Phone(34, prims=True, fail=("startComposition", "createPredefined"), amp=True)
p.play(50, view=False)
check("no view and both effects fail: the one-shot, with the usage touch from API 33", effect_of(p) == ("oneshot", 15, 127, 0x12), p.played)

# ------------------------------------------------------------------ no motor
p = Phone(34, has=False, prims=True)
p.play(50)
check("no motor: nothing is played, the system haptic of the view is still asked", p.played == [] and p.haptic == [(3, None)], (p.played, p.haptic))
p = Phone(34, has=False)
p.play(50, view=False)
check("no motor and no view: nothing at all", p.played == [] and p.haptic == [], (p.played, p.haptic))
p = Phone(34, no_service=True)
p.play(50)
check("no vibrator service: the system haptic of the view", p.played == [] and p.haptic == [(3, None)], (p.played, p.haptic))
p = Phone(34, no_service=True)
p.play(50, view=False)
check("no vibrator service and no view: nothing, and no crash", p.played == [] and p.haptic == [], (p.played, p.haptic))

# ------------------------------------------------------------------ the strength is brought to 1..100
p = Phone(34, prims=True)
p.play(0)
check("strength 0 is played as 1 % (a TICK at 1/50)", effect_of(p) == ("composition", ((7, f32(1 / 50)),), 0x12), p.played)
p = Phone(34, prims=True)
p.play(-30)
check("a negative strength is played as 1 %", effect_of(p) == ("composition", ((7, f32(1 / 50)),), 0x12), p.played)
p = Phone(34, prims=True)
p.play(500)
check("a strength above 100 is played as 100 % (a CLICK at full scale)", effect_of(p) == ("composition", ((1, 1.0),), 0x12), p.played)

# ------------------------------------------------------------------ the effect of a strength is built once
p = Phone(34, prims=True)
for _ in range(5):
    p.play(50)
check("5 key presses at the same strength build the effect once (and ask the support once)",
      p.calls.count("startComposition") == 1 and p.calls.count("areAllPrimitivesSupported") == 1 and len(p.played) == 5, (p.calls, len(p.played)))
p.play(70)
p.play(70)
check("another strength builds a new one, once more", p.calls.count("startComposition") == 2 and effect_of(p) == ("composition", ((1, f32(0.7)),), 0x12), (p.calls, p.played[-1]))
p.play(50)
check("... and going back to the first builds it again (one effect is kept)", p.calls.count("startComposition") == 3 and p.played[-1][1] == ((7, 1.0),), p.calls)
check("the usage touch is made once for all of it", p.calls.count("createForUsage") == 1, p.calls)

p = Phone(34, prims=True, fail=("startComposition", "createPredefined"))
for _ in range(4):
    p.play(50)
check("a device with no effect for the strength does not try again at every key press",
      p.calls.count("createPredefined") == 1 and p.calls.count("startComposition") == 1 and len(p.haptic) == 4, (p.calls, len(p.haptic)))

# ------------------------------------------------------------------ the setting
SPREFS = {}


def level(data):
    prefs = dm.Obj("Landroid/content/SharedPreferences;", data=data)
    ph = Phone(34)
    return ph.vm.run(LEVEL, [prefs])


for text, want in (("0.5", 50), ("0.05", 5), ("1.0", 100), ("0.35000002", 35), ("0.8", 80), ("0.0", 1), ("0", 1), ("2.0", 100), ("-1", 1),
                   ("5", 100), ("abc", 50), ("", 50), ("NaN", 1)):
    check("the setting %r is read as %d %%" % (text, want), level({"vibrate_strength": text}) == want, level({"vibrate_strength": text}))
check("the setting missing is 50 %", level({}) == 50, level({}))
check("the old key (vibrate_len, a duration in ms) is not read", level({"vibrate_len": "30"}) == 50, level({"vibrate_len": "30"}))

# ------------------------------------------------------------------ the slider
class SliderHost:
    def __init__(self, instance=True):
        self.heard = []
        self.instance = dm.Obj("Lcom/mrkeyboard/app/LatinIME;") if instance else None

    def sget(self, cls, name):
        assert (cls, name) == ("Lcom/mrkeyboard/app/LatinIME;", "sInstance"), (cls, name)
        return self.instance

    def invoke(self, vm, op, target, args):
        if target == "Lcom/mrkeyboard/app/LatinIME;->vibrate(I)V":
            self.heard.append(args[1])
            return None
        if target == "Ljava/lang/Math;->round(F)I":
            return jround(args[0])
        raise AssertionError("not faked: " + target)


for value, want in ((0.5, 50), (0.05, 5), (1.0, 100), (0.35000002, 35), (0.95, 95)):
    h = SliderHost()
    vm = dm.VM(PREF, dm.parse_methods(os.path.join(APP, "VibratePreference.smali")), h)
    vm.run("onChange(F)V", [dm.Obj(PREF), dm.f32(value)])
    check("the slider at %s plays %d %% (LatinIME.vibrate takes per cent)" % (value, want), h.heard == [want], h.heard)
h = SliderHost(instance=False)
vm = dm.VM(PREF, dm.parse_methods(os.path.join(APP, "VibratePreference.smali")), h)
vm.run("onChange(F)V", [dm.Obj(PREF), dm.f32(0.5)])
check("the slider with no keyboard running plays nothing (and does not crash)", h.heard == [], h.heard)

# ------------------------------------------------------------------ the files: one key, nothing of the old setting
def read(*parts):
    return open(os.path.join(ROOT, *parts), encoding="utf-8").read()


xml = read("res", "xml", "prefs_feedback.xml")
key = re.search(r'VibratePreference[^>]*android:key="([^"]+)"', xml).group(1)
haptic = read("smali", "com", "mrkeyboard", "app", "MrHaptic.smali")
check("the key of the slider (%s) is the one MrHaptic.level reads" % key, 'const-string v0, "%s"' % key in haptic, key)
check("... the one LatinIME listens to when it changes", 'const-string v0, "%s"' % key in read("smali", "com", "mrkeyboard", "app", "LatinIME.smali"), key)
check("... the one 'Restore defaults' resets (smali and Java)", ('const-string v2, "%s"' % key) in read("smali", "com", "mrkeyboard", "app", "MrReset.smali")
      and ('"%s",' % key) in read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrReset.java"), key)
default = re.search(r'VibratePreference[^>]*android:defaultValue="([^"]+)"', xml).group(1)
check("the slider starts at 50 %% like MrHaptic.level (default %s)" % default, float(default) == 0.5, default)
rng = re.search(r'hk:maxValue="([\d.]+)"[^>]*hk:minValue="([\d.]+)"|hk:minValue="([\d.]+)"', xml)
vp = xml[xml.index("VibratePreference"):]
check("the slider goes from 5 % to 100 % in steps of 5 %, shown as a percentage",
      'hk:minValue="0.05"' in vp.split("/>")[0] and 'hk:maxValue="1.0"' in vp.split("/>")[0] and 'hk:step="0.05"' in vp.split("/>")[0]
      and 'hk:asPercent="true"' in vp.split("/>")[0], vp.split("/>")[0])

left = []
for base, _, names in os.walk(ROOT):
    if os.sep + "build" in base or ".git" in base or "__pycache__" in base or os.sep + "release-notes" in base:
        continue
    for n in names:
        if not n.endswith((".smali", ".xml", ".java", ".md", ".py", ".yml", ".sh")) or n in ("test_haptic.py", "haptics.md"):   # haptics.md tells the history
            continue
        path = os.path.join(base, n)
        text = open(path, encoding="utf-8", errors="replace").read()
        for pat in ("vibrate_len", "vibrate_duration_ms", "HapticHelper", "mVibrateLen", "PREF_VIBRATE_LEN"):
            if pat in text and not (pat == "vibrate_len" and "title_vibrate_len" in text and text.count("vibrate_len") == text.count("title_vibrate_len")):
                left.append((os.path.relpath(path, ROOT), pat))
check("nothing is left of the old duration setting or of HapticHelper", left == [], left)
check("LatinIME.vibrate(I) hands the strength to MrHaptic.play",
      "MrHaptic;->play(Landroid/content/Context;ILandroid/view/View;)V" in read("smali", "com", "mrkeyboard", "app", "LatinIME.smali"))
check("the strings say strength, in the three languages",
      "Vibration strength" in read("res", "values", "strings.xml") and "Intensidade da vibração" in read("res", "values-pt-rBR", "strings.xml")
      and "Intensidad de la vibración" in read("res", "values-es", "strings.xml"))

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
