package com.mrkeyboard.app;

import java.nio.ByteBuffer;
import java.util.Arrays;

/**
 * Java fallback layer (v1.60): approximate search over the .dict trie already loaded by the native
 * lib (same ByteBuffer, no copy). Covers what the lib does not: extra letter, missing letter,
 * transposition, pt-BR phonetic swaps (including 2 letters for 1, like ch/x and ss/ç) and missing
 * space (porisso -> por isso).
 *
 * Format read (the same as dictionary.cpp): group = [count] + entries; entry = char (1 byte or
 * 0xFF + 2 bytes), flags/address (0x80 terminal, 0x40 with children + 22 bits; 30 bits in the format v2 of 1.86,
 * one more byte), freq if terminal and, in the "latest" format (byte 0 >= 200 and byte 1 in {0,1,2}; 2 = v2), the
 * bigram list after the freq.
 *
 * Search: weighted edit distance (dynamic programming row by row while going down the trie),
 * pruning when the lowest cost of the row goes over the limit. The 1st letter of the dictionary word must be
 * the typed one, a neighbour, a phonetic pair, the swapped vowel (e/i, o/u), a silent h or the 2nd typed
 * letter: errors outside that on the 1st letter are rare and opening all the initials costs 10 times more.
 * There is a ceiling of nodes visited per query (NODE_BUDGET) for the worst case.
 *
 * Score on the same scale as the lib: freq * 2^(n+1) for an exact hit, and every 0.25 of cost
 * divides by 2 (which is what the lib does per neighbouring key).
 */
public final class MrFuzzy {
    // costs (x100)
    static final int C_PROX = 25;
    // v1.66: neighbouring key by touch distance (the neighbours come in order of distance from the
    // ProximityKeyDetector): the closest costs the same as before; the farther ones, more
    static final int C_PROX_1 = 25;
    static final int C_PROX_2 = 30;
    static final int C_PROX_FAR = 35;
    // v1.66: the 1st letter of the word was not typed ("lso" -> also, "ersonas" -> personas)
    // v1.75: 35 -> 30 (the floor of the cost of changing the length; the search band depends on it, see setMaxCost)
    static final int C_DEL_FIRST = 30;
    static final int C_PHON = 25;
    static final int C_VOWEL = 45;
    static final int C_SUB = 75;
    static final int C_INS = 60;
    static final int C_INS_DOUBLE = 30;
    static final int C_INS_H = 40;
    static final int C_INS_NEAR = 45;
    // v1.75: dictionary letter that was not typed ("coo" -> como): 60 -> 40. With 60 the swap for a neighbouring
    // key (25) always beat the missing letter, even with the right word being much more common. Measured on the PC
    // (14 thousand errors per language): missing middle letter, at the 2 positions, pt 67% -> 87%, en 69% -> 78%,
    // es 58% -> 80%; typing correctly (word among the first 3 after 2 to 5 letters) equal or better.
    static final int C_DEL = 40;
    static final int C_DEL_DOUBLE = 30;
    // silent letters: the cost comes from rules.txt ([silent]; default MrRules.DEFAULT_SILENT_START and DEFAULT_SILENT)
    static final int C_TRANS = 40;
    static final int C_MULTI = 35;
    static final int C_SPLIT = 35;

    static final int MAX_TYPED = 20;
    static final int MIN_TYPED = 3;
    static final int MAX_EXTRA_DEPTH = 3;
    static final int MAX_RESULTS = 5;
    static final int NODE_BUDGET = 12000;
    static final int MAX_WORD = 48;

    private static final char[] BASE = new char[256];
    private static final char[] LOWER = new char[256];

    static {
        for (int c = 0; c < 256; c++) {
            BASE[c] = MrText.base(c);
            LOWER[c] = Character.toLowerCase((char) c);
        }
    }

    private static MrFuzzy sCache;
    /** Nodes visited in the last query (tests). */
    static int sLastVisits;

    private final ByteBuffer mDict;
    private final int mSize;
    private final int mRoot;
    private final boolean mLatest;
    /** Bytes of an address: 3 in the dictionary format v1, 4 in v2 (header byte 1 = 2). */
    private final int mAb;

    // query state
    private int mN;
    private final char[] mTb = new char[MAX_TYPED];
    private final char[][] mNear = new char[MAX_TYPED][16];
    private final int[] mNearCount = new int[MAX_TYPED];
    private final short[][] mSub = new short[MAX_TYPED][256];
    private final int[] mIns = new int[MAX_TYPED];
    private final boolean[] mFirst = new boolean[256];
    /** Groups from rules.txt: at j, the 2 typed letters (j-2, j-1) may stand for this dictionary one. */
    private final char[] mTwoD1 = new char[MAX_TYPED + 1];
    private final char[] mTwoD2 = new char[MAX_TYPED + 1];
    /** Language rules of this query (from the pack; empty without a pack). */
    private MrRules mR = MrRules.EMPTY;
    private final int[][] mRows = new int[MAX_TYPED + MAX_EXTRA_DEPTH + 2][MAX_TYPED + 1];
    private final char[] mPath = new char[MAX_WORD + 2];
    private int mMaxCost;
    private int mBand;
    private int mVisits;
    static final int INF = 1 << 20;
    /** At the root: 1 = only the typed initial, 2 = only the other accepted initials, 0 = all. */
    private int mOnlyTyped;

    // best results
    private final char[][] mResWord = new char[MAX_RESULTS][MAX_WORD * 2 + 2];
    private final int[] mResLen = new int[MAX_RESULTS];
    private final long[] mResScore = new long[MAX_RESULTS];
    private final int[] mResCost = new int[MAX_RESULTS];
    private int mResCount;

    // v1.77: buffers of the native path (MrNative); the lib writes here and the result is copied to mRes*
    private final char[] mNearFlat = new char[MAX_TYPED * 16];
    private final char[] mOutWords = new char[MAX_RESULTS * MrNative.RESULT_CHARS];
    private final int[] mOutInfo = new int[MrNative.INFO_SIZE];
    private final long[] mOutScores = new long[MAX_RESULTS];

    /** Cheap correction of the last query, to reserve a slot in the band (finish). */
    static final int RESERVE_MAX_COST = 45;

    /**
     * v1.84: a valid word that is probably another word ("cassa" -> casa). Only a suggestion (it takes the 3rd place of the strip through
     * the same reserve as a cheap correction); the typed word is never replaced on its own. It is offered when the typed word is
     * rare (frequency from above ALT_OFFENSIVE_FREQ to ALT_TYPED_MAX, scale 0-255 of the dictionary) and a word within ALT_MAX_COST (one common error) is both frequent
     * (at least ALT_MIN_FREQ) and at least ALT_GAP above it. 0 = off.
     */
    static final int ALT_GAP = 60;
    static final int ALT_MAX_COST = 40;
    static final int ALT_TYPED_MAX = 80;
    static final int ALT_MIN_FREQ = 110;
    static final int ALT_MAX_TYPED = 12;
    /** The pack keeps its possibly offensive words at this frequency (docs/dictionary-build.md): they are not questioned. */
    static final int ALT_OFFENSIVE_FREQ = 5;
    /**
     * v1.85.0: 1 = when the alternative is also a candidate of the previous words' context (MrPredict.inContext) and the typed word is not,
     * it goes to the center of the strip instead of the 3rd place ("eu aida": ainda, not the neighbouring-key AIDS). 0 = always the 3rd.
     * Still only a suggestion: a typed valid word is never replaced on its own.
     */
    static final int ALT_CTX_FIRST = 1;

    /** v1.66: neighbours of each touch of the last word, in order of distance (for finish). */
    private static String sTouchTyped;
    private static final char[][] sTouchNear = new char[MAX_TYPED][12];
    private static final int[] sTouchCount = new int[MAX_TYPED];
    private static String sReserveTyped;
    private static String sReserveWord;
    private static boolean sReserveFirst;

    MrFuzzy(ByteBuffer dict, int size) {
        mDict = dict;
        mSize = size;
        boolean latest = false;
        int ab = 3;
        if (size > 2) {
            int v = dict.get(0) & 0xFF;
            int b = dict.get(1) & 0xFF;
            latest = v >= 200 && (b == 0 || b == 1 || b == 2);
            if (latest && b == 2) ab = 4;
        }
        mAb = ab;
        mLatest = latest;
        mRoot = latest ? 2 : 0;
    }

    static synchronized MrFuzzy forDict(ByteBuffer dict, int size) {
        if (dict == null || size <= 2) return null;
        MrFuzzy f = sCache;
        if (f == null || f.mDict != dict || f.mSize != size) {
            f = new MrFuzzy(dict, size);
            sCache = f;
        }
        return f;
    }

    // ------------------------------------------------------------------ entry point (Suggest)

    /**
     * Called by Suggest.getSuggestions after the main dictionary. Adds the correction from the
     * map (MrFix) and, if the typed word is not valid, the candidates from the approximate search.
     */
    public static void afterWords(Suggest suggest, WordComposer composer) {
        try {
            sReserveTyped = null;
            sReserveWord = null;
            sReserveFirst = false;
            if (suggest == null || composer == null) return;
            int n = composer.size();
            if (n < 2 || n > MAX_TYPED) return;
            // v1.75: words typed recently in this conversation that start with what was typed
            MrRecent.complete(suggest, composer);
            // v1.84: candidates of the previous words' context that start with what was typed
            MrPredict.complete(suggest, composer);
            CharSequence typed = composer.getTypedWord();
            if (typed == null) return;
            rememberTouches(composer, typed, n);
            String fix = MrFix.lookup(typed);
            if (fix != null) {
                char[] c = fix.toCharArray();
                suggest.addWord(c, 0, c.length, Integer.MAX_VALUE / 4, 1, Dictionary.DataType.UNIGRAM);
                return;
            }
            if (n < MIN_TYPED) return;
            if (suggest.isValidWord(typed)) {
                validAlternative(suggest, composer, typed, n);
                return;
            }
            BinaryDictionary main = suggest.mrMainDict();
            if (main == null) return;
            MrFuzzy f = forDict(main.mrBuffer(), main.mrLength());
            if (f == null) return;
            synchronized (f) {
                f.search(composer, typed);
                f.emit(suggest);
                sReserveTyped = typed.toString();
                sReserveWord = f.mResCount > 0 && f.mResCost[0] <= RESERVE_MAX_COST
                        ? f.resultWord(0) : null;
            }
        } catch (RuntimeException e) {
            // never break typing because of the fallback layer
        }
    }

    /** The typed word is valid: if it is rare and a much more frequent word is one common error away, keep that one for the 3rd place (finish). */
    private static void validAlternative(Suggest suggest, WordComposer composer, CharSequence typed, int n) {
        if (ALT_GAP <= 0 || n < MIN_TYPED || n > ALT_MAX_TYPED) return;
        BinaryDictionary main = suggest.mrMainDict();
        if (main == null) return;
        MrFuzzy f = forDict(main.mrBuffer(), main.mrLength());
        if (f == null) return;
        synchronized (f) {
            int own = f.ownFrequency(typed);
            if (own <= ALT_OFFENSIVE_FREQ || own > ALT_TYPED_MAX) return;   // frequent words (the usual case) cost nothing more than this lookup
            f.search(composer, typed);
            String alt = f.alternative(typed.toString(), own, ALT_MAX_COST, ALT_MIN_FREQ, ALT_GAP);
            if (alt != null) {
                sReserveTyped = typed.toString();
                sReserveWord = alt;
                sReserveFirst = ALT_CTX_FIRST > 0 && MrPredict.inContext(alt) && !MrPredict.inContext(typed);
            }
        }
    }

    /** Frequency (0-255) of the typed word in the dictionary, accent and case of the letters ignored; 0 = not found or only as a capitalized word. */
    int ownFrequency(CharSequence typed) {
        int n = Math.min(typed.length(), MAX_TYPED);
        mN = n;
        for (int j = 0; j < n; j++) mTb[j] = MrText.base(typed.charAt(j));
        mGuard = 0;
        return lookup(0, n);
    }

    /**
     * After search() for a valid typed word with frequency {@code own}: the most frequent result that is not the same word (accent or case),
     * has no space, is within maxCost, has frequency of at least minFreq and is at least gap above own; null if there is none.
     * The frequency of a result is recovered from its score (freq x 2^(n+1) x 2^(-cost/25)).
     */
    String alternative(String typed, int own, int maxCost, int minFreq, int gap) {
        String tb = baseString(typed);
        boolean typedCap = Character.isUpperCase(typed.charAt(0));
        double unit = (double) (1L << (Math.min(mN, 24) + 1));
        String best = null;
        int bestFreq = 0;
        for (int i = 0; i < mResCount; i++) {
            int cost = mResCost[i];
            if (cost <= 0 || cost > maxCost) continue;
            String w = resultWord(i);
            if (w.indexOf(' ') >= 0 || baseString(w).equals(tb)) continue;
            if (!typedCap && Character.isUpperCase(w.charAt(0))) continue;
            int freq = (int) Math.round(mResScore[i] / unit * Math.pow(2.0, cost / 25.0));
            if (freq >= minFreq && freq - own >= gap && freq > bestFreq) {
                best = w;
                bestFreq = freq;
            }
        }
        return best;
    }

    /** Keeps the neighbours of each touch (codes[1..], already in order of distance from the touch). */
    private static void rememberTouches(WordComposer composer, CharSequence typed, int n) {
        sTouchTyped = null;
        for (int j = 0; j < n; j++) {
            int[] codes = composer.getCodesAt(j);
            int cnt = 0;
            if (codes != null) {
                char t = MrText.base(typed.charAt(j));
                for (int k = 1; k < codes.length && cnt < sTouchNear[j].length; k++) {
                    if (codes[k] <= 0) break;
                    char b = MrText.base(codes[k]);
                    if (b != t) sTouchNear[j][cnt++] = b;
                }
            }
            sTouchCount[j] = cnt;
        }
        sTouchTyped = typed.toString();
    }

    // ------------------------------------------------------------------ end of the list (Suggest)

    /**
     * Called at the end of Suggest.getSuggestions with the final list (0 = typed) and mHaveCorrection.
     * 1) If the search found a cheap correction (swap, doubled letter, phonetic, neighbour) that
     *    the lib's completions pushed out of the 3 visible positions, it comes back to the 3rd
     *    ("prota" shows porta even with protagonista in front).
     * 2) More careful autocorrection: it only replaces by the 2nd entry on its own if it is from the MrFix map
     *    or is within 1 error (words of up to 5 letters) or 2 errors (longer ones) of the typed one,
     *    not counting accent and case, and never for a suggestion with a space outside the map. Returns the new
     *    value of mHaveCorrection.
     */
    public static boolean finish(java.util.List<CharSequence> list, boolean haveCorrection) {
        String savedTyped = sReserveTyped;
        String word = sReserveWord;
        boolean first = sReserveFirst;
        boolean promoted = false;
        sReserveTyped = null;
        sReserveWord = null;
        sReserveFirst = false;
        try {
            if (list == null || list.isEmpty()) return haveCorrection;
            String typed = list.get(0).toString();
            if (word != null && typed.equals(savedTyped) && typed.length() > 0) {
                String shown = word;
                if (typed.length() > 1 && typed.equals(typed.toUpperCase()) && !typed.equals(typed.toLowerCase())) {
                    shown = word.toUpperCase();
                } else if (Character.isUpperCase(typed.charAt(0))) {
                    shown = Character.toUpperCase(word.charAt(0)) + word.substring(1);
                }
                int at = -1;
                for (int i = 1; i < list.size(); i++) {
                    if (list.get(i).toString().equalsIgnoreCase(shown)) { at = i; break; }
                }
                if (first) {
                    // v1.85.0: the context confirms it, so it takes the center (index 1); what was there moves to the 3rd place
                    if (at != 1) {
                        if (at > 0) list.remove(at);
                        list.add(Math.min(1, list.size()), shown);
                    }
                    promoted = true;
                } else if (at < 0 || at > 2) {
                    if (at > 2) list.remove(at);
                    list.add(Math.min(2, list.size()), shown);
                }
            }
            // v1.85: words the user blocked are never suggested (the typed word stays); if the best suggestion was one of them, nothing is replaced on its own
            if (MrLearned.filter(list)) haveCorrection = false;
            // a single letter (v1.64): Suggest does not look for words for 1 letter, but the map of
            // corrections may have single-letter entries ("i" -> I, "u" -> you in English)
            if (typed.length() == 1) {
                String fix = MrFix.lookup(typed);
                if (fix != null && !fix.equals(typed)) {
                    String shown = Character.isUpperCase(typed.charAt(0))
                            ? Character.toUpperCase(fix.charAt(0)) + fix.substring(1) : fix;
                    for (int i = list.size() - 1; i >= 1; i--) {
                        if (list.get(i).toString().equals(shown)) list.remove(i);
                    }
                    list.add(1, shown);
                    return true;
                }
            }
            // v1.66: the same word with only a capital ("ds" -> DS, "cade" -> Cade) does not stay 1st
            // when the 2nd option is a neighbouring key of the touch ("ds" -> de)
            demoteCaseVariant(list, typed);
            // v1.66: two words that swap the same typed letter: in front goes the one with the key closest
            // to the touch ("feve": deve before teve if the finger landed closer to the d)
            if (!promoted) touchOrder(list, typed);
            if (haveCorrection && list.size() >= 2) {
                haveCorrection = confident(typed, list.get(1).toString());
            }
        } catch (RuntimeException e) {
            // the list stays as it came
        }
        return haveCorrection;
    }

    /** c is the typed one (without accent) with only extra capitals: "DS" for "ds", "Cade" for "cade". */
    static boolean isCaseVariant(String c, String typed) {
        if (c.length() != typed.length() || c.equals(typed)) return false;
        if (!typed.equals(typed.toLowerCase())) return false;
        if (c.equals(c.toLowerCase())) return false;
        return baseString(c).equals(baseString(typed));
    }

    static void demoteCaseVariant(java.util.List<CharSequence> list, String typed) {
        if (list.size() < 3 || !typed.equals(sTouchTyped)) return;
        if (!isCaseVariant(list.get(1).toString(), typed)) return;
        String b = list.get(2).toString();
        int i = oneSubAt(typed, b);
        if (i >= 0 && touchRank(i, b.charAt(i)) >= 0) list.add(1, list.remove(2));
    }

    /** Position of the only letter (without accent/case) where w differs from the typed one, or -1. */
    private static int oneSubAt(String typed, String w) {
        if (w.length() != typed.length()) return -1;
        int at = -1;
        for (int i = 0; i < w.length(); i++) {
            if (MrText.base(w.charAt(i)) != MrText.base(typed.charAt(i))) {
                if (at >= 0) return -1;
                at = i;
            }
        }
        return at;
    }

    private static int touchRank(int j, char c) {
        if (j >= MAX_TYPED) return -1;
        char b = MrText.base(c);
        for (int k = 0; k < sTouchCount[j]; k++) if (sTouchNear[j][k] == b) return k;
        return -1;
    }

    static void touchOrder(java.util.List<CharSequence> list, String typed) {
        if (list.size() < 3 || !typed.equals(sTouchTyped)) return;
        String a = list.get(1).toString(), b = list.get(2).toString();
        int i = oneSubAt(typed, a);
        if (i < 0 || oneSubAt(typed, b) != i) return;
        int ra = touchRank(i, a.charAt(i)), rb = touchRank(i, b.charAt(i));
        if (rb >= 0 && (ra < 0 || rb < ra)) list.add(1, list.remove(2));
    }

    static boolean confident(String typed, String best) {
        String fix = MrFix.lookup(typed);
        if (fix != null && fix.equalsIgnoreCase(best)) return true;
        if (best.indexOf(' ') >= 0) return false;
        String a = baseString(typed), b = baseString(best);
        int allowed = a.length() <= 5 ? 1 : 2;
        if (distance(a, b, allowed) <= allowed) return true;
        // v1.66: same length and each swapped letter is one of the 2 keys closest to the touch: it counts
        // as half an error ("logaf" -> ligar, "tragafp" -> tratado). Does not apply to a proper name or acronym
        // when the typed one is lowercase.
        if (a.length() == b.length() && typed.equals(sTouchTyped)
                && !(typed.equals(typed.toLowerCase()) && !best.equals(best.toLowerCase()))) {
            int half = 0;
            for (int i = 0; i < a.length(); i++) {
                if (a.charAt(i) == b.charAt(i)) continue;
                int r = touchRank(i, b.charAt(i));
                if (r < 0 || r > 1) return false;
                half++;
            }
            return half <= 2 * allowed;
        }
        return false;
    }

    private static String baseString(String s) {
        char[] c = new char[s.length()];
        for (int i = 0; i < c.length; i++) c[i] = MrText.base(s.charAt(i));
        return new String(c);
    }

    /** Edit distance with swap (restricted Damerau), stopping above max. */
    static int distance(String a, String b, int max) {
        int n = a.length(), m = b.length();
        if (Math.abs(n - m) > max) return max + 1;
        int[] p2 = new int[m + 1], p1 = new int[m + 1], cur = new int[m + 1];
        for (int j = 0; j <= m; j++) p1[j] = j;
        for (int i = 1; i <= n; i++) {
            cur[0] = i;
            int rowMin = cur[0];
            for (int j = 1; j <= m; j++) {
                int cost = a.charAt(i - 1) == b.charAt(j - 1) ? 0 : 1;
                int v = Math.min(Math.min(p1[j] + 1, cur[j - 1] + 1), p1[j - 1] + cost);
                if (i > 1 && j > 1 && a.charAt(i - 1) == b.charAt(j - 2) && a.charAt(i - 2) == b.charAt(j - 1)) {
                    v = Math.min(v, p2[j - 2] + 1);
                }
                cur[j] = v;
                if (v < rowMin) rowMin = v;
            }
            if (rowMin > max) return max + 1;
            int[] t = p2; p2 = p1; p1 = cur; cur = t;
        }
        return p1[m];
    }

    // ------------------------------------------------------------------ search

    int resultCount() { return mResCount; }
    String resultWord(int i) { return new String(mResWord[i], 0, mResLen[i]); }
    long resultScore(int i) { return mResScore[i]; }
    int resultCost(int i) { return mResCost[i]; }

    void search(WordComposer composer, CharSequence typed) {
        int n = Math.min(typed.length(), MAX_TYPED);
        mN = n;
        for (int j = 0; j < n; j++) {
            mTb[j] = MrText.base(typed.charAt(j));
            int cnt = 0;
            int[] codes = composer != null ? composer.getCodesAt(j) : null;
            if (codes != null) {
                for (int k = 1; k < codes.length && cnt < 16; k++) {
                    int code = codes[k];
                    if (code <= 0) break;
                    char b = MrText.base(code);
                    if (b != mTb[j]) mNear[j][cnt++] = b;
                }
            }
            mNearCount[j] = cnt;
            Arrays.fill(mSub[j], (short) -1);
        }
        mR = MrRules.get();
        // v1.77: with the native lib the whole search (passes and missing space) runs in C++ with the same result;
        // without it (or if it refuses the query) the Java code below runs
        if (searchNative()) return;
        for (int j = 0; j < n; j++) mIns[j] = insCost(j);
        for (int j = 2; j <= n; j++) {
            char a = mTb[j - 2], b = mTb[j - 1];
            char d1 = 0, d2 = 0;
            char[] ta = mR.t2a, tb = mR.t2b, td = mR.t2d;
            for (int k = 0; k < ta.length; k++) {
                if (ta[k] == a && tb[k] == b) {
                    if (d1 == 0) d1 = td[k];
                    else if (d2 == 0) d2 = td[k];
                }
            }
            mTwoD1[j] = d1;
            mTwoD2[j] = d2;
        }
        firstLetters();
        mResCount = 0;
        mVisits = 0;
        int[] row0 = mRows[0];
        row0[0] = 0;
        for (int j = 1; j <= n; j++) row0[j] = Math.min(INF, row0[j - 1] + mIns[j - 1]);
        // 1st pass: one error (cost of 1 letter more/less or swap); almost every
        // typing error is like this and the search is about 5 times smaller. If the typed word is still the start of a
        // dictionary word, the person is probably in the middle of it and the lib's completions
        // already serve: with 4 letters only the cheap errors (doubled letter, h, swap, phonetic:
        // asim -> assim, omem -> homem), from 5 the whole 1st pass (prota -> porta).
        boolean prefix = isPrefix();
        if (!prefix || n >= 4) {
            setMaxCost(prefix && n == 4 ? 40 : n <= 3 ? 45 : n == 4 ? 60 : 75);
            walkRoot();
            if (!prefix && mVisits <= NODE_BUDGET) {
                // v1.66: the 1st letter was left out; only the missing letter and, in a long word,
                // one more cheap error
                setMaxCost(C_DEL_FIRST + (n >= 6 ? 30 : 0));
                mOnlyTyped = 3;
                walk(mRoot, 0, 0, (char) 0);
                mOnlyTyped = 0;
            }
            if (mResCount == 0 && !prefix && n >= 6) {
                // 2nd pass: up to two errors, for longer words
                setMaxCost(n <= 7 ? 100 : 120);
                walkRoot();
            }
        }
        sLastVisits = mVisits;
        if (n >= 4) split();
    }

    /** Search in C++ (MrNative). false = it did not run (no lib, non-direct buffer, error): use Java. */
    private boolean searchNative() {
        int n = mN;
        for (int j = 0; j < n; j++) System.arraycopy(mNear[j], 0, mNearFlat, j * 16, 16);
        int count = MrNative.search(mDict, mSize, n, mTb, mNearFlat, mNearCount, mR, mOutWords, mOutInfo, mOutScores);
        if (count < 0 || count > MAX_RESULTS) return false;
        for (int i = 0; i < count; i++) {
            int len = mOutInfo[1 + 2 * i];
            if (len < 0 || len > mResWord[i].length) return false;
        }
        mResCount = count;
        for (int i = 0; i < count; i++) {
            int len = mOutInfo[1 + 2 * i];
            System.arraycopy(mOutWords, i * MrNative.RESULT_CHARS, mResWord[i], 0, len);
            mResLen[i] = len;
            mResCost[i] = mOutInfo[2 + 2 * i];
            mResScore[i] = mOutScores[i];
        }
        sLastVisits = mOutInfo[0];
        return true;
    }

    /**
     * Cost limit and width of the dynamic-programming band: with a minimum cost of 30 for
     * changing the length (doubled letter, h, 2 for 1), column j can only stay within the limit if
     * |depth - j| <= limit / 30. Outside the band the cell is INF.
     */
    private void setMaxCost(int max) {
        mMaxCost = max;
        mBand = max / 30;
    }

    /** Root in two rounds: first the typed initial, then the other accepted ones. */
    private void walkRoot() {
        mOnlyTyped = 1;
        walk(mRoot, 0, 0, (char) 0);
        if (mVisits > NODE_BUDGET) return;
        mOnlyTyped = 2;
        walk(mRoot, 0, 0, (char) 0);
        mOnlyTyped = 0;
    }

    /** Is the typed one (without accent/case) the start of some dictionary word? */
    private boolean isPrefix() {
        mGuard = 0;
        return prefixRec(mRoot, 0);
    }

    /**
     * v1.77.2: node ceiling of isPrefix and of the split lookup (the recursive searches that do not go through walk). In a real dictionary
     * they visit a few hundred nodes at most (measured: 41 and 379 in 43 thousand queries); in a corrupt file,
     * with cyclic pointers and repeated letters, they used to grow exponentially and freeze the keyboard.
     */
    private int mGuard;

    private boolean prefixRec(int pos, int j) {
        if (pos < 0 || pos >= mSize) return false;
        if (++mGuard > NODE_BUDGET) return false;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        char want = mTb[j];
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return false;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return false;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + mAb - 1 >= mSize) return false;
                child = addrAt(pos);
                pos += mAb;
            } else {
                pos += 1;
            }
            if ((flags & 0x80) != 0) {
                if (pos >= mSize) return false;
                pos++;
                if (mLatest) pos = skipBigrams(pos);
            }
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (cb != want) continue;
            if (j + 1 == mN) {
                if (child != 0) return true;
            } else if (child != 0 && prefixRec(child, j + 1)) {
                return true;
            }
        }
        return false;
    }

    /** Initials accepted for the dictionary word. */
    private void firstLetters() {
        Arrays.fill(mFirst, false);
        char t = mTb[0];
        mFirst[t & 0xFF] = t < 256;
        for (int k = 0; k < mNearCount[0]; k++) {
            char c = mNear[0][k];
            if (c < 256) mFirst[c] = true;
        }
        MrRules r = mR;
        for (char c = 0; c < 256; c++) {
            // similar letters and swapped vowels; silent letters at the start ("omem" -> homem)
            if (r.pair(c, t) != 0 || r.silentStart[c] > 0) mFirst[c] = true;
        }
        // groups: typed "ch" may be "x" in the dictionary; typed "x" may be "ch"
        if (mN > 1) {
            for (int k = 0; k < r.t2a.length; k++) {
                if (r.t2a[k] == t && r.t2b[k] == mTb[1]) {
                    char d = MrText.base(r.t2d[k]);
                    if (d < 256) mFirst[d] = true;
                }
            }
        }
        for (int k = 0; k < r.d2t.length; k++) {
            if (r.d2t[k] == t) {
                char d = MrText.base(r.d2p[k]);
                if (d < 256) mFirst[d] = true;
            }
        }
        if (mN > 1 && mTb[1] < 256) mFirst[mTb[1]] = true;
    }

    private int sub(int j, int cb) {
        if (cb >= 256) return cb == mTb[j] ? 0 : C_SUB;
        short s = mSub[j][cb];
        if (s < 0) {
            s = (short) subCost((char) cb, j);
            mSub[j][cb] = s;
        }
        return s;
    }

    private void walk(int pos, int depth, int pcb, char parentRaw) {
        if (pos < 0 || pos >= mSize) return;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        int[] prev = mRows[depth];
        int[] prev2 = depth > 0 ? mRows[depth - 1] : null;
        int n = mN;
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            boolean terminal = (flags & 0x80) != 0;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + mAb - 1 >= mSize) return;
                child = addrAt(pos);
                pos += mAb;
            } else {
                pos += 1;
            }
            int freq = 0;
            if (terminal) {
                if (pos >= mSize) return;
                freq = mDict.get(pos++) & 0xFF;
                if (mLatest) pos = skipBigrams(pos);
            }
            if (++mVisits > NODE_BUDGET) return;
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (depth == 0) {
                if (cb >= 256) continue;
                if (mOnlyTyped == 3) {
                    if (mFirst[cb]) continue;
                } else {
                    if (!mFirst[cb]) continue;
                    if (mOnlyTyped == 1 && cb != mTb[0]) continue;
                    if (mOnlyTyped == 2 && cb == mTb[0]) continue;
                }
            }
            char raw = (char) c;
            char rl = c < 256 ? LOWER[c] : Character.toLowerCase(raw);
            int del = delCost(cb, pcb, depth);
            // does the dictionary have 2 letters (parent + this one) for 1 typed? (groups: x = ch, c = sc...)
            int d1 = -1, d2 = -1;
            if (prev2 != null && mR.d2p.length > 0) {
                char p = parentRaw < 256 ? LOWER[parentRaw] : Character.toLowerCase(parentRaw);
                char[] gp = mR.d2p, gc = mR.d2c, gt = mR.d2t;
                for (int k = 0; k < gp.length; k++) {
                    if (gp[k] == p && gc[k] == rl) {
                        if (d1 < 0) d1 = gt[k];
                        else if (d2 < 0) d2 = gt[k];
                    }
                }
            }
            int[] cur = mRows[depth + 1];
            int r = depth + 1;
            int lo = r - mBand;
            int hi = r + mBand;
            if (hi > n) hi = n;
            int rowMin = INF;
            if (lo <= 0) {
                int best0 = prev[0] + del;
                if (best0 > INF) best0 = INF;
                cur[0] = best0;
                rowMin = best0;
                lo = 1;
            } else {
                cur[lo - 1] = INF;
            }
            if (hi + 1 <= n) cur[hi + 1] = INF;
            if (hi + 2 <= n) cur[hi + 2] = INF;
            boolean onlyDel = depth == 0 && mOnlyTyped == 3;
            for (int j = lo; j <= hi; j++) {
                int tj1 = mTb[j - 1];
                // in the pass for the 1st missing letter, the root can only be a missing letter
                int best = onlyDel ? INF : prev[j - 1] + sub(j - 1, cb);
                int v = cur[j - 1] + mIns[j - 1];
                if (v < best) best = v;
                v = prev[j] + del;
                if (v < best) best = v;
                if (j >= 2) {
                    if (prev2 != null && cb == mTb[j - 2] && pcb == tj1 && cb != pcb) {
                        v = prev2[j - 2] + C_TRANS;
                        if (v < best) best = v;
                    }
                    if ((mTwoD1[j] != 0 && rl == mTwoD1[j]) || (mTwoD2[j] != 0 && rl == mTwoD2[j])) {
                        v = prev[j - 2] + C_MULTI;
                        if (v < best) best = v;
                    }
                }
                if (d1 >= 0 && (tj1 == d1 || tj1 == d2)) {
                    v = prev2[j - 1] + C_MULTI;
                    if (v < best) best = v;
                }
                if (best > INF) best = INF;
                cur[j] = best;
                if (best < rowMin) rowMin = best;
            }
            if (depth < MAX_WORD) mPath[depth] = raw;
            if (terminal && hi == n && cur[n] <= mMaxCost && depth + 1 <= MAX_WORD && freq > 0) {
                offer(mPath, depth + 1, freq, cur[n]);
            }
            if (child != 0 && rowMin <= mMaxCost && depth + 1 < n + mBand
                    && depth + 2 < mRows.length && depth + 1 < MAX_WORD) {
                walk(child, depth + 1, cb, raw);
                if (mVisits > NODE_BUDGET) return;
                // the recursion overwrote mRows[depth + 2..]; mRows[depth + 1] is for this entry
                prev = mRows[depth];
                prev2 = depth > 0 ? mRows[depth - 1] : null;
            }
        }
    }

    /** The address that starts at the flags byte (6 bits) followed by 2 bytes (format v1) or 3 bytes (v2). */
    private int addrAt(int pos) {
        int a = ((mDict.get(pos) & 0x3F) << 8) | (mDict.get(pos + 1) & 0xFF);
        a = (a << 8) | (mDict.get(pos + 2) & 0xFF);
        return mAb == 3 ? a : ((a << 8) | (mDict.get(pos + 3) & 0xFF));
    }

    private int skipBigrams(int pos) {
        if (pos >= mSize) return pos;
        if ((mDict.get(pos) & 0x80) != 0) {
            int guard = 0;
            while (pos + mAb < mSize && guard++ < 10000) {
                pos += mAb;
                int more = mDict.get(pos++) & 0x80;
                if (more == 0) break;
            }
            return pos;
        }
        return pos + 1;
    }

    private boolean isNear(int j, char cb) {
        char[] near = mNear[j];
        for (int k = mNearCount[j] - 1; k >= 0; k--) {
            if (near[k] == cb) return true;
        }
        return false;
    }

    /** Position of cb among the neighbours of touch j (0 = the closest), or -1. */
    private int nearRank(int j, char cb) {
        char[] near = mNear[j];
        int cnt = mNearCount[j];
        for (int k = 0; k < cnt; k++) {
            if (near[k] == cb) return k;
        }
        return -1;
    }

    private int subCost(char cb, int j) {
        char t = mTb[j];
        if (cb == t) return 0;
        int near = nearRank(j, cb);
        if (near >= 0) return near == 0 ? C_PROX_1 : near == 1 ? C_PROX_2 : C_PROX_FAR;
        int kind = mR.pair(cb, t);
        if (kind == 1) return C_PHON;
        if (kind == 2) return C_VOWEL;
        return C_SUB;
    }

    /** Typed letter in excess at position j. */
    private int insCost(int j) {
        char t = mTb[j];
        if (j > 0 && mTb[j - 1] == t) return C_INS_DOUBLE;
        if (t < 256 && mR.extra[t]) return C_INS_H;
        if (j > 0 && isNear(j - 1, t)) return C_INS_NEAR;
        if (j + 1 < mN && isNear(j + 1, t)) return C_INS_NEAR;
        return C_INS;
    }

    /** Dictionary letter that was not typed. */
    private int delCost(int cb, int pcb, int depth) {
        MrRules r = mR;
        if (depth == 0 && mOnlyTyped == 3) {
            int s0 = cb < 256 ? r.silentStart[cb] : 0;
            return s0 > 0 && s0 < C_DEL_FIRST ? s0 : C_DEL_FIRST;
        }
        if (depth == 0 && cb < 256 && r.silentStart[cb] > 0) return r.silentStart[cb];
        if (depth > 0 && cb == pcb) return C_DEL_DOUBLE;
        char[] sp = r.silPrev, sc = r.silChar;
        for (int k = 0; k < sp.length; k++) {
            if (sc[k] == cb && sp[k] == pcb) return r.silCost[k];
        }
        if (depth > 0 && cb < 256 && r.silentAny[cb] > 0) return r.silentAny[cb];
        return C_DEL;
    }

    private long scoreFor(int freq, int cost) {
        int n = Math.min(mN, 24);
        double base = (double) freq * (double) (1L << (n + 1));
        double s = base * Math.pow(2.0, -cost / 25.0);
        if (s > Integer.MAX_VALUE / 8) s = Integer.MAX_VALUE / 8;
        return (long) s;
    }

    private void offer(char[] word, int len, int freq, int cost) {
        long score = scoreFor(freq, cost);
        if (score <= 0) return;
        insert(word, 0, len, score, cost);
    }

    private void insert(char[] word, int off, int len, long score, int cost) {
        // repeated? keep the one with the highest score
        for (int i = 0; i < mResCount; i++) {
            if (mResLen[i] == len && same(mResWord[i], word, off, len)) {
                if (score <= mResScore[i]) return;
                remove(i);
                break;
            }
        }
        int at = mResCount;
        while (at > 0 && mResScore[at - 1] < score) at--;
        if (at >= MAX_RESULTS) return;
        int last = Math.min(mResCount, MAX_RESULTS - 1);
        for (int i = last; i > at; i--) {
            char[] tmp = mResWord[i];
            mResWord[i] = mResWord[i - 1];
            mResWord[i - 1] = tmp;
            mResLen[i] = mResLen[i - 1];
            mResScore[i] = mResScore[i - 1];
            mResCost[i] = mResCost[i - 1];
        }
        System.arraycopy(word, off, mResWord[at], 0, len);
        mResLen[at] = len;
        mResScore[at] = score;
        mResCost[at] = cost;
        if (mResCount < MAX_RESULTS) mResCount++;
    }

    private void remove(int i) {
        char[] tmp = mResWord[i];
        for (int k = i; k < mResCount - 1; k++) {
            mResWord[k] = mResWord[k + 1];
            mResLen[k] = mResLen[k + 1];
            mResScore[k] = mResScore[k + 1];
            mResCost[k] = mResCost[k + 1];
        }
        mResWord[mResCount - 1] = tmp;
        mResCount--;
    }

    private static boolean same(char[] a, char[] b, int off, int len) {
        for (int i = 0; i < len; i++) if (a[i] != b[off + i]) return false;
        return true;
    }

    void emit(Dictionary.WordCallback cb) {
        for (int i = 0; i < mResCount; i++) {
            long s = mResScore[i];
            cb.addWord(mResWord[i], 0, mResLen[i], (int) Math.min(s, Integer.MAX_VALUE / 8), 1,
                    Dictionary.DataType.UNIGRAM);
        }
    }

    // ------------------------------------------------------------------ missing space

    private final char[] mSplitBuf = new char[MAX_WORD * 2 + 2];
    private final char[] mLeftBuf = new char[MAX_WORD + 1];
    private final char[] mLookBuf = new char[MAX_WORD + 1];
    private final char[] mLookPath = new char[MAX_WORD + 1];
    private int mLookFreq;
    private int mLookLen;

    private void split() {
        int n = mN;
        mGuard = 0;
        long bestScore = 0;
        int bestLen = 0;
        for (int k = 1; k <= n - 2; k++) {
            if (k == 1 && !oneLetterWord(mTb[0])) continue;
            int fl = lookup(0, k);
            if (fl <= 0) continue;
            int leftLen = mLookLen;
            System.arraycopy(mLookBuf, 0, mLeftBuf, 0, leftLen);
            int fr = lookup(k, n);
            if (fr <= 0) continue;
            long score = scoreFor(Math.min(fl, fr), C_SPLIT);
            if (score > bestScore) {
                bestScore = score;
                System.arraycopy(mLeftBuf, 0, mSplitBuf, 0, leftLen);
                mSplitBuf[leftLen] = ' ';
                System.arraycopy(mLookBuf, 0, mSplitBuf, leftLen + 1, mLookLen);
                bestLen = leftLen + 1 + mLookLen;
            }
        }
        if (bestLen > 0) insert(mSplitBuf, 0, bestLen, bestScore, C_SPLIT);
    }

    private boolean oneLetterWord(char b) {
        return b < 256 && mR.oneLetter[b];
    }

    /** Looks up mTb[from..to) in the trie ignoring accents; keeps the most frequent spelling in mLookBuf. */
    private int lookup(int from, int to) {
        mLookFreq = 0;
        mLookLen = 0;
        if (to - from > MAX_WORD) return 0;
        lookupRec(mRoot, from, to, 0);
        return mLookFreq;
    }

    private void lookupRec(int pos, int j, int to, int depth) {
        if (pos < 0 || pos >= mSize) return;
        if (++mGuard > NODE_BUDGET) return;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        char want = mTb[j];
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            boolean terminal = (flags & 0x80) != 0;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + mAb - 1 >= mSize) return;
                child = addrAt(pos);
                pos += mAb;
            } else {
                pos += 1;
            }
            int freq = 0;
            if (terminal) {
                if (pos >= mSize) return;
                freq = mDict.get(pos++) & 0xFF;
                if (mLatest) pos = skipBigrams(pos);
            }
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (cb != want) continue;
            char raw = (char) c;
            mLookPath[depth] = raw;
            if (j + 1 == to) {
                if (terminal && freq > mLookFreq && !Character.isUpperCase(mLookPath[0])) {
                    mLookFreq = freq;
                    mLookLen = depth + 1;
                    System.arraycopy(mLookPath, 0, mLookBuf, 0, depth + 1);
                }
            } else if (child != 0) {
                lookupRec(child, j + 1, to, depth + 1);
            }
        }
    }
}
