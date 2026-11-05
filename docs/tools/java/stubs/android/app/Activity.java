package android.app;

public class Activity extends android.view.ContextThemeWrapper {
    protected void onCreate(android.os.Bundle savedInstanceState) { }
    protected void onNewIntent(android.content.Intent intent) { }
    public void setIntent(android.content.Intent newIntent) { }
    protected void onSaveInstanceState(android.os.Bundle outState) { }
    protected void onResume() { }
    protected void onPause() { }
    public void setTitle(CharSequence title) { }
    public boolean isFinishing() { return false; }
    public boolean isDestroyed() { return false; }
    public int stubRecreates;
    /** Counts the calls so that the PC tests can see that a screen was created again. */
    public void recreate() { stubRecreates++; }
    public android.view.Window stubWindow = new android.view.Window();
    public android.view.Window getWindow() { return stubWindow; }
    public void setContentView(android.view.View view) { }
    public android.content.Intent getIntent() { return null; }
    public void finish() { }
    public android.view.View findViewById(int id) { return null; }
    public void runOnUiThread(Runnable action) { }
    public void requestPermissions(String[] permissions, int requestCode) { }
}
