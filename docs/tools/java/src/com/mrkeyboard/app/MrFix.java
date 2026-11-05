package com.mrkeyboard.app;

/**
 * Map of common errors and abbreviations of the language (v1.60). Since 1.63 the list comes from the dictionary
 * pack ([corrections] section of rules.txt, read by MrRules); without a pack, there are no corrections.
 * The key is the typed form in lowercase and without accent (MrText.base); the value is the suggestion. The
 * suggestion enters as the best of the list; with autocorrect on it only replaces the word if
 * the typed one is not valid.
 */
public final class MrFix {
    private MrFix() { }

    /** Lookup key: lowercase and without accent. */
    static String key(CharSequence typed) {
        if (typed == null) return null;
        int n = typed.length();
        if (n == 0 || n > 24) return null;
        char[] k = new char[n];
        for (int i = 0; i < n; i++) k[i] = MrText.base(typed.charAt(i));
        return new String(k);
    }

    /** Suggestion for the typed word, or null. */
    public static String lookup(CharSequence typed) {
        MrRules r = MrRules.get();
        if (r.corrections.isEmpty()) return null;
        String k = key(typed);
        if (k == null) return null;
        return r.corrections.get(k);
    }

    /** Number of entries (for tests). */
    static int size() {
        return MrRules.get().corrections.size();
    }
}
