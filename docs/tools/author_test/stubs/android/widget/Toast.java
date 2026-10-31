package android.widget;
public class Toast {
    public static final int LENGTH_SHORT = 0;
    public static final int LENGTH_LONG = 1;
    public static String last; public static int shown;
    private final String t;
    private Toast(String t) { this.t = t; }
    public static Toast makeText(android.content.Context c, CharSequence text, int d) { return new Toast(String.valueOf(text)); }
    public void show() { last = t; shown++; }
}
