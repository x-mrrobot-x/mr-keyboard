package android.content.res;

/** Compile and PC test stub (Android signatures). */
public final class AssetManager {
    /** Not in Android: the folder that stands for the assets of the app in the PC tests (null: there are none, and open answers null). */
    public static java.io.File stubRoot;

    public java.io.InputStream open(String fileName) throws java.io.IOException {
        if (stubRoot == null) return null;
        return new java.io.FileInputStream(new java.io.File(stubRoot, fileName));
    }
}
