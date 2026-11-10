package com.mrkeyboard.app;

/**
 * Compile stub (APK class, hand-written smali): the texts that the old screens keep in Portuguese and switch to Spanish
 * through p(). The special-key catalog still uses it for its names and categories.
 */
public final class SheetStrings {
    private SheetStrings() { }

    /** True when the last isPt() call found Spanish (p() then swaps the text). */
    public static boolean sEs;

    public static boolean isPt(android.content.Context context) { return true; }

    public static String p(String pt) { return pt; }

    public static String tr(android.content.Context context, String pt, String en) { return pt; }

    public static String a(String pt) { return pt; }
}
