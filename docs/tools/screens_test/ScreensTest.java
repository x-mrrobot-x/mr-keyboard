package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Application;
import android.content.SharedPreferences;
import android.graphics.Insets;
import android.os.Build;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.Window;
import android.view.WindowInsets;
import android.view.WindowManager;

/**
 * MrScreens (the insets of the screens on Android 15+): what goes to the padding of the content area, and above all what is
 * left for the views below, which must not be able to reserve the bars again; and the setting of hardware acceleration of the
 * screens (every Android): off by default, the flag of the window when it is on, never for the helper windows.
 */
public class ScreensTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final int BARS = WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout();

    /** The decor view of a window: its own handling of the insets answers with a known object. */
    static class Decor extends View {
        static final WindowInsets MARK = insets(1, 2, 3, 4);
        public WindowInsets onApplyWindowInsets(WindowInsets in) { return MARK; }
    }

    /** A screen whose content area is the given view. */
    static class Screen extends Activity {
        final View content;
        Screen(View content) { this.content = content; }
        public View findViewById(int id) { return id == MrScreens.CONTENT ? content : null; }
    }

    static WindowInsets insets(int status, int nav, int cutoutLeft, int ime) {
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.statusBars(), Insets.of(0, status, 0, 0));
        b.setInsets(WindowInsets.Type.navigationBars(), Insets.of(0, 0, 0, nav));
        b.setInsets(WindowInsets.Type.tappableElement(), Insets.of(0, 0, 0, nav));
        b.setInsets(WindowInsets.Type.displayCutout(), Insets.of(cutoutLeft, 0, 0, 0));
        b.setInsets(WindowInsets.Type.ime(), Insets.of(0, 0, 0, ime));
        return b.build();
    }

    /** A screen with no window (the system can hand over an activity that is already going away). */
    static class NoWindow extends Activity {
        public Window getWindow() { return null; }
    }

    /** Preferences in memory; "broken" makes every read fail, like a store that cannot be opened. */
    static class Prefs implements SharedPreferences {
        final java.util.HashMap<String, Object> map = new java.util.HashMap<String, Object>();
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

    static final int HW = WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED;

    /** The screen goes through onActivityCreated; the answer is the flags of its window afterwards. */
    static int flagsAfterCreate(Activity screen, int before) {
        screen.getWindow().stubFlags = before;
        new MrScreens().onActivityCreated(screen, null);
        return screen.getWindow().stubFlags;
    }

    static int registered(int sdk) {
        Build.VERSION.SDK_INT = sdk;
        Application app = new Application();
        MrScreens.install(app);
        return app.registered.size();
    }

    /** The screen goes through onActivityStarted and receives the insets, as the system would deliver them. */
    static WindowInsets deliver(View content, WindowInsets in) {
        return content.stubInsetsListener().onApplyWindowInsets(content, in);
    }

    public static void main(String[] a) {
        int[] every = {26, 28, 29, 30, 33, 34, 35, 36, 37};
        for (int sdk : every) check("Android SDK " + sdk + ": one callback registered (the acceleration setting works on every Android)", registered(sdk) == 1);
        int[] below = {26, 28, 29, 30, 33, 34};
        for (int sdk : below) {
            Build.VERSION.SDK_INT = sdk;
            View c = new View();
            new MrScreens().onActivityStarted(new Screen(c));
            check("Android SDK " + sdk + ": starting a screen leaves the insets alone (the system fits the window)",
                    c.stubInsetsListener() == null && c.stubInsetsRequests() == 0);
        }
        Build.VERSION.SDK_INT = 36;
        boolean nullApp = true;
        try { MrScreens.install(null); } catch (RuntimeException e) { nullApp = false; }
        check("install(null) does not fail", nullApp);

        // ---- the screen starts: listener on the content area and new request of the insets
        View content = new View();
        MrScreens cb = new MrScreens();
        cb.onActivityStarted(new Screen(content));
        check("starting a screen puts the listener on the content area", content.stubInsetsListener() == cb);
        check("starting a screen asks for the insets", content.stubInsetsRequests() == 1);
        cb.onActivityStarted(new Screen(content));
        check("starting it again keeps one listener and asks again (returning from another screen)",
                content.stubInsetsListener() == cb && content.stubInsetsRequests() == 2);
        boolean noContent = true;
        try { cb.onActivityStarted(new Screen(null)); } catch (RuntimeException e) { noContent = false; }
        check("a screen with no content area does not break", noContent);

        // ---- portrait, gestures: status bar 80, navigation bar 48
        WindowInsets left = deliver(content, insets(80, 48, 0, 0));
        check("padding = status bar on top and navigation bar at the bottom",
                content.getPaddingLeft() == 0 && content.getPaddingTop() == 80 && content.getPaddingRight() == 0 && content.getPaddingBottom() == 48);
        check("what goes down: bars and cutout are zero (a view below cannot reserve them again)",
                left.getInsets(BARS) == Insets.NONE);
        check("what goes down: the status bar alone is zero too (the gap under the title)",
                left.getInsets(WindowInsets.Type.statusBars()) == Insets.NONE);
        check("what goes down: the tappable element (3 buttons) is zero too",
                left.getInsets(WindowInsets.Type.tappableElement()) == Insets.NONE);

        // ---- 3 buttons, notch on the side (landscape): cutout 60 on the left, status bar 24
        deliver(content, insets(24, 96, 60, 0));
        check("landscape: the cutout on the left becomes padding on the left",
                content.getPaddingLeft() == 60 && content.getPaddingTop() == 24 && content.getPaddingBottom() == 96);

        // ---- cutout bigger than the status bar: takes the largest of the two
        WindowInsets.Builder b = new WindowInsets.Builder();
        b.setInsets(WindowInsets.Type.statusBars(), Insets.of(0, 60, 0, 0));
        b.setInsets(WindowInsets.Type.displayCutout(), Insets.of(0, 90, 0, 0));
        deliver(content, b.build());
        check("cutout taller than the status bar: top padding is the largest", content.getPaddingTop() == 90);

        // ---- keyboard: height that SheetEditorActivity works out must stay the same (ime - systemBars at the bottom)
        WindowInsets before = insets(80, 48, 0, 900);
        int oldExtra = Math.max(0, before.getInsets(WindowInsets.Type.ime()).bottom - before.getInsets(WindowInsets.Type.systemBars()).bottom);
        WindowInsets down = deliver(content, before);
        int newExtra = Math.max(0, down.getInsets(WindowInsets.Type.ime()).bottom - down.getInsets(WindowInsets.Type.systemBars()).bottom);
        check("keyboard open: the extra height that the editor computes is the same as before (" + oldExtra + ")", oldExtra == 852 && newExtra == oldExtra);
        WindowInsets hidden = deliver(content, insets(80, 48, 0, 0));
        int hiddenExtra = Math.max(0, hidden.getInsets(WindowInsets.Type.ime()).bottom - hidden.getInsets(WindowInsets.Type.systemBars()).bottom);
        check("keyboard closed: extra height is zero", hiddenExtra == 0);
        WindowInsets small = deliver(content, insets(80, 48, 0, 30));
        check("keyboard shorter than the navigation bar: zero, never negative", small.getInsets(WindowInsets.Type.ime()).bottom == 0);

        // ---- the same insets object is not changed (the system keeps its copy)
        WindowInsets original = insets(80, 48, 0, 900);
        deliver(content, original);
        check("the insets that the system delivered are not changed", original.getInsets(WindowInsets.Type.statusBars()).top == 80
                && original.getInsets(WindowInsets.Type.ime()).bottom == 900);

        // ---- if it ever runs below Android 11: it neither pads nor changes anything
        Build.VERSION.SDK_INT = 29;
        View other = new View();
        WindowInsets sent = insets(80, 48, 0, 0);
        WindowInsets back = new MrScreens().onApplyWindowInsets(other, sent);
        check("below Android 11 the insets pass untouched and there is no padding",
                back == sent && other.getPaddingTop() == 0 && other.getPaddingBottom() == 0);

        // ---- dialog of the AI Editor (window from the top of the display to the keyboard): fitDialog on the decor view
        Build.VERSION.SDK_INT = 33; // Android 13: the case of the screenshot (no edge-to-edge, but the window is under the bar)
        View dDecor = new Decor();
        View dRoot = new View();
        MrScreens.fitDialog(dDecor, dRoot);
        check("dialog on Android 11+: listener on the decor view (not on the root, which the system layout may have consumed)",
                dDecor.stubInsetsListener() != null && dRoot.stubInsetsListener() == null);
        check("dialog: the insets are requested again", dDecor.stubInsetsRequests() == 1);
        WindowInsets portrait = insets(80, 0, 0, 0);
        WindowInsets back1 = dDecor.stubInsetsListener().onApplyWindowInsets(dDecor, portrait);
        check("dialog, portrait: the status bar is padding on top (the card stays below it), nothing else",
                dRoot.getPaddingTop() == 80 && dRoot.getPaddingBottom() == 0 && dRoot.getPaddingLeft() == 0 && dRoot.getPaddingRight() == 0);
        check("dialog: what reaches the decor view goes on as always (the decor's own handling decides)", back1 == Decor.MARK);
        dDecor.stubInsetsListener().onApplyWindowInsets(dDecor, insets(60, 0, 110, 0));
        check("dialog, landscape with the camera on the side: padding on the side and on top",
                dRoot.getPaddingLeft() == 110 && dRoot.getPaddingTop() == 60);
        dDecor.stubInsetsListener().onApplyWindowInsets(dDecor, insets(0, 0, 0, 0));
        check("dialog that does not touch the bars: no padding at all",
                dRoot.getPaddingTop() == 0 && dRoot.getPaddingLeft() == 0 && dRoot.getPaddingBottom() == 0);
        dDecor.stubInsetsListener().onApplyWindowInsets(dDecor, insets(80, 48, 0, 900));
        check("dialog over the whole display: bars in the padding (status bar and navigation bar), keyboard is not",
                dRoot.getPaddingTop() == 80 && dRoot.getPaddingBottom() == 48);
        Build.VERSION.SDK_INT = 36;
        View dDecor36 = new Decor();
        View dRoot36 = new View();
        MrScreens.fitDialog(dDecor36, dRoot36);
        dDecor36.stubInsetsListener().onApplyWindowInsets(dDecor36, insets(80, 0, 0, 0));
        check("dialog on Android 16: same padding", dRoot36.getPaddingTop() == 80);
        Build.VERSION.SDK_INT = 29;
        View dOld = new Decor();
        MrScreens.fitDialog(dOld, new View());
        check("dialog before Android 11: no listener, no request (as before)",
                dOld.stubInsetsListener() == null && dOld.stubInsetsRequests() == 0);
        Build.VERSION.SDK_INT = 36;
        boolean dNull = true;
        try { MrScreens.fitDialog(null, new View()); MrScreens.fitDialog(new View(), null); MrScreens.fitDialog(null, null); }
        catch (RuntimeException e) { dNull = false; }
        check("fitDialog with null views does not fail", dNull);

        // ---- height of the window of the dialog: up to the keyboard, or the whole display when that area is short
        final int match = android.view.ViewGroup.LayoutParams.MATCH_PARENT;
        check("phone on its side (228 px above the keyboard, density 2.5 = 91 dp): the whole display",
                MrAiDialog.windowHeight(228, 2.5f) == match);
        check("phone in portrait (1300 px, density 2.5 = 520 dp): up to the keyboard", MrAiDialog.windowHeight(1300, 2.5f) == 1300);
        check("exactly 240 dp: still up to the keyboard", MrAiDialog.windowHeight(600, 2.5f) == 600);
        check("just under 240 dp: the whole display", MrAiDialog.windowHeight(599, 2.5f) == match);
        check("the limit is in dp: the same 599 px on a screen of density 1 is 599 dp, up to the keyboard",
                MrAiDialog.windowHeight(599, 1f) == 599);
        check("position of the keyboard unknown (0 or negative): the whole display, as before",
                MrAiDialog.windowHeight(0, 2.5f) == match && MrAiDialog.windowHeight(-1, 2.5f) == match);

        // ---- hardware acceleration of the screens: the setting pref_ui_hw_accel, off by default
        check("the key of the setting", MrScreens.KEY_HW_ACCEL.equals("pref_ui_hw_accel"));
        check("the flag is the one of the window (0x01000000)", HW == 0x01000000);
        Prefs prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
        for (int sdk : every) {
            Build.VERSION.SDK_INT = sdk;
            prefs.map.clear();
            check("SDK " + sdk + ", setting never changed: the screen is drawn as always (no flag)", flagsAfterCreate(new Screen(null), 0) == 0);
            prefs.map.put(MrScreens.KEY_HW_ACCEL, Boolean.FALSE);
            check("SDK " + sdk + ", setting off: no flag", flagsAfterCreate(new Screen(null), 0) == 0);
            prefs.map.put(MrScreens.KEY_HW_ACCEL, Boolean.TRUE);
            check("SDK " + sdk + ", setting on: the window asks for hardware acceleration", flagsAfterCreate(new Screen(null), 0) == HW);
        }
        Build.VERSION.SDK_INT = 33;
        check("setting on: the other flags of the window stay (0x80 and 0x1000)", flagsAfterCreate(new Screen(null), 0x1080) == (0x1080 | HW));
        check("setting on and the window already accelerated (manifest): it stays that way", flagsAfterCreate(new Screen(null), HW) == HW);
        prefs.map.put(MrScreens.KEY_HW_ACCEL, Boolean.FALSE);
        check("setting off: a flag the window already had is not taken off (Android cannot turn it off, and the manifest decides)",
                flagsAfterCreate(new Screen(null), HW) == HW);
        prefs.map.put(MrScreens.KEY_HW_ACCEL, Boolean.TRUE);
        check("a helper window (translucent, hands something over) is never accelerated: ShotPerm", flagsAfterCreate(new ShotPerm(), 0) == 0);
        check("a helper window is never accelerated: ShotPick", flagsAfterCreate(new ShotPick(), 0) == 0);
        check("the helper windows are the three of the manifest",
                MrScreens.isHelper("com.google.android.voiceime.ActivityHelper") && MrScreens.isHelper("com.mrkeyboard.app.ShotPerm")
                && MrScreens.isHelper("com.mrkeyboard.app.ShotPick"));
        check("the screens of the app are not helpers",
                !MrScreens.isHelper("com.mrkeyboard.app.MainActivity") && !MrScreens.isHelper("com.mrkeyboard.app.PrefScreenAdvanced")
                && !MrScreens.isHelper("com.mrkeyboard.app.SheetEditorActivity") && !MrScreens.isHelper("com.mrkeyboard.app.ShotPermX")
                && !MrScreens.isHelper("ShotPerm") && !MrScreens.isHelper(""));
        prefs.broken = true;
        boolean unreadable = true;
        int unreadableFlags = -1;
        try { unreadableFlags = flagsAfterCreate(new Screen(null), 0); } catch (RuntimeException e) { unreadable = false; }
        check("preferences that cannot be read: the screen opens as always (no flag, no failure)", unreadable && unreadableFlags == 0);
        prefs.broken = false;
        PreferenceManager.stubDefault = null;
        boolean noPrefs = true;
        int noPrefsFlags = -1;
        try { noPrefsFlags = flagsAfterCreate(new Screen(null), 0); } catch (RuntimeException e) { noPrefs = false; }
        check("no preferences at all: the screen opens as always", noPrefs && noPrefsFlags == 0);
        PreferenceManager.stubDefault = prefs;
        boolean noWin = true;
        try { new MrScreens().onActivityCreated(new NoWindow(), null); } catch (RuntimeException e) { noWin = false; }
        check("a screen with no window does not break", noWin);
        boolean rest = true;
        try { new MrScreens().onActivityResumed(new Screen(null)); new MrScreens().onActivityPaused(new Screen(null)); } catch (RuntimeException e) { rest = false; }
        check("the other callbacks do nothing", rest);

        // ---- the Advanced screen reports a change: only this setting creates the screen again
        Screen adv = new Screen(null);
        MrScreens.onSetting(adv, "pref_ui_hw_accel");
        check("the acceleration setting changed: the screen is created again", adv.stubRecreates == 1);
        MrScreens.onSetting(adv, "fullscreen_override");
        MrScreens.onSetting(adv, "force_keyboard_on");
        MrScreens.onSetting(adv, "pref_ui_hw_accel_x");
        MrScreens.onSetting(adv, null);
        check("any other setting leaves the screen as it is", adv.stubRecreates == 1);
        boolean nullScreen = true;
        try { MrScreens.onSetting(null, "pref_ui_hw_accel"); } catch (RuntimeException e) { nullScreen = false; }
        check("onSetting with no screen does not fail", nullScreen);

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}

/** The helper windows of the manifest exist only as smali in the app; here they stand for them by name. */
class ShotPerm extends Activity { }

class ShotPick extends Activity { }
