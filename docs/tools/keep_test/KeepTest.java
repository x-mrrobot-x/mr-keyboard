package com.mrkeyboard.app;

import android.app.Dialog;
import android.os.Build;
import android.os.SystemClock;
import android.view.inputmethod.EditorInfo;

/**
 * Turning the screen with the "Customize keyboard" tool open (MrKeep): the tool that was open comes back in the form of
 * the new orientation once the keyboard is showing; on Android 17 the keyboard that the system leaves hidden is asked to
 * show itself again when the same app binds a field again; and nothing of this lasts beyond a short window.
 */
public class KeepTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static class Ime extends LatinIME {
        EditorInfo current;
        boolean shown, refuse;
        int showRequests;

        public EditorInfo getCurrentInputEditorInfo() { return current; }
        public boolean isInputViewShown() { return shown; }
        public void requestShowSelf(int flags) {
            showRequests++;
            if (refuse) throw new IllegalStateException("no editor");
        }
    }

    static class Dlg extends Dialog {
        boolean showing = true;
        Dlg() { super(null, 0); }
        public boolean isShowing() { return showing; }
    }

    static EditorInfo editor(String pkg) {
        EditorInfo e = new EditorInfo();
        e.packageName = pkg;
        return e;
    }

    static Ime ime;
    static final long T0 = 1000000L;

    /** A fresh start: the keyboard is in app.a, showing or not, with the tool open (as a panel) or not. */
    static void fresh(boolean shown, boolean toolOpen) {
        MrKeep.reset();
        MrTune.sOn = toolOpen;
        MrTune.sDlg = null;
        MrTune.stubToggles = 0;
        ime = new Ime();
        ime.current = editor("app.a");
        ime.shown = shown;
        MrTools.sIme = ime;
        Build.VERSION.SDK_INT = 36;
        SystemClock.now = T0;
    }

    static void at(long ms) { SystemClock.now = T0 + ms; }

    public static void main(String[] a) {
        // ---- the app handles the rotation, the keyboard stays: dialog (portrait) -> panel (landscape)
        fresh(true, false);
        Dlg dlg = new Dlg();
        MrTune.sDlg = dlg;
        MrKeep.onTurn(ime);
        dlg.showing = false;                     // the keyboard is rebuilt and the dialog is closed (MrTune.setup)
        at(150);
        MrKeep.tick();
        check("dialog open when turning to landscape: the tool is opened again (once)", MrTune.stubToggles == 1 && MrTune.sOn);
        at(300);
        MrKeep.tick();
        check("... and nothing more happens afterwards", MrTune.stubToggles == 1);
        check("keyboard that never left: no request to show it", ime.showRequests == 0);

        // ---- panel (landscape) -> dialog (portrait)
        fresh(true, true);
        MrKeep.onTurn(ime);
        MrTune.sOn = false;                      // MrTune.setup closes the panel (it only exists in landscape)
        at(150);
        MrKeep.tick();
        check("panel open when turning to portrait: the tool is opened again (the dialog)", MrTune.stubToggles == 1);

        // ---- the tool was closed: nothing opens
        fresh(true, false);
        MrKeep.onTurn(ime);
        at(150); MrKeep.tick();
        at(600); MrKeep.tick();
        check("tool closed when turning: it is not opened", MrTune.stubToggles == 0);

        // ---- the tool is still open when the keyboard shows (nothing closed it): not toggled (it would close it)
        fresh(true, true);
        MrKeep.onTurn(ime);
        at(150); MrKeep.tick();
        check("tool still open after the turn: left alone", MrTune.stubToggles == 0 && MrTune.sOn);

        // ---- Android 17: the app is recreated, the system hides the keyboard and does not bring it back
        fresh(true, true);
        MrKeep.onTurn(ime);
        ime.shown = false;
        MrKeep.onHidden();                       // the window hides with the tool open
        MrTune.sOn = false;                      // ... and the tool is closed with it
        at(150); MrKeep.tick();
        check("keyboard hidden and the old field still current: no request yet (the app is being recreated)", ime.showRequests == 0);
        check("keyboard hidden: the tool is not opened into a hidden keyboard", MrTune.stubToggles == 0);
        at(400);
        MrKeep.onInput(editor("app.a"));
        check("the same app binds a field again: the keyboard is asked to show itself", ime.showRequests == 1);
        at(500); MrKeep.tick();
        check("... and not again within a moment", ime.showRequests == 1);
        at(900); MrKeep.tick();
        check("... a second request if it is still hidden a little later", ime.showRequests == 2);
        ime.shown = true;                        // the keyboard is back
        at(950); MrKeep.tick();
        check("keyboard back: the tool is opened again, once", MrTune.stubToggles == 1 && ime.showRequests == 2);
        at(1100); MrKeep.tick();
        check("... and nothing else is asked", MrTune.stubToggles == 1 && ime.showRequests == 2);

        // ---- only for the app that had the keyboard
        fresh(true, true);
        MrKeep.onTurn(ime);
        ime.shown = false;
        at(300);
        MrKeep.onInput(editor("app.b"));
        at(450); MrKeep.tick();
        check("another app binds: the keyboard is not forced on it", ime.showRequests == 0);
        MrKeep.onInput(null);
        check("a binding with no editor does not break", ime.showRequests == 0);

        // ---- at most three requests in a turn
        fresh(true, false);
        MrKeep.onTurn(ime);
        ime.shown = false;
        at(100); MrKeep.onInput(editor("app.a"));
        at(600); MrKeep.tick();
        at(1100); MrKeep.tick();
        at(1600); MrKeep.tick();
        at(2100); MrKeep.tick();
        check("never more than three requests", ime.showRequests == 3);

        // ---- keyboard was showing, tool closed: the keyboard comes back, the tool is not opened
        fresh(true, false);
        MrKeep.onTurn(ime);
        ime.shown = false;
        at(200); MrKeep.onInput(editor("app.a"));
        ime.shown = true;
        at(350); MrKeep.tick();
        check("keyboard restored, tool was closed: only the keyboard", ime.showRequests == 1 && MrTune.stubToggles == 0);

        // ---- keyboard was hidden when the screen turned (the user had closed it): it is not forced
        fresh(false, false);
        MrKeep.onTurn(ime);
        at(200); MrKeep.onInput(editor("app.a"));
        at(350); MrKeep.tick();
        check("keyboard hidden before the turn: not shown by force", ime.showRequests == 0);

        // ---- the keyboard hides without a turn (back, touch outside): nothing comes back
        fresh(true, true);
        MrKeep.onHidden();
        MrTune.sOn = false;
        ime.shown = false;
        at(500); ime.shown = true;
        MrKeep.tick();
        check("keyboard hidden by the user with the tool open (no turn): the tool does not reopen", MrTune.stubToggles == 0);
        MrKeep.onInput(editor("app.a"));
        check("... and the keyboard is not forced", ime.showRequests == 0);
        fresh(true, false);
        MrKeep.onHidden();
        at(100); MrKeep.tick();
        check("window hides with the tool closed: nothing is followed", MrTune.stubToggles == 0 && ime.showRequests == 0);

        // ---- too late: the window is over
        fresh(true, true);
        MrKeep.onTurn(ime);
        MrTune.sOn = false;
        ime.shown = false;
        at(5000);
        MrKeep.onInput(editor("app.a"));
        check("a field that binds after the window: the keyboard is not forced", ime.showRequests == 0);
        ime.shown = true;
        at(5200); MrKeep.tick();
        check("the keyboard shows after the window: the tool does not reopen", MrTune.stubToggles == 0);

        // ---- two quick turns (portrait -> landscape -> portrait): the tool still comes back once
        fresh(true, true);
        MrKeep.onTurn(ime);
        MrKeep.onHidden();
        MrTune.sOn = false;
        ime.shown = false;
        at(1000);
        MrKeep.onTurn(ime);                      // keyboard hidden and tool closed now: what was seen stays
        at(1200); MrKeep.onInput(editor("app.a"));
        check("second turn: the keyboard is still asked for", ime.showRequests == 1);
        ime.shown = true;
        at(1400); MrKeep.tick();
        check("second turn: the tool comes back once", MrTune.stubToggles == 1);

        // ---- the system refuses the request: nothing breaks
        fresh(true, true);
        MrKeep.onTurn(ime);
        ime.shown = false;
        ime.refuse = true;
        at(200);
        boolean ok1 = true;
        try { MrKeep.onInput(editor("app.a")); at(800); MrKeep.tick(); } catch (RuntimeException e) { ok1 = false; }
        check("requestShowSelf refused: no exception", ok1 && ime.showRequests >= 1);

        // ---- Android 8-9: no requestShowSelf, but the tool still comes back
        fresh(true, true);
        Build.VERSION.SDK_INT = 27;
        MrKeep.onTurn(ime);
        MrTune.sOn = false;
        at(150); MrKeep.tick();
        check("Android 8: the tool comes back", MrTune.stubToggles == 1);
        fresh(true, false);
        Build.VERSION.SDK_INT = 27;
        MrKeep.onTurn(ime);
        ime.shown = false;
        at(200); MrKeep.onInput(editor("app.a"));
        check("Android 8: no request to show (not available before Android 9)", ime.showRequests == 0);
        Build.VERSION.SDK_INT = 36;

        // ---- the keyboard never left (the app handles the rotation) and a field binds again: no request
        fresh(true, false);
        MrKeep.onTurn(ime);
        at(100); MrKeep.onInput(editor("app.a"));
        check("keyboard still showing when the field binds again: no request to show it", ime.showRequests == 0);

        // ---- the keyboard already came back and the tool is still being followed: a later hide and rebind is not a turn
        fresh(true, true);
        MrKeep.onTurn(ime);
        at(150); MrKeep.tick();                  // keyboard showing: nothing left to ask for
        ime.shown = false;                       // the user closes the keyboard a moment later
        at(300); MrKeep.onInput(editor("app.a"));
        check("keyboard already back: a later binding does not force it open again", ime.showRequests == 0);

        // ---- a hide with the tool closed does not stretch the window of an earlier turn
        fresh(true, true);
        MrKeep.onTurn(ime);
        MrTune.sOn = false;
        at(3500);
        MrKeep.onHidden();
        at(4200);
        MrKeep.tick();
        check("a hide with the tool closed does not extend the window: the tool is not opened late", MrTune.stubToggles == 0);

        // ---- a new turn after the window starts from nothing (what was seen before is forgotten)
        fresh(true, true);
        MrKeep.onTurn(ime);                      // tool open: seen
        MrTune.sOn = false;                      // the user closes the tool afterwards
        at(6000);
        MrKeep.onTurn(ime);                      // new turn, tool closed
        at(6150); MrKeep.tick();
        check("an old turn does not leak into a new one: a tool closed in the meantime stays closed", MrTune.stubToggles == 0);

        // ---- never breaks the keyboard
        fresh(true, true);
        boolean safe = true;
        try {
            MrKeep.onTurn(null);
            MrTools.sIme = null;
            MrKeep.tick();
            MrKeep.onInput(editor("app.a"));
            MrKeep.onHidden();
        } catch (RuntimeException e) { safe = false; }
        check("no keyboard instance / null: nothing breaks", safe);

        System.out.println(fail == 0 ? ok + " ok, 0 failures" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
