package android.app;

public class Activity extends android.view.ContextThemeWrapper {
    protected void onCreate(android.os.Bundle savedInstanceState) { }
    protected void onResume() { }
    protected void onPause() { }
    public void setTitle(CharSequence title) { }
    public boolean isFinishing() { return false; }
    public boolean isDestroyed() { return false; }
}
