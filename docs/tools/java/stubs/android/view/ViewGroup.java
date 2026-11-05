package android.view;

public abstract class ViewGroup extends View implements ViewParent {
    protected ViewGroup() { }
    protected ViewGroup(android.content.Context context) { super(context); }
    public static class LayoutParams {
        public static final int MATCH_PARENT = -1;
        public static final int WRAP_CONTENT = -2;
        public int width;
        public int height;
        public LayoutParams(int width, int height) { }
    }
    public void addView(View child) { }
    public void addView(View child, ViewGroup.LayoutParams params) { }
    public void removeView(View child) { }
    public int getChildCount() { return 0; }
    public View getChildAt(int index) { return null; }
    public void removeAllViews() { }
}
