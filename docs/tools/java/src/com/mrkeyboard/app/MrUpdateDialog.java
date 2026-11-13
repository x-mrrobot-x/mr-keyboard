package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;

import java.util.Locale;

/**
 * "New version available" dialog (v1.82.0): title, "v1.83.0 · 1.2 MB · you're on v1.82.0", the notes (styled by MrNotesText since
 * v1.98.0: colored labels, space between the items; they scroll) and three actions: Download and install, View on GitHub, Not now. It belongs to a screen (Main or Settings),
 * uses the settings theme (Theme.MrKeyboard.Dialog) and the layout mr_update_dialog; the views are found by tag, like
 * the AI Editor dialog.
 *
 * The same dialog goes through the install (MrUpdateInstall does the work, this class only shows it):
 *   NOTES       the notes and the three actions
 *   PERMISSION  Android has not yet allowed the app to install apps: explains it and takes to the settings; when the
 *               user comes back (the dialog gets the focus again) and it is allowed, the download starts by itself
 *   DOWNLOADING "Downloading… N%" with the bar and Cancel;  VERIFYING "Verifying…";  INSTALLING "Installing…"
 *   ERROR       a short text, and the actions again (Download and install tries again)
 * After the commit Android shows its own confirm screen; the user's "No" there goes back to NOTES without any message.
 *
 * Leaving the dialog in any way except by the screen going away (a button, back, a touch outside) snoozes the pop-up
 * for this version for 24 hours (MrUpdate.snooze); the "Check for updates" line in Settings still offers it. Leaving the
 * screen, or Cancel, or back, stops a download that has not been committed.
 */
final class MrUpdateDialog {
    private static final int BTN_INSTALL = 1;
    private static final int BTN_GITHUB = 2;
    private static final int BTN_LATER = 3;

    // states of the dialog; the working ones are the numbers of MrUpdateInstall (DOWNLOADING, VERIFYING, INSTALLING)
    static final int NOTES = 10;
    static final int PERMISSION = 11;
    static final int ERROR = 12;

    private static Dialog sDialog;
    private static View sRoot;
    private static Activity sOwner;
    private static MrUpdate.Notice sNotice;
    private static long sCode;
    private static int sState = NOTES;
    private static boolean sAwaiting; // went to the settings to allow the install and has not come back yet
    /** Test seam: the last notice the dialog was asked to show, and how many times. */
    static MrUpdate.Notice sAsked;
    static int sAskedCount;

    private MrUpdateDialog() { }

    static boolean showing() {
        return sDialog != null && sDialog.isShowing();
    }

    /** Closes the dialog without snoozing (the screen is going away); a download not yet committed is cancelled. */
    static void dismiss() {
        Dialog d = sDialog;
        sDialog = null;
        sRoot = null;
        sOwner = null;
        sNotice = null;
        sCode = 0;
        sState = NOTES;
        sAwaiting = false;
        MrUpdateInstall.cancel();
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
            dialog = new Box(a, theme);
            dialog.requestWindowFeature(1); // FEATURE_NO_TITLE: the layout has its own title
            int layout = a.getResources().getIdentifier("mr_update_dialog", "layout", a.getPackageName());
            if (layout == 0) return;
            View root = LayoutInflater.from(MrLocaleCtx.of(dialog.getContext())).inflate(layout, null);
            if (!fill(a, root, n)) return;
            final Context app = a.getApplicationContext();
            final MrUpdate.Notice notice = n;
            dialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
                public void onCancel(DialogInterface d) {
                    // back or a touch outside: same as "Not now"; during the download it is also Cancel
                    MrUpdate.snooze(app, notice);
                    MrUpdateInstall.cancel();
                }
            });
            dialog.setContentView(root);
            sDialog = dialog;
            sRoot = root;
            sOwner = a;
            sNotice = n;
            sCode = n.versionCode;
            setState(NOTES, 0, null);
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
        if (root.findViewWithTag("upd_title") == null || root.findViewWithTag("upd_scroll") == null
                || root.findViewWithTag("upd_box") == null || root.findViewWithTag("upd_status") == null
                || root.findViewWithTag("upd_bar") == null || root.findViewWithTag("upd_error") == null) return false;
        Locale loc = a.getResources().getConfiguration().locale;
        sub.setText(text(a, "mr_update_sub", n.versionName, MrUpdate.sizeText(n.apkSize, loc), MrUpdate.appName(a)));
        CharSequence body = MrNotesText.forView(notes, n.raw(loc));
        notes.setText(body.length() > 0 ? body : text(a, "mr_update_notes_none"));
        install.setOnClickListener(new Click(a, n, BTN_INSTALL));
        github.setOnClickListener(new Click(a, n, BTN_GITHUB));
        later.setOnClickListener(new Click(a, n, BTN_LATER));
        return true;
    }

    static String text(Context c, String key, Object... args) {
        String s = MrPacks.text(c, key, args);
        return s != null ? s : key;
    }

    /** The message of a failure: "Couldn't download: no connection", "The file doesn't match"... */
    static String errorText(Context c, MrUpdateInstall.Failure f) {
        if (f.reasonKey != null) return text(c, f.key, text(c, f.reasonKey, f.arg));
        return text(c, f.key);
    }

    // ------------------------------------------------------------------ states

    private static View view(String tag) {
        return sRoot != null ? sRoot.findViewWithTag(tag) : null;
    }

    private static void label(String tag, String s) {
        View v = view(tag);
        if (v instanceof TextView) ((TextView) v).setText(s);
    }

    private static void visible(String tag, boolean on) {
        View v = view(tag);
        if (v != null) v.setVisibility(on ? View.VISIBLE : View.GONE);
    }

    /** Draws a state: what shows, the texts and the buttons. percent only counts for DOWNLOADING; error only for ERROR. */
    static void setState(int state, int percent, String error) {
        Activity a = sOwner;
        if (a == null || sRoot == null) return;
        sState = state;
        boolean working = state == MrUpdateInstall.DOWNLOADING || state == MrUpdateInstall.VERIFYING
                || state == MrUpdateInstall.INSTALLING;
        boolean cancellable = state == MrUpdateInstall.DOWNLOADING || state == MrUpdateInstall.VERIFYING;
        label("upd_title", text(a, state == PERMISSION ? "mr_update_perm_title" : "mr_update_title"));
        visible("upd_scroll", state == NOTES);
        visible("upd_box", state != NOTES && state != ERROR);
        visible("upd_error", state == ERROR);
        if (state == ERROR) label("upd_error", error != null ? error : "");
        visible("upd_bar", working);
        View bar = view("upd_bar");
        if (bar instanceof ProgressBar) {
            ProgressBar pb = (ProgressBar) bar;
            pb.setIndeterminate(state == MrUpdateInstall.VERIFYING || state == MrUpdateInstall.INSTALLING);
            pb.setProgress(percent);
        }
        if (state == PERMISSION) label("upd_status", text(a, "mr_update_perm_text"));
        else if (state == MrUpdateInstall.DOWNLOADING) label("upd_status", text(a, "mr_update_downloading", percent));
        else if (state == MrUpdateInstall.VERIFYING) label("upd_status", text(a, "mr_update_verifying"));
        else if (state == MrUpdateInstall.INSTALLING) label("upd_status", text(a, "mr_update_installing"));
        visible("upd_install", !working);
        label("upd_install", text(a, state == PERMISSION ? "mr_update_open_settings" : "mr_update_install"));
        visible("upd_github", !working);
        label("upd_later", text(a, cancellable ? "mr_update_cancel" : "mr_update_later"));
        if (sDialog != null) sDialog.setCanceledOnTouchOutside(!working);
    }

    /** "Download and install": needs the permission first; then starts the download. */
    static void begin(Activity a, MrUpdate.Notice n) {
        if (!MrUpdateInstall.canInstall(a)) {
            setState(PERMISSION, 0, null);
            return;
        }
        sAwaiting = false;
        setState(MrUpdateInstall.DOWNLOADING, 0, null);
        MrUpdateInstall.start(a.getApplicationContext(), n, new Ui(a, n.versionCode));
    }

    /** The user came back from the settings screen: if the install is allowed now, goes on by itself. */
    private static void resumeAfterSettings() {
        Activity a = sOwner;
        MrUpdate.Notice n = sNotice;
        if (!sAwaiting || a == null || n == null) return;
        sAwaiting = false;
        if (sState == PERMISSION && MrUpdateInstall.canInstall(a)) begin(a, n);
    }

    private static void openSettings(Activity a) {
        sAwaiting = true;
        try {
            a.startActivity(MrUpdateInstall.settingsIntent(a));
        } catch (RuntimeException e) {
            sAwaiting = false;
            setState(ERROR, 0, text(a, "mr_update_err_install"));
        }
    }

    /** A dialog that notices when the screen of the settings closes and the focus comes back. */
    private static final class Box extends Dialog {
        Box(Activity a, int theme) {
            super(a, theme);
        }

        public void onWindowFocusChanged(boolean hasFocus) {
            super.onWindowFocusChanged(hasFocus);
            if (hasFocus) resumeAfterSettings();
        }
    }

    /** What the install thread and the receiver tell: moved to the screen's thread, and only if the dialog is still this one. */
    private static final class Ui implements MrUpdateInstall.Listener {
        private final Activity mActivity;
        private final long mCode;

        Ui(Activity a, long code) {
            mActivity = a;
            mCode = code;
        }

        private void post(Runnable r) {
            mActivity.runOnUiThread(r);
        }

        private boolean mine() {
            return sOwner == mActivity && sCode == mCode && sDialog != null;
        }

        public void state(final int state, final int percent) {
            post(new Runnable() {
                public void run() {
                    if (mine()) setState(state, percent, null);
                }
            });
        }

        public void failed(final MrUpdateInstall.Failure f) {
            post(new Runnable() {
                public void run() {
                    if (mine()) setState(ERROR, 0, errorText(mActivity, f));
                }
            });
        }

        public void aborted() {
            post(new Runnable() {
                public void run() {
                    if (mine()) setState(NOTES, 0, null);
                }
            });
        }
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
            int state = sState;
            if (mWhat == BTN_INSTALL) {
                if (state == PERMISSION) openSettings(mActivity);
                else begin(mActivity, mNotice);
                return;
            }
            if (mWhat == BTN_LATER && (state == MrUpdateInstall.DOWNLOADING || state == MrUpdateInstall.VERIFYING)) {
                MrUpdateInstall.cancel(); // Cancel: back to the notes, nothing to snooze
                setState(NOTES, 0, null);
                return;
            }
            MrUpdate.snooze(mActivity.getApplicationContext(), mNotice);
            dismiss();
            if (mWhat == BTN_GITHUB) MrLink.open(mActivity, MrUpdate.RELEASE_PAGE);
        }
    }
}
