package android.view;

public class View {
    public View() { }
    public View(android.content.Context context) { }
    public static final int VISIBLE = 0;
    public static final int INVISIBLE = 4;
    public static final int GONE = 8;
    public interface OnClickListener { void onClick(View v); }
    public interface OnLongClickListener { boolean onLongClick(View v); }
    public interface OnLayoutChangeListener {
        void onLayoutChange(View view, int left, int top, int right, int bottom,
                int oldLeft, int oldTop, int oldRight, int oldBottom);
    }
    public android.content.Context getContext() { return null; }
    public android.content.res.Resources getResources() { return null; }
    public ViewParent getParent() { return null; }
    public View getRootView() { return this; }
    public int getWidth() { return 0; }
    public int getHeight() { return 0; }
    public void getLocationOnScreen(int[] location) { }
    public ViewGroup.LayoutParams getLayoutParams() { return null; }
    public void setLayoutParams(ViewGroup.LayoutParams params) { }
    public void setBackground(android.graphics.drawable.Drawable background) { }
    public void setBackgroundDrawable(android.graphics.drawable.Drawable background) { }
    public void setBackgroundColor(int color) { }
    private int padL, padT, padR, padB;
    private OnApplyWindowInsetsListener insetsListener;
    private int insetsRequests;
    public interface OnApplyWindowInsetsListener { WindowInsets onApplyWindowInsets(View v, WindowInsets insets); }
    /** Padding, listener and requests are kept so that the PC tests can read them. */
    public void setPadding(int left, int top, int right, int bottom) { padL = left; padT = top; padR = right; padB = bottom; }
    public int getPaddingLeft() { return padL; }
    public int getPaddingTop() { return padT; }
    public int getPaddingRight() { return padR; }
    public int getPaddingBottom() { return padB; }
    public void setOnApplyWindowInsetsListener(OnApplyWindowInsetsListener listener) { insetsListener = listener; }
    public OnApplyWindowInsetsListener stubInsetsListener() { return insetsListener; }
    public void requestApplyInsets() { insetsRequests++; }
    public int stubInsetsRequests() { return insetsRequests; }
    public void addOnLayoutChangeListener(OnLayoutChangeListener listener) { }
    public void removeOnLayoutChangeListener(OnLayoutChangeListener listener) { }
    public void setOnClickListener(OnClickListener l) { }
    public void setClickable(boolean clickable) { }
    public android.os.IBinder getWindowToken() { return null; }
    public void setOnLongClickListener(OnLongClickListener l) { }
    public void setVisibility(int visibility) { }
    public int getVisibility() { return 0; }
    public View findViewWithTag(Object tag) { return null; }
    public void setAlpha(float alpha) { }
    public void setElevation(float elevation) { }
}
