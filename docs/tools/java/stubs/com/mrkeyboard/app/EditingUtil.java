package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

/** Compile and PC test stub: the real class is the EditingUtil smali (word under the cursor). */
public final class EditingUtil {
    private EditingUtil() { }

    public static class SelectedWord {
        public CharSequence word;
        public int start;
        public int end;
    }

    /** Tests only: how many times the usual path was used and what it returns. */
    public static int calls;
    public static SelectedWord result;

    public static SelectedWord getWordAtCursorOrSelection(InputConnection ic, int selStart, int selEnd,
            String wordSeparators) {
        calls++;
        return result;
    }
}
