package com.mrkeyboard.app;

/** Compile stub (APK class, hand-written smali): dependencies used by the AI Editor and the font tool. */
public class MrTools {
    public static LatinIME sIme;
    public static android.content.Context sApp;
    /** The keyboard view (MrFonts redraws its keys). */
    public static android.view.View sKbd;
    /** The main row of the tool bar: the tools or, in their place, the suggestion strip (MrSugg). Visible while the bar is in view. */
    static android.view.View sBarMain;

    /** The field the keys that are events go to while the keyboard types in a field of the bar (translator, emoji search); the redirect itself. */
    static android.widget.TextView sField;
    static android.view.inputmethod.InputConnection sRedirect;
    /** Colors of the text and of the hint of the tool bars (set when a keyboard view is made). */
    static int sTextColor;
    static int sKeyText;
    static int sHint;

    public static void toast(String msg) { }

    /** Tints the compound drawables of the view. */
    static void tintColor(android.widget.TextView t, int color) { }
    /** Backgrounds of the theme: the card of a panel. */
    static android.graphics.drawable.Drawable cardBg() { return null; }

    public static void showPanel(int mode) { }

    public static android.widget.TextView btn(android.view.View parent, String tag, int code) { return null; }

    public static void shotTab(android.widget.TextView t, boolean on) { }

    public static android.graphics.drawable.Drawable flatBg() { return null; }

    public static float radius(float f) { return 0f; }

    /** Like flatBg(), with fully round corners (the buttons inside the floating bar). */
    public static android.graphics.drawable.Drawable flatPill() { return null; }

    /** Background of the floating bar of the emoji panel: opaque, neutral colour of the theme, fully round. */
    static android.graphics.drawable.Drawable floatBg() { return null; }

    /** The accent colour of the theme in use, without alpha (0 before a keyboard view was made). */
    static int accent() { return stubAccent; }
    /** Tests only. */
    public static int stubAccent;
}
