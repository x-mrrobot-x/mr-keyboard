package android.widget;

/** Compile and PC test stub (Android signatures): a scroller that only knows where a fling stops. */
public class OverScroller {
    /** Tests only: how far a fling goes for each px/s of speed (the real physics are not in the stub). */
    public static float stubReach = 0.4f;
    private int velocity;
    public OverScroller(android.content.Context context) { }
    public void forceFinished(boolean finished) { }
    public void fling(int startX, int startY, int velocityX, int velocityY, int minX, int maxX, int minY, int maxY) { velocity = velocityY; }
    public int getFinalY() { return Math.round(velocity * stubReach); }
}
