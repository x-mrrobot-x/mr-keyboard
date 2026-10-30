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
 * Teste de ponta a ponta no PC: classes reais do APK (classes.dex -> jar com dex2jar) e a lib
 * nativa compilada para o PC a partir do mesmo dictionary.cpp. Só LatinIME (que precisa do
 * Android) fica de fora.
 *
 * Uso: java -Djava.library.path=<lib> -cp app.jar:stubs:. com.mrkeyboard.app.E2ETest dict test.txt [modo]
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

    /** O que a faixa mostra: as 3 primeiras entradas (0 = digitada). */
    static void expect(String label, List<String> got, String want, int maxIndex) {
        int at = got.indexOf(want);
        boolean ok = at >= 0 && at <= maxIndex;
        if (!ok) fails++;
        System.out.printf("%s %-34s -> %-14s %s%n", ok ? "OK   " : "FALHA", label, want,
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
        suggest = new Suggest(null, buf);
        int mode = a.length > 2 ? Integer.parseInt(a[2]) : 1;
        suggest.setCorrectionMode(mode);
        System.out.println("modo de correção " + mode + ", dicionário " + bytes.length + " bytes");

        // 1ª letra: bigramas da palavra anterior (antes só nos modos 1 e 3, só a mesma letra exata)
        expect("1ª letra 'o' depois de 'muito'", strs(sugg("o", "muito")), "obrigado", 3);
        expect("1ª letra 'd' depois de 'bom'", strs(sugg("d", "bom")), "dia", 3);
        expect("1ª letra 'e' depois de 'ele' (é)", strs(sugg("e", "ele")), "é", 3);
        expect("1ª letra 'D' depois de 'Bom' (caixa)", strs(sugg("D", "Bom")), "Dia", 3);
        // erros que a lib não pega
        expect("obrogado", strs(sugg("obrogado", null)), "obrigado", 2);
        expect("trabakho (vizinha)", strs(sugg("trabakho", null)), "trabalho", 2);
        expect("pesquiza (fonética)", strs(sugg("pesquiza", null)), "pesquisa", 2);
        expect("asim (letra dobrada)", strs(sugg("asim", null)), "assim", 2);
        expect("omem (h mudo)", strs(sugg("omem", null)), "homem", 2);
        expect("prota (troca de lugar)", strs(sugg("prota", null)), "porta", 2);
        expect("enchergar (ch/x)", strs(sugg("enchergar", null)), "enxergar", 2);
        expect("excessao (mapa MrFix)", strs(sugg("excessao", null)), "exceção", 2);
        expect("concerteza (espaço)", strs(sugg("concerteza", null)), "com certeza", 2);
        expect("eusei (espaço, busca)", strs(sugg("eusei", null)), "eu sei", 2);
        expect("vc (abreviação)", strs(sugg("vc", null)), "você", 2);
        expect("Vc (maiúscula)", strs(sugg("Vc", null)), "Você", 2);
        expect("tbm", strs(sugg("tbm", null)), "também", 2);
        expect("obrig (complemento da lib)", strs(sugg("obrig", null)), "obrigado", 2);
        expect("informac (acento, lib)", strs(sugg("informac", null)), "informação", 2);
        expect("nao (acento, lib)", strs(sugg("nao", null)), "não", 2);

        // previsão depois do espaço (ordem da faixa: 2ª, 1ª, 3ª)
        for (String p : new String[] {"muito", "Bom", "bom", "de", "não", "está", "obrigado", "segunda-feira", "xqzwv"}) {
            List<CharSequence> l = MrPredict.forWord(suggest, p);
            System.out.printf("      previsão depois de %-14s %s%n", p, l);
        }
        List<CharSequence> lm = MrPredict.forWord(suggest, "muito");
        if (lm == null || lm.size() != 3) { fails++; System.out.println("FALHA previsão 'muito' sem 3 itens"); }
        if (MrPredict.forWord(suggest, "xqzwv") != null) { fails++; System.out.println("FALHA previsão de palavra desconhecida"); }
        List<String> lb = strs(MrPredict.forWord(suggest, "Bom"));
        expect("previsão 'Bom' (usa 'bom')", lb, "dia", 2);

        // bigramas do usuário passam à frente
        TestUserBigrams user = new TestUserBigrams();
        user.addBigram("muito", "massa", 60);
        suggest.setUserBigramDictionary(user);
        List<String> lu = strs(MrPredict.forWord(suggest, "muito"));
        boolean centro = lu.size() >= 2 && lu.get(1).equals("massa");
        if (!centro) fails++;
        System.out.printf("%s %-34s -> %-14s %s%n", centro ? "OK   " : "FALHA", "bigrama do usuário no centro", "massa", lu);
        expect("1ª letra 'm' com bigrama do usuário", strs(sugg("m", "muito")), "massa", 3);
        suggest.setUserBigramDictionary(null);

        // tempo por tecla digitando frases do teste
        if (a.length > 1) {
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
                    report("por tecla (getSuggestions)", t);
                    report("previsão depois do espaço", tp);
                }
            }
        }
        System.out.println(fails == 0 ? "TUDO OK" : fails + " FALHA(S)");
        System.exit(fails == 0 ? 0 : 1);
    }

    static void report(String label, List<Double> t) {
        double[] c = new double[t.size()];
        double sum = 0;
        for (int i = 0; i < c.length; i++) { c[i] = t.get(i); sum += c[i]; }
        Arrays.sort(c);
        System.out.printf("tempo %-28s n=%d média %.3f p50 %.3f p95 %.3f p99 %.3f máx %.3f ms%n", label, c.length,
                sum / c.length, c[c.length / 2], c[(int) (c.length * .95)], c[(int) (c.length * .99)], c[c.length - 1]);
    }
}
