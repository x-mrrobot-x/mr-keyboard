package com.mrkeyboard.app;

import android.content.Context;
import android.view.inputmethod.EditorInfo;

/**
 * The quick test field of the sheet editor (SheetEditorActivity): the keyboard opens on the sheet that is being edited and stays on it while the
 * person types there, instead of opening on ABC and going back to ABC after every key ("Return to the main sheet after typing").
 *
 * <p>The field says which sheet in its privateImeOptions ({@link #option}: "com.mrkeyboard.app.sheet=&lt;id&gt;", one of the comma separated
 * options). The keyboard honours it only for a field of this same app: another app that writes it gets nothing. The sheet is looked up by its id
 * every time (SheetStore keeps the list in memory), so a sheet that moved in the list is still found and one that is gone is simply not shown.
 *
 * <p>LatinIME calls {@link #show} at the end of onStartInputView and of onWindowShown (both put the keyboard back on ABC first, as they do for
 * every field) and {@link #holds} in returnToMainSheet, before it goes back to ABC. Any failure here leaves the keyboard as it was.
 */
public final class MrSheetTest {
    /** The option of the field, before the id of the sheet. */
    static final String PREFIX = "com.mrkeyboard.app.sheet=";

    private MrSheetTest() { }

    /** The privateImeOptions of a test field for the sheet {@code sheetId}. */
    static String option(String sheetId) {
        return sheetId == null ? PREFIX : PREFIX + sheetId;
    }

    /** The id of the sheet that the field asks for, or null: no option, an empty id, or a field of another app ({@code ownPackage}). */
    static String sheetId(EditorInfo info, String ownPackage) {
        if (info == null || ownPackage == null || !ownPackage.equals(info.packageName) || info.privateImeOptions == null) return null;
        String[] parts = info.privateImeOptions.split(",");
        for (int i = 0; i < parts.length; i++) {
            String part = parts[i].trim();
            if (!part.startsWith(PREFIX)) continue;
            String id = part.substring(PREFIX.length()).trim();
            return id.length() == 0 ? null : id;
        }
        return null;
    }

    /** Where that sheet is on the keyboard (1 = the first sheet after ABC), or 0 when the field asks for none or the sheet is not there. */
    static int position(Context c, EditorInfo info) {
        if (c == null) return 0;
        String id = sheetId(info, c.getPackageName());
        if (id == null) return 0;
        int index = SheetStore.findSheetIndexById(c, id);
        return index < 0 ? 0 : index + 1;
    }

    /** The keyboard opened (or was shown again) for a field: on the test field it goes to the sheet that the field asks for. */
    public static void show(LatinIME ime) {
        try {
            int at = position(ime, ime.getCurrentInputEditorInfo());
            if (at <= 0) return;
            KeyboardSwitcher switcher = KeyboardSwitcher.getInstance();
            if (switcher != null && switcher.getSheet() == at) return;
            // changeSheet counts from 1 (0 is "next" and -1 "previous"): position + 1
            ime.changeSheet(at + 1);
        } catch (Throwable t) {
            // the keyboard stays on the sheet it is on
        }
    }

    /** True on the test field: "Return to the main sheet after typing" leaves the keyboard on the sheet. */
    public static boolean holds(LatinIME ime) {
        try {
            return position(ime, ime.getCurrentInputEditorInfo()) > 0;
        } catch (Throwable t) {
            return false;
        }
    }
}
