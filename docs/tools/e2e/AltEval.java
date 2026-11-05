package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * "A valid word that is probably another word" (MrFuzzy.alternative, v1.84): how often the suggestion shows up when it should not, and
 * how often it finds the word that was meant. Sentences come from the csv of SubtitleEval (column "sentence,count").
 *
 *  - Wrongly offered (false positives): every valid word of the sentences, typed correctly, weighted by how often the sentence occurs. The
 *    alternative is only a suggestion in the 3rd place, so this is noise, not a wrong replacement; the goal is to keep it very low.
 *  - Found (true positives): every frequent word of the sentences gets one-error variants (neighbouring key, swapped letters, one letter less, one
 *    letter doubled); those that are themselves rare valid words (frequency up to the limit) are the "real-word errors" the suggestion is for.
 *    Of those, in how many does the suggestion return the word that was meant?
 *
 * Parameters (default = the constants of MrFuzzy): -Dgap -Dcost -Dtyped -Dminfreq
 * Usage: java -Djava.library.path=<libs> -cp <build>:app.jar:stubs:tests com.mrkeyboard.app.AltEval <pt-BR|en-US|es> <dicts dir> <sentences.csv>
 */
public class AltEval {
    static String[] ROWS;

    static List<String> variants(String w) {
        List<String> out = new ArrayList<String>();
        for (int i = 0; i < w.length(); i++) {
            char c = w.charAt(i);
            for (String row : ROWS) {
                int k = row.indexOf(Character.toLowerCase(c));
                if (k < 0) continue;
                if (k > 0) out.add(w.substring(0, i) + row.charAt(k - 1) + w.substring(i + 1));
                if (k + 1 < row.length()) out.add(w.substring(0, i) + row.charAt(k + 1) + w.substring(i + 1));
            }
            if (i + 1 < w.length()) out.add(w.substring(0, i) + w.charAt(i + 1) + c + w.substring(i + 2));   // swap
            out.add(w.substring(0, i) + w.substring(i + 1));                                                  // one letter less
            out.add(w.substring(0, i + 1) + c + w.substring(i + 1));                                          // one letter doubled
        }
        return out;
    }

    public static void main(String[] a) throws Exception {
        String lang = a[0];
        File dir = new File(a[1], lang);
        String rows = lang.equals("pt-BR") ? "qwertyuiop,asdfghjklç,zxcvbnm"
                : lang.equals("es") ? "qwertyuiop,asdfghjklñ,zxcvbnm" : "qwertyuiop,asdfghjkl,zxcvbnm";
        ROWS = rows.split(",");
        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = ROWS[i];
        byte[] bytes = Files.readAllBytes(Paths.get(new File(dir, "main.dict").getPath()));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        MrTrigram.load(new FileInputStream(new File(dir, "trigrams.bin")));
        Suggest suggest = new Suggest(null, buf);
        E2ETest.suggest = suggest;
        BinaryDictionary main = suggest.mrMainDict();
        MrFuzzy f = MrFuzzy.forDict(main.mrBuffer(), main.mrLength());
        int gap = Integer.getInteger("gap", MrFuzzy.ALT_GAP), cost = Integer.getInteger("cost", MrFuzzy.ALT_MAX_COST);
        int typedMax = Integer.getInteger("typed", MrFuzzy.ALT_TYPED_MAX), minFreq = Integer.getInteger("minfreq", MrFuzzy.ALT_MIN_FREQ);

        // words of the sentences: weight (how many sentences' occurrences) per distinct word
        Map<String, Long> weight = new LinkedHashMap<String, Long>();
        List<String> lines = Files.readAllLines(Paths.get(a[2]));
        for (int li = 1; li < lines.size(); li++) {
            String line = lines.get(li);
            int c = line.lastIndexOf(',');
            if (c < 0) continue;
            long count;
            try { count = Long.parseLong(line.substring(c + 1).trim()); } catch (NumberFormatException e) { continue; }
            for (String t : line.substring(0, c).split("[^\\p{L}'’-]+")) {
                if (t.length() < 3 || t.length() > 12 || !t.matches("\\p{L}[\\p{L}'’-]*")) continue;
                String w = t.replace('’', '\'');
                Long old = weight.get(w);
                weight.put(w, (old == null ? 0 : old) + count);
            }
        }

        long total = 0, fired = 0, totalU = 0, firedU = 0;
        Map<String, Long> examples = new HashMap<String, Long>();
        for (Map.Entry<String, Long> e : weight.entrySet()) {
            String w = e.getKey();
            if (!(suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase()))) continue;
            total += e.getValue();
            totalU++;
            int own;
            synchronized (f) { own = f.ownFrequency(w); }
            if (own <= MrFuzzy.ALT_OFFENSIVE_FREQ || own > typedMax) continue;
            String alt;
            synchronized (f) {
                f.search(E2ETest.compose(w), w);
                alt = f.alternative(w, own, cost, minFreq, gap);
            }
            if (alt != null) {
                fired += e.getValue();
                firedU++;
                examples.put(w + " -> " + alt + " (own " + own + ")", e.getValue());
            }
        }
        System.out.printf("%s (gap %d, cost %d, typed<=%d, alt>=%d): offered wrongly for %.2f%% of the typed valid words (%.2f%% of the distinct ones, %d of %d)%n",
                lang, gap, cost, typedMax, minFreq, 100.0 * fired / Math.max(1, total), 100.0 * firedU / Math.max(1, totalU), firedU, totalU);
        List<Map.Entry<String, Long>> ex = new ArrayList<Map.Entry<String, Long>>(examples.entrySet());
        java.util.Collections.sort(ex, new java.util.Comparator<Map.Entry<String, Long>>() {
            public int compare(Map.Entry<String, Long> x, Map.Entry<String, Long> y) { return Long.compare(y.getValue(), x.getValue()); }
        });
        StringBuilder sb = new StringBuilder("  most frequent wrong offers:");
        for (int i = 0; i < Math.min(8, ex.size()); i++) sb.append("  ").append(ex.get(i).getKey());
        System.out.println(sb);

        // real-word errors made from frequent words
        int cases = 0, found = 0, other = 0, miss = 0;
        List<String> sample = new ArrayList<String>();
        for (String w : weight.keySet()) {
            if (w.length() < 4 || w.length() > 10 || !w.equals(w.toLowerCase())) continue;
            int wf;
            synchronized (f) { wf = f.ownFrequency(w); }
            if (wf < minFreq) continue;
            java.util.Set<String> seen = new java.util.HashSet<String>();
            for (String t : variants(w)) {
                if (t.equals(w) || t.length() < 3 || !seen.add(t) || !suggest.isValidWord(t)) continue;
                int own;
                synchronized (f) { own = f.ownFrequency(t); }
                if (own <= MrFuzzy.ALT_OFFENSIVE_FREQ || own > typedMax) continue;
                cases++;
                String alt;
                synchronized (f) {
                    f.search(E2ETest.compose(t), t);
                    alt = f.alternative(t, own, cost, minFreq, gap);
                }
                if (alt == null) { miss++; if (sample.size() < 400 && cases % 7 == 0) sample.add(t + " (meant " + w + "): none"); }
                else if (alt.equalsIgnoreCase(w)) { found++; if (sample.size() < 400 && cases % 11 == 0) sample.add(t + " (meant " + w + "): OK"); }
                else { other++; if (sample.size() < 400 && cases % 3 == 0) sample.add(t + " (meant " + w + "): " + alt); }
            }
        }
        System.out.printf("  real-word errors (rare valid word made from a frequent one): %d cases: meant word offered %.1f%%, another word offered %.1f%%, nothing %.1f%%%n",
                cases, 100.0 * found / Math.max(1, cases), 100.0 * other / Math.max(1, cases), 100.0 * miss / Math.max(1, cases));
        if (System.getProperty("explore") != null) for (String s : sample) System.out.println("    " + s);
    }
}
