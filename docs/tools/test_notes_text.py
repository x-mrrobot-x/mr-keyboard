#!/usr/bin/env python3
"""Tests the notes of the update dialog (MrNotesText.smali, the hand-written one) and the glue that puts them in the dialog.

Run it from the project root:  python3 -I docs/tools/test_notes_text.py

Runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework (strings, a SpannableStringBuilder that records the spans,
the span classes, a TextView with a context and resources). The same cases as the Java test (UpdateTest.notesStyled), and then:
  - every notes block of docs/release-notes (Portuguese and English) goes through the smali and through an independent reference written here from the
    rules of the class, and the text and every span must be the same (the real notes are the best corpus: items with and without label, **bold**,
    `code`, long sentences with a colon, "Como receber");
  - the rules of the screen (docs/release-notes are the data): each item starts with a bullet, the label is bold and has the color of its kind, there
    is a thin empty line between paragraphs, and the marks (** and `) are gone from the text;
  - MrUpdate$Notice.raw / notes (language of the notes) and MrUpdateDialog.fill (the notes in the dialog are the styled ones, the "no notes" text when
    there is none, the actions and the line "v1.98.0 · size · you're on...").
"""
import glob
import math
import os
import re
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
NOTES = "Lcom/mrkeyboard/app/MrNotesText;"
NOTICE = "Lcom/mrkeyboard/app/MrUpdate$Notice;"
DIALOG = "Lcom/mrkeyboard/app/MrUpdateDialog;"
FORMAT = "format(Ljava/lang/String;[II)Ljava/lang/CharSequence;"
KIND = "kindOf(Ljava/lang/String;)I"
LABEL = "labelEnd(Ljava/lang/String;)I"
COLORNAME = "colorName(I)Ljava/lang/String;"
FORVIEW = "forView(Landroid/widget/TextView;Ljava/lang/String;)Ljava/lang/CharSequence;"
FILL = "fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z"
BULLET = "• "
FLAGS = 33  # SPAN_EXCLUSIVE_EXCLUSIVE

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


JTRIM = "".join(chr(i) for i in range(33))   # String.trim() takes out everything up to the space


def jround(x):
    x = dm.fv(x)
    return 0 if math.isnan(x) else math.floor(x + 0.5)


class Host:
    """The fake framework. Strings are Python strings; a SpannableStringBuilder is an Obj with text and spans (what, start, end, flags)."""

    def __init__(self):
        self.char_w = 7.0                      # width of one character for measureText
        self.color_ids = {}                    # name of a color -> id (what getIdentifier answers; a missing one gives 0)
        self.package = "com.mrkeyboard.app"
        self.vms = {}                          # class -> VM, to call the classes whose smali is under test from another one
        self.log = []

    def vm(self, cls, smali):
        v = dm.VM(cls, dm.parse_methods(os.path.join(APP, smali)), self)
        self.vms[cls] = v
        return v

    # --- the host of the interpreter
    def new_instance(self, cls):
        return dm.Obj(cls)

    def sget(self, cls, name):
        if (cls, name) == ("Ljava/util/Locale;", "ROOT"):
            return "ROOT"
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def instance_of(self, obj, cls):
        return isinstance(obj, dm.Obj) and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        name = mem.split("(")[0]
        a = args
        if cls in self.vms and cls != vm.cls:            # a class under test called from another one
            return self.vms[cls].run(mem, a)
        if cls == "Ljava/lang/Object;" and name == "<init>":
            return None
        if cls == "Ljava/lang/String;":
            s = a[0]
            if name == "replace":
                return s.replace(a[1], a[2])
            if name == "split":                          # limit -1: the empty ones at the end stay
                assert a[2] == -1
                return s.split(a[1])
            if name == "trim":
                return s.strip(JTRIM)
            if name == "length":
                return len(s)
            if name == "startsWith":
                return 1 if s.startswith(a[1]) else 0
            if name == "substring":
                return s[a[1]:] if len(a) == 2 else s[a[1]:a[2]]
            if name == "indexOf":
                return s.find(a[1], a[2] if len(a) == 3 else 0)
            if name == "toLowerCase":
                assert a[1] == "ROOT"
                return s.lower()
            if name == "equals":
                return 1 if s == a[1] else 0
        if cls == "Ljava/lang/CharSequence;" and name == "length":
            return len(a[0].f["text"]) if isinstance(a[0], dm.Obj) else len(a[0])
        if cls == "Landroid/text/SpannableStringBuilder;":
            o = a[0]
            if name == "<init>":
                o.f["text"], o.f["spans"] = a[1], []
                return None
            if name == "append":
                o.f["text"] += a[1]
                return o
            if name == "length":
                return len(o.f["text"])
            if name == "setSpan":
                o.f["spans"].append((a[1], a[2], a[3], a[4]))
                return None
        if cls == "Landroid/text/style/ForegroundColorSpan;" and name == "<init>":
            a[0].f["color"] = a[1]
            return None
        if cls == "Landroid/text/style/StyleSpan;" and name == "<init>":
            a[0].f["style"] = a[1]
            return None
        if cls == "Landroid/text/style/RelativeSizeSpan;" and name == "<init>":
            a[0].f["proportion"] = dm.fv(a[1])
            return None
        if cls == "Landroid/text/style/LeadingMarginSpan$Standard;" and name == "<init>":
            a[0].f["first"], a[0].f["rest"] = a[1], a[2]
            return None
        # a text view with its context, resources and paint
        if cls == "Landroid/widget/TextView;":
            tv = a[0]
            if name == "getContext":
                return tv.f["context"]
            if name == "getPaint":
                return dm.Obj("Landroid/text/TextPaint;")
            if name == "setText":
                tv.f["shown"] = a[1]
                return None
        if cls == "Landroid/text/TextPaint;" and name == "measureText":
            return float(len(a[1])) * self.char_w
        if cls == "Landroid/content/Context;":
            if name == "getResources":
                return a[0].f["res"]
            if name == "getPackageName":
                return self.package
        if cls == "Landroid/content/res/Resources;":
            if name == "getIdentifier":
                assert a[2] == "color" and a[3] == self.package, a
                return self.color_ids.get(a[1], 0)
            if name == "getColor":
                return dm.i32(0xff000000 + a[1])
        if cls == "Ljava/lang/Math;" and name == "round":
            return jround(a[0])
        if cls == "Ljava/util/Locale;" and name == "getLanguage":
            return a[0].f["lang"]
        if cls == "Lcom/mrkeyboard/app/MrUpdate;":
            if name == "plain":
                return "plain(" + a[0] + ")"
            if name == "sizeText":
                return "%s MB" % a[0]
            if name == "appName":
                return "Mr Keyboard"
        if cls == "Lcom/mrkeyboard/app/MrPacks;" and name == "text":
            return "<%s%s>" % (a[1], ":" + ",".join(str(x) for x in a[2]) if a[2] else "")
        if cls == "Landroid/view/View;":
            if name == "findViewWithTag":
                return a[0].f["views"].get(a[1])
            if name == "setOnClickListener":
                a[0].f["click"] = a[1]
                return None
        if cls == "Landroid/app/Activity;":
            if name == "getResources":
                return a[0].f["res"]
        if cls == "Landroid/content/res/Resources;" and name == "getConfiguration":
            return a[0].f["conf"]
        if cls == "Lcom/mrkeyboard/app/MrUpdateDialog$Click;" and name == "<init>":
            a[0].f["what"] = a[3]
            return None
        raise AssertionError("not faked: %s %s" % (op, target))


H = Host()
VM = H.vm(NOTES, "MrNotesText.smali")
PAL = [0xff00aa01 - 2 ** 32, 0xff00aa02 - 2 ** 32, 0xff00aa03 - 2 ** 32, 0xff00aa04 - 2 ** 32, 0xff00aa05 - 2 ** 32]
NEW, IMP, FIX, HOW, OTH = PAL


def fmt(md, colors=None, indent=11):
    return VM.run(FORMAT, [md, PAL if colors is None else colors, indent])


def spans_of(sb, cls):
    """The spans of a class as (start, end, value): value is the color, the style, the proportion or the margin."""
    key = {"Landroid/text/style/ForegroundColorSpan;": "color", "Landroid/text/style/StyleSpan;": "style",
           "Landroid/text/style/RelativeSizeSpan;": "proportion", "Landroid/text/style/LeadingMarginSpan$Standard;": "rest"}[cls]
    return [(s, e, w.f[key]) for (w, s, e, fl) in sb.f["spans"] if w.cls == cls]


FG = "Landroid/text/style/ForegroundColorSpan;"
ST = "Landroid/text/style/StyleSpan;"
RS = "Landroid/text/style/RelativeSizeSpan;"
LM = "Landroid/text/style/LeadingMarginSpan$Standard;"


# ------------------------------------------------------------------ the reference: the rules of the class, written again from the description
def ref_kind(label):
    s = label.lower()
    for words, kind in ((("novo", "new"), 0), (("melhor", "improv"), 1), (("corrig", "corre", "fix"), 2), (("como receber", "how to get"), 3)):
        if s.startswith(words):
            return kind
    return 4


def ref_label(text):
    i = text.find(": ")
    return i + 1 if 0 < i <= 32 else 0


def ref_format(md, colors, indent):
    text, spans = "", []
    for line in md.replace("\r\n", "\n").split("\n"):
        t = line.replace("`", "").strip(JTRIM)
        if not t:
            continue
        item = t.startswith("- ") or t.startswith("* ")
        if item:
            t = t[2:]
        if text:
            text += "\n\n"
            spans.append((RS, len(text) - 1, len(text), 0.5))
        start = len(text)
        if item:
            text += BULLET
        body = len(text)
        for n, part in enumerate(t.split("**")):          # the odd parts are between two marks: bold (an odd mark makes the rest bold)
            frm = len(text)
            text += part
            if n % 2 == 1 and len(text) > frm:
                spans.append((ST, frm, len(text), 1))
        if item:
            clean = t.replace("**", "")
            lab = ref_label(clean)
            color = colors[ref_kind(clean[:lab - 1]) if lab > 0 else 4]
            spans.append((LM, start, len(text), indent))
            spans.append((FG, start, body + lab, color))
            if lab > 0:
                spans.append((ST, body, body + lab, 1))
    return text, spans


def dump(sb):
    return sb.f["text"], [(w.cls, s, e, w.f.get({FG: "color", ST: "style", RS: "proportion", LM: "rest"}[w.cls])) for (w, s, e, fl) in sb.f["spans"]]


# ------------------------------------------------------------------ the kinds and the labels
def kind(label):
    return VM.run(KIND, [label])


check("kind: new, in both languages, in any case, with a note after it",
      all(kind(x) == 0 for x in ("Novo", "New", "NOVO", "Novo (experimental)", "New in the packs", "Novo nos pacotes")))
check("kind: improved", kind("Melhorado") == 1 and kind("Improved") == 1)
check("kind: fixed (Corrigido, Correções, Fixed, Fixes)", all(kind(x) == 2 for x in ("Corrigido", "Correções", "Fixed", "Fixes")))
check("kind: how to get it", kind("Como receber") == 3 and kind("How to get it") == 3)
check("kind: anything else is other", all(kind(x) == 4 for x in ("Observações", "Notes", "Under the hood", "Privacidade", "")))
label = lambda s: VM.run(LABEL, [s])  # noqa: E731
check("label: ends after the colon; none without ': ', at the start or past 32 characters",
      label("Novo: texto") == 5 and label("sem rótulo") == 0 and label(": texto") == 0 and label("12:30 hoje") == 0
      and label("Mesmo conteúdo, mesmas sugestões: os pacotes") == 33 and label("Mesmo conteúdo, mesmas sugestões novas: os pacotes") == 0)
check("color names: one palette color for each kind",
      [VM.run(COLORNAME, [k]) for k in range(5)] == ["mr_ui_mint", "mr_ui_blue", "mr_ui_amber", "mr_ui_violet", "mr_ui_slate"])

# ------------------------------------------------------------------ the same cases as the Java test
f = fmt("- Novo: **Mostrar** ferramentas.\r\n* Corrigido: x `y`.\n\n\nTexto solto.\n- Sem rótulo, mas com vírgula.\n")
t = f.f["text"]
check("styled: the text (bullets, no marks, a blank line between paragraphs, a loose line with no bullet)",
      t == "• Novo: Mostrar ferramentas.\n\n• Corrigido: x y.\n\nTexto solto.\n\n• Sem rótulo, mas com vírgula.", repr(t))
a, b, c, d, m = t.index("• Novo"), t.index("• Corrigido"), t.index("Texto solto"), t.index("• Sem"), t.index("Mostrar")
check("styled: the bullet and the label take the color of the kind, an item with no label only the bullet, a loose line none",
      spans_of(f, FG) == [(a, a + 7, NEW), (b, b + 12, FIX), (d, d + 2, OTH)], spans_of(f, FG))
check("styled: bold on the label (not on the bullet) and on the **bold** of the text, nowhere else",
      spans_of(f, ST) == [(m, m + 7, 1), (a + 2, a + 7, 1), (b + 2, b + 12, 1)], spans_of(f, ST))
check("styled: hanging indent on every item (first line 0, the rest as wide as the bullet), over the whole paragraph",
      spans_of(f, LM) == [(a, b - 2, 11), (b, c - 2, 11), (d, len(t), 11)], spans_of(f, LM))
check("styled: the second line break of each gap is a thin line (3 gaps, half height)",
      spans_of(f, RS) == [(b - 1, b, 0.5), (c - 1, c, 0.5), (d - 1, d, 0.5)], spans_of(f, RS))
check("styled: the margins span has first = 0",
      all(w.f["first"] == 0 for (w, s, e, fl) in f.f["spans"] if w.cls == LM))
check("styled: every span is exclusive-exclusive", all(fl == FLAGS for (w, s, e, fl) in f.f["spans"]))
g = fmt("- Melhorado: a\n- Como receber: b\n- Observações: c\n- Resultado medido no PC, em mensagens reais: sim\n- Fixed: d", indent=0)
gc = spans_of(g, FG)
check("styled: each kind has its color (improved, how to get it, other, a long sentence with a colon is no label, fixed)",
      [x[2] for x in gc] == [IMP, HOW, OTH, OTH, FIX] and gc[3][1] - gc[3][0] == 2, gc)
h = fmt("- Novo: a **b", indent=0)
check("styled: a ** that is never closed makes the rest bold, with no mark left",
      h.f["text"] == "• Novo: a b" and spans_of(h, ST) == [(len(h.f["text"]) - 1, len(h.f["text"]), 1), (2, 7, 1)], dump(h))
check("styled: null and blank text give an empty text, no exception", fmt(None).f["text"] == "" and fmt(" \r\n\n  \n").f["text"] == "")
check("styled: a single paragraph has no gap before it", spans_of(fmt("- Novo: a"), RS) == [])

# ------------------------------------------------------------------ the real notes
files = sorted(glob.glob(os.path.join(ROOT, "docs", "release-notes", "*.md")))
blocks = []
for fn in files:
    txt = open(fn, encoding="utf-8").read().replace("\r\n", "\n")
    parts = re.split(r"^\*\*(Português|English)\*\*$", txt, flags=re.M)
    for i in range(1, len(parts), 2):
        blocks.append((os.path.basename(fn) + " " + parts[i], parts[i + 1].strip()))
check("real notes: there are blocks to test", len(blocks) >= 20, len(blocks))
bad = []
for name, md in blocks:
    got = dump(fmt(md, indent=13))
    want = ref_format(md, PAL, 13)
    want = (want[0], [(w, s, e, v) for (w, s, e, v) in want[1]])
    if got != want:
        bad.append(name)
check("real notes: the smali gives the same text and the same spans as the reference, for every block of docs/release-notes (%d)" % len(blocks),
      not bad, bad[:5])
marks = [name for name, md in blocks if "**" in dump(fmt(md))[0] or "`" in dump(fmt(md))[0]]
check("real notes: no ** and no ` is left in any text", not marks, marks[:5])
items = sum(len(re.findall(r"^[-*] ", md, flags=re.M)) for name, md in blocks)
bullets = sum(dump(fmt(md))[0].count(BULLET) for name, md in blocks)
check("real notes: every item has its bullet", items == bullets, (items, bullets))
labeled = {"novo", "new", "melhorado", "improved", "corrigido", "fixed", "como receber", "how to get it"}
firsts = []
for name, md in blocks:
    for ln in md.split("\n"):
        mm = re.match(r"^[-*] ([^:]{1,32}): ", ln.replace("**", ""))
        if mm and mm.group(1).lower() in labeled:
            firsts.append((name, mm.group(1)))
check("real notes: there are labels of the four kinds to look at", len(firsts) > 50, len(firsts))
colorsok = True
for name, md in blocks:
    sb = fmt(md)
    txt = sb.f["text"]
    for (s, e, col) in spans_of(sb, FG):
        word = txt[s + 2:e - 1] if e > s + 2 else ""
        want = {"novo": NEW, "new": NEW, "melhorado": IMP, "improved": IMP, "corrigido": FIX, "fixed": FIX, "como receber": HOW, "how to get it": HOW}.get(word.lower())
        if want is not None and col != want:
            colorsok = False
check("real notes: the labels Novo/New, Melhorado/Improved, Corrigido/Fixed and Como receber/How to get it get their own color", colorsok)

# ------------------------------------------------------------------ the glue: colors from the resources, the indent from the bullet
tv = dm.Obj("Landroid/widget/TextView;", context=dm.Obj("Landroid/content/Context;", res=dm.Obj("Landroid/content/res/Resources;")))
H.color_ids = {"mr_ui_mint": 1, "mr_ui_blue": 2, "mr_ui_amber": 3, "mr_ui_violet": 4}      # mr_ui_slate is missing: white
H.char_w = 6.0
v = VM.run(FORVIEW, [tv, "- Novo: a\n- Corrigido: b\n- Notes: c"])
vc = [x[2] for x in spans_of(v, FG)]
check("for a view: the colors come by name from the resources, white when one is missing",
      vc == [dm.i32(0xff000001), dm.i32(0xff000003), -1], vc)
check("for a view: the indent is the width of the bullet and the space in the paint of the view", [x[2] for x in spans_of(v, LM)] == [12, 12, 12])
H.char_w = 6.4
check("for a view: the indent is rounded (2 characters of 6.4 -> 13)", [x[2] for x in spans_of(VM.run(FORVIEW, [tv, "- a"]), LM)] == [13])

# ------------------------------------------------------------------ the notice and the dialog
NVM = H.vm(NOTICE, "MrUpdate$Notice.smali")
pt, en, es = dm.Obj("Ljava/util/Locale;", lang="pt"), dm.Obj("Ljava/util/Locale;", lang="en"), dm.Obj("Ljava/util/Locale;", lang="es")
RAW = "raw(Ljava/util/Locale;)Ljava/lang/String;"
NOTES_M = "notes(Ljava/util/Locale;)Ljava/lang/String;"
both = dm.Obj(NOTICE, notesPt="- Novo: texto", notesEn="- New: text")
only_en = dm.Obj(NOTICE, notesPt=None, notesEn="- New: text")
check("Notice.raw: Portuguese for pt, English for the rest and for no language, English when there is no Portuguese",
      NVM.run(RAW, [both, pt]) == "- Novo: texto" and NVM.run(RAW, [both, en]) == "- New: text" and NVM.run(RAW, [both, es]) == "- New: text"
      and NVM.run(RAW, [both, None]) == "- New: text" and NVM.run(RAW, [only_en, pt]) == "- New: text")
check("Notice.notes: still the plain text of the notes of the language", NVM.run(NOTES_M, [both, pt]) == "plain(- Novo: texto)"
      and NVM.run(NOTES_M, [both, en]) == "plain(- New: text)")

DVM = H.vm(DIALOG, "MrUpdateDialog.smali")


def make_dialog(notes_pt, notes_en="- New: text", lang="pt", missing=None):
    tags = ["upd_title", "upd_sub", "upd_notes", "upd_scroll", "upd_box", "upd_status", "upd_bar", "upd_error", "upd_install", "upd_github", "upd_later"]
    views = {k: dm.Obj("Landroid/widget/TextView;", context=tv.f["context"]) for k in tags if k != missing}
    root = dm.Obj("Landroid/view/View;", views=views)
    act = dm.Obj("Landroid/app/Activity;", res=dm.Obj("Landroid/content/res/Resources;", conf=dm.Obj("Landroid/content/res/Configuration;",
                 locale=dm.Obj("Ljava/util/Locale;", lang=lang))))
    n = dm.Obj(NOTICE, versionName="v1.98.0", apkSize=2300000, notesPt=notes_pt, notesEn=notes_en)
    return act, root, n, views


H.color_ids = {"mr_ui_mint": 1, "mr_ui_blue": 2, "mr_ui_amber": 3, "mr_ui_violet": 4}
H.char_w = 6.0
act, root, n, views = make_dialog("- Novo: **busca** nova.\n- Corrigido: algo.")
r = DVM.run(FILL, [act, root, n])
shown = views["upd_notes"].f.get("shown")
check("dialog: fill answers true and the notes are the styled text of the language (Portuguese)", r == 1 and isinstance(shown, dm.Obj)
      and shown.f["text"] == "• Novo: busca nova.\n\n• Corrigido: algo." and spans_of(shown, FG)[0][2] == dm.i32(0xff000001), shown)
check("dialog: the line under the title has the version, the size and the app", views["upd_sub"].f.get("shown") == "<mr_update_sub:v1.98.0,2300000 MB,Mr Keyboard>",
      views["upd_sub"].f.get("shown"))
check("dialog: the three actions are connected (install 1, GitHub 2, not now 3)",
      [views[k].f["click"].f["what"] for k in ("upd_install", "upd_github", "upd_later")] == [1, 2, 3])
act, root, n, views = make_dialog(None, "- Fixed: x", lang="en")
check("dialog: in English the notes are the English ones", DVM.run(FILL, [act, root, n]) == 1 and views["upd_notes"].f["shown"].f["text"] == "• Fixed: x")
act, root, n, views = make_dialog("  \n \n", "- New: text", lang="pt")
check("dialog: notes with nothing in them show the 'no notes' text", DVM.run(FILL, [act, root, n]) == 1 and views["upd_notes"].f["shown"] == "<mr_update_notes_none>",
      views["upd_notes"].f.get("shown"))
act, root, n, views = make_dialog("- Novo: a", missing="upd_notes")
check("dialog: a layout without the notes view is refused (false)", DVM.run(FILL, [act, root, n]) == 0)

# ------------------------------------------------------------------ what is around
src = open(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrNotesText.java"), encoding="utf-8").read()
colors_xml = open(os.path.join(ROOT, "res", "values", "mr_colors.xml"), encoding="utf-8").read()
check("the five palette colors that the notes use exist in mr_colors.xml",
      all('name="%s"' % c in colors_xml for c in ("mr_ui_mint", "mr_ui_blue", "mr_ui_amber", "mr_ui_violet", "mr_ui_slate")))
check("the Java source and the smali have the same kinds (constants), the same limit and the same gap",
      all(re.search(r"static final int %s = %d;" % (k, v), src) for k, v in (("NEW", 0), ("IMPROVED", 1), ("FIXED", 2), ("HOW", 3), ("OTHER", 4), ("KINDS", 5)))
      and "LABEL_MAX = 32" in src and "GAP = 0.5f" in src
      and ".field static final KINDS:I = 0x5" in open(os.path.join(APP, "MrNotesText.smali"), encoding="utf-8").read())
check("the layout still has the notes view that the dialog looks for", 'android:tag="upd_notes"' in open(os.path.join(ROOT, "res", "layout", "mr_update_dialog.xml"), encoding="utf-8").read())

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
