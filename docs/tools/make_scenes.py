#!/usr/bin/env python3
"""Draws the landscapes number 7 and 8 of each category of the landscapes of the keyboard background (assets/mr_scenes/<category>_<n>.webp).

The first six of each category are pictures cut from sheets (see docs/themes-screen.md); these twelve are drawn here, in code, in the same dark
neon way (deep blue and violet, cyan and magenta light), so the same program draws them again whenever a detail changes:

    python3 docs/tools/make_scenes.py                  # writes the twelve WebP files in assets/mr_scenes
    python3 docs/tools/make_scenes.py --png <folder>   # also keeps the PNG of each (for the tests with the real pictures) and a contact sheet
    python3 docs/tools/make_scenes.py --only sports_7  # only one

Needs numpy, Pillow (with WebP) and OpenCV (cv2). The drawing is deterministic (every random number comes from a seed), so the files are the same
each time. Each picture is made at twice its size and brought down, which smooths every edge (the toolbox is scenekit.py).
"""
import argparse
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import cv2
import numpy as np
from PIL import Image

from scenekit import *  # noqa: F401,F403
from scenekit import W, OUT, QUALITY, Scene, rim_from, circle_pts, bezier, tree_pine, rgb

SCENES = {}


def scene(name):
    def deco(fn):
        SCENES[name] = fn
        return fn
    return deco


# ---------------------------------------------------------------- sports

@scene('sports_7')
def sports_7():
    """A running track at night under the floodlights of a stadium: the lanes run to the horizon, the stands are a band of little lights."""
    s = Scene(701)
    hor = 440
    s.vgrad([(0, NIGHT), (0.30, DEEP), (0.46, 0x2a1670), (0.5, 0x4a1c8a), (0.52, 0x120a38), (1, 0x080422)])
    s.stars(260, ymax=300, gain=0.8)
    # the stands: a dark band at the horizon with the lights of the crowd
    stand = s.poly([(0, hor - 70), (260, hor - 38), (480, hor - 30), (700, hor - 38), (960, hor - 70), (960, hor), (0, hor)])
    s.over(stand, 0x0a0a2e, 0.95)
    for row, col in enumerate([BLUE, CYAN, PURPLE, MAGENTA, CYAN]):
        s.dust(150 - row * 14, col, 1, 3, ymin=hor - 66 + row * 12, ymax=hor - 22 + row * 4, gain=0.8, soft=False)
    s.dust(60, WHITE, 2, 5, ymin=hor - 70, ymax=hor - 10, gain=0.6)
    # the roof line of the stand: a thin bright edge
    roof = s.line([(0, hor - 70), (260, hor - 38), (480, hor - 30), (700, hor - 38), (960, hor - 70)], 3)
    s.light(roof, ICE, 0.7)
    # floodlight towers: little banks of lights on masts, with beams to the track
    for tx, ty in [(110, 190), (300, 240), (660, 240), (850, 190)]:
        s.over(s.line([(tx, ty + 30), (tx, hor - 40)], 6), 0x0b0b30)
        bank = np.zeros((W, W), np.float32)
        for i in range(4):
            for j in range(3):
                cv2.circle(bank, (tx - 36 + i * 24, ty - 20 + j * 20), 7, 1.0, -1, cv2.LINE_AA)
        s.light(bank, WHITE, 1.2, blurs=(0, 6, 20, 50), shares=(1.0, 0.8, 0.6, 0.5))
        beam = s.poly([(tx - 40, ty), (tx + 40, ty), (tx + (480 - tx) * 1.3 + 260, 960), (tx + (480 - tx) * 1.3 - 260, 960)])
        beam = cv2.GaussianBlur(beam, (0, 0), 26) * np.clip((s.yy - ty) / 700.0, 0, 1) ** 1.2 * np.clip(1 - (s.yy - ty) / 900.0, 0, 1)
        s.light(beam, 0x7fb6ff, 0.55, blurs=(0,), shares=(1.0,))
    # the track: a surface in perspective, lanes that run to the horizon
    ground = s.below(np.full(W, hor, np.float32))
    surf = np.clip((s.yy - hor) / (W - hor), 0, 1)
    track = np.stack([0.10 + 0.20 * surf, 0.04 + 0.05 * surf, 0.30 + 0.20 * surf], axis=2)
    s.img = s.img * (1 - ground[:, :, None]) + track * ground[:, :, None]
    vp = (480, hor)
    lanes = []
    for k in range(-9, 10):
        bx = 480 + k * 150
        lanes.append((k, s.line([vp, (bx, W + 40)], 3 if k % 2 else 5)))
    for k, m in lanes:
        col = CYAN if k % 3 == 0 else (MAGENTA if k % 3 == 1 else ICE)
        # the lines get wider and brighter toward the viewer
        s.light(m * np.clip((s.yy - hor) / 260.0, 0, 1) * ground, col, 0.9, blurs=(0, 3, 10), shares=(1.0, 0.8, 0.5))
    # the lines across (start and finish): their spacing grows with the distance
    for z in [1.0, 1.6, 2.6, 4.4, 7.5]:
        y = hor + 22 * z ** 1.25
        if y < W:
            width = max(2, int(2 + (y - hor) / 55))
            m = s.line([(0, y), (W, y)], width)
            s.light(m * ground, WHITE, 0.7, blurs=(0, 4, 14), shares=(1.0, 0.7, 0.5))
    # a banner across the track at the far end, with a checker
    banner = np.zeros((W, W), np.float32)
    for i in range(30):
        for j in range(2):
            if (i + j) % 2 == 0:
                x0 = 300 + i * 12
                cv2.rectangle(banner, (x0, hor - 52 + j * 9), (x0 + 11, hor - 44 + j * 9), 1.0, -1)
    s.light(banner, WHITE, 0.9, blurs=(0, 2, 8), shares=(1.0, 0.6, 0.4))
    # the track reflects the lights
    refl = cv2.GaussianBlur(np.flipud(np.roll(s.img * 0, 0, axis=0)), (0, 0), 1)
    for tx in [110, 300, 660, 850]:
        streak = s.poly([(tx - 8 + (480 - tx) * 0.2, hor + 4), (tx + 8 + (480 - tx) * 0.2, hor + 4), (tx + 60 + (480 - tx) * 0.9, W), (tx - 60 + (480 - tx) * 0.9, W)])
        s.light(cv2.GaussianBlur(streak, (0, 0), 14) * np.clip((s.yy - hor) / 500.0, 0, 1) * ground, 0x8fb8ff, 0.5, blurs=(0,), shares=(1.0,))
    s.fog(0x3a2a9a, hor, 40, 0.35)
    s.dust(40, ICE, 1, 3, ymin=hor, ymax=W, gain=0.5)
    return s.finish()


@scene('sports_8')
def sports_8():
    """A glowing archery target with the arrow that has just hit it, in front of the lights of a stadium."""
    s = Scene(801)
    s.vgrad([(0, NIGHT), (0.35, DEEP), (0.62, 0x1b1470), (0.70, 0x0a0830), (1, 0x04041a)])
    s.stars(120, ymax=400, gain=0.7)
    # far lights of the stadium: bokeh in two bands
    s.dust(46, CYAN, 6, 18, ymin=120, ymax=420, gain=0.55)
    s.dust(34, MAGENTA, 6, 16, ymin=160, ymax=460, gain=0.5)
    s.dust(26, WHITE, 3, 9, ymin=100, ymax=380, gain=0.5)
    cx, cy = 480, 470
    # the floor: a grid in perspective, lit under the target
    fl = 700
    floor = s.below(np.full(W, fl, np.float32))
    s.img = s.img * (1 - floor[:, :, None] * 0.7) + rgb(0x0a0a38) * floor[:, :, None] * 0.7
    for k in range(-12, 13):
        m = s.line([(480, fl), (480 + k * 230, W + 40)], 2)
        s.light(m * floor, BLUE, 0.55, blurs=(0, 3, 9), shares=(1.0, 0.7, 0.4))
    for i, y in enumerate([fl + 8, fl + 28, fl + 62, fl + 118, fl + 200]):
        m = s.line([(0, y), (W, y)], 2 + i)
        s.light(m * floor, BLUE, 0.5, blurs=(0, 3, 9), shares=(1.0, 0.7, 0.4))
    # the stand of the target: two legs
    for dx in (-1, 1):
        leg = s.line([(cx + dx * 40, cy + 200), (cx + dx * 180, fl + 90)], 14)
        s.over(leg, 0x0d0d3c)
        s.light(rim_from(s, leg, -dx * 3, 0, 2), CYAN, 0.8, blurs=(0, 3), shares=(1.0, 0.6))
    # the target: rings, from the edge to the centre
    rings = [(300, 0x1a2fa8), (250, CYAN), (200, 0x1a2fa8), (150, WHITE), (100, MAGENTA), (50, AMBER)]
    base = s.ellipse(cx, cy, 306, 306)
    s.over(base, 0x080a30)
    for r, col in rings:
        face = s.ellipse(cx, cy, r, r)
        s.over(face, col, 0.55)
        edge = s.ring(cx, cy, r, 6)
        s.light(edge, col, 1.0, blurs=(0, 4, 14, 36), shares=(1.0, 0.8, 0.6, 0.5))
    s.light(s.ellipse(cx, cy, 26, 26), WHITE, 1.4, blurs=(0, 6, 24), shares=(1.0, 0.8, 0.6))
    # a light from the target on the floor
    glow = s.ellipse(cx, fl + 60, 360, 40)
    s.light(cv2.GaussianBlur(glow, (0, 0), 30), CYAN, 0.6, blurs=(0,), shares=(1.0,))
    # the arrow: a shaft that comes in from the upper right to the middle of the target, with the feathers at the other end
    tip = (cx + 12, cy - 10)
    tail = (cx + 420, cy - 300)
    shaft = s.line([tip, tail], 9)
    s.over(shaft, 0x20204a)
    s.light(shaft, ICE, 0.9, blurs=(0, 3, 12), shares=(1.0, 0.8, 0.5))
    ang = math.atan2(tail[1] - tip[1], tail[0] - tip[0])
    for k, col in enumerate([MAGENTA, CYAN, MAGENTA]):
        d0 = 0.80 + k * 0.07
        bx = tip[0] + (tail[0] - tip[0]) * d0
        by = tip[1] + (tail[1] - tip[1]) * d0
        for sgn in (-1, 1):
            nx, ny = -math.sin(ang) * sgn, math.cos(ang) * sgn
            fe = s.poly([(bx, by), (bx + (tail[0] - tip[0]) * 0.05, by + (tail[1] - tip[1]) * 0.05),
                         (bx + (tail[0] - tip[0]) * 0.05 + nx * 38, by + (tail[1] - tip[1]) * 0.05 + ny * 38), (bx + nx * 38, by + ny * 38)])
            s.over(fe, col, 0.55)
            s.light(fe, col, 0.8, blurs=(0, 4, 12), shares=(1.0, 0.7, 0.5))
    # sparks round the hit, and the trail of the arrow
    trail = s.line([(tail[0] + 30, tail[1] - 22), (tail[0] + 200, tail[1] - 150)], 4)
    s.light(cv2.GaussianBlur(trail, (0, 0), 2) * 0.8, CYAN, 0.8)
    s.dust(70, ICE, 1, 4, ymin=250, ymax=700, gain=0.7)
    s.fog(0x2a1c8a, fl, 60, 0.35)
    return s.finish()


# ---------------------------------------------------------------- animals

def stag_mask(s, ox, oy, k=1.0, flip=False):
    """The silhouette of a stag (a mask), standing with the head up; (ox, oy) is the middle of the body."""
    sx = -1 if flip else 1

    def P(x, y):
        return (ox + sx * x * k, oy + y * k)

    polys = []
    body = []
    for t in np.linspace(0, 2 * math.pi, 60):
        body.append(P(128 * math.cos(t), 54 * math.sin(t) - 5 * math.cos(t) ** 2))
    polys.append(body)
    polys.append([P(x, y) for x, y in circle_pts(96, -4, 60, 36)])           # the chest
    polys.append([P(x, y) for x, y in circle_pts(-102, -4, 56, 36)])         # the rump
    polys.append([P(66, -52), P(112, -66), P(168, -134), P(200, -122), P(150, -6), P(96, 34)])   # the neck
    polys.append([P(x, y) for x, y in circle_pts(186, -138, 25, 24)])        # the head
    polys.append([P(176, -150), P(246, -122), P(250, -108), P(182, -108)])   # the muzzle
    polys.append([P(168, -156), P(146, -190), P(190, -166)])                  # the ears
    polys.append([P(190, -160), P(188, -198), P(214, -166)])
    polys.append([P(-160, -34), P(-190, -48), P(-170, -4)])                   # the tail
    # the legs: thick enough to be seen at the size of the keyboard, with the hooves
    for pts in ([(84, 30), (116, 30), (108, 130), (112, 202), (96, 210), (90, 130)],
                [(50, 34), (80, 34), (74, 130), (78, 202), (62, 210), (56, 130)],
                [(-112, 20), (-80, 20), (-90, 96), (-66, 150), (-72, 202), (-88, 210), (-98, 150), (-122, 96)],
                [(-78, 30), (-50, 30), (-58, 96), (-40, 150), (-46, 202), (-62, 210), (-68, 150), (-84, 96)]):
        polys.append([P(x, y) for x, y in pts])
    m = np.zeros((W, W), np.float32)
    for pts in polys:
        m = np.maximum(m, s.poly(pts))
    return m


def antler_lines(ox, oy, k, flip):
    """The antlers as a list of (points, width): a main beam that sweeps up and back, with tines that point forward and up."""
    sx = -1 if flip else 1
    out = []

    def P(x, y):
        return (ox + sx * x * k, oy + y * k)

    for side, (dx, thick) in enumerate([(0, 1.0), (34, 0.7)]):
        beam = bezier(P(176 + dx * 0.4, -150), P(120 + dx, -230), P(70 + dx, -300), P(118 + dx, -400), 60)
        out.append((beam, int(13 * thick)))
        for t, length, ang in [(0.16, 70, 35), (0.34, 96, 40), (0.52, 100, 48), (0.72, 84, 58), (0.88, 60, 70)]:
            bx, by = beam[int(t * 60)]
            a = math.radians(ang)
            ex = bx + sx * length * k * math.cos(a)
            ey = by - length * k * math.sin(a)
            out.append(([(bx, by), (ex, ey)], int(9 * thick)))
            # a small fork at the end of the long tines
            if length > 80:
                fx, fy = (bx + ex) / 2, (by + ey) / 2
                out.append(([(fx, fy), (fx + sx * 30 * k, fy - 34 * k)], int(6 * thick)))
        tip_a, tip_b = beam[-1], (beam[-1][0] + sx * 46 * k, beam[-1][1] - 30 * k)
        out.append(([tip_a, tip_b], int(8 * thick)))
    return out


@scene('animals_7')
def animals_7():
    """A stag with great antlers on a ridge, in front of a huge moon, over a forest and a layer of mist."""
    s = Scene(901)
    s.vgrad([(0, NIGHT), (0.4, 0x0a1050), (0.68, 0x1c2a8a), (0.8, 0x3a3cc0), (1, 0x0a0a30)])
    s.stars(240, ymax=520, gain=0.9)
    # a big moon, pale (not white): the keys carry light ink over it
    mx, my, mr = 640, 370, 230
    s.glass_orb(mx, my, mr, 0x7a90d0, gain=0.8)
    dmoon = np.sqrt((s.xx - mx) ** 2 + (s.yy - my) ** 2)
    disc = np.clip((mr - dmoon) / 3, 0, 1)
    shade = np.clip(1 - dmoon / mr, 0, 1)
    s.over(disc * (0.45 - 0.3 * shade), 0x5a70b4)                      # darker toward the edge, as a sphere is
    texture = s.fbm2(5, 2)
    s.over(disc * np.clip((texture - 0.5) * 1.6, 0, 1), 0x7a8fd2, 0.45)   # the seas of the moon, soft
    clouds = s.fbm2(5, 2)
    s.over(np.clip((clouds - 0.5) * 3, 0, 1) * np.exp(-((s.yy - 560) / 120) ** 2), 0x2a3aa8, 0.5)
    # the ridges of forest: far to near
    for i, (yb, amp, col) in enumerate([(640, 120, 0x26338f), (720, 110, 0x151c66), (800, 100, 0x0a0f3e)]):
        ys = s.ridge(yb, amp, base=5 + i, octaves=5, seed=910 + i)
        m = s.below(ys)
        # a forest on the line: little spikes of pines
        pines = np.zeros((W, W), np.float32)
        for x in range(0, W, 14 - i * 3):
            h = 36 + 30 * s.rng.rand() + i * 14
            pines = np.maximum(pines, s.poly([(x, ys[x] - h), (x + 9 + i * 2, ys[x] + 2), (x - 9 - i * 2, ys[x] + 2)]))
        m = np.maximum(m, pines)
        s.over(m, col, 1.0)
        s.light(rim_from(s, m, 0, 3, 2), 0x6fa0ff, 0.4 - i * 0.08, blurs=(0, 3), shares=(1.0, 0.6))
        s.fog(0x4a56d0, yb - 20, 60, 0.28 - i * 0.05)
    # the stag on a rock in the front
    rock = s.ridge(860, 70, base=3, octaves=4, seed=930)
    rock_m = s.below(rock + np.where(np.abs(np.arange(W) - 330) < 300, 0, 90))
    sx0, sy0, kk = 330, 650, 1.1
    st = stag_mask(s, sx0, sy0, kk, flip=False)
    ant = np.zeros((W, W), np.float32)
    for pts, w in antler_lines(sx0, sy0, kk, False):
        ant = np.maximum(ant, s.line(pts, max(2, int(w * kk))))
    sil = np.maximum(st, ant)
    s.over(rock_m, 0x070a2a, 1.0)
    s.over(sil, 0x04061c, 1.0)
    # a cold rim round the stag and the antlers, from the moon behind
    outline = np.clip(cv2.dilate(sil, np.ones((5, 5), np.uint8)) - sil, 0, 1)
    s.light(cv2.GaussianBlur(outline, (0, 0), 1.5), CYAN, 0.9, blurs=(0, 4, 14, 36), shares=(1.0, 0.8, 0.5, 0.4))
    s.light(rim_from(s, rock_m, 0, 3, 2), 0x6fa0ff, 0.6, blurs=(0, 3), shares=(1.0, 0.6))
    # grass in the front, fireflies, mist
    grass = np.zeros((W, W), np.float32)
    for x in range(0, W, 7):
        h = 18 + 40 * s.rng.rand()
        y0 = float(rock[x] + (0 if abs(x - 330) < 300 else 90)) + 6
        grass = np.maximum(grass, s.poly([(x, y0 - h), (x + 4, y0), (x - 4, y0)]))
    s.over(grass, 0x04061c, 1.0)
    s.fog(0x5a6ae0, 800, 70, 0.30)
    s.dust(60, CYAN, 1, 4, ymin=420, ymax=900, gain=0.9)
    s.dust(26, 0x9be8ff, 2, 5, ymin=300, ymax=800, gain=0.6)
    return s.finish()


def jellyfish(s, cx, cy, rx, ry, colour, tent, seed, gain=1.0, blur=0):
    """A jellyfish: a bell that glows from the inside, a frill, and the tentacles that trail under it."""
    rng = np.random.RandomState(seed)
    pts = [(cx + rx * math.cos(t), cy - ry * math.sin(t)) for t in np.linspace(0, math.pi, 60)]
    frill = [(cx - rx + 2 * rx * i / 24.0, cy + 8 * math.sin(i * 1.8) + ry * 0.06) for i in range(25)][::-1]
    bell = s.poly(pts + frill[::-1][::-1])
    dome = np.clip(1 - np.sqrt(((s.xx - cx) / rx) ** 2 + ((s.yy - cy + ry * 0.35) / (ry * 1.1)) ** 2), 0, 1)
    body = bell * (0.18 + 0.55 * dome)
    if blur:
        body = cv2.GaussianBlur(body, (0, 0), blur)
    s.over(body, colour, 0.9)
    s.light(body * 0.7, colour, 0.9 * gain, blurs=(0, 8, 24, 60), shares=(0.6, 0.6, 0.5, 0.4))
    # the rim of the bell and some ribs
    rim = s.line(pts, max(2, int(rx * 0.03)))
    s.light(cv2.GaussianBlur(rim, (0, 0), max(0.1, blur)) if blur else rim, ICE, 0.7 * gain, blurs=(0, 4, 14), shares=(1.0, 0.7, 0.5))
    for k in range(-3, 4):
        rib = [(cx + k * rx * 0.28 * math.cos(t) * 0.9 * (1 - t / 3.3), cy - ry * 0.9 * math.sin(t * 0.5)) for t in np.linspace(0.05, 1.45, 16)]
        rb = s.line([(cx + k * rx * 0.26 * (1 - 0.35 * u), cy - ry * 0.92 * (1 - u * u * 0.2) + u * ry * 0.95) for u in np.linspace(0, 1, 14)], 2)
        s.light((cv2.GaussianBlur(rb, (0, 0), blur) if blur else rb) * 0.35, colour, 0.8 * gain, blurs=(0, 3), shares=(1.0, 0.6))
    # the tentacles
    tm = np.zeros((W, W), np.float32)
    for i in range(tent):
        x0 = cx - rx * 0.85 + 1.7 * rx * i / max(1, tent - 1)
        length = ry * rng.uniform(2.0, 3.6)
        ph = rng.uniform(0, 6.28)
        amp = rx * rng.uniform(0.08, 0.2)
        line = [(x0 + amp * math.sin(ph + u * 7.0) * (0.3 + u), cy + 6 + length * u) for u in np.linspace(0, 1, 30)]
        tm = np.maximum(tm, s.line(line, 2 if i % 3 else 3) * 0.7)
    for i in range(3):
        x0 = cx - rx * 0.3 + rx * 0.3 * i
        line = [(x0 + rx * 0.16 * math.sin(i + u * 5.0) * (0.3 + u), cy + 10 + ry * 3.0 * u) for u in np.linspace(0, 1, 30)]
        tm = np.maximum(tm, s.line(line, max(4, int(rx * 0.05))) * 0.5)
    if blur:
        tm = cv2.GaussianBlur(tm, (0, 0), blur)
    s.light(tm, colour, 0.9 * gain, blurs=(0, 3, 10, 24), shares=(1.0, 0.7, 0.5, 0.4))


@scene('animals_8')
def animals_8():
    """Jellyfish that glow in deep water, with shafts of light from above and plankton."""
    s = Scene(1001)
    s.vgrad([(0, 0x0a1a60), (0.30, 0x070f48), (0.7, 0x04062a), (1, 0x02031a)])
    # shafts of light from the surface
    for x0, w0 in [(140, 60), (420, 90), (700, 70), (880, 50)]:
        beam = s.poly([(x0 - w0 * 0.3, 0), (x0 + w0 * 0.3, 0), (x0 + w0 + 120, W), (x0 - w0 + 120, W)])
        s.light(cv2.GaussianBlur(beam, (0, 0), 22) * np.clip(1 - s.yy / 800, 0, 1), 0x4aa8ff, 0.42, blurs=(0,), shares=(1.0,))
    s.dust(110, 0x6fd8ff, 1, 3, gain=0.8)
    # far jellyfish, soft and small
    jellyfish(s, 120, 250, 46, 38, 0x5b8cff, 9, 3, gain=0.6, blur=2.5)
    jellyfish(s, 820, 560, 52, 42, PURPLE, 9, 4, gain=0.6, blur=2.5)
    jellyfish(s, 840, 190, 40, 32, 0x2fd0ff, 8, 5, gain=0.55, blur=2.0)
    # the near ones
    jellyfish(s, 230, 640, 92, 74, CYAN, 13, 6, gain=0.95)
    jellyfish(s, 700, 330, 120, 96, 0xff5ad0, 15, 7, gain=1.0)
    jellyfish(s, 460, 420, 168, 134, 0x7a5cff, 18, 8, gain=1.05)
    s.dust(70, ICE, 1, 4, gain=0.7)
    s.dust(24, PINK, 2, 6, gain=0.5)
    return s.finish(vignette=0.5)

# ---------------------------------------------------------------- snow

@scene('snow_7')
def snow_7():
    """A small cabin with a lit window in a forest of snowy pines, under the moon, while it snows."""
    s = Scene(1101)
    s.vgrad([(0, NIGHT), (0.35, 0x0a1252), (0.62, 0x233b9e), (0.72, 0x3a5cc8), (1, 0x0c1448)])
    s.stars(220, ymax=420, gain=0.9)
    s.glass_orb(720, 210, 82, 0xdcecff, gain=0.9)
    # far hills with pines, covered in snow
    for i, (yb, amp, col, hi) in enumerate([(610, 90, 0x2c4ab4, 0x9cc4ff), (690, 80, 0x1b2f86, 0x7aa6ff)]):
        ys = s.ridge(yb, amp, base=4 + i, octaves=5, seed=1110 + i)
        m = s.below(ys)
        pines = np.zeros((W, W), np.float32)
        for x in range(0, W, 22 - i * 4):
            h = 70 + 50 * s.rng.rand()
            for tri in tree_pine(s, x, ys[x] + 8, h, 36 + 10 * i, 5):
                pines = np.maximum(pines, s.poly(tri))
        m = np.maximum(m, pines)
        s.over(m, col)
        s.light(rim_from(s, m, 0, 3, 2), hi, 0.5, blurs=(0, 3), shares=(1.0, 0.6))
        s.fog(0x6a8ae8, yb, 50, 0.22)
    # the snow field in the front
    field = s.ridge(740, 40, base=2, octaves=3, seed=1120)
    fm = s.below(field)
    snowcol = np.stack([0.50 + 0.25 * np.clip((s.yy - 740) / 220, 0, 1), 0.64 + 0.2 * np.clip((s.yy - 740) / 220, 0, 1), 0.95 * np.ones((W, W), np.float32)], axis=2)
    s.img = s.img * (1 - fm[:, :, None]) + (snowcol * np.array([0.55, 0.6, 0.78], np.float32)) * fm[:, :, None]
    s.light(rim_from(s, fm, 0, 3, 2), ICE, 0.5, blurs=(0, 3), shares=(1.0, 0.6))
    # drifts: soft long shadows on the snow
    shade = s.fbm2(4, 3)
    s.over(fm * np.clip((shade - 0.45) * 2, 0, 1), 0x24409a, 0.35)
    # the cabin
    cx, base = 520, 790
    body = s.poly([(cx - 130, base), (cx + 130, base), (cx + 130, base - 120), (cx - 130, base - 120)])
    s.over(body, 0x1a1240)
    roof = s.poly([(cx - 165, base - 112), (cx, base - 214), (cx + 165, base - 112)])
    s.over(roof, 0x0c0a2a)
    cap = s.poly([(cx - 165, base - 112), (cx, base - 214), (cx + 165, base - 112), (cx + 150, base - 104), (cx, base - 196), (cx - 150, base - 104)])
    s.over(cap, 0xd8ecff, 0.95)
    s.light(rim_from(s, cap, 0, 2, 2), WHITE, 0.6, blurs=(0, 3), shares=(1.0, 0.6))
    chim = s.poly([(cx + 70, base - 190), (cx + 70, base - 245), (cx + 104, base - 245), (cx + 104, base - 168)])
    s.over(chim, 0x1a1240)
    s.over(s.poly([(cx + 66, base - 245), (cx + 108, base - 245), (cx + 108, base - 256), (cx + 66, base - 256)]), 0xd8ecff, 0.95)
    # logs: lines across the wall
    for k in range(1, 6):
        s.over(s.line([(cx - 130, base - k * 20), (cx + 130, base - k * 20)], 2), 0x2d2468, 0.8)
    # the lit window and the door
    win = s.poly([(cx - 90, base - 92), (cx - 28, base - 92), (cx - 28, base - 40), (cx - 90, base - 40)])
    s.over(win, 0xffc060)
    s.light(win, AMBER, 1.3, blurs=(0, 8, 26, 60), shares=(0.5, 0.7, 0.6, 0.5))
    s.over(s.line([(cx - 59, base - 92), (cx - 59, base - 40)], 3) + s.line([(cx - 90, base - 66), (cx - 28, base - 66)], 3), 0x6a3a10, 0.9)
    door = s.poly([(cx + 30, base - 84), (cx + 88, base - 84), (cx + 88, base), (cx + 30, base)])
    s.over(door, 0x3a2410)
    s.light(s.poly([(cx + 40, base - 74), (cx + 78, base - 74), (cx + 78, base - 8), (cx + 40, base - 8)]) * 0.18, AMBER, 1.0, blurs=(0, 8), shares=(1.0, 0.7))
    # warm light on the snow in front of the window
    glow = s.poly([(cx - 90, base - 40), (cx - 28, base - 40), (cx + 30, base + 120), (cx - 150, base + 120)])
    s.light(cv2.GaussianBlur(glow, (0, 0), 18) * fm, AMBER, 0.55, blurs=(0,), shares=(1.0,))
    # smoke from the chimney
    sm = np.zeros((W, W), np.float32)
    for i in range(8):
        cv2.circle(sm, (cx + 88 + int(14 * math.sin(i * 0.9)) + i * 6, base - 275 - i * 34), 12 + i * 5, 0.45 - i * 0.04, -1, cv2.LINE_AA)
    s.over(cv2.GaussianBlur(sm, (0, 0), 10), 0x9fb4e8, 0.55)
    # pines in the front, at both sides, with snow on every layer
    for tx, tb, th, tw, col in [(120, 850, 420, 190, 0x0a1038), (250, 880, 320, 150, 0x0d1442), (860, 860, 440, 200, 0x0a1038), (760, 890, 300, 140, 0x0d1442), (30, 900, 280, 130, 0x0a1038)]:
        full = np.zeros((W, W), np.float32)
        for tri in tree_pine(s, tx, tb, th, tw, 7):
            full = np.maximum(full, s.poly(tri))
        s.over(s.line([(tx, tb), (tx, tb + 60)], 14), 0x0a0a22)
        s.over(full, col)
        s.light(rim_from(s, full, 0, 2, 1.5), 0xbfe0ff, 0.9, blurs=(0, 3), shares=(1.0, 0.6))
        s.light(rim_from(s, full, 4, 0, 2), 0x6aa0ff, 0.35, blurs=(0, 3), shares=(1.0, 0.6))
    s.snow(520, 0, 960, rmax=3.6, gain=0.95)
    s.snow(120, 0, 960, rmax=6, gain=0.55)
    return s.finish()


@scene('snow_8')
def snow_8():
    """A cave of ice: tall crystals of ice that glow from inside, in a blue light, with snow in the air."""
    s = Scene(1201)
    s.vgrad([(0, NIGHT), (0.4, 0x07123e), (0.75, 0x0c2a78), (1, 0x061040)])
    # the light at the back of the cave
    d = np.sqrt((s.xx - 480) ** 2 + ((s.yy - 470) * 1.4) ** 2)
    s.light(np.clip(1 - d / 380, 0, 1) ** 2, 0x4ad0ff, 0.9, blurs=(0, 30), shares=(0.7, 0.6))
    for a in np.linspace(-0.6, 0.6, 9):
        ray = s.poly([(480 - 6, 470), (480 + 6, 470), (480 + 700 * math.sin(a) + 60, 470 - 700 * math.cos(a)), (480 + 700 * math.sin(a) - 60, 470 - 700 * math.cos(a))])
        s.light(cv2.GaussianBlur(ray, (0, 0), 16) * 0.5, 0x7fe0ff, 0.28, blurs=(0,), shares=(1.0,))
    # the floor: ice that reflects
    fl = 700
    floor = s.below(np.full(W, fl, np.float32))
    s.over(floor, 0x07164f, 0.8)
    s.over(floor * np.clip((s.yy - fl) / 260, 0, 1), 0x020a2a, 0.5)

    def crystal(x, y, h, w, tilt, hue_l, hue_r, seed):
        rng = np.random.RandomState(seed)
        t = w * 0.9
        # a prism that leans: its top is shifted by tilt
        top = (x + tilt, y - h)
        tip = (x + tilt - w * 0.05, y - h - t * 1.1)
        lf = [(x - w, y), (top[0] - w, top[1]), tip, (x, y)]
        rf = [(x, y), tip, (top[0] + w, top[1]), (x + w, y)]
        lm, rm = s.poly(lf), s.poly(rf)
        grad = np.clip((y - s.yy) / max(1.0, h + t), 0, 1)
        s.over(lm, hue_l, 0.55)
        s.over(rm, hue_r, 0.6)
        s.over(lm * grad, WHITE, 0.25)       # lighter toward the tip
        s.light(cv2.GaussianBlur(lm * 0.35 + rm * 0.2, (0, 0), 4), hue_l, 0.9, blurs=(0, 10, 30), shares=(0.4, 0.6, 0.5))
        for pts in (lf + [lf[0]], rf + [rf[0]]):
            s.light(s.line(pts, 3), ICE, 0.9, blurs=(0, 3, 10), shares=(1.0, 0.7, 0.5))
        s.light(s.line([(x, y), tip], 3), WHITE, 0.9, blurs=(0, 3, 10), shares=(1.0, 0.7, 0.5))
        # a reflection under it
        refl = s.poly([(x - w, y), (x + w, y), (x + w * 0.6 - tilt * 0.4, y + h * 0.5), (x - w * 0.6 - tilt * 0.4, y + h * 0.5)])
        s.light(cv2.GaussianBlur(refl, (0, 0), 8) * floor * 0.5, hue_l, 0.5, blurs=(0,), shares=(1.0,))

    # the far crystals first, then the near ones
    for x, y, h, w, tilt in [(380, 600, 150, 26, -18), (560, 590, 190, 30, 14), (480, 580, 120, 20, 0), (300, 630, 190, 34, -30), (660, 630, 170, 32, 28)]:
        crystal(x, y, h, w, tilt, 0x58c8ff, 0x1c58e0, x)
    for x, y, h, w, tilt in [(190, 720, 320, 52, -40), (790, 730, 360, 56, 44), (110, 800, 200, 40, -20), (880, 810, 230, 44, 18), (430, 840, 130, 36, -10), (590, 860, 160, 38, 12)]:
        crystal(x, y, h, w, tilt, 0x7ad8ff, 0x2a62f0, x)
    s.dust(46, ICE, 1, 4, gain=0.8)
    s.snow(260, 0, 900, rmax=3.4, gain=0.9)
    s.fog(0x2a58c8, fl, 50, 0.3)
    return s.finish()


# ---------------------------------------------------------------- nature

def reflect_water(s, hor, strength=0.7, tint=0x0a1a60, ripple=6.0):
    """Below the line hor: a lake that shows what is above it (flipped, blurred, a little darker, with ripples)."""
    h = W - hor
    src = s.img[max(0, hor - h):hor][::-1]
    if src.shape[0] < h:
        pad = np.repeat(src[-1:], h - src.shape[0], axis=0)
        src = np.concatenate([src, pad], axis=0)
    rows = np.arange(h)
    shift = (np.sin(rows * 0.9) * ripple * (rows / h) * 1.0).astype(int)
    out = np.empty_like(src)
    for r in range(h):
        out[r] = np.roll(src[r], shift[r], axis=0)
    out = cv2.GaussianBlur(out, (0, 0), 2.4)
    fade = np.linspace(1.0, 0.55, h)[:, None, None]
    water = out * fade * strength + rgb(tint) * (1 - strength * 0.7)
    s.img[hor:] = water
    streak = (s.rng.rand(h, W) > 0.992).astype(np.float32)
    streak = cv2.GaussianBlur(streak, (21, 1), 0) * 14
    s.img[hor:] = 1 - (1 - s.img[hor:]) * (1 - np.clip(streak, 0, 0.5)[:, :, None] * np.array([0.5, 0.7, 1.0], np.float32))


@scene('nature_7')
def nature_7():
    """A sunset behind layers of mountains over a still lake that reflects them, with fireflies."""
    s = Scene(1301)
    hor = 560
    s.vgrad([(0, 0x080a3c), (0.30, 0x2a1a8a), (0.55, 0x7a2aa8), (0.78, 0xe0408c), (0.92, 0xff7a64), (1, 0xffb070)], 0, hor)
    s.stars(150, ymax=300, gain=0.8)
    # a few streaks of cloud lit from below
    c = s.fbm2(5, 2)
    s.over(np.clip((c - 0.55) * 3, 0, 1) * np.exp(-((s.yy - 300) / 90) ** 2) * (s.yy < hor), 0xff6aa8, 0.45)
    s.over(np.clip((c - 0.5) * 3, 0, 1) * np.exp(-((s.yy - 420) / 60) ** 2) * (s.yy < hor), 0xffb070, 0.35)
    # the sun, half behind the first ridge
    s.glass_orb(480, 520, 120, 0xffd9a0, gain=1.0)
    s.light(s.ellipse(480, 530, 360, 90) * 0.35, 0xff9a60, 1.0, blurs=(0, 30), shares=(0.6, 0.5))
    ridges = [(560, 150, 0x8a3ab0, 0xff9ad0, 3), (585, 130, 0x5a2aa0, 0xd870d0, 4), (600, 120, 0x34228a, 0x9a60e0, 5), (620, 100, 0x1b1766, 0x6a70f0, 6)]
    for i, (yb, amp, col, hi, base) in enumerate(ridges):
        ys = s.ridge(yb, amp, base=base, octaves=6, seed=1310 + i, persistence=0.55)
        m = s.below(ys) * (s.yy < hor + 40)
        s.over(m, col)
        s.light(rim_from(s, m, 0, 3, 2), hi, 0.7 - i * 0.1, blurs=(0, 3, 10), shares=(1.0, 0.6, 0.4))
        s.fog(hi, yb - 10, 50, 0.20)
    # a forest on the near shore
    shore = s.ridge(hor + 40, 36, base=6, octaves=3, seed=1320)
    shm = s.below(shore) * (s.yy < hor + 40)
    pines = np.zeros((W, W), np.float32)
    for x in range(0, W, 10):
        h = 40 + 70 * s.rng.rand() * (1 if x < 260 or x > 700 else 0.5)
        pines = np.maximum(pines, s.poly([(x, shore[x] - h), (x + 12, shore[x] + 3), (x - 12, shore[x] + 3)]))
    s.over(np.maximum(shm, pines), 0x070a2e)
    s.light(rim_from(s, np.maximum(shm, pines), 0, 3, 2), 0xff8ab0, 0.35, blurs=(0, 3), shares=(1.0, 0.6))
    reflect_water(s, hor + 40, 0.95, 0x120a40)
    s.fog(0xff80a0, hor + 40, 30, 0.2)
    s.dust(70, 0xffe0a0, 1, 4, ymin=420, ymax=900, gain=0.9)
    s.dust(24, PINK, 2, 6, ymin=400, ymax=900, gain=0.5)
    return s.finish()


@scene('nature_8')
def nature_8():
    """A forest that glows at night: dark trunks, mushrooms that shine in cyan and violet, light shafts, fireflies and mist."""
    s = Scene(1401)
    s.vgrad([(0, 0x02051a), (0.4, 0x06143e), (0.75, 0x0a2a58), (1, 0x04122c)])
    # the moonlight through the leaves
    for x0, w0 in [(220, 80), (520, 110), (780, 70)]:
        beam = s.poly([(x0 - w0 * 0.3, 0), (x0 + w0 * 0.3, 0), (x0 + w0 + 180, 900), (x0 - w0 + 180, 900)])
        s.light(cv2.GaussianBlur(beam, (0, 0), 24) * np.clip(1 - s.yy / 950, 0, 1), 0x3ad8d0, 0.40, blurs=(0,), shares=(1.0,))
    # the trunks: far (thin, in the fog) to near (wide, dark)
    for layer, (n, wmin, wmax, col, alpha, rimc) in enumerate([(14, 14, 30, 0x0a2a5a, 0.8, 0x2a8ae0), (9, 28, 54, 0x061a40, 0.95, 0x30c8f0), (5, 56, 100, 0x030c26, 1.0, 0x40e8ff)]):
        for i in range(n):
            x = int(s.rng.uniform(-20, W + 20))
            w = s.rng.uniform(wmin, wmax)
            lean = s.rng.uniform(-30, 30)
            trunk = s.poly([(x - w * 0.5 + lean, -20), (x + w * 0.5 + lean, -20), (x + w * 0.62, 940), (x - w * 0.62, 940)])
            s.over(trunk, col, alpha)
            s.light(rim_from(s, trunk, 3, 0, 2), rimc, 0.30 - layer * 0.05, blurs=(0, 3, 9), shares=(1.0, 0.7, 0.4))
            # a root flare and a branch
            if layer > 0:
                s.over(s.poly([(x - w * 0.62, 940), (x + w * 0.62, 940), (x + w * 1.3, 990), (x - w * 1.3, 990)]), col, alpha)
        s.fog(0x2a78c8, 540 + layer * 110, 120, 0.28 - layer * 0.04)
    # the canopy: dark leaves at the top, with a cold light on their edge
    leaves = np.clip((s.fbm2(5, 4) - 0.42) * 5, 0, 1) * np.exp(-(s.yy / 150.0) ** 2)
    s.over(leaves, 0x020818, 0.97)
    s.light(rim_from(s, leaves, 0, 3, 2), 0x30c8f0, 0.5, blurs=(0, 3, 10), shares=(1.0, 0.6, 0.4))
    # the ground
    ground = s.ridge(870, 36, base=3, octaves=3, seed=1410)
    gm = s.below(ground)
    s.over(gm, 0x030a22)
    s.light(rim_from(s, gm, 0, 3, 2), 0x2ab8e8, 0.45, blurs=(0, 3), shares=(1.0, 0.6))
    # mushrooms
    shroom_cols = [CYAN, 0x7a5cff, 0x30ffd0, MAGENTA]
    pos = [(150, 900, 92), (330, 930, 58), (440, 885, 30), (580, 945, 112), (720, 900, 48), (860, 930, 78), (50, 945, 52), (950, 900, 38), (510, 872, 22), (250, 872, 26), (790, 872, 26)]
    for i, (x, y, r) in enumerate(pos):
        col = shroom_cols[i % 4]
        stem = s.poly([(x - r * 0.18, y), (x + r * 0.18, y), (x + r * 0.12, y - r * 1.1), (x - r * 0.12, y - r * 1.1)])
        cap = s.poly([(x + r * math.cos(t), y - r * 1.05 - r * 0.62 * math.sin(t)) for t in np.linspace(0, math.pi, 30)])
        s.over(stem, 0x103060)
        s.over(cap, 0x0a1a48)
        s.light(cap * 0.7 + stem * 0.25, col, 1.3, blurs=(0, 6, 18, 44), shares=(0.7, 0.7, 0.6, 0.5))
        s.light(s.line([(x + r * math.cos(t), y - r * 1.05 - r * 0.62 * math.sin(t)) for t in np.linspace(0, math.pi, 30)], 3), col, 1.0, blurs=(0, 3, 9), shares=(1.0, 0.8, 0.5))
        for k in range(5):
            sx = x + r * rng_pick(s, -0.6, 0.6)
            sy = y - r * (1.05 + rng_pick(s, 0.05, 0.4))
            cv2.circle(s.img, (int(sx), int(sy)), max(1, int(r * 0.07)), tuple(float(v) for v in rgb(WHITE)), -1, cv2.LINE_AA)
    s.fog(0x1a68b8, 900, 70, 0.35)
    s.dust(90, 0x6affd8, 1, 4, ymin=200, ymax=930, gain=1.0)
    s.dust(40, 0x9a8cff, 1, 4, ymin=300, ymax=930, gain=0.8)
    return s.finish()


def rng_pick(s, a, b):
    return float(s.rng.uniform(a, b))

# ---------------------------------------------------------------- anime

def pagoda(s, cx, base, k=1.0, col=0x0a0620, lit=True):
    """The silhouette of a pagoda: a base, five roofs with eaves that turn up, and a spire. Returns the mask."""
    m = np.zeros((W, W), np.float32)
    y = base
    tiers = [(150, 74), (128, 66), (108, 58), (90, 50), (72, 44)]
    for i, (hw, hh) in enumerate(tiers):
        hw *= k
        hh *= k
        # the wall of the floor
        wall = s.poly([(cx - hw * 0.62, y), (cx + hw * 0.62, y), (cx + hw * 0.62, y - hh * 0.8), (cx - hw * 0.62, y - hh * 0.8)])
        m = np.maximum(m, wall)
        # the roof, with the eaves that turn up at the ends
        top = y - hh * 0.8
        roof = s.poly([(cx - hw * 1.22, top + 4 * k), (cx - hw * 1.0, top + 14 * k), (cx - hw * 0.5, top + 8 * k), (cx - hw * 0.2, top - 22 * k), (cx, top - 30 * k),
                       (cx + hw * 0.2, top - 22 * k), (cx + hw * 0.5, top + 8 * k), (cx + hw * 1.0, top + 14 * k), (cx + hw * 1.22, top + 4 * k),
                       (cx + hw * 0.9, top + 22 * k), (cx - hw * 0.9, top + 22 * k)])
        m = np.maximum(m, roof)
        if lit:
            for dx in (-0.3, 0.0, 0.3):
                win = s.poly([(cx + hw * dx - 7 * k, y - hh * 0.62), (cx + hw * dx + 7 * k, y - hh * 0.62), (cx + hw * dx + 7 * k, y - hh * 0.22), (cx + hw * dx - 7 * k, y - hh * 0.22)])
                s.over(win, 0x04020e, 0.0)
        y = top - 26 * k
    spire = s.poly([(cx - 3 * k, y + 20 * k), (cx + 3 * k, y + 20 * k), (cx + 1.5 * k, y - 110 * k), (cx - 1.5 * k, y - 110 * k)])
    m = np.maximum(m, spire)
    for j in range(5):
        m = np.maximum(m, s.ellipse(cx, y - 10 * k - j * 18 * k, 14 * k - j * 1.6 * k, 4 * k))
    return m


def blossoms(s, cx, cy, spread, count, colours, rmin=10, rmax=26):
    """A cloud of cherry blossom: many pink discs of different size, with some light in the middle."""
    m = np.zeros((W, W), np.float32)
    lights = np.zeros((W, W), np.float32)
    for _ in range(count):
        a = s.rng.uniform(0, 2 * math.pi)
        r = spread * math.sqrt(s.rng.rand())
        x, y = cx + r * math.cos(a) * 1.3, cy + r * math.sin(a) * 0.75
        rad = s.rng.uniform(rmin, rmax)
        cv2.circle(m, (int(x), int(y)), int(rad), float(s.rng.uniform(0.5, 1.0)), -1, cv2.LINE_AA)
        if s.rng.rand() < 0.25:
            cv2.circle(lights, (int(x), int(y)), int(rad * 0.5), 1.0, -1, cv2.LINE_AA)
    return m, lights


@scene('anime_7')
def anime_7():
    """A pagoda on a hill under a huge pink moon, with a cherry tree in bloom and petals in the air."""
    s = Scene(1501)
    s.vgrad([(0, 0x05031e), (0.35, 0x1b0f5a), (0.62, 0x5a1c94), (0.78, 0xb03ca0), (1, 0x2a0c58)])
    s.stars(180, ymax=380, gain=0.9)
    mx, my, mr = 600, 400, 240
    s.glass_orb(mx, my, mr, 0xe890cc, gain=0.8)
    dm = np.sqrt((s.xx - mx) ** 2 + (s.yy - my) ** 2)
    disc = np.clip((mr - dm) / 3, 0, 1)
    tex = s.fbm2(5, 2)
    s.over(disc * np.clip((tex - 0.5) * 1.6, 0, 1), 0xb050a8, 0.4)
    s.over(disc * np.clip(dm / mr, 0, 1) ** 2, 0xa04090, 0.35)
    # layers of far hills and mist
    for i, (yb, amp, col, hi) in enumerate([(640, 100, 0x4a1c88, 0xff80d0), (700, 80, 0x2a1068, 0xc060e0)]):
        ys = s.ridge(yb, amp, base=4 + i, octaves=5, seed=1510 + i)
        m = s.below(ys)
        s.over(m, col)
        s.light(rim_from(s, m, 0, 3, 2), hi, 0.5, blurs=(0, 3), shares=(1.0, 0.6))
        s.fog(hi, yb - 10, 50, 0.25)
    # the near hill with the pagoda
    hill = s.ridge(800, 70, base=2, octaves=3, seed=1520)
    hm = s.below(hill)
    pg = pagoda(s, 700, 770, 1.0)
    s.over(pg, 0x080418)
    s.light(rim_from(s, pg, -4, 0, 2), 0xff7ad9, 0.7, blurs=(0, 3, 10), shares=(1.0, 0.7, 0.4))
    # the lit windows of the pagoda
    for i, (hw, hh) in enumerate([(150, 74), (128, 66), (108, 58), (90, 50), (72, 44)]):
        yb = 770 - sum(t[1] * 0.8 + 26 for t in [(150, 74), (128, 66), (108, 58), (90, 50), (72, 44)][:i])
        for dx in (-0.3, 0.0, 0.3):
            w = s.poly([(700 + hw * dx - 6, yb - hh * 0.6), (700 + hw * dx + 6, yb - hh * 0.6), (700 + hw * dx + 6, yb - hh * 0.25), (700 + hw * dx - 6, yb - hh * 0.25)])
            s.over(w, 0xffc070)
            s.light(w, AMBER, 1.0, blurs=(0, 5, 14), shares=(0.6, 0.7, 0.5))
    s.over(hm, 0x0a0522)
    s.light(rim_from(s, hm, 0, 3, 2), 0xff80d0, 0.5, blurs=(0, 3), shares=(1.0, 0.6))
    # the cherry tree on the left: a trunk that leans, branches and a crown of blossom
    trunk = bezier((130, 900), (150, 760), (90, 640), (170, 500), 40)
    tr = s.line(trunk, 30) + s.line([(150, 760), (260, 690), (330, 590)], 14) + s.line([(120, 650), (40, 590), (20, 520)], 12) + s.line([(170, 520), (240, 440), (300, 400)], 12)
    tr = np.clip(tr, 0, 1)
    s.over(tr, 0x120620)
    s.light(rim_from(s, tr, 4, 0, 2), 0xff7ad9, 0.6, blurs=(0, 3), shares=(1.0, 0.6))
    bm, bl = blossoms(s, 190, 470, 210, 190, [PINK], 12, 30)
    bm2, bl2 = blossoms(s, 300, 640, 130, 80, [PINK], 10, 22)
    bm = np.maximum(bm, bm2)
    s.over(bm, 0xff8ad8, 0.9)
    s.over(np.clip(bm - cv2.GaussianBlur(bm, (0, 0), 12), 0, 1), 0xffd0f0, 0.5)
    s.light(bm * 0.25 + np.maximum(bl, bl2) * 0.6, 0xff9ae0, 1.0, blurs=(0, 6, 20), shares=(0.5, 0.6, 0.5))
    # petals in the air
    for _ in range(90):
        x, y = s.rng.uniform(0, W), s.rng.uniform(150, 900)
        a = s.rng.uniform(0, math.pi)
        r = s.rng.uniform(3, 8)
        pm = s.ellipse(x, y, r, r * 0.55)
        pm = cv2.warpAffine(pm, cv2.getRotationMatrix2D((x, y), math.degrees(a), 1.0), (W, W))
        s.light(pm * 0.9, 0xffa0e0, 0.9, blurs=(0, 2), shares=(1.0, 0.6))
    s.fog(0xff80d0, 820, 60, 0.25)
    return s.finish()


@scene('anime_8')
def anime_8():
    """A street of a city at night in the rain: layers of towers with lit windows and neon, lanterns on a wire, and a person with an umbrella."""
    s = Scene(1601)
    hor = 660
    s.vgrad([(0, 0x05031e), (0.45, 0x1a1060), (0.75, 0x5a1c9a), (1, 0xb03ca8)], 0, hor)
    s.stars(100, ymax=240, gain=0.7)
    neon = [MAGENTA, CYAN, PURPLE, 0xff6a3c, BLUE, GREEN]

    def tower_layer(n, wmin, wmax, hmin, hmax, col, wincol, alpha_win, seed, neon_chance):
        rng = np.random.RandomState(seed)
        x = -20
        while x < W + 20:
            w = rng.uniform(wmin, wmax)
            h = rng.uniform(hmin, hmax)
            b = s.poly([(x, hor), (x, hor - h), (x + w, hor - h), (x + w, hor)])
            s.over(b, col)
            wm = np.zeros((W, W), np.float32)
            for yy in range(int(hor - h + 14), hor - 10, 18):
                for xx in range(int(x + 8), int(x + w - 10), 14):
                    if rng.rand() < alpha_win:
                        cv2.rectangle(wm, (xx, yy), (xx + 7, yy + 9), float(rng.uniform(0.5, 1)), -1)
            s.light(wm, wincol if rng.rand() < 0.7 else AMBER, 0.9, blurs=(0, 3, 9), shares=(0.9, 0.6, 0.4))
            if rng.rand() < neon_chance:
                ncol = neon[int(rng.randint(0, len(neon)))]
                sign = s.poly([(x + w * 0.2, hor - h * rng.uniform(0.3, 0.7)), (x + w * 0.2 + 16, hor - h * rng.uniform(0.3, 0.7) - 0), (x + w * 0.2 + 16, hor - h * 0.3), (x + w * 0.2, hor - h * 0.3)])
                bar = s.line([(x + w * 0.25, hor - h * 0.75), (x + w * 0.25, hor - h * 0.35)], 9)
                s.over(bar, ncol, 0.9)
                s.light(bar, ncol, 1.4, blurs=(0, 6, 18, 44), shares=(0.8, 0.7, 0.6, 0.5))
            s.light(rim_from(s, b, 3, 0, 1.5), 0x9a7ae8, 0.3, blurs=(0, 3), shares=(1.0, 0.6))
            x += w + rng.uniform(-4, 14)

    tower_layer(0, 50, 90, 220, 420, 0x2a1670, CYAN, 0.28, 1610, 0.15)
    s.fog(0xb060e0, hor - 120, 120, 0.35)
    tower_layer(0, 70, 130, 200, 520, 0x140a48, 0xffd890, 0.34, 1620, 0.45)
    s.fog(0x8a4ad0, hor - 40, 90, 0.25)
    tower_layer(0, 110, 190, 120, 360, 0x08041e, 0xffc070, 0.3, 1630, 0.5)
    # the street: the colours of the street are the ones above it, flipped
    reflect_water(s, hor, 0.9, 0x0a0626, ripple=3.0)
    # a person with an umbrella, in the middle of the street
    px, py = 480, 800
    body = s.poly([(px - 14, py - 80), (px + 14, py - 80), (px + 20, py), (px - 20, py)]) + s.ellipse(px, py - 98, 11, 12)
    body = np.clip(body, 0, 1)
    umb = s.poly([(px + 5 + 70 * math.cos(t), py - 118 - 46 * math.sin(t)) for t in np.linspace(0, math.pi, 30)])
    handle = s.line([(px + 5, py - 118), (px + 5, py - 60)], 3)
    s.over(np.clip(body + handle, 0, 1), 0x04020e)
    s.over(umb, 0x3a1a88)
    s.light(rim_from(s, umb, 0, 3, 2), PINK, 0.9, blurs=(0, 3, 10), shares=(1.0, 0.7, 0.4))
    s.light(rim_from(s, body, -3, 0, 1.5), CYAN, 0.6, blurs=(0, 3), shares=(1.0, 0.6))
    shadow = s.ellipse(px, py + 6, 70, 10)
    s.light(cv2.GaussianBlur(shadow, (0, 0), 10), MAGENTA, 0.5, blurs=(0,), shares=(1.0,))
    # a wire with lanterns across the top
    pts = bezier((-10, 120), (260, 300), (700, 300), (970, 110), 60)
    s.over(s.line(pts, 2), 0x1a0a40)
    lant = np.zeros((W, W), np.float32)
    for i in range(3, 58, 6):
        lx, ly = pts[i]
        cv2.circle(lant, (int(lx), int(ly + 22)), 15, 1.0, -1, cv2.LINE_AA)
    s.light(lant, 0xff5a3c, 1.4, blurs=(0, 8, 24, 56), shares=(0.8, 0.7, 0.6, 0.5))
    # the rain
    rain = np.zeros((W, W), np.float32)
    for _ in range(420):
        x, y = s.rng.uniform(0, W), s.rng.uniform(0, W)
        L = s.rng.uniform(16, 40)
        cv2.line(rain, (int(x), int(y)), (int(x - L * 0.18), int(y + L)), float(s.rng.uniform(0.3, 0.9)), 1, cv2.LINE_AA)
    s.light(rain, 0xbfd8ff, 0.7, blurs=(0, 1), shares=(1.0, 0.5))
    s.dust(40, 0xffd0f0, 1, 3, ymin=660, ymax=940, gain=0.6)
    return s.finish()


# ---------------------------------------------------------------- AI

@scene('ai_7')
def ai_7():
    """A sphere of nodes joined by lines (a network that thinks), with rings round it and points of light that rise from it."""
    s = Scene(1701)
    s.vgrad([(0, 0x02031a), (0.5, 0x070b3c), (1, 0x02031a)])
    d = np.sqrt((s.xx - 480) ** 2 + (s.yy - 480) ** 2)
    s.light(np.clip(1 - d / 420, 0, 1) ** 2, 0x2f6bff, 0.6, blurs=(0, 30), shares=(0.6, 0.6))
    s.stars(160, gain=0.6)
    rng = np.random.RandomState(1710)
    n = 150
    i = np.arange(n) + 0.5
    phi = np.arccos(1 - 2 * i / n)
    theta = math.pi * (1 + 5 ** 0.5) * i
    pts = np.stack([np.cos(theta) * np.sin(phi), np.sin(theta) * np.sin(phi), np.cos(phi)], axis=1)
    ax, ay = 0.45, 0.35
    rx = np.array([[1, 0, 0], [0, math.cos(ax), -math.sin(ax)], [0, math.sin(ax), math.cos(ax)]])
    ry = np.array([[math.cos(ay), 0, math.sin(ay)], [0, 1, 0], [-math.sin(ay), 0, math.cos(ay)]])
    p = pts @ rx.T @ ry.T
    R = 300
    scr = np.stack([480 + p[:, 0] * R, 480 + p[:, 1] * R], axis=1)
    depth = (p[:, 2] + 1) / 2
    # the lines between near nodes: lighter where they are in front
    links = np.zeros((W, W, 3), np.float32)
    for a in range(n):
        dist = np.linalg.norm(pts - pts[a], axis=1)
        for b in np.argsort(dist)[1:4]:
            if b > a or True:
                dd = (depth[a] + depth[b]) / 2
                col = rgb(CYAN) * dd + rgb(PURPLE) * (1 - dd)
                layer = s.line([tuple(scr[a]), tuple(scr[b])], 2 if dd > 0.5 else 1) * (0.25 + 0.75 * dd)
                links = 1 - (1 - links) * (1 - layer[:, :, None] * col)
    s.img = 1 - (1 - s.img) * (1 - np.clip(links, 0, 1))
    s.light(np.clip(links.max(axis=2), 0, 1), 0x5ad0ff, 0.5, blurs=(0, 3, 10), shares=(0.0, 0.7, 0.5))
    # the nodes
    nodes = np.zeros((W, W), np.float32)
    big = np.zeros((W, W), np.float32)
    for k in range(n):
        r = 3 + 6 * depth[k]
        cv2.circle(nodes, (int(scr[k][0]), int(scr[k][1])), int(r), 0.4 + 0.6 * float(depth[k]), -1, cv2.LINE_AA)
        if rng.rand() < 0.12:
            cv2.circle(big, (int(scr[k][0]), int(scr[k][1])), int(r + 4), 1.0, -1, cv2.LINE_AA)
    s.light(nodes, ICE, 1.1, blurs=(0, 4, 12, 30), shares=(1.0, 0.8, 0.6, 0.4))
    s.light(big, MAGENTA, 1.2, blurs=(0, 6, 20, 50), shares=(0.8, 0.7, 0.6, 0.5))
    # the ring of the sphere, and the rings that go round it
    rim = s.ring(480, 480, R, 3)
    s.light(rim, 0x6ab0ff, 0.7, blurs=(0, 3, 12), shares=(1.0, 0.7, 0.5))
    for tilt, rr, col in [(0.28, 400, CYAN), (-0.22, 440, PURPLE)]:
        ring = np.zeros((W, W), np.float32)
        cv2.ellipse(ring, (480, 480), (rr, int(rr * 0.22)), math.degrees(tilt), 0, 360, 1.0, 3, cv2.LINE_AA)
        s.light(ring * 0.9, col, 0.9, blurs=(0, 4, 14), shares=(1.0, 0.7, 0.5))
        for t in rng.uniform(0, 2 * math.pi, 6):
            ex, ey = rr * math.cos(t), rr * 0.22 * math.sin(t)
            c, sn = math.cos(tilt), math.sin(tilt)
            cx, cy = 480 + ex * c - ey * sn, 480 + ex * sn + ey * c
            m = np.zeros((W, W), np.float32)
            cv2.circle(m, (int(cx), int(cy)), 6, 1.0, -1, cv2.LINE_AA)
            s.light(m, WHITE, 1.2, blurs=(0, 4, 14), shares=(1.0, 0.8, 0.5))
    # points that rise from the sphere
    for _ in range(80):
        x = rng.uniform(80, 880)
        y = rng.uniform(40, 940)
        m = np.zeros((W, W), np.float32)
        cv2.circle(m, (int(x), int(y)), int(rng.uniform(1, 3)), 1.0, -1, cv2.LINE_AA)
        s.light(m, ICE, 0.9, blurs=(0, 3), shares=(1.0, 0.6))
    return s.finish(vignette=0.5)


@scene('ai_8')
def ai_8():
    """A field of data as a mesh of light: wireframe hills in perspective, a bright horizon and a rising sun made of lines."""
    s = Scene(1801)
    hor = 400
    s.vgrad([(0, 0x02031a), (0.5, 0x120a4a), (0.78, 0x5a1a96), (0.9, 0xd03cb0), (1, 0xff7ac8)], 0, hor + 20)
    s.stars(150, ymax=260, gain=0.7)
    # the sun: a disc cut by lines that are thicker toward the bottom
    sx, sy, sr = 480, 370, 170
    d = np.sqrt((s.xx - sx) ** 2 + (s.yy - sy) ** 2)
    sun = np.clip((sr - d) / 2, 0, 1) * (s.yy < hor + 10)
    sungrad = np.stack([np.clip(1.0 - (s.yy - (sy - sr)) / (2 * sr) * 0.2, 0, 1), np.clip(0.4 + (s.yy - (sy - sr)) / (2 * sr) * 0.1, 0, 1), np.clip(0.9 - (s.yy - (sy - sr)) / (2 * sr) * 0.5, 0, 1)], axis=2)
    cut = np.ones((W, W), np.float32)
    for k in range(8):
        y0 = sy - 10 + k * 20
        cut[int(y0):int(y0 + 2 + k * 1.6), :] = 0
    s.img = s.img * (1 - (sun * cut)[:, :, None]) + (sungrad * np.array([1.0, 0.75, 0.9], np.float32)) * (sun * cut)[:, :, None]
    s.light(sun * cut, 0xff6ad0, 0.8, blurs=(0, 14, 40, 90), shares=(0.0, 0.6, 0.5, 0.4))
    # the terrain: rows from far to near, each hides what is behind it
    f, camh = 560.0, 1.5
    nz, nx = 46, 56
    rng = np.random.RandomState(1810)
    base = np.clip(cv2.resize(rng.rand(12, 14).astype(np.float32), (nx, nz * 2), interpolation=cv2.INTER_CUBIC), 0, 1)
    zs = np.linspace(1.0, 0.0, nz) ** 1.6 * 9.0 + 1.1
    xs = np.linspace(-9, 9, nx)
    back = rgb(0x0a0630)
    rows = []
    for iz in range(nz):                      # far first (zs goes from far to near)
        z = zs[iz]
        h = (base[iz * 2] ** 1.5) * 2.8 * np.clip(np.abs(xs) / 3.5, 0.05, 1.0) ** 1.2
        sxr = 480 + xs * f / z
        syr = hor + (camh - h) * f / z * 0.55
        poly = [(float(a), float(b)) for a, b in zip(sxr, syr)] + [(float(sxr[-1]), W + 10.0), (float(sxr[0]), W + 10.0)]
        fillm = s.poly(poly)
        k = 1 - (z - 1.1) / 9.0                 # 1 near, 0 far
        s.over(fillm, 0x0a0630, 1.0)
        col = np.array(rgb(MAGENTA)) * (1 - k) + np.array(rgb(CYAN)) * k
        line = s.line([(float(a), float(b)) for a, b in zip(sxr, syr)], max(1, int(1 + 3 * k)))
        s.light(line, col.astype(np.float32), 1.0, blurs=(0, 3, 9), shares=(1.0, 0.7, 0.5))
        # the columns: little segments toward the row in front
        if iz < nz - 1:
            z2 = zs[iz + 1]
            h2 = (base[(iz + 1) * 2] ** 1.5) * 2.8 * np.clip(np.abs(xs) / 3.5, 0.05, 1.0) ** 1.2
            sx2 = 480 + xs * f / z2
            sy2 = hor + (camh - h2) * f / z2 * 0.55
            seg = np.zeros((W, W), np.float32)
            for a in range(0, nx, 2):
                cv2.line(seg, (int(sxr[a]), int(syr[a])), (int(sx2[a]), int(sy2[a])), 1.0, max(1, int(1 + 2 * k)), cv2.LINE_AA)
            s.light(seg * 0.8, col.astype(np.float32), 0.8, blurs=(0, 3), shares=(1.0, 0.6))
    # a glow at the horizon, and points of data in the air
    s.light(s.ellipse(480, hor + 10, 460, 18) * 0.7, 0xff6ad0, 0.9, blurs=(0, 12, 30), shares=(0.7, 0.6, 0.5))
    s.dust(60, CYAN, 1, 3, ymin=0, ymax=hor, gain=0.8, soft=False)
    s.dust(30, ICE, 1, 3, ymin=hor, ymax=W, gain=0.5)
    return s.finish()

# @@SCENES@@


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--png', help='folder where the PNG files and the contact sheet go')
    ap.add_argument('--only', help='the name of one picture (sports_7 ...)')
    ap.add_argument('--out', default=os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'assets', 'mr_scenes'))
    args = ap.parse_args()
    names = [args.only] if args.only else sorted(SCENES)
    if args.png:
        os.makedirs(args.png, exist_ok=True)
    made = []
    for n in names:
        im = SCENES[n]()
        path = os.path.join(args.out, n + '.webp')
        im.save(path, 'WEBP', quality=QUALITY, method=6)
        if args.png:
            im.save(os.path.join(args.png, n + '.png'))
        made.append(im)
        print('%-10s %6.1f KB' % (n, os.path.getsize(path) / 1024.0))
    if args.png and len(made) > 1:
        cols = 4
        rows = (len(made) + cols - 1) // cols
        sheet = Image.new('RGB', (cols * 300, rows * 300))
        for i, im in enumerate(made):
            sheet.paste(im.resize((300, 300), Image.LANCZOS), ((i % cols) * 300, (i // cols) * 300))
        sheet.save(os.path.join(args.png, 'sheet.png'))


if __name__ == '__main__':
    main()
