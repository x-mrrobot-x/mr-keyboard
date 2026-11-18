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
    /** Real ScrollView: the distance to scroll to show the rectangle (0 = nothing). Tests count the calls. */
    public int stubDeltaCalls;
    protected int computeScrollDeltaToGetChildRectOnScreen(android.graphics.Rect rect) { stubDeltaCalls++; return 7; }
    /** Real ScrollView: starts a fling at the speed given (px/s). The stub records it. */
    public int stubFlings, stubFlingSpeed;
    public void fling(int velocityY) { stubFlings++; stubFlingSpeed = velocityY; }
    /** Real ScrollView: sets the place while a fling runs. The stub moves like scrollTo. */
    protected void onOverScrolled(int scrollX, int scrollY, boolean clampedX, boolean clampedY) { this.scrollY = scrollY; }
    /** Real View: the scroll moved. Tests call it to simulate the steps of a fling. */
    protected void onScrollChanged(int l, int t, int oldl, int oldt) { }
    public boolean dispatchTouchEvent(android.view.MotionEvent event) { return true; }
    /** Tests only: moves like a fling step (the real ScrollView sets the place and calls onScrollChanged). */
    public void stubStep(int y) { int old = scrollY; onOverScrolled(0, y, false, false); onScrollChanged(0, scrollY, 0, old); }
    /** Tests only: the real onLayout asks for the delta of the child in focus. */
    public int stubShowFocused() { return computeScrollDeltaToGetChildRectOnScreen(new android.graphics.Rect()); }
}
