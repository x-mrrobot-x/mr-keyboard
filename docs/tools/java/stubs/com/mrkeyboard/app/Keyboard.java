package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Compile and PC test stub (the real class is the Keyboard smali). */
public class Keyboard {
    public static class Key {
        public int[] codes;
        public int x, y, width, height;

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

    public List<Key> getKeys() { return keys; }

    /** Test: all the keys (the real one returns those near the point, in a grid). */
    public int[] getNearestKeys(int x, int y) {
        int[] all = new int[keys.size()];
        for (int i = 0; i < all.length; i++) all[i] = i;
        return all;
    }
}
