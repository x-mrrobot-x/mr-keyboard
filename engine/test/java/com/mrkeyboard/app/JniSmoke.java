package com.mrkeyboard.app;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * JNI bridge test without the app: loads libmrengine.so, hands over tables and rules built here (with the Character of
 * Java, as the app's MrNative does), searches the real dictionary and checks bad arguments (non-direct buffer, short arrays,
 * missing file): a clean failure instead of a crash. The behaviour of the app through the lib is NOT checked here: that is the job of
 * docs/tools/e2e/StrategyTest.java (which uses the app's real classes).
 *
 * With the last two arguments it also goes through the gesture natives (contract 2): bad arguments, the weights file, and the
 * English gestures of gesture/test, which must give through the JNI the words mr_gesture_test counts in C++; and through
 * nGestureMore (contract 3), the same gesture searched in a second dictionary written here in the main.dict format, as the
 * app writes the words of the person. The app's own classes for gestures (MrGesture, MrGestureWords) are checked by
 * docs/tools/e2e/GestureTest.java and GestureInputE2E.java.
 *
 * Usage: java -cp classes_dir com.mrkeyboard.app.JniSmoke path/libmrengine.so dicts_dir [gesture/encoder.bin gesture/test]
 */
public class JniSmoke {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("FAIL: " + what); }
    }

    static char[] chars(String s, int n) {
        char[] c = new char[n];
        for (int i = 0; i < s.length() && i < n; i++) c[i] = s.charAt(i);
        return c;
    }

    public static void main(String[] a) throws Exception {
        System.load(new File(a[0]).getAbsolutePath());
        File dicts = new File(a[1]);
        check(MrNative.nVersion() == 3, "nVersion == 3");

        int[] costs = {25, 30, 35, 30, 25, 45, 75, 60, 30, 40, 45, 40, 30, 40, 35, 35, 12000};
        char[] lower = new char[65536];
        byte[] upper = new byte[65536];
        for (int i = 0; i < 65536; i++) {
            lower[i] = Character.toLowerCase((char) i);
            upper[i] = (byte) (Character.isUpperCase((char) i) ? 1 : 0);
        }
        char[] base = new char[256];
        for (int i = 0; i < 256; i++) base[i] = lower[i];
        double[] pow2 = new double[256];
        for (int i = 0; i < 256; i++) pow2[i] = Math.pow(2.0, -i / 25.0);
        check(MrNative.nInit(costs, lower, upper, base, pow2), "nInit");
        check(!MrNative.nInit(new int[3], lower, upper, base, pow2), "nInit rejects short costs");
        check(!MrNative.nInit(costs, lower, upper, base, new double[10]), "nInit rejects short power table");
        int[] bad = costs.clone();
        bad[16] = 0;   // zero node limit
        check(!MrNative.nInit(bad, lower, upper, base, pow2), "nInit rejects zero node limit");
        check(MrNative.nInit(costs, lower, upper, base, pow2), "nInit again");

        // rules: one of each kind
        byte[] pairs = new byte[65536];
        pairs[('s' << 8) | 'z'] = 1;
        pairs[('z' << 8) | 's'] = 1;
        short[] st = new short[256], any = new short[256];
        st['h'] = 30;
        boolean[] extra = new boolean[256], one = new boolean[256];
        extra['h'] = true;
        one['a'] = true;
        check(MrNative.nSetRules(pairs, chars("chx", 3), chars("ssc", 3), chars("nh", 2), new short[] {35}, st, any, extra, one), "nSetRules");

        String[] langs = {"pt-BR", "en-US", "es"};
        String[] typed = {"vda", "recieve", "ecuela"};
        String[] want = {"vida", "receive", "escuela"};
        for (int li = 0; li < langs.length; li++) {
            byte[] dictBytes = Files.readAllBytes(new File(dicts, langs[li] + "/main.dict").toPath());
            ByteBuffer dict = ByteBuffer.allocateDirect(dictBytes.length);
            dict.put(dictBytes);
            dict.rewind();
            char[] outWords = new char[5 * 98];
            int[] info = new int[11];
            long[] scores = new long[5];
            String w = typed[li];
            char[] tb = chars(w, 20);
            int c = MrNative.nSearch(dict, dictBytes.length, w.length(), tb, new char[320], new int[20], outWords, info, scores);
            boolean found = false;
            for (int i = 0; i < c; i++) if (new String(outWords, i * 98, info[1 + 2 * i]).equals(want[li])) found = true;
            check(c > 0 && c <= 5 && found, langs[li] + ": " + w + " -> " + want[li] + " through the JNI (got " + c + " results)");
            check(info[0] > 0, langs[li] + ": visited nodes reported");
            for (int i = 1; i < c; i++) check(scores[i - 1] >= scores[i], langs[li] + ": scores in order");

            String tri = new File(dicts, langs[li] + "/trigrams.bin").getAbsolutePath();
            check(MrNative.nTriOpen(tri), "nTriOpen " + langs[li]);
            String[] ow = new String[8];
            int[] os = new int[8];
            int hits = 0;
            String[][] pairsList = {{"de", "acordo"}, {"por", "causa"}, {"of", "the"}, {"in", "the"}, {"de", "la"}, {"en", "el"}, {"o", "que"}, {"it", "is"}};
            for (String[] p : pairsList) {
                Arrays.fill(ow, null);
                int n = MrNative.nTriFind(p[0], p[0], p[1], p[1], ow, os);
                check(n >= 0 && n <= 8, "trigram count within the limit");
                for (int i = 0; i < n; i++) check(ow[i] != null && !ow[i].isEmpty() && os[i] >= 0 && os[i] <= 255, "valid continuation");
                if (n > 0) hits++;
            }
            check(hits > 0, langs[li] + ": some common pair has a continuation through the JNI");
        }

        // bad arguments: clean failure, no crash
        char[] ow = new char[490];
        int[] info = new int[11];
        long[] sc = new long[5];
        char[] tb = new char[20], near = new char[320];
        int[] cnt = new int[20];
        ByteBuffer heap = ByteBuffer.allocate(1000);   // non-direct
        check(MrNative.nSearch(heap, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "non-direct buffer");
        check(MrNative.nSearch(null, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "null buffer");
        ByteBuffer small = ByteBuffer.allocateDirect(100);
        check(MrNative.nSearch(small, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "size larger than the buffer");
        check(MrNative.nSearch(small, 100, 0, tb, near, cnt, ow, info, sc) == -1, "n = 0");
        check(MrNative.nSearch(small, 100, 21, tb, near, cnt, ow, info, sc) == -1, "n = 21");
        check(MrNative.nSearch(small, 100, 3, new char[1], near, cnt, ow, info, sc) == -1, "short tb");
        check(MrNative.nSearch(small, 100, 3, tb, near, cnt, new char[10], info, sc) == -1, "short output");
        check(!MrNative.nTriOpen("/does/not/exist/trigrams.bin"), "missing file");
        check(!MrNative.nTriOpen(null), "null path");
        MrNative.nTriClose();
        check(MrNative.nTriFind("a", "a", "b", "b", new String[3], new int[3]) == 0, "closed trigrams give 0");
        check(!MrNative.nSetRules(new byte[10], new char[0], new char[0], new char[0], new short[0], new short[256],
                new short[256], new boolean[256], new boolean[256]), "rules with short table");

        gestures(dicts, a.length > 3 ? new File(a[2]) : null, a.length > 3 ? new File(a[3]) : null);

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }

    // ---- gesture typing (contracts 2 and 3)

    static final int G_RESULTS = 16, G_CHARS = 48, G_INFO = 2 + 4 * G_RESULTS, G_TOUCHES = 4096;   // mr_gesture.h
    static final float[] G_PARAMS = {0f, 0.075f, 2.9f, 0.066f, 0.4234f, 1.0382f};                  // MrGesture.params()
    static final int[] G_LIMITS = {200, 2, 60000};                                                 // MrGesture.limits()
    static final char[] G_FREE = {'\'', '-'};

    static char[] gWords = new char[G_RESULTS * G_CHARS];
    static int[] gInfo = new int[G_INFO];
    static float[] gScores = new float[2 * G_RESULTS];

    static int gesture(ByteBuffer dict, int size, float[] x, float[] y, int[] t, String prev) {
        char[] pc = prev == null ? null : (prev + prev.toLowerCase()).toCharArray();
        int[] pl = prev == null ? null : new int[] {prev.length(), prev.length()};
        return MrNative.nGesture(dict, size, x.length, x, y, t, pc, pl, gWords, gInfo, gScores);
    }

    static String gWord(int i) {
        return new String(gWords, i * G_CHARS, gInfo[2 + 4 * i]);
    }

    static final class Node {
        char c;
        int freq = -1, group;
        final List<Node> kids = new ArrayList<Node>();
    }

    /**
     * A dictionary of the main.dict format (two-byte header, groups breadth first, no pairs) with these words, in a direct
     * buffer of exactly its size: what the app makes of the words of the person (MrGestureWords.build), written again here
     * so that the lib is checked against a second writer.
     */
    static ByteBuffer smallDict(String[] words, int[] freqs) {
        Node root = new Node();
        for (int i = 0; i < words.length; i++) {
            Node cur = root;
            for (char c : words[i].toCharArray()) {
                Node next = null;
                for (Node k : cur.kids) if (k.c == c) next = k;
                if (next == null) {
                    next = new Node();
                    next.c = c;
                    cur.kids.add(next);
                }
                cur = next;
            }
            cur.freq = Math.max(cur.freq, freqs[i]);
        }
        List<Node> order = new ArrayList<Node>();
        order.add(root);
        int pos = 2;
        for (int q = 0; q < order.size(); q++) {
            Node p = order.get(q);
            if (p.kids.isEmpty()) continue;
            p.group = pos++;
            for (Node k : p.kids) {
                pos += (k.c >= 0xFF ? 3 : 1) + (k.kids.isEmpty() ? 1 : 3) + (k.freq >= 0 ? 2 : 0);
                order.add(k);
            }
        }
        ByteBuffer out = ByteBuffer.allocateDirect(pos);
        out.put(0, (byte) 200);
        out.put(1, (byte) 1);
        for (Node p : order) {
            if (p.kids.isEmpty()) continue;
            int at = p.group;
            out.put(at++, (byte) p.kids.size());
            for (Node k : p.kids) {
                if (k.c >= 0xFF) {
                    out.put(at++, (byte) 0xFF);
                    out.put(at++, (byte) (k.c >> 8));
                }
                out.put(at++, (byte) k.c);
                int flags = k.freq >= 0 ? 0x80 : 0;
                if (k.kids.isEmpty()) {
                    out.put(at++, (byte) flags);
                } else {
                    out.put(at++, (byte) (flags | 0x40 | (k.group >> 16)));
                    out.put(at++, (byte) (k.group >> 8));
                    out.put(at++, (byte) k.group);
                }
                if (k.freq >= 0) {
                    out.put(at++, (byte) k.freq);
                    out.put(at++, (byte) 0);
                }
            }
        }
        return out;
    }

    static int more(ByteBuffer d) {
        return MrNative.nGestureMore(d, d.capacity(), null, null, gWords, gInfo, gScores);
    }

    /** The merged list of nGestureMore: in order by score, lengths in range, and a word of the second dictionary never twice. */
    static boolean merged(int c) {
        if (c < 0 || c > G_RESULTS) return false;
        for (int i = 0; i < c; i++) {
            int len = gInfo[2 + 4 * i];
            if (len < 1 || len > G_CHARS || Float.isNaN(gScores[2 * i])) return false;
            if (i > 0 && gScores[2 * (i - 1)] < gScores[2 * i]) return false;
            if ((gInfo[1] >> i & 1) == 0) continue;
            for (int k = 0; k < c; k++) if (k != i && gWord(k).equalsIgnoreCase(gWord(i))) return false;
        }
        return (gInfo[1] >>> c) == 0;      // no bit beyond the results
    }

    static void gestures(File dicts, File weights, File data) throws Exception {
        byte[] dictBytes = Files.readAllBytes(new File(dicts, "en-US/main.dict").toPath());
        ByteBuffer dict = ByteBuffer.allocateDirect(dictBytes.length);
        dict.put(dictBytes);
        dict.rewind();
        final int size = dictBytes.length;
        float[] x = {0.60f, 0.55f, 0.45f, 0.30f, 0.25f}, y = {0.5f, 0.45f, 0.35f, 0.2f, 0.17f};
        int[] t = {0, 16, 32, 48, 64};
        char[] keys = "qwertyuiopasdfghjklzxcvbnm".toCharArray();
        float[] xy = new float[52];
        for (int i = 0; i < 26; i++) {
            int row = i < 10 ? 0 : i < 19 ? 1 : 2, col = i < 10 ? i : i < 19 ? i - 10 : i - 19;
            xy[2 * i] = (col + 0.5f + (row == 0 ? 0f : row == 1 ? 0.5f : 1.5f)) / 10f;
            xy[2 * i + 1] = (row + 0.5f) / 3f;
        }

        // nothing handed over yet: every piece is needed, and each refusal is clean
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture before anything is set: -1");
        check(!MrNative.nGestureConfig(null, G_LIMITS) && !MrNative.nGestureConfig(G_PARAMS, null), "nGestureConfig rejects null");
        check(!MrNative.nGestureConfig(new float[5], G_LIMITS) && !MrNative.nGestureConfig(G_PARAMS, new int[2]), "nGestureConfig rejects short arrays");
        float[] nan = G_PARAMS.clone();
        nan[2] = Float.NaN;
        check(!MrNative.nGestureConfig(nan, G_LIMITS), "nGestureConfig rejects NaN");
        check(!MrNative.nGestureConfig(G_PARAMS, new int[] {0, 2, 60000}), "nGestureConfig rejects beam 0");
        check(!MrNative.nGestureConfig(G_PARAMS, new int[] {200, 2, 100000000}), "nGestureConfig rejects an absurd node limit");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture after refused values: -1");
        check(MrNative.nGestureConfig(G_PARAMS, G_LIMITS), "nGestureConfig");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture without weights: -1");
        final ByteBuffer own = smallDict(new String[] {"heee", "Hello", "zzz"}, new int[] {255, 100, 100});
        check(more(own) == -1, "second dictionary without weights: -1");

        check(!MrNative.nGestureLayout(null, xy, G_FREE) && !MrNative.nGestureLayout(keys, null, G_FREE), "nGestureLayout rejects null");
        check(!MrNative.nGestureLayout(new char[] {'a'}, xy, G_FREE), "nGestureLayout rejects one key");
        check(!MrNative.nGestureLayout(keys, new float[51], G_FREE), "nGestureLayout rejects short centres");
        check(!MrNative.nGestureLayout(new char[65], new float[130], G_FREE), "nGestureLayout rejects 65 keys");
        check(!MrNative.nGestureLayout(keys, xy, new char[9]), "nGestureLayout rejects 9 free characters");
        check(!MrNative.nGestureLayout("qwertyuiopasdfghjklzxcvbnq".toCharArray(), xy, G_FREE), "nGestureLayout rejects a repeated key");
        float[] bad = xy.clone();
        bad[7] = Float.NaN;
        check(!MrNative.nGestureLayout(keys, bad, G_FREE), "nGestureLayout rejects a NaN centre");
        check(MrNative.nGestureLayout(keys, xy, null), "nGestureLayout with no free characters (null)");
        check(MrNative.nGestureLayout(keys, xy, new char[0]), "nGestureLayout with no free characters (empty)");
        check(MrNative.nGestureLayout(keys, xy, G_FREE), "nGestureLayout");

        check(!MrNative.nGestureOpen(null), "nGestureOpen rejects null");
        check(!MrNative.nGestureOpen("/does/not/exist/encoder.bin"), "nGestureOpen: missing file");
        check(!MrNative.nGestureOpen(dicts.getAbsolutePath()), "nGestureOpen: a folder");
        check(!MrNative.nGestureOpen(new File(dicts, "en-US/main.dict").getAbsolutePath()), "nGestureOpen: a file that is not weights");
        check(!MrNative.nGestureOpen(new File(dicts, "en-US/trigrams.bin").getAbsolutePath()), "nGestureOpen: another file that is not weights");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture after refused weights: -1");
        MrNative.nGestureClose();   // closing what is not open does nothing
        if (weights == null) {
            System.out.println("gesture natives: bad arguments only (no weights file given)");
            return;
        }
        check(MrNative.nGestureOpen(weights.getAbsolutePath()), "nGestureOpen " + weights);

        // the output of one gesture
        int c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);
        check(c >= 1 && c <= G_RESULTS, "a short stroke from h to e gives words through the JNI (got " + c + ")");
        check(gInfo[0] > 0 && gInfo[1] == 0, "dictionary entries read reported, no context");
        boolean shape = true;
        for (int i = 0; i < c; i++) {
            int len = gInfo[2 + 4 * i], keysUsed = gInfo[3 + 4 * i], freq = gInfo[4 + 4 * i], bigram = gInfo[5 + 4 * i];
            if (len < 1 || len > G_CHARS || keysUsed < 2 || keysUsed > 48 || freq < 0 || freq > 255 || bigram != 0) shape = false;
            if (Float.isNaN(gScores[2 * i]) || !(gScores[2 * i + 1] <= 0f)) shape = false;
            if (i > 0 && gScores[2 * (i - 1)] < gScores[2 * i]) shape = false;
            for (int k = 0; k < len; k++) if (gWords[i * G_CHARS + k] == 0) shape = false;
        }
        check(shape, "lengths, keys, frequencies, scores in order, log-probabilities not above 0");
        String first = gWord(0);
        check(first.equalsIgnoreCase("he"), "the stroke from h to e gives he first (got " + first + ")");

        // the same gesture in a second dictionary (contract 3): its words join the list, by score
        final int nodes1 = gInfo[0];
        final String[] alone = new String[c];
        for (int i = 0; i < c; i++) alone[i] = gWord(i);
        int m = more(own);
        int at = -1;
        for (int i = 0; i < m; i++) if (gWord(i).equals("heee")) at = i;
        // "heee" is h, e (a doubled letter is passed over once): the stroke writes it; "Hello" and "zzz" it does not
        check(m >= 1 && merged(m) && at >= 0 && gInfo[1] == 1 << at && gInfo[4 + 4 * at] == 255, "second dictionary: its word joins the list and is marked (got " + m + ", at " + at + ", mask " + gInfo[1] + ")");
        check(gInfo[0] > nodes1, "second dictionary: the entries read count both searches");
        boolean kept = true;
        for (int i = 0, k = 0; i < m; i++) {
            if (i == at) continue;
            while (k < c && !alone[k].equals(gWord(i))) k++;
            if (k == c) kept = false;
        }
        check(kept, "second dictionary: the words of main.dict keep their order");
        check(more(smallDict(new String[] {"hEEe"}, new int[] {1})) == m && gInfo[1] == 1 << at && gWord(at).equals("heee"), "second dictionary: the same word again with a lower score changes nothing");
        // the same word main.dict has, in another spelling and with the highest frequency: one of the two stays
        c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);
        m = more(smallDict(new String[] {"HE"}, new int[] {255}));
        int he = 0;
        for (int i = 0; i < m; i++) if (gWord(i).equalsIgnoreCase("he")) he++;
        check(m >= 1 && m <= c && merged(m) && he >= 1, "second dictionary: a word of main.dict in another spelling does not come twice (" + he + ")");
        // bad arguments: -1 and the arrays untouched
        c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);
        final int[] infoBefore = gInfo.clone();
        final char[] wordsBefore = gWords.clone();
        ByteBuffer heapOwn = ByteBuffer.allocate(100);
        check(MrNative.nGestureMore(heapOwn, 100, null, null, gWords, gInfo, gScores) == -1, "second dictionary: non-direct buffer");
        check(MrNative.nGestureMore(null, 100, null, null, gWords, gInfo, gScores) == -1, "second dictionary: null buffer");
        check(MrNative.nGestureMore(own, own.capacity() + 1, null, null, gWords, gInfo, gScores) == -1, "second dictionary: size larger than the buffer");
        check(MrNative.nGestureMore(own, 2, null, null, gWords, gInfo, gScores) == -1 && MrNative.nGestureMore(own, 0, null, null, gWords, gInfo, gScores) == -1
                && MrNative.nGestureMore(own, -5, null, null, gWords, gInfo, gScores) == -1, "second dictionary: sizes 2, 0 and -5");
        check(MrNative.nGestureMore(own, own.capacity(), null, null, new char[100], gInfo, gScores) == -1, "second dictionary: short word output");
        check(MrNative.nGestureMore(own, own.capacity(), null, null, gWords, new int[G_INFO - 1], gScores) == -1, "second dictionary: short info output");
        check(MrNative.nGestureMore(own, own.capacity(), null, null, gWords, gInfo, null) == -1, "second dictionary: null score output");
        check(MrNative.nGestureMore(own, own.capacity(), "he".toCharArray(), new int[] {3}, gWords, gInfo, gScores) == -1, "second dictionary: previous word longer than its array");
        check(Arrays.equals(infoBefore, gInfo) && Arrays.equals(wordsBefore, gWords), "second dictionary: a refused call leaves the arrays as they were");
        final int again = more(own);
        check(again >= 1 && merged(again) && gInfo[1] != 0, "second dictionary: and the table is still there for a good call");
        // garbage instead of a dictionary: an answer within the limits, never a crash
        java.util.Random junk = new java.util.Random(11);
        boolean junkOk = true;
        for (int round = 0; round < 20; round++) {
            byte[] d = new byte[3 + junk.nextInt(4000)];
            junk.nextBytes(d);
            if (round % 2 == 0) { d[0] = (byte) 200; d[1] = 1; }
            ByteBuffer db = ByteBuffer.allocateDirect(d.length);
            db.put(d);
            db.rewind();
            c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);
            int r = more(db);
            if (c < 1 || r < 1 || !merged(r) || gInfo[0] > 2 * (60000 + 256)) junkOk = false;
        }
        check(junkOk, "second dictionary: 20 buffers of garbage answered within the limits");
        // the table goes with the layout, the weights and the last gesture
        check(MrNative.nGestureLayout(keys, xy, G_FREE) && more(own) == -1, "second dictionary: after a new layout there is no gesture to search: -1");
        c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);
        check(c >= 1 && MrNative.nGesture(dict, size, 0, x, y, t, null, null, gWords, gInfo, gScores) == -1 && more(own) >= 1, "second dictionary: a call refused before the lib is reached keeps the last gesture");
        float[] nanX = x.clone();
        nanX[1] = Float.NaN;
        check(MrNative.nGesture(dict, size, 5, nanX, y, t, null, null, gWords, gInfo, gScores) == -1 && more(own) == -1, "second dictionary: a gesture the lib refused leaves none: -1");
        c = MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores);

        // bad arguments: clean failure, no crash
        ByteBuffer heap = ByteBuffer.allocate(1000);   // non-direct
        ByteBuffer small = ByteBuffer.allocateDirect(100);
        check(MrNative.nGesture(heap, 1000, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: non-direct buffer");
        check(MrNative.nGesture(null, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: null buffer");
        check(MrNative.nGesture(small, 1000, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: size larger than the buffer");
        check(MrNative.nGesture(small, 2, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: 2-byte dictionary");
        check(MrNative.nGesture(dict, size, 0, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: n = 0");
        check(MrNative.nGesture(dict, size, -1, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: n = -1");
        check(MrNative.nGesture(dict, size, 6, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: n larger than the arrays");
        check(MrNative.nGesture(dict, size, G_TOUCHES + 1, new float[5000], new float[5000], new int[5000], null, null, gWords, gInfo, gScores) == -1, "gesture: too many points");
        check(MrNative.nGesture(dict, size, 5, null, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: null x");
        check(MrNative.nGesture(dict, size, 5, x, new float[4], t, null, null, gWords, gInfo, gScores) == -1, "gesture: short y");
        check(MrNative.nGesture(dict, size, 5, x, y, null, null, null, gWords, gInfo, gScores) == -1, "gesture: null times");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, new char[100], gInfo, gScores) == -1, "gesture: short word output");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, new int[G_INFO - 1], gScores) == -1, "gesture: short info output");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, new float[31]) == -1, "gesture: short score output");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, null, gInfo, gScores) == -1, "gesture: null output");
        float[] xn = x.clone();
        xn[3] = Float.NaN;
        check(MrNative.nGesture(dict, size, 5, xn, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture: NaN coordinate");
        xn[3] = Float.POSITIVE_INFINITY;
        check(MrNative.nGesture(dict, size, 5, x, xn, t, null, null, gWords, gInfo, gScores) == -1, "gesture: infinite coordinate");
        char[] of = {'o', 'f'};
        check(MrNative.nGesture(dict, size, 5, x, y, t, of, new int[] {-1}, gWords, gInfo, gScores) == -1, "gesture: negative length of the previous word");
        check(MrNative.nGesture(dict, size, 5, x, y, t, of, new int[] {3}, gWords, gInfo, gScores) == -1, "gesture: previous word longer than its array");
        check(MrNative.nGesture(dict, size, 5, x, y, t, of, new int[] {2, 1}, gWords, gInfo, gScores) == -1, "gesture: spellings longer than their array");
        check(MrNative.nGesture(dict, size, 5, x, y, t, new char[600], new int[] {600}, gWords, gInfo, gScores) == -1, "gesture: absurd previous word");
        // accepted forms of "no previous word" and of a previous word
        check(MrNative.nGesture(dict, size, 5, x, y, t, of, null, gWords, gInfo, gScores) == c && gInfo[1] == 0, "gesture: previous word without lengths = none");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, new int[] {2}, gWords, gInfo, gScores) == c && gInfo[1] == 0, "gesture: lengths without previous word = none");
        check(MrNative.nGesture(dict, size, 5, x, y, t, new char[0], new int[0], gWords, gInfo, gScores) == c && gInfo[1] == 0, "gesture: empty previous word = none");
        check(MrNative.nGesture(dict, size, 5, x, y, t, of, new int[] {0, 2}, gWords, gInfo, gScores) >= 1 && gInfo[1] > 0, "gesture: the second spelling of the previous word is found");
        check(MrNative.nGesture(dict, size, 5, x, y, t, "zzqzz".toCharArray(), new int[] {5}, gWords, gInfo, gScores) == c && gInfo[1] == 0, "gesture: a previous word the dictionary does not have = none");
        check(MrNative.nGesture(dict, size, 5, x, y, t, "ofofofofofofof".toCharArray(), new int[] {3, 3, 3, 3, 2}, gWords, gInfo, gScores) == c && gInfo[1] == 0,
                "gesture: only the first four spellings are tried");
        // a corrupt dictionary through the JNI: an answer or -1, never a crash
        java.util.Random rnd = new java.util.Random(7);
        boolean sane = true;
        for (int round = 0; round < 20; round++) {
            byte[] d = dictBytes.clone();
            if (round % 2 == 0) for (int k = 0; k < 200; k++) d[rnd.nextInt(4096)] = (byte) rnd.nextInt(256);
            else rnd.nextBytes(d);
            int cut = round % 4 == 3 ? 3 + rnd.nextInt(d.length - 3) : d.length;
            ByteBuffer db = ByteBuffer.allocateDirect(d.length);
            db.put(d);
            db.rewind();
            int r = MrNative.nGesture(db, cut, 5, x, y, t, of, new int[] {2}, gWords, gInfo, gScores);
            if (r < 0 || r > G_RESULTS || gInfo[0] > 60000 + 256) sane = false;
            for (int i = 0; i < r; i++) if (gInfo[2 + 4 * i] < 1 || gInfo[2 + 4 * i] > G_CHARS) sane = false;
        }
        check(sane, "gesture: 20 corrupt dictionaries answered within the limits");

        // close and open again: the layout stays, the answer is the same
        MrNative.nGestureClose();
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture after close: -1");
        check(more(own) == -1, "second dictionary after close: -1");
        MrNative.nGestureClose();
        check(MrNative.nGestureOpen(weights.getAbsolutePath()), "nGestureOpen again");
        check(more(own) == -1, "second dictionary after open, before a gesture: -1");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == c && gWord(0).equals(first), "same answer after close and open, with the layout set before");
        check(!MrNative.nGestureLayout(keys, bad, G_FREE), "a refused layout");
        check(MrNative.nGesture(dict, size, 5, x, y, t, null, null, gWords, gInfo, gScores) == -1, "gesture after a refused layout: -1 (it leaves none)");

        // the real gestures of the test data, through the JNI
        List<String> lines = Files.readAllLines(new File(data, "gestures_en-US.tsv").toPath(), StandardCharsets.UTF_8);
        List<String> wordList = new ArrayList<String>(), prevList = new ArrayList<String>();
        List<float[]> xs = new ArrayList<float[]>(), ys = new ArrayList<float[]>();
        List<int[]> ts = new ArrayList<int[]>();
        boolean layoutSet = false;
        for (String line : lines) {
            if (line.isEmpty() || line.startsWith("#")) continue;
            if (line.startsWith("@keys")) {
                String[] p = line.trim().split(" +");
                int n = (p.length - 1) / 3;
                char[] k = new char[n];
                float[] kxy = new float[2 * n];
                for (int i = 0; i < n; i++) {
                    k[i] = p[1 + 3 * i].charAt(0);
                    kxy[2 * i] = Float.parseFloat(p[2 + 3 * i]);
                    kxy[2 * i + 1] = Float.parseFloat(p[3 + 3 * i]);
                }
                layoutSet = MrNative.nGestureLayout(k, kxy, G_FREE);
                continue;
            }
            String[] f = line.split("\t", -1);
            String[] p = f[2].trim().split(" +");
            int n = p.length / 3;
            float[] gx = new float[n], gy = new float[n];
            int[] gt = new int[n];
            for (int i = 0; i < n; i++) {
                gx[i] = Float.parseFloat(p[3 * i]);
                gy[i] = Float.parseFloat(p[3 * i + 1]);
                gt[i] = (int) Double.parseDouble(p[3 * i + 2]);
            }
            wordList.add(f[0]);
            prevList.add(f[1]);
            xs.add(gx);
            ys.add(gy);
            ts.add(gt);
        }
        check(layoutSet && wordList.size() == 300, "gestures_en-US.tsv: layout and 300 gestures (got " + wordList.size() + ")");
        int first1 = 0, first3 = 0, withContext = 0, answered = 0;
        long t0 = System.nanoTime();
        for (int g = 0; g < wordList.size(); g++) {
            String prev = prevList.get(g).isEmpty() ? null : prevList.get(g);
            int r = gesture(dict, size, xs.get(g), ys.get(g), ts.get(g), prev);
            if (r >= 0) answered++;
            if (gInfo[1] > 0) withContext++;
            List<String> seen = new ArrayList<String>();   // words that differ only in upper and lower case count once
            for (int i = 0; i < r && seen.size() < 3; i++) {
                String w = gWord(i).toLowerCase();
                if (seen.contains(w)) continue;
                seen.add(w);
                if (w.equals(wordList.get(g).toLowerCase())) {
                    if (seen.size() == 1) first1++;
                    first3++;
                    break;
                }
            }
        }
        double ms = (System.nanoTime() - t0) / 1e6 / wordList.size();
        System.out.printf("gestures through the JNI (en-US): %d gestures, %d answered, %d with previous word; right word first in %d, among 3 in %d; %.2f ms per gesture%n",
                wordList.size(), answered, withContext, first1, first3, ms);
        check(answered == wordList.size(), "every gesture answered through the JNI");
        // mr_gesture_test counts 256 and 272 for the same file with the letter tables of its own, and so does this; the floors
        // are the ones of mr_gesture_test.cpp
        check(first1 >= G_FIRST && first3 >= G_AMONG3, "en-US gestures through the JNI: at least " + G_FIRST + " first and " + G_AMONG3 + " among 3 (got " + first1 + " and " + first3 + ")");
        check(withContext > 200, "the previous word is found in most gestures (" + withContext + ")");

        // the same gestures with a second dictionary that has every word of the file (frequency 100, as the app gives a word it
        // has just learned): the words main.dict lacks now come out and the others keep their place
        List<String> ownWords = new ArrayList<String>();
        for (String w : wordList) if (!ownWords.contains(w.toLowerCase())) ownWords.add(w.toLowerCase());
        int[] ownFreqs = new int[ownWords.size()];
        Arrays.fill(ownFreqs, 100);
        final ByteBuffer all = smallDict(ownWords.toArray(new String[0]), ownFreqs);
        int both1 = 0, both3 = 0, wrong = 0, marked = 0;
        t0 = System.nanoTime();
        for (int g = 0; g < wordList.size(); g++) {
            String prev = prevList.get(g).isEmpty() ? null : prevList.get(g);
            int r = gesture(dict, size, xs.get(g), ys.get(g), ts.get(g), prev);
            final int context = gInfo[1];
            int r2 = more(all);
            if (r < 0 || r2 < r - 1 || !merged(r2)) wrong++;
            List<String> seen = new ArrayList<String>();
            for (int i = 0; i < r2; i++) {
                String w = gWord(i).toLowerCase();
                if ((gInfo[1] >> i & 1) != 0) {
                    marked++;
                    if (!ownWords.contains(w)) wrong++;     // a marked word is a word of the second dictionary
                }
                if (seen.contains(w) || seen.size() >= 3) continue;
                seen.add(w);
                if (w.equals(wordList.get(g).toLowerCase())) {
                    if (seen.size() == 1) both1++;
                    both3++;
                }
            }
            if (context < 0) wrong++;
        }
        ms = (System.nanoTime() - t0) / 1e6 / wordList.size();
        System.out.printf("the same gestures with a second dictionary of %d words (%d bytes): right word first in %d, among 3 in %d; %d words came from it; %.2f ms per gesture%n",
                ownWords.size(), all.capacity(), both1, both3, marked, ms);
        check(wrong == 0, "second dictionary: every merged list is valid and its marks are right (" + wrong + " wrong)");
        check(both1 >= G_BOTH_FIRST && both3 >= G_BOTH_AMONG3, "en-US gestures with the second dictionary: at least " + G_BOTH_FIRST + " first and " + G_BOTH_AMONG3
                + " among 3 (got " + both1 + " and " + both3 + ")");
        MrNative.nGestureClose();
    }

    static final int G_FIRST = 254, G_AMONG3 = 270;   // measured: 256 and 272
    static final int G_BOTH_FIRST = 274, G_BOTH_AMONG3 = 291;   // measured: 276 and 293 (the 17 words main.dict lacks, and a few it has with a low frequency)
}
