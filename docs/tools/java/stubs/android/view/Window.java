package android.view;

public class Window {
    public void setBackgroundDrawable(android.graphics.drawable.Drawable drawable) { }
    public void clearFlags(int flags) { }
    public void addFlags(int flags) { }
    public android.view.WindowManager.LayoutParams getAttributes() { return null; }
    public void setAttributes(android.view.WindowManager.LayoutParams attrs) { }
    public android.view.View getDecorView() { return null; }
    /** API 30. */
    public android.view.WindowInsetsController getInsetsController() { return null; }
    /** Flags kept so that the PC tests can read what a screen asked for (Window.setFlags: new value under a mask). */
    public int stubFlags;
    public void setFlags(int flags, int mask) { stubFlags = (stubFlags & ~mask) | (flags & mask); }
}
