package com.mrkeyboard.app;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
* End-to-end of the es pack (v1.65): APK classes, PC native lib, dictionary, rules and
* the pack's two-word model. Usage: E2EEs dicts/es/main.dict (reads rules.txt and trigrams.bin from the folder).
 */
public class E2EEs {
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
            {"q", "que"}, {"xq", "porque"}, {"tb", "también"}, {"ola", "hola"}, {"haiga", "haya"}, {"nadien", "nadie"},
            {"aver", "a ver"}, {"nose", "no sé"}, {"enserio", "en serio"}, {"porfa", "por favor"}, {"dijistes", "dijiste"},
            {"kiero", "quiero"}, {"aora", "ahora"}, {"tambien", "también"}, {"yuvia", "lluvia"}, {"aber", "haber"},
            {"proibir", "prohibir"}, {"qiero", "quiero"}, {"vien", "bien"}, {"caveza", "cabeza"}, {"sapato", "zapato"},
            {"ajencia", "agencia"}, {"trabjo", "trabajo"}, {"graicas", "gracias"}, {"manana", "mañana"},
            {"Q", "Que"}, {"Xq", "Porque"}, {"cancion", "canción"}, {"esta", "está"}, {"despues", "después"},
        };
        for (String[] c : fix) E2ETest.expect(c[0], E2ETest.strs(E2ETest.sugg(c[0], null)), c[1], 2);
        String[][] first = {{"g", "muchas", "gracias"}, {"d", "buenos", "días"}, {"q", "te", "quiero"}};
        for (String[] c : first) {
            E2ETest.expect("1st letter '" + c[0] + "' after '" + c[1] + "'", E2ETest.strs(E2ETest.sugg(c[0], c[1])), c[2], 3);
        }
        for (String p : new String[] {"muchas", "buenos", "por", "te", "yo", "de", "que", "xqzwv"}) {
            System.out.printf("      prediction after %-10s %s%n", p, MrPredict.forWord(s, p));
        }
        E2ETest.expect("prediction 'muchas'", E2ETest.strs(MrPredict.forWord(s, "muchas")), "gracias", 2);
        String[][] ctx = {{"muchas", "gracias"}, {"por", "favor"}, {"te", "quiero"}, {"buenos", "días"}, {"no", "sé"}, {"lo", "que"}};
        for (String[] c : ctx) System.out.printf("      two words %-14s %s%n", c[0] + " " + c[1], MrPredict.forWords(s, c[0], c[1]));
        for (String b : new String[] {"", "Hola. ", "¿", "Hola, ¡", "dijo "}) System.out.printf("      sentence start in %-10s %s%n", "'" + b + "'", MrText.atSentenceStart(b));
        s.setCorrectionMode(3);
        String[][] ac = {{"haiga", "1"}, {"nadien", "1"}, {"q", "1"}, {"dijistes", "1"}, {"kiero", "1"},
                         {"ola", "0"}, {"esta", "0"}, {"tenia", "0"}, {"como", "0"}, {"si", "0"}};
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
