package android.widget;

public class TextView extends android.view.View {
    protected CharSequence stubText;
    private int selStart, selEnd;
    public TextView(android.content.Context context) { super(context); }
    public void setText(CharSequence text) { stubText = text; }
    public CharSequence getText() { return stubText; }
    public int length() { return stubText == null ? 0 : stubText.length(); }
    public int getSelectionStart() { return selStart; }
    public int getSelectionEnd() { return selEnd; }
    protected void stubSelect(int start, int end) { selStart = start; selEnd = end; }
    public int stubTextColor;
    public void setTextColor(int color) { stubTextColor = color; }
    private final android.text.TextPaint stubPaint = new android.text.TextPaint();
    public android.text.TextPaint getPaint() { return stubPaint; }
    public android.view.inputmethod.InputConnection onCreateInputConnection(android.view.inputmethod.EditorInfo outAttrs) { return null; }
    public int getCurrentTextColor() { return 0; }
    public float stubTextSize;
    public void setTextSize(float size) { stubTextSize = size; }
    public void setTypeface(android.graphics.Typeface tf, int style) { }
    public void setGravity(int gravity) { }
    public void setMinWidth(int minPixels) { }

    private android.graphics.drawable.Drawable[] stubCompound = new android.graphics.drawable.Drawable[4];
    public android.graphics.drawable.Drawable[] getCompoundDrawables() { return stubCompound.clone(); }
    public void setCompoundDrawables(android.graphics.drawable.Drawable left, android.graphics.drawable.Drawable top, android.graphics.drawable.Drawable right, android.graphics.drawable.Drawable bottom) {
        stubCompound = new android.graphics.drawable.Drawable[] {left, top, right, bottom};
    }
    private CharSequence stubHint;
    public void setHint(CharSequence hint) { stubHint = hint; }
    public CharSequence getHint() { return stubHint; }
    public void setHintTextColor(int color) { }
    private int stubInputType;
    public void setInputType(int type) { stubInputType = type; }
    public int getInputType() { return stubInputType; }
    public void setSingleLine(boolean singleLine) { }
    public void setFilters(android.text.InputFilter[] filters) { }
    /** Not in Android: what the field tells the keyboard (setPrivateImeOptions). */
    public String stubPrivateImeOptions;
    public void setPrivateImeOptions(String type) { stubPrivateImeOptions = type; }
    public String getPrivateImeOptions() { return stubPrivateImeOptions; }
    /** Not in Android: the lines as last set (a test reads them). */
    public int stubMinLines, stubMaxLines;
    public void setMinLines(int minLines) { stubMinLines = minLines; }
    public void setMaxLines(int maxLines) { stubMaxLines = maxLines; }
    public float stubLineAdd, stubLineMult;
    public void setLineSpacing(float add, float mult) { stubLineAdd = add; stubLineMult = mult; }
    /** Shadow as last set (radius 0 = none): read by the PC tests. */
    public float stubShadowRadius;
    public int stubShadowColor;
    public void setShadowLayer(float radius, float dx, float dy, int color) {
        stubShadowRadius = radius;
        stubShadowColor = color;
    }
}
