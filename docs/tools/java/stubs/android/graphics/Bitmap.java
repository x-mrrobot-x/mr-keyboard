package android.graphics;

/** Compile and PC test stub (Android signatures). The pixels are kept (ARGB, row by row) so that a test can read what was drawn on it. */
public final class Bitmap {
    public enum Config { ALPHA_8, RGB_565, ARGB_4444, ARGB_8888 }
    public enum CompressFormat { JPEG, PNG, WEBP }

    public final int stubW, stubH;
    public final int[] stubPixels;
    public boolean stubRecycled;
    /** What compress wrote (the format and the quality of the last call), for the tests. */
    public CompressFormat stubFormat;
    public int stubQuality;

    private Bitmap(int w, int h) { stubW = w; stubH = h; stubPixels = new int[w * h]; }

    public static Bitmap createBitmap(int width, int height, Config config) {
        if (width <= 0 || height <= 0) throw new IllegalArgumentException("width and height must be > 0");
        return new Bitmap(width, height);
    }

    /** The scaled copy (the pixels are not resampled in the stub: only the size is what the tests read). */
    public static Bitmap createScaledBitmap(Bitmap src, int dstWidth, int dstHeight, boolean filter) {
        return createBitmap(dstWidth, dstHeight, Config.ARGB_8888);
    }

    /** The turned copy: a quarter turn swaps the sides (what the tests read), the other angles keep them. */
    public static Bitmap createBitmap(Bitmap src, int x, int y, int width, int height, Matrix m, boolean filter) {
        boolean quarter = m != null && Math.abs(Math.round(m.stubDegrees / 90f)) % 2 == 1;
        return quarter ? createBitmap(height, width, Config.ARGB_8888) : createBitmap(width, height, Config.ARGB_8888);
    }

    public final int getWidth() { return stubW; }
    public final int getHeight() { return stubH; }
    public int getPixel(int x, int y) { return stubPixels[y * stubW + x]; }
    public void setPixel(int x, int y, int color) { stubPixels[y * stubW + x] = color; }
    public void getPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {
        for (int j = 0; j < height; j++) {
            for (int i = 0; i < width; i++) pixels[offset + j * stride + i] = stubPixels[(y + j) * stubW + x + i];
        }
    }
    public void recycle() { stubRecycled = true; }
    public final boolean isRecycled() { return stubRecycled; }

    public boolean compress(CompressFormat format, int quality, java.io.OutputStream stream) {
        stubFormat = format;
        stubQuality = quality;
        try {
            stream.write(new byte[] {(byte) 0xff, (byte) 0xd8, 1, 2, 3});
        } catch (java.io.IOException e) {
            return false;
        }
        return true;
    }
}
