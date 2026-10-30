package android.content;

public class ContextWrapper extends Context {
    protected void attachBaseContext(Context base) { }
    public android.content.res.AssetManager getAssets() { return null; }
    public Context getApplicationContext() { return null; }
    public android.content.res.Resources getResources() { return null; }
    public String getPackageName() { return null; }
    public android.content.pm.PackageManager getPackageManager() { return null; }
    public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
    public java.io.File getFilesDir() { return null; }
    public java.io.File getCacheDir() { return null; }
    public Object getSystemService(String name) { return null; }
    public void startActivity(Intent intent) { }
}
