package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the KeyStyle smali). */
public final class KeyStyle {
    /** Colour filter each face had while it was drawn, in order: read by the PC tests. */
    public static final java.util.List<android.graphics.ColorFilter> stubDrawn =
            new java.util.ArrayList<android.graphics.ColorFilter>();

    public static void drawKey(android.graphics.drawable.Drawable d, android.graphics.Canvas c, int w, int h) {
        stubDrawn.add(d == null ? null : d.stubFilter);
    }
}
