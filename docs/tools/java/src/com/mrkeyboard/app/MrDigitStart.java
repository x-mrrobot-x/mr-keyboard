package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

/**
 * A digit typed for the first letter of a word ("5udo" for tudo, "3ntão", "8sso"): the number row sits right above q..p, so a finger that
 * starts a word on the top row can land on the digit above. A digit does not start a word (LatinIME.isAlphabet), and the letter after it
 * did not either, because the cursor was already touching the digit: the word was never composed and got no suggestion and no correction.
 *
 * <p>Now the digit keeps its touch ({@link #sent}, from LatinIME.handleCharacter when a character goes to the field outside a word) and, when
 * a letter comes right after it, {@link #take} gives the digit back to the word: it takes it out of the field and hands its codes over, and
 * LatinIME starts the word with the digit and the letter ("5u" composing), so the search sees the touch on 5 with t among its neighbours.
 * Where the field asks for a capital there (the start of a sentence: the shift was on for the digit and went off after it), LatinIME marks
 * the word as capitalized, so the suggestions come with the capital ("5udo" -> Tudo; MrFuzzy.sCapTyped).
 *
 * <p>Only a lone digit: typed on the letter keyboard (the number row; not the symbols sheet), alone after a space, the start of the text or
 * an opening bracket or quote, with nothing glued after the cursor, and the last thing typed. A number ("10h", "2026", "3,5") or a digit
 * after a word stays as it is. What may be replaced on its own is decided by MrFuzzy.digitSlip: "5udo" becomes tudo, "9h", "3dias", "2kg"
 * stay as typed (they only get suggestions).
 */
public final class MrDigitStart {
    /** The digit sent last outside a word, or 0. */
    private static char sDigit;
    /** Its codes (the digit and the keys near the touch, in order of distance), or null. */
    private static int[] sCodes;

    private MrDigitStart() { }

    /** A character went to the field outside a word: a digit of the letter keyboard is kept with its touch; anything else forgets it. */
    public static void sent(LatinIME ime, int code, int[] codes) {
        sDigit = 0;
        sCodes = null;
        try {
            if (code < '0' || code > '9' || codes == null || codes.length == 0) return;
            KeyboardSwitcher switcher = KeyboardSwitcher.getInstance();
            if (switcher == null || !switcher.isAlphabetMode()) return;
            int[] copy = codes.clone();
            copy[0] = code;
            sDigit = (char) code;
            sCodes = copy;
        } catch (Throwable t) {
            sDigit = 0;
            sCodes = null;
        }
    }

    /**
     * A letter is being typed with the cursor touching a word: when that is the lone digit sent just before, it leaves the field and its codes
     * come back (codes[0] is the digit) for the word to start with it; null otherwise (nothing is changed). Asked once: the digit is forgotten.
     */
    public static int[] take(LatinIME ime) {
        char digit = sDigit;
        int[] codes = sCodes;
        sDigit = 0;
        sCodes = null;
        if (digit == 0 || codes == null || ime == null) return null;
        try {
            InputConnection ic = ime.getCurrentInputConnection();
            if (ic == null) return null;
            if (!lone(ic.getTextBeforeCursor(2, 0), ic.getTextAfterCursor(1, 0), digit)) return null;
            if (!ic.deleteSurroundingText(1, 0)) return null;
            return codes;
        } catch (Throwable t) {
            return null;
        }
    }

    /**
     * The text around the cursor has the digit alone: it is the last character before the cursor, the one before it (if any) is a space or an
     * opening bracket or quote, and the one after the cursor (if any) is not a letter or a digit.
     */
    static boolean lone(CharSequence before, CharSequence after, char digit) {
        if (before == null || before.length() == 0 || before.charAt(before.length() - 1) != digit) return false;
        if (before.length() >= 2) {
            char prev = before.charAt(before.length() - 2);
            if (!Character.isWhitespace(prev) && "([{\"'«¿¡“‘".indexOf(prev) < 0) return false;
        }
        return after == null || after.length() == 0 || !Character.isLetterOrDigit(after.charAt(0));
    }
}
