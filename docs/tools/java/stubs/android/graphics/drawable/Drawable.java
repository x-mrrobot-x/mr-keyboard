package android.graphics.drawable;

public abstract class Drawable {
    public void setAlpha(int alpha) { }
    public void setBounds(int left, int top, int right, int bottom) { }
    public int getOpacity() { return 0; }
    /** Colour filter as last set: read by the PC tests. */
    public android.graphics.ColorFilter stubFilter;
    public void setColorFilter(android.graphics.ColorFilter colorFilter) { stubFilter = colorFilter; }
}
