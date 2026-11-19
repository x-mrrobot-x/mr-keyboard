package android.widget;

public class HorizontalScrollView extends android.view.ViewGroup {
    /** Tests only: where the last smoothScrollTo went. */
    public int stubSmoothX = -1;
    public HorizontalScrollView(android.content.Context context) { super(context); }
    public final void smoothScrollTo(int x, int y) { stubSmoothX = x; }
}
