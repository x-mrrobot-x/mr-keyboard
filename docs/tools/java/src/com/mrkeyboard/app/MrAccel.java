package com.mrkeyboard.app;

import android.app.Dialog;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.util.Log;
import android.view.View;
import android.view.Window;

/**
 * Diagnostic of the keyboard window: is it drawn with hardware acceleration?
 *
 * The manifest says <code>hardwareAccelerated="false"</code> for the app, but the documentation of InputMethodService says
 * that the system turns the acceleration of the keyboard window on by itself (API 21+), whatever the app says. That was
 * never confirmed on a device, so the first time the keyboard window is shown in a process this writes ONE line to the log
 * with what the window really has, to read with <code>adb logcat -s MrAccel</code>. It changes nothing and reads nothing
 * else; a failure of any kind is swallowed (a diagnostic must never be able to hurt the keyboard).
 */
public final class MrAccel {
    static final String TAG = "MrAccel";

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

    /** Writes the line, once, when the window is attached (before that the view does not know yet). */
    static void log(View decor) {
        if (sLogged || !decor.isAttachedToWindow()) return;
        sLogged = true;
        Log.i(TAG, "keyboard window hardwareAccelerated=" + decor.isHardwareAccelerated() + " (SDK " + Build.VERSION.SDK_INT + ")");
    }

    /** For the tests: the state of the "once per process" guard. */
    static boolean logged() { return sLogged; }

    static void reset() { sLogged = false; }
}
