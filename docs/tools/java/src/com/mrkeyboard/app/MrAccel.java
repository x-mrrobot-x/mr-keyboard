package com.mrkeyboard.app;

import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

/**
 * Diagnostic of the keyboard window: is it drawn with hardware acceleration?
 *
 * The manifest says <code>hardwareAccelerated="false"</code> for the app, but the documentation of InputMethodService says
 * that the system turns the acceleration of the keyboard window on by itself (API 21+), whatever the app says. That was
 * never confirmed on a device, so the first time the keyboard window is shown in a process this
 * <ul>
 * <li>writes ONE line to the log with what the window really has (<code>adb logcat -s MrAccel</code>), and</li>
 * <li>keeps the answer, with the Android it was measured on, in its own preferences file "mr_diag" (outside the backup,
 * which only takes the default preferences), so that the Advanced screen can show it without adb.</li>
 * </ul>
 * It changes nothing else; a failure of any kind is swallowed (a diagnostic must never be able to hurt the keyboard).
 */
public final class MrAccel {
    static final String TAG = "MrAccel";
    /** Preferences file of the diagnostic (not the default one: the backup and "Restore defaults" do not touch it). */
    static final String PREFS = "mr_diag";
    static final String KEY_ACCEL = "kbd_accel";
    static final String KEY_SDK = "kbd_sdk";
    /** Key of the read-only row of the Advanced screen about the keyboard window. */
    static final String ROW = "mr_kbd_accel";
    /** Key of the read-only row about the screen itself (what the app asked and what the system gave). */
    static final String ROW_SCREEN = "mr_scr_accel";
    static final int FLAG_HW = WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED;

    /** Nothing measured yet on this Android. */
    static final int UNKNOWN = 0;
    static final int ACCELERATED = 1;
    static final int SOFTWARE = 2;

    /** True after the line was written (once per process). */
    private static boolean sLogged;

    private MrAccel() { }

    /** LatinIME.onWindowShown: waits for the decor view to be attached to its window, which is when the answer is true. */
    public static void onShown(InputMethodService ime) {
        if (sLogged || ime == null) return;
        try {
            Dialog dialog = ime.getWindow();
            Window window = dialog == null ? null : dialog.getWindow();
            final View decor = window == null ? null : window.getDecorView();
            if (decor == null) return;
            decor.post(new Runnable() {
                public void run() { log(decor); }
            });
        } catch (RuntimeException e) {
            // diagnostic only
        }
    }

    /** Writes the line and keeps the answer, once, when the window is attached (before that the view does not know yet). */
    static void log(View decor) {
        if (sLogged || !decor.isAttachedToWindow()) return;
        sLogged = true;
        boolean accelerated = decor.isHardwareAccelerated();
        Log.i(TAG, "keyboard window hardwareAccelerated=" + accelerated + " (SDK " + Build.VERSION.SDK_INT + ")");
        try {
            Context c = decor.getContext();
            if (c == null) return;
            c.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                    .putBoolean(KEY_ACCEL, accelerated).putInt(KEY_SDK, Build.VERSION.SDK_INT).apply();
        } catch (RuntimeException e) {
            // diagnostic only
        }
    }

    /** What was measured on this Android: UNKNOWN when nothing was kept, or it was kept on another Android. */
    static int state(Context c) {
        try {
            SharedPreferences sp = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
            if (sp.getInt(KEY_SDK, -1) != Build.VERSION.SDK_INT || !sp.getAll().containsKey(KEY_ACCEL)) return UNKNOWN;
            return sp.getBoolean(KEY_ACCEL, false) ? ACCELERATED : SOFTWARE;
        } catch (RuntimeException e) {
            return UNKNOWN;
        }
    }

    /** Name of the string that says it (the three are in mr_strings.xml). */
    static String textName(int state) {
        if (state == ACCELERATED) return "mr_ui_kbd_accel_on";
        if (state == SOFTWARE) return "mr_ui_kbd_accel_off";
        return "mr_ui_kbd_accel_unknown";
    }

    /** PrefScreenAdvanced.onResume: the two read-only rows (the keyboard window and this screen) say what was measured. */
    public static void fill(PreferenceActivity screen) {
        fillKeyboard(screen);
        fillScreen(screen);
    }

    /** The row of the keyboard window (it may have changed while the screen was away). */
    static void fillKeyboard(PreferenceActivity screen) {
        try {
            Preference row = screen.findPreference(ROW);
            if (row == null) return;
            String text = MrPacks.text(screen, textName(state(screen)));
            if (text != null) row.setSummary(text);
        } catch (RuntimeException e) {
            // the row keeps the text of the XML ("not measured yet")
        }
    }

    /**
     * The row of this screen: the window can ask for acceleration (the flag that the app or the manifest puts on it) and the
     * system can give it or not (what its view root really did). Some systems turn it on whatever the app says, and some
     * refuse it, so both are shown. The answer is only true once the decor view is attached, hence the post.
     */
    static void fillScreen(final PreferenceActivity screen) {
        try {
            final Preference row = screen.findPreference(ROW_SCREEN);
            Window window = screen.getWindow();
            final View decor = window == null ? null : window.getDecorView();
            if (row == null || decor == null) return;
            decor.post(new Runnable() {
                public void run() { showScreen(screen, row, decor); }
            });
        } catch (RuntimeException e) {
            // the row keeps the text of the XML ("measuring")
        }
    }

    static void showScreen(PreferenceActivity screen, Preference row, View decor) {
        try {
            if (!decor.isAttachedToWindow()) return;
            WindowManager.LayoutParams attrs = screen.getWindow().getAttributes();
            boolean asked = attrs != null && (attrs.flags & FLAG_HW) != 0;
            boolean given = decor.isHardwareAccelerated();
            Log.i(TAG, screen.getClass().getSimpleName() + " window asked=" + asked + " given=" + given + " (SDK " + Build.VERSION.SDK_INT + ")");
            String text = MrPacks.text(screen, screenTextName(asked, given));
            if (text != null) row.setSummary(text);
        } catch (RuntimeException e) {
            // diagnostic only
        }
    }

    /** Name of the string for what the app asked and what the system gave. */
    static String screenTextName(boolean asked, boolean given) {
        if (given) return asked ? "mr_ui_scr_accel_asked" : "mr_ui_scr_accel_system";
        return asked ? "mr_ui_scr_accel_refused" : "mr_ui_scr_accel_off";
    }

    /** For the tests: the state of the "once per process" guard. */
    static boolean logged() { return sLogged; }

    static void reset() { sLogged = false; }
}
