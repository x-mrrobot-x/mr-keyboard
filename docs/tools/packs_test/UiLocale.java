package com.mrkeyboard.app;

/** Replaces the APK class in the test (the real one uses APIs the PC does not have). */
public final class UiLocale {
    public static android.content.Context wrap(android.content.Context c) { return c; }
}
