package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.lang.reflect.Field;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;

/**
 * Everyday-language benchmark: the 10,000 most common sentences of the OpenSubtitles 2018 corpus (the files
 * bld/top_sentences/<lang>_top_sentences.csv of https://github.com/orgtre/top-open-subtitles-sentences, columns "sentence,count").
 * It is NOT the training data of any pack, so it is a fair test of how well a dictionary fits short, spoken sentences.
 *
 * Typing is simulated word by word with the sentence as the context. Only words with 4 or more letters are counted, so
 * every row has the same words and a hit really saves keystrokes (a 1-letter word is "completed" by typing it):
 *   after space : the word is among the 3 predictions shown after the space (no letter typed)
 *   1/2/3 letters : the word is one of the 2 suggestions next to the typed word in the strip (entries 1 and 2; entry 0 is what was typed)
 * Numbers are by sentence occurrence (weighted by count) and by distinct sentence (unique).
 * -Dall=1 counts every word length instead (the old, less strict way).
 *
 * Usage: java -Djava.library.path=<libs> -cp app.jar:stubs:. com.mrkeyboard.app.SubtitleEval <pt-BR|en-US|es> <dicts dir> <top_sentences.csv>
 *        -Dmin=3 minimum words in a sentence (default 3)   -Dmax=10000 sentences read
 */
public class SubtitleEval {
    static boolean hit(List<String> l, String want, int from, int to) {
        for (int i = from; i <= to && i < l.size(); i++) {
            if (l.get(i).equalsIgnoreCase(want)) return true;
        }
        return false;
    }

    static String fold(String t) {
        return Normalizer.normalize(t.toLowerCase(), Normalizer.Form.NFD).replaceAll("\\p{M}", "");
    }

    /**
     * Prototype of "context while typing" (not in the app yet): after forWords(...), the best candidate of the previous
     * words' context (bigrams, trigrams, user, recent) that starts with what was typed. Reads the private arrays of MrPredict.
     */
    static String ctxBest(String prefix, int skip) throws Exception {
        Class<?> c = MrPredict.class;
        Field fw = c.getDeclaredField("sWord"), fm = c.getDeclaredField("sMain"), fu = c.getDeclaredField("sUser"), fc = c.getDeclaredField("sCount");
        fw.setAccessible(true); fm.setAccessible(true); fu.setAccessible(true); fc.setAccessible(true);
        String[] w = (String[]) fw.get(null);
        int[] m = (int[]) fm.get(null), u = (int[]) fu.get(null);
        int n = fc.getInt(null);
        String pre = fold(prefix);
        int best = -1, bestScore = -1;
        for (int i = 0; i < n; i++) {
            if (w[i] == null || w[i].length() <= prefix.length() || !fold(w[i]).startsWith(pre)) continue;
            int sc = m[i] + u[i];
            if (sc > bestScore) { bestScore = sc; best = i; }
        }
        return best < 0 ? null : w[best];
    }

    /** Strip with the context candidate merged in (mode "A": slot 1, "B": slot 2); the others keep their order. */
    static List<String> merge(List<String> l, String ctx, String mode) {
        if (ctx == null || mode == null) return l;
        List<String> out = new ArrayList<String>();
        out.add(l.size() > 0 ? l.get(0) : "");
        List<String> rest = new ArrayList<String>();
        for (int i = 1; i < l.size(); i++) if (!l.get(i).equalsIgnoreCase(ctx)) rest.add(l.get(i));
        if (mode.equals("A")) { out.add(ctx); out.addAll(rest); }
        else { if (rest.size() > 0) out.add(rest.get(0)); out.add(ctx); if (rest.size() > 1) out.addAll(rest.subList(1, rest.size())); }
        return out;
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
        E2ETest.suggest = new Suggest(null, buf);
        E2ETest.suggest.setCorrectionMode(1);
        String ctxMode = System.getProperty("ctx");   // prototype: "A" or "B", see merge()
        int minWords = Integer.getInteger("min", 3);
        int maxSent = Integer.getInteger("max", 10000);

        // [kind][0 = hits weighted, 1 = total weighted, 2 = hits unique, 3 = total unique]
        long[][] c = new long[4][4];
        long[] cover = new long[4];   // known words weighted / total weighted / known unique / total unique (every word, any length)
        int sentences = 0;
        int minLen = System.getProperty("all") != null ? 1 : 4;
        List<String> lines = Files.readAllLines(Paths.get(a[2]));
        for (int li = 1; li < lines.size() && sentences < maxSent; li++) {
            String line = lines.get(li);
            int comma = line.lastIndexOf(',');
            if (comma < 0) continue;
            long count;
            try { count = Long.parseLong(line.substring(comma + 1).trim()); } catch (NumberFormatException e) { continue; }
            String text = line.substring(0, comma).trim();
            if (text.startsWith("\"") && text.endsWith("\"") && text.length() > 1) text = text.substring(1, text.length() - 1);
            List<String> w = new ArrayList<String>();
            for (String t : text.split("[^\\p{L}'’-]+")) {
                if (t.length() > 0 && t.matches(".*\\p{L}.*")) w.add(t.replace('’', '\''));
            }
            if (w.size() < minWords) continue;
            sentences++;
            for (String t : w) {
                boolean known = E2ETest.suggest.isValidWord(t) || E2ETest.suggest.isValidWord(t.toLowerCase());
                if (known) { cover[0] += count; cover[2]++; }
                cover[1] += count;
                cover[3]++;
            }
            for (int i = 1; i < w.size(); i++) {
                String want = w.get(i), p1 = w.get(i - 1), p2 = i >= 2 ? w.get(i - 2) : null;
                if (want.length() < minLen) continue;
                // after the space (two words when there are two)
                List<String> pred = E2ETest.strs(p2 == null ? MrPredict.forWord(E2ETest.suggest, p1) : MrPredict.forWords(E2ETest.suggest, p2, p1));
                add(c, 0, hit(pred, want, 0, 2), count);
                for (int k = 1; k <= 3; k++) {
                    if (want.length() <= k) continue;
                    // same context the keyboard has before the first letter: the prediction of the previous words
                    if (p2 == null) MrPredict.forWord(E2ETest.suggest, p1); else MrPredict.forWords(E2ETest.suggest, p2, p1);
                    List<String> l = E2ETest.strs(E2ETest.sugg(want.substring(0, k), p1));
                    if (ctxMode != null && k >= 2) l = merge(l, ctxBest(want.substring(0, k), 0), ctxMode);
                    add(c, k, hit(l, want, 1, 2), count);
                }
            }
        }
        System.out.printf("%s: %d sentences with %d or more words%n", lang, sentences, minWords);
        System.out.printf("  %-16s weighted %5.1f%%               unique %5.1f%%   (words of the sentences that the dictionary knows)%n", "known words",
                100.0 * cover[0] / Math.max(1, cover[1]), 100.0 * cover[2] / Math.max(1, cover[3]));
        String[] names = {"after the space", "1 letter", "2 letters", "3 letters"};
        for (int k = 0; k < 4; k++) {
            System.out.printf("  %-16s weighted %5.1f%% (n=%d)   unique %5.1f%% (n=%d)%n", names[k],
                    100.0 * c[k][0] / Math.max(1, c[k][1]), c[k][1], 100.0 * c[k][2] / Math.max(1, c[k][3]), c[k][3]);
        }
    }

    static void add(long[][] c, int kind, boolean ok, long weight) {
        if (ok) { c[kind][0] += weight; c[kind][2]++; }
        c[kind][1] += weight;
        c[kind][3]++;
    }
}
