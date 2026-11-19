package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.View;

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
 * default heights (the keys keep their size) and the places of the code that call it.
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

        // ---- the places of the code
        String ime = read("smali/com/mrkeyboard/app/LatinIME.smali");
        int apply = index(ime, "Lcom/mrkeyboard/app/MrBottom;->apply(Landroid/view/View;)V");
        int insets = index(ime, "Lcom/mrkeyboard/app/ImeInsets;->apply(Landroid/view/View;)V");
        check("LatinIME.setInputView adds the space to the view", apply > 0);
        check("... before ImeInsets, which takes the padding it finds as its base and adds the bars of the system on top", apply > 0 && insets > apply);
        String kbd = read("smali/com/mrkeyboard/app/Keyboard.smali");
        check("the Keyboard takes the space out of the height of its rows (MrBottom.keysHeight)",
                kbd.contains("Lcom/mrkeyboard/app/MrBottom;->keysHeight(Landroid/content/Context;I)I"));
        int round = index(kbd, "mKeyboardHeight:I");
        check("... where it is made, before the height is kept", round > 0 && index(kbd, "MrBottom;->keysHeight") > 0 && index(kbd, "MrBottom;->keysHeight") < index(kbd, "iput p2, p0, Lcom/mrkeyboard/app/Keyboard;->mKeyboardHeight:I"));
        check("the doc says what is done and why", read("docs/bottom-space.md").contains("32 dp") && read("docs/bottom-space.md").contains("10 dp"));

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
