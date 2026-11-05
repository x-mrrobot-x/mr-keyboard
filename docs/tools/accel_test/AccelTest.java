package com.mrkeyboard.app;

import android.app.Dialog;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.inputmethodservice.InputMethodService;
import android.os.Build;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

/**
 * MrAccel (diagnostic of the keyboard window): one line in the log per process, only when the window is attached to its
 * display, with what the window really has, kept (with the Android) in its own preferences for the Advanced screen; it
 * changes nothing else and a failure never reaches the keyboard.
 */
public class AccelTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    /** The decor view of the keyboard window. */
    static class Decor extends View { }

    static class Win extends Window {
        final View decor;
        Win(View decor) { this.decor = decor; }
        public View getDecorView() { return decor; }
    }

    static class Box extends Dialog {
        final Window window;
        Box(Window window) { super(null, 0); this.window = window; }
        public Window getWindow() { return window; }
    }

    /** The keyboard service with the window it hands out. */
    static class Ime extends InputMethodService {
        final Dialog dialog;
        Ime(Dialog dialog) { this.dialog = dialog; }
        public Dialog getWindow() { return dialog; }
    }

    static class BrokenIme extends InputMethodService {
        public Dialog getWindow() { throw new IllegalStateException("window not ready"); }
    }

    static int lines() { return Log.stubLines.size(); }

    /** Preferences in memory with an editor; "broken" makes every access fail. */
    static class Prefs implements SharedPreferences {
        final java.util.HashMap<String, Object> map = new java.util.HashMap<String, Object>();
        boolean broken;
        public java.util.Map<String, ?> getAll() { if (broken) throw new IllegalStateException("broken"); return map; }
        public String getString(String key, String def) { return def; }
        public int getInt(String key, int def) { if (broken) throw new IllegalStateException("broken"); Object v = map.get(key); return v == null ? def : ((Integer) v).intValue(); }
        public long getLong(String key, long def) { return def; }
        public boolean getBoolean(String key, boolean def) { if (broken) throw new IllegalStateException("broken"); Object v = map.get(key); return v == null ? def : ((Boolean) v).booleanValue(); }
        public Editor edit() {
            if (broken) throw new IllegalStateException("broken");
            return new Editor() {
                public Editor putString(String key, String value) { map.put(key, value); return this; }
                public Editor putInt(String key, int value) { map.put(key, Integer.valueOf(value)); return this; }
                public Editor putLong(String key, long value) { map.put(key, Long.valueOf(value)); return this; }
                public Editor putBoolean(String key, boolean value) { map.put(key, Boolean.valueOf(value)); return this; }
                public Editor remove(String key) { map.remove(key); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
    }

    /** A context that hands out the preferences file asked for (and remembers which one and how). */
    static class Ctx extends ContextWrapper {
        final Prefs prefs = new Prefs();
        String file;
        int mode = -1;
        public Context getApplicationContext() { return this; }
        public SharedPreferences getSharedPreferences(String name, int m) { file = name; mode = m; return prefs; }
    }

    /** The Advanced screen: it finds the read-only row, and gives resources that know the three texts. */
    static class Row extends Preference {
        CharSequence summary;
        Row() { super(null); }
        public void setSummary(CharSequence s) { summary = s; }
    }

    static class Advanced extends PreferenceActivity {
        final Ctx ctx = new Ctx();
        final Row row = new Row();
        final Row screenRow = new Row();
        final Decor decor = new Decor();
        final WindowManager.LayoutParams attrs = new WindowManager.LayoutParams();
        final java.util.ArrayList<String> asked = new java.util.ArrayList<String>();
        boolean hasRow = true;
        boolean noAttrs;
        Advanced() {
            stubWindow = new Window() {
                public View getDecorView() { return decor; }
                public WindowManager.LayoutParams getAttributes() { return noAttrs ? null : attrs; }
            };
        }
        public Preference findPreference(CharSequence key) {
            asked.add(String.valueOf(key));
            if (!hasRow) return null;
            if ("mr_kbd_accel".equals(String.valueOf(key))) return row;
            if ("mr_scr_accel".equals(String.valueOf(key))) return screenRow;
            return null;
        }
        public SharedPreferences getSharedPreferences(String name, int m) { return ctx.getSharedPreferences(name, m); }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public Resources getResources() {
            return new Resources() {
                public int getIdentifier(String name, String defType, String defPackage) {
                    return defType.equals("string") && (name.startsWith("mr_ui_kbd_accel") || name.startsWith("mr_ui_scr_accel")) ? name.hashCode() : 0;
                }
                public String getString(int id) {
                    if (id == "mr_ui_kbd_accel_on".hashCode()) return "TEXT ON";
                    if (id == "mr_ui_kbd_accel_off".hashCode()) return "TEXT OFF";
                    if (id == "mr_ui_kbd_accel_unknown".hashCode()) return "TEXT UNKNOWN";
                    if (id == "mr_ui_scr_accel_off".hashCode()) return "SCR OFF";
                    if (id == "mr_ui_scr_accel_asked".hashCode()) return "SCR ASKED";
                    if (id == "mr_ui_scr_accel_system".hashCode()) return "SCR SYSTEM";
                    if (id == "mr_ui_scr_accel_refused".hashCode()) return "SCR REFUSED";
                    return null;
                }
                public String getString(int id, Object... args) { return getString(id); }
            };
        }
    }

    static Decor decor(boolean attached, boolean accelerated) {
        Decor d = new Decor();
        d.stubWindowState(attached, accelerated);
        return d;
    }

    public static void main(String[] a) {
        Build.VERSION.SDK_INT = 34;

        // ---- window shown and attached, accelerated: ONE line, says true, with the Android
        MrAccel.reset();
        Log.stubLines.clear();
        Decor d = decor(true, true);
        Ime ime = new Ime(new Box(new Win(d)));
        MrAccel.onShown(ime);
        check("nothing is written before the view runs its posted work (it waits for the attach)", lines() == 0 && d.stubPostedCount() == 1);
        d.stubRunPosted();
        check("one line in the log", lines() == 1);
        check("the line has the tag MrAccel", Log.stubLines.get(0).startsWith("MrAccel: "));
        check("the line says the window is accelerated", Log.stubLines.get(0).contains("hardwareAccelerated=true"));
        check("the line has the Android SDK", Log.stubLines.get(0).contains("SDK 34"));
        check("the state says it was logged", MrAccel.logged());

        // ---- shown again: no second line, no more work posted
        MrAccel.onShown(ime);
        check("shown again: no work posted (once per process)", d.stubPostedCount() == 0);
        check("shown again: still one line", lines() == 1);

        // ---- not accelerated: says false
        MrAccel.reset();
        Log.stubLines.clear();
        Decor soft = decor(true, false);
        MrAccel.onShown(new Ime(new Box(new Win(soft))));
        soft.stubRunPosted();
        check("window drawn by software: the line says false", lines() == 1 && Log.stubLines.get(0).contains("hardwareAccelerated=false"));

        // ---- two shows before the view runs its work: still one line
        MrAccel.reset();
        Log.stubLines.clear();
        Decor twice = decor(true, true);
        Ime imeTwice = new Ime(new Box(new Win(twice)));
        MrAccel.onShown(imeTwice);
        MrAccel.onShown(imeTwice);
        check("two shows before the work runs: two posted", twice.stubPostedCount() == 2);
        twice.stubRunPosted();
        check("two posted: one line only", lines() == 1);

        // ---- the view is not attached when the work runs: no line, and the next show tries again
        MrAccel.reset();
        Log.stubLines.clear();
        Decor loose = decor(false, false);
        Ime imeLoose = new Ime(new Box(new Win(loose)));
        MrAccel.onShown(imeLoose);
        loose.stubRunPosted();
        check("view not attached: no line (it would say false only because it does not know yet)", lines() == 0 && !MrAccel.logged());
        loose.stubWindowState(true, true);
        MrAccel.onShown(imeLoose);
        loose.stubRunPosted();
        check("attached on the next show: the line is written then", lines() == 1 && Log.stubLines.get(0).contains("hardwareAccelerated=true"));

        // ---- nothing available: no line and no failure
        MrAccel.reset();
        Log.stubLines.clear();
        boolean safe = true;
        try {
            MrAccel.onShown(null);
            MrAccel.onShown(new Ime(null));
            MrAccel.onShown(new Ime(new Box(null)));
            MrAccel.onShown(new Ime(new Box(new Win(null))));
            MrAccel.onShown(new BrokenIme());
        } catch (RuntimeException e) { safe = false; }
        check("no service, no dialog, no window, no decor view, or a window that is not ready: nothing happens and nothing fails", safe && lines() == 0);

        // ---- the answer is kept for the Advanced screen (own file, with the Android it was measured on)
        Build.VERSION.SDK_INT = 34;
        MrAccel.reset();
        Log.stubLines.clear();
        Ctx ctx = new Ctx();
        check("nothing kept yet: unknown", MrAccel.state(ctx) == MrAccel.UNKNOWN);
        Decor kept = new Decor() { public Context getContext() { return ctx; } };
        kept.stubWindowState(true, true);
        MrAccel.onShown(new Ime(new Box(new Win(kept))));
        kept.stubRunPosted();
        check("kept in its own file, private (not the default preferences: the backup and 'Restore defaults' do not touch it)",
                "mr_diag".equals(ctx.file) && ctx.mode == Context.MODE_PRIVATE);
        check("kept: accelerated, with the Android", Boolean.TRUE.equals(ctx.prefs.map.get("kbd_accel")) && Integer.valueOf(34).equals(ctx.prefs.map.get("kbd_sdk")));
        check("the screen reads: accelerated", MrAccel.state(ctx) == MrAccel.ACCELERATED);
        Build.VERSION.SDK_INT = 35;
        check("measured on another Android (an update of the system): unknown again", MrAccel.state(ctx) == MrAccel.UNKNOWN);
        Build.VERSION.SDK_INT = 33;
        check("measured on another Android (a restore on an older one): unknown", MrAccel.state(ctx) == MrAccel.UNKNOWN);
        Build.VERSION.SDK_INT = 34;
        check("back on the same Android: accelerated again", MrAccel.state(ctx) == MrAccel.ACCELERATED);

        // ---- software
        Ctx soft2 = new Ctx();
        MrAccel.reset();
        Decor softDecor = new Decor() { public Context getContext() { return soft2; } };
        softDecor.stubWindowState(true, false);
        MrAccel.onShown(new Ime(new Box(new Win(softDecor))));
        softDecor.stubRunPosted();
        check("kept: software", Boolean.FALSE.equals(soft2.prefs.map.get("kbd_accel")) && MrAccel.state(soft2) == MrAccel.SOFTWARE);

        // ---- the guard of once per process also keeps the first answer
        Decor later = new Decor() { public Context getContext() { return soft2; } };
        later.stubWindowState(true, true);
        MrAccel.onShown(new Ime(new Box(new Win(later))));
        later.stubRunPosted();
        check("a second window in the same process does not change the answer", MrAccel.state(soft2) == MrAccel.SOFTWARE);

        // ---- not attached: nothing kept
        MrAccel.reset();
        Ctx none = new Ctx();
        Decor early = new Decor() { public Context getContext() { return none; } };
        early.stubWindowState(false, false);
        MrAccel.onShown(new Ime(new Box(new Win(early))));
        early.stubRunPosted();
        check("view not attached: nothing is kept (it would say software only because it does not know yet)", none.prefs.map.isEmpty() && MrAccel.state(none) == MrAccel.UNKNOWN);

        // ---- preferences that fail: the line is written anyway and nothing reaches the keyboard
        MrAccel.reset();
        Log.stubLines.clear();
        Ctx bad = new Ctx();
        bad.prefs.broken = true;
        Decor badDecor = new Decor() { public Context getContext() { return bad; } };
        badDecor.stubWindowState(true, true);
        MrAccel.onShown(new Ime(new Box(new Win(badDecor))));
        boolean quiet = true;
        try { badDecor.stubRunPosted(); } catch (RuntimeException e) { quiet = false; }
        check("preferences that cannot be written: no failure, the line is written", quiet && lines() == 1);
        check("preferences that cannot be read: unknown", MrAccel.state(bad) == MrAccel.UNKNOWN);
        Ctx half = new Ctx();
        half.prefs.map.put("kbd_sdk", Integer.valueOf(34));
        check("only the Android kept, no answer: unknown", MrAccel.state(half) == MrAccel.UNKNOWN);

        // ---- the texts of the row
        check("text of accelerated", MrAccel.textName(MrAccel.ACCELERATED).equals("mr_ui_kbd_accel_on"));
        check("text of software", MrAccel.textName(MrAccel.SOFTWARE).equals("mr_ui_kbd_accel_off"));
        check("text of unknown, and of anything else", MrAccel.textName(MrAccel.UNKNOWN).equals("mr_ui_kbd_accel_unknown") && MrAccel.textName(7).equals("mr_ui_kbd_accel_unknown"));
        check("the key of the row", MrAccel.ROW.equals("mr_kbd_accel"));

        // ---- the Advanced screen fills the row
        Advanced adv = new Advanced();
        MrAccel.fill(adv);
        check("the screen asks for the two rows by their keys", adv.asked.contains("mr_kbd_accel") && adv.asked.contains("mr_scr_accel"));
        check("nothing measured: the row says so", "TEXT UNKNOWN".equals(String.valueOf(adv.row.summary)));
        adv.ctx.prefs.map.put("kbd_accel", Boolean.TRUE);
        adv.ctx.prefs.map.put("kbd_sdk", Integer.valueOf(34));
        MrAccel.fill(adv);
        check("measured accelerated: the row says so", "TEXT ON".equals(String.valueOf(adv.row.summary)));
        adv.ctx.prefs.map.put("kbd_accel", Boolean.FALSE);
        MrAccel.fill(adv);
        check("measured software: the row says so (the screen was away and came back)", "TEXT OFF".equals(String.valueOf(adv.row.summary)));
        adv.hasRow = false;
        boolean noRow = true;
        try { MrAccel.fill(adv); } catch (RuntimeException e) { noRow = false; }
        check("a screen without the row does not break", noRow);
        Advanced noText = new Advanced() {
            public Resources getResources() { return new Resources(); }   // no text available
        };
        noText.row.summary = "from the XML";
        MrAccel.fill(noText);
        check("no text available: the summary of the XML stays", "from the XML".equals(String.valueOf(noText.row.summary)));
        boolean nullScreen = true;
        try { MrAccel.fill(null); } catch (RuntimeException e) { nullScreen = false; }
        check("fill with no screen does not fail", nullScreen);

        // ---- the row of this screen: what the app asked (flag of the window) and what the system gave (the view root)
        check("the key of the row of the screen", MrAccel.ROW_SCREEN.equals("mr_scr_accel"));
        check("text: given and asked", MrAccel.screenTextName(true, true).equals("mr_ui_scr_accel_asked"));
        check("text: given without being asked (the system or the ROM turns it on)", MrAccel.screenTextName(false, true).equals("mr_ui_scr_accel_system"));
        check("text: asked and not given (the system refuses)", MrAccel.screenTextName(true, false).equals("mr_ui_scr_accel_refused"));
        check("text: neither asked nor given", MrAccel.screenTextName(false, false).equals("mr_ui_scr_accel_off"));
        check("the flag is the one of the window", MrAccel.FLAG_HW == 0x01000000);

        Log.stubLines.clear();
        Advanced scr = new Advanced();
        scr.screenRow.summary = "MEASURING";
        scr.attrs.flags = MrAccel.FLAG_HW | 0x80;
        scr.decor.stubWindowState(true, true);
        MrAccel.fillScreen(scr);
        check("the answer waits for the decor view (posted, nothing written yet)", scr.decor.stubPostedCount() == 1 && "MEASURING".equals(String.valueOf(scr.screenRow.summary)));
        scr.decor.stubRunPosted();
        check("asked and given: the row says so", "SCR ASKED".equals(String.valueOf(scr.screenRow.summary)));
        check("one line in the log with both answers", lines() == 1 && Log.stubLines.get(0).contains("Advanced window asked=true given=true"));

        scr.attrs.flags = 0x80;
        MrAccel.fillScreen(scr);
        scr.decor.stubRunPosted();
        check("not asked, given: the row says the system turned it on", "SCR SYSTEM".equals(String.valueOf(scr.screenRow.summary)));
        check("the log has asked=false given=true", Log.stubLines.get(Log.stubLines.size() - 1).contains("asked=false given=true"));

        scr.decor.stubWindowState(true, false);
        MrAccel.fillScreen(scr);
        scr.decor.stubRunPosted();
        check("not asked, not given: the row says the processor draws it", "SCR OFF".equals(String.valueOf(scr.screenRow.summary)));
        scr.attrs.flags = MrAccel.FLAG_HW;
        MrAccel.fillScreen(scr);
        scr.decor.stubRunPosted();
        check("asked, not given: the row says the system refused", "SCR REFUSED".equals(String.valueOf(scr.screenRow.summary)));

        scr.screenRow.summary = "MEASURING";
        scr.decor.stubWindowState(false, true);
        MrAccel.fillScreen(scr);
        scr.decor.stubRunPosted();
        check("view not attached when the work runs: the row is left as it was", "MEASURING".equals(String.valueOf(scr.screenRow.summary)));

        scr.decor.stubWindowState(true, true);
        scr.noAttrs = true;
        MrAccel.fillScreen(scr);
        scr.decor.stubRunPosted();
        check("window without attributes counts as not asked", "SCR SYSTEM".equals(String.valueOf(scr.screenRow.summary)));
        scr.noAttrs = false;

        Advanced noScreenRow = new Advanced();
        noScreenRow.hasRow = false;
        MrAccel.fillScreen(noScreenRow);
        check("a screen without the row posts nothing", noScreenRow.decor.stubPostedCount() == 0);

        Advanced noWindow = new Advanced() { public Window getWindow() { return null; } };
        boolean noWin2 = true;
        try { MrAccel.fillScreen(noWindow); } catch (RuntimeException e) { noWin2 = false; }
        check("a screen with no window does not break", noWin2);

        Advanced both = new Advanced();
        both.attrs.flags = MrAccel.FLAG_HW;
        both.decor.stubWindowState(true, true);
        MrAccel.fill(both);
        both.decor.stubRunPosted();
        check("fill does both rows", "TEXT UNKNOWN".equals(String.valueOf(both.row.summary)) && "SCR ASKED".equals(String.valueOf(both.screenRow.summary)));

        Advanced noTextScreen = new Advanced() { public Resources getResources() { return new Resources(); } };
        noTextScreen.screenRow.summary = "MEASURING";
        noTextScreen.attrs.flags = MrAccel.FLAG_HW;
        noTextScreen.decor.stubWindowState(true, true);
        MrAccel.fillScreen(noTextScreen);
        noTextScreen.decor.stubRunPosted();
        check("no text available: the row keeps the text of the XML", "MEASURING".equals(String.valueOf(noTextScreen.screenRow.summary)));

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
