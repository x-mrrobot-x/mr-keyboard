#!/usr/bin/env python3
"""Checks that changing "Idioma do app" (App language) rebuilds the keyboard right away, once, so that the toolbar and its tools show the new language.

Run it from the project root:  python3 -I docs/tools/test_ui_language_rebuild.py

The toolbar (mr_toolbar.xml) and the buttons that the tools build take their texts from the language of the moment they are inflated; only the
panels that read their strings when they open (the emotes) followed a change by themselves. The fix is in LatinIME.onSharedPreferenceChanged:
when the key of the language changes, the keyboard view is made again at that moment (one time, not on every open) and MrTools.wrap inflates the
bar again with MrLocaleCtx. This script reads the smali and checks each link of that chain, and that the check notices when a link is missing
(the same smali with the block taken out must fail).
"""
import os
import re

ROOT = os.getcwd()
APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


def read(name):
    with open(os.path.join(APP, name), encoding="utf-8") as f:
        return f.read()


def method(text, head):
    """The body of the method whose line starts with `.method` and contains `head`."""
    m = re.search(r"^\.method [^\n]*" + re.escape(head) + r"[^\n]*\n(.*?)^\.end method", text, re.S | re.M)
    return m.group(1) if m else None


def code(body):
    """The instructions only: no comments, no blank lines, no .line."""
    out = []
    for raw in body.splitlines():
        t = raw.split("#")[0].strip()
        if t and not t.startswith(".line"):
            out.append(t)
    return out


def language_block(ime_text):
    """The instructions of onSharedPreferenceChanged from the test of the language key until the `return-void` that ends its block, or None."""
    body = method(ime_text, "onSharedPreferenceChanged(Landroid/content/SharedPreferences;Ljava/lang/String;)V")
    if body is None:
        return None
    ins = code(body)
    for i, t in enumerate(ins):
        if t.startswith("const-string") and t.endswith('"pref_ui_language"'):
            for j in range(i, len(ins)):
                if ins[j] == "return-void":
                    return ins[i:j + 1]
            return ins[i:]
    return None


ime = read("LatinIME.smali")
loc = read("UiLocale.smali")
tools = read("MrTools.smali")
sw = read("KeyboardSwitcher.smali")
settings = read("LatinIMESettings.smali")

# ---- the key is the one the Settings screen writes and UiLocale reads
m = re.search(r'\.field public static final KEY:Ljava/lang/String; = "([^"]+)"', loc)
key = m.group(1) if m else None
check("UiLocale.KEY is pref_ui_language", key == "pref_ui_language", key)
check("the Settings screen asks for the key in prefs.xml",
      'android:key="pref_ui_language"' in open(os.path.join(ROOT, "res", "xml", "prefs.xml"), encoding="utf-8").read())

# ---- the keyboard rebuilds its view when that key changes
blk = language_block(ime)
check("onSharedPreferenceChanged has a block for pref_ui_language", blk is not None)
blk = blk or []
text = "\n".join(blk)
check("the block compares the changed key with the language key (String.equals with p2, the key that changed)",
      any(t.startswith("invoke-virtual {v0, p2}") and "String;->equals" in t for t in blk), text)
check("the block rebuilds the view with recreateInputView", "KeyboardSwitcher;->recreateInputView()V" in text, text)
check("...only when there is a view already (getInputView is tested before): with none, the first one is made in the new language",
      "KeyboardSwitcher;->getInputView()" in text and text.index("getInputView") < text.index("recreateInputView"), text)
check("...and refreshes the height like the other settings that rebuild the view", "LatinIME;->refreshHeightNow()V" in text, text)
check("the block ends the method (the language needs nothing else)", bool(blk) and blk[-1] == "return-void", text)

# ---- it is done on the change, not on every opening
osv = method(ime, "onStartInputView(Landroid/view/inputmethod/EditorInfo;Z)V") or ""
check("opening the keyboard does not look at the language (no check on every open)", "pref_ui_language" not in osv and "UiLocale" not in osv)

# ---- the rebuild reaches the toolbar, and the toolbar is inflated in the language chosen
rec = method(sw, "recreateInputView()V") or ""
check("KeyboardSwitcher.recreateInputView makes the view again (forced)",
      "changeLatinKeyboardView(IZ)V" in rec and "const/4 v1, 0x1" in rec, rec)
setiv = method(ime, "setInputView(Landroid/view/View;)V") or ""
check("LatinIME.setInputView wraps the new view with the toolbar (MrTools.wrap)", "MrTools;->wrap(Lcom/mrkeyboard/app/LatinIME;Landroid/view/View;)Landroid/view/View;" in setiv)
wrap = method(tools, "wrap(Lcom/mrkeyboard/app/LatinIME;Landroid/view/View;)Landroid/view/View;") or ""
i_ctx = wrap.find("MrLocaleCtx;->of(")
i_inf = wrap.find("LayoutInflater;->inflate(")
check("MrTools.wrap inflates the toolbar with the context of MrLocaleCtx (the language chosen)", 0 <= i_ctx < i_inf, (i_ctx, i_inf))
check("the Settings screen recreates itself on the same key (its own texts)",
      re.search(r'const-string v0, "pref_ui_language".*?LatinIMESettings;->recreate\(\)V', settings, re.S) is not None)

# ---- the check itself: the same smali without the block must fail
without = re.sub(r'(?s)    const-string v0, "pref_ui_language"\n.*?    :cond_mr_langdone\n    return-void\n\n    :cond_mr_nolang\n', "", ime, count=1)
check("control: the smali without the block is noticed (no block found)", without != ime and language_block(without) is None)
no_rebuild = ime.replace("invoke-virtual {v0}, Lcom/mrkeyboard/app/KeyboardSwitcher;->recreateInputView()V\n\n    invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIME;->refreshHeightNow()V",
                         "invoke-direct {p0}, Lcom/mrkeyboard/app/LatinIME;->refreshHeightNow()V", 1)
nb = "\n".join(language_block(no_rebuild) or [])
check("control: the block without recreateInputView is noticed", no_rebuild != ime and "recreateInputView" not in nb)

print()
print(("ALL OK (%d checks)" % ok) if not fails else ("%d ok, %d FAILED" % (ok, fails)))
raise SystemExit(1 if fails else 0)
