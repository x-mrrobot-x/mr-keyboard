package android.content;

public class ContextWrapper extends Context {
    public ContextWrapper() { }
    public ContextWrapper(Context base) { }
    protected void attachBaseContext(Context base) { }
    private Context stubBase;
    /** Stub only: lets a PC test give the wrapper (a service) its context. */
    public void stubAttach(Context base) { stubBase = base; }
    public android.content.res.AssetManager getAssets() { return null; }
    public Context getApplicationContext() { return stubBase != null ? stubBase.getApplicationContext() : null; }
    public android.content.res.Resources getResources() { return null; }
    public String getPackageName() { return null; }
    public android.content.pm.PackageManager getPackageManager() { return null; }
    public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
    public java.io.File getFilesDir() { return null; }
    public java.io.File getCacheDir() { return null; }
    public void startActivity(Intent intent) { }
}
