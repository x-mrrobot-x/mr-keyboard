package android.graphics.drawable;

public class GradientDrawable extends Drawable {
    public static final int RECTANGLE = 0;
    public static final int OVAL = 1;
    public GradientDrawable() { }
    public void setShape(int shape) { }
    /** What was asked (the PC tests tell the chosen tile from the others by it). */
    public int stubFill, stubLine;
    public void setColor(int argb) { stubFill = argb; }
    /** The radius as last set (the real class answers it too). */
    public float stubRadius;
    public void setCornerRadius(float radius) { stubRadius = radius; }
    public float getCornerRadius() { return stubRadius; }
    public void setStroke(int width, int color) { stubLine = color; }
}
