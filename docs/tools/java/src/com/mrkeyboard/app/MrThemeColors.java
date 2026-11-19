package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;

/**
 * The colours and the names of the keyboard themes, read for any theme and not only for the one in use ({@link MrTheme#color} answers for the
 * theme of the keyboard that is on the screen): the themes screen shows all of them at once. A colour is looked up the way MrTheme does: first
 * {@code <tag>_<role>} ({@code mr_midnight_text}), then {@code mr_<role>}. A role that no colour has gives {@link #NONE}.
 */
final class MrThemeColors {
    /** What a missing role answers (opaque magenta, as MrTheme.color does). */
    static final int NONE = 0xffff00ff;

    /**
     * The two themes of the backgrounds (colours, gradients, landscapes, the picture of the gallery) have tags that start like this: they are
     * themes of the keyboard like the others (a layout, key faces, colours), but the themes screen does not list them, because a background
     * chooses one of them ({@link MrBackdrop#themeTag}) and the choice of a theme of the list puts the background away.
     */
    static final String BACKDROP_PREFIX = "mr_over";

    private MrThemeColors() { }

    /** Whether {@code tag} is one of the themes of the backgrounds. */
    static boolean hidden(String tag) {
        return tag != null && tag.startsWith(BACKDROP_PREFIX);
    }

    /** How many themes the screen lists: the ones that are not themes of the backgrounds (these are put last, so they are the tail of the lists). */
    static int listed(String[] tags) {
        int n = 0;
        while (n < tags.length && !hidden(tags[n])) n++;
        return n;
    }

    /** The position of the theme with this tag, or -1. */
    static int indexOfTag(String[] tags, String tag) {
        for (int i = 0; i < tags.length; i++) {
            if (tags[i].equals(tag)) return i;
        }
        return -1;
    }

    /** The tags of the themes, in the order of the preference value (0 .. n - 1); empty when the resource is missing. */
    static String[] tags(Context c) {
        return array(c, "mr_theme_tags");
    }

    /** The names of the themes, in the same order. */
    static String[] names(Context c) {
        return array(c, "keyboard_layout_modes");
    }

    /**
     * The value of the preference {@code pref_keyboard_layout} for each theme, in the same order ({@code keyboard_layout_modes_values}); when the
     * list is missing or is not as long as the one of the themes, the position of the theme.
     */
    static String[] values(Context c) {
        String[] v = array(c, "keyboard_layout_modes_values");
        int n = tags(c).length;
        if (v.length == n) return v;
        String[] own = new String[n];
        for (int i = 0; i < n; i++) own[i] = String.valueOf(i);
        return own;
    }

    /** The position of the theme that a value of the preference means (the first one when the value is not any theme's). */
    static int indexOf(String[] values, String value) {
        for (int i = 0; i < values.length; i++) {
            if (values[i].equals(value)) return i;
        }
        return 0;
    }

    private static String[] array(Context c, String name) {
        try {
            Resources r = c.getResources();
            int id = r.getIdentifier(name, "array", c.getPackageName());
            if (id == 0) return new String[0];
            String[] a = r.getStringArray(id);
            return a == null ? new String[0] : a;
        } catch (RuntimeException e) {
            return new String[0];
        }
    }

    /** The colour of {@code role} for the theme {@code tag} (null tag: the roles every theme shares). */
    static int color(Context c, String tag, String role) {
        try {
            Resources r = c.getResources();
            String pkg = c.getPackageName();
            if (tag != null) {
                int id = r.getIdentifier(tag + "_" + role, "color", pkg);
                if (id != 0) return r.getColor(id);
            }
            int id = r.getIdentifier("mr_" + role, "color", pkg);
            return id == 0 ? NONE : r.getColor(id);
        } catch (RuntimeException e) {
            return NONE;
        }
    }

    /** Like {@link #color}, with {@code fallback} for a role that is missing. */
    static int colorOr(Context c, String tag, String role, int fallback) {
        int v = color(c, tag, role);
        return v == NONE ? fallback : v;
    }

    /**
     * The colour of a role that most themes leave unsaid (the ink of the toolbar when it is not the one of the keys, the neon glow): the colours
     * every theme shares give it as clear black, which means "none". Returns 0 for none (also when no colour has the role at all).
     */
    static int declared(Context c, String tag, String role) {
        int v = color(c, tag, role);
        return v == NONE ? 0 : v;
    }

    /**
     * The colour of a role that the theme itself says (the shared default is no answer): 0 when it does not. The gradient themes are the ones that say
     * spectrum_start (the hues the keyboard turns through) and the glow (the hue their drawables are written in).
     */
    static int own(Context c, String tag, String role) {
        if (tag == null) return 0;
        try {
            Resources r = c.getResources();
            int id = r.getIdentifier(tag + "_" + role, "color", c.getPackageName());
            return id == 0 ? 0 : r.getColor(id);
        } catch (RuntimeException e) {
            return 0;
        }
    }

    /** The ink of what sits on the background of the keyboard (the suggestions, the icons of the bar): the one the theme declares, else the text of its keys. */
    static int ink(Context c, String tag) {
        int tool = declared(c, tag, "tool_ink");
        if (tool != 0) return 0xff000000 | tool;
        return colorOr(c, tag, "text", 0xffffffff);
    }

    /**
     * Whether the theme sits on a dark background: the colour of its keyboard background (without its transparency) is darker than the middle. This
     * is what the veil of a background goes by (black over a dark theme, white over a light one), and not the ink: Chrome has dark keys' labels on a
     * dark background and Sky has pale labels on a light one, so the ink says nothing about what the toolbar is laid on.
     */
    static boolean dark(Context c, String tag) {
        return luminance(0xff000000 | colorOr(c, tag, "kbd_bg", 0xff202020)) < 0.5f;
    }

    /** Relative brightness of a colour, 0 (black) .. 1 (white): the weights of Rec. 709 on the values as they are. */
    static float luminance(int argb) {
        float r = ((argb >> 16) & 0xff) / 255f;
        float g = ((argb >> 8) & 0xff) / 255f;
        float b = (argb & 0xff) / 255f;
        return 0.2126f * r + 0.7152f * g + 0.0722f * b;
    }

    /** The drawable of a key of the theme ({@code btn_keyboard_key_midnight}, or the {@code _accent} one); 0 when the theme has none. */
    static int keyDrawable(Context c, String tag, boolean accent) {
        if (tag == null) return 0;
        try {
            String base = tag.startsWith("mr_") ? tag.substring(3) : tag;
            return c.getResources().getIdentifier("btn_keyboard_key_" + base + (accent ? "_accent" : ""), "drawable", c.getPackageName());
        } catch (RuntimeException e) {
            return 0;
        }
    }
}
