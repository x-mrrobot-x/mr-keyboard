package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.preference.Preference;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Locale;

/**
 * The "Version" line of Settings, About (v2.0.0): shows the installed version and, when tapped, the notes of that
 * version in the same dialog as the update notice (layout mr_update_dialog, notes as cards by MrNotesText), with a
 * single Close button. The notes come from the APK, so they work without a network: assets/mr_release_notes.md is a
 * copy of docs/release-notes/v&lt;versionName&gt;.md (check_version.py fails when they differ), with the two blocks
 * **Português** and **English**; the phone gets Portuguese in Portuguese and English in any other language.
 *
 * The line used to end with " custom" or " official" (an old check of the signature of Hacker's Keyboard that never
 * had anything to compare); it is just the version now, followed by a hint that the line can be tapped.
 */
public final class MrVersion implements Preference.OnPreferenceClickListener {
    static final String ASSET = "mr_release_notes.md";
    static final String MARK_PT = "**Português**";
    static final String MARK_EN = "**English**";
    /** The notes of one version are a few KB; a file far larger than that is not read. */
    static final int MAX_BYTES = 64 << 10;

    private static Dialog sDialog;
    private static Activity sOwner;

    private final Activity mActivity;

    public MrVersion(Activity a) {
        mActivity = a;
    }

    public boolean onPreferenceClick(Preference preference) {
        show(mActivity);
        return true;
    }

    // ------------------------------------------------------------------ the line

    /** The text under "Version": the installed version name and the hint (just the name if the hint is missing). */
    static String summary(Context c) {
        String name = MrUpdate.appName(c);
        String s = MrPacks.text(c, "mr_version_summary", name);
        return s != null ? s : name;
    }

    // ------------------------------------------------------------------ the notes

    /** The notes of the installed version in the language of the phone, as written (Markdown); empty if there are none. */
    static String notes(Context c, Locale l) {
        String all = readAsset(c);
        if (all == null) return "";
        boolean pt = l != null && "pt".equals(l.getLanguage());
        String body = block(all, pt);
        return body != null ? body : "";
    }

    /** The whole asset as text, or null if it is missing, too large or cannot be read. */
    static String readAsset(Context c) {
        InputStream in = null;
        try {
            in = c.getAssets().open(ASSET);
            return readAll(in);
        } catch (IOException e) {
            return null;
        } catch (RuntimeException e) {
            return null;
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    // nothing to do
                }
            }
        }
    }

    /** What the stream has, as UTF-8 text; null when it has more than MAX_BYTES (the stream is not closed here). */
    static String readAll(InputStream in) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        byte[] buf = new byte[4096];
        int n;
        while ((n = in.read(buf)) > 0) {
            out.write(buf, 0, n);
            if (out.size() > MAX_BYTES) return null;
        }
        return new String(out.toByteArray(), "UTF-8");
    }

    /**
     * The text of one language block: what follows the line "**Português**" (pt) or "**English**" up to the other
     * mark or the end, trimmed (the same rule as make_update.py, which makes the notes of update.json). When the block
     * asked for is missing or empty the other one is used; null when there is neither.
     */
    static String block(String text, boolean pt) {
        String[] lines = text.replace("\r\n", "\n").split("\n", -1);
        int ptAt = -1;
        int enAt = -1;
        for (int i = 0; i < lines.length; i++) {
            String t = lines[i].trim();
            if (ptAt < 0 && t.equals(MARK_PT)) ptAt = i;
            else if (enAt < 0 && t.equals(MARK_EN)) enAt = i;
        }
        String body = body(lines, pt ? ptAt : enAt, pt ? enAt : ptAt);
        return body != null ? body : body(lines, pt ? enAt : ptAt, pt ? ptAt : enAt);
    }

    /** The trimmed lines after the mark at line at, up to the other mark (line other, -1 if there is none); null if empty. */
    private static String body(String[] lines, int at, int other) {
        if (at < 0) return null;
        int end = other > at ? other : lines.length;
        StringBuilder sb = new StringBuilder();
        for (int i = at + 1; i < end; i++) {
            if (sb.length() > 0) sb.append('\n');
            sb.append(lines[i]);
        }
        String body = sb.toString().trim();
        return body.length() > 0 ? body : null;
    }

    // ------------------------------------------------------------------ the dialog

    static boolean showing() {
        return sDialog != null && sDialog.isShowing();
    }

    /** Closes the dialog if it belongs to this screen: called when the screen is destroyed. */
    static void release(Activity a) {
        if (sOwner == a) dismiss();
    }

    static void dismiss() {
        Dialog d = sDialog;
        sDialog = null;
        sOwner = null;
        if (d != null) {
            try {
                d.dismiss();
            } catch (RuntimeException e) {
                // the window may already be gone with its screen
            }
        }
    }

    /** Opens the notes of the installed version on the screen. */
    static void show(Activity a) {
        if (a == null || a.isFinishing() || a.isDestroyed()) return;
        dismiss();
        Dialog dialog = null;
        try {
            int theme = a.getResources().getIdentifier("Theme.MrKeyboard.Dialog", "style", a.getPackageName());
            if (theme == 0) theme = 0x7f0d00a1;
            theme = MrMatrix.dialogTheme(a, theme); // a little see-through with the Matrix effect
            dialog = new Dialog(a, theme);
            dialog.requestWindowFeature(1); // FEATURE_NO_TITLE: the layout has its own title
            int layout = a.getResources().getIdentifier("mr_update_dialog", "layout", a.getPackageName());
            if (layout == 0) return;
            View root = LayoutInflater.from(MrLocaleCtx.of(dialog.getContext())).inflate(layout, null);
            if (!fill(a, root)) return;
            dialog.setContentView(root);
            sDialog = dialog;
            sOwner = a;
            dialog.show();
        } catch (RuntimeException e) {
            // a dialog that cannot be drawn must not bring the screen down
            if (dialog != null && dialog == sDialog) dismiss();
        }
    }

    /** Puts the texts in the layout and hides what only the update uses; false if the layout lacks what it should. */
    static boolean fill(Activity a, View root) {
        TextView title = (TextView) root.findViewWithTag("upd_title");
        TextView sub = (TextView) root.findViewWithTag("upd_sub");
        View notes = root.findViewWithTag("upd_notes");
        TextView close = (TextView) root.findViewWithTag("upd_later");
        View install = root.findViewWithTag("upd_install");
        View github = root.findViewWithTag("upd_github");
        View box = root.findViewWithTag("upd_box");
        View error = root.findViewWithTag("upd_error");
        if (title == null || sub == null || !(notes instanceof LinearLayout) || close == null || install == null
                || github == null || box == null || error == null) return false;
        Locale loc = a.getResources().getConfiguration().locale;
        title.setText(MrUpdateDialog.text(a, "mr_version_title"));
        sub.setText(MrUpdate.appName(a));
        MrNotesText.fill((LinearLayout) notes, notes(a, loc), MrUpdateDialog.text(a, "mr_update_notes_none"));
        install.setVisibility(View.GONE);
        github.setVisibility(View.GONE);
        box.setVisibility(View.GONE);
        error.setVisibility(View.GONE);
        close.setText(MrUpdateDialog.text(a, "mr_version_close"));
        close.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                dismiss();
            }
        });
        return true;
    }
}
