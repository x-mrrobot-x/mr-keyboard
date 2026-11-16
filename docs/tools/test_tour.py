#!/usr/bin/env python3
"""Tests how the first steps (MrTour, MrTourActivity, docs/first-steps.md) are wired into the app:

  - the manifest has the screen (not exported, no intent filter, the theme of the screens, turning the phone keeps it);
  - the steps of Android (turn the keyboard on, choose it) read the system and open the settings and the picker of Android, the screen
    marks itself as done when it is closed, the main screen marks it at once only when no step of Android is left;
  - the screen: the step is centred in the middle (the scroll fills the viewport), the buttons stay out of the scroll, the step changes
    along the horizontal axis, the ring that pulses does not loop when the animations are off, the glyphs exist;
  - the main screen opens it (the smali of Main.onCreate calls MrTour.onOpen once, after the update notice) and nothing else does;
  - the defaults that make the steps necessary are on, in the XML and in the Java layer, and the same one in each place;
  - the texts: every name used by the Java code (the step ones are built from the step name) exists in the three languages with the same
    placeholders, nothing is empty;
  - the network: the screen has no network code, and the catalog and the files are asked for only in MrTour.work, which only
    MrTour.download runs (the button "Download"); opening the app and the screen's own code never connect;
  - the generated smali exists, and the docs and the README (privacy) say it.

The rules (which steps, when it opens, the system language) are in TourTest.java (docs/tools/run_java_tests.sh) and the downloads in the
packs tests (ThreeLangTest, ModelPackTest).

Run it from the project root:  python3 -I docs/tools/test_tour.py
"""
import glob
import os
import re
import sys

ROOT = os.getcwd()
APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
SRC = os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app")
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(*parts):
    with open(os.path.join(ROOT, *parts), encoding="utf-8") as f:
        return f.read()


tour = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrTour.java")
screen = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrTourActivity.java")

# ---------------------------------------------------------------- the manifest
manifest = read("AndroidManifest.xml")
m = re.search(r'<activity\b[^>]*android:name="com\.mrkeyboard\.app\.MrTourActivity"[^>]*?(/>|>.*?</activity>)', manifest, re.S)
check("manifest: MrTourActivity is declared", m is not None)
tag = m.group(0) if m else ""
check("manifest: not exported, no intent filter (only the app opens it)", 'android:exported="false"' in tag and "<intent-filter" not in tag, tag[:200])
check("manifest: the theme of the screens, the title of the screen", 'android:theme="@style/Theme.MrKeyboard.Main"' in tag and 'android:label="@string/mr_tour_title"' in tag, tag[:200])
cc = re.search(r'android:configChanges="([^"]*)"', tag)
check("manifest: turning the phone does not rebuild it (the screen keeps the step)",
      cc is not None and all(x in cc.group(1).split("|") for x in ("orientation", "screenSize", "screenLayout", "smallestScreenSize", "keyboardHidden")), cc.group(1) if cc else None)
check("manifest: one declaration", manifest.count('android:name="com.mrkeyboard.app.MrTourActivity"') == 1)

# ---------------------------------------------------------------- who opens it
main = read("smali", "com", "mrkeyboard", "app", "Main.smali")
body = re.search(r"\.method public onCreate\(Landroid/os/Bundle;\)V(.*?)\.end method", main, re.S)
body = body.group(1) if body else ""
update = body.find("MrUpdateUi;->onOpen(Landroid/app/Activity;)V")
hook = body.find("Lcom/mrkeyboard/app/MrTour;->onOpen(Landroid/app/Activity;)V")
check("Main.onCreate calls MrTour.onOpen(Activity) once, after the update notice", hook > update > 0 and body.count("MrTour;->onOpen") == 1)
check("... with the screen itself as the argument and no register added", "invoke-static {p0}, Lcom/mrkeyboard/app/MrTour;->onOpen" in body)
others = []
for path in sorted(glob.glob(os.path.join(APP, "*.smali"))):
    name = os.path.basename(path)
    if name.startswith("MrTour") or name == "Main.smali":
        continue
    with open(path, encoding="utf-8") as f:
        if "MrTour;->" in f.read():
            others.append(name)
check("nothing else calls MrTour (the settings never open the steps by themselves)", not others, others)
check("generated smali: MrTour, MrTourActivity and the inner classes", all(os.path.isfile(os.path.join(APP, n)) for n in ("MrTour.smali", "MrTourActivity.smali", "MrTour$1.smali")))
check("MrTour.onOpen(Activity) exists with the signature of the call",
      "\n.method static onOpen(Landroid/app/Activity;)V" in read("smali", "com", "mrkeyboard", "app", "MrTour.smali"))

# ---------------------------------------------------------------- the defaults the steps depend on
bools = read("res", "values", "bools.xml")
check("default_suggestions is true", '<bool name="default_suggestions">true</bool>' in bools)
sugg = read("res", "xml", "prefs_suggestions.xml")
check("prefs_suggestions.xml: show_suggestions takes the bool, gesture typing is on by default",
      'android:key="show_suggestions"' in sugg and 'android:defaultValue="@bool/default_suggestions"' in sugg
      and re.search(r'android:key="pref_gesture_typing"[^>]*android:defaultValue="true"', sugg) is not None)
check("prefs_word_delete.xml: delete by word is on by default", re.search(r'android:key="pref_word_delete"[^>]*android:defaultValue="true"', read("res", "xml", "prefs_word_delete.xml")) is not None)
check("MrTour reads the two options with the default true, the same as the keyboard and the screens; delete by word has no step",
      "sp.getBoolean(KEY_SUGGESTIONS, true)" in tour and "sp.getBoolean(MrGestureInput.PREF_ON, true)" in tour and "MrWordDelete" not in tour and "WORD" not in tour)
check("the Java layer (gesture typing, delete by word, the dictionaries screen) also defaults to on",
      "sp.getBoolean(PREF_ON, true)" in read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrGestureInput.java")
      and "sp.getBoolean(PREF_ON, true)" in read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrWordDelete.java")
      and "getBoolean(MrGestureInput.PREF_ON, true)" in read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrPacksActivity.java"))
check("the keys of MrTour are the keyboard's", 'KEY_SUGGESTIONS = "show_suggestions"' in tour and 'PREF_SHOW = "show_suggestions"' not in tour
      and "show_suggestions" in read("smali", "com", "mrkeyboard", "app", "LatinIME.smali"))

# ---------------------------------------------------------------- the texts
STEPS = {"enable": ("title", "text", "missing", "on", "open", "note"), "select": ("title", "text", "missing", "on", "open", "note"),
         "dict": ("title", "text", "off", "missing", "nopack"), "gesture": ("title", "text", "off", "missing")}
STATE_KEYS = {"mr_tour_steps", "mr_tour_index"}  # saved instance state of the screen, not texts
code = tour + screen
names = {n for n in re.findall(r'"(mr_tour_[a-z_]+)"', code) if n not in STATE_KEYS and not n.startswith("mr_tour_ic_")}
names.add("mr_tour_title")   # the label of the screen in the manifest
check("the screen keeps the steps and the position when it is rebuilt", all('"%s"' % k in screen for k in STATE_KEYS))
dynamic = set()
for step, parts in STEPS.items():
    for part in parts:
        dynamic.add("mr_tour_%s_%s" % (step, part))
for part in ("title", "text", "off", "missing", "on", "open", "note"):
    check("the screen builds the texts of the step as mr_tour_<step>_%s" % part, ('"mr_tour_" + step + "_%s"' % part) in screen)
check("the steps of the test are the steps of the code", set(re.findall(r'static final String (ENABLE|SELECT|DICT|GESTURE) = "([a-z]+)"', tour)) ==
      {("ENABLE", "enable"), ("SELECT", "select"), ("DICT", "dict"), ("GESTURE", "gesture")})
needed = names | dynamic
check("the code uses a good number of texts (more than 20)", len(needed) > 20, len(needed))
langs = {"en": "values", "pt": "values-pt-rBR", "es": "values-es"}
table = {}
for lang, folder in langs.items():
    s = read("res", folder, "mr_strings.xml")
    table[lang] = dict(re.findall(r'<string name="(mr_tour_[a-z_]+)">(.*?)</string>', s, re.S))
    check("%s: every text the code uses exists" % lang, needed <= set(table[lang]), sorted(needed - set(table[lang])))
    check("%s: no text that nothing uses" % lang, set(table[lang]) <= needed, sorted(set(table[lang]) - needed))
    check("%s: no empty text, no unescaped apostrophe (aapt2)" % lang, all(v.strip() and not re.search(r"(?<!\\)'", v) for v in table[lang].values()))
    check("%s: each name once" % lang, len(re.findall(r'<string name="mr_tour_', s)) == len(table[lang]))
for name in sorted(needed):
    ph = [sorted(re.findall(r"%\d\$[sd]", table[l].get(name, ""))) for l in ("en", "pt", "es")]
    if ph[0] != ph[1] or ph[0] != ph[2]:
        check("placeholders of %s agree in the three languages" % name, False, ph)
check("the step counter and the missing dictionary take their arguments",
      sorted(re.findall(r"%\d\$[sd]", table["en"]["mr_tour_step"])) == ["%1$d", "%2$d"] and "%1$s" in table["en"]["mr_tour_dict_missing"])
check("the three languages are translated (no text equal to English except the ones that are the same word)",
      sum(1 for n in needed if table["pt"][n] == table["en"][n]) <= 2 and sum(1 for n in needed if table["es"][n] == table["en"][n]) <= 2,
      [n for n in needed if table["pt"][n] == table["en"][n]])
check("the failure texts of MrTour exist (no pack in the catalog, no gesture file)", {"mr_tour_no_pack", "mr_tour_no_gesture"} <= names)

# ---------------------------------------------------------------- the steps of Android
check("the keyboard turned on is read from the list of keyboards of Android, by package", "getEnabledInputMethodList()" in tour and "getPackageName()" in tour)
check("the keyboard in use is read from default_input_method, by 'package/'", "Settings.Secure.DEFAULT_INPUT_METHOD" in tour and 'startsWith(pkg + "/")' in tour)
check("when Android cannot be asked the answer is done (a step that cannot end never holds the person)", tour.count("return true;") >= 6 and "catch (RuntimeException e)" in tour)
check("the first step opens the keyboard settings of Android, the second the picker; neither needs a permission",
      "Settings.ACTION_INPUT_METHOD_SETTINGS" in screen and "showInputMethodPicker()" in screen and "android.permission.WRITE_SECURE_SETTINGS" not in manifest)
check("the steps of Android and their settings use no network class", not re.search(r"java\.net|HttpURLConnection|URL\(", screen) and "java.net" not in tour)
check("the screen is followed while the person is in the settings: it reads again on resume, when the window has the focus back and every half second",
      "protected void onResume()" in screen and "public void onWindowFocusChanged(boolean hasFocus)" in screen and "postDelayed(this, MrTour.sBusy ? 400 : 500)" in screen)
check("the main screen marks it as done at once only when no step of Android is left", "if (!needsSetup(s)) markDone(a);" in tour)
check("closing the screen (Skip, Back, the last button: finish()) marks it as done, and so does reaching a step that is not of Android",
      re.search(r"public void finish\(\) \{\s*MrTour\.markDone\(this\);\s*super\.finish\(\);", screen) is not None
      and "if (!MrTour.isSetup(step)) MrTour.markDone(this);" in screen)

# ---------------------------------------------------------------- the screen (design)
check("the step is in the middle: the scroll fills the viewport and the stage is centred", "scroll.setFillViewport(true);" in screen and "mStage.setGravity(Gravity.CENTER);" in screen)
check("the buttons are under the scroll, not inside it (they stay in reach while the step scrolls)", "mBody.addView(mActions" in screen and "mStage.addView(mPrimary" not in screen and "mStage.addView(mActions" not in screen)
check("the column is at most 440 dp wide and centred on a tablet, and it follows the turn of the phone",
      "COLUMN_DP = 440f" in screen and "public void onConfigurationChanged(Configuration c)" in screen and "applySide();" in screen)
check("the step changes along the horizontal axis: it leaves to the left and the next comes from the right, with the easings of Material",
      "translationX(-dist)" in screen and "mBody.setTranslationX(dist);" in screen and "new PathInterpolator(0.3f, 0f, 1f, 1f)" in screen and "new PathInterpolator(0f, 0f, 0f, 1f)" in screen)
check("the times are those of an onboarding (160 ms out, 340 ms in)", "T_EXIT = 160" in screen and "T_ENTER = 340" in screen)
check("a change of step that is cancelled by the system lets go of the screen", "mHandler.postDelayed(mUnstick," in screen and "private final Runnable mUnstick" in screen)
check("the ring that pulses does not loop when the animations are off, and it stops when the screen is left",
      "SystemClock.uptimeMillis() - t0 < 300" in screen and re.search(r"protected void onPause\(\) \{[^}]*stopPulse\(\);", screen) is not None)
check("the main button is the progress bar of a download (a fill that grows with the percent)", "mPrimaryFill.animate().scaleX(f)" in screen and "MrPacks.sJobPercent / 100f" in screen)
check("a done step turns the icon into a check with a bounce", '"mr_tour_ic_check"' in screen and "popIn(mGlyph, 0);" in screen and "bump(mDisc);" in screen)
check("the quiet button (turn off) is only for the downloads", "if (setup) {\n            mSecondary.setVisibility(View.GONE);" in screen)
check("a repaint happens only when something changed (a tap is never lost)", "if (!now.equals(mSig))" in screen)
check("the screen has no sleep and no loop of its own (the animators of the system run it)", "Thread.sleep" not in screen and "while (true)" not in screen)
for name in ("keyboard", "pick", "book", "swipe", "check"):
    path = os.path.join(ROOT, "res", "drawable", "mr_tour_ic_%s.xml" % name)
    check("glyph mr_tour_ic_%s exists, white stroke (the screen tints it) and used" % name,
          os.path.isfile(path) and "#ffffffff" in open(path, encoding="utf-8").read() and ('"mr_tour_ic_%s"' % name) in screen)

# ---------------------------------------------------------------- the network
check("the screen has no network code of its own", not re.search(r"java\.net|HttpURLConnection|fetchCatalog|fetchBytes|MrPacks\.install", screen))
check("the screen only starts a download with MrTour.download", screen.count("MrTour.download(") == 1)
head, _, work = tour.partition("static String work(")
check("MrTour: the catalog and the files are asked for only inside work()", "fetchCatalog(" not in head and "MrPacks.install(" not in head and "fetchCatalog(" in work)
callers = [n for n in os.listdir(SRC) if n.endswith(".java") and n != "MrTour.java" and "MrTour.work(" in read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", n)]
check("work() is run by MrTour.download only (the Java layer)", not callers and len(re.findall(r"\bwork\(", tour)) == 2 and "err = work(app, step, locale);" in tour, callers)
check("download() does nothing while another job runs", "if (sBusy || MrPacks.sJobId != null) return;" in tour)

# ---------------------------------------------------------------- the docs
doc = read("docs", "first-steps.md")
check("docs/first-steps.md says what it is, the steps, when it opens and the network", all(w in doc for w in ("Step 1 of", "Skip", "once", "English", "MrTour", "Download")))
check("README (en): the privacy section says the first steps download only when Download is tapped", "first steps" in read("README.md").lower() and "first-steps.md" in read("README.md"))
check("README (pt-BR): the same", "primeiros passos" in read("README.pt-BR.md").lower() and "first-steps.md" in read("README.pt-BR.md"))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
