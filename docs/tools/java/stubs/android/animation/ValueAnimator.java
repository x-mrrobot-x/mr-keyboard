package android.animation;

public class ValueAnimator {
    public interface AnimatorUpdateListener {
        void onAnimationUpdate(ValueAnimator animation);
    }

    private int[] stubValues = new int[0];
    private Object stubValue;
    private AnimatorUpdateListener stubListener;

    public ValueAnimator() { }
    public static ValueAnimator ofInt(int... values) {
        ValueAnimator a = new ValueAnimator();
        a.stubValues = values;
        return a;
    }
    public ValueAnimator setDuration(long duration) { return this; }
    public void setInterpolator(TimeInterpolator value) { }
    public void addUpdateListener(AnimatorUpdateListener listener) { stubListener = listener; }
    public Object getAnimatedValue() { return stubValue; }
    /** The PC tests have no clock: an animation jumps to its last value the moment it starts, and the listener hears it once. */
    public void start() {
        if (stubValues.length == 0) return;
        stubValue = Integer.valueOf(stubValues[stubValues.length - 1]);
        if (stubListener != null) stubListener.onAnimationUpdate(this);
    }
    public void cancel() { }
}
