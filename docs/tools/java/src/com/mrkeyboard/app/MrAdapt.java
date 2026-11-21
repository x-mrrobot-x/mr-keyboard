package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.LayerDrawable;
import android.preference.PreferenceManager;

/**
 * What lets the tools of the keyboard, the bubble of the key that is pressed and the popup of variants take the tone of a theme of the backgrounds.
 * These themes have one set of fixed colours for all of them (a deep blue slate, a pale blue for the "Send" button), made for no background in
 * particular, so on a red keyboard, a green landscape or a golden gradient the buttons of the tools, the popup and the bubble were still blue.
 *
 * <p>The tone is the colour of the keys when the style has one (the person's own colour, a preset of the glass, of the outline or of the gradient: the
 * middle colour of a gradient) and, when the keys have none to give (the clear glass, the dark glass, the white outline), the tone of the background
 * under the keyboard: the plain colour, or what a gradient, a landscape or a picture is like at its lower edge. Each colour of the roles below
 * keeps what it is for (how light it is, so the ink on it still reads, and how opaque) and takes the hue of the tone and a share of its saturation: a
 * face that is a dark slate becomes a dark tone of the colour, the "Send" button a light tone of it.
 *
 * <p>{@link MrTheme#color} answers every role through {@link #adapt}, so each tool, the toolbar and the panels follow it; the drawables of the bubble
 * and of the popup are set by {@link #popup} and {@link #bubble} (the keyboard calls them where it gives them their shape) and the face of the key
 * that is chosen in the popup is drawn by {@link MrGlow} with {@link #popupFilter}. Any other theme is left exactly as it is.
 */
final class MrAdapt {
    private MrAdapt() { }

    /** How much of the saturation of the tone the tools take (a vivid colour on a button would be too much). */
    static final float SAT_SHARE = 0.65f;
    /** Under this saturation the colour of the keys has no hue to give (white, greys, slates), and the tone of the background is used. */
    static final float GREY = 0.12f;
    /** Which part of the way to the tone each role goes (its saturation; the lightness and the opacity stay): faces and strokes of the buttons, the accent button, the bubble. */
    static final float FACE = 0.85f, STROKE = 0.85f, ACCENT = 0.90f, FAINT = 0.55f, TEXT = 0.30f;
    /** The same for a pale background: the white of the bubble and of the fields is only a breath of the tone. */
    static final float WHITE_SHARE = 0.10f;

    /** The roles that take the tone and how far (see above); the others are left as the theme has them. */
    private static float share(String role, boolean pale) {
        if (role == null) return 0f;
        switch (role) {
            case "panel_btn": case "sel_cancel": case "sel_card": return FACE;
            case "sel_cancel_stroke": return STROKE;
            case "sel_send": case "sel_send_stroke": case "sel_media": case "tool_tint": return ACCENT;
            case "attach_fab": case "attach_fab_stroke": case "ctrl_bg": return FAINT;
            case "panel_tab_off_text": return TEXT;
            case "bubble_fill": return pale ? WHITE_SHARE : 0.75f;
            case "bubble_stroke": case "popup_key_fill": case "preview_stroke": case "preview_dots": return ACCENT;
            default: return 0f;
        }
    }

    /** What the keyboard on the screen takes from: its hue and saturation, and whether the background is a pale one. */
    private static final class Tone {
        static final Tone OFF = new Tone(0f, 0f, false, false);
        final float hue, sat;
        final boolean pale, on;

        Tone(float hue, float sat, boolean pale, boolean on) {
            this.hue = hue;
            this.sat = sat;
            this.pale = pale;
            this.on = on;
        }
    }

    private static volatile Tone sTone = Tone.OFF;
    private static volatile String sKey;
    private static boolean sBusy;
    /** The filter of the face of the key chosen in the popup, and the colour it was made for. */
    private static PorterDuffColorFilter sPopupFilter;
    private static int sPopupColour;

    /** Forgets what was worked out (tests, and any change of the keyboard that the key below does not tell). */
    static synchronized void reset() {
        sKey = null;
        sTone = Tone.OFF;
        sPopupFilter = null;
    }

    /** Whether the keyboard on the screen is a theme of the backgrounds that takes a tone (there is a background under it). */
    static boolean active() {
        return tone().on;
    }

    /**
     * The colour of the role {@code role} for the keyboard on the screen: {@code raw}, the one the theme has, moved to the tone of the theme when it is
     * one of the backgrounds and the role is one of those that follow it. Cheap when there is nothing to change.
     */
    static int adapt(String role, int raw) {
        if (sBusy) return raw;
        Tone t = tone();
        if (!t.on) return raw;
        float share = share(role, t.pale);
        if (share <= 0f) return raw;
        return retint(raw, t.hue, t.sat, share);
    }

    /**
     * {@code raw} with the hue {@code hue} and the saturation moved {@code share} of the way to {@code sat}, as light as it was (so the ink on it reads the
     * same) and as opaque. When the hue cannot be as light as that (a pure red cannot be as light as a pale blue), it is made whiter until it is.
     */
    static int retint(int raw, float hue, float sat, float share) {
        float[] hsv = new float[3];
        MrGlow.hsv(raw, hsv);
        float s = hsv[1] + (sat - hsv[1]) * share;
        float want = MrThemeColors.luminance(0xff000000 | raw);
        int out;
        if (MrThemeColors.luminance(MrGlow.rgb(hue, s, 1f)) < want) {
            // lighten by letting the white in: the greatest saturation at which the colour is as light as it was
            float lo = 0f, hi = s;
            for (int i = 0; i < 14; i++) {
                float mid = (lo + hi) / 2f;
                if (MrThemeColors.luminance(MrGlow.rgb(hue, mid, 1f)) < want) hi = mid;
                else lo = mid;
            }
            out = MrGlow.rgb(hue, lo, 1f);
        } else {
            float lo = 0f, hi = 1f;
            for (int i = 0; i < 14; i++) {
                float mid = (lo + hi) / 2f;
                if (MrThemeColors.luminance(MrGlow.rgb(hue, s, mid)) < want) lo = mid;
                else hi = mid;
            }
            out = MrGlow.rgb(hue, s, hi);
        }
        return (raw & 0xff000000) | (out & 0xffffff);
    }

    // ---- the tone

    private static Tone tone() {
        Context c = MrTools.sApp;
        String tag = MrTheme.tag();
        if (c == null || !MrThemeColors.hidden(tag)) return Tone.OFF;
        String key = keyOf(c, tag);
        if (key != null && key.equals(sKey)) return sTone;
        synchronized (MrAdapt.class) {
            if (key != null && key.equals(sKey)) return sTone;
            sBusy = true;
            try {
                sTone = compute(c, tag);
                sKey = key;
                sPopupFilter = null;
            } catch (RuntimeException e) {
                sTone = Tone.OFF;
                sKey = null;
            } finally {
                sBusy = false;
            }
            return sTone;
        }
    }

    /** What the tone depends on: the theme, the look the person tuned, the background and its softening. */
    private static String keyOf(Context c, String tag) {
        String spec = "";
        int soft = 0;
        try {
            SharedPreferences p = PreferenceManager.getDefaultSharedPreferences(c);
            if (p != null) {
                spec = p.getString(MrBackdrop.PREF, "");
                soft = p.getInt(MrBackdrop.PREF_SOFT, 0);
            }
        } catch (RuntimeException e) {
            // a value of another type: the tone is worked out without it
        }
        return tag + "|" + MrKeyLook.version() + "|" + spec + "|" + soft;
    }

    private static Tone compute(Context c, String tag) {
        MrBackdrop.Look bg = MrBackdrop.lookNow(c);
        if (bg == null) return Tone.OFF;
        boolean pale = !MrBackdrop.darkNow(c);
        float[] hsv = new float[3];
        int keys = keyColour(c, tag);
        if (keys != 0) MrGlow.hsv(keys, hsv);
        if (keys == 0 || hsv[1] < GREY) MrGlow.hsv(bg.bottom, hsv);
        return new Tone(hsv[0], Math.min(1f, hsv[1]) * SAT_SHARE, pale, true);
    }

    /** The colour that the keys of the theme have (the middle one of a gradient); 0 when the style has none (the clear glass). */
    static int keyColour(Context c, String tag) {
        if (MrBackdrop.isOwn(tag)) {
            int[] s = MrKeyLook.spectrum(tag, MrKeyLook.current(c));
            return s == null ? 0 : s[1];
        }
        int style = MrBackdrop.styleOf(tag);
        if (style <= 0 || style >= MrBackdrop.PRESETS) return 0;
        int[] cs = MrBackdrop.STYLE_COLORS[style];
        return cs.length > 1 ? cs[1] : cs[0];
    }

    // ---- the popup of variants and the bubble

    /**
     * The background of the popup of variants (two layers: the shadow, and the fill with its line): the fill and the line of the theme, in the tone.
     * The keyboard calls it where it gives the drawable its shape. Nothing changes on a theme that takes no tone.
     */
    static void popup(Drawable d) {
        try {
            if (d == null || !active()) return;
            paint(d, MrTheme.color("bubble_fill"), MrTheme.color("bubble_stroke"), 0);
        } catch (RuntimeException e) {
            // the popup keeps the colours of the theme
        }
    }

    /** The bubble of the key that is pressed, the same way: the fill and the line, and the three dots of the one that has variants. */
    static void bubble(Drawable d) {
        try {
            if (d == null || !active()) return;
            paint(d, MrTheme.color("bubble_fill"), MrTheme.color("preview_stroke"), MrTheme.color("preview_dots"));
        } catch (RuntimeException e) {
            // the bubble keeps the colours of the theme
        }
    }

    /** The fill and the line go to the last shape of the layers, the dots (when there are some, a layer that is not a shape) are tinted. */
    private static void paint(Drawable d, int fill, int line, int dots) {
        d = d.mutate();
        if (!(d instanceof LayerDrawable)) {
            if (d instanceof GradientDrawable) fillAndLine((GradientDrawable) d, fill, line);
            return;
        }
        LayerDrawable l = (LayerDrawable) d;
        int shape = -1;
        for (int i = 0; i < l.getNumberOfLayers(); i++) {
            if (l.getDrawable(i) instanceof GradientDrawable) shape = i;
        }
        for (int i = 0; i < l.getNumberOfLayers(); i++) {
            Drawable layer = l.getDrawable(i);
            if (i == shape) fillAndLine((GradientDrawable) layer, fill, line);
            else if (dots != 0 && !(layer instanceof GradientDrawable) && i > shape && shape >= 0) layer.mutate().setTint(dots);
        }
    }

    private static void fillAndLine(GradientDrawable g, int fill, int line) {
        g.setColor(fill);
        Context c = MrTools.sApp;
        float density = c == null ? 1f : c.getResources().getDisplayMetrics().density;
        g.setStroke(Math.max(1, Math.round(density)), line);
    }

    /**
     * The filter that draws the face of the key chosen in the popup of variants in the colour that the theme gives it, in the tone: the face (a shape with
     * round corners) takes the colour and keeps its form. Null on a theme that takes no tone.
     */
    static synchronized PorterDuffColorFilter popupFilter() {
        if (!active()) return null;
        int colour = MrTheme.color("popup_key_fill");
        if (sPopupFilter == null || sPopupColour != colour) {
            sPopupFilter = new PorterDuffColorFilter(colour, PorterDuff.Mode.SRC_IN);
            sPopupColour = colour;
        }
        return sPopupFilter;
    }
}
