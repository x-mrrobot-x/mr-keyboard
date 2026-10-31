package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

/**
 * Digitação normal (sem erro), v1.75: depois de digitar as k primeiras letras de uma palavra do texto
 * de teste, ela está entre as 3 primeiras entradas da faixa (a 0 é a digitada)? É a medida de que uma
 * mudança na correção NÃO atrapalha quem digita certo. Mostra também o que a 3ª posição guarda de correção.
 *
 * Uso: java ... com.mrkeyboard.app.PrefixEval dicionario.dict texto1.txt [texto2.txt] [-Dn=4000]
 */
public class PrefixEval {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        String rowsProp = System.getProperty("rows");
        if (rowsProp != null) { String[] r = rowsProp.split(","); for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i]; }
        Pattern tok = Pattern.compile("[\\p{L}]+");
        List<String> words = new ArrayList<String>();
        int every = Integer.getInteger("every", 9);
        int cnt = 0;
        for (int f = 1; f < a.length; f++) {
            for (String line : Files.readAllLines(Paths.get(a[f]), StandardCharsets.UTF_8)) {
                Matcher m = tok.matcher(line);
                while (m.find()) {
                    String w = m.group();
                    if (w.length() >= 4 && w.equals(w.toLowerCase()) && (cnt++ % every) == 0 && s.isValidWord(w)) words.add(w);
                }
            }
        }
        int max = Integer.getInteger("n", 6000);
        if (words.size() > max) words = words.subList(0, max);
        int[] hit = new int[7], tot = new int[7];
        int[] first = new int[7];
        double ms = 0;
        long calls = 0;
        for (String w : words) {
            for (int k = 2; k <= 5 && k < w.length(); k++) {
                s.setCorrectionMode(1);
                long t0 = System.nanoTime();
                List<String> l = E2ETest.strs(new ArrayList<CharSequence>(s.getSuggestions(null, E2ETest.compose(w.substring(0, k)), false, null)));
                ms += (System.nanoTime() - t0) / 1e6; calls++;
                tot[k]++;
                int at = -1;
                for (int i = 0; i < l.size() && i < 3; i++) if (l.get(i).equalsIgnoreCase(w)) { at = i; break; }
                if (at >= 0) hit[k]++;
                if (at == 1) first[k]++;
            }
        }
        System.out.printf("palavras %d  tempo médio %.2f ms%n", words.size(), ms / calls);
        for (int k = 2; k <= 5; k++) {
            System.out.printf("  %d letras: alvo nas 3 primeiras %.2f%%  (na 1ª sugestão %.2f%%)  n=%d%n", k, 100.0 * hit[k] / tot[k], 100.0 * first[k] / tot[k], tot[k]);
        }
    }
}
