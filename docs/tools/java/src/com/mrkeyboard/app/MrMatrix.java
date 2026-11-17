package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;
import android.view.Window;

/**
 * The Matrix effect of the settings screens (Advanced, Screens, "Matrix effect"): letters that fall behind the screen in the colour of the theme.
 * This class decides who gets it and puts it on; the drawing is {@link MrRainDrawable} and the movement {@link MrRain}.
 *
 * <p>The screens that get it are the settings screens: every PreferenceActivity of the app (the settings, the AI settings, the dictionaries, the
 * pages of the keyboard settings) and the home screen (Main). The word screens, the tour, the Sheets editor and the helper windows (translucent,
 * they only hand something over) do not. The setting is off by default and a failure of any kind leaves the screen as it was: a decoration
 * must never be able to stop a screen from opening. With the effect on, the cards of these screens (and the background of the home screen)
 * are see-through ({@link #GLASS}), so that the letters show a little behind them; the header of the settings screens stays solid.
 *
 * <p>MrScreens calls {@link #attach} when a screen is created, before its window is shown, and creates the screen again when the setting changes
 * (the effect needs the window to be accelerated, which Android only takes when the window is created: {@link MrScreens#accelerates}).
 */
final class MrMatrix {
    private MrMatrix() { }

    /** Setting (Advanced, "Screens"): letters falling behind the settings screens. Off by default. */
    static final String KEY = "pref_ui_matrix";
    private static final String HOME = "com.mrkeyboard.app.Main";

    /** True when this screen is one of the settings screens (see above). */
    static boolean eligible(Activity screen) {
        if (screen == null || MrScreens.isHelper(screen.getClass().getName())) return false;
        return screen instanceof PreferenceActivity || HOME.equals(screen.getClass().getName());
    }

    /** The setting is on. A failure to read it counts as off. */
    static boolean enabled(Context context) {
        try {
            return PreferenceManager.getDefaultSharedPreferences(context).getBoolean(KEY, false);
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** The screen is one of the settings screens and the setting is on: it should be drawn with the rain. */
    static boolean wanted(Activity screen) {
        return eligible(screen) && enabled(screen);
    }

    /** Name of the style (res/values/mr_theme.xml) that makes the cards and the background of the screen see-through. */
    static final String GLASS = "MrMatrixGlass";

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
