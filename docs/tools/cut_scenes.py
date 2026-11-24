#!/usr/bin/env python3
"""Cuts the landscapes of the keyboard out of the sheets the pictures come in.

A sheet is a picture of two landscapes side by side, each one with a thin black frame and round corners (or one landscape alone, with its frame).
The frame and the corners are cut away, the landscape is scaled to 480 pixels on its longer side (the size of the others in assets/mr_scenes) and written as a
WebP of quality 72, the way the app reads it (MrScenes).

    python3 docs/tools/cut_scenes.py SHEET NAME [NAME2] [--out assets/mr_scenes]

With one NAME the sheet is one landscape; with two it is cut in the middle, the left half is NAME and the right half is NAME2. NAME is the file without its
extension: sports_7, animals_8 ...
"""
import argparse
import os

import numpy as np
from PIL import Image

SIZE = 480          # the longer side of the file
QUALITY = 72        # the quality of the WebP
INSET = 14          # what is cut inside the picture, so that the round corners of its frame go too


def span(lum, axis, lo, hi):
    """The first and the last row (or column) between lo and hi that has something bright in it: the frame and the gap between the pictures are black."""
    line = lum[:, lo:hi].max(axis=0) if axis == 0 else lum[lo:hi, :].max(axis=1)
    lit = np.nonzero(line > 120)[0]
    return lo + int(lit[0]), lo + int(lit[-1]) + 1


def cut(im, lum, x0, x1):
    """The landscape inside its frame, between the columns x0 and x1 of the sheet, less the corners."""
    l, r = span(lum, 0, x0, x1)
    t, b = span(lum, 1, 0, im.height)
    return im.crop((l + INSET, t + INSET, r - INSET, b - INSET))


def scale(im):
    k = SIZE / float(max(im.size))
    return im.resize((max(1, round(im.width * k)), max(1, round(im.height * k))), Image.LANCZOS)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("sheet")
    ap.add_argument("names", nargs="+")
    ap.add_argument("--out", default=os.path.join(os.path.dirname(__file__), "..", "..", "assets", "mr_scenes"))
    a = ap.parse_args()
    if len(a.names) > 2:
        ap.error("a sheet has one landscape or two")
    im = Image.open(a.sheet)
    if im.mode == "RGBA":                       # a picture with an alpha channel: over black, as it is framed
        back = Image.new("RGB", im.size, (0, 0, 0))
        back.paste(im, mask=im.split()[3])
        im = back
    im = im.convert("RGB")
    w, h = im.size
    lum = np.asarray(im, dtype=np.int32).sum(axis=2)
    halves = [(0, w)] if len(a.names) == 1 else [(0, w // 2), (w // 2, w)]
    for name, (x0, x1) in zip(a.names, halves):
        out = scale(cut(im, lum, x0, x1))
        path = os.path.join(a.out, name + ".webp")
        out.save(path, "WEBP", quality=QUALITY, method=6)
        print("%s: %dx%d, %.1f KB" % (name, out.width, out.height, os.path.getsize(path) / 1024.0))


if __name__ == "__main__":
    main()
