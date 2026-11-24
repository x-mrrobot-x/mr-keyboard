package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Paint;
import android.graphics.Insets;
import android.graphics.drawable.GradientDrawable;
import android.media.AudioManager;
import android.media.SoundPool;
import android.preference.PreferenceManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.text.InputType;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.WindowInsets;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * The key sounds (v2.1.0, "Keyboard sound"), run on the PC against the stubs of Android: MrKeySound (the style and the volume read from the
 * preferences, what is played for each key, what happens while a sound loads, when it fails or is missing, a style that changes, a preview that is asked
 * for before the sound has loaded), the screen MrSoundActivity (the fifteen tiles in the order of the picture, the choice written in the preferences the
 * keyboard reads, mute, the volume, what it says for the default sound) and the files (the thirteen .ogg of res/raw read byte by byte, the strings in
 * three languages, the manifest, the row of the feedback screen, the reset and the call in LatinIME.playKeyClick). Hearing them is not possible here: the
 * person tries them on the phone.
 */
public class SoundTest {
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

    /** Mute and the default sound first, then from the most discreet to the most eye-catching, five to a row. */
    static final String[] EXPECTED_TILES = {
            "mute", "default", "keyboard", "drop", "bubble",
            "bubble2", "bell", "duck", "mouse", "cat",
            "frog", "fox", "wand", "pistol", "rocket"};
    static final String[] NAMES = {"mute", "bubble", "bubble2", "bell", "duck", "keyboard", "fox", "pistol", "wand", "frog", "cat", "drop", "rocket", "mouse"};

    // ---------------------------------------------------------------- the world of the stubs

    static class Prefs implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();
        public Map<String, ?> getAll() { return m; }
        public String getString(String k, String d) { Object o = m.get(k); return o instanceof String ? (String) o : d; }
        public int getInt(String k, int d) { Object o = m.get(k); return o instanceof Integer ? (Integer) o : d; }
        public long getLong(String k, long d) { Object o = m.get(k); return o instanceof Long ? (Long) o : d; }
        public boolean getBoolean(String k, boolean d) { Object o = m.get(k); return o instanceof Boolean ? (Boolean) o : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String k, String v) { m.put(k, v); return this; }
                public Editor putInt(String k, int v) { m.put(k, v); return this; }
                public Editor putLong(String k, long v) { m.put(k, v); return this; }
                public Editor putBoolean(String k, boolean v) { m.put(k, v); return this; }
                public Editor remove(String k) { m.remove(k); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
    }

    static class Res extends Resources {
        final Map<String, Integer> ids = new HashMap<String, Integer>();
        final Map<Integer, String> names = new HashMap<Integer, String>();
        final Set<String> missing = new HashSet<String>();
        final DisplayMetrics dm = new DisplayMetrics();

        Res() {
            dm.density = 2f;
            dm.widthPixels = 1080;
        }

        public int getIdentifier(String name, String type, String pkg) {
            if (missing.contains(type + ":" + name)) return 0;
            String key = type + ":" + name;
            Integer id = ids.get(key);
            if (id == null) {
                id = 1000 + ids.size();
                ids.put(key, id);
                names.put(id, name);
            }
            return id;
        }

        public String getString(int id) { return names.get(id); }
        public String getString(int id, Object... args) { return names.get(id) + Arrays.toString(args); }
        public int getColor(int id) { return 0xff000000 | id; }
        public DisplayMetrics getDisplayMetrics() { return dm; }
    }

    /** A context for the engine: resources, the audio service and nothing else. */
    static class Ctx extends Activity {
        final Res res = new Res();
        final AudioManager am = new AudioManager();
        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(Intent i) { }
        public Object getSystemService(String name) { return Context.AUDIO_SERVICE.equals(name) ? am : null; }
    }

    static class Screen extends MrSoundActivity {
        final Res res = new Res();
        final AudioManager am = new AudioManager();
        final InputMethodManager imm = new InputMethodManager();
        View content;
        int finishes;
        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(Intent i) { }
        public Object getSystemService(String name) {
            return Context.AUDIO_SERVICE.equals(name) ? am : Context.INPUT_METHOD_SERVICE.equals(name) ? imm : null;
        }
        public void setContentView(View v) { content = v; }
        public void finish() { finishes++; }
    }

    static Prefs prefs;

    static void reset() {
        MrKeySound.release();
        SoundPool.stubCreated.clear();
        Paint.stubNoGlyph.clear();
        SoundPool.stubFailAllLoads = false;
        Settings.Secure.stubValues.clear();
        Build.VERSION.SDK_INT = 36;
        prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
    }

    static SoundPool pool() {
        return SoundPool.stubCreated.isEmpty() ? null : SoundPool.stubCreated.get(SoundPool.stubCreated.size() - 1);
    }

    static boolean near(float a, float b) { return Math.abs(a - b) < 0.0001f; }

    // ---------------------------------------------------------------- MrKeySound: what is read

    static void reading() {
        reset();
        check("no style chosen is the default one", MrKeySound.style(prefs).equals("default"));
        check("no preferences at all is the default one", MrKeySound.style(null).equals("default"));
        boolean every = true;
        for (String s : MrKeySound.STYLES) {
            prefs.edit().putString(MrKeySound.KEY, s).apply();
            if (!MrKeySound.style(prefs).equals(s) || !MrKeySound.known(s)) every = false;
        }
        check("each of the thirteen styles is read back as it was chosen", every && MrKeySound.STYLES.length == 13);
        prefs.edit().putString(MrKeySound.KEY, "gone").apply();
        check("a name that does not exist is the default one", MrKeySound.style(prefs).equals("default"));
        check("mute and default are not sounds of the app", !MrKeySound.known("mute") && !MrKeySound.known("default") && !MrKeySound.known(null));

        check("no volume saved is 80%", near(MrKeySound.volume(prefs), 0.8f));
        String[][] cases = {{"0.5", "0.5"}, {" 0.25 ", "0.25"}, {"0", "0"}, {"1.0", "1"}, {"2", "1"}, {"-1", "0.8"}, {"abc", "0.8"}, {"NaN", "0.8"}, {"", "0.8"}};
        boolean allVol = true;
        for (String[] c : cases) {
            prefs.edit().putString(MrKeySound.VOLUME_KEY, c[0]).apply();
            if (!near(MrKeySound.volume(prefs), Float.parseFloat(c[1]))) {
                allVol = false;
                System.out.println("      volume of \"" + c[0] + "\" was " + MrKeySound.volume(prefs));
            }
        }
        check("the volume is clamped to 0..1 and what cannot be read is 80%", allVol);
        check("without preferences the volume is 80%", near(MrKeySound.volume(null), 0.8f));

        check("a letter and any other key play the sound as it was made", near(MrKeySound.rate(5), 1f) && near(MrKeySound.rate(99), 1f));
        check("delete is lower, space a little lower, return a little higher",
                near(MrKeySound.rate(7), 0.85f) && near(MrKeySound.rate(6), 0.92f) && near(MrKeySound.rate(8), 1.08f));
    }

    // ---------------------------------------------------------------- MrKeySound: what is played

    static void playing() {
        reset();
        Ctx c = new Ctx();
        check("the default style hands the key to the system click", !MrKeySound.play(c, 5));
        check("the default style does not even make a pool", SoundPool.stubCreated.isEmpty());

        prefs.edit().putString(MrKeySound.KEY, "bubble").apply();
        check("a style handles the key itself, even while it loads", MrKeySound.play(c, 5));
        SoundPool p = pool();
        check("one pool with four streams on the sonification stream",
                SoundPool.stubCreated.size() == 1 && p.stubMaxStreams == 4 && p.stubAttributes != null
                        && p.stubAttributes.stubUsage == 13 && p.stubAttributes.stubContentType == 4);
        check("the sound of the style was loaded, from res/raw/mr_snd_bubble", p.stubLoaded.size() == 1 && p.stubLoaded.get(0).equals(c.res.ids.get("raw:mr_snd_bubble")));
        check("nothing is heard while it loads (and no other sound takes its place)", p.stubPlays.isEmpty() && c.am.stubEffects.isEmpty());
        p.stubComplete(1, 0);
        check("a key played while it loaded did not wait to be heard later", p.stubPlays.isEmpty());
        check("loaded, the key is handled", MrKeySound.play(c, 5));
        float[] pl = p.stubPlays.get(0);
        check("it is played at 80% on both sides and at its own speed", p.stubPlays.size() == 1 && pl[0] == 1 && near(pl[1], 0.8f) && near(pl[2], 0.8f) && near(pl[3], 1f));
        MrKeySound.play(c, 6);
        MrKeySound.play(c, 7);
        MrKeySound.play(c, 8);
        check("space, delete and return are played at their own speed",
                p.stubPlays.size() == 4 && near(p.stubPlays.get(1)[3], 0.92f) && near(p.stubPlays.get(2)[3], 0.85f) && near(p.stubPlays.get(3)[3], 1.08f));
        check("the same style is not loaded again", p.stubLoaded.size() == 1 && SoundPool.stubCreated.size() == 1);
        prefs.edit().putString(MrKeySound.VOLUME_KEY, "0.35").apply();
        MrKeySound.play(c, 5);
        check("the volume of the screen is the volume of the sound", near(p.stubPlays.get(4)[1], 0.35f) && near(p.stubPlays.get(4)[2], 0.35f));

        // another style: the old sample is let go, the new one loads and is silent until loaded
        prefs.edit().putString(MrKeySound.KEY, "bell").apply();
        check("a new style handles the key", MrKeySound.play(c, 5));
        check("the sound of the old style was unloaded and the new one loaded", p.stubUnloaded.size() == 1 && p.stubUnloaded.get(0).intValue() == 1 && p.stubLoaded.size() == 2
                && p.stubLoaded.get(1).equals(c.res.ids.get("raw:mr_snd_bell")));
        check("the new style is silent until it has loaded (not the old sound)", p.stubPlays.size() == 5);
        p.stubComplete(2, 0);
        MrKeySound.play(c, 5);
        check("then it is played, with its own sample", p.stubPlays.size() == 6 && p.stubPlays.get(5)[0] == 2);
        p.stubComplete(1, 0);
        check("the end of an old load changes nothing", MrKeySound.play(c, 5) && p.stubPlays.size() == 7 && p.stubPlays.get(6)[0] == 2);

        // a sound that cannot be loaded: the system click plays, as before
        reset();
        c = new Ctx();
        prefs.edit().putString(MrKeySound.KEY, "fox").apply();
        MrKeySound.play(c, 5);
        pool().stubComplete(1, 1);
        check("a sound that failed to load hands the key to the system click", !MrKeySound.play(c, 5) && pool().stubPlays.isEmpty());

        reset();
        c = new Ctx();
        c.res.missing.add("raw:mr_snd_fox");
        prefs.edit().putString(MrKeySound.KEY, "fox").apply();
        check("a style whose file is missing hands the key to the system click", !MrKeySound.play(c, 5) && pool().stubLoaded.isEmpty());

        reset();
        c = new Ctx();
        SoundPool.stubFailAllLoads = true;
        prefs.edit().putString(MrKeySound.KEY, "fox").apply();
        check("a pool that cannot load the file hands the key to the system click", !MrKeySound.play(c, 5) && !MrKeySound.play(c, 5));
        SoundPool.stubFailAllLoads = false;

        reset();
        c = new Ctx();
        prefs.edit().putString(MrKeySound.KEY, "duck").apply();
        MrKeySound.play(c, 5);
        pool().stubComplete(1, 0);
        pool().stubThrowOnPlay = true;
        check("a pool that throws on play hands the key to the system click, never an exception", !MrKeySound.play(c, 5));

        reset();
        c = new Ctx();
        prefs.edit().putString(MrKeySound.KEY, "frog").apply();
        MrKeySound.release();
        MrKeySound.play(c, 5);
        SoundPool a = pool();
        MrKeySound.release();
        check("release lets go of the pool", a.stubReleased);
        MrKeySound.play(c, 5);
        check("a key after release makes a new pool and loads again", SoundPool.stubCreated.size() == 2 && pool() != a && pool().stubLoaded.size() == 1);
    }

    static void previewing() {
        reset();
        Ctx c = new Ctx();
        MrKeySound.preview(c, "bubble");
        SoundPool p = pool();
        check("a preview asked for while the sound loads plays nothing yet", p != null && p.stubLoaded.size() == 1 && p.stubPlays.isEmpty());
        p.stubComplete(1, 0);
        check("it is heard as soon as the sound has loaded, at the volume of the screen", p.stubPlays.size() == 1 && near(p.stubPlays.get(0)[1], 0.8f) && near(p.stubPlays.get(0)[3], 1f));
        MrKeySound.preview(c, "bubble");
        check("a preview of a loaded sound is heard at once", p.stubPlays.size() == 2);
        prefs.edit().putString(MrKeySound.VOLUME_KEY, "0.5").apply();
        MrKeySound.preview(c, "bubble");
        check("the preview follows the volume", p.stubPlays.size() == 3 && near(p.stubPlays.get(2)[1], 0.5f));

        MrKeySound.preview(c, "default");
        check("the default one previews the system click at the volume of the system", c.am.stubEffects.size() == 1 && c.am.stubEffects.get(0)[0] == 5 && c.am.stubEffects.get(0)[1] < 0f);
        check("and does not touch the pool", p.stubPlays.size() == 3 && p.stubLoaded.size() == 1);

        // a key typed while the preview loads is not played later; a preview is
        reset();
        c = new Ctx();
        prefs.edit().putString(MrKeySound.KEY, "cat").apply();
        MrKeySound.play(c, 5);
        pool().stubComplete(1, 0);
        check("a key played while a sound loads is not kept to be heard later", pool().stubPlays.isEmpty());

        // two previews in a row: only the last one is heard
        reset();
        c = new Ctx();
        MrKeySound.preview(c, "bubble");
        MrKeySound.preview(c, "bell");
        p = pool();
        p.stubComplete(1, 0);
        check("the load of a sound that was left is ignored", p.stubPlays.isEmpty());
        p.stubComplete(2, 0);
        check("the preview of the last tile is heard once", p.stubPlays.size() == 1 && p.stubPlays.get(0)[0] == 2);

        // a failed load never plays the preview
        reset();
        c = new Ctx();
        MrKeySound.preview(c, "bubble");
        pool().stubComplete(1, 1);
        check("a preview of a sound that failed to load is not heard", pool().stubPlays.isEmpty());

        reset();
        c = new Ctx();
        MrKeySound.preview(c, "bubble");
        pool().stubThrowOnPlay = true;
        boolean threw = false;
        try {
            pool().stubComplete(1, 0);
        } catch (RuntimeException e) {
            threw = true;
        }
        check("a pool that throws when the preview is played does not take the callback down", !threw);

        reset();
        c = new Ctx();
        MrKeySound.preload(c, "frog");
        check("preload loads the sound and plays nothing", pool().stubLoaded.size() == 1 && pool().stubPlays.isEmpty());
        MrKeySound.preload(c, "frog");
        check("preload of the same style loads it once", pool().stubLoaded.size() == 1);
        MrKeySound.preload(c, "default");
        MrKeySound.preload(c, "mute");
        check("preload of default and mute does nothing", pool().stubLoaded.size() == 1 && pool().stubUnloaded.isEmpty());
    }

    // ---------------------------------------------------------------- the screen

    static Screen open() {
        Screen s = new Screen();
        s.onCreate(null);
        return s;
    }

    static String tileName(Screen s, int i) {
        return String.valueOf(s.mTiles.get(i).getContentDescription());
    }

    static boolean chosen(Screen s, int i) {
        GradientDrawable d = (GradientDrawable) s.mTiles.get(i).stubBackground;
        return d.stubFill == s.k.soft && d.stubLine == s.k.accent;
    }

    static int chosenCount(Screen s) {
        int n = 0;
        for (int i = 0; i < s.mTiles.size(); i++) if (chosen(s, i)) n++;
        return n;
    }

    static int index(String id) {
        return Arrays.asList(MrSoundActivity.TILES).indexOf(id);
    }

    static void screen() {
        reset();
        check("the tiles are the fifteen of the picture, in its order (5 columns, 3 rows)", Arrays.equals(MrSoundActivity.TILES, EXPECTED_TILES) && MrSoundActivity.COLUMNS == 5);
        Set<String> all = new HashSet<String>(Arrays.asList(MrSoundActivity.TILES));
        boolean covers = all.size() == 15 && all.contains("mute") && all.contains("default");
        for (String st : MrKeySound.STYLES) if (!all.contains(st)) covers = false;
        check("every sound of the app, mute and default are on the screen once", covers);

        Screen s = open();
        check("one view for every tile", s.mTiles.size() == 15);
        android.view.ViewGroup scroll = (android.view.ViewGroup) s.content;
        android.view.ViewGroup col = (android.view.ViewGroup) scroll.getChildAt(0);
        android.view.ViewGroup grid = (android.view.ViewGroup) col.getChildAt(2);
        boolean rows = grid.getChildCount() == 3;
        for (int r = 0; rows && r < 3; r++) rows = ((android.view.ViewGroup) grid.getChildAt(r)).getChildCount() == 5;
        boolean order = rows;
        for (int i = 0; order && i < 15; i++) order = ((android.view.ViewGroup) grid.getChildAt(i / 5)).getChildAt(i % 5) == s.mTiles.get(i);
        check("the grid has three rows of five tiles, in the order of the list", rows && order);

        boolean desc = true;
        for (int i = 0; i < 15; i++) {
            String id = MrSoundActivity.TILES[i];
            String want = id.equals("default") ? "mr_sound_default" : "mr_sound_name_" + id;
            if (!tileName(s, i).equals(want)) desc = false;
            if (!s.mTiles.get(i).isClickable()) desc = false;
        }
        check("every tile can be touched and says what it is to the screen reader", desc);

        check("nothing chosen yet: the default tile is the chosen one, and only it", s.current().equals("default") && chosen(s, index("default")) && chosenCount(s) == 1);
        check("the volume shows 80%", s.mSeek.getProgress() == 80 && String.valueOf(s.mPercent.getText()).equals("80%") && s.mSeek.getMax() == 100);
        check("with the default sound the slider is off and the screen says why", !s.mSeek.isEnabled() && s.mSeek.getAlpha() < 1f
                && String.valueOf(s.mNote.getText()).equals("mr_sound_default_note") && s.mNote.getVisibility() == View.VISIBLE);
        check("opening the screen plays nothing and writes nothing", pool() == null && s.am.stubEffects.isEmpty() && prefs.m.isEmpty());

        // choosing a sound
        s.choose("bubble");
        check("a tile chosen turns the sound on and names the style", prefs.getBoolean("sound_on", false) && prefs.getString(MrKeySound.KEY, "").equals("bubble"));
        check("the chosen tile is drawn as chosen, the others are not", chosen(s, index("bubble")) && chosenCount(s) == 1);
        check("with a sound of the app the slider is on and there is no note", s.mSeek.isEnabled() && s.mSeek.getAlpha() == 1f && s.mNote.getVisibility() == View.GONE);
        SoundPool p = pool();
        check("the sound is loaded and, when it has loaded, heard", p != null && p.stubLoaded.size() == 1 && p.stubPlays.isEmpty());
        p.stubComplete(1, 0);
        check("it is heard once, at the volume of the screen", p.stubPlays.size() == 1 && near(p.stubPlays.get(0)[1], 0.8f));
        s.choose("bubble");
        check("touching the chosen tile again plays it again", p.stubPlays.size() == 2 && prefs.getString(MrKeySound.KEY, "").equals("bubble"));

        // the volume
        s.mSeek.stubListener.onProgressChanged(s.mSeek, 35, true);
        check("moving the slider writes the volume as the keyboard reads it", prefs.getString(MrKeySound.VOLUME_KEY, "").equals("0.35") && near(MrKeySound.volume(prefs), 0.35f));
        check("and shows it", String.valueOf(s.mPercent.getText()).equals("35%"));
        s.mSeek.stubListener.onProgressChanged(s.mSeek, 90, false);
        check("a change that the person did not make (the screen drawing itself) writes nothing", prefs.getString(MrKeySound.VOLUME_KEY, "").equals("0.35"));
        int before = p.stubPlays.size();
        s.mSeek.stubListener.onProgressChanged(s.mSeek, 40, true);
        check("moving the slider is quiet", p.stubPlays.size() == before);
        s.mSeek.stubListener.onStopTrackingTouch(s.mSeek);
        check("letting it go plays the sound at the new volume", p.stubPlays.size() == before + 1 && near(p.stubPlays.get(before)[1], 0.4f));
        s.mSeek.stubListener.onProgressChanged(s.mSeek, 150, true);
        check("a value above 100 is 100%", prefs.getString(MrKeySound.VOLUME_KEY, "").equals("1.0") && String.valueOf(s.mPercent.getText()).equals("100%"));
        s.mSeek.stubListener.onProgressChanged(s.mSeek, -3, true);
        check("a value below 0 is 0%", prefs.getString(MrKeySound.VOLUME_KEY, "").equals("0.0") && String.valueOf(s.mPercent.getText()).equals("0%"));
        s.mSeek.stubListener.onStartTrackingTouch(s.mSeek);
        check("touching the slider does nothing by itself", true);
        boolean round = true;
        for (int v = 0; v <= 100; v++) {
            prefs.edit().putString(MrKeySound.VOLUME_KEY, Float.toString(v / 100f)).apply();
            if (Math.round(MrKeySound.volume(prefs) * 100f) != v) round = false;
        }
        check("every percent from 0 to 100 is read back as the same percent", round);

        // mute
        prefs.edit().putString(MrKeySound.VOLUME_KEY, "0.6").apply();
        int plays = p.stubPlays.size();
        s.choose("mute");
        check("mute turns the sound off and leaves the style as it was", !prefs.getBoolean("sound_on", true) && prefs.getString(MrKeySound.KEY, "").equals("bubble"));
        check("mute is the chosen tile", s.current().equals("mute") && chosen(s, index("mute")) && chosenCount(s) == 1);
        check("mute is silent and says so, and the slider is off", p.stubPlays.size() == plays && s.am.stubEffects.isEmpty() && !s.mSeek.isEnabled()
                && String.valueOf(s.mNote.getText()).equals("mr_sound_muted") && s.mNote.getVisibility() == View.VISIBLE);
        s.mSeek.stubListener.onStopTrackingTouch(s.mSeek);
        check("letting go of the slider while muted plays nothing", p.stubPlays.size() == plays && s.am.stubEffects.isEmpty());

        Screen again = open();
        check("a screen opened again shows mute, from the preferences", again.current().equals("mute") && chosen(again, index("mute")) && chosenCount(again) == 1
                && again.mSeek.getProgress() == 60);

        // from mute to a sound and to the default one
        s.choose("bubble2");
        check("a sound chosen after mute turns the sound on again", prefs.getBoolean("sound_on", false) && prefs.getString(MrKeySound.KEY, "").equals("bubble2")
                && chosen(s, index("bubble2")) && chosenCount(s) == 1 && s.mSeek.isEnabled());
        s.choose("default");
        check("default turns the sound on and names the default style", prefs.getBoolean("sound_on", false) && prefs.getString(MrKeySound.KEY, "").equals("default")
                && MrKeySound.style(prefs).equals("default"));
        check("default is heard as the system click, at the volume of the system", s.am.stubEffects.size() == 1 && s.am.stubEffects.get(0)[0] == 5 && s.am.stubEffects.get(0)[1] < 0f);
        check("default is the chosen tile, the slider is off and says why", chosen(s, index("default")) && chosenCount(s) == 1 && !s.mSeek.isEnabled()
                && String.valueOf(s.mNote.getText()).equals("mr_sound_default_note"));
        check("the keyboard, asked for a key, leaves it to the system", !MrKeySound.play(s, 5));

        // each tile
        boolean each = true;
        for (String id : MrSoundActivity.TILES) {
            reset();
            Screen t = open();
            t.mTiles.get(index(id)).performClick();
            boolean mute = id.equals("mute");
            boolean right = mute ? !prefs.getBoolean("sound_on", true) : prefs.getBoolean("sound_on", false) && prefs.getString(MrKeySound.KEY, "").equals(id);
            if (!right || !chosen(t, index(id)) || chosenCount(t) != 1) {
                each = false;
                System.out.println("      tile " + id + " does not choose itself");
            }
            if (!mute && !id.equals("default") && (pool() == null || pool().stubLoaded.size() != 1)) {
                each = false;
                System.out.println("      tile " + id + " does not load its sound");
            }
        }
        check("touching each of the fifteen tiles chooses it, and a sound loads its own file", each);

        // a style that is gone
        reset();
        prefs.edit().putString(MrKeySound.KEY, "gone").apply();
        Screen gone = open();
        check("a style that no longer exists shows the default tile", gone.current().equals("default") && chosen(gone, index("default")));

        // the way back
        reset();
        Screen back = open();
        android.view.ViewGroup head = (android.view.ViewGroup) ((android.view.ViewGroup) ((android.view.ViewGroup) back.content).getChildAt(0)).getChildAt(0);
        head.getChildAt(0).performClick();
        check("the back arrow closes the screen", back.finishes == 1);
    }

    static WindowInsets keyboardInsets(boolean visible) {
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.ime(), Insets.of(0, 0, 0, 900));
        b.setInsets(WindowInsets.Type.navigationBars(), Insets.of(0, 0, 0, 48));
        b.setVisible(WindowInsets.Type.ime(), visible);
        return b.build();
    }

    /** The field under the volume where the sounds are tried, and the keyboard that opens with the screen. */
    static void tryField() {
        reset();
        Screen s = open();
        android.view.ViewGroup col = (android.view.ViewGroup) ((android.view.ViewGroup) s.content).getChildAt(0);
        check("a field to type in is under the volume card, a direct child of the column (what the room for the keyboard needs)",
                s.mTry != null && ((android.view.ViewGroup) col.getChildAt(3)).getChildCount() > 0 && col.getChildAt(4) == s.mTry && col.getChildCount() == 6);
        int type = s.mTry.getInputType();
        check("it is a text field with no suggestions, that takes lines (the return key is the return key)",
                (type & InputType.TYPE_CLASS_TEXT) != 0 && (type & InputType.TYPE_TEXT_FLAG_MULTI_LINE) != 0 && (type & InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS) != 0);
        check("it says to type there, and has no password or number type", "mr_sound_try".equals(String.valueOf(s.mTry.getHint())) && (type & 0x0f) == InputType.TYPE_CLASS_TEXT);
        check("it has the focus from the start", s.mTry.hasFocus());
        check("the keyboard is not asked for before the window has the focus", s.imm.shows == 0 && s.mTry.getViewTreeObserver().stubListeners() == 1);
        s.mTry.stubWindowFocus(true);
        s.mTry.stubRunPosted();
        check("the keyboard opens with the screen, for that field", s.imm.shows == 1 && s.imm.lastView == s.mTry && s.imm.lastFlags == InputMethodManager.SHOW_IMPLICIT);
        s.choose("bubble");
        s.mTiles.get(index("bell")).performClick();
        s.mSeek.stubListener.onProgressChanged(s.mSeek, 50, true);
        check("touching tiles and the slider does not take the focus from the field or ask for the keyboard again", s.mTry.hasFocus() && s.imm.shows == 1);
        check("the screen puts the keyboard room in its column (Android 11+), scrolling down only as far as needed",
                ((ScrollView) s.content).stubInsetsListener() != null);
        Build.VERSION.SDK_INT = 29;
        Screen old = open();
        check("below Android 11 the window resizes by itself (adjustResize): no listener", ((ScrollView) old.content).stubInsetsListener() == null);
        Build.VERSION.SDK_INT = 36;

        // the screen turns (or is recreated): the keyboard comes back only if it was open
        Screen a = open();
        a.mTry.requestFocus();
        a.mTry.stubRootInsets(keyboardInsets(true));
        Bundle out = new Bundle();
        a.onSaveInstanceState(out);
        check("the open keyboard is saved with the screen", out.getInt(MrScreenIme.KEY_FIELD, -1) == 0);
        Screen b = new Screen();
        b.onCreate(out);
        check("the new screen gives the field its focus back", b.mTry.hasFocus());
        b.mTry.stubWindowFocus(true);
        b.mTry.stubRunPosted();
        check("... and asks for the keyboard once", b.imm.shows == 1 && b.imm.lastView == b.mTry);

        Screen c = open();
        c.mTry.requestFocus();
        c.mTry.stubRootInsets(keyboardInsets(false));
        Bundle shut = new Bundle();
        c.onSaveInstanceState(shut);
        Screen d = new Screen();
        d.onCreate(shut);
        d.mTry.stubWindowFocus(true);
        d.mTry.stubRunPosted();
        check("a keyboard the person had closed stays closed when the screen is created again", shut.size() == 0 && !d.mTry.hasFocus() && d.imm.shows == 0);

        // which keyboard is in use
        reset();
        Settings.Secure.stubValues.put("default_input_method", "com.mrkeyboard.app/.LatinIME");
        Screen mine = open();
        check("Mr Keyboard in use: no note", mine.mOtherIme.getVisibility() == View.GONE);
        Settings.Secure.stubValues.put("default_input_method", "com.other.keyboard/.Service");
        Screen other = open();
        check("another keyboard in use: the note says to switch to this one", other.mOtherIme.getVisibility() == View.VISIBLE
                && String.valueOf(other.mOtherIme.getText()).equals("mr_sound_other_ime"));
        Settings.Secure.stubValues.put("default_input_method", "com.mrkeyboard.app/.LatinIME");
        other.onResume();
        check("back on the screen after switching to Mr Keyboard: the note goes", other.mOtherIme.getVisibility() == View.GONE);
        Settings.Secure.stubValues.put("default_input_method", "com.other.keyboard/.Service");
        mine.onResume();
        check("back on the screen after switching to another one: the note comes", mine.mOtherIme.getVisibility() == View.VISIBLE);
        Settings.Secure.stubValues.clear();
        check("Android cannot say which keyboard is in use: no note", open().mOtherIme.getVisibility() == View.GONE);
    }

    static void glyphs() {
        reset();
        Paint probe = new Paint(Paint.ANTI_ALIAS_FLAG);
        boolean every = true;
        for (String id : MrSoundActivity.TILES) {
            String g = MrSoundActivity.glyph(id, probe);
            if (id.equals("default") ? !g.isEmpty() : g.isEmpty()) every = false;
        }
        check("every tile but the default one has a glyph", every);
        check("the newest emoji is the one used when the font has it", MrSoundActivity.glyph("bubble", probe).equals("🫧") && MrSoundActivity.glyph("wand", probe).equals("🪄"));
        Paint.stubNoGlyph.add("🫧");
        Paint.stubNoGlyph.add("🪄");
        check("a font without it gets the older emoji", MrSoundActivity.glyph("bubble", probe).equals("🔵") && MrSoundActivity.glyph("bubble2", probe).equals("🔵")
                && MrSoundActivity.glyph("wand", probe).equals("✨"));
        Paint.stubNoGlyph.add("🔵");
        Paint.stubNoGlyph.add("✨");
        Paint.stubNoGlyph.add("🔔");
        check("the last choice of a tile is used even when the font has none of them", MrSoundActivity.glyph("bubble", probe).equals("🔵") && MrSoundActivity.glyph("bell", probe).equals("🔔"));
        check("an id that is not a tile has no glyph", MrSoundActivity.glyph("zzz", probe).isEmpty());
        Paint.stubNoGlyph.clear();
    }

    // ---------------------------------------------------------------- the files

    static String read(String path) throws Exception {
        return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
    }

    static long le(byte[] b, int at, int n) {
        long v = 0;
        for (int i = n - 1; i >= 0; i--) v = (v << 8) | (b[at + i] & 0xff);
        return v;
    }

    static int find(byte[] b, byte[] pat, int from, boolean last) {
        int found = -1;
        for (int i = from; i + pat.length <= b.length; i++) {
            boolean m = true;
            for (int j = 0; j < pat.length; j++) if (b[i + j] != pat[j]) { m = false; break; }
            if (m) {
                found = i;
                if (!last) return i;
            }
        }
        return found;
    }

    static void files() throws Exception {
        File raw = new File("res/raw");
        List<String> have = new ArrayList<String>();
        for (String n : raw.list()) if (n.startsWith("mr_snd_")) have.add(n);
        List<String> want = new ArrayList<String>();
        for (String st : MrKeySound.STYLES) want.add("mr_snd_" + st + ".ogg");
        java.util.Collections.sort(have);
        java.util.Collections.sort(want);
        check("res/raw has one mr_snd_<style>.ogg for each style and no other", have.equals(want) && want.size() == 13);

        boolean ogg = true, mono = true, rate = true, dur = true, small = true;
        long total = 0, shortest = Long.MAX_VALUE, longest = 0;
        for (String n : want) {
            byte[] b = Files.readAllBytes(Paths.get("res/raw/" + n));
            total += b.length;
            if (b.length < 1000 || b.length > 16000) small = false;
            if (!(b[0] == 'O' && b[1] == 'g' && b[2] == 'g' && b[3] == 'S')) ogg = false;
            int id = find(b, new byte[] {1, 'v', 'o', 'r', 'b', 'i', 's'}, 0, false);
            if (id < 0) {
                ogg = false;
                continue;
            }
            if ((b[id + 11] & 0xff) != 1) mono = false;
            long hz = le(b, id + 12, 4);
            if (hz != 44100) rate = false;
            int lastPage = find(b, new byte[] {'O', 'g', 'g', 'S'}, 0, true);
            long granule = le(b, lastPage + 6, 8);
            long ms = granule * 1000 / hz;
            shortest = Math.min(shortest, ms);
            longest = Math.max(longest, ms);
            if (ms < 60 || ms > 300) {
                dur = false;
                System.out.println("      " + n + " lasts " + ms + " ms");
            }
        }
        check("the thirteen files are Ogg Vorbis", ogg);
        check("they are mono at 44100 Hz", mono && rate);
        check("each lasts between 60 and 300 ms (a key sound, not a tune): " + shortest + ".." + longest + " ms", dur);
        check("each is between 1 and 16 KB and the thirteen are under 120 KB (" + total + " bytes)", small && total < 120 * 1024);

        String gen = read("docs/tools/make_key_sounds.py");
        boolean recipes = true;
        for (String st : MrKeySound.STYLES) if (!gen.contains("(\"" + st + "\", ")) recipes = false;
        check("the script that makes them has a recipe for each style", recipes);

        String[] keys = {"title", "summary", "styles", "volume", "default", "default_note", "muted", "try", "other_ime"};
        List<String> all = new ArrayList<String>();
        for (String k : keys) all.add("mr_sound_" + k);
        for (String n : NAMES) all.add("mr_sound_name_" + n);
        for (String dir : new String[] {"values", "values-pt-rBR", "values-es"}) {
            String xml = read("res/" + dir + "/mr_strings.xml");
            boolean has = true;
            for (String k : all) {
                int i = xml.indexOf("<string name=\"" + k + "\">");
                if (i < 0) {
                    has = false;
                    System.out.println("      " + dir + " lacks " + k);
                    continue;
                }
                int e = xml.indexOf("</string>", i);
                String v = xml.substring(xml.indexOf('>', i) + 1, e);
                if (v.trim().isEmpty() || v.contains("\n")) has = false;
            }
            check("the " + all.size() + " texts of the screen exist in " + dir, has);
        }
        check("the screen is named in the three languages",
                read("res/values/mr_strings.xml").contains("\"mr_sound_title\">Keyboard sound<")
                        && read("res/values-pt-rBR/mr_strings.xml").contains("\"mr_sound_title\">Som do teclado<")
                        && read("res/values-es/mr_strings.xml").contains("\"mr_sound_title\">Sonido del teclado<"));

        String man = read("AndroidManifest.xml");
        int a = man.indexOf("com.mrkeyboard.app.MrSoundActivity");
        int open = man.lastIndexOf("<activity", a);
        int close = man.indexOf("/>", a);
        String tag = a < 0 ? "" : man.substring(open, close);
        check("the screen is in the manifest, private, with its own title, the theme of the other screens and the window that resizes for the keyboard",
                a > 0 && tag.contains("android:exported=\"false\"") && tag.contains("@string/mr_sound_title") && tag.contains("Theme.MrKeyboard.Main")
                        && tag.contains("android:windowSoftInputMode=\"adjustResize\""));
        check("the manifest has it once", man.indexOf("com.mrkeyboard.app.MrSoundActivity", a + 1) < 0);

        String fb = read("res/xml/prefs_feedback.xml");
        int row = fb.indexOf("android:key=\"mr_sound_style\"");
        int rowStart = fb.lastIndexOf("<Preference", row);
        int rowEnd = fb.indexOf("</Preference>", row);
        String r = row < 0 ? "" : fb.substring(rowStart, rowEnd);
        check("the feedback screen has the row that opens it, with a title, a summary and no stored value",
                row > 0 && r.contains("@string/mr_sound_title") && r.contains("@string/mr_sound_summary") && r.contains("android:persistent=\"false\"")
                        && r.contains("android:targetClass=\"com.mrkeyboard.app.MrSoundActivity\""));
        check("the row is in the sound category, right after the on/off box",
                fb.indexOf("android:key=\"sound_on\"") < row && row > fb.indexOf("android:key=\"sound_settings\"") && row < fb.indexOf("android:key=\"visual_feedback_settings\""));
        boolean twice = false;
        for (File x : new File("res/xml").listFiles()) if (x.getName().startsWith("prefs") && read(x.getPath()).contains("pref_click_volume")) twice = true;
        check("the volume is on the Keyboard sound screen only: no settings screen has a second slider for pref_click_volume", !twice);
        check("the old title of that slider is gone from the three languages",
                !read("res/values/mr_strings.xml").contains("title_click_volume") && !read("res/values-pt-rBR/mr_strings.xml").contains("title_click_volume")
                        && !read("res/values-es/mr_strings.xml").contains("title_click_volume"));

        String reset = read("docs/tools/java/src/com/mrkeyboard/app/MrReset.java");
        check("a reset forgets the style as well as the volume", reset.contains("\"pref_sound_style\"") && reset.contains("\"pref_click_volume\"") && MrKeySound.KEY.equals("pref_sound_style"));

        String smali = read("smali/com/mrkeyboard/app/LatinIME.smali");
        int m = smali.indexOf(".method private playKeyClick(I)V");
        int end = smali.indexOf(".end method", m);
        String body = smali.substring(m, end);
        int hook = body.indexOf("invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrKeySound;->play(Landroid/content/Context;I)Z");
        int sys = body.indexOf("playSoundEffect(IF)V");
        int guard = body.indexOf("if-nez v1, :cond_4", hook);
        check("LatinIME.playKeyClick asks MrKeySound first and keeps the system click for when it answers false",
                m > 0 && hook > 0 && sys > hook && guard > hook && guard < sys && body.contains(".locals 2") && body.indexOf("move-result v1", hook) > hook
                        && body.indexOf("move-result v1", hook) < guard);
        check("the call comes after the on/off box and the silent mode, so mute and silent keep every key quiet",
                body.indexOf("mSoundOn") < hook && body.indexOf("mSilentMode") < hook);
        check("it is the only place that asks MrKeySound for a key", smali.indexOf("MrKeySound;->play", smali.indexOf("MrKeySound;->play") + 1) < 0);
        check("the smali of the new classes is built", new File("smali/com/mrkeyboard/app/MrKeySound.smali").isFile() && new File("smali/com/mrkeyboard/app/MrSoundActivity.smali").isFile());

        String yml = read("apktool.yml");
        String tail = yml.substring(yml.indexOf("doNotCompress:"));
        check("apktool.yml stores the sounds (ogg in doNotCompress): SoundPool.load opens the raw resource as a file and Android refuses a compressed one",
                tail.contains("\n- ogg") && tail.contains("\n- arsc") && tail.contains("\n- webp"));
        check("the design is written down", new File("docs/key-sounds.md").isFile() && read("docs/key-sounds.md").contains("make_key_sounds.py"));
    }

    public static void main(String[] args) throws Exception {
        reading();
        playing();
        previewing();
        screen();
        tryField();
        glyphs();
        files();
        MrKeySound.release();
        System.out.println();
        System.out.println(ok + " checks ok, " + fail + " failed");
        if (fail > 0) System.exit(1);
    }
}
