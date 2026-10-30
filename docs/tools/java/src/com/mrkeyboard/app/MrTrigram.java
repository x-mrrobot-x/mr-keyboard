package com.mrkeyboard.app;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

/**
 * Palavras mais prováveis depois de DUAS palavras (v1.62), do trigrams.bin do pacote de dicionário
 * (desde a 1.63; antes ficava em assets). Formato em docs/tools/make_trigrams.py. Só tem os
 * contextos em que o par sozinho erraria; no resto a previsão continua com os bigramas do .dict.
 *
 * MrPacks chama use() ao ativar o pacote do idioma: carrega numa thread à parte (uns poucos MB na
 * memória); enquanto não termina, find() devolve 0 e a previsão usa só os bigramas.
 */
public final class MrTrigram {
    private MrTrigram() { }

    private static String[] sWords;               // em ordem de código (String.compareTo)
    private static long[] sKeys;                  // (id1 << 32) | id2, em ordem
    private static int[] sStart;                  // início das continuações de cada contexto
    private static int[] sNext;                   // ids das continuações
    private static byte[] sScore;                 // f7 de cada continuação
    private static String sPath;                  // arquivo carregado (ou carregando)
    private static int sGen;                      // muda a cada use(); carga velha é descartada

    /** Passa a usar este arquivo (null = nenhum). Não faz nada se já é o arquivo em uso. */
    static void use(final File file) {
        final String path = file != null ? file.getPath() : null;
        final int gen;
        synchronized (MrTrigram.class) {
            if (path == null ? sPath == null : path.equals(sPath)) return;
            sPath = path;
            gen = ++sGen;
            sWords = null;
            sKeys = null;
            sStart = null;
            sNext = null;
            sScore = null;
        }
        if (path == null) return;
        Thread t = new Thread(new Runnable() {
            public void run() {
                InputStream in = null;
                try {
                    in = new FileInputStream(file);
                    load(in, gen);
                } catch (Throwable e) {
                    // sem o arquivo a previsão segue só com os bigramas
                } finally {
                    if (in != null) {
                        try { in.close(); } catch (IOException ignored) { }
                    }
                }
            }
        }, "MrTrigram");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    static void load(InputStream raw) throws IOException {
        int gen;
        synchronized (MrTrigram.class) {
            gen = ++sGen;
            sPath = "(teste)";
        }
        load(raw, gen);
    }

    /** Lê o arquivo (também usado nos testes). */
    private static void load(InputStream raw, int gen) throws IOException {
        DataInputStream in = new DataInputStream(new BufferedInputStream(raw, 65536));
        byte[] magic = new byte[4];
        in.readFully(magic);
        if (magic[0] != 'M' || magic[1] != 'R' || magic[2] != 'T' || magic[3] != '1') {
            throw new IOException("formato desconhecido");
        }
        int n = in.readInt();
        String[] words = new String[n];
        byte[] buf = new byte[256];
        for (int i = 0; i < n; i++) {
            int len = in.readUnsignedByte();
            in.readFully(buf, 0, len);
            words[i] = new String(buf, 0, len, "UTF-8");
        }
        int m = in.readInt();
        long[] keys = new long[m];
        int[] start = new int[m + 1];
        int[] next = new int[m * 3];
        byte[] score = new byte[m * 3];
        int p = 0;
        for (int i = 0; i < m; i++) {
            long a = read24(in);
            long b = read24(in);
            keys[i] = (a << 32) | b;
            start[i] = p;
            int k = in.readUnsignedByte();
            for (int j = 0; j < k; j++) {
                next[p] = read24(in);
                score[p] = (byte) in.readUnsignedByte();
                p++;
            }
        }
        start[m] = p;
        synchronized (MrTrigram.class) {
            if (gen != sGen) return;
            sKeys = keys;
            sStart = start;
            sNext = next;
            sScore = score;
            sWords = words;
        }
    }

    private static int read24(DataInputStream in) throws IOException {
        int a = in.readUnsignedByte();
        int b = in.readUnsignedByte();
        int c = in.readUnsignedByte();
        return (a << 16) | (b << 8) | c;
    }

    static synchronized boolean ready() {
        return sWords != null;
    }

    private static int id(String w) {
        String[] words = sWords;
        if (words == null || w == null) return -1;
        int i = Arrays.binarySearch(words, w);
        return i >= 0 ? i : -1;
    }

    /**
     * Continuações de (w1, w2) com a f7 de cada uma, ou null. Tenta as palavras como vieram e em
     * minúscula (início de frase).
     */
    static synchronized int find(String w1, String w2, String[] outWords, int[] outScores) {
        if (sWords == null || w1 == null || w2 == null) return 0;
        String[] c1 = {w1, w1.toLowerCase()};
        String[] c2 = {w2, w2.toLowerCase()};
        for (String a : c1) {
            int ia = id(a);
            if (ia < 0) continue;
            for (String b : c2) {
                int ib = id(b);
                if (ib < 0) continue;
                int at = Arrays.binarySearch(sKeys, ((long) ia << 32) | ib);
                if (at < 0) continue;
                int n = 0;
                for (int p = sStart[at]; p < sStart[at + 1] && n < outWords.length; p++) {
                    outWords[n] = sWords[sNext[p]];
                    outScores[n] = sScore[p] & 0xFF;
                    n++;
                }
                return n;
            }
        }
        return 0;
    }
}
