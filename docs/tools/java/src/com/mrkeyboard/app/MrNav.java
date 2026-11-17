package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.WeakHashMap;

/**
 * The one place that builds the Intent that opens a screen of the app (Settings, Packs, Sheets, AI Editor settings and
 * its style editor).
 * <p>
 * The app is ONE task and ONE window in the list of recent apps: no screen has a <code>taskAffinity</code> of its own in the manifest, so
 * everything (the home screen and every screen that the keyboard opens) lives in the task of the package, under the single title that
 * {@link MrScreens} gives it. The screens are not hidden from the list: the person sees that the app is open and can close it there.
 * <p>
 * From the keyboard (a Service, not an Activity) the screen has to start in a task: NEW_TASK, which with the affinity of the package puts
 * it on top of the task of the app when that is alive (and creates the task when it is not). REORDER_TO_FRONT brings the screen to the
 * front if it is already open in that task, instead of stacking another copy: tapping the gear three times no longer needs three Backs.
 * CLEAR_TOP is deliberately not used (it would also close what the user has open above the screen, such as a style being edited) and,
 * if it were set, REORDER_TO_FRONT would be ignored.
 * <p>
 * From a screen (an Activity) the new screen goes on the stack of the one that opened it, so no NEW_TASK; but
 * REORDER_TO_FRONT is kept, so that a copy that is already in that stack (a style editor left under the list of styles,
 * for instance) is brought to the front instead of getting a second one. The manifest's launchMode="singleTop" answers
 * a double tap with a call to onNewIntent of the screen already on top.
 * <p>
 * The screens that the keyboard opens carry {@link #EXTRA_FROM_KEYBOARD}, MrScreens tells {@link #opened} and {@link #gone} about them,
 * and when the person is back in the app that they were typing in, a screen that is no longer needed is closed
 * ({@link #closeOpenedByKeyboard}) instead of being left in the background spending memory: the whole task goes only when that screen is
 * alone in it ({@link #aloneInTask}), otherwise only the screen, so that nothing the person has open next to it is lost.
 */
public final class MrNav {
    /** Flag of every screen: an open copy in the task is brought to the front, not duplicated. */
    static final int REUSE = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT;
    /** Flags of a screen opened from the keyboard window. */
    static final int FROM_KEYBOARD = Intent.FLAG_ACTIVITY_NEW_TASK | REUSE;
    /** Extra of the Intent of a screen opened from the keyboard window (not of the ones opened from another screen). */
    static final String EXTRA_FROM_KEYBOARD = "mr_from_keyboard";

    /** The screens that the keyboard opened and that are still alive (weak: a screen that is gone does not stay here). */
    private static final ArrayList<WeakReference<Activity>> OPENED = new ArrayList<WeakReference<Activity>>();

    /** Every screen of the app that is alive and the task it was created in (weak: a screen that is gone does not stay here). */
    private static final WeakHashMap<Activity, Integer> TASKS = new WeakHashMap<Activity, Integer>();

    private MrNav() { }

    /** Intent that opens the screen; the caller adds its extras and starts it. */
    public static Intent intent(Context from, Class<?> screen) {
        Intent i = new Intent(from, screen);
        if (from instanceof Activity) {
            i.addFlags(REUSE);
        } else {
            i.addFlags(FROM_KEYBOARD);
            i.putExtra(EXTRA_FROM_KEYBOARD, true);
        }
        return i;
    }

    /** MrScreens: a screen was created. The ones that the keyboard opened are remembered. */
    static void opened(Activity screen) {
        if (screen == null) return;
        try {
            Intent in = screen.getIntent();
            if (in == null || !in.getBooleanExtra(EXTRA_FROM_KEYBOARD, false)) return;
        } catch (RuntimeException e) {
            return;
        }
        synchronized (OPENED) {
            forget(null);
            OPENED.add(new WeakReference<Activity>(screen));
        }
    }

    /** MrScreens: a screen was created (any screen of the app): remembers which task it is in. */
    static void born(Activity screen) {
        if (screen == null) return;
        int task;
        try {
            task = screen.getTaskId();
        } catch (RuntimeException e) {
            return;
        }
        synchronized (TASKS) {
            TASKS.put(screen, Integer.valueOf(task));
        }
    }

    /** MrScreens: a screen was destroyed. */
    static void gone(Activity screen) {
        if (screen == null) return;
        synchronized (TASKS) {
            TASKS.remove(screen);
        }
        synchronized (OPENED) {
            forget(screen);
        }
    }

    /**
     * True when no other screen of the app that is still alive (not finishing) is in the task of {@code screen}: closing it would not take
     * anything else with it. A screen that MrScreens never told about counts as alone.
     */
    static boolean aloneInTask(Activity screen) {
        int task;
        try {
            task = screen.getTaskId();
        } catch (RuntimeException e) {
            return false;
        }
        synchronized (TASKS) {
            for (java.util.Map.Entry<Activity, Integer> e : TASKS.entrySet()) {
                Activity other = e.getKey();
                if (other == null || other == screen || other.isFinishing() || other.isDestroyed()) continue;
                if (e.getValue() != null && e.getValue().intValue() == task) return false;
            }
        }
        return true;
    }

    /** Takes out {@code screen} (when not null) and every reference that has been cleared or whose screen is finishing. */
    private static void forget(Activity screen) {
        for (int i = OPENED.size() - 1; i >= 0; i--) {
            Activity a = OPENED.get(i).get();
            if (a == null || a == screen || a.isDestroyed()) OPENED.remove(i);
        }
    }

    /** The screen of this class that the keyboard opened and that is still open (not finishing), or null. */
    static Activity openedByKeyboard(Class<?> screen) {
        synchronized (OPENED) {
            for (int i = OPENED.size() - 1; i >= 0; i--) {
                Activity a = OPENED.get(i).get();
                if (a != null && screen.isInstance(a) && !a.isFinishing() && !a.isDestroyed()) return a;
            }
        }
        return null;
    }

    /**
     * Closes the screen of this class that the keyboard opened: when it is the root of its task and nothing else of the app is in that
     * task the whole task goes (and with it the entry in the list of recent apps), otherwise only the screen. True when there was one
     * to close. A failure leaves it open.
     */
    static boolean closeOpenedByKeyboard(Class<?> screen) {
        Activity a = openedByKeyboard(screen);
        if (a == null) return false;
        try {
            if (a.isTaskRoot() && aloneInTask(a)) a.finishAndRemoveTask();
            else a.finish();
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }
}
