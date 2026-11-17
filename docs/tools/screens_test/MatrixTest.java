package com.mrkeyboard.app;

import android.app.Activity;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.os.Build;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.Window;
import android.view.WindowManager;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * The Matrix effect of the settings screens, run on the PC against the stubs of Android: MrRain (the drops: where they are, how they fade, that they
 * come back and never move together), MrRainDrawable (what it draws, the beats that it asks for and that stop when the window is hidden), MrMatrix
 * (which screens get it, the setting, a failure that leaves the screen alone) and MrScreens (the rain and the acceleration when the screen is
 * created, the screen that is created again when it comes back after the setting changed, never in a loop).
 */
public class MatrixTest {
    static int ok, fail;

    static void check(String what, boolean cond) {
        if (cond) {
            ok++;
            System.out.println("OK    " + what);
        } else {
            fail++;
            System.out.println("FAIL  " + what);
        }
    }

    static final int BG = 0xff060c17;
    static final int ACCENT = 0xff1b97fc;

    // ---------------------------------------------------------------- MrRain

    static int lit(MrRain r, int col) {
        int n = 0;
        for (int row = 0; row < r.rows(); row++) if (r.level(col, row) > 0f) n++;
        return n;
    }

    static void rain() {
        MrRain r = new MrRain(90, 7);
        r.resize(40, 60);
        check("the grid is the one asked", r.cols() == 40 && r.rows() == 60);
        boolean headOne = true, fades = true, outside = true, inGlyphs = true, range = true;
        for (int step = 0; step < 300; step++) {
            for (int c = 0; c < r.cols(); c++) {
                int first = r.first(c), last = r.last(c);
                float before = 2f;
                for (int row = 0; row < r.rows(); row++) {
                    float level = r.level(c, row);
                    if (row < first || row > last) {
                        if (level > 0f && !(row >= first && row <= last)) outside = false;
                    }
                    if (level > 0f) {
                        if (level > 1f) range = false;
                        if (level == 1f && row != last) headOne = false;
                        if (before <= 1f && level < before && before != 2f) { /* going down the column the level grows to the head */ }
                        int g = r.glyphAt(c, row);
                        if (g < 0 || g >= 90) inGlyphs = false;
                    }
                }
                // along the trail, towards the head, the level only grows
                float prev = -1f;
                for (int row = first; row <= last; row++) {
                    float level = r.level(c, row);
                    if (level > 0f) {
                        if (level < prev) fades = false;
                        prev = level;
                    }
                }
            }
            r.step();
        }
        check("a cell outside of the trail of its column has no level", outside);
        check("only the head is at full strength, nothing is above it", headOne && range);
        check("the trail fades away from the head: the level only grows from the top of the trail down to the head", fades);
        check("every glyph is an index of the set (300 beats, every cell that is lit)", inGlyphs);

        // the trails have the length asked
        MrRain t = new MrRain(10, 3);
        t.resize(30, 80);
        boolean lengths = true;
        for (int step = 0; step < 400; step++) {
            for (int c = 0; c < t.cols(); c++) {
                if (t.last(c) >= MrRain.TRAIL_MAX && t.last(c) < t.rows() - 1 && t.first(c) > 0) {   // the whole drop is on the grid (the head is not at the edge)
                    int n = lit(t, c);
                    if (n < MrRain.TRAIL_MIN + 1 || n > MrRain.TRAIL_MAX + 1) lengths = false;
                }
            }
            t.step();
        }
        check("a drop that is all on the grid is between " + (MrRain.TRAIL_MIN + 1) + " and " + (MrRain.TRAIL_MAX + 1) + " cells long (head included)", lengths);

        // drops come back
        MrRain b = new MrRain(10, 11);
        b.resize(5, 30);
        int[] comebacks = new int[5];
        boolean[] wasOff = new boolean[5];
        boolean[] reachedBottom = new boolean[5];
        for (int step = 0; step < 3000; step++) {
            for (int c = 0; c < 5; c++) {
                boolean empty = b.first(c) > b.last(c);
                if (b.last(c) == b.rows() - 1) reachedBottom[c] = true;
                if (reachedBottom[c] && empty) wasOff[c] = true;
                if (wasOff[c] && !empty) {
                    comebacks[c]++;
                    wasOff[c] = false;
                    reachedBottom[c] = false;
                }
            }
            b.step();
        }
        boolean every = true;
        for (int c = 0; c < 5; c++) if (comebacks[c] < 3) every = false;
        check("a drop that went off the bottom comes back (every column, at least three times in 3000 beats)", every);

        // they do not move together
        MrRain m = new MrRain(10, 5);
        m.resize(40, 60);
        for (int i = 0; i < 50; i++) m.step();
        java.util.HashSet<Integer> heads = new java.util.HashSet<Integer>();
        for (int c = 0; c < 40; c++) heads.add(m.last(c) * 1000 + m.first(c));
        check("the columns are not in step (many different positions after 50 beats)", heads.size() > 20);

        // the glyphs flicker
        MrRain g = new MrRain(90, 2);
        g.resize(10, 10);
        int[] first = new int[100];
        for (int c = 0; c < 10; c++) for (int row = 0; row < 10; row++) first[c * 10 + row] = g.glyphAt(c, row);
        for (int i = 0; i < 40; i++) g.step();
        int changed = 0;
        for (int c = 0; c < 10; c++) for (int row = 0; row < 10; row++) if (g.glyphAt(c, row) != first[c * 10 + row]) changed++;
        check("the glyphs change now and then (some cells have another one after 40 beats, not all)", changed > 5 && changed < 100);

        // the same seed gives the same rain, another seed another one
        MrRain a1 = new MrRain(90, 42), a2 = new MrRain(90, 42), a3 = new MrRain(90, 43);
        a1.resize(20, 40);
        a2.resize(20, 40);
        a3.resize(20, 40);
        boolean same = true, other = false;
        for (int i = 0; i < 100; i++) {
            a1.step();
            a2.step();
            a3.step();
            for (int c = 0; c < 20; c++) {
                if (a1.first(c) != a2.first(c) || a1.last(c) != a2.last(c) || a1.glyphAt(c, 0) != a2.glyphAt(c, 0)) same = false;
                if (a1.first(c) != a3.first(c) || a1.last(c) != a3.last(c)) other = true;
            }
        }
        check("the same seed makes the same rain (100 beats) and another seed another one", same && other);

        // the edges
        boolean edges = true;
        int[][] sizes = {{0, 0}, {1, 1}, {1, 0}, {0, 5}, {3, 2}, {200, 3}};
        for (int[] s : sizes) {
            try {
                MrRain e = new MrRain(1, 1);
                e.resize(s[0], s[1]);
                for (int i = 0; i < 60; i++) {
                    e.step();
                    for (int c = 0; c < e.cols(); c++) {
                        int f = e.first(c), l = e.last(c);
                        for (int row = Math.max(0, f); row <= l; row++) e.level(c, row);
                    }
                }
            } catch (RuntimeException ex) {
                edges = false;
            }
        }
        check("empty and tiny grids (0x0, 1x1, 1x0, 0x5, 3x2, 200x3) and a set of one glyph run without failing", edges);
        MrRain z = new MrRain(0, 1);
        z.resize(4, 4);
        boolean zero = true;
        for (int i = 0; i < 20; i++) z.step();
        for (int c = 0; c < 4; c++) for (int row = 0; row < 4; row++) if (z.glyphAt(c, row) != 0) zero = false;
        check("a set of no glyph is taken as one (index 0)", zero);
        MrRain again = new MrRain(10, 1);
        again.resize(8, 8);
        again.resize(20, 12);
        check("a new size makes a new grid", again.cols() == 20 && again.rows() == 12 && again.last(19) <= 11);
    }

    // ---------------------------------------------------------------- MrRainDrawable

    static int alphaOf(String glyphEntry) {
        String hex = glyphEntry.substring(glyphEntry.lastIndexOf('#') + 1);
        return (int) (Long.parseLong(hex, 16) >> 24) & 0xff;
    }

    static int rgbOf(String glyphEntry) {
        String hex = glyphEntry.substring(glyphEntry.lastIndexOf('#') + 1);
        return (int) (Long.parseLong(hex, 16) & 0xffffff);
    }

    static void drawable() {
        Paint.stubNoGlyph.clear();
        check("the colour helpers: alpha is put in the top byte, clamped, and the rgb is kept", MrRainDrawable.withAlpha(0xff1b97fc, 0.5f) == 0x801b97fc
                && MrRainDrawable.withAlpha(0x1b97fc, 2f) == 0xff1b97fc && MrRainDrawable.withAlpha(0x1b97fc, -1f) == 0x001b97fc);
        check("lighter(): 0 keeps the colour and 1 is white", MrRainDrawable.lighter(0xff1b97fc, 0f) == 0xff1b97fc && MrRainDrawable.lighter(0xff1b97fc, 1f) == 0xffffffff);
        int light = MrRainDrawable.lighter(ACCENT, MrRainDrawable.HEAD_LIGHT);
        check("the head is the accent moved towards white (lighter in every channel, the blue stays the strongest)",
                ((light >> 16) & 0xff) > 0x1b && ((light >> 8) & 0xff) > 0x97 && (light & 0xff) >= 0xfc && ((light >> 16) & 0xff) < 0xff);

        String[] all = MrRainDrawable.glyphs(new Paint(Paint.ANTI_ALIAS_FLAG));
        check("the font has everything: the base set and the half-width katakana (" + (MrRainDrawable.BASE.length() + MrRainDrawable.KANA.length()) + " glyphs)",
                all.length == MrRainDrawable.BASE.length() + MrRainDrawable.KANA.length() && all[0].equals("0") && all[all.length - 1].equals("ﾝ"));
        Paint.stubNoGlyph.add("ｱ");
        Paint.stubNoGlyph.add("ﾝ");
        String[] some = MrRainDrawable.glyphs(new Paint(Paint.ANTI_ALIAS_FLAG));
        boolean none = true;
        for (String g : some) if (g.equals("ｱ") || g.equals("ﾝ")) none = false;
        check("a katakana that the font lacks is left out (no box with a cross on the screen)", some.length == all.length - 2 && none);
        for (int i = 0; i < MrRainDrawable.KANA.length(); i++) Paint.stubNoGlyph.add(String.valueOf(MrRainDrawable.KANA.charAt(i)));
        String[] base = MrRainDrawable.glyphs(new Paint(Paint.ANTI_ALIAS_FLAG));
        check("a font with no katakana: the base set only (digits, capitals and signs)", base.length == MrRainDrawable.BASE.length());
        Paint.stubNoGlyph.clear();

        MrRainDrawable d = new MrRainDrawable(BG, ACCENT, 2f);
        d.setBounds(0, 0, 300, 600);
        Canvas c = new Canvas();
        d.draw(c);
        check("it paints the colour of the screens first", c.stubFill == BG);
        check("and then letters over it", c.stubGlyphs.size() > 30);
        boolean alphaOk = true, rgbOk = true, withinWindow = true;
        int maxAlpha = 0, minAlpha = 255;
        int headRgb = light & 0xffffff;
        for (String e : c.stubGlyphs) {
            int a = alphaOf(e), rgb = rgbOf(e);
            maxAlpha = Math.max(maxAlpha, a);
            minAlpha = Math.min(minAlpha, a);
            if (rgb != (ACCENT & 0xffffff) && rgb != headRgb) rgbOk = false;
            String pos = e.substring(e.indexOf('@') + 1, e.indexOf('#'));
            float x = Float.parseFloat(pos.split(",")[0]);
            if (x < 0 || x > 300) withinWindow = false;
        }
        int headA = Math.round(MrRainDrawable.HEAD_ALPHA * 255f);
        check("every letter is in the colour of the theme (or its lighter head), nothing else", rgbOk);
        check("the letters are faint so that the text of the screen stays readable: the strongest is the head (" + headA + "/255), the rest less, none invisible",
                maxAlpha == headA && minAlpha > 0 && minAlpha < Math.round(MrRainDrawable.TRAIL_ALPHA * 255f));
        check("the columns are inside the width of the window", withinWindow);
        // the grid follows the size: 300 px / (7 * 1.05) wide
        java.util.HashSet<String> columns = new java.util.HashSet<String>();
        for (String e : c.stubGlyphs) columns.add(e.substring(e.indexOf('@') + 1, e.indexOf('#')).split(",")[0]);
        check("the columns are the width of a glyph apart and fill the window (at most " + (int) Math.ceil(300 / (7 * 1.05f)) + ")", columns.size() <= (int) Math.ceil(300 / (7 * 1.05f)) && columns.size() > 20);

        // the beats
        check("the first draw asks for ONE beat", d.stubScheduled.size() == 1);
        d.draw(new Canvas());
        check("drawing again before the beat does not ask for another", d.stubScheduled.size() == 1);
        int inv = d.stubInvalidations;
        Runnable beat = d.stubScheduled.get(0);
        d.stubScheduled.clear();
        beat.run();
        check("the beat moves the rain and asks to be drawn", d.stubInvalidations == inv + 1 && d.stubScheduled.isEmpty());
        Canvas c2 = new Canvas();
        for (int i = 0; i < 5; i++) {
            d.draw(c2);
            Runnable next = d.stubScheduled.remove(0);
            next.run();
        }
        Canvas c3 = new Canvas();
        d.draw(c3);
        check("the rain has moved after a few beats", !c3.stubGlyphs.equals(c.stubGlyphs));
        check("each draw asks for the next beat again (the loop keeps itself going)", d.stubScheduled.size() == 1);

        // hidden: nothing is asked
        boolean changed = d.setVisible(false, false);
        check("the window hides its background: the beat that was asked for is taken back", changed && d.stubScheduled.isEmpty());
        d.draw(new Canvas());
        check("a hidden background still paints if it is asked to but asks for no beat (battery)", d.stubScheduled.isEmpty());
        int before = d.stubInvalidations;
        boolean shown = d.setVisible(true, false);
        check("shown again it asks to be drawn, and that draw starts the beats again", shown && d.stubInvalidations == before + 1);
        d.draw(new Canvas());
        check("... one beat", d.stubScheduled.size() == 1);
        check("setVisible with the same value changes nothing", !d.setVisible(true, false) && d.stubInvalidations == before + 1);

        // another size makes another grid
        MrRainDrawable r = new MrRainDrawable(BG, ACCENT, 2f);
        r.setBounds(0, 0, 100, 200);
        Canvas small = new Canvas();
        r.draw(small);
        java.util.HashSet<String> narrow = new java.util.HashSet<String>();
        for (String e : small.stubGlyphs) narrow.add(e.substring(e.indexOf('@') + 1, e.indexOf('#')).split(",")[0]);
        r.setBounds(0, 0, 400, 200);
        Canvas wide = new Canvas();
        r.draw(wide);
        java.util.HashSet<String> broad = new java.util.HashSet<String>();
        for (String e : wide.stubGlyphs) broad.add(e.substring(e.indexOf('@') + 1, e.indexOf('#')).split(",")[0]);
        check("turning the phone (another width) makes another grid: more columns", broad.size() > narrow.size() * 2);
        check("it is opaque (the whole window is painted) and ignores alpha and filters", r.getOpacity() == -1);
        r.setAlpha(10);
        r.setColorFilter(null);
        r.setBounds(0, 0, 0, 0);
        boolean empty = true;
        try { r.draw(new Canvas()); } catch (RuntimeException e) { empty = false; }
        check("a window of no size does not break the drawing", empty);
    }

    // ---------------------------------------------------------------- MrMatrix and MrScreens

    static class Prefs implements SharedPreferences {
        final HashMap<String, Object> map = new HashMap<String, Object>();
        boolean broken;
        public java.util.Map<String, ?> getAll() { return map; }
        public String getString(String key, String def) { return def; }
        public int getInt(String key, int def) { return def; }
        public long getLong(String key, long def) { return def; }
        public boolean getBoolean(String key, boolean def) {
            if (broken) throw new IllegalStateException("cannot read");
            Object v = map.get(key);
            return v == null ? def : ((Boolean) v).booleanValue();
        }
        public Editor edit() { return null; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
    }

    /** The colours of the app and a display of density 2. */
    static class Res extends Resources {
        public int getIdentifier(String name, String defType, String defPackage) {
            if (defType.equals("style")) return name.equals("MrMatrixGlass") ? GLASS_ID : name.equals("Theme.MrKeyboard.Dialog.Glass") ? DIALOG_GLASS_ID : 0;
            return name.equals("mr_ui_bg") ? 1 : name.equals("mr_accent") ? 2 : name.equals("mr_ui_card") ? 5 : name.equals("mr_ui_card_glass") ? 6
                    : name.equals("mr_ui_glass_top") ? 7 : name.equals("mr_ui_glass_bottom") ? 8 : name.equals("mr_ui_glass_edge") ? 9 : 0;
        }
        public int getColor(int id) { return id == 1 ? BG : id == 2 ? ACCENT : id == 5 ? CARD : id == 6 ? CARD_GLASS : id == 7 ? TOP : id == 8 ? BOTTOM : id == 9 ? EDGE : 0; }
        public DisplayMetrics getDisplayMetrics() {
            DisplayMetrics m = new DisplayMetrics();
            m.density = 2f;
            return m;
        }
    }

    static final int GLASS_ID = 3;
    static final int DIALOG_GLASS_ID = 4;
    static final int CARD = 0xff0d1626;
    static final int CARD_GLASS = 0xb3295082;
    static final int TOP = 0xbe345c8e;
    static final int BOTTOM = 0xad1e4476;
    static final int EDGE = 0x59a8d8ff;

    /** Resources that have the colours but not the see-through style. */
    static class ResNoGlass extends Res {
        public int getIdentifier(String name, String defType, String defPackage) { return name.equals("MrMatrixGlass") || name.equals("Theme.MrKeyboard.Dialog.Glass") ? 0 : super.getIdentifier(name, defType, defPackage); }
    }

    static class Settings extends PreferenceActivity {
        final Resources.Theme stubTheme = new Resources.Theme();
        public Resources.Theme getTheme() { return stubTheme; }
        public Resources getResources() { return new Res(); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
    }

    /** A settings screen whose resources cannot be read (the colours are missing). */
    static class Broken extends PreferenceActivity {
        public Resources getResources() { return new Resources(); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
    }

    static class Plain extends Activity {
        final Resources.Theme stubTheme = new Resources.Theme();
        public Resources.Theme getTheme() { return stubTheme; }
        public Resources getResources() { return new Res(); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
    }

    static class NoWindow extends PreferenceActivity {
        public Window getWindow() { return null; }
        public Resources getResources() { return new Res(); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
    }

    static final int HW = WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED;

    static Prefs prefs;

    static void matrix() {
        prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
        Build.VERSION.SDK_INT = 33;
        check("the key of the setting", MrMatrix.KEY.equals("pref_ui_matrix"));
        check("off by default: never changed, the setting is off", !MrMatrix.enabled(new Plain()));
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        check("on when it is on", MrMatrix.enabled(new Plain()));
        prefs.map.put("pref_ui_matrix", Boolean.FALSE);
        check("off when it is off", !MrMatrix.enabled(new Plain()));
        prefs.broken = true;
        check("preferences that cannot be read: off", !MrMatrix.enabled(new Plain()));
        prefs.broken = false;
        PreferenceManager.stubDefault = null;
        check("no preferences at all: off", !MrMatrix.enabled(new Plain()));
        PreferenceManager.stubDefault = prefs;

        check("the settings screens get it (a PreferenceActivity)", MrMatrix.eligible(new Settings()));
        check("the home screen gets it (Main)", MrMatrix.eligible(new com.mrkeyboard.app.Main()));
        check("the other screens do too (word screens, tour, AI style, Sheets and its editor: a plain Activity)", MrMatrix.eligible(new Plain()));
        check("a helper window does not, even if it is a PreferenceActivity", !MrMatrix.eligible(new ShotPerm()));
        check("... nor the other helper window (the picker)", !MrMatrix.eligible(new ShotPick()));
        check("no screen: no", !MrMatrix.eligible(null));

        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        Settings s = new Settings();
        check("attach puts the rain as the window background, with the colours and the density of the screen", MrMatrix.attach(s) && s.getWindow().stubBackground instanceof MrRainDrawable);
        check("... and lays the see-through style over the theme of the screen, forced (the layouts are inflated after it)", s.stubTheme.stubApplied.size() == 1 && s.stubTheme.stubApplied.get(0) == GLASS_ID);
        check("the name of the style", MrMatrix.GLASS.equals("MrMatrixGlass"));
        Settings noStyle = new Settings() { public Resources getResources() { return new ResNoGlass(); } };
        check("a build without the style: the rain is put and the cards stay solid, no failure", MrMatrix.attach(noStyle) && noStyle.getWindow().stubBackground instanceof MrRainDrawable && noStyle.stubTheme.stubApplied.isEmpty());
        Settings noTheme = new Settings() { public Resources.Theme getTheme() { return null; } };
        check("a screen with no theme to change: the rain is put, no failure", MrMatrix.attach(noTheme) && noTheme.getWindow().stubBackground instanceof MrRainDrawable);
        check("a screen with no window: nothing put, no failure", !MrMatrix.attach(new NoWindow()));
        check("resources that cannot be read: nothing put, no failure", !MrMatrix.attach(new Broken()) );
        Broken b = new Broken();
        MrMatrix.attach(b);
        check("... and the window keeps its own background", b.getWindow().stubBackground == null);

        // MrScreens: the screen is created
        PreferenceManager.stubDefault = prefs;
        prefs.map.clear();
        Settings off = new Settings();
        new MrScreens().onActivityCreated(off, null);
        check("setting off: the settings screen is drawn as always (no rain, no acceleration)", off.getWindow().stubBackground == null && off.getWindow().stubFlags == 0);
        check("setting off: the cards stay solid (the theme is not touched)", off.stubTheme.stubApplied.isEmpty());
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        Settings on = new Settings();
        new MrScreens().onActivityCreated(on, null);
        check("setting on: the settings screen gets the rain", on.getWindow().stubBackground instanceof MrRainDrawable);
        check("... and is accelerated (the letters are animated), though the acceleration setting is off", (on.getWindow().stubFlags & HW) == HW);
        check("... and its cards are see-through (the style is laid over the theme while the screen is created)", on.stubTheme.stubApplied.size() == 1 && on.stubTheme.stubApplied.get(0) == GLASS_ID);
        check("the home screen is built the same way as the settings screens (it gets the rain and the see-through style)", homeIsTreatedLikeSettings());
        Plain plain = new Plain();
        new MrScreens().onActivityCreated(plain, null);
        check("setting on: any other screen of the app gets the rain, the acceleration and the see-through style too", plain.getWindow().stubBackground instanceof MrRainDrawable
                && (plain.getWindow().stubFlags & HW) == HW && plain.stubTheme.stubApplied.size() == 1 && plain.stubTheme.stubApplied.get(0) == GLASS_ID);
        ShotPerm helper = new ShotPerm();
        new MrScreens().onActivityCreated(helper, null);
        check("setting on: a helper window gets nothing", helper.getWindow().stubBackground == null && helper.getWindow().stubFlags == 0);
        prefs.map.put("pref_ui_hw_accel", Boolean.TRUE);
        prefs.map.put("pref_ui_matrix", Boolean.FALSE);
        Settings accel = new Settings();
        new MrScreens().onActivityCreated(accel, null);
        check("only the acceleration on: accelerated, no rain (the two settings do not depend on each other)", accel.getWindow().stubBackground == null && (accel.getWindow().stubFlags & HW) == HW);
        check("... and the cards stay solid", accel.stubTheme.stubApplied.isEmpty());
        prefs.map.remove("pref_ui_hw_accel");
        boolean noWin = true;
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        try { new MrScreens().onActivityCreated(new NoWindow(), null); } catch (RuntimeException e) { noWin = false; }
        check("a screen with no window does not break", noWin);
        boolean noRes = true;
        Broken broken = new Broken();
        try { new MrScreens().onActivityCreated(broken, null); } catch (RuntimeException e) { noRes = false; }
        check("a screen whose colours cannot be read opens as always (accelerated, no rain)", noRes && broken.getWindow().stubBackground == null && (broken.getWindow().stubFlags & HW) == HW);

        // MrScreens: it comes back after the setting changed
        prefs.map.clear();
        MrScreens cb = new MrScreens();
        Settings behind = new Settings();
        cb.onActivityCreated(behind, null);
        cb.onActivityResumed(behind);
        check("nothing changed (off, off): the screen is left alone when it comes back", behind.stubRecreates == 0);
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        cb.onActivityResumed(behind);
        check("the setting was turned on on a screen above: this one is created again when it comes back", behind.stubRecreates == 1);
        Settings behindOn = new Settings();
        cb.onActivityCreated(behindOn, null);
        cb.onActivityResumed(behindOn);
        check("made with the rain and the setting still on: left alone", behindOn.stubRecreates == 0);
        prefs.map.put("pref_ui_matrix", Boolean.FALSE);
        cb.onActivityResumed(behindOn);
        check("made with the rain and the setting turned off meanwhile: created again", behindOn.stubRecreates == 1);
        ShotPerm other = new ShotPerm();
        cb.onActivityCreated(other, null);
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        cb.onActivityResumed(other);
        check("a window that cannot have the rain (a helper) is never created again for it", other.stubRecreates == 0);
        Plain word = new Plain();
        prefs.map.put("pref_ui_matrix", Boolean.FALSE);
        cb.onActivityCreated(word, null);
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        cb.onActivityResumed(word);
        check("a word screen (a plain Activity) made without the rain is created again when the setting is turned on", word.stubRecreates == 1);
        check("a screen that MrScreens never saw (created before it was installed) is left alone", skipped(cb));
        MrScreens loop = new MrScreens();
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        Broken noColours = new Broken();
        loop.onActivityCreated(noColours, null);
        loop.onActivityResumed(noColours);
        loop.onActivityResumed(noColours);
        check("the rain could not be put (colours missing) and the setting stays on: the screen is not created again and again", noColours.stubRecreates == 0);

        // the Advanced screen reports a change
        Settings adv = new Settings();
        MrScreens.onSetting(adv, "pref_ui_matrix");
        check("the Matrix setting changed on the Advanced screen: it is created again at once", adv.stubRecreates == 1);
        MrScreens.onSetting(adv, "pref_ui_matrix_x");
        MrScreens.onSetting(adv, "force_keyboard_on");
        check("any other setting leaves it as it is", adv.stubRecreates == 1);
        PreferenceManager.stubDefault = null;
    }

    /** The dialogs that a screen opens with an explicit theme, and the colours that the screens built in code take. */
    static void dialogsAndKit() {
        PreferenceManager.stubDefault = prefs;
        prefs.map.clear();
        check("the effect off: a dialog keeps the theme that it was given", MrMatrix.dialogTheme(new Settings(), 77) == 77);
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        check("the effect on: the see-through dialog theme", MrMatrix.dialogTheme(new Settings(), 77) == DIALOG_GLASS_ID);
        check("the effect on in a build without that theme: the one that was given", MrMatrix.dialogTheme(new Settings() { public Resources getResources() { return new ResNoGlass(); } }, 77) == 77);
        check("resources that cannot be read: the one that was given", MrMatrix.dialogTheme(new Broken(), 77) == 77);
        check("a helper window never gets it", MrMatrix.dialogTheme(new ShotPerm(), 77) == 77);
        check("the name of the theme", MrMatrix.GLASS_DIALOG.equals("Theme.MrKeyboard.Dialog.Glass"));

        MrKit solid = new MrKit(offScreen());
        check("a screen built in code with the effect off: the background and the card of the settings", !solid.glass && solid.bg == BG && solid.card == CARD);
        prefs.map.put("pref_ui_matrix", Boolean.TRUE);
        MrKit clear = new MrKit(new Plain());
        check("with the effect on: the background is clear (the window shows the rain) and the card a little see-through", clear.glass && clear.bg == 0 && clear.card == CARD_GLASS);
        check("... the same for a helper window: it is never glass", !new MrKit(new ShotPerm()).glass);
        android.graphics.drawable.GradientDrawable g = clear.round(clear.card, 0x11223344, 14, false);
        check("a card with the effect is glass: a gradient from the top colour to the bottom one, with the light edge instead of its line",
                g.stubColors != null && g.stubColors.length == 2 && g.stubColors[0] == TOP && g.stubColors[1] == BOTTOM
                && g.stubOrientation == android.graphics.drawable.GradientDrawable.Orientation.TOP_BOTTOM && g.stubStrokeColor == EDGE);
        android.graphics.drawable.GradientDrawable flat = clear.round(0xff112233, 0x11223344, 14, false);
        android.graphics.drawable.GradientDrawable oval = clear.round(clear.card, 0x11223344, 0, true);
        android.graphics.drawable.GradientDrawable noLine = clear.round(clear.card, 0, 14, false);
        check("anything that is not a card (another colour, a circle, a fill without a line: the main buttons) keeps one flat colour and its line",
                flat.stubColors == null && flat.stubColor == 0xff112233 && flat.stubStrokeColor == 0x11223344 && oval.stubColors == null && oval.stubColor == CARD_GLASS && noLine.stubColors == null);
        MrKit plain = new MrKit(offScreen());
        android.graphics.drawable.GradientDrawable p = plain.round(plain.card, 0x11223344, 14, false);
        check("with the effect off the cards are as they were: one colour (the card) and their own line", p.stubColors == null && p.stubColor == CARD && p.stubStrokeColor == 0x11223344);
        PreferenceManager.stubDefault = null;
    }

    static Activity offScreen() {
        prefs.map.put("pref_ui_matrix", Boolean.FALSE);
        return new Plain();
    }

    /** The home screen (class Main, a plain Activity here with the same colours): rain, acceleration and the see-through style, like a settings screen. */
    static boolean homeIsTreatedLikeSettings() {
        com.mrkeyboard.app.Main m = new com.mrkeyboard.app.Main();
        new MrScreens().onActivityCreated(m, null);
        return m.getWindow().stubBackground instanceof MrRainDrawable && (m.getWindow().stubFlags & HW) == HW && m.stubTheme.stubApplied.size() == 1
                && m.stubTheme.stubApplied.get(0) == GLASS_ID;
    }

    static boolean skipped(MrScreens cb) {
        Settings unseen = new Settings();
        cb.onActivityResumed(unseen);
        return unseen.stubRecreates == 0;
    }

    // ---------------------------------------------------------------- what the files say

    static String file(String path) {
        try {
            return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
        } catch (Exception e) {
            return "";
        }
    }

    static String string(String lang, String key) {
        String x = file("res/" + lang + "/mr_strings.xml");
        int i = x.indexOf("<string name=\"" + key + "\">");
        if (i < 0) return null;
        int a = x.indexOf('>', i) + 1;
        return x.substring(a, x.indexOf("</string>", a));
    }

    /** The value of a colour of mr_colors.xml, -1 if it is missing. */
    static int argb(String colors, String name) {
        int i = colors.indexOf("<color name=\"" + name + "\">#");
        return i < 0 ? -1 : (int) Long.parseLong(colors.substring(colors.indexOf('#', i) + 1, colors.indexOf('<', i + 20)), 16);
    }

    static int red(int c) { return (c >> 16) & 0xff; }
    static int blue(int c) { return c & 0xff; }
    /** The lightness of a colour (the sum of the channels: enough to tell lighter from darker). */
    static int lum(int c) { return ((c >> 16) & 0xff) + ((c >> 8) & 0xff) + (c & 0xff); }

    static void files() {
        String adv = file("res/xml/prefs_advanced.xml");
        check("the setting is in the Advanced screen, a checkbox, stored, off by default", adv.contains("android:key=\"pref_ui_matrix\"") && adv.contains("android:defaultValue=\"false\" android:summaryOn=\"@string/mr_ui_matrix_on\""));
        boolean all = true;
        for (String lang : new String[] {"values", "values-pt-rBR", "values-es"}) {
            for (String k : new String[] {"mr_ui_matrix", "mr_ui_matrix_on", "mr_ui_matrix_off"}) {
                String t = string(lang, k);
                if (t == null || t.trim().length() == 0) all = false;
            }
        }
        check("the title and the two summaries exist in the three languages", all);
        check("the titles", "Matrix effect".equals(string("values", "mr_ui_matrix")) && "Efeito Matrix".equals(string("values-pt-rBR", "mr_ui_matrix"))
                && "Efecto Matrix".equals(string("values-es", "mr_ui_matrix")));
        check("the summary says that the screens are drawn by the GPU while it is on (it asks for the acceleration) in the three languages",
                string("values", "mr_ui_matrix_on").contains("GPU") && string("values-pt-rBR", "mr_ui_matrix_on").contains("GPU") && string("values-es", "mr_ui_matrix_on").contains("GPU"));
        check("Restore defaults resets it", file("docs/tools/java/src/com/mrkeyboard/app/MrReset.java").contains("\"pref_ui_matrix\""));
        // the see-through cards
        String attrs = file("res/values/mr_attrs.xml");
        boolean attrsOk = true;
        for (String a : new String[] {"mrScreenBg", "mrCard", "mrCardFlat", "mrHero"}) if (!attrs.contains("<attr name=\"" + a + "\"")) attrsOk = false;
        check("the four attributes of the cards and of the background are declared", attrsOk);
        String theme = file("res/values/mr_theme.xml");
        int ts = theme.indexOf("<style name=\"Theme.MrKeyboard.Settings\"");
        int te = theme.indexOf("</style>", ts);
        String settingsTheme = ts < 0 || te < 0 ? "" : theme.substring(ts, te);
        check("the theme of the settings screens gives the solid ones (nothing changes with the effect off)", settingsTheme.contains("<item name=\"mrScreenBg\">@color/mr_ui_bg</item>")
                && settingsTheme.contains("<item name=\"mrCard\">@drawable/mr_ui_card_ripple</item>") && settingsTheme.contains("<item name=\"mrCardFlat\">@drawable/mr_ui_card_shape</item>")
                && settingsTheme.contains("<item name=\"mrHero\">@drawable/mr_ui_hero_bg</item>"));
        int gs = theme.indexOf("<style name=\"MrMatrixGlass\">");
        int ge = theme.indexOf("</style>", gs);
        String glassStyle = gs < 0 || ge < 0 ? "" : theme.substring(gs, ge);
        check("the style laid over it gives the see-through ones and the background of the home screen is clear", glassStyle.contains("<item name=\"mrScreenBg\">@android:color/transparent</item>")
                && glassStyle.contains("@drawable/mr_ui_card_ripple_glass") && glassStyle.contains("@drawable/mr_ui_card_shape_glass") && glassStyle.contains("@drawable/mr_ui_hero_bg_glass"));
        check("the home screen has the theme of the settings screens as parent (it gets the same attributes)", theme.contains("<style name=\"Theme.MrKeyboard.Main\" parent=\"@style/Theme.MrKeyboard.Settings\">"));
        String colors = file("res/values/mr_colors.xml");
        int cardArgb = argb(colors, "mr_ui_card");
        int top = argb(colors, "mr_ui_glass_top");
        int bottom = argb(colors, "mr_ui_glass_bottom");
        int mid = argb(colors, "mr_ui_card_glass");
        int sTop = argb(colors, "mr_ui_glass_sunken_top");
        int sBottom = argb(colors, "mr_ui_glass_sunken_bottom");
        int edge = argb(colors, "mr_ui_glass_edge");
        int alpha = mid >>> 24;
        boolean alphas = true;
        for (int c : new int[] {top, bottom, mid, sTop, sBottom}) if ((c >>> 24) < 153 || (c >>> 24) > 217) alphas = false;
        check("the glass colours are a little see-through (alpha between 60% and 85%: " + (top >>> 24) + " at the top, " + (bottom >>> 24) + " at the bottom): the letters show, the text stays readable", alphas);
        check("the glass is lighter at the top than at the bottom (the sheen), the fixed cards too, and the middle colour is in between", lum(top) > lum(bottom) && lum(sTop) > lum(sBottom) && lum(top) > lum(mid) && lum(mid) > lum(bottom));
        check("it is a soft blue, bluer and lighter than the solid card (not the matte dark one) and not too light for the text: the blue is the strongest channel and the top is not too light (the average channel under 150)",
                blue(top) > 100 && blue(top) > red(top) && blue(bottom) > red(bottom) && lum(bottom) > lum(cardArgb) && lum(top) < 450);
        check("the edge is a light blue line, faint", (edge >>> 24) > 0x30 && (edge >>> 24) < 0x90 && blue(edge) > 0xc0 && red(edge) > 0x90);
        int dialogGlass = argb(colors, "mr_ui_dialog_glass");
        int dialogAlpha = dialogGlass >>> 24;
        check("the dialog is the colour of the card, a little see-through (" + dialogAlpha + "/255) and less than the cards", (dialogGlass & 0xffffff) == (cardArgb & 0xffffff) && dialogAlpha > (top >>> 24) && dialogAlpha >= 204 && dialogAlpha < 255);
        boolean glassFiles = true;
        for (String[] p : new String[][] {{"mr_ui_card_ripple", "16"}, {"mr_ui_card_shape", "16"}, {"mr_sheet_fixed_bg", "16"}}) {
            String d = file("res/drawable/" + p[0] + "_glass.xml");
            String solid = file("res/drawable/" + p[0] + ".xml");
            boolean sunken = p[0].equals("mr_sheet_fixed_bg");
            String from = sunken ? "mr_ui_glass_sunken_top" : "mr_ui_glass_top";
            String to = sunken ? "mr_ui_glass_sunken_bottom" : "mr_ui_glass_bottom";
            if (!d.contains("<gradient android:angle=\"270\" android:startColor=\"@color/" + from + "\" android:endColor=\"@color/" + to + "\" />")) glassFiles = false;
            if (!d.contains("<stroke android:width=\"1dp\" android:color=\"@color/mr_ui_glass_edge\" />") || d.contains("<solid android:color=\"@color/mr_ui")) glassFiles = false;
            if (!d.contains("<corners android:radius=\"" + p[1] + "dp\" />") || !solid.contains("<corners android:radius=\"" + p[1] + "dp\" />")) glassFiles = false;
            if (solid.contains("<ripple") != d.contains("<ripple") || (solid.contains("@android:id/mask") && !d.contains("@android:id/mask"))) glassFiles = false;
        }
        check("each glass drawable is its solid one with a sheen from the top (gradient, 270 degrees) and the light edge: same corners, same ripple and mask", glassFiles);
        String hero = file("res/drawable/mr_ui_hero_bg_glass.xml");
        String heroSolid = file("res/drawable/mr_ui_hero_bg.xml");
        check("the hero card is glass too, with its own line and its glow over it", hero.contains("<gradient android:angle=\"270\" android:startColor=\"@color/mr_ui_glass_top\" android:endColor=\"@color/mr_ui_glass_bottom\" />")
                && hero.contains("@color/mr_ui_cyan_line") && hero.contains("android:type=\"radial\"") && hero.replace("<gradient android:angle=\"270\" android:startColor=\"@color/mr_ui_glass_top\" android:endColor=\"@color/mr_ui_glass_bottom\" />",
                "<solid android:color=\"@color/mr_ui_card\" />").equals(heroSolid));
        check("the dialog background is the solid one with the fill changed", file("res/drawable/mr_ui_dialog_bg_glass.xml").replace("@color/mr_ui_dialog_glass", "@color/mr_ui_card").equals(file("res/drawable/mr_ui_dialog_bg.xml")));
        int ds = theme.indexOf("<style name=\"Theme.MrKeyboard.Dialog.Glass\" parent=\"@style/Theme.MrKeyboard.Dialog\">");
        String dialogStyle = ds < 0 ? "" : theme.substring(ds, theme.indexOf("</style>", ds));
        check("the see-through dialog theme only changes the background of the window", dialogStyle.contains("<item name=\"android:windowBackground\">@drawable/mr_ui_dialog_bg_glass</item>") && dialogStyle.split("<item ", -1).length == 2);
        check("the dialogs follow the screen: the solid theme is the default and the style of the effect changes it (the framework opens them with it)",
                settingsTheme.contains("<item name=\"android:alertDialogTheme\">@style/Theme.MrKeyboard.Dialog</item>") && glassStyle.contains("<item name=\"android:alertDialogTheme\">@style/Theme.MrKeyboard.Dialog.Glass</item>"));
        boolean rows = true;
        for (String f : new String[] {"mr_ui_pref_row", "mr_ui_pref_row_value", "mr_ui_pref_row_metrics", "mr_ui_pref_row_static", "mr_ui_pref_row_last"}) {
            String l = file("res/layout/" + f + ".xml");
            if (!l.contains("android:background=\"?attr/mrCard\"") || l.contains("@drawable/mr_ui_card_ripple\"")) rows = false;
        }
        check("the rows of the settings take their card from the theme", rows && file("res/layout/mr_ui_pref_hero.xml").contains("android:background=\"?attr/mrHero\""));
        String main = file("res/layout/main.xml");
        check("the home screen takes its background, its header and its cards from the theme (so that the rain shows on it)", main.contains("android:background=\"?attr/mrScreenBg\"")
                && main.contains("android:background=\"?attr/mrHero\"") && main.contains("android:background=\"?attr/mrCard\"") && main.split("\\?attr/mrCardFlat", -1).length - 1 == 3
                && !main.contains("@color/mr_ui_bg") && !main.contains("@drawable/mr_ui_card_shape\"") && !main.contains("@drawable/mr_ui_card_ripple\"") && !main.contains("@drawable/mr_ui_hero_bg\""));
        boolean sheets = file("res/layout/mr_sheets_screen.xml").contains("android:background=\"?attr/mrScreenBg\"") && file("res/layout/mr_sheet_ed_screen.xml").contains("android:background=\"?attr/mrScreenBg\"")
                && file("res/layout/mr_sheet_card.xml").contains("android:background=\"?attr/mrCard\"") && file("res/layout/mr_sheet_ed_test_card.xml").contains("android:background=\"?attr/mrCardFlat\"")
                && file("res/layout/mr_sheet_fixed_card.xml").contains("android:background=\"?attr/mrSheetFixed\"");
        check("the sheets and their editor take their background and their cards from the theme too (the header stays solid)", sheets
                && file("res/layout/mr_sheets_screen.xml").contains("android:background=\"@color/mr_ui_bg\"") && file("res/layout/mr_sheet_ed_screen.xml").contains("android:background=\"@color/mr_ui_bg\""));
        String src = "docs/tools/java/src/com/mrkeyboard/app/";
        check("the screens built in code (word screens, tour, AI style, the test card of the sheet editor) ask MrMatrix", file(src + "MrKit.java").contains("MrMatrix.wanted(a)")
                && file(src + "MrAiStyleActivity.java").contains("MrMatrix.wanted(this)") && file(src + "SheetEditorActivity.java").contains("MrMatrix.wanted(SheetEditorActivity.this)"));
        check("the dialogs that are opened with an explicit theme (the notes of the version, the update) ask MrMatrix", file(src + "MrVersion.java").contains("MrMatrix.dialogTheme(a, theme)")
                && file(src + "MrUpdateDialog.java").contains("MrMatrix.dialogTheme(a, theme)"));
        check("the danger rows were already see-through and the dialog and the other screens do not use the attributes",
                file("res/layout/mr_ui_pref_row_danger.xml").contains("mr_ui_card_ripple_danger") && !file("res/layout/mr_update_dialog.xml").contains("?attr/mrCard"));
        String man = file("AndroidManifest.xml");
        check("the manifest still says that the app is not accelerated (the effect asks for it by window)", man.contains("android:hardwareAccelerated=\"false\""));
    }

    public static void main(String[] args) {
        rain();
        drawable();
        matrix();
        dialogsAndKit();
        files();
        System.out.println();
        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAIL of " + (ok + fail));
        if (fail > 0) System.exit(1);
    }
}

/** The home screen of the app (its real class is smali): only the name matters to MrMatrix. */
class Main extends Activity {
    final Resources.Theme stubTheme = new Resources.Theme();
    public Resources.Theme getTheme() { return stubTheme; }
    public Resources getResources() { return new MatrixTest.Res(); }
    public String getPackageName() { return "com.mrkeyboard.app"; }
}

/** The other helper windows (translucent): only the names matter. */
class ShotPick extends Activity { }

/** A window that is not a screen of the app (translucent), here also a PreferenceActivity to show that the helper check comes first. */
class ShotPerm extends PreferenceActivity {
    public Resources getResources() { return new MatrixTest.Res(); }
    public String getPackageName() { return "com.mrkeyboard.app"; }
}
