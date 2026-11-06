package com.mrkeyboard.app;

import java.nio.ByteBuffer;

/**
 * Native engine (v1.77; the only implementation since v1.87.0): the correction search of MrFuzzy and the trigram lookup of
 * MrTrigram done in C++ (libmrengine.so, built from engine/). This class loads the lib, hands over the costs and the
 * rules and acts as the bridge; Java decides:
 *   - the lib is loaded once per process, in the background, as soon as the keyboard opens a dictionary (MrPacks.activate calls
 *     preload()); a query that arrives before it has finished waits for it (ready());
 *   - without the lib (not copied to lib/<abi>/, ABI without it, different contract version, any error while loading) the
 *     searches answer "no result": the keyboard keeps typing and completing words (libjni_pckeyboard.so) but has no
 *     correction by search and no two-word prediction. The settings screen says so;
 *   - the source of truth for costs, rules and letter tables stays in Java: here they are
 *     handed to the lib once (init) or when the language pack changes (rules).
 *
 * Simulating a lib that does not load (tests): -Dmr.native=off.
 */
public final class MrNative {
    private MrNative() { }

    /** Contract with the lib: equal to mr::kEngineVersion in engine/src/mr_engine.h. Goes up together with it. */
    static final int ENGINE_VERSION = 1;

    /** Characters of each result in the output buffer (word + space + word): equal to kResultChars. */
    static final int RESULT_CHARS = MrFuzzy.MAX_WORD * 2 + 2;
    /** Size of outInfo: visited nodes + (length, cost) of each result. */
    static final int INFO_SIZE = 1 + 2 * MrFuzzy.MAX_RESULTS;

    private static final int UNKNOWN = 0;
    private static final int READY = 1;
    private static final int OFF = -1;

    private static volatile int sState = UNKNOWN;
    private static boolean sPreloading;
    private static MrRules sPushed;

    /**
     * Is the lib loaded, in the right version and with the tables handed over? If the load is in progress (preload) or has not started, it
     * waits for it (load() is synchronized): the first query after a cold start can wait a few milliseconds, never more than once.
     */
    static boolean ready() {
        int s = sState;
        if (s == UNKNOWN) return load();
        return s == READY;
    }

    /** Starts the load in the background (once). Called when the keyboard opens a dictionary, so that the first key does not wait. */
    static synchronized void preload() {
        if (sPreloading || sState != UNKNOWN) return;
        sPreloading = true;
        Thread t = new Thread(new Runnable() {
            public void run() {
                load();
            }
        }, "MrNative");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    private static synchronized boolean load() {
        if (sState != UNKNOWN) return sState == READY;
        boolean ok = false;
        try {
            if (!"off".equals(System.getProperty("mr.native"))) {
                System.loadLibrary("mrengine");
                ok = nVersion() == ENGINE_VERSION && init();
            }
        } catch (Throwable e) {
            ok = false;   // UnsatisfiedLinkError (lib missing or JNI_OnLoad failed) and anything else
        }
        sState = ok ? READY : OFF;
        return ok;
    }

    /** Costs and limits, in the order of Costs in mr_engine.h. */
    static int[] costs() {
        return new int[] {
            MrFuzzy.C_PROX_1, MrFuzzy.C_PROX_2, MrFuzzy.C_PROX_FAR, MrFuzzy.C_DEL_FIRST, MrFuzzy.C_PHON,
            MrFuzzy.C_VOWEL, MrFuzzy.C_SUB, MrFuzzy.C_INS, MrFuzzy.C_INS_DOUBLE, MrFuzzy.C_INS_H,
            MrFuzzy.C_INS_NEAR, MrFuzzy.C_DEL, MrFuzzy.C_DEL_DOUBLE, MrFuzzy.C_TRANS, MrFuzzy.C_MULTI,
            MrFuzzy.C_SPLIT, MrFuzzy.NODE_BUDGET
        };
    }

    /** Character.toLowerCase from U+0000 to U+FFFF (the lib has no Unicode table of its own). */
    static char[] lowerTable() {
        char[] t = new char[65536];
        for (int i = 0; i < 65536; i++) t[i] = Character.toLowerCase((char) i);
        return t;
    }

    /** Character.isUpperCase from U+0000 to U+FFFF (1 = uppercase). */
    static byte[] upperTable() {
        byte[] t = new byte[65536];
        for (int i = 0; i < 65536; i++) t[i] = (byte) (Character.isUpperCase((char) i) ? 1 : 0);
        return t;
    }

    /** MrText.base from 0 to 255. */
    static char[] baseTable() {
        char[] t = new char[256];
        for (int i = 0; i < 256; i++) t[i] = MrText.base(i);
        return t;
    }

    /** Java scores with Math.pow(2.0, -cost / 25.0): the lib uses these values to round the same way. */
    static double[] powTable() {
        double[] t = new double[256];
        for (int i = 0; i < 256; i++) t[i] = Math.pow(2.0, -i / 25.0);
        return t;
    }

    private static boolean init() {
        return nInit(costs(), lowerTable(), upperTable(), baseTable(), powTable());
    }

    /** Groups typed (2 letters) -> dictionary (1): a, b, d of each rule in sequence. */
    static char[] packT2(MrRules r) {
        char[] t = new char[r.t2a.length * 3];
        for (int i = 0; i < r.t2a.length; i++) {
            t[3 * i] = r.t2a[i]; t[3 * i + 1] = r.t2b[i]; t[3 * i + 2] = r.t2d[i];
        }
        return t;
    }

    /** Groups dictionary (2 letters) -> typed (1): p, c, t of each rule in sequence. */
    static char[] packD2(MrRules r) {
        char[] t = new char[r.d2p.length * 3];
        for (int i = 0; i < r.d2p.length; i++) {
            t[3 * i] = r.d2p[i]; t[3 * i + 1] = r.d2c[i]; t[3 * i + 2] = r.d2t[i];
        }
        return t;
    }

    /** Silent letters after another one: previous and letter of each rule in sequence (the cost goes in silCost). */
    static char[] packSil(MrRules r) {
        char[] t = new char[r.silPrev.length * 2];
        for (int i = 0; i < r.silPrev.length; i++) {
            t[2 * i] = r.silPrev[i]; t[2 * i + 1] = r.silChar[i];
        }
        return t;
    }

    private static boolean pushRules(MrRules r) {
        return nSetRules(r.pairs, packT2(r), packD2(r), packSil(r), r.silCost, r.silentStart, r.silentAny, r.extra,
                r.oneLetter);
    }

    /**
     * Correction search in C++. Returns how many results (0 to 5) were written to outWords (result i starting at
     * i * RESULT_CHARS), outInfo (0 = visited nodes; then length and cost of each) and outScores, or -1 if
     * it was not possible (no lib, a query it refuses): the caller then has no results.
     */
    static int search(ByteBuffer dict, int size, int n, char[] tb, char[] near, int[] nearCount, MrRules rules,
                      char[] outWords, int[] outInfo, long[] outScores) {
        if (!ready() || dict == null || rules == null) return -1;
        try {
            synchronized (MrNative.class) {
                if (sPushed != rules) {
                    sPushed = null;
                    if (!pushRules(rules)) return -1;
                    sPushed = rules;
                }
            }
            return nSearch(dict, size, n, tb, near, nearCount, outWords, outInfo, outScores);
        } catch (Throwable e) {
            return -1;
        }
    }

    /** Opens trigrams.bin in the lib. false = it did not open (bad file or no lib): there is no two-word prediction. */
    static boolean triOpen(String path) {
        if (!ready()) return false;
        try {
            return nTriOpen(path);
        } catch (Throwable e) {
            return false;
        }
    }

    static void triClose() {
        if (sState != READY) return;
        try {
            nTriClose();
        } catch (Throwable e) {
            // nothing to do
        }
    }

    /** Continuations of (w1, w2) as in MrTrigram.find; a1/a2 are the spellings of w1 and b1/b2 those of w2. */
    static int triFind(String a1, String a2, String b1, String b2, String[] outWords, int[] outScores) {
        try {
            return nTriFind(a1, a2, b1, b2, outWords, outScores);
        } catch (Throwable e) {
            return 0;
        }
    }

    private static native int nVersion();

    private static native boolean nInit(int[] costs, char[] lower, byte[] upper, char[] base256, double[] pow2);

    private static native boolean nSetRules(byte[] pairs, char[] t2, char[] d2, char[] sil, short[] silCost,
                                            short[] silentStart, short[] silentAny, boolean[] extra, boolean[] oneLetter);

    private static native int nSearch(ByteBuffer dict, int size, int n, char[] tb, char[] near, int[] nearCount,
                                      char[] outWords, int[] outInfo, long[] outScores);

    private static native boolean nTriOpen(String path);

    private static native void nTriClose();

    private static native int nTriFind(String a1, String a2, String b1, String b2, String[] outWords, int[] outScores);
}
