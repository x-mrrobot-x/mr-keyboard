package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the KeyStyle smali). */
public final class KeyStyle {
    /** Colour filter each face had while it was drawn, in order: read by the PC tests. */
    public static final java.util.List<android.graphics.ColorFilter> stubDrawn =
            new java.util.ArrayList<android.graphics.ColorFilter>();

    /** Faces prepared, with the size they were prepared for ("w x h"): read by the PC tests. */
    public static final java.util.List<String> stubPrepared = new java.util.ArrayList<String>();

    public static void prepare(android.graphics.drawable.Drawable d, int w, int h, android.content.Context c) {
        stubPrepared.add(w + "x" + h);
    }

    public static void drawKey(android.graphics.drawable.Drawable d, android.graphics.Canvas c, int w, int h) {
        stubDrawn.add(d == null ? null : d.stubFilter);
    }
}
