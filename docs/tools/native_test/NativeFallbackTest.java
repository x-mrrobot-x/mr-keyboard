package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
 * Motor nativo (1.77): o app sem a libmrengine.so tem de funcionar igual à 1.76. Este teste roda no CI, onde a lib
 * não existe, e prova a reserva em Java com o dicionário e os trigramas de verdade (dicts/pt-BR):
 *   - a lib não carrega e MrNative diz que não está pronto, sem lançar nada;
 *   - MrFuzzy.search dá as correções de sempre;
 *   - MrTrigram.use() carrega pelo caminho Java e find() responde;
 *   - uma busca com a lib desligada (-Dmr.native=off) e com sForceJava dão o mesmo.
 * Com a lib presente (PC) o teste de paridade é docs/tools/e2e/NativeParity.java.
 * Roda na raiz do projeto (precisa de dicts/pt-BR/main.dict, rules.txt e trigrams.bin).
 */
public class NativeFallbackTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) fails++;
        System.out.println((ok ? "OK    " : "FALHA ") + what);
    }

    static final String[] ROWS = {"qwertyuiop", "asdfghjklç", "zxcvbnm"};

    static int[] codesFor(char c) {
        int[] out = new int[16];
        Arrays.fill(out, -1);
        out[0] = c;
        int n = 1;
        for (int r = 0; r < 3; r++) {
            int k = ROWS[r].indexOf(c);
            if (k < 0) continue;
            int[][] nb = {{r, k - 1}, {r, k + 1}, {r - 1, k}, {r - 1, k + 1}, {r + 1, k - 1}, {r + 1, k}};
            for (int[] p : nb) {
                if (p[0] < 0 || p[0] > 2 || p[1] < 0 || p[1] >= ROWS[p[0]].length()) continue;
                out[n++] = ROWS[p[0]].charAt(p[1]);
            }
        }
        return out;
    }

    static WordComposer compose(String w) {
        WordComposer wc = new WordComposer();
        for (int i = 0; i < w.length(); i++) wc.add(w.charAt(i), codesFor(w.charAt(i)));
        return wc;
    }

    static String top(MrFuzzy f, String typed) {
        f.search(compose(typed), typed);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < f.resultCount(); i++) sb.append(f.resultWord(i)).append(' ');
        return sb.toString().trim();
    }

    public static void main(String[] a) throws Exception {
        File dir = new File("dicts/pt-BR");
        byte[] bytes = Files.readAllBytes(new File(dir, "main.dict").toPath());
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));

        // 1) sem a lib: não carrega, não lança
        boolean threw = false;
        boolean ready = true;
        try {
            ready = MrNative.ready();
        } catch (Throwable e) {
            threw = true;
        }
        check(!threw, "MrNative.ready() sem a lib não lança");
        check(!ready, "sem a lib o motor nativo não está pronto (o teste roda sem libmrengine.so no java.library.path)");
        check(MrNative.search(buf, bytes.length, 3, new char[20], new char[320], new int[20], MrRules.get(),
                new char[490], new int[11], new long[5]) == -1, "search sem a lib devolve -1");
        check(!MrNative.triOpen(new File(dir, "trigrams.bin").getPath()), "triOpen sem a lib devolve false");

        // 2) correção pelo Java
        MrFuzzy f = new MrFuzzy(buf, bytes.length);
        String[][] cases = {{"vda", "vida"}, {"sepre", "sempre"}, {"durate", "durante"}, {"prte", "parte"}, {"agoa", "agora"},
            {"obrigdo", "obrigado"}, {"porisso", "por isso"}};
        for (String[] c : cases) {
            String got = top(f, c[0]);
            // palavras separadas por espaço; "por isso" é uma sugestão só, então confere com os espaços das pontas
            check((" " + got + " ").contains(" " + c[1] + " "), "Java corrige " + c[0] + " -> " + c[1] + "   [" + got + "]");
        }

        // 3) desligar de propósito dá o mesmo resultado
        String base = top(f, "obrigdo");
        MrNative.sForceJava = true;
        check(top(f, "obrigdo").equals(base), "sForceJava não muda o resultado");
        MrNative.sForceJava = false;

        // 4) trigramas pelo Java, pelo caminho de produção (use + thread)
        File tri = new File(dir, "trigrams.bin");
        MrTrigram.use(tri);
        long end = System.currentTimeMillis() + 20000;
        while (!MrTrigram.ready() && System.currentTimeMillis() < end) Thread.sleep(50);
        check(MrTrigram.ready(), "trigramas carregam pelo Java quando a lib não abre o arquivo");
        // um contexto que existe no arquivo: primeira entrada de qualquer par com continuação
        String[] w = new String[3];
        int[] s = new int[3];
        int found = 0;
        String[][] pairs = {{"de", "acordo"}, {"por", "causa"}, {"no", "entanto"}, {"em", "relação"}, {"de", "forma"}, {"a", "partir"},
            {"não", "é"}, {"o", "que"}, {"é", "um"}, {"que", "o"}};
        for (String[] p : pairs) if (MrTrigram.find(p[0], p[1], w, s) > 0) found++;
        check(found > 0, "MrTrigram.find responde pelo Java (" + found + " de " + pairs.length + " pares com continuação)");
        MrTrigram.use(null);
        check(!MrTrigram.ready(), "use(null) descarrega");

        System.out.println(fails == 0 ? "TUDO OK (" + checks + " verificações)" : "FALHOU: " + fails + " de " + checks);
        System.exit(fails == 0 ? 0 : 1);
    }
}
