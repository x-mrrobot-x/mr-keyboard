package com.mrkeyboard.app;

import android.content.Context;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.view.View;
import android.view.Window;

import java.util.WeakHashMap;

/**
 * The space under the last row of keys and the navigation bar under the keyboard, as Gboard does them.
 * <p>
 * The last row does not touch the edge of the window: there is {@link #GAP_DP} (4 dp, the value of Gboard) under it, the same with the
 * home gesture and with the buttons (Gboard does not choose it by the way of navigating either). The space is part of the height of the
 * keyboard: {@link #keysHeight} takes it out of the share of the screen that the setting "Keyboard height" gives (the keys give way by the
 * same amount, so the keyboard keeps the height the person chose), and {@link #apply} adds it as bottom padding of the view that holds the
 * toolbar and the keys (it has the background of the theme, so the space is painted like the keyboard). From Android 15 on ImeInsets adds
 * the system bar on top of it.
 * <p>
 * The navigation bar under the keyboard shows the background of the theme ({@link #bar}), as it does with Gboard: the window is asked for
 * a bar of the colour of the keyboard background and no veil of the system (the "contrast" that Android puts on the three buttons: 80% of an
 * opaque colour, a band of another shade). From Android 16 on the keyboard is drawn under the bar (ImeInsets), so the bar is asked to be
 * transparent and the background shows through; before that it is asked for the background colour itself, because the system paints the bar
 * of its own (black) under a window that ends above it. In both the colour of the buttons follows the theme ({@link MrLight#bars}).
 */
public final class MrBottom {
    /** Space under the last row of keys, in dp (the bottom row gap of Gboard). */
    static final float GAP_DP = 4f;

    /** From this Android on the window of the keyboard can colour the navigation bar and its buttons (the controller of Android 11). */
    static final int BAR_SDK = 30;
    /** From this Android on the bar is transparent and the keyboard, drawn under it, shows through (Gboard also paints the bar itself up to Android 15). */
    static final int TRANSPARENT_BAR_SDK = 36;
    /** What MrTheme.color answers for a role it does not have (opaque magenta). */
    static final int NO_COLOR = 0xffff00ff;

    /** The keys never give up more than half of their share of the screen, whatever the space. */
    static final int MIN_KEYS_PERCENT = 50;

    /** The padding that apply() added to a view, so that asking twice does not add it twice. */
    private static final WeakHashMap<View, Integer> APPLIED = new WeakHashMap<View, Integer>();

    private MrBottom() { }

    /** The space under the last row, in pixels, now. */
    public static int gapPx(Context c) {
        try {
            float density = c.getResources().getDisplayMetrics().density;
            return Math.round(GAP_DP * density);
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
     * for the same view it sets the space again (a new density, say), it does not add it a second time.
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

    /**
     * The colour to ask for the navigation bar, for the Android in use and the keyboard background of the theme (<code>background</code>, as
     * MrTheme.color gives it): the background itself up to Android 15, as Gboard does, with its opacity (a see-through theme gets a
     * see-through bar); nothing (0, transparent) from Android 16 on, where the keyboard is drawn under the bar and shows through. A theme
     * without that role gives {@link #NO_COLOR}, which {@link #bar} does not ask for before Android 16.
     */
    static int barColor(int sdk, int background) {
        if (sdk >= TRANSPARENT_BAR_SDK) return 0;
        return background;
    }

    /**
     * Lets the navigation bar of the system show the background of the keyboard theme, and sets the colour of its buttons for it. From Android
     * 11 to 15 the bar has the colour of the background, which the system would otherwise paint black; from Android 16 on it is transparent.
     * Both without the veil that the system puts on the three buttons (the "contrast" of the bar). Before Android 11 nothing is asked. The
     * window keeps the values, but it is asked again when it is shown, because a window that the system made again has the defaults.
     */
    public static void bar(InputMethodService ime) {
        if (ime == null || Build.VERSION.SDK_INT < BAR_SDK) return;
        try {
            android.app.Dialog dialog = ime.getWindow();
            Window w = dialog == null ? null : dialog.getWindow();
            if (w == null) return;
            int color = barColor(Build.VERSION.SDK_INT, MrTheme.color("kbd_bg"));
            if (Build.VERSION.SDK_INT < TRANSPARENT_BAR_SDK && color == NO_COLOR) return;
            Api29.bar(w, color);
            MrLight.bars(ime, MrTools.sTextColor);
        } catch (Throwable t) {
            // a keyboard with the bar of the system is still a keyboard
        }
    }

    /** The call of Android 10, apart so that this class loads on any Android. */
    static final class Api29 {
        private Api29() { }

        static void bar(Window w, int color) {
            w.setNavigationBarColor(color);
            w.setNavigationBarContrastEnforced(false);
        }
    }
}
