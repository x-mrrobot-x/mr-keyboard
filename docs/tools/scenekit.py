"""The toolbox of docs/tools/make_scenes.py: a float picture (0 .. 1) that is drawn at twice its size and brought down, with the ways of putting colour
and light on it (masks, gradients, ridges of hills, noise, stars, bokeh, bloom). Needs numpy, Pillow and OpenCV (cv2)."""
import math

import cv2
import numpy as np
from PIL import Image, ImageDraw

W = 960          # the size the pictures are drawn at
OUT = 480        # the size of the files
QUALITY = 72     # of the WebP files

# the palette: deep blues and violets, with cyan, blue, violet, magenta and a little warm light
NIGHT = 0x03051a
DEEP = 0x070b30
INDIGO = 0x141a66
VIOLET = 0x5b2bd6
PURPLE = 0x8a3cff
MAGENTA = 0xff3cc8
PINK = 0xff7ad9
CYAN = 0x18d8ff
ICE = 0xbff3ff
BLUE = 0x2f6bff
WHITE = 0xffffff
AMBER = 0xffa23c
GREEN = 0x37ffb0


def rgb(h):
    return np.array([(h >> 16) & 255, (h >> 8) & 255, h & 255], np.float32) / 255.0


# ---------------------------------------------------------------- the toolbox

class Scene:
    """A picture being drawn: a float image (0 .. 1), with the ways of putting colour and light on it."""

    def __init__(self, seed):
        self.rng = np.random.RandomState(seed)
        self.img = np.zeros((W, W, 3), np.float32)
        self.yy, self.xx = np.mgrid[0:W, 0:W].astype(np.float32)

    # -- masks
    def mask(self, fn):
        """A mask (0 .. 1) of what fn draws with white on a black PIL image."""
        im = Image.new('L', (W, W), 0)
        fn(ImageDraw.Draw(im))
        return np.asarray(im, np.float32) / 255.0

    def poly(self, pts, width=0):
        return self.mask(lambda d: d.polygon([(float(x), float(y)) for x, y in pts], fill=255))

    def line(self, pts, width=3):
        return self.mask(lambda d: d.line([(float(x), float(y)) for x, y in pts], fill=255, width=int(width), joint='curve'))

    def ellipse(self, cx, cy, rx, ry):
        return self.mask(lambda d: d.ellipse([cx - rx, cy - ry, cx + rx, cy + ry], fill=255))

    def ring(self, cx, cy, r, width):
        return self.mask(lambda d: d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=255, width=int(width)))

    # -- paint
    def fill(self, colour):
        self.img[:] = rgb(colour)

    def vgrad(self, stops, y0=0, y1=None):
        """A vertical gradient: stops = [(position 0 .. 1, colour), ...] from y0 to y1."""
        y1 = W if y1 is None else y1
        t = np.clip((self.yy[:, 0] - y0) / max(1.0, y1 - y0), 0, 1)
        ps = [p for p, _ in stops]
        cols = np.stack([rgb(c) for _, c in stops])
        col = np.stack([np.interp(t, ps, cols[:, k]) for k in range(3)], axis=1)
        self.img[:] = col[:, None, :]

    def over(self, m, colour, alpha=1.0):
        """The colour (or an image of colours) over the picture where the mask is."""
        c = rgb(colour) if np.isscalar(colour) else colour
        m3 = (m * alpha)[:, :, None]
        self.img = self.img * (1 - m3) + c * m3

    def light(self, m, colour, gain=1.0, blurs=(0, 3, 10, 28), shares=(1.0, 0.6, 0.45, 0.35)):
        """Light made by the mask: itself and some blurs of it, added with the screen mode (what glows, glows wider)."""
        c = rgb(colour) if np.isscalar(colour) else colour
        total = np.zeros_like(m)
        for b, s in zip(blurs, shares):
            total += (cv2.GaussianBlur(m, (0, 0), b) if b else m) * s
        total = np.clip(total * gain, 0, 1)[:, :, None]
        self.img = 1 - (1 - self.img) * (1 - total * c)

    def tint(self, m, colour, alpha):
        """Mixes the colour into the picture where the mask is (a haze, a glow with no lighter centre)."""
        self.over(m, colour, alpha)

    # -- shapes of the landscapes
    def fbm1(self, n, octaves=5, persistence=0.5, base=4, seed=None):
        """Fractal noise along a line of n points, 0 .. 1."""
        rng = np.random.RandomState(seed) if seed is not None else self.rng
        out = np.zeros(n, np.float32)
        amp, tot = 1.0, 0.0
        for o in range(octaves):
            k = base * (2 ** o)
            pts = rng.rand(k + 2).astype(np.float32)
            out += np.interp(np.linspace(0, k, n), np.arange(k + 2), pts) * amp
            tot += amp
            amp *= persistence
        out /= tot
        return (out - out.min()) / max(1e-6, out.max() - out.min())

    def fbm2(self, octaves=5, base=3, persistence=0.55):
        """Fractal noise over the picture, 0 .. 1 (clouds, fog)."""
        out = np.zeros((W, W), np.float32)
        amp, tot = 1.0, 0.0
        for o in range(octaves):
            k = base * (2 ** o)
            n = cv2.resize(self.rng.rand(k + 1, k + 1).astype(np.float32), (W, W), interpolation=cv2.INTER_CUBIC)
            out += n * amp
            tot += amp
            amp *= persistence
        out /= tot
        return np.clip((out - out.min()) / max(1e-6, out.max() - out.min()), 0, 1)

    def ridge(self, y_base, amp, base=3, octaves=5, seed=None, persistence=0.5):
        """The height line of a ridge of hills: y for every x."""
        n = self.fbm1(W, octaves, persistence, base, seed)
        return y_base - n * amp

    def below(self, ys):
        """The mask of what is under a line given as y for every x."""
        return (self.yy >= ys[None, :]).astype(np.float32)

    def fog(self, colour, y, thick, alpha, seed_scale=1.0):
        n = self.fbm2(4, 3)
        band = np.exp(-((self.yy - y) / thick) ** 2)
        self.over(np.clip(band * (0.45 + n), 0, 1), colour, alpha)

    def stars(self, count, ymax=None, size=1.0, colour=WHITE, gain=1.0, twinkle=0.7):
        ymax = W if ymax is None else ymax
        m = np.zeros((W, W), np.float32)
        xs = self.rng.randint(0, W, count)
        ys = (self.rng.rand(count) ** 1.3 * ymax).astype(int)
        br = self.rng.rand(count) ** 2.2
        for x, y, b in zip(xs, ys, br):
            r = 1 if b < 0.6 else 2
            m[max(0, y - r + 1):y + r, max(0, x - r + 1):x + r] = max(m[y, x], 0.25 + 0.75 * b * twinkle)
        self.light(m, colour, gain, blurs=(0, 2, 6), shares=(1.0, 0.8, 0.5))

    def dust(self, count, colour, rmin=2, rmax=8, ymin=0, ymax=None, gain=1.0, soft=True):
        """Round bokeh lights (little soft discs)."""
        ymax = W if ymax is None else ymax
        m = np.zeros((W, W), np.float32)
        for _ in range(count):
            x = self.rng.randint(0, W)
            y = self.rng.randint(ymin, ymax)
            r = self.rng.uniform(rmin, rmax)
            cv2.circle(m, (x, y), int(r), float(self.rng.uniform(0.35, 1.0)), -1, cv2.LINE_AA)
        self.light(m, colour, gain, blurs=(0, 2, 7) if soft else (0, 1), shares=(1.0, 0.7, 0.4) if soft else (1.0, 0.5))

    def snow(self, count, ymin=0, ymax=None, rmax=3.2, gain=0.9, colour=0xe6f6ff):
        ymax = W if ymax is None else ymax
        m = np.zeros((W, W), np.float32)
        for _ in range(count):
            x = self.rng.randint(0, W)
            y = self.rng.randint(ymin, ymax)
            r = self.rng.uniform(0.8, rmax)
            cv2.circle(m, (x, y), max(1, int(r)), float(self.rng.uniform(0.4, 1.0)), -1, cv2.LINE_AA)
        self.light(m, colour, gain, blurs=(0, 2), shares=(1.0, 0.6))

    def glass_orb(self, cx, cy, r, colour, gain=1.0):
        """A big soft disc with a bright rim (a moon, a sun, a planet)."""
        d = np.sqrt((self.xx - cx) ** 2 + (self.yy - cy) ** 2)
        disc = np.clip((r - d) / 2.5, 0, 1)
        self.over(disc, colour, 1.0)
        self.light(disc, colour, 0.9 * gain, blurs=(0, 14, 40, 90), shares=(0.0, 0.6, 0.5, 0.4))

    # -- the end
    def finish(self, vignette=0.45, bloom=0.30, grain=0.012):
        img = np.clip(self.img, 0, 1)
        # bloom: the bright parts spread a little
        hi = np.clip(img - 0.55, 0, 1)
        img = 1 - (1 - img) * (1 - cv2.GaussianBlur(hi, (0, 0), 16) * bloom * 2.2)
        # a vignette
        d = np.sqrt(((self.xx - W / 2) / (W / 2)) ** 2 + ((self.yy - W / 2) / (W / 2)) ** 2)
        img = img * (1 - vignette * np.clip(d - 0.55, 0, 1) ** 1.6)[:, :, None]
        # a little grain (not much: it would make the files heavy)
        rng = np.random.RandomState(7)
        img = img + (rng.rand(W, W, 1).astype(np.float32) - 0.5) * grain
        img = np.clip(img, 0, 1)
        out = cv2.resize((img * 255 + 0.5).astype(np.uint8), (OUT, OUT), interpolation=cv2.INTER_AREA)
        return Image.fromarray(out)


def rim_from(scene, m, dx, dy, width=2):
    """The edge of a shape that faces the light that comes from (dx, dy): the shape less the shape moved the other way."""
    sh = np.roll(np.roll(m, -dy, axis=0), -dx, axis=1)
    e = np.clip(m - sh, 0, 1)
    return cv2.GaussianBlur(e, (0, 0), width)


def circle_pts(cx, cy, r, n=64, a0=0.0, a1=2 * math.pi):
    return [(cx + r * math.cos(a0 + (a1 - a0) * i / n), cy + r * math.sin(a0 + (a1 - a0) * i / n)) for i in range(n + 1)]


def bezier(p0, p1, p2, p3, n=40):
    out = []
    for i in range(n + 1):
        t = i / n
        a = (1 - t) ** 3
        b = 3 * (1 - t) ** 2 * t
        c = 3 * (1 - t) * t ** 2
        d = t ** 3
        out.append((a * p0[0] + b * p1[0] + c * p2[0] + d * p3[0], a * p0[1] + b * p1[1] + c * p2[1] + d * p3[1]))
    return out


def tree_pine(s, x, base, h, w, layers=7):
    """A pine: layers of triangles, as a list of polygon points (a mask is made by the caller)."""
    pts = []
    for i in range(layers):
        t0 = i / layers
        y_top = base - h + h * t0 * 0.92
        y_bot = base - h * (1 - (i + 1) / layers) * 0.98 - h * 0.04
        wi = w * (0.25 + 0.75 * (i + 1) / layers)
        pts.append([(x, y_top), (x + wi / 2, y_bot), (x - wi / 2, y_bot)])
    return pts


