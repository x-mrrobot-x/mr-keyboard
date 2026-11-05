package com.mrkeyboard.app;

import android.content.Context;
import android.preference.PreferenceManager;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;

/**
 * v1.85: the rules behind the screens "What the keyboard learned" (MrLearnedActivity) and "Add words and texts" (MrImportActivity), and the part that
 * the keyboard itself uses: loading what the user added into the dictionaries (AutoDictionary and UserBigramDictionary call {@link #load}), the list of
 * words that are never suggested ({@link #isBlocked}, {@link #filter}) and the signal that makes the keyboard reload ({@link #changed}).
 * The storage is a MrWordStore (SQLite on the phone, lists in the PC tests); everything here is plain Java.
 */
public final class MrLearned {
    private MrLearned() { }

    /** Imported words and pairs have their own caps and are never evicted by the cleanup of the learned pairs (10,000, 1,000 at a time). */
    public static final int IMPORT_MAX_WORDS = 20000;
    public static final int IMPORT_MAX_PAIRS = 30000;

    /**
     * Frequency (scale 0-255 of the dictionaries) of an imported word of weight 50, measured with docs/tools/e2e/ImportEval: at 130 a name that the
     * dictionary does not know is one of the 2 suggestions after 3 letters in about 9 of 10 cases (pt-BR 11 of 12, en-US 15 of 18, es 18 of 19) and
     * seldom takes a place after 2 letters. Weight 100 gives 250 (first place after 2 letters), weight 20 gives 52 (only after 4 letters).
     * The words the keyboard learned by itself are valid from 6.
     */
    static final int WORD_FREQ_AT_50 = 130;
    static final int WORD_FREQ_MIN = 6;
    static final int WORD_FREQ_MAX = 250;
    /**
     * Frequency of an imported pair, on the scale of the user's pairs (the number of times it was typed; MrText.userBigramScore gives 40 + 10 x
     * this, up to 127). Measured: 4 (score 80) is the least that gets into the three predictions, 9 (score 127) takes the first place; so weight 1
     * gives 4, weight 50 gives 6 and weight 100 gives 9.
     */
    static final int PAIR_FREQ_MIN = 4;
    static final int PAIR_FREQ_MAX = 9;
    /** The learned word with this frequency is shown as "used" in the export (the original keyboard promotes a word at 250). */
    static final int LEARNED_FREQ_FULL = 250;
    /** A learned word below this frequency is not valid yet for the keyboard (typed once or twice): it is not exported. */
    static final int LEARNED_FREQ_MIN_EXPORT = 6;
    static final int LEARNED_PAIR_MIN_EXPORT = 12;

    /** What the keyboard fills with the words and pairs added by the user (AutoDictionary takes the words, UserBigramDictionary the pairs). */
    public interface Sink {
        /** 0: this sink takes words; 1: it takes pairs. */
        int kind();

        void word(String word, int freq);

        void pair(String first, String second, int freq);
    }

    // ------------------------------------------------------------------ the store and the signal

    private static MrWordStore sStore;
    private static volatile HashSet<String> sBlocked = new HashSet<String>();

    /** The store of the app (opened on first use), or null if the database cannot be opened. */
    static synchronized MrWordStore store(Context c) {
        if (sStore == null && c != null) {
            try {
                sStore = new MrSqlStore(c.getApplicationContext());
            } catch (Throwable e) {
                sStore = null;
            }
        }
        return sStore;
    }

    /** For the PC tests. */
    static synchronized void useStore(MrWordStore s) {
        sStore = s;
        sBlocked = new HashSet<String>();
    }

    /** Tells the keyboard to read the dictionaries again (LatinIME rebuilds them when this preference changes). */
    static void changed(Context c) {
        try {
            PreferenceManager.getDefaultSharedPreferences(c).edit().putLong(MrPacks.SIGNAL_KEY, System.currentTimeMillis()).apply();
        } catch (RuntimeException e) {
            // the keyboard picks the change up the next time it starts
        }
    }

    // ------------------------------------------------------------------ the keyboard side

    /** Called by AutoDictionary / UserBigramDictionary after they load their own database: adds what the user imported. Never throws. */
    public static void load(Context c, Sink sink, String locale) {
        try {
            MrWordStore st = store(c);
            if (st == null || sink == null || locale == null) return;
            loadFrom(st, sink, locale);
        } catch (Throwable e) {
            // the dictionary goes on with what it has
        }
    }

    static void loadFrom(MrWordStore st, Sink sink, String locale) {
        if (sink.kind() == 0) {
            refreshBlocked(st, locale);
            List<MrWordStore.Row> rows = st.all(MrWordStore.KIND_IMPORTED_WORD, locale);
            for (MrWordStore.Row r : rows) {
                if (!isBlocked(r.a)) sink.word(r.a, wordFreq(r.freq));
            }
        } else {
            List<MrWordStore.Row> rows = st.all(MrWordStore.KIND_IMPORTED_PAIR, locale);
            for (MrWordStore.Row r : rows) {
                if (r.b != null && !isBlocked(r.a) && !isBlocked(r.b)) sink.pair(r.a, r.b, pairFreq(r.freq));
            }
        }
    }

    static void refreshBlocked(MrWordStore st, String locale) {
        HashSet<String> set = new HashSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_BLOCKED, locale)) set.add(key(r.a));
        sBlocked = set;
    }

    /** Weight 1-100 -> frequency of a word in the dictionary of learned words. */
    static int wordFreq(int weight) {
        int w = Math.max(1, Math.min(100, weight));
        return Math.min(WORD_FREQ_MAX, Math.max(WORD_FREQ_MIN, Math.round(w * WORD_FREQ_AT_50 / 50f)));
    }

    /** Weight 1-100 -> frequency of a pair in the dictionary of the user's pairs (PAIR_FREQ_MIN to PAIR_FREQ_MAX). */
    static int pairFreq(int weight) {
        int w = Math.max(1, Math.min(100, weight));
        return PAIR_FREQ_MIN + Math.round((w - 1) * (PAIR_FREQ_MAX - PAIR_FREQ_MIN) / 99f);
    }

    private static String key(String w) {
        return w == null ? "" : w.toLowerCase(Locale.ROOT);
    }

    /** A word of the learned dictionary only completes what is typed from this frequency on: the same threshold that makes it a valid word. */
    static final int COMPLETE_MIN_FREQ = 6;

    /**
     * Lets only the words the keyboard has accepted (learned from frequency 6, and every imported word) through to the strip: a word seen once or twice
     * is a possible typo. Used by AutoDictionary.getWords (v1.85): until then the learned words only kept the keyboard from correcting them, they never
     * completed anything. One instance, because the keyboard asks from the main thread only.
     */
    public static Dictionary.WordCallback gate(Dictionary.WordCallback to) {
        Gate g = sGate;
        g.to = to;
        return g;
    }

    private static final Gate sGate = new Gate();

    private static final class Gate implements Dictionary.WordCallback {
        Dictionary.WordCallback to;

        public boolean addWord(char[] word, int wordOffset, int wordLength, int frequency, int dicTypeId, Dictionary.DataType dataType) {
            Dictionary.WordCallback next = to;
            if (next == null) return false;
            if (frequency < COMPLETE_MIN_FREQ) return true;
            return next.addWord(word, wordOffset, wordLength, frequency, dicTypeId, dataType);
        }
    }

    /** The word is on the list of words that are never suggested nor learned (the language of the last load). */
    public static boolean isBlocked(String word) {
        HashSet<String> set = sBlocked;
        return word != null && !set.isEmpty() && set.contains(key(word));
    }

    /**
     * Removes the blocked words from the strip list (entry 0, the typed word, stays). Called by MrFuzzy.finish. Returns true if the best suggestion
     * (entry 1) was one of them.
     */
    static boolean filter(List<CharSequence> list) {
        HashSet<String> set = sBlocked;
        if (set.isEmpty() || list == null) return false;
        boolean first = false;
        for (int i = list.size() - 1; i >= 1; i--) {
            if (set.contains(key(list.get(i).toString()))) {
                list.remove(i);
                if (i == 1) first = true;
            }
        }
        return first;
    }

    // ------------------------------------------------------------------ counts and listing

    /** How many rows of each kind (MrWordStore.KIND_*) the language has. */
    static int[] counts(MrWordStore st, String locale) {
        int[] n = new int[5];
        for (int k = 0; k < 5; k++) n[k] = st.count(k, locale);
        return n;
    }

    // ------------------------------------------------------------------ saving an import

    /** What an import did. */
    static final class Result {
        long batch;
        int words;
        int pairs;
        int blocked;
        /** Already imported before (not added again). */
        int dupWords;
        int dupPairs;
        /** Not added because the cap of imported words / pairs was reached. */
        int cappedWords;
        int cappedPairs;
        /** Not added because the user blocked them. */
        int blockedSkipped;

        int total() {
            return words + pairs + blocked;
        }
    }

    /**
     * Saves what the user kept in the preview (the words that are still ticked and the pairs whose words are all ticked). One batch number for the
     * whole import, so that "Undo this import" can take it back. Never evicts learned data; stops at the caps.
     */
    static Result apply(MrWordStore st, MrImport.Plan plan, String locale, long now) {
        st.begin();
        try {
            return applyIn(st, plan, locale, now);
        } finally {
            st.end();
        }
    }

    private static Result applyIn(MrWordStore st, MrImport.Plan plan, String locale, long now) {
        Result res = new Result();
        HashSet<String> haveWords = new HashSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_IMPORTED_WORD, locale)) haveWords.add(r.a);
        HashSet<String> havePairs = new HashSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_IMPORTED_PAIR, locale)) havePairs.add(r.a + "\u0000" + r.b);
        HashSet<String> blocked = new HashSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_BLOCKED, locale)) blocked.add(key(r.a));
        HashSet<String> unticked = new HashSet<String>();
        for (MrImport.NewWord w : plan.words) if (!w.checked) unticked.add(w.word);
        int wordsHave = haveWords.size();
        int pairsHave = havePairs.size();
        long batch = 0;
        for (MrImport.NewWord w : plan.words) {
            if (!w.checked) continue;
            if (blocked.contains(key(w.word))) {
                res.blockedSkipped++;
                continue;
            }
            if (haveWords.contains(w.word)) {
                res.dupWords++;
                continue;
            }
            if (wordsHave + res.words >= IMPORT_MAX_WORDS) {
                res.cappedWords++;
                continue;
            }
            if (batch == 0) batch = st.newBatch();
            st.add(MrWordStore.KIND_IMPORTED_WORD, locale, new MrWordStore.Row(MrWordStore.KIND_IMPORTED_WORD, w.word, null, clampWeight(w.weight), batch, now));
            haveWords.add(w.word);
            res.words++;
        }
        for (MrImport.NewPair p : plan.pairs) {
            if (unticked.contains(p.a) || unticked.contains(p.b)) continue;
            if (blocked.contains(key(p.a)) || blocked.contains(key(p.b))) {
                res.blockedSkipped++;
                continue;
            }
            String k = p.a + "\u0000" + p.b;
            if (havePairs.contains(k)) {
                res.dupPairs++;
                continue;
            }
            if (pairsHave + res.pairs >= IMPORT_MAX_PAIRS) {
                res.cappedPairs++;
                continue;
            }
            if (batch == 0) batch = st.newBatch();
            st.add(MrWordStore.KIND_IMPORTED_PAIR, locale, new MrWordStore.Row(MrWordStore.KIND_IMPORTED_PAIR, p.a, p.b, clampWeight(p.weight), batch, now));
            havePairs.add(k);
            res.pairs++;
        }
        for (String w : plan.blocked) {
            if (blocked.contains(key(w))) continue;
            if (batch == 0) batch = st.newBatch();
            block(st, locale, w, now);
            blocked.add(key(w));
            res.blocked++;
        }
        res.batch = batch;
        return res;
    }

    private static int clampWeight(int w) {
        return Math.max(1, Math.min(100, w));
    }

    /** Takes an import back (the words and pairs of the batch; blocked words stay: they were a decision, not material). */
    static int undo(MrWordStore st, String locale, long batch) {
        return batch <= 0 ? 0 : st.deleteBatch(locale, batch);
    }

    // ------------------------------------------------------------------ managing

    /**
     * Blocks a word: it is never suggested and never learned again. Deletes it from what the keyboard learned and from what was imported, and every
     * pair that has it. Returns how many rows were deleted, or -1 if it is not a word the keyboard can take.
     */
    static int block(MrWordStore st, String locale, String word, long now) {
        String w = word == null ? "" : word.trim().replace('’', '\'');
        if (MrImport.checkWord(w) != 0) return -1;
        boolean have = false;
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_BLOCKED, locale)) if (key(r.a).equals(key(w))) have = true;
        if (!have) st.add(MrWordStore.KIND_BLOCKED, locale, new MrWordStore.Row(MrWordStore.KIND_BLOCKED, w, null, 0, 0, now));
        int n = 0;
        for (int kind = MrWordStore.KIND_LEARNED_WORD; kind <= MrWordStore.KIND_IMPORTED_PAIR; kind++) {
            for (MrWordStore.Row r : st.all(kind, locale)) {
                if (key(r.a).equals(key(w)) || (r.b != null && key(r.b).equals(key(w)))) {
                    if (st.delete(kind, r.id)) n++;
                }
            }
        }
        return n;
    }

    static boolean unblock(MrWordStore st, long id) {
        return st.delete(MrWordStore.KIND_BLOCKED, id);
    }

    static boolean forget(MrWordStore st, int kind, long id) {
        return st.delete(kind, id);
    }

    /**
     * Fixes a word (or a pair, "first second") that was learned or imported with a typo: the row is replaced, keeping its frequency or weight and
     * its import. Returns 0 if done, otherwise the reason (MrImport.R_*), or -1 if the row is not there.
     */
    static int edit(MrWordStore st, String locale, MrWordStore.Row row, String text) {
        boolean pair = row.kind == MrWordStore.KIND_LEARNED_PAIR || row.kind == MrWordStore.KIND_IMPORTED_PAIR;
        String a, b = null;
        if (pair) {
            String[] w = MrImport.splitWords(text == null ? "" : text.replace('’', '\''), 2);
            if (w == null) return MrImport.R_CHARS;
            a = w[0];
            b = w[1];
        } else {
            a = text == null ? "" : text.trim().replace('’', '\'');
            int why = MrImport.checkWord(a);
            if (why != 0) return why;
        }
        if (!st.delete(row.kind, row.id)) return -1;
        st.add(row.kind, locale, new MrWordStore.Row(row.kind, a, b, row.freq, row.batch, row.added));
        return 0;
    }

    static int deleteAllLearned(MrWordStore st, String locale) {
        return st.deleteAll(MrWordStore.KIND_LEARNED_WORD, locale) + st.deleteAll(MrWordStore.KIND_LEARNED_PAIR, locale);
    }

    static int deleteAllImported(MrWordStore st, String locale) {
        return st.deleteAll(MrWordStore.KIND_IMPORTED_WORD, locale) + st.deleteAll(MrWordStore.KIND_IMPORTED_PAIR, locale);
    }

    // ------------------------------------------------------------------ export (the backup)

    /** "pt_BR" -> "pt-BR". */
    static String tag(String locale) {
        return locale == null ? "" : locale.replace('_', '-');
    }

    /** "pt-BR" -> "pt_BR". */
    static String localeOf(String tag) {
        return tag == null ? "" : tag.replace('-', '_');
    }

    static int weightOfLearned(int freq) {
        return Math.max(1, Math.min(100, Math.round(freq * 100f / LEARNED_FREQ_FULL)));
    }

    /**
     * What the keyboard has for the language, in the standard list format (the same file can be imported again, on this phone or on another).
     * The words that were imported and the ones the keyboard learned go to [words] (the learned ones with a weight made from their use), the pairs to
     * [phrases], the blocked words to [blocked]. Sorted, so the same data always gives the same text.
     */
    static String export(MrWordStore st, String locale) {
        java.util.TreeMap<String, Integer> words = new java.util.TreeMap<String, Integer>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_LEARNED_WORD, locale)) {
            if (r.freq >= LEARNED_FREQ_MIN_EXPORT) words.put(r.a, weightOfLearned(r.freq));
        }
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_IMPORTED_WORD, locale)) words.put(r.a, r.freq);
        java.util.TreeSet<String> pairs = new java.util.TreeSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_LEARNED_PAIR, locale)) {
            if (r.b != null && r.freq >= LEARNED_PAIR_MIN_EXPORT) pairs.add(r.a + " " + r.b);
        }
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_IMPORTED_PAIR, locale)) if (r.b != null) pairs.add(r.a + " " + r.b);
        java.util.TreeSet<String> blocked = new java.util.TreeSet<String>();
        for (MrWordStore.Row r : st.all(MrWordStore.KIND_BLOCKED, locale)) blocked.add(r.a);
        StringBuilder sb = new StringBuilder();
        sb.append("# mr-words 1\n# language: ").append(tag(locale)).append('\n');
        sb.append("[words]\n");
        for (java.util.Map.Entry<String, Integer> e : words.entrySet()) {
            sb.append(e.getKey());
            if (e.getValue() != MrImport.WEIGHT_DEFAULT) sb.append('\t').append(e.getValue());
            sb.append('\n');
        }
        sb.append("[phrases]\n");
        for (String p : pairs) sb.append(p).append('\n');
        if (!blocked.isEmpty()) {
            sb.append("[blocked]\n");
            for (String w : blocked) sb.append(w).append('\n');
        }
        return sb.toString();
    }

    /** The locales (ids of the packs with "_") that the screens offer: the installed ones first, then any other that has data. */
    static List<String> languages(List<String> installed, List<String> withData) {
        ArrayList<String> out = new ArrayList<String>();
        for (String id : installed) {
            String l = localeOf(id);
            if (!out.contains(l)) out.add(l);
        }
        ArrayList<String> extra = new ArrayList<String>();
        for (String l : withData) if (l != null && l.length() > 0 && !out.contains(l) && !extra.contains(l)) extra.add(l);
        Collections.sort(extra);
        out.addAll(extra);
        return out;
    }
}
