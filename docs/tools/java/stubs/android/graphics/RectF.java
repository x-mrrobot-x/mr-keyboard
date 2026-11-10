package android.graphics;

/** Compile stub (Android signature): a rectangle with float edges. */
public class RectF {
    public float left;
    public float top;
    public float right;
    public float bottom;

    public RectF() { }

    public RectF(float left, float top, float right, float bottom) {
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }

    public void set(float left, float top, float right, float bottom) {
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }

    public final float width() { return right - left; }
    public final float height() { return bottom - top; }
    public final float centerX() { return (left + right) * 0.5f; }
    public final float centerY() { return (top + bottom) * 0.5f; }
    public boolean contains(float x, float y) {
        return x >= left && x < right && y >= top && y < bottom;
    }
}
