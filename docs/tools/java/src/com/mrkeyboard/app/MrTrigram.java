package com.mrkeyboard.app;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

/**
 * Most likely words after TWO words (v1.62), from the trigrams.bin of the dictionary pack
 * (since 1.63; before, it was in assets). Format in docs/tools/make_trigrams.py. It only has the
 * contexts where the pair alone would be wrong; for the rest the prediction goes on with the bigrams of the .dict.
 *
 * MrPacks calls use() when activating the language pack: it loads in a separate thread (a few MB in
 * memory); until it finishes, find() returns 0 and the prediction uses only the bigrams.
 */
public final class MrTrigram {
    private MrTrigram() { }

    private static String[] sWords;               // in code order (String.compareTo)
    private static long[] sKeys;                  // (id1 << 32) | id2, in order
    private static int[] sStart;                  // start of the continuations of each context
    private static int[] sNext;                   // ids of the continuations
    private static byte[] sScore;                 // f7 of each continuation
    private static String sPath;                  // file loaded (or loading)
    private static int sGen;                      // changes at every use(); an old load is discarded
    private static boolean sNative;               // v1.77: the file is open in the native lib (MrNative), not in sWords
    private static final Object NATIVE_LOAD = new Object();   // one native open at a time (the lib keeps a single file)

    /** Starts using this file (null = none). Does nothing if it is already the file in use. */
    static void use(final File file) {
        final String path = file != null ? file.getPath() : null;
        final int gen;
        synchronized (MrTrigram.class) {
            if (path == null ? sPath == null : path.equals(sPath)) return;
            sPath = path;
            gen = ++sGen;
            sWords = null;
            sKeys = null;
            sStart = null;
            sNext = null;
            sScore = null;
            sNative = false;
        }
        if (path == null) {
            MrNative.triClose();
            return;
        }
        Thread t = new Thread(new Runnable() {
            public void run() {
                // v1.77: the lib reads and checks the file and keeps only indexes (about 4 bytes per word and per
                // context); if it does not open (no lib, a file it refuses) it falls back to the Java loading below
                if (openNative(path, gen)) return;
                InputStream in = null;
                try {
                    in = new FileInputStream(file);
                    load(in, gen);
                } catch (Throwable e) {
                    // without the file the prediction goes on with the bigrams only
                } finally {
                    if (in != null) {
                        try { in.close(); } catch (IOException ignored) { }
                    }
                }
            }
        }, "MrTrigram");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    /** Opens the file in the native lib if this load is still the current one. true = ready through the native path. */
    private static boolean openNative(String path, int gen) {
        synchronized (NATIVE_LOAD) {
            synchronized (MrTrigram.class) {
                if (gen != sGen) return true;   // another load has taken its place: nothing to do here
            }
            if (!MrNative.triOpen(path)) {
                MrNative.triClose();   // does not leave the previous file open in the lib
                return false;
            }
            synchronized (MrTrigram.class) {
                if (gen == sGen) sNative = true;
            }
            return true;
        }
    }

    static void load(InputStream raw) throws IOException {
        int gen;
        synchronized (MrTrigram.class) {
            gen = ++sGen;
            sPath = "(teste)";
            sNative = false;
        }
        load(raw, gen);
    }

    /** Reads the file (also used in tests). */
    private static void load(InputStream raw, int gen) throws IOException {
        DataInputStream in = new DataInputStream(new BufferedInputStream(raw, 65536));
        byte[] magic = new byte[4];
        in.readFully(magic);
        if (magic[0] != 'M' || magic[1] != 'R' || magic[2] != 'T' || magic[3] != '1') {
            throw new IOException("unknown format");
        }
        int n = in.readInt();
        String[] words = new String[n];
        byte[] buf = new byte[256];
        for (int i = 0; i < n; i++) {
            int len = in.readUnsignedByte();
            in.readFully(buf, 0, len);
            words[i] = new String(buf, 0, len, "UTF-8");
        }
        int m = in.readInt();
        long[] keys = new long[m];
        int[] start = new int[m + 1];
        int[] next = new int[m * 3];
        byte[] score = new byte[m * 3];
        int p = 0;
        for (int i = 0; i < m; i++) {
            long a = read24(in);
            long b = read24(in);
            keys[i] = (a << 32) | b;
            start[i] = p;
            int k = in.readUnsignedByte();
            for (int j = 0; j < k; j++) {
                next[p] = read24(in);
                score[p] = (byte) in.readUnsignedByte();
                p++;
            }
        }
        start[m] = p;
        synchronized (MrTrigram.class) {
            if (gen != sGen) return;
            sKeys = keys;
            sStart = start;
            sNext = next;
            sScore = score;
            sWords = words;
        }
    }

    private static int read24(DataInputStream in) throws IOException {
        int a = in.readUnsignedByte();
        int b = in.readUnsignedByte();
        int c = in.readUnsignedByte();
        return (a << 16) | (b << 8) | c;
    }

    static synchronized boolean ready() {
        return sWords != null || sNative;
    }

    private static int id(String w) {
        String[] words = sWords;
        if (words == null || w == null) return -1;
        int i = Arrays.binarySearch(words, w);
        return i >= 0 ? i : -1;
    }

    /**
     * Continuations of (w1, w2) with the f7 of each, or null. Tries the words as they came and in
     * lowercase (start of sentence).
     */
    static synchronized int find(String w1, String w2, String[] outWords, int[] outScores) {
        if ((sWords == null && !sNative) || w1 == null || w2 == null) return 0;
        String[] c1 = {w1, w1.toLowerCase()};
        String[] c2 = {w2, w2.toLowerCase()};
        if (sNative) return MrNative.triFind(c1[0], c1[1], c2[0], c2[1], outWords, outScores);
        for (String a : c1) {
            int ia = id(a);
            if (ia < 0) continue;
            for (String b : c2) {
                int ib = id(b);
                if (ib < 0) continue;
                int at = Arrays.binarySearch(sKeys, ((long) ia << 32) | ib);
                if (at < 0) continue;
                int n = 0;
                for (int p = sStart[at]; p < sStart[at + 1] && n < outWords.length; p++) {
                    outWords[n] = sWords[sNext[p]];
                    outScores[n] = sScore[p] & 0xFF;
                    n++;
                }
                return n;
            }
        }
        return 0;
    }
}
