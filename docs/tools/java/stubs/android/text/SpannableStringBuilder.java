package android.text;

public class SpannableStringBuilder implements Spanned {
    private final StringBuilder sb = new StringBuilder();
    /** The spans set, in order, as {what, start, end, flags}: read by the PC tests. */
    public final java.util.ArrayList<Object[]> stubSpans = new java.util.ArrayList<Object[]>();
    public SpannableStringBuilder(CharSequence text) { sb.append(text); }
    public SpannableStringBuilder append(CharSequence text) { sb.append(text); return this; }
    public void setSpan(Object what, int start, int end, int flags) { stubSpans.add(new Object[] { what, start, end, flags }); }
    public int length() { return sb.length(); }
    public char charAt(int i) { return sb.charAt(i); }
    public CharSequence subSequence(int a, int b) { return sb.subSequence(a, b); }
    public String toString() { return sb.toString(); }
}
