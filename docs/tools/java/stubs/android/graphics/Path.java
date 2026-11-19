package android.graphics;

/** Compile and PC test stub (Android signatures): the trail of gesture typing. The test reads how many points it holds. */
public class Path {
    private int stubPoints;

    public Path() { }

    /** The calls, in order: {code, values...} with 0 moveTo, 1 lineTo, 2 quadTo, 3 close (the drawing backend of the PC tests follows them). */
    public final java.util.List<float[]> stubOps = new java.util.ArrayList<float[]>();

    public void reset() { stubPoints = 0; stubOps.clear(); }
    public void moveTo(float x, float y) { stubPoints++; stubOps.add(new float[] {0, x, y}); }
    public void lineTo(float x, float y) { stubPoints++; stubOps.add(new float[] {1, x, y}); }
    public void quadTo(float x1, float y1, float x2, float y2) { stubPoints++; stubOps.add(new float[] {2, x1, y1, x2, y2}); }
    public void close() { stubOps.add(new float[] {3}); }
    public boolean isEmpty() { return stubPoints == 0; }
    public int stubPoints() { return stubPoints; }
}
