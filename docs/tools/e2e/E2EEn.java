package com.mrkeyboard.app;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
 * Ponta a ponta do pacote en-US (v1.64): classes do APK, lib nativa do PC, dicionário, regras e
 * duas palavras do pacote. Uso: E2EEn dicts/en-US/main.dict (lê rules.txt e trigrams.bin da pasta).
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
        if (tri.isFile()) MrTrigram.load(new FileInputStream(tri));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        s.setCorrectionMode(1);
        System.out.println("dicionário " + bytes.length + " bytes, " + MrRules.get().corrections.size() + " correções");
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
            E2ETest.expect("1ª letra '" + c[0] + "' depois de '" + c[1] + "'", E2ETest.strs(E2ETest.sugg(c[0], c[1])), c[2], 3);
        }
        for (String p : new String[] {"thank", "how", "I", "want", "going", "of", "in", "the", "xqzwv"}) {
            System.out.printf("      previsão depois de %-10s %s%n", p, MrPredict.forWord(s, p));
        }
        E2ETest.expect("previsão 'thank'", E2ETest.strs(MrPredict.forWord(s, "thank")), "you", 2);
        String[][] ctx = {{"thank", "you"}, {"I", "want"}, {"how", "are"}, {"see", "you"}, {"in", "the"}, {"I", "don't"}};
        for (String[] c : ctx) System.out.printf("      duas palavras %-12s %s%n", c[0] + " " + c[1], MrPredict.forWords(s, c[0], c[1]));
        s.setCorrectionMode(3);
        String[][] ac = {{"teh", "1"}, {"recieve", "1"}, {"dont", "1"}, {"im", "1"}, {"i", "1"}, {"definately", "1"},
                         {"id", "0"}, {"ill", "0"}, {"its", "0"}, {"were", "0"}, {"well", "0"}, {"lets", "0"}};
        for (String[] c : ac) {
            List<String> l = E2ETest.strs(E2ETest.sugg(c[0], null));
            // como o LatinIME: só troca sozinho se a digitada não é palavra válida
            boolean auto = s.hasMinimalCorrection() && !s.isValidWord(c[0]);
            boolean ok = auto == c[1].equals("1");
            if (!ok) E2ETest.fails++;
            System.out.printf("%s autocorreção %-12s -> %-5s (%s)%n", ok ? "OK   " : "FALHA", c[0], auto, l.size() > 1 ? l.get(1) : "-");
        }
        System.out.println(E2ETest.fails == 0 ? "TUDO OK" : E2ETest.fails + " FALHA(S)");
        System.exit(E2ETest.fails == 0 ? 0 : 1);
    }
}
