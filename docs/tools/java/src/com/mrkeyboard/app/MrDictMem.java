package com.mrkeyboard.app;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.preference.Preference;
import android.preference.PreferenceActivity;

import java.io.File;

/**
 * The "Dictionary memory" lines of Settings → Advanced → Performance → Keyboard statistics (the row of MrPerf), after the memory line and before the
 * note about resetting. They say, for the dictionary in use, the size of the files, how much of each is in memory now and how long each part took to
 * open (MrDiag). They are not a row of their own: {@link MrPerf#summary} asks {@link #block} for them every time it makes the text of the row.
 *
 * Reading the memory map of the process takes a few milliseconds, so the text is made in a thread and, when it is ready, the row is written again
 * with it (never when the screen has gone). Each time the screen opens the lines say "Reading…" again and a new read starts; an answer that arrives
 * after a newer read started is dropped (the generation), so two reads never write over each other.
 */
final class MrDictMem {
    private MrDictMem() { }

    /** Number of the last read started; only the main thread changes it. */
    private static int sGeneration;
    /** Reads started since the process began (the tests count them). */
    static volatile int sReads;
    /** Is the screen of the statistics open (or was it, in this process)? Until then the lines are not part of the text of the row. */
    private static boolean sShown;
    /** The lines of the last read; null while a read is running. Only the main thread writes it. */
    private static String sText;
    /** The handler of the main thread that takes the answers; made on the first use (only the main thread asks for it). */
    private static Handler sMain;

    static Handler main() {
        if (sMain == null) sMain = new Handler(Looper.getMainLooper());
        return sMain;
    }

    /**
     * MrPerf.summary: the title and the lines (or "Reading…"), or null when the screen of the statistics was never opened (the other users of the text
     * of the row, like the tests of the meter, do not get them).
     */
    static String block(Context c) {
        if (!sShown) return null;
        String body = sText != null ? sText : string(c, "mr_mem_wait");
        return string(c, "mr_mem_title") + "\n" + body;
    }

    /**
     * PrefScreenAdvanced.onResume, BEFORE MrPerf.fill (which writes the row with the lines): the lines say it is reading and the text arrives from a
     * thread. It does nothing when the screen has no row of the numbers.
     */
    public static void fill(PreferenceActivity screen) {
        try {
            final Preference row = screen.findPreference(MrPerf.ROW);
            if (row == null) return;
            final PreferenceActivity owner = screen;
            final File dir = MrPacks.activeDir();
            final int gen = ++sGeneration;
            sShown = true;
            if (dir == null) {
                sText = text(owner, null);
                return;
            }
            sText = null;
            final Handler main = main();
            Thread th = new Thread(new Runnable() {
                public void run() {
                    String made;
                    try {
                        made = text(owner, MrDiag.collect(dir));
                    } catch (RuntimeException e) {
                        return;   // the lines keep "Reading…"; nothing is worth a crash here
                    }
                    final String shown = made;
                    main.post(new Runnable() {
                        public void run() {
                            if (gen != sGeneration || owner.isFinishing() || owner.isDestroyed()) return;
                            sText = shown;
                            try {
                                row.setSummary(MrPerf.summary(owner));
                            } catch (RuntimeException e) {
                                // the next time the row is written it has the lines
                            }
                        }
                    });
                }
            }, "MrDiag");
            th.setPriority(Thread.MIN_PRIORITY);
            sReads++;
            th.start();
        } catch (RuntimeException e) {
            // the row has no lines
        }
    }

    /** The lines of the report: dictionary, trigram file and engine, each with size, memory and time; no report = no dictionary yet. */
    static String text(Context c, MrDiag.Report r) {
        if (r == null) return string(c, "mr_mem_none");
        StringBuilder sb = new StringBuilder();
        sb.append(string(c, "mr_mem_dict", r.id, Integer.valueOf(r.version), MrDiag.bytesText(r.dictBytes), MrDiag.bytesText(r.dictMem),
                MrDiag.msText(r.dictNs)));
        sb.append('\n');
        if (r.hasTri) {
            sb.append(string(c, "mr_mem_tri", Integer.valueOf(r.triFormat), MrDiag.bytesText(r.triBytes), MrDiag.bytesText(r.triMem),
                    MrDiag.msText(r.triNs)));
        } else {
            sb.append(string(c, "mr_mem_tri_none"));
        }
        sb.append('\n').append(string(c, "mr_mem_engine", MrDiag.msText(r.engineNs), MrDiag.msText(r.rulesNs)));
        if (r.dictMem < 0 && r.triMem < 0) sb.append('\n').append(string(c, "mr_mem_nomem"));
        return sb.toString();
    }

    /** A text of the app in the language of the screen; the name itself when it is missing (never null, never an exception). */
    private static String string(Context c, String name, Object... args) {
        String s = MrPacks.text(c, name, args);
        return s != null ? s : name;
    }
}
