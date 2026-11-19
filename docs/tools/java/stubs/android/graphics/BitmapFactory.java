package android.graphics;

/** Compile and PC test stub (Android signatures): the decoding of the picture that the person chooses as a background. */
public class BitmapFactory {
    public static class Options {
        public boolean inJustDecodeBounds;
        public int inSampleSize;
        public Bitmap.Config inPreferredConfig;
        public int outWidth;
        public int outHeight;
        public Options() { }
    }

    /** What the next decodeStream / decodeFile answer (the PC tests set them): the size of the picture and whether it can be decoded. */
    public static int stubWidth, stubHeight;
    public static boolean stubFail;
    /** The sample sizes that were asked for, in order. */
    public static final java.util.List<Integer> stubSamples = new java.util.ArrayList<Integer>();

    public static Bitmap decodeStream(java.io.InputStream is, Rect outPadding, Options opts) {
        return decode(opts);
    }

    public static Bitmap decodeFile(String pathName, Options opts) {
        return decode(opts);
    }

    public static Bitmap decodeFile(String pathName) {
        return decode(null);
    }

    private static Bitmap decode(Options opts) {
        if (stubFail) return null;
        if (opts != null && opts.inJustDecodeBounds) {
            opts.outWidth = stubWidth;
            opts.outHeight = stubHeight;
            return null;
        }
        int sample = opts == null || opts.inSampleSize < 1 ? 1 : opts.inSampleSize;
        stubSamples.add(Integer.valueOf(sample));
        return Bitmap.createBitmap(Math.max(1, stubWidth / sample), Math.max(1, stubHeight / sample), Bitmap.Config.ARGB_8888);
    }
}
