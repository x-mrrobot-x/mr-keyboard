package com.mrkeyboard.app;

import android.content.Context;
import android.view.inputmethod.InputConnection;

import java.util.ArrayList;
import java.util.List;

/**
 * Next-word prediction (v1.60, v1.62). Combines:
 *  - the continuations of the TWO previous words (MrTrigram, when the context exists);
 *  - the continuations of the last word in the main dictionary (bigrams of the .dict);
 *  - the user's (UserBigramDictionary, already on the MrText.userBigramScore scale).
 * At the start of the text or after . ! ? it shows the words that most often open a sentence (from the pack,
 * [sentence_start] in rules.txt). Without a dictionary for the language, it shows the "Baixar dicionário" (download dictionary) item
 * (MrPacks.offerList), which opens the dictionaries screen.
 * Up to 3 predictions; the best goes to the center of the strip. With no prediction (after a comma, a number),
 * LatinIME.setNextSuggestions empties the strip (there is no punctuation list), so the row goes back to the tools.
 */
public final class MrPredict {
    private MrPredict() { }

    static final int MAX_WORD = 48;   // BinaryDictionary.MAX_WORD_LENGTH
    static final int MAX_BIGRAMS = 60; // BinaryDictionary.MAX_BIGRAMS
    static final int SHOW = 3;
    static final int LOOKBACK = 96;
    /** A two-word continuation is worth more than a one-word one (it is the more specific context). */
    static final int TRIGRAM_BONUS = 128;
    private static final int MAX_CAND = MAX_BIGRAMS * 4 + 8;

    private static final int[] sInitials = new int[96];
    private static int sInitialCount;
    private static final char[] sOut = new char[MAX_WORD * MAX_BIGRAMS];
    private static final int[] sFreq = new int[MAX_BIGRAMS];
    private static final String[] sTriWords = new String[3];
    private static final int[] sTriScores = new int[3];

    private static final String[] sWord = new String[MAX_CAND];
    private static final int[] sMain = new int[MAX_CAND];
    private static final int[] sUser = new int[MAX_CAND];
    private static int sCount;
    private static String sPrev;

    /** Context of the last prediction, for the 1st letter of the next word. */
    private static String sCtx1;
    private static String sCtx2;

    /**
     * v1.84: context while typing. Until now the previous words only counted for the 1st letter; from the 2nd on the list was the plain
     * frequency one, so the hit rate fell from 1 to 2 letters (pt-BR 58.9% to 48.5% on everyday sentences). The candidates that the last
     * prediction already collected (bigrams, trigrams, the user's pairs, recent pairs) and that start with what was typed now enter the list
     * for 2 to CTX_MAX_LETTERS letters. 0 letters = off.
     */
    static final int CTX_MAX_LETTERS = 12;
    /** How many context candidates enter per query (the best ones). */
    static final int CTX_MAX = 2;
    /** Dictionary frequency (0 to 255) of the best context candidate; each next one gets CTX_STEP less. Then x 2^letters, the lib scale. */
    static final int CTX_FREQ = 255;
    static final int CTX_STEP = 40;

    /** The word being typed saw the context of the last prediction on its 1st letter (and this was its first letter). */
    private static boolean sTypedCtx;
    private static int sTypedInitial;

    /** Collects the user's bigrams (ExpandableDictionary.getBigrams calls addWord). */
    private static final class UserCollector implements Dictionary.WordCallback {
        UserCollector() { }

        public boolean addWord(char[] word, int offset, int length, int freq, int dicTypeId,
                Dictionary.DataType dataType) {
            if (word != null && length > 0 && freq > 0) {
                add(new String(word, offset, length), 0, freq);
            }
            return true;
        }
    }

    private static final UserCollector sUserCollector = new UserCollector();

    /**
     * List for the strip (order: 2nd, 1st, 3rd; with 2: 2nd, 1st; with 1: only it), or null if there is no
     * prediction. Never throws an exception.
     */
    public static List<CharSequence> list(Context context, Suggest suggest, InputConnection ic) {
        try {
            if (suggest == null || ic == null) return null;
            if (!suggest.hasMainDictionary()) return MrPacks.offerList(context);
            CharSequence before = ic.getTextBeforeCursor(LOOKBACK, 0);
            if (MrText.atSentenceStart(before)) {
                sCtx1 = null;
                sCtx2 = null;
                MrRecent.breakPair();   // v1.75: the new sentence does not form a pair with the previous one
                String[] starters = MrRules.get().starters;
                if (starters.length == 0) return null;
                // rules.txt lists from the most to the least likely; on the strip: 2nd, 1st (center), 3rd
                ArrayList<CharSequence> out = new ArrayList<CharSequence>(SHOW);
                if (starters.length >= 2) out.add(starters[1]);
                out.add(starters[0]);
                if (starters.length >= 3) out.add(starters[2]);
                return out;
            }
            String[] two = MrText.lastTwoWords(before);
            if (two == null) {
                sCtx1 = null;
                sCtx2 = null;
                return null;
            }
            return forWords(suggest, two[0], two[1]);
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** The predictions for the previous word (without a two-word context). */
    static List<CharSequence> forWord(Suggest suggest, String prev) {
        return forWords(suggest, null, prev);
    }

    /** The predictions for (second to last, last), already in the strip order. */
    static synchronized List<CharSequence> forWords(Suggest suggest, String prev2, String prev) {
        sCount = 0;
        sPrev = prev;
        sCtx1 = prev2;
        sCtx2 = prev;
        String lower = prev.toLowerCase();
        boolean hasLower = !lower.equals(prev);
        if (prev2 != null) {
            int n = MrTrigram.find(prev2, prev, sTriWords, sTriScores);
            for (int i = 0; i < n; i++) add(sTriWords[i], TRIGRAM_BONUS + sTriScores[i], 0);
        }
        BinaryDictionary main = suggest.mrMainDict();
        if (main != null) {
            if (sInitialCount == 0) sInitialCount = MrText.allInitials(sInitials);
            mainBigrams(main, prev);
            if (hasLower && main.isValidWord(lower)) mainBigrams(main, lower);
        }
        Dictionary user = suggest.mrUserBigrams();
        if (user != null) {
            user.getBigrams(null, prev, sUserCollector, null);
            if (hasLower) user.getBigrams(null, lower, sUserCollector, null);
        }
        // v1.75: what was written a moment ago in this conversation: recent pairs enter as candidates and whoever is already
        // a candidate and was typed a moment ago goes up
        String[] after = MrRecent.nextAfter(prev, 2);
        for (int i = 0; i < after.length; i++) add(after[i], 0, MrRecent.PAIR_SCORE - 5 * i);
        for (int i = 0; i < sCount; i++) {
            int bonus = MrRecent.bonus(sWord[i]);
            if (bonus > 0) sUser[i] += bonus;
        }
        if (sCount == 0) return null;
        int[] best = {-1, -1, -1};
        for (int i = 0; i < sCount; i++) {
            int s = score(i);
            for (int k = 0; k < SHOW; k++) {
                if (best[k] < 0 || s > score(best[k])) {
                    for (int m = SHOW - 1; m > k; m--) best[m] = best[m - 1];
                    best[k] = i;
                    break;
                }
            }
        }
        ArrayList<CharSequence> out = new ArrayList<CharSequence>(SHOW);
        if (best[1] >= 0) out.add(sWord[best[1]]);
        out.add(sWord[best[0]]);
        if (best[2] >= 0) out.add(sWord[best[2]]);
        return out;
    }

    /**
     * Suggest, 1st letter: adds the two-word continuations that start with the typed
     * letter (as high-priority bigrams). Only counts if the previous word is the same as in the last
     * prediction (the context was read from the text at that moment).
     */
    public static void firstLetter(Suggest suggest, WordComposer composer, CharSequence prev) {
        try {
            String c1 = sCtx1, c2 = sCtx2;
            if (suggest == null || composer == null) return;
            // v1.75: recent words that start with the typed letter
            MrRecent.complete(suggest, composer);
            // v1.84: remember that this word is being typed after the context of the last prediction (used from the 2nd letter on)
            if (composer.size() == 1) {
                CharSequence t = composer.getTypedWord();
                synchronized (MrPredict.class) {
                    sTypedCtx = t != null && t.length() > 0 && prev != null && c2 != null && c2.equalsIgnoreCase(prev.toString());
                    sTypedInitial = sTypedCtx ? MrText.base(t.charAt(0)) : 0;
                }
            }
            if (prev == null || c1 == null || c2 == null) return;
            if (composer.size() != 1 || !c2.equalsIgnoreCase(prev.toString())) return;
            int typed = composer.getTypedWord().charAt(0);
            String[] w = new String[3];
            int[] f = new int[3];
            int n;
            synchronized (MrPredict.class) {
                n = MrTrigram.find(c1, c2, w, f);
            }
            for (int i = 0; i < n; i++) {
                if (!MrText.sameInitial(w[i], typed)) continue;
                char[] c = w[i].toCharArray();
                suggest.addWord(c, 0, c.length, 127, 1, Dictionary.DataType.BIGRAM);
            }
        } catch (RuntimeException e) {
            // the 1st letter goes on with the bigrams
        }
    }

    /**
     * Suggest, 2nd letter on (called by MrFuzzy.afterWords): the best candidates of the previous words' context that start with the
     * typed letters (accent and case ignored) enter the list as dictionary words, so that "muito ob" shows obrigado before the
     * words that are only frequent. Only if the 1st letter of this word was typed after that same context (see firstLetter).
     */
    public static void complete(Suggest suggest, WordComposer composer) {
        if (CTX_MAX <= 0 || CTX_MAX_LETTERS < 2 || suggest == null || composer == null) return;
        try {
            int n = composer.size();
            if (n < 2 || n > CTX_MAX_LETTERS) return;
            CharSequence typed = composer.getTypedWord();
            if (typed == null || typed.length() != n) return;
            String[] pick = new String[CTX_MAX];
            int[] best = new int[CTX_MAX];
            int found = 0;
            synchronized (MrPredict.class) {
                if (!sTypedCtx || sCount == 0 || MrText.base(typed.charAt(0)) != sTypedInitial) return;
                for (int i = 0; i < sCount; i++) {
                    String w = sWord[i];
                    if (w.length() <= n || !startsWith(w, typed, n)) continue;
                    int sc = score(i);
                    int at = found;
                    while (at > 0 && best[at - 1] < sc) at--;
                    if (at >= CTX_MAX) continue;
                    for (int m = Math.min(found, CTX_MAX - 1); m > at; m--) {
                        pick[m] = pick[m - 1];
                        best[m] = best[m - 1];
                    }
                    pick[at] = w;
                    best[at] = sc;
                    if (found < CTX_MAX) found++;
                }
            }
            for (int f = 0; f < found; f++) {
                char[] c = pick[f].toCharArray();
                suggest.addWord(c, 0, c.length, (CTX_FREQ - CTX_STEP * f) << Math.min(n, 16), 1, Dictionary.DataType.UNIGRAM);
            }
        } catch (RuntimeException e) {
            // the suggestions go on without the context
        }
    }

    /**
     * v1.85.0: the word is one of the candidates of the context that the word being typed saw on its 1st letter (accent and case ignored).
     * Used by MrFuzzy to move a likely word to the center of the strip when the previous words confirm it ("eu aida" -> ainda).
     */
    static boolean inContext(CharSequence w) {
        if (w == null || w.length() == 0) return false;
        synchronized (MrPredict.class) {
            if (!sTypedCtx || sCount == 0) return false;
            for (int i = 0; i < sCount; i++) {
                if (score(i) > 0 && sameWord(sWord[i], w)) return true;
            }
        }
        return false;
    }

    private static boolean sameWord(String a, CharSequence b) {
        if (a.length() != b.length()) return false;
        for (int i = 0; i < a.length(); i++) {
            if (MrText.base(a.charAt(i)) != MrText.base(b.charAt(i))) return false;
        }
        return true;
    }

    /** The word starts with the n typed letters, ignoring accent and case. */
    private static boolean startsWith(String word, CharSequence typed, int n) {
        for (int i = 0; i < n; i++) {
            if (MrText.base(word.charAt(i)) != MrText.base(typed.charAt(i))) return false;
        }
        return true;
    }

    private static int score(int i) {
        return sMain[i] + sUser[i];
    }

    private static void mainBigrams(BinaryDictionary main, String prev) {
        char[] p = prev.toCharArray();
        main.mrBigrams(p, sInitials, sInitialCount, sOut, sFreq);
        for (int i = 0; i < MAX_BIGRAMS; i++) {
            int f = sFreq[i];
            if (f <= 0) break;
            int off = i * MAX_WORD;
            int len = 0;
            while (len < MAX_WORD && sOut[off + len] != 0) len++;
            if (len > 0) add(new String(sOut, off, len), f, 0);
        }
    }

    private static void add(String w, int mainFreq, int userFreq) {
        if (w.equalsIgnoreCase(sPrev) || MrLearned.isBlocked(w)) return;
        for (int i = 0; i < sCount; i++) {
            if (sWord[i].equals(w)) {
                if (mainFreq > sMain[i]) sMain[i] = mainFreq;
                if (userFreq > sUser[i]) sUser[i] = userFreq;
                return;
            }
        }
        if (sCount >= MAX_CAND) return;
        sWord[sCount] = w;
        sMain[sCount] = mainFreq;
        sUser[sCount] = userFreq;
        sCount++;
    }
}
