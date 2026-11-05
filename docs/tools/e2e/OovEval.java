package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

/**
* Correct words the dictionary does not know (names, slang, acronyms, rare terms), v1.75: with
* autocorrection on, how many would the keyboard swap on its own for another? It is the risk of a more
* aggressive correction: it is only worth it if this does not go up. It also counts how many had some suggestion in position 1.
 *
* Usage: java ... com.mrkeyboard.app.OovEval dictionary.dict text1.txt [text2.txt]   (-Dn=3000)
 */
public class OovEval {
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
        LinkedHashSet<String> oov = new LinkedHashSet<String>();
        for (int f = 1; f < a.length; f++) {
            for (String line : Files.readAllLines(Paths.get(a[f]), StandardCharsets.UTF_8)) {
                Matcher m = tok.matcher(line);
                while (m.find()) {
                    String w = m.group();
                    if (w.length() < 4 || w.equals(w.toUpperCase())) continue;
                    if (s.isValidWord(w) || s.isValidWord(w.toLowerCase())) continue;
                    oov.add(w);
                }
            }
        }
        List<String> words = new ArrayList<String>(oov);
        int max = Integer.getInteger("n", 4000);
        if (words.size() > max) words = words.subList(0, max);
        int fire = 0;
        for (String w : words) {
            s.setCorrectionMode(3);
            List<String> l = E2ETest.strs(new ArrayList<CharSequence>(s.getSuggestions(null, E2ETest.compose(w), false, null)));
            if (s.hasMinimalCorrection() && l.size() > 1) fire++;
        }
        System.out.printf("words outside the dictionary %d  autocorrection would swap %d = %.2f%%%n", words.size(), fire, 100.0 * fire / words.size());
    }
}
