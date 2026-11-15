package com.mrkeyboard.app;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Debug;
import android.os.Handler;
import android.os.Looper;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.support.v4.content.FileProvider;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Build _86 of docs/plan-performance.md (stage 4 part 5): the map of the memory of the keyboard, to find what keeps an old service alive.
 *
 * The count of MrLive showed one more service and one more input view alive after every switch to another keyboard (2, then 3), and the
 * search from the static variables of the app found nothing that holds them, so what holds them is outside what the app can look at
 * (a message queue, an animator, a thread, a registration in the system). Only the heap itself says which: the row "Save the memory map"
 * of the Advanced screen runs the same cleanup and collection as the row "Free memory now", writes a heap dump (android.os.Debug), puts it
 * in a zip in the cache folder that the screenshots already share (shots/, the provider com.mrkeyboard.app.shots) and opens the system's Share.
 * docs/tools/heap_holders.py reads that file and prints the chain from a root of the heap to each service and input view of the keyboard.
 *
 * The dump is the memory of the keyboard's process: it can have words that were typed and the items of the clipboard, so the text of the row says
 * so. Nothing is sent by the app; the person chooses where it goes. The zip is replaced at every save and lives in the cache folder, which
 * the system can empty.
 */
final class MrHeap {
    /** Key of the row of the Advanced screen. */
    static final String ROW = "mr_perf_heap";
    static final String AUTHORITY = "com.mrkeyboard.app.shots";
    static final String NAME = "mr_heap";
    private static final String DIR = "shots";

    /** True while a map is being written: a second tap in the meantime does nothing. */
    static volatile boolean sBusy;

    private MrHeap() { }

    /** The row of the Advanced screen (PrefScreenAdvanced.onResume, after MrPerf.fill). */
    static void fill(PreferenceActivity screen) {
        try {
            Preference row = screen.findPreference(ROW);
            if (row != null) row.setOnPreferenceClickListener(new Click(screen, row));
        } catch (RuntimeException e) {
            // the row keeps the text of the XML
        }
    }

    /** Writes the dump and zips it into shots/mr_heap.zip of the cache folder; null when anything fails. The dump itself is not kept. */
    static File save(Context c) {
        File dir = new File(c.getCacheDir(), DIR);
        File dump = new File(dir, NAME + ".hprof");
        File zip = new File(dir, NAME + ".zip");
        try {
            dir.mkdirs();
            Debug.dumpHprofData(dump.getAbsolutePath());
            zip(dump, zip);
            return zip;
        } catch (Throwable t) {
            zip.delete();
            return null;
        } finally {
            dump.delete();
        }
    }

    private static void zip(File from, File to) throws IOException {
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(to));
        FileInputStream in = new FileInputStream(from);
        try {
            out.putNextEntry(new ZipEntry(NAME + ".hprof"));
            byte[] buf = new byte[65536];
            int n;
            while ((n = in.read(buf)) > 0) out.write(buf, 0, n);
            out.closeEntry();
        } finally {
            in.close();
            out.close();
        }
    }

    /** The system's Share for the zip: the chooser of an ACTION_SEND with the file read-only for whoever receives it. */
    static Intent share(Uri uri, String title) {
        Intent send = new Intent(Intent.ACTION_SEND);
        send.setType("application/zip");
        send.putExtra(Intent.EXTRA_STREAM, uri);
        send.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        Intent chooser = Intent.createChooser(send, title);
        chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_GRANT_READ_URI_PERMISSION);
        return chooser;
    }

    /** A tap on the row: the cleanup and the collection here (they touch the views), the dump and the zip in the background, Share at the end. */
    static final class Click implements Preference.OnPreferenceClickListener {
        private final Context mContext;
        private final Preference mRow;
        private final Handler mMain = new Handler(Looper.getMainLooper());

        Click(Context c, Preference row) {
            mContext = c;
            mRow = row;
        }

        public boolean onPreferenceClick(Preference p) {
            if (sBusy) return true;
            sBusy = true;
            setSummary("mr_ui_perf_heap_busy");
            MrTrim.onTrim(MrTrim.COMPLETE);
            System.gc();
            new Thread(new Work(this)).start();
            return true;
        }

        void setSummary(String name) {
            String text = MrPacks.text(mContext, name);
            if (text != null) mRow.setSummary(text);
        }

        /** The dump and the zip (a thread of its own: the dump stops the process for a moment and a big one takes seconds). */
        void work() {
            File zip = save(mContext);
            mMain.post(new Done(this, zip));
        }

        /** Back on the main thread: Share, or the text that says it failed. */
        void done(File zip) {
            sBusy = false;
            setSummary(zip == null ? "mr_ui_perf_heap_fail" : "mr_ui_perf_heap_sum");
            if (zip == null) return;
            try {
                String title = MrPacks.text(mContext, "mr_ui_perf_heap_title");
                mContext.startActivity(share(FileProvider.getUriForFile(mContext, AUTHORITY, zip), title != null ? title : ""));
            } catch (RuntimeException e) {
                setSummary("mr_ui_perf_heap_fail");
            }
        }
    }

    private static final class Work implements Runnable {
        private final Click mClick;

        Work(Click click) {
            mClick = click;
        }

        public void run() {
            mClick.work();
        }
    }

    private static final class Done implements Runnable {
        private final Click mClick;
        private final File mZip;

        Done(Click click, File zip) {
            mClick = click;
            mZip = zip;
        }

        public void run() {
            mClick.done(mZip);
        }
    }
}
