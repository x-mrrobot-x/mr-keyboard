package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
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
 *   1 to 7 letters : the word is one of the 2 suggestions next to the typed word in the strip (entries 1 and 2; entry 0 is what was typed)
 * Numbers are by sentence occurrence (weighted by count) and by distinct sentence (unique).
 * -Dall=1 counts every word length instead (the old, less strict way).
 *
 * The same measurement also runs on a plain text file, one sentence per line (every sentence counts once): StrategyTest uses it
 * with docs/tools/e2e/data/everyday_<lang>.txt (about 120 original sentences per language, so it needs no download) and fails when a
 * rate falls under its floor (S28). A file whose name ends in .txt is read that way, anything else is "sentence,count" with a header line.
 *
 * Usage: java -Djava.library.path=<libs> -cp app.jar:stubs:. com.mrkeyboard.app.SubtitleEval <pt-BR|en-US|es> <dicts dir> <top_sentences.csv | sentences.txt>
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

    /** Counts of one run: c[kind] = {hits weighted, total weighted, hits unique, total unique}; cover = the same for "known words". */
    static final class Result {
        final long[][] c = new long[8][4];
        final long[] cover = new long[4];
        int sentences;

        double rate(int kind) { return 100.0 * c[kind][0] / Math.max(1, c[kind][1]); }
        double known() { return 100.0 * cover[0] / Math.max(1, cover[1]); }
    }

    /** Types the sentences with E2ETest.suggest (already loaded). csv: "sentence,count" with a header line; otherwise one sentence per line. */
    static Result run(List<String> lines, boolean csv, int minWords, int maxSent, int minLen) {
        Result res = new Result();
        long[][] c = res.c;
        long[] cover = res.cover;
        for (int li = csv ? 1 : 0; li < lines.size() && res.sentences < maxSent; li++) {
            String line = lines.get(li);
            String text = line.trim();
            long count = 1;
            if (csv) {
                int comma = line.lastIndexOf(',');
                if (comma < 0) continue;
                try { count = Long.parseLong(line.substring(comma + 1).trim()); } catch (NumberFormatException e) { continue; }
                text = line.substring(0, comma).trim();
                if (text.startsWith("\"") && text.endsWith("\"") && text.length() > 1) text = text.substring(1, text.length() - 1);
            }
            List<String> w = new ArrayList<String>();
            for (String t : text.split("[^\\p{L}'’-]+")) {
                if (t.length() > 0 && t.matches(".*\\p{L}.*")) w.add(t.replace('’', '\''));
            }
            if (w.size() < minWords) continue;
            res.sentences++;
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
                // the keystrokes in order: the 1st letter is typed before the 2nd, as the keyboard sees them (the context of the previous
                // words is read at the 1st letter)
                if (p2 == null) MrPredict.forWord(E2ETest.suggest, p1); else MrPredict.forWords(E2ETest.suggest, p2, p1);
                for (int k = 1; k <= 7; k++) {
                    if (want.length() <= k) break;
                    List<String> l = E2ETest.strs(E2ETest.sugg(want.substring(0, k), p1));
                    add(c, k, hit(l, want, 1, 2), count);
                }
            }
        }
        return res;
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
        int minWords = Integer.getInteger("min", 3);
        int maxSent = Integer.getInteger("max", 10000);
        int minLen = System.getProperty("all") != null ? 1 : 4;
        List<String> lines = Files.readAllLines(Paths.get(a[2]), java.nio.charset.StandardCharsets.UTF_8);
        Result res = run(lines, !a[2].endsWith(".txt"), minWords, maxSent, minLen);
        long[][] c = res.c;
        long[] cover = res.cover;
        System.out.printf("%s: %d sentences with %d or more words%n", lang, res.sentences, minWords);
        System.out.printf("  %-16s weighted %5.1f%%               unique %5.1f%%   (words of the sentences that the dictionary knows)%n", "known words",
                100.0 * cover[0] / Math.max(1, cover[1]), 100.0 * cover[2] / Math.max(1, cover[3]));
        String[] names = {"after the space", "1 letter", "2 letters", "3 letters", "4 letters", "5 letters", "6 letters", "7 letters"};
        for (int k = 0; k < 8; k++) {
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
