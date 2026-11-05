package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Application;
import android.graphics.Insets;
import android.os.Build;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.Window;
import android.view.WindowInsets;
import android.view.WindowManager;

/**
 * Behaviour shared by every screen (Activity) of the app, registered once in MrApplication.
 *
 * Insets (Android 15+): an app that targets 35 or higher is drawn edge-to-edge, under the status bar, the navigation bar and
 * the display cutout. On every screen the area of android.R.id.content gets as padding the system bars and the cutout (the
 * background of the window, the same colour as the screens, shows behind the bars), and the insets that go down to the views
 * are the ones that are left <b>after</b> taking that padding off (WindowInsets.inset). That is what keeps a view below from
 * reserving the same space again: the PreferenceActivity layout belongs to the system and changes between Android versions,
 * and one that applied the status bar a second time left a gap under the title of the settings screens. The IME inset goes
 * down too, less the part that is already padding (SheetEditorActivity works out the height of the keyboard from it).
 *
 * Below Android 15 the system fits the window by itself (status and navigation bar with the colours of the theme), as
 * always, and the insets are left alone.
 *
 * Hardware acceleration (every Android): the manifest says <code>hardwareAccelerated="false"</code> for the app, so the
 * screens are drawn by the processor, as they always were; the three that draw with their own code (the Sheets editor, the
 * Sheets page and the AI Editor styles) say "true" in the manifest. Android lets a window turn the acceleration on but never
 * off, so the setting "pref_ui_hw_accel" (Advanced, off by default) is applied here, in onActivityCreated, which runs before
 * the window is handed to the system (the flag is read when the window is added, after onResume). It never touches the
 * windows without a screen of their own (the translucent helpers) or the keyboard and its dialogs.
 */
public final class MrScreens implements Application.ActivityLifecycleCallbacks, View.OnApplyWindowInsetsListener {
    /** android.R.id.content. */
    static final int CONTENT = 0x1020002;
    /** First Android that draws the screens edge-to-edge for an app that targets it. */
    static final int EDGE_TO_EDGE_SDK = 35;
    /** First Android with WindowInsets.Type and WindowInsets.inset. */
    static final int INSETS_API_SDK = 30;
    /** Setting (Advanced screen): draw the screens of the app with hardware acceleration. Off by default. */
    static final String KEY_HW_ACCEL = "pref_ui_hw_accel";
    /** Windows with no screen of their own (translucent, they only hand something over): never accelerated. */
    private static final String[] HELPERS = {
            "com.google.android.voiceime.ActivityHelper", "com.mrkeyboard.app.ShotPerm", "com.mrkeyboard.app.ShotPick"};

    /** Registers the callbacks of the screens (once, in MrApplication.onCreate). */
    public static void install(Application app) {
        if (app == null) return;
        app.registerActivityLifecycleCallbacks(new MrScreens());
    }

    /**
     * The Advanced screen calls this when a setting changes: the acceleration is read when the window is created, so
     * that screen is created again to take the new value at once (the ones behind it take it the next time they open).
     */
    public static void onSetting(Activity screen, String key) {
        if (screen != null && KEY_HW_ACCEL.equals(key)) screen.recreate();
    }

    /** True for the windows that are not screens of the app (see HELPERS). */
    static boolean isHelper(String className) {
        for (String name : HELPERS) if (name.equals(className)) return true;
        return false;
    }

    /** The setting is on and this window is a screen: the flag goes on. A failure to read it leaves the screen as it was. */
    static boolean accelerates(Activity screen) {
        if (isHelper(screen.getClass().getName())) return false;
        try {
            return PreferenceManager.getDefaultSharedPreferences(screen).getBoolean(KEY_HW_ACCEL, false);
        } catch (RuntimeException e) {
            return false;
        }
    }

    /**
     * The window of the AI Editor dialog is not an Activity (it is attached to the keyboard window and laid out from the top
     * of the display down, with FLAG_LAYOUT_NO_LIMITS), so the callbacks above never see it, and the system gives a window
     * like that no legacy insets: the card sat under the status bar and the camera. From Android 11 (WindowInsets.Type)
     * the bars and the cutout that overlap the window are still reported, and this puts them as padding on the root of the
     * dialog, so that the card never goes under them; its dark layer (the background of the root) still fills the window.
     * The listener is on the decor view, which receives the insets before the layout of the system that consumes them,
     * and what it receives is passed on to the decor as always. No overlap, no padding. Before Android 11 nothing changes.
     */
    public static void fitDialog(View decor, View root) {
        if (decor == null || root == null || Build.VERSION.SDK_INT < INSETS_API_SDK) return;
        decor.setOnApplyWindowInsetsListener(new DialogFit(root));
        decor.requestApplyInsets();
    }

    public void onActivityStarted(Activity activity) {
        if (Build.VERSION.SDK_INT < EDGE_TO_EDGE_SDK) return;
        View content = activity.findViewById(CONTENT);
        if (content == null) return;
        content.setOnApplyWindowInsetsListener(this);
        content.requestApplyInsets();
    }

    public WindowInsets onApplyWindowInsets(View view, WindowInsets insets) {
        if (Build.VERSION.SDK_INT < INSETS_API_SDK) return insets;
        return Api30.fit(view, insets);
    }

    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (!accelerates(activity)) return;
        Window window = activity.getWindow();
        if (window != null) {
            window.setFlags(WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED,
                    WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED);
        }
    }

    public void onActivityResumed(Activity activity) { }

    public void onActivityPaused(Activity activity) { }

    public void onActivityStopped(Activity activity) { }

    public void onActivitySaveInstanceState(Activity activity, Bundle outState) { }

    public void onActivityDestroyed(Activity activity) { }

    /** Padding of the dialog root from the insets that reach the decor view of its window. */
    static final class DialogFit implements View.OnApplyWindowInsetsListener {
        private final View mRoot;

        DialogFit(View root) { mRoot = root; }

        public WindowInsets onApplyWindowInsets(View decor, WindowInsets insets) {
            if (Build.VERSION.SDK_INT >= INSETS_API_SDK) Api30.pad(mRoot, insets);
            return decor.onApplyWindowInsets(insets);
        }
    }

    /** The calls of Android 11 and up, apart so that this class loads on any Android. */
    static final class Api30 {
        static void pad(View root, WindowInsets insets) {
            Insets bars = insets.getInsets(WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout());
            root.setPadding(bars.left, bars.top, bars.right, bars.bottom);
        }

        static WindowInsets fit(View view, WindowInsets insets) {
            Insets bars = insets.getInsets(WindowInsets.Type.systemBars() | WindowInsets.Type.displayCutout());
            view.setPadding(bars.left, bars.top, bars.right, bars.bottom);
            return insets.inset(bars.left, bars.top, bars.right, bars.bottom);
        }
    }
}
