#!/usr/bin/env python3
"""The real MrAnim.smali (the animations of the toolbar row) in the mini Dalvik interpreter, with fake views and a fake animator.

Used by test_anim.py, and by the tests that run MrTools/MrSugg together (test_grid_key.py, test_toolbar_row.py), so that what they check
about the row (visible, gone, strip, tools) goes through the real animation code.

  AnimWorld(instant=True)   an animation ends inside start(), end action included (how the animator behaves with the system animator
                            scale at 0). The views are in their final state as soon as the call returns.
  AnimWorld(instant=False)  an animation waits: the views keep their state until finish() (the animation ends, end actions run) or
                            until it is cancelled (stop: the end action never runs). `log` has one line per animation started.
"""
import os

import dalvik_mini as dm

ANIM = "Lcom/mrkeyboard/app/MrAnim;"
VIEW = "Landroid/view/View;"
PROPS = "Landroid/view/ViewPropertyAnimator;"
APP = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "smali", "com", "mrkeyboard", "app")
DENSITY = 2.5


def make_view(tag, vis=0, **kw):
    """A fake view: visibility, alpha, translationY and the animator it owns."""
    return dm.Obj(VIEW, vis=vis, tag=tag, alpha=1.0, ty=0.0, animator=None, parent=None, kids=[], **kw)


class AnimWorld:
    def __init__(self, bar_main=None, instant=False):
        self.instant = instant
        self.main = bar_main
        self.running = []          # animators waiting for finish()
        self.log = []              # (tag, alpha, translationY, ms, has end action) of each animation started
        self.ended = []            # tags of the views whose end action ran
        self.vm = dm.VM(ANIM, dm.parse_methods(os.path.join(APP, "MrAnim.smali")), self)

    # --- what the tests call
    def run(self, key, args):
        return self.vm.run(key, args)

    @property
    def s_to(self):
        return self.vm.statics.get("sTo")

    @property
    def s_hiding(self):
        return self.vm.statics.get("sHiding")

    def finish(self):
        """Every animation in progress reaches its end (end actions included)."""
        while self.running:
            self._end(self.running.pop(0))

    def _end(self, a):
        v = a.f["view"]
        for k, val in a.f["target"].items():
            v.f[k] = val
        a.f["target"] = {}
        end, a.f["end"] = a.f["end"], None
        if end is not None:
            self.ended.append(v.f.get("tag"))
            self.vm.run("run()V", [end])

    # --- the host of the interpreter
    def sget(self, cls, name):
        if cls == "Lcom/mrkeyboard/app/MrTools;" and name == "sBarMain":
            return self.main
        raise AssertionError("static of another class: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return isinstance(obj, dm.Obj) and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        a0 = args[0] if args else None
        if mem == "<init>()V":
            return None
        if cls == ANIM and mem.startswith("<init>"):
            return vm.run(mem, args)
        if cls == VIEW:
            if mem == "getVisibility()I":
                return a0.f["vis"]
            if mem == "setVisibility(I)V":
                a0.f["vis"] = args[1]
                return None
            if mem == "setAlpha(F)V":
                a0.f["alpha"] = dm.fv(args[1])
                return None
            if mem == "setTranslationY(F)V":
                a0.f["ty"] = dm.fv(args[1])
                return None
            if mem == "getResources()Landroid/content/res/Resources;":
                return dm.Obj("Landroid/content/res/Resources;")
            if mem == "animate()" + PROPS:
                if a0.f.get("animator") is None:
                    a0.f["animator"] = dm.Obj(PROPS, view=a0, target={}, ms=None, end=None)
                return a0.f["animator"]
        if cls == "Landroid/content/res/Resources;" and mem == "getDisplayMetrics()Landroid/util/DisplayMetrics;":
            return dm.Obj("Landroid/util/DisplayMetrics;", density=DENSITY)
        if cls == PROPS:
            if mem == "cancel()V":
                if a0 in self.running:
                    self.running.remove(a0)
                a0.f["target"], a0.f["end"] = {}, None        # the end action of a cancelled animation never runs
                return None
            if mem == "alpha(F)" + PROPS:
                a0.f["target"]["alpha"] = dm.fv(args[1])
                return a0
            if mem == "translationY(F)" + PROPS:
                a0.f["target"]["ty"] = dm.fv(args[1])
                return a0
            if mem == "setDuration(J)" + PROPS:
                a0.f["ms"] = args[1]
                return a0
            if mem == "withEndAction(Ljava/lang/Runnable;)" + PROPS:
                a0.f["end"] = args[1]
                return a0
            if mem == "start()V":
                t = a0.f["target"]
                self.log.append((a0.f["view"].f.get("tag"), t.get("alpha"), t.get("ty"), a0.f["ms"], a0.f["end"] is not None))
                if a0 in self.running:
                    self.running.remove(a0)
                self.running.append(a0)
                if self.instant:
                    self.running.remove(a0)
                    self._end(a0)
                return None
        raise AssertionError("not faked: " + target)
