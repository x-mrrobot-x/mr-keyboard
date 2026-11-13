#!/usr/bin/env python3
"""Tests the blurred icon shadows (ShadowDrawHelper.smali) and the render mode of the keyboard view (GlobalKeyboardSettings).

Run it from the project root:  python3 -I docs/tools/test_shadow_cache.py

Runs the REAL smali in the mini Dalvik interpreter (dalvik_mini.py) with a fake framework: bitmaps that remember whether they were
recycled, a canvas that records what it draws, drawables with bounds, alpha, level and a current child (a state list), and a blur
(extractAlpha) that counts how many times it runs. The rules (docs/plan-performance.md, stage 1):
  - the shadow of an icon is blurred once and kept; the next frames only draw the kept bitmap, at the offset extractAlpha gave;
  - it is found again by the drawable really drawn (getCurrent), the size of the key, the bounds, alpha and level of the drawable and
    the radius; the colour filter is not part of it (it is applied when drawing) and is taken off the paint afterwards;
  - 24 places, the oldest replaced first; a kept or replaced bitmap is never recycled, the bitmap of the key is recycled at once;
  - nothing is drawn for a key with no size, for a radius of 0 or less, or when extractAlpha gives nothing (and no place is used);
  - a failure while drawing the icon leaves the work canvas without a bitmap, recycles the bitmap of the key and goes up;
  - the keyboard view has no layer: the render mode is 0 (it was 1, a software layer).
"""
import os
import sys

ROOT = os.getcwd()
sys.path.insert(0, os.path.join(ROOT, "docs", "tools"))
import dalvik_mini as dm  # noqa: E402

APP = os.path.join(ROOT, "smali", "com", "mrkeyboard", "app")
HELPER = "Lcom/mrkeyboard/app/ShadowDrawHelper;"
SETTINGS = "Lcom/mrkeyboard/app/GlobalKeyboardSettings;"
DRAW = "draw(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V"

ok = fails = 0


def check(name, cond, extra=""):
    global ok, fails
    if cond:
        ok += 1
        print("OK    " + name)
    else:
        fails += 1
        print("FAIL  " + name + (" | " + str(extra) if extra else ""))


class Fw:
    """The fake framework and the host of the interpreter."""

    def __init__(self):
        self.blurs = 0                 # extractAlpha calls
        self.masks = []                # radius of each BlurMaskFilter made
        self.bitmaps = []              # every bitmap made (key bitmaps and blurred alphas)
        self.drawn = []                # (bitmap, x, y, filter on the paint) of each drawBitmap on a screen canvas
        self.alpha_none = False        # extractAlpha gives null
        self.icon_fails = False        # Drawable.draw throws
        self.vm = dm.VM(HELPER, dm.parse_methods(os.path.join(APP, "ShadowDrawHelper.smali")), self)
        self.vm.run("<clinit>()V", [])
        self.work = self.vm.statics["sTmpCanvas"]
        self.paint = self.vm.statics["sColorPaint"]

    # --- objects of the test
    def drawable(self, l=0, t=0, r=40, b=40, alpha=255, level=0, children=None):
        d = dm.Obj("Landroid/graphics/drawable/Drawable;", bounds=dm.Obj("Landroid/graphics/Rect;", left=l, top=t, right=r, bottom=b),
                   alpha=alpha, level=level, children=children, current=0)
        return d

    def key(self, w=100, h=150):
        return dm.Obj("Lcom/mrkeyboard/app/Keyboard$Key;", width=w, height=h)

    def canvas(self):
        return dm.Obj("Landroid/graphics/Canvas;", bitmap=None, screen=True)

    def draw(self, d, k, radius=3.0, flt=None, c=None):
        self.vm.run(DRAW, [c or self.canvas(), d, k, dm.f32(radius), flt])

    def built(self):
        return self.vm.statics.get("sBuilt", 0)

    # --- the host
    def sget(self, cls, name):
        if cls == "Landroid/graphics/Bitmap$Config;":
            return name
        if cls == "Landroid/graphics/BlurMaskFilter$Blur;":
            return name
        raise AssertionError("static not faked: %s.%s" % (cls, name))

    def new_instance(self, cls):
        return dm.Obj(cls)

    def instance_of(self, obj, cls):
        return obj is not None and obj.cls == cls

    def invoke(self, vm, op, target, args):
        cls, _, mem = target.partition("->")
        if mem.startswith("set") and "(L" in mem:     # setBitmap/setColorFilter/setMaskFilter(null): const/4 0x0 is null in Dalvik
            args = [args[0]] + [None if a == 0 else a for a in args[1:]]
        a0 = args[0] if args else None
        if mem == "<init>()V" and cls in ("Ljava/lang/Object;", "Landroid/graphics/Paint;", "Landroid/graphics/Canvas;"):
            if cls == "Landroid/graphics/Paint;":
                a0.f.update(filter=None, mask=None)
            if cls == "Landroid/graphics/Canvas;":
                a0.f.update(bitmap=None, screen=False)
            return None
        if cls == "Landroid/graphics/BlurMaskFilter;" and mem.startswith("<init>"):
            assert args[2] == "OUTER", args[2]
            a0.f["radius"] = dm.fv(args[1])
            self.masks.append(dm.fv(args[1]))
            return None
        if cls == "Landroid/graphics/Paint;":
            if mem == "setMaskFilter(Landroid/graphics/MaskFilter;)Landroid/graphics/MaskFilter;":
                a0.f["mask"] = args[1]
                return args[1]
            if mem == "setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;":
                a0.f["filter"] = args[1]
                return args[1]
        if cls == "Landroid/graphics/Bitmap;":
            if mem == "createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;":
                assert args[2] == "ARGB_8888"
                b = dm.Obj("Landroid/graphics/Bitmap;", w=args[0], h=args[1], kind="key", recycled=False, painted=[])
                self.bitmaps.append(b)
                return b
            if mem == "extractAlpha(Landroid/graphics/Paint;[I)Landroid/graphics/Bitmap;":
                assert args[1].f["mask"] is not None, "the blur paint has no mask filter"
                assert not a0.f["recycled"]
                self.blurs += 1
                if self.alpha_none:
                    return None
                r = int(args[1].f["mask"].f["radius"])
                args[2][0], args[2][1] = -r, -r
                b = dm.Obj("Landroid/graphics/Bitmap;", w=a0.f["w"] + 2 * r, h=a0.f["h"] + 2 * r, kind="alpha", recycled=False,
                           source=tuple(a0.f["painted"]), radius=r)
                self.bitmaps.append(b)
                return b
            if mem == "recycle()V":
                a0.f["recycled"] = True
                return None
        if cls == "Landroid/graphics/Canvas;":
            if mem == "setBitmap(Landroid/graphics/Bitmap;)V":
                a0.f["bitmap"] = args[1]
                return None
            if mem == "drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V":
                assert a0.f["screen"], "drawn on the work canvas"
                assert not args[1].f["recycled"], "a recycled bitmap was drawn"
                self.drawn.append((args[1], dm.fv(args[2]), dm.fv(args[3]), args[4].f["filter"]))
                return None
        if cls == "Landroid/graphics/drawable/Drawable;":
            if mem == "getBounds()Landroid/graphics/Rect;":
                return a0.f["bounds"]
            if mem == "getAlpha()I":
                return a0.f["alpha"]
            if mem == "getLevel()I":
                return a0.f["level"]
            if mem == "getCurrent()Landroid/graphics/drawable/Drawable;":
                ch = a0.f["children"]
                return ch[a0.f["current"]] if ch else a0
            if mem == "draw(Landroid/graphics/Canvas;)V":
                if self.icon_fails:
                    raise dm.JavaExc("Ljava/lang/IllegalStateException;", "icon")
                bmp = args[1].f["bitmap"]
                assert bmp is not None and not args[1].f["screen"]
                b = a0.f["bounds"].f
                bmp.f["painted"].append((id(a0), b["left"], b["top"], b["right"], b["bottom"]))
                return None
        raise AssertionError("not faked: " + target)


# ---------------------------------------------------------------- the shadow is blurred once
fw = Fw()
icon, key = fw.drawable(10, 20, 50, 60), fw.key()
red, blue = dm.Obj("Landroid/graphics/ColorFilter;", c="red"), dm.Obj("Landroid/graphics/ColorFilter;", c="blue")
fw.draw(icon, key, 3.0, red)
check("first frame: one blur", fw.blurs == 1 and fw.built() == 1, (fw.blurs, fw.built()))
check("one mask filter of the radius", fw.masks == [3.0], fw.masks)
src = [b for b in fw.bitmaps if b.f["kind"] == "key"]
check("the bitmap of the key has the size of the key and is recycled", len(src) == 1 and (src[0].f["w"], src[0].f["h"]) == (100, 150)
      and src[0].f["recycled"], [(b.f["w"], b.f["h"], b.f["recycled"]) for b in src])
check("the icon was drawn on it at its bounds", src[0].f["painted"] == [(id(icon), 10, 20, 50, 60)], src[0].f["painted"])
check("the work canvas is left without a bitmap", fw.work.f["bitmap"] is None)
b1, x, y, f = fw.drawn[-1]
check("drawn at the offset of extractAlpha, with the filter of the call", b1.f["kind"] == "alpha" and (x, y) == (-3.0, -3.0) and f is red,
      (b1.f["kind"], x, y, f))
check("the filter is taken off the paint afterwards", fw.paint.f["filter"] is None)

for _ in range(5):
    fw.draw(icon, key, 3.0, red)
check("five more frames: no new blur, no new bitmap", fw.blurs == 1 and len(fw.bitmaps) == 2, (fw.blurs, len(fw.bitmaps)))
check("they draw the same kept bitmap", all(d[0] is b1 for d in fw.drawn) and len(fw.drawn) == 6)
check("the kept bitmap is not recycled", not b1.f["recycled"])

fw.draw(icon, key, 3.0, blue)
check("another colour: same shadow, the new filter", fw.blurs == 1 and fw.drawn[-1][0] is b1 and fw.drawn[-1][3] is blue)
fw.draw(icon, key, 3.0, None)
check("no filter: same shadow, no filter on the paint", fw.blurs == 1 and fw.drawn[-1][3] is None)

# ---------------------------------------------------------------- what makes a new shadow
fw.draw(icon, key, 4.0, red)
check("another radius: blurred again with a new mask", fw.blurs == 2 and fw.masks == [3.0, 4.0], (fw.blurs, fw.masks))
fw.draw(icon, key, 3.0, red)
check("back to the first radius: the first shadow again (new mask for the paint, no blur)", fw.blurs == 2 and fw.drawn[-1][0] is b1)
fw.draw(icon, fw.key(120, 150), 3.0, red)
check("a key of another size: blurred again", fw.blurs == 3)
icon.f["bounds"].f["left"] = 12
fw.draw(icon, key, 3.0, red)
check("other bounds: blurred again", fw.blurs == 4)
icon.f["bounds"].f["left"] = 10
fw.draw(icon, key, 3.0, red)
check("the first bounds again: no blur", fw.blurs == 4 and fw.drawn[-1][0] is b1)
icon.f["alpha"] = 128
fw.draw(icon, key, 3.0, red)
check("another alpha: blurred again", fw.blurs == 5)
icon.f["alpha"] = 255
icon.f["level"] = 3
fw.draw(icon, key, 3.0, red)
check("another level: blurred again", fw.blurs == 6)
icon.f["level"] = 0

on, off = fw.drawable(), fw.drawable()
state = fw.drawable(children=[on, off])
fw.draw(state, key, 3.0, red)
n = fw.blurs
state.f["current"] = 1
fw.draw(state, key, 3.0, red)
check("a state list: another child is another shadow", fw.blurs == n + 1)
state.f["current"] = 0
fw.draw(state, key, 3.0, red)
check("the first child again: kept", fw.blurs == n + 1)
other = fw.drawable(10, 20, 50, 60)
fw.draw(other, key, 3.0, red)
check("another drawable with the same bounds: its own shadow", fw.blurs == n + 2)

# ---------------------------------------------------------------- nothing to draw
fw = Fw()
icon = fw.drawable()
fw.draw(icon, fw.key(0, 150))
fw.draw(icon, fw.key(100, 0))
fw.draw(icon, fw.key(), 0.0)
fw.draw(icon, fw.key(), -2.0)
check("no size or no radius: nothing blurred, nothing drawn", fw.blurs == 0 and not fw.drawn and not fw.bitmaps)
fw.alpha_none = True
fw.draw(icon, fw.key())
check("extractAlpha gives nothing: nothing drawn, no place used", fw.blurs == 1 and not fw.drawn and fw.built() == 0
      and fw.vm.statics["sNext"] == 0)
check("... and the bitmap of the key is recycled", fw.bitmaps[0].f["recycled"])
fw.alpha_none = False
fw.draw(icon, fw.key())
check("the next time it is blurred and kept", fw.blurs == 2 and len(fw.drawn) == 1 and fw.built() == 1)

fw = Fw()
fw.icon_fails = True
try:
    fw.draw(fw.drawable(), fw.key())
    raised = False
except dm.JavaExc:
    raised = True
check("the icon fails: the failure goes up", raised)
check("... the work canvas has no bitmap and the key bitmap is recycled", fw.work.f["bitmap"] is None and fw.bitmaps[0].f["recycled"])
check("... nothing kept", fw.built() == 0 and not fw.drawn)

# ---------------------------------------------------------------- 24 places
fw = Fw()
icons = [fw.drawable(i, 0, i + 30, 30) for i in range(25)]
k = fw.key()
for d in icons[:24]:
    fw.draw(d, k)
first = fw.drawn[0][0]
for d in icons[:24]:
    fw.draw(d, k)
check("24 icons: 24 blurs, the second round is all kept", fw.blurs == 24, fw.blurs)
fw.draw(icons[24], k)
check("the 25th takes the place of the oldest", fw.blurs == 25 and fw.vm.statics["sNext"] == 1, (fw.blurs, fw.vm.statics["sNext"]))
check("the replaced bitmap is not recycled", not first.f["recycled"])
fw.draw(icons[1], k)
check("the second one is still kept", fw.blurs == 25)
fw.draw(icons[0], k)
check("the first one is blurred again", fw.blurs == 26)
alphas = [b for b in fw.bitmaps if b.f["kind"] == "alpha"]
check("no blurred alpha was ever recycled", not any(b.f["recycled"] for b in alphas))

# ---------------------------------------------------------------- render mode of the keyboard view
lines = [l.strip() for l in open(os.path.join(APP, "GlobalKeyboardSettings.smali"), encoding="utf-8")]
start = next(i for i, l in enumerate(lines) if l.startswith(".method public constructor <init>()V"))
end = next(i for i in range(start, len(lines)) if lines[i] == ".end method")
body = [l for l in lines[start:end] if l and not l.startswith("#") and not l.startswith(".line")]
put = next(i for i, l in enumerate(body) if l.endswith("->renderMode:I"))
reg = body[put].split()[1].rstrip(",")
writes = [l for l in body[:put] if l.split()[0].startswith(("const", "move", "iget", "sget", "add", "mul")) and l.split()[1].rstrip(",") == reg]
check("the render mode is 0 (no layer)", body[put].startswith("iput ") and writes and writes[-1] == "const/4 %s, 0x0" % reg,
      (body[put], writes[-1:] if writes else None))
check("no other code sets the render mode", sum("->renderMode:I" in l and l.strip().startswith("iput") for f in os.listdir(APP)
                                              if f.endswith(".smali")
                                              for l in open(os.path.join(APP, f), encoding="utf-8").read().split("\n")) == 1)

print("\n%d OK, %d FAIL" % (ok, fails))
sys.exit(1 if fails else 0)
