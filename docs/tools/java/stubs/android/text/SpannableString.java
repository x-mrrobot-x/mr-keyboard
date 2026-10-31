package android.text;

public class SpannableString implements Spanned {
    private final String s;
    public SpannableString(CharSequence source) { s = String.valueOf(source); }
    public void setSpan(Object what, int start, int end, int flags) { }
    public int length() { return s.length(); }
    public char charAt(int i) { return s.charAt(i); }
    public CharSequence subSequence(int a, int b) { return s.subSequence(a, b); }
    public String toString() { return s; }
}
