package com.mrkeyboard.app;

import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.view.Window;
import android.view.WindowInsetsController;

/**
 * What a light keyboard theme needs from the code. A theme is light when its labels are dark: the brightness of the
 * key text colour (V of HSV) is at most 0.5, the same rule MrTools.deriveColors uses for the tool bar. Nothing is
 * declared per theme: a theme only has to choose a dark text colour.
 *
 * <p>Two things change with dark labels:
 * <ul>
 * <li>a dark label or icon loses the dark outline that makes the light ones stand out on a dark key (it would only
 *     smudge dark letters on a light key): {@link #shadowRadius} gives a radius of 0 for it. This one goes key by
 *     key, by the colour of what is drawn on that key, because a dark theme can have highlight keys with a light
 *     face and dark labels;</li>
 * <li>from Android 15 on the keyboard reaches under the navigation bar (ImeInsets), so the buttons the system draws
 *     there (back, keyboard switcher) sit on the keyboard's own background: {@link #bars} asks for dark ones on a
 *     light theme and for light ones on a dark theme.</li>
 * </ul>
 */
final class MrLight {
    private MrLight() { }

    /** From this Android on the keyboard draws under the navigation bar (LatinIME.setInputView calls ImeInsets). */
    static final int EDGE_TO_EDGE_SDK = 35;

    /** True when <code>textColor</code>, the colour of the key labels, is dark: the theme is light. */
    static boolean is(int textColor) {
        int r = (textColor >> 16) & 0xff, g = (textColor >> 8) & 0xff, b = textColor & 0xff;
        int max = Math.max(r, Math.max(g, b));
        return max * 2 <= 255;      // V = max / 255 <= 0.5
    }

    /**
     * Radius of the dark outline of a label or an icon drawn in <code>ink</code>: <code>radius</code>, the one of
     * the theme, when the ink is light; none when it is dark.
     */
    static float shadowRadius(int ink, float radius) {
        return is(ink) ? 0f : radius;
    }

    /**
     * Colour of the system buttons under the keyboard, for the theme whose labels are <code>textColor</code>. Only
     * from Android 15 on: before it the system paints its own dark background behind those buttons and they must
     * stay light on every theme.
     */
    static void bars(InputMethodService ime, int textColor) {
        if (ime == null || Build.VERSION.SDK_INT < EDGE_TO_EDGE_SDK) return;
        try {
            Window w = ime.getWindow() == null ? null : ime.getWindow().getWindow();
            if (w != null) Api30.navigationButtons(w, is(textColor));
        } catch (Throwable t) {
            // a keyboard without the right button colour is still a keyboard
        }
    }

    /** The calls of Android 11 and up, apart so that this class loads on any Android. */
    static final class Api30 {
        private Api30() { }

        static void navigationButtons(Window w, boolean dark) {
            WindowInsetsController c = w.getInsetsController();
            if (c == null) return;
            int flag = WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS;
            c.setSystemBarsAppearance(dark ? flag : 0, flag);
        }
    }
}
