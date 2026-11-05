package com.mrkeyboard.app;

/** Compile stub (APK class, hand-written smali): the "Customize keyboard" tool, as far as MrKeep uses it. */
public class MrTune {
    /** Panel inside the keyboard (landscape) open. */
    static boolean sOn;
    /** Dialog (portrait). */
    static android.app.Dialog sDlg;
    static int stubToggles;
    static int stubDialogDismissals;

    /** Opens the tool (panel or dialog by orientation) or closes it if it is open; the stub only flips sOn. */
    static void toggle() {
        stubToggles++;
        sOn = !sOn;
    }

    /** Closes the dialog (portrait) if it is open; the stub only counts. */
    static void dismissDialog() {
        stubDialogDismissals++;
    }
}
