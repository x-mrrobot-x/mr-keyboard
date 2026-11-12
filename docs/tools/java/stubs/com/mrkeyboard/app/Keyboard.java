package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Compile and PC test stub (the real class is the Keyboard smali). */
public class Keyboard {
    public static final int SHIFT_OFF = 0;
    public static final int SHIFT_ON = 1;
    public static final int SHIFT_LOCKED = 2;
    public static final int SHIFT_CAPS = 3;
    public static final int SHIFT_CAPS_LOCKED = 4;
    public static final int EDGE_LEFT = 1;
    public static final int EDGE_RIGHT = 2;
    public static final int EDGE_TOP = 4;
    public static final int EDGE_BOTTOM = 8;

    public static class Key {
        public int[] codes;
        public int x, y, width, height;
        /** Text the key writes instead of a single character (null on a plain key). */
        public CharSequence text;
        /** A sticky key (Ctrl, Alt...) that is switched on. */
        public boolean on;
        /** Keyboard.EDGE_*: on these sides the key reaches to the edge of the keyboard. */
        public int edgeFlags;

        public Key(int code, int x, int y, int width, int height) {
            this.codes = new int[] {code};
            this.x = x; this.y = y; this.width = width; this.height = height;
        }

        /** Like the real one: square of the distance from the key center to the point. */
        public int squaredDistanceFrom(int px, int py) {
            int dx = x + width / 2 - px, dy = y + height / 2 - py;
            return dx * dx + dy * dy;
        }
    }

    /** Tests only. */
    public final List<Key> keys = new ArrayList<Key>();
    /** Tests only: the size of the keyboard in pixels. */
    public int stubWidth, stubHeight;

    public List<Key> getKeys() { return keys; }

    public int getMinWidth() { return stubWidth; }

    public int getHeight() { return stubHeight; }

    /** Test: all the keys (the real one returns those near the point, in a grid). */
    public int[] getNearestKeys(int x, int y) {
        int[] all = new int[keys.size()];
        for (int i = 0; i < all.length; i++) all[i] = i;
        return all;
    }
}
