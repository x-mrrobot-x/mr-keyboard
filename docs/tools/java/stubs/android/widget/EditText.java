package android.widget;

public class EditText extends TextView {
    public EditText(android.content.Context context) { super(context); }
    public void addTextChangedListener(android.text.TextWatcher watcher) { }
    public void setSelection(int start, int stop) {
        if (start < 0 || stop < 0 || start > length() || stop > length()) throw new IndexOutOfBoundsException("setSpan");
        stubSelect(start, stop);
    }
    public void setSelection(int index) { setSelection(index, index); }
}
