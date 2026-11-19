package android.view;

public abstract class ViewGroup extends View implements ViewParent {
    protected ViewGroup() { }
    protected ViewGroup(android.content.Context context) { super(context); }
    public static class LayoutParams {
        public static final int MATCH_PARENT = -1;
        public static final int WRAP_CONTENT = -2;
        public int width;
        public int height;
        public LayoutParams(int width, int height) { this.width = width; this.height = height; }
    }
    public void requestDisallowInterceptTouchEvent(boolean disallowIntercept) { }
    /** Children as added, with the layout params each came with: read by the PC tests. */
    private final java.util.ArrayList<View> stubChildren = new java.util.ArrayList<View>();
    private final java.util.ArrayList<LayoutParams> stubParams = new java.util.ArrayList<LayoutParams>();
    public void addView(View child) { stubChildren.add(child); stubParams.add(null); child.stubParent = this; }
    public void addView(View child, ViewGroup.LayoutParams params) { stubChildren.add(child); stubParams.add(params); child.stubParent = this; }
    public void removeView(View child) { int i = stubChildren.indexOf(child); if (i >= 0) { stubChildren.remove(i); stubParams.remove(i); child.stubParent = null; } }
    public int getChildCount() { return stubChildren.size(); }
    public View getChildAt(int index) { return index >= 0 && index < stubChildren.size() ? stubChildren.get(index) : null; }
    public LayoutParams stubParamsAt(int index) { return stubParams.get(index); }
    public void removeAllViews() { for (View v : stubChildren) v.stubParent = null; stubChildren.clear(); stubParams.clear(); }
}
