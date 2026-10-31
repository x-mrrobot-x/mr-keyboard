package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
 * Paridade do motor nativo (v1.77): para cada palavra das listas, a busca de correção do MrFuzzy roda pelo
 * caminho Java e pelo caminho C++ (libmrengine.so, pela JNI) e as duas têm de dar o MESMO resultado: mesmas palavras,
 * mesma ordem, mesma pontuação, mesmo custo e o mesmo número de nós visitados. Depois compara a lista final
 * de Suggest.getSuggestions (o que a faixa mostra) e mede o tempo dos dois caminhos.
 *
 * Também confere os trigramas: MrTrigram.find pelo Java e pela lib, para os pares de -Dpairs.
 * As consultas saem do próprio dicionário: engine/tools/gen_parity_queries.py (o docs/tools/e2e/run_native_parity.sh faz tudo).
 *
 * Uso: java -Djava.library.path=<pastas das libs> -cp ... com.mrkeyboard.app.NativeParity dicionario.dict erros.tsv [trigramas.bin]
 *   -Dlimit=N  só as N primeiras linhas;  -Dpairs=arquivo.txt  linhas "w1 w2" para os pares de trigramas
 *   -Drows=...  layout das teclas vizinhas;  -Dshow=20  mostra até 20 diferenças;  -Drounds=1  uma rodada só (padrão 2: a 2ª mede o tempo)
 *   -Dsuggmax=N  quantas palavras passam pelo Suggest completo (padrão 4000)
 * Sai com código 1 se houver qualquer diferença (ou se a lib não carregar).
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
            System.out.println("FALHA: a lib nativa não carregou (java.library.path, versão do contrato ou mr.native=off)");
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
            // começos de palavra (digitar certo): 2 a 5 letras
            for (int k = 2; k <= 5 && k < p[0].length(); k++) words.add(p[0].substring(0, k));
        }
        // casos de borda: maiúsculas, acento, 1 letra, tamanho máximo, só consoantes, repetidas
        String[] edge = {"Casa", "CASA", "ÁGUA", "coração", "ação", "ç", "a", "aa", "aaaaaaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaa",
            "bcdfghjklm", "xyzxyzxyzxyz", "porisso", "tambem", "naoseiseeuvou", "qwertyuiopasdfghjklz", "hhhhh", "ççççç",
            "1234", "a-b", "d'água", "ÿ", "ñandú", "über", "ǅ", "İstanbul", "日本語", "😀😀😀"};
        for (String e : edge) words.add(e);

        int diffs = 0, total = 0;
        List<String> shown = new ArrayList<String>();
        long tJava = 0, tNative = 0;
        // 2 rodadas: a 2ª com os caches quentes, que é a que vale para o tempo
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
                    if (shown.size() < show) shown.add(w + "\n   java:   " + j + "\n   nativo: " + n);
                }
            }
        }
        System.out.printf("busca (MrFuzzy): %d consultas, %d diferenças%n", total, diffs);
        for (String d : shown) System.out.println("  DIFERENÇA " + d);
        System.out.printf("tempo médio por consulta: Java %.1f us, nativo %.1f us (%.1fx)%n",
                tJava / 1e3 / total, tNative / 1e3 / total, (double) tJava / Math.max(1, tNative));

        // dicionário feito à mão com caractere de 2 bytes (0xFF + 2: "aő"): os dicionários do projeto só têm letras
        // abaixo de U+00FF, então esse caminho da leitura só se prova assim
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
            if (!j.equals(n)) { hd++; System.out.println("  DIFERENÇA (dicionário à mão) " + w + "\n   java:   " + j + "\n   nativo: " + n); }
        }
        System.out.println("dicionário à mão (caractere de 2 bytes): 8 consultas, " + hd + " diferenças");
        diffs += hd;

        // lista final de sugestões (o que a faixa mostra), com e sem a lib
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
                if (shown2.size() < show) shown2.add(w + "\n   java:   " + j + "\n   nativo: " + n);
            }
        }
        System.out.printf("lista de sugestões (Suggest): %d palavras, %d diferenças%n", st, sd);
        for (String d : shown2) System.out.println("  DIFERENÇA " + d);
        int bad = diffs + sd;

        // trigramas
        if (a.length > 2) {
            File tri = new File(a[2]);
            // Java
            MrNative.sForceJava = true;
            InputStream in = new FileInputStream(tri);
            MrTrigram.load(in);
            in.close();
            if (!MrTrigram.ready()) { System.out.println("FALHA: trigramas Java não carregaram"); System.exit(1); }
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
            // nativo: reabre o mesmo arquivo pela lib
            MrNative.sForceJava = false;
            if (!MrNative.triOpen(tri.getPath())) { System.out.println("FALHA: a lib recusou o arquivo " + tri); System.exit(1); }
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
                    if (shown3.size() < show) shown3.add(p[0] + " " + p[1] + "\n   java:   " + javaOut.get(k) + "\n   nativo: " + sb);
                }
            }
            long tn = System.nanoTime() - t0;
            int hits = 0;
            for (String o : javaOut) if (!o.startsWith("0")) hits++;
            System.out.printf("trigramas: %d pares (%d com continuação), %d diferenças; Java %.2f us, nativo %.2f us por consulta%n",
                    pairs.size(), hits, td, tj / 1e3 / Math.max(1, pairs.size()), tn / 1e3 / Math.max(1, pairs.size()));
            for (String d : shown3) System.out.println("  DIFERENÇA " + d);
            bad += td;
        }
        System.out.println(bad == 0 ? "PARIDADE OK" : "PARIDADE FALHOU: " + bad + " diferenças");
        System.exit(bad == 0 ? 0 : 1);
    }
}
