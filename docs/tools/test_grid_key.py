#!/usr/bin/env python3
"""Tests the grid key of the keyboard (MrTools.toggleBar), with the REAL smali of MrTools and MrSugg running together in the mini Dalvik
interpreter (dalvik_mini.py): fake views, a fake Handler, fake tools (AI Editor, Customize, translator, panels).

Run it from the project root:  python3 -I docs/tools/test_grid_key.py

The rule, by what is in view when the key is pressed:
  - a tool is open (a header beside bar_main: clipboard, translator, attachments, emojis, fonts, emoji search, Customize; or the AI Editor or the
    Customize dialog): the key closes it as its back button does (leave(true) for the translator, MrTune.close, MrAiDialog.dismiss,
    showPanel(0) for the panels, whose hooks end Fonts, the emoji search, the attachments and the emojis) and the tools take the row, even
    when there are suggestions; the row is not hidden;
  - the suggestions strip is in view: the tools take the row (they stay until the next typing, MrSugg.sIdle), any debounce is cancelled;
  - the tools are in view (or the row is hidden): the key shows/hides the whole row (MrTools.sBarOn).
"""
import os
import sys

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


TOOLS = "Lcom/mrkeyboard/app/MrTools;"
SUGG = "Lcom/mrkeyboard/app/MrSugg;"
APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
HEADERS = ("bar_t", "bar_c", "bar_s", "bar_e", "bar_tune", "bar_fonts", "bar_es")


def view(tag, vis=0, **f):
    f.setdefault("parent", None)
    return dm.Obj("Landroid/view/View;", vis=vis, tag=tag, kids=[], **f)


class ToolsVM(dm.VM):
    """MrTools: the panels and the translator are replaced by what they do to the headers (their own code needs the whole keyboard)."""

    def __init__(self, world):
        super().__init__(TOOLS, dm.parse_methods(os.path.join(APP, "MrTools.smali")), world.tools_host)
        self.world = world

    def run(self, key, args):
        w = self.world
        if key == "leave(Z)V":
            w.log.append("leave(%d)" % args[0])
            w.hide("bar_t")
            w.log.append("showPanel(0)")      # leave ends with showPanel(0)
            w.close_panels()
            return super().run("applyMain()V", [])
        if key == "showPanel(I)V":
            w.log.append("showPanel(%d)" % args[0])
            w.close_panels()
            return super().run("applyMain()V", [])
        return super().run(key, args)


class ToolsHost:
    def __init__(self, world):
        self.w = world

    def sget(self, cls, name):
        w = self.w
        if cls == "Lcom/mrkeyboard/app/MrTune;":
            return {"sDlg": w.tune_dlg, "sOn": w.tune_on}[name]
        raise AssertionError("static of another class: %s.%s" % (cls, name))

    def new_instance(self, cls):
        raise AssertionError(cls)

    def instance_of(self, obj, cls):
        if cls == "Ljava/lang/String;":
            return isinstance(obj, str)
        return isinstance(obj, dm.Obj) and obj.cls == cls

    def invoke(self, vm, op, target, args):
        w = self.w
        cls, _, mem = target.partition("->")
        if cls == SUGG:
            return w.sugg.run(mem, args)
        if cls == "Lcom/mrkeyboard/app/MrAiDialog;":
            if mem == "isShowing()Z":
                return 1 if w.ai else 0
            if mem == "dismiss()V":
                w.log.append("ai.dismiss")
                w.ai = False
                return None
        if cls == "Lcom/mrkeyboard/app/MrTune;" and mem == "close()V":
            w.log.append("tune.close")
            w.tune_dlg = None
            w.tune_on = 0
            w.hide("bar_tune")
            return vm.run("applyMain()V", [])
        if mem == "isShowing()Z":              # the Customize dialog
            return 1
        if mem == "getParent()Landroid/view/ViewParent;":
            return args[0].f["parent"]
        if mem == "getChildCount()I":
            return len(args[0].f["kids"])
        if mem == "getChildAt(I)Landroid/view/View;":
            return args[0].f["kids"][args[1]]
        if mem == "getVisibility()I":
            return args[0].f["vis"]
        if mem == "setVisibility(I)V":
            args[0].f["vis"] = args[1]
            return None
        if mem == "getTag()Ljava/lang/Object;":
            return args[0].f["tag"]
        if mem == "startsWith(Ljava/lang/String;)Z":
            return 1 if args[0].startswith(args[1]) else 0
        raise AssertionError("not faked: " + target)


class SuggHost:
    def __init__(self, world):
        self.w = world

    def sget(self, cls, name):
        if cls == TOOLS:
            return self.w.tools.statics[name]
        raise AssertionError("static of another class: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return True

    def invoke(self, vm, op, target, args):
        w = self.w
        cls, _, mem = target.partition("->")
        if cls == TOOLS:
            return w.tools.run(mem, args)
        if mem in ("<init>(Landroid/os/Looper;)V", "<init>()V"):
            return None
        if cls == "Landroid/os/Looper;":
            return dm.Obj("Landroid/os/Looper;")
        if mem == "removeCallbacks(Ljava/lang/Runnable;)V":
            w.pending = None
            return None
        if mem == "postDelayed(Ljava/lang/Runnable;J)Z":
            w.pending = (w.now + args[2], args[1])
            return 1
        if mem == "setVisibility(I)V":
            args[0].f["vis"] = args[1]
            return None
        if mem == "getContext()Landroid/content/Context;":
            return args[0].f["ctx"]
        if mem == "getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;":
            return dm.Obj("Landroid/content/SharedPreferences;")
        if mem == "getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;":
            return args[2]
        if mem == "parseInt(Ljava/lang/String;)I":
            return int(args[0])
        raise AssertionError("not faked: " + target)


class World:
    def __init__(self):
        self.log = []
        self.now = 0
        self.pending = None
        self.ai = False
        self.tune_dlg = None
        self.tune_on = 0
        self.tools_host = ToolsHost(self)
        self.tools = ToolsVM(self)
        self.sugg = dm.VM(SUGG, dm.parse_methods(os.path.join(APP, "MrSugg.smali")), SuggHost(self))
        # the views: a root with bar_main (tools + strip inside) and the headers beside it
        self.root = dm.Obj("Landroid/view/ViewGroup;", vis=0, tag="root", parent=None, kids=[])
        self.main = view("bar_main", parent=self.root, ctx=dm.Obj("Landroid/content/Context;"))
        self.hdr = {}
        self.root.f["kids"] = [self.main]
        for t in HEADERS:
            v = view(t, vis=8, parent=self.root)
            self.hdr[t] = v
            self.root.f["kids"].append(v)
        self.tools_v = view("tools")
        self.sugg_v = view("sugg", vis=8)
        st = self.tools.statics
        st["sBarMain"], st["sBarOn"], st["sPrefs"], st["sKbd"] = self.main, 1, None, None
        st["sBarT"] = self.hdr["bar_t"]
        ss = self.sugg.statics
        ss["sContainer"], ss["sHost"] = dm.Obj("Landroid/view/View;"), dm.Obj("Landroid/view/ViewGroup;")
        ss["sTools"], ss["sSugg"] = self.tools_v, self.sugg_v
        ss["sHas"] = ss["sIdle"] = ss["sWait"] = ss["sTyping"] = 0
        self.apply()

    def apply(self):
        self.tools.run("applyMain()V", [])

    def hide(self, tag):
        self.hdr[tag].f["vis"] = 8

    def open(self, tag):
        self.hdr[tag].f["vis"] = 0
        self.apply()

    def close_panels(self):
        for v in self.hdr.values():
            v.f["vis"] = 8

    def in_view(self):
        """What the person sees in the row: strip / tools / hidden (the row, or a tool header owns it)."""
        if self.main.f["vis"] != 0:
            return "hidden"
        return "strip" if self.sugg_v.f["vis"] == 0 else "tools"

    def key(self):
        self.log.clear()
        self.tools.run("toggleBar()V", [])

    def lst(self, has, typing):
        self.sugg.run("onList(ZZ)V", [1 if has else 0, 1 if typing else 0])

    def row_on(self):
        return self.tools.statics["sBarOn"]

    def idle(self):
        return self.sugg.statics["sIdle"]


# ---- the strip in view: the first press gives the row to the tools, the second hides the row, the third shows it (tools)
w = World()
w.lst(True, True)
check("start: the person types, the strip is in view", w.in_view() == "strip")
w.key()
check("grid key with the strip in view: the tools take the row", w.in_view() == "tools" and w.row_on() == 1, (w.in_view(), w.row_on()))
check("... it does not close any tool and does not hide the row", w.log == [], w.log)
w.key()
check("grid key with the tools in view: the whole row is hidden", w.in_view() == "hidden" and w.row_on() == 0)
w.key()
check("grid key with the row hidden: the row is shown, with the tools (they were given the row)", w.in_view() == "tools" and w.row_on() == 1)
w.lst(True, True)
check("typing brings the strip back", w.in_view() == "strip")

# ---- the debounce is cancelled by the key
w = World()
w.lst(True, True)
w.lst(True, False)
check("after the word: the debounce is running", w.pending is not None)
w.key()
check("grid key during the debounce: the tools, and the debounce is cancelled", w.in_view() == "tools" and w.pending is None, (w.in_view(), w.pending))

# ---- the tools in view, nothing to show: the key toggles the row
w = World()
check("no suggestions: the tools are in view", w.in_view() == "tools")
w.key()
check("grid key: the row is hidden", w.in_view() == "hidden" and w.row_on() == 0)
w.key()
check("grid key: the row is back", w.in_view() == "tools" and w.row_on() == 1)

# ---- a tool open: the key closes it and the tools come back, whatever the strip would show
for tag, expect in (("bar_fonts", ["showPanel(0)"]), ("bar_es", ["showPanel(0)"]), ("bar_c", ["showPanel(0)"]), ("bar_e", ["showPanel(0)"]),
                    ("bar_s", ["showPanel(0)"]), ("bar_t", ["leave(1)", "showPanel(0)"]), ("bar_tune", ["tune.close"])):
    w = World()
    w.lst(True, True)                                  # there are suggestions: without the rule the strip would come back
    if tag == "bar_tune":
        w.tune_on = 1
    w.open(tag)
    check("%s open: the row belongs to the tool" % tag, w.in_view() == "hidden")
    w.key()
    check("%s open, grid key: the tool is closed (%s)" % (tag, ", ".join(expect)), w.log == expect, w.log)
    check("%s open, grid key: the tools take the row (not the strip), and the row is not hidden" % tag,
          w.in_view() == "tools" and w.row_on() == 1 and w.idle() == 1, (w.in_view(), w.row_on(), w.idle()))
    check("%s open, grid key: no header is left open" % tag, all(v.f["vis"] == 8 for v in w.hdr.values()))
    w.lst(True, True)
    check("%s: typing after it brings the strip back" % tag, w.in_view() == "strip")

# ---- the dialogs over the keyboard (the bar is in view)
w = World()
w.lst(True, True)
w.ai = True
w.key()
check("AI Editor dialog open: the key dismisses it, the tools take the row, the row stays", w.log == ["ai.dismiss"] and w.in_view() == "tools" and w.row_on() == 1, (w.log, w.in_view()))
w = World()
w.tune_dlg = dm.Obj("Landroid/app/Dialog;")
w.key()
check("Customize dialog open: the key closes it (MrTune.close), the row stays", w.log == ["tune.close"] and w.in_view() == "tools" and w.row_on() == 1, (w.log, w.in_view()))
w.key()
check("... and the next key hides the row (nothing is open now)", w.in_view() == "hidden" and w.row_on() == 0)

# ---- two things open at once (the translator and a dialog): one press ends them all
w = World()
w.ai = True
w.open("bar_t")
w.key()
check("translator and AI Editor open: one key press ends both", w.log[0] == "ai.dismiss" and "leave(1)" in w.log and w.in_view() == "tools", w.log)

# ---- the key shows the hidden row and the strip comes back with it: the debounce starts for it (MrSugg.rearm)
w = World()
w.tools.statics["sBarOn"] = 0
w.apply()
w.lst(True, False)                       # the initial suggestions (Você, Eu, Não) arrive while the row is hidden: no strip, no debounce
check("row hidden, the initial suggestions arrive: nothing in view, no debounce", w.in_view() == "hidden" and w.pending is None, (w.in_view(), w.pending))
w.key()
check("grid key shows the row: the strip with the initial suggestions", w.in_view() == "strip" and w.row_on() == 1, (w.in_view(), w.row_on()))
check("... and the 3 s debounce starts for it", w.pending is not None and w.pending[0] == w.now + 3000, w.pending)
w = World()
w.tools.statics["sBarOn"] = 0
w.apply()
w.lst(True, True)                        # the word being typed
w.key()
check("grid key shows the row while a word is being typed: the strip, and no debounce", w.in_view() == "strip" and w.pending is None, (w.in_view(), w.pending))

# ---- no tool left open means the next press is the row toggle
w = World()
w.open("bar_fonts")
w.key()
w.key()
check("after a tool was closed by the key, the next press hides the row", w.row_on() == 0 and w.in_view() == "hidden")

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
