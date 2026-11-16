package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

/**
 * The first steps (the rules; the screen is MrTourActivity).
 *
 * <p>Word suggestions, gesture typing and delete by word are on by default, but the first two need a file that the APK does not carry
 * (the dictionary of the language and the gesture recognition). The first time the app is opened with one of them still missing, the
 * screen "First steps" offers them in steps ("Step 1 of 3"): download, turn the option off, or skip it all. The screen is shown once:
 * it is marked as done as soon as it starts, so turning the phone, closing it with Back or "Skip" never brings it back.
 *
 * <p>Steps, in this order, each only when it still has something to ask:
 * <ul>
 * <li>{@link #DICT}: suggestions are on and no dictionary is installed. Downloads the dictionary of the system language (English
 * when the system language is not one of Portuguese, English or Spanish).</li>
 * <li>{@link #GESTURE}: gesture typing is on and the recognition file is not installed.</li>
 * <li>{@link #WORD}: delete by word is still on; only when one of the two steps above is there (it is a choice, not a download).</li>
 * </ul>
 * The screen opens only for a download step ({@link #shouldShow}); an app that has what it needs, or whose person already turned the
 * options off, never sees it.
 *
 * <p>The network is used only by the button "Download" of a step ({@link #download}): the catalog first, then the file, the same
 * calls and checks of the dictionaries screen (MrPacks), which sees the same job (MrPacks.sJobId, sJobPercent). The state of a
 * download lives here, in statics, so that it survives the screen being rebuilt and the screen is closed with the job still running.
 */
final class MrTour {
    static final String PREFS = "mr_tour";
    static final String KEY_DONE = "done";
    static final String DICT = "dict";
    static final String GESTURE = "gesture";
    static final String WORD = "word";
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

    /** Is the file of the step on the phone (for {@link #WORD}, always: there is nothing to download). */
    static boolean ready(Context c, String step) {
        if (DICT.equals(step)) return !MrPacks.installedIds(c).isEmpty();
        if (GESTURE.equals(step)) return MrPacks.modelVersion(c, MrPacks.MODEL_GESTURE) > 0;
        return true;
    }

    /** The steps that still have something to ask, in order (empty: nothing to show). */
    static ArrayList<String> steps(Context c) {
        ArrayList<String> out = new ArrayList<String>();
        SharedPreferences sp = defaults(c);
        boolean on = sp == null;                     // no preferences to read: the defaults, which are on
        if (on || sp.getBoolean(KEY_SUGGESTIONS, true)) {
            if (!ready(c, DICT)) out.add(DICT);
        }
        if (on || sp.getBoolean(MrGestureInput.PREF_ON, true)) {
            if (!ready(c, GESTURE)) out.add(GESTURE);
        }
        if (!out.isEmpty() && (on || sp.getBoolean(MrWordDelete.PREF_ON, true))) out.add(WORD);
        return out;
    }

    /** The screen opens when it has not been shown and a file is still missing for an option that is on. */
    static boolean shouldShow(Context c) {
        if (done(c)) return false;
        ArrayList<String> s = steps(c);
        return s.contains(DICT) || s.contains(GESTURE);
    }

    /** The main screen was opened (smali, Main.onCreate): shows the first steps once. A failure here never stops the screen. */
    static void onOpen(Activity a) {
        try {
            if (!shouldShow(a)) return;
            a.startActivity(MrNav.intent(a, MrTourActivity.class));
            markDone(a);   // after the start: a screen that could not open is tried again at the next opening
        } catch (RuntimeException e) {
            // a courtesy: never bring the main screen down
        }
    }

    /** "Turn off" of a step: the option goes off and the keyboard follows (its listeners read the setting). */
    static void turnOff(Context c, String step) {
        SharedPreferences sp = defaults(c);
        if (sp == null) return;
        String key = DICT.equals(step) ? KEY_SUGGESTIONS : GESTURE.equals(step) ? MrGestureInput.PREF_ON : WORD.equals(step) ? MrWordDelete.PREF_ON : null;
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
