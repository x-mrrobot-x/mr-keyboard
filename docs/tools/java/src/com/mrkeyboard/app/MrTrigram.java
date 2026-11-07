package com.mrkeyboard.app;

import java.io.File;

/**
 * Most likely words after TWO words (v1.62), from the trigrams.bin of the dictionary pack
 * (since 1.63; before, it was in assets). Format in docs/tools/make_trigrams.py. It only has the
 * contexts where the pair alone would be wrong; for the rest the prediction goes on with the bigrams of the .dict.
 *
 * Since v1.87.0 the file is read and searched only by the native engine (engine/src/mr_tri.cpp, through MrNative), so the trigrams take
 * nothing from the Java heap. Since v1.90.0 the lib maps the file instead of copying it, and the MRT2 layout needs no index at all
 * (MRT1, the layout of the packs until 1.89, still gets about 4 bytes per word and per context on the lib's heap). This class
 * only chooses which file is open and asks the lib. Without the lib there is no two-word prediction (find() returns 0) and the
 * prediction uses only the bigrams of the .dict.
 *
 * MrPacks calls use() when activating the language pack: it opens in a separate thread; until it finishes, find() returns 0.
 */
public final class MrTrigram {
    private MrTrigram() { }

    private static String sPath;                  // file open (or opening)
    private static int sGen;                      // changes at every use(); an old open is discarded
    private static boolean sNative;               // the file is open in the lib
    private static final Object NATIVE_LOAD = new Object();   // one native open at a time (the lib keeps a single file)

    /** Starts using this file (null = none). Does nothing if it is already the file in use. */
    static void use(final File file) {
        final String path = file != null ? file.getPath() : null;
        final int gen;
        synchronized (MrTrigram.class) {
            if (path == null ? sPath == null : path.equals(sPath)) return;
            sPath = path;
            gen = ++sGen;
            sNative = false;
        }
        if (path == null) {
            MrNative.triClose();
            return;
        }
        Thread t = new Thread(new Runnable() {
            public void run() {
                open(path, gen);
            }
        }, "MrTrigram");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    /** Same as use(), but returns when the file is open (tests and tools). true = the lib has the file. */
    static boolean useNow(File file) {
        use(null);   // forces the reopening even if it is the same file
        final String path = file != null ? file.getPath() : null;
        if (path == null) return false;
        final int gen;
        synchronized (MrTrigram.class) {
            sPath = path;
            gen = ++sGen;
            sNative = false;
        }
        return open(path, gen);
    }

    /** Opens the file in the native lib if this call is still the current one. true = ready. */
    private static boolean open(String path, int gen) {
        synchronized (NATIVE_LOAD) {
            synchronized (MrTrigram.class) {
                if (gen != sGen) return false;   // another call has taken its place: nothing to do here
            }
            final long t0 = System.nanoTime();
            if (!MrNative.triOpen(path)) {
                MrNative.triClose();   // does not leave the previous file open in the lib
                return false;
            }
            MrDiag.sTriPath = path;   // 1.90.0: how long it took, for the "Dictionary memory" line
            MrDiag.sTriNs = System.nanoTime() - t0;
            synchronized (MrTrigram.class) {
                if (gen == sGen) sNative = true;
                return sNative;
            }
        }
    }

    static synchronized boolean ready() {
        return sNative;
    }

    /**
     * Continuations of (w1, w2) with the f7 of each, or 0. Tries the words as they came and in
     * lowercase (start of sentence).
     */
    static synchronized int find(String w1, String w2, String[] outWords, int[] outScores) {
        if (!sNative || w1 == null || w2 == null) return 0;
        return MrNative.triFind(w1, w1.toLowerCase(), w2, w2.toLowerCase(), outWords, outScores);
    }
}
