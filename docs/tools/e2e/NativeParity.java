package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
* Parity of the native engine (v1.77): for each word of the lists, the MrFuzzy correction search runs through the
* Java path and the C++ path (libmrengine.so, through JNI) and both must give the SAME result: same words,
* same order, same score, same cost and the same number of visited nodes. Then it compares the final list
* of Suggest.getSuggestions (what the strip shows) and measures the time of both paths.
 *
* It also checks the trigrams: MrTrigram.find through Java and through the lib, for the pairs of -Dpairs.
* The queries come from the dictionary itself: engine/tools/gen_parity_queries.py (docs/tools/e2e/run_native_parity.sh does it all).
 *
* Usage: java -Djava.library.path=<lib folders> -cp ... com.mrkeyboard.app.NativeParity dictionary.dict typos.tsv [trigrams.bin]
*   -Dlimit=N  only the first N lines;  -Dpairs=file.txt  "w1 w2" lines for the trigram pairs
*   -Drows=...  layout of the neighbouring keys;  -Dshow=20  shows up to 20 differences;  -Drounds=1  a single round (default 2: the 2nd measures the time)
*   -Dsuggmax=N  how many words go through the full Suggest (default 4000)
* Exits with code 1 if there is any difference (or if the lib does not load).
 */
public class NativeParity {
    static String render(MrFuzzy f) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < f.resultCount(); i++) {
            sb.append(f.resultWord(i)).append('|').append(f.resultScore(i)).append('|').append(f.resultCost(i)).append(';');
        }
        sb.append("v=").append(MrFuzzy.sLastVisits);
        return sb.toString();
    }

    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        String rowsProp = System.getProperty("rows");
        if (rowsProp != null) {
            String[] r = rowsProp.split(",");
            for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i];
        }
        MrNative.sForceJava = false;
        if (!MrNative.ready()) {
            System.out.println("FAIL: the native lib did not load (java.library.path, contract version or mr.native=off)");
            System.exit(1);
        }
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        MrFuzzy f = new MrFuzzy(buf, bytes.length);

        int limit = Integer.getInteger("limit", Integer.MAX_VALUE);
        int show = Integer.getInteger("show", 10);
        LinkedHashSet<String> words = new LinkedHashSet<String>();
        List<String> lines = Files.readAllLines(Paths.get(a[1]));
        for (String line : lines) {
            if (words.size() >= limit) break;
            String[] p = line.split("\t");
            if (p[0].length() >= 2) words.add(p[0]);
            if (p.length > 1 && p[1].length() >= 2) words.add(p[1]);
            // word starts (typing correctly): 2 to 5 letters
            for (int k = 2; k <= 5 && k < p[0].length(); k++) words.add(p[0].substring(0, k));
        }
        // edge cases: uppercase, accent, 1 letter, maximum size, only consonants, repeated
        String[] edge = {"Casa", "CASA", "ÁGUA", "coração", "ação", "ç", "a", "aa", "aaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaa",
            "bcdfghjklm", "xyzxyzxyzxyz", "porisso", "tambem", "naoseiseeuvou", "qwertyuiopasdfghjklz", "hhhhh", "ççççç",
            "1234", "a-b", "d'água", "ÿ", "ñandú", "über", "ǅ", "İstanbul", "日本語", "😀😀😀"};
        for (String e : edge) words.add(e);

        int diffs = 0, total = 0;
        List<String> shown = new ArrayList<String>();
        long tJava = 0, tNative = 0;
        // 2 rounds: the 2nd with warm caches, which is the one that counts for the time
        int rounds = Integer.getInteger("rounds", 2);
        for (int round = 0; round < rounds; round++) {
            tJava = 0; tNative = 0; total = 0; diffs = 0; shown.clear();
            for (String w : words) {
                if (w.length() > MrFuzzy.MAX_TYPED + 4) continue;
                WordComposer wc = E2ETest.compose(w);
                MrNative.sForceJava = true;
                long t0 = System.nanoTime();
                f.search(wc, w);
                tJava += System.nanoTime() - t0;
                String j = render(f);
                MrNative.sForceJava = false;
                t0 = System.nanoTime();
                f.search(wc, w);
                tNative += System.nanoTime() - t0;
                String n = render(f);
                total++;
                if (!j.equals(n)) {
                    diffs++;
                    if (shown.size() < show) shown.add(w + "\n   java:   " + j + "\n   native: " + n);
                }
            }
        }
        System.out.printf("search (MrFuzzy): %d queries, %d differences%n", total, diffs);
        for (String d : shown) System.out.println("  DIFFERENCE " + d);
        System.out.printf("mean time per query: Java %.1f us, native %.1f us (%.1fx)%n",
                tJava / 1e3 / total, tNative / 1e3 / total, (double) tJava / Math.max(1, tNative));

        // hand-made dictionary with a 2-byte character (0xFF + 2: "aő"): the project's dictionaries only have letters
        // below U+00FF, so this read path can only be proven this way
        byte[] hand = {(byte) 200, 1, 1, 'a', 0x40, 0x00, 0x07, 2, 'b', (byte) 0x80, 100, 0x00,
                (byte) 0xFF, 0x01, 0x51, (byte) 0x80, 90, 0x00};
        ByteBuffer hb = ByteBuffer.allocateDirect(hand.length);
        hb.put(hand); hb.rewind();
        MrFuzzy hf = new MrFuzzy(hb, hand.length);
        int hd = 0;
        for (String w : new String[] {"ab", "a\u0151", "a", "abc", "ao", "aa", "ba", "a\u0150"}) {
            WordComposer wc = E2ETest.compose(w);
            MrNative.sForceJava = true;
            hf.search(wc, w);
            String j = render(hf);
            MrNative.sForceJava = false;
            hf.search(wc, w);
            String n = render(hf);
            if (!j.equals(n)) { hd++; System.out.println("  DIFFERENCE (hand-made dictionary) " + w + "\n   java:   " + j + "\n   native: " + n); }
        }
        System.out.println("hand-made dictionary (2-byte character): 8 queries, " + hd + " differences");
        diffs += hd;

        // final suggestion list (what the strip shows), with and without the lib
        int sd = 0, st = 0;
        List<String> shown2 = new ArrayList<String>();
        int cap = Math.min(words.size(), Integer.getInteger("suggmax", 4000));
        int i = 0;
        for (String w : words) {
            if (i++ >= cap) break;
            s.setCorrectionMode(1);
            MrNative.sForceJava = true;
            List<String> j = E2ETest.strs(E2ETest.sugg(w, null));
            MrNative.sForceJava = false;
            List<String> n = E2ETest.strs(E2ETest.sugg(w, null));
            st++;
            if (!j.equals(n)) {
                sd++;
                if (shown2.size() < show) shown2.add(w + "\n   java:   " + j + "\n   native: " + n);
            }
        }
        System.out.printf("suggestion list (Suggest): %d words, %d differences%n", st, sd);
        for (String d : shown2) System.out.println("  DIFFERENCE " + d);
        int bad = diffs + sd;

        // trigrams
        if (a.length > 2) {
            File tri = new File(a[2]);
            // Java
            MrNative.sForceJava = true;
            InputStream in = new FileInputStream(tri);
            MrTrigram.load(in);
            in.close();
            if (!MrTrigram.ready()) { System.out.println("FAIL: Java trigrams did not load"); System.exit(1); }
            List<String[]> pairs = new ArrayList<String[]>();
            String pairsFile = System.getProperty("pairs");
            if (pairsFile != null) {
                for (String line : Files.readAllLines(Paths.get(pairsFile))) {
                    String[] t = line.trim().split("\\s+");
                    for (int k = 0; k + 1 < t.length && pairs.size() < 400000; k++) pairs.add(new String[] {t[k], t[k + 1]});
                }
            }
            Collections.shuffle(pairs, new Random(7));
            if (pairs.size() > 100000) pairs = pairs.subList(0, 100000);
            String[] wj = new String[8]; int[] sj = new int[8];
            String[] wn = new String[8]; int[] sn = new int[8];
            List<String> javaOut = new ArrayList<String>();
            long t0 = System.nanoTime();
            for (String[] p : pairs) {
                Arrays.fill(wj, null);
                int c = MrTrigram.find(p[0], p[1], wj, sj);
                StringBuilder sb = new StringBuilder().append(c);
                for (int k = 0; k < c; k++) sb.append('|').append(wj[k]).append(':').append(sj[k]);
                javaOut.add(sb.toString());
            }
            long tj = System.nanoTime() - t0;
            // native: reopens the same file through the lib
            MrNative.sForceJava = false;
            if (!MrNative.triOpen(tri.getPath())) { System.out.println("FAIL: the lib refused the file " + tri); System.exit(1); }
            java.lang.reflect.Field fn = MrTrigram.class.getDeclaredField("sNative");
            fn.setAccessible(true);
            fn.setBoolean(null, true);
            t0 = System.nanoTime();
            int td = 0;
            List<String> shown3 = new ArrayList<String>();
            for (int k = 0; k < pairs.size(); k++) {
                String[] p = pairs.get(k);
                Arrays.fill(wn, null);
                int c = MrTrigram.find(p[0], p[1], wn, sn);
                StringBuilder sb = new StringBuilder().append(c);
                for (int q = 0; q < c; q++) sb.append('|').append(wn[q]).append(':').append(sn[q]);
                if (!sb.toString().equals(javaOut.get(k))) {
                    td++;
                    if (shown3.size() < show) shown3.add(p[0] + " " + p[1] + "\n   java:   " + javaOut.get(k) + "\n   native: " + sb);
                }
            }
            long tn = System.nanoTime() - t0;
            int hits = 0;
            for (String o : javaOut) if (!o.startsWith("0")) hits++;
            System.out.printf("trigrams: %d pairs (%d with a continuation), %d differences; Java %.2f us, native %.2f us per query%n",
                    pairs.size(), hits, td, tj / 1e3 / Math.max(1, pairs.size()), tn / 1e3 / Math.max(1, pairs.size()));
            for (String d : shown3) System.out.println("  DIFFERENCE " + d);
            bad += td;
        }
        System.out.println(bad == 0 ? "PARITY OK" : "PARITY FAILED: " + bad + " difference(s)");
        System.exit(bad == 0 ? 0 : 1);
    }
}
