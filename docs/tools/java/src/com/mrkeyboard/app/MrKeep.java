package com.mrkeyboard.app;

import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.view.inputmethod.EditorInfo;

/**
 * What survives turning the screen while the keyboard is in use.
 * <p>
 * The "Customize keyboard" tool (MrTune) is a dialog in portrait and a panel inside the keyboard in landscape. Turning the
 * screen used to close it (the keyboard window hides and the tool is closed with it, and the dialog is dismissed when the
 * keyboard is rebuilt), so the user had to open it again. Here the tool that was open when the screen turned is opened
 * again, in the form that fits the new orientation, as soon as the keyboard is showing.
 * <p>
 * On Android 17 an app that is recreated by the rotation no longer gets the keyboard back from the system: the keyboard
 * hides and stays hidden. If it was showing when the screen turned, it is asked to show itself again when the same app
 * binds a field again (the way MrAiDialog does when it comes back from Settings).
 * <p>
 * Everything happens in a short window after the turn ({@link #WINDOW_MS}); after that the state is dropped, so nothing
 * opens by itself later. The work is a handful of cheap checks on a handler, only while a turn is being followed.
 */
final class MrKeep {
    /** From the last event (turn, or hide with the tool open) until the state is dropped. */
    static final long WINDOW_MS = 4000L;
    /** Interval of the checks while a turn is being followed. */
    static final long TICK_MS = 150L;
    /** Minimum time between two requests to show the keyboard. */
    static final long ASK_AGAIN_MS = 450L;
    /** Requests to show the keyboard in one turn. */
    static final int MAX_ASKS = 3;

    /** Time of the last event of this turn; 0 = nothing being followed. */
    private static long sStart;
    private static boolean sTurned;
    /** The tool was open when the screen turned or when the keyboard window hid. */
    private static boolean sTool;
    /** The keyboard was showing when the screen turned. */
    private static boolean sKeyboard;
    private static String sPackage;
    /** A field of that app bound again after the turn. */
    private static boolean sRebound;
    private static int sAsks;
    private static long sAskedAt;
    private static boolean sTicking;

    private MrKeep() { }

    /** The orientation changed (LatinIME.onConfigurationChanged, before the keyboard is rebuilt). */
    static void onTurn(LatinIME ime) {
        try {
            if (ime == null) return;
            begin(SystemClock.elapsedRealtime());
            sTurned = true;
            if (ime.isInputViewShown()) {
                sKeyboard = true;
                EditorInfo info = ime.getCurrentInputEditorInfo();
                if (info != null && info.packageName != null) sPackage = info.packageName;
            }
            if (toolOpen()) sTool = true;
            postTick();
        } catch (RuntimeException e) {
            // Following a turn is a convenience; it must never take the keyboard down.
            reset();
        }
    }

    /** The keyboard window hid (LatinIME.onWindowHidden, before the tool is closed with it). */
    static void onHidden() {
        try {
            if (!toolOpen()) return;
            begin(SystemClock.elapsedRealtime());
            sTool = true;
            postTick();
        } catch (RuntimeException e) {
            reset();
        }
    }

    /** A field was bound to the keyboard (LatinIME.onStartInput). */
    static void onInput(EditorInfo info) {
        try {
            if (info == null || !active(SystemClock.elapsedRealtime()) || !sTurned || !sKeyboard) return;
            if (sPackage == null || !sPackage.equals(info.packageName)) return;
            sRebound = true;
            LatinIME ime = MrTools.sIme;
            if (ime != null && !ime.isInputViewShown()) ask(SystemClock.elapsedRealtime());
        } catch (RuntimeException e) {
            reset();
        }
    }

    /** One check; also called by the handler. */
    static void tick() {
        try {
            long now = SystemClock.elapsedRealtime();
            LatinIME ime = MrTools.sIme;
            if (ime == null || !active(now)) {
                reset();
                return;
            }
            boolean shown = ime.isInputViewShown();
            if (shown) sKeyboard = false;
            else if (sTurned && sKeyboard && sRebound) ask(now);
            if (sTurned && sTool && shown && !toolOpen()) {
                sTool = false;
                MrTune.toggle();
            }
            if (sKeyboard || sTool) postTick();
            else reset();
        } catch (RuntimeException e) {
            reset();
        }
    }

    private static void begin(long now) {
        if (sStart != 0L && now - sStart > WINDOW_MS) reset();
        sStart = now;
    }

    private static boolean active(long now) {
        return sStart != 0L && now - sStart <= WINDOW_MS;
    }

    private static void ask(long now) {
        if (sAsks >= MAX_ASKS || (sAsks > 0 && now - sAskedAt < ASK_AGAIN_MS)) return;
        sAsks++;
        sAskedAt = now;
        MrAiDialog.showKeyboard();
    }

    /** The tool is open, as a panel in the keyboard or as a dialog. */
    private static boolean toolOpen() {
        return MrTune.sOn || (MrTune.sDlg != null && MrTune.sDlg.isShowing());
    }

    private static void postTick() {
        if (sTicking) return;
        sTicking = true;
        new Handler(Looper.getMainLooper()).postDelayed(new Tick(), TICK_MS);
    }

    /** Back to nothing being followed (the handler, if one is pending, finds nothing to do). */
    static void reset() {
        sStart = 0L;
        sTurned = false;
        sTool = false;
        sKeyboard = false;
        sPackage = null;
        sRebound = false;
        sAsks = 0;
        sAskedAt = 0L;
    }

    private static final class Tick implements Runnable {
        public void run() {
            sTicking = false;
            tick();
        }
    }
}
