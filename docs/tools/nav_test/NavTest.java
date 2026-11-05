package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Application;
import android.content.Intent;
import android.inputmethodservice.InputMethodService;

/**
 * Opening screens without stacking copies: the Intent that MrNav builds (flags from the keyboard window and from a
 * screen), and what the AI style editor does when it is asked for again while it is already open.
 */
public class NavTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static class Screen extends Activity { }

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

        System.out.println(ok + " ok, " + fail + " failures");
        if (fail > 0) System.exit(1);
    }
}
