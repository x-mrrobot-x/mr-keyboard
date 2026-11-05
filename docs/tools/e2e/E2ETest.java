package com.mrkeyboard.app;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
* End-to-end test on the PC: real classes of the APK (classes.dex -> jar with dex2jar) and the
* native lib compiled for the PC from the same dictionary.cpp. Only LatinIME (which needs
* Android) is left out.
 *
 * Usage: java -Djava.library.path=<lib> -cp app.jar:stubs:. com.mrkeyboard.app.E2ETest dict test.txt [mode] [trigrams]
* (since 1.63 it reads rules.txt from the dictionary folder, like the downloaded pack)
 */
public class E2ETest {
    static final String[] ROWS = {"qwertyuiop", "asdfghjklç", "zxcvbnm"};
    static Suggest suggest;
    static int fails = 0;

    static int[] codesFor(char c) {
        int[] out = new int[16];
        Arrays.fill(out, -1);
        out[0] = c;
        char b = Character.toLowerCase(c);
        int n = 1;
        for (int r = 0; r < 3; r++) {
            int k = ROWS[r].indexOf(b);
            if (k < 0) continue;
            int[][] nb = {{r, k - 1}, {r, k + 1}, {r - 1, k}, {r - 1, k + 1}, {r + 1, k - 1}, {r + 1, k}};
            for (int[] p : nb) {
                if (p[0] < 0 || p[0] > 2 || p[1] < 0 || p[1] >= ROWS[p[0]].length()) continue;
                out[n++] = ROWS[p[0]].charAt(p[1]);
            }
        }
        return out;
    }

    static WordComposer compose(String typed) {
        WordComposer wc = new WordComposer();
        for (int i = 0; i < typed.length(); i++) wc.add(typed.charAt(i), codesFor(typed.charAt(i)));
        if (Character.isUpperCase(typed.charAt(0))) wc.setFirstCharCapitalized(true);
        return wc;
    }

    static List<CharSequence> sugg(String typed, String prev) {
        List<CharSequence> l = suggest.getSuggestions(null, compose(typed), false, prev);
        return new ArrayList<CharSequence>(l);
    }

    static List<String> strs(List<CharSequence> l) {
        List<String> o = new ArrayList<String>();
        if (l != null) for (CharSequence c : l) o.add(c.toString());
        return o;
    }

    /** What the strip shows: the first 3 entries (0 = typed). */
    static void expect(String label, List<String> got, String want, int maxIndex) {
        int at = got.indexOf(want);
        boolean ok = at >= 0 && at <= maxIndex;
        if (!ok) fails++;
        System.out.printf("%s %-34s -> %-14s %s%n", ok ? "OK   " : "FAIL ", label, want,
                got.subList(0, Math.min(6, got.size())));
    }

    static class TestUserBigrams extends ExpandableDictionary {
        TestUserBigrams() { super(null, 2); }
    }

    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        // 1.63: the language rules come from the pack (rules.txt in the same folder as the dictionary)
        java.io.File rules = new java.io.File(new java.io.File(a[0]).getAbsoluteFile().getParentFile(), "rules.txt");
        if (rules.isFile()) {
            MrRules.set(MrRules.parse(new FileInputStream(rules)));
            System.out.println("rules: " + rules + " (" + MrRules.get().corrections.size() + " corrections)");
        }
        suggest = new Suggest(null, buf);
        int mode = a.length > 2 ? Integer.parseInt(a[2]) : 1;
        suggest.setCorrectionMode(mode);
        System.out.println("correction mode " + mode + ", dictionary " + bytes.length + " bytes");

        // 1st letter: bigrams of the previous word (before, only in modes 1 and 3, only the exact same letter)
        expect("1st letter 'o' after 'muito'", strs(sugg("o", "muito")), "obrigado", 3);
        expect("1st letter 'd' after 'bom'", strs(sugg("d", "bom")), "dia", 3);
        expect("1st letter 'e' after 'ele' (é)", strs(sugg("e", "ele")), "é", 3);
        expect("1st letter 'D' after 'Bom' (case)", strs(sugg("D", "Bom")), "Dia", 3);
        // errors the lib does not catch
        expect("obrogado", strs(sugg("obrogado", null)), "obrigado", 2);
        expect("trabakho (neighbour)", strs(sugg("trabakho", null)), "trabalho", 2);
        expect("pesquiza (phonetic)", strs(sugg("pesquiza", null)), "pesquisa", 2);
        expect("asim (doubled letter)", strs(sugg("asim", null)), "assim", 2);
        expect("omem (silent h)", strs(sugg("omem", null)), "homem", 2);
        expect("enchergar (ch/x)", strs(sugg("enchergar", null)), "enxergar", 2);
        expect("excessao (MrFix map)", strs(sugg("excessao", null)), "exceção", 2);
        expect("concerteza (space)", strs(sugg("concerteza", null)), "com certeza", 2);
        expect("eusei (space, search)", strs(sugg("eusei", null)), "eu sei", 2);
        expect("vc (abbreviation)", strs(sugg("vc", null)), "você", 2);
        expect("Vc (uppercase)", strs(sugg("Vc", null)), "Você", 2);
        expect("tbm", strs(sugg("tbm", null)), "também", 2);
        expect("obrig (lib completion)", strs(sugg("obrig", null)), "obrigado", 2);
        expect("informac (accent, lib)", strs(sugg("informac", null)), "informação", 2);
        expect("nao (accent, lib)", strs(sugg("nao", null)), "não", 2);

        // prediction after the space (strip order: 2nd, 1st, 3rd)
        for (String p : new String[] {"muito", "Bom", "bom", "de", "não", "está", "obrigado", "segunda-feira", "xqzwv"}) {
            List<CharSequence> l = MrPredict.forWord(suggest, p);
            System.out.printf("      prediction after %-14s %s%n", p, l);
        }
        List<CharSequence> lm = MrPredict.forWord(suggest, "muito");
        if (lm == null || lm.size() != 3) { fails++; System.out.println("FAIL  prediction 'muito' without 3 items"); }
        if (MrPredict.forWord(suggest, "xqzwv") != null) { fails++; System.out.println("FAIL  prediction for an unknown word"); }
        List<String> lb = strs(MrPredict.forWord(suggest, "Bom"));
        expect("prediction 'Bom' (uses 'bom')", lb, "dia", 2);

        // user bigrams go first
        TestUserBigrams user = new TestUserBigrams();
        user.addBigram("muito", "massa", 60);
        suggest.setUserBigramDictionary(user);
        List<String> lu = strs(MrPredict.forWord(suggest, "muito"));
        boolean center = lu.size() >= 2 && lu.get(1).equals("massa");
        if (!center) fails++;
        System.out.printf("%s %-34s -> %-14s %s%n", center ? "OK   " : "FAIL ", "user bigram in the center", "massa", lu);
        expect("1st letter 'm' with a user bigram", strs(sugg("m", "muito")), "massa", 3);
        suggest.setUserBigramDictionary(null);

        // 1.62: slot reserved for the cheap correction
        expect("prota (reserved correction)", strs(sugg("prota", null)), "porta", 2);
        // 1.62: careful autocorrection (mode 3 = autocorrection on)
        suggest.setCorrectionMode(3);
        String[][] ac = {{"obrogado", "1"}, {"pesquiza", "1"}, {"asim", "1"}, {"concerteza", "1"}, {"obrig", "0"}, {"eusei", "0"}};
        for (String[] c : ac) {
            List<String> l = strs(sugg(c[0], null));
            boolean auto = suggest.hasMinimalCorrection();
            boolean ok = auto == c[1].equals("1");
            if (!ok) fails++;
            System.out.printf("%s autocorrection %-12s -> %-5s (%s)%n", ok ? "OK   " : "FAIL ", c[0], auto, l.size() > 1 ? l.get(1) : "-");
        }
        suggest.setCorrectionMode(mode);
        // 1.62: sentence start and two words
        String[] sent = {"", "Oi. ", "Tudo bem? ", "muito ", "ele disse, "};
        for (String t : sent) System.out.printf("      sentence start in %-14s %s%n", "'" + t + "'", MrText.atSentenceStart(t));
        if (a.length > 3) {
            MrTrigram.load(new java.io.FileInputStream(a[3]));
            String[][] ctx = {{"bom", "dia"}, {"muito", "obrigado"}, {"eu", "não"}, {"vou", "te"}, {"de", "acordo"}, {"o", "que"}, {"tudo", "bem"}};
            for (String[] c : ctx) {
                System.out.printf("      prediction after %-16s %s   (last one only: %s)%n", c[0] + " " + c[1],
                        MrPredict.forWords(suggest, c[0], c[1]), MrPredict.forWord(suggest, c[1]));
            }
            MrPredict.forWords(suggest, "bom", "dia");
            System.out.println("      1st letter 'p' after 'bom dia': " + strs(sugg("p", "dia")));
        }
        // 1.62: user bigram shows up with 2 uses
        TestUserBigrams u2 = new TestUserBigrams();
        u2.addBigram("bom", "demais", 4);
        suggest.setUserBigramDictionary(u2);
        expect("user bigram with 2 uses", strs(MrPredict.forWord(suggest, "bom")), "demais", 2);
        suggest.setUserBigramDictionary(null);

        // time per key typing the test sentences
        if (a.length > 1 && !a[1].equals("-")) {
            Pattern word = Pattern.compile("[\\p{L}]+(?:['-][\\p{L}]+)*");
            List<String> lines = new ArrayList<String>();
            BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream(a[1]), "UTF-8"));
            String s;
            while ((s = r.readLine()) != null && lines.size() < 1500) lines.add(s);
            r.close();
            for (int round = 0; round < 2; round++) {
                List<Double> t = new ArrayList<Double>();
                List<Double> tp = new ArrayList<Double>();
                int keys = 0;
                for (String line : lines) {
                    Matcher m = word.matcher(line);
                    String prev = null;
                    while (m.find()) {
                        String w = m.group();
                        for (int k = 1; k <= w.length() && k <= 20; k++) {
                            long t0 = System.nanoTime();
                            suggest.getSuggestions(null, compose(w.substring(0, k)), false, prev);
                            t.add((System.nanoTime() - t0) / 1e6);
                            keys++;
                        }
                        long t0 = System.nanoTime();
                        MrPredict.forWord(suggest, w);
                        tp.add((System.nanoTime() - t0) / 1e6);
                        prev = w;
                    }
                }
                if (round == 1) {
                    report("per key (getSuggestions)", t);
                    report("prediction after the space", tp);
                }
            }
        }
        System.out.println(fails == 0 ? "ALL OK" : fails + " FAILURE(S)");
        System.exit(fails == 0 ? 0 : 1);
    }

    static void report(String label, List<Double> t) {
        double[] c = new double[t.size()];
        double sum = 0;
        for (int i = 0; i < c.length; i++) { c[i] = t.get(i); sum += c[i]; }
        Arrays.sort(c);
        System.out.printf("time %-28s n=%d mean %.3f p50 %.3f p95 %.3f p99 %.3f max %.3f ms%n", label, c.length,
                sum / c.length, c[c.length / 2], c[(int) (c.length * .95)], c[(int) (c.length * .99)], c[c.length - 1]);
    }
}
