package android.view;

public class View {
    private android.content.Context stubContext;
    public View() { }
    public View(android.content.Context context) { stubContext = context; }
    public static final int VISIBLE = 0;
    public static final int INVISIBLE = 4;
    public static final int GONE = 8;
    public interface OnClickListener { void onClick(View v); }
    public interface OnLongClickListener { boolean onLongClick(View v); }
    public interface OnTouchListener { boolean onTouch(View v, MotionEvent event); }
    public interface OnFocusChangeListener { void onFocusChange(View v, boolean hasFocus); }
    public static final int FOCUS_DOWN = 130;
    public interface OnLayoutChangeListener {
        void onLayoutChange(View view, int left, int top, int right, int bottom,
                int oldLeft, int oldTop, int oldRight, int oldBottom);
    }
    public android.content.Context getContext() { return stubContext; }
    public android.content.res.Resources getResources() { return null; }
    private Object stubTag;
    public Object getTag() { return stubTag; }
    public void setTag(Object tag) { stubTag = tag; }
    public ViewParent getParent() { return null; }
    public View getRootView() { return this; }
    private int stubW, stubH;
    /** Size of the view, set by the PC tests (a real view gets it from the layout). */
    public void stubSize(int w, int h) { stubW = w; stubH = h; }
    public int getWidth() { return stubW; }
    public int getHeight() { return stubH; }
    public void getLocationOnScreen(int[] location) { }
    public ViewGroup.LayoutParams getLayoutParams() { return null; }
    public void setLayoutParams(ViewGroup.LayoutParams params) { }
    public void setBackground(android.graphics.drawable.Drawable background) { }
    public void setBackgroundResource(int resid) { }
    public boolean postDelayed(Runnable action, long delayMillis) { stubPosted.add(action); return true; }
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
    public WindowInsets onApplyWindowInsets(WindowInsets insets) { return insets; }
    public OnApplyWindowInsetsListener stubInsetsListener() { return insetsListener; }
    public void requestApplyInsets() { insetsRequests++; }
    public int stubInsetsRequests() { return insetsRequests; }
    private boolean stubFocus, stubWindowFocus;
    private int stubTop;
    private WindowInsets stubRoot;
    private final ViewTreeObserver stubObserver = new ViewTreeObserver();
    private final java.util.ArrayList<Runnable> stubPosted = new java.util.ArrayList<Runnable>();
    /** Focus, window focus, position, root insets and posted work: kept so that the PC tests can drive and read them. */
    public boolean requestFocus() { stubFocus = true; return true; }
    public boolean hasFocus() { return stubFocus; }
    public void stubClearFocus() { stubFocus = false; }
    public View findFocus() { return stubFocus ? this : null; }
    public boolean hasWindowFocus() { return stubWindowFocus; }
    public void stubWindowFocus(boolean has) { stubWindowFocus = has; stubObserver.stubDispatch(has); }
    public ViewTreeObserver getViewTreeObserver() { return stubObserver; }
    public int getTop() { return stubTop; }
    public void stubTop(int top) { stubTop = top; }
    public WindowInsets getRootWindowInsets() { return stubRoot; }
    public void stubRootInsets(WindowInsets insets) { stubRoot = insets; }
    public boolean post(Runnable action) { stubPosted.add(action); return true; }
    public int stubPostedCount() { return stubPosted.size(); }
    public void stubRunPosted() {
        while (!stubPosted.isEmpty()) stubPosted.remove(0).run();
    }
    public void addOnLayoutChangeListener(OnLayoutChangeListener listener) { }
    public void removeOnLayoutChangeListener(OnLayoutChangeListener listener) { }
    public void setOnClickListener(OnClickListener l) { }
    public void setOnFocusChangeListener(OnFocusChangeListener l) { }
    public void setClickable(boolean clickable) { }
    public void setContentDescription(CharSequence contentDescription) { }
    public void setEnabled(boolean enabled) { }
    public android.os.IBinder getWindowToken() { return null; }
    public void setOnLongClickListener(OnLongClickListener l) { }
    public void setOnTouchListener(OnTouchListener l) { }
    public void scrollTo(int x, int y) { }
    private int stubVisibility;
    public void setVisibility(int visibility) { stubVisibility = visibility; }
    public int getVisibility() { return stubVisibility; }
    public View findViewWithTag(Object tag) { return null; }
    public void setAlpha(float alpha) { }
    public void setElevation(float elevation) { }

    /** Measure modes and the helpers of onMeasure (Android nested class View.MeasureSpec). */
    public static class MeasureSpec {
        public static int getSize(int measureSpec) { return 0; }
    }
    /** Drawing and measuring hooks of a drawn view (the key grid of the sheet editor). */
    protected void onDraw(android.graphics.Canvas canvas) { }
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) { setMeasuredDimension(0, 0); }
    protected void onSizeChanged(int w, int h, int oldw, int oldh) { }
    public boolean onTouchEvent(MotionEvent event) { return false; }
    public static int resolveSize(int size, int measureSpec) { return size; }
    protected final void setMeasuredDimension(int measuredWidth, int measuredHeight) { stubMeasuredH = measuredHeight; }
    private int stubMeasuredH;
    public int stubMeasuredHeight() { return stubMeasuredH; }
    /** Runs the measure step (a real view is measured by its parent). */
    public final void measure(int widthMeasureSpec, int heightMeasureSpec) { onMeasure(widthMeasureSpec, heightMeasureSpec); }
    public void requestLayout() { }
    public void invalidate() { }
    /** Tests read how many times a part of the view was asked to be drawn again and the last rectangle. */
    public int stubInvalidates;
    public int[] stubDirty;
    public void invalidate(int l, int t, int r, int b) { stubInvalidates++; stubDirty = new int[] {l, t, r, b}; }
    public boolean performHapticFeedback(int feedbackConstant) { return true; }
    private boolean stubAttached, stubAccelerated;
    /** Attached to a window and drawn with hardware acceleration: set by the PC tests, read by the code. */
    public void stubWindowState(boolean attached, boolean accelerated) { stubAttached = attached; stubAccelerated = accelerated; }
    public boolean isAttachedToWindow() { return stubAttached; }
    public boolean isHardwareAccelerated() { return stubAccelerated; }
}
