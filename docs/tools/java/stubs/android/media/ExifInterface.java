package android.media;

/** Compile and PC test stub (Android signatures): the orientation of a photo. */
public class ExifInterface {
    public static final String TAG_ORIENTATION = "Orientation";
    public static final int ORIENTATION_NORMAL = 1;
    public static final int ORIENTATION_ROTATE_90 = 6;
    public static final int ORIENTATION_ROTATE_180 = 3;
    public static final int ORIENTATION_ROTATE_270 = 8;
    /** What the next photo says (the PC tests set it), and whether the file can be read at all. */
    public static int stubOrientation = 1;
    public static boolean stubFail;
    public ExifInterface(String filename) throws java.io.IOException {
        if (stubFail) throw new java.io.IOException("no exif");
    }
    public int getAttributeInt(String tag, int defaultValue) { return stubOrientation; }
}
