package com.mrkeyboard.app;

import java.io.File;
import java.nio.ByteBuffer;

/**
 * Gesture typing, the recognition: which word is a trace of the finger over the letters? (MrGestureInput is the keyboard
 * side: which touches are gestures and what is done with the word. docs/gesture-typing.md has the whole story.)
 *
 * The work is done by the native engine (engine/src/mr_gesture.h, through MrNative): a small neural network reads the trace
 * and a search in main.dict and in the words of the person too (MrGestureWords), finds the words. This class is
 * the policy and the source of truth:
 *   - the scoring values and the limits below are handed to the lib (params(), limits()); the lib has none of its own;
 *   - which weights file is open (use(), like MrTrigram with trigrams.bin);
 *   - which keys the keyboard has and where (setLayout());
 *   - which spellings of the previous word are looked up for the context (decode()).
 * Without the lib, or before the weights are open, decode() answers -1: there is no Java implementation.
 *
 * The network is the encoder of "FUTO Swipe" (model honorable_sturgeon) by FUTO Holdings, Inc. Its weights are under the FUTO
 * Model Weights License 1.0 (gesture/LICENSE-FUTO-Model-Weights.md), which asks that the product tell its users, in a visible
 * place, that it is powered by "FUTO Swipe". The keyboard must show that notice from the moment it ships the weights.
 *
 * The frame of the coordinates (keys and touch points alike): x = 0 at the left edge of the keyboard and 1 at the right edge;
 * y = 0 at the top of the first row of letters and 1 at the bottom of the last row of letters. In the standard keyboard the
 * three rows of letters are therefore at y = 1/6, 1/2 and 5/6. A touch may be outside the frame (y &lt; 0 over the number row).
 */
public final class MrGesture {
    private MrGesture() { }

    // Score of a word = logp / keys^GAMMA + LAMBDA_FREQ * freq + BETA * keys + CTX * bigram
    //   logp: log-probability the network gives to the word; keys: keys the gesture went through; freq: frequency in the
    //   dictionary (0..255); bigram: frequency of the pair with the previous word in the dictionary (1..127; 0 = none).
    // The values were tuned on the validation part of the public gestures of swipe.futo.org (English), with the dictionary of the
    // app, and measured on the test part and on Spanish and Portuguese: gesture/test/README.md and docs/gesture-typing.md.
    // Changing one: run docs/tools/e2e/run_gesture_tests.sh; the floors there say whether words were lost.
    static final float GAMMA = 0f;                 // 0 = the probability is not divided by the length
    static final float LAMBDA_FREQ = 0.075f;       // weight of the frequency of the word
    static final float BETA = 2.9f;                // bonus per key: without it short words win over long ones
    static final float CTX = 0.066f;               // weight of the previous word
    // Pruning of the search at each step: logp / keys^GAMMA_PRUNE + BETA_PRUNE * keys; the BEAM best key sequences stay.
    // These two are the values published with the model.
    static final float GAMMA_PRUNE = 0.4234f;
    static final float BETA_PRUNE = 1.0382f;
    static final int BEAM = 200;                   // 100: 0.2 point fewer right words first; 400: 0.03 more, and the search takes 70% longer
    static final int MIN_KEYS = 2;                 // a gesture goes through at least two keys (one key is a tap)
    static final int NODE_BUDGET = 60000;          // ceiling of dictionary entries read per gesture (the most a real one read: 12,512)

    // Limits of the lib (engine/src/mr_gesture.h); they change together with it.
    static final int MAX_RESULTS = 16;             // kGestureResults
    static final int RESULT_CHARS = MrFuzzy.MAX_WORD;    // kGestureChars
    static final int INFO_SIZE = 2 + 4 * MAX_RESULTS;    // kGestureInfo
    static final int MAX_TOUCHES = 4096;           // kGestureMaxTouches
    static final int MAX_KEYS = 64;                // kGestureKeys

    /** Characters that are part of a word but not of its gesture: "don't" is drawn d-o-n-t. */
    static final char[] FREE = {'\'', '-'};

    /** The scoring values, in the order of GestureParams in engine/src/mr_gesture.h. */
    static float[] params() {
        return new float[] {GAMMA, LAMBDA_FREQ, BETA, CTX, GAMMA_PRUNE, BETA_PRUNE};
    }

    /** The limits, in the order of GestureParams in engine/src/mr_gesture.h. */
    static int[] limits() {
        return new int[] {BEAM, MIN_KEYS, NODE_BUDGET};
    }

    /** The words of one gesture, best first. One object can be reused for every gesture. */
    public static final class Result {
        final char[] words = new char[MAX_RESULTS * RESULT_CHARS];
        final int[] info = new int[INFO_SIZE];
        final float[] scores = new float[2 * MAX_RESULTS];
        int count;
        int extra;                 // bit i set: word i came from the second dictionary (the words of the person)

        /** How many words (0 to MAX_RESULTS). */
        public int count() { return count; }
        public String word(int i) { return new String(words, i * RESULT_CHARS, info[2 + 4 * i]); }
        /** The score above: only its order and the distance between two words of the same gesture mean something. */
        public float score(int i) { return scores[2 * i]; }
        /** Log-probability the network gives to the word (0 = certain). Very low on every word = the trace is no word. */
        public float logp(int i) { return scores[2 * i + 1]; }
        /** Keys the gesture went through for this word. */
        public int keys(int i) { return info[3 + 4 * i]; }
        /** Frequency of the word in the dictionary (0..255). */
        public int freq(int i) { return info[4 + 4 * i]; }
        /** Frequency of the pair with the previous word (0 = none). */
        public int bigram(int i) { return info[5 + 4 * i]; }
        /** Dictionary entries the search read (diagnostics). */
        public int visited() { return info[0]; }
        /** Was the previous word found in the dictionary with words after it? */
        public boolean hadContext() { return info[1] > 0; }
        /** Did this word come from the second dictionary, the one of the words of the person? */
        public boolean fromExtra(int i) { return (extra >> i & 1) != 0; }

        /**
         * The words without the repetitions that differ only in upper and lower case ("the" and "The" are two dictionary
         * entries and one gesture): of each group the best one stays. Fills out from 0 and returns how many.
         */
        public int distinct(String[] out) {
            int n = 0;
            for (int i = 0; i < count && n < out.length; i++) {
                String w = word(i);
                boolean seen = false;
                for (int k = 0; k < n && !seen; k++) seen = sameIgnoringCase(out[k], w);
                if (!seen) out[n++] = w;
            }
            return n;
        }
    }

    /** Equal but for upper and lower case, letter by letter, with the same table the lib uses (Character.toLowerCase). */
    static boolean sameIgnoringCase(String a, String b) {
        if (a.length() != b.length()) return false;
        for (int i = 0; i < a.length(); i++) {
            if (Character.toLowerCase(a.charAt(i)) != Character.toLowerCase(b.charAt(i))) return false;
        }
        return true;
    }

    private static final Object DECODE = new Object();   // the two native calls of one gesture go together

    private static String sPath;                  // weights file open (or opening)
    private static int sGen;                      // changes at every use(); an old open is discarded
    private static boolean sOpen;                 // the weights are open in the lib
    private static final Object NATIVE_LOAD = new Object();   // one native open at a time (the lib keeps a single file)

    /** Starts using this weights file (null = none: frees the 2.8 MB the lib holds). Does nothing if it is already the one in use. */
    static void use(final File file) {
        final String path = file != null ? file.getPath() : null;
        final int gen;
        synchronized (MrGesture.class) {
            if (path == null ? sPath == null : path.equals(sPath)) return;
            sPath = path;
            gen = ++sGen;
            sOpen = false;
        }
        if (path == null) {
            MrNative.gestureClose();
            return;
        }
        Thread t = new Thread(new Runnable() {
            public void run() {
                open(path, gen);
            }
        }, "MrGesture");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    /** Same as use(), but returns when the file is open (tests and tools). true = the lib has the weights. */
    static boolean useNow(File file) {
        use(null);   // forces the reopening even if it is the same file
        final String path = file != null ? file.getPath() : null;
        if (path == null) return false;
        final int gen;
        synchronized (MrGesture.class) {
            sPath = path;
            gen = ++sGen;
            sOpen = false;
        }
        return open(path, gen);
    }

    /** Hands the values over and opens the file in the native lib, if this call is still the current one. true = ready. */
    private static boolean open(String path, int gen) {
        synchronized (NATIVE_LOAD) {
            synchronized (MrGesture.class) {
                if (gen != sGen) return false;   // another call has taken its place: nothing to do here
            }
            if (!MrNative.gestureConfig(params(), limits()) || !MrNative.gestureOpen(path)) {
                MrNative.gestureClose();   // does not leave the previous weights open in the lib
                return false;
            }
            boolean closed;
            synchronized (MrGesture.class) {
                if (gen == sGen) {
                    sOpen = true;
                    return true;
                }
                closed = sPath == null;
            }
            // use(null) came while this was opening, and its close may have run before the open: close again
            if (closed) MrNative.gestureClose();
            return false;
        }
    }

    /** Are the weights open in the lib? */
    static synchronized boolean ready() {
        return sOpen;
    }

    /**
     * The keys a gesture can go through. keys: the letter of each key, in lowercase, none repeated (2 to MAX_KEYS); xy: x and y
     * of the centre of each key, in the frame described at the top. Call it whenever the keyboard on screen changes (language,
     * layout, size). It does not depend on the weights being open. false = refused or no lib (decode() then answers -1).
     */
    static boolean setLayout(char[] keys, float[] xy) {
        if (keys == null || xy == null || keys.length < 2 || keys.length > MAX_KEYS || xy.length < 2 * keys.length) return false;
        return MrNative.gestureLayout(keys, xy, FREE);
    }

    /**
     * The words of a gesture.
     *   dict, size: main.dict, the same buffer MrFuzzy searches (BinaryDictionary.mrBuffer(), mrLength());
     *   extra:      a second dictionary of the same format, or null: the words of the person (MrGestureWords.get()). It must be
     *               a direct buffer that holds exactly the dictionary (capacity() is its size);
     *   x, y, t:    the first n touch points, from the finger going down to the finger going up, in the frame described at the
     *               top; t in milliseconds (only the differences matter). n from 1 to MAX_TOUCHES;
     *   prev:       the word before this one in the text, or null. It is looked up in main.dict as written, in lowercase and
     *               with a capital first letter, and the first spelling the dictionary has gives the context.
     * The words of the two dictionaries come in one list, best first, with one score for both (a word both have comes once,
     * with the larger of its two scores); Result.fromExtra(i) says which ones came from the second. The network reads the trace
     * once: the second dictionary is searched with the table the first search left (MrNative.gestureMore, contract 3). The
     * words of the second dictionary get no bonus from the previous word (it has no pairs).
     * Returns how many words went to out (0 to MAX_RESULTS), or -1 if it could not answer: no lib, weights not open, no layout,
     * n out of range, a coordinate that is not a number.
     */
    static int decode(ByteBuffer dict, int size, ByteBuffer extra, float[] x, float[] y, int[] t, int n, CharSequence prev,
                      Result out) {
        if (out == null) return -1;
        out.count = 0;
        out.extra = 0;
        if (dict == null || x == null || y == null || t == null || n < 1 || n > MAX_TOUCHES || x.length < n || y.length < n
                || t.length < n) {
            return -1;
        }
        synchronized (MrGesture.class) {
            if (!sOpen) return -1;
        }
        char[] spellings = null;
        int[] lengths = null;
        final int len = prev != null ? prev.length() : 0;
        if (len > 0 && len <= MrFuzzy.MAX_WORD) {
            spellings = new char[3 * len];
            lengths = new int[] {len, len, len};
            for (int i = 0; i < len; i++) {
                final char c = prev.charAt(i);
                final char lower = Character.toLowerCase(c);
                spellings[i] = c;
                spellings[len + i] = lower;
                spellings[2 * len + i] = i == 0 ? Character.toUpperCase(c) : lower;
            }
        }
        int c;
        synchronized (DECODE) {
            c = MrNative.gesture(dict, size, n, x, y, t, spellings, lengths, out.words, out.info, out.scores);
            if (c >= 0 && extra != null && extra.isDirect() && extra.capacity() > 2) {
                final int context = out.info[1];
                // -1 leaves the arrays as they are: the words of main.dict stand
                final int both = MrNative.gestureMore(extra, extra.capacity(), null, null, out.words, out.info, out.scores);
                if (both >= 0) {
                    c = both;
                    out.extra = out.info[1];
                    out.info[1] = context;
                }
            }
        }
        out.count = c < 0 ? 0 : c;
        return c;
    }

    /** The words of a gesture, from main.dict alone. */
    static int decode(ByteBuffer dict, int size, float[] x, float[] y, int[] t, int n, CharSequence prev, Result out) {
        return decode(dict, size, null, x, y, t, n, prev, out);
    }
}
