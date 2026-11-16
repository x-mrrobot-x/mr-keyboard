package android.view;

/** Animation of the properties of a view (API 12 and later). The PC tests subclass it to read what was asked. */
public class ViewPropertyAnimator {
    public ViewPropertyAnimator() { }
    public ViewPropertyAnimator alpha(float value) { return this; }
    public ViewPropertyAnimator scaleX(float value) { return this; }
    public ViewPropertyAnimator scaleY(float value) { return this; }
    public ViewPropertyAnimator translationX(float value) { return this; }
    public ViewPropertyAnimator translationY(float value) { return this; }
    public ViewPropertyAnimator setDuration(long duration) { return this; }
    public ViewPropertyAnimator setStartDelay(long startDelay) { return this; }
    public ViewPropertyAnimator setInterpolator(android.animation.TimeInterpolator interpolator) { return this; }
    private Runnable stubEnd;
    public ViewPropertyAnimator withEndAction(Runnable runnable) { stubEnd = runnable; return this; }
    /** The PC tests have no clock: an animation ends the moment it starts, and its end action runs. */
    public void start() {
        Runnable r = stubEnd;
        stubEnd = null;
        if (r != null) r.run();
    }
    public void cancel() { }
}
