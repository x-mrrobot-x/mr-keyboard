package com.mrkeyboard.app;

import android.app.job.JobParameters;
import android.app.job.JobService;
import android.content.Context;

/**
 * The morning check (v1.82.0): a JobService that the system starts some time after the morning that
 * MrUpdateSchedule aimed at, when there is a network. Declared in the manifest with BIND_JOB_SERVICE.
 *
 * What a round does (run): switch off, nothing; notifications blocked, nothing and no network (a notice that nobody can
 * see is not worth a request); otherwise the check of MrUpdate (the result of one less than 6 hours old is reused, so
 * who opened the app at 7:50 does not cause a second request at 8:00) and, if there is a version newer than the installed
 * one that was not notified yet, one notification. Always ends by scheduling the next morning, whatever happened:
 * today's failure is solved tomorrow or when the app opens.
 *
 * The work runs in its own thread (the system calls onStartJob on the main thread). If the system stops the job before
 * the work ends, it is rescheduled by the system (onStopJob returns true); once the work is done, the next morning
 * is scheduled (that replaces this job, which the system reports as a stop: then nothing is rescheduled).
 */
public final class MrUpdateJob extends JobService {
    /** run(): the switch is off. */
    static final int OFF = 0;
    /** run(): notifications are blocked; no request was made. */
    static final int BLOCKED = 1;
    /** run(): checked (or answered from the stored result) and there is nothing newer. */
    static final int NONE = 2;
    /** run(): a notification was posted. */
    static final int NOTIFIED = 3;
    /** run(): there is a newer version but it was already notified. */
    static final int REPEATED = 4;
    /** run(): the check failed and there is nothing to notify, or the notification could not be posted. */
    static final int FAILED = 5;

    private volatile boolean mDone;

    /** One round, without Android's service (the PC tests call it). Never throws. */
    static int run(Context c) {
        try {
            if (!MrUpdateSchedule.morning(c)) return OFF;
            if (!MrUpdateNotify.enabled(c)) return BLOCKED;
            MrUpdate.Result r = MrUpdate.checkIfOlder(c, MrUpdate.JOB_REUSE);
            MrUpdate.Notice n = MrUpdate.pending(c);
            if (n == null) {
                MrUpdateNotify.dismiss(c);
                return r.status == MrUpdate.FAILED ? FAILED : NONE;
            }
            if (n.versionCode <= MrUpdateSchedule.notified(c)) return REPEATED;
            if (!MrUpdateNotify.show(c, n)) return FAILED;
            MrUpdateSchedule.setNotified(c, n.versionCode);
            return NOTIFIED;
        } catch (RuntimeException e) {
            return FAILED;
        }
    }

    @Override
    public boolean onStartJob(final JobParameters params) {
        final Context app = getApplicationContext();
        mDone = false;
        new Thread(new Runnable() {
            public void run() {
                MrUpdateJob.run(app);
                mDone = true;
                MrUpdateSchedule.arm(app);
                jobFinished(params, false);
            }
        }, "mr-update-job").start();
        return true;
    }

    @Override
    public boolean onStopJob(JobParameters params) {
        // stopped by the system before the work ended: try again later; stopped by the next scheduling: nothing
        return !mDone;
    }
}
