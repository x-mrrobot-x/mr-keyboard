package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

/**
* Recent words (v1.75): in simulated sessions (gen_sessions.py), is the next word among the 3
* shown (a) right after the space, (b) after 1, 2 and 3 letters? With and without MrRecent (-Drecent=0 turns it off:
* nothing is recorded). Splits the words the dictionary knows from those it does not (names, slang).
 *
* Usage: java ... com.mrkeyboard.app.RecentEval dictionary.dict trigrams.bin sessions.txt [-Drecent=0] [-Dmax=N]
 */
public class RecentEval {
    static final Pattern TOK = Pattern.compile("\\p{L}+(?:['’-]\\p{L}+)*");

    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        E2ETest.openTrigrams(new File(a[1]));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        String rowsProp = System.getProperty("rows");
        if (rowsProp != null) { String[] r = rowsProp.split(","); for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i]; }
        boolean recent = !"0".equals(System.getProperty("recent"));
        int maxSess = Integer.getInteger("max", 300);
        List<List<String>> sessions = new ArrayList<List<String>>();
        List<String> cur = new ArrayList<String>();
        for (String line : Files.readAllLines(Paths.get(a[2]), StandardCharsets.UTF_8)) {
            if (line.trim().isEmpty()) { if (!cur.isEmpty()) sessions.add(cur); cur = new ArrayList<String>(); }
            else cur.add(line);
        }
        if (!cur.isEmpty()) sessions.add(cur);
        if (sessions.size() > maxSess) sessions = sessions.subList(0, maxSess);
        // [0] known, [1] outside the dictionary; k = 0 (after the space), 1, 2, 3 letters
        int[][] hit = new int[2][4], tot = new int[2][4];
        long calls = 0;
        double ms = 0;
        for (List<String> sess : sessions) {
            MrRecent.clear();
            for (String sentence : sess) {
                List<String> toks = new ArrayList<String>();
                Matcher m = TOK.matcher(sentence);
                while (m.find()) toks.add(m.group());
                for (int i = 0; i < toks.size(); i++) {
                    String w = toks.get(i);
                    if (i >= 1 && w.length() >= 3) {
                        String prev = toks.get(i - 1), prev2 = i >= 2 ? toks.get(i - 2) : null;
                        int g = (s.isValidWord(w) || s.isValidWord(w.toLowerCase())) ? 0 : 1;
                        long t0 = System.nanoTime();
                        List<CharSequence> pl = MrPredict.forWords(s, prev2, prev);
                        ms += (System.nanoTime() - t0) / 1e6; calls++;
                        tot[g][0]++;
                        if (pl != null && contains(pl, w)) hit[g][0]++;
                        for (int k = 1; k <= 3 && k < w.length(); k++) {
                            t0 = System.nanoTime();
                            List<String> l = E2ETest.strs(new ArrayList<CharSequence>(
                                    s.getSuggestions(null, E2ETest.compose(w.substring(0, k)), false, prev)));
                            ms += (System.nanoTime() - t0) / 1e6; calls++;
                            tot[g][k]++;
                            for (int q = 0; q < l.size() && q < 3; q++) {
                                if (l.get(q).equalsIgnoreCase(w)) { hit[g][k]++; break; }
                            }
                        }
                    }
                    if (recent) MrRecent.record(s, w);
                }
                MrRecent.breakPair();
            }
        }
        String[] name = {"dictionary words", "words outside the dictionary"};
        System.out.printf("sessions %d  recent=%s  mean time per query %.3f ms%n", sessions.size(), recent, ms / calls);
        for (int g = 0; g < 2; g++) {
            System.out.printf("  %-28s", name[g]);
            for (int k = 0; k <= 3; k++) System.out.printf("  %s: %5.2f%% (n=%d)", k == 0 ? "space" : k + " letter" + (k > 1 ? "s" : ""), 100.0 * hit[g][k] / Math.max(1, tot[g][k]), tot[g][k]);
            System.out.println();
        }
        int[] th = new int[4], tt = new int[4];
        for (int k = 0; k < 4; k++) { th[k] = hit[0][k] + hit[1][k]; tt[k] = tot[0][k] + tot[1][k]; }
        System.out.printf("  %-28s", "all");
        for (int k = 0; k <= 3; k++) System.out.printf("  %s: %5.2f%%", k == 0 ? "space" : k + " letter" + (k > 1 ? "s" : ""), 100.0 * th[k] / Math.max(1, tt[k]));
        System.out.println();
    }

    static boolean contains(List<CharSequence> l, String w) {
        for (CharSequence c : l) if (c.toString().equalsIgnoreCase(w)) return true;
        return false;
    }
}
