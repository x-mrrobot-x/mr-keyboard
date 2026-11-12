package android.view;

/**
 * Compile and PC test stub (Android signatures): the touch events of the key grid (drag, tap, long press) and of gesture typing
 * (several fingers, the points between two events, the times).
 */
public final class MotionEvent {
    public static final int ACTION_DOWN = 0;
    public static final int ACTION_UP = 1;
    public static final int ACTION_MOVE = 2;
    public static final int ACTION_CANCEL = 3;
    public static final int ACTION_POINTER_DOWN = 5;
    public static final int ACTION_POINTER_UP = 6;

    private int stubAction;
    private int stubIndex;                       // which pointer went down or up (ACTION_POINTER_*)
    private long stubDown, stubTime;
    private int[] stubIds = {0};
    private float[] stubXs = {0f}, stubYs = {0f};
    private long[] stubHistT = new long[0];      // the points between the previous event and this one
    private float[][] stubHistX = new float[0][], stubHistY = new float[0][];
    /** Tests only: how many copies made by obtain(MotionEvent) were not recycled. */
    public static int stubLive;
    private boolean stubCopy;

    public MotionEvent() { }

    /** Builds an event like MotionEvent.obtain (the PC tests use it to drive the grid). */
    public static MotionEvent obtain(int action, float x, float y) {
        MotionEvent e = new MotionEvent();
        e.stubAction = action;
        e.stubXs = new float[] {x};
        e.stubYs = new float[] {y};
        return e;
    }

    /** Tests only: an event with every field. ids, xs, ys: one entry per finger on the screen. */
    public static MotionEvent stub(int action, int actionIndex, long downTime, long eventTime, int[] ids, float[] xs, float[] ys) {
        MotionEvent e = new MotionEvent();
        e.stubAction = action;
        e.stubIndex = actionIndex;
        e.stubDown = downTime;
        e.stubTime = eventTime;
        e.stubIds = ids.clone();
        e.stubXs = xs.clone();
        e.stubYs = ys.clone();
        return e;
    }

    /** Tests only: the points recorded between the previous event and this one (times, then x and y per point, per finger). */
    public MotionEvent stubHistory(long[] times, float[][] xs, float[][] ys) {
        stubHistT = times.clone();
        stubHistX = xs;
        stubHistY = ys;
        return this;
    }

    public static MotionEvent obtain(MotionEvent other) {
        MotionEvent e = new MotionEvent();
        e.stubAction = other.stubAction;
        e.stubIndex = other.stubIndex;
        e.stubDown = other.stubDown;
        e.stubTime = other.stubTime;
        e.stubIds = other.stubIds.clone();
        e.stubXs = other.stubXs.clone();
        e.stubYs = other.stubYs.clone();
        e.stubHistT = other.stubHistT;
        e.stubHistX = other.stubHistX;
        e.stubHistY = other.stubHistY;
        e.stubCopy = true;
        stubLive++;
        return e;
    }

    public void recycle() {
        if (stubCopy) {
            stubCopy = false;
            stubLive--;
        }
    }

    public void setAction(int action) { stubAction = action; stubIndex = 0; }
    public float getX() { return stubXs[0]; }
    public float getY() { return stubYs[0]; }
    public float getX(int pointerIndex) { return stubXs[pointerIndex]; }
    public float getY(int pointerIndex) { return stubYs[pointerIndex]; }
    public int getActionMasked() { return stubAction; }
    public int getActionIndex() { return stubIndex; }
    public int getPointerCount() { return stubIds.length; }
    public int getPointerId(int pointerIndex) { return stubIds[pointerIndex]; }
    public int findPointerIndex(int pointerId) {
        for (int i = 0; i < stubIds.length; i++) if (stubIds[i] == pointerId) return i;
        return -1;
    }
    public long getDownTime() { return stubDown; }
    public long getEventTime() { return stubTime; }
    public int getHistorySize() { return stubHistT.length; }
    public long getHistoricalEventTime(int pos) { return stubHistT[pos]; }
    public float getHistoricalX(int pointerIndex, int pos) { return stubHistX[pos][pointerIndex]; }
    public float getHistoricalY(int pointerIndex, int pos) { return stubHistY[pos][pointerIndex]; }
}
