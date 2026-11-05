package com.mrkeyboard.app;

import android.app.Dialog;
import java.lang.reflect.Field;

/**
 * Buttons of the tool bar with a dialog open (MrBarClose): the dialogs that are open close, the one that the button itself
 * controls is left to the button's own toggle, and what is not a button of the bar changes nothing.
 */
public class BarTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** The AI Editor dialog: open until it is dismissed. */
    static class Dlg extends Dialog {
        boolean showing = true;
        int dismissed;
        Dlg() { super(null, 0); }
        public boolean isShowing() { return showing; }
        public void dismiss() { dismissed++; showing = false; }
    }

    static Dlg openAi() throws Exception {
        Dlg d = new Dlg();
        Field f = MrAiDialog.class.getDeclaredField("sDialog");
        f.setAccessible(true);
        f.set(null, d);
        return d;
    }

    static void closeAi() throws Exception {
        Field f = MrAiDialog.class.getDeclaredField("sDialog");
        f.setAccessible(true);
        f.set(null, null);
    }

    public static void main(String[] a) throws Exception {
        final int[] others = {0x0, 0x1, 0x8, 0x14, 0x15};   // clipboard, translate, attachments, emoji, sheets

        // ---- the five buttons that open something else: both dialogs close
        for (int code : others) {
            Dlg ai = openAi();
            MrTune.stubDialogDismissals = 0;
            MrBarClose.onClick(code);
            check("button " + code + ": the AI Editor dialog closes", ai.dismissed == 1 && !MrAiDialog.isShowing());
            check("button " + code + ": the Customize dialog is closed too", MrTune.stubDialogDismissals == 1);
        }

        // ---- the AI Editor button: its own toggle closes its dialog; the other one closes here
        Dlg ai = openAi();
        MrTune.stubDialogDismissals = 0;
        MrBarClose.onClick(MrBarClose.AI);
        check("AI Editor button: its dialog is left to the toggle (closing here would make the toggle open it again)",
                ai.dismissed == 0 && ai.showing);
        check("AI Editor button: the Customize dialog closes", MrTune.stubDialogDismissals == 1);

        // ---- the Customize button
        MrTune.stubDialogDismissals = 0;
        MrBarClose.onClick(MrBarClose.TUNE);
        check("Customize button: the AI Editor dialog closes", ai.dismissed == 1);
        check("Customize button: its own dialog is left to its toggle", MrTune.stubDialogDismissals == 0);

        // ---- nothing open: nothing is touched (no needless close of the AI Editor state)
        closeAi();
        MrTune.stubDialogDismissals = 0;
        MrBarClose.onClick(0x0);
        check("no AI Editor dialog open: it is not closed", !MrAiDialog.isShowing());
        Dlg shut = openAi();
        shut.showing = false;
        MrBarClose.onClick(0x14);
        check("a dialog that is no longer showing is not dismissed again", shut.dismissed == 0);
        closeAi();

        // ---- what is not a button of the bar: no dialog closes
        int[] notBar = {-1, 0x2, 0x3, 0x7, 0x9, 0xa, 0x12, 0x16, 0x17, 0x19, 0x100};
        boolean untouched = true;
        for (int code : notBar) {
            Dlg d = openAi();
            MrTune.stubDialogDismissals = 0;
            MrBarClose.onClick(code);
            if (d.dismissed != 0 || MrTune.stubDialogDismissals != 0) untouched = false;
            check("code " + code + " is not a button of the bar", !MrBarClose.isToolbar(code));
        }
        check("buttons inside the panels (clipboard, photos...) leave the dialogs alone", untouched);
        closeAi();

        // ---- the seven buttons are exactly the list
        int n = 0;
        for (int code = -2; code < 0x40; code++) if (MrBarClose.isToolbar(code)) n++;
        check("seven buttons in the bar", n == 7 && MrBarClose.TOOLBAR.length == 7);

        // ---- a failure while closing does not reach the button
        MrBarClose.onClick(0x0);
        check("closing with nothing open does not fail", true);

        System.out.println(fail == 0 ? ok + " ok, 0 failures" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
