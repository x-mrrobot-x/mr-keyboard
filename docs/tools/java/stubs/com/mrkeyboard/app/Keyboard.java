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
        /** Label, icon, gap before the key, a key of the system (Shift, delete...), long-press popup (characters and template, or keys). */
        public CharSequence label;
        public android.graphics.drawable.Drawable icon;
        public int gap;
        public boolean modifier;
        public CharSequence popupCharacters;
        public int popupResId;
        public java.util.List popupKeys;
        public CharSequence shiftLabel;

        /** The popup opens to the left (the key is on the right half). */
        public boolean popupReversed;

        /** Added to the real class in the smali (MrAbcKeys): the capital of Shift for a key that changed. Tests only: what it got. */
        public void mrSetCase(CharSequence shift) { shiftLabel = shift; stubCaseSet = true; }
        public boolean stubCaseSet;

        /** Like the real one: x, width and gap as given (rounded), y moved by half the vertical gap and the height without it. */
        public void setCustomBounds(float x, float width, float gap, float verticalGap, int y, int rowHeight) {
            this.x = Math.round(x);
            this.width = Math.round(width);
            this.gap = Math.round(gap);
            this.y = (int) (y + verticalGap / 2f);
            this.height = Math.round(rowHeight - verticalGap);
        }

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

    /** A row of keys (the defaults of its keys). */
    public static class Row {
        public float defaultWidth;
        public int defaultHeight;
        public float defaultHorizontalGap;
        public int verticalGap;
        public int mode;
        public boolean extension;
        public Row(Keyboard parent) { }
    }

    /** Rows of the keyboard and rows of the layout (the bottom one included). */
    public int mRowCount, mLayoutRows;

    public Keyboard() { }

    /** Height of a row of the XML. */
    public int getDefaultHeightPx() { return stubDefaultHeight; }
    public int stubDefaultHeight;

    /** The real one sets the size, finds Shift, Ctrl, Alt and the keys of the system again and the edges. Tests only: what it got. */
    public void finishCustomBuild(int totalWidth, int totalHeight, int defaultHeight, int rowCount, int layoutRows) {
        stubFinished = new int[] {totalWidth, totalHeight, defaultHeight, rowCount, layoutRows};
        mRowCount = rowCount;
    }
    public int[] stubFinished;

    /** The real one reads the XML (default height, xml, mode, height in percent); here no key. */
    public Keyboard(android.content.Context context, int defaultHeight, int xmlLayoutResId, int modeId, float kbHeightPercent) { }

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
