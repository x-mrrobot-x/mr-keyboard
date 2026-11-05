package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

/**
 * The one place that builds the Intent that opens a screen of the app (Settings, Packs, Sheets, AI Editor settings and
 * its style editor).
 * <p>
 * From the keyboard (a Service, not an Activity) the screen has to start in a task: NEW_TASK, which the manifest sends
 * to the shared task of those screens (taskAffinity), so that Back returns to the app being typed in. REORDER_TO_FRONT
 * brings the screen to the front if it is already open in that task, instead of stacking another copy: tapping the
 * gear three times no longer needs three Backs. CLEAR_TOP is deliberately not used (it would also close what the user
 * has open above the screen, such as a style being edited) and, if it were set, REORDER_TO_FRONT would be ignored.
 * <p>
 * From a screen (an Activity) the new screen goes on the stack of the one that opened it, so no NEW_TASK; but
 * REORDER_TO_FRONT is kept, so that a copy that is already in that stack (a style editor left under the list of styles,
 * for instance) is brought to the front instead of getting a second one. The manifest's launchMode="singleTop" answers
 * a double tap with a call to onNewIntent of the screen already on top.
 */
public final class MrNav {
    /** Flag of every screen: an open copy in the task is brought to the front, not duplicated. */
    static final int REUSE = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT;
    /** Flags of a screen opened from the keyboard window. */
    static final int FROM_KEYBOARD = Intent.FLAG_ACTIVITY_NEW_TASK | REUSE;

    private MrNav() { }

    /** Intent that opens the screen; the caller adds its extras and starts it. */
    public static Intent intent(Context from, Class<?> screen) {
        Intent i = new Intent(from, screen);
        i.addFlags(from instanceof Activity ? REUSE : FROM_KEYBOARD);
        return i;
    }
}
