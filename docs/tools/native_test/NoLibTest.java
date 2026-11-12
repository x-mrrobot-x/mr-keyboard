package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
* Native engine (1.77; the only search since 1.87.0): the app on a device whose libmrengine.so does not load must not crash. This test runs in
* CI, where the lib does not exist (java.library.path without it), with the real dictionary (dicts/pt-BR):
*   - MrNative says it is not ready and never throws (ready, preload, search, triOpen);
*   - MrFuzzy.search answers "no results" (the keyboard keeps typing and completing words, it only loses the correction by search);
*   - MrTrigram opens nothing and find() answers 0 (the prediction goes on with the bigrams of the dictionary);
*   - MrGesture (the recognition of gesture typing, contract 2 of the lib) opens nothing and decode() answers -1.
* With the lib present (PC) the same code is checked by StrategyTest, E2E* and the evaluators.
* Runs at the project root (needs dicts/pt-BR/main.dict, rules.txt and trigrams.bin, and gesture/encoder.bin).
 */
public class NoLibTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) fails++;
        System.out.println((ok ? "OK    " : "FAIL  ") + what);
    }

    static final String[] ROWS = {"qwertyuiop", "asdfghjklç", "zxcvbnm"};

    static int[] codesFor(char c) {
        int[] out = new int[16];
        Arrays.fill(out, -1);
        out[0] = c;
        int n = 1;
        for (int r = 0; r < 3; r++) {
            int k = ROWS[r].indexOf(c);
            if (k < 0) continue;
            int[][] nb = {{r, k - 1}, {r, k + 1}, {r - 1, k}, {r - 1, k + 1}, {r + 1, k - 1}, {r + 1, k}};
            for (int[] p : nb) {
                if (p[0] < 0 || p[0] > 2 || p[1] < 0 || p[1] >= ROWS[p[0]].length()) continue;
                out[n++] = ROWS[p[0]].charAt(p[1]);
            }
        }
        return out;
    }

    static WordComposer compose(String w) {
        WordComposer wc = new WordComposer();
        for (int i = 0; i < w.length(); i++) wc.add(w.charAt(i), codesFor(w.charAt(i)));
        return wc;
    }

    static String top(MrFuzzy f, String typed) {
        f.search(compose(typed), typed);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < f.resultCount(); i++) sb.append(f.resultWord(i)).append(' ');
        return sb.toString().trim();
    }

    public static void main(String[] a) throws Exception {
        File dir = new File("dicts/pt-BR");
        byte[] bytes = Files.readAllBytes(new File(dir, "main.dict").toPath());
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));

        // 1) without the lib: it does not load, does not throw
        boolean threw = false;
        boolean ready = true;
        try {
            MrNative.preload();
            ready = MrNative.ready();   // waits for the background load
        } catch (Throwable e) {
            threw = true;
        }
        check(!threw, "MrNative.preload()/ready() without the lib do not throw");
        check(!ready, "without the lib the native engine is not ready (the test runs without libmrengine.so on java.library.path)");
        check(MrNative.search(buf, bytes.length, 3, new char[20], new char[320], new int[20], MrRules.get(),
                new char[490], new int[11], new long[5]) == -1, "search without the lib returns -1");
        check(!MrNative.triOpen(new File(dir, "trigrams.bin").getPath()), "triOpen without the lib returns false");

        // 2) the correction search has no results, and nothing breaks
        MrFuzzy f = new MrFuzzy(buf, bytes.length);
        String[] typos = {"vda", "sepre", "durate", "prte", "agoa", "obrigdo", "porisso"};
        for (String t : typos) {
            String got = top(f, t);
            check(got.isEmpty(), "no results for " + t + " without the lib   [" + got + "]");
        }
        check(f.ownFrequency("casa") > 0, "the dictionary lookup (valid word) does not depend on the lib");

        // 3) trigrams: nothing opens, find answers 0
        File tri = new File(dir, "trigrams.bin");
        check(!MrTrigram.useNow(tri), "trigrams do not open without the lib");
        check(!MrTrigram.ready(), "MrTrigram is not ready without the lib");
        String[] w = new String[3];
        int[] s = new int[3];
        check(MrTrigram.find("de", "acordo", w, s) == 0, "MrTrigram.find answers 0 without the lib");
        MrTrigram.use(null);

        // 4) gesture typing: the weights do not open, decode answers -1, nothing throws
        File gw = new File("gesture/encoder.bin");
        check(gw.isFile(), "gesture/encoder.bin is there (the test must fail for the missing lib, not for a missing file)");
        MrGesture.Result gr = new MrGesture.Result();
        float[] gx = {0.1f, 0.3f, 0.5f}, gy = {0.5f, 0.4f, 0.2f};
        int[] gt = {0, 50, 100};
        char[] gkeys = "qwertyuiopasdfghjklzxcvbnm".toCharArray();
        float[] gxy = new float[52];
        for (int i = 0; i < 26; i++) { gxy[2 * i] = (i % 10 + 0.5f) / 10f; gxy[2 * i + 1] = (i / 10 + 0.5f) / 3f; }
        boolean gThrew = false, gOpened = true, gLaid = true;
        int gCount = 0;
        try {
            gOpened = MrGesture.useNow(gw);
            gLaid = MrGesture.setLayout(gkeys, gxy);
            gCount = MrGesture.decode(buf, bytes.length, gx, gy, gt, 3, "de", gr);
            MrGesture.use(gw);     // the background open fails quietly
            Thread.sleep(200);
            MrGesture.use(null);
        } catch (Throwable e) {
            gThrew = true;
        }
        check(!gThrew, "MrGesture without the lib does not throw (useNow, setLayout, decode, use)");
        check(!gOpened && !MrGesture.ready(), "the gesture weights do not open without the lib");
        check(!gLaid, "MrGesture.setLayout without the lib returns false");
        check(gCount == -1 && gr.count() == 0, "MrGesture.decode without the lib returns -1 and no words");
        check(!MrNative.gestureOpen(gw.getPath()) && !MrNative.gestureConfig(MrGesture.params(), MrGesture.limits())
                && !MrNative.gestureLayout(gkeys, gxy, MrGesture.FREE), "the gesture calls of MrNative return false without the lib");
        check(MrNative.gesture(buf, bytes.length, 3, gx, gy, gt, null, null, new char[MrGesture.MAX_RESULTS * MrGesture.RESULT_CHARS],
                new int[MrGesture.INFO_SIZE], new float[2 * MrGesture.MAX_RESULTS]) == -1, "MrNative.gesture without the lib returns -1");
        MrNative.gestureClose();

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
