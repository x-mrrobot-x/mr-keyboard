package com.mrkeyboard.app;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.preference.Preference;
import android.preference.PreferenceActivity;

import java.io.File;

/**
 * The "Dictionary memory" row of Settings → Advanced → Performance, next to the other numbers measured on the phone (MrPerf). It says,
 * for the dictionary in use, the size of the files, how much of each is in memory now and how long each part took to open (MrDiag).
 *
 * Reading the memory map of the process takes a few milliseconds, so the text is made in a thread and put on the row when it is
 * ready, never when the screen has gone. Each time the screen opens the row says "Reading…" again and a new read starts; an answer
 * that arrives after a newer read started is dropped (the generation), so two reads never write over each other.
 */
final class MrDictMem {
    private MrDictMem() { }

    /** The key of the row in prefs_advanced.xml. */
    static final String ROW = "mr_dict_mem";

    /** Number of the last read started; only the main thread changes it. */
    private static int sGeneration;
    /** Reads started since the process began (the tests count them). */
    static volatile int sReads;
    /** The handler of the main thread that takes the answers; made on the first use (only the main thread asks for it). */
    private static Handler sMain;

    static Handler main() {
        if (sMain == null) sMain = new Handler(Looper.getMainLooper());
        return sMain;
    }

    /** PrefScreenAdvanced.onResume: the row says it is reading and the text arrives from a thread. */
    public static void fill(PreferenceActivity screen) {
        try {
            final Preference row = screen.findPreference(ROW);
            if (row == null) return;
            final PreferenceActivity owner = screen;
            final File dir = MrPacks.activeDir();
            final int gen = ++sGeneration;
            if (dir == null) {
                row.setSummary(text(owner, null));
                return;
            }
            row.setSummary(string(owner, "mr_mem_wait"));
            final Handler main = main();
            Thread th = new Thread(new Runnable() {
                public void run() {
                    String made;
                    try {
                        made = text(owner, MrDiag.collect(dir));
                    } catch (RuntimeException e) {
                        return;   // the row keeps "Reading…"; nothing is worth a crash here
                    }
                    final String shown = made;
                    main.post(new Runnable() {
                        public void run() {
                            if (gen != sGeneration || owner.isFinishing() || owner.isDestroyed()) return;
                            row.setSummary(shown);
                        }
                    });
                }
            }, "MrDiag");
            th.setPriority(Thread.MIN_PRIORITY);
            sReads++;
            th.start();
        } catch (RuntimeException e) {
            // the row keeps the text of the XML
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
