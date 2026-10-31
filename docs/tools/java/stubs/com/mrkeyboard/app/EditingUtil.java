package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

/** Stub de compilação e de teste de PC: a classe de verdade é o smali EditingUtil (palavra sob o cursor). */
public final class EditingUtil {
    private EditingUtil() { }

    public static class SelectedWord {
        public CharSequence word;
        public int start;
        public int end;
    }

    /** Só para os testes: quantas vezes o caminho de sempre foi usado e o que ele devolve. */
    public static int calls;
    public static SelectedWord result;

    public static SelectedWord getWordAtCursorOrSelection(InputConnection ic, int selStart, int selEnd,
            String wordSeparators) {
        calls++;
        return result;
    }
}
