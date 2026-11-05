package com.mrkeyboard.app;

import java.util.Arrays;
import java.util.HashSet;

/** PC test of the import of words and texts (MrImport, v1.85). Runs through docs/tools/run_java_tests.sh. */
public class ImportTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    static MrImport.Known known(String... words) {
        final HashSet<String> set = new HashSet<String>(Arrays.asList(words));
        return new MrImport.Known() {
            public boolean knows(String w) {
                return set.contains(w);
            }
        };
    }

    static final MrImport.Known PT = known("o", "a", "de", "da", "do", "em", "eu", "vou", "no", "na", "para", "com", "que", "é", "bom", "dia", "mais",
            "reunião", "alinhamento", "conta", "minha", "tenho", "uma", "ver", "meu", "cartão", "usar", "hoje", "ele", "ela", "muito", "obrigado");

    static boolean hasWord(MrImport.Plan p, String w) {
        for (MrImport.NewWord n : p.words) if (n.word.equals(w)) return true;
        return false;
    }

    static MrImport.NewWord word(MrImport.Plan p, String w) {
        for (MrImport.NewWord n : p.words) if (n.word.equals(w)) return n;
        return null;
    }

    static boolean hasPair(MrImport.Plan p, String a, String b) {
        for (MrImport.NewPair n : p.pairs) if (n.a.equals(a) && n.b.equals(b)) return true;
        return false;
    }

    static boolean hasWeight(MrImport.Plan p, int weight) {
        for (MrImport.NewWord n : p.words) if (n.weight == weight) return true;
        return false;
    }

    static boolean ignored(MrImport.Plan p, int reason) {
        for (MrImport.Ignored i : p.ignored) if (i.reason == reason) return true;
        return false;
    }

    /** The text of a string resource read from the XML (what Android would give back: \n, \t, \' and \" turned into the characters). */
    static String resString(String dir, String name) {
        try {
            String xml = new String(java.nio.file.Files.readAllBytes(java.nio.file.Paths.get("res/" + dir + "/mr_strings.xml")), "UTF-8");
            java.util.regex.Matcher m = java.util.regex.Pattern.compile("<string name=\"" + name + "\">(.*?)</string>", java.util.regex.Pattern.DOTALL).matcher(xml);
            if (!m.find()) return null;
            return m.group(1).replace("\\n", "\n").replace("\\t", "\t").replace("\\'", "'").replace("\\\"", "\"")
                    .replace("&lt;", "<").replace("&amp;", "&");
        } catch (java.io.IOException e) {
            return null;
        }
    }

    public static void main(String[] a) {
        // ---------------------------------------------------------------- free text: what becomes a word
        MrImport.Plan p = MrImport.parse("Vou usar o Nubank hoje. Minha conta no Nubank é boa. O cartão do Nubank. Fui no banco.", PT);
        check("free text is not taken for a standard list", !p.standard);
        check("a word the dictionary does not know and seen 3 times is kept (Nubank)", hasWord(p, "Nubank") && word(p, "Nubank").count == 3);
        check("a word seen once and in lower case is not kept (banco, boa)", !hasWord(p, "banco") && !hasWord(p, "boa"));
        check("known words are never kept (conta, cartão, hoje)", !hasWord(p, "conta") && !hasWord(p, "cartão") && !hasWord(p, "hoje"));
        p = MrImport.parse("Hoje vou ver a Marina na reunião. Depois vou comer.", PT);
        check("a name with a capital in the middle of a sentence is kept even once (Marina)", hasWord(p, "Marina"));
        check("a word with a capital only at the start of a sentence, seen once, is not kept (Depois)", !hasWord(p, "Depois"));
        p = MrImport.parse("Marina disse oi. Marina foi embora.", PT);
        check("a capitalized unknown word at the start of a sentence counts when it is seen twice (Marina)", hasWord(p, "Marina"));
        p = MrImport.parse("Hoje é bom. Hoje é muito bom.", PT);
        check("a capitalized known word at the start of a sentence is the ordinary word (Hoje is not kept)", p.words.isEmpty());
        p = MrImport.parse("vou usar o zap. vou ver o zap hoje.", PT);
        check("a lower case unknown word seen twice is kept (zap)", hasWord(p, "zap") && word(p, "zap").weight == MrImport.WEIGHT_DEFAULT);
        StringBuilder many = new StringBuilder();
        for (int i = 0; i < 12; i++) many.append("vou usar o zap. ");
        p = MrImport.parse(many.toString(), PT);
        check("the weight goes up with the use (12 times = 70)", word(p, "zap") != null && word(p, "zap").weight == 70);

        // ---------------------------------------------------------------- free text: what is cleaned
        p = MrImport.parse("12/03/2024 14:05 - Ana: vou usar o zap\n[12/03/24 14:06:10] Ana: vou ver o zap\n12/03/24, 2:07 PM - Bia Souza: o zap é bom", PT);
        check("WhatsApp line prefixes are removed (the names Ana and Bia do not become words)", !hasWord(p, "Ana") && !hasWord(p, "Bia") && !hasWord(p, "Souza"));
        check("... and the lines are still read (zap seen 3 times)", hasWord(p, "zap") && word(p, "zap").count == 3);
        p = MrImport.parse("veja https://exemplo.com/zapzap e www.zapzap.com\nfale com ana@zapzap.com ou +55 (11) 91234-5678\nzapzap zapzap", PT);
        check("links, e-mails and phone numbers give no words", !hasWord(p, "exemplo") && !hasWord(p, "ana") && p.words.size() == 1 && hasWord(p, "zapzap"));
        p = MrImport.parse("kkkkkk\nhahaha\naaaaaa\nrsrsrs\nnoooooo\njajaja\nhehehe", PT);
        check("laughs and repeated letters are dropped", p.words.isEmpty() && p.pairs.isEmpty());
        p = MrImport.parse("abc123 abc123 3pm 3pm 2024 2024", PT);
        check("words glued to digits and numbers are dropped", p.words.isEmpty());
        p = MrImport.parse("zap zap\nzap zap", PT);
        check("a word seen only on lines is counted across lines", hasWord(p, "zap") && word(p, "zap").count == 4);
        StringBuilder longWord = new StringBuilder();
        for (int i = 0; i < 40; i++) longWord.append('x');
        p = MrImport.parse("vou usar " + longWord + " hoje\nvou usar " + longWord, PT);
        check("a word over 32 letters is left out and told", !hasWord(p, longWord.toString()) && ignored(p, MrImport.R_TOO_LONG));

        // ---------------------------------------------------------------- free text: pairs
        p = MrImport.parse("Maria Clara chegou. Vou ver Maria Clara hoje. Maria Clara é boa.", PT);
        check("a pair of unknown words seen 3 times is kept (Maria Clara)", hasPair(p, "Maria", "Clara") && hasWord(p, "Maria") && hasWord(p, "Clara"));
        p = MrImport.parse("vou ver a reunião hoje. vou ver a reunião de novo.", PT);
        check("a pair of known words seen twice is kept (vou ver, ver a, a reunião)", hasPair(p, "vou", "ver") && hasPair(p, "a", "reunião"));
        check("... and one seen once is not (reunião hoje)", !hasPair(p, "reunião", "hoje"));
        p = MrImport.parse("vou ver, a reunião hoje. vou ver, a reunião ontem.", PT);
        check("no pair across a comma (ver a)", !hasPair(p, "ver", "a") && hasPair(p, "a", "reunião"));
        p = MrImport.parse("vou ver a. reunião hoje. vou ver a. reunião ontem.", PT);
        check("no pair across the end of a sentence (a reunião)", !hasPair(p, "a", "reunião"));
        p = MrImport.parse("vou zap zap zap xyz xyz", PT);
        check("a pair needs both words valid: a word that was not kept breaks it", !hasPair(p, "vou", "zap") || hasWord(p, "zap"));

        // ---------------------------------------------------------------- lines that were left out
        p = MrImport.parse("https://exemplo.com/a\n12345\n!!!\nvou ver\nzap zap", PT);
        check("a line with only a link says link", ignored(p, MrImport.R_LINK));
        check("a line with only numbers says number", ignored(p, MrImport.R_NUMBER));
        check("a line without letters says no words", ignored(p, MrImport.R_NO_WORDS));
        check("the count of left out lines is kept (3)", p.ignoredCount == 3);
        StringBuilder lines = new StringBuilder();
        for (int i = 0; i < 300; i++) lines.append("12345\n");
        p = MrImport.parse(lines.toString(), PT);
        check("only the first lines left out are kept for the preview, the total is counted", p.ignored.size() == MrImport.MAX_IGNORED_KEPT && p.ignoredCount == 300);
        check("empty or null text gives an empty plan", MrImport.parse("", PT).words.isEmpty() && MrImport.parse(null, PT).lines == 0);

        // ---------------------------------------------------------------- the standard list
        String std = "# mr-words 1\n# language: pt-BR\n[words]\nNubank\nItaú\t70\n# a comment\n\nbom\n[phrases]\nreunião de alinhamento\nMaria Clara\n[blocked]\nbadword\n";
        check("the header makes it a standard list", MrImport.isStandard(std));
        check("a section header alone also does", MrImport.isStandard("[words]\nzap") && MrImport.isStandard("\n  [PHRASES]\nxx yy"));
        check("a plain text is not", !MrImport.isStandard("vou ver o zap\n# not a header") && !MrImport.isStandard(""));
        p = MrImport.parse(std, PT);
        check("standard list: version and language hint", p.standard && p.version == 1 && "pt-BR".equals(p.languageHint));
        check("[words]: the weight is read, the default is 50", word(p, "Itaú") != null && word(p, "Itaú").weight == 70 && word(p, "Nubank").weight == 50);
        check("[words]: a known word is counted, not stored (bom)", !hasWord(p, "bom") && p.knownSkipped == 1);
        check("[phrases]: unknown words are added, known ones are not (alinhamento is known)", hasWord(p, "Maria") && hasWord(p, "Clara") && !hasWord(p, "reunião") && !hasWord(p, "alinhamento"));
        check("[phrases]: every neighbouring pair is kept, once is enough", hasPair(p, "reunião", "de") && hasPair(p, "de", "alinhamento") && hasPair(p, "Maria", "Clara"));
        check("[blocked]: the words go to the block list", p.blocked.size() == 1 && p.blocked.get(0).equals("badword"));
        check("a clean standard list has no line left out", p.ignoredCount == 0);

        String bad = "[words]\ntwo words\nabc123\nx\nzapzap\t0\nzapzap\t101\nzapzap\tmuito\nza_p\n" + longWord + "\n[stuff]\nzap\n[shortcuts]\npdc\tpau de chuva\n";
        p = MrImport.parse(bad, PT);
        check("[words]: a space says use phrases", ignored(p, MrImport.R_SPACE));
        check("[words]: digits say number", ignored(p, MrImport.R_NUMBER));
        check("[words]: one letter says short", ignored(p, MrImport.R_SHORT));
        check("[words]: a weight out of 1-100 or not a number says weight", ignored(p, MrImport.R_WEIGHT) && !hasWord(p, "zapzap"));
        check("[words]: a character a word cannot have says characters", ignored(p, MrImport.R_CHARS));
        check("[words]: over 32 letters says too long", ignored(p, MrImport.R_TOO_LONG));
        check("an unknown section says section, and so do its lines", ignored(p, MrImport.R_SECTION));
        check("[shortcuts] is read but left out (a later version)", ignored(p, MrImport.R_SHORTCUT));
        p = MrImport.parse("# mr-words 1\nzap\n[words]\nzop\n", PT);
        check("a line before any section is left out", ignored(p, MrImport.R_SECTION) && hasWord(p, "zop") && !hasWord(p, "zap"));
        p = MrImport.parse("# mr-words 2\n[words]\nzop\n", PT);
        check("a newer version of the format is reported", p.version == 2);
        p = MrImport.parse("﻿# mr-words 1\r\n[words]\r\nzop\t80\r\n", PT);
        check("BOM and Windows line ends are accepted", p.standard && word(p, "zop") != null && word(p, "zop").weight == 80);
        p = MrImport.parse("[words]\nzop\nzop\t90\nzop\n", PT);
        check("a word listed twice is one word with the highest weight", p.words.size() == 1 && word(p, "zop").weight == 90);
        p = MrImport.parse("[phrases]\nPedro de Souza\nvou ver\n12345\n", PT);
        check("[phrases]: a line with no words says number; the first word with a capital that the dictionary knows is lower case",
                ignored(p, MrImport.R_NUMBER) && hasPair(p, "vou", "ver") && hasWord(p, "Pedro") && hasWord(p, "Souza"));
        p = MrImport.parse("[phrases]\nVou ver o Pedro\n", PT);
        check("[phrases]: Vou -> vou when the dictionary knows it in lower case", hasPair(p, "vou", "ver") && !hasPair(p, "Vou", "ver"));
        StringBuilder bigPhrase = new StringBuilder("[phrases]\n");
        for (int i = 0; i < 40; i++) bigPhrase.append("zop ");
        p = MrImport.parse(bigPhrase.toString(), PT);
        check("[phrases]: more than 30 words is left out", ignored(p, MrImport.R_PHRASE_LONG));
        check("splitWords takes exactly the number of valid words", MrImport.splitWords("vou ver", 2) != null && MrImport.splitWords("vou", 2) == null
                && MrImport.splitWords("vou ver 3", 2) == null && MrImport.splitWords("vou ver", 1) == null);
        check("checkWord: letters, apostrophe, hyphen are fine", MrImport.checkWord("d'água") == 0 && MrImport.checkWord("guarda-chuva") == 0 && MrImport.checkWord("Itaú") == 0);

        // ---------------------------------------------------------------- the bytes of a file
        try {
            byte[] u8 = "Itaú\nNubank".getBytes("UTF-8");
            check("decode: valid UTF-8 is read as UTF-8", "Itaú\nNubank".equals(MrImport.decode(u8, false)));
            byte[] win = "Itaú\nNubank “ok”".getBytes("windows-1252");
            check("decode: an old Windows file (not UTF-8) is read as Windows-1252", "Itaú\nNubank “ok”".equals(MrImport.decode(win, false)));
            byte[] cutAtChar = "casa ú".getBytes("UTF-8");
            byte[] half = java.util.Arrays.copyOf(cutAtChar, cutAtChar.length - 1);
            check("decode: a UTF-8 file cut in the middle of a character loses only that character", "casa ".equals(MrImport.decode(half, true)));
            check("decode: the same bytes in a file that was not cut are not UTF-8", !"casa ".equals(MrImport.decode(half, false)));
            byte[] bom = new byte[] {(byte) 0xEF, (byte) 0xBB, (byte) 0xBF, '#', ' ', 'm', 'r', '-', 'w', 'o', 'r', 'd', 's', ' ', '1', '\n', '[', 'w', 'o', 'r', 'd', 's', ']', '\n', 'I', 't', 'a', (byte) 0xC3, (byte) 0xBA};
            MrImport.Plan pb = MrImport.parse(MrImport.decode(bom, false), known());
            check("decode: a UTF-8 file with a BOM is read as a standard list", pb.standard && pb.words.size() == 1 && pb.words.get(0).word.equals("Itaú"));
            check("decode: empty and null", "".equals(MrImport.decode(new byte[0], false)) && MrImport.decode(null, false) == null);
        } catch (Exception e) {
            check("decode: no exception (" + e + ")", false);
        }

        // ---------------------------------------------------------------- the prompt for an AI, in the three languages
        String[][] langs = {{"values", "en-US"}, {"values-pt-rBR", "pt-BR"}, {"values-es", "es"}};
        for (String[] l : langs) {
            String prompt = resString(l[0], "mr_import_prompt");
            check(l[1] + ": the prompt for the AI exists", prompt != null && prompt.length() > 200);
            if (prompt == null) continue;
            int at = prompt.indexOf("\n# mr-words 1\n");
            check(l[1] + ": the prompt carries an example answer", at > 0);
            if (at < 0) continue;
            String example = prompt.substring(at + 1);
            int end = example.indexOf("\n\n");
            if (end > 0) example = example.substring(0, end + 1);
            MrImport.Plan q = MrImport.parse(example, known());
            check(l[1] + ": the example in the prompt is read as a standard list with no line left out", q.standard && q.ignoredCount == 0);
            check(l[1] + ": the example has words, a weight and phrases", q.words.size() >= 2 && q.pairs.size() >= 1 && hasWeight(q, 70));
            check(l[1] + ": the example names its own language", q.languageHint != null && q.languageHint.equalsIgnoreCase(l[1]));
            boolean whyAll = true;
            for (int r = 1; r <= MrImport.R_PHRASE_LONG; r++) whyAll &= resString(l[0], "mr_import_why_" + r) != null;
            check(l[1] + ": every reason a line can be left out for has a text", whyAll);
        }

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        if (fail != 0) System.exit(1);
    }
}
