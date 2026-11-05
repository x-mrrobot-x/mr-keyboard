package android.view;

import android.graphics.Insets;

/**
 * Compile stub (Android 11, API 30): keeps the insets by type with the same rules as the real class (getInsets takes the
 * largest value of each side among the types of the mask; inset() takes the margins off every type and never goes below
 * zero), so that the PC tests can check what the screens do with them.
 */
public final class WindowInsets {
    public static final class Type {
        public static final int STATUS_BARS = 1;
        public static final int NAVIGATION_BARS = 1 << 1;
        public static final int CAPTION_BAR = 1 << 2;
        public static final int IME = 1 << 3;
        public static final int SYSTEM_GESTURES = 1 << 4;
        public static final int MANDATORY_SYSTEM_GESTURES = 1 << 5;
        public static final int TAPPABLE_ELEMENT = 1 << 6;
        public static final int DISPLAY_CUTOUT = 1 << 7;
        public static final int SIZE = 8;

        public static int statusBars() { return STATUS_BARS; }
        public static int navigationBars() { return NAVIGATION_BARS; }
        public static int captionBar() { return CAPTION_BAR; }
        public static int ime() { return IME; }
        public static int systemGestures() { return SYSTEM_GESTURES; }
        public static int mandatorySystemGestures() { return MANDATORY_SYSTEM_GESTURES; }
        public static int tappableElement() { return TAPPABLE_ELEMENT; }
        public static int displayCutout() { return DISPLAY_CUTOUT; }
        public static int systemBars() { return STATUS_BARS | NAVIGATION_BARS | CAPTION_BAR; }
    }

    private final Insets[] byType;
    private final int visible;

    private WindowInsets(Insets[] byType, int visible) {
        this.byType = byType;
        this.visible = visible;
    }

    public boolean isVisible(int typeMask) {
        return (visible & typeMask) == typeMask;
    }

    public Insets getInsets(int typeMask) {
        int l = 0, t = 0, r = 0, b = 0;
        for (int i = 0; i < Type.SIZE; i++) {
            if ((typeMask & (1 << i)) == 0) continue;
            Insets in = byType[i];
            l = Math.max(l, in.left);
            t = Math.max(t, in.top);
            r = Math.max(r, in.right);
            b = Math.max(b, in.bottom);
        }
        return Insets.of(l, t, r, b);
    }

    public WindowInsets inset(int left, int top, int right, int bottom) {
        Insets[] out = new Insets[Type.SIZE];
        for (int i = 0; i < Type.SIZE; i++) {
            Insets in = byType[i];
            out[i] = Insets.of(Math.max(0, in.left - left), Math.max(0, in.top - top),
                    Math.max(0, in.right - right), Math.max(0, in.bottom - bottom));
        }
        return new WindowInsets(out, visible);
    }

    public boolean isConsumed() {
        for (int i = 0; i < Type.SIZE; i++) {
            if (byType[i] != Insets.NONE) return false;
        }
        return true;
    }

    public static final class Builder {
        private final Insets[] byType = new Insets[Type.SIZE];
        private int visible;

        public Builder setVisible(int typeMask, boolean isVisible) {
            visible = isVisible ? (visible | typeMask) : (visible & ~typeMask);
            return this;
        }

        public Builder() {
            for (int i = 0; i < Type.SIZE; i++) byType[i] = Insets.NONE;
        }

        public Builder setInsets(int typeMask, Insets insets) {
            for (int i = 0; i < Type.SIZE; i++) {
                if ((typeMask & (1 << i)) != 0) byType[i] = insets;
            }
            return this;
        }

        public WindowInsets build() {
            return new WindowInsets(byType.clone(), visible);
        }
    }
}
