package android.view.animation;

/** API 21: the curve of a cubic Bezier (the Material easings). */
public class PathInterpolator implements Interpolator {
    public PathInterpolator(float controlX1, float controlY1, float controlX2, float controlY2) { }
    public float getInterpolation(float input) { return input; }
}
