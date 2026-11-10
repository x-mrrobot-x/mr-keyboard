package android.widget;

/** Compile and PC test stub: like the real class, getText() returns an Editable (clear() included). */
public class EditText extends TextView {
    private final android.text.Editable stubEditable = new android.text.Editable() {
        public int length() { return stubText == null ? 0 : stubText.length(); }
        public char charAt(int index) { return stubText.charAt(index); }
        public CharSequence subSequence(int start, int end) { return stubText.subSequence(start, end); }
        public void clear() { stubText = ""; }
    };

    public EditText(android.content.Context context) { super(context); }
    public android.text.Editable getText() { return stubEditable; }
    public void addTextChangedListener(android.text.TextWatcher watcher) { }
    public void setSelection(int start, int stop) {
        if (start < 0 || stop < 0 || start > length() || stop > length()) throw new IndexOutOfBoundsException("setSpan");
        stubSelect(start, stop);
    }
    public void setSelection(int index) { setSelection(index, index); }
}
