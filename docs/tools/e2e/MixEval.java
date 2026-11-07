package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class MixEval {
    static final int PRED = 0, NEAR = 6, DEL = 7, SWAP = 8, KINDS = 9, COLS = 8;
    static final int MIN_LEN = 4, MAX_K = 5, PROBES = 40, GROUPS = 5;
    static final String[] COL_NAMES = {"space", "1 let", "2 let", "3 let", "4 let", "5 let", "typo 1st", "typo top2"};
    static final String PROBE = "qzxwvk";

    static final class Lang {
        final String id;
        final String[] rows;
        final File tri;
        final MrRules rules;
        final Suggest suggest;

        Lang(String id, File dicts) throws Exception {
            this.id = id;
            File dir = new File(dicts, id);
            rows = rowsOf(id).split(",");
            tri = new File(dir, "trigrams.bin");
            FileInputStream in = new FileInputStream(new File(dir, "rules.txt"));
            MrRules r;
            try {
                r = MrRules.parse(in);
            } finally {
                in.close();
            }
            rules = r;
            byte[] bytes = Files.readAllBytes(new File(dir, "main.dict").toPath());
            ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
            buf.put(bytes);
            buf.rewind();
            suggest = new Suggest(null, buf);
            suggest.setCorrectionMode(1);
        }

        boolean valid(String w) {
            return suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase(Locale.ROOT));
        }
    }

    static String rowsOf(String id) {
        return id.equals("pt-BR") ? "qwertyuiop,asdfghjklç,zxcvbnm"
                : id.equals("es") ? "qwertyuiop,asdfghjklñ,zxcvbnm" : "qwertyuiop,asdfghjkl,zxcvbnm";
    }

    static final class Tok {
        final String w;
        final boolean emb;

        Tok(String w, boolean emb) {
            this.w = w;
            this.emb = emb;
        }
    }

    static final class Ans {
        final String[][] lst = new String[KINDS][];
        final String[] typed = new String[KINDS];
        final long[] ns = new long[KINDS];
        final boolean[] fuzzy = new boolean[KINDS];
        final boolean[] valid = new boolean[KINDS];
    }

    static final class Ev {
        int kind, grp;
        String want, typed;
        List<String> la, lb;
        long ta, tb;
        boolean fa, fb, va, vb, ctxB;
    }

    static final class Run {
        final String title;
        final Lang act, oth;
        final List<Ev> evs = new ArrayList<Ev>();
        final int[] words = new int[GROUPS];
        final int[] cover = new int[6];

        Run(String title, Lang act, Lang oth) {
            this.title = title;
            this.act = act;
            this.oth = oth;
        }
    }

    static Lang cur;
    static final java.util.Set<String> ADDED = new java.util.HashSet<String>();
    static final List<Long> triNs = new ArrayList<Long>();
    static double[] weights;
    static String[] names;

    static void activate(Lang l) {
        if (cur == l) return;
        E2ETest.suggest = l.suggest;
        MrRules.set(l.rules);
        long t0 = System.nanoTime();
        if (!MrTrigram.useNow(l.tri)) {
            throw new IllegalStateException("the native engine did not open " + l.tri);
        }
        triNs.add(System.nanoTime() - t0);
        cur = l;
    }

    static double[] measureSwitch(Lang a, Lang b) {
        long[] sw = new long[PROBES];
        for (int i = 0; i < PROBES; i++) {
            Lang from = i % 2 == 0 ? a : b;
            Lang to = i % 2 == 0 ? b : a;
            activate(from);
            E2ETest.sugg(PROBE, null);
            activate(to);
            long t0 = System.nanoTime();
            E2ETest.sugg(PROBE, null);
            long t1 = System.nanoTime();
            E2ETest.sugg(PROBE, null);
            long t2 = System.nanoTime();
            sw[i] = Math.max(0, (t1 - t0) - (t2 - t1));
        }
        Arrays.sort(sw);
        long tri = 0;
        for (long t : triNs) tri += t;
        return new double[] {sw[PROBES / 2], triNs.isEmpty() ? 0 : (double) tri / triNs.size()};
    }

    static boolean letter(char c) {
        return Character.isLetter(c) || c == '\'' || c == '’' || c == '-';
    }

    static List<Tok> tokens(String line) {
        List<Tok> out = new ArrayList<Tok>();
        StringBuilder sb = new StringBuilder();
        boolean emb = false, wordEmb = false;
        for (int i = 0; i <= line.length(); i++) {
            char c = i < line.length() ? line.charAt(i) : ' ';
            if (letter(c)) {
                if (sb.length() == 0) wordEmb = emb;
                sb.append(c == '’' ? '\'' : c);
                continue;
            }
            if (sb.length() > 0 && sb.toString().matches(".*\\p{L}.*")) out.add(new Tok(sb.toString(), wordEmb));
            sb.setLength(0);
            if (c == '{') emb = true;
            else if (c == '}') emb = false;
        }
        return out;
    }

    static List<List<Tok>> sentences(String file) throws Exception {
        List<List<Tok>> out = new ArrayList<List<Tok>>();
        for (String line : Files.readAllLines(new File(file).toPath(), StandardCharsets.UTF_8)) {
            if (line.trim().length() == 0) continue;
            List<Tok> t = tokens(line);
            if (t.size() >= 2) out.add(t);
        }
        return out;
    }

    static char neighbour(char c, String[] rows) {
        for (String r : rows) {
            int i = r.indexOf(c);
            if (i >= 0) return r.charAt(i + 1 < r.length() ? i + 1 : i - 1 >= 0 ? i - 1 : i);
        }
        return c;
    }

    static String[] typos(String w, String[] rows) {
        int m = w.length() / 2;
        String[] t = new String[3];
        char c = Character.toLowerCase(w.charAt(m));
        char nb = neighbour(c, rows);
        if (nb != c) t[0] = w.substring(0, m) + nb + w.substring(m + 1);
        t[1] = w.substring(0, m) + w.substring(m + 1);
        if (w.charAt(m - 1) != w.charAt(m)) t[2] = w.substring(0, m - 1) + w.charAt(m) + w.charAt(m - 1) + w.substring(m + 1);
        return t;
    }

    static List<CharSequence> predict(Lang l, String p2, String p1) {
        return p2 == null ? MrPredict.forWord(l.suggest, p1) : MrPredict.forWords(l.suggest, p2, p1);
    }

    static Ans session(Lang l, String p2, String p1, String want, String[] ty) {
        activate(l);
        E2ETest.sugg(PROBE, null);
        Ans a = new Ans();
        if (p1 != null) {
            long t0 = System.nanoTime();
            List<CharSequence> pr = predict(l, p2, p1);
            a.ns[PRED] = System.nanoTime() - t0;
            a.lst[PRED] = E2ETest.strs(pr).toArray(new String[0]);
            a.typed[PRED] = "";
            predict(l, p2, p1);
        }
        for (int k = 1; k <= MAX_K && k < want.length(); k++) {
            String typed = want.substring(0, k);
            MrFuzzy.sLastVisits = -1;
            long t0 = System.nanoTime();
            List<String> r = E2ETest.strs(E2ETest.sugg(typed, p1));
            a.ns[k] = System.nanoTime() - t0;
            a.fuzzy[k] = MrFuzzy.sLastVisits >= 0;
            a.lst[k] = r.toArray(new String[0]);
            a.typed[k] = typed;
            a.valid[k] = l.valid(typed);
        }
        for (int t = 0; t < 3; t++) {
            if (ty[t] == null) continue;
            int kind = NEAR + t;
            if (p1 != null) predict(l, p2, p1);
            for (int k = 1; k < ty[t].length(); k++) E2ETest.sugg(ty[t].substring(0, k), p1);
            MrFuzzy.sLastVisits = -1;
            long t0 = System.nanoTime();
            List<String> r = E2ETest.strs(E2ETest.sugg(ty[t], p1));
            a.ns[kind] = System.nanoTime() - t0;
            a.fuzzy[kind] = MrFuzzy.sLastVisits >= 0;
            a.lst[kind] = r.toArray(new String[0]);
            a.typed[kind] = ty[t];
            a.valid[kind] = l.valid(ty[t]);
        }
        return a;
    }

    static int validCount(Lang l, List<Tok> s, int i) {
        int n = 0;
        for (int j = Math.max(0, i - 3); j < i; j++) if (l.valid(s.get(j).w)) n++;
        return n;
    }

    static void collect(Run run, List<List<Tok>> sents, boolean mixed) {
        run.evs.clear();
        Arrays.fill(run.words, 0);
        Arrays.fill(run.cover, 0);
        Lang act = run.act, oth = run.oth;
        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = act.rows[i];
        for (List<Tok> s : sents) {
            for (int i = 0; i < s.size(); i++) {
                Tok tk = s.get(i);
                String want = tk.w;
                boolean vA = act.valid(want), vB = oth.valid(want);
                int grp;
                if (!mixed) {
                    if (want.length() < MIN_LEN) continue;
                    grp = 2;
                } else if (tk.emb) {
                    run.cover[0]++;
                    if (want.length() < MIN_LEN) {
                        run.cover[1]++;
                        continue;
                    }
                    if (vA) {
                        boolean added = ADDED.contains(want.toLowerCase(Locale.ROOT));
                        run.cover[added ? 3 : 2]++;
                        grp = added ? 4 : 3;
                    } else if (!vB) {
                        run.cover[4]++;
                        continue;
                    } else {
                        run.cover[5]++;
                        grp = 0;
                    }
                } else {
                    if (want.length() < MIN_LEN) continue;
                    grp = 1;
                }
                String p1 = i > 0 ? s.get(i - 1).w : null, p2 = i > 1 ? s.get(i - 2).w : null;
                boolean ctxB = validCount(oth, s, i) > validCount(act, s, i);
                String[] ty = typos(want, act.rows);
                Ans a = session(act, p2, p1, want, ty);
                Ans b = session(oth, p2, p1, want, ty);
                run.words[grp]++;
                for (int kind = 0; kind < KINDS; kind++) {
                    if (a.lst[kind] == null || b.lst[kind] == null) continue;
                    Ev e = new Ev();
                    e.kind = kind;
                    e.grp = grp;
                    e.want = want;
                    e.typed = a.typed[kind];
                    e.la = Arrays.asList(a.lst[kind]);
                    e.lb = Arrays.asList(b.lst[kind]);
                    e.ta = a.ns[kind];
                    e.tb = b.ns[kind];
                    e.fa = a.fuzzy[kind];
                    e.fb = b.fuzzy[kind];
                    e.va = a.valid[kind];
                    e.vb = b.valid[kind];
                    e.ctxB = ctxB;
                    run.evs.add(e);
                }
            }
        }
    }

    static boolean answers(List<String> l, String typed) {
        String t = SubtitleEval.fold(typed);
        for (int i = 1; i <= 2 && i < l.size(); i++) {
            String w = SubtitleEval.fold(l.get(i));
            if (w.startsWith(t)) return true;
            int max = t.length() <= 5 ? 1 : 2;
            if (MrFuzzy.distance(t, w, max) <= max) return true;
        }
        return false;
    }

    static boolean asksB(Ev e) {
        if (e.kind == PRED) return e.la.isEmpty();
        return !(e.va || answers(e.la, e.typed)) && (e.vb || answers(e.lb, e.typed));
    }

    static List<Integer> order(int size) {
        List<Integer> o = new ArrayList<Integer>();
        if (size >= 2) o.add(1);
        if (size >= 1) o.add(0);
        if (size >= 3) o.add(2);
        return o;
    }

    static void addScores(Map<String, Double> sc, Map<String, String> spell, List<String> l, boolean pred, double w) {
        if (pred) {
            List<Integer> o = order(l.size());
            for (int r = 0; r < o.size(); r++) put(sc, spell, l.get(o.get(r)), w / (r + 1));
        } else {
            for (int i = 1; i < l.size(); i++) put(sc, spell, l.get(i), w / i);
        }
    }

    static void put(Map<String, Double> sc, Map<String, String> spell, String word, double v) {
        String key = word.toLowerCase(Locale.ROOT);
        Double old = sc.get(key);
        sc.put(key, old == null ? v : old + v);
        if (!spell.containsKey(key)) spell.put(key, word);
    }

    static List<String> fuse(Ev e, double wb) {
        boolean pred = e.kind == PRED;
        Map<String, Double> sc = new LinkedHashMap<String, Double>();
        Map<String, String> spell = new LinkedHashMap<String, String>();
        addScores(sc, spell, e.la, pred, 1.0);
        addScores(sc, spell, e.lb, pred, wb);
        List<String> keys = new ArrayList<String>(sc.keySet());
        for (int i = 1; i < keys.size(); i++) {
            String k = keys.get(i);
            int j = i - 1;
            while (j >= 0 && sc.get(keys.get(j)) < sc.get(k)) {
                keys.set(j + 1, keys.get(j));
                j--;
            }
            keys.set(j + 1, k);
        }
        List<String> out = new ArrayList<String>();
        if (!pred) out.add(!e.la.isEmpty() ? e.la.get(0) : e.lb.isEmpty() ? "" : e.lb.get(0));
        for (int i = 0; i < keys.size() && out.size() < 3; i++) out.add(spell.get(keys.get(i)));
        return out;
    }

    static List<String> gate(Ev e) {
        if (!asksB(e)) return e.la;
        if (e.kind == PRED) return e.lb;
        List<String> out = new ArrayList<String>();
        out.add(e.la.isEmpty() ? e.typed : e.la.get(0));
        if (e.lb.size() > 1) out.add(e.lb.get(1));
        if (e.la.size() > 1) out.add(e.la.get(1));
        return out;
    }

    static List<String> apply(int s, Ev e) {
        if (s == 0) return e.la;
        if (s == 1) return e.lb;
        if (s == 2) return gate(e);
        if (s < 3 + weights.length) return fuse(e, weights[s - 3]);
        return e.ctxB ? e.lb : e.la;
    }

    static void tally(long[][][] st, int s, Ev e) {
        List<String> out = apply(s, e);
        if (e.kind == PRED) {
            add(st, s, 0, SubtitleEval.hit(out, e.want, 0, 2));
        } else if (e.kind <= MAX_K) {
            add(st, s, e.kind, SubtitleEval.hit(out, e.want, 1, 2));
        } else {
            add(st, s, 6, SubtitleEval.hit(out, e.want, 1, 1));
            add(st, s, 7, SubtitleEval.hit(out, e.want, 1, 2));
        }
    }

    static void add(long[][][] st, int s, int col, boolean hit) {
        if (hit) st[s][col][0]++;
        st[s][col][1]++;
    }

    static double pct(long[] c) {
        return 100.0 * c[0] / Math.max(1, c[1]);
    }

    static void table(String title, long[][][] st, int words, int rows) {
        System.out.printf("%n  %s  (%d words)%n", title, words);
        System.out.printf("  %-34s", "strategy");
        for (String c : COL_NAMES) System.out.printf(" %9s", c);
        System.out.println();
        for (int s = 0; s < rows; s++) {
            System.out.printf("  %-34s", names[s]);
            for (int c = 0; c < COLS; c++) System.out.printf(" %9.1f", pct(st[s][c]));
            System.out.println();
        }
        System.out.printf("  %-34s", "n");
        for (int c = 0; c < COLS; c++) System.out.printf(" %9d", st[0][c][1]);
        System.out.println();
    }

    static void drops(long[][][] st) {
        for (int s = 1; s < names.length; s++) {
            double worst = 0;
            int at = 0;
            for (int c = 0; c < COLS; c++) {
                double d = pct(st[0][c]) - pct(st[s][c]);
                if (d > worst) {
                    worst = d;
                    at = c;
                }
            }
            System.out.printf("  %-34s worst drop vs A only: %s%n", names[s],
                    worst < 0.05 ? "none" : String.format(Locale.ROOT, "%.1f points (%s)", worst, COL_NAMES[at]));
        }
    }

    static class Model {
        Lang pushed, triAt;
        final Lang a, b;
        final double sw, tri;

        Model(Lang a, Lang b, Lang start, double sw, double tri) {
            this.a = a;
            this.b = b;
            this.pushed = start;
            this.triAt = start;
            this.sw = sw;
            this.tri = tri;
        }

        double step(Lang l, boolean fuzzy, boolean usesTri, long ns) {
            double t = ns;
            if (fuzzy && pushed != l) {
                t += sw;
                pushed = l;
            }
            if (usesTri && triAt != l) {
                t += tri;
                triAt = l;
            }
            return t;
        }

        double cost(int s, Ev e) {
            boolean tri = e.kind == PRED || e.kind == 1;
            if (s == 0) return step(a, e.fa, tri, e.ta);
            if (s == 1) return step(b, e.fb, tri, e.tb);
            if (s == 2) {
                double t = step(a, e.fa, tri, e.ta);
                if (asksB(e)) t += step(b, e.fb, tri, e.tb);
                return t;
            }
            if (s < 3 + weights.length) return step(a, e.fa, tri, e.ta) + step(b, e.fb, tri, e.tb);
            return e.ctxB ? step(b, e.fb, tri, e.tb) : step(a, e.fa, tri, e.ta);
        }
    }

    static void latency(Run run, double sw, double tri) {
        System.out.printf("%n  modeled time per keystroke, microseconds (measured query times of both languages; one language switch = %.0f us"
                + " for the rules and %.0f us for the trigram file)%n", sw / 1000.0, tri / 1000.0);
        System.out.printf("  %-34s %10s %10s %12s %10s %10s %12s%n", "strategy", "p50 sw", "p95 sw", "p95 ratio sw", "p50 no", "p95 no",
                "p95 ratio no");
        List<Ev> used = new ArrayList<Ev>();
        for (Ev e : run.evs) if (e.grp <= 2) used.add(e);
        double[] base = new double[2];
        for (int s = 0; s < names.length; s++) {
            double[][] p = new double[2][];
            for (int v = 0; v < 2; v++) {
                Model m = new Model(run.act, run.oth, s == 1 ? run.oth : run.act, v == 0 ? sw : 0, v == 0 ? tri : 0);
                double[] t = new double[used.size()];
                for (int i = 0; i < t.length; i++) t[i] = m.cost(s, used.get(i));
                Arrays.sort(t);
                p[v] = new double[] {t[t.length / 2] / 1000.0, t[(int) (t.length * 0.95)] / 1000.0};
                if (s == 0) base[v] = p[v][1];
            }
            System.out.printf("  %-34s %10.1f %10.1f %12.2f %10.1f %10.1f %12.2f%n", names[s], p[0][0], p[0][1], p[0][1] / base[0],
                    p[1][0], p[1][1], p[1][1] / base[1]);
        }
    }

    static void report(Run run, boolean mixed, double sw, double tri) {
        System.out.printf("%n==== %s%n", run.title);
        long[][][][] st = new long[GROUPS][names.length][COLS][2];
        for (Ev e : run.evs) for (int s = 0; s < names.length; s++) tally(st[e.grp], s, e);
        if (mixed) {
            int[] c = run.cover;
            System.out.printf("  embedded words %d: shorter than %d letters %d (left out), unknown in both %d (left out), already in %s %d"
                    + " (F), added to %s by the loanword list %d (N), still unknown in %s %d (E)%n", c[0], MIN_LEN, c[1], c[4], run.act.id, c[2],
                    run.act.id, c[3], run.act.id, c[5]);
            table("E: foreign words still unknown in " + run.act.id + " (known in " + run.oth.id + ")", st[0], run.words[0], names.length);
            table("N: foreign words added to " + run.act.id + " by the loanword list (0% before: they were unknown)", st[4], run.words[4], 1);
            table("F: foreign words " + run.act.id + " already knew", st[3], run.words[3], 1);
            table("M: the words of " + run.act.id + " in the same sentences", st[1], run.words[1], names.length);
            drops(st[1]);
        } else {
            table("words of " + run.act.id + " typed with " + run.oth.id + " installed", st[2], run.words[2], names.length);
            drops(st[2]);
        }
        latency(run, sw, tri);
    }

    public static void main(String[] a) throws Exception {
        File dicts = new File(a[2]);
        Lang act = new Lang(a[0], dicts), oth = new Lang(a[1], dicts);
        String[] w = System.getProperty("w", "0.6").split(",");
        weights = new double[w.length];
        names = new String[4 + w.length];
        names[0] = "A only (active language)";
        names[1] = "B only (the other language)";
        names[2] = "a: B when A has no answer";
        for (int i = 0; i < w.length; i++) {
            weights[i] = Double.parseDouble(w[i]);
            names[3 + i] = "b: merge, weight of B " + w[i];
        }
        names[names.length - 1] = "c: language of the words before";
        int warm = Integer.getInteger("warm", 1);
        String added = System.getProperty("added");
        if (added != null) {
            for (String line : Files.readAllLines(new File(added).toPath(), StandardCharsets.UTF_8)) {
                if (line.trim().length() > 0) ADDED.add(line.split("\t")[0].toLowerCase(Locale.ROOT));
            }
        }
        List<List<Tok>> mixed = sentences(a[3]);
        List<List<Tok>> pureA = sentences(a[4]);
        List<List<Tok>> pureB = sentences(a[5]);
        System.out.printf("MixEval: A = %s (active), B = %s, %d mixed sentences, %d and %d plain ones, weights %s, warm-up rounds %d,"
                + " %d words from the loanword list%n", act.id, oth.id, mixed.size(), pureA.size(), pureB.size(), Arrays.toString(weights), warm,
                ADDED.size());

        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = act.rows[i];
        double[] sw = measureSwitch(act, oth);

        Run r1 = new Run(act.id + " keyboard, mixed sentences (" + act.id + " with " + oth.id + " words)", act, oth);
        for (int i = 0; i <= warm; i++) collect(r1, mixed, true);
        report(r1, true, sw[0], sw[1]);

        Run r2 = new Run(act.id + " keyboard, plain " + act.id + " sentences", act, oth);
        for (int i = 0; i <= warm; i++) collect(r2, pureA, false);
        report(r2, false, sw[0], sw[1]);

        Run r3 = new Run(oth.id + " keyboard, plain " + oth.id + " sentences (roles swapped: A = " + oth.id + ")", oth, act);
        for (int i = 0; i <= warm; i++) collect(r3, pureB, false);
        report(r3, false, sw[0], sw[1]);
    }
}
