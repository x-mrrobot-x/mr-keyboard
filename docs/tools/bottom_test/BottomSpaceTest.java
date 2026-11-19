package com.mrkeyboard.app;

import android.app.Dialog;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.Window;
import android.view.WindowInsetsController;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * MrBottom (2.0.0): the space under the last row of keys, by the way of navigating (home gesture or buttons). Checks the choice of the space
 * from the settings (navigation_mode, the resource, the settings of Samsung and Xiaomi), the pixels by the density, the height that is left
 * to the rows of keys (the space is part of the height of the keyboard: the keys give way by the same amount), the padding of the view that
 * holds the toolbar and the keys (once, and again when the way of navigating changes), what happens when Android answers with an error, the new
 * default heights (the keys keep their size), the navigation bar that shows the background of the theme (its colour from Android 11 to 14,
 * transparent and without the veil of the three buttons from Android 15 on, and the colour of its buttons) and the places of the code that call it.
 */
public class BottomSpaceTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** A context with a density, that answers with an error when it is asked for its resources if `broken`. */
    static class Ctx extends Context {
        float density = 3f;
        boolean broken;
        public Resources getResources() {
            if (broken) throw new IllegalStateException("no resources");
            return new Resources() {
                public DisplayMetrics getDisplayMetrics() { DisplayMetrics m = new DisplayMetrics(); m.density = density; return m; }
            };
        }
        public android.content.res.AssetManager getAssets() { return null; }
        public String getPackageName() { return "app"; }
        public Context getApplicationContext() { return this; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String n, int m) { return null; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }
    }

    /** The window of the keyboard: remembers what it was asked (the stub of Window keeps the colour of the bar and its veil). */
    static class Ime extends InputMethodService {
        final Window window;
        final boolean noDialog;
        Ime(Window window, boolean noDialog) { this.window = window; this.noDialog = noDialog; }
        public Dialog getWindow() {
            if (noDialog) return null;
            return new Dialog(null, 0) { public Window getWindow() { return window; } };
        }
    }

    /** Remembers the appearance of the bars like the real controller does (what MrLight.bars asks for). */
    static class Bars implements WindowInsetsController {
        int appearance;
        int calls;
        public void setSystemBarsAppearance(int value, int mask) { calls++; appearance = (appearance & ~mask) | (value & mask); }
        boolean darkButtons() { return (appearance & WindowInsetsController.APPEARANCE_LIGHT_NAVIGATION_BARS) != 0; }
    }

    static class Win extends Window {
        final WindowInsetsController bars;
        Win(WindowInsetsController bars) { this.bars = bars; }
        public WindowInsetsController getInsetsController() { return bars; }
    }

    static class BrokenIme extends InputMethodService {
        public Dialog getWindow() { throw new IllegalStateException("window not ready"); }
    }

    static void settings(String navigationMode, String samsung, String xiaomi) {
        Settings.Secure.stubValues.clear();
        Settings.Global.stubValues.clear();
        if (navigationMode != null) Settings.Secure.stubValues.put("navigation_mode", navigationMode);
        if (samsung != null) Settings.Global.stubValues.put("navigation_bar_gesture_while_hidden", samsung);
        if (xiaomi != null) Settings.Global.stubValues.put("force_fsg_nav_bar", xiaomi);
    }

    static String read(String path) throws Exception {
        return new String(Files.readAllBytes(Paths.get(path)), StandardCharsets.UTF_8);
    }

    static int index(String text, String what) { return text.indexOf(what); }

    public static void main(String[] args) throws Exception {
        // ---- the way of navigating, from the values of the settings
        check("navigation_mode 2 is the home gesture", MrBottom.gesturesFrom(2, -1, -1, -1));
        check("navigation_mode 0 (three buttons) and 1 (two buttons) are not", !MrBottom.gesturesFrom(0, -1, -1, -1) && !MrBottom.gesturesFrom(1, -1, -1, -1));
        check("with no navigation_mode the resource config_navBarInteractionMode decides (2 gesture, 0 buttons)",
                MrBottom.gesturesFrom(-1, 2, -1, -1) && !MrBottom.gesturesFrom(-1, 0, -1, -1));
        check("nothing found: not the home gesture (the smaller space)", !MrBottom.gesturesFrom(-1, -1, -1, -1));
        check("the full-screen gestures of Samsung and of Xiaomi count even when navigation_mode says buttons",
                MrBottom.gesturesFrom(0, -1, 1, -1) && MrBottom.gesturesFrom(0, -1, -1, 1));
        check("a Samsung or Xiaomi setting that is 0 changes nothing", MrBottom.gesturesFrom(2, -1, 0, 0) && !MrBottom.gesturesFrom(0, -1, 0, 0));

        // ---- the space
        check("the space with the gesture is 10 dp and with the buttons 4 dp (the gesture bar is 24 dp and its area 32 dp; Gboard leaves about 10)",
                MrBottom.gapDp(true) == 10f && MrBottom.gapDp(false) == 4f);
        check("the home gesture leaves more room than the buttons", MrBottom.gapDp(true) > MrBottom.gapDp(false));
        Ctx c = new Ctx();
        settings("2", null, null);
        check("gesture, density 3: 30 px", MrBottom.gapPx(c) == 30);
        settings("0", null, null);
        check("buttons, density 3: 12 px", MrBottom.gapPx(c) == 12);
        c.density = 2.625f;
        settings("2", null, null);
        check("gesture, density 2.625 (a Pixel): 26 px", MrBottom.gapPx(c) == 26);
        settings("1", null, null);
        check("two buttons, density 2.625: 11 px", MrBottom.gapPx(c) == 11);
        settings("0", "1", null);
        check("buttons on navigation_mode but the gestures of Samsung on: 26 px", MrBottom.gapPx(c) == 26);
        settings(null, null, null);
        check("no setting at all: the space of the buttons, 11 px", MrBottom.gapPx(c) == 11);
        Resources.stubSystem = new Resources() {
            public int getIdentifier(String name, String type, String pkg) { return "config_navBarInteractionMode".equals(name) && "integer".equals(type) && "android".equals(pkg) ? 7 : 0; }
            public int getInteger(int id) { return id == 7 ? 2 : 0; }
        };
        check("no navigation_mode but the resource of the system says gestures: 26 px", MrBottom.gapPx(c) == 26);
        Resources.stubSystem = new Resources();
        check("the resource not found: the space of the buttons again", MrBottom.gapPx(c) == 11);

        // ---- the height that is left to the keys
        check("the rows of keys are the share of the screen less the space: 816 - 26 = 790", MrBottom.keysHeight(816, 26) == 790);
        check("no space: the same height", MrBottom.keysHeight(816, 0) == 816 && MrBottom.keysHeight(816, -3) == 816);
        check("never less than half of the share: 40 less 100 is 20", MrBottom.keysHeight(40, 100) == 20);
        check("a share that is zero or negative is left alone", MrBottom.keysHeight(0, 26) == 0 && MrBottom.keysHeight(-5, 26) == -5);
        settings("2", null, null);
        check("by the context, with the gesture: 816 - 26 = 790", MrBottom.keysHeight(c, 816) == 790);
        settings("0", null, null);
        check("by the context, with the buttons: 816 - 11 = 805", MrBottom.keysHeight(c, 816) == 805);

        // ---- Android answers with an error: nothing changes
        Ctx broken = new Ctx();
        broken.broken = true;
        check("a context that fails: no space, the keys keep their height", MrBottom.gapPx(broken) == 0 && MrBottom.keysHeight(broken, 816) == 816);

        // ---- the padding of the view that holds the toolbar and the keys
        c.density = 3f;
        settings("2", null, null);
        View root = new View(c);
        root.setPadding(2, 3, 4, 5);
        MrBottom.apply(root);
        check("the space goes under the last row: bottom 5 + 30 = 35, the other sides as they were",
                root.getPaddingBottom() == 35 && root.getPaddingLeft() == 2 && root.getPaddingTop() == 3 && root.getPaddingRight() == 4);
        MrBottom.apply(root);
        check("asked again for the same view it is not added twice", root.getPaddingBottom() == 35);
        settings("0", null, null);
        MrBottom.apply(root);
        check("the person changed to the buttons: the space is 12 px now, over the same 5 (17)", root.getPaddingBottom() == 17);
        settings("2", null, null);
        View other = new View(c);
        MrBottom.apply(other);
        check("a view with no padding gets just the space (30)", other.getPaddingBottom() == 30);
        // ImeInsets (Android 15) takes the padding that the view has when it is called as its base: the space has to be there first
        check("a keyboard view itself is not padded (the touches of its keys would move)", paddedKeyboard(c) == 0);
        MrBottom.apply(null);
        check("null is left alone", true);
        View broke = new View(broken);
        MrBottom.apply(broke);
        check("a view of a context that fails keeps its padding", broke.getPaddingBottom() == 0);

        // ---- the default heights: the keys keep their size
        String strings = read("res/values/strings.xml");
        int portrait = percent(strings, "default_height_portrait");
        int landscape = percent(strings, "default_height_landscape");
        check("default height: 35% in portrait and 62% in landscape (34% and 60% before the space was part of the height)", portrait == 35 && landscape == 62);
        // a phone of 1080 x 2400 px at 2.625: the keys had 34% / 60% of the height of the screen; now (35% / 62%) less the space of the gesture (26 px)
        check("portrait: the rows of keys keep their height, 816 px before and 814 px now (within 1%)", within(0.34 * 2400, MrBottom.keysHeight((int) Math.round(portrait / 100.0 * 2400), 26), 0.01));
        check("landscape: 648 px before and 644 px now (within 1%)", within(0.60 * 1080, MrBottom.keysHeight((int) Math.round(landscape / 100.0 * 1080), 26), 0.01));
        // the limits of the setting in prefs.xml are not changed
        String prefs = read("res/xml/prefs.xml");
        check("the setting still goes from 15% to 75% in steps of 1", prefs.contains("settings_height_portrait") && prefs.contains("hk:maxValue=\"75.0\"") && prefs.contains("hk:minValue=\"15.0\""));

        // ---- the navigation bar under the keyboard: the background of the theme shows through it
        final int NIGHT_BG = 0xff171e27, NIGHT_TEXT = 0xffe7eef7, DAY_BG = 0xffe7eaef, DAY_TEXT = 0xff1f2329, GLASS_BG = 0x8007101d;
        MrTheme.stubColors.put("bars_ink", 0);          // a theme without that role: the real MrTheme answers 0 for it
        MrTheme.stubColors.put("kbd_bg", NIGHT_BG);
        MrTools.sTextColor = NIGHT_TEXT;
        Bars bars = new Bars();
        Win win = new Win(bars);
        Ime ime0 = new Ime(win, false);
        Build.VERSION.SDK_INT = 29;
        MrBottom.bar(ime0);
        check("Android 10: nothing is asked (only the system paints that bar)", win.stubBarCalls == 0 && win.stubNavigationBarColor == 0xff000000 && win.stubNavigationBarContrastEnforced && bars.calls == 0);
        Build.VERSION.SDK_INT = 33;
        MrBottom.bar(ime0);
        check("Android 13: the bar has the color of the keyboard background (the system would paint it black)", win.stubNavigationBarColor == NIGHT_BG);
        check("... without the veil of the system", !win.stubNavigationBarContrastEnforced);
        check("... and the buttons on it are light on a dark theme", bars.calls == 1 && !bars.darkButtons());
        MrTheme.stubColors.put("kbd_bg", DAY_BG);
        MrTools.sTextColor = DAY_TEXT;
        MrBottom.bar(ime0);
        check("a light theme: the bar takes its background and the buttons are dark", win.stubNavigationBarColor == DAY_BG && bars.darkButtons());
        MrTheme.stubColors.put("kbd_bg", NIGHT_BG);
        MrTools.sTextColor = NIGHT_TEXT;
        Build.VERSION.SDK_INT = 30;
        MrBottom.bar(ime0);
        check("Android 11 (the first with the controller of the buttons): the same, and a new theme is followed when it is asked again", win.stubNavigationBarColor == NIGHT_BG && !bars.darkButtons());
        Build.VERSION.SDK_INT = 34;
        MrTheme.stubColors.put("kbd_bg", GLASS_BG);
        MrBottom.bar(ime0);
        check("Android 14: a see-through theme (Glass) gets a see-through bar, its opacity is kept", win.stubNavigationBarColor == GLASS_BG);
        MrTheme.stubColors.remove("kbd_bg");
        win.stubNavigationBarColor = 0xff000000;
        win.stubNavigationBarContrastEnforced = true;
        int calls = bars.calls;
        MrBottom.bar(ime0);
        check("a theme that has no keyboard background yet (the role answers magenta): nothing is asked", win.stubNavigationBarColor == 0xff000000 && win.stubNavigationBarContrastEnforced && bars.calls == calls);
        MrTheme.stubColors.put("kbd_bg", NIGHT_BG);
        Build.VERSION.SDK_INT = 35;
        MrBottom.bar(ime0);
        check("Android 15: the keyboard is drawn under the bar, so the bar is transparent", win.stubNavigationBarColor == 0);
        check("... and without the veil of the three buttons", !win.stubNavigationBarContrastEnforced);
        check("... and the buttons follow the theme as before", !bars.darkButtons());
        win.stubNavigationBarColor = 0xff000000;
        win.stubNavigationBarContrastEnforced = true;
        Build.VERSION.SDK_INT = 37;
        MrTheme.stubColors.remove("kbd_bg");
        MrBottom.bar(ime0);
        check("Android 17: the same, again when it is asked again (a window that was made again has the defaults), whatever the role says", win.stubNavigationBarColor == 0 && !win.stubNavigationBarContrastEnforced);
        MrTheme.stubColors.put("kbd_bg", NIGHT_BG);
        MrBottom.bar(null);
        MrBottom.bar(new Ime(null, false));
        MrBottom.bar(new Ime(null, true));
        MrBottom.bar(new Ime(new Win(null), false));
        MrBottom.bar(new BrokenIme());
        check("no service, no dialog, no window, no controller or a window that is not ready: nothing happens, no exception", true);
        Build.VERSION.SDK_INT = 35;

        // ---- the places of the code
        String ime = read("smali/com/mrkeyboard/app/LatinIME.smali");
        int apply = index(ime, "Lcom/mrkeyboard/app/MrBottom;->apply(Landroid/view/View;)V");
        int insets = index(ime, "Lcom/mrkeyboard/app/ImeInsets;->apply(Landroid/view/View;)V");
        check("LatinIME.setInputView adds the space to the view", apply > 0);
        check("... before ImeInsets, which takes the padding it finds as its base and adds the bars of the system on top", apply > 0 && insets > apply);
        int setView = index(ime, ".method public setInputView(Landroid/view/View;)V");
        String viewBody = setView > 0 ? ime.substring(setView, ime.indexOf(".end method", setView)) : "";
        int bar = index(viewBody, "Lcom/mrkeyboard/app/MrBottom;->bar(Landroid/inputmethodservice/InputMethodService;)V");
        check("LatinIME.setInputView asks for the bar of the theme, for every Android (the call decides by itself), after the Android 15 block",
                bar > 0 && bar > index(viewBody, "ImeInsets;->apply") && bar > viewBody.lastIndexOf(":cond_1")
                && bar < index(viewBody, "invoke-super {p0, p1}, Landroid/inputmethodservice/InputMethodService;->setInputView(Landroid/view/View;)V"));
        check("... and MrBottom.bar sets the colour of the buttons itself (setInputView no longer calls MrLight.bars)", !viewBody.contains("MrLight;->bars"));
        int shown = index(ime, ".method public onWindowShown()V");
        int shownEnd = ime.indexOf(".end method", shown);
        String shownBody = shown > 0 ? ime.substring(shown, shownEnd) : "";
        check("... and again in onWindowShown, after the call of the system", shownBody.contains("MrBottom;->bar(Landroid/inputmethodservice/InputMethodService;)V") && shownBody.indexOf("MrBottom;->bar") > shownBody.indexOf("InputMethodService;->onWindowShown()V"));
        String kbd = read("smali/com/mrkeyboard/app/Keyboard.smali");
        check("the Keyboard takes the space out of the height of its rows (MrBottom.keysHeight)",
                kbd.contains("Lcom/mrkeyboard/app/MrBottom;->keysHeight(Landroid/content/Context;I)I"));
        int round = index(kbd, "mKeyboardHeight:I");
        check("... where it is made, before the height is kept", round > 0 && index(kbd, "MrBottom;->keysHeight") > 0 && index(kbd, "MrBottom;->keysHeight") < index(kbd, "iput p2, p0, Lcom/mrkeyboard/app/Keyboard;->mKeyboardHeight:I"));
        check("the doc says what is done and why", read("docs/bottom-space.md").contains("32 dp") && read("docs/bottom-space.md").contains("10 dp"));
        check("the doc says what the navigation bar does", read("docs/bottom-space.md").contains("transparent") && read("docs/bottom-space.md").contains("contrast"));

        System.out.println();
        System.out.println(ok + " ok, " + fail + " fail");
        System.exit(fail == 0 ? 0 : 1);
    }

    static int paddedKeyboard(Context c) {
        LatinKeyboardBaseView k = new LatinKeyboardBaseView(c);
        MrBottom.apply(k);
        return k.getPaddingBottom();
    }

    static int percent(String strings, String name) {
        Matcher m = Pattern.compile("name=\"" + name + "\">(\\d+)%<").matcher(strings);
        return m.find() ? Integer.parseInt(m.group(1)) : -1;
    }

    static boolean within(double expected, int actual, double share) {
        return Math.abs(actual - expected) <= expected * share;
    }
}
