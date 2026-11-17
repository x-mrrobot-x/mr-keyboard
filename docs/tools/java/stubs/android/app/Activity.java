package android.app;

public class Activity extends android.view.ContextThemeWrapper {
    protected void onCreate(android.os.Bundle savedInstanceState) { }
    protected void onDestroy() { }
    protected void onNewIntent(android.content.Intent intent) { }
    public void setIntent(android.content.Intent newIntent) { }
    protected void onSaveInstanceState(android.os.Bundle outState) { }
    protected void onResume() { }
    protected void onPause() { }
    public void onWindowFocusChanged(boolean hasFocus) { }
    public void onConfigurationChanged(android.content.res.Configuration newConfig) { }
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
    /** Not in Android: how many times the screen was finished (and how many of them took the whole task with them), and what isTaskRoot answers. */
    public int stubFinishes, stubTaskRemovals;
    public boolean stubTaskRoot;
    /** Not in Android: the task the screen is in, and the description it gave the task. */
    public int stubTaskId;
    public ActivityManager.TaskDescription stubTaskDescription;
    public int getTaskId() { return stubTaskId; }
    public void setTaskDescription(ActivityManager.TaskDescription description) { stubTaskDescription = description; }
    public void finish() { stubFinishes++; }
    public boolean isTaskRoot() { return stubTaskRoot; }
    public void finishAndRemoveTask() { stubFinishes++; stubTaskRemovals++; }
    public android.view.View findViewById(int id) { return null; }
    public void runOnUiThread(Runnable action) { }
    public void requestPermissions(String[] permissions, int requestCode) { }
    public void startActivityForResult(android.content.Intent intent, int requestCode) { }
    protected void onActivityResult(int requestCode, int resultCode, android.content.Intent data) { }
    public static final int RESULT_OK = -1;
    public android.content.ContentResolver getContentResolver() { return null; }
}
