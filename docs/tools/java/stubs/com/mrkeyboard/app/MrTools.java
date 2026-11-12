package com.mrkeyboard.app;

/** Compile stub (APK class, hand-written smali): dependencies used by the AI Editor and the font tool. */
public class MrTools {
    public static LatinIME sIme;
    public static android.content.Context sApp;
    /** The keyboard view (MrFonts redraws its keys). */
    public static android.view.View sKbd;
    /** The main row of the tool bar: the tools or, in their place, the suggestion strip (MrSugg). Visible while the bar is in view. */
    static android.view.View sBarMain;

    public static void toast(String msg) { }

    public static void showPanel(int mode) { }

    public static android.widget.TextView btn(android.view.View parent, String tag, int code) { return null; }

    public static void shotTab(android.widget.TextView t, boolean on) { }

    public static android.graphics.drawable.Drawable flatBg() { return null; }

    public static float radius(float f) { return 0f; }

    /** The accent colour of the theme in use, without alpha (0 before a keyboard view was made). */
    static int accent() { return stubAccent; }
    /** Tests only. */
    public static int stubAccent;
}
