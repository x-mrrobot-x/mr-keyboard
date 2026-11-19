package android.graphics;

/** Compile stub (Android signature): only the drawing calls of the key grid. */
public class Canvas {
    public Canvas() { stubBitmap = null; }

    /** The bitmap this canvas draws on (null: a canvas of a view). */
    public final Bitmap stubBitmap;

    public Canvas(Bitmap bitmap) { stubBitmap = bitmap; }

    /**
     * Not in Android: a drawing backend the PC tests plug in to rasterize what the code draws on a bitmap (the stub itself draws nothing).
     * Null: the calls only count.
     */
    public interface StubBackend {
        void drawRect(Canvas canvas, float left, float top, float right, float bottom, Paint paint);
        void drawCircle(Canvas canvas, float cx, float cy, float radius, Paint paint);
        void drawPath(Canvas canvas, Path path, Paint paint);
        void drawColor(Canvas canvas, int color);
        void drawBitmap(Canvas canvas, Bitmap bitmap, Rect src, Rect dst, Paint paint);
        void drawRoundRect(Canvas canvas, float left, float top, float right, float bottom, float rx, float ry, Paint paint);
        /** The state calls: a backend that rasterizes keeps its own stack of transforms and clips (the defaults ignore them). */
        default void save(Canvas canvas) { }
        default void restore(Canvas canvas) { }
        default void translate(Canvas canvas, float dx, float dy) { }
        default void scale(Canvas canvas, float sx, float sy) { }
        default void clipPath(Canvas canvas, Path path) { }
        default void drawText(Canvas canvas, String text, float x, float y, Paint paint) { }
        default void drawLine(Canvas canvas, float x0, float y0, float x1, float y1, Paint paint) { }
    }
    public static StubBackend stubBackend;
    /** How many drawing calls of each kind were made on any canvas (the PC tests count them). */
    public static int stubRects, stubCircles, stubBitmaps, stubColors;

    public void drawRect(float left, float top, float right, float bottom, Paint paint) {
        stubRects++;
        if (stubBackend != null) stubBackend.drawRect(this, left, top, right, bottom, paint);
    }

    public void drawBitmap(Bitmap bitmap, Rect src, Rect dst, Paint paint) {
        stubBitmaps++;
        if (stubBackend != null) stubBackend.drawBitmap(this, bitmap, src, dst, paint);
    }

    public void drawRoundRect(float left, float top, float right, float bottom, float rx, float ry, Paint paint) {
        if (stubBackend != null) stubBackend.drawRoundRect(this, left, top, right, bottom, rx, ry, paint);
    }

    public int save() { if (stubBackend != null) stubBackend.save(this); return 0; }
    public void restore() { if (stubBackend != null) stubBackend.restore(this); }
    public void translate(float dx, float dy) { if (stubBackend != null) stubBackend.translate(this, dx, dy); }
    public void scale(float sx, float sy) { if (stubBackend != null) stubBackend.scale(this, sx, sy); }
    public boolean clipRect(int left, int top, int right, int bottom) { return true; }
    public boolean clipPath(Path path) { if (stubBackend != null) stubBackend.clipPath(this, path); return true; }

    public void drawRoundRect(RectF rect, float rx, float ry, Paint paint) { }

    /** Not in Android: the colour that drawColor filled the canvas with last, and every glyph drawn ("text@x,y#colour"), for the PC tests. */
    public int stubFill;
    public final java.util.List<String> stubGlyphs = new java.util.ArrayList<String>();
    public void drawColor(int color) {
        stubFill = color;
        stubColors++;
        if (stubBackend != null) stubBackend.drawColor(this, color);
    }

    /** Texts drawn, with the shadow the paint had at that moment ("text|radius|colour"): read by the PC tests. */
    public final java.util.List<String> stubTexts = new java.util.ArrayList<String>();

    public void drawText(String text, float x, float y, Paint paint) {
        stubTexts.add(text + "|" + paint.stubShadowRadius + "|" + Integer.toHexString(paint.stubShadowColor));
        stubGlyphs.add(text + "@" + x + "," + y + "#" + Integer.toHexString(paint.getColor()));
        if (stubBackend != null) stubBackend.drawText(this, text, x, y, paint);
    }

    public void drawLine(float startX, float startY, float stopX, float stopY, Paint paint) {
        if (stubBackend != null) stubBackend.drawLine(this, startX, startY, stopX, stopY, paint);
    }

    public void drawCircle(float cx, float cy, float radius, Paint paint) {
        stubCircles++;
        if (stubBackend != null) stubBackend.drawCircle(this, cx, cy, radius, paint);
    }

    public void drawArc(RectF oval, float startAngle, float sweepAngle, boolean useCenter, Paint paint) { }

    /** Tests read the paths drawn (the trail of gesture typing). */
    public int stubPaths;

    public void drawPath(Path path, Paint paint) {
        stubPaths++;
        if (stubBackend != null) stubBackend.drawPath(this, path, paint);
    }
}
