package android.app;

public class Activity extends android.view.ContextThemeWrapper {
    protected void onCreate(android.os.Bundle savedInstanceState) { }
    protected void onResume() { }
    protected void onPause() { }
    public void setTitle(CharSequence title) { }
    public boolean isFinishing() { return false; }
    public boolean isDestroyed() { return false; }
    public void recreate() { }
    public void setContentView(android.view.View view) { }
    public android.content.Intent getIntent() { return null; }
    public void finish() { }
    public void runOnUiThread(Runnable action) { }
    public void requestPermissions(String[] permissions, int requestCode) { }
}
