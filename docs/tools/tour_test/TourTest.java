package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The first steps (MrTour): which steps there are (turn the keyboard on, choose it, the dictionary, the gesture file) and when the screen
 * opens, the keyboard read from Android (the list of keyboards that are on, the one in use), the dictionary of the system language
 * (English for any language the app has no dictionary for), the choices that turn an option off, the screen opening once (and again
 * while the keyboard is not on), and a failure never reaching the main screen. The downloads themselves (the catalog, the file, the install) are in the packs tests (ThreeLangTest, ModelPackTest),
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
        /** What Android answers about keyboards: the manager (the list of the ones that are on) and whether asking fails. */
        final InputMethodManager imm = new InputMethodManager();
        boolean imeFails;
        boolean noManager;
        public Object getSystemService(String name) {
            if (!Context.INPUT_METHOD_SERVICE.equals(name)) return null;
            if (imeFails) throw new IllegalStateException("no service");
            return noManager ? null : imm;
        }
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

    static final String OURS = "com.mrkeyboard.app";
    static final String OTHER = "com.example.otherime";

    /** A phone where another keyboard is on and in use, and nothing of Mr Keyboard is on: the first run. */
    static Act fresh(Prefs defaults) {
        PreferenceManager.stubDefault = defaults;
        Settings.Secure.stubValues.clear();
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, OTHER + "/.Ime");
        Act a = new Act();
        a.imm.stubEnabled.add(new InputMethodInfo(OTHER, OTHER + "/.Ime"));
        return a;
    }

    /** Mr Keyboard turned on in Android (and in use when {@code inUse}). */
    static void keyboard(Act a, boolean on, boolean inUse) {
        a.imm.stubEnabled.clear();
        a.imm.stubEnabled.add(new InputMethodInfo(OTHER, OTHER + "/.Ime"));
        if (on) a.imm.stubEnabled.add(new InputMethodInfo(OURS, OURS + "/.LatinIME"));
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, inUse ? OURS + "/.LatinIME" : OTHER + "/.Ime");
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
        keyboardInAndroid();
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

    // ---------------------------------------------------------------- the keyboard, as Android tells it
    static void keyboardInAndroid() {
        Act a = fresh(new Prefs());
        check("another keyboard on and in use: ours is neither on nor in use", !MrTour.imeEnabled(a) && !MrTour.imeSelected(a));
        keyboard(a, true, false);
        check("turned on, not in use: on yes, in use no", MrTour.imeEnabled(a) && !MrTour.imeSelected(a));
        keyboard(a, true, true);
        check("turned on and in use", MrTour.imeEnabled(a) && MrTour.imeSelected(a));
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, OURS + "/" + OURS + ".LatinIME");
        check("in use, the class written in full (package/package.Class)", MrTour.imeSelected(a));

        a = fresh(new Prefs());
        a.imm.stubEnabled.add(new InputMethodInfo(OURS + ".fake", OURS + ".fake/.LatinIME"));
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, OURS + ".fake/.LatinIME");
        check("a package that only starts with ours (com.mrkeyboard.app.fake) is not ours: not on, not in use", !MrTour.imeEnabled(a) && !MrTour.imeSelected(a));

        a = fresh(new Prefs());
        a.imeFails = true;
        check("the service of keyboards fails: on counts as done, so no step holds the person; in use still reads the setting", MrTour.imeEnabled(a) && !MrTour.imeSelected(a));
        Settings.Secure.stubValues.clear();
        check("... and with no setting to read either, both count as done", MrTour.imeEnabled(a) && MrTour.imeSelected(a));
        a = fresh(new Prefs());
        a.noManager = true;
        Settings.Secure.stubValues.clear();
        check("no manager and no value to read: both count as done", MrTour.imeEnabled(a) && MrTour.imeSelected(a));
        a = fresh(new Prefs());
        a.imm.stubEnabled = null;
        check("a manager with no list: on", MrTour.imeEnabled(a));
        check("the two steps are the ones of Android, the other two are downloads",
                MrTour.isSetup("enable") && MrTour.isSetup("select") && !MrTour.isSetup("dict") && !MrTour.isSetup("gesture") && !MrTour.isSetup(null));
        check("a list with a step of Android needs the setup, one without does not",
                MrTour.needsSetup(list("enable", "select", "dict")) && MrTour.needsSetup(list("select", "dict")) && !MrTour.needsSetup(list("dict", "gesture")) && !MrTour.needsSetup(list()));
    }

    // ---------------------------------------------------------------- which steps, and when the screen opens
    static void steps() {
        Act a = fresh(new Prefs());
        check("first run, the keyboard off, nothing downloaded, nothing changed: four steps, in this order",
                MrTour.steps(a).equals(list("enable", "select", "dict", "gesture")));
        check("first run: the screen opens", MrTour.shouldShow(a));
        check("nothing is done: the keyboard is not on, not in use, the dictionary and the recognition are not there",
                !MrTour.ready(a, "enable") && !MrTour.ready(a, "select") && !MrTour.ready(a, "dict") && !MrTour.ready(a, "gesture"));
        check("a step that does not exist counts as done", MrTour.ready(a, "word") && MrTour.ready(a, "nothing") && MrTour.ready(a, null));

        keyboard(a, true, false);
        check("the keyboard is turned on: its step goes, choosing it stays", MrTour.steps(a).equals(list("select", "dict", "gesture")) && MrTour.ready(a, "enable") && !MrTour.ready(a, "select"));
        keyboard(a, true, true);
        check("... and in use: the two downloads", MrTour.steps(a).equals(list("dict", "gesture")) && MrTour.ready(a, "select"));
        keyboard(a, false, true);
        check("in use but not on (it cannot be): both steps of Android, a keyboard that is off cannot be in use",
                MrTour.steps(a).equals(list("enable", "select", "dict", "gesture")));
        keyboard(a, true, true);

        a.packs().m.put(MrPacks.KEY_INSTALLED + "pt-BR", 2);
        check("a dictionary is installed (any language): the dictionary step goes", MrTour.steps(a).equals(list("gesture")) && MrTour.ready(a, "dict"));
        check("... and the screen still opens (the recognition is missing)", MrTour.shouldShow(a));

        a.packs().m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        check("the keyboard in use and both files there: no step at all, the screen never opens", MrTour.steps(a).isEmpty() && !MrTour.shouldShow(a) && MrTour.ready(a, "gesture"));
        keyboard(a, true, false);
        check("both files there but the keyboard not in use: only choosing it, and the screen opens", MrTour.steps(a).equals(list("select")) && MrTour.shouldShow(a));
        keyboard(a, true, true);

        a.packs().m.remove(MrPacks.KEY_INSTALLED + "pt-BR");
        check("only the recognition is there: the dictionary", MrTour.steps(a).equals(list("dict")) && MrTour.shouldShow(a));
        a.packs().m.remove(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE);

        Prefs d = new Prefs();
        a = fresh(d);
        keyboard(a, true, true);
        d.m.put("show_suggestions", Boolean.FALSE);
        check("suggestions turned off by the person: no dictionary step", MrTour.steps(a).equals(list("gesture")));
        d.m.put("pref_gesture_typing", Boolean.FALSE);
        check("... and gesture typing off too: nothing to ask", MrTour.steps(a).isEmpty() && !MrTour.shouldShow(a));
        d.m.put("show_suggestions", Boolean.TRUE);
        check("suggestions on, gesture typing off: the dictionary", MrTour.steps(a).equals(list("dict")));
        d.m.put("pref_gesture_typing", Boolean.TRUE);
        d.m.put("pref_word_delete", Boolean.TRUE);
        check("delete by word has no step, on or off", MrTour.steps(a).equals(list("dict", "gesture")));
        d.m.put("pref_word_delete", Boolean.FALSE);
        check("... off or on, the same", MrTour.steps(a).equals(list("dict", "gesture")));
        keyboard(a, false, false);
        d.m.put("show_suggestions", Boolean.FALSE);
        d.m.put("pref_gesture_typing", Boolean.FALSE);
        check("the options off but the keyboard not on: the two steps of Android are still asked", MrTour.steps(a).equals(list("enable", "select")) && MrTour.shouldShow(a));

        a = fresh(new Prefs());
        MrTour.markDone(a);
        check("already shown: never again, whatever is missing", MrTour.done(a) && !MrTour.shouldShow(a) && MrTour.steps(a).size() == 4);

        PreferenceManager.stubDefault = null;
        a = fresh(null);
        PreferenceManager.stubDefault = null;
        check("no preferences to read: the defaults (all on), the four steps", MrTour.steps(a).equals(list("enable", "select", "dict", "gesture")));
    }

    // ---------------------------------------------------------------- the choices
    static void choices() {
        Prefs d = new Prefs();
        Act a = fresh(d);
        keyboard(a, true, true);
        MrTour.turnOff(a, "dict");
        check("Turn off suggestions: show_suggestions is false", Boolean.FALSE.equals(d.m.get("show_suggestions")) && d.m.size() == 1);
        MrTour.turnOff(a, "gesture");
        check("Turn off gesture typing: pref_gesture_typing is false", Boolean.FALSE.equals(d.m.get("pref_gesture_typing")) && d.m.size() == 2);
        MrTour.turnOff(a, "word");
        MrTour.turnOff(a, "enable");
        MrTour.turnOff(a, "select");
        MrTour.turnOff(a, "nothing");
        MrTour.turnOff(a, null);
        check("delete by word, the steps of Android and a step that does not exist change nothing", d.m.size() == 2 && !d.m.containsKey("pref_word_delete"));
        check("the keys are the ones the keyboard reads", MrTour.KEY_SUGGESTIONS.equals("show_suggestions") && MrGestureInput.PREF_ON.equals("pref_gesture_typing"));
        check("off, they leave the steps: nothing to ask", MrTour.steps(a).isEmpty());
        PreferenceManager.stubDefault = null;
        MrTour.turnOff(new Act(), "dict");
        check("no preferences to write: no fault", true);
    }

    // ---------------------------------------------------------------- the screen opening
    static void opening() {
        Act a = fresh(new Prefs());
        MrTour.onOpen(a);
        check("the main screen opens on a first run: the first steps start, as a screen of the app (reusing an open copy)",
                a.started.size() == 1 && MrTourActivity.class.getName().equals(a.started.get(0).className)
                && (a.started.get(0).flags & Intent.FLAG_ACTIVITY_REORDER_TO_FRONT) != 0 && (a.started.get(0).flags & Intent.FLAG_ACTIVITY_NEW_TASK) == 0);
        check("... and it is NOT marked as done: the keyboard is not on yet, so it comes back", !MrTour.done(a));
        MrTour.onOpen(a);
        check("the app opened again with the keyboard still off: the screen is shown again", a.started.size() == 2 && !MrTour.done(a));
        MrTour.markDone(a);
        MrTour.onOpen(a);
        check("closed by the person (Skip, Back or the last button marks it): it does not come back", a.started.size() == 2 && MrTour.done(a));

        a = fresh(new Prefs());
        keyboard(a, true, false);
        MrTour.onOpen(a);
        check("the keyboard is on but not in use: the screen opens and is not marked either", a.started.size() == 1 && !MrTour.done(a));

        a = fresh(new Prefs());
        keyboard(a, true, true);
        MrTour.onOpen(a);
        check("the keyboard is ready and only downloads are left: the screen starts and is marked as done at once", a.started.size() == 1 && MrTour.done(a));
        MrTour.onOpen(a);
        MrTour.onOpen(a);
        check("the main screen turned or opened again: the screen does not come back", a.started.size() == 1);

        a = fresh(new Prefs());
        keyboard(a, true, true);
        a.packs().m.put(MrPacks.KEY_INSTALLED + "en-US", 1);
        a.packs().m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        MrTour.onOpen(a);
        check("everything done: the screen does not open and nothing is marked", a.started.isEmpty() && !MrTour.done(a));

        a = fresh(new Prefs());
        a.startFails = true;
        MrTour.onOpen(a);
        check("the screen cannot start: no fault reaches the main screen, and it is tried again at the next opening", a.started.isEmpty() && !MrTour.done(a));
        keyboard(a, true, true);
        MrTour.onOpen(a);
        check("... with only downloads left it is not marked either when it cannot start", a.started.isEmpty() && !MrTour.done(a));

        a = fresh(new Prefs());
        a.imeFails = true;
        Settings.Secure.stubValues.clear();
        MrTour.onOpen(a);
        check("Android cannot be asked about keyboards: only the downloads, the screen opens and is marked", a.started.size() == 1 && MrTour.done(a));

        PreferenceManager.stubDefault = null;
        a = fresh(null);
        PreferenceManager.stubDefault = null;
        MrTour.onOpen(a);
        check("no preferences: the defaults, the screen opens", a.started.size() == 1);
    }
}
