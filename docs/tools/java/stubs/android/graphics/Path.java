package android.graphics;

/** Compile and PC test stub (Android signatures): the trail of gesture typing. The test reads how many points it holds. */
public class Path {
    private int stubPoints;

    public Path() { }

    public void reset() { stubPoints = 0; }
    public void moveTo(float x, float y) { stubPoints++; }
    public void lineTo(float x, float y) { stubPoints++; }
    public boolean isEmpty() { return stubPoints == 0; }
    public int stubPoints() { return stubPoints; }
}
