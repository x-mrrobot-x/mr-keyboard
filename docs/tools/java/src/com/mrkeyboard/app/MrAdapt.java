package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.ColorFilter;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.LayerDrawable;
import android.preference.PreferenceManager;

/**
 * What lets the keyboard take the tone of a theme of the backgrounds: the tools, the letters, the dash under Ctrl, Alt and Shift, the clear glass of the keys,
 * and the bubble of the key that is pressed and the popup of variants. These themes have one set of fixed colours for all of them (a deep blue slate, a pale
 * blue for the "Send" button, a white ink), made for no background in particular, so on a red keyboard, a green landscape or a golden gradient they were
 * still blue and white.
 *
 * <p>The tone ({@link Tone}) is the colour of the keys when the style has one (the person's own colour, a preset of the glass, of the outline or of the gradient:
 * the middle colour of a gradient) and, when the keys have none to give (the clear glass, the dark glass, the white outline), a colour of the background under
 * the keyboard: the colour that stands out in a landscape or a picture ({@link MrBackdrop.Look#accent}), or what a plain colour or a gradient is like at its
 * lower edge. What takes it:
 * <ul>
 * <li>the tools and the panels: each colour of the roles in {@link #share} keeps what it is for (how light it is, so the ink on it still reads, and how opaque)
 * and takes the hue of the tone and a share of its saturation: a face that is a dark slate becomes a dark tone of the colour, the "Send" button a light tone of it;</li>
 * <li>the ink: a white (or a grey that is nearly white) becomes a white pulled a little to the tone, and a black (or a nearly black) a black pulled to it
 * ({@link Tone#ink}); a colour that already has a hue is left alone;</li>
 * <li>the dash of Ctrl, Alt and Shift, off and on ({@link Tone#dash}); the locked one keeps the colour that tells it;</li>
 * <li>the clear glass of the keys: the white veil is drawn through {@link Tone#see}, a white pulled to the tone, so it is not a flat white;</li>
 * <li>the bubble and the popup: the fill and the line of a key of the theme, as colours that hide what is behind them ({@link #face}); the key chosen in the
 * popup is that face a little lighter ({@link #chosen});</li>
 * <li>the cards of the tools ({@link #card}), the floating bar of the emotes ({@link #bar}) and the style in use of the fonts ({@link #fontFill}).</li>
 * </ul>
 *
 * <p>{@link MrTheme#color} answers every role through {@link #adapt}; the drawables of the bubble and of the popup are set by {@link #popup} and
 * {@link #bubble} (the keyboard calls them where it gives them their shape) and the face of the key that is chosen in the popup is drawn by {@link MrGlow}
 * with {@link #popupFilter}. The small keyboards of the themes screen ask {@link Tone} the same things, so they show what the keyboard shows. Any other theme
 * is left exactly as it is.
 */
final class MrAdapt {
    private MrAdapt() { }

    /** How much of the saturation of the tone the tools take (a vivid colour on a button would be too much). */
    static final float SAT_SHARE = 0.65f;
    /** Under this saturation the colour of the keys has no hue to give (white, greys, slates), and a colour of the background is used. */
    static final float GREY = 0.12f;
    /** Which part of the way to the tone each role goes (its saturation; the lightness and the opacity stay): faces and strokes of the buttons, the accent button, the bubble. */
    static final float FACE = 0.85f, STROKE = 0.85f, ACCENT = 0.90f, FAINT = 0.55f, TEXT = 0.30f;
    /** The same for a pale background: the white of the bubble and of the fields is only a breath of the tone. */
    static final float WHITE_SHARE = 0.10f;
    /** A colour with no more saturation than this is an ink that has no hue (white, black, the greys): it takes the tone. */
    static final float INK_NEUTRAL = 0.14f;
    /** How far a light ink and a dark ink go to the tone (the saturation they take, per saturation of the tone), and how light the darkest ink is (value). */
    static final float INK_LIGHT = 0.22f, INK_DARK = 0.65f, INK_DARK_MIN = 0.16f;
    /** How far the white of the clear glass goes to the tone (the saturation it takes, per saturation of the tone). */
    static final float SEE_TINT = 0.30f;
    /** The line of a key that has none (the clear glass) is this much lighter than its face when it is the line of the bubble and of the popup. */
    static final float RIM = 0.28f;
    /** The key chosen in the popup of variants is its face made this much lighter (value, on a dark face) or darker (on a pale one), a little less saturated when lighter. */
    static final float CHOSEN_LIGHT = 0.16f, CHOSEN_DARK = 0.10f, CHOSEN_SAT = 0.92f;
    /** The floating bar of the emotes: the tone at a medium lightness (value) and the share of its saturation that it takes; the same on a pale background. */
    static final float BAR_VALUE = 0.46f, BAR_SAT = 0.95f, BAR_MAX_SAT = 0.80f, BAR_PALE_VALUE = 0.92f, BAR_PALE_SAT = 0.45f;

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

    /** The roles that are ink (letters, icons, small letters): the white or the black of the theme is pulled to the tone. */
    private static boolean isInk(String role) {
        if (role == null) return false;
        switch (role) {
            case "text": case "hint": case "accent_text": case "accent_hint": case "popup_text": case "popup_hint": case "cursor":
            case "panel_icon": case "panel_tab_on_text": case "sel_cancel_text": case "attach_fab_icon": case "tool_ink": case "tool_hint":
            case "sel_send_text": case "lang_text": case "space_text":
                return true;
            default:
                return false;
        }
    }

    /**
     * What a keyboard takes from its theme and background: the hue and the saturation of the tone, and whether the background is a pale one. Immutable;
     * {@link #OFF} takes nothing.
     */
    static final class Tone {
        static final Tone OFF = new Tone(0f, 0f, 0f, false, false, false, null, 0);

        /** The hue (degrees) and the saturation (already {@link #SAT_SHARE} of the tone's) that the tools take. */
        final float hue, sat;
        /** The saturation of the tone itself (0 .. 1), which the ink goes by. */
        final float tint;
        final boolean pale, on;
        /** The theme draws its keys in the hues of their place (a gradient, or the person's own colour): their dash and ink follow the keys. */
        final boolean spectrum;
        /** The white of the clear glass pulled to the tone, as the 3 x 3 matrix that {@link MrGlow#filter} takes; null when the keys are not the clear glass. */
        final float[] see;
        /** The colour of the background at the lower edge (what the keys are over), opaque; 0 when not known. */
        final int under;
        private ColorFilter mSeeFilter;

        private Tone(float hue, float sat, float tint, boolean pale, boolean on, boolean spectrum, float[] see, int under) {
            this.hue = hue;
            this.sat = sat;
            this.tint = tint;
            this.pale = pale;
            this.on = on;
            this.spectrum = spectrum;
            this.see = see;
            this.under = under;
        }

        /**
         * The tone made from the colour {@code base} (what the keys or the background give). {@code clear}: the keys are the clear glass (over a dark
         * background), whose white veil takes it too. {@code under}: the colour of the lower edge of the background.
         */
        static Tone of(int base, boolean pale, boolean spectrum, boolean clear, int under) {
            float[] hsv = new float[3];
            MrGlow.hsv(base, hsv);
            float tint = Math.min(1f, hsv[1]);
            float[] see = null;
            if (clear && !pale && tint > 0f) {
                int w = MrGlow.rgb(hsv[0], tint * SEE_TINT, 1f);
                see = new float[] {((w >> 16) & 0xff) / 255f, 0f, 0f, 0f, ((w >> 8) & 0xff) / 255f, 0f, 0f, 0f, (w & 0xff) / 255f};
            }
            return new Tone(hsv[0], tint * SAT_SHARE, tint, pale, true, spectrum, see, under);
        }

        /** The filter that draws the clear glass of the keys in the tone (null when it does not). */
        synchronized ColorFilter seeFilter() {
            if (see == null) return null;
            if (mSeeFilter == null) mSeeFilter = MrGlow.filter(see);
            return mSeeFilter;
        }

        /**
         * {@code raw} when it is an ink with a hue (the light tone of an outline), else: a light one (white, the pale greys) with a little of the tone
         * in it, a dark one (black, the dark greys) with more, as light or as dark as it was (the darkest is a little lighter than black). Clear
         * colours (no opacity: "none" in a role) are left as they are.
         */
        int ink(int raw) {
            if (!on || (raw >>> 24) == 0) return raw;
            float[] h = new float[3];
            MrGlow.hsv(raw, h);
            if (h[1] > INK_NEUTRAL) return raw;
            float s, v = h[2];
            if (v >= 0.5f) {
                s = tint * INK_LIGHT;
            } else {
                s = tint * INK_DARK;
                v = Math.max(v, INK_DARK_MIN);
            }
            return (raw & 0xff000000) | (MrGlow.rgb(hue, s, v) & 0xffffff);
        }

        /** Whether {@code raw} is an ink that has no hue (see {@link #ink}). */
        boolean neutral(int raw) {
            float[] h = new float[3];
            MrGlow.hsv(raw, h);
            return h[1] <= INK_NEUTRAL;
        }

        /**
         * The colour of the dash of a modifier key, off or on ({@code raw}: the one of the theme): a white one takes the tone as the ink does, the others
         * take its hue as they are (as light and as opaque). The keys that are drawn in the hues of their place (a gradient) follow them, and not this.
         */
        int dash(int raw) {
            if (!on || spectrum || (raw >>> 24) == 0) return raw;
            return neutral(raw) ? ink(raw) : retint(raw, hue, sat, FACE);
        }

        /**
         * The colour of the role {@code role} for a keyboard in this tone: {@code raw}, the one the theme has, moved to the tone when the role is one of
         * those that follow it. Cheap when there is nothing to change.
         */
        int adapt(String role, int raw) {
            if (!on || role == null) return raw;
            if (isInk(role)) return ink(raw);
            if (role.equals("modifier_indicator_off") || role.equals("modifier_indicator_on")) return dash(raw);
            float share = share(role, pale);
            if (share <= 0f) return raw;
            return retint(raw, hue, sat, share);
        }
    }

    private static volatile Tone sTone = Tone.OFF;
    private static volatile String sKey;
    private static boolean sBusy;
    /** The filter of the face of the key chosen in the popup, and the colour it was made for. */
    private static PorterDuffColorFilter sPopupFilter;
    private static int sPopupColour;
    /** The face of a key of the keyboard on the screen as the bubble and the popup have it: {fill, line} at rest; null until worked out. */
    private static int[] sFaces;

    /** Forgets what was worked out (tests, and any change of the keyboard that the key below does not tell). */
    static synchronized void reset() {
        sKey = null;
        sTone = Tone.OFF;
        sPopupFilter = null;
        sFaces = null;
    }

    /** Whether the keyboard on the screen is a theme of the backgrounds that takes a tone (there is a background under it). */
    static boolean active() {
        return tone().on;
    }

    /** The tone of the keyboard on the screen ({@link Tone#OFF} on a theme that takes none). */
    static Tone current() {
        return tone();
    }

    /**
     * The colour of the role {@code role} for the keyboard on the screen: {@code raw}, the one the theme has, moved to the tone of the theme when it is
     * one of the backgrounds and the role is one of those that follow it. Cheap when there is nothing to change.
     */
    static int adapt(String role, int raw) {
        if (sBusy) return raw;
        return tone().adapt(role, raw);
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
                sFaces = null;
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
        int keys = keyColour(tag, MrKeyLook.current(c));
        return Tone.of(base(keys, bg.accent, bg.bottom), pale, MrTheme.spectrum(), MrBackdrop.TAG_LIGHT_INK.equals(tag), bg.bottom);
    }

    /**
     * The colour that the tone is made from: the colour of the keys when it has a hue to give, else the colour that stands out in the background
     * ({@code accent}: a landscape or a picture), else the colour of its lower edge.
     */
    static int base(int keys, int accent, int bottom) {
        float[] hsv = new float[3];
        if (keys != 0) {
            MrGlow.hsv(keys, hsv);
            if (hsv[1] >= GREY) return keys;
        }
        if (accent != 0) {
            MrGlow.hsv(accent, hsv);
            if (hsv[1] >= GREY) return accent;
        }
        return bottom;
    }

    /** The colour that the keys of the theme have (the middle one of a gradient); 0 when the style has none (the clear glass). */
    static int keyColour(Context c, String tag) {
        return keyColour(tag, MrKeyLook.current(c));
    }

    /** The same for a look that is not the one in use (the small keyboards of the themes screen). */
    static int keyColour(String tag, MrKeyLook look) {
        if (MrBackdrop.isOwn(tag)) {
            int[] s = MrKeyLook.spectrum(tag, look);
            return s == null ? 0 : s[1];
        }
        int style = MrBackdrop.styleOf(tag);
        if (style <= 0 || style >= MrBackdrop.PRESETS) return 0;
        int[] cs = MrBackdrop.STYLE_COLORS[style];
        return cs.length > 1 ? cs[1] : cs[0];
    }

    // ---- the face of a key, for the popup of variants and the bubble

    /**
     * The fill and the line of the face of a key of the theme {@code tag} (at rest, or {@code pressed}) as the person has them tuned, as two opaque colours:
     * a key is see-through, so the colours are the ones it has over {@code under}, the colour of the background at the lower edge, which is what the bubble and
     * the popup need to hide the keys behind them. A key with no line (the clear glass) gets one a little lighter than its face ({@link #RIM}), so that the
     * bubble can be told from the keys. Null when the theme has no face to give.
     */
    static int[] face(Context c, String tag, MrKeyLook look, int under, boolean pressed) {
        if (c == null || tag == null || look == null || (under >>> 24) == 0) return null;
        String state = pressed ? "pressed" : "normal";
        int fill = MrThemeColors.own(c, tag, "key_" + state + "_fill");
        if (fill == 0) return null;
        int edge = MrThemeColors.own(c, tag, "key_" + state + "_edge");
        int[] spectrum = MrKeyLook.spectrum(tag, look);      // the person's own colour
        int mid = spectrum != null ? spectrum[1] : MrThemeColors.own(c, tag, "spectrum_mid");
        if (mid != 0) {
            float[] m = MrGlow.remap(MrThemeColors.own(c, tag, "glow"), mid);
            fill = MrGlow.map(m, fill);
            edge = edge == 0 ? 0 : MrGlow.map(m, edge);
        }
        fill = MrGlow.scale(fill, look.key / 100f);
        edge = edge == 0 ? 0 : MrGlow.scale(edge, look.edge / 100f);
        if (look.line != 0) edge = MrGlow.fade(look.line, look.lineAlpha());
        int face = over(under, fill);
        int line = (edge >>> 24) == 0 ? MrBackdrop.mix(face, 0xffffffff, RIM) : over(under, edge);
        return new int[] {face, line};
    }

    /** The colour {@code top} (any opacity) drawn over the opaque colour {@code under}. */
    static int over(int under, int top) {
        return MrBackdrop.mix(under, 0xff000000 | top, (top >>> 24) / 255f);
    }

    /**
     * The face of a key of the keyboard on the screen, as {@link #face} gives it: {fill, line} at rest. Null on a theme that takes no tone.
     */
    private static synchronized int[] faceNow() {
        Tone t = tone();
        if (!t.on || t.under == 0) return null;
        if (sFaces == null) {
            Context c = MrTools.sApp;
            int[] rest = face(c, MrTheme.tag(), MrKeyLook.current(c), t.under, false);
            if (rest == null) return null;
            sFaces = rest;
        }
        return new int[] {sFaces[0], sFaces[1]};
    }

    // ---- the popup of variants and the bubble

    /**
     * The background of the popup of variants (two layers: the shadow, and the fill with its line): the face of a key of the theme and its line. The
     * keyboard calls it where it gives the drawable its shape. Nothing changes on a theme that takes no tone.
     */
    static void popup(Drawable d) {
        try {
            if (d == null || !active()) return;
            int[] f = faceNow();
            if (f != null) paint(d, f[0], f[1], 0);
            else paint(d, MrTheme.color("bubble_fill"), MrTheme.color("bubble_stroke"), 0);
        } catch (RuntimeException e) {
            // the popup keeps the colours of the theme
        }
    }

    /** The bubble of the key that is pressed, the same way: the face and the line of a key, and the three dots of the one that has variants (the ink of the small letters). */
    static void bubble(Drawable d) {
        try {
            if (d == null || !active()) return;
            int[] f = faceNow();
            if (f != null) paint(d, f[0], f[1], MrTheme.color("hint"));
            else paint(d, MrTheme.color("bubble_fill"), MrTheme.color("preview_stroke"), MrTheme.color("preview_dots"));
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
     * The face of the key chosen in the popup of variants for the popup whose face is {@code face}: the same colour a little lighter (a pale one, a little
     * darker), so it reads as the key under the finger and keeps the hue of the popup.
     */
    static int chosen(int face) {
        float[] h = new float[3];
        MrGlow.hsv(face, h);
        boolean pale = h[2] > 0.75f;
        float s = pale ? Math.min(1f, h[1] / CHOSEN_SAT) : h[1] * CHOSEN_SAT;
        float v = pale ? Math.max(0f, h[2] - CHOSEN_DARK) : Math.min(1f, h[2] + CHOSEN_LIGHT);
        return 0xff000000 | (MrGlow.rgb(h[0], s, v) & 0xffffff);
    }

    /**
     * The filter that draws the face of the key chosen in the popup of variants: the face of the popup made a little lighter ({@link #chosen}). The face (a
     * shape with round corners) takes the colour and keeps its form. Null on a theme that takes no tone.
     */
    static synchronized PorterDuffColorFilter popupFilter() {
        if (!active()) return null;
        int[] f = faceNow();
        int colour = f != null ? chosen(f[0]) : MrTheme.color("popup_key_fill");
        if (sPopupFilter == null || sPopupColour != colour) {
            sPopupFilter = new PorterDuffColorFilter(colour, PorterDuff.Mode.SRC_IN);
            sPopupColour = colour;
        }
        return sPopupFilter;
    }

    // ---- what the tools take from the tone besides the roles

    /**
     * The fill of a card of the tools (the clipboard, the attachments, the results of the emotes): on a theme of the backgrounds the face of the buttons
     * inside the tools (the accent of the tools at the opacity of alpha_btn, what MrTools.softBg draws), so the cards and the buttons are one colour;
     * {@code fallback} on any other theme.
     */
    static int card(int fallback) {
        try {
            if (!active()) return fallback;
            int accent = MrTools.accent() & 0xffffff;
            int alpha = MrTheme.color("alpha_btn") & 0xff000000;
            return accent == 0 || alpha == 0 ? fallback : alpha | accent;
        } catch (RuntimeException e) {
            return fallback;
        }
    }

    /**
     * The floating bar of the emotes (search, symbols, emojis, delete): on a theme of the backgrounds the tone at a medium lightness, opaque (on a pale
     * background a light one); {@code fallback} on any other theme.
     */
    static int bar(int fallback) {
        try {
            Tone t = tone();
            if (!active() || !t.on) return fallback;
            float s = t.pale ? t.tint * BAR_PALE_SAT : Math.min(BAR_MAX_SAT, t.tint * BAR_SAT);
            return 0xff000000 | (MrGlow.rgb(t.hue, s, t.pale ? BAR_PALE_VALUE : BAR_VALUE) & 0xffffff);
        } catch (RuntimeException e) {
            return fallback;
        }
    }

    /** How opaque the button of the style in use of the fonts is (it is a little see-through, so the background shows in it). */
    static final float FONT_OPACITY = 0.72f;

    /**
     * The button of the style in use in the tool of the fonts: the accent button of the theme in the tone (the one of Send), a little see-through, on a
     * theme of the backgrounds; {@code fallback} otherwise.
     */
    static int fontFill(int fallback) {
        try {
            if (!active()) return fallback;
            int c = MrTheme.color("sel_send");
            return (c >>> 24) == 0 ? fallback : (Math.round(FONT_OPACITY * 255f) << 24) | (c & 0xffffff);
        } catch (RuntimeException e) {
            return fallback;
        }
    }

    /** The text of the style in use in the tool of the fonts: the one that goes with {@link #fontFill}; {@code fallback} otherwise. */
    static int fontInk(int fallback) {
        try {
            if (!active()) return fallback;
            int c = MrTheme.color("sel_send_text");
            return (c >>> 24) == 0 ? fallback : c;
        } catch (RuntimeException e) {
            return fallback;
        }
    }
}
