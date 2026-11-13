#!/usr/bin/env python3
"""Tests the animations of the toolbar row (MrAnim.smali): tools <-> suggestions, and showing/hiding the row.

Run it from the project root:  python3 -I docs/tools/test_anim.py

Runs the REAL smali of MrAnim in the mini Dalvik interpreter (dalvik_mini.py) with fake views and a fake ViewPropertyAnimator
(anim_fake.py) that keeps the animations waiting, so what is on screen in the middle of an animation can be checked. The rules:
  - the tools and the strip change with a crossfade only when the row is on screen; the same target again does not restart it;
    turning back in the middle of it reverses it; a missing group changes the other at once;
  - the row shows as the card of the emoji search does (grows from its bottom edge, scaleY 0.6 -> 1, with a fade, 240 ms), and hides the same way backwards; it hides with a fade and leaves the layout (GONE) only at the end; showing it again in
    the middle of the fade-out turns it back; a tool taking the row (gone) takes it out at once and the end action never runs;
  - what is cancelled never runs its end action, and the views stay at alpha 1 and scale 1 after any of it (the next time starts clean);
  - with the animator scale at 0 (it ends inside start) everything is final at once.
It also reads the layout (bar_main overlays the two groups) and checks that every call into MrAnim in the smali has its method.
"""
import glob
import os
import re
import sys
import xml.etree.ElementTree as ET

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import anim_fake as af  # noqa: E402
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
FROM = dm.bits2f(0x3f19999a)          # 0.6f: where the row starts growing from (MrEmojiSearch.ENTER_FROM)


def state(v):
    return (v.f["vis"], v.f["alpha"], v.f["sy"])


def world(main_vis=VISIBLE, instant=False):
    main = af.make_view("bar_main", main_vis)
    tools = af.make_view("bar_tools", VISIBLE)
    sugg = af.make_view("bar_sugg", GONE)
    return af.AnimWorld(main, instant), main, tools, sugg


# ---- swap: tools <-> suggestions
w, main, tools, sugg = world()
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [tools, sugg])
check("the first call with the tools already in view: nothing to animate", not w.log and state(tools) == (VISIBLE, 1.0, 1.0) and state(sugg)[0] == GONE)

w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
check("tools -> suggestions, row on screen: the strip starts at alpha 0 and both are in view",
      state(sugg) == (VISIBLE, 0.0, 1.0) and tools.f["vis"] == VISIBLE, (state(sugg), state(tools)))
check("... the strip fades in (150 ms, no end action) and the tools fade out (150 ms, with the end action)",
      w.log == [("bar_sugg", 1.0, 1.0, 150, False), ("bar_tools", 0.0, 1.0, 150, True)], w.log)
n = len(w.log)
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
check("the same target again in the middle of it: the crossfade is not restarted", len(w.log) == n and len(w.running) == 2)
w.finish()
check("at the end the tools are gone and clean (alpha 1, scale 1), the strip is shown",
      state(tools) == (GONE, 1.0, 1.0) and state(sugg) == (VISIBLE, 1.0, 1.0), (state(tools), state(sugg)))

# turning back in the middle of the crossfade
w.log.clear()
w.ended.clear()
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [tools, sugg])
sugg.f["alpha"], tools.f["alpha"] = 0.6, 0.4           # in the middle
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
check("strip -> tools and back in the middle: the first end action is cancelled and the strip carries on from where it was",
      w.ended == [] and sugg.f["alpha"] == 0.6 and len(w.running) == 2, (w.ended, sugg.f["alpha"], len(w.running)))
w.finish()
check("... and it ends with the strip shown, the tools gone and both clean",
      state(sugg) == (VISIBLE, 1.0, 1.0) and state(tools) == (GONE, 1.0, 1.0), (state(sugg), state(tools)))

# the row is not on screen: at once
w, main, tools, sugg = world(main_vis=GONE)
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
check("row off screen: the groups change at once, with no animation",
      not w.log and state(sugg) == (VISIBLE, 1.0, 1.0) and state(tools)[0] == GONE, (w.log, state(sugg), state(tools)))

# a group is missing
w, main, tools, sugg = world()
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [None, tools])
check("a group missing (the one to show): the other one is hidden at once, no error", not w.log and tools.f["vis"] == GONE)
w, main, tools, sugg = world()
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [tools, None])
check("a group missing (the one to hide): the one to show is shown at once, no error", not w.log and state(tools) == (VISIBLE, 1.0, 1.0))

# release
w, main, tools, sugg = world()
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
w.run("reset()V", [])
check("reset lets go of the views", not w.s_to and not w.s_hiding)

# ---- show / hide of the row
w, main, tools, sugg = world(main_vis=GONE)
w.run("show(Landroid/view/View;)V", [main])
check("show with the row gone: it starts at alpha 0 and scale 0.6 from its bottom edge and grows while it fades in (240 ms, as the emoji search card)",
      state(main) == (VISIBLE, 0.0, FROM) and w.log == [("bar_main", 1.0, 1.0, 240, False)] and main.f["pivot"] == af.HEIGHT, (state(main), w.log))
w.finish()
check("... and ends at alpha 1 and scale 1", state(main) == (VISIBLE, 1.0, 1.0))
w.log.clear()
w.run("show(Landroid/view/View;)V", [main])
check("show with the row in view: nothing", not w.log and state(main) == (VISIBLE, 1.0, 1.0))

w.run("hide(Landroid/view/View;)V", [main])
check("hide: the row shrinks towards its bottom edge while it fades out (140 ms, with the end action) and is still in the layout",
      w.log == [("bar_main", 0.0, FROM, 140, True)] and main.f["vis"] == VISIBLE and w.s_hiding is main and main.f["pivot"] == af.HEIGHT, (w.log, state(main)))
w.run("hide(Landroid/view/View;)V", [main])
check("hide again while it fades: not restarted", len(w.log) == 1 and len(w.running) == 1)
w.finish()
check("at the end the row leaves the layout (GONE), clean for the next time, and nothing is left hiding",
      state(main) == (GONE, 1.0, 1.0) and not w.s_hiding and w.ended == ["bar_main"], (state(main), w.ended))
w.log.clear()
w.run("hide(Landroid/view/View;)V", [main])
check("hide with the row already gone: nothing", not w.log and main.f["vis"] == GONE)

# showing again in the middle of the fade-out
w, main, tools, sugg = world()
w.run("hide(Landroid/view/View;)V", [main])
main.f["alpha"] = 0.5
w.run("show(Landroid/view/View;)V", [main])
check("show in the middle of the fade-out: it turns back (120 ms, no end action), the end action is cancelled",
      w.log[-1] == ("bar_main", 1.0, 1.0, 120, False) and not w.s_hiding and main.f["alpha"] == 0.5 and len(w.running) == 1,
      (w.log, w.s_hiding))
w.finish()
check("... and the row stays in view at alpha 1 (the end action of the hide never ran)",
      state(main) == (VISIBLE, 1.0, 1.0) and w.ended == [], (state(main), w.ended))

# a tool takes the row in the middle of the fade-out
w, main, tools, sugg = world()
w.run("hide(Landroid/view/View;)V", [main])
w.run("gone(Landroid/view/View;)V", [main])
check("gone in the middle of the fade-out: the row leaves at once, clean, and the fade-out is cancelled",
      state(main) == (GONE, 1.0, 1.0) and not w.running and not w.s_hiding, (state(main), len(w.running)))
w.finish()
check("... and no end action runs later", w.ended == [] and state(main) == (GONE, 1.0, 1.0))
w.run("show(Landroid/view/View;)V", [main])
w.finish()
check("... the row can come back after it", state(main) == (VISIBLE, 1.0, 1.0))

# hide after a show that is still running
w, main, tools, sugg = world(main_vis=GONE)
w.run("show(Landroid/view/View;)V", [main])
w.run("hide(Landroid/view/View;)V", [main])
w.finish()
check("hide in the middle of the fade-in: it ends gone and clean", state(main) == (GONE, 1.0, 1.0), state(main))

# ---- animator scale 0: the animation ends inside start()
w, main, tools, sugg = world(instant=True)
w.run("hide(Landroid/view/View;)V", [main])
check("animator scale 0: hide leaves the row gone and clean at once", state(main) == (GONE, 1.0, 1.0) and not w.s_hiding, (state(main), w.s_hiding))
w.run("show(Landroid/view/View;)V", [main])
check("animator scale 0: show leaves the row in view at once, at alpha 1 and scale 1", state(main) == (VISIBLE, 1.0, 1.0), state(main))
w.run("swap(Landroid/view/View;Landroid/view/View;)V", [sugg, tools])
check("animator scale 0: the crossfade is final at once",
      state(sugg) == (VISIBLE, 1.0, 1.0) and state(tools) == (GONE, 1.0, 1.0), (state(sugg), state(tools)))

# ---- the layout: bar_main overlays the two groups, so they can crossfade
ns = "{http://schemas.android.com/apk/res/android}"
tree = ET.parse(os.path.join(ROOT, "res", "layout", "mr_toolbar.xml")).getroot()
main_el = next(e for e in tree if e.get(ns + "tag") == "bar_main")
kids = {e.get(ns + "tag"): e for e in main_el}
check("bar_main is a FrameLayout (the groups overlay each other)", main_el.tag == "FrameLayout", main_el.tag)
check("bar_main has the two groups, bar_tools and bar_sugg", set(kids) == {"bar_tools", "bar_sugg"}, set(kids))
check("both groups fill bar_main (no weight: in a FrameLayout a width of 0 would hide them)",
      all(e.get(ns + "layout_width") == "fill_parent" and e.get(ns + "layout_height") == "fill_parent" and e.get(ns + "layout_weight") is None
          for e in kids.values()), {t: (e.get(ns + "layout_width"), e.get(ns + "layout_weight")) for t, e in kids.items()})
check("the strip starts gone, the tools in view", kids["bar_sugg"].get(ns + "visibility") == "gone" and kids["bar_tools"].get(ns + "visibility") in (None, "visible"))

# ---- every call into MrAnim has its method
defs = set()
for m in re.finditer(r"^\.method\s+(?:[\w-]+\s+)*([\w$<>]+\(.*?\)\S+)$", open(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "MrAnim.smali"), encoding="utf-8").read(), re.M):
    defs.add(m.group(1))
calls, bad = set(), []
for path in glob.glob(os.path.join(ROOT, "smali", "**", "*.smali"), recursive=True):
    if path.endswith("MrAnim.smali"):
        continue
    for line in open(path, encoding="utf-8"):
        m = re.search(r"invoke-\w+(?:/range)? \{[^}]*\}, Lcom/mrkeyboard/app/MrAnim;->(\S+)", line)
        if m:
            calls.add(m.group(1))
            if m.group(1) not in defs:
                bad.append((os.path.basename(path), m.group(1)))
check("MrAnim is called from the smali (swap, show, hide, gone, reset)",
      {c.split("(")[0] for c in calls} == {"swap", "show", "hide", "gone", "reset"}, sorted(calls))
check("every call into MrAnim has its method with that signature", not bad, bad)

# ---- the entrance is the one of the card of the emoji search (same numbers; if one changes the other has to)
java = open(os.path.join(ROOT, "docs", "tools", "java", "src", "com", "mrkeyboard", "app", "MrEmojiSearch.java"), encoding="utf-8").read()
enter_ms = int(re.search(r"ENTER_MS\s*=\s*(\d+)", java).group(1))
enter_from = float(re.search(r"ENTER_FROM\s*=\s*([\d.]+)f", java).group(1))
anim = open(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "MrAnim.smali"), encoding="utf-8").read()
show = anim[anim.index(".method static show("):anim.index(".method static hide(")]
ms_in_show = int(re.search(r"const/16 v2, (0x[0-9a-f]+)\s+invoke-static \{p0, v0, v0, v3, v2\}", show).group(1), 16)
from_bits = int(re.search(r"const v1, (0x[0-9a-f]+)", show).group(1), 16)
check("the row enters in the same time as the emoji search card (ENTER_MS, %d ms)" % enter_ms, ms_in_show == 0xf0 and enter_ms == 0xf0, (ms_in_show, enter_ms))
check("... and starts from the same scale (ENTER_FROM, %s)" % enter_from, abs(dm.bits2f(from_bits) - enter_from) < 1e-6, (dm.bits2f(from_bits), enter_from))

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
