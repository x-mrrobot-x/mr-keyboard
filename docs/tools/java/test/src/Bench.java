import com.mrkeyboard.app.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;
public class Bench {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length); buf.put(bytes); buf.rewind();
        HashSet<String> words = new HashSet<>();
        List<String> pool = new ArrayList<>();
        for (String s : Files.readAllLines(Paths.get(a[1]))) { String[] p = s.split("\t"); words.add(p[0]);
            if (Integer.parseInt(p[1]) >= 100 && p[0].length() >= 4 && p[0].length() <= 12 && p[0].matches("[a-zà-ÿ]+")) pool.add(p[0]); }
        BinaryDictionary dict = new BinaryDictionary(buf, bytes.length, words);
        Random r = new Random(1);
        List<String> typos = new ArrayList<>();
        while (typos.size() < 3000) { String w = pool.get(r.nextInt(pool.size())); int i = 1 + r.nextInt(w.length() - 1);
            String t = r.nextBoolean() ? w.substring(0, i) + w.substring(i + 1) : w.substring(0, i) + "qwertyuiopasdfghjklzxcvbnm".charAt(r.nextInt(26)) + w.substring(i);
            if (!words.contains(t)) typos.add(t); }
        // also prefixes typed keystroke by keystroke (mid-word, not valid)
        List<String> prefixes = new ArrayList<>();
        for (int k = 0; k < 1500; k++) { String w = pool.get(r.nextInt(pool.size())); for (int L = 3; L < w.length(); L++) { String p = w.substring(0, L); if (!words.contains(p)) prefixes.add(p); } }
        for (int round = 0; round < 3; round++) {
            for (List<String> set : Arrays.asList(typos, prefixes)) {
                double[] t = new double[set.size()];
                for (int i = 0; i < set.size(); i++) {
                    Suggest s = new Suggest(dict);
                    WordComposer wc = FuzzyTest.compose(set.get(i));
                    long t0 = System.nanoTime();
                    MrFuzzy.afterWords(s, wc);
                    t[i] = (System.nanoTime() - t0) / 1e6;
                }
                double[] c = t.clone(); Arrays.sort(c); double sum = 0; for (double x : c) sum += x;
                if (round == 2) System.out.printf("%s n=%d average %.3f p50 %.3f p95 %.3f p99 %.3f max %.3f ms%n", set == typos ? "typos   " : "prefixes", c.length, sum / c.length, c[c.length / 2], c[(int) (c.length * .95)], c[(int) (c.length * .99)], c[c.length - 1]);
            }
        }
    }
}
