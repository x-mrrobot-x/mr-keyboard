package android.text;

public class SpannableStringBuilder implements Spanned {
    private final StringBuilder sb = new StringBuilder();
    public SpannableStringBuilder(CharSequence text) { sb.append(text); }
    public SpannableStringBuilder append(CharSequence text) { sb.append(text); return this; }
    public void setSpan(Object what, int start, int end, int flags) { }
    public int length() { return sb.length(); }
    public char charAt(int i) { return sb.charAt(i); }
    public CharSequence subSequence(int a, int b) { return sb.subSequence(a, b); }
    public String toString() { return sb.toString(); }
}
