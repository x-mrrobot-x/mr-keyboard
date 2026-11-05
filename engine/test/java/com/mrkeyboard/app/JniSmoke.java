package com.mrkeyboard.app;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.util.Arrays;

/**
 * JNI bridge test without the app: loads libmrengine.so, hands over tables and rules built here (with the Character of
 * Java, as the app's MrNative does), searches the real dictionary and checks bad arguments (non-direct buffer, short arrays,
 * missing file): a clean failure instead of a crash. A result exactly equal to Java's is NOT checked here: that is the job of
 * docs/tools/e2e/NativeParity.java (which uses the app's real classes).
 *
 * Usage: java -cp classes_dir com.mrkeyboard.app.JniSmoke path/libmrengine.so dicts_dir
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
        check(MrNative.nVersion() == 1, "nVersion == 1");

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

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
