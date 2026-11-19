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

    /**
     * The stream of a file of the app: a picture that the PC can read (PNG, JPEG) is decoded with its pixels; a WebP file (the PC has no decoder
     * for it) gives a bitmap of its size (read from its header) with a pattern that depends on its bytes, so two files do not look alike; anything
     * else is answered as before (the size that the test set). Not in Android: the way it is decoded.
     */
    public static Bitmap decodeStream(java.io.InputStream is, Rect outPadding, Options opts) {
        if (stubFail) return null;
        byte[] data = null;
        try {
            if (is != null) {
                java.io.ByteArrayOutputStream out = new java.io.ByteArrayOutputStream();
                byte[] buf = new byte[8192];
                int n;
                while ((n = is.read(buf)) > 0) out.write(buf, 0, n);
                data = out.toByteArray();
            }
        } catch (java.io.IOException e) {
            data = null;
        }
        if (data == null || data.length < 30) return decode(opts);
        int sample = opts == null || opts.inSampleSize < 1 ? 1 : opts.inSampleSize;
        try {
            java.awt.image.BufferedImage img = javax.imageio.ImageIO.read(new java.io.ByteArrayInputStream(data));
            if (img != null) {
                Bitmap b = Bitmap.createBitmap(Math.max(1, img.getWidth() / sample), Math.max(1, img.getHeight() / sample), Bitmap.Config.ARGB_8888);
                for (int y = 0; y < b.getHeight(); y++) {
                    for (int x = 0; x < b.getWidth(); x++) b.setPixel(x, y, img.getRGB(x * sample, y * sample) | 0xff000000);
                }
                stubSamples.add(Integer.valueOf(sample));
                return b;
            }
        } catch (java.io.IOException e) {
            // not a picture the PC reads: the WebP below, or the answer of the test
        }
        boolean webp = data[0] == 'R' && data[1] == 'I' && data[2] == 'F' && data[3] == 'F' && data[8] == 'W' && data[9] == 'E' && data[10] == 'B' && data[11] == 'P';
        if (!webp) return decode(opts);
        // a lossy WebP: "VP8 ", the size of the chunk, 3 bytes of frame tag, the start code 9d 01 2a, then width and height in 14 bits each
        int w = 0, h = 0;
        if (data[12] == 'V' && data[13] == 'P' && data[14] == '8' && data[15] == ' ') {
            w = ((data[26] & 0xff) | ((data[27] & 0x3f) << 8));
            h = ((data[28] & 0xff) | ((data[29] & 0x3f) << 8));
        }
        if (w <= 0 || h <= 0) return decode(opts);
        stubSamples.add(Integer.valueOf(sample));
        if (opts != null && opts.inJustDecodeBounds) {
            opts.outWidth = w;
            opts.outHeight = h;
            return null;
        }
        Bitmap b = Bitmap.createBitmap(Math.max(1, w / sample), Math.max(1, h / sample), Bitmap.Config.ARGB_8888);
        int seed = java.util.Arrays.hashCode(data);
        int base = 0xff000000 | (0x203040 + ((seed >> 3) & 0x1f1f1f));
        for (int y = 0; y < b.getHeight(); y++) {
            int shade = y * 80 / b.getHeight();
            for (int x = 0; x < b.getWidth(); x++) b.setPixel(x, y, base + (shade << 8) + ((x * 60 / b.getWidth()) << 16));
        }
        return b;
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
