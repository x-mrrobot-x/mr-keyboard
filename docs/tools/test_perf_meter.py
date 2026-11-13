#!/usr/bin/env python3
"""Tests the performance meter of the keyboard (MrPerf.smali, MrPerf$Reset.smali) and where the keyboard calls it.

Run it from the project root:  python3 -I docs/tools/test_perf_meter.py

Part 1 runs the REAL smali of MrPerf in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework (clock, MotionEvent,
StringBuilder, the texts of the app, the memory, the log, the Advanced screen and its row), so the smali the mr-smali workflow
generates from docs/tools/java/src/com/mrkeyboard/app/MrPerf.java is held to the same rules as the Java test
(docs/tools/perf_test/PerfTest.java):
  - a begin and an end measure in microseconds; an end with no begin is ignored; a clock going back counts 0;
  - the average and the p95 are of the last 256 samples, the count and the maximum since the reset;
  - the first frame after a field opens is timed from the start of the open, once, and not after 2 s;
  - a finger down (first or another) counts how late it reached the keyboard; other actions do not count;
  - the Advanced row: one line per kind measured, in order (one sample: its time only), the memory, how to reset; nothing measured:
    "nothing yet" and the memory; a tap resets; no row or a broken screen: nothing happens;
  - the log gets one line when the keyboard hides after new keys.
Part 2 reads the smali of the keyboard: every piece of work measured has its begin before the work and its end right before every
return (no register used), the questions to the app are wrapped right after their result, the touch is the first line of the
keyboard view, the log is written when the window hides, the row is filled when the Advanced screen resumes; and the row, its
layout and its texts exist in the three languages with the same placeholders.
"""
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
PERF = "Lcom/mrkeyboard/app/MrPerf;"
RESET = "Lcom/mrkeyboard/app/MrPerf$Reset;"
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


TEXTS = {
    "mr_ui_perf_create": "Start", "mr_ui_perf_view": "View", "mr_ui_perf_open": "Open", "mr_ui_perf_shown": "Shown",
    "mr_ui_perf_frame": "Frame", "mr_ui_perf_key": "Key", "mr_ui_perf_touch": "Touch", "mr_ui_perf_app": "App",
    "mr_ui_perf_sugg": "Sugg", "mr_ui_perf_stat": "%1$s: average %2$s ms · 95%% within %3$s · max %4$s (%5$d×)",
    "mr_ui_perf_one": "%1$s: %2$s ms", "mr_ui_perf_none": "Nothing yet.", "mr_ui_perf_mem": "Memory: Java %1$s · native %2$s",
    "mr_ui_perf_reset": "Tap to reset."}


def jformat(fmt, args):
    """String.format for %N$s, %N$d and %%."""
    def one(m):
        if m.group(0) == "%%":
            return "%"
        return str(args[int(m.group(1)) - 1])
    return re.sub(r"%%|%(\d+)\$[sd]", one, fmt)


def ms_text(ns):
    return "?" if ns < 0 else "%.1f" % (ns / 1000000.0)


def bytes_text(b):
    if b < 0:
        return "?"
    if b >= 1000000:
        return "%.1f MB" % (b / 1000000.0)
    return "%d KB" % ((b + 500) // 1000)


class Fw:
    def __init__(self):
        self.nano = 777          # System.nanoTime
        self.uptime = 0          # SystemClock.uptimeMillis
        self.heap = (30000000, 5900000)   # totalMemory, freeMemory
        self.native = 18300000
        self.log = []
        self.missing = set()     # names of texts the app does not have
        self.perf = dm.VM(PERF, dm.parse_methods(os.path.join(APP, "MrPerf.smali")), self)
        self.reset_cls = dm.VM(RESET, dm.parse_methods(os.path.join(APP, "MrPerf$Reset.smali")), self)
        self.perf.run("<clinit>()V", [])

    def run(self, key, *args):
        return self.perf.run(key, list(args))

    def stats(self, kind):
        return list(self.run("stats(I)[I", kind))

    def set_nanos(self, v):
        self.perf.statics["sFakeNanos"] = v

    def tick(self, us):
        self.perf.statics["sFakeNanos"] += us * 1000

    # --- host
    def sget(self, cls, name):
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return obj is not None and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        a0 = args[0] if args else None
        if cls == PERF:
            return self.perf.run(mem, args)
        if cls == RESET and mem == "<init>(Landroid/content/Context;)V":
            return self.reset_cls.run(mem, args)
        if cls == "Ljava/lang/Object;" and mem == "<init>()V":
            return None
        if cls == "Ljava/util/Arrays;":
            if mem in ("fill([JJ)V", "fill([II)V"):
                for i in range(len(a0)):
                    a0[i] = args[1]
                return None
            if mem == "sort([III)V":
                a0[args[1]:args[2]] = sorted(a0[args[1]:args[2]])
                return None
        if cls == "Ljava/lang/System;" and mem == "nanoTime()J":
            return self.nano
        if cls == "Landroid/os/SystemClock;" and mem == "uptimeMillis()J":
            return self.uptime
        if cls == "Landroid/view/MotionEvent;":
            if mem == "getActionMasked()I":
                return a0.f["action"]
            if mem == "getEventTime()J":
                return a0.f["time"]
        if cls == "Ljava/lang/Integer;" and mem == "valueOf(I)Ljava/lang/Integer;":
            return a0
        if cls == "Ljava/lang/StringBuilder;":
            if mem == "<init>()V":
                a0.f["s"] = ""
                return None
            if mem.startswith("append("):
                v = args[1]
                a0.f["s"] += chr(v) if mem.startswith("append(C)") else str(v)
                return a0
            if mem == "length()I":
                return len(a0.f["s"])
            if mem == "toString()Ljava/lang/String;":
                return a0.f["s"]
        if cls == "Lcom/mrkeyboard/app/MrPacks;" and mem.startswith("text("):
            name, fargs = args[1], args[2]
            if name in self.missing or name not in TEXTS:
                return None
            return jformat(TEXTS[name], fargs) if fargs else TEXTS[name]
        if cls == "Lcom/mrkeyboard/app/MrDiag;":
            if mem == "msText(J)Ljava/lang/String;":
                return ms_text(args[0])
            if mem == "bytesText(J)Ljava/lang/String;":
                return bytes_text(args[0])
        if cls == "Ljava/lang/Runtime;":
            if mem == "getRuntime()Ljava/lang/Runtime;":
                return dm.Obj("Ljava/lang/Runtime;")
            if mem == "totalMemory()J":
                return self.heap[0]
            if mem == "freeMemory()J":
                return self.heap[1]
        if cls == "Landroid/os/Debug;" and mem == "getNativeHeapAllocatedSize()J":
            return self.native
        if cls == "Landroid/util/Log;" and mem == "i(Ljava/lang/String;Ljava/lang/String;)I":
            self.log.append(args[0] + ": " + args[1])
            return 0
        if cls == "Landroid/preference/PreferenceActivity;" and mem.startswith("findPreference("):
            if a0.f.get("broken"):
                raise dm.JavaExc("Ljava/lang/RuntimeException;", "no screen")
            a0.f["asked"].append(args[1])
            return a0.f["row"] if args[1] == "mr_perf" else None
        if cls == "Landroid/preference/Preference;":
            if mem == "setSummary(Ljava/lang/CharSequence;)V":
                a0.f["summary"] = args[1]
                return None
            if mem.startswith("setOnPreferenceClickListener("):
                a0.f["click"] = args[1]
                return None
        raise AssertionError("not faked: " + target)

    # --- the Advanced screen
    def screen(self, row=True, broken=False):
        r = dm.Obj("Landroid/preference/Preference;", summary=None, click=None)
        return dm.Obj("Landroid/preference/PreferenceActivity;", row=r if row else None, asked=[], broken=broken), r

    def fill(self, scr):
        self.run("fill(Landroid/preference/PreferenceActivity;)V", scr)

    def tap(self, row):
        return self.reset_cls.run("onPreferenceClick(Landroid/preference/Preference;)Z", [row.f["click"], row])

    def event(self, action, time):
        return dm.Obj("Landroid/view/MotionEvent;", action=action, time=time)


def j(a):
    return ",".join(str(x) for x in a)


KINDS = ["create", "view", "open", "shown", "frame", "key", "touch", "app", "sugg"]
CREATE, VIEW, OPEN, SHOWN, FRAME, KEY, TOUCH, APP_, SUGG = range(9)

# ======================================================================== part 1: the smali of MrPerf
fw = Fw()
st = fw.perf.statics
check("the names of the texts, in the order of the kinds", st["NAMES"] == ["mr_ui_perf_" + k for k in KINDS], st["NAMES"])
check("the names of the log", st["LOG"] == KINDS, st["LOG"])
check("nothing under way, no first frame awaited, the real clock", st["sStart"] == [-1] * 9 and st["sShownFrom"] == -1
      and st["sFakeNanos"] == -1)
check("the real clock is System.nanoTime", fw.run("nanos()J") == 777)
check("p95 index of 0, 1, 2, 20, 100, 256", [fw.run("p95(I)I", k) for k in (0, 1, 2, 20, 100, 256)] == [0, 0, 1, 18, 94, 243])

fw.set_nanos(0)
fw.run("keyBegin()V"); fw.tick(1500); fw.run("keyEnd()V")
check("a key of 1.5 ms: 1500 us", j(fw.stats(KEY)) == "1,1500,1500,1500,1500", fw.stats(KEY))
fw.run("keyEnd()V")
check("an end with no begin is ignored", fw.stats(KEY)[0] == 1)
fw.run("keyBegin()V"); fw.tick(900); fw.run("keyBegin()V"); fw.tick(300); fw.run("keyEnd()V")
check("a second begin starts again", fw.stats(KEY)[4] == 300)
fw.set_nanos(5000000); fw.run("appBegin()V"); fw.set_nanos(4000000); fw.run("appEnd()V")
check("a clock going back counts 0", fw.stats(APP_)[4] == 0)
for begin, end, kind, us in (("createBegin", "createEnd", CREATE, 180000), ("viewBegin", "viewEnd", VIEW, 95000),
                             ("suggBegin", "suggEnd", SUGG, 2000), ("frameBegin", "frameEnd", FRAME, 3000),
                             ("openBegin", "openEnd", OPEN, 4000), ("appBegin", "appEnd", APP_, 250)):
    fw.run(begin + "()V"); fw.tick(us); fw.run(end + "()V")
    check("%s/%s go to their kind" % (begin, end), fw.stats(kind)[4] == us, fw.stats(kind))

fw.run("reset()V")
for i in range(1, 21):
    fw.run("add(IJ)V", FRAME, i * 100)
check("20 frames: count, average, p95, max, last", j(fw.stats(FRAME)) == "20,1050,1900,2000,2000", fw.stats(FRAME))
fw.run("reset()V")
for i in range(300):
    fw.run("add(IJ)V", FRAME, 99999 if i == 10 else 1000)
s = fw.stats(FRAME)
check("300 frames: all counted, average and p95 of the last 256, the old peak still the maximum", s[:4] == [300, 1000, 1000, 99999], s)
fw.run("reset()V")
fw.run("add(IJ)V", KEY, -5)
fw.run("add(IJ)V", KEY, 1 << 40)
s = fw.stats(KEY)
check("below 0 counts 0, too big counts Integer.MAX_VALUE", s[1] == 2147483647 // 2 and s[3] == 2147483647, s)

fw.run("reset()V")
fw.set_nanos(1000000000)
fw.run("openBegin()V"); fw.tick(4000); fw.run("openEnd()V"); fw.tick(10000)
fw.run("frameBegin()V"); fw.tick(3000); fw.run("frameEnd()V")
check("first frame: 17 ms from the start of the open", fw.stats(SHOWN)[:1] + fw.stats(SHOWN)[4:] == [1, 17000], fw.stats(SHOWN))
fw.run("frameBegin()V"); fw.run("frameEnd()V")
check("a second frame is not a first frame", fw.stats(SHOWN)[0] == 1)
fw.run("openBegin()V"); fw.run("openEnd()V"); fw.tick(2000001); fw.run("frameBegin()V"); fw.run("frameEnd()V")
check("later than 2 s: not counted", fw.stats(SHOWN)[0] == 1)
fw.run("openBegin()V"); fw.run("openEnd()V"); fw.tick(2000000); fw.run("frameBegin()V"); fw.run("frameEnd()V")
check("exactly 2 s: counted", fw.stats(SHOWN)[0] == 2 and fw.stats(SHOWN)[4] == 2000000, fw.stats(SHOWN))

fw.run("reset()V")
fw.uptime = 50000
fw.run("touch(Landroid/view/MotionEvent;)V", fw.event(0, 49996))
fw.run("touch(Landroid/view/MotionEvent;)V", fw.event(5, 49980))
check("finger down 4 ms late, another finger 20 ms late", fw.stats(TOUCH)[0] == 2 and fw.stats(TOUCH)[3] == 20000, fw.stats(TOUCH))
for action in (1, 2, 3, 6):
    fw.run("touch(Landroid/view/MotionEvent;)V", fw.event(action, 1))
fw.run("touch(Landroid/view/MotionEvent;)V", None)
check("up, move, cancel, pointer up and no event: not counted", fw.stats(TOUCH)[0] == 2)

fw.run("reset()V")
scr, row = fw.screen()
fw.fill(scr)
check("nothing measured: 'nothing yet' and the memory", row.f["summary"] == "Nothing yet.\nMemory: Java 24.1 MB · native 18.3 MB",
      row.f["summary"])
check("the row is asked by its key and gets a tap listener", scr.f["asked"] == ["mr_perf"] and row.f["click"] is not None
      and row.f["click"].cls == RESET)
fw.set_nanos(0)
fw.run("createBegin()V"); fw.tick(182400); fw.run("createEnd()V")
fw.run("add(IJ)V", KEY, 1000)
fw.run("add(IJ)V", KEY, 3000)
scr, row = fw.screen()
fw.fill(scr)
check("lines: once, many, memory, reset", row.f["summary"] == "Start: 182.4 ms\nKey: average 2.0 ms · 95% within 3.0 · max 3.0 (2×)\n"
      "Memory: Java 24.1 MB · native 18.3 MB\nTap to reset.", row.f["summary"])
check("a tap is handled", fw.tap(row) == 1)
check("... it resets and says so at once", fw.stats(KEY)[0] == 0 and fw.stats(CREATE)[0] == 0
      and row.f["summary"].startswith("Nothing yet.\n"), row.f["summary"])
for k in range(9):
    fw.run("add(IJ)V", k, 1000 * (k + 1))
    fw.run("add(IJ)V", k, 1000 * (k + 1))
scr, row = fw.screen()
fw.fill(scr)
lines = row.f["summary"].split("\n")
names = ["Start", "View", "Open", "Shown", "Frame", "Key", "Touch", "App", "Sugg"]
check("every kind in order, then memory and reset", len(lines) == 11
      and all(lines[k].startswith("%s: average %d.0 ms" % (names[k], k + 1)) for k in range(9)), lines)
fw.missing = {"mr_ui_perf_reset", "mr_ui_perf_mem", "mr_ui_perf_stat"}
scr, row = fw.screen()
fw.fill(scr)
check("texts missing: their lines are left out (no line of a kind left: 'nothing yet')", row.f["summary"] == "Nothing yet.",
      row.f["summary"])
fw.missing = set()
scr, row = fw.screen(row=False)
fw.fill(scr)
check("no row: nothing", scr.f["asked"] == ["mr_perf"])
scr, row = fw.screen(broken=True)
try:
    fw.fill(scr)
    quiet = True
except dm.JavaExc:
    quiet = False
check("a broken screen: no exception", quiet and row.f["summary"] is None)

fw.run("reset()V")
fw.log.clear()
fw.run("onHidden()V")
check("hidden with no key: no line", fw.log == [])
fw.run("add(IJ)V", KEY, 1500)
fw.run("add(IJ)V", FRAME, 4200)
fw.run("onHidden()V")
check("keys typed: one line", fw.log == ["MrPerf: frame 4.2/4.2/4.2 ms (1) key 1.5/1.5/1.5 ms (1) heap 24.1 MB native 18.3 MB"],
      fw.log)
fw.run("onHidden()V")
check("hidden again with no new key: no line", len(fw.log) == 1)
fw.run("add(IJ)V", KEY, 1500)
fw.run("onHidden()V")
check("a new key: a new line", len(fw.log) == 2)

# ======================================================================== part 2: the calls in the keyboard
CALL = "invoke-static {}, " + PERF + "->"


def body(name, head):
    lines = open(os.path.join(APP, name), encoding="utf-8").read().split("\n")
    s = next(i for i, l in enumerate(lines) if l.startswith(".method ") and head in l)
    e = next(i for i in range(s, len(lines)) if lines[i].startswith(".end method"))
    return [l.strip() for l in lines[s:e] if l.strip() and not l.strip().startswith(("#", ".line", ".prologue"))]


def code(b):
    return [l for l in b if not l.startswith(".") and not l.startswith(":")]


def wrapped(name, head, begin, end, first=True):
    b = body(name, head)
    c = code(b)
    rets = [i for i, l in enumerate(c) if l.startswith("return")]
    good_begin = c.count(CALL + begin + "()V") == 1 and (c[0] == CALL + begin + "()V" if first else True)
    good_end = all(i > 0 and c[i - 1] == CALL + end + "()V" for i in rets) and c.count(CALL + end + "()V") == len(rets)
    return good_begin and good_end and len(rets) > 0, (len(rets), c[:2])


for name, head, begin, end in (("LatinIME.smali", "public onCreateInputView()", "viewBegin", "viewEnd"),
                               ("LatinIME.smali", "public onStartInputView(", "openBegin", "openEnd"),
                               ("LatinIME.smali", "public onKey(I[III)V", "keyBegin", "keyEnd"),
                               ("LatinIME.smali", "private updateSuggestions()V", "suggBegin", "suggEnd"),
                               ("LatinKeyboardBaseView.smali", "public onDraw(Landroid/graphics/Canvas;)V", "frameBegin", "frameEnd")):
    good, info = wrapped(name, head, begin, end)
    check("%s %s: %s first, %s before every return" % (name[:-6], head.split("(")[0].split()[-1], begin, end), good, info)

c = code(body("LatinIME.smali", "public constructor <init>()V"))
check("the start of the keyboard begins right after the constructor of the service",
      c[0].endswith("InputMethodService;-><init>()V") and c[1] == CALL + "createBegin()V", c[:2])
c = code(body("LatinIME.smali", "public onCreate()V"))
rets = [i for i, l in enumerate(c) if l.startswith("return")]
check("... and ends before the return of onCreate", len(rets) == 1 and c[rets[0] - 1] == CALL + "createEnd()V"
      and CALL + "createBegin()V" not in c)

for head, call in (("private getCursorCapsMode(", "InputConnection;->getCursorCapsMode(I)I"),
                   ("private checkReCorrectionOnStart()V", "InputConnection;->getExtractedText(")):
    c = code(body("LatinIME.smali", head))
    i = next(k for k, l in enumerate(c) if call in l)
    check("the question to the app %s is measured around it" % call.split(">")[1].split("(")[0],
          c[i - 1] == CALL + "appBegin()V" and c[i + 1].startswith("move-result") and c[i + 2] == CALL + "appEnd()V"
          and c.count(CALL + "appBegin()V") == 1, c[i - 1:i + 3])

c = code(body("LatinIME.smali", "public onWindowHidden()V"))
check("the log line when the window hides", c.count(CALL + "onHidden()V") == 1 and c[0].startswith("invoke-super")
      and c[1] == CALL + "onHidden()V", c[:2])
c = code(body("LatinKeyboardView.smali", "public onTouchEvent(Landroid/view/MotionEvent;)Z"))
check("the touch is the first line of the keyboard view", c[0] == "invoke-static {p1}, " + PERF + "->touch(Landroid/view/MotionEvent;)V", c[0])
c = code(body("PrefScreenAdvanced.smali", "protected onResume()V"))
check("the Advanced screen fills the row when it resumes",
      "invoke-static {p0}, " + PERF + "->fill(Landroid/preference/PreferenceActivity;)V" in c)

perf_src = open(os.path.join(APP, "MrPerf.smali"), encoding="utf-8").read()
called = set()
for f in os.listdir(APP):
    if f.endswith(".smali") and not f.startswith("MrPerf"):
        called |= set(re.findall(re.escape(PERF) + r"->(\w+\([^)]*\)\S+)", open(os.path.join(APP, f), encoding="utf-8").read()))
missing = [m for m in sorted(called) if not re.search(r"\.method public static " + re.escape(m) + r"\n", perf_src)]
check("every MrPerf call of the keyboard is a public static method of MrPerf (%d)" % len(called), not missing and len(called) == 17,
      (missing, len(called)))

xml = open(os.path.join(ROOT, "res", "xml", "prefs_advanced.xml"), encoding="utf-8").read()
check("the row of the Advanced screen: key, metrics layout, tappable, not saved",
      re.search(r'<Preference android:layout="@layout/mr_ui_pref_row_metrics" android:persistent="false" [^>]*android:key="mr_perf"', xml)
      is not None and 'android:key="mr_perf"' in xml and "selectable=\"false\" android:title=\"@string/mr_ui_perf\"" not in xml)
lay = open(os.path.join(ROOT, "res", "layout", "mr_ui_pref_row_metrics.xml"), encoding="utf-8").read()
check("its layout shows every line (no maxLines)", "android:id/summary" in lay and "maxLines" not in lay)
needed = ["mr_ui_perf_" + k for k in KINDS] + ["mr_ui_perf", "mr_ui_perf_stat", "mr_ui_perf_one", "mr_ui_perf_none", "mr_ui_perf_mem",
                                              "mr_ui_perf_reset", "mr_ui_cat_perf", "mr_ui_cat_perf_sum"]
specs = {}
for lang in ("values", "values-pt-rBR", "values-es"):
    src = open(os.path.join(ROOT, "res", lang, "mr_strings.xml"), encoding="utf-8").read()
    have = dict(re.findall(r'<string name="(mr_ui_perf\w*|mr_ui_cat_perf\w*)">([^<]*)</string>', src))
    gone = [n for n in needed if n not in have]
    check("the texts of the row in %s" % lang, not gone, gone)
    specs[lang] = {n: sorted(re.findall(r"%\d\$[sd]", have.get(n, ""))) for n in needed}
check("the same placeholders in the three languages", specs["values"] == specs["values-pt-rBR"] == specs["values-es"])
check("the line of a kind has its five values", specs["values"]["mr_ui_perf_stat"] == ["%1$s", "%2$s", "%3$s", "%4$s", "%5$d"])

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
