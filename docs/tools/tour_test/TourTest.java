package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The first steps (MrTour): which steps there are and when the screen opens, the dictionary of the system language (English for any
 * language the app has no dictionary for), the choices that turn an option off, the screen opening once, and a failure never reaching
 * the main screen. The downloads themselves (the catalog, the file, the install) are in the packs tests (ThreeLangTest, ModelPackTest),
 * which run the same MrTour.work with the real classes of the APK and a fake network.
 */
public class TourTest {
    static int oks, fails;

    static void check(String name, boolean ok) {
        if (ok) {
            oks++;
            System.out.println("OK    " + name);
        } else {
            fails++;
            System.out.println("FAIL  " + name);
        }
    }

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

    /** The main screen: preference files by name, and the screens it was asked to start. */
    static class Act extends Activity {
        final Map<String, Prefs> files = new HashMap<String, Prefs>();
        final List<Intent> started = new ArrayList<Intent>();
        boolean startFails;
        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public android.content.res.Resources getResources() { return null; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) {
            Prefs p = files.get(name);
            if (p == null) {
                p = new Prefs();
                files.put(name, p);
            }
            return p;
        }
        public void startActivity(Intent i) {
            if (startFails) throw new IllegalStateException("no screen");
            started.add(i);
        }
        Prefs packs() { return (Prefs) getSharedPreferences(MrPacks.PREFS, 0); }
        Prefs tour() { return (Prefs) getSharedPreferences(MrTour.PREFS, 0); }
    }

    static Act fresh(Prefs defaults) {
        PreferenceManager.stubDefault = defaults;
        return new Act();
    }

    static MrPacks.Catalog catalog(String... ids) {
        MrPacks.Catalog c = new MrPacks.Catalog();
        for (String id : ids) {
            MrPacks.Pack p = new MrPacks.Pack();
            p.id = id;
            c.packs.add(p);
        }
        return c;
    }

    static List<String> list(String... s) {
        return Arrays.asList(s);
    }

    public static void main(String[] args) {
        packFor();
        steps();
        choices();
        opening();
        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAILURE(S)");
        System.exit(fails == 0 ? 0 : 1);
    }

    // ---------------------------------------------------------------- the dictionary of the system language
    static void packFor() {
        MrPacks.Catalog three = catalog("pt-BR", "en-US", "es");
        String[][] table = {
                {"pt", "BR", "pt-BR"}, {"pt", "PT", "pt-BR"}, {"en", "US", "en-US"}, {"en", "GB", "en-US"}, {"es", "ES", "es"}, {"es", "MX", "es"},
                {"es", "", "es"}, {"PT", "br", "pt-BR"},
                // a language with no dictionary gets English, whatever the region
                {"fr", "FR", "en-US"}, {"de", "DE", "en-US"}, {"ja", "JP", "en-US"}, {"zh", "", "en-US"}, {"", "", "en-US"}, {null, null, "en-US"}};
        for (String[] t : table) {
            check("language " + t[0] + "_" + t[1] + " -> " + t[2] + " (catalog of three)", t[2].equals(MrTour.packFor(three, t[0], t[1])));
            check("language " + t[0] + "_" + t[1] + " -> " + t[2] + " (no catalog yet: the three the app knows)", t[2].equals(MrTour.packFor(null, t[0], t[1])));
        }
        MrPacks.Catalog more = catalog("pt-BR", "pt-PT", "en-US", "en-GB", "es");
        check("the region of the system comes first (pt_PT -> pt-PT)", "pt-PT".equals(MrTour.packFor(more, "pt", "PT")));
        check("a region the catalog has not: the first of the language (pt_AO -> pt-BR)", "pt-BR".equals(MrTour.packFor(more, "pt", "AO")));
        check("English with the region of the system (en_GB -> en-GB)", "en-GB".equals(MrTour.packFor(more, "en", "GB")));
        check("French with English in the catalog: the first English one, en-US", "en-US".equals(MrTour.packFor(more, "fr", "FR")));
        check("a catalog with no English and no pack of the language: none", MrTour.packFor(catalog("es", "pt-BR"), "fr", "FR") == null);
        check("a catalog with no English, the language is there: its pack", "es".equals(MrTour.packFor(catalog("es", "pt-BR"), "es", "ES")));
        check("an empty catalog: none", MrTour.packFor(catalog(), "pt", "BR") == null);
    }

    // ---------------------------------------------------------------- which steps, and when the screen opens
    static void steps() {
        Act a = fresh(new Prefs());
        check("first run, nothing downloaded, nothing changed: three steps, in this order", MrTour.steps(a).equals(list("dict", "gesture", "word")));
        check("first run: the screen opens", MrTour.shouldShow(a));
        check("nothing is downloaded: the dictionary and the recognition are not ready, delete by word needs none",
                !MrTour.ready(a, "dict") && !MrTour.ready(a, "gesture") && MrTour.ready(a, "word"));

        a.packs().m.put(MrPacks.KEY_INSTALLED + "pt-BR", 2);
        check("a dictionary is installed (any language): the dictionary step goes", MrTour.steps(a).equals(list("gesture", "word")) && MrTour.ready(a, "dict"));
        check("... and the screen still opens (the recognition is missing)", MrTour.shouldShow(a));

        a.packs().m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        check("both files are there: no step at all, the screen never opens", MrTour.steps(a).isEmpty() && !MrTour.shouldShow(a) && MrTour.ready(a, "gesture"));

        a.packs().m.remove(MrPacks.KEY_INSTALLED + "pt-BR");
        check("only the recognition is there: the dictionary and delete by word", MrTour.steps(a).equals(list("dict", "word")) && MrTour.shouldShow(a));
        a.packs().m.remove(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE);

        Prefs d = new Prefs();
        a = fresh(d);
        d.m.put("show_suggestions", Boolean.FALSE);
        check("suggestions turned off by the person: no dictionary step", MrTour.steps(a).equals(list("gesture", "word")));
        d.m.put("pref_gesture_typing", Boolean.FALSE);
        check("... and gesture typing off too: nothing to ask, not even delete by word alone", MrTour.steps(a).isEmpty() && !MrTour.shouldShow(a));
        d.m.put("show_suggestions", Boolean.TRUE);
        check("suggestions on, gesture typing off: the dictionary and delete by word", MrTour.steps(a).equals(list("dict", "word")));
        d.m.put("pref_word_delete", Boolean.FALSE);
        check("delete by word off by the person: only the dictionary", MrTour.steps(a).equals(list("dict")) && MrTour.shouldShow(a));
        d.m.put("pref_gesture_typing", Boolean.TRUE);
        check("the recognition on again: the two downloads, no choice about delete by word", MrTour.steps(a).equals(list("dict", "gesture")));

        a = fresh(new Prefs());
        MrTour.markDone(a);
        check("already shown: never again, whatever is missing", MrTour.done(a) && !MrTour.shouldShow(a) && MrTour.steps(a).size() == 3);

        PreferenceManager.stubDefault = null;
        a = new Act();
        check("no preferences to read: the defaults (all on), the three steps", MrTour.steps(a).equals(list("dict", "gesture", "word")));
    }

    // ---------------------------------------------------------------- the choices
    static void choices() {
        Prefs d = new Prefs();
        Act a = fresh(d);
        MrTour.turnOff(a, "dict");
        check("Turn off suggestions: show_suggestions is false", Boolean.FALSE.equals(d.m.get("show_suggestions")) && d.m.size() == 1);
        MrTour.turnOff(a, "gesture");
        check("Turn off gesture typing: pref_gesture_typing is false", Boolean.FALSE.equals(d.m.get("pref_gesture_typing")) && d.m.size() == 2);
        MrTour.turnOff(a, "word");
        check("Turn off delete by word: pref_word_delete is false", Boolean.FALSE.equals(d.m.get("pref_word_delete")) && d.m.size() == 3);
        MrTour.turnOff(a, "nothing");
        MrTour.turnOff(a, null);
        check("a step that does not exist changes nothing", d.m.size() == 3);
        check("the keys are the ones the keyboard reads",
                MrTour.KEY_SUGGESTIONS.equals("show_suggestions") && MrGestureInput.PREF_ON.equals("pref_gesture_typing") && MrWordDelete.PREF_ON.equals("pref_word_delete"));
        check("off, they leave the steps: nothing to ask", MrTour.steps(a).isEmpty());
        PreferenceManager.stubDefault = null;
        MrTour.turnOff(new Act(), "dict");
        check("no preferences to write: no fault", true);
    }

    // ---------------------------------------------------------------- the screen opening
    static void opening() {
        Act a = fresh(new Prefs());
        MrTour.onOpen(a);
        check("the main screen opens: the first steps start once, as a screen of the app (reusing an open copy)",
                a.started.size() == 1 && MrTourActivity.class.getName().equals(a.started.get(0).className)
                && (a.started.get(0).flags & Intent.FLAG_ACTIVITY_REORDER_TO_FRONT) != 0 && (a.started.get(0).flags & Intent.FLAG_ACTIVITY_NEW_TASK) == 0);
        check("... and it is marked as done", MrTour.done(a));
        MrTour.onOpen(a);
        MrTour.onOpen(a);
        check("the main screen turned or opened again: the screen does not come back", a.started.size() == 1);

        a = fresh(new Prefs());
        a.packs().m.put(MrPacks.KEY_INSTALLED + "en-US", 1);
        a.packs().m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        MrTour.onOpen(a);
        check("everything downloaded: the screen does not open and nothing is marked", a.started.isEmpty() && !MrTour.done(a));

        a = fresh(new Prefs());
        a.startFails = true;
        MrTour.onOpen(a);
        check("the screen cannot start: no fault reaches the main screen, and it is tried again at the next opening", a.started.isEmpty() && !MrTour.done(a));

        PreferenceManager.stubDefault = null;
        a = new Act();
        MrTour.onOpen(a);
        check("no preferences: the defaults, the screen opens", a.started.size() == 1);
    }
}
