package android.widget;

public class ScrollView extends android.view.ViewGroup {
    private int scrollY;
    /** The descendant that has the focus (the stub has no tree): findFocus() returns it. */
    public android.view.View stubFocused;
    public ScrollView(android.content.Context context) { super(context); }
    public void setFillViewport(boolean fillViewport) { }
    public void scrollTo(int x, int y) { scrollY = y; }
    public int getScrollY() { return scrollY; }
    public int getScrollX() { return 0; }
    /** Real ScrollView: scrolls to show the rectangle of the child. The stub only answers that it did (the tests override it to see the calls). */
    public boolean requestChildRectangleOnScreen(android.view.View child, android.graphics.Rect rectangle, boolean immediate) { return true; }
    public android.view.View findFocus() { return stubFocused; }
    public boolean fullScroll(int direction) { return true; }
}
