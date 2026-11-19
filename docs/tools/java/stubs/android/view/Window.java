package android.view;

public class Window {
    /** Not in Android: the background that the screen asked for last (read by the PC tests). */
    public android.graphics.drawable.Drawable stubBackground;
    public void setBackgroundDrawable(android.graphics.drawable.Drawable drawable) { stubBackground = drawable; }
    public void clearFlags(int flags) { }
    public void addFlags(int flags) { }
    public android.view.WindowManager.LayoutParams getAttributes() { return null; }
    public void setAttributes(android.view.WindowManager.LayoutParams attrs) { }
    public android.view.View getDecorView() { return null; }
    /** API 30. */
    public android.view.WindowInsetsController getInsetsController() { return null; }
    /** Flags kept so that the PC tests can read what a screen asked for (Window.setFlags: new value under a mask). */
    public int stubFlags;
    /** Not in Android: what the navigation bar was asked for last (the colour, and the veil of API 29 that the system puts on three buttons). */
    public int stubNavigationBarColor = 0xff000000;
    public boolean stubNavigationBarContrastEnforced = true;
    public int stubBarCalls;
    public void setNavigationBarColor(int color) { stubNavigationBarColor = color; stubBarCalls++; }
    /** API 29. */
    public void setNavigationBarContrastEnforced(boolean enforce) { stubNavigationBarContrastEnforced = enforce; stubBarCalls++; }
    public void setFlags(int flags, int mask) { stubFlags = (stubFlags & ~mask) | (flags & mask); }
}
