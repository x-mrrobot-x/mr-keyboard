package android.graphics;

/** Compile and PC test stub (Android signatures): only the rotation that the photos of the gallery need. */
public class Matrix {
    public float stubDegrees;
    public float stubSx = 1f, stubSy = 1f;
    public Matrix() { }
    public boolean postRotate(float degrees) { stubDegrees += degrees; return true; }
    public boolean postScale(float sx, float sy) { stubSx *= sx; stubSy *= sy; return true; }
}
