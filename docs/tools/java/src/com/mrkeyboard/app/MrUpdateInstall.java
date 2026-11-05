package com.mrkeyboard.app;

import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInstaller;
import android.net.Uri;
import android.os.Build;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

/**
 * Download and install of the new version, inside the app (v1.82.0). The APK of the exact tag of the signed notice is
 * read by MrPacks.sNet (HTTPS, redirects, timeouts) and written straight into a PackageInstaller session while its
 * SHA-256 is computed; only when the size and the hash match what the signed update.json says the session is committed.
 * Android then asks the user to confirm the update (an app cannot skip that screen, and this one does not ask for the
 * permission that would let it) and checks the signature: an APK signed by another key never replaces this app.
 *
 *   permission  canInstall() / settingsIntent()   "Install unknown apps" of the app (REQUEST_INSTALL_PACKAGES)
 *   download    start() -> Job (one thread)       DOWNLOADING n% -> VERIFYING -> INSTALLING, or a Failure
 *   result      MrUpdateReceiver -> onResult()    the system's answer: confirm screen, done, "No", or an error
 *
 * flow(), copy(), verify() and statusKey() do not depend on Android (the session is a Target), so the PC tests run
 * them with a fake one. Leaving the screen cancels a download that has not been committed yet (cancel()); the thread
 * checks the flag on every block, abandons the session and says nothing.
 */
final class MrUpdateInstall {
    /** Action of the PendingIntent that the session reports to (MrUpdateReceiver, not exported). */
    static final String ACTION = "com.mrkeyboard.app.UPDATE_RESULT";
    /** Settings screen "Install unknown apps" of one app (Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Android 8+). */
    static final String ACTION_UNKNOWN_SOURCES = "android.settings.MANAGE_UNKNOWN_APP_SOURCES";
    static final String APK_NAME = "mr-keyboard.apk";

    static final int DOWNLOADING = 1;
    static final int VERIFYING = 2;
    static final int INSTALLING = 3;

    private static final int BLOCK = 65536;

    private MrUpdateInstall() { }

    // ------------------------------------------------------------------ what the screen hears

    interface Listener {
        /** Called from the install thread (and from the receiver): the screen must move it to its own thread. */
        void state(int state, int percent);

        void failed(Failure f);

        /** The user said "No" on the system's confirm screen: not an error. */
        void aborted();
    }

    /** What the copy needs from the job: progress, cancel flag, and the moment of no return. */
    interface Sink {
        void percent(int percent);

        boolean cancelled();

        /** True if the commit may go on; from then on cancel() has no effect. */
        boolean beginCommit();
    }

    /** The place the APK is written to: a PackageInstaller session (or a fake one in the tests). */
    interface Target {
        OutputStream openWrite() throws IOException;

        void sync(OutputStream out) throws IOException;

        void commit();

        void abandon();

        void close();
    }

    static final class Failure extends Exception {
        /** Name of the text of the failure; null = cancelled (no message). */
        final String key;
        /** Name of the text of the reason, put inside the first (or null), and its number (HTTP code). */
        final String reasonKey;
        final int arg;

        Failure(String key, String reasonKey, int arg) {
            super(key);
            this.key = key;
            this.reasonKey = reasonKey;
            this.arg = arg;
        }

        static Failure cancelled() {
            return new Failure(null, null, 0);
        }

        boolean isCancel() {
            return key == null;
        }
    }

    static final class Copied {
        long total;
        String sha256;
    }

    // ------------------------------------------------------------------ logic that does not need Android

    static int percent(long done, long total) {
        if (total <= 0 || done <= 0) return 0;
        return (int) Math.min(100L, done * 100L / total);
    }

    /**
     * Text (name) of the system's answer for a session that did not install; null if it is no failure: installed (the
     * app is replaced and restarted) or the user's "No" on the confirm screen.
     */
    static String statusKey(int status) {
        switch (status) {
            case PackageInstaller.STATUS_SUCCESS:
            case PackageInstaller.STATUS_PENDING_USER_ACTION:
            case PackageInstaller.STATUS_FAILURE_ABORTED:
                return null;
            case PackageInstaller.STATUS_FAILURE_STORAGE:
                return "mr_update_err_storage";
            default: // blocked, invalid, conflict, incompatible (another signature), unknown
                return "mr_update_err_install";
        }
    }

    static boolean isNoSpace(IOException e) {
        String m = e.getMessage();
        if (m == null) return false;
        m = m.toLowerCase(java.util.Locale.ROOT);
        return m.contains("enospc") || m.contains("no space");
    }

    private static Failure writeFailure(IOException e) {
        return new Failure(isNoSpace(e) ? "mr_update_err_storage" : "mr_update_err_install", null, 0);
    }

    private static Failure readFailure(IOException e) {
        if (e instanceof MrPacks.HttpError) {
            return new Failure("mr_update_err_download", "mr_update_err_http", ((MrPacks.HttpError) e).code);
        }
        return new Failure("mr_update_err_download", "mr_update_err_network", 0);
    }

    static Failure mismatch() {
        return new Failure("mr_update_err_mismatch", null, 0);
    }

    /**
     * Copies the stream to out counting, hashing and reporting. More bytes than the signed size stop the copy at once
     * (a file that does not match is never written to the end); fewer are found by verify().
     */
    static Copied copy(InputStream in, long declared, OutputStream out, long expected, Sink sink) throws Failure {
        if (declared > 0 && declared != expected) throw mismatch();
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            throw new Failure("mr_update_err_install", null, 0);
        }
        byte[] buf = new byte[BLOCK];
        long total = 0;
        int last = -1;
        while (true) {
            int r;
            try {
                r = in.read(buf);
            } catch (IOException e) {
                if (sink.cancelled()) throw Failure.cancelled();
                throw readFailure(e);
            }
            if (r < 0) break;
            if (sink.cancelled()) throw Failure.cancelled();
            total += r;
            if (total > expected) throw mismatch();
            md.update(buf, 0, r);
            try {
                out.write(buf, 0, r);
            } catch (IOException e) {
                throw writeFailure(e);
            }
            int p = percent(total, expected);
            if (p != last) {
                last = p;
                sink.percent(p);
            }
        }
        Copied c = new Copied();
        c.total = total;
        c.sha256 = MrPacks.hex(md.digest());
        return c;
    }

    /** The size and the SHA-256 have to be the ones of the signed notice. */
    static void verify(Copied c, MrUpdate.Notice n) throws Failure {
        if (c.total != n.apkSize || !c.sha256.equalsIgnoreCase(n.apkSha256)) throw mismatch();
    }

    /** The whole job after the session exists: download, check, commit. Runs in the install thread. */
    static void flow(MrUpdate.Notice n, Target t, Listener l, Sink s) {
        InputStream in = null;
        OutputStream out = null;
        boolean committed = false;
        try {
            l.state(DOWNLOADING, 0);
            long[] len = new long[1];
            try {
                in = MrPacks.sNet.open(n.apkUrl(), len);
            } catch (IOException e) {
                if (s.cancelled()) throw Failure.cancelled();
                throw readFailure(e);
            }
            try {
                out = t.openWrite();
            } catch (IOException e) {
                throw writeFailure(e);
            }
            Copied c = copy(in, len[0], out, n.apkSize, s);
            l.state(VERIFYING, 100);
            verify(c, n);
            try {
                t.sync(out);
                out.close();
                out = null;
            } catch (IOException e) {
                throw writeFailure(e);
            }
            if (!s.beginCommit()) throw Failure.cancelled();
            t.commit();
            committed = true;
            l.state(INSTALLING, 100);
        } catch (Failure f) {
            // whatever goes wrong after the user cancelled is no news: the screen already went back to the notes
            if (!f.isCancel() && !s.cancelled()) l.failed(f);
        } catch (RuntimeException e) {
            // the system refused the session or the commit (SecurityException, IllegalStateException...)
            if (!s.cancelled()) l.failed(new Failure("mr_update_err_install", null, 0));
        } finally {
            MrPacks.closeQuietly(in);
            MrPacks.closeQuietly(out);
            if (committed) t.close();
            else t.abandon();
        }
    }

    // ------------------------------------------------------------------ the job and its state

    private static Job sJob;

    private static final class Job implements Runnable, Sink {
        private final Context mApp;
        private final MrUpdate.Notice mNotice;
        private final Target mTarget; // null: a session of the PackageInstaller (the tests give a fake one)
        final Listener listener;
        private boolean mCancelled;
        private boolean mCommitted;

        Job(Context app, MrUpdate.Notice n, Target t, Listener l) {
            mApp = app;
            mNotice = n;
            mTarget = t;
            listener = l;
        }

        public void run() {
            try {
                Target t = mTarget;
                try {
                    if (t == null) t = SessionTarget.create(mApp, mNotice);
                } catch (IOException e) {
                    listener.failed(writeFailure(e));
                    return;
                } catch (RuntimeException e) {
                    listener.failed(new Failure("mr_update_err_install", null, 0));
                    return;
                }
                flow(mNotice, t, listener, this);
            } finally {
                synchronized (MrUpdateInstall.class) {
                    if (sJob == this && !isCommitted()) sJob = null;
                }
            }
        }

        public void percent(int p) {
            listener.state(DOWNLOADING, p);
        }

        public synchronized boolean cancelled() {
            return mCancelled;
        }

        public synchronized boolean beginCommit() {
            if (mCancelled) return false;
            mCommitted = true;
            return true;
        }

        synchronized boolean isCommitted() {
            return mCommitted;
        }

        synchronized void cancel() {
            if (!mCommitted) mCancelled = true;
        }
    }

    /** True while a download that can still be cancelled is running. */
    static synchronized boolean busy() {
        return sJob != null && !sJob.isCommitted();
    }

    /** Starts the download and install; false if one is already running. */
    static synchronized boolean start(Context app, MrUpdate.Notice n, Listener l) {
        return startJob(app, n, null, l);
    }

    /** For the tests: the same job with a fake place to write to. */
    static synchronized boolean startWith(MrUpdate.Notice n, Target t, Listener l) {
        return startJob(null, n, t, l);
    }

    private static boolean startJob(Context app, MrUpdate.Notice n, Target t, Listener l) {
        if (busy()) return false;
        Job j = new Job(app, n, t, l);
        sJob = j;
        Thread th = new Thread(j, "mr-update-install");
        th.setDaemon(true);
        th.start();
        return true;
    }

    /** The screen is leaving or the user said Cancel: stops a download that has not been committed; nothing after. */
    static synchronized void cancel() {
        if (sJob != null && !sJob.isCommitted()) {
            sJob.cancel();
            sJob = null;
        }
    }

    /** What the system answered about the session (MrUpdateReceiver). Success is not handled: the app is replaced. */
    static synchronized void onResult(int status) {
        Job j = sJob;
        if (j == null || !j.isCommitted()) return; // an answer for a session that is not the one in progress
        sJob = null;
        if (status == PackageInstaller.STATUS_SUCCESS) return;
        if (status == PackageInstaller.STATUS_FAILURE_ABORTED) {
            j.listener.aborted();
            return;
        }
        String key = statusKey(status);
        j.listener.failed(new Failure(key != null ? key : "mr_update_err_install", null, 0));
    }

    // ------------------------------------------------------------------ Android: permission and session

    /** True if the user already allowed this app to install apps ("Install unknown apps"). */
    static boolean canInstall(Context c) {
        return c.getPackageManager().canRequestPackageInstalls();
    }

    /** The system screen where the user allows it, for this app. */
    static Intent settingsIntent(Context c) {
        return new Intent(ACTION_UNKNOWN_SOURCES, Uri.parse("package:" + c.getPackageName()));
    }

    /** Abandons the sessions left by earlier tries (an interrupted download keeps a partial file on the device). */
    static void cleanup(Context app) {
        if (busy()) return;
        try {
            abandonMine(app.getPackageManager().getPackageInstaller());
        } catch (RuntimeException e) {
            // nothing to clean
        }
    }

    private static void abandonMine(PackageInstaller pi) {
        List<PackageInstaller.SessionInfo> mine = pi.getMySessions();
        if (mine == null) return;
        for (PackageInstaller.SessionInfo si : mine) {
            try {
                pi.abandonSession(si.getSessionId());
            } catch (RuntimeException e) {
                // already gone
            }
        }
    }

    private static final class SessionTarget implements Target {
        private final Context mApp;
        private final PackageInstaller.Session mSession;
        private final int mId;
        private final long mSize;

        private SessionTarget(Context app, PackageInstaller.Session s, int id, long size) {
            mApp = app;
            mSession = s;
            mId = id;
            mSize = size;
        }

        static SessionTarget create(Context app, MrUpdate.Notice n) throws IOException {
            PackageInstaller pi = app.getPackageManager().getPackageInstaller();
            abandonMine(pi);
            PackageInstaller.SessionParams p = new PackageInstaller.SessionParams(PackageInstaller.SessionParams.MODE_FULL_INSTALL);
            p.setAppPackageName(app.getPackageName());
            p.setSize(n.apkSize);
            // always ask the user: the permission that allows silent updates is not requested
            if (Build.VERSION.SDK_INT >= 31) p.setRequireUserAction(PackageInstaller.SessionParams.USER_ACTION_REQUIRED);
            int id = pi.createSession(p);
            PackageInstaller.Session s;
            try {
                s = pi.openSession(id);
            } catch (IOException e) {
                pi.abandonSession(id);
                throw e;
            }
            return new SessionTarget(app, s, id, n.apkSize);
        }

        public OutputStream openWrite() throws IOException {
            return mSession.openWrite(APK_NAME, 0, mSize);
        }

        public void sync(OutputStream out) throws IOException {
            mSession.fsync(out);
        }

        public void commit() {
            Intent i = new Intent(mApp, MrUpdateReceiver.class); // explicit: a mutable PendingIntent may not be implicit
            i.setAction(ACTION);
            int flags = PendingIntent.FLAG_UPDATE_CURRENT;
            if (Build.VERSION.SDK_INT >= 31) flags |= PendingIntent.FLAG_MUTABLE; // the system adds the status to it
            mSession.commit(PendingIntent.getBroadcast(mApp, mId, i, flags).getIntentSender());
        }

        public void abandon() {
            try {
                mSession.abandon();
            } catch (RuntimeException e) {
                // already gone
            }
            close();
        }

        public void close() {
            try {
                mSession.close();
            } catch (RuntimeException e) {
                // already closed
            }
        }
    }
}
