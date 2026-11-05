package com.mrkeyboard.app;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.file.*;
import java.util.*;

/** Suggestion output for a list of words, to compare two versions of the app. */
public class Parity {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes); buf.rewind();
        if (a.length > 3) {
            Class<?> r = Class.forName("com.mrkeyboard.app.MrRules");
            java.lang.reflect.Method parse = r.getDeclaredMethod("parse", InputStream.class);
            parse.setAccessible(true);
            Object rules = parse.invoke(null, new FileInputStream(a[3]));
            java.lang.reflect.Method set = r.getDeclaredMethod("set", r);
            set.setAccessible(true);
            set.invoke(null, rules);
        }
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        PrintStream out = new PrintStream(new FileOutputStream(a[2]), true, "UTF-8");
        BufferedReader r = new BufferedReader(new InputStreamReader(new FileInputStream(a[1]), "UTF-8"));
        String w;
        long t0 = System.nanoTime();
        int n = 0;
        while ((w = r.readLine()) != null) {
            if (w.isEmpty()) continue;
            s.setCorrectionMode(1);
            List<String> l = E2ETest.strs(E2ETest.sugg(w, null));
            s.setCorrectionMode(3);
            E2ETest.sugg(w, null);
            boolean auto = s.hasMinimalCorrection();
            out.println(w + "\t" + l.subList(0, Math.min(6, l.size())) + "\t" + auto);
            n++;
        }
        System.out.printf("%d words, %.3f ms each%n", n, (System.nanoTime() - t0) / 1e6 / n / 2);
    }
}
