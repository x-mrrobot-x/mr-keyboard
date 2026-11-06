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

    /**
     * S26, context while typing: after "p2 p1", the letters of {@code typed} are typed one by one (the 1st letter is where the keyboard
     * reads the context); with the last letter the word must be one of the 2 suggestions next to the typed word.
     */
    static void ctxType(String tag, String p2, String p1, String typed, String want, boolean gap) {
        if (p2 == null) MrPredict.forWord(suggest, p1); else MrPredict.forWords(suggest, p2, p1);
        List<String> l = null;
        for (int k = 1; k <= typed.length(); k++) l = strip(typed.substring(0, k), p1);
        int at = l.indexOf(want);
        record(tag, (p2 == null ? "" : p2 + " ") + p1 + " | " + typed + " -> " + want, at >= 1 && at <= 2, gap,
                l.subList(0, Math.min(5, l.size())).toString());
    }

    /**
     * S27 (v1.85): like ctxType, but the word must be at exactly {@code index} of the strip at the end: 1 = the center (the previous words confirm
     * the likely word for a valid but rare typed one: "quase semper" -> sempre), 2 = the 3rd place (nothing confirms it: "vou cassa" -> casa).
     */
    static void ctxAt(String tag, String p2, String p1, String typed, String want, int index, boolean gap) {
        if (p2 == null) MrPredict.forWord(suggest, p1); else MrPredict.forWords(suggest, p2, p1);
        List<String> l = null;
        for (int k = 1; k <= typed.length(); k++) l = strip(typed.substring(0, k), p1);
        record(tag, (p2 == null ? "" : p2 + " ") + p1 + " | " + typed + " -> " + want + " at " + index, l.indexOf(want) == index, gap,
                l.subList(0, Math.min(5, l.size())).toString());
    }

    /**
     * S27 on its own (MrFuzzy.alternative): the word the strip keeps for the 3rd place when the typed word is a valid one, or null
     * (expect = null) when nothing should be offered: a common word, or a rare one whose neighbour is not much more frequent. The strip itself
     * is not used here because the lib already offers neighbouring-key words ("fone" -> fome) in every case.
     */
    static void alt(String tag, String typed, String expect) {
        BinaryDictionary main = suggest.mrMainDict();
        MrFuzzy f = MrFuzzy.forDict(main.mrBuffer(), main.mrLength());
        String got = null;
        int own;
        synchronized (f) {
            own = f.ownFrequency(typed);
            if (own > MrFuzzy.ALT_OFFENSIVE_FREQ && own <= MrFuzzy.ALT_TYPED_MAX) {
                f.search(E2ETest.compose(typed), typed);
                got = f.alternative(typed, own, MrFuzzy.ALT_MAX_COST, MrFuzzy.ALT_MIN_FREQ, MrFuzzy.ALT_GAP);
            }
        }
        record(tag, "alternative of '" + typed + "' = " + expect, expect == null ? got == null : expect.equalsIgnoreCase(got), false,
                "own=" + own + " got=" + got);
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
        E2ETest.openTrigrams(new File(dir, "trigrams.bin"));
        suggest = new Suggest(null, buf);
        E2ETest.suggest = suggest;   // the helpers of E2ETest (sugg, compose) use this one
        suggest.setCorrectionMode(1);
        System.out.println("== " + lang + ": dictionary " + bytes.length + " bytes, " + MrRules.get().corrections.size() + " corrections");

        dataIntegrity(lang, bytes);
        if (lang.equals("pt-BR")) ptCases();
        else if (lang.equals("en-US")) enCases();
        else if (lang.equals("es")) esCases();
        helpers();
        importCases(lang);
        limits(lang);
        everyday(lang);

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
        // format v1 (header byte 1 = 1, 22-bit addresses, under 4 MB) or v2 (byte 1 = 2, one more byte per address, under 16 MB)
        record("D1", "dictionary header 200/1 or 200/2", (bytes[0] & 0xFF) >= 200 && (bytes[1] == 0 || bytes[1] == 1 || bytes[1] == 2), false, "format " + bytes[1]);
        record("D1", "dictionary under the address limit of its format", bytes.length < (bytes[1] == 2 ? 0x1000000 : 0x400000), false, bytes.length + " bytes");
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
        // known data defects, listed in docs/suggestion-features.md ("Known gaps"); none left since 1.84 (visavis now points to vis-à-vis)
        List<String> knownBad = Arrays.asList();
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
        predict("S14", null, "tudo", "bem", false);           // was a GAP with pt-BR 5 (que/o/isso, from the news, won); fixed by pt-BR 6
        predict("S14", null, "muito", "obrigado", true);      // GAP (data): tempo/bem/mais win
        predict("S14", null, "eu", "vou", true);              // GAP (data): tenho/não/acho win
        // S26 context while typing: the previous word keeps counting from the 2nd letter on
        ctxType("S26", null, "muito", "ob", "obrigado", false);
        ctxType("S26", null, "por", "fa", "favor", false);
        ctxType("S26", null, "bom", "di", "dia", false);
        ctxType("S26", null, "boa", "no", "noite", false);
        ctxType("S26", null, "feliz", "an", "aniversário", false);
        ctxType("S26", null, "de", "ac", "acordo", false);
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
        typed("S21", "deposi", "depois", 2, false);
        // Known gaps: valid word that is another word / chat words with low frequency / 3-letter errors
        // S27 a valid word that is probably another word: only a suggestion in the 3rd place, never a replacement
        typed("S27", "cassa", "casa", 2, false);
        typed("S27", "cousa", "coisa", 2, false);
        typed("S27", "semper", "sempre", 2, false);
        autocorrect("S27", "cassa", false, false);
        alt("S27", "cassa", "casa");
        alt("S27", "fone", null);                                // a real word: nothing to offer
        alt("S27", "casa", null);                                // a frequent word: not even searched
        // S27 (v1.85) the previous words confirm the likely word: it takes the center instead of the 3rd place (never replaces the typed word)
        ctxAt("S27", null, "quase", "semper", "sempre", 1, false);
        ctxAt("S27", null, "nem", "semper", "sempre", 1, false);
        ctxAt("S27", null, "na", "cassa", "casa", 1, false);
        ctxAt("S27", null, "uma", "cousa", "coisa", 1, false);
        ctxAt("S27", null, "vou", "cassa", "casa", 2, false);    // "vou casa" is not what people write: the context does not confirm it
        autocorrect("S27", "semper", false, false);
        typed("GAP", "ola", "olá", 2, false);
        typed("GAP", "entao", "então", 2, false);
        typed("GAP", "flw", "falou", 2, false);
        typed("GAP", "wpp", "WhatsApp", 2, false);
        typed("GAP", "ifood", "iFood", 2, false);
        typed("GAP", "tiktok", "TikTok", 2, false);
        autocorrect("S19", "flw", true, false);
        typed("GAP", "whats", "WhatsApp", 2, false);
        // C1 everyday words: after 2 letters the word must be among the first 3 completions
        typed("C1", "ta", "tá", 3, false);
        typed("C1", "to", "tô", 3, false);                 // was a GAP with pt-BR 5; fixed by pt-BR 6
        typed("C1", "ne", "né", 3, false);
        typed("C1", "pr", "pra", 3, false);                 // was a GAP with pt-BR 5; fixed by pt-BR 6
        typed("C1", "vo", "vou", 3, true);
    }

    static void enCases() {
        typed("S1", "tomorr", "tomorrow", 2, false);
        // S27 a valid word that is probably another word
        typed("S27", "whee", "where", 2, false);
        typed("S27", "eeks", "weeks", 2, false);
        autocorrect("S27", "whee", false, false);
        alt("S27", "whee", "where");
        alt("S27", "they", null);
        // S27 (v1.85) the previous words confirm the likely word
        ctxAt("S27", null, "few", "eeks", "weeks", 1, false);
        ctxAt("S27", null, "from", "whee", "where", 1, false);
        ctxAt("S27", null, "the", "whee", "where", 2, false);
        // S26 context while typing
        ctxType("S26", null, "thank", "yo", "you", false);
        ctxType("S26", null, "good", "mo", "morning", false);
        ctxType("S26", null, "happy", "bi", "birthday", false);
        ctxType("S26", null, "of", "co", "course", false);
        ctxType("S26", null, "what", "ti", "time", false);
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
        predict("S14", null, "how", "are", true);             // GAP (data): much/to/do win (P(are | how) is about 4%)
        predict("S14", null, "see", "you", false);
        predict("S14", null, "good", "morning", true);        // GAP (data): to/at/night win
        predict("S14", null, "hey", "guys", false);
        predict("S15", "thank", "you", "so", false);          // was a GAP with en-US 4 (to/for/very won); fixed by en-US 5
        predict("S15", "see", "you", "later", false);         // was a GAP with en-US 4 (in/again/at won); fixed by en-US 5
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
        typed("GAP", "tiktok", "TikTok", 2, true);            // GAP (data): the dictionary does not know TikTok (rules cannot point to an unknown word)
        typed("GAP", "wasap", "WhatsApp", 2, false);
        typed("GAP", "ive", "I've", 2, false);
        typed("GAP", "youre", "you're", 2, false);
        typed("C1", "gon", "gonna", 3, false);
        typed("C1", "ye", "yeah", 3, false);                  // was a GAP with en-US 4; fixed by en-US 5
        typed("C1", "do", "don't", 3, false);
    }

    static void esCases() {
        typed("S1", "grac", "gracias", 2, false);
        // S27 a valid word that is probably another word
        typed("S27", "entones", "entonces", 2, false);
        typed("S27", "vece", "veces", 2, false);
        autocorrect("S27", "vece", false, false);
        alt("S27", "vece", "veces");
        alt("S27", "hola", null);                                // a valid greeting with a low frequency: bola is not that much more frequent
        // S27 (v1.85) the previous words confirm the likely word
        ctxAt("S27", null, "muchas", "vece", "veces", 1, false);
        ctxAt("S27", null, "algunas", "vece", "veces", 1, false);
        // S26 context while typing
        ctxType("S26", null, "muchas", "gr", "gracias", false);
        ctxType("S26", null, "por", "fa", "favor", false);
        ctxType("S26", null, "buenos", "di", "días", false);
        ctxType("S26", null, "buenas", "no", "noches", false);
        ctxType("S26", null, "feliz", "cu", "cumpleaños", false);
        ctxType("S26", null, "hasta", "ma", "mañana", false);
        typed("S1", "tambi", "también", 2, false);
        typed("S2", "graciaz", "gracias", 2, false);
        typed("S2", "gola", "hola", 2, false);                // was a GAP with es 3 (hola 78, bola/golazo won); fixed by es 4
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
        typed("S8", "bamos", "vamos", 2, false);              // was a GAP with es 3 (bajos/baños, from the news, won); fixed by es 4
        typed("S8", "vien", "bien", 2, false);
        typed("S9", "ermano", "hermano", 2, false);
        typed("S9", "ablar", "hablar", 2, false);
        typed("S9", "ombre", "hombre", 2, false);             // was a GAP with es 3 ('ombre' is a valid word); fixed by es 4
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
        predict("S14", null, "por", "favor", false);          // was a GAP with es 3 (el/la/qué won); fixed by es 4
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
        typed("GAP", "wasap", "WhatsApp", 2, false);
        typed("GAP", "tio", "tío", 2, false);
        typed("C1", "ho", "hola", 3, true);
        typed("C1", "vam", "vamos", 3, false);
        typed("C1", "gr", "gracias", 3, false);
        typed("C1", "es", "estoy", 3, true);
    }

    // ------------------------------------------------------------------ everyday sentences

    /**
     * Floors of S28 (percent, weighted by sentence; every sentence counts once here), per language: known words, hit after the space,
     * after 1, 2 and 3 letters. They sit about 2 points under what the code measures today (pt-BR 99.9 / 19.9 / 39.8 / 52.7 / 62.4,
     * en-US 100 / 17.7 / 38.3 / 53.7 / 70.3, es 99.9 / 16.1 / 35.7 / 45.4 / 61.3; before v1.84.0 the 2-letter rate was 30.5 / 39.1 / 27.3),
     * so ordinary noise passes and a real loss
     * (an engine change that costs context, a dictionary that forgets everyday words) does not. Raise them when a release improves the
     * rates; never lower one to make a run pass.
     */
    static final Map<String, double[]> FLOORS = new LinkedHashMap<String, double[]>();
    static {
        FLOORS.put("pt-BR", new double[] {98, 17.5, 37.5, 50.5, 60});
        FLOORS.put("en-US", new double[] {98, 15.5, 36, 51.5, 68});
        FLOORS.put("es", new double[] {98, 14, 33.5, 43, 59});
    }

    /**
     * S28: the original everyday sentences of data/everyday_<lang>.txt (about 130 per language, written for this repository, so the test
     * needs no download) are typed word by word as SubtitleEval does; the rates must stay over their floors.
     */
    static void everyday(String lang) throws Exception {
        File f = new File(System.getProperty("everyday", "docs/tools/e2e/data"), "everyday_" + lang + ".txt");
        if (!f.exists()) { record("S28", "sentences file " + f.getPath(), false, false, "missing"); return; }
        List<String> lines = Files.readAllLines(f.toPath(), java.nio.charset.StandardCharsets.UTF_8);
        SubtitleEval.Result r = SubtitleEval.run(lines, false, 3, 10000, 4);
        double[] got = {r.known(), r.rate(0), r.rate(1), r.rate(2), r.rate(3)};
        String[] names = {"known words", "after the space", "1 letter", "2 letters", "3 letters"};
        double[] floor = FLOORS.get(lang);
        for (int i = 0; i < names.length; i++) {
            record("S28", names[i] + " >= " + floor[i] + "%", got[i] >= floor[i], false, String.format("%.1f%% (%d sentences)", got[i], r.sentences));
        }
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


    // ------------------------------------------------------------------ S29: words and pairs added by the user (v1.85)

    /**
     * Fills the two learned dictionaries of the keyboard the way it does at start: the standard list goes through the parser and the saving of an
     * import (MrImport.parse, MrLearned.apply) into a store in memory, and MrLearned.loadFrom puts what was imported into an auto dictionary and a
     * user-pair dictionary, which are handed to Suggest. {@code learnedWords} are put into the auto dictionary directly with the given frequency, as the
     * keyboard does when it learns a word (frequency 1 to 5 is "typed once or twice", from 6 the word is valid).
     */
    static MrWordStore importList(String list) {
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        MrLearned.apply(st, MrImport.parse(list, null), "xx", 1L);
        ImportEval.Words words = new ImportEval.Words();
        ImportEval.Pairs pairs = new ImportEval.Pairs();
        MrLearned.loadFrom(st, words, "xx");
        MrLearned.loadFrom(st, pairs, "xx");
        suggest.setAutoDictionary(words);
        suggest.setUserBigramDictionary(pairs);
        return st;
    }

    static void unload() {
        suggest.setAutoDictionary(null);
        suggest.setUserBigramDictionary(null);
        MrLearned.useStore(new MrMemStore());
    }

    /** How many of the names are one of the 2 suggestions next to the typed prefix, or {@code -1} for the names that are too short for the prefix. */
    static int[] namesInTop2(List<String> names, int letters) {
        int in = 0, counted = 0;
        for (String n : names) {
            if (letters >= n.length()) continue;
            counted++;
            int at = ImportEval.at(strip(n.substring(0, letters).toLowerCase(), null), n);
            if (at == 1 || at == 2) in++;
        }
        return new int[] {in, counted};
    }

    static String listOf(List<String> names, int weight) {
        StringBuilder sb = new StringBuilder("# mr-words 1\n[words]\n");
        for (String n : names) sb.append(n).append('\t').append(weight).append('\n');
        return sb.toString();
    }

    static void importCases(String lang) {
        List<String> names = ImportEval.unknown(lang);
        record("S29", "names the dictionary does not know (>= 8 to measure)", names.size() >= 8, false, String.valueOf(names.size()));
        if (names.size() < 8) return;
        int[] base3 = namesInTop2(names, 3);

        importList(listOf(names, 50));
        int[] w50 = namesInTop2(names, 3);
        record("S29", "weight 50: after 3 letters the name is one of the 2 suggestions (>= 75%)", w50[0] * 4 >= w50[1] * 3, false, w50[0] + " of " + w50[1] + " (without: " + base3[0] + ")");
        boolean valid = true;
        for (String n : names) valid &= suggest.isValidWord(n);
        record("S29", "an added name counts as a valid word (never corrected into another)", valid, false, "");
        autocorrect("S29", names.get(0), false, false);
        importList(listOf(names, 50));
        int[] c4 = namesInTop2(names, 4);
        record("S29", "weight 50: after 4 letters nearly all are one of the 2 suggestions (>= 85%)", c4[0] * 100 >= c4[1] * 85, false, c4[0] + " of " + c4[1]);
        unload();

        importList(listOf(names, 100));
        int[] w100 = namesInTop2(names, 3);
        int[] w100two = namesInTop2(names, 2);
        record("S29", "weight 100: after 3 letters every name is one of the 2 suggestions", w100[0] == w100[1], false, w100[0] + " of " + w100[1]);
        record("S29", "weight 100: after 2 letters more than half are", w100two[0] * 100 > w100two[1] * 55, false, w100two[0] + " of " + w100two[1]);
        unload();

        importList(listOf(names, 5));
        int[] low = namesInTop2(names, 3);
        record("S29", "weight 5: a low weight does not push the name up after 3 letters", low[0] <= base3[0], false, low[0] + " (without: " + base3[0] + ")");
        unload();

        // a word the keyboard learned by itself completes only once it is accepted (frequency 6), not after being typed once or twice
        String n0 = null;
        for (String n : names) {
            if (n.length() > 4 && namesInTop2(java.util.Collections.singletonList(n), 4)[0] == 0) { n0 = n; break; }
        }
        record("S29", "a name that is not suggested without being added (to try the learned words)", n0 != null, false, String.valueOf(n0));
        if (n0 != null) {
            ImportEval.Words once = new ImportEval.Words();
            once.addWord(n0, 5);
            suggest.setAutoDictionary(once);
            int[] seen = namesInTop2(java.util.Collections.singletonList(n0), 4);
            record("S29", "a word typed only twice (frequency 5) is not offered as a completion", seen[0] == 0, false, "in top 2: " + seen[0]);
            ImportEval.Words accepted = new ImportEval.Words();
            accepted.addWord(n0, 130);
            suggest.setAutoDictionary(accepted);
            int[] now = namesInTop2(java.util.Collections.singletonList(n0), 4);
            record("S29", "the same word accepted (frequency 130) is offered after 4 letters", now[0] == 1, false, "in top 2: " + now[0]);
            unload();
        }

        // a blocked word never shows: take the first suggestion of an ordinary prefix, block it, it is gone
        String prefix = lang.equals("pt-BR") ? "cas" : lang.equals("es") ? "cas" : "cou";
        List<String> before = strip(prefix, null);
        String victim = before.size() > 1 ? before.get(1) : null;
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        if (victim != null) {
            MrLearned.block(st, "xx", victim, 1L);
            ImportEval.Words w = new ImportEval.Words();
            MrLearned.loadFrom(st, w, "xx");
            suggest.setAutoDictionary(w);
            List<String> after = strip(prefix, null);
            record("S29", "a blocked word is gone from the suggestions ('" + victim + "' after '" + prefix + "')", !after.contains(victim) && !after.isEmpty(), false, after.toString());
            MrLearned.unblock(st, st.all(MrWordStore.KIND_BLOCKED, "xx").get(0).id);
            ImportEval.Words w2 = new ImportEval.Words();
            MrLearned.loadFrom(st, w2, "xx");
            suggest.setAutoDictionary(w2);
            List<String> again = strip(prefix, null);
            record("S29", "allowed again, it comes back", again.contains(victim), false, again.toString());
        }
        unload();

        // pairs: absent from the 3 predictions of the main dictionary, then present at weight 50 and first at weight 100
        String[][] pairs = ImportEval.pairs(lang);
        int shown = 0, first = 0, absent = 0, tried = 0;
        for (int i = 0; i < 3; i++) {
            String[] p = pairs[i];
            suggest.setUserBigramDictionary(null);
            List<CharSequence> main = MrPredict.forWord(suggest, p[0]);
            boolean wasAbsent = main == null || !E2ETest.strs(main).contains(p[1]);
            if (!wasAbsent) continue;
            absent++;
            for (int weight : new int[] {50, 100}) {
                MrMemStore ws = new MrMemStore();
                MrLearned.useStore(ws);
                ws.add(MrWordStore.KIND_IMPORTED_PAIR, "xx", new MrWordStore.Row(MrWordStore.KIND_IMPORTED_PAIR, p[0], p[1], weight, 1L, 1L));
                ImportEval.Pairs up = new ImportEval.Pairs();
                MrLearned.loadFrom(ws, up, "xx");
                suggest.setUserBigramDictionary(up);
                List<CharSequence> got = MrPredict.forWord(suggest, p[0]);
                List<String> g = got == null ? new ArrayList<String>() : E2ETest.strs(got);
                if (weight == 50) { tried++; if (g.contains(p[1])) shown++; }
                else if (g.indexOf(p[1]) == 1) first++;
            }
        }
        record("S29", "pairs the main dictionary does not predict (>= 2 to measure)", absent >= 2, false, absent + " of 3");
        record("S29", "weight 50: an added pair gets into the 3 predictions", tried > 0 && shown == tried, false, shown + " of " + tried);
        record("S29", "weight 100: an added pair is the first prediction", tried > 0 && first == tried, false, first + " of " + tried);
        unload();
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
