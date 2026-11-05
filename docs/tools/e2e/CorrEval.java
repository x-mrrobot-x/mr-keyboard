package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/**
* Correction over synthetic typos (gen_typos_all.py), v1.75: does the right word show up in positions
* 1 and 2 of the strip (0 is the typed word)? Splits by typo type and by whether the wrong word is (or not)
* a valid dictionary word. It also shows the 1st position alone (what autocorrection would use).
 *
* Usage: java ... com.mrkeyboard.app.CorrEval dictionary.dict typos.tsv [rules.txt] [--noprox]
*   --noprox  builds the word with the letters only (no neighbouring keys), as the re-correction did up to 1.74
* -Drows=qwertyuiop,asdfghjklç,zxcvbnm  layout used for the neighbouring keys
* -Dkind=del_mid  only one typo type;  -Dmisses=1 -Dnmiss=60  lists the typos it got wrong
 */
public class CorrEval {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        File rules = new File(dir, "rules.txt");
        boolean noprox = false;
        for (int i = 2; i < a.length; i++) {
            if (a[i].equals("--noprox")) noprox = true; else rules = new File(a[i]);
        }
        MrRules.set(MrRules.parse(new FileInputStream(rules)));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        String rowsProp = System.getProperty("rows");
        if (rowsProp != null) {
            String[] r = rowsProp.split(",");
            for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i];
        }
        String only = System.getProperty("kind");     // -Dkind=del_mid: only this typo type
        Map<String, int[]> by = new TreeMap<String, int[]>();   // type/valid -> {top1, top2, n}
        int[] tot = new int[3];
        double ms = 0, worst = 0;
        List<String> misses = new ArrayList<String>();
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            String[] p = line.split("\t");
            if (!s.isValidWord(p[1])) continue;          // the right word has to exist in the dictionary
            if (only != null && !p[2].equals(only)) continue;
            boolean valid = s.isValidWord(p[0]);
            s.setCorrectionMode(1);
            WordComposer wc;
            if (noprox) {
                wc = new WordComposer();
                for (int i = 0; i < p[0].length(); i++) wc.add(p[0].charAt(i), new int[] {p[0].charAt(i)});
            } else {
                wc = E2ETest.compose(p[0]);
            }
            long t0 = System.nanoTime();
            List<String> l = E2ETest.strs(new ArrayList<CharSequence>(s.getSuggestions(null, wc, false, null)));
            double d = (System.nanoTime() - t0) / 1e6;
            ms += d; worst = Math.max(worst, d);
            int at = l.indexOf(p[1]);
            boolean top1 = at == 1, top2 = at >= 1 && at <= 2;
            String key = p[2] + (valid ? " (wrong is a valid word)" : "");
            int[] k = by.computeIfAbsent(key, x -> new int[3]);
            k[2]++; tot[2]++;
            if (top1) { k[0]++; tot[0]++; }
            if (top2) { k[1]++; tot[1]++; }
            else if (!valid && misses.size() < Integer.getInteger("nmiss", 40)) misses.add(p[0] + "->" + p[1] + " " + l.subList(0, Math.min(4, l.size())));
        }
        System.out.printf("TOTAL  n=%d  1st position %.1f%%  in the 2 positions %.1f%%  mean time %.2f ms, worst %.1f ms%n",
                tot[2], 100.0 * tot[0] / tot[2], 100.0 * tot[1] / tot[2], ms / tot[2], worst);
        for (Map.Entry<String, int[]> e : by.entrySet()) {
            int[] k = e.getValue();
            System.out.printf("  %-40s n=%-5d 1st %.1f%%  2 positions %.1f%%%n", e.getKey(), k[2], 100.0 * k[0] / k[2], 100.0 * k[1] / k[2]);
        }
        if (System.getProperty("misses") != null) System.out.println("misses: " + misses);
    }
}
