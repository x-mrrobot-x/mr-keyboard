package android.widget;

public class ScrollView extends android.view.ViewGroup {
    private int scrollY;
    /** The descendant that has the focus (the stub has no tree): findFocus() returns it. */
    public android.view.View stubFocused;
    public ScrollView(android.content.Context context) { super(context); }
    public void scrollTo(int x, int y) { scrollY = y; }
    public int getScrollY() { return scrollY; }
    public android.view.View findFocus() { return stubFocused; }
    public boolean fullScroll(int direction) { return true; }
}
