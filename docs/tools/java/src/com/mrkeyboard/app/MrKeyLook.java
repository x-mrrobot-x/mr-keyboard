package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

/**
 * What the person tunes about the keys of a background, besides the style: how much the face of a key shows (its opacity), how much its line shows,
 * the colour of the letters and, for the styles of their own colour (one for each kind of style: glass, outline and gradient), that colour (and the end
 * of the gradient). It is made in the dialog of a background and kept in the preferences {@code pref_kbd_look_*}; only a theme of the backgrounds
 * (tag {@code mr_over...}) reads it, so a theme of the list is never touched.
 *
 * <p>The opacities are shares of the opacity the style gives (100 = as it is, 0 = nothing, up to {@link #OPACITY_MAX}); the face of a key of these
 * themes is two layers (the fill and the line), so that each has its own: see {@link MrGlow#drawKey}. A colour is an opaque ARGB; 0 means "none".
 *
 * <p>The keyboard reads it through {@link #current} (kept until a {@code pref_kbd_look_*} key changes: the KeyboardSwitcher tells {@link #changed}).
 */
final class MrKeyLook {
    /** The preferences, all of them under one prefix (the keyboard is made again when any of them changes). */
    static final String PREFIX = "pref_kbd_look_";
    static final String PREF_KEY = PREFIX + "key", PREF_EDGE = PREFIX + "edge", PREF_TEXT = PREFIX + "text", PREF_HUE = PREFIX + "hue", PREF_HUE2 = PREFIX + "hue2";
    static final String[] PREFS = {PREF_KEY, PREF_EDGE, PREF_TEXT, PREF_HUE, PREF_HUE2};

    /** The opacities as shares of the style's own (per cent): the one it has, and the most. */
    static final int OPACITY_DEFAULT = 100, OPACITY_MAX = 250;
    /** How much of its colour the dash of a modifier key that is off is drawn with: it is only a hint, so it is faint. */
    static final float DASH_OFF_SHARE = 0.45f;
    /** The hue that the end of a gradient is moved by from its start when the person has not chosen one (degrees). */
    static final float PARTNER_SHIFT = 100f;

    static final MrKeyLook NONE = new MrKeyLook(OPACITY_DEFAULT, OPACITY_DEFAULT, 0, 0, 0);

    /** Opacity of the face and of the line (per cent of the style's own), the colour of the letters (0 = the theme's), the colour of the styles of their own and the end of the gradient. */
    final int key, edge, text, hue, hue2;

    MrKeyLook(int key, int edge, int text, int hue, int hue2) {
        this.key = clampOpacity(key);
        this.edge = clampOpacity(edge);
        this.text = text == 0 ? 0 : 0xff000000 | text;
        this.hue = hue == 0 ? 0 : 0xff000000 | hue;
        this.hue2 = hue2 == 0 ? 0 : 0xff000000 | hue2;
    }

    static int clampOpacity(int v) {
        return v < 0 ? 0 : v > OPACITY_MAX ? OPACITY_MAX : v;
    }

    MrKeyLook withKey(int v) {
        return new MrKeyLook(v, edge, text, hue, hue2);
    }

    MrKeyLook withEdge(int v) {
        return new MrKeyLook(key, v, text, hue, hue2);
    }

    MrKeyLook withText(int v) {
        return new MrKeyLook(key, edge, v, hue, hue2);
    }

    MrKeyLook withHue(int v) {
        return new MrKeyLook(key, edge, text, v, hue2);
    }

    MrKeyLook withHue2(int v) {
        return new MrKeyLook(key, edge, text, hue, v);
    }

    /** True when nothing is tuned. */
    boolean isNone() {
        return key == OPACITY_DEFAULT && edge == OPACITY_DEFAULT && text == 0 && hue == 0 && hue2 == 0;
    }

    /** True when the face of the keys has to be drawn in two layers with their own opacity. */
    boolean faceTuned() {
        return key != OPACITY_DEFAULT || edge != OPACITY_DEFAULT;
    }

    boolean same(MrKeyLook o) {
        return o != null && key == o.key && edge == o.edge && text == o.text && hue == o.hue && hue2 == o.hue2;
    }

    // ---- the preferences

    static MrKeyLook read(SharedPreferences sp) {
        if (sp == null) return NONE;
        try {
            return new MrKeyLook(sp.getInt(PREF_KEY, OPACITY_DEFAULT), sp.getInt(PREF_EDGE, OPACITY_DEFAULT), sp.getInt(PREF_TEXT, 0), sp.getInt(PREF_HUE, 0), sp.getInt(PREF_HUE2, 0));
        } catch (ClassCastException e) {
            return NONE;
        }
    }

    static MrKeyLook read(Context c) {
        return c == null ? NONE : read(PreferenceManager.getDefaultSharedPreferences(c));
    }

    /** Writes every value (the default ones too, so that the one that was there before is not left behind). */
    void write(SharedPreferences.Editor e) {
        e.putInt(PREF_KEY, key);
        e.putInt(PREF_EDGE, edge);
        e.putInt(PREF_TEXT, text);
        e.putInt(PREF_HUE, hue);
        e.putInt(PREF_HUE2, hue2);
    }

    // ---- what the keyboard has read

    private static MrKeyLook sCurrent;
    private static int sVersion;

    /** What the keyboard reads: the preferences, kept until {@link #changed} says one of them moved. */
    static MrKeyLook current(Context c) {
        MrKeyLook l = sCurrent;
        if (l == null) {
            l = read(c);
            if (c != null) sCurrent = l;      // nothing is kept while there is no context to read it with
        }
        return l;
    }

    /** Which read it is: it goes up every time the preferences are read again (what is kept per theme is made again when it moves). */
    static int version() {
        return sVersion;
    }

    /** Whether the preference {@code key} is one of these; when it is, what was read is let go (the keyboard is made again by the caller). */
    static boolean changed(String key) {
        if (key == null || !key.startsWith(PREFIX)) return false;
        invalidate();
        return true;
    }

    static void invalidate() {
        sCurrent = null;
        sVersion++;
    }

    // ---- the styles of their own colour

    /** The three hues (start, middle, end) that a theme of its own colour turns through with this look; null for any other theme. */
    static int[] spectrum(String tag, MrKeyLook look) {
        if (!MrBackdrop.isOwn(tag) || look == null) return null;
        int start = look.hue != 0 ? look.hue : MrBackdrop.OWN_DEFAULT;
        if (MrBackdrop.kindOf(MrBackdrop.styleOf(tag)) != MrBackdrop.KIND_GRADIENT) return new int[] {start, start, start};
        int end = look.hue2 != 0 ? look.hue2 : partner(start);
        return new int[] {start, middle(start, end), end};
    }

    /** The end of a gradient that starts at {@code start}, when the person did not choose one: the same colour turned along the hues. */
    static int partner(int start) {
        float[] hsv = new float[3];
        MrGlow.hsv(start, hsv);
        float s = hsv[1] < 0.35f ? 0.55f : hsv[1], v = hsv[2] < 0.6f ? 0.9f : hsv[2];
        return MrGlow.rgb((hsv[0] + PARTNER_SHIFT) % 360f, s, v);
    }

    /** The colour half way from {@code a} to {@code b} the short way round the hues. */
    static int middle(int a, int b) {
        return MrGlow.ramp(a, b, b, 0.25f);
    }

    /** What the dash of a modifier key that is off is drawn with: its colour at {@link #DASH_OFF_SHARE} of its opacity. */
    static int dashOff(int colour) {
        return MrGlow.fade(colour | 0xff000000, DASH_OFF_SHARE);
    }
}
