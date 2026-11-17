package android.graphics.drawable;

public class GradientDrawable extends Drawable {
    public static final int RECTANGLE = 0;
    public static final int OVAL = 1;
    public enum Orientation { TOP_BOTTOM, BOTTOM_TOP, LEFT_RIGHT, RIGHT_LEFT }
    /** What the PC tests can read back: the one colour, the colours of a gradient, the line. */
    public int stubColor;
    public int[] stubColors;
    public Orientation stubOrientation;
    public int stubStrokeColor;
    public GradientDrawable() { }
    public void setShape(int shape) { }
    public void setColor(int argb) { stubColor = argb; }
    public void setColors(int[] colors) { stubColors = colors; }
    public void setOrientation(Orientation orientation) { stubOrientation = orientation; }
    public void setCornerRadius(float radius) { }
    public void setStroke(int width, int color) { stubStrokeColor = color; }
}
