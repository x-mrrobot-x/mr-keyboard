package android.widget;

public class FrameLayout extends android.view.ViewGroup {
    public static class LayoutParams extends android.view.ViewGroup.LayoutParams {
        public int gravity;
        public LayoutParams(int width, int height) { super(width, height); }
        public LayoutParams(int width, int height, int gravity) { super(width, height); this.gravity = gravity; }
    }
    public FrameLayout(android.content.Context context) { super(context); }
}
