package android.view.animation;

public class OvershootInterpolator implements Interpolator {
    public OvershootInterpolator(float tension) { }
    public float getInterpolation(float input) { return input; }
}
