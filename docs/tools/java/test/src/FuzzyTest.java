import com.mrkeyboard.app.BinaryDictionary;
import com.mrkeyboard.app.MrFuzzy;
import com.mrkeyboard.app.Suggest;
import com.mrkeyboard.app.WordComposer;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;

/** Teste da camada Java de reserva (MrFuzzy + MrFix) sobre o .dict, no PC. */
public class FuzzyTest {
    static final String[] ROWS = {"qwertyuiop", "asdfghjklç", "zxcvbnm"};

    static int[] codesFor(char c) {
        int[] out = new int[16];
        java.util.Arrays.fill(out, -1);
        out[0] = c;
        char b = Character.toLowerCase(c);
        int n = 1;
        for (int r = 0; r < 3; r++) {
            int k = ROWS[r].indexOf(b);
            if (k < 0) continue;
            int[][] nb = {{r, k - 1}, {r, k + 1}, {r - 1, k}, {r - 1, k + 1}, {r + 1, k - 1}, {r + 1, k}};
            for (int[] p : nb) {
                if (p[0] < 0 || p[0] > 2 || p[1] < 0 || p[1] >= ROWS[p[0]].length()) continue;
                out[n++] = ROWS[p[0]].charAt(p[1]);
            }
        }
        return out;
    }

    static WordComposer compose(String typed) {
        WordComposer wc = new WordComposer();
        for (int i = 0; i < typed.length(); i++) wc.add(typed.charAt(i), codesFor(typed.charAt(i)));
        return wc;
    }

    static List<String> lines(String path) throws Exception {
        List<String> out = new ArrayList<String>();
        BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream(path), "UTF-8"));
        String s;
        while ((s = r.readLine()) != null) if (!s.isEmpty() && !s.startsWith("#")) out.add(s);
        r.close();
        return out;
    }

    static java.lang.reflect.Field visitsField;
    static int visits() throws Exception {
        if (visitsField == null) { visitsField = MrFuzzy.class.getDeclaredField("sLastVisits"); visitsField.setAccessible(true); }
        return visitsField.getInt(null);
    }

    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        HashSet<String> words = new HashSet<String>();
        List<String> freqLines = lines(a[1]);
        for (String s : freqLines) words.add(s.split("\t")[0]);
        BinaryDictionary dict = new BinaryDictionary(buf, bytes.length, words);
        // aquecimento
        String[] warm = {"obrogado", "excessao", "trabakho", "nescessario", "prota", "concerteza", "adevogado", "sombrancelha"};
        for (int i = 0; i < 3000; i++) {
            Suggest s = new Suggest(dict);
            MrFuzzy.afterWords(s, compose(warm[i % warm.length]));
        }
        // casos
        int ok3 = 0, total = 0;
        double sum = 0, worst = 0;
        long vsum = 0;
        for (String line : lines(a[2])) {
            String[] p = line.split("\t");
            Suggest s = new Suggest(dict);
            long t0 = System.nanoTime();
            MrFuzzy.afterWords(s, compose(p[0]));
            double ms = (System.nanoTime() - t0) / 1e6;
            sum += ms;
            worst = Math.max(worst, ms);
            vsum += visits();
            int at = s.words.indexOf(p[1]);
            boolean hit = at >= 0 && at < 3;
            total++;
            if (hit) ok3++;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < Math.min(5, s.words.size()); i++) sb.append(s.words.get(i)).append(' ');
            System.out.printf("%s %-13s -> %-13s %6.3f ms %5d nós | %s%n", hit ? "OK   " : (at >= 0 ? "POS" + (at + 1) + " " : "FALHA"), p[0], p[1], ms, visits(), sb);
        }
        System.out.printf("casos: %d/%d com a esperada entre as 3 primeiras; média %.3f ms, pior %.3f ms; nós visitados em média %d%n", ok3, total, sum / total, worst, vsum / total);

        // erros sintéticos sobre palavras frequentes
        if (a.length > 3) {
            Random rnd = new Random(42);
            List<String> pool = new ArrayList<String>();
            for (String s : freqLines) {
                String[] p = s.split("\t");
                String w = p[0];
                if (Integer.parseInt(p[1]) >= 110 && w.length() >= 4 && w.length() <= 12 && w.equals(w.toLowerCase()) && w.matches("[a-zà-ÿ]+")) pool.add(w);
            }
            String[] kinds = {"vizinha", "falta", "sobra", "dobrada", "troca", "fonetica"};
            int[] hit = new int[kinds.length], cnt = new int[kinds.length], valid = new int[kinds.length];
            double tsum = 0, tworst = 0;
            long tv = 0; int vmax = 0;
            int runs = Integer.parseInt(a[3]);
            for (int it = 0; it < runs; it++) {
                String w = pool.get(rnd.nextInt(pool.size()));
                int k = it % kinds.length;
                String t = mutate(w, k, rnd);
                if (t == null || t.equals(w)) continue;
                if (words.contains(t)) { valid[k]++; continue; }
                Suggest s = new Suggest(dict);
                long t0 = System.nanoTime();
                MrFuzzy.afterWords(s, compose(t));
                double ms = (System.nanoTime() - t0) / 1e6;
                tsum += ms;
                tworst = Math.max(tworst, ms);
                tv += visits();
                if (visits() > vmax) vmax = visits();
                cnt[k]++;
                int at = s.words.indexOf(w);
                if (at >= 0 && at < 3) hit[k]++;
            }
            int all = 0, allHit = 0;
            for (int k = 0; k < kinds.length; k++) {
                System.out.printf("  %-9s %4d/%4d (%.0f%%)  [viraram palavra válida: %d]%n", kinds[k], hit[k], cnt[k], 100.0 * hit[k] / Math.max(1, cnt[k]), valid[k]);
                all += cnt[k];
                allHit += hit[k];
            }
            System.out.printf("sintéticos: %d/%d (%.0f%%) com a original entre as 3 primeiras; média %.3f ms, pior %.3f ms; nós: média %d, máx %d%n", allHit, all, 100.0 * allHit / all, tsum / all, tworst, tv / all, vmax);
        }
    }

    static String mutate(String w, int kind, Random r) {
        int n = w.length();
        int i = 1 + r.nextInt(n - 1);
        switch (kind) {
            case 0: { // tecla vizinha
                int[] c = codesFor(w.charAt(i));
                int m = 0; while (m < 16 && c[m] > 0) m++;
                if (m < 2) return null;
                return w.substring(0, i) + (char) c[1 + r.nextInt(m - 1)] + w.substring(i + 1);
            }
            case 1: return w.substring(0, i) + w.substring(i + 1);
            case 2: {
                int[] c = codesFor(w.charAt(i));
                int m = 0; while (m < 16 && c[m] > 0) m++;
                return w.substring(0, i) + (char) c[r.nextInt(m)] + w.substring(i);
            }
            case 3: return w.substring(0, i) + w.charAt(i) + w.substring(i);
            case 4: if (i + 1 >= n) i = n - 2; return w.substring(0, i) + w.charAt(i + 1) + w.charAt(i) + w.substring(i + 2);
            default: {
                String[][] sw = {{"ss", "s"}, {"ç", "ss"}, {"ç", "s"}, {"s", "z"}, {"z", "s"}, {"x", "ch"}, {"ch", "x"}, {"g", "j"}, {"j", "g"}, {"ce", "se"}, {"ci", "si"}, {"qu", "k"}, {"lh", "li"}, {"nh", "ni"}, {"h", ""}, {"rr", "r"}, {"sc", "s"}, {"xc", "c"}};
                List<String[]> ok = new ArrayList<String[]>();
                for (String[] p : sw) if (w.indexOf(p[0], 1) > 0) ok.add(p);
                if (ok.isEmpty()) return null;
                String[] p = ok.get(r.nextInt(ok.size()));
                int at = w.indexOf(p[0], 1);
                return w.substring(0, at) + p[1] + w.substring(at + p[0].length());
            }
        }
    }
}
