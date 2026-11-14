package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the ShadowDrawHelper smali). */
final class ShadowDrawHelper {
    /** Radius and colour filter of the last call: read by the PC tests. */
    static float stubRadius;
    static android.graphics.ColorFilter stubFilter;
    /** Tests only: the places filled and the bytes held, and how many times release ran. */
    static int stubKept;
    static int stubBytes;
    static int stubReleases;

    /** Bytes the kept shadows hold. */
    static int heldBytes() {
        return stubBytes;
    }

    /** Lets go of every kept shadow (onTrimMemory); how many places were filled. */
    static int release() {
        stubReleases++;
        int n = stubKept;
        stubKept = 0;
        stubBytes = 0;
        return n;
    }

    static void draw(android.graphics.Canvas c, android.graphics.drawable.Drawable d, Keyboard.Key k, float radius,
            android.graphics.ColorFilter filter) {
        stubRadius = radius;
        stubFilter = filter;
    }
}
