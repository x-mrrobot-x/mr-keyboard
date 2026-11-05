package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;

/**
 * What the screens do about the notice of a new version (v1.82.0):
 *  - onOpen(): when the main screen or Settings opens, if "Check when the app opens" is on, looks for a new version in
 *    the background (at most once a day, MrUpdate.checkIfOlder) and, if there is one that is not snoozed, opens the
 *    dialog. No Toast and no error on failure: offline simply shows nothing. The dialog also opens at once when the
 *    screen is started with the extra EXTRA_SHOW (the morning notification, stage 8).
 *  - bind(): in Settings, About: the "Check for updates" line (manual, the result shows in its own summary) and the
 *    "Check when the app opens" switch. Both rows are not persistent: the switch lives in the "mr_update" preferences
 *    (MrUpdate.auto), outside the backup and outside "Restore defaults".
 *  - release(): the screen is going away; closes the dialog without snoozing.
 */
final class MrUpdateUi {
    /** Extra that asks the screen to open the dialog of the known new version. */
    static final String EXTRA_SHOW = "mr_update_show";

    private static boolean sChecking;

    private MrUpdateUi() { }

    // ------------------------------------------------------------------ Settings

    /** Connects the rows of Settings and does what opening the screen does. */
    static void bind(PreferenceActivity a) {
        try {
            Preference row = a.findPreference("mr_update");
            if (row != null) {
                row.setOnPreferenceClickListener(new Check(a));
                showKnown(a, row);
            }
            Preference sw = a.findPreference("mr_update_auto");
            if (sw instanceof CheckBoxPreference) {
                ((CheckBoxPreference) sw).setChecked(MrUpdate.auto(a));
                sw.setOnPreferenceChangeListener(new Auto(a.getApplicationContext()));
            }
        } catch (RuntimeException e) {
            // the rows are optional: a failure here must not stop Settings from opening
        }
        onOpen(a);
    }

    /** The summary of the line when nothing is happening: the new version if known, else the installed one. */
    private static void showKnown(Activity a, Preference row) {
        MrUpdate.Notice known = MrUpdate.pending(a);
        if (known != null) {
            row.setSummary(MrUpdateDialog.text(a, "mr_update_sum_available", known.versionName));
        } else {
            row.setSummary(MrUpdateDialog.text(a, "mr_update_check_sum", MrUpdate.appName(a)));
        }
    }

    /** After a check in the background: the line of Settings (if this is Settings) shows the version found. */
    private static void refreshRow(Activity a) {
        if (!(a instanceof PreferenceActivity) || sChecking) return;
        Preference row = ((PreferenceActivity) a).findPreference("mr_update");
        if (row != null) showKnown(a, row);
    }

    /** Tap on "Check for updates": a known new version opens the dialog; otherwise it asks GitHub now. */
    private static void check(final Activity a, final Preference row) {
        final Context app = a.getApplicationContext();
        MrUpdate.Notice known = MrUpdate.pending(app);
        if (known != null) {
            MrUpdateDialog.show(a, known);
            return;
        }
        if (sChecking) return;
        sChecking = true;
        row.setSummary(MrUpdateDialog.text(a, "mr_update_sum_checking"));
        new Thread(new Runnable() {
            public void run() {
                MrUpdate.Result r;
                try {
                    r = MrUpdate.check(app);
                } catch (RuntimeException e) {
                    r = new MrUpdate.Result();
                    r.status = MrUpdate.FAILED;
                    r.error = MrUpdate.ERR_FILE;
                }
                final MrUpdate.Result result = r;
                a.runOnUiThread(new Runnable() {
                    public void run() {
                        sChecking = false;
                        if (a.isFinishing() || a.isDestroyed()) return;
                        answer(a, row, result);
                    }
                });
            }
        }, "mr-update-check").start();
    }

    /** Shows the result of a manual check in the line itself; a new version also opens the dialog. */
    private static void answer(Activity a, Preference row, MrUpdate.Result r) {
        try {
            if (r.status == MrUpdate.AVAILABLE && r.notice != null) {
                showKnown(a, row);
                MrUpdateDialog.show(a, r.notice);
            } else if (r.status == MrUpdate.UP_TO_DATE) {
                row.setSummary(MrUpdateDialog.text(a, "mr_update_sum_uptodate", MrUpdate.appName(a)));
            } else if (r.status == MrUpdate.FAILED) {
                String why = MrUpdateDialog.text(a, MrUpdate.errorKey(r.error), r.httpCode);
                row.setSummary(MrUpdateDialog.text(a, "mr_update_sum_error", why));
            } else {
                showKnown(a, row);
            }
        } catch (RuntimeException e) {
            // the screen may be going away
        }
    }

    private static final class Check implements Preference.OnPreferenceClickListener {
        private final PreferenceActivity mActivity;

        Check(PreferenceActivity a) {
            mActivity = a;
        }

        public boolean onPreferenceClick(Preference preference) {
            check(mActivity, preference);
            return true;
        }
    }

    private static final class Auto implements Preference.OnPreferenceChangeListener {
        private final Context mContext;

        Auto(Context c) {
            mContext = c;
        }

        public boolean onPreferenceChange(Preference preference, Object newValue) {
            MrUpdate.setAuto(mContext, Boolean.TRUE.equals(newValue));
            return true;
        }
    }

    // ------------------------------------------------------------------ opening a screen

    /** What opening the main screen or Settings does about updates (see the class comment). */
    static void onOpen(final Activity a) {
        try {
            if (a.getIntent() != null && a.getIntent().getBooleanExtra(EXTRA_SHOW, false)) {
                a.getIntent().removeExtra(EXTRA_SHOW); // so that turning the screen does not open it again
                MrUpdate.Notice known = MrUpdate.pending(a);
                if (known != null) {
                    MrUpdateDialog.show(a, known);
                    return;
                }
            }
            if (!MrUpdate.auto(a)) return;
            final Context app = a.getApplicationContext();
            new Thread(new Runnable() {
                public void run() {
                    MrUpdate.Notice n = null;
                    try {
                        MrUpdate.checkIfOlder(app, MrUpdate.WINDOW);
                        n = MrUpdate.toShow(app);
                    } catch (RuntimeException e) {
                        // offline or anything else: nothing to show
                    }
                    final MrUpdate.Notice notice = n;
                    a.runOnUiThread(new Runnable() {
                        public void run() {
                            if (a.isFinishing() || a.isDestroyed()) return;
                            refreshRow(a);
                            if (notice != null) MrUpdateDialog.show(a, notice);
                        }
                    });
                }
            }, "mr-update-open").start();
        } catch (RuntimeException e) {
            // the check is a courtesy: never bring the screen down
        }
    }

    /** The screen is going away: closes its dialog (without snoozing). */
    static void release(Activity a) {
        MrUpdateDialog.release(a);
    }
}
