package com.mrkeyboard.app;

import android.content.ContentResolver;
import android.content.Context;
import android.content.res.Resources;
import android.provider.Settings;
import android.view.View;

import java.util.WeakHashMap;

/**
 * The space under the last row of keys, by the way the person navigates in Android.
 * <p>
 * With the home gesture the system keeps the bottom of the screen for the swipe (the gesture bar is 24 dp and the area that detects the
 * swipe is 32 dp, <code>navigation_bar_gesture_height</code> of AOSP), so a last row that touches the edge of the window sits right
 * where a swipe up starts, and a finger that slides while typing by gestures leaves the keyboard. Gboard leaves about 10 dp under the
 * row. With the three buttons (or two) the system draws its own bar of 48 dp under the keyboard and a thin margin is enough.
 * <p>
 * The space is part of the height of the keyboard: {@link #keysHeight} takes it out of the share of the screen that the setting
 * "Keyboard height" gives (the keys give way by the same amount, so the keyboard keeps the height the person chose), and {@link #apply}
 * adds it as bottom padding of the view that holds the toolbar and the keys (it has the background of the theme, so the space is painted
 * like the keyboard). From Android 15 on ImeInsets adds the system bar on top of it.
 * <p>
 * The way of navigating is <code>Settings.Secure navigation_mode</code> (0 three buttons, 1 two, 2 gestures; the same value as the
 * resource <code>config_navBarInteractionMode</code>); Samsung and Xiaomi have settings of their own for their full-screen gestures.
 */
public final class MrBottom {
    /** Space under the last row with the home gesture, in dp (the gesture area of the system, 32 dp, less its bar, 24 dp, is 8 dp; Gboard leaves about 10). */
    static final float GESTURE_DP = 10f;
    /** The same with the buttons of the system, in dp. */
    static final float BUTTONS_DP = 4f;

    /** Values of Settings.Secure navigation_mode. */
    static final int MODE_GESTURES = 2;
    static final String NAVIGATION_MODE = "navigation_mode";
    static final String NAV_BAR_MODE_RES = "config_navBarInteractionMode";
    /** Settings.Global of the full-screen gestures of Samsung (One UI) and of Xiaomi (MIUI/HyperOS): 1 = on. */
    static final String SAMSUNG_GESTURES = "navigation_bar_gesture_while_hidden";
    static final String XIAOMI_GESTURES = "force_fsg_nav_bar";

    /** The keys never give up more than half of their share of the screen, whatever the space. */
    static final int MIN_KEYS_PERCENT = 50;

    /** The padding that apply() added to a view, so that asking twice does not add it twice. */
    private static final WeakHashMap<View, Integer> APPLIED = new WeakHashMap<View, Integer>();

    private MrBottom() { }

    /** True when the home gesture is the way of navigating, from the values of the settings (-1 = not found). */
    static boolean gesturesFrom(int navigationMode, int resourceMode, int samsung, int xiaomi) {
        if (samsung == 1 || xiaomi == 1) return true;
        if (navigationMode >= 0) return navigationMode == MODE_GESTURES;
        return resourceMode == MODE_GESTURES;
    }

    /** True when the person navigates with the home gesture. A value that cannot be read counts as not found. */
    static boolean gestures(Context c) {
        try {
            ContentResolver cr = c.getContentResolver();
            int mode = Settings.Secure.getInt(cr, NAVIGATION_MODE, -1);
            int res = -1;
            if (mode < 0) res = resourceMode();
            int samsung = Settings.Global.getInt(cr, SAMSUNG_GESTURES, -1);
            int xiaomi = Settings.Global.getInt(cr, XIAOMI_GESTURES, -1);
            return gesturesFrom(mode, res, samsung, xiaomi);
        } catch (RuntimeException e) {
            return false;
        }
    }

    private static int resourceMode() {
        try {
            Resources r = Resources.getSystem();
            int id = r.getIdentifier(NAV_BAR_MODE_RES, "integer", "android");
            return id == 0 ? -1 : r.getInteger(id);
        } catch (RuntimeException e) {
            return -1;
        }
    }

    /** The space under the last row, in dp, for the way of navigating. */
    static float gapDp(boolean gestures) {
        return gestures ? GESTURE_DP : BUTTONS_DP;
    }

    /** The space under the last row, in pixels, now. */
    public static int gapPx(Context c) {
        try {
            float density = c.getResources().getDisplayMetrics().density;
            return Math.round(gapDp(gestures(c)) * density);
        } catch (RuntimeException e) {
            return 0;
        }
    }

    /**
     * Height of the rows of keys: <code>total</code>, the share of the screen that the setting gives to the keyboard, less the space under
     * them; never less than {@link #MIN_KEYS_PERCENT} per cent of it.
     */
    static int keysHeight(int total, int gapPx) {
        if (total <= 0 || gapPx <= 0) return total;
        return Math.max(total - gapPx, total * MIN_KEYS_PERCENT / 100);
    }

    /** Height of the rows of keys for the share of the screen <code>total</code> (the Keyboard calls it when it is made). */
    public static int keysHeight(Context c, int total) {
        return keysHeight(total, gapPx(c));
    }

    /**
     * Adds the space under the last row as bottom padding of <code>root</code>, the view that holds the toolbar and the keys. Asked again
     * for the same view it sets the space again (a new way of navigating), it does not add it a second time.
     */
    public static void apply(View root) {
        if (root == null || root instanceof LatinKeyboardBaseView) return;
        try {
            int gap = gapPx(root.getContext());
            Integer was = APPLIED.get(root);
            int base = root.getPaddingBottom() - (was == null ? 0 : was.intValue());
            root.setPadding(root.getPaddingLeft(), root.getPaddingTop(), root.getPaddingRight(), Math.max(0, base) + gap);
            APPLIED.put(root, Integer.valueOf(gap));
        } catch (RuntimeException e) {
            // Without it the keyboard is as it was: the last row at the edge of the window.
        }
    }
}
