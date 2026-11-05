package com.mrkeyboard.app;

import android.os.Build;
import android.os.SystemClock;
import android.view.inputmethod.EditorInfo;

/**
 * Return to the AI Editor dialog after Settings (MrAiDialog): the keyboard is asked to appear when the original field
 * binds again, only for that field, only once (plus one retry), only soon after leaving, and the dialog reopens when
 * the keyboard window shows.
 */
public class AiReturnTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** The keyboard: counts the requests to show itself and the attempts to open the dialog (it asks for the window). */
    static class Ime extends LatinIME {
        EditorInfo current;
        int showRequests, lastFlags = -1, windowAsks;
        boolean inputViewShown, refuse;

        public EditorInfo getCurrentInputEditorInfo() { return current; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public boolean isInputViewShown() { return inputViewShown; }
        public void requestShowSelf(int flags) {
            showRequests++;
            lastFlags = flags;
            if (refuse) throw new IllegalStateException("no editor");
        }
        public android.app.Dialog getWindow() { windowAsks++; return null; }
    }

    static EditorInfo editor(String pkg) {
        EditorInfo e = new EditorInfo();
        e.packageName = pkg;
        return e;
    }

    static Ime ime;

    /** Fresh state: the user is in app.a and taps the gear; the Settings screen is shown and then left (Back). */
    static void leaveToSettings(String pkg) {
        MrAiDialog.cancelReopenOnReturn();
        ime = new Ime();
        MrTools.sIme = ime;
        ime.current = editor(pkg);
        Build.VERSION.SDK_INT = 36;
        SystemClock.now = 1000000L;
        MrAiDialog.requestReopenOnReturn();
        MrAiDialog.setAuxiliaryUiVisible(true);   // MrAiPrefs.onResume
    }

    static void backFromSettings() {
        MrAiDialog.setAuxiliaryUiVisible(false);  // MrAiPrefs.onPause
    }

    public static void main(String[] a) {
        // ---- the system brings the keyboard back by itself (as before): the dialog reopens, once
        leaveToSettings("app.a");
        backFromSettings();
        MrAiDialog.onImeWindowShown();
        check("keyboard back by itself: the dialog reopens", ime.windowAsks == 1);
        MrAiDialog.onImeWindowShown();
        check("... and only once (the next time the keyboard shows nothing opens)", ime.windowAsks == 1);

        // ---- the system does not bring it back: the field binds and the keyboard is asked to appear
        leaveToSettings("app.a");
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("the original field binds: the keyboard is asked to show itself", ime.showRequests == 1);
        check("... as an explicit request (flags 0)", ime.lastFlags == 0);
        MrAiDialog.onInputStarted(editor("app.a"));
        check("the field restarting does not ask again", ime.showRequests == 1);
        MrAiDialog.onImeWindowShown();
        check("the keyboard window shows: the dialog reopens", ime.windowAsks == 1);

        // ---- a second trip to Settings right after the first one asks again (the "already asked" mark is per trip)
        leaveToSettings("app.a");
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        MrAiDialog.onImeWindowShown();
        MrAiDialog.requestReopenOnReturn();
        MrAiDialog.setAuxiliaryUiVisible(true);
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("second trip to Settings: the keyboard is asked again", ime.showRequests == 2);

        // ---- retry: still down after a moment, once; not if it already appeared or the dialog is already back
        leaveToSettings("app.a");
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        ime.inputViewShown = false;
        MrAiDialog.retryKeyboard();
        check("the keyboard is still down: a second request", ime.showRequests == 2);
        ime.inputViewShown = true;
        MrAiDialog.retryKeyboard();
        check("the keyboard is already shown: no new request", ime.showRequests == 2);
        ime.inputViewShown = false;
        MrAiDialog.onImeWindowShown();
        MrAiDialog.retryKeyboard();
        check("dialog already back: the retry does nothing", ime.showRequests == 2);

        // ---- only for the field the user left, and only when the Settings screen is gone
        leaveToSettings("app.a");
        MrAiDialog.onInputStarted(editor("app.a"));
        check("Settings still in front: the keyboard is not asked", ime.showRequests == 0);
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.b"));
        check("another app's field: the keyboard is not asked", ime.showRequests == 0);
        MrAiDialog.onInputStarted(null);
        check("no editor info: nothing happens", ime.showRequests == 0);
        MrAiDialog.onInputStarted(editor("app.a"));
        check("then the original field: now it is", ime.showRequests == 1);

        MrAiDialog.cancelReopenOnReturn();
        ime = new Ime();
        MrTools.sIme = ime;
        ime.current = editor("app.a");
        SystemClock.now = 5000L;
        MrAiDialog.requestReopenOnReturn();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("the Settings screen never opened: the keyboard is not asked", ime.showRequests == 0);

        MrAiDialog.cancelReopenOnReturn();
        ime.current = editor("app.a");
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("no return requested: the keyboard is not asked", ime.showRequests == 0);

        // ---- the user went to another app instead: it is dropped
        leaveToSettings("app.a");
        backFromSettings();
        MrAiDialog.onInputViewStarted("app.b");
        MrAiDialog.onInputStarted(editor("app.a"));
        MrAiDialog.onImeWindowShown();
        check("went to another app: no request and no dialog", ime.showRequests == 0 && ime.windowAsks == 0);

        // ---- the style editor stacked on top of Settings: only the last screen counts
        leaveToSettings("app.a");
        MrAiDialog.setAuxiliaryUiVisible(false);   // Settings paused
        MrAiDialog.setAuxiliaryUiVisible(true);    // style editor resumed
        MrAiDialog.onInputStarted(editor("app.a"));
        check("style editor in front: not asked", ime.showRequests == 0);
        MrAiDialog.setAuxiliaryUiVisible(false);
        MrAiDialog.onInputStarted(editor("app.a"));
        check("both gone: asked", ime.showRequests == 1);

        // ---- time away
        leaveToSettings("app.a");
        SystemClock.now += 5000;
        backFromSettings();
        SystemClock.now += MrAiDialog.RETURN_WINDOW_MS;
        MrAiDialog.onInputStarted(editor("app.a"));
        check("back at the limit: still asked", ime.showRequests == 1);

        leaveToSettings("app.a");
        backFromSettings();
        SystemClock.now += MrAiDialog.RETURN_WINDOW_MS + 1;
        MrAiDialog.onInputStarted(editor("app.a"));
        MrAiDialog.onImeWindowShown();
        check("long away: no request and the dialog does not come out of nowhere", ime.showRequests == 0 && ime.windowAsks == 0);
        SystemClock.now += 1;
        MrAiDialog.onInputStarted(editor("app.a"));
        check("... and it stays dropped", ime.showRequests == 0);

        leaveToSettings("app.a");
        SystemClock.now += 10 * MrAiDialog.RETURN_WINDOW_MS;   // long time inside Settings
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("a long time inside Settings does not count, only the time since leaving it", ime.showRequests == 1);

        // ---- Android versions and failures
        int[] old = {26, 27};
        for (int sdk : old) {
            leaveToSettings("app.a");
            Build.VERSION.SDK_INT = sdk;
            backFromSettings();
            MrAiDialog.onInputStarted(editor("app.a"));
            check("Android SDK " + sdk + ": no requestShowSelf (API 28), the system brings it back", ime.showRequests == 0);
            MrAiDialog.onImeWindowShown();
            check("Android SDK " + sdk + ": the dialog still reopens when the keyboard shows", ime.windowAsks == 1);
        }
        int[] now = {28, 29, 34, 35, 36, 37};
        for (int sdk : now) {
            leaveToSettings("app.a");
            Build.VERSION.SDK_INT = sdk;
            backFromSettings();
            MrAiDialog.onInputStarted(editor("app.a"));
            check("Android SDK " + sdk + ": the keyboard is asked", ime.showRequests == 1);
        }

        leaveToSettings("app.a");
        ime.refuse = true;
        backFromSettings();
        boolean fine = true;
        try { MrAiDialog.onInputStarted(editor("app.a")); MrAiDialog.retryKeyboard(); } catch (RuntimeException e) { fine = false; }
        check("the system refusing the request does not break the keyboard", fine && ime.showRequests >= 1);
        ime.refuse = false;
        MrAiDialog.onImeWindowShown();
        check("... and the normal return still works afterwards", ime.windowAsks == 1);

        leaveToSettings("app.a");
        MrTools.sIme = null;
        backFromSettings();
        boolean noIme = true;
        try { MrAiDialog.onInputStarted(editor("app.a")); MrAiDialog.retryKeyboard(); MrAiDialog.onImeWindowShown(); }
        catch (RuntimeException e) { noIme = false; }
        check("without a keyboard instance nothing breaks", noIme);

        // ---- the field could not be read when the gear was tapped: the system's own return still works, no forced show
        MrAiDialog.cancelReopenOnReturn();
        ime = new Ime();
        MrTools.sIme = ime;
        ime.current = null;
        Build.VERSION.SDK_INT = 36;
        SystemClock.now = 1000000L;
        MrAiDialog.requestReopenOnReturn();
        MrAiDialog.setAuxiliaryUiVisible(true);
        backFromSettings();
        MrAiDialog.onInputStarted(editor("app.a"));
        check("field unknown when leaving: the keyboard is not forced", ime.showRequests == 0);
        ime.current = editor("app.a");   // when the keyboard shows there is an editor
        MrAiDialog.onImeWindowShown();
        check("... but the dialog still reopens when the keyboard shows", ime.windowAsks == 1);

        System.out.println(ok + " ok, " + fail + " failures");
        if (fail > 0) System.exit(1);
    }
}
