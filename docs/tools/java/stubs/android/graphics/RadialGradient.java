package android.graphics;

/** Compile and PC test stub (Android signature). The values are kept so that a test (or its drawing backend) can read them. */
public class RadialGradient extends Shader {
    public final float cx, cy, radius;
    public final int[] colors;
    public final float[] stops;

    public RadialGradient(float centerX, float centerY, float radius, int[] colors, float[] stops, TileMode tileMode) {
        this.cx = centerX; this.cy = centerY; this.radius = radius; this.colors = colors; this.stops = stops;
    }
}
