package android.widget;

/** Compile and PC test stub: like the real class, getText() returns an Editable (clear() included). */
public class EditText extends TextView {
    private final android.text.Editable stubEditable = new android.text.Editable() {
        public int length() { return stubText == null ? 0 : stubText.length(); }
        public char charAt(int index) { return stubText.charAt(index); }
        public CharSequence subSequence(int start, int end) { return stubText.subSequence(start, end); }
        public void clear() { stubText = ""; }
        public String toString() { return stubText == null ? "" : stubText.toString(); }
    };

    public EditText(android.content.Context context) { super(context); }
    public android.text.Editable getText() { return stubEditable; }
    private final java.util.ArrayList<android.text.TextWatcher> stubWatchers = new java.util.ArrayList<android.text.TextWatcher>();
    public void addTextChangedListener(android.text.TextWatcher watcher) { stubWatchers.add(watcher); }
    /** Like the real one, a new text is told to the watchers (before, on and after); the PC tests use it to type. */
    public void setText(CharSequence text) {
        CharSequence old = stubText == null ? "" : stubText;
        CharSequence now = text == null ? "" : text;
        for (android.text.TextWatcher w : new java.util.ArrayList<android.text.TextWatcher>(stubWatchers)) w.beforeTextChanged(old, 0, old.length(), now.length());
        super.setText(text);
        for (android.text.TextWatcher w : new java.util.ArrayList<android.text.TextWatcher>(stubWatchers)) w.onTextChanged(now, 0, old.length(), now.length());
        for (android.text.TextWatcher w : new java.util.ArrayList<android.text.TextWatcher>(stubWatchers)) w.afterTextChanged(stubEditable);
    }
    public void setSelection(int start, int stop) {
        if (start < 0 || stop < 0 || start > length() || stop > length()) throw new IndexOutOfBoundsException("setSpan");
        stubSelect(start, stop);
    }
    public void setSelection(int index) { setSelection(index, index); }
}
