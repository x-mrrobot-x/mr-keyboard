package com.mrkeyboard.app;

import android.app.Dialog;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.view.Window;
import android.view.WindowInsetsController;

/**
 * Light keyboard themes (MrLight): which text colours make a theme light, the dark outline that a dark label or
 * icon does not get, and the colour of the system buttons under the keyboard (only from Android 15 on, dark on a
 * light theme, light again on a dark one, and never an exception out of it).
 */
public class LightTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** Remembers what was asked of it, like the real one remembers its appearance. */
    static class Bars implements WindowInsetsController {
        int appearance = WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS;   // something else already set
        int calls;
        public void setSystemBarsAppearance(int value, int mask) {
            calls++;
            appearance = (appearance & ~mask) | (value & mask);
        }
        boolean darkButtons() { return (appearance & WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS) != 0; }
    }

    static class Win extends Window {
        final WindowInsetsController bars;
        Win(WindowInsetsController bars) { this.bars = bars; }
        public WindowInsetsController getInsetsController() { return bars; }
    }

    static class Box extends Dialog {
        final Window window;
        Box(Window window) { super(null, 0); this.window = window; }
        public Window getWindow() { return window; }
    }

    static class Ime extends InputMethodService {
        final Dialog dialog;
        Ime(Dialog dialog) { this.dialog = dialog; }
        public Dialog getWindow() { return dialog; }
    }

    static class BrokenIme extends InputMethodService {
        public Dialog getWindow() { throw new IllegalStateException("window not ready"); }
    }

    static final int WHITE = 0xffffffff, MIDNIGHT_TEXT = 0xffe7eef7, NEON_TEXT = 0xffb8f8d9, CREAM = 0xffebdbb2;
    static final int INK = 0xff1f2329, BROWN = 0xff33312b, WINE = 0xff4a2030, BLACK = 0xff000000;

    public static void main(String[] a) {
        // ---- which themes are light
        check("white, the Midnight text, a neon text and a cream text are dark themes",
                !MrLight.is(WHITE) && !MrLight.is(MIDNIGHT_TEXT) && !MrLight.is(NEON_TEXT) && !MrLight.is(CREAM));
        check("black, ink, brown and wine texts are light themes",
                MrLight.is(BLACK) && MrLight.is(INK) && MrLight.is(BROWN) && MrLight.is(WINE));
        check("the limit is a brightness of 0.5: #7f7f7f is light, #808080 is dark (as in MrTools.deriveColors)",
                MrLight.is(0xff7f7f7f) && !MrLight.is(0xff808080));
        check("brightness is the strongest channel: a saturated dark red is light, a saturated mid blue is dark",
                MrLight.is(0xff7f0000) && !MrLight.is(0xff0000c0));
        check("the opacity of the colour does not count", MrLight.is(0x001f2329) && !MrLight.is(0x00ffffff));

        // ---- outline of labels and icons
        check("a light label keeps the outline radius of its theme", MrLight.shadowRadius(MIDNIGHT_TEXT, 2.75f) == 2.75f);
        check("a dark label has none", MrLight.shadowRadius(INK, 2.75f) == 0f);
        check("a radius of 0 stays 0 on both", MrLight.shadowRadius(WHITE, 0f) == 0f && MrLight.shadowRadius(INK, 0f) == 0f);

        // ---- system buttons under the keyboard
        Bars bars = new Bars();
        Ime ime = new Ime(new Box(new Win(bars)));
        Build.VERSION.SDK_INT = 34;
        MrLight.bars(ime, INK);
        check("Android 14: nothing is asked (the system paints its own dark bar there)", bars.calls == 0 && !bars.darkButtons());
        Build.VERSION.SDK_INT = 35;
        MrLight.bars(ime, INK);
        check("Android 15, light theme: dark buttons", bars.calls == 1 && bars.darkButtons());
        check("the rest of the appearance is left alone",
                (bars.appearance & WindowInsetsController.APPEARANCE_LIGHT_STATUS_BARS) != 0);
        MrLight.bars(ime, MIDNIGHT_TEXT);
        check("back to a dark theme: light buttons again", bars.calls == 2 && !bars.darkButtons());
        Build.VERSION.SDK_INT = 37;
        MrLight.bars(ime, BROWN);
        check("Android 17, light theme: dark buttons", bars.darkButtons());

        // ---- nothing to hold on to: no exception
        MrLight.bars(null, INK);
        MrLight.bars(new Ime(null), INK);
        MrLight.bars(new Ime(new Box(null)), INK);
        MrLight.bars(new Ime(new Box(new Win(null))), INK);
        MrLight.bars(new BrokenIme(), INK);
        check("no service, no window, no controller or a window that is not ready: nothing happens", true);

        System.out.println(ok + " ok, " + fail + " failures");
        if (fail > 0) System.exit(1);
    }
}
