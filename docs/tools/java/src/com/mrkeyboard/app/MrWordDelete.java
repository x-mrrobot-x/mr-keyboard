package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.SystemClock;
import android.preference.PreferenceManager;
import android.view.inputmethod.InputConnection;

/**
 * Delete by words while the delete key is held (2.0.0, setting "pref_word_delete", off unless the person turns it on).
 *
 * <p>The delete key repeats: once on the touch, then after 300 ms, then every 50 ms. With this setting on, once the key has been
 * held for the time set ("pref_word_delete_after", 1 s by default, between 0.5 s and 3 s) every repeat removes a whole word
 * instead of a letter, and the repeats come {@link #STEP_FACTOR} times slower, so that the person can let go at the word they want.
 * A tap, or a hold shorter than the time set, works exactly as before; with the setting off every method here returns on its
 * first line.
 *
 * <p>What is "a word": the spaces before the cursor, then the letters and digits right before them (an apostrophe or a hyphen
 * between two letters belongs to the word: don't, state-of-the-art), or, when what is there is not a letter, the run of signs
 * (punctuation, symbols, emojis: a joined family is one). Accents written as separate marks stay with their letter. A line break
 * is a step of its own: the spaces before a line break are removed without crossing it, and a line break right before the cursor
 * goes alone. See {@link #wordLength}.
 *
 * <p>Left to the usual delete, whatever the time held: text selected (the delete removes it), a word still being typed with the
 * suggestions on (it is composed text that the keyboard keeps in step with the strip; it goes letter by letter and the words
 * start with the next repeat), the text before the cursor not readable, and the start of the field.
 *
 * <p>All on the main thread. The calls from the smali, each of them catching what is thrown here (a fault never stops typing):
 * <pre>
 *   PointerTracker.onDownEvent               {@link #down}: the key that starts to repeat, before its first repeat
 *   LatinKeyboardBaseView$UIHandler
 *       .cancelKeyRepeatTimer                {@link #up}: the key was let go, or the repeat was cancelled
 *       .handleMessage (repeat)              {@link #interval}: the time to the next repeat
 *   LatinIME.handleBackspace                 {@link #onBackspace}: true = the delete was done here
 * </pre>
 * and LatinIME.mrComposingLength(), a small method added to the class for it.
 */
public final class MrWordDelete {
    static final String PREF_ON = "pref_word_delete";
    static final String PREF_AFTER = "pref_word_delete_after";

    /** The time held, in ms, that starts the words: default and limits of the setting. */
    static final int AFTER_DEFAULT = 1000;
    static final int AFTER_MIN = 500;
    static final int AFTER_MAX = 3000;

    /** The delay between two repeats is this many times the usual one while words are being deleted. */
    static final int STEP_FACTOR = 4;

    /** How many characters before the cursor are read to find the word. A longer word goes in more than one step. */
    static final int LOOKBACK = 64;

    /** Keyboard.KEYCODE_DELETE. */
    static final int KEYCODE_DELETE = -5;

    /** Tests: the clock (uptime, ms); -1 = SystemClock.uptimeMillis. */
    static long sFakeNow = -1;

    /** The setting is on. Read on every key that repeats. */
    static volatile boolean sOn;
    /** The time held that starts the words, ms. */
    static volatile int sAfter = AFTER_DEFAULT;

    /** When the delete key under the finger went down (uptime, ms); 0 = it is not held, or the setting is off. */
    private static long sDownAt;
    /** The last repeat deleted a word: the next one is due later. */
    private static boolean sStep;

    private static Context sApp;
    private static SharedPreferences.OnSharedPreferenceChangeListener sListener;   // kept here: the preferences only hold it weakly

    private MrWordDelete() { }

    static long now() {
        return sFakeNow >= 0 ? sFakeNow : SystemClock.uptimeMillis();
    }

    // ------------------------------------------------------------------ the setting

    /** Tests: back to the state of a process that has not read anything yet. */
    static synchronized void resetForTest() {
        try {
            final SharedPreferences sp = sApp == null ? null : PreferenceManager.getDefaultSharedPreferences(sApp);
            if (sp != null && sListener != null) sp.unregisterOnSharedPreferenceChangeListener(sListener);
        } catch (Throwable t) {
            // nothing: a test helper
        }
        sApp = null;
        sListener = null;
        sOn = false;
        sAfter = AFTER_DEFAULT;
        sDownAt = 0;
        sStep = false;
        sFakeNow = -1;
    }

    /** Reads the setting from the preferences of the keyboard; the first call also starts following them. c: any context. */
    static synchronized void init(Context c) {
        try {
            if (c == null) return;
            if (sApp == null) {
                final Context app = c.getApplicationContext();
                sApp = app != null ? app : c;
                final SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(sApp);
                if (sp != null) {
                    sListener = new SharedPreferences.OnSharedPreferenceChangeListener() {
                        public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
                            if (key == null || PREF_ON.equals(key) || PREF_AFTER.equals(key)) reload();
                        }
                    };
                    sp.registerOnSharedPreferenceChangeListener(sListener);
                }
            }
            reload();
        } catch (Throwable t) {
            sOn = false;
        }
    }

    static synchronized void reload() {
        try {
            if (sApp == null) return;
            final SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(sApp);
            sOn = sp != null && sp.getBoolean(PREF_ON, false);
            sAfter = sp == null ? AFTER_DEFAULT : after(sp.getString(PREF_AFTER, null));
            if (!sOn) {
                sDownAt = 0;
                sStep = false;
            }
        } catch (Throwable t) {
            sOn = false;
        }
    }

    /**
     * The time held, in ms, from what the setting stored (the seek bar keeps a decimal number as text: "1000.0"). A value that
     * is missing, is not a number or is outside the limits gives the default or the nearest limit.
     */
    static int after(String stored) {
        if (stored == null) return AFTER_DEFAULT;
        try {
            final float v = Float.parseFloat(stored.trim());
            if (v != v) return AFTER_DEFAULT;                     // NaN
            if (v < AFTER_MIN) return AFTER_MIN;
            if (v > AFTER_MAX) return AFTER_MAX;
            return Math.round(v);
        } catch (Throwable t) {
            return AFTER_DEFAULT;
        }
    }

    // ------------------------------------------------------------------ the hold

    /**
     * PointerTracker.onDownEvent, for a key that repeats, before its first repeat. Only the delete key starts a hold; any other key
     * (the arrows repeat too) leaves the state as it is.
     */
    public static void down(Keyboard.Key key) {
        try {
            if (key == null || key.codes == null || key.codes.length == 0 || key.codes[0] != KEYCODE_DELETE) return;
            sStep = false;
            sDownAt = 0;
            if (sApp == null) init(LatinIME.sInstance);        // before the first hold of the process
            if (sOn) sDownAt = now();
        } catch (Throwable t) {
            sDownAt = 0;
            sStep = false;
        }
    }

    /** UIHandler.cancelKeyRepeatTimer: the key was let go (or the repeat stopped for another reason). */
    public static void up() {
        sDownAt = 0;
        sStep = false;
    }

    /** UIHandler, when it sets the time to the next repeat: <code>normal</code> ms, or longer after a word was deleted. */
    public static int interval(int normal) {
        return sStep ? normal * STEP_FACTOR : normal;
    }

    /**
     * LatinIME.handleBackspace, after its housekeeping and before it reads the text. true = the word before the cursor was
     * deleted here and the usual delete must not run; false = it is not for this class (the usual delete goes on).
     */
    public static boolean onBackspace(LatinIME ime) {
        if (sDownAt == 0) return false;                           // not held, or the setting is off: the common case
        try {
            if (now() - sDownAt < sAfter) return false;
            if (ime.mrComposingLength() > 0) return false;        // the word being typed goes letter by letter first
            final InputConnection ic = ime.getCurrentInputConnection();
            if (ic == null) return false;
            final int n;
            MrPerf.appBegin();
            try {
                final CharSequence selected = ic.getSelectedText(0);
                if (selected != null && selected.length() > 0) return false;      // the usual delete removes the selection
                n = wordLength(ic.getTextBeforeCursor(LOOKBACK, 0));
                if (n > 0) ic.deleteSurroundingText(n, 0);
            } finally {
                MrPerf.appEnd();
            }
            if (n <= 0) return false;
            sStep = true;
            return true;
        } catch (Throwable t) {
            sDownAt = 0;
            sStep = false;
            return false;
        }
    }

    // ------------------------------------------------------------------ what a word is

    private static boolean isMark(int cp) {
        final int t = Character.getType(cp);
        return t == Character.NON_SPACING_MARK || t == Character.COMBINING_SPACING_MARK || t == Character.ENCLOSING_MARK
                || cp == 0x200D;       // the joiner of a family or a flag: it stays with what it joins
    }

    private static boolean isBreak(int cp) {
        return cp == '\n' || cp == '\r' || cp == 0x2028 || cp == 0x2029;
    }

    /** Spaces, tabs and the other blanks (the no-break ones too), not the line breaks. */
    private static boolean isBlank(int cp) {
        return !isBreak(cp) && (Character.isWhitespace(cp) || Character.isSpaceChar(cp));
    }

    private static boolean isWord(int cp) {
        return Character.isLetterOrDigit(cp) || cp == '_';
    }

    private static boolean isJoiner(int cp) {
        return cp == '\'' || cp == 0x2019 || cp == '-' || cp == 0x2010;
    }

    /**
     * How many characters (UTF-16 units) to delete from the end of <code>before</code> (the text before the cursor, at most
     * LOOKBACK of it) to remove one word: 0 when there is nothing to remove or the text is not known.
     */
    static int wordLength(CharSequence before) {
        if (before == null) return 0;
        final int n = before.length();
        if (n == 0) return 0;
        int i = n;
        int cp = Character.codePointBefore(before, i);
        if (isBreak(cp)) {                                        // a line break is a step of its own ("\r\n" is one)
            if (cp == '\n' && i >= 2 && before.charAt(i - 2) == '\r') return 2;
            return Character.charCount(cp);
        }
        while (i > 0) {                                           // the blanks before the cursor
            cp = Character.codePointBefore(before, i);
            if (!isBlank(cp)) break;
            i -= Character.charCount(cp);
        }
        if (i == 0) return n;                                     // only blanks
        if (isBreak(Character.codePointBefore(before, i))) return n - i;     // up to the start of the line, not further
        int j = i;
        int word = -1;                                            // -1 not known yet, 1 a word, 0 a run of signs
        while (j > 0) {
            cp = Character.codePointBefore(before, j);
            final int w = Character.charCount(cp);
            if (isMark(cp)) {                                     // stays with the character it follows
                j -= w;
                continue;
            }
            if (isBlank(cp) || isBreak(cp)) break;
            final boolean letter = isWord(cp);
            if (word < 0) {
                word = letter ? 1 : 0;
            } else if (word == 1 && !letter) {
                // an apostrophe or hyphen between two letters belongs to the word (j < i: there is a letter after it)
                if (j < i && isJoiner(cp) && j - w > 0 && isWord(Character.codePointBefore(before, j - w))) {
                    j -= w;
                    continue;
                }
                break;
            } else if (word == 0 && letter) {
                break;
            }
            j -= w;
        }
        return n - j;
    }
}
