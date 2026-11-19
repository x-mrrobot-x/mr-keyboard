package com.mrkeyboard.app;

import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.Shader;

/**
 * The landscapes that can be the background of the keyboard, drawn by the code (nothing is stored in the app, nothing is downloaded):
 * a sky, a sun or a moon, and layers of hills, trees or buildings in front of each other, darker the nearer they are. Every scene is drawn
 * for any size (the shapes are a share of the width and the height), so the same code fills the keyboard, a tile of the themes screen and
 * the big preview. The "random" parts (the stars, the windows, the height of the peaks) come from a fixed sequence, so a scene looks the same
 * every time it is drawn.
 */
final class MrScenes {
    /** The number of landscapes. */
    static final int COUNT = 6;

    /** Peaks at dusk, desert dunes, sea at sunset, forest at night, northern lights, city at night. */
    static final int DUSK = 0, DUNES = 1, SEA = 2, FOREST = 3, AURORA = 4, CITY = 5;

    private MrScenes() { }

    /** Draws scene {@code scene} (0 .. COUNT - 1) over the whole canvas of {@code w} x {@code h} pixels. An unknown scene draws nothing. */
    static void draw(Canvas c, int scene, int w, int h) {
        if (c == null || w <= 0 || h <= 0) return;
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        switch (scene) {
            case DUSK: dusk(c, p, w, h); break;
            case DUNES: dunes(c, p, w, h); break;
            case SEA: sea(c, p, w, h); break;
            case FOREST: forest(c, p, w, h); break;
            case AURORA: aurora(c, p, w, h); break;
            case CITY: city(c, p, w, h); break;
            default: break;
        }
    }

    // ---- pieces

    /** A vertical band of colours from the top to {@code bottom} of the canvas (the sky, the water). */
    private static void band(Canvas c, Paint p, float top, float bottom, int w, int[] colors, float[] stops) {
        p.setShader(new LinearGradient(0, top, 0, bottom, colors, stops, Shader.TileMode.CLAMP));
        c.drawRect(0, top, w, bottom, p);
        p.setShader(null);
    }

    /** A soft light: a disc of {@code colour} that fades out to nothing at {@code radius}. */
    private static void glow(Canvas c, Paint p, float x, float y, float radius, int colour) {
        int clear = colour & 0x00ffffff;
        p.setShader(new RadialGradient(x, y, radius, new int[] {colour, clear}, new float[] {0f, 1f}, Shader.TileMode.CLAMP));
        c.drawCircle(x, y, radius, p);
        p.setShader(null);
    }

    private static void disc(Canvas c, Paint p, float x, float y, float radius, int colour) {
        p.setColor(colour);
        c.drawCircle(x, y, radius, p);
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

    /** A triangle wave of 0 .. 1 with period 1: the sharp peaks of mountains. */
    private static float tri(float t) {
        float f = t - (float) Math.floor(t);
        return Math.abs(2f * f - 1f);
    }

    /**
     * A ridge across the canvas filled down to the bottom: its top is at {@code base - height * shape(x)}, with the peaks of two triangle waves of
     * different periods ({@code f1}, {@code f2}) moved by {@code ph1}, {@code ph2}. {@code soft} 0 .. 1 rounds them (1 = smooth hills).
     */
    private static void ridge(Canvas c, Paint p, int w, int h, float base, float height, float f1, float ph1, float f2, float ph2, float soft, int colour) {
        Path path = new Path();
        int steps = 48;
        path.moveTo(0, h);
        for (int i = 0; i <= steps; i++) {
            float x = w * i / (float) steps;
            float u = i / (float) steps;
            float a = 1f - tri(u * f1 + ph1);
            float b = 1f - tri(u * f2 + ph2);
            float sharp = 0.62f * a + 0.38f * b;
            float round = 0.5f + 0.5f * (float) Math.sin((u * f1 + ph1) * 2.0 * Math.PI) * 0.62f + 0.5f * 0.38f * (float) Math.sin((u * f2 + ph2) * 2.0 * Math.PI);
            float shape = sharp * (1f - soft) + round * soft;
            path.lineTo(x, base - height * shape);
        }
        path.lineTo(w, h);
        path.close();
        p.setColor(colour);
        c.drawPath(path, p);
    }

    private static void stars(Canvas c, Paint p, int w, int h, float areaBottom, int count, long seed) {
        Seq r = new Seq(seed);
        float unit = Math.min(w, h) / 360f;
        for (int i = 0; i < count; i++) {
            float x = r.next() * w;
            float y = r.next() * areaBottom;
            float size = (0.5f + r.next() * 1.1f) * unit;
            int alpha = 120 + (int) (r.next() * 135f);
            disc(c, p, x, y, Math.max(0.6f, size), (alpha << 24) | 0x00ffffff);
        }
    }

    // ---- the scenes

    private static void dusk(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff2b1b4d, 0xff8e3b6e, 0xfff2784b, 0xffffc371}, new float[] {0f, 0.42f, 0.7f, 0.82f});
        glow(c, p, w * 0.68f, h * 0.60f, h * 0.42f, 0xaaffd89b);
        disc(c, p, w * 0.68f, h * 0.60f, h * 0.07f, 0xffffe3a3);
        ridge(c, p, w, h, h * 0.70f, h * 0.20f, 2.3f, 0.10f, 5.1f, 0.40f, 0f, 0xff7a4a7c);
        ridge(c, p, w, h, h * 0.78f, h * 0.20f, 1.7f, 0.60f, 4.3f, 0.15f, 0f, 0xff4d2d63);
        ridge(c, p, w, h, h * 0.88f, h * 0.16f, 2.9f, 0.30f, 6.7f, 0.70f, 0.15f, 0xff2a1745);
        ridge(c, p, w, h, h * 0.98f, h * 0.10f, 1.3f, 0.85f, 3.9f, 0.25f, 0.5f, 0xff140b26);
    }

    private static void dunes(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff3a1c71, 0xffd76d77, 0xffffaf7b}, new float[] {0f, 0.52f, 0.85f});
        glow(c, p, w * 0.30f, h * 0.46f, h * 0.40f, 0x88ffe0b0);
        disc(c, p, w * 0.30f, h * 0.46f, h * 0.055f, 0xffffeccf);
        ridge(c, p, w, h, h * 0.66f, h * 0.12f, 1.1f, 0.10f, 2.0f, 0.55f, 1f, 0xffc9744f);
        ridge(c, p, w, h, h * 0.78f, h * 0.14f, 0.9f, 0.70f, 1.6f, 0.20f, 1f, 0xff9c4a3a);
        ridge(c, p, w, h, h * 0.90f, h * 0.14f, 1.2f, 0.35f, 2.3f, 0.80f, 1f, 0xff6b2d33);
        ridge(c, p, w, h, h * 1.00f, h * 0.10f, 0.8f, 0.05f, 1.9f, 0.45f, 1f, 0xff3d1a2c);
    }

    private static void sea(Canvas c, Paint p, int w, int h) {
        float horizon = h * 0.60f;
        band(c, p, 0, horizon, w, new int[] {0xff141e30, 0xff35477d, 0xffff7e5f}, new float[] {0f, 0.6f, 1f});
        glow(c, p, w * 0.5f, horizon, h * 0.45f, 0x99ffb38a);
        disc(c, p, w * 0.5f, horizon - h * 0.02f, h * 0.075f, 0xffffe6c7);
        band(c, p, horizon, h, w, new int[] {0xffd95f66, 0xff4a2f63, 0xff0b132b}, new float[] {0f, 0.35f, 1f});
        // the light of the sun on the water: bars that get shorter and fainter with the distance
        Seq r = new Seq(7);
        for (int i = 0; i < 9; i++) {
            float y = horizon + h * (0.015f + 0.40f * i / 9f);
            float half = w * (0.20f - 0.012f * i) * (0.6f + 0.4f * r.next());
            int alpha = (int) (170 - 15 * i);
            p.setColor((alpha << 24) | 0x00ffd9b0);
            c.drawRect(w * 0.5f - half, y, w * 0.5f + half, y + Math.max(1f, h * 0.012f), p);
        }
        ridge(c, p, w, h, h * 0.62f, h * 0.035f, 2.2f, 0.4f, 5.5f, 0.1f, 0.2f, 0xff1b1633);
    }

    private static void forest(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff0b1026, 0xff1b2a49, 0xff2d4a6b}, new float[] {0f, 0.55f, 0.9f});
        stars(c, p, w, h, h * 0.55f, 70, 11);
        glow(c, p, w * 0.76f, h * 0.20f, h * 0.30f, 0x55cfe2ff);
        disc(c, p, w * 0.76f, h * 0.20f, h * 0.07f, 0xfff2f6ff);
        trees(c, p, w, h, h * 0.78f, h * 0.20f, 14, 3, 0xff12303a);
        trees(c, p, w, h, h * 0.90f, h * 0.26f, 10, 5, 0xff0b2229);
        trees(c, p, w, h, h * 1.00f, h * 0.30f, 7, 9, 0xff06141a);
    }

    /** A row of pines whose feet are on {@code ground}: {@code count} of them, between 60% and 100% of {@code tallest}. */
    private static void trees(Canvas c, Paint p, int w, int h, float ground, float tallest, int count, long seed, int colour) {
        Seq r = new Seq(seed);
        p.setColor(colour);
        c.drawRect(0, ground - tallest * 0.12f, w, h, p);
        float slot = w / (float) count;
        for (int i = 0; i < count + 1; i++) {
            float x = i * slot + (r.next() - 0.5f) * slot * 0.5f;
            float height = tallest * (0.6f + 0.4f * r.next());
            float width = height * 0.46f;
            Path t = new Path();
            for (int tier = 0; tier < 3; tier++) {
                float top = ground - height + height * 0.30f * tier;
                float bottom = top + height * 0.50f;
                float half = width * (0.40f + 0.30f * tier) / 1.4f;
                t.moveTo(x, top);
                t.lineTo(x + half, bottom);
                t.lineTo(x - half, bottom);
                t.close();
            }
            c.drawPath(t, p);
        }
    }

    private static void aurora(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff05060f, 0xff0a1232, 0xff122044}, new float[] {0f, 0.6f, 1f});
        stars(c, p, w, h, h * 0.6f, 55, 23);
        int[] hues = {0x3cffb0, 0x4d9bff, 0xb36bff};
        float[] tops = {0.14f, 0.24f, 0.34f};
        for (int i = 0; i < hues.length; i++) {
            float y0 = h * tops[i];
            Path band = new Path();
            int steps = 30;
            band.moveTo(0, y0);
            for (int k = 0; k <= steps; k++) {
                float u = k / (float) steps;
                band.lineTo(w * u, y0 + h * 0.07f * (float) Math.sin(u * 5.0 + i * 1.7) + h * 0.03f * (float) Math.sin(u * 11.0 + i));
            }
            float depth = h * (0.34f - 0.04f * i);
            for (int k = steps; k >= 0; k--) {
                float u = k / (float) steps;
                band.lineTo(w * u, y0 + depth + h * 0.06f * (float) Math.sin(u * 4.0 + i * 2.3));
            }
            band.close();
            p.setShader(new LinearGradient(0, y0 - h * 0.05f, 0, y0 + depth, new int[] {0x00000000 | hues[i], 0x99000000 | hues[i], 0x00000000 | hues[i]},
                    new float[] {0f, 0.35f, 1f}, Shader.TileMode.CLAMP));
            c.drawPath(band, p);
            p.setShader(null);
        }
        ridge(c, p, w, h, h * 0.86f, h * 0.18f, 1.8f, 0.2f, 4.4f, 0.6f, 0.1f, 0xff0c1a3a);
        ridge(c, p, w, h, h * 0.98f, h * 0.12f, 1.2f, 0.7f, 3.1f, 0.3f, 0.3f, 0xff060d22);
    }

    private static void city(Canvas c, Paint p, int w, int h) {
        band(c, p, 0, h, w, new int[] {0xff1a0b3d, 0xff6a2a7a, 0xffff6f91}, new float[] {0f, 0.5f, 0.78f});
        glow(c, p, w * 0.28f, h * 0.45f, h * 0.38f, 0x66ffd0e0);
        disc(c, p, w * 0.28f, h * 0.45f, h * 0.055f, 0xfffff0f5);
        skyline(c, p, w, h, h * 0.80f, h * 0.30f, 15, 4, 0xff3a1c5a, false);
        skyline(c, p, w, h, h * 1.00f, h * 0.36f, 11, 8, 0xff130a26, true);
    }

    /** Blocks side by side standing on {@code ground}; with {@code lit} some of their windows are on. */
    private static void skyline(Canvas c, Paint p, int w, int h, float ground, float tallest, int count, long seed, int colour, boolean lit) {
        Seq r = new Seq(seed);
        float slot = w / (float) count;
        for (int i = 0; i < count; i++) {
            float bw = slot * (0.8f + 0.5f * r.next());
            float bh = tallest * (0.35f + 0.65f * r.next());
            float x = i * slot;
            p.setColor(colour);
            c.drawRect(x, ground - bh, x + bw, h, p);
            if (!lit) continue;
            float cell = Math.max(3f, Math.min(w, h) / 36f);
            for (float wy = ground - bh + cell; wy < ground - cell; wy += cell * 1.9f) {
                for (float wx = x + cell * 0.7f; wx + cell * 0.8f < x + bw; wx += cell * 1.6f) {
                    if (r.next() < 0.45f) {
                        p.setColor(0xccffd27a);
                        c.drawRect(wx, wy, wx + cell * 0.8f, wy + cell * 0.9f, p);
                    }
                }
            }
        }
    }
}
