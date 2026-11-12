package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the ShadowDrawHelper smali). */
final class ShadowDrawHelper {
    /** Radius and colour filter of the last call: read by the PC tests. */
    static float stubRadius;
    static android.graphics.ColorFilter stubFilter;

    static void draw(android.graphics.Canvas c, android.graphics.drawable.Drawable d, Keyboard.Key k, float radius,
            android.graphics.ColorFilter filter) {
        stubRadius = radius;
        stubFilter = filter;
    }
}
