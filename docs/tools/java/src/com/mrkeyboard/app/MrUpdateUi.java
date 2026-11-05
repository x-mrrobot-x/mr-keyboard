package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceGroup;

/**
 * What the screens do about the notice of a new version (v1.82.0):
 *  - onOpen(): when the main screen or Settings opens, abandons the install sessions that an interrupted download left
 *    and, if "Check when the app opens" is on, looks for a new version in
 *    the background (at most once a day, MrUpdate.checkIfOlder) and, if there is one that is not snoozed, opens the
 *    dialog. No Toast and no error on failure: offline simply shows nothing. The dialog also opens at once when the
 *    screen is started with the extra EXTRA_SHOW (the morning notification). It also makes sure the morning job exists
 *    (MrUpdateSchedule.sync) and, on Android 13+, asks once for the notification permission.
 *  - bind(): in Settings, About: the "Check for updates" line (manual, the result shows in its own summary), the
 *    "Check when the app opens" switch and the "Check every morning" switch. The rows are not persistent: the switches
 *    live in the "mr_update" preferences (MrUpdate.auto, MrUpdateSchedule.morning), outside the backup and outside
 *    "Restore defaults". Under the morning switch there is a line "Allow notifications" that is only in the screen
 *    while the switch is on and the notifications are blocked; a tap opens the notification settings of the app.
 *  - resume(): the screen came back (maybe from the system settings): updates that line.
 *  - release(): the screen is going away; closes the dialog without snoozing.
 */
final class MrUpdateUi {
    /** Extra that asks the screen to open the dialog of the known new version. */
    static final String EXTRA_SHOW = "mr_update_show";

    /** Request code of the notification permission (the answer is not needed: resume() reads the new state). */
    static final int REQUEST_NOTIFICATIONS = 1820;
    static final String POST_NOTIFICATIONS = "android.permission.POST_NOTIFICATIONS";
    private static final int ANDROID_13 = 33;

    private static boolean sChecking;
    /** The "Allow notifications" line, the group it belongs to, whether it is in the screen now and the screen that owns them. */
    private static Preference sNotifRow;
    private static PreferenceGroup sNotifGroup;
    private static boolean sNotifShown;
    private static Activity sOwner;

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
            Preference morning = a.findPreference("mr_update_morning");
            if (morning instanceof CheckBoxPreference) {
                ((CheckBoxPreference) morning).setChecked(MrUpdateSchedule.morning(a));
                morning.setOnPreferenceChangeListener(new Morning(a));
            }
            Preference notif = a.findPreference("mr_update_notif");
            Preference group = a.findPreference("debugging");
            if (notif != null && group instanceof PreferenceGroup) {
                sOwner = a;
                sNotifRow = notif;
                sNotifGroup = (PreferenceGroup) group;
                sNotifShown = true; // it comes with the screen; refreshNotif takes it out when it is not needed
                notif.setOnPreferenceClickListener(new Notif(a));
                refreshNotif(a);
            }
        } catch (RuntimeException e) {
            // the rows are optional: a failure here must not stop Settings from opening
        }
        onOpen(a);
    }

    /** The screen came back: the notification settings may have changed meanwhile. */
    static void resume(PreferenceActivity a) {
        try {
            refreshNotif(a);
        } catch (RuntimeException e) {
            // the line is optional
        }
    }

    /** Puts the "Allow notifications" line in the screen while the morning check is on and the notifications are blocked, else takes it out. */
    private static void refreshNotif(Activity a) {
        if (sOwner != a || sNotifRow == null || sNotifGroup == null) return;
        boolean blocked = MrUpdateSchedule.morning(a) && !MrUpdateNotify.enabled(a);
        if (blocked && !sNotifShown) {
            sNotifGroup.addPreference(sNotifRow);
            sNotifShown = true;
        } else if (!blocked && sNotifShown) {
            sNotifGroup.removePreference(sNotifRow);
            sNotifShown = false;
        }
    }

    /**
     * Android 13+: asks for the notification permission (the system dialog). On the first opening with the morning check
     * on (once) or when the user turns the switch on (force). True if the dialog was asked for. Older Androids have
     * no such permission. After two refusals the system no longer shows it: the line "Allow notifications" is the way.
     */
    static boolean askNotifications(Activity a, boolean force) {
        try {
            if (Build.VERSION.SDK_INT < ANDROID_13 || !MrUpdateSchedule.morning(a) || MrUpdateNotify.enabled(a)) return false;
            if (!force && MrUpdateSchedule.asked(a)) return false;
            MrUpdateSchedule.setAsked(a);
            a.requestPermissions(new String[] {POST_NOTIFICATIONS}, REQUEST_NOTIFICATIONS);
            return true;
        } catch (RuntimeException e) {
            return false;
        }
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

    /** The morning switch: on schedules the next morning (and asks for the permission if it is missing), off cancels it. */
    private static final class Morning implements Preference.OnPreferenceChangeListener {
        private final PreferenceActivity mActivity;

        Morning(PreferenceActivity a) {
            mActivity = a;
        }

        public boolean onPreferenceChange(Preference preference, Object newValue) {
            boolean on = Boolean.TRUE.equals(newValue);
            Context app = mActivity.getApplicationContext();
            MrUpdateSchedule.setMorning(app, on);
            MrUpdateSchedule.arm(app);
            if (on) {
                MrUpdateNotify.ensureChannel(app);
                askNotifications(mActivity, true);
            }
            refreshNotif(mActivity);
            return true;
        }
    }

    /** The "Allow notifications" line: opens the notification settings of the app. */
    private static final class Notif implements Preference.OnPreferenceClickListener {
        private final PreferenceActivity mActivity;

        Notif(PreferenceActivity a) {
            mActivity = a;
        }

        public boolean onPreferenceClick(Preference preference) {
            try {
                mActivity.startActivity(MrUpdateNotify.settingsIntent(mActivity));
            } catch (RuntimeException e) {
                // no screen for it on this phone
            }
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
            final Context app = a.getApplicationContext();
            boolean shown = false;
            if (a.getIntent() != null && a.getIntent().getBooleanExtra(EXTRA_SHOW, false)) {
                a.getIntent().removeExtra(EXTRA_SHOW); // so that turning the screen does not open it again
                MrUpdate.Notice known = MrUpdate.pending(a);
                if (known != null) {
                    MrUpdateDialog.show(a, known);
                    shown = true;
                }
            }
            // the system dialog of the permission and ours do not come together: the notice waits for the next opening
            final boolean asking = !shown && askNotifications(a, false);
            final boolean look = !shown && MrUpdate.auto(a);
            new Thread(new Runnable() {
                public void run() {
                    MrUpdateInstall.cleanup(app); // sessions that an interrupted download left behind
                    MrUpdateSchedule.sync(app);   // the morning job exists, the notification of an installed version is gone
                    if (!look) return;
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
                            refreshNotif(a);
                            if (notice != null && !asking) MrUpdateDialog.show(a, notice);
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
        if (sOwner == a) {
            sOwner = null;
            sNotifRow = null;
            sNotifGroup = null;
            sNotifShown = false;
        }
        MrUpdateDialog.release(a);
    }
}
