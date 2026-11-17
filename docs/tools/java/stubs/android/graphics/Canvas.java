package android.graphics;

/** Compile stub (Android signature): only the drawing calls of the key grid. */
public class Canvas {
    public Canvas() { }

    public void drawRoundRect(RectF rect, float rx, float ry, Paint paint) { }

    /** Not in Android: the colour that drawColor filled the canvas with last, and every glyph drawn ("text@x,y#colour"), for the PC tests. */
    public int stubFill;
    public final java.util.List<String> stubGlyphs = new java.util.ArrayList<String>();
    public void drawColor(int color) { stubFill = color; }

    /** Texts drawn, with the shadow the paint had at that moment ("text|radius|colour"): read by the PC tests. */
    public final java.util.List<String> stubTexts = new java.util.ArrayList<String>();

    public void drawText(String text, float x, float y, Paint paint) {
        stubTexts.add(text + "|" + paint.stubShadowRadius + "|" + Integer.toHexString(paint.stubShadowColor));
        stubGlyphs.add(text + "@" + x + "," + y + "#" + Integer.toHexString(paint.getColor()));
    }

    public void drawLine(float startX, float startY, float stopX, float stopY, Paint paint) { }

    public void drawCircle(float cx, float cy, float radius, Paint paint) { }

    public void drawArc(RectF oval, float startAngle, float sweepAngle, boolean useCenter, Paint paint) { }

    /** Tests read the paths drawn (the trail of gesture typing). */
    public int stubPaths;

    public void drawPath(Path path, Paint paint) { stubPaths++; }
}
