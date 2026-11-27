package com.mrkeyboard.app;

import android.content.ContextWrapper;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * PC test of the keys of ABC that the person edits (MrAbcKeys): which keys of the XML change and which stay fixed, ABC as the editor shows
 * it (rows, widths, the gap of the row of A, the padlocks), what is saved (only the keys that differ; a popup not touched stays the one of
 * the language), the JSON and the backup of the sheets, and the keys of the keyboard after the edits (label, what it writes, popup, capital
 * for Shift), with the other layouts and a broken preference left alone. The real configuration of a key is the one of the sheets
 * (SheetKeyboardBuilder.configureKeyFromSpec, smali); the stub here does the same for text and special keys. Runs through
 * docs/tools/run_java_tests.sh, with the working org.json of docs/tools/abc_test/stubs.
 */
public class AbcKeysTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    /** In-memory preferences. */
    static class Prefs implements SharedPreferences {
        final java.util.Map<String, Object> m = new java.util.HashMap<String, Object>();
        public java.util.Map<String, ?> getAll() { return m; }
        public String getString(String key, String def) { Object o = m.get(key); return o == null ? def : (String) o; }
        public int getInt(String key, int def) { Object o = m.get(key); return o == null ? def : ((Integer) o).intValue(); }
        public long getLong(String key, long def) { Object o = m.get(key); return o == null ? def : ((Long) o).longValue(); }
        public boolean getBoolean(String key, boolean def) { Object o = m.get(key); return o == null ? def : ((Boolean) o).booleanValue(); }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String k, String v) { m.put(k, v); return this; }
                public Editor putInt(String k, int v) { m.put(k, Integer.valueOf(v)); return this; }
                public Editor putLong(String k, long v) { m.put(k, Long.valueOf(v)); return this; }
                public Editor putBoolean(String k, boolean v) { m.put(k, Boolean.valueOf(v)); return this; }
                public Editor remove(String k) { m.remove(k); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
    }

    /** A key of the XML: unit = 100 px (a tenth of a keyboard of 1000). */
    static Keyboard.Key key(String label, int code, int x, int y, int width) {
        Keyboard.Key k = new Keyboard.Key(code, x, y, width, 80);
        k.label = label;
        return k;
    }

    static Keyboard.Key letter(String label, int x, int y, String popup) {
        Keyboard.Key k = key(label, label.charAt(0), x, y, 100);
        k.popupCharacters = popup;
        k.popupResId = popup == null ? 0 : 0x7f0f000a;
        k.shiftLabel = label.toUpperCase();
        return k;
    }

    static Keyboard.Key system(String label, int code, int x, int y, int width) {
        Keyboard.Key k = key(label, code, x, y, width);
        k.modifier = true;
        return k;
    }

    /** A small ABC with the shape of kbd_qwerty: the grid key row, Ctrl and arrows, digits, three rows of letters and the bottom row. */
    static List<Keyboard.Key> abc() {
        ArrayList<Keyboard.Key> keys = new ArrayList<Keyboard.Key>();
        keys.add(system(null, -306, 0, 0, 102));
        keys.add(letter("-", 102, 0, null));
        keys.add(key("=>", '=', 204, 0, 102));
        keys.add(system("Ctrl", -113, 0, 100, 142));
        keys.add(system("←", -21, 142, 100, 100));
        keys.add(letter("{", 242, 100, null));
        keys.add(letter("1", 0, 200, null));
        keys.add(letter("2", 100, 200, null));
        keys.add(letter("q", 0, 300, "1"));
        keys.add(letter("w", 100, 300, "2"));
        Keyboard.Key a = letter("a", 50, 400, "áàâã");
        a.gap = 50;
        keys.add(a);
        keys.add(letter("s", 150, 400, "ß"));
        keys.add(system(null, -1, 0, 500, 150));
        keys.add(letter("z", 150, 500, null));
        keys.add(system(null, -5, 250, 500, 150));
        Keyboard.Key tab = key("↹", 9, 0, 600, 100);
        keys.add(tab);
        Keyboard.Key dot = system(".", '.', 100, 600, 100);
        dot.edgeFlags = Keyboard.EDGE_BOTTOM;
        keys.add(dot);
        Keyboard.Key at = letter("@", 200, 600, null);
        at.edgeFlags = Keyboard.EDGE_BOTTOM;
        keys.add(at);
        return keys;
    }

    static SheetModel.KeySpec at(SheetModel.Sheet s, int row, int k) { return s.rows.get(row).keys.get(k); }

    public static void main(String[] a) throws Exception {
        // ---------------------------------------------------------------- which keys change
        List<Keyboard.Key> keys = abc();
        check("a letter, a digit and a symbol change", MrAbcKeys.editable(keys.get(8)) && MrAbcKeys.editable(keys.get(6))
                && MrAbcKeys.editable(keys.get(1)) && MrAbcKeys.editable(keys.get(2)));
        check("Shift, delete, Ctrl, an arrow and the grid key are fixed", !MrAbcKeys.editable(keys.get(12)) && !MrAbcKeys.editable(keys.get(14))
                && !MrAbcKeys.editable(keys.get(3)) && !MrAbcKeys.editable(keys.get(4)) && !MrAbcKeys.editable(keys.get(0)));
        check("a key that writes a control character (Tab) is fixed", !MrAbcKeys.editable(keys.get(15)));
        check("the bottom row is fixed, even a key that writes a character", !MrAbcKeys.editable(keys.get(16)) && !MrAbcKeys.editable(keys.get(17)));
        Keyboard.Key icon = letter("x", 0, 0, null);
        icon.icon = new android.graphics.drawable.ColorDrawable(0);
        check("a key with an icon is fixed", !MrAbcKeys.editable(icon) && !MrAbcKeys.editable(null));
        check("only the layouts of ABC", MrAbcKeys.isAbcXml(0x7f0f000b) && MrAbcKeys.isAbcXml(0x7f0f0005) && MrAbcKeys.isAbcXml(0x7f0f0001)
                && !MrAbcKeys.isAbcXml(0x7f0f000c));

        // ---------------------------------------------------------------- ABC in the editor
        MrAbcKeys.Model m = MrAbcKeys.fromKeys(keys, 1000);
        SheetModel.Sheet d = m.defaults;
        check("six rows: the bottom row is left out", d.rows.size() == 6 && m.ids.length == 6);
        check("row of the grid key: fixed, then '-' and '=>'", m.locked(0, 0) && "-".equals(m.ids[0][1]) && "=>".equals(m.ids[0][2])
                && SheetModel.TYPE_SPECIAL.equals(at(d, 0, 0).type) && "-306".equals(at(d, 0, 0).value));
        check("a key that changes is a text key with its label, text and popup", SheetModel.TYPE_TEXT.equals(at(d, 3, 0).type)
                && "q".equals(at(d, 3, 0).label) && "q".equals(at(d, 3, 0).value) && "1".equals(at(d, 3, 0).popupChars));
        check("widths in tenths of the keyboard (1.42 for Ctrl, 1 for a letter)", Math.abs(at(d, 1, 0).width - 1.42f) < 0.01f
                && Math.abs(at(d, 3, 1).width - 1f) < 0.01f);
        check("fixed keys keep their label (Ctrl, ←); one with only an icon gets a label", "Ctrl".equals(at(d, 1, 0).label)
                && "←".equals(at(d, 1, 1).label) && at(d, 5, 0).label != null && at(d, 5, 0).label.length() > 0);
        check("the row of A: a gap before it and the same gap after it, both fixed", d.rows.get(4).keys.size() == 4
                && SheetModel.TYPE_SPACER.equals(at(d, 4, 0).type) && SheetModel.TYPE_SPACER.equals(at(d, 4, 3).type)
                && Math.abs(at(d, 4, 0).width - 0.5f) < 0.01f && Math.abs(at(d, 4, 3).width - 0.5f) < 0.01f
                && m.locked(4, 0) && m.locked(4, 3) && "a".equals(m.ids[4][1]));
        check("the delete key is left out (the grid draws its ⌫)", d.rows.get(5).keys.size() == 2 && "z".equals(m.ids[5][1]) && m.locked(5, 0));
        check("the editor starts with ABC as in the XML", MrAbcKeys.diff(m, m.sheet).isEmpty());
        boolean[][] lockedMap = m.lockedMap();
        check("the map of padlocks for the grid", lockedMap[0][0] && !lockedMap[3][0] && lockedMap[4][0] && !lockedMap[4][1]);
        check("outside the rows is fixed", m.locked(9, 0) && m.locked(3, 9) && m.locked(-1, 0));

        // ---------------------------------------------------------------- what is saved
        SheetModel.Sheet edited = MrAbcKeys.copySheet(m.defaults);
        SheetModel.KeySpec q = at(edited, 3, 0);
        q.label = "ç";
        q.value = "ç";
        SheetModel.KeySpec w = at(edited, 3, 1);
        w.popupChars = "€£";
        SheetModel.KeySpec one = at(edited, 2, 0);
        one.type = SheetModel.TYPE_SPECIAL;
        one.value = "-21";
        one.label = "←";
        one.popupChars = null;
        Map<String, MrAbcKeys.Entry> diff = MrAbcKeys.diff(m, edited);
        check("three keys differ, in the order of the keyboard", diff.size() == 3
                && new ArrayList<String>(diff.keySet()).toString().equals("[1, q, w]"));
        check("q: what it writes changed, its popup did not (it stays the one of the language)", diff.get("q").defaultPopup
                && diff.get("q").spec.popupChars == null && "ç".equals(diff.get("q").spec.value));
        check("w: only the popup changed", !diff.get("w").defaultPopup && "€£".equals(diff.get("w").spec.popupChars)
                && "w".equals(diff.get("w").spec.value));
        check("1: a special key now", SheetModel.TYPE_SPECIAL.equals(diff.get("1").spec.type) && "-21".equals(diff.get("1").spec.value));
        SheetModel.Sheet back = MrAbcKeys.copySheet(edited);
        at(back, 3, 0).label = "q";
        at(back, 3, 0).value = "q";
        check("a key edited back to the XML is no edit", !MrAbcKeys.diff(m, back).containsKey("q"));
        SheetModel.Sheet popupGone = MrAbcKeys.copySheet(m.defaults);
        at(popupGone, 3, 0).popupChars = null;
        check("a popup removed is an edit that clears it", MrAbcKeys.diff(m, popupGone).containsKey("q")
                && !MrAbcKeys.diff(m, popupGone).get("q").defaultPopup);

        String json = MrAbcKeys.toJson(diff);
        Map<String, MrAbcKeys.Entry> read = MrAbcKeys.entries(json);
        check("the JSON gives the same edits back", read.size() == 3 && read.get("q").defaultPopup && !read.get("w").defaultPopup
                && "ç".equals(read.get("q").spec.label) && "€£".equals(read.get("w").spec.popupChars)
                && SheetModel.TYPE_SPECIAL.equals(read.get("1").spec.type));
        check("no edit: no JSON", MrAbcKeys.toJson(new java.util.HashMap<String, MrAbcKeys.Entry>()) == null && MrAbcKeys.toJson(null) == null);
        check("a broken or foreign JSON is no edit", MrAbcKeys.entries("{oops").isEmpty() && MrAbcKeys.entries("[1,2]").isEmpty()
                && MrAbcKeys.entries("{\"v\":1}").isEmpty() && MrAbcKeys.entries(null).isEmpty());
        check("a gap in the JSON is not taken", MrAbcKeys.entries("{\"v\":1,\"keys\":{\"q\":{\"type\":\"spacer\"}}}").isEmpty());

        SheetModel.Sheet shown = MrAbcKeys.withEdits(m, read);
        check("the editor shows the edits, with the popup of the XML where it was not touched", "ç".equals(at(shown, 3, 0).label)
                && "1".equals(at(shown, 3, 0).popupChars) && "€£".equals(at(shown, 3, 1).popupChars) && "-21".equals(at(shown, 2, 0).value));
        check("... and the widths of the keyboard", Math.abs(at(shown, 3, 0).width - 1f) < 0.01f);
        m.sheet = shown;
        check("what the editor shows saves as the same edits", MrAbcKeys.diff(m, shown).size() == 3);

        // ---------------------------------------------------------------- save, count, restore
        Prefs prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
        ContextWrapper ctx = new ContextWrapper(null);
        int changed = KeyboardSwitcher.stubSheetsChanged;
        check("save writes the preference", MrAbcKeys.save(ctx, m) && prefs.m.get(MrAbcKeys.PREF) != null);
        check("... and the keyboard builds its keyboards again", KeyboardSwitcher.stubSheetsChanged == changed + 1);
        check("count of the ABC card", MrAbcKeys.count(ctx) == 3);
        m.sheet = MrAbcKeys.copySheet(m.defaults);
        check("ABC as in the XML: the preference goes", MrAbcKeys.save(ctx, m) && !prefs.m.containsKey(MrAbcKeys.PREF)
                && MrAbcKeys.count(ctx) == 0);
        m.sheet = shown;
        MrAbcKeys.save(ctx, m);
        check("restore", MrAbcKeys.reset(ctx) && !prefs.m.containsKey(MrAbcKeys.PREF) && MrAbcKeys.count(ctx) == 0);

        // ---------------------------------------------------------------- backup
        MrAbcKeys.save(ctx, m);
        String backup = MrAbcKeys.addToBackup(ctx, "{\"version\":2,\"sheets\":[]}");
        check("the backup carries the keys of ABC", backup.contains("\"abcKeys\"") && backup.contains("\"sheets\""));
        String plain = "{\"version\":2,\"sheets\":[]}";
        MrAbcKeys.reset(ctx);
        check("no edit: the backup is the same text", MrAbcKeys.addToBackup(ctx, plain) == plain);
        check("import: a backup with the keys of ABC brings them back", MrAbcKeys.takeFromBackup(ctx, backup) && MrAbcKeys.count(ctx) == 3);
        check("import: a backup without them leaves ABC as it is", !MrAbcKeys.takeFromBackup(ctx, plain) && MrAbcKeys.count(ctx) == 3);
        check("import: a broken file changes nothing", !MrAbcKeys.takeFromBackup(ctx, "{oops") && MrAbcKeys.count(ctx) == 3);

        // ---------------------------------------------------------------- the keyboard
        Keyboard kb = new Keyboard();
        kb.keys.addAll(abc());
        MrAbcKeys.apply(ctx, kb, 0x7f0f000b);
        Keyboard.Key kq = kb.keys.get(8), kw = kb.keys.get(9), k1 = kb.keys.get(6), k2 = kb.keys.get(7);
        check("q writes ç, with Ç for Shift", "ç".equals(String.valueOf(kq.label)) && kq.codes[0] == 'ç' && kq.text == null
                && "Ç".equals(String.valueOf(kq.shiftLabel)) && kq.stubCaseSet);
        check("q keeps the popup of the language", "1".equals(String.valueOf(kq.popupCharacters)) && kq.popupResId == 0x7f0f000a);
        check("w: the popup of the person", "€£".equals(String.valueOf(kw.popupCharacters)) && kw.codes[0] == 'w'
                && "W".equals(String.valueOf(kw.shiftLabel)));
        check("1 is a special key now (no capital, its popup cleared)", k1.codes[0] == -21 && k1.modifier && k1.shiftLabel == null
                && k1.popupCharacters == null && k1.popupResId == 0);
        check("a key that was not edited is not touched", k2.codes[0] == '2' && !k2.stubCaseSet);
        check("the fixed keys are not touched", kb.keys.get(12).codes[0] == -1 && !kb.keys.get(12).stubCaseSet
                && !kb.keys.get(16).stubCaseSet);

        Keyboard other = new Keyboard();
        other.keys.addAll(abc());
        MrAbcKeys.apply(ctx, other, 0x7f0f000c);
        check("another keyboard (symbols, a sheet) is not touched", other.keys.get(8).codes[0] == 'q' && !other.keys.get(8).stubCaseSet);
        Keyboard full = new Keyboard();
        full.keys.addAll(abc());
        MrAbcKeys.apply(ctx, full, 0x7f0f0005);
        check("the 5-row layout of ABC gets the same edits", full.keys.get(8).codes[0] == 'ç');

        Keyboard text = new Keyboard();
        text.keys.addAll(abc());
        prefs.m.put(MrAbcKeys.PREF, "{\"v\":1,\"keys\":{\"q\":{\"type\":\"text\",\"label\":\"Oi\",\"value\":\"Olá!\",\"width\":1}}}");
        MrAbcKeys.apply(ctx, text, 0x7f0f000b);
        Keyboard.Key tq = text.keys.get(8);
        check("a key that writes a text: the text, no capital", "Olá!".equals(String.valueOf(tq.text)) && "Oi".equals(String.valueOf(tq.label))
                && tq.shiftLabel == null && tq.stubCaseSet);

        Keyboard broken = new Keyboard();
        broken.keys.addAll(abc());
        prefs.m.put(MrAbcKeys.PREF, "{not json");
        boolean threw = false;
        try {
            MrAbcKeys.apply(ctx, broken, 0x7f0f000b);
        } catch (Throwable t) {
            threw = true;
        }
        check("a broken preference: the keyboard as in the XML, no exception", !threw && broken.keys.get(8).codes[0] == 'q');
        prefs.m.remove(MrAbcKeys.PREF);
        Keyboard none = new Keyboard();
        none.keys.addAll(abc());
        MrAbcKeys.apply(ctx, none, 0x7f0f000b);
        MrAbcKeys.apply(null, none, 0x7f0f000b);
        MrAbcKeys.apply(ctx, null, 0x7f0f000b);
        check("no edit: nothing touched", !none.keys.get(8).stubCaseSet && none.keys.get(8).codes[0] == 'q');

        check("capital: one letter only", "Ç".equals(MrAbcKeys.capital(kq)) && MrAbcKeys.capital(k1) == null && MrAbcKeys.capital(tq) == null
                && MrAbcKeys.capital(key("9", '9', 0, 0, 100)) == null);

        System.out.println(ok + " OK, " + fail + " FAIL");
        System.exit(fail == 0 ? 0 : 1);
    }
}
