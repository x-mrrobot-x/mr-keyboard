package android.graphics;

/** Compile stub (Android signature): only the drawing calls of the key grid. */
public class Canvas {
    public Canvas() { }

    public void drawRoundRect(RectF rect, float rx, float ry, Paint paint) { }

    /** Texts drawn, with the shadow the paint had at that moment ("text|radius|colour"): read by the PC tests. */
    public final java.util.List<String> stubTexts = new java.util.ArrayList<String>();

    public void drawText(String text, float x, float y, Paint paint) {
        stubTexts.add(text + "|" + paint.stubShadowRadius + "|" + Integer.toHexString(paint.stubShadowColor));
    }

    public void drawLine(float startX, float startY, float stopX, float stopY, Paint paint) { }

    public void drawCircle(float cx, float cy, float radius, Paint paint) { }

    public void drawArc(RectF oval, float startAngle, float sweepAngle, boolean useCenter, Paint paint) { }
}
