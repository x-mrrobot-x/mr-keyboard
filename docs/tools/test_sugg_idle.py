#!/usr/bin/env python3
"""Tests which of the two groups of the toolbar row (tools or word suggestions) is in view, and the debounce that gives the row back to the tools.

Run it from the project root:  python3 -I docs/tools/test_sugg_idle.py

It runs the REAL smali of MrSugg (onList, arm, idleMs, stripShown, expire, mode, schedule, cancel) in the mini Dalvik interpreter (dalvik_mini.py) with a
fake Handler on a virtual clock, fake preferences and a fake MrTools (what applyMain does is recorded as "the screen": the state in view changes only when
applyMain is called, as in the app, so a missing call shows up).

The rules (see the header of MrSugg.smali and docs/suggestion-features.md, "Strip or tools in the row"):
  - typing (a list of the word being typed, corrected or swiped) brings the strip back at once, if the row is visible and no tool owns it;
  - when the word ends (the list of the next word, a picked suggestion) and the strip is on screen, a debounce of "pref_sugg_idle" seconds starts
    (2 by default, 0 = off); each new end of word restarts it; typing cancels it; at the end the tools take the row and stay until the next typing;
  - the debounce never runs for a strip that is not on screen (a tool owns the row, the row is hidden by the bar key);
  - an empty list with the strip on screen keeps it for 1 s before the tools come back;
  - a strip that comes into view without a new list (created after the list, the row shown again by the bar key) starts the debounce (rearm), unless
    its list belongs to a word being typed;
  - the grid key is tested in test_grid_key.py.
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


SUGG = "Lcom/mrkeyboard/app/MrSugg;"
TOOLS_CLS = "Lcom/mrkeyboard/app/MrTools;"


class Host:
    def __init__(self):
        self.now = 0
        self.pending = None          # (due, runnable) of the one Handler task
        self.pref = None             # value of "pref_sugg_idle" (None: not stored, the default is used)
        self.row_owned = 0
        self.bar_on = 1
        self.screen = "tools"        # what applyMain left in view: tools / strip / hidden / owned
        self.applies = 0
        self.vm = None
        self.context = dm.Obj("Landroid/content/Context;")
        self.bar_main = dm.Obj("Landroid/view/View;", ctx=self.context)

    # ---- the view state, the way MrTools.applyMain would draw it now
    def draw(self):
        self.applies += 1
        if self.row_owned:
            self.screen = "owned"
            return
        m = self.vm.run("mode(Z)I", [self.bar_on])
        self.screen = {0: "hidden", 1: "tools", 2: "strip"}[m]

    def sget(self, cls, name):
        if cls == TOOLS_CLS and name == "sBarOn":
            return self.bar_on
        if cls == TOOLS_CLS and name == "sBarMain":
            return self.bar_main
        raise AssertionError("static of another class: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return True

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if mem == "<init>(Landroid/os/Looper;)V" or mem == "<init>()V":
            return None
        if cls == "Landroid/os/Looper;" and mem == "getMainLooper()Landroid/os/Looper;":
            return dm.Obj("Landroid/os/Looper;")
        if mem == "removeCallbacks(Ljava/lang/Runnable;)V":
            self.pending = None
            return None
        if mem == "postDelayed(Ljava/lang/Runnable;J)Z":
            self.pending = (self.now + args[2], args[1])
            return 1
        if cls == TOOLS_CLS and mem == "applyMain()V":
            self.draw()
            return None
        if cls == TOOLS_CLS and mem == "rowOwned()Z":
            return self.row_owned
        if mem == "getContext()Landroid/content/Context;":
            return args[0].f["ctx"]
        if mem == "getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;":
            return dm.Obj("Landroid/content/SharedPreferences;")
        if mem == "getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;":
            assert args[1] == "pref_sugg_idle", args
            return self.pref if self.pref is not None else args[2]
        if mem == "parseInt(Ljava/lang/String;)I":
            try:
                return int(args[0])
            except ValueError:
                raise dm.JavaExc("Ljava/lang/NumberFormatException;", args[0])
        raise AssertionError("not faked: " + target)

    # ---- the clock
    def advance(self, ms):
        end = self.now + ms
        while self.pending and self.pending[0] <= end:
            due, _ = self.pending
            self.now = due
            self.pending = None
            self.vm.run("expire()V", [])      # MrSugg$Expire.run calls exactly this
        self.now = end


def setup(pref=None):
    methods = dm.parse_methods(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "MrSugg.smali"))
    host = Host()
    vm = dm.VM(SUGG, methods, host)
    host.vm = vm
    host.pref = pref
    # the strip exists and is hosted (LatinIME.onCreateCandidatesView -> MrSugg.host)
    vm.statics["sContainer"] = dm.Obj("Landroid/view/View;")
    vm.statics["sHost"] = dm.Obj("Landroid/view/ViewGroup;")
    vm.statics["sHas"] = 0
    vm.statics["sIdle"] = 0
    vm.statics["sTyping"] = 0
    vm.statics["sWait"] = 0
    host.draw()
    return vm, host


def lst(vm, has, typing):
    vm.run("onList(ZZ)V", [1 if has else 0, 1 if typing else 0])


def type_word(vm, host):
    lst(vm, True, True)


def end_word(vm, host):
    lst(vm, True, False)


# ---- the default: 2 seconds
vm, host = setup()
check("start: nothing to show, the tools are in the row", host.screen == "tools")
type_word(vm, host)
check("typing a word: the strip shows at once", host.screen == "strip")
check("typing: no debounce is running", host.pending is None)
type_word(vm, host)
check("typing more of the word: still the strip, still no debounce", host.screen == "strip" and host.pending is None)
end_word(vm, host)
check("space (list of the next word): the strip stays", host.screen == "strip")
check("space: the debounce starts, 2 s ahead", host.pending is not None and host.pending[0] == 2000, host.pending)
host.advance(1999)
check("1.999 s after the space: still the strip", host.screen == "strip")
host.advance(1)
check("2 s after the space: the tools take the row", host.screen == "tools" and vm.statics["sIdle"] == 1)
check("... and nothing is pending", host.pending is None)

# ---- typing brings the strip back from the tools
type_word(vm, host)
check("tools in view (after the debounce), the person types: the strip comes back at once", host.screen == "strip" and vm.statics["sIdle"] == 0)
end_word(vm, host)
check("end of the word again: the debounce restarts from the strip", host.pending is not None and host.pending[0] == host.now + 2000)

# ---- debounce restarts with each end of word
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(1500)
end_word(vm, host)             # another space (or a picked suggestion) 1.5 s later
check("a second end of word restarts the clock", host.pending[0] == host.now + 2000)
host.advance(1999)
check("1.999 s after the SECOND end of word: still the strip", host.screen == "strip")
host.advance(1)
check("2 s after the second end of word: the tools", host.screen == "tools")

# ---- typing before it ends cancels it
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(1500)
type_word(vm, host)
check("typing before the 2 s: the debounce is cancelled", host.pending is None)
host.advance(60000)
check("... and the strip stays for as long as the person types", host.screen == "strip")

# ---- with the tools in view, a list of the next word (cursor moved, field changed) does not flicker the row
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(2000)
n = host.applies
end_word(vm, host)
check("tools in view: a list of the next word keeps the tools", host.screen == "tools" and host.pending is None and host.applies == n,
      (host.screen, host.pending, host.applies - n))
lst(vm, False, False)
check("tools in view: an empty list keeps the tools and starts no wait", host.screen == "tools" and host.pending is None)

# ---- a tool owns the row: no debounce, no strip over it
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.row_owned = 1
host.advance(2000)
check("a tool took the row during the countdown: the debounce ends with no change", vm.statics["sIdle"] == 0)
host.row_owned = 0
host.draw()
check("the tool closes: the strip comes back (the row was not handed to the tools)", host.screen == "strip")
vm, host = setup()
host.row_owned = 1
host.draw()
end_word(vm, host)
check("end of word while a tool owns the row: no debounce starts", host.pending is None)
type_word(vm, host)
check("typing while a tool owns the row: the row is not touched", host.screen == "owned")

# ---- the row hidden with the bar key: nothing counts
vm, host = setup()
host.bar_on = 0
host.draw()
type_word(vm, host)
check("row hidden (bar key): typing shows nothing", host.screen == "hidden")
end_word(vm, host)
check("row hidden: no debounce starts", host.pending is None)
host.bar_on = 1
host.draw()
check("the bar key shows the row again: suggestions are there, so the strip", host.screen == "strip")

# ---- the row shown again by the bar key: the debounce starts for the strip that comes back (MrTools.toggleBar calls rearm)
vm, host = setup()
host.bar_on = 0
host.draw()
type_word(vm, host)
end_word(vm, host)
host.bar_on = 1
host.draw()
vm.run("rearm()V", [])
check("row hidden, a list of the next words arrived, the bar key shows the row: the debounce starts now", host.screen == "strip" and host.pending is not None and host.pending[0] == host.now + 2000, host.pending)
host.advance(2000)
check("... and 2 s later the tools take the row", host.screen == "tools" and vm.statics["sIdle"] == 1)
vm, host = setup()
host.bar_on = 0
host.draw()
type_word(vm, host)
host.bar_on = 1
host.draw()
vm.run("rearm()V", [])
check("row hidden, the word being typed, the row shown again: the strip stays, no debounce", host.screen == "strip" and host.pending is None, host.pending)
vm, host = setup()
vm.run("rearm()V", [])
check("rearm with no suggestions: nothing starts", host.pending is None)
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(2000)
vm.run("rearm()V", [])
check("rearm with the tools in view (the debounce already ended): nothing starts", host.screen == "tools" and host.pending is None)
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(1000)
vm.run("rearm()V", [])
check("rearm restarts the 2 s from now", host.pending[0] == host.now + 2000, host.pending)
vm, host = setup()
host.row_owned = 1
host.draw()
end_word(vm, host)
vm.run("rearm()V", [])
check("rearm while a tool owns the row: nothing starts", host.pending is None and host.screen == "owned", (host.pending, host.screen))
vm, host = setup(pref="0")
host.bar_on = 0
host.draw()
end_word(vm, host)
host.bar_on = 1
host.draw()
vm.run("rearm()V", [])
check("rearm with the setting off: no debounce", host.pending is None)

# ---- a strip created AFTER the list (a new field: LatinIME.onCreateCandidatesView -> MrSugg.host) gets the debounce too
vm, host = setup()
vm.statics["sContainer"] = None
host.draw()
end_word(vm, host)          # the initial suggestions (Você, Eu, Não) arrive; there is no strip yet
check("list before the strip exists: the tools, no debounce", host.screen == "tools" and host.pending is None)
vm.statics["sContainer"] = dm.Obj("Landroid/view/View;")      # the strip is created ...
host.draw()
vm.run("rearm()V", [])                                       # ... and host() calls rearm after attach/applyMain
check("the strip is created: the initial suggestions show and the debounce starts", host.screen == "strip" and host.pending is not None and host.pending[0] == host.now + 2000, (host.screen, host.pending))
host.advance(2000)
check("... and 2 s later the tools take the row", host.screen == "tools")

# ---- the setting
for value, expect in (("0", None), ("1", 1000), ("2", 2000), ("5", 5000), ("8", 8000), ("10", 10000), ("abc", 2000), ("", 2000), ("-4", None)):
    vm, host = setup(pref=value)
    type_word(vm, host)
    end_word(vm, host)
    got = host.pending[0] if host.pending else None
    check("setting %r: debounce %s" % (value, "off" if expect is None else "%d ms" % expect), got == expect, got)
vm, host = setup(pref="0")
type_word(vm, host)
end_word(vm, host)
host.advance(600000)
check("setting off: the strip stays for ever", host.screen == "strip")

# ---- no suggestions at all: 1 s of hold, as before
vm, host = setup()
type_word(vm, host)
lst(vm, False, False)
check("empty list while the strip shows: the strip stays...", host.screen == "strip" and host.pending is not None and host.pending[0] == 1000, host.pending)
host.advance(999)
check("... for 1 s", host.screen == "strip")
host.advance(1)
check("... then the tools", host.screen == "tools")
vm, host = setup()
type_word(vm, host)
lst(vm, False, False)
host.advance(500)
type_word(vm, host)
check("typing during the hold cancels it", host.pending is None and host.screen == "strip")
vm, host = setup()
type_word(vm, host)
lst(vm, False, False)
host.advance(700)
lst(vm, False, False)
check("another empty list during the hold restarts the 1 s", host.pending[0] == host.now + 1000)
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
lst(vm, False, False)
check("the list empties during the debounce: the debounce is replaced by the 1 s hold", host.pending[0] == host.now + 1000)
host.advance(1000)
check("... and the tools come back", host.screen == "tools")

# ---- the next-word list arriving in the hold shows the strip again and starts the debounce
vm, host = setup()
type_word(vm, host)
lst(vm, False, False)
end_word(vm, host)
check("hold, then a list of the next word: the strip stays and the debounce replaces the hold", host.screen == "strip" and host.pending[0] == host.now + 2000)

# ---- a gesture preview is typing (LatinIME.mrStrip sets it): it brings the strip back from the tools
vm, host = setup()
type_word(vm, host)
end_word(vm, host)
host.advance(2000)
lst(vm, True, True)
check("tools in view, a gesture preview list arrives: the strip", host.screen == "strip" and host.pending is None)

# ---- no strip hosted (suggestions off in the field): always the tools, no debounce
vm, host = setup()
vm.statics["sContainer"] = None
host.draw()
type_word(vm, host)
end_word(vm, host)
check("no strip hosted: the tools, and no debounce", host.screen == "tools" and host.pending is None)

# ---- the bar key does not call the old switch between tools and suggestions (the grid key is tested in test_grid_key.py)
src = open(os.path.join(ROOT, "smali", "com", "mrkeyboard", "app", "MrTools.smali"), encoding="utf-8").read()
check("MrTools.toggleBar no longer calls MrSugg.onBarKey", "onBarKey" not in src)

print("%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
