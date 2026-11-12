package android.view;

/** Compile stub (Android 11, API 30). */
public interface WindowInsetsController {
    int APPEARANCE_LIGHT_STATUS_BARS = 8;
    int APPEARANCE_LIGHT_NAVIGATION_BARS = 16;

    void setSystemBarsAppearance(int appearance, int mask);
}
