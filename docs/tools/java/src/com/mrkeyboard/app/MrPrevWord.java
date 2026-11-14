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
 *
 * Second use (stage 7): the word that a separator commits is learned as a pair with the word before it (checkAddToDictionary), which used
 * to ask the app for that word once more. {@link #hold} keeps what was known about the word, for that one key, before the separator
 * forgets it; {@link #previousForLearning} works the answer out from it (the same 15 characters, whatever the length of the word that
 * was really committed) and asks the app only when it cannot; {@link #release} drops it when the key is done.
 *
 * What stays in memory: at most the {@link #WINDOW} characters before the word being typed, in one place, overwritten by the next word.
 * Forgetting a word ({@link #clear}) drops the text too, not only the flag, and {@link #reset} (end of the input, keyboard hidden or
 * destroyed) drops everything, so nothing typed is left behind for a field that is not the one it came from.
 */
public final class MrPrevWord {
    private MrPrevWord() { }

    /** Characters read before the cursor: the window of EditingUtil.getPreviousWord. */
    static final int WINDOW = 15;
    private static final Pattern SPACES = Pattern.compile("\\s+");

    private static boolean sValid;
    private static String sTail = "";
    private static String sTyped = "";
    /** The text read was the whole text before the cursor (shorter than the window), so there is nothing before {@link #sTail}. */
    private static boolean sComplete;

    /** What {@link #hold} took from the word, for the learning of the key that is being handled. */
    private static boolean sHeld;
    private static String sHeldTail = "";
    private static boolean sHeldComplete;

    /** Forgets the word kept (the text too): the next answer comes from the app. What {@link #hold} took stays until {@link #release}. */
    public static void clear() {
        sValid = false;
        sTail = "";
        sTyped = "";
        sComplete = false;
    }

    /** Forgets everything, the word kept and what was held (end of the input, the keyboard hidden, the service destroyed). */
    public static void reset() {
        clear();
        release();
    }

    /** Drops what {@link #hold} took. */
    public static void release() {
        sHeld = false;
        sHeldTail = "";
        sHeldComplete = false;
    }

    /**
     * At the start of a separator: keeps, for this key only, the text before the word that the separator commits, if the word was
     * kept and {@code composing} (the word as typed now) is that word grown by letters; then forgets the word as before. Without
     * either, nothing is held and the learning asks the app.
     */
    public static void hold(CharSequence composing) {
        release();
        int k = composing == null ? 0 : composing.length();
        if (sValid && k > 0 && k >= sTyped.length() && startsWith(composing, sTyped)) {
            sHeld = true;
            sHeldTail = sTail;
            sHeldComplete = sComplete;
        }
        clear();
    }

    /**
     * The word before the one just committed, for the learning of a pair: the same answer as EditingUtil.getPreviousWord(ic, separators)
     * would give with the committed word (its length in the field is {@code committedLength}) right before the cursor. Worked out from
     * what {@link #hold} took when that is certain: the text before the word, and a word that is the last thing before the cursor. It
     * needs the 15 characters of the window: the text kept plus the word fill them, or the text kept was everything before the cursor.
     * Otherwise it asks the app, as before.
     */
    public static CharSequence previousForLearning(InputConnection ic, String separators, int committedLength) {
        if (ic == null || separators == null) return null;
        if (sHeld && committedLength > 0) {
            int word = Math.min(committedLength, WINDOW);
            int need = WINDOW - word;
            String tail = sHeldTail;
            if (tail.length() >= need || sHeldComplete) {
                String keep = need >= tail.length() ? tail : tail.substring(tail.length() - need);
                StringBuilder all = new StringBuilder(keep);
                for (int i = 0; i < word; i++) all.append('x');
                return fromWindow(all, separators);
            }
        }
        CharSequence before = ask(ic);
        return before == null ? null : fromWindow(before, separators);
    }

    /** Tests only: how many characters of typed text are in memory (the word kept and what was held). */
    static int textInMemory() {
        return sTail.length() + sTyped.length() + sHeldTail.length();
    }

    /** True if the text ends with a character that is not white space: after it, a space typed is not the second one of two. */
    public static boolean endsPlain(CharSequence text) {
        int n = text == null ? 0 : text.length();
        return n > 0 && !Character.isWhitespace(text.charAt(n - 1));
    }

    /** The window of EditingUtil.getPreviousWord, asked of the app (counted by the performance meter). */
    private static CharSequence ask(InputConnection ic) {
        MrPerf.appBegin();   // the question waits for the app: the performance meter counts it
        try {
            return ic.getTextBeforeCursor(WINDOW, 0);
        } finally {
            MrPerf.appEnd();
        }
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
        clear();
        CharSequence before = ask(ic);
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
        sComplete = n < WINDOW;
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
