package com.mrkeyboard.app;

import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.List;

/**
 * v1.88: which languages the word screens offer and which one they start on. "What the keyboard learned" and "Add words and texts" share
 * the choice: the language picked on one is the one the other opens on, so the person does not choose it twice in a row. Plain Java apart
 * from the preferences, so the rules are checked on the PC (LangTest).
 */
final class MrLang {
    /** Where the last choice is kept (the same file as the other word-screen settings). */
    static final String PREFS = "mr_words";
    static final String P_LAST = "lang_last";

    private MrLang() {
    }

    /** The languages to offer: the installed packs first, then any other that has data; the three of the app when there is nothing at all. */
    static List<String> offered(List<String> installedIds, List<String> withData) {
        List<String> out = new ArrayList<String>(MrLearned.languages(installedIds, withData));
        if (out.isEmpty()) {
            out.add("pt_BR");
            out.add("en_US");
            out.add("es");
        }
        return out;
    }

    /**
     * The language to show: the one already chosen on this screen (when it is still offered), else the last one chosen on any word screen,
     * else the one of the interface (first offered with the same language), else the first offered. {@code offered} is never empty.
     */
    static String pick(List<String> offered, String current, String last, String uiLanguage) {
        if (current != null && offered.contains(current)) return current;
        if (last != null && offered.contains(last)) return last;
        if (uiLanguage != null) {
            for (String l : offered) {
                if (MrPacks.splitLocale(l)[0].equals(uiLanguage)) return l;
            }
        }
        return offered.get(0);
    }

    static String last(SharedPreferences p) {
        try {
            return p.getString(P_LAST, null);
        } catch (RuntimeException e) {
            return null;
        }
    }

    static void remember(SharedPreferences p, String locale) {
        if (locale == null || locale.length() == 0) return;
        try {
            p.edit().putString(P_LAST, locale).apply();
        } catch (RuntimeException e) {
            // the choice is a convenience: not remembering it breaks nothing
        }
    }
}
