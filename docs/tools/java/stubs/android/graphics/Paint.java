package android.graphics;

/** Compile stub (Android signature): only what the drawn grid uses. */
public class Paint {
    public static final int ANTI_ALIAS_FLAG = 1;

    public enum Style { FILL, STROKE, FILL_AND_STROKE }

    public enum Align { LEFT, CENTER, RIGHT }

    public enum Cap { BUTT, ROUND, SQUARE }

    public enum Join { MITER, ROUND, BEVEL }

    public static class FontMetrics {
        public float ascent;
        public float descent;
    }

    public Paint(int flags) { }

    public void setColor(int color) { }
    public void setStyle(Style style) { }
    public void setStrokeWidth(float width) { }
    public float getStrokeWidth() { return 0f; }
    public void setStrokeCap(Cap cap) { }
    public void setStrokeJoin(Join join) { }
    public PathEffect setPathEffect(PathEffect effect) { return null; }
    public void setTextAlign(Align align) { }
    public void setTextSize(float textSize) { }
    public Typeface setTypeface(Typeface typeface) { return typeface; }   // real API returns the previous typeface
    public float getFontMetrics(FontMetrics metrics) { return 0f; }       // real API returns the ascent
}
