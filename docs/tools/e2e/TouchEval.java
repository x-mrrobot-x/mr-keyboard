package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.text.Normalizer;
import java.util.*;
import java.util.regex.*;

/**
 * Digitação simulada com toques imprecisos (v1.66): cada letra vira um toque com dispersão normal
 * em volta do centro da tecla; a tecla tocada e os vizinhos saem como no ProximityKeyDetector do
 * app (vizinhos em ordem de distância do toque até o centro, dentro de 1,4 largura de tecla).
 * Mede, para palavras tiradas das frases de teste:
 *   - faixa: a palavra certa está entre as 3 posições (0 = digitada);
 *   - autocorreção: o que fica depois do espaço com a autocorreção ligada (como no LatinIME);
 *   - separando palavras que saíram com erro de toque e palavras digitadas certas.
 * Uso: TouchEval dict test.txt idioma(pt|en|es) [n] [sigma]
 */
public class TouchEval {
    static final double KW = 1.0, KH = 1.4;  // tecla: largura 1, altura 1,4
    static String[] rows;
    static double[] cx = new double[65536], cy = new double[65536];
    static boolean[] has = new boolean[65536];
    static List<Character> keys = new ArrayList<Character>();

    static void layout(String lang) {
        String r1 = lang.equals("pt") ? "asdfghjklç" : lang.equals("es") ? "asdfghjklñ" : "asdfghjkl";
        rows = new String[] {"qwertyuiop", r1, "zxcvbnm"};
        double[] off = {0, 0.5, 1.5};
        for (int r = 0; r < 3; r++) {
            for (int k = 0; k < rows[r].length(); k++) {
                char c = rows[r].charAt(k);
                cx[c] = off[r] + k * KW + KW / 2;
                cy[c] = r * KH + KH / 2;
                has[c] = true;
                keys.add(c);
            }
        }
    }

    static Random rnd = new Random(166);

    /** Toca a letra c: devolve {tecla tocada, vizinhos em ordem de distância}. */
    static int[] touch(char c, double sigma) {
        double x = cx[c] + rnd.nextGaussian() * sigma * KW;
        double y = cy[c] + rnd.nextGaussian() * sigma * KH;
        // tecla tocada: a que contém o ponto (ou a mais próxima)
        char hit = 0;
        double best = 1e9;
        List<double[]> near = new ArrayList<double[]>();
        double th = 1.4 * KW;
        for (char k : keys) {
            double dx = cx[k] - x, dy = cy[k] - y;
            double d2 = dx * dx + dy * dy;
            boolean inside = Math.abs(dx) <= KW / 2 && Math.abs(dy) <= KH / 2;
            if (inside) hit = k;
            if (d2 < best) { best = d2; if (hit == 0) hit = k; }
            if (d2 < th * th || inside) near.add(new double[] {d2, k});
        }
        if (hit == 0 || !insideAny(x, y)) {
            // fora de todas: a mais próxima
            double b = 1e9;
            for (char k : keys) {
                double dx = cx[k] - x, dy = cy[k] - y, d2 = dx * dx + dy * dy;
                if (d2 < b) { b = d2; hit = k; }
            }
        }
        Collections.sort(near, new Comparator<double[]>() {
            public int compare(double[] a, double[] b) { return Double.compare(a[0], b[0]); }
        });
        int[] codes = new int[16];
        Arrays.fill(codes, -1);
        int n = 0;
        codes[n++] = hit;
        for (double[] p : near) {
            if (n >= 12) break;
            if ((char) p[1] != hit) codes[n++] = (char) p[1];
        }
        return codes;
    }

    static boolean insideAny(double x, double y) {
        for (char k : keys) if (Math.abs(cx[k] - x) <= KW / 2 && Math.abs(cy[k] - y) <= KH / 2) return true;
        return false;
    }

    static String keyForm(String w, String lang) {
        StringBuilder b = new StringBuilder();
        for (char c : w.toCharArray()) {
            if ((c == 'ç' && lang.equals("pt")) || (c == 'ñ' && lang.equals("es"))) { b.append(c); continue; }
            String d = Normalizer.normalize(String.valueOf(c), Normalizer.Form.NFD).replaceAll("\\p{M}", "");
            b.append(d);
        }
        return b.toString();
    }

    public static void main(String[] a) throws Exception {
        String lang = a[2];
        int want = a.length > 3 ? Integer.parseInt(a[3]) : 3000;
        double sigma = a.length > 4 ? Double.parseDouble(a[4]) : 0.2;
        layout(lang);
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        File dir = new File(a[0]).getAbsoluteFile().getParentFile();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        Suggest s = new Suggest(null, buf);
        Pattern word = Pattern.compile("\\p{L}[\\p{L}']*");
        List<String> words = new ArrayList<String>();
        Random pick = new Random(7);
        for (String line : Files.readAllLines(Paths.get(a[1]))) {
            Matcher m = word.matcher(line);
            while (m.find()) {
                String w = m.group();
                if (!w.equals(w.toLowerCase())) continue;
                if (w.length() >= 2 && w.length() <= 16 && pick.nextInt(4) == 0) words.add(w);
            }
            if (words.size() >= want) break;
        }
        int[] errStrip = new int[2], errAuto = new int[2], tot = new int[2];
        int spoiled = 0, wrongFix = 0;
        double ms = 0;
        List<String> samples = new ArrayList<String>();
        List<String> spoiledSamples = new ArrayList<String>();
        List<String> wrongSamples = new ArrayList<String>();
        for (String w : words) {
            String keysTyped = keyForm(w, lang);
            boolean ok = true;
            for (int i = 0; i < keysTyped.length(); i++) if (!has[keysTyped.charAt(i)] && keysTyped.charAt(i) != '\'') ok = false;
            if (!ok) continue;
            WordComposer wc = new WordComposer();
            StringBuilder typed = new StringBuilder();
            for (int i = 0; i < keysTyped.length(); i++) {
                char c = keysTyped.charAt(i);
                int[] codes;
                if (c == '\'') { codes = new int[16]; Arrays.fill(codes, -1); codes[0] = c; }
                else codes = touch(c, sigma);
                wc.add(codes[0], codes);
                typed.append((char) codes[0]);
            }
            String t = typed.toString();
            int e = t.equals(keysTyped) ? 0 : 1;   // 1 = saiu errado no toque
            s.setCorrectionMode(3);
            long t0 = System.nanoTime();
            List<String> l = E2ETest.strs(s.getSuggestions(null, wc, false, null));
            ms += (System.nanoTime() - t0) / 1e6;
            List<String> strip = l.subList(0, Math.min(3, l.size()));
            boolean inStrip = strip.contains(w) || (e == 0 && strip.contains(keysTyped) && s.isValidWord(keysTyped));
            boolean valid = s.isValidWord(t);
            String after = (!valid && s.hasMinimalCorrection() && l.size() > 1) ? l.get(1) : t;
            tot[e]++;
            if (inStrip) errStrip[e]++;
            // certo: a palavra pretendida, ou a forma sem acento que a pessoa digitaria (esta/está)
            boolean good = after.equals(w) || after.equals(keysTyped);
            if (good) errAuto[e]++;
            else if (e == 1 && !after.equals(t)) wrongFix++;
            // sem erro de toque: "estragada" se a autocorreção trocou por outra palavra
            if (e == 0 && !good) spoiled++;
            if (e == 1 && inStrip && !good && wrongSamples.size() < 30) wrongSamples.add(t + "->" + after + " (" + w + ") " + strip + (valid ? " válida" : "") + (s.hasMinimalCorrection() ? "" : " semcorr"));
            if (e == 0 && !good && spoiledSamples.size() < 12) spoiledSamples.add(t + "->" + after + " (" + w + ")");
            if (e == 1 && !inStrip && samples.size() < 20) samples.add(t + "->" + w + " " + l.subList(0, Math.min(3, l.size())));
        }
        System.out.printf("%s σ=%.2f: %d palavras, %d com erro de toque (%.1f%%)%n", lang, sigma, tot[0] + tot[1], tot[1], 100.0 * tot[1] / (tot[0] + tot[1]));
        System.out.printf("  com erro: certa na faixa %.1f%%, certa depois da autocorreção %.1f%%, trocada por outra palavra %.1f%%%n", 100.0 * errStrip[1] / tot[1], 100.0 * errAuto[1] / tot[1], 100.0 * wrongFix / tot[1]);
        System.out.printf("  sem erro: na faixa %.1f%%, estragadas pela autocorreção %d (%.2f%%)%n", 100.0 * errStrip[0] / tot[0], spoiled, 100.0 * spoiled / tot[0]);
        System.out.printf("  tempo médio por consulta %.2f ms%n", ms / (tot[0] + tot[1]));
        System.out.println("  exemplos perdidos: " + samples);
        System.out.println("  exemplos estragados: " + spoiledSamples);
        System.out.println("  na faixa mas a autocorreção não pegou: " + wrongSamples);
    }
}
