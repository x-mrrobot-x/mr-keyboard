package com.mrkeyboard.app;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.io.File;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The screen of the first steps (MrTourActivity) run for real on the PC, against the stubs of Android: the views are built, the texts
 * and the buttons are read from them and the buttons are pressed. The stubs have no drawing and no clock (an animation ends the moment it
 * starts), so this shows what the screen SAYS and DOES, not how it looks or moves: the step in view, the counter, the chip, the label and
 * the action of the main button, the quiet button, the note, the move from one step to the next, the follow-up of a step of Android when
 * the person comes back, the progress of a download, a failure and the retry, the end, Skip, a screen that is rebuilt, a phone with
 * nothing to ask. The rules that decide the steps are in TourTest.
 */
public class TourScreenTest {
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

    /** Resources that know every name: the id of a name is stable, a string answers its own name (and its arguments). */
    static class Res extends Resources {
        final Map<String, Integer> ids = new HashMap<String, Integer>();
        final Map<Integer, String> names = new HashMap<Integer, String>();
        final DisplayMetrics dm = new DisplayMetrics();

        Res() {
            dm.density = 2f;
            dm.widthPixels = 1080;
        }

        public int getIdentifier(String name, String type, String pkg) {
            String key = type + ":" + name;
            Integer id = ids.get(key);
            if (id == null) {
                id = ids.size() + 1;
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

    /** The screen, with the preferences, the keyboard manager and the starts of screens that a phone would give it. */
    static class Screen extends MrTourActivity {
        final Res res = new Res();
        final Map<String, TourTest.Prefs> files = new HashMap<String, TourTest.Prefs>();
        final List<Intent> started = new ArrayList<Intent>();
        final InputMethodManager imm = new InputMethodManager();
        boolean startFails;
        int finishes;

        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) {
            TourTest.Prefs p = files.get(name);
            if (p == null) {
                p = new TourTest.Prefs();
                files.put(name, p);
            }
            return p;
        }
        public void startActivity(Intent i) {
            if (startFails) throw new IllegalStateException("no screen");
            started.add(i);
        }
        public Object getSystemService(String name) { return Context.INPUT_METHOD_SERVICE.equals(name) ? imm : null; }
        public void finish() {
            finishes++;
            super.finish();
        }
        TourTest.Prefs packs() { return (TourTest.Prefs) getSharedPreferences(MrPacks.PREFS, 0); }
    }

    // ---------------------------------------------------------------- helpers

    static Object f(Object o, String name) {
        try {
            Field fl = MrTourActivity.class.getDeclaredField(name);
            fl.setAccessible(true);
            return fl.get(o);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    static String text(Screen s, String field) { return String.valueOf(((TextView) f(s, field)).getText()); }
    static View view(Screen s, String field) { return (View) f(s, field); }
    /** How much of the pill of the main button shows as the download fill (0 to 10000). */
    static int fill(Screen s) { return ((android.graphics.drawable.ClipDrawable) f(s, "mFillClip")).getLevel(); }

    /** What the poll of the screen does in a while: runs what the handler has pending, a few times. */
    static void pump(Screen s) {
        Handler h = (Handler) f(s, "mHandler");
        for (int i = 0; i < 4; i++) h.stubRunOnce();
    }

    /** The person comes back to the screen (from the settings of Android or from another screen of the app). */
    static void back(Screen s) {
        s.onResume();
        pump(s);
    }

    static Screen open(TourTest.Prefs defaults, boolean kbOn, boolean kbInUse, Bundle state) {
        PreferenceManager.stubDefault = defaults;
        MrTour.sBusy = false;
        MrTour.sStep = null;
        MrTour.sError = null;
        MrTour.sErrorStep = null;
        MrPacks.sJobPercent = 0;
        MrPacks.sJobInstalling = false;
        Settings.Secure.stubValues.clear();
        Screen s = new Screen();
        s.imm.stubEnabled.add(new InputMethodInfo(TourTest.OTHER, TourTest.OTHER + "/.Ime"));
        if (kbOn) s.imm.stubEnabled.add(new InputMethodInfo(TourTest.OURS, TourTest.OURS + "/.LatinIME"));
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, kbInUse ? TourTest.OURS + "/.LatinIME" : TourTest.OTHER + "/.Ime");
        s.onCreate(state);
        return s;
    }

    static void turnOn(Screen s) {
        s.imm.stubEnabled.add(new InputMethodInfo(TourTest.OURS, TourTest.OURS + "/.LatinIME"));
    }

    static void useIt() {
        Settings.Secure.stubValues.put(Settings.Secure.DEFAULT_INPUT_METHOD, TourTest.OURS + "/.LatinIME");
    }

    static boolean step(Screen s, int n, int of, String title) {
        return text(s, "mCounter").equals("mr_tour_step[" + n + ", " + of + "]") && text(s, "mTitle").equals("mr_tour_" + title + "_title")
                && text(s, "mText").equals("mr_tour_" + title + "_text");
    }

    public static void main(String[] args) {
        fullWalk();
        downloads();
        skipAndEnd();
        rebuilt();
        nothingToAsk();
        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAILURE(S)");
        System.exit(fails == 0 ? 0 : 1);
    }

    // ---------------------------------------------------------------- a fresh phone, step by step
    static void fullWalk() {
        TourTest.Prefs d = new TourTest.Prefs();
        Screen s = open(d, false, false, null);
        check("the screen is built and its content set", s.finishes == 0 && view(s, "mBody") != null);
        check("step 1 of 4: turn the keyboard on", step(s, 1, 4, "enable"));
        check("... the bar has one segment for each step", ((List<?>) f(s, "mFills")).size() == 4);
        check("... the chip says it is off in Android, the main button opens the settings", text(s, "mChipText").equals("mr_tour_enable_missing") && text(s, "mPrimaryLabel").equals("mr_tour_enable_open"));
        check("... no quiet button (the steps of Android cannot be turned off), a note instead",
                view(s, "mSecondary").getVisibility() == View.GONE && text(s, "mNote").equals("mr_tour_enable_note") && view(s, "mNote").getVisibility() == View.VISIBLE);
        check("... the first step of a phone with no keyboard is not marked as done: it comes back until the keyboard is on", !MrTour.done(s));

        view(s, "mPrimary").performClick();
        check("the button opens the keyboard settings of Android", s.started.size() == 1 && Settings.ACTION_INPUT_METHOD_SETTINGS.equals(s.started.get(0).action));
        pump(s);
        check("... and while the person is there nothing changes on the screen", text(s, "mChipText").equals("mr_tour_enable_missing") && step(s, 1, 4, "enable"));
        s.startFails = true;
        view(s, "mPrimary").performClick();
        check("the settings of Android cannot be opened: a message, no fault", s.started.size() == 1);
        s.startFails = false;

        turnOn(s);
        back(s);
        check("the person turns the keyboard on and comes back: the step follows by itself (green chip, Continue)",
                text(s, "mChipText").equals("mr_tour_enable_on") && text(s, "mPrimaryLabel").equals("mr_tour_continue") && step(s, 1, 4, "enable"));
        view(s, "mPrimary").performClick();
        check("Continue moves to step 2 of 4: choose the keyboard", step(s, 2, 4, "select"));
        check("... still not marked as done (a step of Android is on show)", !MrTour.done(s));
        check("... the chip says another keyboard is in use, the button opens the picker", text(s, "mChipText").equals("mr_tour_select_missing") && text(s, "mPrimaryLabel").equals("mr_tour_select_open"));
        view(s, "mPrimary").performClick();
        check("the button asks Android for the picker of keyboards", s.imm.pickers == 1);
        useIt();
        s.onWindowFocusChanged(true);
        pump(s);
        check("the person picks Mr Keyboard and the screen gets the focus back: In use, Continue", text(s, "mChipText").equals("mr_tour_select_on") && text(s, "mPrimaryLabel").equals("mr_tour_continue"));
        view(s, "mPrimary").performClick();
        check("step 3 of 4: the dictionary", step(s, 3, 4, "dict"));
        check("... the two steps of Android are behind: the screen is marked as done", MrTour.done(s));
        check("... the chip names the dictionary that will come (the system language), the button downloads", text(s, "mChipText").startsWith("mr_tour_dict_missing[") && text(s, "mPrimaryLabel").equals("mr_tour_download"));
        check("... the quiet button turns suggestions off, the note says where the file comes from",
                text(s, "mSecondary").equals("mr_tour_dict_off") && view(s, "mSecondary").getVisibility() == View.VISIBLE && text(s, "mNote").equals("mr_tour_net_note"));

        // a download in progress (the job is in MrTour; the screen only shows it)
        MrTour.sBusy = true;
        MrTour.sStep = "dict";
        MrPacks.sJobPercent = 42;
        back(s);
        check("a download at 42%: the button is its progress bar with the percent, the chip says Downloading",
                text(s, "mPrimaryLabel").equals("mr_dicts_state_downloading[42]") && text(s, "mChipText").equals("mr_tour_downloading"));
        check("... the fill is the pill cut at 42% (a clip, not a view that is scaled: its corners stay round), and it is on show",
                fill(s) == 4200 && view(s, "mPrimaryFill").getVisibility() == View.VISIBLE);
        check("... the quiet button is hidden and the main one does nothing", view(s, "mSecondary").getVisibility() == View.INVISIBLE && !view(s, "mPrimary").performClick());
        MrPacks.sJobPercent = 77;
        pump(s);
        check("... the percent follows the job, and the fill grows with it", text(s, "mPrimaryLabel").equals("mr_dicts_state_downloading[77]") && fill(s) == 7700);
        MrPacks.sJobInstalling = true;
        pump(s);
        check("... and then it says it is checking and installing, with the fill complete", text(s, "mPrimaryLabel").equals("mr_dicts_state_installing") && fill(s) == 10000);

        MrTour.sBusy = false;
        MrPacks.sJobInstalling = false;
        MrTour.sError = "no connection";
        MrTour.sErrorStep = "dict";
        pump(s);
        check("the download failed: the chip gives the reason, the button says Try again, the quiet button is back",
                text(s, "mChipText").equals("no connection") && text(s, "mPrimaryLabel").equals("mr_tour_retry") && view(s, "mSecondary").getVisibility() == View.VISIBLE);

        MrTour.sError = null;
        MrTour.sErrorStep = null;
        s.packs().m.put(MrPacks.KEY_INSTALLED + "en-US", 1);
        back(s);   // no job is running any more: the screen reads it again when the person is back on it (or on its next visit)
        check("the dictionary arrives: Ready, Continue, no quiet button, no note",
                text(s, "mChipText").equals("mr_tour_ready") && text(s, "mPrimaryLabel").equals("mr_tour_continue")
                && view(s, "mSecondary").getVisibility() == View.INVISIBLE && view(s, "mNote").getVisibility() == View.INVISIBLE);
        view(s, "mPrimary").performClick();
        check("step 4 of 4: gesture typing", step(s, 4, 4, "gesture"));
        check("... the button downloads, the chip says the file is not downloaded", text(s, "mPrimaryLabel").equals("mr_tour_download") && text(s, "mChipText").equals("mr_tour_gesture_missing"));
        view(s, "mSecondary").performClick();
        check("Turn off gesture typing on the last step: the option goes off and the screen closes",
                Boolean.FALSE.equals(d.m.get("pref_gesture_typing")) && s.finishes == 1 && MrTour.done(s));
        check("... suggestions were not touched", !d.m.containsKey("show_suggestions"));
        s.onPause();
        s.onDestroy();
        check("leaving the screen runs without fault", true);
    }

    // ---------------------------------------------------------------- only downloads left
    static void downloads() {
        TourTest.Prefs d = new TourTest.Prefs();
        Screen s = open(d, true, true, null);
        check("the keyboard is on and in use: two steps, the dictionary first", step(s, 1, 2, "dict"));
        check("... marked as done as soon as it shows (only downloads)", MrTour.done(s));
        view(s, "mSecondary").performClick();
        check("Turn off suggestions: the option goes off and the next step comes", Boolean.FALSE.equals(d.m.get("show_suggestions")) && step(s, 2, 2, "gesture") && s.finishes == 0);

        MrTour.sBusy = true;
        MrTour.sStep = "gesture";
        MrPacks.sJobPercent = 5;
        back(s);
        check("the gesture file at 5%: the progress bar of the button, with a piece of the fill already there for the round end to show",
                text(s, "mPrimaryLabel").equals("mr_dicts_state_downloading[5]") && fill(s) == 500);
        MrTour.sBusy = false;
        s.packs().m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        pump(s);
        check("the file arrives: the fill is hidden and back to zero", fill(s) == 0 && view(s, "mPrimaryFill").getVisibility() == View.GONE);
        check("the file arrives: Ready, and on the last step the button says Finish", text(s, "mChipText").equals("mr_tour_ready") && text(s, "mPrimaryLabel").equals("mr_tour_finish"));
        view(s, "mPrimary").performClick();
        check("Finish closes the screen", s.finishes == 1);

        // a download that went on while the screen was closed is seen when it is opened again
        MrTour.sBusy = true;
        MrTour.sStep = "gesture";
        MrPacks.sJobPercent = 61;
        TourTest.Prefs d2 = new TourTest.Prefs();
        Screen s2 = open(d2, true, true, null);
        MrTour.sBusy = true;
        MrTour.sStep = "dict";
        MrPacks.sJobPercent = 61;
        back(s2);
        check("a screen opened with a job running shows it at once", text(s2, "mPrimaryLabel").equals("mr_dicts_state_downloading[61]"));
        MrTour.sBusy = false;
    }

    // ---------------------------------------------------------------- Skip and the end
    static void skipAndEnd() {
        Screen s = open(new TourTest.Prefs(), false, false, null);
        LinearLayout top = (LinearLayout) f(s, "mTop");
        top.getChildAt(top.getChildCount() - 1).performClick();
        check("Skip closes the screen and marks it as done (even with the keyboard still off)", s.finishes == 1 && MrTour.done(s));
        check("... and changes nothing else", s.packs().m.isEmpty());

        s = open(new TourTest.Prefs(), false, false, null);
        s.finish();
        check("closed by Back (finish): marked as done", MrTour.done(s));
    }

    // ---------------------------------------------------------------- the screen rebuilt
    static void rebuilt() {
        Screen s = open(new TourTest.Prefs(), false, false, null);
        turnOn(s);
        back(s);
        view(s, "mPrimary").performClick();
        check("at step 2 of 4", step(s, 2, 4, "select"));
        Bundle b = new Bundle();
        s.onSaveInstanceState(b);
        Screen s2 = open(new TourTest.Prefs(), true, false, b);
        check("the screen is rebuilt (the process died): the same steps and the same position", step(s2, 2, 4, "select"));
        check("... and nothing settles in again (a rebuilt screen is just drawn)", s2.finishes == 0);
        s2.onConfigurationChanged(new Configuration());
        check("the phone is turned: no fault, the step stays", step(s2, 2, 4, "select"));

        Bundle bad = new Bundle();
        bad.putString("mr_tour_steps", "select,dict,");
        bad.putInt("mr_tour_index", 9);
        Screen s3 = open(new TourTest.Prefs(), true, false, bad);
        check("a saved position outside the list goes back to the first step", step(s3, 1, 2, "select"));
    }

    // ---------------------------------------------------------------- nothing to ask
    static void nothingToAsk() {
        TourTest.Prefs d = new TourTest.Prefs();
        d.m.put("show_suggestions", Boolean.FALSE);
        d.m.put("pref_gesture_typing", Boolean.FALSE);
        Screen s = open(d, true, true, null);
        check("the keyboard in use and the options off: the screen closes at once, with nothing built", s.finishes == 1 && f(s, "mBody") == null);
        s.onResume();
        s.onWindowFocusChanged(true);
        s.onPause();
        s.onDestroy();
        check("... and its lifecycle runs without fault", true);
    }
}
