package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TouchRescore {
    static final double KW = TouchEval.KW, KH = TouchEval.KH;
    static final int NEAR_MAX = 12;

    static final class Touch {
        int[] codes;
        double x, y;
    }

    static final class Strat {
        final String name;
        final double lambda, model;

        Strat(String name, double lambda, double model) {
            this.name = name;
            this.lambda = lambda;
            this.model = model;
        }
    }

    static Touch touch(char c, double sigma, double th, Random rnd) {
        Touch t = new Touch();
        t.x = TouchEval.cx[c] + rnd.nextGaussian() * sigma * KW;
        t.y = TouchEval.cy[c] + rnd.nextGaussian() * sigma * KH;
        char hit = 0, nearest = 0;
        double best = 1e18, lim = th * KW;
        List<double[]> near = new ArrayList<double[]>();
        for (char k : TouchEval.keys) {
            double dx = TouchEval.cx[k] - t.x, dy = TouchEval.cy[k] - t.y, d2 = dx * dx + dy * dy;
            boolean inside = Math.abs(dx) <= KW / 2 && Math.abs(dy) <= KH / 2;
            if (inside) hit = k;
            if (d2 < best) {
                best = d2;
                nearest = k;
            }
            if (inside || d2 < lim * lim) near.add(new double[] {d2, k});
        }
        if (hit == 0) hit = nearest;
        Collections.sort(near, new Comparator<double[]>() {
            public int compare(double[] a, double[] b) {
                return Double.compare(a[0], b[0]);
            }
        });
        t.codes = new int[16];
        Arrays.fill(t.codes, -1);
        int n = 0;
        t.codes[n++] = hit;
        for (double[] p : near) {
            if (n >= NEAR_MAX) break;
            if ((char) p[1] != hit) t.codes[n++] = (char) p[1];
        }
        return t;
    }

    static double loglik(String cand, double[] xs, double[] ys, double sigma) {
        double s = 0;
        for (int j = 0; j < cand.length(); j++) {
            char k = cand.charAt(j);
            if (Double.isNaN(xs[j]) || !TouchEval.has[k]) continue;
            double dx = (xs[j] - TouchEval.cx[k]) / (sigma * KW), dy = (ys[j] - TouchEval.cy[k]) / (sigma * KH);
            s -= (dx * dx + dy * dy) / 2;
        }
        return s;
    }

    static List<String> rerank(List<String> l, int n, double[] xs, double[] ys, double sigma, double lambda, String lang) {
        final List<Integer> slots = new ArrayList<Integer>();
        final double[] score = new double[l.size()];
        for (int i = 1; i < l.size(); i++) {
            String k = TouchEval.keyForm(l.get(i).toLowerCase(Locale.ROOT), lang);
            if (k.length() != n) continue;
            slots.add(i);
            score[i] = loglik(k, xs, ys, sigma) - lambda * i;
        }
        if (slots.size() < 2) return l;
        List<Integer> order = new ArrayList<Integer>(slots);
        Collections.sort(order, new Comparator<Integer>() {
            public int compare(Integer a, Integer b) {
                return Double.compare(score[b], score[a]);
            }
        });
        List<String> out = new ArrayList<String>(l);
        for (int m = 0; m < slots.size(); m++) out.set(slots.get(m), l.get(order.get(m)));
        return out;
    }

    static double pct(int a, int b) {
        return b == 0 ? 0 : 100.0 * a / b;
    }

    public static void main(String[] a) throws Exception {
        String lang = a[2];
        TouchEval.layout(lang);
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        FileInputStream in = new FileInputStream(new File(dir, "rules.txt"));
        try {
            MrRules.set(MrRules.parse(in));
        } finally {
            in.close();
        }
        Suggest s = new Suggest(null, buf);
        int reps = Integer.getInteger("reps", 8);
        String[] sg = System.getProperty("sigmas", "0.15,0.2,0.3").split(",");
        String[] tl = System.getProperty("ths", "1.4,1.1,0.8").split(",");
        String[] ll = System.getProperty("lambdas", "0.5,1,2,4").split(",");
        String[] ml = System.getProperty("model", "0.7,1.5").split(",");

        List<Strat> strats = new ArrayList<Strat>();
        strats.add(new Strat("engine order (today)", -1, 1));
        for (String l : ll) strats.add(new Strat("touch model, lambda " + l, Double.parseDouble(l), 1));
        for (String m : ml) strats.add(new Strat("touch model, lambda 1, sigma x" + m, 1, Double.parseDouble(m)));

        Pattern word = Pattern.compile("\\p{L}[\\p{L}']*");
        List<String> words = new ArrayList<String>();
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            Matcher m = word.matcher(line);
            while (m.find()) {
                String w = m.group();
                if (!w.equals(w.toLowerCase(Locale.ROOT)) || w.length() < 2 || w.length() > 16) continue;
                String k = TouchEval.keyForm(w, lang);
                boolean ok = true;
                for (int i = 0; i < k.length(); i++) if (!TouchEval.has[k.charAt(i)] && k.charAt(i) != '\'') ok = false;
                if (ok) words.add(w);
            }
        }
        System.out.printf("TouchRescore %s: %d words, %d touch sequences each, lambdas %s (nats per list position), model sigma multipliers %s%n",
                lang, words.size(), reps, Arrays.toString(ll), Arrays.toString(ml));

        for (String sgs : sg) {
            double sigma = Double.parseDouble(sgs);
            for (String ths : tl) {
                double th = Double.parseDouble(ths);
                Random rnd = new Random(166);
                int ns = strats.size();
                int[][] strip = new int[ns][2], auto = new int[ns][2], swapped = new int[ns][2], spoiled = new int[ns][2];
                int[] tot = new int[2];
                double ms = 0;
                int queries = 0;
                for (int rep = 0; rep < reps; rep++) {
                    for (String w : words) {
                        String keys = TouchEval.keyForm(w, lang);
                        int n = keys.length();
                        WordComposer wc = new WordComposer();
                        StringBuilder typed = new StringBuilder();
                        double[] xs = new double[n], ys = new double[n];
                        for (int i = 0; i < n; i++) {
                            char c = keys.charAt(i);
                            int[] codes;
                            if (c == '\'') {
                                codes = new int[16];
                                Arrays.fill(codes, -1);
                                codes[0] = c;
                                xs[i] = Double.NaN;
                                ys[i] = Double.NaN;
                            } else {
                                Touch t = touch(c, sigma, th, rnd);
                                codes = t.codes;
                                xs[i] = t.x;
                                ys[i] = t.y;
                            }
                            wc.add(codes[0], codes);
                            typed.append((char) codes[0]);
                        }
                        String t = typed.toString();
                        int e = t.equals(keys) ? 0 : 1;
                        s.setCorrectionMode(3);
                        long t0 = System.nanoTime();
                        List<String> base = E2ETest.strs(s.getSuggestions(null, wc, false, null));
                        ms += (System.nanoTime() - t0) / 1e6;
                        queries++;
                        boolean valid = s.isValidWord(t);
                        boolean fix = s.hasMinimalCorrection();
                        tot[e]++;
                        for (int k = 0; k < ns; k++) {
                            Strat st = strats.get(k);
                            List<String> l = st.lambda < 0 ? base : rerank(base, n, xs, ys, sigma * st.model, st.lambda, lang);
                            List<String> sp = l.subList(0, Math.min(3, l.size()));
                            boolean inStrip = sp.contains(w) || (e == 0 && sp.contains(keys) && s.isValidWord(keys));
                            String after = (!valid && fix && l.size() > 1) ? l.get(1) : t;
                            boolean good = after.equals(w) || after.equals(keys);
                            if (inStrip) strip[k][e]++;
                            if (good) auto[k][e]++;
                            else if (e == 1 && !after.equals(t)) swapped[k][e]++;
                            if (e == 0 && !good) spoiled[k][e]++;
                        }
                    }
                }
                System.out.printf("%n==== %s sigma %.2f, neighbours kept within %.1f key widths: %d touch sequences, %d with a touch error (%.1f%%), %.2f ms per query%n",
                        lang, sigma, th, tot[0] + tot[1], tot[1], pct(tot[1], tot[0] + tot[1]), ms / Math.max(1, queries));
                System.out.printf("  %-36s | %-33s | %s%n", "", "with a touch error", "no touch error");
                System.out.printf("  %-36s | %9s %11s %9s | %9s %9s%n", "strategy", "in strip", "right fix", "swapped", "in strip", "spoiled");
                for (int k = 0; k < ns; k++) {
                    System.out.printf("  %-36s | %9.1f %11.1f %9.1f | %9.1f %9.2f%n", strats.get(k).name, pct(strip[k][1], tot[1]),
                            pct(auto[k][1], tot[1]), pct(swapped[k][1], tot[1]), pct(strip[k][0], tot[0]), pct(spoiled[k][0], tot[0]));
                }
            }
        }
    }
}
