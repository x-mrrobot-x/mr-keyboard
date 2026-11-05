package com.mrkeyboard.app;

import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;
import android.content.SharedPreferences;

import java.util.Calendar;
import java.util.Random;
import java.util.TimeZone;

/**
 * When the morning check runs and what is kept for it (v1.82.0).
 *
 * There is no periodic job "at 8 o'clock" in Android, only "every N hours", so the check is a one-time job that
 * schedules the next one when it ends: JobScheduler with a minimum latency up to the next morning of the phone
 * (MORNING_HOUR plus a number of minutes between 0 and 59, drawn once and kept, so that the phones do not all ask at the
 * same minute), any network, persisted over a restart. No deadline: the job does not run without a network just to fail.
 * Android decides the exact time (Doze, battery saving): the morning is a goal, not a promise.
 *
 * State in the preferences "mr_update": the switch (on by default), the drawn minutes, the highest versionCode already
 * notified (one notification per version) and whether the notification permission was already asked for.
 * next() does not depend on Android, so the PC tests run it with fixed dates, time zones and daylight saving time.
 *
 * Nothing here uses the network.
 */
final class MrUpdateSchedule {
    private MrUpdateSchedule() { }

    /** Identifier of the job (one per app). */
    static final int JOB_ID = 1820;
    /** Hour of the morning (local time) that the job aims at. */
    static final int MORNING_HOUR = 8;
    static final String KEY_MORNING = "morning";
    static final String KEY_MINUTES = "morning_min";
    static final String KEY_NOTIFIED = "notified_code";
    static final String KEY_ASKED = "perm_asked";

    /** Fixed in tests (-1 = draw). */
    static int sTestMinutes = -1;

    // ------------------------------------------------------------------ the time

    /**
     * The next moment, strictly after now, at MORNING_HOUR:minutes of the local day of tz. Before that time today it is
     * today; at that time or later it is tomorrow. The calendar takes care of the changes of day, of the month and of
     * the daylight saving time (a local time that does not exist that day moves forward).
     */
    static long next(long now, TimeZone tz, int minutes) {
        int m = Math.max(0, Math.min(59, minutes));
        Calendar c = Calendar.getInstance(tz);
        c.setTimeInMillis(now);
        c.set(Calendar.HOUR_OF_DAY, MORNING_HOUR);
        c.set(Calendar.MINUTE, m);
        c.set(Calendar.SECOND, 0);
        c.set(Calendar.MILLISECOND, 0);
        if (c.getTimeInMillis() <= now) {
            c.add(Calendar.DAY_OF_MONTH, 1);
            c.set(Calendar.HOUR_OF_DAY, MORNING_HOUR);
            c.set(Calendar.MINUTE, m);
        }
        return c.getTimeInMillis();
    }

    /** How long to wait from now to the next morning, in milliseconds (always above zero). */
    static long delay(long now, TimeZone tz, int minutes) {
        return Math.max(1L, next(now, tz, minutes) - now);
    }

    // ------------------------------------------------------------------ what is kept

    static SharedPreferences prefs(Context c) {
        return MrUpdate.prefs(c);
    }

    /** "Check every morning" (Settings, About). On by default. */
    static boolean morning(Context c) {
        return prefs(c).getBoolean(KEY_MORNING, true);
    }

    static void setMorning(Context c, boolean on) {
        prefs(c).edit().putBoolean(KEY_MORNING, on).commit();
    }

    /** The minutes after MORNING_HOUR (0 to 59): drawn the first time and kept. */
    static int minutes(Context c) {
        SharedPreferences p = prefs(c);
        int m = p.getInt(KEY_MINUTES, -1);
        if (m >= 0 && m <= 59) return m;
        m = sTestMinutes >= 0 ? sTestMinutes : new Random().nextInt(60);
        p.edit().putInt(KEY_MINUTES, m).commit();
        return m;
    }

    /** The highest versionCode that already had a notification (0 = none). */
    static long notified(Context c) {
        return prefs(c).getLong(KEY_NOTIFIED, 0);
    }

    static void setNotified(Context c, long versionCode) {
        prefs(c).edit().putLong(KEY_NOTIFIED, versionCode).commit();
    }

    /** True once the notification permission was asked for (the system dialog is shown on the first opening only). */
    static boolean asked(Context c) {
        return prefs(c).getBoolean(KEY_ASKED, false);
    }

    static void setAsked(Context c) {
        prefs(c).edit().putBoolean(KEY_ASKED, true).commit();
    }

    // ------------------------------------------------------------------ the job

    private static JobScheduler scheduler(Context c) {
        Object s = c.getSystemService(Context.JOB_SCHEDULER_SERVICE);
        return s instanceof JobScheduler ? (JobScheduler) s : null;
    }

    /** True when the job of the next morning is waiting in the system. */
    static boolean armed(Context c) {
        try {
            JobScheduler js = scheduler(c);
            return js != null && js.getPendingJob(JOB_ID) != null;
        } catch (RuntimeException e) {
            return false;
        }
    }

    /**
     * Schedules the job for the next morning (replacing the one that waits) if the switch is on; cancels it if off.
     * Never throws: if the system refuses, the next opening of the app tries again.
     */
    static void arm(Context c) {
        try {
            JobScheduler js = scheduler(c);
            if (js == null) return;
            if (!morning(c)) {
                js.cancel(JOB_ID);
                return;
            }
            long wait = delay(MrUpdate.now(), TimeZone.getDefault(), minutes(c));
            JobInfo job = new JobInfo.Builder(JOB_ID, new ComponentName(c, MrUpdateJob.class))
                    .setMinimumLatency(wait)
                    .setRequiredNetworkType(JobInfo.NETWORK_TYPE_ANY)
                    .setPersisted(true)
                    .build();
            js.schedule(job);
        } catch (RuntimeException e) {
            // the system refused the job (or the permission to persist it): nothing else to do here
        }
    }

    /** Like arm, but leaves alone a job that is already waiting (opening the app does not move it). */
    static void ensure(Context c) {
        if (!morning(c)) {
            arm(c); // off: cancels what may be left
        } else if (!armed(c)) {
            arm(c);
        }
    }

    /**
     * What opening the app (and the update of the app) does about the morning check: the job exists if the switch is
     * on, the channel of the notification exists, and the notification of a version that is already installed goes away.
     * No network.
     */
    static void sync(Context c) {
        ensure(c);
        if (morning(c)) MrUpdateNotify.ensureChannel(c);
        MrUpdateNotify.dropIfInstalled(c);
    }
}
