package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

import java.util.Arrays;
import java.util.List;

/**
 * Re-correction (v1.74, "Tocar para corrigir palavras" / tap to correct words): finds the word under the cursor and decides whether it
 * deserves suggestions. LatinIME.setOldSuggestions calls {@link #wordAt} and {@link #eligible}.
 *
 * Before, the method only showed suggestions for words that the dictionary already knew or that had been
 * typed in the session; a wrong word outside that (the one that most needs correction) was left with nothing.
 * Now every word with letters qualifies; only what is not a word to correct is left out.
 *
 * Neighbouring keys (v1.75): the reopened word is rebuilt with the keys around each letter, taken from the
 * keyboard on screen, as in typing ({@link #composer}). Before, it carried only the letters and the correction
 * by neighbouring key ("fato" for gato) did not work on the reopened word.
 *
 * Reading the text (by Android version, according to the documentation):
 *  - API 31+: InputConnection.getSurroundingText returns the surrounding text, the selection and its
 *    offset in the editor in a single call. The position comes from the same snapshot of the text, without depending
 *    on the last stored selection (which may be stale) and without getExtractedText (the whole field text).
 *  - API 26 to 30, or an editor that does not return the snapshot: EditingUtil.getWordAtCursorOrSelection, as always.
 */
public final class MrRecorrect {
    private MrRecorrect() { }

    /** Same limit as the dictionary (BinaryDictionary.MAX_WORD_LENGTH): above that the search does not run. */
    static final int MAX_WORD = 48;
    /** Characters read on each side of the cursor (the same as EditingUtil). */
    static final int REACH = 1000;

    /** Internal answer: the text snapshot is no use, take the usual path (never leaves this class). */
    static final EditingUtil.SelectedWord NO_SNAPSHOT = new EditingUtil.SelectedWord();

    /**
     * Word of 2 to 48 characters, with at least one letter and no digit (codes, passwords,
     * "4g", "abc123" do not get suggestions).
     */
    static boolean eligible(CharSequence word) {
        if (word == null) return false;
        int n = word.length();
        if (n < 2 || n > MAX_WORD) return false;
        boolean letter = false;
        for (int i = 0; i < n; i++) {
            char c = word.charAt(i);
            if (Character.isDigit(c)) return false;
            if (Character.isLetter(c)) letter = true;
        }
        return letter;
    }

    /**
     * The word under the cursor, or the selection when it is a whole word; null if there is no word.
     * start and end are positions in the editor text (what setComposingRegion expects).
     */
    static EditingUtil.SelectedWord wordAt(InputConnection ic, int selStart, int selEnd, String separators) {
        if (ic == null || separators == null) return null;
        if (Build.VERSION.SDK_INT >= 31) {
            EditingUtil.SelectedWord w = Api31.wordAt(ic, selStart, selEnd, separators);
            if (w != NO_SNAPSHOT) return w;
        }
        return EditingUtil.getWordAtCursorOrSelection(ic, selStart, selEnd, separators);
    }

    /** Separate so that Android 8 to 11 never load SurroundingText (API 31). */
    static final class Api31 {
        private Api31() { }

        static EditingUtil.SelectedWord wordAt(InputConnection ic, int selStart, int selEnd, String separators) {
            SurroundingText st;
            MrPerf.appBegin();   // the question waits for the app: the performance meter counts it
            try {
                st = ic.getSurroundingText(REACH, REACH, 0);
            } catch (RuntimeException e) {
                return NO_SNAPSHOT;
            } finally {
                MrPerf.appEnd();
            }
            if (st == null) return NO_SNAPSHOT;
            return fromSnapshot(st.getText(), st.getSelectionStart(), st.getSelectionEnd(), st.getOffset(),
                    selStart, selEnd, separators);
        }
    }

    /**
     * Finds the word inside the text snapshot. text = the text read; s/e = the selection inside it (may
     * come inverted); offset = where the text starts in the editor (-1 if the editor does not know; then the position
     * comes from the last stored selection, cachedStart/cachedEnd).
     */
    static EditingUtil.SelectedWord fromSnapshot(CharSequence text, int s, int e, int offset,
            int cachedStart, int cachedEnd, String separators) {
        if (text == null) return NO_SNAPSHOT;
        int n = text.length();
        if (s > e) { int t = s; s = e; e = t; }
        if (s < 0 || e > n) return NO_SNAPSHOT;
        int base = offset >= 0 ? offset : Math.min(cachedStart, cachedEnd) - s;
        if (base < 0) return NO_SNAPSHOT;
        int a, b;
        if (s == e) {
            a = s;
            while (a > 0 && !isSeparator(text.charAt(a - 1), separators)) a--;
            b = e;
            while (b < n && !isSeparator(text.charAt(b), separators)) b++;
            if (a == b) return null;
        } else {
            // selection: only counts if it is a whole word (separator or text edge on each side,
            // no separator inside)
            if (s == 0 ? offset > 0 : !isSeparator(text.charAt(s - 1), separators)) return null;
            if (e < n && !isSeparator(text.charAt(e), separators)) return null;
            for (int i = s; i < e; i++) {
                if (isSeparator(text.charAt(i), separators)) return null;
            }
            a = s;
            b = e;
        }
        EditingUtil.SelectedWord w = new EditingUtil.SelectedWord();
        w.word = text.subSequence(a, b).toString();
        w.start = base + a;
        w.end = base + b;
        return w;
    }

    private static boolean isSeparator(char c, String separators) {
        return separators.indexOf(c) >= 0;
    }

    // ------------------------------------------------------------------ strip of the reopened word

    /**
     * Is the reopened word a dictionary word (as is or in lowercase)? If so, the strip shows it in the
     * center, as in typing ("gato" in the middle and "fato", "gatos" at the sides); if not, the center holds the
     * best correction. Without this, the neighbouring keys made "fato" take the center from a correct word (1.75).
     */
    static boolean isValid(Suggest suggest, CharSequence word) {
        if (suggest == null || word == null || word.length() == 0) return false;
        try {
            String w = word.toString();
            return suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase());
        } catch (RuntimeException e) {
            return false;
        }
    }

    // ------------------------------------------------------------------ reopened word with neighbouring keys

    /** Size of the typing codes vector (ProximityKeyDetector.getMaxNearbyKeys). */
    static final int NEARBY = 12;

    /**
     * The word as if it had just been typed: each letter carries, after it, the neighbouring keys of the
     * current keyboard, from the closest to the farthest (what the ProximityKeyDetector does on touch,
     * with the center of the key in place of the finger). Without a letter keyboard on screen, only the letters.
     */
    static WordComposer composer(KeyboardSwitcher switcher, CharSequence word) {
        WordComposer wc = new WordComposer();
        Keyboard kb = null;
        List<Keyboard.Key> keys = null;
        try {
            LatinKeyboardView view = switcher != null ? switcher.getInputView() : null;
            kb = view != null ? view.getKeyboard() : null;
            keys = kb != null ? kb.getKeys() : null;
        } catch (RuntimeException e) {
            kb = null;
            keys = null;
        }
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            wc.add(c, codesFor(kb, keys, c));
        }
        wc.setFirstCharCapitalized(word.length() > 0 && Character.isUpperCase(word.charAt(0)));
        return wc;
    }

    /** [c, neighbours from the closest to the farthest, -1 ...], with NEARBY positions. */
    static int[] codesFor(Keyboard kb, List<Keyboard.Key> keys, char c) {
        int[] codes = new int[NEARBY];
        Arrays.fill(codes, -1);
        codes[0] = c;
        if (kb == null || keys == null) return codes;
        try {
            Keyboard.Key key = keyFor(keys, c);
            if (key == null) return codes;
            int cx = key.x + key.width / 2;
            int cy = key.y + key.height / 2;
            int[] near = kb.getNearestKeys(cx, cy);
            if (near == null) return codes;
            int reach = (int) (1.4f * key.width);
            reach *= reach;
            int[] dist = new int[NEARBY];
            int n = 1;
            char base = MrText.base(c);
            for (int idx : near) {
                if (idx < 0 || idx >= keys.size()) continue;
                Keyboard.Key k = keys.get(idx);
                if (k == key || k.codes == null || k.codes.length == 0) continue;
                int code = k.codes[0];
                if (code <= 32 || MrText.base(code) == base) continue;
                int d = k.squaredDistanceFrom(cx, cy);
                if (d > reach) continue;
                boolean seen = false;
                for (int j = 1; j < n; j++) {
                    if (MrText.base(codes[j]) == MrText.base(code)) { seen = true; break; }
                }
                if (seen) continue;
                int at = n < NEARBY ? n : NEARBY - 1;
                if (n >= NEARBY && dist[at] <= d) continue;
                while (at > 1 && dist[at - 1] > d) {
                    codes[at] = codes[at - 1];
                    dist[at] = dist[at - 1];
                    at--;
                }
                codes[at] = code;
                dist[at] = d;
                if (n < NEARBY) n++;
            }
        } catch (RuntimeException e) {
            // what has already been built stays
        }
        return codes;
    }

    /** The key of letter c (without accent or case) on the keyboard, or null (symbols keyboard, for example). */
    private static Keyboard.Key keyFor(List<Keyboard.Key> keys, char c) {
        char base = MrText.base(c);
        for (int i = 0, n = keys.size(); i < n; i++) {
            Keyboard.Key k = keys.get(i);
            if (k.codes == null || k.codes.length == 0 || k.codes[0] <= 32) continue;
            if (k.codes[0] == c || MrText.base(k.codes[0]) == base) return k;
        }
        return null;
    }
}
