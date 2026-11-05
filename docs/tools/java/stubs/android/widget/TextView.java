package android.widget;

public class TextView extends android.view.View {
    private CharSequence stubText;
    private int selStart, selEnd;
    public TextView(android.content.Context context) { super(context); }
    public void setText(CharSequence text) { stubText = text; }
    public CharSequence getText() { return stubText; }
    public int length() { return stubText == null ? 0 : stubText.length(); }
    public int getSelectionStart() { return selStart; }
    public int getSelectionEnd() { return selEnd; }
    protected void stubSelect(int start, int end) { selStart = start; selEnd = end; }
    public void setTextColor(int color) { }
    public void setTextSize(float size) { }
    public void setTypeface(android.graphics.Typeface tf, int style) { }
    public void setGravity(int gravity) { }
    public void setHint(CharSequence hint) { }
    public void setHintTextColor(int color) { }
    public void setInputType(int type) { }
    public void setSingleLine(boolean singleLine) { }
    public void setMinLines(int minLines) { }
    public void setMaxLines(int maxLines) { }
    public void setLineSpacing(float add, float mult) { }
}
