package android.view;

/** Compile stub (Android signature): the touch events of the key grid (drag, tap, long press). */
public final class MotionEvent {
    public static final int ACTION_DOWN = 0;
    public static final int ACTION_UP = 1;
    public static final int ACTION_MOVE = 2;
    public static final int ACTION_CANCEL = 3;

    private int stubAction;
    private float stubX, stubY;

    public MotionEvent() { }

    /** Builds an event like MotionEvent.obtain (the PC tests use it to drive the grid). */
    public static MotionEvent obtain(int action, float x, float y) {
        MotionEvent e = new MotionEvent();
        e.stubAction = action;
        e.stubX = x;
        e.stubY = y;
        return e;
    }

    public float getX() { return stubX; }
    public float getY() { return stubY; }
    public int getActionMasked() { return stubAction; }
}
