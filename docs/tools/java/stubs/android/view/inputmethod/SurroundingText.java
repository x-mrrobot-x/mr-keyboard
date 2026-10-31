package android.view.inputmethod;

/** Stub de compilação e de teste de PC (API 31). */
public final class SurroundingText {
    private final CharSequence mText;
    private final int mStart, mEnd, mOffset;

    public SurroundingText(CharSequence text, int selectionStart, int selectionEnd, int offset) {
        mText = text; mStart = selectionStart; mEnd = selectionEnd; mOffset = offset;
    }

    public CharSequence getText() { return mText; }
    public int getSelectionStart() { return mStart; }
    public int getSelectionEnd() { return mEnd; }
    public int getOffset() { return mOffset; }
}
