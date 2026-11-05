package android.view.inputmethod;

/** Compile stub: only what the new layer uses. */
public interface InputConnection {
    CharSequence getTextBeforeCursor(int n, int flags);
    CharSequence getSelectedText(int flags);
    boolean commitText(CharSequence text, int newCursorPosition);
    boolean deleteSurroundingText(int beforeLength, int afterLength);
    boolean finishComposingText();
    boolean beginBatchEdit();
    boolean endBatchEdit();

    /** API 31. default: whoever already implements the stub (tests) does not need to change. */
    default SurroundingText getSurroundingText(int beforeLength, int afterLength, int flags) { return null; }
}
