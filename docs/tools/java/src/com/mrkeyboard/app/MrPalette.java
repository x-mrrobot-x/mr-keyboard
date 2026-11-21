package com.mrkeyboard.app;

import android.graphics.Bitmap;
import android.graphics.Canvas;

/**
 * The colours that stand out in a background (and, for a plain colour, the ones close to its tone: {@link #near}), to offer them as the colour of the keys: a few of them, the ones that a person would point at ("the red of
 * the sunset, the blue of the sea"), not the average of the picture.
 *
 * <p>The picture is drawn small, its colours are counted (four bits of each channel) and grouped in a few clusters (k-means, from the heaviest colour and
 * then the ones farthest from those chosen). Each cluster is scored by how much of the picture it covers (its square root, so a big sky does not hide
 * everything else) and how vivid it is, and the near blacks, near whites and greys are scored down: they are the colour of nothing. The colours are taken in
 * that order, each at least some distance from the ones taken (the distance is relaxed if the picture has few colours), and made usable as the colour of a
 * key (not so dark that it would not be seen over a dark background). The picture is never sent anywhere: all of it is done here, in a few milliseconds.
 */
final class MrPalette {
    private MrPalette() {
    }

    /** How many colours are offered. */
    static final int COUNT = 5;
    /** The size at which a background is drawn to be counted (the shape of the keyboard). */
    static final int WIDTH = 96, HEIGHT = 48;

    private static final int CLUSTERS = 12;
    private static final int ROUNDS = 6;
    /** The smallest distance (in RGB) between two colours that are offered; if there are not enough, the next ones are tried. */
    private static final int[] DISTANCES = {72, 48, 36};
    private static final float MIN_VALUE = 0.40f;
    /** How bright the dark colour is (its brightest channel, as a share of the most): darker than any colour offered, which is at least {@link #MIN_VALUE}. */
    private static final float DARK_VALUE = 0.26f;

    /**
     * The colours that stand out in {@code spec} ({@code image} is the picture of a landscape or of the gallery); for a plain colour, the ones close to its
     * tone ({@link #near}); none for no background.
     */
    static int[] of(MrBackdrop.Spec spec, Bitmap image) {
        if (spec != null && spec.kind == MrBackdrop.COLOR) return spec.index >= 0 && spec.index < MrBackdrop.COLORS.length ? near(MrBackdrop.COLORS[spec.index]) : new int[0];
        int[] px = pixels(spec, image);
        return px == null ? new int[0] : extract(px, COUNT);
    }

    /**
     * The tone of the background: the colour of a plain colour, the mean colour of what a gradient, a landscape or a picture draws (opaque 0xffRRGGBB);
     * 0 when there is none (no background, or the picture is not there).
     */
    static int tone(MrBackdrop.Spec spec, Bitmap image) {
        if (spec != null && spec.kind == MrBackdrop.COLOR) return spec.index >= 0 && spec.index < MrBackdrop.COLORS.length ? 0xff000000 | MrBackdrop.COLORS[spec.index] : 0;
        return mean(pixels(spec, image));
    }

    /** The mean colour of {@code pixels} (ARGB; the clear ones are left out), opaque; 0 when there is none. */
    static int mean(int[] pixels) {
        if (pixels == null) return 0;
        long r = 0, g = 0, b = 0, n = 0;
        for (int i = 0; i < pixels.length; i++) {
            int p = pixels[i];
            if ((p >>> 24) < 128) continue;
            r += (p >> 16) & 0xff;
            g += (p >> 8) & 0xff;
            b += p & 0xff;
            n++;
        }
        if (n == 0) return 0;
        return 0xff000000 | ((int) (r / n) << 16) | ((int) (g / n) << 8) | (int) (b / n);
    }

    /** What {@code spec} draws, at the size at which it is counted (null for none, or when the picture is not there or it cannot be drawn). */
    private static int[] pixels(MrBackdrop.Spec spec, Bitmap image) {
        if (spec == null || spec.kind == MrBackdrop.NONE) return null;
        if ((spec.kind == MrBackdrop.SCENE || spec.kind == MrBackdrop.IMAGE) && image == null) return null;
        Bitmap b = null;
        try {
            b = Bitmap.createBitmap(WIDTH, HEIGHT, Bitmap.Config.ARGB_8888);
            MrBackdrop.draw(new Canvas(b), spec, WIDTH, HEIGHT, image);
            int[] px = new int[WIDTH * HEIGHT];
            b.getPixels(px, 0, WIDTH, 0, 0, WIDTH, HEIGHT);
            return px;
        } catch (RuntimeException e) {
            return null;
        } catch (OutOfMemoryError e) {
            return null;
        } finally {
            if (b != null) b.recycle();
        }
    }

    /**
     * Up to {@code count} colours (opaque 0xffRRGGBB, the most notable first) that stand out in {@code pixels} (ARGB; the ones that are mostly clear are
     * left out). Fewer when the picture has fewer colours that are far enough from each other; none when it has no pixel.
     */
    static int[] extract(int[] pixels, int count) {
        if (pixels == null || count <= 0) return new int[0];
        int[] hist = new int[4096];
        float[] hr = new float[4096], hg = new float[4096], hb = new float[4096];
        int total = 0;
        for (int i = 0; i < pixels.length; i++) {
            int p = pixels[i];
            if ((p >>> 24) < 128) continue;
            int bin = (((p >> 20) & 0xf) << 8) | (((p >> 12) & 0xf) << 4) | ((p >> 4) & 0xf);
            hist[bin]++;
            hr[bin] += (p >> 16) & 0xff;
            hg[bin] += (p >> 8) & 0xff;
            hb[bin] += p & 0xff;
            total++;
        }
        if (total == 0) return new int[0];
        int n = 0;
        for (int i = 0; i < 4096; i++) {
            if (hist[i] > 0) n++;
        }
        float[] r = new float[n], g = new float[n], b = new float[n], w = new float[n];
        int j = 0;
        for (int i = 0; i < 4096; i++) {
            if (hist[i] == 0) continue;
            r[j] = hr[i] / hist[i];
            g[j] = hg[i] / hist[i];
            b[j] = hb[i] / hist[i];
            w[j] = hist[i];
            j++;
        }
        int k = Math.min(CLUSTERS, n);
        float[] cr = new float[k], cg = new float[k], cb = new float[k];
        seed(r, g, b, w, cr, cg, cb);
        int[] owner = new int[n];
        float[] sw = new float[k];
        for (int round = 0; round < ROUNDS; round++) {
            for (int i = 0; i < n; i++) owner[i] = nearest(cr, cg, cb, r[i], g[i], b[i]);
            float[] sr = new float[k], sg = new float[k], sb = new float[k];
            sw = new float[k];
            for (int i = 0; i < n; i++) {
                int c = owner[i];
                sr[c] += r[i] * w[i];
                sg[c] += g[i] * w[i];
                sb[c] += b[i] * w[i];
                sw[c] += w[i];
            }
            for (int c = 0; c < k; c++) {
                if (sw[c] <= 0f) continue;
                cr[c] = sr[c] / sw[c];
                cg[c] = sg[c] / sw[c];
                cb[c] = sb[c] / sw[c];
            }
        }
        // the clusters that have pixels, best first
        float[] score = new float[k];
        Integer[] order = new Integer[k];
        int m = 0;
        for (int c = 0; c < k; c++) {
            if (sw[c] <= 0f) continue;
            score[c] = score(cr[c], cg[c], cb[c], sw[c] / total);
            order[m++] = c;
        }
        final float[] sc = score;
        java.util.Arrays.sort(order, 0, m, new java.util.Comparator<Integer>() {
            public int compare(Integer a, Integer c) {
                int d = Float.compare(sc[c], sc[a]);
                return d != 0 ? d : a - c;
            }
        });
        int[] out = new int[Math.min(count, m)];
        boolean[] taken = new boolean[k];
        int have = 0;
        for (int pass = 0; pass < DISTANCES.length && have < out.length; pass++) {
            float min2 = (float) DISTANCES[pass] * DISTANCES[pass];
            for (int i = 0; i < m && have < out.length; i++) {
                int c = order[i];
                if (taken[c]) continue;
                int candidate = usable(Math.round(cr[c]), Math.round(cg[c]), Math.round(cb[c]));
                boolean far = true;
                for (int t = 0; t < have && far; t++) {
                    int o = out[t];
                    float dr = ((o >> 16) & 0xff) - ((candidate >> 16) & 0xff), dg = ((o >> 8) & 0xff) - ((candidate >> 8) & 0xff), db = (o & 0xff) - (candidate & 0xff);
                    if (dr * dr + dg * dg + db * db < min2) far = false;
                }
                if (!far) continue;
                taken[c] = true;
                out[have++] = candidate;
            }
        }
        return have == out.length ? out : java.util.Arrays.copyOf(out, have);
    }

    /** The first centre is the heaviest colour; each next one is the colour that is farthest from the ones chosen, weighed by its weight (square root). */
    private static void seed(float[] r, float[] g, float[] b, float[] w, float[] cr, float[] cg, float[] cb) {
        int n = r.length, k = cr.length;
        int first = 0;
        for (int i = 1; i < n; i++) {
            if (w[i] > w[first]) first = i;
        }
        cr[0] = r[first];
        cg[0] = g[first];
        cb[0] = b[first];
        float[] near = new float[n];
        for (int i = 0; i < n; i++) near[i] = dist2(r[i], g[i], b[i], cr[0], cg[0], cb[0]);
        for (int c = 1; c < k; c++) {
            int best = -1;
            float bestScore = -1f;
            for (int i = 0; i < n; i++) {
                float s = near[i] * (float) Math.sqrt(w[i]);
                if (s > bestScore) {
                    bestScore = s;
                    best = i;
                }
            }
            cr[c] = r[best];
            cg[c] = g[best];
            cb[c] = b[best];
            for (int i = 0; i < n; i++) near[i] = Math.min(near[i], dist2(r[i], g[i], b[i], cr[c], cg[c], cb[c]));
        }
    }

    private static int nearest(float[] cr, float[] cg, float[] cb, float r, float g, float b) {
        int best = 0;
        float bestD = Float.MAX_VALUE;
        for (int c = 0; c < cr.length; c++) {
            float d = dist2(r, g, b, cr[c], cg[c], cb[c]);
            if (d < bestD) {
                bestD = d;
                best = c;
            }
        }
        return best;
    }

    private static float dist2(float r, float g, float b, float r2, float g2, float b2) {
        float dr = r - r2, dg = g - g2, db = b - b2;
        return dr * dr + dg * dg + db * db;
    }

    /** How much a colour stands out: the square root of the share of the picture it covers, times how vivid it is; near blacks, near whites and greys count little. */
    private static float score(float r, float g, float b, float share) {
        float max = Math.max(r, Math.max(g, b)) / 255f, min = Math.min(r, Math.min(g, b)) / 255f;
        float sat = max <= 0f ? 0f : (max - min) / max;
        float weight = 1f;
        if (max < 0.20f) weight = 0.15f;
        else if (sat < 0.12f) weight = max > 0.85f ? 0.25f : 0.4f;
        return (float) Math.sqrt(share) * (0.25f + sat) * weight;
    }

    /** The colour made usable as the colour of a key: bright enough (a dark one is not seen over a dark background). Opaque. */
    static int usable(int r, int g, int b) {
        int max = Math.max(r, Math.max(g, b));
        float v = max / 255f;
        if (v < MIN_VALUE) {
            if (max <= 0) {
                r = g = b = Math.round(MIN_VALUE * 255f);
            } else {
                float f = MIN_VALUE / v;
                r = Math.min(255, Math.round(r * f));
                g = Math.min(255, Math.round(g * f));
                b = Math.min(255, Math.round(b * f));
            }
        }
        return 0xff000000 | (clamp(r) << 16) | (clamp(g) << 8) | clamp(b);
    }

    /** How far, in degrees of hue, the colours next to the tone of a plain colour are from it. */
    private static final float HUE_STEP = 36f;

    /**
     * Five colours close to the tone of a plain colour ({@code base}), to be the colour of the keys over it: the same hue, the hues next to it on both sides
     * and a softer (or deeper) one of the same hue, and one more hue step beyond; the most like the colour first. On a dark colour they are bright (a key
     * that is the colour of the background is not seen) and on a light one they are deep; the ones of a colour with no hue (black, greys) are greys of
     * different depths and a cool and a warm one. Each is at least 36 from the others in RGB. Opaque.
     */
    static int[] near(int base) {
        float[] hsv = new float[3];
        MrGlow.hsv(base, hsv);
        boolean light = MrThemeColors.luminance(0xff000000 | base) > 0.5f;
        float h = hsv[0];
        if (hsv[1] < 0.10f || hsv[2] < 0.12f) {
            // no hue to speak of: greys of three depths, one cool and one warm
            if (light) return new int[] {MrGlow.rgb(0f, 0f, 0.58f), MrGlow.rgb(0f, 0f, 0.42f), MrGlow.rgb(0f, 0f, 0.28f), MrGlow.rgb(215f, 0.40f, 0.60f), MrGlow.rgb(30f, 0.40f, 0.60f)};
            return new int[] {MrGlow.rgb(0f, 0f, 0.84f), MrGlow.rgb(0f, 0f, 0.64f), MrGlow.rgb(0f, 0f, 0.46f), MrGlow.rgb(215f, 0.30f, 0.92f), MrGlow.rgb(30f, 0.30f, 0.92f)};
        }
        float s = Math.min(0.95f, Math.max(hsv[1], light ? 0.55f : 0.50f));
        float v = light ? 0.62f : 0.92f;
        return new int[] {
                MrGlow.rgb(h, s, v),
                MrGlow.rgb(turn(h, -HUE_STEP), s, v),
                MrGlow.rgb(turn(h, HUE_STEP), s, v),
                light ? MrGlow.rgb(h, s, 0.38f) : MrGlow.rgb(h, 0.36f, 1f),
                MrGlow.rgb(turn(h, 2f * HUE_STEP), s, v)};
    }

    private static float turn(float hue, float by) {
        return ((hue + by) % 360f + 360f) % 360f;
    }

    /** A dark colour of the hue of {@code colour} (its brightest channel is {@link #DARK_VALUE}); grey for black. Opaque. */
    static int dark(int colour) {
        int r = (colour >> 16) & 0xff, g = (colour >> 8) & 0xff, b = colour & 0xff;
        int max = Math.max(r, Math.max(g, b));
        int to = Math.round(DARK_VALUE * 255f);
        if (max <= 0) return 0xff000000 | (to << 16) | (to << 8) | to;
        if (max <= to) return 0xff000000 | (r << 16) | (g << 8) | b;
        float f = (float) to / max;
        return 0xff000000 | (clamp(Math.round(r * f)) << 16) | (clamp(Math.round(g * f)) << 8) | clamp(Math.round(b * f));
    }

    private static int clamp(int v) {
        return v < 0 ? 0 : v > 255 ? 255 : v;
    }
}
