package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/** Erros de digitação sintéticos: a palavra certa aparece nas 2 posições de sugestão? (v1.64) */
public class TypoEval {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        File rules = a.length > 2 ? new File(a[2]) : new File(dir, "rules.txt");
        MrRules.set(MrRules.parse(new FileInputStream(rules)));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        Map<String, int[]> by = new TreeMap<String, int[]>();
        int hit = 0, n = 0, auto = 0, autoWrong = 0;
        double ms = 0, worst = 0;
        List<String> misses = new ArrayList<String>();
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            String[] p = line.split("\t");
            s.setCorrectionMode(3);
            long t0 = System.nanoTime();
            List<String> l = E2ETest.strs(E2ETest.sugg(p[0], null));
            double d = (System.nanoTime() - t0) / 1e6;
            ms += d; worst = Math.max(worst, d);
            int at = l.indexOf(p[1]);
            boolean ok = at >= 1 && at <= 2;
            int[] k = by.computeIfAbsent(p[2], x -> new int[2]);
            k[1]++; n++;
            if (ok) { hit++; k[0]++; } else if (misses.size() < 25) misses.add(p[0] + "->" + p[1] + " " + l.subList(0, Math.min(4, l.size())));
            boolean valid = s.isValidWord(p[0]);
            if (s.hasMinimalCorrection() && !valid && l.size() > 1) {
                if (l.get(1).equals(p[1])) auto++; else autoWrong++;
            }
        }
        System.out.printf("acerto nas 2 posições: %d/%d = %.1f%%  por tipo: ", hit, n, 100.0 * hit / n);
        for (Map.Entry<String, int[]> e : by.entrySet()) System.out.printf("%s %.0f%%  ", e.getKey(), 100.0 * e.getValue()[0] / e.getValue()[1]);
        System.out.printf("%nautocorreção: certa %d, errada %d; tempo médio %.2f ms, pior %.1f ms%n", auto, autoWrong, ms / n, worst);
        System.out.println("erros: " + misses);
    }
}
