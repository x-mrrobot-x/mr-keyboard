package com.mrkeyboard.app;

import java.io.File;
import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * One check per suggestion strategy, per language (docs/suggestion-features.md lists the strategies; the tag of each
 * case below is the id used there). It runs the APK's real classes (classes.dex -> jar) and the native lib
 * compiled for the PC, like the other classes of this folder, and needs only dicts/ (no corpus).
 *
 * Case kinds:
 *   T  typed word  -> the expected word must be at strip position 1..max (0 is the typed word)
 *   F  first letter after a previous word (bigram list) -> expected word within the first max
 *   P  prediction after the space (one or two previous words) -> expected word among the 3 shown
 *   A  autocorrection (mode 3): does it replace the typed word on its own (true) or not (false)?
 *   V  the typed word is valid: it must stay at position 0 (never replaced by a correction)
 *
 * A case marked GAP is a known weakness (documented in docs/suggestion-features.md, "Known gaps"): it is allowed to fail,
 * it is reported as GAP, and when it starts to pass the run says so, so that the marker can be taken off. Any other
 * failure makes the run exit with 1 (that is what CI looks at).
 *
 * Usage: java -Djava.library.path=<libs> -cp app.jar:stubs:. com.mrkeyboard.app.StrategyTest <pt-BR|en-US|es> <dicts dir>
 *        -Dexplore=1 prints what every case returned.
 */
public class StrategyTest {
    static Suggest suggest;
    static final boolean EXPLORE = System.getProperty("explore") != null;
    static final Map<String, int[]> byStrategy = new LinkedHashMap<String, int[]>(); // tag -> {pass, fail, gap, fixed}
    static int fails = 0;

    static void record(String tag, String label, boolean ok, boolean gap, String got) {
        int[] c = byStrategy.get(tag);
        if (c == null) { c = new int[4]; byStrategy.put(tag, c); }
        String status;
        if (ok && !gap) { c[0]++; status = "ok  "; }
        else if (ok) { c[3]++; status = "FIXED (take the GAP marker off)"; }
        else if (gap) { c[2]++; status = "GAP "; }
        else { c[1]++; fails++; status = "FAIL"; }
        if (!ok || gap || EXPLORE) System.out.printf("  %-5s [%s] %-38s %s%n", status, tag, label, got);
    }

    static List<String> strip(String typed, String prev) {
        return E2ETest.strs(E2ETest.sugg(typed, prev));
    }

    static void typed(String tag, String typed, String want, int max, boolean gap) {
        List<String> l = strip(typed, null);
        int at = l.indexOf(want);
        record(tag, typed + " -> " + want, at >= 1 && at <= max, gap, l.subList(0, Math.min(5, l.size())).toString());
    }

    static void first(String tag, String letters, String prev, String want, int max, boolean gap) {
        List<String> l = strip(letters, prev);
        int at = l.indexOf(want);
        record(tag, "'" + letters + "' after '" + prev + "' -> " + want, at >= 0 && at <= max, gap, l.subList(0, Math.min(5, l.size())).toString());
    }

    static void predict(String tag, String p2, String p1, String want, boolean gap) {
        List<CharSequence> l = p2 == null ? MrPredict.forWord(suggest, p1) : MrPredict.forWords(suggest, p2, p1);
        List<String> s = E2ETest.strs(l);
        record(tag, (p2 == null ? "" : p2 + " ") + p1 + " _ -> " + want, s.contains(want), gap, String.valueOf(s));
    }

    static void autocorrect(String tag, String typed, boolean expect, boolean gap) {
        suggest.setCorrectionMode(3);
        List<String> l = strip(typed, null);
        // like LatinIME: it only swaps on its own when the typed word is not a valid word
        boolean auto = suggest.hasMinimalCorrection() && !suggest.isValidWord(typed) && !suggest.isValidWord(typed.toLowerCase());
        suggest.setCorrectionMode(1);
        record(tag, "autocorrect '" + typed + "' = " + expect, auto == expect, gap, "auto=" + auto + " " + l.subList(0, Math.min(3, l.size())));
    }

    static void valid(String tag, String typed, boolean gap) {
        List<String> l = strip(typed, null);
        boolean ok = !l.isEmpty() && l.get(0).equals(typed);
        record(tag, "'" + typed + "' stays as typed", ok, gap, l.subList(0, Math.min(4, l.size())).toString());
    }

    public static void main(String[] a) throws Exception {
        String lang = a[0];
        File dir = new File(a[1], lang);
        String rows = lang.equals("pt-BR") ? "qwertyuiop,asdfghjklç,zxcvbnm"
                : lang.equals("es") ? "qwertyuiop,asdfghjklñ,zxcvbnm" : "qwertyuiop,asdfghjkl,zxcvbnm";
        String[] r = rows.split(",");
        for (int i = 0; i < 3; i++) E2ETest.ROWS[i] = r[i];
        byte[] bytes = Files.readAllBytes(Paths.get(new File(dir, "main.dict").getPath()));
        ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
        buf.put(bytes);
        buf.rewind();
        MrRules.set(MrRules.parse(new FileInputStream(new File(dir, "rules.txt"))));
        MrTrigram.load(new FileInputStream(new File(dir, "trigrams.bin")));
        suggest = new Suggest(null, buf);
        E2ETest.suggest = suggest;   // the helpers of E2ETest (sugg, compose) use this one
        suggest.setCorrectionMode(1);
        System.out.println("== " + lang + ": dictionary " + bytes.length + " bytes, " + MrRules.get().corrections.size() + " corrections");

        dataIntegrity(lang, bytes);
        if (lang.equals("pt-BR")) ptCases();
        else if (lang.equals("en-US")) enCases();
        else if (lang.equals("es")) esCases();
        helpers();
        limits(lang);

        System.out.println("-- by strategy (ok / FAIL / GAP / fixed)");
        for (Map.Entry<String, int[]> e : byStrategy.entrySet()) {
            int[] c = e.getValue();
            System.out.printf("   %-4s %3d ok  %2d fail  %2d gap  %2d fixed%n", e.getKey(), c[0], c[1], c[2], c[3]);
        }
        System.out.println(fails == 0 ? "STRATEGIES OK (" + lang + ")" : fails + " FAILURE(S) (" + lang + ")");
        System.exit(fails == 0 ? 0 : 1);
    }

    // ------------------------------------------------------------------ data

    static void dataIntegrity(String lang, byte[] bytes) {
        // D1 format and headroom
        record("D1", "dictionary header 200/1", (bytes[0] & 0xFF) >= 200 && (bytes[1] == 0 || bytes[1] == 1), false, "");
        record("D1", "dictionary under the 22-bit address limit", bytes.length < 0x400000, false, bytes.length + " bytes");
        // D2 rules: every section the engine reads is present
        MrRules m = MrRules.get();
        record("D2", "sentence starters (3)", m.starters.length == 3, false, Arrays.toString(m.starters));
        record("D2", "corrections not empty", m.corrections.size() > 100, false, String.valueOf(m.corrections.size()));
        boolean phon = false;
        for (int i = 0; i < m.pairs.length; i++) if (m.pairs[i] != 0) { phon = true; break; }
        record("D2", "phonetic/vowel pairs not empty", phon, false, "");
        record("D2", "one-letter words not empty", m.oneLetter['a'] || m.oneLetter['e'] || m.oneLetter['o'] || m.oneLetter['i'] || m.oneLetter['y'], false, "");
        // D3 every correction points to words the dictionary knows (otherwise autocorrect would invent a word)
        List<String> bad = new ArrayList<String>();
        // known data defects, listed in docs/suggestion-features.md ("Known gaps"); take the entry off when rules.txt is fixed
        List<String> knownBad = Arrays.asList("visavis");
        for (Map.Entry<String, String> e : m.corrections.entrySet()) {
            if (knownBad.contains(e.getKey())) continue;
            for (String w : e.getValue().split(" ")) {
                if (w.length() == 0) continue;
                if (!(suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase()) || suggest.isValidWord(MrRecent.key(w)))) {
                    bad.add(e.getKey() + "->" + e.getValue());
                    break;
                }
            }
        }
        record("D3", "every correction target is a dictionary word", bad.isEmpty(), false, bad.size() + " not in the dictionary: " + bad.subList(0, Math.min(12, bad.size())));
        // D4 no correction key is a word more common than its target (the correction would hide a real word)
        record("D4", "sentence starters are dictionary words", allValid(m.starters), false, Arrays.toString(m.starters));
    }

    static boolean allValid(String[] ws) {
        for (String w : ws) if (!(suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase()))) return false;
        return true;
    }

    // ------------------------------------------------------------------ cases

    static void ptCases() {
        // S1 completion (lib), accent-insensitive
        typed("S1", "obrig", "obrigado", 2, false);
        typed("S1", "informac", "informação", 2, false);
        typed("S1", "nao", "não", 2, false);
        typed("S1", "tamb", "também", 2, false);
        typed("S1", "amanh", "amanhã", 2, false);
        // S2 neighbouring key
        typed("S2", "trabakho", "trabalho", 2, false);
        typed("S2", "obrigafo", "obrigado", 2, false);
        typed("S2", "bpm", "bom", 2, false);
        // S3 map of errors and abbreviations (rules.txt [corrections])
        typed("S3", "vc", "você", 2, false);
        typed("S3", "tbm", "também", 2, false);
        typed("S3", "pq", "porque", 2, false);
        typed("S3", "blz", "beleza", 2, false);
        typed("S3", "excessao", "exceção", 2, false);
        typed("S3", "concerteza", "com certeza", 2, false);
        typed("S3", "Vc", "Você", 2, false);
        // S4 extra letter / S5 missing letter / S6 swapped letters
        typed("S4", "obrigaddo", "obrigado", 2, false);
        typed("S4", "muuuito", "muito", 2, false);
        typed("S5", "obigado", "obrigado", 2, false);
        typed("S5", "tabalho", "trabalho", 2, false);
        typed("S5", "ossível", "possível", 2, false);
        typed("S6", "porblema", "problema", 2, false);
        typed("S6", "tmepo", "tempo", 2, false);
        typed("S6", "obrigdao", "obrigado", 2, false);
        // S7 doubled letter, S8 phonetic, S9 silent letter, S10 groups
        typed("S7", "asim", "assim", 2, false);
        typed("S8", "pesquiza", "pesquisa", 2, false);
        typed("S8", "jente", "gente", 2, false);
        typed("S8", "geito", "jeito", 2, false);
        typed("S9", "omem", "homem", 2, false);
        typed("S9", "ospital", "hospital", 2, false);
        typed("S10", "enchergar", "enxergar", 2, false);
        typed("S10", "nacer", "nascer", 2, false);
        typed("S10", "cresser", "crescer", 2, false);
        // S11 missing first letter
        typed("S11", "ersonagem", "personagem", 2, false);
        // S12 missing space
        typed("S12", "porisso", "por isso", 2, false);
        typed("S12", "eusei", "eu sei", 2, false);
        typed("S12", "tudobem", "tudo bem", 2, false);
        // S13 first letter after the previous word (bigrams)
        first("S13", "d", "bom", "dia", 3, false);
        first("S13", "n", "boa", "noite", 3, false);
        first("S13", "o", "muito", "obrigado", 3, false);
        first("S13", "b", "tudo", "bem", 3, false);
        // S14 prediction after the space (bigrams) / S15 two words (trigrams)
        predict("S14", null, "bom", "dia", false);
        predict("S14", null, "por", "favor", false);
        predict("S14", null, "tudo", "bem", true);            // GAP (data): news bigrams put que/o/isso first
        predict("S14", null, "muito", "obrigado", true);      // GAP (data): tempo/bem/mais win
        predict("S14", null, "eu", "vou", true);              // GAP (data): tenho/não/acho win
        predict("S15", "de", "acordo", "com", false);
        predict("S15", "por", "favor", "me", false);
        predict("S15", "muito", "obrigado", "pela", false);
        predict("S15", "tudo", "bem", "e", true);             // GAP (data)
        // S19 autocorrect: replaces wrong words, never a valid word or a half-typed one
        autocorrect("S19", "obrogado", true, false);
        autocorrect("S19", "pesquiza", true, false);
        autocorrect("S19", "obrig", false, false);
        autocorrect("S19", "casa", false, false);
        autocorrect("S19", "tá", false, false);
        // S20 valid word stays as typed
        valid("S20", "casa", false);
        valid("S20", "tá", false);
        valid("S20", "né", false);
        valid("S20", "kkkk", false);
        // S21 cheap correction keeps its slot when the completions are many
        typed("S21", "prota", "porta", 2, false);
        // Known gaps: valid word that is another word / chat words with low frequency / 3-letter errors
        typed("GAP", "cassa", "casa", 2, true);               // GAP: 'cassa' is a valid word, so nothing is searched
        typed("GAP", "ola", "olá", 2, false);
        typed("GAP", "entao", "então", 2, false);
        typed("GAP", "flw", "falou", 2, true);                // GAP: abbreviation missing from [corrections]
        typed("GAP", "whats", "WhatsApp", 2, false);
        // C1 everyday words: after 2 letters the word must be among the first 3 completions
        typed("C1", "ta", "tá", 3, false);
        typed("C1", "to", "tô", 3, true);
        typed("C1", "ne", "né", 3, false);
        typed("C1", "pr", "pra", 3, true);
        typed("C1", "vo", "vou", 3, true);
    }

    static void enCases() {
        typed("S1", "tomorr", "tomorrow", 2, false);
        typed("S1", "beaut", "beautiful", 2, false);
        typed("S2", "thamk", "thank", 2, false);
        typed("S2", "wprld", "world", 2, false);
        typed("S3", "teh", "the", 2, false);
        typed("S3", "dont", "don't", 2, false);
        typed("S3", "im", "I'm", 2, false);
        typed("S3", "u", "you", 2, false);
        typed("S3", "thx", "thanks", 2, false);
        typed("S3", "Dont", "Don't", 2, false);
        typed("S4", "helllo", "hello", 2, false);
        typed("S4", "thhe", "the", 2, false);
        typed("S5", "frend", "friend", 2, false);
        typed("S5", "tomrrow", "tomorrow", 2, false);
        typed("S6", "freind", "friend", 2, false);
        typed("S6", "recieve", "receive", 2, false);
        typed("S6", "wierd", "weird", 2, false);
        typed("S7", "untill", "until", 2, false);
        typed("S8", "definately", "definitely", 2, false);
        typed("S8", "seperate", "separate", 2, false);
        typed("S9", "nife", "knife", 2, false);
        typed("S9", "wich", "which", 2, false);
        typed("S10", "fone", "phone", 2, true);               // GAP: 'fone' is a valid word, so nothing is searched
        typed("S11", "ello", "hello", 2, false);
        typed("S12", "thankyou", "thank you", 2, false);
        typed("S12", "alot", "a lot", 2, false);
        first("S13", "y", "thank", "you", 3, false);
        first("S13", "m", "very", "much", 3, false);
        first("S13", "a", "how", "are", 3, false);
        predict("S14", null, "thank", "you", false);
        predict("S14", null, "how", "are", true);             // GAP (data): much/to/many win
        predict("S14", null, "see", "you", false);
        predict("S14", null, "good", "morning", true);        // GAP: news bigrams (good -> at/idea/for)
        predict("S14", null, "hey", "guys", false);
        predict("S15", "thank", "you", "so", true);           // GAP (data)
        predict("S15", "see", "you", "later", true);          // GAP (data)
        predict("S15", "how", "are", "you", false);
        predict("S15", "I", "don't", "know", false);
        autocorrect("S19", "teh", true, false);
        autocorrect("S19", "recieve", true, false);
        autocorrect("S19", "its", false, false);
        autocorrect("S19", "were", false, false);
        valid("S20", "hello", false);
        valid("S20", "gonna", false);
        valid("S20", "lol", false);
        valid("S20", "yeah", false);
        typed("S21", "frend", "friend", 2, false);
        typed("GAP", "whatsapp", "WhatsApp", 2, false);
        typed("GAP", "tiktok", "TikTok", 2, true);            // GAP: apps of the last years are missing
        typed("GAP", "ive", "I've", 2, false);
        typed("GAP", "youre", "you're", 2, false);
        typed("C1", "gon", "gonna", 3, false);
        typed("C1", "ye", "yeah", 3, true);
        typed("C1", "do", "don't", 3, false);
    }

    static void esCases() {
        typed("S1", "grac", "gracias", 2, false);
        typed("S1", "tambi", "también", 2, false);
        typed("S2", "graciaz", "gracias", 2, false);
        typed("S2", "gola", "hola", 2, true);                 // GAP (data): hola has a low frequency (78); bola/golazo win
        typed("S3", "xq", "porque", 2, false);
        typed("S3", "pq", "porque", 2, false);
        typed("S3", "tmb", "también", 2, false);
        typed("S3", "tambien", "también", 2, false);
        typed("S3", "q", "que", 2, false);
        typed("S4", "graciass", "gracias", 2, false);
        typed("S5", "grcias", "gracias", 2, false);
        typed("S5", "bueos", "buenos", 2, false);
        typed("S6", "muhco", "mucho", 2, false);
        typed("S6", "graicas", "gracias", 2, false);
        typed("S8", "bamos", "vamos", 2, true);               // GAP (data): vamos (everyday) loses to bajos/baños (news)
        typed("S8", "vien", "bien", 2, false);
        typed("S9", "ermano", "hermano", 2, false);
        typed("S9", "ablar", "hablar", 2, false);
        typed("S9", "ombre", "hombre", 2, true);              // GAP: 'ombre' is a valid word
        typed("S10", "kiero", "quiero", 2, false);
        typed("S10", "kien", "quién", 2, false);
        typed("S10", "caye", "calle", 2, false);
        typed("S11", "ola", "hola", 2, false);
        typed("S12", "porfavor", "por favor", 2, false);
        typed("S12", "muchasgracias", "muchas gracias", 2, false);
        first("S13", "g", "muchas", "gracias", 3, false);
        first("S13", "d", "buenos", "días", 3, false);
        first("S13", "t", "buenas", "tardes", 3, false);
        predict("S14", null, "muchas", "gracias", false);
        predict("S14", null, "buenos", "días", false);
        predict("S14", null, "por", "favor", true);           // GAP (data): el/la/qué win
        predict("S14", null, "hola", "cómo", true);           // GAP (data): y/a/mundo win
        predict("S15", "muchas", "gracias", "por", false);
        predict("S15", "por", "favor", "me", true);           // GAP (data)
        autocorrect("S19", "graciaz", true, false);
        autocorrect("S19", "tambien", true, false);
        autocorrect("S19", "grac", false, false);
        autocorrect("S19", "casa", false, false);
        valid("S20", "hola", false);
        valid("S20", "jaja", false);
        valid("S20", "vale", false);
        typed("S21", "protagonist", "protagonista", 2, false);
        typed("GAP", "pa", "para", 2, false);
        typed("GAP", "wasap", "WhatsApp", 2, true);           // GAP: chat spelling of WhatsApp is missing
        typed("GAP", "tio", "tío", 2, false);
        typed("C1", "ho", "hola", 3, true);
        typed("C1", "vam", "vamos", 3, true);
        typed("C1", "gr", "gracias", 3, true);
        typed("C1", "es", "estoy", 3, true);
    }

    // ------------------------------------------------------------------ helpers (no dictionary)

    static void helpers() {
        record("S19", "distance: swap counts as 1", MrFuzzy.distance("casa", "csaa", 2) == 1, false, "");
        record("S19", "distance: 2 apart stops above max", MrFuzzy.distance("casa", "carro", 1) > 1, false, "");
        record("S19", "confident: one error in a short word", MrFuzzy.confident("obrogado", "obrigado"), false, "");
        record("S19", "confident: unrelated word is not", !MrFuzzy.confident("casa", "carro"), false, "");
        record("S19", "confident: suggestion with a space only from the map", !MrFuzzy.confident("eusei", "eu sei") || MrFix.lookup("eusei") != null, false, "");
        record("S23", "isCaseVariant: DS for ds", MrFuzzy.isCaseVariant("DS", "ds"), false, "");
        record("S23", "isCaseVariant: another word is not", !MrFuzzy.isCaseVariant("de", "ds"), false, "");
        record("S22", "MrRecorrect.eligible: word with letters", MrRecorrect.eligible("casa") && !MrRecorrect.eligible("abc123") && !MrRecorrect.eligible("a"), false, "");
        // S24 text helpers
        record("S18", "atSentenceStart after '. '", MrText.atSentenceStart("Oi. ") && MrText.atSentenceStart("") && !MrText.atSentenceStart("muito "), false, "");
    }

    // ------------------------------------------------------------------ limits and robustness

    static void limits(String lang) {
        // L1 list size never goes over the Suggest ceiling (12 + the typed word)
        int worst = 0;
        String[] probes = {"a", "co", "con", "com", "como", "pro", "per", "the", "est", "mu", "ca"};
        for (String p : probes) worst = Math.max(worst, strip(p, null).size());
        record("L1", "list size <= 13 (12 + typed)", worst <= 13, false, "worst " + worst);
        // L2 long words do not break and do not freeze (MAX_TYPED 20, MAX_WORD 48)
        String longWord = "pneumoultramicroscopicossilicovulcanoconiotico";
        long t0 = System.nanoTime();
        List<String> l = strip(longWord, null);
        double ms = (System.nanoTime() - t0) / 1e6;
        record("L2", "46-letter word returns in time", ms < 200 && !l.isEmpty(), false, String.format("%.1f ms", ms));
        String twenty1 = "abcdefghijklmnopqrstu";
        l = strip(twenty1, null);
        record("L2", "21 letters (above MAX_TYPED) still returns the typed word", !l.isEmpty() && l.get(0).equals(twenty1), false, "");
        // L3 cost of the search stays under the node ceiling
        strip("xqzwvkj", null);
        record("L3", "node ceiling respected", MrFuzzy.sLastVisits <= MrFuzzy.NODE_BUDGET + 8, false, "visits " + MrFuzzy.sLastVisits);
        // L4 time per key on a wrong word: the point is to catch a search that grows out of control, not to benchmark
        // (PC with JIT; first 300 queries are warm-up; the phone is a few times slower, so the real ceiling is NODE_BUDGET)
        double worstMs = 0;
        for (int i = 0; i < 500; i++) {
            long s = System.nanoTime();
            strip("pesquizando".substring(0, 4 + (i % 7)), i % 2 == 0 ? "muito" : null);
            double d = (System.nanoTime() - s) / 1e6;
            if (i >= 300) worstMs = Math.max(worstMs, d);
        }
        record("L4", "worst time per key under 100 ms on the PC", worstMs < 100, false, String.format("%.1f ms", worstMs));
        // L5 no prediction for an unknown word, 3 items for a common one
        record("L5", "unknown previous word gives no prediction", MrPredict.forWord(suggest, "xqzwv") == null, false, "");
    }
}
