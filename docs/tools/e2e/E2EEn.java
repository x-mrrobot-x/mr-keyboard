package com.mrkeyboard.app;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
* End-to-end of the en-US pack (v1.64): APK classes, PC native lib, dictionary, rules and
* the pack's two-word model. Usage: E2EEn dicts/en-US/main.dict (reads rules.txt and trigrams.bin from the folder).
 */
public class E2EEn {
    public static void main(String[] a) throws Exception {
        byte[] bytes = Files.readAllBytes(Paths.get(a[0]));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        java.io.File dir = new java.io.File(a[0]).getAbsoluteFile().getParentFile();
        MrRules.set(MrRules.parse(new FileInputStream(new java.io.File(dir, "rules.txt"))));
        java.io.File tri = new java.io.File(dir, "trigrams.bin");
        if (tri.isFile()) E2ETest.openTrigrams(tri);
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        s.setCorrectionMode(1);
        System.out.println("dictionary " + bytes.length + " bytes, " + MrRules.get().corrections.size() + " corrections");
        String[][] fix = {
            {"teh", "the"}, {"recieve", "receive"}, {"dont", "don't"}, {"im", "I'm"}, {"i", "I"}, {"u", "you"},
            {"becuase", "because"}, {"thier", "their"}, {"wat", "what"}, {"nife", "knife"},
            {"alot", "a lot"}, {"thankyou", "thank you"}, {"helo", "hello"}, {"beleive", "believe"},
            {"freind", "friend"}, {"tomorow", "tomorrow"}, {"definately", "definitely"}, {"seperate", "separate"},
            {"wierd", "weird"}, {"untill", "until"}, {"goverment", "government"}, {"tbh", "to be honest"},
            {"Dont", "Don't"}, {"Im", "I'm"}, {"probly", "probably"}, {"thx", "thanks"}, {"knowlege", "knowledge"},
            {"writting", "writing"}, {"wich", "which"}, {"realy", "really"}, {"happend", "happened"},
            {"youre", "you're"}, {"cant", "can't"}, {"woudl", "would"}, {"becasue", "because"}, {"amazng", "amazing"},
            {"comming", "coming"}, {"intresting", "interesting"}, {"beautifull", "beautiful"},
        };
        for (String[] c : fix) E2ETest.expect(c[0], E2ETest.strs(E2ETest.sugg(c[0], null)), c[1], 2);
        String[][] first = {{"y", "thank", "you"}, {"t", "want", "to"}, {"m", "very", "much"}};
        for (String[] c : first) {
            E2ETest.expect("1st letter '" + c[0] + "' after '" + c[1] + "'", E2ETest.strs(E2ETest.sugg(c[0], c[1])), c[2], 3);
        }
        for (String p : new String[] {"thank", "how", "I", "want", "going", "of", "in", "the", "xqzwv"}) {
            System.out.printf("      prediction after %-10s %s%n", p, MrPredict.forWord(s, p));
        }
        E2ETest.expect("prediction 'thank'", E2ETest.strs(MrPredict.forWord(s, "thank")), "you", 2);
        String[][] ctx = {{"thank", "you"}, {"I", "want"}, {"how", "are"}, {"see", "you"}, {"in", "the"}, {"I", "don't"}};
        for (String[] c : ctx) System.out.printf("      two words %-12s %s%n", c[0] + " " + c[1], MrPredict.forWords(s, c[0], c[1]));
        s.setCorrectionMode(3);
        String[][] ac = {{"teh", "1"}, {"recieve", "1"}, {"dont", "1"}, {"im", "1"}, {"i", "1"}, {"definately", "1"},
                         {"id", "0"}, {"ill", "0"}, {"its", "0"}, {"were", "0"}, {"well", "0"}, {"lets", "0"}};
        for (String[] c : ac) {
            List<String> l = E2ETest.strs(E2ETest.sugg(c[0], null));
            // like LatinIME: it only swaps on its own if the typed word is not a valid word
            boolean auto = s.hasMinimalCorrection() && !s.isValidWord(c[0]);
            boolean ok = auto == c[1].equals("1");
            if (!ok) E2ETest.fails++;
            System.out.printf("%s autocorrection %-12s -> %-5s (%s)%n", ok ? "OK   " : "FAIL ", c[0], auto, l.size() > 1 ? l.get(1) : "-");
        }
        System.out.println(E2ETest.fails == 0 ? "ALL OK" : E2ETest.fails + " FAILURE(S)");
        System.exit(E2ETest.fails == 0 ? 0 : 1);
    }
}
