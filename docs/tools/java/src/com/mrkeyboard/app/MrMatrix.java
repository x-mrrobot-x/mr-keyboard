package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import android.view.Window;

/**
 * The Matrix effect of the screens (Advanced, Screens, "Matrix effect"): letters that fall behind the screens in the colour of the theme.
 * This class decides who gets it and puts it on; the drawing is {@link MrRainDrawable} and the movement {@link MrRain}.
 *
 * <p>Every screen of the app gets it (the settings, the AI settings, the dictionaries, the pages of the keyboard settings, the home screen, the
 * word screens, the tour, the AI style editor, the sheets and the sheet editor), except the helper windows (translucent, they only hand
 * something over). The setting is off by default and a failure of any kind leaves the screen as it was: a decoration must never be able to
 * stop a screen from opening. With the effect on, the cards of the screens (and the background of the ones that draw one) are a little
 * see-through ({@link #GLASS}, and in code {@link #wanted}), so that the letters show behind them, and so are the dialogs ({@link #GLASS_DIALOG});
 * the header of the settings screens stays solid.
 *
 * <p>MrScreens calls {@link #attach} when a screen is created, before its window is shown, and creates the screen again when the setting changes
 * (the effect needs the window to be accelerated, which Android only takes when the window is created: {@link MrScreens#accelerates}).
 */
final class MrMatrix {
    private MrMatrix() { }

    /** Setting (Advanced, "Screens"): letters falling behind the settings screens. Off by default. */
    static final String KEY = "pref_ui_matrix";

    /** True when this window is a screen of the app (see above): everything but the helper windows. */
    static boolean eligible(Activity screen) {
        return screen != null && !MrScreens.isHelper(screen.getClass().getName());
    }

    /** The setting is on. A failure to read it counts as off. */
    static boolean enabled(Context context) {
        try {
            return PreferenceManager.getDefaultSharedPreferences(context).getBoolean(KEY, false);
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** The screen is one of the screens of the app and the setting is on: it should be drawn with the rain, and its cards see-through. */
    static boolean wanted(Activity screen) {
        return eligible(screen) && enabled(screen);
    }

    /** Name of the style (res/values/mr_theme.xml) that makes the cards and the background of the screen see-through. */
    static final String GLASS = "MrMatrixGlass";

    /** Name of the theme of the dialogs (res/values/mr_theme.xml) that is a little see-through. */
    static final String GLASS_DIALOG = "Theme.MrKeyboard.Dialog.Glass";

    /**
     * The theme for a dialog that a screen opens with an explicit theme (the ones that the framework opens take it from the screen: the style of
     * {@link #GLASS} gives the screen the see-through one): the see-through dialog theme when the screen has the effect, else the one that was given.
     */
    static int dialogTheme(Activity screen, int plain) {
        try {
            if (!wanted(screen)) return plain;
            int glass = screen.getResources().getIdentifier(GLASS_DIALOG, "style", screen.getPackageName());
            return glass != 0 ? glass : plain;
        } catch (RuntimeException e) {
            return plain;
        }
    }

    /**
     * Lays the see-through cards over the theme of the screen, so that the rain shows a little through them. It has to be done before the screen
     * is inflated (the layouts read the theme when they are inflated): MrScreens calls {@link #attach} while the screen is being created. A
     * theme or a style that cannot be read leaves the cards solid, and the rain is still there.
     */
    private static void glass(Activity screen) {
        try {
            Resources.Theme theme = screen.getTheme();
            int style = screen.getResources().getIdentifier(GLASS, "style", screen.getPackageName());
            if (theme != null && style != 0) theme.applyStyle(style, true);
        } catch (RuntimeException e) {
            // the cards stay solid
        }
    }

    /** Puts the rain behind the screen as its window background, and the see-through cards over it. True when the rain was put. */
    static boolean attach(Activity screen) {
        try {
            Window window = screen.getWindow();
            if (window == null) return false;
            Resources res = screen.getResources();
            String pkg = screen.getPackageName();
            int bg = res.getColor(res.getIdentifier("mr_ui_bg", "color", pkg));
            int accent = res.getColor(res.getIdentifier("mr_accent", "color", pkg));
            window.setBackgroundDrawable(new MrRainDrawable(bg, accent, res.getDisplayMetrics().density));
            glass(screen);
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }
}
