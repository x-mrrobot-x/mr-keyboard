package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Calibrates what an imported word / pair weighs (MrLearned.WORD_FREQ_AT_50, PAIR_FREQ_AT_50, v1.85). It stands in for the keyboard's own
 * learned dictionaries with two in-memory ExpandableDictionary (the same class AutoDictionary and UserBigramDictionary extend), fills them
 * the way the keyboard does at start (MrLearned.loadFrom) and prints where the imported names land in the strip while they are typed.
 *
 * Usage: java -Djava.library.path=<libs> -cp app.jar:stubs:. com.mrkeyboard.app.ImportEval <pt-BR|en-US|es> <dicts dir> [sweep]
 *   without "sweep": the weights as shipped; with "sweep": the same names with a stored frequency from 6 to 250 (to choose the constant).
 */
public class ImportEval {
    static Suggest suggest;

    /** The auto dictionary of the keyboard: a word is valid from frequency 6 (AutoDictionary.isValidWord). */
    static final class Words extends ExpandableDictionary implements MrLearned.Sink {
        Words() {
            super(null, Suggest.DIC_AUTO);
            setRequiresReload(false);
        }

        public int kind() {
            return 0;
        }

        public void word(String w, int freq) {
            addWord(w, freq);
        }

        public void pair(String a, String b, int freq) {
        }

        @Override
        public boolean isValidWord(CharSequence word) {
            return getWordFrequency(word) >= 6;
        }
    }

    static final class Pairs extends ExpandableDictionary implements MrLearned.Sink {
        Pairs() {
            super(null, Suggest.DIC_USER);
            setRequiresReload(false);
        }

        public int kind() {
            return 1;
        }

        public void word(String w, int freq) {
        }

        public void pair(String a, String b, int freq) {
            setBigram(a, b, freq);
        }
    }

    /** Names, nicknames, brands and slang that a user would add; the ones the dictionary already knows are dropped by unknown(). */
    static String[] candidates(String lang) {
        return lang.equals("pt-BR")
                ? new String[] {"Taciane", "Gleidson", "Jhonatan", "Wanderléa", "Edvaldo", "Zildete", "Brunão", "Tadeuzinho", "Quitéria", "Kauê", "Ifood", "tiktok",
                        "Pix", "Shopee", "Itapecuru", "Quixeramobim", "Vinicão", "Rayanne", "Dalvanir", "Eustáquio", "Jandira", "Cleiton"}
                : lang.equals("es")
                ? new String[] {"Aitziber", "Nahuel", "Xóchitl", "Yolotzin", "Leire", "Ainhoa", "Itziar", "Zuleyka", "Jhoana", "Wilmer", "Yeison", "Tiktok", "Bizum",
                        "Shopee", "Quilmes", "Tlaxcala", "Cuauhtémoc", "Ximenita", "Brayan", "Deivid", "Nubank", "Yaiza"}
                : new String[] {"Sjoerd", "Odalys", "Kaelen", "Brynlee", "Zephyrine", "Quillan", "Tamsin", "Oluwaseun", "Yevgeny", "Aaliyah", "Tiktok", "Venmo",
                        "Shopee", "Xiomara", "Kauai", "Wyndham", "Taliesin", "Beyoncé", "Jhené", "Saoirse", "Niamh", "Siobhan"};
    }

    /** The candidates that the main dictionary does not know in any case (the suggest object must be loaded). */
    static ArrayList<String> unknown(String lang) {
        ArrayList<String> out = new ArrayList<String>();
        for (String n : candidates(lang)) {
            if (!E2ETest.suggest.isValidWord(n) && !E2ETest.suggest.isValidWord(n.toLowerCase())
                    && !E2ETest.suggest.isValidWord(n.substring(0, 1).toUpperCase() + n.substring(1).toLowerCase())) out.add(n);
        }
        return out;
    }

    /** Pairs of known words that the main bigrams do not put in the three predictions: {first, second}. */
    static String[][] pairs(String lang) {
        return lang.equals("pt-BR")
                ? new String[][] {{"conta", "corrente"}, {"vou", "pagar"}, {"minha", "senha"}, {"de", "souza"}, {"que", "saudade"}, {"eu", "preciso"}}
                : lang.equals("es")
                ? new String[][] {{"cuenta", "corriente"}, {"voy", "pagar"}, {"mi", "contraseña"}, {"de", "souza"}, {"que", "saudade"}, {"yo", "necesito"}}
                : new String[][] {{"checking", "account"}, {"going", "pay"}, {"my", "password"}, {"of", "course"}, {"that", "reminds"}, {"i", "need"}};
    }


    /** -Dspeed=1: the cost of a full learned dictionary (20,000 imported words, 30,000 imported pairs) in time per key and in memory. */
    static void speed(String lang) {
        String[] syl = {"ka", "ro", "li", "mu", "ta", "ne", "so", "vi", "da", "pe", "ju", "co", "bra", "tri", "gle", "sha", "mon", "lu", "xe", "ri"};
        java.util.Random rnd = new java.util.Random(7);
        String[] probes = {"co", "con", "com", "como", "pro", "per", "est", "mu", "ca", "pa", "que", "nao", "obr", "bom", "vou", "mui", "tem", "fal", "ama", "dia"};
        if (!lang.equals("pt-BR")) probes = new String[] {"th", "the", "wha", "wou", "tha", "hav", "goo", "mor", "com", "pro", "est", "mu", "ca", "que", "gra", "hol", "por", "est", "ten", "ama"};
        for (int round = 0; round < 2; round++) {
            Runtime rt = Runtime.getRuntime();
            System.gc();
            long before = rt.totalMemory() - rt.freeMemory();
            Words w = new Words();
            Pairs p = new Pairs();
            int nWords = round == 0 ? 0 : 20000, nPairs = round == 0 ? 0 : 30000;
            ArrayList<String> made = new ArrayList<String>();
            for (int i = 0; i < nWords; i++) {
                StringBuilder sb = new StringBuilder();
                int n = 2 + rnd.nextInt(3);
                for (int k = 0; k < n; k++) sb.append(syl[rnd.nextInt(syl.length)]);
                String word = sb.toString() + (i % 7);
                word = word.replaceAll("[0-9]", "");
                made.add(word);
                w.addWord(word, 130);
            }
            for (int i = 0; i < nPairs; i++) p.pair(made.get(rnd.nextInt(made.size())), made.get(rnd.nextInt(made.size())), 6);
            System.gc();
            long after = rt.totalMemory() - rt.freeMemory();
            suggest.setAutoDictionary(w);
            suggest.setUserBigramDictionary(p);
            for (int warm = 0; warm < 3; warm++) for (String pr : probes) strip(pr, null);
            double worst = 0, total = 0;
            int count = 0;
            for (int rep = 0; rep < 5; rep++) {
                for (String pr : probes) {
                    long t0 = System.nanoTime();
                    strip(pr, "de");
                    double ms = (System.nanoTime() - t0) / 1e6;
                    worst = Math.max(worst, ms);
                    total += ms;
                    count++;
                }
            }
            System.out.printf("%s: %5d words, %5d pairs: heap +%.1f MB, per key avg %.2f ms, worst %.2f ms%n", lang, nWords, nPairs,
                    (after - before) / 1048576.0, total / count, worst);
            suggest.setAutoDictionary(null);
            suggest.setUserBigramDictionary(null);
        }
    }

    static boolean f50(int[] pf) {
        return true;
    }

    static List<String> strip(String typed, String prev) {
        return E2ETest.strs(E2ETest.sugg(typed, prev));
    }

    /** Position of the word in the strip (case ignored), or -1. */
    static int at(List<String> l, String w) {
        for (int i = 0; i < l.size(); i++) if (l.get(i).equalsIgnoreCase(w)) return i;
        return -1;
    }

    public static void main(String[] a) throws Exception {
        String lang = a[0];
        boolean sweep = a.length > 2 && a[2].equals("sweep");
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
        suggest = new Suggest(null, buf);
        E2ETest.suggest = suggest;
        suggest.setCorrectionMode(1);

        if (System.getProperty("speed") != null) {
            speed(lang);
            return;
        }
        ArrayList<String> oov = unknown(lang);
        if (System.getProperty("probe") != null) {
            for (String n : System.getProperty("probe").split(",")) {
                System.out.println("probe " + n + " valid=" + suggest.isValidWord(n) + " lower=" + suggest.isValidWord(n.toLowerCase()));
            }
        }
        System.out.println("== " + lang + ": names the dictionary does not know: " + oov);

        int[] freqs = sweep ? new int[] {6, 20, 60, 90, 100, 110, 120, 130, 140, 150, 170, 200, 250} : new int[] {MrLearned.wordFreq(50), MrLearned.wordFreq(80), MrLearned.wordFreq(100)};
        for (int f : freqs) {
            Words words = new Words();
            for (String n : oov) words.addWord(n, f);
            suggest.setAutoDictionary(words);
            int[][] hist = new int[3][5]; // prefix length 2..4 -> {at1, at2, at3+, none}
            StringBuilder detail = new StringBuilder();
            for (String n : oov) {
                detail.append(n).append(':');
                for (int len = 2; len <= 4; len++) {
                    if (len >= n.length()) continue;   // the whole word typed is not completing it
                    List<String> l = strip(n.substring(0, len).toLowerCase(), null);
                    int p = at(l, n);
                    int slot = p == 1 ? 0 : p == 2 ? 1 : p > 2 ? 2 : 3;
                    hist[len - 2][slot]++;
                    detail.append(' ').append(p);
                }
                detail.append(" | ");
            }
            System.out.println("freq " + f + (f == MrLearned.wordFreq(50) ? " (weight 50 as shipped)" : ""));
            for (int len = 2; len <= 4; len++) {
                System.out.println("   " + len + " letters typed: 1st=" + hist[len - 2][0] + " 2nd=" + hist[len - 2][1] + " later=" + hist[len - 2][2]
                        + " none=" + hist[len - 2][3] + " of " + oov.size());
            }
            if (System.getProperty("explore") != null) System.out.println("   positions: " + detail);
        }
        suggest.setAutoDictionary(null);

        // pairs: a pair of two words the dictionary knows. The first group are pairs the main bigrams do not rank; the second group starts with
        // the most common words, where the main dictionary has strong opinions already.
        String[][] pairs = pairs(lang);
        int[] pf = sweep ? new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9, 12} : new int[] {MrLearned.pairFreq(50), MrLearned.pairFreq(80), MrLearned.pairFreq(100)};
        for (String[] p : pairs) {
            suggest.setUserBigramDictionary(null);
            List<CharSequence> pb = MrPredict.forWord(suggest, p[0]);
            System.out.println("pair " + p[0] + " _ -> " + p[1] + "   main only: " + (pb == null ? "null" : E2ETest.strs(pb)));
            StringBuilder line = new StringBuilder();
            for (int f : pf) {
                Pairs user = new Pairs();
                user.pair(p[0], p[1], f);
                suggest.setUserBigramDictionary(user);
                List<CharSequence> pa = MrPredict.forWord(suggest, p[0]);
                int pos = pa == null ? -1 : at(E2ETest.strs(pa), p[1]);
                line.append("  f").append(f).append("@").append(pos);
            }
            System.out.println("   position of the pair (0 left, 1 center, 2 right, -1 absent):" + line
                    + (f50(pf) ? "" : ""));
        }
        suggest.setUserBigramDictionary(null);
    }
}
