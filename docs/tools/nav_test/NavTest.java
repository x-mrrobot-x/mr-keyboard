package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.inputmethodservice.InputMethodService;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Opening screens without stacking copies: the Intent that MrNav builds (flags from the keyboard window and from a
 * screen), and what the AI style editor does when it is asked for again while it is already open.
 */
public class NavTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static class Screen extends Activity { }

    /** A screen with the Intent it was started with, and the answers that the system would give about its state. */
    static class Opened extends Activity {
        final Intent in = new Intent();
        boolean finishing, destroyed, failToClose;
        Opened(boolean fromKeyboard, boolean root) {
            if (fromKeyboard) in.putExtra(MrNav.EXTRA_FROM_KEYBOARD, true);
            stubTaskRoot = root;
        }
        public Intent getIntent() { return in; }
        public boolean isFinishing() { return finishing; }
        public boolean isDestroyed() { return destroyed; }
        public void finishAndRemoveTask() {
            if (failToClose) throw new IllegalStateException("the system refused");
            super.finishAndRemoveTask();
        }
    }

    static class Other extends Opened {
        Other(boolean fromKeyboard, boolean root) { super(fromKeyboard, root); }
    }

    static String file(String path) {
        try {
            return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
        } catch (Exception e) {
            return "";
        }
    }

    static final int NEW_TASK = Intent.FLAG_ACTIVITY_NEW_TASK;
    static final int REORDER = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT;

    public static void main(String[] a) {
        // ---- from the keyboard (a Service): a task, and the open screen is brought to the front
        Intent i = MrNav.intent(new InputMethodService(), MrAiPrefs.class);
        check("keyboard: the screen is the class asked for", MrAiPrefs.class.getName().equals(i.className));
        check("keyboard: NEW_TASK and REORDER_TO_FRONT", i.flags == (NEW_TASK | REORDER));
        check("keyboard: no CLEAR_TOP (it would cancel REORDER_TO_FRONT and close what is above)",
                (i.flags & Intent.FLAG_ACTIVITY_CLEAR_TOP) == 0);
        check("keyboard: no MULTIPLE_TASK (it would open a new task on every tap)",
                (i.flags & Intent.FLAG_ACTIVITY_MULTIPLE_TASK) == 0);
        check("keyboard: no CLEAR_TASK (it would erase the screens the user has open)",
                (i.flags & Intent.FLAG_ACTIVITY_CLEAR_TASK) == 0);
        Class<?>[] screens = {LatinIMESettings.class, PrefScreenSheets.class, MrPacksActivity.class,
                MrAiPrefs.class, MrAiStyleActivity.class};
        boolean same = true;
        for (Class<?> c : screens) {
            Intent x = MrNav.intent(new InputMethodService(), c);
            same &= c.getName().equals(x.className) && x.flags == (NEW_TASK | REORDER);
        }
        check("the five screens that the keyboard opens get the same flags", same);
        check("another context that is not a screen (the application) is treated as the keyboard",
                MrNav.intent(new Application(), MrPacksActivity.class).flags == (NEW_TASK | REORDER));

        // ---- from a screen: no flags, the new one goes on top of the one that opened it
        Intent s = MrNav.intent(new Screen(), MrAiStyleActivity.class);
        check("screen: only REORDER_TO_FRONT (a copy already in the stack is reused)", s.flags == REORDER);
        check("screen: no NEW_TASK (stays in the task of the one that opened it)",
                (s.flags & Intent.FLAG_ACTIVITY_NEW_TASK) == 0);
        check("screen: no CLEAR_TOP (it would cancel REORDER_TO_FRONT and close what is above)",
                (s.flags & Intent.FLAG_ACTIVITY_CLEAR_TOP) == 0);
        check("screen: the class asked for", MrAiStyleActivity.class.getName().equals(s.className));
        s.putExtra(MrAi.EXTRA_STYLE, 3);
        check("the caller can add its extras", s.getIntExtra(MrAi.EXTRA_STYLE, -1) == 3);
        check("the keyboard intent also takes extras without losing the flags",
                MrNav.intent(new InputMethodService(), MrAiStyleActivity.class)
                        .putExtra(MrAi.EXTRA_STYLE, 1).flags == (NEW_TASK | REORDER));

        // ---- the style editor already open
        check("index inside the list is kept", MrAiStyleActivity.normalIndex(0, 3) == 0 && MrAiStyleActivity.normalIndex(2, 3) == 2);
        check("-1 is a new style", MrAiStyleActivity.normalIndex(-1, 3) == -1);
        check("past the end of the list is a new style", MrAiStyleActivity.normalIndex(3, 3) == -1 && MrAiStyleActivity.normalIndex(9, 0) == -1);
        check("negative other than -1 is a new style", MrAiStyleActivity.normalIndex(-5, 3) == -1);

        check("same style asked for again: stays, nothing is reloaded", !MrAiStyleActivity.shouldReload(1, 1, false));
        check("new style asked for while on a new style: stays", !MrAiStyleActivity.shouldReload(-1, -1, false));
        check("another style and nothing typed: reloads", MrAiStyleActivity.shouldReload(2, 1, false));
        check("a new style asked for while editing an old one, nothing typed: reloads", MrAiStyleActivity.shouldReload(-1, 2, false));
        check("another style but there are unsaved edits: stays (the draft is not lost)", !MrAiStyleActivity.shouldReload(2, 1, true));
        check("same style with unsaved edits: stays", !MrAiStyleActivity.shouldReload(1, 1, true));

        String[] saved = {"✨", "Pirata", "Fale como um pirata"};
        check("saved style, nothing changed: clean", !MrAiStyleActivity.isDirty("Pirata", "Fale como um pirata", "✨", saved));
        check("... with spaces around the text: still clean (the save trims)",
                !MrAiStyleActivity.isDirty("  Pirata ", "\nFale como um pirata  ", "✨", saved));
        check("saved style, name changed: dirty", MrAiStyleActivity.isDirty("Pirata 2", "Fale como um pirata", "✨", saved));
        check("saved style, instructions changed: dirty", MrAiStyleActivity.isDirty("Pirata", "Fale como um marinheiro", "✨", saved));
        check("saved style, emoji changed: dirty", MrAiStyleActivity.isDirty("Pirata", "Fale como um pirata", "🏴", saved));
        check("saved style, field cleared: dirty", MrAiStyleActivity.isDirty("", "Fale como um pirata", "✨", saved));
        check("new style, empty form: clean", !MrAiStyleActivity.isDirty("", "", "✨", null));
        check("new style, only spaces: clean", !MrAiStyleActivity.isDirty("  ", "\n", "✨", null));
        check("new style, name typed: dirty", MrAiStyleActivity.isDirty("A", "", "✨", null));
        check("new style, instructions typed: dirty", MrAiStyleActivity.isDirty("", "A", "✨", null));
        check("new style, another emoji chosen: dirty", MrAiStyleActivity.isDirty("", "", "🏴", null));
        check("null texts count as empty", !MrAiStyleActivity.isDirty(null, null, "✨", null));

        // ---- the extra that says "the keyboard opened this" (and only the keyboard)
        check("from the keyboard: the Intent carries the extra of the keyboard", i.getBooleanExtra(MrNav.EXTRA_FROM_KEYBOARD, false));
        check("from a screen: no such extra (that screen goes on the stack of the one that opened it)", !s.getBooleanExtra(MrNav.EXTRA_FROM_KEYBOARD, false));
        check("the extra does not change the flags that decide the task", i.flags == (NEW_TASK | REORDER) && s.flags == REORDER);

        // ---- the screens that the keyboard opened are remembered, and closed when they are not needed
        Opened ai = new Opened(true, true);
        MrNav.opened(ai);
        check("a screen that the keyboard opened is found by its class", MrNav.openedByKeyboard(Opened.class) == ai);
        check("... and not under another class", MrNav.openedByKeyboard(Other.class) == null);
        Opened fromMain = new Opened(false, true);
        MrNav.opened(fromMain);
        check("a screen that another screen opened (no extra) is not remembered: it is not the keyboard's to close", MrNav.openedByKeyboard(Opened.class) == ai);
        MrNav.opened(null);
        MrNav.gone(null);
        check("null does nothing", MrNav.openedByKeyboard(Opened.class) == ai);
        check("closing a class that has nothing open: false, nothing happens", !MrNav.closeOpenedByKeyboard(Other.class));
        check("closing the root of the task: the whole task goes (finishAndRemoveTask, no entry left in the recent apps)",
                MrNav.closeOpenedByKeyboard(Opened.class) && ai.stubTaskRemovals == 1);
        MrNav.gone(ai);
        check("destroyed: no longer there", MrNav.openedByKeyboard(Opened.class) == null && !MrNav.closeOpenedByKeyboard(Opened.class));

        Opened inner = new Opened(true, false);
        MrNav.opened(inner);
        check("a screen that is not the root of its task: only that screen is finished, the task stays", MrNav.closeOpenedByKeyboard(Opened.class) && inner.stubFinishes == 1 && inner.stubTaskRemovals == 0);
        MrNav.gone(inner);

        Opened going = new Opened(true, true);
        MrNav.opened(going);
        going.finishing = true;
        check("a screen that is already finishing is not found (and not finished again)", MrNav.openedByKeyboard(Opened.class) == null && !MrNav.closeOpenedByKeyboard(Opened.class) && going.stubFinishes == 0);
        going.finishing = false;
        going.destroyed = true;
        check("a destroyed one is not found either", MrNav.openedByKeyboard(Opened.class) == null);
        Opened later = new Opened(true, true);
        MrNav.opened(later);
        check("... and the one opened later is (the destroyed one is dropped from the list)", MrNav.openedByKeyboard(Opened.class) == later);
        MrNav.gone(later);
        MrNav.gone(going);

        Opened first = new Opened(true, true);
        Opened second = new Opened(true, true);
        MrNav.opened(first);
        MrNav.opened(second);
        check("two of the same class (the screen was created again): the newest is the one", MrNav.openedByKeyboard(Opened.class) == second);
        MrNav.gone(second);
        check("... and when it goes the other is still there", MrNav.openedByKeyboard(Opened.class) == first);
        MrNav.gone(first);

        Opened stubborn = new Opened(true, true);
        stubborn.failToClose = true;
        MrNav.opened(stubborn);
        boolean refused = true;
        boolean closed = true;
        try { closed = MrNav.closeOpenedByKeyboard(Opened.class); } catch (RuntimeException e) { refused = false; }
        check("the system refusing to close it: no failure, and the answer is false", refused && !closed);
        MrNav.gone(stubborn);

        // the callbacks of MrScreens are what feeds the list
        MrScreens cb = new MrScreens();
        Opened viaCallbacks = new Opened(true, true);
        cb.onActivityCreated(viaCallbacks, null);
        check("MrScreens.onActivityCreated remembers the screen that the keyboard opened", MrNav.openedByKeyboard(Opened.class) == viaCallbacks);
        cb.onActivityDestroyed(viaCallbacks);
        check("MrScreens.onActivityDestroyed forgets it", MrNav.openedByKeyboard(Opened.class) == null);
        Opened mainScreen = new Opened(false, true);
        cb.onActivityCreated(mainScreen, null);
        check("a screen that the keyboard did not open is not remembered by the callbacks", MrNav.openedByKeyboard(Opened.class) == null);
        cb.onActivityDestroyed(mainScreen);

        // ---- the manifest: no second window of the app in the recent apps
        String manifest = file("AndroidManifest.xml");
        Matcher m = Pattern.compile("<activity\\b[^>]*>").matcher(manifest);
        int withAffinity = 0, excluded = 0;
        boolean sheetsOk = false;
        while (m.find()) {
            String tag = m.group();
            if (!tag.contains("android:taskAffinity=\"com.mrkeyboard.app.screens\"")) continue;
            withAffinity++;
            if (tag.contains("android:excludeFromRecents=\"true\"")) excluded++;
        }
        check("the manifest has the task of the keyboard screens (8 screens with its affinity)", withAffinity == 8);
        check("every one of them is excluded from the recent apps (any of them can be the root of the task, and the task is not a second window of the app)", excluded == withAffinity);
        Matcher home = Pattern.compile("<activity\\b[^>]*android:name=\"com\\.mrkeyboard\\.app\\.Main\"[^>]*>").matcher(manifest);
        check("the home screen (Main) is not excluded: it is the one window that the app has in the recent apps", home.find() && !home.group().contains("excludeFromRecents"));

        System.out.println(ok + " ok, " + fail + " failures");
        if (fail > 0) System.exit(1);
    }
}
