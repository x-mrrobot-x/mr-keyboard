package com.mrkeyboard.app;

import java.io.*;
import java.nio.file.*;
import java.util.*;

/**
 * Arquivo de ouro dos trigramas para o mr-engine (testdata/golden_tri_<idioma>.tsv): o que MrTrigram.find
 * (caminho Java) responde para cada par de pares.txt. Uso:
 *   java -cp app.jar:stubs:. com.mrkeyboard.app.TriDump trigrams.bin pares.txt saida.tsv
 * Linha de saída: w1 TAB w2 TAB n|palavra:pontuação|...
 */
public class TriDump {
    public static void main(String[] a) throws Exception {
        MrNative.sForceJava = true;
        InputStream in = new FileInputStream(a[0]);
        MrTrigram.load(in);
        in.close();
        PrintStream out = new PrintStream(new FileOutputStream(a[2]), false, "UTF-8");
        String[] w = new String[8];
        int[] s = new int[8];
        int hits = 0, n = 0;
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            String[] p = line.split("\t", -1);
            if (p.length < 2) continue;
            Arrays.fill(w, null);
            int c = MrTrigram.find(p[0], p[1], w, s);
            StringBuilder sb = new StringBuilder().append(c);
            for (int k = 0; k < c; k++) sb.append('|').append(w[k]).append(':').append(s[k]);
            out.println(p[0] + "\t" + p[1] + "\t" + sb);
            n++;
            if (c > 0) hits++;
        }
        out.close();
        System.out.println(a[2] + ": " + n + " pares, " + hits + " com continuação");
    }
}
