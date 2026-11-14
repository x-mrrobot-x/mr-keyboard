package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

import java.util.regex.Pattern;

/**
 * The word before the one being typed, for the suggestions (docs/plan-performance.md, stage 6).
 *
 * LatinIME.showSuggestions gives the suggestion engine the word before the one being typed (the bigram context). It used to ask the app
 * for it, synchronously, on every run: {@code getTextBeforeCursor(15)} and then the word before the last one of those 15 characters
 * ({@link EditingUtil#getPreviousWord}). Every run is one more letter of the same word, and the text before that word cannot change
 * by typing letters, so the second letter on does not need to ask again.
 *
 * What is kept: the text that was before the word being typed when the app was last asked ({@link #sTail}) and the word as it was
 * ({@link #sTyped}). The answer for a longer word is then worked out from the kept text and the word, with the same rule as
 * EditingUtil.getPreviousWord on the same 15 characters, so it is exactly the answer the app would have given, a truncated word
 * of a long previous word included (the window is 15 characters, whatever the length of the word typed).
 *
 * When the keyboard is certain:
 *  - what was read is kept only if the text before the cursor ends with the word the keyboard is composing (the app confirms where the
 *    word is); with anything else the answer is taken from the app every time, as before;
 *  - it is used only for the same word grown by letters at its end (the word typed starts with the word kept);
 *  - LatinIME clears it everywhere the word being typed starts, ends or is reopened (every change of {@code mPredicting},
 *    {@code WordComposer.reset}, a separator, a backspace, a text written by the keyboard, a new field).
 * Any doubt means asking as before. {@code docs/tools/prevword_test} compares the answer with the app's on random texts and counts
 * the questions.
 */
public final class MrPrevWord {
    private MrPrevWord() { }

    /** Characters read before the cursor: the window of EditingUtil.getPreviousWord. */
    static final int WINDOW = 15;
    private static final Pattern SPACES = Pattern.compile("\\s+");

    private static boolean sValid;
    private static String sTail = "";
    private static String sTyped = "";

    /** Forgets what was kept: the next answer comes from the app. */
    public static void clear() {
        sValid = false;
    }

    /**
     * The same answer as EditingUtil.getPreviousWord(ic, separators) while the keyboard is composing {@code composing} right before
     * the cursor. null if there is no previous word. Asks the app only when it cannot work the answer out from what it kept.
     */
    public static CharSequence get(InputConnection ic, String separators, CharSequence composing) {
        if (ic == null || separators == null) return null;
        int k = composing == null ? 0 : composing.length();
        if (sValid && k > 0 && k >= sTyped.length() && startsWith(composing, sTyped)) {
            String all = sTail + composing.toString();
            if (all.length() > WINDOW) all = all.substring(all.length() - WINDOW);
            return fromWindow(all, separators);
        }
        sValid = false;
        CharSequence before;
        MrPerf.appBegin();   // the question waits for the app: the performance meter counts it
        try {
            before = ic.getTextBeforeCursor(WINDOW, 0);
        } finally {
            MrPerf.appEnd();
        }
        if (before == null) return null;
        remember(before, composing);
        return fromWindow(before, separators);
    }

    /** Keeps what was read if the text before the cursor ends with the word being composed. */
    private static void remember(CharSequence before, CharSequence composing) {
        int k = composing == null ? 0 : composing.length();
        int n = before.length();
        if (k == 0 || n < k || !endsWith(before, composing)) return;
        sTail = before.subSequence(0, n - k).toString();
        sTyped = composing.toString();
        sValid = true;
    }

    /** EditingUtil.getPreviousWord on the text before the cursor (up to {@link #WINDOW} characters). */
    static CharSequence fromWindow(CharSequence before, String separators) {
        if (before == null) return null;
        String[] words = SPACES.split(before);
        int n = words.length;
        if (n >= 2 && words[n - 2].length() > 0) {
            String prev = words[n - 2];
            if (separators.contains(String.valueOf(prev.charAt(prev.length() - 1)))) return null;
            return prev;
        }
        return null;
    }

    private static boolean startsWith(CharSequence text, String prefix) {
        int n = prefix.length();
        if (text.length() < n) return false;
        for (int i = 0; i < n; i++) {
            if (text.charAt(i) != prefix.charAt(i)) return false;
        }
        return true;
    }

    private static boolean endsWith(CharSequence text, CharSequence suffix) {
        int n = suffix.length();
        int from = text.length() - n;
        if (from < 0) return false;
        for (int i = 0; i < n; i++) {
            if (text.charAt(from + i) != suffix.charAt(i)) return false;
        }
        return true;
    }
}
