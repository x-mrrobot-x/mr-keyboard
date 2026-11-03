package android.view.inputmethod;

/** Stub de compilação: só o que a camada nova usa. */
public interface InputConnection {
    CharSequence getTextBeforeCursor(int n, int flags);
    CharSequence getSelectedText(int flags);
    boolean commitText(CharSequence text, int newCursorPosition);
    boolean deleteSurroundingText(int beforeLength, int afterLength);
    boolean finishComposingText();
    boolean beginBatchEdit();
    boolean endBatchEdit();

    /** API 31. default: quem já implementa o stub (testes) não precisa mudar. */
    default SurroundingText getSurroundingText(int beforeLength, int afterLength, int flags) { return null; }
}
