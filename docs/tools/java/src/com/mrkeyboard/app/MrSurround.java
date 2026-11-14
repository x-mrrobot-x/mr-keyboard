package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

/**
 * One question to the app instead of two after the echo of a separator the keyboard typed itself (docs/plan-performance.md, stage 6).
 *
 * After that echo LatinIME asks the app for the character after the cursor (is the cursor touching a word?) and, a moment later in the
 * same reaction, MrPredict.list asks for the 96 characters before the cursor (next-word prediction). From Android 12
 * {@code InputConnection.getSurroundingText} gives both in one question: {@link #echo} asks it, answers with the character after
 * the cursor, and keeps the text before the cursor for {@link #takeBefore}, which MrPredict.list uses instead of asking.
 *
 * When the keyboard is certain (anything else is asked as before, so the answers never change, only the number of questions):
 *  - only on Android 12 or later, and only if the app answers with a text (an app that does not implement it answers null: it is
 *    not asked again in that field, see {@link #fieldChanged});
 *  - only if no text is selected in the answer; with a selection the usual two questions run;
 *  - the text kept lives inside the reaction to that one report of the selection: LatinIME clears it when the next report comes,
 *    when a key is typed and when the reaction ends, so it is never used for another cursor.
 */
public final class MrSurround {
    private MrSurround() { }

    /** Answer of {@link #echo}: nothing after the cursor. */
    public static final int END = -1;
    /** Answer of {@link #echo}: the question could not be answered this way; ask as before. */
    public static final int NONE = -2;

    private static CharSequence sBefore;
    private static boolean sUnsupported;

    /**
     * The character after the cursor (END if there is none), asking the app once; or NONE to ask as before. On an answer the text
     * before the cursor is kept for {@link #takeBefore}.
     */
    public static int echo(InputConnection ic) {
        sBefore = null;
        if (ic == null || sUnsupported || Build.VERSION.SDK_INT < 31) return NONE;
        return Api31.echo(ic);
    }

    /** Separate so that Android 8 to 11 never load SurroundingText (API 31). */
    static final class Api31 {
        private Api31() { }

        static int echo(InputConnection ic) {
            SurroundingText st;
            MrPerf.echoOneBegin();
            MrPerf.appBegin();   // the question waits for the app: the performance meter counts it
            try {
                st = ic.getSurroundingText(MrPredict.LOOKBACK, 1, 0);
            } catch (RuntimeException e) {
                return NONE;
            } finally {
                MrPerf.appEnd();
            }
            if (st == null) {
                sUnsupported = true;   // this app does not answer it: do not pay for the question again in this field
                return NONE;
            }
            CharSequence text = st.getText();
            int s = st.getSelectionStart();
            int e = st.getSelectionEnd();
            if (text == null || s != e || s < 0 || s > text.length()) return NONE;
            MrPerf.echoOneEnd();   // counted only when the one question answered
            sBefore = text.subSequence(0, s);
            return s < text.length() ? text.charAt(s) : END;
        }
    }

    /** The text before the cursor read by {@link #echo}, once; null if there is none (the caller asks as before). */
    public static CharSequence takeBefore() {
        CharSequence b = sBefore;
        sBefore = null;
        return b;
    }

    /** Forgets the text kept. */
    public static void clear() {
        sBefore = null;
    }

    /** A new field: forgets the text kept and the note that the app does not answer. */
    public static void fieldChanged() {
        sBefore = null;
        sUnsupported = false;
    }
}
