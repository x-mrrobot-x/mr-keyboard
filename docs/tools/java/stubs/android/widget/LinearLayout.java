package android.widget;

public class LinearLayout extends android.view.ViewGroup {
    public static final int HORIZONTAL = 0;
    public static final int VERTICAL = 1;
    public static class LayoutParams extends android.view.ViewGroup.LayoutParams {
        public LayoutParams(int width, int height) { super(width, height); }
        public LayoutParams(int width, int height, float weight) { super(width, height); }
        public void setMargins(int l, int t, int r, int b) { }
    }
    public LinearLayout(android.content.Context context) { }
    public void setOrientation(int orientation) { }
    public void setGravity(int gravity) { }
}
