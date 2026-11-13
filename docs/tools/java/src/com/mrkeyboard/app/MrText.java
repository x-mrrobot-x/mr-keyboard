package com.mrkeyboard.app;

/**
 * Text utilities for pt-BR suggestions (v1.60).
 * - base(): lowercase without accent (á -> a, ç -> c), the same idea as BASE_CHARS in the native lib.
 * - fillInitials()/allInitials(): 1st-letter alternatives for the bigram query, because the lib
 *   compares the initial of the next word exactly (é != e).
 * - lastWord(): last word before the cursor, for the prediction after the space.
 */
public final class MrText {
    private MrText() { }

    /** Lowercase without accent for Latin letters; other characters only lowercased. */
    public static char base(int code) {
        char c = (char) code;
        switch (c) {
            case 'à': case 'á': case 'â': case 'ã': case 'ä': case 'å':
            case 'À': case 'Á': case 'Â': case 'Ã': case 'Ä': case 'Å':
                return 'a';
            case 'ç': case 'Ç':
                return 'c';
            case 'è': case 'é': case 'ê': case 'ë':
            case 'È': case 'É': case 'Ê': case 'Ë':
                return 'e';
            case 'ì': case 'í': case 'î': case 'ï':
            case 'Ì': case 'Í': case 'Î': case 'Ï':
                return 'i';
            case 'ñ': case 'Ñ':
                return 'n';
            case 'ò': case 'ó': case 'ô': case 'õ': case 'ö':
            case 'Ò': case 'Ó': case 'Ô': case 'Õ': case 'Ö':
                return 'o';
            case 'ù': case 'ú': case 'û': case 'ü':
            case 'Ù': case 'Ú': case 'Û': case 'Ü':
                return 'u';
            case 'ý': case 'ÿ': case 'Ý':
                return 'y';
            default:
                return Character.toLowerCase(c);
        }
    }

    /** true if the 1st letter of word and typed are the same letter, ignoring case and accent. */
    public static boolean sameInitial(CharSequence word, int typed) {
        if (word == null || word.length() == 0) return false;
        return base(word.charAt(0)) == base(typed);
    }

    private static final String VARIANTS_A = "àáâã";
    private static final String VARIANTS_E = "éê";
    private static final String VARIANTS_I = "í";
    private static final String VARIANTS_O = "óôõ";
    private static final String VARIANTS_U = "úü";
    private static final String VARIANTS_C = "ç";

    private static String variantsOf(char b) {
        switch (b) {
            case 'a': return VARIANTS_A;
            case 'e': return VARIANTS_E;
            case 'i': return VARIANTS_I;
            case 'o': return VARIANTS_O;
            case 'u': return VARIANTS_U;
            case 'c': return VARIANTS_C;
            default: return "";
        }
    }

    private static int put(int[] dst, int count, int max, int code) {
        if (code <= 0 || count >= max) return count;
        for (int i = 0; i < count; i++) {
            if (dst[i] == code) return count;
        }
        dst[count] = code;
        return count + 1;
    }

    /**
     * Copies the codes of the 1st position (touched key and neighbours) to dst and adds the accented
     * and uppercase variants of each. Returns how many codes were written; the rest of dst
     * (up to max) gets -1.
     */
    public static int fillInitials(int[] src, int[] dst, int max) {
        if (max > dst.length) max = dst.length;
        int count = 0;
        if (src != null) {
            for (int k = 0; k < src.length; k++) {
                int code = src[k];
                if (code <= 0) {
                    if (k == 0) continue;
                    break;
                }
                char b = base(code);
                count = put(dst, count, max, code);
                count = put(dst, count, max, Character.toUpperCase((char) code));
                if (Character.isLetter((char) code)) {
                    count = put(dst, count, max, b);
                    count = put(dst, count, max, Character.toUpperCase(b));
                    String v = variantsOf(b);
                    for (int i = 0; i < v.length(); i++) {
                        count = put(dst, count, max, v.charAt(i));
                        count = put(dst, count, max, Character.toUpperCase(v.charAt(i)));
                    }
                }
            }
        }
        for (int i = count; i < max; i++) dst[i] = -1;
        return count;
    }

    private static final String ALL_LOWER = "abcdefghijklmnopqrstuvwxyzàáâãéêíóôõúüç";

    /** All the initials (a-z, accented, lowercase and uppercase), to predict without a typed letter. */
    public static int allInitials(int[] dst) {
        int count = 0;
        int max = dst.length;
        for (int i = 0; i < ALL_LOWER.length(); i++) {
            char c = ALL_LOWER.charAt(i);
            count = put(dst, count, max, c);
            count = put(dst, count, max, Character.toUpperCase(c));
        }
        for (int i = count; i < max; i++) dst[i] = -1;
        return count;
    }

    /**
     * Fixes the words that the native lib returns from the bigrams. On x86 the lib's char is signed and
     * the letters from 0x80 to 0xFF arrive as 0xFF80..0xFFFF (é becomes U+FFE9); on ARM it does not happen.
     * The dictionary only has characters below U+00FF, so nothing legitimate falls in that range.
     */
    public static void fixNative(char[] buf) {
        if (buf == null) return;
        for (int i = 0; i < buf.length; i++) {
            char c = buf[i];
            if (c >= 0xFF80) buf[i] = (char) (c & 0xFF);
        }
    }

    /**
     * Can it enter learning (AutoDictionary and user bigrams)? Not for suggestions with a
     * space (MrFix corrections like "com certeza" and "por isso", or missing space): they become
     * two words in the text and each one is already learned as a bigram when it is chosen.
     */
    public static boolean learnable(CharSequence word) {
        if (word == null) return false;
        int n = word.length();
        if (n == 0) return false;
        for (int i = 0; i < n; i++) {
            if (Character.isWhitespace(word.charAt(i))) return false;
        }
        return true;
    }

    /**
     * Frequency that a user bigram (UserBigramDictionary, +2 per use) is now worth in the
     * prediction and in the 1st letter, on the dictionary's 7-bit scale: 2 uses = 80, 3 = 100, 5+ = 127.
     * Before, it only showed up at 12 (6 uses) and was worth the raw number, below the dictionary suggestions.
     */
    public static int userBigramScore(int freq) {
        int s = 40 + 10 * freq;
        return s > 127 ? 127 : s;
    }

    /** Empty text or ending in . ! ? (ignoring spaces): start of a sentence. */
    public static boolean atSentenceStart(CharSequence before) {
        if (before == null) return true;
        int end = before.length();
        while (end > 0 && Character.isWhitespace(before.charAt(end - 1))) end--;
        if (end == 0) return true;
        char c = before.charAt(end - 1);
        // ¿ and ¡ open a sentence in Spanish (v1.65): "¿" -> shows the sentence starts
        return c == '.' || c == '!' || c == '?' || c == '…' || c == '¿' || c == '¡';
    }

    /**
     * The last two words before the cursor: {second to last or null, last}. The second to last only counts if
     * between the two there is only a space (a comma or period breaks the context). null if there is no
     * last word.
     */
    public static String[] lastTwoWords(CharSequence before) {
        String w2 = lastWord(before);
        if (w2 == null) return null;
        int end = before.length();
        while (end > 0 && Character.isWhitespace(before.charAt(end - 1))) end--;
        int start = end;
        while (start > 0) {
            char c = before.charAt(start - 1);
            if (Character.isLetter(c) || c == '\'' || c == '-') start--;
            else break;
        }
        int k = start;
        boolean space = false;
        while (k > 0 && Character.isWhitespace(before.charAt(k - 1))) { k--; space = true; }
        String w1 = null;
        if (space && k > 0 && Character.isLetter(before.charAt(k - 1))) {
            w1 = lastWord(before.subSequence(0, k));
        }
        return new String[] {w1, w2};
    }

    /**
     * Last word before the cursor (ignoring trailing spaces). Returns null if the text ends in
     * punctuation or a number, or if there is no word: in those cases there is no prediction and the strip is empty.
     */
    public static String lastWord(CharSequence before) {
        if (before == null) return null;
        int end = before.length();
        while (end > 0 && Character.isWhitespace(before.charAt(end - 1))) end--;
        if (end == 0) return null;
        int start = end;
        while (start > 0) {
            char c = before.charAt(start - 1);
            if (Character.isLetter(c) || c == '\'' || c == '-') start--;
            else break;
        }
        while (start < end && !Character.isLetter(before.charAt(start))) start++;
        while (end > start && !Character.isLetter(before.charAt(end - 1))) end--;
        if (start >= end) return null;
        if (end - start > 47) return null;
        return before.subSequence(start, end).toString();
    }
}
