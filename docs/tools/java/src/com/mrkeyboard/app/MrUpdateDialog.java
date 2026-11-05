package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import java.util.Locale;

/**
 * "New version available" dialog (v1.82.0): title, "v1.83.0 · 1.2 MB · you're on v1.82.0", the notes (plain text, they
 * scroll) and three actions: Download and install, View on GitHub, Not now. It belongs to a screen (Main or Settings),
 * uses the settings theme (Theme.MrKeyboard.Dialog) and the layout mr_update_dialog; the views are found by tag, like
 * the AI Editor dialog.
 *
 * Leaving the dialog in any way except by the screen going away (a button, back, a touch outside) snoozes the
 * pop-up for this version for 24 hours (MrUpdate.snooze); the "Check for updates" line in Settings still offers it.
 * The layout already has the box for the progress and for the error (hidden); the download and the install fill them in
 * (stage 7).
 */
final class MrUpdateDialog {
    private static final int INSTALL = 1;
    private static final int GITHUB = 2;
    private static final int LATER = 3;

    private static Dialog sDialog;
    private static Activity sOwner;
    private static long sCode;
    /** Test seam: the last notice the dialog was asked to show, and how many times. */
    static MrUpdate.Notice sAsked;
    static int sAskedCount;

    private MrUpdateDialog() { }

    static boolean showing() {
        return sDialog != null && sDialog.isShowing();
    }

    /** Closes the dialog without snoozing (the screen is going away). */
    static void dismiss() {
        Dialog d = sDialog;
        sDialog = null;
        sOwner = null;
        sCode = 0;
        if (d != null) {
            try {
                d.dismiss();
            } catch (RuntimeException e) {
                // the window may already be gone with its screen
            }
        }
    }

    /** Closes the dialog if it belongs to this screen: called when the screen is destroyed. */
    static void release(Activity a) {
        if (sOwner == a) dismiss();
    }

    /** Opens the dialog for this notice on the screen; with one already open for the same version, does nothing. */
    static void show(Activity a, MrUpdate.Notice n) {
        if (a == null || n == null || a.isFinishing() || a.isDestroyed()) return;
        if (showing() && sOwner == a && sCode == n.versionCode) return;
        sAsked = n;
        sAskedCount++;
        dismiss();
        Dialog dialog = null;
        try {
            int theme = a.getResources().getIdentifier("Theme.MrKeyboard.Dialog", "style", a.getPackageName());
            if (theme == 0) theme = 0x7f0d00a1;
            dialog = new Dialog(a, theme);
            dialog.requestWindowFeature(1); // FEATURE_NO_TITLE: the layout has its own title
            int layout = a.getResources().getIdentifier("mr_update_dialog", "layout", a.getPackageName());
            if (layout == 0) return;
            View root = LayoutInflater.from(MrLocaleCtx.of(dialog.getContext())).inflate(layout, null);
            if (!fill(a, root, n)) return;
            final Context app = a.getApplicationContext();
            final MrUpdate.Notice notice = n;
            dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
                public void onCancel(DialogInterface d) {
                    MrUpdate.snooze(app, notice);
                }
            });
            dialog.setCanceledOnTouchOutside(true);
            dialog.setContentView(root);
            sDialog = dialog;
            sOwner = a;
            sCode = n.versionCode;
            dialog.show();
        } catch (RuntimeException e) {
            // a pop-up that cannot be drawn must not bring the screen down
            if (dialog != null && dialog == sDialog) dismiss();
        }
    }

    /** Puts the texts and the actions in the layout; false if the layout does not have what it should. */
    private static boolean fill(Activity a, View root, MrUpdate.Notice n) {
        TextView sub = (TextView) root.findViewWithTag("upd_sub");
        TextView notes = (TextView) root.findViewWithTag("upd_notes");
        View install = root.findViewWithTag("upd_install");
        View github = root.findViewWithTag("upd_github");
        View later = root.findViewWithTag("upd_later");
        if (sub == null || notes == null || install == null || github == null || later == null) return false;
        Locale loc = a.getResources().getConfiguration().locale;
        sub.setText(text(a, "mr_update_sub", n.versionName, MrUpdate.sizeText(n.apkSize, loc), MrUpdate.appName(a)));
        String body = n.notes(loc);
        notes.setText(body.length() > 0 ? body : text(a, "mr_update_notes_none"));
        install.setOnClickListener(new Click(a, n, INSTALL));
        github.setOnClickListener(new Click(a, n, GITHUB));
        later.setOnClickListener(new Click(a, n, LATER));
        return true;
    }

    static String text(Context c, String key, Object... args) {
        String s = MrPacks.text(c, key, args);
        return s != null ? s : key;
    }

    /**
     * Download and install: for now it opens the APK of the exact tag of the signed notice in the browser, which
     * downloads it (stage 7 replaces this with the download and install inside the app, with progress).
     */
    static void install(Activity a, MrUpdate.Notice n) {
        MrLink.open(a, n.apkUrl());
    }

    private static final class Click implements View.OnClickListener {
        private final Activity mActivity;
        private final MrUpdate.Notice mNotice;
        private final int mWhat;

        Click(Activity a, MrUpdate.Notice n, int what) {
            mActivity = a;
            mNotice = n;
            mWhat = what;
        }

        public void onClick(View v) {
            MrUpdate.snooze(mActivity.getApplicationContext(), mNotice);
            dismiss();
            if (mWhat == INSTALL) install(mActivity, mNotice);
            else if (mWhat == GITHUB) MrLink.open(mActivity, MrUpdate.RELEASE_PAGE);
        }
    }
}
