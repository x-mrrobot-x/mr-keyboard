package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Speed of the suggestion engine on the PC, per keystroke, to compare two builds of the app (before and after a change) with the
 * same workload. Sentences come from a csv with the column "sentence,count" (the OpenSubtitles top sentences of SubtitleEval) or a plain
 * text file with one sentence per line.
 *
 * Every word of every sentence is typed letter by letter, in this order, as the keyboard does:
 *   1. "space"   : the prediction after the space (MrPredict.forWords), once per word
 *   2. "1 letter", "2-4 letters", "5+ letters" : Suggest.getSuggestions after each typed letter, with the previous word as context
 *   3. "typo"    : the last keystroke of a copy of the word with a neighbouring key in place of its middle letter (the correction search, the slow path)
 *   4. "valid"   : only the words the dictionary knows, typed in full: the keystrokes where the typed word is valid (the path the
 *                  "valid word that is probably another word" suggestion adds to)
 * One warm-up round (JIT, caches) is not counted; the next ROUNDS rounds are. Times are in microseconds: mean, median, 95th and 99th
 * percentile, and the worst. The phone is several times slower than the PC (estimate 5 to 15 times): use the ratio between two builds, not the absolute value.
 *
 * Usage: java -Djava.library.path=<libs> [-Dmr.native=off] -cp <build>:app.jar:stubs:tests com.mrkeyboard.app.SpeedEval <pt-BR|en-US|es> <dicts dir> <sentences file>
 *        -Dsentences=1500 (how many sentences, default 1500)  -Drounds=3 (default 3)
 */
public class SpeedEval {
    static final String[] KINDS = {"space", "1 letter", "2-4 letters", "5+ letters", "typo", "valid"};
    static long[][] us = new long[KINDS.length][];
    static int[] cnt = new int[KINDS.length];

    static void rec(int kind, long ns) {
        if (cnt[kind] == us[kind].length) us[kind] = Arrays.copyOf(us[kind], us[kind].length * 2);
        us[kind][cnt[kind]++] = ns;
    }

    /** A neighbouring key of the same row for the letter, or the same letter if it has none. */
    static char neighbour(char c, String[] rows) {
        for (String r : rows) {
            int i = r.indexOf(c);
            if (i >= 0) return r.charAt(i + 1 < r.length() ? i + 1 : i - 1 >= 0 ? i - 1 : i);
        }
        return c;
    }

    public static void main(String[] a) throws Exception {
        String lang = a[0];
        File dir = new File(a[1], lang);
        String rows = lang.equals("pt-BR") ? "qwertyuiop,asdfghjklç,zxcvbnm"
                : lang.equals("es") ? "qwertyuiop,asdfghjklñ,zxcvbnm" : "qwertyuiop,asdfghjkl,zxcvbnm";
        String[] r = rows.split(",");
        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i];
        byte[] bytes = Files.readAllBytes(Paths.get(new File(dir, "main.dict").getPath()));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        MrTrigram.load(new FileInputStream(new File(dir, "trigrams.bin")));
        Suggest suggest = new Suggest(null, buf);
        E2ETest.suggest = suggest;
        suggest.setCorrectionMode(1);

        int maxSent = Integer.getInteger("sentences", 1500);
        int rounds = Integer.getInteger("rounds", 3);
        List<String[]> sentences = new ArrayList<String[]>();
        List<String> lines = Files.readAllLines(Paths.get(a[2]));
        boolean csv = lines.size() > 0 && lines.get(0).equals("sentence,count");
        for (int li = csv ? 1 : 0; li < lines.size() && sentences.size() < maxSent; li++) {
            String line = lines.get(li);
            if (csv) { int c = line.lastIndexOf(','); if (c < 0) continue; line = line.substring(0, c); }
            List<String> w = new ArrayList<String>();
            for (String t : line.split("[^\\p{L}'’-]+")) if (t.length() > 0 && t.matches(".*\\p{L}.*")) w.add(t.replace('’', '\''));
            if (w.size() >= 3) sentences.add(w.toArray(new String[0]));
        }
        for (int k = 0; k < KINDS.length; k++) us[k] = new long[1 << 16];

        for (int round = 0; round <= rounds; round++) {
            boolean count = round > 0;
            for (String[] w : sentences) {
                for (int i = 1; i < w.length; i++) {
                    String want = w[i], p1 = w[i - 1], p2 = i >= 2 ? w[i - 2] : null;
                    long t0 = System.nanoTime();
                    if (p2 == null) MrPredict.forWord(suggest, p1); else MrPredict.forWords(suggest, p2, p1);
                    long t1 = System.nanoTime();
                    if (count) rec(0, t1 - t0);
                    int len = Math.min(want.length(), 12);
                    for (int k = 1; k <= len; k++) {
                        t0 = System.nanoTime();
                        E2ETest.sugg(want.substring(0, k), p1);
                        t1 = System.nanoTime();
                        if (count) {
                            rec(k == 1 ? 1 : k <= 4 ? 2 : 3, t1 - t0);
                            if (k == len && k >= 3 && (suggest.isValidWord(want) || suggest.isValidWord(want.toLowerCase()))) rec(5, t1 - t0);
                        }
                    }
                    if (want.length() >= 4 && want.length() <= 12) {
                        int mid = want.length() / 2;
                        char nb = neighbour(Character.toLowerCase(want.charAt(mid)), r);
                        String typo = want.substring(0, mid) + nb + want.substring(mid + 1);
                        if (!typo.equals(want)) {
                            for (int k = 1; k < typo.length(); k++) E2ETest.sugg(typo.substring(0, k), p1);
                            t0 = System.nanoTime();
                            E2ETest.sugg(typo, p1);
                            t1 = System.nanoTime();
                            if (count) rec(4, t1 - t0);
                        }
                    }
                }
            }
        }
        System.out.printf("%s: %d sentences, %d rounds counted, engine %s%n", lang, sentences.size(), rounds,
                System.getProperty("mr.native", "on").equals("off") ? "Java" : "native when the lib loads");
        System.out.printf("  %-12s %8s %8s %8s %8s %9s %8s%n", "keystroke", "n", "mean us", "p50", "p95", "p99", "max");
        for (int k = 0; k < KINDS.length; k++) {
            long[] v = Arrays.copyOf(us[k], cnt[k]);
            Arrays.sort(v);
            if (v.length == 0) continue;
            double sum = 0;
            for (long x : v) sum += x;
            System.out.printf("  %-12s %8d %8.1f %8.1f %8.1f %9.1f %8.1f%n", KINDS[k], v.length, sum / v.length / 1000.0,
                    v[v.length / 2] / 1000.0, v[(int) (v.length * 0.95)] / 1000.0, v[(int) (v.length * 0.99)] / 1000.0, v[v.length - 1] / 1000.0);
        }
    }
}
