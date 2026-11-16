package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.view.inputmethod.InputConnection;

/**
 * Ctrl + delete deletes by words (2.0.0, setting "pref_word_delete", off unless the person turns it on).
 *
 * <p>With the setting on and Ctrl on when the delete key is touched, the key removes a word instead of a letter: one word on the
 * touch, and while the finger stays down one more word on every repeat. The repeats of the delete key come after 300 ms and then
 * every 50 ms; with words they come every "pref_word_delete_interval" ms instead (200 by default, between 100 and 600), so that
 * the person can let go at the word they want. Ctrl is read at the touch and kept for the whole hold: the keyboard puts a one-shot
 * Ctrl off after the first key, and the repeats must not lose it. Without Ctrl, or with the setting off, the delete key works
 * exactly as before; with the setting off every method here returns on its first line.
 *
 * <p>What is "a word": the spaces before the cursor, then the letters and digits right before them (an apostrophe or a hyphen
 * between two letters belongs to the word: don't, state-of-the-art), or, when what is there is not a letter, the run of signs
 * (punctuation, symbols, emojis: a joined family is one). Accents written as separate marks stay with their letter. A line break
 * is a step of its own: the spaces before a line break are removed without crossing it, and a line break right before the cursor
 * goes alone. See {@link #wordLength}.
 *
 * <p>The composing text. A word still being typed, or reopened by the correction under the cursor (the underlined word: the app
 * marks it as composing text, the keyboard shows its suggestions and holds nothing in mComposing), is composing text in the app.
 * The delete of the app (BaseInputConnection.deleteSurroundingText) counts that text as part of the selection and deletes before
 * ITS start: with the word at the end of the field, a word is taken from before it every time and the underlined one is left,
 * stuck to the cursor, with the pieces of the others glued to it. So before each delete the keyboard lets go of the word it
 * holds ({@link LatinIME#mrDropComposing}, nothing is committed, so it is not learned) and the app is always told to finish its
 * composing text, whether the keyboard knows of any or not. Then the word goes from the text like any other, all in one batch of
 * edits. The class only reads the text and deletes by position; it never writes composing text. Left to the usual delete: text
 * selected (the delete removes it), the text before the cursor not readable, and the start of the field.
 *
 * <p>Ctrl + Z, word by word. The app puts deletes that follow each other in a single step of its undo ("Multiple deletes are
 * consolidated into a single operation"), so two words taken with Ctrl + delete came back together, in one Ctrl + Z, and the
 * keyboard cannot cut that step in two. So the keyboard keeps what it takes: each word, with the text around the cursor as it
 * was left ({@link Cut}). Ctrl + Z (Ctrl alone, no Shift, Alt or Meta) with the text still exactly as the last word left it
 * writes that word back at the cursor, the last one first, and the key is not sent to the app. With any other text, a
 * selection, or nothing kept, the key goes to the app as always. One word alone is left to the undo of the app (it gives the
 * same, and keeps its own history in step). The words kept do not pile up: each one expires after {@link #UNDO_LIFETIME_MS}, at
 * most {@link #UNDO_MAX} are kept (the oldest goes first), turning the setting off clears them, and the first text that is not
 * the one kept clears them all. The expired ones are let go with the next key typed or deleted, and nothing runs while the keyboard
 * is idle. The words written back are typing for the app: after the last one, a further Ctrl + Z of the app first takes them out
 * again.
 *
 * <p>All on the main thread. The calls from the smali, each of them catching what is thrown here (a fault never stops typing):
 * <pre>
 *   PointerTracker.onDownEvent               {@link #down}: the key that starts to repeat, before its first repeat
 *   LatinKeyboardBaseView$UIHandler
 *       .cancelKeyRepeatTimer                {@link #up}: the key was let go, or the repeat was cancelled
 *       .handleMessage (repeat)              {@link #interval}: the time to the next repeat
 *   LatinIME.handleBackspace                 {@link #onBackspace}: true = the delete was done here
 *   LatinIME.sendModifiableKeyChar           {@link #onUndo}: true = the Ctrl + Z was done here
 * </pre>
 * and LatinIME.mrCtrlOn(), mrCtrlOnly(), mrHoldsWord() and mrDropComposing(), small methods added to the class for it.
 */
public final class MrWordDelete {
    static final String PREF_ON = "pref_word_delete";
    static final String PREF_INTERVAL = "pref_word_delete_interval";

    /** The time between two words while the key is held, in ms: default and limits of the setting. */
    static final int INTERVAL_DEFAULT = 200;
    static final int INTERVAL_MIN = 100;
    static final int INTERVAL_MAX = 600;

    /** How many characters before the cursor are read to find the word. A longer word goes in more than one step. */
    static final int LOOKBACK = 64;

    /** Keyboard.KEYCODE_DELETE. */
    static final int KEYCODE_DELETE = -5;

    /** Ctrl + Z: how many words are kept at most (the oldest goes first) and for how long each one is kept. */
    static final int UNDO_MAX = 32;
    static final long UNDO_LIFETIME_MS = 120000L;

    /** The setting is on. Read on every delete key that goes down. */
    static volatile boolean sOn;
    /** The time between two words while the key is held, ms. */
    static volatile int sInterval = INTERVAL_DEFAULT;

    /** The delete key under the finger went down with Ctrl on (and the setting on): it deletes by words until it is let go. */
    private static boolean sHold;

    /** A word taken by Ctrl + delete and the text around the cursor as it was left: what Ctrl + Z needs to give it back. */
    private static final class Cut {
        final String text;      // the characters taken from before the cursor (the blanks before the word too)
        final String before;    // the text before the cursor (at most LOOKBACK) after the delete
        final String after;     // the text after the cursor (at most LOOKBACK), the same before and after the delete
        final long at;          // when it was taken, ms

        Cut(String text, String before, String after, long at) {
            this.text = text;
            this.before = before;
            this.after = after;
            this.at = at;
        }

        boolean matches(CharSequence b, CharSequence a) {
            return b != null && a != null && before.contentEquals(b) && after.contentEquals(a);
        }
    }

    /** The words taken and not yet given back, the newest last. */
    private static final java.util.ArrayList<Cut> sCuts = new java.util.ArrayList<Cut>();
    /** The words kept are all the words in the last step of the undo of the app (nothing was written back, nothing was let go). */
    private static boolean sPure;
    /** Tests: the clock, ms; negative = the real one. */
    static long sClock = -1;

    private static Context sApp;
    private static SharedPreferences.OnSharedPreferenceChangeListener sListener;   // kept here: the preferences only hold it weakly

    private MrWordDelete() { }

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
        sInterval = INTERVAL_DEFAULT;
        sHold = false;
        sCuts.clear();
        sPure = false;
        sClock = -1;
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
                            if (key == null || PREF_ON.equals(key) || PREF_INTERVAL.equals(key)) reload();
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
            sInterval = sp == null ? INTERVAL_DEFAULT : interval(sp.getString(PREF_INTERVAL, null), INTERVAL_DEFAULT);
            if (!sOn) {
                sHold = false;
                sCuts.clear();
            }
        } catch (Throwable t) {
            sOn = false;
        }
    }

    /**
     * The time between two words, in ms, from what the setting stored (the seek bar keeps a decimal number as text: "200.0").
     * A value that is missing or is not a number gives <code>fallback</code>; one outside the limits gives the nearest limit.
     */
    static int interval(String stored, int fallback) {
        if (stored == null) return fallback;
        try {
            final float v = Float.parseFloat(stored.trim());
            if (v != v) return fallback;                          // NaN
            if (v < INTERVAL_MIN) return INTERVAL_MIN;
            if (v > INTERVAL_MAX) return INTERVAL_MAX;
            return Math.round(v);
        } catch (Throwable t) {
            return fallback;
        }
    }

    // ------------------------------------------------------------------ the hold

    /**
     * PointerTracker.onDownEvent, for a key that repeats, before its first repeat. Only the delete key starts a hold; any other key
     * (the arrows repeat too) leaves the state as it is. Ctrl is asked here, once: the keyboard puts a one-shot Ctrl off after
     * the first key, and the repeats of this hold go on by words.
     */
    public static void down(Keyboard.Key key) {
        try {
            if (key == null || key.codes == null || key.codes.length == 0 || key.codes[0] != KEYCODE_DELETE) return;
            sHold = false;
            if (sApp == null) init(LatinIME.sInstance);        // before the first hold of the process
            if (!sOn) return;
            final LatinIME ime = LatinIME.sInstance;
            sHold = ime != null && ime.mrCtrlOn();
        } catch (Throwable t) {
            sHold = false;
        }
    }

    /** UIHandler.cancelKeyRepeatTimer: the key was let go (or the repeat stopped for another reason). */
    public static void up() {
        sHold = false;
    }

    /** UIHandler, when it sets the time to the next repeat: <code>normal</code> ms, or the time set while words are deleted. */
    public static int interval(int normal) {
        return sHold ? Math.max(normal, sInterval) : normal;
    }

    /**
     * LatinIME.handleBackspace, after its housekeeping and before it reads the text. true = the delete was done here (the word
     * before the cursor, or the word being typed) and the usual delete must not run; false = it is not for this class (the usual
     * delete goes on).
     */
    public static boolean onBackspace(LatinIME ime) {
        if (!sHold) return false;                                 // not a hold with Ctrl, or the setting is off: the common case
        try {
            final InputConnection ic = ime.getCurrentInputConnection();
            if (ic == null) return false;
            final int n;
            MrPerf.appBegin();
            try {
                final CharSequence selected = ic.getSelectedText(0);
                if (selected != null && selected.length() > 0) return false;      // the usual delete removes the selection
                final CharSequence before = ic.getTextBeforeCursor(LOOKBACK, 0);
                n = wordLength(before);
                if (n > 0) {
                    final String taken = before.subSequence(before.length() - n, before.length()).toString();
                    final String text = before.toString();
                    purge();
                    final CharSequence after = readAfter(ic);
                    ic.beginBatchEdit();
                    try {
                        if (ime.mrHoldsWord()) ime.mrDropComposing();     // the keyboard's side: a word being typed or reopened
                        ic.finishComposingText();                         // the app's side, always: its delete counts composing text as selected
                        ic.deleteSurroundingText(n, 0);
                    } finally {
                        ic.endBatchEdit();
                    }
                    keep(ic, taken, text, after);                         // never throws: the delete is done
                }
            } finally {
                MrPerf.appEnd();
            }
            return n > 0;
        } catch (Throwable t) {
            sHold = false;
            return false;
        }
    }

    // ------------------------------------------------------------------ Ctrl + Z, word by word

    private static long now() {
        return sClock >= 0 ? sClock : System.nanoTime() / 1000000L;
    }

    /** The ones that expired are let go (the oldest are the first). Whatever goes, the words left are no longer all of the last step of the app. */
    private static void purge() {
        final long t = now();
        int n = 0;
        while (n < sCuts.size() && t - sCuts.get(n).at >= UNDO_LIFETIME_MS) n++;
        if (n > 0) {
            sCuts.subList(0, n).clear();
            sPure = false;
        }
    }

    /** The text after the cursor, null when it cannot be read (then nothing is kept). */
    private static CharSequence readAfter(InputConnection ic) {
        try {
            return ic.getTextAfterCursor(LOOKBACK, 0);
        } catch (Throwable t) {
            return null;
        }
    }

    /**
     * A word was taken: keeps it. <code>before</code>: the text before the cursor as it was before the delete (what was read to
     * find the word), <code>after</code>: the text after the cursor (the delete does not change it), <code>taken</code>: what the
     * delete removed. What was kept before is kept only if the text was as it left it; otherwise it is let go first.
     */
    private static void keep(InputConnection ic, String taken, String before, CharSequence after) {
        try {
            if (after == null) { sCuts.clear(); return; }
            if (!sCuts.isEmpty() && !sCuts.get(sCuts.size() - 1).matches(before, after)) sCuts.clear();
            final CharSequence left = ic.getTextBeforeCursor(LOOKBACK, 0);
            if (left == null) { sCuts.clear(); return; }
            if (sCuts.isEmpty()) sPure = true;
            if (sCuts.size() >= UNDO_MAX) {
                sCuts.remove(0);
                sPure = false;
            }
            sCuts.add(new Cut(taken, left.toString(), after.toString(), now()));
        } catch (Throwable t) {
            sCuts.clear();
        }
    }

    /**
     * LatinIME.sendModifiableKeyChar, first thing, for every character the keyboard sends: true = it was a Ctrl + Z and the last
     * word taken by Ctrl + delete was written back (the key must not go to the app); false = not for this class.
     * With nothing kept it returns on its first line.
     */
    public static boolean onUndo(LatinIME ime, char key) {
        if (sCuts.isEmpty()) return false;                        // the common case: nothing taken
        try {
            purge();
            if (sCuts.isEmpty()) return false;
            if (!sOn) {
                sCuts.clear();
                return false;
            }
            if ((key != 'z' && key != 'Z') || !ime.mrCtrlOnly()) return false;
            final int last = sCuts.size() - 1;
            if (last == 0 && sPure) {                             // one word alone: the undo of the app gives it back, in step with its history
                sCuts.clear();
                return false;
            }
            final InputConnection ic = ime.getCurrentInputConnection();
            if (ic == null) return false;
            final CharSequence selected = ic.getSelectedText(0);
            if (selected != null && selected.length() > 0) {
                sCuts.clear();
                return false;
            }
            final Cut cut = sCuts.get(last);
            if (!cut.matches(ic.getTextBeforeCursor(LOOKBACK, 0), ic.getTextAfterCursor(LOOKBACK, 0))) {
                sCuts.clear();                                    // the text is not the one left: nothing kept belongs to it
                return false;
            }
            ic.beginBatchEdit();
            try {
                if (ime.mrHoldsWord()) ime.mrDropComposing();
                ic.finishComposingText();                         // commitText replaces composing text: nothing may be left
                ic.commitText(cut.text, 1);
            } finally {
                ic.endBatchEdit();
            }
            sCuts.remove(last);
            sPure = false;
            return true;
        } catch (Throwable t) {
            sCuts.clear();
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
