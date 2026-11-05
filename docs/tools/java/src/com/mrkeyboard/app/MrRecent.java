package com.mrkeyboard.app;

import java.util.Arrays;

/**
 * Recent words (v1.75): what you have just typed in the conversation (names, the subject) gains weight in the
 * suggestions. Memory only (nothing goes to disk), only in this text field and erased when the field or the
 * app changes ({@link #onField}); it does not record in a password field or in incognito mode (the caller is the same
 * hook that already respects this, LatinIME.checkAddToDictionary).
 *
 * Three uses, all with the short list of the last {@link #CAP} terms, from newest to oldest:
 *  1) completing while typing: the recent word that starts with what was typed enters the list
 *     ({@link #complete}); it is what makes "Mar" suggest "Maria" the 2nd time, without waiting for learning;
 *  2) prediction after the space: whoever is already a candidate and was typed a moment ago goes up ({@link #bonus});
 *  3) recent pairs: if you wrote "reunião de amanhã", after "reunião de" comes "amanhã" ({@link #nextAfter}).
 */
public final class MrRecent {
    private MrRecent() { }

    /** How many terms to keep. */
    static final int CAP = 96;
    static final int MIN_LEN = 3;
    static final int MAX_LEN = 30;

    /** Prediction: bonus (on the MrPredict scale) of a candidate word typed a moment ago; falls with age. */
    static final int PRED_BOOST = 40;
    /** Prediction: points of a recent pair (previous word -> this one) that enters as a candidate. 0 = off. */
    static final int PAIR_SCORE = 70;
    /**
     * Word that the dictionary does not know and was written only in lowercase: 1 = record; 0 = ignore. It is almost
     * always a typo ("obrogado"), and recording it would make the keyboard offer the mistake back; names,
     * brands and acronyms come capitalized ("Maria", "iPhone", "NASA") and always enter.
     */
    static final int OOV_LOWER = 0;
    /** Completing: "dictionary frequency" of a recent word (0 to 255; falls with age). 0 = off. */
    static final int COMP_V = 200;
    /** Completing: how many recent words at most enter per query. */
    static final int COMP_MAX = 2;
    /** With 1 letter typed (the list is the bigram one): how many and with what priority (0 to 127). 0 = off. */
    static final int COMP1_MAX = 1;
    static final int COMP1_V = 60;
    /** With 1 letter: 1 = any recent word; 0 = only those the dictionary does not know (names, slang). */
    static final int COMP1_ALL = 0;

    // newest first: sShow[0] is the last recorded word
    private static final String[] sShow = new String[CAP];
    private static final String[] sKey = new String[CAP];
    /** true when the word is not from the dictionary (name, slang, rare term). */
    private static final boolean[] sOov = new boolean[CAP];
    private static int sCount;
    // pairs (previous -> next), newest first
    private static final String[] sPairPrev = new String[CAP];
    private static final String[] sPairNext = new String[CAP];
    private static int sPairCount;
    private static String sLastKey;
    private static String sPkg;
    private static int sField = -1;

    // ------------------------------------------------------------------ life cycle

    /** New text field (another app or another field): starts from zero. */
    public static synchronized void onField(String pkg, int fieldId) {
        boolean same = pkg != null && pkg.equals(sPkg) && fieldId == sField;
        sPkg = pkg;
        sField = fieldId;
        if (!same) clear();
    }

    public static synchronized void clear() {
        Arrays.fill(sShow, null);
        Arrays.fill(sKey, null);
        Arrays.fill(sPairPrev, null);
        Arrays.fill(sPairNext, null);
        sCount = 0;
        sPairCount = 0;
        sLastKey = null;
    }

    /** End of sentence or text erased: the next term does not form a pair with the previous one. */
    public static synchronized void breakPair() {
        sLastKey = null;
    }

    // ------------------------------------------------------------------ record

    /**
     * Records a word that has just been written. A common dictionary word goes in lowercase (the case
     * is fixed when displaying); names, slang and rare terms stay as typed ("Maria", "iPhone").
     */
    public static synchronized void record(Suggest suggest, CharSequence word) {
        if (word == null) return;
        String w = word.toString().trim();
        int n = w.length();
        if (n < MIN_LEN || n > MAX_LEN) return;
        boolean letter = false;
        for (int i = 0; i < n; i++) {
            char c = w.charAt(i);
            if (Character.isDigit(c) || c == ' ') return;
            if (Character.isLetter(c)) letter = true;
        }
        if (!letter) return;
        String show = w;
        boolean oov = true;
        if (suggest != null) {
            String lower = w.toLowerCase();
            if (suggest.isValidWord(lower)) { show = lower; oov = false; }
            else if (suggest.isValidWord(w)) oov = false;
        }
        if (oov && OOV_LOWER == 0 && w.equals(w.toLowerCase())) return;
        String key = key(show);
        if (sLastKey != null) addPair(sLastKey, show);
        sLastKey = key;
        int at = -1;
        for (int i = 0; i < sCount; i++) {
            if (sKey[i].equals(key)) { at = i; break; }
        }
        if (at < 0) at = Math.min(sCount, CAP - 1);
        for (int i = at; i > 0; i--) {
            sShow[i] = sShow[i - 1];
            sKey[i] = sKey[i - 1];
            sOov[i] = sOov[i - 1];
        }
        sShow[0] = show;
        sKey[0] = key;
        sOov[0] = oov;
        if (at == sCount && sCount < CAP) sCount++;
    }

    private static void addPair(String prevKey, String next) {
        String nk = key(next);
        int at = -1;
        for (int i = 0; i < sPairCount; i++) {
            if (sPairPrev[i].equals(prevKey) && key(sPairNext[i]).equals(nk)) { at = i; break; }
        }
        if (at < 0) at = Math.min(sPairCount, CAP - 1);
        for (int i = at; i > 0; i--) {
            sPairPrev[i] = sPairPrev[i - 1];
            sPairNext[i] = sPairNext[i - 1];
        }
        sPairPrev[0] = prevKey;
        sPairNext[0] = next;
        if (at == sPairCount && sPairCount < CAP) sPairCount++;
    }

    /** Lowercase and without accent: the comparison the rest of the engine uses. */
    static String key(CharSequence s) {
        char[] c = new char[s.length()];
        for (int i = 0; i < c.length; i++) c[i] = MrText.base(s.charAt(i));
        return new String(c);
    }

    // ------------------------------------------------------------------ use

    /** Age 0 (the newest) to CAP-1 becomes a factor from 1 to 1/4. */
    private static int scaled(int max, int rank) {
        return max - (max * 3 / 4) * rank / (CAP - 1);
    }

    /** Prediction: bonus of the word if it was typed a moment ago; 0 if not. */
    static synchronized int bonus(String word) {
        if (PRED_BOOST <= 0 || sCount == 0) return 0;
        String k = key(word);
        for (int i = 0; i < sCount; i++) {
            if (sKey[i].equals(k)) return scaled(PRED_BOOST, i);
        }
        return 0;
    }

    /** Prediction: words that came right after prev in this conversation, newest first (up to max). */
    static synchronized String[] nextAfter(String prev, int max) {
        if (PAIR_SCORE <= 0 || sPairCount == 0 || prev == null) return EMPTY;
        String k = key(prev);
        String[] out = new String[max];
        int n = 0;
        for (int i = 0; i < sPairCount && n < max; i++) {
            if (sPairPrev[i].equals(k)) out[n++] = sPairNext[i];
        }
        return n == 0 ? EMPTY : Arrays.copyOf(out, n);
    }

    static final String[] EMPTY = new String[0];

    /**
     * Completing: hands Suggest the recent words that start with what was typed (without accent or
     * case), at most COMP_MAX. With 1 letter the list goes as a bigram (it is what Suggest shows at that moment);
     * with 2 or more, as a dictionary word with the score on the lib scale (frequency x 2^letters).
     */
    public static void complete(Suggest suggest, WordComposer composer) {
        if (COMP_V <= 0 || suggest == null || composer == null) return;
        try {
            CharSequence typed = composer.getTypedWord();
            int n = typed == null ? 0 : typed.length();
            if (n < 1 || n > 12) return;
            int max = n == 1 ? COMP1_MAX : COMP_MAX;
            if (max <= 0) return;
            String pre = key(typed);
            String[] pick = new String[max];
            int[] rank = new int[max];
            int found = 0;
            synchronized (MrRecent.class) {
                for (int i = 0; i < sCount && found < max; i++) {
                    String k = sKey[i];
                    if (k.length() > n && k.startsWith(pre) && (n > 1 || COMP1_ALL > 0 || sOov[i])) {
                        pick[found] = sShow[i];
                        rank[found] = i;
                        found++;
                    }
                }
            }
            for (int f = 0; f < found; f++) {
                char[] c = pick[f].toCharArray();
                if (n == 1) {
                    suggest.addWord(c, 0, c.length, Math.min(127, scaled(COMP1_V, rank[f])), 1, Dictionary.DataType.BIGRAM);
                } else {
                    suggest.addWord(c, 0, c.length, scaled(COMP_V, rank[f]) << Math.min(n, 16), 1, Dictionary.DataType.UNIGRAM);
                }
            }
        } catch (RuntimeException e) {
            // the suggestions go on without the recent words
        }
    }
}
