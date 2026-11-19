package com.mrkeyboard.app;

import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.Shader;

/**
 * The landscapes that can be the background of the keyboard, drawn by the code (nothing is stored in the app, nothing is downloaded): a neon city,
 * a synthwave horizon, a circuit board, a network, the limb of a planet, a hologram, a stream of data, waves of light and a hexagon grid. They
 * are dark on purpose (the keys over a background carry light ink). Every scene is drawn for any size (the shapes are a share of the width and of
 * the height), so the same code fills the keyboard, a tile of the themes screen and the preview. The "random" parts (the stars, the windows,
 * the nodes) come from a fixed sequence, so a scene looks the same every time it is drawn.
 */
final class MrScenes {
    /** The number of landscapes. */
    static final int COUNT = 9;

    /** Neon city, synthwave, circuit, network, orbit, hologram, data stream, neon waves, hexagons. */
    static final int NEON_CITY = 0, SYNTHWAVE = 1, CIRCUIT = 2, NETWORK = 3, ORBIT = 4, HOLOGRAM = 5, STREAMS = 6, WAVES = 7, HEX = 8;

    private MrScenes() { }

    /** Draws scene {@code scene} (0 .. COUNT - 1) over the whole canvas of {@code w} x {@code h} pixels. An unknown scene draws nothing. */
    static void draw(Canvas c, int scene, int w, int h) {
        if (c == null || w <= 0 || h <= 0) return;
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        switch (scene) {
            case NEON_CITY: neonCity(c, p, w, h); break;
            case SYNTHWAVE: synthwave(c, p, w, h); break;
            case CIRCUIT: circuit(c, p, w, h); break;
            case NETWORK: network(c, p, w, h); break;
            case ORBIT: orbit(c, p, w, h); break;
            case HOLOGRAM: hologram(c, p, w, h); break;
            case STREAMS: streams(c, p, w, h); break;
            case WAVES: waves(c, p, w, h); break;
            case HEX: hex(c, p, w, h); break;
            default: break;
        }
    }

    // ---- pieces

    /** A vertical band of colours from {@code top} to {@code bottom} of the canvas (the sky, the floor). {@code stops} null: even steps. */
    private static void band(Canvas c, Paint p, float top, float bottom, int w, int[] colors, float[] stops) {
        p.setStyle(Paint.Style.FILL);
        p.setShader(new LinearGradient(0, top, 0, bottom, colors, stops, Shader.TileMode.CLAMP));
        c.drawRect(0, top, w, bottom, p);
        p.setShader(null);
    }

    /** A soft light: a disc of {@code colour} that fades out to nothing at {@code radius}. */
    private static void glow(Canvas c, Paint p, float x, float y, float radius, int colour) {
        if (radius <= 0f) return;
        int clear = colour & 0x00ffffff;
        p.setStyle(Paint.Style.FILL);
        p.setShader(new RadialGradient(x, y, radius, new int[] {colour, clear}, new float[] {0f, 1f}, Shader.TileMode.CLAMP));
        c.drawCircle(x, y, radius, p);
        p.setShader(null);
    }

    private static void disc(Canvas c, Paint p, float x, float y, float radius, int colour) {
        p.setStyle(Paint.Style.FILL);
        p.setColor(colour);
        c.drawCircle(x, y, radius, p);
    }

    private static void box(Canvas c, Paint p, float l, float t, float r, float b, int colour) {
        p.setStyle(Paint.Style.FILL);
        p.setColor(colour);
        c.drawRect(l, t, r, b, p);
    }

    /** A line of {@code width} and {@code colour}; at least one pixel wide. */
    private static void line(Canvas c, Paint p, float x0, float y0, float x1, float y1, float width, int colour) {
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(Math.max(1f, width));
        p.setColor(colour);
        c.drawLine(x0, y0, x1, y1, p);
        p.setStyle(Paint.Style.FILL);
    }

    /** An outline of a path in {@code colour}, with a wide faint copy under it: light round a tube. */
    private static void tube(Canvas c, Paint p, Path path, float width, int colour) {
        int faint = (0x2a << 24) | (colour & 0x00ffffff);
        p.setStyle(Paint.Style.STROKE);
        p.setColor(faint);
        p.setStrokeWidth(Math.max(2f, width * 4f));
        c.drawPath(path, p);
        p.setColor(colour);
        p.setStrokeWidth(Math.max(1f, width));
        c.drawPath(path, p);
        p.setStyle(Paint.Style.FILL);
    }

    private static int alpha(int colour, float a) {
        return (Math.round(Math.max(0f, Math.min(1f, a)) * 255f) << 24) | (colour & 0x00ffffff);
    }

    /** The colour {@code from} to {@code to}, {@code t} of the way (0 .. 1), opaque. */
    private static int lerp(int from, int to, float t) {
        int r = Math.round(((from >> 16) & 0xff) * (1f - t) + ((to >> 16) & 0xff) * t);
        int g = Math.round(((from >> 8) & 0xff) * (1f - t) + ((to >> 8) & 0xff) * t);
        int b = Math.round((from & 0xff) * (1f - t) + (to & 0xff) * t);
        return 0xff000000 | (r << 16) | (g << 8) | b;
    }

    /** The same numbers every time: a small linear congruential sequence of 0 .. 1. */
    private static final class Seq {
        private long s;

        Seq(long seed) { s = seed; }

        float next() {
            s = (s * 1103515245L + 12345L) & 0x7fffffffL;
            return (s >> 8 & 0xffff) / 65535f;
        }
    }

    private static void stars(Canvas c, Paint p, int w, int h, float areaBottom, int count, long seed) {
        Seq r = new Seq(seed);
        float unit = Math.min(w, h) / 360f;
        for (int i = 0; i < count; i++) {
            float x = r.next() * w;
            float y = r.next() * areaBottom;
            float size = (0.5f + r.next() * 1.1f) * unit;
            int a = 120 + (int) (r.next() * 135f);
            disc(c, p, x, y, Math.max(0.6f, size), (a << 24) | 0x00ffffff);
        }
    }

    /** A ridge across the canvas filled down to the bottom (a triangle wave of two periods). */
    private static void ridge(Canvas c, Paint p, int w, int h, float base, float height, float f1, float ph1, float f2, float ph2, int colour) {
        Path path = new Path();
        int steps = 48;
        path.moveTo(0, h);
        for (int i = 0; i <= steps; i++) {
            float u = i / (float) steps;
            float a = 1f - tri(u * f1 + ph1), b = 1f - tri(u * f2 + ph2);
            path.lineTo(w * u, base - height * (0.62f * a + 0.38f * b));
        }
        path.lineTo(w, h);
        path.close();
        p.setStyle(Paint.Style.FILL);
        p.setColor(colour);
        c.drawPath(path, p);
    }

    /** A triangle wave of 0 .. 1 with period 1: the sharp peaks of mountains. */
    private static float tri(float t) {
        float f = t - (float) Math.floor(t);
        return Math.abs(2f * f - 1f);
    }

    // ---- the scenes

    private static void neonCity(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff070320, 0xff2a0a5a, 0xff8a1f7a, 0xffff4f8b}, new float[] {0f, 0.45f, 0.75f, 0.88f});
        glow(c, p, w * 0.74f, h * 0.30f, h * 0.55f, 0x66ff7ad9);
        disc(c, p, w * 0.74f, h * 0.30f, h * 0.085f, 0xffffe6fb);
        disc(c, p, w * 0.74f - h * 0.025f, h * 0.30f - h * 0.015f, h * 0.075f, 0x33c07ad8);
        towers(c, p, w, h, h * 0.92f, h * 0.42f, 17, 6, 0xff2b0f55, false);
        towers(c, p, w, h, h * 1.02f, h * 0.55f, 12, 8, 0xff0a0420, true);
        // the street: a faint pink light on the water of the road
        band(c, p, h * 0.94f, h, w, new int[] {0x00ff4f8b, 0x55ff4f8b}, null);
        line(c, p, 0, h * 0.97f, w, h * 0.97f, u * 0.5f, 0x55ff8ad8);
    }

    /** Blocks side by side standing on {@code ground}; the near ones ({@code near}) have windows, neon edges and lights on their roofs. */
    private static void towers(Canvas c, Paint p, int w, int h, float ground, float tallest, int count, long seed, int body, boolean near) {
        Seq r = new Seq(seed);
        float u = h / 100f;
        float slot = w / (float) count;
        for (int i = 0; i < count; i++) {
            float bw = slot * (0.85f + 0.5f * r.next());
            float bh = tallest * (0.3f + 0.7f * r.next());
            float x = i * slot - slot * 0.1f;
            box(c, p, x, ground - bh, x + bw, h, body);
            if (!near) continue;
            if (r.next() < 0.45f) {
                float mast = tallest * (0.08f + 0.10f * r.next());
                box(c, p, x + bw * 0.5f - u * 0.4f, ground - bh - mast, x + bw * 0.5f + u * 0.4f, ground - bh, body);
                disc(c, p, x + bw * 0.5f, ground - bh - mast, Math.max(1.2f, u * 0.9f), 0xffff3b6b);
                glow(c, p, x + bw * 0.5f, ground - bh - mast, u * 4f, 0x88ff3b6b);
            }
            int neon = r.next() < 0.5f ? 0xff35f0ff : 0xffff4fd8;
            box(c, p, x + bw - u * 0.9f, ground - bh, x + bw, ground - u * 2f, alpha(neon, 0.85f));
            box(c, p, x + bw - u * 3f, ground - bh, x + bw, ground - u * 2f, alpha(neon, 0.12f));
            float cell = Math.max(3f, u * 2.6f);
            for (float wy = ground - bh + cell; wy < ground - cell * 2f; wy += cell * 1.9f) {
                for (float wx = x + cell * 0.8f; wx + cell * 0.8f < x + bw - u * 2f; wx += cell * 1.6f) {
                    float k = r.next();
                    if (k < 0.40f) box(c, p, wx, wy, wx + cell * 0.8f, wy + cell * 0.9f, alpha(k < 0.18f ? 0xff35f0ff : k < 0.32f ? 0xffff4fd8 : 0xffffd27a, 0.85f));
                }
            }
        }
    }

    private static void synthwave(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        float horizon = h * 0.60f;
        band(c, p, 0, horizon + 1f, w, new int[] {0xff0d0030, 0xff4a0a78, 0xffd3238a, 0xffff7a59}, new float[] {0f, 0.5f, 0.88f, 1f});
        float sx = w * 0.5f, sy = horizon - h * 0.02f, sr = h * 0.30f;
        glow(c, p, sx, sy, sr * 2.0f, 0x77ff4fa0);
        // the sun: slices that get thinner towards the bottom, so the sky shows between them
        int n = 24;
        for (int k = 0; k < n; k++) {
            float t = k / (float) n;
            float y0 = sy - sr + 2f * sr * t, y1 = sy - sr + 2f * sr * (k + 1) / n;
            float mid = (y0 + y1) / 2f - sy;
            float half = (float) Math.sqrt(Math.max(0f, sr * sr - mid * mid));
            float thick = t > 0.46f ? 1f - (t - 0.46f) / 0.54f * 0.82f : 1f;
            box(c, p, sx - half, y0, sx + half, y0 + (y1 - y0) * thick, lerp(0xffffe45e, 0xffff2e88, t));
        }
        ridge(c, p, w, h, horizon + u * 0.6f, h * 0.13f, 3.1f, 0.2f, 7.3f, 0.6f, 0xff1a0540);
        band(c, p, horizon, h, w, new int[] {0xff3a0a63, 0xff10002a}, null);
        box(c, p, 0, horizon - u * 0.8f, w, horizon + u * 0.8f, alpha(0xffff7ad8, 0.85f));
        glow(c, p, sx, horizon, h * 0.45f, 0x44ff7ad8);
        // the grid of the floor, in perspective
        for (int i = 1; i <= 9; i++) {
            float t = i / 9f;
            line(c, p, 0, horizon + (h - horizon) * t * t, w, horizon + (h - horizon) * t * t, u * (0.35f + 0.6f * t), alpha(0xffff3ec9, 0.35f + 0.5f * t));
        }
        for (int k = -14; k <= 14; k++) {
            line(c, p, w * 0.5f + k * w * 0.016f, horizon, w * 0.5f + k * w * 0.17f, h, u * 0.6f, alpha(0xffff3ec9, 0.55f));
        }
    }

    private static void circuit(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff031018, 0xff06242b, 0xff031820}, null);
        glow(c, p, w * 0.5f, h * 0.5f, h * 0.9f, 0x3300e5ff);
        float cell = Math.max(6f, h / 10f);
        Seq r = new Seq(31);
        int cols = (int) (w / cell) + 1, rows = (int) (h / cell) + 1;
        for (int t = 0; t < 22; t++) {
            float x = Math.round(r.next() * cols) * cell, y = Math.round(r.next() * rows) * cell;
            Path path = new Path();
            path.moveTo(x, y);
            float sx0 = x, sy0 = y;
            boolean horizontal = r.next() < 0.5f;
            int segments = 3 + (int) (r.next() * 3f);
            for (int s = 0; s < segments; s++) {
                float len = (2 + (int) (r.next() * 4f)) * cell;
                float sign = r.next() < 0.5f ? -1f : 1f;
                float bend = r.next() < 0.5f ? -1f : 1f;
                if (horizontal) {
                    x += sign * len;
                    path.lineTo(x, y);
                    x += sign * cell * 0.7f;
                    y += bend * cell * 0.7f;
                } else {
                    y += sign * len;
                    path.lineTo(x, y);
                    y += sign * cell * 0.7f;
                    x += bend * cell * 0.7f;
                }
                path.lineTo(x, y);
                horizontal = !horizontal;
            }
            tube(c, p, path, u * 1.1f, 0xaa2de6ff);
            pad(c, p, sx0, sy0, u);
            pad(c, p, x, y, u);
        }
        // the chip in the middle, with its pins
        float cx = w * 0.5f, cy = h * 0.5f, hw = h * 0.30f, hh = h * 0.22f;
        for (int i = 0; i < 7; i++) {
            float f = -0.75f + i * 0.25f;
            line(c, p, cx + f * hw, cy - hh, cx + f * hw, cy - hh - h * 0.07f, u * 1.2f, 0xcc2de6ff);
            line(c, p, cx + f * hw, cy + hh, cx + f * hw, cy + hh + h * 0.07f, u * 1.2f, 0xcc2de6ff);
        }
        box(c, p, cx - hw, cy - hh, cx + hw, cy + hh, 0xf0041b24);
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(Math.max(1f, u * 0.9f));
        p.setColor(0xcc2de6ff);
        c.drawRect(cx - hw, cy - hh, cx + hw, cy + hh, p);
        c.drawRect(cx - hw * 0.55f, cy - hh * 0.5f, cx + hw * 0.55f, cy + hh * 0.5f, p);
        p.setStyle(Paint.Style.FILL);
        glow(c, p, cx, cy, hh * 0.9f, 0x6600e5ff);
    }

    /** A solder pad: a ring with a dark centre. */
    private static void pad(Canvas c, Paint p, float x, float y, float u) {
        disc(c, p, x, y, u * 2.2f, 0xff031820);
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(Math.max(1f, u * 0.9f));
        p.setColor(0xffa6f6ff);
        c.drawCircle(x, y, u * 2.2f, p);
        p.setStyle(Paint.Style.FILL);
    }

    private static void network(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff040a1e, 0xff0a1a40, 0xff130f3a}, null);
        glow(c, p, w * 0.32f, h * 0.42f, h * 0.9f, 0x331f6bff);
        glow(c, p, w * 0.78f, h * 0.62f, h * 0.8f, 0x30a04dff);
        Seq r = new Seq(57);
        int n = 44;
        float[] xs = new float[n], ys = new float[n];
        for (int i = 0; i < n; i++) {
            xs[i] = (0.02f + 0.96f * r.next()) * w;
            ys[i] = (0.04f + 0.92f * r.next()) * h;
        }
        float reach = h * 0.55f;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                float dx = xs[i] - xs[j], dy = ys[i] - ys[j];
                float d = (float) Math.sqrt(dx * dx + dy * dy);
                if (d < reach) line(c, p, xs[i], ys[i], xs[j], ys[j], u * 0.5f, alpha(0xff5ac8ff, (1f - d / reach) * 0.6f));
            }
        }
        for (int i = 0; i < n; i++) {
            boolean hub = i % 7 == 0;
            int colour = hub ? 0xffb48cff : 0xff9fe6ff;
            glow(c, p, xs[i], ys[i], u * (hub ? 7f : 4f), alpha(colour, hub ? 0.55f : 0.35f));
            disc(c, p, xs[i], ys[i], u * (hub ? 1.9f : 1.0f), colour);
        }
    }

    private static void orbit(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff01030a, 0xff040b24, 0xff0a1d4a}, new float[] {0f, 0.6f, 1f});
        stars(c, p, w, h, h * 0.78f, 90, 41);
        float r = h * 1.7f, cx = w * 0.5f, cy = h * 0.72f + r, t = h * 0.22f;
        // the air round the planet: faint, brighter towards the limb, gone a little beyond it
        p.setStyle(Paint.Style.FILL);
        p.setShader(new RadialGradient(cx, cy, r + t, new int[] {0x005ab8ff, 0x005ab8ff, 0xcc5ab8ff, 0x005ab8ff},
                new float[] {0f, (r - t * 0.8f) / (r + t), r / (r + t), 1f}, Shader.TileMode.CLAMP));
        c.drawCircle(cx, cy, r + t, p);
        p.setShader(null);
        // the sun coming over the limb
        float sunX = w * 0.74f, rim = cy - (float) Math.sqrt(Math.max(0f, r * r - (sunX - cx) * (sunX - cx)));
        glow(c, p, sunX, rim, h * 0.42f, 0x99ffe2b8);
        disc(c, p, cx, cy, r, 0xff030814);
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(Math.max(1f, u * 1.3f));
        p.setColor(0xcc8fd4ff);
        c.drawCircle(cx, cy, r, p);
        p.setStyle(Paint.Style.FILL);
        glow(c, p, sunX, rim, h * 0.10f, 0xffffffff);
        // the lights of cities on the dark side
        Seq q = new Seq(5);
        for (int i = 0; i < 70; i++) {
            float x = q.next() * w, y = h * 0.78f + q.next() * h * 0.22f;
            float dx = x - cx, dy = y - cy;
            if (dx * dx + dy * dy < (r - u * 4f) * (r - u * 4f)) disc(c, p, x, y, Math.max(0.7f, u * 0.5f), alpha(0xffffc66b, 0.35f + 0.5f * q.next()));
        }
        // a station: a body with two panels
        float sx = w * 0.20f, sy = h * 0.30f;
        box(c, p, sx - h * 0.05f, sy - u * 1.2f, sx + h * 0.05f, sy + u * 1.2f, 0xff8a94a8);
        box(c, p, sx - h * 0.17f, sy - h * 0.06f, sx - h * 0.07f, sy + h * 0.06f, 0xff2c4a8a);
        box(c, p, sx + h * 0.07f, sy - h * 0.06f, sx + h * 0.17f, sy + h * 0.06f, 0xff2c4a8a);
        line(c, p, sx - h * 0.12f, sy - h * 0.06f, sx - h * 0.12f, sy + h * 0.06f, u * 0.4f, 0xff6f93d8);
        line(c, p, sx + h * 0.12f, sy - h * 0.06f, sx + h * 0.12f, sy + h * 0.06f, u * 0.4f, 0xff6f93d8);
        disc(c, p, sx, sy - u * 1.2f, Math.max(1f, u * 0.7f), 0xffff4d4d);
    }

    private static void hologram(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff010b12, 0xff02202e, 0xff010b12}, null);
        float cx = w * 0.5f, cy = h * 0.50f, r = h * 0.38f;
        glow(c, p, cx, cy, h * 0.85f, 0x5500c8ff);
        int ink = 0x66e0fbff & 0x00ffffff;
        // parallels
        for (int k = -3; k <= 3; k++) {
            double lat = Math.toRadians(k * 22.0);
            float rx = (float) (r * Math.cos(lat));
            ellipse(c, p, cx, cy + (float) (r * Math.sin(lat)), rx, rx * 0.22f, u * 0.7f, (0x77 << 24) | ink);
        }
        // meridians
        for (int k = 0; k < 6; k++) {
            double a = Math.toRadians(k * 30.0);
            ellipse(c, p, cx, cy, (float) (r * Math.abs(Math.cos(a))), r, u * 0.7f, (0x77 << 24) | ink);
        }
        ellipse(c, p, cx, cy, r, r, u * 1.2f, 0xcc7be8ff);
        // the base the globe stands on
        ellipse(c, p, cx, cy + r * 1.22f, r * 1.35f, r * 0.20f, u * 0.9f, 0x887be8ff);
        ellipse(c, p, cx, cy + r * 1.22f, r * 0.95f, r * 0.13f, u * 0.7f, 0x557be8ff);
        // scan lines and specks of light
        float pitch = Math.max(3f, u * 2.4f);
        for (float y = 0; y < h; y += pitch) box(c, p, 0, y, w, y + 1f, 0x0a8fe8ff);
        Seq q = new Seq(19);
        for (int i = 0; i < 40; i++) disc(c, p, q.next() * w, q.next() * h, Math.max(0.7f, u * 0.45f), alpha(0xffb8f4ff, 0.25f + 0.5f * q.next()));
    }

    /** An ellipse as an outline of short lines (it needs nothing but a path). */
    private static void ellipse(Canvas c, Paint p, float cx, float cy, float rx, float ry, float width, int colour) {
        if (rx <= 0.5f || ry <= 0.5f) return;
        Path path = new Path();
        int steps = 48;
        for (int i = 0; i <= steps; i++) {
            double a = 2.0 * Math.PI * i / steps;
            float x = cx + rx * (float) Math.cos(a), y = cy + ry * (float) Math.sin(a);
            if (i == 0) path.moveTo(x, y);
            else path.lineTo(x, y);
        }
        path.close();
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(Math.max(1f, width));
        p.setColor(colour);
        c.drawPath(path, p);
        p.setStyle(Paint.Style.FILL);
    }

    private static void streams(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff000a06, 0xff00180f}, null);
        float cell = Math.max(5f, h / 14f);
        Seq r = new Seq(73);
        int cols = (int) (w / cell) + 1;
        for (int col = 0; col < cols; col++) {
            float x = col * cell;
            if (r.next() < 0.30f) continue;
            float head = r.next() * h * 1.15f;
            int length = 6 + (int) (r.next() * 10f);
            for (int k = 0; k < length; k++) {
                float y = head - k * cell;
                if (r.next() < 0.14f || y < -cell || y > h) continue;
                float fade = 1f - k / (float) length;
                int colour = k == 0 ? 0xffd9ffe9 : alpha(0xff00ff9c, 0.15f + 0.75f * fade);
                box(c, p, x + cell * 0.12f, y + cell * 0.12f, x + cell * 0.88f, y + cell * 0.88f, colour);
            }
            glow(c, p, x + cell * 0.5f, head, cell * 2.2f, 0x4400ff9c);
        }
    }

    private static void waves(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff08031f, 0xff1a0a4a, 0xff0a0630}, null);
        glow(c, p, w * 0.5f, h * 0.55f, h * 0.9f, 0x33704dff);
        int[] hues = {0xff35f0ff, 0xffb36bff, 0xffff4fd8, 0xff4d9bff, 0xff35f0ff, 0xffb36bff};
        for (int i = 0; i < hues.length; i++) {
            Path path = new Path();
            float y0 = h * (0.30f + 0.09f * i), amp = h * (0.07f + 0.012f * i);
            int steps = 72;
            for (int k = 0; k <= steps; k++) {
                float t = k / (float) steps;
                double a = t * 2.0 * Math.PI;
                float y = y0 + amp * (float) Math.sin(a * (1.3 + 0.25 * i) + i * 1.1) + amp * 0.45f * (float) Math.sin(a * (3.1 + 0.4 * i) + i * 2.3);
                if (k == 0) path.moveTo(0, y);
                else path.lineTo(w * t, y);
            }
            tube(c, p, path, u * (1.0f + 0.12f * i), alpha(hues[i], 0.9f));
        }
        Seq q = new Seq(88);
        for (int i = 0; i < 45; i++) disc(c, p, q.next() * w, q.next() * h, Math.max(0.7f, u * 0.5f), alpha(0xffffffff, 0.2f + 0.5f * q.next()));
    }

    private static void hex(Canvas c, Paint p, int w, int h) {
        float u = h / 100f;
        band(c, p, 0, h, w, new int[] {0xff040716, 0xff0a1030}, null);
        glow(c, p, w * 0.5f, h * 0.5f, h * 1.0f, 0x3300c8ff);
        float r = h * 0.15f;
        float wd = r * 1.7320508f, rowH = r * 1.5f;
        Seq q = new Seq(101);
        for (int row = -1; row * rowH < h + r; row++) {
            for (int col = -1; col * wd < w + wd; col++) {
                float cx = col * wd + (row & 1) * wd / 2f, cy = row * rowH;
                Path path = new Path();
                for (int k = 0; k < 6; k++) {
                    double a = Math.toRadians(30.0 + 60.0 * k);
                    float x = cx + r * 0.96f * (float) Math.cos(a), y = cy + r * 0.96f * (float) Math.sin(a);
                    if (k == 0) path.moveTo(x, y);
                    else path.lineTo(x, y);
                }
                path.close();
                float dx = cx - w * 0.5f, dy = cy - h * 0.5f;
                float near = 1f - Math.min(1f, (float) Math.sqrt(dx * dx + dy * dy) / (h * 1.5f));
                if (q.next() < 0.17f) {
                    p.setStyle(Paint.Style.FILL);
                    p.setColor(alpha(q.next() < 0.5f ? 0xff2fd6ff : 0xff8a5cff, 0.14f + 0.22f * q.next()));
                    c.drawPath(path, p);
                }
                p.setStyle(Paint.Style.STROKE);
                p.setStrokeWidth(Math.max(1f, u * 0.6f));
                p.setColor(alpha(0xff59a8ff, 0.10f + 0.30f * near));
                c.drawPath(path, p);
                p.setStyle(Paint.Style.FILL);
            }
        }
    }
}
