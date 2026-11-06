package com.mrkeyboard.app;

import android.content.SharedPreferences;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** PC test of the language choice shared by the word screens (MrLang, v1.88). Runs through docs/tools/run_java_tests.sh. */
public class LangTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    /** SharedPreferences in memory. */
    static class Mem implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();
        boolean broken;

        public Map<String, ?> getAll() { return m; }
        public String getString(String key, String def) {
            if (broken) throw new IllegalStateException("broken");
            return m.containsKey(key) ? (String) m.get(key) : def;
        }
        public int getInt(String key, int def) { return def; }
        public long getLong(String key, long def) { return def; }
        public boolean getBoolean(String key, boolean def) { return def; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String key, String v) { if (broken) throw new IllegalStateException("broken"); m.put(key, v); return this; }
                public Editor putInt(String key, int v) { m.put(key, v); return this; }
                public Editor putLong(String key, long v) { m.put(key, v); return this; }
                public Editor putBoolean(String key, boolean v) { m.put(key, v); return this; }
                public Editor remove(String key) { m.remove(key); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
    }

    static List<String> list(String... s) {
        return new ArrayList<String>(Arrays.asList(s));
    }

    public static void main(String[] a) {
        // ---- offered
        check("offered: installed packs first, in their order", MrLang.offered(list("en_US", "pt_BR"), list()).equals(list("en_US", "pt_BR")));
        check("offered: installed ids with a dash become locales", MrLang.offered(list("pt-BR"), list()).equals(list("pt_BR")));
        check("offered: a language with data and no pack comes after the packs",
                MrLang.offered(list("pt_BR"), list("fr_FR", "pt_BR")).equals(list("pt_BR", "fr_FR")));
        check("offered: nothing at all gives the three languages of the app",
                MrLang.offered(list(), list()).equals(list("pt_BR", "en_US", "es")));

        List<String> three = list("pt_BR", "en_US", "es");
        // ---- pick
        check("pick: the language already chosen on the screen wins", MrLang.pick(three, "es", "en_US", "pt").equals("es"));
        check("pick: the last choice of the other screen comes next", MrLang.pick(three, null, "en_US", "pt").equals("en_US"));
        check("pick: a choice that is no longer offered is ignored", MrLang.pick(three, "fr_FR", "de_DE", "es").equals("es"));
        check("pick: the UI language when nothing was chosen", MrLang.pick(three, null, null, "en").equals("en_US"));
        check("pick: the UI language without a pack gives the first one", MrLang.pick(three, null, null, "fr").equals("pt_BR"));
        check("pick: a null UI language gives the first one", MrLang.pick(three, null, null, null).equals("pt_BR"));
        check("pick: one language only", MrLang.pick(list("es"), null, "en_US", "pt").equals("es"));

        // ---- memory of the last choice
        Mem p = new Mem();
        check("last: nothing before the first choice", MrLang.last(p) == null);
        MrLang.remember(p, "en_US");
        check("last: the choice is kept", "en_US".equals(MrLang.last(p)));
        MrLang.remember(p, "es");
        check("last: the new choice replaces it", "es".equals(MrLang.last(p)));
        MrLang.remember(p, null);
        MrLang.remember(p, "");
        check("last: an empty choice is not kept", "es".equals(MrLang.last(p)));
        // the learned screen picks, the import screen opens on the same language
        MrLang.remember(p, "en_US");
        check("flow: the second screen opens on the language chosen on the first",
                MrLang.pick(three, null, MrLang.last(p), "pt").equals("en_US"));
        // the import screen keeps the language of its last import for the undo under "last_locale": the language choice must not touch it
        Mem shared = new Mem();
        shared.m.put("last_locale", "pt_BR");
        shared.m.put("last_batch", Long.valueOf(7L));
        MrLang.remember(shared, "es");
        check("keys: the choice does not overwrite the language kept for undoing the last import",
                "pt_BR".equals(shared.m.get("last_locale")) && Long.valueOf(7L).equals(shared.m.get("last_batch")) && "es".equals(MrLang.last(shared)));
        check("keys: the key of the choice is its own", !MrLang.P_LAST.equals("last_locale") && !MrLang.P_LAST.equals("last_batch") && !MrLang.P_LAST.equals("last_count"));
        Mem bad = new Mem();
        bad.broken = true;
        MrLang.remember(bad, "es");
        check("last: preferences that fail do not break the screen", MrLang.last(bad) == null);

        System.out.println(ok + " ok, " + fail + " fail");
        if (fail > 0) System.exit(1);
    }
}
