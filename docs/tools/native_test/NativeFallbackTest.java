package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
* Native engine (1.77): the app without libmrengine.so must work the same as 1.76. This test runs in CI, where the lib
* does not exist, and proves the Java fallback with the real dictionary and trigrams (dicts/pt-BR):
*   - the lib does not load and MrNative says it is not ready, without throwing anything;
*   - MrFuzzy.search gives the usual corrections;
*   - MrTrigram.use() loads through the Java path and find() answers;
*   - a search with the lib turned off (-Dmr.native=off) and with sForceJava give the same.
* With the lib present (PC) the parity test is docs/tools/e2e/NativeParity.java.
* Runs at the project root (needs dicts/pt-BR/main.dict, rules.txt and trigrams.bin).
 */
public class NativeFallbackTest {
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
            ready = MrNative.ready();
        } catch (Throwable e) {
            threw = true;
        }
        check(!threw, "MrNative.ready() without the lib does not throw");
        check(!ready, "without the lib the native engine is not ready (the test runs without libmrengine.so on java.library.path)");
        check(MrNative.search(buf, bytes.length, 3, new char[20], new char[320], new int[20], MrRules.get(),
                new char[490], new int[11], new long[5]) == -1, "search without the lib returns -1");
        check(!MrNative.triOpen(new File(dir, "trigrams.bin").getPath()), "triOpen without the lib returns false");

        // 2) correction through Java
        MrFuzzy f = new MrFuzzy(buf, bytes.length);
        String[][] cases = {{"vda", "vida"}, {"sepre", "sempre"}, {"durate", "durante"}, {"prte", "parte"}, {"agoa", "agora"},
            {"obrigdo", "obrigado"}, {"porisso", "por isso"}};
        for (String[] c : cases) {
            String got = top(f, c[0]);
            // words separated by a space; "por isso" is a single suggestion, so it is matched with the spaces at the ends
            check((" " + got + " ").contains(" " + c[1] + " "), "Java corrects " + c[0] + " -> " + c[1] + "   [" + got + "]");
        }

        // 3) turning it off on purpose gives the same result
        String base = top(f, "obrigdo");
        MrNative.sForceJava = true;
        check(top(f, "obrigdo").equals(base), "sForceJava does not change the result");
        MrNative.sForceJava = false;

        // 4) trigrams through Java, through the production path (use + thread)
        File tri = new File(dir, "trigrams.bin");
        MrTrigram.use(tri);
        long end = System.currentTimeMillis() + 20000;
        while (!MrTrigram.ready() && System.currentTimeMillis() < end) Thread.sleep(50);
        check(MrTrigram.ready(), "trigrams load through Java when the lib does not open the file");
        // a context that exists in the file: first entry of any pair with a continuation
        String[] w = new String[3];
        int[] s = new int[3];
        int found = 0;
        String[][] pairs = {{"de", "acordo"}, {"por", "causa"}, {"no", "entanto"}, {"em", "relação"}, {"de", "forma"}, {"a", "partir"},
            {"não", "é"}, {"o", "que"}, {"é", "um"}, {"que", "o"}};
        for (String[] p : pairs) if (MrTrigram.find(p[0], p[1], w, s) > 0) found++;
        check(found > 0, "MrTrigram.find answers through Java (" + found + " of " + pairs.length + " pairs with a continuation)");
        MrTrigram.use(null);
        check(!MrTrigram.ready(), "use(null) unloads");

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
