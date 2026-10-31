package com.mrkeyboard.app;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.util.Arrays;

/**
 * Teste da ponte JNI sem o app: carrega a libmrengine.so, entrega tabelas e regras montadas aqui (com o Character do
 * Java, como o MrNative do app faz), busca no dicionário de verdade e confere argumentos ruins (buffer não direto, arrays
 * curtos, arquivo inexistente): falha limpa em vez de cair. O resultado exato igual ao do Java NÃO é conferido aqui: é do
 * docs/tools/e2e/NativeParity.java (que usa as classes reais do app).
 *
 * Uso: java -cp pasta_das_classes com.mrkeyboard.app.JniSmoke caminho/libmrengine.so pasta_dicts
 */
public class JniSmoke {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("FALHA: " + what); }
    }

    static char[] chars(String s, int n) {
        char[] c = new char[n];
        for (int i = 0; i < s.length() && i < n; i++) c[i] = s.charAt(i);
        return c;
    }

    public static void main(String[] a) throws Exception {
        System.load(new File(a[0]).getAbsolutePath());
        File dicts = new File(a[1]);
        check(MrNative.nVersion() == 1, "nVersion == 1");

        int[] costs = {25, 30, 35, 30, 25, 45, 75, 60, 30, 40, 45, 40, 30, 40, 35, 35, 12000};
        char[] lower = new char[65536];
        byte[] upper = new byte[65536];
        for (int i = 0; i < 65536; i++) {
            lower[i] = Character.toLowerCase((char) i);
            upper[i] = (byte) (Character.isUpperCase((char) i) ? 1 : 0);
        }
        char[] base = new char[256];
        for (int i = 0; i < 256; i++) base[i] = lower[i];
        double[] pow2 = new double[256];
        for (int i = 0; i < 256; i++) pow2[i] = Math.pow(2.0, -i / 25.0);
        check(MrNative.nInit(costs, lower, upper, base, pow2), "nInit");
        check(!MrNative.nInit(new int[3], lower, upper, base, pow2), "nInit recusa custos curtos");
        check(!MrNative.nInit(costs, lower, upper, base, new double[10]), "nInit recusa tabela de potências curta");
        int[] bad = costs.clone();
        bad[16] = 0;   // teto de nós zero
        check(!MrNative.nInit(bad, lower, upper, base, pow2), "nInit recusa teto de nós zero");
        check(MrNative.nInit(costs, lower, upper, base, pow2), "nInit de novo");

        // regras: uma de cada tipo
        byte[] pairs = new byte[65536];
        pairs[('s' << 8) | 'z'] = 1;
        pairs[('z' << 8) | 's'] = 1;
        short[] st = new short[256], any = new short[256];
        st['h'] = 30;
        boolean[] extra = new boolean[256], one = new boolean[256];
        extra['h'] = true;
        one['a'] = true;
        check(MrNative.nSetRules(pairs, chars("chx", 3), chars("ssc", 3), chars("nh", 2), new short[] {35}, st, any, extra, one), "nSetRules");

        String[] langs = {"pt-BR", "en-US", "es"};
        String[] typed = {"vda", "recieve", "ecuela"};
        String[] want = {"vida", "receive", "escuela"};
        for (int li = 0; li < langs.length; li++) {
            byte[] dictBytes = Files.readAllBytes(new File(dicts, langs[li] + "/main.dict").toPath());
            ByteBuffer dict = ByteBuffer.allocateDirect(dictBytes.length);
            dict.put(dictBytes);
            dict.rewind();
            char[] outWords = new char[5 * 98];
            int[] info = new int[11];
            long[] scores = new long[5];
            String w = typed[li];
            char[] tb = chars(w, 20);
            int c = MrNative.nSearch(dict, dictBytes.length, w.length(), tb, new char[320], new int[20], outWords, info, scores);
            boolean found = false;
            for (int i = 0; i < c; i++) if (new String(outWords, i * 98, info[1 + 2 * i]).equals(want[li])) found = true;
            check(c > 0 && c <= 5 && found, langs[li] + ": " + w + " -> " + want[li] + " pela JNI (veio " + c + " resultados)");
            check(info[0] > 0, langs[li] + ": nós visitados informados");
            for (int i = 1; i < c; i++) check(scores[i - 1] >= scores[i], langs[li] + ": pontuações em ordem");

            String tri = new File(dicts, langs[li] + "/trigrams.bin").getAbsolutePath();
            check(MrNative.nTriOpen(tri), "nTriOpen " + langs[li]);
            String[] ow = new String[8];
            int[] os = new int[8];
            int hits = 0;
            String[][] pairsList = {{"de", "acordo"}, {"por", "causa"}, {"of", "the"}, {"in", "the"}, {"de", "la"}, {"en", "el"}, {"o", "que"}, {"it", "is"}};
            for (String[] p : pairsList) {
                Arrays.fill(ow, null);
                int n = MrNative.nTriFind(p[0], p[0], p[1], p[1], ow, os);
                check(n >= 0 && n <= 8, "contagem de trigramas dentro do limite");
                for (int i = 0; i < n; i++) check(ow[i] != null && !ow[i].isEmpty() && os[i] >= 0 && os[i] <= 255, "continuação válida");
                if (n > 0) hits++;
            }
            check(hits > 0, langs[li] + ": algum par comum tem continuação pela JNI");
        }

        // argumentos ruins: falha limpa, sem queda
        char[] ow = new char[490];
        int[] info = new int[11];
        long[] sc = new long[5];
        char[] tb = new char[20], near = new char[320];
        int[] cnt = new int[20];
        ByteBuffer heap = ByteBuffer.allocate(1000);   // não direto
        check(MrNative.nSearch(heap, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "buffer não direto");
        check(MrNative.nSearch(null, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "buffer nulo");
        ByteBuffer small = ByteBuffer.allocateDirect(100);
        check(MrNative.nSearch(small, 1000, 3, tb, near, cnt, ow, info, sc) == -1, "tamanho maior que o buffer");
        check(MrNative.nSearch(small, 100, 0, tb, near, cnt, ow, info, sc) == -1, "n = 0");
        check(MrNative.nSearch(small, 100, 21, tb, near, cnt, ow, info, sc) == -1, "n = 21");
        check(MrNative.nSearch(small, 100, 3, new char[1], near, cnt, ow, info, sc) == -1, "tb curto");
        check(MrNative.nSearch(small, 100, 3, tb, near, cnt, new char[10], info, sc) == -1, "saída curta");
        check(!MrNative.nTriOpen("/nao/existe/trigrams.bin"), "arquivo inexistente");
        check(!MrNative.nTriOpen(null), "caminho nulo");
        MrNative.nTriClose();
        check(MrNative.nTriFind("a", "a", "b", "b", new String[3], new int[3]) == 0, "trigramas fechados dão 0");
        check(!MrNative.nSetRules(new byte[10], new char[0], new char[0], new char[0], new short[0], new short[256],
                new short[256], new boolean[256], new boolean[256]), "regras com tabela curta");

        System.out.println(fails == 0 ? "OK: " + checks + " verificações da ponte JNI" : "FALHOU: " + fails + " de " + checks);
        System.exit(fails == 0 ? 0 : 1);
    }
}
