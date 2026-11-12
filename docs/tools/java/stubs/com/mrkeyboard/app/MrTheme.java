package com.mrkeyboard.app;

import java.util.HashMap;
import java.util.Map;

/** Compile and PC test stub (the real class is the MrTheme smali). */
public final class MrTheme {
    /** What the theme of the PC tests answers (the real ones come from mr_theme_flags and the colours). */
    public static boolean stubGlow, stubSpectrum;
    public static String stubTag;
    public static final Map<String, Integer> stubColors = new HashMap<String, Integer>();

    public static boolean flatBar() { return false; }
    public static boolean glow() { return stubGlow; }
    public static boolean spectrum() { return stubSpectrum; }
    public static String tag() { return stubTag; }
    public static int color(String role) {
        Integer c = stubColors.get(role);
        return c == null ? 0xffff00ff : c.intValue();
    }
}
