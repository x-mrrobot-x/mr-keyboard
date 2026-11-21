package com.mrkeyboard.app;

import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.LayerDrawable;
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
 * follow (the locked dash of Shift keeps its own reddish colour). The popup of variants and the preview bubble keep the hue of the drawables, except on the themes of the backgrounds, where {@link MrAdapt} gives them (and the tools) the tone of the theme.
 *
 * <p>LatinKeyboardBaseView calls in at nine points: {@link #key} and {@link #hint} once per key, before its face;
 * {@link #drawKey} in place of KeyStyle.drawKey; {@link #bloom} right before the label is drawn, or {@link #edge}
 * when the label is a dead key; {@link #icon} in place of ShadowDrawHelper.draw; {@link #iconFilter} for the colour
 * of the icon; {@link #dash} before the modifier dash and {@link #preview} when the bubble is filled. On a theme
 * without the flag each call does exactly what the keyboard did before it existed.
 *
 * <p>The same calls carry what the person tuned for a theme of the backgrounds ({@link MrKeyLook}): the opacity of the face and of the line of
 * each key (the face is two layers, the fill and the line, each drawn through a filter that scales its opacity, see {@link #drawKey}), the colour of
 * the letters, the icons and the small letters (set in {@link #key} and {@link #hint}) and the colours of the styles of the person's own colour (the
 * spectrum of those themes is made from the look and not from the roles). The dash of a modifier key that is off is drawn faint on these themes.
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

    // ---- what the person tuned (MrKeyLook) for the theme on the keyboard, read again when the theme or the preferences change ----
    private static String sLookTag;
    private static int sLookVersion = -1;
    private static MrKeyLook sLook = MrKeyLook.NONE;
    private static int sText;               // the colour of the letters that the person chose; 0 = the theme's
    private static int sOverOff = -1;       // theme of the backgrounds: the colour (RGB) of the dash that is off, to be drawn faint; -1 = any other theme
    private static ColorFilter[] sFillFilter, sEdgeFilter;   // [step, or STEPS + 1 for none] the face and the line of the key with the opacity chosen
    /** Opacity of the small letters of a key when the person chose the colour of the letters (a share of it). */
    static final float HINT_SHARE = 0.70f;

    // ---- key being drawn (set by key()) ----
    private static float sDensity = 1f;
    private static int sGlow;               // glow colour of this key; 0 = the theme has none
    private static int sStep = -1;          // spectrum step of this key; -1 = none
    private static int sInk;                // spectrum: colour of the label and of the icon; 0 = the theme's own
    private static boolean sPopup;          // the key is one of the popup of variants (its view has no tag)

    // ---- small caches ----
    private static int sIconGlowColor, sInkFilterColor;
    private static ColorFilter sIconGlowFilter, sInkFilter;

    /** True on a neon theme; reads the colours of the theme the first time and after a theme change. */
    private static boolean sync() {
        tuning();
        if (!MrTheme.glow()) return false;
        String tag = MrTheme.tag();
        if (tag == null ? sTag != null : !tag.equals(sTag)) load(tag);
        return true;
    }

    /** Reads what the person tuned when the theme or the preferences changed; a style of their own colour is made again from it. */
    private static void tuning() {
        String tag = MrTheme.tag();
        int version = MrKeyLook.version();
        if (version == sLookVersion && (tag == null ? sLookTag == null : tag.equals(sLookTag))) return;
        sLookTag = tag;
        sLookVersion = version;
        boolean over = MrThemeColors.hidden(tag);
        sLook = over ? MrKeyLook.current(MrTools.sApp) : MrKeyLook.NONE;
        sText = sLook.text;
        sOverOff = over ? MrTheme.color("modifier_indicator_off") & 0xffffff : -1;
        sFillFilter = null;
        sEdgeFilter = null;
        if (MrBackdrop.isOwn(tag)) sTag = null;      // its hues come from the look: load() runs again
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
            int[] own = MrKeyLook.spectrum(tag, sLook);      // the styles of the person's own colour
            if (own != null) {
                sStart = own[0];
                sMid = own[1];
                sEnd = own[2];
            }
            sMatrix = new float[STEPS + 1][];
            sFaceFilter = new ColorFilter[STEPS + 1];
            sHue = new int[STEPS + 1];
        }
    }

    /**
     * The colour of the text and of the icons of the toolbar that the person chose (the colour of the letters of the keys), for a theme of the backgrounds;
     * 0 = the theme's own. MrTools.wrap asks it when the keyboard is made.
     */
    static int toolInk() {
        tuning();
        return sText;
    }

    /** The secondary text of the toolbar for the ink {@code ink} that the person chose: the same colour, fainter. */
    static int toolHint(int ink) {
        return fade(ink, HINT_SHARE);
    }

    /** Forgets the theme that was read (tests). */
    static void reset() {
        sTag = null;
        sLookTag = null;
        sLookVersion = -1;
        sLook = MrKeyLook.NONE;
        sText = 0;
        sOverOff = -1;
        sFillFilter = null;
        sEdgeFilter = null;
        sGlow = 0;
        sStep = -1;
        sInk = 0;
        sPopup = false;
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
        sPopup = v != null && v.getTag() == null;
        if (!sync()) {
            sGlow = 0;
        } else {
            sDensity = density(v);
            sGlow = accent ? sAccentGlow : sKeyGlow;
            boolean lit = (sGlow >>> 24) != 0;       // a style of the person's own colour has the hue of the drawables and no light of its own
            if (!lit) sGlow = 0;
            if (sSpectrum && v != null && k != null && v.getTag() != null) {       // the popup of variants has no tag
                int step = step(k.x + k.width * 0.5f, k.y + k.height * 0.5f, v.getWidth(), v.getHeight());
                float[] m = matrix(step);
                if (m != null) {
                    sStep = step;
                    sGlow = lit ? (sGlow & 0xff000000) | (sHue[step] & 0xffffff) : 0;
                    if (p != null) {
                        sInk = map(m, p.getColor());
                        p.setColor(sInk);
                    }
                }
            }
        }
        // the colour of the letters that the person chose: the letters, and the icons through sInk
        if (sText != 0) {
            sInk = sText;
            if (p != null) p.setColor(sText);
        }
    }

    /**
     * Once per key, right after {@link #key}. <code>p</code>: the paint of the small hint letters of the key;
     * <code>color</code>: the colour the theme gives them. On a spectrum theme they take the hue of the key; on any
     * other the paint is left alone (the keyboard sets it once, before the first key).
     */
    static void hint(Paint p, int color) {
        if (p == null) return;
        if (sText != 0) {
            p.setColor(fade(sText, HINT_SHARE));
            return;
        }
        if (sStep < 0) return;
        p.setColor(map(sMatrix[sStep], color));
    }

    /**
     * In place of KeyStyle.drawKey: on a spectrum theme the face is drawn in the hue of the key, and when the person gave the keys of a background
     * another opacity the face is drawn through filters that scale it: the fill and the line (the last two layers of the face) each with its own,
     * a face of one layer (the clear glass) with the opacity of the fill.
     */
    static void drawKey(Drawable d, Canvas c, int w, int h) {
        if (sPopup && d != null) {
            // the key chosen in the popup of variants of a theme of the backgrounds: the colour that the theme gives it, in the tone of the theme, whole
            // (the opacities that the person tuned are for the keys of the keyboard, not for this face)
            ColorFilter f = MrAdapt.popupFilter();
            if (f != null) {
                d.setColorFilter(f);
                try {
                    KeyStyle.drawKey(d, c, w, h);
                } finally {
                    d.setColorFilter(null);
                }
                return;
            }
        }
        int step = sStep;
        boolean tuned = sLook.faceTuned();
        if (d == null || (step < 0 && !tuned)) {
            KeyStyle.drawKey(d, c, w, h);
            return;
        }
        drawFace(d, c, w, h, step < 0 ? null : faceFilter(step), tuned ? fillFilter(step) : null, tuned ? edgeFilter(step) : null,
                tuned ? sLook.line : 0, sLook.lineAlpha(), sDensity);
    }

    /**
     * Draws the face {@code d}: through {@code whole} (the hue of the key; null = as it is), or, when {@code fill} and {@code edge} are given (the
     * opacities the person chose), with the fill and the line, the last two layers of the face, each through its own filter; a face of one layer
     * goes through {@code fill}. The filters are taken off afterwards.
     */
    static void drawFace(Drawable d, Canvas c, int w, int h, ColorFilter whole, ColorFilter fill, ColorFilter edge) {
        drawFace(d, c, w, h, whole, fill, edge, 0, 0f, 1f);
    }

    /**
     * The same, with the colour of the line that the person chose ({@code line}, 0 = the line of the style): the line of the style is hidden and the
     * keyboard draws a line of its own over the face, of that colour at {@code lineAlpha} (0 .. 1) and 1 dp ({@code density}). It is drawn by the
     * keyboard, not taken from the style, so that every style can have one (the clear glass has none) and it has the colour that was chosen whatever the
     * style's own line is.
     */
    static void drawFace(Drawable d, Canvas c, int w, int h, ColorFilter whole, ColorFilter fill, ColorFilter edge, int line, float lineAlpha, float density) {
        if (d == null) {
            KeyStyle.drawKey(d, c, w, h);
            return;
        }
        if (fill != null) {
            if (edge == null || !splitFace(d, fill, line != 0 ? hidden() : edge)) d.setColorFilter(fill);
        } else if (whole != null) {
            d.setColorFilter(whole);
        }
        try {
            KeyStyle.drawKey(d, c, w, h);
            if (line != 0) strokeFace(d, c, line, lineAlpha, density);
        } finally {
            d.setColorFilter(null);
        }
    }

    private static ColorFilter sHidden;
    private static final Paint sLinePaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private static final RectF sLineRect = new RectF();

    /** The filter that draws nothing (the line of the style, when the person's line is drawn in its place). */
    private static ColorFilter hidden() {
        if (sHidden == null) sHidden = filter(null, 0f);
        return sHidden;
    }

    /**
     * The line of the colour that the person chose: a rounded rectangle 1 dp thick along the edge of the fill of the face (the layer under the line of the
     * style, or the only one), with the corners of that fill. The face has been prepared, so the bounds of its layers are those of the key.
     */
    private static void strokeFace(Drawable d, Canvas c, int line, float alpha, float density) {
        Drawable fill = d.getCurrent();
        if (fill instanceof LayerDrawable) {
            LayerDrawable layers = (LayerDrawable) fill;
            int n = layers.getNumberOfLayers();
            if (n == 0) return;
            fill = layers.getDrawable(n >= 2 ? n - 2 : 0);
        }
        if (fill == null) return;
        Rect b = fill.getBounds();
        float w = Math.max(1f, density);
        sLineRect.set(b.left + w / 2f, b.top + w / 2f, b.right - w / 2f, b.bottom - w / 2f);
        if (sLineRect.width() <= w || sLineRect.height() <= w) return;
        float r = fill instanceof GradientDrawable ? ((GradientDrawable) fill).getCornerRadius() : 0f;
        if (r <= 0f) r = 8f * density;
        r = Math.max(0f, r - w / 2f);
        sLinePaint.setShader(null);
        sLinePaint.setStyle(Paint.Style.STROKE);
        sLinePaint.setStrokeWidth(w);
        sLinePaint.setColor((Math.round(clamp(alpha, 0f, 1f) * 255f) << 24) | (line & 0xffffff));
        c.drawRoundRect(sLineRect.left, sLineRect.top, sLineRect.right, sLineRect.bottom, r, r, sLinePaint);
    }

    /** Gives the fill and the line of the face (its last two layers) their own filters; false when the face has not two layers. */
    private static boolean splitFace(Drawable d, ColorFilter fill, ColorFilter edge) {
        Drawable now = d.getCurrent();
        if (!(now instanceof LayerDrawable)) return false;
        LayerDrawable layers = (LayerDrawable) now;
        int n = layers.getNumberOfLayers();
        if (n < 2) return false;
        layers.getDrawable(n - 2).setColorFilter(fill);
        layers.getDrawable(n - 1).setColorFilter(edge);
        return true;
    }

    private static ColorFilter fillFilter(int step) {
        if (sFillFilter == null) sFillFilter = new ColorFilter[STEPS + 2];
        int i = step < 0 ? STEPS + 1 : step;
        if (sFillFilter[i] == null) sFillFilter[i] = filter(step < 0 ? null : sMatrix[step], sLook.key / 100f);
        return sFillFilter[i];
    }

    private static ColorFilter edgeFilter(int step) {
        if (sEdgeFilter == null) sEdgeFilter = new ColorFilter[STEPS + 2];
        int i = step < 0 ? STEPS + 1 : step;
        if (sEdgeFilter[i] == null) sEdgeFilter[i] = filter(step < 0 ? null : sMatrix[step], sLook.edge / 100f);
        return sEdgeFilter[i];
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

    /** In place of ShadowDrawHelper.draw (dark outline of the icon): on a neon theme, the light of the icon; on any other, nothing. */
    static void icon(Canvas c, Drawable d, Keyboard.Key k, float radius, ColorFilter shadow) {
        int glow = sGlow;
        if (glow == 0) return;
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
        int c = p.getColor();
        // a theme of the backgrounds draws the dash that is off faint (it is only a hint of where the modifier keys are)
        boolean faint = sOverOff >= 0 && (c & 0xffffff) == sOverOff;
        if (sGlow == 0 && sStep < 0) {
            p.clearShadowLayer();
            if (faint) p.setColor(MrKeyLook.dashOff(c));
            return;
        }
        boolean off = (c & 0xffffff) == (sDashOff & 0xffffff);
        boolean lock = (c & 0xffffff) == (sDashLock & 0xffffff);
        if (sStep >= 0 && !lock) c = map(sMatrix[sStep], c);
        if (faint) c = MrKeyLook.dashOff(c);
        p.setColor(c);
        if (off || sGlow == 0) p.clearShadowLayer();
        else p.setShadowLayer(DASH_DP * sDensity, 0f, 0f, c);
    }

    /** When the preview bubble gets its text: the letter shines like the ones on the keys. */
    static void preview(TextView t) {
        if (t == null) return;
        if (!sync()) {
            return;
        }
        if ((sKeyGlow >>> 24) == 0) return;       // a style of the person's own colour has no light
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
            f = filter(sMatrix[step]);
            sFaceFilter[step] = f;
        }
        return f;
    }

    /** The colour filter that draws a drawable written in the hue of {@link #remap}'s <code>from</code> in the hue of its <code>to</code> (the opacity is kept). */
    static ColorFilter filter(float[] m) {
        return filter(m, 1f);
    }

    /** The same, with the opacity multiplied by {@code alpha}; {@code m} null: the colours are left as they are (only the opacity changes). */
    static ColorFilter filter(float[] m, float alpha) {
        if (m == null) {
            return new ColorMatrixColorFilter(new float[] {
                    1f, 0f, 0f, 0f, 0f,
                    0f, 1f, 0f, 0f, 0f,
                    0f, 0f, 1f, 0f, 0f,
                    0f, 0f, 0f, alpha, 0f });
        }
        return new ColorMatrixColorFilter(new float[] {
                m[0], m[1], m[2], 0f, 0f,
                m[3], m[4], m[5], 0f, 0f,
                m[6], m[7], m[8], 0f, 0f,
                0f, 0f, 0f, alpha, 0f });
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

    /** The colour with its opacity multiplied by <code>k</code>, which can be more than 1 (up to full opacity). */
    static int scale(int color, float k) {
        int a = Math.round((color >>> 24) * Math.max(0f, k));
        return (Math.min(255, a) << 24) | (color & 0xffffff);
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
