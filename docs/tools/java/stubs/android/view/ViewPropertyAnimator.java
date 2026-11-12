package android.view;

/** Animation of the properties of a view (API 12). The PC tests subclass it to read what was asked. */
public class ViewPropertyAnimator {
    public ViewPropertyAnimator() { }
    public ViewPropertyAnimator alpha(float value) { return this; }
    public ViewPropertyAnimator scaleY(float value) { return this; }
    public ViewPropertyAnimator setDuration(long duration) { return this; }
    public void start() { }
    public void cancel() { }
}
