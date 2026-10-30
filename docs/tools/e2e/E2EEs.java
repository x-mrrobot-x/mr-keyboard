package com.mrkeyboard.app;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
 * Ponta a ponta do pacote es (v1.65): classes do APK, lib nativa do PC, dicionário, regras e
 * duas palavras do pacote. Uso: E2EEs dicts/es/main.dict (lê rules.txt e trigrams.bin da pasta).
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
        if (tri.isFile()) MrTrigram.load(new FileInputStream(tri));
        E2ETest.suggest = new Suggest(null, buf);
        Suggest s = E2ETest.suggest;
        s.setCorrectionMode(1);
        System.out.println("dicionário " + bytes.length + " bytes, " + MrRules.get().corrections.size() + " correções");
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
            E2ETest.expect("1ª letra '" + c[0] + "' depois de '" + c[1] + "'", E2ETest.strs(E2ETest.sugg(c[0], c[1])), c[2], 3);
        }
        for (String p : new String[] {"muchas", "buenos", "por", "te", "yo", "de", "que", "xqzwv"}) {
            System.out.printf("      previsão depois de %-10s %s%n", p, MrPredict.forWord(s, p));
        }
        E2ETest.expect("previsão 'muchas'", E2ETest.strs(MrPredict.forWord(s, "muchas")), "gracias", 2);
        String[][] ctx = {{"muchas", "gracias"}, {"por", "favor"}, {"te", "quiero"}, {"buenos", "días"}, {"no", "sé"}, {"lo", "que"}};
        for (String[] c : ctx) System.out.printf("      duas palavras %-14s %s%n", c[0] + " " + c[1], MrPredict.forWords(s, c[0], c[1]));
        for (String b : new String[] {"", "Hola. ", "¿", "Hola, ¡", "dijo "}) System.out.printf("      começo de frase em %-10s %s%n", "'" + b + "'", MrText.atSentenceStart(b));
        s.setCorrectionMode(3);
        String[][] ac = {{"haiga", "1"}, {"nadien", "1"}, {"q", "1"}, {"dijistes", "1"}, {"kiero", "1"},
                         {"ola", "0"}, {"esta", "0"}, {"tenia", "0"}, {"como", "0"}, {"si", "0"}};
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
