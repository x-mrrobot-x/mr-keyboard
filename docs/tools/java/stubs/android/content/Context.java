package android.content;

/** Compile stub: only what the Mr Keyboard Java layer uses (Android signatures). */
public abstract class Context {
    public static final int MODE_PRIVATE = 0;
    public static final String JOB_SCHEDULER_SERVICE = "jobscheduler";
    public static final String NOTIFICATION_SERVICE = "notification";
    public static final String INPUT_METHOD_SERVICE = "input_method";
    public abstract android.content.res.AssetManager getAssets();
    public abstract Context getApplicationContext();
    public abstract android.content.res.Resources getResources();
    public abstract String getPackageName();
    public abstract android.content.pm.PackageManager getPackageManager();
    public abstract SharedPreferences getSharedPreferences(String name, int mode);
    public abstract java.io.File getFilesDir();
    public abstract java.io.File getCacheDir();
    public abstract void startActivity(Intent intent);
    public android.content.res.Resources.Theme getTheme() { return null; }
    public Object getSystemService(String name) { return null; }
}
