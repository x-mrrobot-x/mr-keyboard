#!/usr/bin/env python3
"""Tests the settings texts and the "Version" line of Settings, About (v2.0.0). Static checks on the files; the notes dialog itself is in test_notes_text.py.

Run it from the project root:  python3 -I docs/tools/test_version_row.py

  - the subtitles of Settings, Typing and of the card "Suggestions and dictionaries" say that gesture typing is there (three languages), and gesture
    typing really is on the screen that card opens;
  - gesture typing is no longer "experimental" in the settings or in the docs (the line "Swipe gestures" keeps its own label);
  - the "Version" line: no " custom"/" official" left (the dead check of the signature), the summary comes from MrVersion, the line is a normal row that can
    be tapped (no static layout) and has the listener that opens the notes; the launcher screen prints the real version name and not the old "custom" text;
  - the notes of the installed version are inside the APK (assets/mr_release_notes.md, a byte-for-byte copy of docs/release-notes/v<versionName>.md) and the
    screens that own the dialog close it when they go away;
  - the texts of the dialog exist in the three languages.
"""
import os
import re
import sys

ROOT = os.getcwd()
ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(*parts, binary=False):
    p = os.path.join(ROOT, *parts)
    return open(p, "rb").read() if binary else open(p, encoding="utf-8").read()


def strings(lang_dir, fn="mr_strings.xml"):
    s = read("res", lang_dir, fn)
    return {m.group(1): m.group(2) for m in re.finditer(r'<string name="([^"]+)">([^<]*)</string>', s)}


LANGS = {"en": "values", "pt": "values-pt-rBR", "es": "values-es"}
MR = {k: strings(d) for k, d in LANGS.items()}
GESTURE_WORD = {"en": "gesture typing", "pt": "digitação por gestos", "es": "escritura por gestos"}

# ------------------------------------------------------------------ the subtitles
prefs = read("res", "xml", "prefs.xml")
dicts_row = re.search(r'<PreferenceScreen[^>]*mr_dicts_title[^>]*>', prefs)
cat_row = re.search(r'<PreferenceCategory[^>]*mr_ui_cat_typing[^>]*>', prefs)
check("the Typing category uses mr_ui_cat_typing_sum as its subtitle and the dictionaries card uses mr_dicts_summary",
      cat_row is not None and 'android:summary="@string/mr_ui_cat_typing_sum"' in cat_row.group(0)
      and dicts_row is not None and 'android:summary="@string/mr_dicts_summary"' in dicts_row.group(0), (cat_row, dicts_row))
for k in LANGS:
    check("subtitles (%s): Typing and 'Suggestions and dictionaries' both say gesture typing" % k,
          GESTURE_WORD[k] in MR[k]["mr_ui_cat_typing_sum"].lower() and GESTURE_WORD[k] in MR[k]["mr_dicts_summary"].lower(),
          (MR[k]["mr_ui_cat_typing_sum"], MR[k]["mr_dicts_summary"]))
    check("subtitles (%s): the word suggestions and the dictionaries are still said" % k,
          any(w in MR[k]["mr_ui_cat_typing_sum"].lower() for w in ("sugest", "sugerenc", "suggestion"))
          and any(w in MR[k]["mr_dicts_summary"].lower() for w in ("dicion", "diccion", "dictionar")))
suggestions = read("res", "xml", "prefs_suggestions.xml")
check("gesture typing really is on the screen that the card opens (res/xml/prefs_suggestions.xml has its group)", "@string/mr_gesture_cat" in suggestions)

# ------------------------------------------------------------------ not experimental any more
for k in LANGS:
    check("gesture typing group title (%s): no 'experimental' in it, and it is the plain name" % k,
          "experiment" not in MR[k]["mr_gesture_cat"].lower() and MR[k]["mr_gesture_cat"].lower() == GESTURE_WORD[k], MR[k]["mr_gesture_cat"])
other = [(k, n) for k in LANGS for n, v in MR[k].items() if n.startswith("mr_gesture") and "experiment" in v.lower()]
check("no other text of the gesture typing group says 'experimental'", not other, other)
docs = {}
for fn in ("README.md", "README.pt-BR.md", os.path.join("engine", "README.md"), os.path.join("docs", "gesture-typing.md")):
    text = read(fn)
    docs[fn] = [l for l in text.split("\n") if re.search(r"experimental", l, re.I) and re.search(r"gesture typing|digitação por gestos", l, re.I)]
check("README, README.pt-BR, engine/README and docs/gesture-typing.md do not call gesture typing experimental", not any(docs.values()), docs)

# ------------------------------------------------------------------ the Version line
settings = read("smali", "com", "mrkeyboard", "app", "LatinIMESettings.smali")
check("Settings: the old ' custom' / ' official' text and the signature loop are gone",
      '" custom"' not in settings and '" official"' not in settings and "Landroid/content/pm/Signature;" not in settings)
check("Settings: the summary of the Version line comes from MrVersion.summary and is set on mLabelVersion",
      settings.count("Lcom/mrkeyboard/app/MrVersion;->summary(Landroid/content/Context;)Ljava/lang/String;") == 1
      and re.search(r"MrVersion;->summary.*?mLabelVersion.*?Preference;->setSummary", settings, re.S) is not None)
m = re.search(r'const-string v0, "label_version"(.*?)\n    :cond_no_version\n', settings, re.S)
check("Settings: the Version line gets the listener that opens the notes (found by its key, skipped if it is missing)",
      m is not None and re.search(r"if-eqz v0, :cond_no_version\b", m.group(0)) is not None and "new-instance v1, Lcom/mrkeyboard/app/MrVersion;" in m.group(1)
      and "invoke-direct {v1, p0}, Lcom/mrkeyboard/app/MrVersion;-><init>(Landroid/app/Activity;)V" in m.group(1)
      and "setOnPreferenceClickListener" in m.group(1), m.group(1) if m else None)
row = re.search(r'<Preference[^>]*android:key="label_version"[^>]*/>', prefs)
check("prefs.xml: the Version line is a normal row (no static layout, no fixed summary: the summary is set in code)",
      row is not None and "pref_row_static" not in row.group(0) and "android:summary" not in row.group(0) and "@string/title_version" in row.group(0), row)
check("the text 'custom' (auto_version) is gone from the resources and from the public ids",
      "auto_version" not in read("res", "values", "strings.xml") and "auto_version" not in read("res", "values", "public.xml") and "auto_version" not in prefs)
main = read("smali", "com", "mrkeyboard", "app", "Main.smali")
check("the launcher screen prints the real version name (MrUpdate.appName), not the old fixed text (the id 0x7f0c0049 is not used any more)",
      "0x7f0c0049" not in main and "Lcom/mrkeyboard/app/MrUpdate;->appName(Landroid/content/Context;)Ljava/lang/String;" in main)
ui = read("smali", "com", "mrkeyboard", "app", "MrUpdateUi.smali")
check("the screens close the Version dialog when they go away (MrUpdateUi.release calls MrVersion.release)",
      "Lcom/mrkeyboard/app/MrVersion;->release(Landroid/app/Activity;)V" in ui)

# ------------------------------------------------------------------ the notes inside the APK
yml = read("apktool.yml")
name = re.search(r"versionName:\s*['\"]?v?([0-9.]+)", yml).group(1)
asset = os.path.join("assets", "mr_release_notes.md")
notes = os.path.join("docs", "release-notes", "v%s.md" % name)
check("assets/mr_release_notes.md exists and is a byte-for-byte copy of docs/release-notes/v<versionName>.md (v%s)" % name,
      os.path.exists(os.path.join(ROOT, asset)) and read(asset, binary=True) == read(notes, binary=True))
text = read(asset)
check("the asset has the two blocks the app looks for, each alone on its line",
      re.search(r"^\*\*Português\*\*\s*$", text, re.M) is not None and re.search(r"^\*\*English\*\*\s*$", text, re.M) is not None)
src = read("docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrVersion.java")
check("MrVersion reads the asset by the same name that is shipped", 'ASSET = "mr_release_notes.md"' in src and os.path.basename(asset) == "mr_release_notes.md")
check("MrVersion looks for the same two marks as make_update.py", 'MARK_PT = "**Português**"' in src and 'MARK_EN = "**English**"' in src
      and "('pt-BR', '**Português**'), ('en', '**English**')" in read("docs", "tools", "make_update.py"))

# ------------------------------------------------------------------ the texts of the dialog
for k in LANGS:
    t = MR[k]
    check("dialog texts (%s): title, close and the summary with the version in it" % k,
          all(t.get(x) for x in ("mr_version_title", "mr_version_close", "mr_version_summary")) and "%1$s" in t.get("mr_version_summary", ""))
check("the dialog texts are written in each language (not the same text in the three)",
      len({MR[k]["mr_version_title"] for k in LANGS}) == 3 and len({MR[k]["mr_version_close"] for k in LANGS}) == 3)

# ------------------------------------------------------------------ the buttons of the update dialog: one row, GitHub kept and renamed
layout = read("res", "layout", "mr_update_dialog.xml")
row = re.search(r'<LinearLayout\s+android:tag="upd_actions"(.*?)\n    </LinearLayout>', layout, re.S)
tags = re.findall(r'android:tag="(upd_\w+)"', row.group(1)) if row else []
check("update dialog: the three actions are in one horizontal row (upd_actions), in the order Not now, GitHub, Install",
      row is not None and 'android:orientation="horizontal"' in row.group(1).split("<TextView")[0] and tags == ["upd_later", "upd_github", "upd_install"], tags)
cells = re.findall(r"<TextView(.*?)/>", row.group(1), re.S) if row else []
check("update dialog: the buttons share the width equally, can use two lines and are 48dp high at least",
      len(cells) == 3 and all('android:layout_width="0dp"' in c and 'android:layout_weight="1"' in c and 'android:maxLines="2"' in c
                              and 'android:minHeight="48dp"' in c and 'android:clickable="true"' in c for c in cells))
check("update dialog: the GitHub button is still there and the buttons are not outside the row",
      layout.count('android:tag="upd_github"') == 1 and layout.count('android:tag="upd_install"') == 1 and layout.count('android:tag="upd_later"') == 1)
want = {"en": "Open on GitHub", "pt": "Abrir no GitHub", "es": "Abrir en GitHub"}
check("update dialog: the GitHub button says 'Open on GitHub' in each language", all(MR[k]["mr_update_github"] == want[k] for k in LANGS),
      {k: MR[k]["mr_update_github"] for k in LANGS})

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
