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

    private int stubColor = 0xff000000;
    private float stubTextSize;
    /** Shadow layer as last set (radius 0 = none): read by the PC tests. */
    public float stubShadowRadius;
    public int stubShadowColor;

    public void setColor(int color) { stubColor = color; }
    public int getColor() { return stubColor; }
    public void setStyle(Style style) { }
    public void setStrokeWidth(float width) { }
    public float getStrokeWidth() { return 0f; }
    public void setStrokeCap(Cap cap) { }
    public void setStrokeJoin(Join join) { }
    public PathEffect setPathEffect(PathEffect effect) { return null; }
    public void setTextAlign(Align align) { }
    public void setTextSize(float textSize) { stubTextSize = textSize; }
    public float getTextSize() { return stubTextSize; }
    public void setShadowLayer(float radius, float dx, float dy, int shadowColor) {
        stubShadowRadius = radius;
        stubShadowColor = shadowColor;
    }
    public void clearShadowLayer() { stubShadowRadius = 0f; stubShadowColor = 0; }
    public Typeface setTypeface(Typeface typeface) { return typeface; }   // real API returns the previous typeface
    public float getFontMetrics(FontMetrics metrics) { return 0f; }       // real API returns the ascent

    /** Strings hasGlyph answers false for (the PC tests fill it: a phone whose font lacks some emojis). */
    public static final java.util.HashSet<String> stubNoGlyph = new java.util.HashSet<String>();
    /** How many times hasGlyph was asked (the PC tests check that the answers are kept). */
    public static int stubGlyphCalls;
    public boolean hasGlyph(String string) { stubGlyphCalls++; return !stubNoGlyph.contains(string); }   // API 23
}
