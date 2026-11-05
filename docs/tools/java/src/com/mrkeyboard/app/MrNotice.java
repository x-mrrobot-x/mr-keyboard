package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

/**
 * Notices that appear only once (v1.64). Today: the first time the Translate panel opens, it warns
 * that the text of that field goes to Google Translate. Since v1.78 it also warns, the first
 * time the AI Editor opens, that the rewritten text goes to the service the user configured.
 */
public final class MrNotice {
    private MrNotice() { }

    static final String PREFS = "mr_notices";
    static final String KEY_TRANSLATE = "translate_seen";
    static final String KEY_AI = "ai_seen";

    /** Called by MrTools.enterTranslate. Never throws an exception. */
    public static void translate(Context c) {
        once(c, KEY_TRANSLATE, "mr_tr_notice");
    }

    /** Called by MrAi.onOpen (first opening of the AI Editor). Never throws an exception. */
    public static void aiEditor(Context c) {
        once(c, KEY_AI, "mr_ai_notice");
    }

    private static void once(Context c, String key, String stringName) {
        try {
            if (c == null) return;
            SharedPreferences p = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
            if (p.getBoolean(key, false)) return;
            String msg = MrPacks.text(c, stringName);
            if (msg == null) return;
            p.edit().putBoolean(key, true).apply();
            Toast.makeText(c, msg, Toast.LENGTH_LONG).show();
        } catch (RuntimeException e) {
            // without the notice, the panel opens normally
        }
    }
}
