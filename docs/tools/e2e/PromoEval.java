package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * v1.85.0: how often the likely word is moved to the center of the strip because the previous words confirm it (MrFuzzy.ALT_CTX_FIRST,
 * "eu aida" -> ainda), measured with the REAL previous words of every sentence.
 *
 *  - Wrongly promoted (false positives): every valid word of the sentences, typed correctly after its real context. The promotion puts another
 *    word in the center of the strip; it never replaces the typed word. Weighted by how often the sentence occurs, and by distinct sentence.
 *  - Promoted right (true positives): every frequent word of the sentences gets one-error variants (as AltEval) that are themselves rare valid words
 *    (the "real-word errors"), typed after the real previous words. Of those: the meant word reaches the center (promoted), stays in the 3rd place (the
 *    alternative is found but the context does not confirm it), another word is promoted (wrong), or nothing is offered.
 *
 * Usage: java -Djava.library.path=<libs> -cp <build>:app.jar:stubs:tests com.mrkeyboard.app.PromoEval <pt-BR|en-US|es> <dicts dir> <sentences.csv | sentences.txt>
 *        -Dmax=10000 sentences read   -Dexplore=1 prints examples
 */
public class PromoEval {
    static String[] ROWS;

    static List<String> words(String text) {
        List<String> w = new ArrayList<String>();
        for (String t : text.split("[^\\p{L}'’-]+")) {
            if (t.length() > 0 && t.matches(".*\\p{L}.*")) w.add(t.replace('’', '\''));
        }
        return w;
    }

    /** Types the word after the context (p2, p1) the way the keyboard sees it: the context is read at the 1st letter. */
    static List<String> type(String t, String p2, String p1) {
        if (p2 == null) MrPredict.forWord(E2ETest.suggest, p1); else MrPredict.forWords(E2ETest.suggest, p2, p1);
        List<String> l = null;
        for (int k = 1; k <= t.length(); k++) {
            if (k == 1 || k == t.length()) l = E2ETest.strs(E2ETest.sugg(t.substring(0, k), p1));
        }
        return l;
    }

    public static void main(String[] a) throws Exception {
        String lang = a[0];
        File dir = new File(a[1], lang);
        String rows = lang.equals("pt-BR") ? "qwertyuiop,asdfghjklç,zxcvbnm"
                : lang.equals("es") ? "qwertyuiop,asdfghjklñ,zxcvbnm" : "qwertyuiop,asdfghjkl,zxcvbnm";
        ROWS = rows.split(",");
        AltEval.ROWS = ROWS;
        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = ROWS[i];
        byte[] bytes = Files.readAllBytes(Paths.get(new File(dir, "main.dict").getPath()));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        MrTrigram.load(new FileInputStream(new File(dir, "trigrams.bin")));
        Suggest suggest = new Suggest(null, buf);
        suggest.setCorrectionMode(1);
        E2ETest.suggest = suggest;
        BinaryDictionary main = suggest.mrMainDict();
        MrFuzzy f = MrFuzzy.forDict(main.mrBuffer(), main.mrLength());
        boolean csv = !a[2].endsWith(".txt");
        int maxSent = Integer.getInteger("max", 10000);
        boolean explore = System.getProperty("explore") != null;
        List<String> lines = Files.readAllLines(Paths.get(a[2]), java.nio.charset.StandardCharsets.UTF_8);

        long fpPrefix = 0, fpPrefixU = 0;
        int tpPrefixRight = 0, tpPrefixWrong = 0;
        long fpTotal = 0, fpAlt = 0, fpPromo = 0, fpTotalU = 0, fpAltU = 0, fpPromoU = 0;
        java.util.Map<String, Long> fpEx = new java.util.LinkedHashMap<String, Long>();
        int tpCases = 0, tpPromoRight = 0, tpThird = 0, tpPromoWrong = 0, tpOtherThird = 0, tpNone = 0;
        int tpMeantInCtx = 0;
        List<String> tpEx = new ArrayList<String>();
        int sentences = 0;
        for (int li = csv ? 1 : 0; li < lines.size() && sentences < maxSent; li++) {
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
            List<String> w = words(text);
            if (w.size() < 3) continue;
            sentences++;
            for (int i = 1; i < w.size(); i++) {
                String want = w.get(i), p1 = w.get(i - 1), p2 = i >= 2 ? w.get(i - 2) : null;
                if (want.length() < 3 || want.length() > MrFuzzy.ALT_MAX_TYPED) continue;
                if (!(suggest.isValidWord(want) || suggest.isValidWord(want.toLowerCase()))) continue;

                // ---- false positives: the word is typed correctly
                fpTotal += count;
                fpTotalU++;
                List<String> strip = type(want, p2, p1);
                int own;
                String alt = null;
                synchronized (f) {
                    own = f.ownFrequency(want);
                    if (own > MrFuzzy.ALT_OFFENSIVE_FREQ && own <= MrFuzzy.ALT_TYPED_MAX) {
                        f.search(E2ETest.compose(want), want);
                        alt = f.alternative(want, own, MrFuzzy.ALT_MAX_COST, MrFuzzy.ALT_MIN_FREQ, MrFuzzy.ALT_GAP);
                    }
                }
                if (alt != null) {
                    fpAlt += count;
                    fpAltU++;
                    boolean promoted = strip.size() > 1 && strip.get(1).equalsIgnoreCase(alt);
                    if (promoted) {
                        fpPromo += count;
                        fpPromoU++;
                        if (alt.regionMatches(true, 0, want, 0, want.length())) { fpPrefix += count; fpPrefixU++; }
                        String key = p1 + " " + want + " -> " + alt;
                        Long old = fpEx.get(key);
                        fpEx.put(key, (old == null ? 0 : old) + count);
                    }
                }

                // ---- true positives: a rare valid word made from this frequent one by one error, typed after the same context
                if (want.length() < 4 || want.length() > 10 || !want.equals(want.toLowerCase())) continue;
                int wf;
                synchronized (f) { wf = f.ownFrequency(want); }
                if (wf < MrFuzzy.ALT_MIN_FREQ) continue;
                Set<String> seen = new HashSet<String>();
                for (String t : AltEval.variants(want)) {
                    if (t.equals(want) || t.length() < 3 || !seen.add(t) || !suggest.isValidWord(t)) continue;
                    int tOwn;
                    synchronized (f) { tOwn = f.ownFrequency(t); }
                    if (tOwn <= MrFuzzy.ALT_OFFENSIVE_FREQ || tOwn > MrFuzzy.ALT_TYPED_MAX) continue;
                    List<String> l = type(t, p2, p1);
                    String got;
                    synchronized (f) {
                        f.search(E2ETest.compose(t), t);
                        got = f.alternative(t, tOwn, MrFuzzy.ALT_MAX_COST, MrFuzzy.ALT_MIN_FREQ, MrFuzzy.ALT_GAP);
                    }
                    tpCases++;
                    if (MrPredict.inContext(want)) tpMeantInCtx++;
                    if (got == null) { tpNone++; continue; }
                    boolean atCenter = l.size() > 1 && l.get(1).equalsIgnoreCase(got);
                    boolean right = got.equalsIgnoreCase(want);
                    boolean pre = got.regionMatches(true, 0, t, 0, t.length());
                    if (atCenter && right) { tpPromoRight++; if (pre) tpPrefixRight++; }
                    else if (atCenter) { if (pre) tpPrefixWrong++; tpPromoWrong++; if (tpEx.size() < 40) tpEx.add(p1 + " " + t + " (meant " + want + ") -> " + got); }
                    else if (right) tpThird++;
                    else tpOtherThird++;
                }
            }
        }
        System.out.printf("%s: %d sentences%n", lang, sentences);
        System.out.printf("  correct valid words: alternative found for %.2f%% (3rd place, as in 1.84.0); moved to the CENTER for %.2f%% weighted, %.2f%% unique (%d of %d)%n",
                100.0 * fpAlt / Math.max(1, fpTotal), 100.0 * fpPromo / Math.max(1, fpTotal), 100.0 * fpPromoU / Math.max(1, fpTotalU), fpPromoU, fpTotalU);
        StringBuilder sb = new StringBuilder("  most frequent wrong promotions:");
        List<java.util.Map.Entry<String, Long>> ex = new ArrayList<java.util.Map.Entry<String, Long>>(fpEx.entrySet());
        java.util.Collections.sort(ex, new java.util.Comparator<java.util.Map.Entry<String, Long>>() {
            public int compare(java.util.Map.Entry<String, Long> x, java.util.Map.Entry<String, Long> y) { return Long.compare(y.getValue(), x.getValue()); }
        });
        for (int i = 0; i < Math.min(10, ex.size()); i++) sb.append("  [").append(ex.get(i).getKey()).append(" x").append(ex.get(i).getValue()).append("]");
        System.out.println(sb);
        System.out.printf("  real-word errors after their real context: %d cases; meant word is in the context for %.1f%%%n", tpCases, 100.0 * tpMeantInCtx / Math.max(1, tpCases));
        System.out.printf("    meant word at the CENTER %.1f%%   meant word only in the 3rd place %.1f%%   another word at the center (wrong) %.1f%%   another word in the 3rd place %.1f%%   nothing %.1f%%%n",
                100.0 * tpPromoRight / Math.max(1, tpCases), 100.0 * tpThird / Math.max(1, tpCases), 100.0 * tpPromoWrong / Math.max(1, tpCases),
                100.0 * tpOtherThird / Math.max(1, tpCases), 100.0 * tpNone / Math.max(1, tpCases));
        System.out.printf("  of those at the center: correct words %.0f%% of the weighted wrong promotions (%d of %d unique) are the typed word + more letters; errors: %d right and %d wrong are such%n",
                100.0 * fpPrefix / Math.max(1, fpPromo), fpPrefixU, fpPromoU, tpPrefixRight, tpPrefixWrong);
        if (explore) for (String s : tpEx) System.out.println("    wrong: " + s);
    }
}
