package com.mrkeyboard.app;

import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * v1.85: turns the material of the screen "Add words and texts" into a plan (new words, pairs, blocked words and the lines that were left out).
 * Pure Java, no Android: the PC test (ImportTest) runs it. Nothing is saved here; MrLearned.apply saves what the user keeps in the preview.
 *
 * Two kinds of material:
 *  - the standard list ("Mr Keyboard word list", docs/suggestion-features.md, "The two screens"): a header "# mr-words 1", sections [words], [phrases], [blocked]
 *    ([shortcuts] is read but left out: it comes in a later version). Every line is checked and counted.
 *  - free text (anything else): split in sentences; links, e-mails, phone numbers, numbers, WhatsApp/Telegram line prefixes, laughs and repeated
 *    letters are dropped. A word is kept only if the main dictionary does not know it and it appears at least twice (once when written with a capital
 *    in the middle of a sentence: a name). A pair is kept when both words are valid and it appears at least twice.
 */
final class MrImport {
    private MrImport() { }

    /** The longest word the dictionaries of the keyboard take. */
    static final int MAX_WORD = 32;
    /** Words in one phrase of the standard list. */
    static final int MAX_PHRASE = 30;
    /** The default weight, and the weight of what appears often in a free text. */
    static final int WEIGHT_DEFAULT = 50;
    /** Distinct pairs followed in a free text (a 2 MB text has far more; the rest are rare ones). */
    static final int MAX_PAIR_CANDIDATES = 200000;
    /** Ignored lines kept for the preview (the total is counted apart). */
    static final int MAX_IGNORED_KEPT = 200;

    // reasons a line (or a word) was left out; the screen has one text for each (mr_import_why_<n>)
    static final int R_NO_WORDS = 1;
    static final int R_LINK = 2;
    static final int R_NUMBER = 3;
    static final int R_TOO_LONG = 4;
    static final int R_CHARS = 5;
    static final int R_SPACE = 6;
    static final int R_WEIGHT = 7;
    static final int R_SECTION = 8;
    static final int R_SHORTCUT = 9;
    static final int R_SHORT = 10;
    static final int R_PHRASE_LONG = 11;

    /** Whether the main dictionary of the language knows the word (the screen reads it from the installed pack). */
    interface Known {
        boolean knows(String word);
    }

    static final class NewWord {
        final String word;
        int weight;
        int count;
        /** The user can untick a word (a typo) in the preview. */
        boolean checked = true;

        NewWord(String word, int weight, int count) {
            this.word = word;
            this.weight = weight;
            this.count = count;
        }
    }

    static final class NewPair {
        final String a;
        final String b;
        int weight;
        int count;

        NewPair(String a, String b, int weight, int count) {
            this.a = a;
            this.b = b;
            this.weight = weight;
            this.count = count;
        }
    }

    static final class Ignored {
        final int line;
        final String text;
        final int reason;

        Ignored(int line, String text, int reason) {
            this.line = line;
            this.text = text;
            this.reason = reason;
        }
    }

    static final class Plan {
        boolean standard;
        /** Version of the standard format in the header (0 = no header). */
        int version;
        /** The "# language:" line of the file, or null. */
        String languageHint;
        int lines;
        final ArrayList<NewWord> words = new ArrayList<NewWord>();
        final ArrayList<NewPair> pairs = new ArrayList<NewPair>();
        final ArrayList<String> blocked = new ArrayList<String>();
        final ArrayList<Ignored> ignored = new ArrayList<Ignored>();
        int ignoredCount;
        /** Words the dictionary already knows (not stored: it would only cost memory). */
        int knownSkipped;
        /** The pairs of a free text were cut at MAX_PAIR_CANDIDATES. */
        boolean pairsCut;

        int checkedWords() {
            int n = 0;
            for (NewWord w : words) if (w.checked) n++;
            return n;
        }

        void ignore(int line, String text, int reason) {
            ignoredCount++;
            if (ignored.size() < MAX_IGNORED_KEPT) {
                String t = text.trim();
                if (t.length() > 60) t = t.substring(0, 60) + "…";
                ignored.add(new Ignored(line, t, reason));
            }
        }
    }

    private static final Pattern WORD = Pattern.compile("\\p{L}[\\p{L}\\p{M}'’-]*");
    private static final Pattern URL = Pattern.compile("(?i)\\b(?:https?://|www\\.)\\S+");
    private static final Pattern EMAIL = Pattern.compile("[\\w.+-]+@[\\w-]+(?:\\.[\\w-]+)+");
    private static final Pattern PHONE = Pattern.compile("\\+?\\d[\\d\\s().-]{6,}\\d");
    private static final Pattern DIGIT = Pattern.compile("\\d");
    private static final Pattern DIGITS = Pattern.compile("\\p{L}*\\d[\\p{L}\\d]*");
    /** "[12/03/24 14:05] Ana:", "12/03/2024 14:05 - Ana:", "12/03/24, 2:05 PM - Ana:" (WhatsApp), "Ana, [12.03.2024 14:05]" is not covered. */
    private static final Pattern CHAT_PREFIX = Pattern.compile(
            "^\\s*\\[?\\d{1,4}[/.\\-]\\d{1,2}[/.\\-]\\d{1,4},?\\s+\\d{1,2}:\\d{2}(?::\\d{2})?(?:\\s?[AaPp]\\.?[Mm]\\.?)?\\]?\\s*(?:[-–—]\\s*)?(?:[^:]{1,40}:\\s*)?");
    /** Laughs: kkk, hahaha, hehe, jajaja, rsrs. A run of one letter (4 or more) is dropped as well. */
    private static final Pattern LAUGH = Pattern.compile(
            "(?i)k{3,}|(?:ha){2,}h?|(?:he){2,}h?|(?:hi){2,}h?|(?:ho){2,}h?|(?:ja){2,}j?|(?:je){2,}j?|(?:ji){2,}j?|(?:rs){2,}|(?:kk)+k?");
    private static final Pattern RUN = Pattern.compile("(?i)(\\p{L})\\1{3,}");

    /**
     * The bytes of a file -> text: UTF-8 when they are valid UTF-8, otherwise Windows-1252 (the old Notepad/Excel files, "Itaú" is one byte there).
     * A file that was cut at its size limit may end in the middle of a character: up to 3 bytes of the end are dropped before giving up on UTF-8.
     * A BOM stays in the text; parse() drops it.
     */
    static String decode(byte[] b, boolean cut) {
        if (b == null) return null;
        for (int drop = 0; drop <= (cut ? 3 : 0) && drop <= b.length; drop++) {
            try {
                CharsetDecoder d = Charset.forName("UTF-8").newDecoder().onMalformedInput(CodingErrorAction.REPORT).onUnmappableCharacter(CodingErrorAction.REPORT);
                return d.decode(ByteBuffer.wrap(b, 0, b.length - drop)).toString();
            } catch (CharacterCodingException e) {
                // not (complete) UTF-8: try with fewer bytes, then the old code page
            }
        }
        try {
            return new String(b, "windows-1252");
        } catch (Exception e) {
            try {
                return new String(b, "ISO-8859-1");
            } catch (Exception e2) {
                return new String(b);
            }
        }
    }

    /** The text is a standard list: it has the header or a known section. */
    static boolean isStandard(String text) {
        if (text == null) return false;
        int pos = 0;
        int n = text.length();
        while (pos < n) {
            int end = text.indexOf('\n', pos);
            if (end < 0) end = n;
            String line = text.substring(pos, end).trim();
            if (line.startsWith("﻿")) line = line.substring(1).trim();
            pos = end + 1;
            if (line.length() == 0) continue;
            String low = line.toLowerCase(Locale.ROOT);
            if (low.startsWith("# mr-words")) return true;
            if (low.equals("[words]") || low.equals("[phrases]") || low.equals("[blocked]") || low.equals("[shortcuts]")) return true;
        }
        return false;
    }

    static Plan parse(String text, Known known) {
        Plan plan = new Plan();
        if (text == null) return plan;
        text = text.replace("\r\n", "\n").replace('\r', '\n');
        if (text.startsWith("﻿")) text = text.substring(1);
        if (isStandard(text)) {
            plan.standard = true;
            parseStandard(text, known, plan);
        } else {
            parseFree(text, known, plan);
        }
        return plan;
    }

    // ------------------------------------------------------------------ the standard list

    private static void parseStandard(String text, Known known, Plan plan) {
        String[] lines = text.split("\n", -1);
        String section = null;
        HashMap<String, NewWord> words = new HashMap<String, NewWord>();
        HashMap<String, NewPair> pairs = new HashMap<String, NewPair>();
        HashSet<String> blocked = new HashSet<String>();
        for (int i = 0; i < lines.length; i++) {
            String raw = lines[i];
            String line = raw.trim();
            if (line.length() == 0) continue;
            plan.lines++;
            if (line.startsWith("#")) {
                comment(line, plan);
                continue;
            }
            if (line.startsWith("[") && line.endsWith("]")) {
                section = line.substring(1, line.length() - 1).trim().toLowerCase(Locale.ROOT);
                if (!section.equals("words") && !section.equals("phrases") && !section.equals("blocked") && !section.equals("shortcuts")) {
                    plan.ignore(i + 1, line, R_SECTION);
                    section = "?";
                }
                continue;
            }
            if (section == null || section.equals("?")) {
                plan.ignore(i + 1, line, R_SECTION);
            } else if (section.equals("words")) {
                standardWord(i + 1, raw, known, plan, words);
            } else if (section.equals("phrases")) {
                standardPhrase(i + 1, line, known, plan, words, pairs);
            } else if (section.equals("blocked")) {
                String w = line;
                int why = checkWord(w);
                if (why != 0) plan.ignore(i + 1, line, why);
                else if (blocked.add(w.toLowerCase(Locale.ROOT).replace('’', '\''))) plan.blocked.add(w.replace('’', '\''));
            } else {
                plan.ignore(i + 1, line, R_SHORTCUT);
            }
        }
        plan.words.addAll(words.values());
        plan.pairs.addAll(pairs.values());
    }

    private static void comment(String line, Plan plan) {
        String body = line.substring(1).trim();
        String low = body.toLowerCase(Locale.ROOT);
        if (low.startsWith("mr-words")) {
            String v = body.substring("mr-words".length()).trim();
            try {
                plan.version = Integer.parseInt(v);
            } catch (NumberFormatException e) {
                plan.version = 1;
            }
        } else if (low.startsWith("language:")) {
            String l = body.substring("language:".length()).trim();
            if (l.length() > 0 && l.length() <= 12) plan.languageHint = l;
        }
    }

    /** 0 if the text is a word the keyboard can take, otherwise the reason. */
    static int checkWord(String w) {
        if (w.indexOf(' ') >= 0 || w.indexOf('\t') >= 0) return R_SPACE;
        if (w.length() > MAX_WORD) return R_TOO_LONG;
        for (int i = 0; i < w.length(); i++) {
            if (Character.isDigit(w.charAt(i))) return R_NUMBER;
        }
        if (!WORD.matcher(w).matches()) return R_CHARS;
        if (w.length() < 2) return R_SHORT;
        return 0;
    }

    private static void standardWord(int no, String raw, Known known, Plan plan, HashMap<String, NewWord> words) {
        String w = raw.trim();
        int weight = WEIGHT_DEFAULT;
        int tab = raw.indexOf('\t');
        if (tab >= 0) {
            w = raw.substring(0, tab).trim();
            String ws = raw.substring(tab + 1).trim();
            try {
                weight = Integer.parseInt(ws);
            } catch (NumberFormatException e) {
                weight = -1;
            }
            if (weight < 1 || weight > 100) {
                plan.ignore(no, raw, R_WEIGHT);
                return;
            }
        }
        int why = checkWord(w);
        if (why != 0) {
            plan.ignore(no, raw, why);
            return;
        }
        w = w.replace('’', '\'');
        if (knows(known, w)) {
            plan.knownSkipped++;
            return;
        }
        NewWord old = words.get(w);
        if (old == null) words.put(w, new NewWord(w, weight, 1));
        else {
            old.count++;
            old.weight = Math.max(old.weight, weight);
        }
    }

    private static void standardPhrase(int no, String line, Known known, Plan plan, HashMap<String, NewWord> words, HashMap<String, NewPair> pairs) {
        ArrayList<String> toks = new ArrayList<String>();
        Matcher m = WORD.matcher(clean(line));
        while (m.find()) {
            String t = trimToken(m.group()).replace('’', '\'');
            if (t.length() == 0) continue;
            if (t.length() > MAX_WORD) {
                plan.ignore(no, line, R_TOO_LONG);
                return;
            }
            toks.add(t);
        }
        if (toks.isEmpty()) {
            plan.ignore(no, line, DIGITS.matcher(line).find() ? R_NUMBER : R_NO_WORDS);
            return;
        }
        if (toks.size() > MAX_PHRASE) {
            plan.ignore(no, line, R_PHRASE_LONG);
            return;
        }
        String prev = null;
        for (int i = 0; i < toks.size(); i++) {
            String t = toks.get(i);
            String low = t.toLowerCase(Locale.ROOT);
            // the first word of a phrase written with a capital is an ordinary word when the dictionary knows it in lower case
            if (i == 0 && !t.equals(low) && known != null && known.knows(low) && !isAllCaps(t)) t = low;
            if (t.length() >= 2 && !knows(known, t)) {
                NewWord old = words.get(t);
                if (old == null) words.put(t, new NewWord(t, WEIGHT_DEFAULT, 1));
                else old.count++;
            }
            if (prev != null) {
                String key = prev + "\u0000" + t;
                NewPair p = pairs.get(key);
                if (p == null) pairs.put(key, new NewPair(prev, t, WEIGHT_DEFAULT, 1));
                else p.count++;
            }
            prev = t;
        }
    }

    // ------------------------------------------------------------------ free text

    private static String clean(String line) {
        line = URL.matcher(line).replaceAll(" . ");
        line = EMAIL.matcher(line).replaceAll(" . ");
        line = PHONE.matcher(line).replaceAll(" . ");
        return line;
    }

    private static String trimToken(String t) {
        int e = t.length();
        while (e > 0 && (t.charAt(e - 1) == '-' || t.charAt(e - 1) == '\'' || t.charAt(e - 1) == '’')) e--;
        return t.substring(0, e);
    }

    private static boolean isAllCaps(String t) {
        return t.length() > 1 && t.equals(t.toUpperCase(Locale.ROOT)) && !t.equals(t.toLowerCase(Locale.ROOT));
    }

    static boolean isNoise(String t) {
        return LAUGH.matcher(t).matches() || RUN.matcher(t).find();
    }

    private static boolean knows(Known known, String w) {
        if (known == null) return false;
        if (known.knows(w)) return true;
        String low = w.toLowerCase(Locale.ROOT);
        return !low.equals(w) && known.knows(low);
    }

    /** One word of a free text and where it stands. */
    private static final class Tok {
        final String text;
        final boolean sentenceStart;
        /** Written with a capital that is not at the start of a sentence. */
        final boolean capMiddle;
        /** The word is next to the previous one (nothing but spaces between them). */
        final boolean joined;

        Tok(String text, boolean sentenceStart, boolean capMiddle, boolean joined) {
            this.text = text;
            this.sentenceStart = sentenceStart;
            this.capMiddle = capMiddle;
            this.joined = joined;
        }
    }

    private static void parseFree(String text, Known known, Plan plan) {
        String[] lines = text.split("\n", -1);
        ArrayList<Tok[]> sentences = new ArrayList<Tok[]>();
        LinkedHashMap<String, int[]> counts = new LinkedHashMap<String, int[]>();   // surface -> {count, capMiddle(0/1)}
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            if (line.trim().length() == 0) continue;
            plan.lines++;
            String body = CHAT_PREFIX.matcher(line).replaceFirst("");
            boolean hadLink = URL.matcher(body).find() || EMAIL.matcher(body).find() || PHONE.matcher(body).find();
            boolean hadDigits = DIGIT.matcher(body).find();
            String cleaned = clean(body);
            ArrayList<Tok> run = new ArrayList<Tok>();
            Matcher m = WORD.matcher(cleaned);
            int lastEnd = -1;
            boolean sentStart = true;
            int used = 0;
            boolean tooLong = false;
            while (m.find()) {
                String gap = lastEnd < 0 ? "" : cleaned.substring(lastEnd, m.start());
                lastEnd = m.end();
                String g = gap.trim();
                boolean joined = g.length() == 0 && !run.isEmpty();
                if (g.length() > 0) {
                    if (!run.isEmpty()) {
                        sentences.add(run.toArray(new Tok[run.size()]));
                        run = new ArrayList<Tok>();
                    }
                    sentStart = endsSentence(g);
                }
                String t = trimToken(m.group()).replace('’', '\'');
                // a token glued to digits ("abc123", "3pm") is a code, not a word
                if ((m.end() < cleaned.length() && Character.isDigit(cleaned.charAt(m.end())))
                        || (m.start() > 0 && Character.isDigit(cleaned.charAt(m.start() - 1)))) {
                    hadDigits = true;
                    flush(sentences, run);
                    run = new ArrayList<Tok>();
                    sentStart = false;
                    continue;
                }
                if (t.length() > MAX_WORD) {
                    tooLong = true;
                    plan.ignore(i + 1, t, R_TOO_LONG);
                    flush(sentences, run);
                    run = new ArrayList<Tok>();
                    sentStart = false;
                    continue;
                }
                if (isNoise(t)) {
                    flush(sentences, run);
                    run = new ArrayList<Tok>();
                    sentStart = false;
                    continue;
                }
                boolean cap = Character.isUpperCase(t.charAt(0));
                String surface = t;
                boolean capMiddle = cap && !sentStart && !isAllCaps(t);
                if (cap && sentStart && !isAllCaps(t)) {
                    String low = t.toLowerCase(Locale.ROOT);
                    if (known != null && known.knows(low)) surface = low;
                }
                run.add(new Tok(surface, sentStart, capMiddle, joined));
                if (t.length() >= 2) {   // "a", "o", "I" take part in the pairs but are never stored as words
                    int[] c = counts.get(surface);
                    if (c == null) {
                        c = new int[2];
                        counts.put(surface, c);
                    }
                    c[0]++;
                    if (capMiddle) c[1] = 1;
                }
                used++;
                sentStart = false;
            }
            flush(sentences, run);
            if (used == 0 && !tooLong) {
                plan.ignore(i + 1, line, hadLink ? R_LINK : (hadDigits ? R_NUMBER : R_NO_WORDS));
            }
        }
        // 1) the words: unknown to the dictionary and seen twice (or once with a capital in the middle of a sentence)
        HashMap<String, Integer> accepted = new HashMap<String, Integer>();
        for (Map.Entry<String, int[]> e : counts.entrySet()) {
            String w = e.getKey();
            int[] c = e.getValue();
            if (knows(known, w)) continue;
            if (c[0] >= 2 || c[1] == 1) {
                int weight = c[0] >= 10 ? 70 : (c[0] >= 5 ? 60 : WEIGHT_DEFAULT);
                plan.words.add(new NewWord(w, weight, c[0]));
                accepted.put(w, c[0]);
            }
        }
        // 2) the pairs: both words valid (the dictionary or the words above) and seen twice
        LinkedHashMap<String, int[]> pairCounts = new LinkedHashMap<String, int[]>();
        for (Tok[] s : sentences) {
            for (int k = 1; k < s.length; k++) {
                if (!s[k].joined) continue;
                String a = s[k - 1].text, b = s[k].text;
                if (!(accepted.containsKey(a) || knows(known, a)) || !(accepted.containsKey(b) || knows(known, b))) continue;
                String key = a + "\u0000" + b;
                int[] c = pairCounts.get(key);
                if (c == null) {
                    if (pairCounts.size() >= MAX_PAIR_CANDIDATES) {
                        plan.pairsCut = true;
                        continue;
                    }
                    c = new int[1];
                    pairCounts.put(key, c);
                }
                c[0]++;
            }
        }
        for (Map.Entry<String, int[]> e : pairCounts.entrySet()) {
            int n = e.getValue()[0];
            if (n < 2) continue;
            String key = e.getKey();
            int z = key.indexOf('\u0000');
            plan.pairs.add(new NewPair(key.substring(0, z), key.substring(z + 1), n >= 10 ? 70 : (n >= 5 ? 60 : WEIGHT_DEFAULT), n));
        }
    }

    private static void flush(ArrayList<Tok[]> sentences, ArrayList<Tok> run) {
        if (run.size() > 0) sentences.add(run.toArray(new Tok[run.size()]));
    }

    private static boolean endsSentence(String gap) {
        for (int i = 0; i < gap.length(); i++) {
            char c = gap.charAt(i);
            if (c == '.' || c == '!' || c == '?' || c == '…' || c == ':' || c == '\n') return true;
        }
        return false;
    }

    // ------------------------------------------------------------------ the text of an export

    /** The words of a free line, for the tests and for the editing of a pair ("word1 word2"); null if it is not exactly the given number of valid words. */
    static String[] splitWords(String text, int want) {
        if (text == null) return null;
        String[] parts = text.trim().split("\\s+");
        if (parts.length != want) return null;
        for (int i = 0; i < parts.length; i++) {
            if (checkWord(parts[i]) != 0) return null;
        }
        return parts;
    }

    static List<String> reasons() {
        ArrayList<String> r = new ArrayList<String>();
        for (int i = 1; i <= R_PHRASE_LONG; i++) r.add("mr_import_why_" + i);
        return r;
    }
}
