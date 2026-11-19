package android.graphics;

/** Compile and PC test stub (Android signatures). The values are kept so that a test (or its drawing backend) can read them. */
public class LinearGradient extends Shader {
    public final float x0, y0, x1, y1;
    public final int[] colors;
    public final float[] positions;

    public LinearGradient(float x0, float y0, float x1, float y1, int[] colors, float[] positions, TileMode tile) {
        this.x0 = x0; this.y0 = y0; this.x1 = x1; this.y1 = y1; this.colors = colors; this.positions = positions;
    }

    public LinearGradient(float x0, float y0, float x1, float y1, int color0, int color1, TileMode tile) {
        this(x0, y0, x1, y1, new int[] {color0, color1}, null, tile);
    }
}
