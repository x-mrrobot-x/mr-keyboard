#!/usr/bin/env python3
"""Tests the notes of the update dialog and of the "Version" dialog (MrNotesText.smali, MrVersion.smali, MrUpdateDialog.smali) and the glue.

Run it from the project root:  python3 -I docs/tools/test_notes_text.py

Runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework (strings, a SpannableStringBuilder that records the spans, the
span classes, a TextView and a LinearLayout that record what they are given, resources). The same cases as the Java test (UpdateTest.notesCards), and then:
  - every notes block of docs/release-notes (Portuguese and English) goes through the smali and through an independent reference written here from the
    rules of the class, and the items, the text and every span must be the same (the real notes are the best corpus: items with and without label,
    **bold**, `code`, long sentences with a colon, "Como receber");
  - the rules of the screen (docs/release-notes are the data): one card for each item, no bullet, no ** and no ` left, the label bold and white, the
    rest in the softer color, the same faint card for all (no color by kind), a gap between the cards and none before the first one;
  - MrUpdate$Notice.raw / notes (language of the notes) and MrUpdateDialog.fill (one card for each item of the notes of the language, the "no notes"
    text when there is none, the actions and the line "v1.98.0 · size · you're on...");
  - MrVersion (the "Version" line of Settings, v2.0.0): block (the Portuguese and the English block of the notes, the same rule as make_update.py), notes
    (Portuguese for pt, English for the rest), summary and fill (the dialog of the version: title, line, cards, only the Close button).
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
VERSION = "Lcom/mrkeyboard/app/MrVersion;"
FORMAT = "format(Ljava/lang/String;I)Ljava/lang/CharSequence;"
ITEMS = "items(Ljava/lang/String;)Ljava/util/List;"
LABEL = "labelEnd(Ljava/lang/String;)I"
FILLC = "fill(Landroid/widget/LinearLayout;Ljava/lang/String;Ljava/lang/String;)I"
FILL = "fill(Landroid/app/Activity;Landroid/view/View;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z"
VFILL = "fill(Landroid/app/Activity;Landroid/view/View;)Z"
BLOCK = "block(Ljava/lang/String;Z)Ljava/lang/String;"
VNOTES = "notes(Landroid/content/Context;Ljava/util/Locale;)Ljava/lang/String;"
VSUMMARY = "summary(Landroid/content/Context;)Ljava/lang/String;"
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
    """The fake framework. Strings are Python strings; a SpannableStringBuilder is an Obj with text and spans (what, start, end, flags);
    a LinearLayout keeps its children as (view, layout params)."""

    def __init__(self):
        self.ids = {}                          # (type, name) -> id (what getIdentifier answers; a missing one gives 0)
        self.package = "com.mrkeyboard.app"
        self.vms = {}                          # class -> VM, to call the classes whose smali is under test from another one
        self.asset = None                      # what MrVersion.readAsset gives (None = no asset)
        self.hint_missing = False              # MrPacks.text answers null
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
        if cls == VERSION and name == "readAsset":
            return self.asset
        if cls in self.vms and cls != vm.cls:            # a class under test called from another one
            return self.vms[cls].run(mem, a)
        if name == "<init>" and cls in ("Ljava/lang/Object;",):
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
            if name == "equals":
                return 1 if s == a[1] else 0
            if name == "isEmpty":
                return 1 if not s else 0
        if cls == "Ljava/lang/StringBuilder;":
            o = a[0]
            if name == "<init>":
                o.f["text"] = ""
                return None
            if name == "append":
                o.f["text"] += chr(a[1]) if isinstance(a[1], int) else a[1]
                return o
            if name == "length":
                return len(o.f["text"])
            if name == "toString":
                return o.f["text"]
        if cls == "Ljava/lang/CharSequence;" and name == "length":
            return len(a[0].f["text"]) if isinstance(a[0], dm.Obj) else len(a[0])
        if cls in ("Ljava/util/ArrayList;", "Ljava/util/List;"):
            o = a[0]
            if name == "<init>":
                o.f["l"] = []
                return None
            if name == "add":
                o.f["l"].append(a[1])
                return 1
            if name == "isEmpty":
                return 0 if o.f["l"] else 1
            if name == "size":
                return len(o.f["l"])
            if name == "get":
                return o.f["l"][a[1]]
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
        # views: a text view and a linear layout record what they are given
        if cls == "Landroid/widget/TextView;" and name == "<init>":
            a[0].f["context"] = a[1]
            return None
        if cls in ("Landroid/widget/TextView;", "Landroid/widget/LinearLayout;", "Landroid/view/View;"):
            v = a[0]
            if name == "getContext":
                return v.f["context"]
            if name == "setText":
                v.f["shown"] = a[1]
                return None
            if name == "setTextSize":
                v.f["size"] = dm.fv(a[1])
                return None
            if name == "setTextColor":
                v.f["color"] = a[1]
                return None
            if name == "setLineSpacing":
                v.f["spacing"] = (dm.fv(a[1]), dm.fv(a[2]))
                return None
            if name == "setPadding":
                v.f["pad"] = tuple(a[1:5])
                return None
            if name == "setBackgroundResource":
                v.f["bg"] = a[1]
                return None
            if name == "setVisibility":
                v.f["visibility"] = a[1]
                return None
            if name == "removeAllViews":
                v.f["children"] = []
                return None
            if name == "addView":
                v.f.setdefault("children", []).append((a[1], a[2]))
                return None
            if name == "findViewWithTag":
                return v.f["views"].get(a[1])
            if name == "setOnClickListener":
                v.f["click"] = a[1]
                return None
        if cls == "Landroid/widget/LinearLayout$LayoutParams;":
            if name == "<init>":
                a[0].f["w"], a[0].f["h"], a[0].f["margins"] = a[1], a[2], (0, 0, 0, 0)
                return None
            if name == "setMargins":
                a[0].f["margins"] = tuple(a[1:5])
                return None
        if cls == "Landroid/content/Context;":
            if name == "getResources":
                return a[0].f["res"]
            if name == "getPackageName":
                return self.package
        if cls == "Landroid/content/res/Resources;":
            if name == "getIdentifier":
                assert a[3] == self.package, a
                return self.ids.get((a[2], a[1]), 0)
            if name == "getColor":
                return dm.i32(0xff000000 + a[1])
            if name == "getDisplayMetrics":
                return a[0].f.get("dm")
            if name == "getConfiguration":
                return a[0].f["conf"]
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
                return "v1.99.0"
        if cls == "Lcom/mrkeyboard/app/MrPacks;" and name == "text":
            if self.hint_missing:
                return None
            return "<%s%s>" % (a[1], ":" + ",".join(str(x) for x in a[2]) if a[2] else "")
        if cls == "Landroid/app/Activity;":
            if name == "getResources":
                return a[0].f["res"]
        if cls == "Lcom/mrkeyboard/app/MrUpdateDialog$Click;" and name == "<init>":
            a[0].f["what"] = a[3]
            return None
        if cls == "Lcom/mrkeyboard/app/MrVersion$1;" and name == "<init>":
            return None
        raise AssertionError("not faked: %s %s" % (op, target))


H = Host()
VM = H.vm(NOTES, "MrNotesText.smali")
WHITE, SOFT = dm.i32(0xff00aa01), dm.i32(0xff00aa02)    # what the resources give for mr_ui_text and mr_ui_text2
LABELC = dm.i32(0xff112233)

FG = "Landroid/text/style/ForegroundColorSpan;"
ST = "Landroid/text/style/StyleSpan;"


def fmt(item, color=LABELC):
    return VM.run(FORMAT, [item, color])


def spans_of(sb, cls):
    """The spans of a class as (start, end, value): value is the color or the style."""
    key = {FG: "color", ST: "style"}[cls]
    return [(s, e, w.f[key]) for (w, s, e, fl) in sb.f["spans"] if w.cls == cls]


def dump(sb):
    return sb.f["text"], [(w.cls, s, e, w.f.get({FG: "color", ST: "style"}[w.cls])) for (w, s, e, fl) in sb.f["spans"]]


def items_of(md):
    return VM.run(ITEMS, [md]).f["l"]


# ------------------------------------------------------------------ the reference: the rules of the class, written again from the description
def ref_label(text):
    i = text.find(": ")
    return i + 1 if 0 < i <= 32 else 0


def ref_items(md):
    out = []
    for line in md.replace("\r\n", "\n").split("\n"):
        t = line.replace("`", "").strip(JTRIM)
        if t.startswith("- ") or t.startswith("* "):
            t = t[2:].strip(JTRIM)
        if t and t not in ("-", "*"):
            out.append(t)
    return out


def ref_format(item, color):
    text, spans = "", []
    for n, part in enumerate(item.split("**")):          # the odd parts are between two marks: bold (an odd mark makes the rest bold)
        frm = len(text)
        text += part
        if n % 2 == 1 and len(text) > frm:
            spans.append((ST, frm, len(text), 1))
    lab = ref_label(item.replace("**", ""))
    if lab > 0:
        spans.append((FG, 0, lab, color))
        spans.append((ST, 0, lab, 1))
    return text, spans


# ------------------------------------------------------------------ the label and the items
label = lambda s: VM.run(LABEL, [s])  # noqa: E731
check("label: ends after the colon; none without ': ', at the start or past 32 characters",
      label("Novo: texto") == 5 and label("sem rótulo") == 0 and label(": texto") == 0 and label("12:30 hoje") == 0
      and label("Mesmo conteúdo, mesmas sugestões: os pacotes") == 33 and label("Mesmo conteúdo, mesmas sugestões novas: os pacotes") == 0)
check("label: the limit is exactly 32 characters before the colon (32 is a label, 33 is not)",
      label("a" * 32 + ": x") == 33 and label("a" * 33 + ": x") == 0 and label("a" * 31 + ": x") == 32)
check("items: one for each non-empty line, the '- ' and '* ' of a list item and the ` marks taken out, ** kept, CRLF accepted",
      items_of("- Novo: **Mostrar** ferramentas.\r\n* Corrigido: x `y`.\n\n\nTexto solto.\n- Sem rótulo, mas com vírgula.\n")
      == ["Novo: **Mostrar** ferramentas.", "Corrigido: x y.", "Texto solto.", "Sem rótulo, mas com vírgula."],
      items_of("- Novo: **Mostrar** ferramentas.\r\n* Corrigido: x `y`.\n\n\nTexto solto.\n- Sem rótulo, mas com vírgula.\n"))
check("items: null, blank text and lines with only a '- ' give no item",
      items_of(None) == [] and items_of(" \r\n\n  \n") == [] and items_of("-\n- \n*  \n") == [], items_of("-\n- \n*  \n"))
check("items: a line is trimmed, and a dash in the middle or a '-x' with no space is not a list mark",
      items_of("   - A coisa: ok   \n-x\nde-a-b") == ["A coisa: ok", "-x", "de-a-b"], items_of("   - A coisa: ok   \n-x\nde-a-b"))

# ------------------------------------------------------------------ one item as styled text
f = fmt("Novo: **Mostrar** ferramentas.")
check("format: no mark left in the text", f.f["text"] == "Novo: Mostrar ferramentas.", f.f["text"])
check("format: the label (with its colon) is bold and has the label color; the **bold** part is bold; nothing else",
      spans_of(f, ST) == [(6, 13, 1), (0, 5, 1)] and spans_of(f, FG) == [(0, 5, LABELC)], dump(f))
check("format: every span is exclusive-exclusive", all(fl == FLAGS for (w, s, e, fl) in f.f["spans"]))
g = fmt("Sem rótulo, mas com vírgula.")
check("format: an item with no label has no span at all", g.f["text"] == "Sem rótulo, mas com vírgula." and g.f["spans"] == [])
h = fmt("Novo: a **b")
check("format: a ** that is never closed makes the rest bold, with no mark left",
      h.f["text"] == "Novo: a b" and spans_of(h, ST) == [(8, 9, 1), (0, 5, 1)], dump(h))
k = fmt("Resultado medido no PC, em mensagens reais: sim")
check("format: a long sentence with a colon is no label", k.f["spans"] == [])
m = fmt("**Novo:** texto")
check("format: a label written in bold has its marks dropped and is bold and colored once over the label",
      m.f["text"] == "Novo: texto" and spans_of(m, FG) == [(0, 5, LABELC)] and (0, 5, 1) in spans_of(m, ST), dump(m))
check("format: null gives an empty text, no exception", fmt(None).f["text"] == "" and fmt("").f["text"] == "")

# ------------------------------------------------------------------ the real notes
files = sorted(glob.glob(os.path.join(ROOT, "docs", "release-notes", "*.md")))
blocks = []
for fn in files:
    txt = open(fn, encoding="utf-8").read().replace("\r\n", "\n")
    parts = re.split(r"^\*\*(Português|English)\*\*$", txt, flags=re.M)
    for i in range(1, len(parts), 2):
        blocks.append((os.path.basename(fn) + " " + parts[i], parts[i + 1].strip()))
check("real notes: there are blocks to test", len(blocks) >= 20, len(blocks))
bad_items, bad_fmt, marks, labels_seen = [], [], [], 0
for name, md in blocks:
    got = items_of(md)
    want = ref_items(md)
    if got != want:
        bad_items.append(name)
        continue
    for it in got:
        sb = fmt(it)
        if dump(sb) != (lambda r: (r[0], [(w, s, e, v) for (w, s, e, v) in r[1]]))(ref_format(it, LABELC)):
            bad_fmt.append(name)
        if "**" in sb.f["text"] or "`" in sb.f["text"]:
            marks.append(name)
        labels_seen += 1 if spans_of(sb, FG) else 0
check("real notes: the smali gives the same items as the reference, for every block of docs/release-notes (%d)" % len(blocks), not bad_items, bad_items[:5])
check("real notes: the smali gives the same text and the same spans as the reference for every item", not bad_fmt, bad_fmt[:5])
check("real notes: no ** and no ` is left in any text", not marks, marks[:5])
check("real notes: there are many labeled items to look at", labels_seen > 100, labels_seen)
n_lines = sum(len(re.findall(r"^[-*] ", md, flags=re.M)) for name, md in blocks)
n_items = sum(len(items_of(md)) for name, md in blocks)
check("real notes: every '- ' line is an item and no line is lost (plain lines are items too)", n_items >= n_lines, (n_items, n_lines))

# ------------------------------------------------------------------ the cards: the glue with the resources
H.ids = {("color", "mr_ui_text2"): 2, ("color", "mr_ui_text"): 1, ("drawable", "mr_ui_note_card"): 77}


def make_box(density=2.0, dm_missing=False):
    res = dm.Obj("Landroid/content/res/Resources;", dm=None if dm_missing else dm.Obj("Landroid/util/DisplayMetrics;", density=density))
    ctx = dm.Obj("Landroid/content/Context;", res=res)
    return dm.Obj("Landroid/widget/LinearLayout;", context=ctx, children=[dm.Obj("Landroid/widget/TextView;"), dm.Obj("Landroid/widget/TextView;")])


box = make_box()
n = VM.run(FILLC, [box, "- Novo: **a** b\n- Corrigido: c\n\nTexto solto.", "none"])
cards = box.f["children"]
check("cards: one for each item, and the old children are gone", n == 3 and len(cards) == 3 and all(tv.cls == "Landroid/widget/TextView;" and not tv.f.get("children") for tv, lp in cards))
check("cards: the text of each (no bullet, no mark)", [tv.f["shown"].f["text"] for tv, lp in cards] == ["Novo: a b", "Corrigido: c", "Texto solto."],
      [tv.f["shown"].f["text"] for tv, lp in cards])
check("cards: the same faint card for all of them (no color by kind)", [tv.f["bg"] for tv, lp in cards] == [77, 77, 77])
check("cards: soft text color, white bold label", all(tv.f["color"] == dm.i32(0xff000002) for tv, lp in cards)
      and [spans_of(tv.f["shown"], FG) for tv, lp in cards][:2] == [[(0, 5, dm.i32(0xff000001))], [(0, 10, dm.i32(0xff000001))]]
      and spans_of(cards[2][0].f["shown"], FG) == [])
check("cards: 14 sp, line spacing 3 dp (6 px at density 2) and padding 12 dp / 10 dp (24 and 20 px)",
      all(tv.f["size"] == 14.0 and tv.f["spacing"] == (6.0, 1.0) and tv.f["pad"] == (24, 20, 24, 20) for tv, lp in cards),
      [(tv.f["size"], tv.f["spacing"], tv.f["pad"]) for tv, lp in cards])
check("cards: full width, height by the text; a gap of 8 dp (16 px) between the cards and none before the first",
      all(lp.f["w"] == -1 and lp.f["h"] == -2 for tv, lp in cards) and [lp.f["margins"] for tv, lp in cards] == [(0, 0, 0, 0), (0, 16, 0, 0), (0, 16, 0, 0)],
      [lp.f["margins"] for tv, lp in cards])
box = make_box(density=3.0)
VM.run(FILLC, [box, "- a\n- b", None])
check("cards: the sizes follow the density of the screen (3.0: gap 24, padding 36 / 30, spacing 9)",
      box.f["children"][1][1].f["margins"] == (0, 24, 0, 0) and box.f["children"][0][0].f["pad"] == (36, 30, 36, 30) and box.f["children"][0][0].f["spacing"] == (9.0, 1.0))
box = make_box(density=0.5)
VM.run(FILLC, [box, "- a\n- b", None])
check("cards: a screen with a density below 1 (0.5) is followed too (gap 4, padding 6 / 5, spacing 2)",
      box.f["children"][1][1].f["margins"] == (0, 4, 0, 0) and box.f["children"][0][0].f["pad"] == (6, 5, 6, 5) and box.f["children"][0][0].f["spacing"] == (2.0, 1.0),
      box.f["children"][0][0].f["pad"])
box = make_box(density=0.0)
VM.run(FILLC, [box, "- a\n- b", None])
check("cards: a density of 0 (a broken screen) counts as 1", box.f["children"][1][1].f["margins"] == (0, 8, 0, 0))
box = make_box(dm_missing=True)
VM.run(FILLC, [box, "- a\n- b", None])
check("cards: with no display metrics the density is 1", box.f["children"][1][1].f["margins"] == (0, 8, 0, 0))
box = make_box()
check("cards: no notes and a 'none' text: that text is the only card", VM.run(FILLC, [box, " \n", "Sem notas."]) == 1
      and [tv.f["shown"].f["text"] for tv, lp in box.f["children"]] == ["Sem notas."])
box = make_box()
check("cards: no notes and no 'none' text (null or empty): the box is left empty", VM.run(FILLC, [box, None, None]) == 0 and box.f["children"] == []
      and VM.run(FILLC, [box, "", ""]) == 0 and box.f["children"] == [])
H.ids = {("color", "mr_ui_text2"): 2}      # the drawable and one color are missing: no background, white label
box = make_box()
VM.run(FILLC, [box, "- Novo: a", None])
tv0 = box.f["children"][0][0]
check("cards: with the drawable and a color missing there is no background call and the label is white (-1)",
      "bg" not in tv0.f and spans_of(tv0.f["shown"], FG) == [(0, 5, -1)], tv0.f)
H.ids = {("color", "mr_ui_text2"): 2, ("color", "mr_ui_text"): 1, ("drawable", "mr_ui_note_card"): 77}

# ------------------------------------------------------------------ the notice and the update dialog
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


def make_dialog(notes_pt, notes_en="- New: text", lang="pt", missing=None, notes_is_text=False):
    tags = ["upd_title", "upd_sub", "upd_notes", "upd_scroll", "upd_box", "upd_status", "upd_bar", "upd_error", "upd_install", "upd_github", "upd_later"]
    ctx = make_box().f["context"]
    views = {k: dm.Obj("Landroid/widget/TextView;", context=ctx) for k in tags if k != missing}
    if not notes_is_text and missing != "upd_notes":
        views["upd_notes"] = dm.Obj("Landroid/widget/LinearLayout;", context=ctx)
    root = dm.Obj("Landroid/view/View;", views=views)
    act = dm.Obj("Landroid/app/Activity;", res=dm.Obj("Landroid/content/res/Resources;", conf=dm.Obj("Landroid/content/res/Configuration;",
                 locale=dm.Obj("Ljava/util/Locale;", lang=lang))))
    n = dm.Obj(NOTICE, versionName="v1.98.0", apkSize=2300000, notesPt=notes_pt, notesEn=notes_en)
    return act, root, n, views


def card_texts(view):
    return [tv.f["shown"].f["text"] if isinstance(tv.f["shown"], dm.Obj) else tv.f["shown"] for tv, lp in view.f["children"]]


act, root, n, views = make_dialog("- Novo: **busca** nova.\n- Corrigido: algo.")
r = DVM.run(FILL, [act, root, n])
check("dialog: fill answers true and the notes are one card for each item, in the language (Portuguese)",
      r == 1 and card_texts(views["upd_notes"]) == ["Novo: busca nova.", "Corrigido: algo."], card_texts(views["upd_notes"]))
check("dialog: the line under the title has the version, the size and the app", views["upd_sub"].f.get("shown") == "<mr_update_sub:v1.98.0,2300000 MB,v1.99.0>",
      views["upd_sub"].f.get("shown"))
check("dialog: the three actions are connected (install 1, GitHub 2, not now 3)",
      [views[k].f["click"].f["what"] for k in ("upd_install", "upd_github", "upd_later")] == [1, 2, 3])
act, root, n, views = make_dialog(None, "- Fixed: x", lang="en")
check("dialog: in English the notes are the English ones", DVM.run(FILL, [act, root, n]) == 1 and card_texts(views["upd_notes"]) == ["Fixed: x"])
act, root, n, views = make_dialog("  \n \n", "- New: text", lang="pt")
check("dialog: notes with nothing in them show the 'no notes' text as the only card", DVM.run(FILL, [act, root, n]) == 1
      and card_texts(views["upd_notes"]) == ["<mr_update_notes_none>"], card_texts(views["upd_notes"]))
act, root, n, views = make_dialog("- Novo: a", missing="upd_notes")
check("dialog: a layout without the notes view is refused (false)", DVM.run(FILL, [act, root, n]) == 0)
act, root, n, views = make_dialog("- Novo: a", notes_is_text=True)
check("dialog: a notes view that is not the box of cards (an old layout) is refused (false)", DVM.run(FILL, [act, root, n]) == 0)

# ------------------------------------------------------------------ MrVersion: the notes of the installed version
VVM = H.vm(VERSION, "MrVersion.smali")
del VVM.m["readAsset(Landroid/content/Context;)Ljava/lang/String;"]     # the host answers it (the real reading is the Java test): the VM would call itself
SAMPLE = ("# v9.9.9\n\n**Português**\n\n- Novo: item um.\n- Corrigido: item dois.\n\n**English**\n\n- New: item one.\n- Fixed: item two.\n")
blk = lambda text, p: VVM.run(BLOCK, [text, p])  # noqa: E731
check("block: the Portuguese block is what follows **Português** up to **English**, trimmed; the English one is what follows **English**",
      blk(SAMPLE, 1) == "- Novo: item um.\n- Corrigido: item dois." and blk(SAMPLE, 0) == "- New: item one.\n- Fixed: item two.",
      (blk(SAMPLE, 1), blk(SAMPLE, 0)))
swapped = "**English**\n- New: a.\n**Português**\n- Novo: b.\n"
check("block: the order of the blocks does not matter (English first)", blk(swapped, 1) == "- Novo: b." and blk(swapped, 0) == "- New: a.")
check("block: CRLF is accepted and the marks may have spaces around them", blk("  **Português**  \r\n- Novo: b.\r\n**English**\r\n- New: a.", 1) == "- Novo: b."
      and blk("  **Português**  \r\n- Novo: b.\r\n**English**\r\n- New: a.", 0) == "- New: a.")
check("block: with one block missing or empty the other is used; with none it is null",
      blk("**English**\n- New: a.", 1) == "- New: a." and blk("**Português**\n- Novo: b.", 0) == "- Novo: b." and blk("- sem blocos", 1) in (None, 0)
      and blk("**Português**\n\n**English**\n- New: a.", 1) == "- New: a." and blk("**Português**\n\n**English**\n", 1) in (None, 0)
      and blk("**Português**\n- Novo: b.\n**English**\n  \n", 0) == "- Novo: b.")
check("block: a mark in the middle of a line is not a mark", blk("texto **Português** aqui\n**English**\n- New: a.", 0) == "- New: a."
      and blk("texto **Português** aqui\n**English**\n- New: a.", 1) == "- New: a.")

H.asset = SAMPLE
check("notes: Portuguese for pt, English for any other language and for none", VVM.run(VNOTES, [None, pt]) == "- Novo: item um.\n- Corrigido: item dois."
      and VVM.run(VNOTES, [None, en]) == "- New: item one.\n- Fixed: item two." and VVM.run(VNOTES, [None, es]) == "- New: item one.\n- Fixed: item two."
      and VVM.run(VNOTES, [None, None]) == "- New: item one.\n- Fixed: item two.")
H.asset = None
check("notes: with no asset (or one that cannot be read) the notes are empty, no exception", VVM.run(VNOTES, [None, pt]) == "")
H.asset = "texto sem blocos"
check("notes: an asset with no block gives empty notes", VVM.run(VNOTES, [None, en]) == "")

ctx = make_box().f["context"]
check("summary: the version name and the hint that the line can be tapped", VVM.run(VSUMMARY, [ctx]) == "<mr_version_summary:v1.99.0>", VVM.run(VSUMMARY, [ctx]))
H.hint_missing = True
check("summary: without the hint text it is just the version name (never ' custom')", VVM.run(VSUMMARY, [ctx]) == "v1.99.0")
H.hint_missing = False


def make_version_dialog(lang="pt", missing=None, notes_is_text=False):
    tags = ["upd_title", "upd_sub", "upd_notes", "upd_scroll", "upd_box", "upd_status", "upd_bar", "upd_error", "upd_install", "upd_github", "upd_later"]
    c = make_box().f["context"]
    views = {k: dm.Obj("Landroid/widget/TextView;", context=c) for k in tags if k != missing}
    if not notes_is_text and missing != "upd_notes":
        views["upd_notes"] = dm.Obj("Landroid/widget/LinearLayout;", context=c)
    root = dm.Obj("Landroid/view/View;", views=views)
    act = dm.Obj("Landroid/app/Activity;", res=dm.Obj("Landroid/content/res/Resources;", conf=dm.Obj("Landroid/content/res/Configuration;",
                 locale=dm.Obj("Ljava/util/Locale;", lang=lang))))
    return act, root, views


H.asset = SAMPLE
act, root, views = make_version_dialog()
r = VVM.run(VFILL, [act, root])
check("version dialog: fill answers true; the title, the version line and one card for each item of the notes in Portuguese",
      r == 1 and views["upd_title"].f["shown"] == "<mr_version_title>" and views["upd_sub"].f["shown"] == "v1.99.0"
      and card_texts(views["upd_notes"]) == ["Novo: item um.", "Corrigido: item dois."], (views["upd_title"].f.get("shown"), card_texts(views["upd_notes"])))
check("version dialog: only Close is left (install, GitHub, the download box and the error are hidden: 8 = GONE) and it has its text and a click",
      all(views[k].f.get("visibility") == 8 for k in ("upd_install", "upd_github", "upd_box", "upd_error"))
      and views["upd_later"].f["shown"] == "<mr_version_close>" and views["upd_later"].f.get("click") is not None
      and "visibility" not in views["upd_scroll"].f and "visibility" not in views["upd_notes"].f)
act, root, views = make_version_dialog(lang="en")
check("version dialog: in English the notes are the English ones", VVM.run(VFILL, [act, root]) == 1 and card_texts(views["upd_notes"]) == ["New: item one.", "Fixed: item two."])
H.asset = None
act, root, views = make_version_dialog()
check("version dialog: with no notes in the APK the 'no notes' text is the only card", VVM.run(VFILL, [act, root]) == 1
      and card_texts(views["upd_notes"]) == ["<mr_update_notes_none>"], card_texts(views["upd_notes"]))
for gone in ("upd_title", "upd_sub", "upd_notes", "upd_later", "upd_install", "upd_github", "upd_box", "upd_error"):
    act, root, views = make_version_dialog(missing=gone)
    check("version dialog: a layout without %s is refused (false)" % gone, VVM.run(VFILL, [act, root]) == 0)
act, root, views = make_version_dialog(notes_is_text=True)
check("version dialog: a notes view that is not the box of cards (an old layout) is refused (false)", VVM.run(VFILL, [act, root]) == 0)

# ------------------------------------------------------------------ what is around
src = open(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrNotesText.java"), encoding="utf-8").read()
colors_xml = open(os.path.join(ROOT, "res", "values", "mr_colors.xml"), encoding="utf-8").read()
card_xml = open(os.path.join(ROOT, "res", "drawable", "mr_ui_note_card.xml"), encoding="utf-8").read()
layout_xml = open(os.path.join(ROOT, "res", "layout", "mr_update_dialog.xml"), encoding="utf-8").read()
check("the palette colors that the cards use exist in mr_colors.xml (text, text2, faint, stroke)",
      all('name="%s"' % c in colors_xml for c in ("mr_ui_text", "mr_ui_text2", "mr_ui_faint", "mr_ui_stroke")))
check("the card drawable: a rectangle with the faint fill, a thin line and rounded corners (12dp), palette colors only",
      'android:shape="rectangle"' in card_xml and "@color/mr_ui_faint" in card_xml and "@color/mr_ui_stroke" in card_xml and 'android:radius="12dp"' in card_xml
      and not re.search(r"#[0-9a-fA-F]{3,8}", card_xml.split("-->", 1)[1]))
check("the Java source and the smali have the same limit, gaps, padding and text size",
      "LABEL_MAX = 32" in src and "GAP_DP = 8" in src and "PAD_H_DP = 12" in src and "PAD_V_DP = 10" in src and "TEXT_SP = 14" in src)
check("the layout has the notes as a vertical LinearLayout inside the scroll (what the cards go into)",
      re.search(r'<ScrollView[^>]*android:tag="upd_scroll"[^>]*>\s*<LinearLayout\s+android:tag="upd_notes"\s+android:orientation="vertical"', layout_xml) is not None)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
