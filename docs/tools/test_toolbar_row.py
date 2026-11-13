#!/usr/bin/env python3
"""Tests the rule of the toolbar row: while a tool uses the row, nothing else shares it (MrTools.rowOwned, MrTools.applyMain).

Run it from the project root:  python3 -I docs/tools/test_toolbar_row.py

The tools (clipboard, translator, attachments, emojis, Customize, Fonts, emoji search) open a header beside bar_main, in the same row of the
toolbar. bar_main holds the tools and, when there are suggestions, the strip of word suggestions. The rule: while one of the headers is visible,
bar_main stays hidden, whatever the suggestions are doing. It was broken for Fonts and for the emoji search, which the old list of headers in
applyMain did not have: a suggestion arriving while Fonts was open put the strip above the fonts.

This runs the REAL smali of MrTools.rowOwned and MrTools.applyMain in the mini Dalvik interpreter (dalvik_mini.py) with fake views, and reads
mr_toolbar.xml to check that every header of the layout starts hidden and that the headers the rule has to cover are there.
"""
import os
import re
import sys
import xml.etree.ElementTree as ET

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


VISIBLE, GONE = 0, 8
GROUP = "Landroid/view/ViewGroup;"


def view(tag, vis=GONE, group=False):
    return dm.Obj(GROUP if group else "Landroid/view/View;", vis=vis, tag=tag, parent=None, kids=[])


class Host:
    """The Android classes the two methods touch, made of fake views."""

    def __init__(self):
        self.mode = 1            # what MrSugg.mode answers: 0 hidden, 1 tools, 2 suggestions
        self.inner = []          # MrSugg.applyInner calls

    def sget(self, cls, name):
        raise AssertionError("static of another class: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        if cls == GROUP:
            return isinstance(obj, dm.Obj) and obj.cls == GROUP
        if cls == "Ljava/lang/String;":
            return isinstance(obj, str)
        raise AssertionError(cls)

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        v = args[0] if args else None
        if mem == "getParent()Landroid/view/ViewParent;":
            return v.f["parent"]
        if mem == "getChildCount()I":
            return len(v.f["kids"])
        if mem == "getChildAt(I)Landroid/view/View;":
            return v.f["kids"][args[1]]
        if mem == "getVisibility()I":
            return v.f["vis"]
        if mem == "setVisibility(I)V":
            v.f["vis"] = args[1]
            return None
        if mem == "getTag()Ljava/lang/Object;":
            return v.f["tag"]
        if mem == "startsWith(Ljava/lang/String;)Z":
            return 1 if v.startswith(args[1]) else 0
        if cls == "Lcom/mrkeyboard/app/MrSugg;" and mem == "mode(Z)I":
            return self.mode if args[0] else 0
        if cls == "Lcom/mrkeyboard/app/MrSugg;" and mem == "applyInner(IZ)V":
            self.inner.append((args[0], args[1]))
            return None
        raise AssertionError("not faked: " + target)


def setup():
    methods = dm.parse_methods(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "MrTools.smali"))
    host = Host()
    vm = dm.VM("Lcom/mrkeyboard/app/MrTools;", methods, host)
    root = view("root", VISIBLE, group=True)
    main = view("bar_main", VISIBLE)
    heads = {t: view(t) for t in ("bar_t", "bar_c", "bar_s", "bar_e", "bar_tune", "bar_fonts", "bar_es")}
    others = [view("p_clip", VISIBLE), view("kbd_host", VISIBLE), view(None, VISIBLE), view(42, VISIBLE)]
    root.f["kids"] = [main] + list(heads.values()) + others
    for k in root.f["kids"]:
        k.f["parent"] = root
    main.f["parent"] = root
    vm.statics["sBarMain"] = main
    vm.statics["sBarOn"] = 1
    return vm, host, main, heads, others


def owned(vm):
    return vm.run("rowOwned()Z", [])


def apply(vm):
    vm.run("applyMain()V", [])


# ---- nothing open: the row is the tools or the suggestions, by MrSugg.mode
vm, host, main, heads, others = setup()
check("no header open: no tool owns the row", owned(vm) == 0)
for mode, name in ((1, "tools"), (2, "suggestions")):
    host.mode = mode
    main.f["vis"] = GONE
    host.inner.clear()
    apply(vm)
    check("no header open, mode %s: bar_main is shown and the inner groups are set" % name,
          main.f["vis"] == VISIBLE and host.inner == [(mode, 1)], (main.f["vis"], host.inner))
host.mode = 0
main.f["vis"] = VISIBLE
apply(vm)
check("no header open, bar off (mode 0): bar_main is hidden", main.f["vis"] == GONE)

# ---- each header, with the suggestions strip asking for the row (the case of the bug)
for tag, h in heads.items():
    vm, host, main, heads2, others = setup()
    host.mode = 2
    h2 = heads2[tag]
    h2.f["vis"] = VISIBLE
    apply(vm)
    check("%s open and suggestions on: a tool owns the row" % tag, owned(vm) == 1)
    check("%s open and suggestions on: bar_main (the strip) stays hidden" % tag, main.f["vis"] == GONE and host.inner == [], (main.f["vis"], host.inner))
    h2.f["vis"] = GONE
    apply(vm)
    check("%s closed: the row goes back to the suggestions" % tag, owned(vm) == 0 and main.f["vis"] == VISIBLE and host.inner == [(2, 1)])

# ---- the views that are not tool headers do not count
vm, host, main, heads, others = setup()
check("the panels, the keyboard host and views with no tag or a tag that is not text are not headers", owned(vm) == 0)

# ---- a tool header added later is covered with no change to the rule
vm, host, main, heads, others = setup()
extra = view("bar_future", VISIBLE)
extra.f["parent"] = main.f["parent"]
main.f["parent"].f["kids"].append(extra)
host.mode = 2
apply(vm)
check("a new header named bar_*: it owns the row too", owned(vm) == 1 and main.f["vis"] == GONE)

# ---- no bar_main yet, or one that is not in a group: nothing to do, no error
vm, host, main, heads, others = setup()
vm.statics["sBarMain"] = None
check("no bar_main: no tool owns the row, applyMain does nothing", owned(vm) == 0 and vm.run("applyMain()V", []) is None)
vm, host, main, heads, others = setup()
main.f["parent"] = None
check("bar_main with no parent: no tool owns the row", owned(vm) == 0)

# ---- the layout: every header starts hidden, and the two the old list missed are headers
ns = "{http://schemas.android.com/apk/res/android}"
tree = ET.parse(os.path.join(ROOT, "res", "layout", "mr_toolbar.xml")).getroot()
tops = {k.get(ns + "tag"): k for k in tree if k.get(ns + "tag")}
heads_xml = [t for t in tops if t.startswith("bar_") and t != "bar_main"]
check("the layout has the headers bar_t, bar_c, bar_s, bar_e, bar_tune, bar_fonts and bar_es beside bar_main",
      set(heads_xml) >= set(heads), sorted(heads_xml))
check("every header of the layout starts hidden (a visible one would take the row from the start)",
      all(tops[t].get(ns + "visibility") == "gone" for t in heads_xml), [t for t in heads_xml if tops[t].get(ns + "visibility") != "gone"])
check("bar_main starts visible, beside the headers", "bar_main" in tops and tops["bar_main"].get(ns + "visibility") in (None, "visible"))

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
