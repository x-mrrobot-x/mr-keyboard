package android.graphics;

/** Compile stub (Android signature): only what the drawn grid uses. */
public class Paint {
    public static final int ANTI_ALIAS_FLAG = 1;
    public static final int FILTER_BITMAP_FLAG = 2;

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

    public void setColor(int color) {
        stubColor = color;
        stubPaintAlpha = color >>> 24;
    }
    /** The alpha that the real paint has (the one of its colour, or the one set after it): what a bitmap is drawn with. */
    public int stubPaintAlpha = 255;
    public int getColor() { return stubColor; }
    /** What was asked (the PC tests and their drawing backend read it). */
    public Style stubStyle = Style.FILL;
    public Shader stubShader;
    public int stubAlpha = 255;
    public void setStyle(Style style) { stubStyle = style; }
    public Shader setShader(Shader shader) { Shader old = stubShader; stubShader = shader; return old; }
    public void setAlpha(int a) {
        stubAlpha = a;
        stubPaintAlpha = a;
    }
    public void setAntiAlias(boolean aa) { }
    public void setDither(boolean dither) { }
    public void setFilterBitmap(boolean filter) { }
    public float stubStroke;
    public void setStrokeWidth(float width) { stubStroke = width; }
    public float getStrokeWidth() { return stubStroke; }
    public void setStrokeCap(Cap cap) { }
    public void setStrokeJoin(Join join) { }
    public PathEffect setPathEffect(PathEffect effect) { return null; }
    public Align stubAlign = Align.LEFT;
    public void setTextAlign(Align align) { stubAlign = align; }
    public void setTextSize(float textSize) { stubTextSize = textSize; }
    public float getTextSize() { return stubTextSize; }
    public void setShadowLayer(float radius, float dx, float dy, int shadowColor) {
        stubShadowRadius = radius;
        stubShadowColor = shadowColor;
    }
    public void clearShadowLayer() { stubShadowRadius = 0f; stubShadowColor = 0; }
    public Typeface setTypeface(Typeface typeface) { return typeface; }   // real API returns the previous typeface
    public float getFontMetrics(FontMetrics metrics) { return 0f; }       // real API returns the ascent
    /** Width of one character for measureText (the PC tests set it). */
    public static float stubCharWidth = 7f;
    public float measureText(String text) { return text.length() * stubCharWidth; }

    /** Strings hasGlyph answers false for (the PC tests fill it: a phone whose font lacks some emojis). */
    public static final java.util.HashSet<String> stubNoGlyph = new java.util.HashSet<String>();
    /** How many times hasGlyph was asked (the PC tests check that the answers are kept). */
    public static int stubGlyphCalls;
    public boolean hasGlyph(String string) { stubGlyphCalls++; return !stubNoGlyph.contains(string); }   // API 23
}
