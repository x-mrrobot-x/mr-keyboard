package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

/**
 * The first steps (the rules; the screen is MrTourActivity).
 *
 * <p>A new keyboard has to be turned on in Android and chosen as the one to type with, and suggestions and gesture typing, which are on
 * by default, need two files that the APK does not carry (the dictionary of the language and the gesture recognition). The screen "First
 * steps" asks for all of it, one step at a time ("Step 1 of 4"): do it, turn the option off, or skip everything.
 *
 * <p>Steps, in this order, each only when it still has something to ask:
 * <ul>
 * <li>{@link #ENABLE}: Mr Keyboard is not in the list of keyboards that are turned on. The button opens the keyboard settings of Android.</li>
 * <li>{@link #SELECT}: it is not the keyboard in use (always there when {@link #ENABLE} is). The button opens the picker of Android.</li>
 * <li>{@link #DICT}: suggestions are on and no dictionary is installed. Downloads the dictionary of the system language (English
 * when the system language is not one of Portuguese, English or Spanish).</li>
 * <li>{@link #GESTURE}: gesture typing is on and the recognition file is not installed.</li>
 * </ul>
 * Delete by word is on by default and needs nothing, so it has no step. The screen opens when at least one step is left
 * ({@link #shouldShow}): a phone where the keyboard is in use and everything is downloaded, or turned off by the person, never sees it.
 *
 * <p>It is shown once. A screen that only asks for downloads is marked as done as soon as it starts. While the keyboard is not turned on
 * and chosen it comes back at every opening of the app, because without those two steps there is no keyboard to type with: it is marked
 * as done when the person leaves the two steps (the screen does it) or closes it (Skip, Back, the last button).
 *
 * <p>The network is used only by the button "Download" of a step ({@link #download}): the catalog first, then the file, the same
 * calls and checks of the dictionaries screen (MrPacks), which sees the same job (MrPacks.sJobId, sJobPercent). The state of a
 * download lives here, in statics, so that it survives the screen being rebuilt and the screen is closed with the job still running.
 * The two steps of Android read the system (which keyboards are on, which is in use) and never connect.
 */
final class MrTour {
    static final String PREFS = "mr_tour";
    static final String KEY_DONE = "done";
    static final String ENABLE = "enable";
    static final String SELECT = "select";
    static final String DICT = "dict";
    static final String GESTURE = "gesture";
    /** The setting of the suggestions (LatinIME reads it with the same name). */
    static final String KEY_SUGGESTIONS = "show_suggestions";

    /** A download is running (the step in sStep); the screen polls it with MrPacks.sJobPercent and sJobInstalling. */
    static volatile boolean sBusy;
    static volatile String sStep;
    /** The text of the last failure and the step it belongs to; cleared when a download starts. */
    static volatile String sError;
    static volatile String sErrorStep;

    private MrTour() { }

    // ------------------------------------------------------------------ what to ask

    private static SharedPreferences defaults(Context c) {
        return PreferenceManager.getDefaultSharedPreferences(c);
    }

    static boolean done(Context c) {
        SharedPreferences p = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
        return p != null && p.getBoolean(KEY_DONE, false);
    }

    static void markDone(Context c) {
        SharedPreferences p = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
        if (p != null) p.edit().putBoolean(KEY_DONE, true).commit();
    }

    /** The two steps of Android (the keyboard turned on, the keyboard in use); the others are downloads. */
    static boolean isSetup(String step) {
        return ENABLE.equals(step) || SELECT.equals(step);
    }

    /** Is there a step of Android in the list. */
    static boolean needsSetup(List<String> steps) {
        return steps.contains(ENABLE) || steps.contains(SELECT);
    }

    /**
     * Is Mr Keyboard in the list of keyboards that Android has turned on. When Android cannot be asked the answer is yes: a step that
     * cannot be seen to end must not hold the person.
     */
    static boolean imeEnabled(Context c) {
        try {
            Object o = c.getSystemService(Context.INPUT_METHOD_SERVICE);
            if (!(o instanceof InputMethodManager)) return true;
            List<InputMethodInfo> list = ((InputMethodManager) o).getEnabledInputMethodList();
            if (list == null) return true;
            String pkg = c.getPackageName();
            for (InputMethodInfo i : list) if (pkg != null && pkg.equals(i.getPackageName())) return true;
            return false;
        } catch (RuntimeException e) {
            return true;
        }
    }

    /** Is Mr Keyboard the keyboard in use ("default_input_method" is "package/class"). Unknown: yes, as above. */
    static boolean imeSelected(Context c) {
        try {
            String id = Settings.Secure.getString(c.getContentResolver(), Settings.Secure.DEFAULT_INPUT_METHOD);
            String pkg = c.getPackageName();
            if (id == null || pkg == null) return true;
            return id.startsWith(pkg + "/");
        } catch (RuntimeException e) {
            return true;
        }
    }

    /** Is the step done: the keyboard turned on or in use, the file of a download on the phone. */
    static boolean ready(Context c, String step) {
        if (ENABLE.equals(step)) return imeEnabled(c);
        if (SELECT.equals(step)) return imeSelected(c);
        if (DICT.equals(step)) return !MrPacks.installedIds(c).isEmpty();
        if (GESTURE.equals(step)) return MrPacks.modelVersion(c, MrPacks.MODEL_GESTURE) > 0;
        return true;
    }

    /** The steps that still have something to ask, in order (empty: nothing to show). */
    static ArrayList<String> steps(Context c) {
        ArrayList<String> out = new ArrayList<String>();
        boolean enabled = imeEnabled(c);
        if (!enabled) out.add(ENABLE);
        if (!enabled || !imeSelected(c)) out.add(SELECT);   // a keyboard that is off cannot be in use
        SharedPreferences sp = defaults(c);
        boolean on = sp == null;                     // no preferences to read: the defaults, which are on
        if (on || sp.getBoolean(KEY_SUGGESTIONS, true)) {
            if (!ready(c, DICT)) out.add(DICT);
        }
        if (on || sp.getBoolean(MrGestureInput.PREF_ON, true)) {
            if (!ready(c, GESTURE)) out.add(GESTURE);
        }
        return out;
    }

    /** The screen opens when it has not been shown and at least one step is left. */
    static boolean shouldShow(Context c) {
        return !done(c) && !steps(c).isEmpty();
    }

    /**
     * The main screen was opened (smali, Main.onCreate): shows the first steps once. A failure here never stops the screen. With a step of
     * Android in the list it is not marked as done here (see the class text); otherwise it is, after the start.
     */
    static void onOpen(Activity a) {
        try {
            if (done(a)) return;
            ArrayList<String> s = steps(a);
            if (s.isEmpty()) return;
            a.startActivity(MrNav.intent(a, MrTourActivity.class));
            if (!needsSetup(s)) markDone(a);   // after the start: a screen that could not open is tried again at the next opening
        } catch (RuntimeException e) {
            // a courtesy: never bring the main screen down
        }
    }

    /** "Turn off" of a download step: the option goes off and the keyboard follows (its listeners read the setting). */
    static void turnOff(Context c, String step) {
        SharedPreferences sp = defaults(c);
        if (sp == null) return;
        String key = DICT.equals(step) ? KEY_SUGGESTIONS : GESTURE.equals(step) ? MrGestureInput.PREF_ON : null;
        if (key != null) sp.edit().putBoolean(key, false).commit();
    }

    // ------------------------------------------------------------------ the dictionary of the system language

    /** The language that a system language without a dictionary falls back to. */
    static final String FALLBACK_LANGUAGE = "en";
    static final String FALLBACK_COUNTRY = "US";

    /**
     * The id of the pack for a language: the one of the same region first ("pt_BR" -> pt-BR), else the first of the same language, else
     * the English one (a system language that has no dictionary, like French, gets English), else null (a catalog with no English
     * either). The catalog is the one seen so far; without one, the three the app knows.
     */
    static String packFor(MrPacks.Catalog cat, String language, String country) {
        List<String> ids = new ArrayList<String>();
        if (cat != null) {
            for (MrPacks.Pack p : cat.packs) ids.add(p.id);
        } else {
            ids.addAll(Arrays.asList(MrPacks.DEFAULT_IDS));
        }
        String id = pick(ids, language, country);
        return id != null ? id : pick(ids, FALLBACK_LANGUAGE, FALLBACK_COUNTRY);
    }

    /** The id of the list for a language and region (the same region first, else the first of the language), or null. */
    private static String pick(List<String> ids, String language, String country) {
        String lang = language == null ? "" : language.toLowerCase(Locale.ROOT);
        String reg = country == null ? "" : country.toUpperCase(Locale.ROOT);
        if (lang.length() == 0) return null;
        String best = null;
        for (String id : ids) {
            String[] p = MrPacks.splitLocale(id);
            if (!p[0].equals(lang)) continue;
            if (p[1].equals(reg)) return id;
            if (best == null) best = id;
        }
        return best;
    }

    /** The id of the dictionary that the screen is about to offer (the catalog already seen, if any), or null. */
    static String packIdForSystem(Context c) {
        Locale l = Locale.getDefault();
        return packFor(MrPacks.cachedCatalog(c), l.getLanguage(), l.getCountry());
    }

    // ------------------------------------------------------------------ the download

    /**
     * The button "Download" of a step: the catalog, then the file, off the main thread. Does nothing while another job runs. When
     * it ends, {@link #sBusy} is false and {@link #sError} says why it failed (null: it worked, and what the option needs is in place).
     */
    static void download(final Context c, final String step) {
        if (sBusy || MrPacks.sJobId != null) return;
        final Context app = c.getApplicationContext() != null ? c.getApplicationContext() : c;
        final Locale locale = Locale.getDefault();
        sBusy = true;
        sStep = step;
        sError = null;
        sErrorStep = null;
        MrPacks.sJobPercent = 0;
        MrPacks.sJobInstalling = false;
        new Thread(new Runnable() {
            public void run() {
                String err = null;
                try {
                    err = work(app, step, locale);
                } catch (RuntimeException e) {
                    err = MrPacks.text(app, "mr_dicts_err_io", e.getClass().getSimpleName());
                    if (err == null) err = "mr_dicts_err_io";
                } finally {
                    sError = err;
                    sErrorStep = err == null ? null : step;
                    sBusy = false;
                }
            }
        }, "MrTour").start();
    }

    /** The work of the thread: the text of the failure, or null. Separate so that a test can run it in the calling thread. */
    static String work(Context app, String step, Locale locale) {
        try {
            MrPacks.Catalog cat = MrPacks.fetchCatalog(app);
            if (GESTURE.equals(step)) {
                MrPacks.Pack m = cat.model(MrPacks.MODEL_GESTURE);
                if (m == null) throw new MrPacks.PackException("mr_tour_no_gesture");
                MrPacks.install(app, cat, m);
                return null;
            }
            String id = packFor(cat, locale.getLanguage(), locale.getCountry());
            MrPacks.Pack p = id == null ? null : cat.find(id);
            if (p == null) throw new MrPacks.PackException("mr_tour_no_pack");
            MrPacks.install(app, cat, p);
            SharedPreferences sp = defaults(app);
            if (sp != null) sp.edit().putBoolean(KEY_SUGGESTIONS, true).apply();
            ArrayList<String> catIds = new ArrayList<String>();
            for (MrPacks.Pack q : cat.packs) catIds.add(q.id);
            MrPacks.syncLanguages(app, MrPacks.cardIds(catIds, MrPacks.installedIds(app), locale.getLanguage()));
            return null;
        } catch (MrPacks.PackException e) {
            String s = MrPacks.text(app, e.key, e.args);
            return s != null ? s : e.key;
        }
    }
}
