package com.mrkeyboard.app;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.widget.TextView;

/**
 * Neon look of the keyboard themes that carry the GLOW flag (MrTheme.glow(), bit 0x80 of mr_theme_flags): the light
 * around the label and the icon of each key, around the lit dash of Ctrl, Alt and Shift and around the letter of the
 * preview bubble. The tube and the light of the key faces are plain drawables (key_&lt;theme&gt;_*.xml, written by
 * docs/tools/make_themes.py); only what a drawable cannot do lives here.
 *
 * <p>With the SPECTRUM flag as well (bit 0x100), each key of the main keyboard takes its hue from its position: the
 * drawables are written in one hue (the one of the role <code>glow</code>) and every key draws them through a colour
 * filter that moves that hue to the one of the key, between the roles <code>spectrum_start</code>,
 * <code>spectrum_mid</code> and <code>spectrum_end</code>. The label, the icon, the dash and the light of the key
 * follow (the locked dash of Shift keeps its own reddish colour). The popup of variants and the preview bubble keep the hue of the drawables.
 *
 * <p>LatinKeyboardBaseView calls in at nine points: {@link #key} and {@link #hint} once per key, before its face;
 * {@link #drawKey} in place of KeyStyle.drawKey; {@link #bloom} right before the label is drawn, or {@link #edge}
 * when the label is a dead key; {@link #icon} in place of ShadowDrawHelper.draw; {@link #iconFilter} for the colour
 * of the icon; {@link #dash} before the modifier dash and {@link #preview} when the bubble is filled. On a theme
 * without the flag each call does exactly what the keyboard did before it existed.
 *
 * <p>Only text shadows, a bitmap blur (ShadowDrawHelper) and colour filters are used: all three work the same on a
 * software canvas and on an accelerated one, and the keyboard window can be either (see MrAccel).
 */
final class MrGlow {
    private MrGlow() { }

    /** Number of hue steps of a spectrum theme (the filters are kept per step). */
    static final int STEPS = 48;
    /** How much the vertical position counts in the hue of a key (0 = columns of one hue, 1 = rows of one hue). */
    static final float TILT = 0.22f;

    /** Label: radius of the wide light and of the tight one, as a share of the text size, and their limits in dp. */
    static final float WIDE = 0.30f, WIDE_MIN = 3f, WIDE_MAX = 7f;
    static final float TIGHT = 0.085f, TIGHT_MIN = 1.25f, TIGHT_MAX = 2.5f;
    /** Label drawn in pieces (dead key): radius of its single light, between the two above. */
    static final float MID = 0.16f, MID_MIN = 2f, MID_MAX = 4f;
    /** Opacity of the wide light, as a share of the opacity of the glow colour. */
    static final float WIDE_ALPHA = 0.75f;
    /** Radius of the light of an icon, of the lit dash and of the letter in the bubble, in dp. */
    static final float ICON_DP = 3.25f, DASH_DP = 3f, PREVIEW_DP = 6f;

    // ---- theme (read again when the tag of the keyboard changes) ----
    private static String sTag;
    private static boolean sSpectrum;
    private static int sKeyGlow, sAccentGlow, sDashOff, sDashLock;
    private static int sStart, sMid, sEnd;
    private static float[][] sMatrix;       // [step] 3x3 that moves the hue of the drawables to the hue of the step
    private static ColorFilter[] sFaceFilter;
    private static int[] sHue;              // [step] hue of the step, opaque; 0 = not computed yet

    // ---- key being drawn (set by key()) ----
    private static float sDensity = 1f;
    private static int sGlow;               // glow colour of this key; 0 = the theme has none
    private static int sStep = -1;          // spectrum step of this key; -1 = none
    private static int sInk;                // spectrum: colour of the label and of the icon; 0 = the theme's own

    // ---- small caches ----
    private static int sIconGlowColor, sInkFilterColor;
    private static ColorFilter sIconGlowFilter, sInkFilter;

    /** True on a neon theme; reads the colours of the theme the first time and after a theme change. */
    private static boolean sync() {
        if (!MrTheme.glow()) return false;
        String tag = MrTheme.tag();
        if (tag == null ? sTag != null : !tag.equals(sTag)) load(tag);
        return true;
    }

    private static void load(String tag) {
        sTag = tag;
        sKeyGlow = MrTheme.color("glow");
        sAccentGlow = MrTheme.color("accent_glow");
        sDashOff = MrTheme.color("modifier_indicator_off");
        sDashLock = MrTheme.color("modifier_indicator_lock");
        sSpectrum = MrTheme.spectrum();
        sMatrix = null;
        sFaceFilter = null;
        sHue = null;
        sIconGlowFilter = null;
        sInkFilter = null;
        if (sSpectrum) {
            sStart = MrTheme.color("spectrum_start");
            sMid = MrTheme.color("spectrum_mid");
            sEnd = MrTheme.color("spectrum_end");
            sMatrix = new float[STEPS + 1][];
            sFaceFilter = new ColorFilter[STEPS + 1];
            sHue = new int[STEPS + 1];
        }
    }

    /** Forgets the theme that was read (tests). */
    static void reset() {
        sTag = null;
        sGlow = 0;
        sStep = -1;
        sInk = 0;
        sDensity = 1f;
        load(null);
    }

    // ------------------------------------------------------------------ calls from LatinKeyboardBaseView

    /**
     * Once per key, before its face is drawn. <code>accent</code>: the key is one of the highlight keys of the theme;
     * <code>p</code>: the paint of the labels, already with the colour of this key.
     */
    static void key(View v, Keyboard.Key k, boolean accent, Paint p) {
        sStep = -1;
        sInk = 0;
        if (!sync()) {
            sGlow = 0;
            return;
        }
        sDensity = density(v);
        sGlow = accent ? sAccentGlow : sKeyGlow;
        if (!sSpectrum || v == null || k == null || v.getTag() == null) return;   // the popup of variants has no tag
        int step = step(k.x + k.width * 0.5f, k.y + k.height * 0.5f, v.getWidth(), v.getHeight());
        float[] m = matrix(step);
        if (m == null) return;
        sStep = step;
        sGlow = (sGlow & 0xff000000) | (sHue[step] & 0xffffff);
        if (p != null) {
            sInk = map(m, p.getColor());
            p.setColor(sInk);
        }
    }

    /**
     * Once per key, right after {@link #key}. <code>p</code>: the paint of the small hint letters of the key;
     * <code>color</code>: the colour the theme gives them. On a spectrum theme they take the hue of the key; on any
     * other the paint is left alone (the keyboard sets it once, before the first key).
     */
    static void hint(Paint p, int color) {
        if (p == null || sStep < 0) return;
        p.setColor(map(sMatrix[sStep], color));
    }

    /** In place of KeyStyle.drawKey: on a spectrum theme the face is drawn in the hue of the key. */
    static void drawKey(Drawable d, Canvas c, int w, int h) {
        int step = sStep;
        if (step < 0 || d == null) {
            KeyStyle.drawKey(d, c, w, h);
            return;
        }
        d.setColorFilter(faceFilter(step));
        try {
            KeyStyle.drawKey(d, c, w, h);
        } finally {
            d.setColorFilter(null);
        }
    }

    /**
     * Right before the label of the key is drawn with <code>p</code>: draws the wide light and leaves the tight one in
     * the paint, as its shadow, for the drawing that follows (the keyboard clears the shadow after it).
     */
    static void bloom(Canvas c, String text, float x, float y, Paint p) {
        int glow = sGlow;
        if (glow == 0 || c == null || text == null || p == null) return;
        float size = p.getTextSize();
        float d = sDensity;
        p.setShadowLayer(clamp(size * WIDE, WIDE_MIN * d, WIDE_MAX * d), 0f, 0f, fade(glow, WIDE_ALPHA));
        c.drawText(text, x, y, p);
        p.setShadowLayer(clamp(size * TIGHT, TIGHT_MIN * d, TIGHT_MAX * d), 0f, 0f, glow);
    }

    /**
     * Right before the label of a dead key is drawn with <code>p</code>. The keyboard draws it in two pieces (the
     * dotted circle, then the accent), so {@link #bloom} cannot draw the wide light under it: the label gets one light
     * of middle width, left in the paint as its shadow (the keyboard clears the shadow after the label).
     */
    static void edge(Paint p) {
        int glow = sGlow;
        if (glow == 0 || p == null) return;
        float d = sDensity;
        p.setShadowLayer(clamp(p.getTextSize() * MID, MID_MIN * d, MID_MAX * d), 0f, 0f, glow);
    }

    /** In place of ShadowDrawHelper.draw (dark outline of the icon): on a neon theme, the light of the icon. */
    static void icon(Canvas c, Drawable d, Keyboard.Key k, float radius, ColorFilter shadow) {
        int glow = sGlow;
        if (glow == 0) {
            ShadowDrawHelper.draw(c, d, k, radius, shadow);
            return;
        }
        if (sIconGlowFilter == null || sIconGlowColor != glow) {
            sIconGlowColor = glow;
            sIconGlowFilter = new PorterDuffColorFilter(glow, PorterDuff.Mode.SRC_IN);
        }
        ShadowDrawHelper.draw(c, d, k, ICON_DP * sDensity, sIconGlowFilter);
    }

    /** Colour filter of the icon of the key: the theme's own (<code>f</code>), or the hue of the key on a spectrum theme. */
    static ColorFilter iconFilter(ColorFilter f) {
        int ink = sInk;
        if (ink == 0) return f;
        if (sInkFilter == null || sInkFilterColor != ink) {
            sInkFilterColor = ink;
            sInkFilter = new PorterDuffColorFilter(ink, PorterDuff.Mode.SRC_ATOP);
        }
        return sInkFilter;
    }

    /**
     * Before the dash of Ctrl, Alt and Shift is drawn with <code>p</code>, which already has its colour (one of the
     * roles modifier_indicator_*): a lit dash shines, an off one does not; on a spectrum theme both take the hue of
     * the key, but the locked dash (Shift locked) keeps its own reddish colour, so it can still be told apart.
     */
    static void dash(Paint p) {
        if (p == null) return;
        if (sGlow == 0) {
            p.clearShadowLayer();
            return;
        }
        int c = p.getColor();
        boolean off = (c & 0xffffff) == (sDashOff & 0xffffff);
        boolean lock = (c & 0xffffff) == (sDashLock & 0xffffff);
        if (sStep >= 0 && !lock) {
            c = map(sMatrix[sStep], c);
            p.setColor(c);
        }
        if (off) p.clearShadowLayer();
        else p.setShadowLayer(DASH_DP * sDensity, 0f, 0f, c);
    }

    /** When the preview bubble gets its text: the letter shines like the ones on the keys. */
    static void preview(TextView t) {
        if (t == null) return;
        if (!sync()) {
            return;
        }
        t.setShadowLayer(PREVIEW_DP * density(t), 0f, 0f, sKeyGlow);
    }

    // ------------------------------------------------------------------ spectrum

    /** Step (0..STEPS) of a key whose centre is at (cx, cy) on a keyboard of w by h. */
    static int step(float cx, float cy, int w, int h) {
        if (w <= 0 || h <= 0) return 0;
        float t = (cx / w) * (1f - TILT) + (cy / h) * TILT;
        int s = Math.round(clamp(t, 0f, 1f) * STEPS);
        return s < 0 ? 0 : s > STEPS ? STEPS : s;
    }

    /** Hue of position t (0..1) between three colours, turning the hue by the short way and keeping it vivid. */
    static int ramp(int start, int mid, int end, float t) {
        t = clamp(t, 0f, 1f);
        float[] a = new float[3], b = new float[3];
        float f;
        if (t < 0.5f) {
            hsv(start, a);
            hsv(mid, b);
            f = t * 2f;
        } else {
            hsv(mid, a);
            hsv(end, b);
            f = (t - 0.5f) * 2f;
        }
        float dh = b[0] - a[0];
        if (dh > 180f) dh -= 360f;
        if (dh < -180f) dh += 360f;
        float hue = a[0] + dh * f;
        if (hue < 0f) hue += 360f;
        if (hue >= 360f) hue -= 360f;
        return rgb(hue, a[1] + (b[1] - a[1]) * f, a[2] + (b[2] - a[2]) * f);
    }

    private static float[] matrix(int step) {
        float[][] all = sMatrix;
        if (all == null || step < 0 || step > STEPS) return null;
        float[] m = all[step];
        if (m == null) {
            int hue = ramp(sStart, sMid, sEnd, step / (float) STEPS);
            m = remap(sKeyGlow, hue);
            if (m == null) return null;      // the drawables are grey: there is no hue to move
            sHue[step] = hue;
            all[step] = m;
        }
        return m;
    }

    private static ColorFilter faceFilter(int step) {
        ColorFilter f = sFaceFilter[step];
        if (f == null) {
            float[] m = sMatrix[step];
            f = new ColorMatrixColorFilter(new float[] {
                    m[0], m[1], m[2], 0f, 0f,
                    m[3], m[4], m[5], 0f, 0f,
                    m[6], m[7], m[8], 0f, 0f,
                    0f, 0f, 0f, 1f, 0f });
            sFaceFilter[step] = f;
        }
        return f;
    }

    /**
     * 3x3 matrix (rows) that takes the colour <code>from</code> to <code>to</code> and leaves white as white. Every
     * mix of <code>from</code>, white and black (a tube, its light, a tinted face) lands on the same mix of
     * <code>to</code>, so a drawable written in one hue is redrawn in another with nothing lost. null when
     * <code>from</code> is a grey (there is no hue to move).
     */
    static float[] remap(int from, int to) {
        float r = ((from >> 16) & 0xff) / 255f, g = ((from >> 8) & 0xff) / 255f, b = (from & 0xff) / 255f;
        float tr = ((to >> 16) & 0xff) / 255f, tg = ((to >> 8) & 0xff) / 255f, tb = (to & 0xff) / 255f;
        // third axis, at right angles to the colour and to white: kept as it is
        float nr = g - b, ng = b - r, nb = r - g;
        // inverse of the matrix whose columns are (from, white, third)
        float c00 = nb - ng, c01 = nr - nb, c02 = ng - nr;                    // cofactors of the first column
        float det = r * c00 + g * c01 + b * c02;
        if (Math.abs(det) < 1e-4f) return null;
        float i00 = c00 / det, i01 = c01 / det, i02 = c02 / det;
        float i10 = (b * ng - g * nb) / det, i11 = (r * nb - b * nr) / det, i12 = (g * nr - r * ng) / det;
        float i20 = (g - b) / det, i21 = (b - r) / det, i22 = (r - g) / det;
        // (to, white, third) x inverse
        return new float[] {
                tr * i00 + i10 + nr * i20, tr * i01 + i11 + nr * i21, tr * i02 + i12 + nr * i22,
                tg * i00 + i10 + ng * i20, tg * i01 + i11 + ng * i21, tg * i02 + i12 + ng * i22,
                tb * i00 + i10 + nb * i20, tb * i01 + i11 + nb * i21, tb * i02 + i12 + nb * i22 };
    }

    /** Colour <code>c</code> through the matrix of remap(); the opacity is kept. */
    static int map(float[] m, int c) {
        if (m == null) return c;
        float r = (c >> 16) & 0xff, g = (c >> 8) & 0xff, b = c & 0xff;
        return (c & 0xff000000)
                | (byteOf(m[0] * r + m[1] * g + m[2] * b) << 16)
                | (byteOf(m[3] * r + m[4] * g + m[5] * b) << 8)
                | byteOf(m[6] * r + m[7] * g + m[8] * b);
    }

    // ------------------------------------------------------------------ small things

    private static float density(View v) {
        try {
            float d = v.getResources().getDisplayMetrics().density;
            return d > 0f ? d : 1f;
        } catch (RuntimeException e) {
            return sDensity;
        }
    }

    static float clamp(float v, float lo, float hi) {
        return v < lo ? lo : v > hi ? hi : v;
    }

    /** The colour with its opacity multiplied by <code>k</code>. */
    static int fade(int color, float k) {
        int a = Math.round((color >>> 24) * clamp(k, 0f, 1f));
        return (a << 24) | (color & 0xffffff);
    }

    private static int byteOf(float v) {
        int i = Math.round(v);
        return i < 0 ? 0 : i > 255 ? 255 : i;
    }

    /** RGB to hue (0..360), saturation and value (0..1). */
    static void hsv(int color, float[] out) {
        float r = ((color >> 16) & 0xff) / 255f, g = ((color >> 8) & 0xff) / 255f, b = (color & 0xff) / 255f;
        float max = Math.max(r, Math.max(g, b)), min = Math.min(r, Math.min(g, b));
        float d = max - min, h;
        if (d <= 0f) h = 0f;
        else if (max == r) h = 60f * (((g - b) / d) % 6f);
        else if (max == g) h = 60f * ((b - r) / d + 2f);
        else h = 60f * ((r - g) / d + 4f);
        if (h < 0f) h += 360f;
        out[0] = h;
        out[1] = max <= 0f ? 0f : d / max;
        out[2] = max;
    }

    /** Hue (0..360), saturation and value (0..1) to opaque RGB. */
    static int rgb(float h, float s, float v) {
        float c = v * s;
        float hp = (h % 360f) / 60f;
        float x = c * (1f - Math.abs(hp % 2f - 1f));
        float r, g, b;
        if (hp < 1f) { r = c; g = x; b = 0f; }
        else if (hp < 2f) { r = x; g = c; b = 0f; }
        else if (hp < 3f) { r = 0f; g = c; b = x; }
        else if (hp < 4f) { r = 0f; g = x; b = c; }
        else if (hp < 5f) { r = x; g = 0f; b = c; }
        else { r = c; g = 0f; b = x; }
        float m = v - c;
        return 0xff000000 | (byteOf((r + m) * 255f) << 16) | (byteOf((g + m) * 255f) << 8) | byteOf((b + m) * 255f);
    }
}
