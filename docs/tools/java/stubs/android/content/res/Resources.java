package android.content.res;

public class Resources {
    public int getIdentifier(String name, String defType, String defPackage) { return 0; }
    public String getString(int id) { return null; }
    public String getString(int id, Object... formatArgs) { return null; }
    public Configuration getConfiguration() { return null; }
    public int getColor(int id) { return 0; }
    public android.graphics.drawable.Drawable getDrawable(int id) { return new android.graphics.drawable.Drawable() { }; }
    public float getDimension(int id) { return 0; }
    public int getInteger(int id) { return 0; }
    public android.util.DisplayMetrics getDisplayMetrics() { return null; }
    public java.io.InputStream openRawResource(int id) { return null; }
    public static final class Theme {
        public void setTo(Theme other) { }
    }
}
