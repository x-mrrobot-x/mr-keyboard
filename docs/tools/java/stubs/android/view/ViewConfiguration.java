package android.view;

/** Compile stub (Android signature): touch slop and long-press timeout of the key grid. */
public class ViewConfiguration {
    public static ViewConfiguration get(android.content.Context context) { return new ViewConfiguration(); }

    public int getScaledTouchSlop() { return 8; }

    public static int getLongPressTimeout() { return 400; }
}
