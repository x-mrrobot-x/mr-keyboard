package com.mrkeyboard.app;

import android.content.ContextWrapper;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import java.util.ArrayList;
import java.util.List;

/**
 * PC test of ABC edited as a sheet (MrAbcKeys): the XML read as a sheet (rows, widths, the gap of the A row, Shift and Ctrl as special keys,
 * no delete and no bottom row), what is kept (nothing while it is the XML; the popups of the language named, not copied; the default name
 * and badge left out), the JSON, the backup of the sheets, the badge for the keys that name ABC, and the keyboard laid out again from it
 * (rows in the same room, the keys of the system of the XML moved, the others made as on the sheets with the popup of the language and their
 * capital, delete at the end of the last row, the bottom row untouched), with the other layouts and a broken preference left alone. The real
 * configuration of a key is the one of the sheets (SheetKeyboardBuilder.configureKeyFromSpec, smali); the stub does the same for text and
 * special keys. Runs through docs/tools/run_java_tests.sh, with the working org.json of docs/tools/abc_test/stubs.
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

    /** A key of the XML: a keyboard of 1000 px (a width of 1 = 100 px), rows of 100 px with keys of 80 px. */
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

    static Keyboard.Key bottom(String label, int code, int x) {
        Keyboard.Key k = system(label, code, x, 600, 200);
        k.edgeFlags = Keyboard.EDGE_BOTTOM;
        return k;
    }

    /** A small ABC with the shape of kbd_qwerty: the grid key row, Ctrl and an arrow, digits, three rows of letters and the bottom row. */
    static List<Keyboard.Key> abc() {
        ArrayList<Keyboard.Key> keys = new ArrayList<Keyboard.Key>();
        keys.add(system(null, -306, 0, 0, 102));          // 0
        keys.add(letter("-", 102, 0, null));               // 1
        keys.add(key("=>", '=', 204, 0, 102));             // 2
        keys.add(system("Ctrl", -113, 0, 100, 142));       // 3
        keys.add(system("←", -21, 142, 100, 100));         // 4
        keys.add(letter("{", 242, 100, null));             // 5
        keys.add(letter("1", 0, 200, null));               // 6
        keys.add(letter("2", 100, 200, null));             // 7
        keys.add(letter("q", 0, 300, "1"));                // 8
        keys.add(letter("w", 100, 300, "2"));              // 9
        Keyboard.Key a = letter("a", 50, 400, "áàâã");     // 10
        a.gap = 50;
        keys.add(a);
        keys.add(letter("s", 150, 400, "ß"));              // 11
        keys.add(system(null, -1, 0, 500, 150));           // 12 Shift
        keys.add(letter("z", 150, 500, null));             // 13
        keys.add(system(null, -5, 850, 500, 150));         // 14 delete
        keys.add(bottom("123", -300, 0));                  // 15
        keys.add(bottom(" ", 32, 200));                    // 16
        keys.add(bottom("@", '@', 400));                   // 17
        return keys;
    }

    static LatinKeyboard keyboard() {
        LatinKeyboard kb = new LatinKeyboard();
        kb.keys.addAll(abc());
        kb.stubWidth = 1000;
        kb.stubHeight = 700;
        kb.stubDefaultHeight = 100;
        kb.mLayoutRows = 7;
        return kb;
    }

    static SheetModel.KeySpec at(SheetModel.Sheet s, int row, int k) { return s.rows.get(row).keys.get(k); }

    static SheetModel.KeySpec text(String label, float width) { return new SheetModel.KeySpec(label, SheetModel.TYPE_TEXT, label, width); }

    static Keyboard.Key find(List<Keyboard.Key> keys, String label) {
        for (Keyboard.Key k : keys) if (k.label != null && label.equals(k.label.toString())) return k;
        return null;
    }

    public static void main(String[] a) throws Exception {
        // ---------------------------------------------------------------- the keys of the XML
        List<Keyboard.Key> keys = abc();
        check("a letter, a digit and a symbol are text keys", MrAbcKeys.editable(keys.get(8)) && MrAbcKeys.editable(keys.get(6))
                && MrAbcKeys.editable(keys.get(1)) && MrAbcKeys.editable(keys.get(2)));
        check("Shift, delete, Ctrl, an arrow and the grid key are keys of the system", !MrAbcKeys.editable(keys.get(12))
                && !MrAbcKeys.editable(keys.get(14)) && !MrAbcKeys.editable(keys.get(3)) && !MrAbcKeys.editable(keys.get(4))
                && !MrAbcKeys.editable(keys.get(0)));
        check("only the layouts of ABC", MrAbcKeys.isAbcXml(0x7f0f000b) && MrAbcKeys.isAbcXml(0x7f0f0005) && MrAbcKeys.isAbcXml(0x7f0f0001)
                && !MrAbcKeys.isAbcXml(0x7f0f000c));

        // ---------------------------------------------------------------- ABC of the XML as a sheet
        SheetModel.Sheet d = MrAbcKeys.fromKeys(keys, 1000, "Teclado principal");
        check("six rows, the bottom row left out", d.rows.size() == 6);
        check("name, badge and id of ABC", "Teclado principal".equals(d.name) && "ABC".equals(d.badge) && MrAbcKeys.ID.equals(d.id) && d.builtin);
        check("the grid key and Ctrl are special keys with their codes", SheetModel.TYPE_SPECIAL.equals(at(d, 0, 0).type)
                && "-306".equals(at(d, 0, 0).value) && "Ctrl".equals(at(d, 1, 0).label) && "-113".equals(at(d, 1, 0).value));
        check("a letter is a text key with its popup", SheetModel.TYPE_TEXT.equals(at(d, 3, 0).type) && "q".equals(at(d, 3, 0).value)
                && "1".equals(at(d, 3, 0).popupChars));
        check("widths in tenths of the keyboard", Math.abs(at(d, 1, 0).width - 1.42f) < 0.01f && Math.abs(at(d, 3, 1).width - 1f) < 0.01f);
        check("the A row: a gap before and after it", d.rows.get(4).keys.size() == 4 && MrAbcKeys.isGap(at(d, 4, 0)) && MrAbcKeys.isGap(at(d, 4, 3))
                && Math.abs(at(d, 4, 3).width - 0.5f) < 0.01f);
        check("Shift has a label, delete is left out (the grid draws it)", d.rows.get(5).keys.size() == 2 && at(d, 5, 0).label.length() > 0
                && "-1".equals(at(d, 5, 0).value));

        // ---------------------------------------------------------------- what is kept
        check("ABC as in the XML is the same sheet", MrAbcKeys.same(MrAbcKeys.copySheet(d), d));
        SheetModel.Sheet ed = MrAbcKeys.copySheet(d);
        ed.rows.remove(1);                                            // the row of Ctrl goes
        SheetModel.KeySpec aKey = ed.rows.get(3).keys.remove(1);      // the A moves to the end of the row of Q, renamed
        aKey.label = "à";
        aKey.value = "à";
        ed.rows.get(2).keys.add(aKey);
        at(ed, 2, 1).popupChars = "€£";                               // W gets a popup of its own
        ed.rows.get(1).keys.add(text("ç", 1.5f));                     // a new key in the row of the digits
        ed.name = "Meu ABC";
        check("an edited ABC is not the same sheet", !MrAbcKeys.same(ed, d));
        MrAbcKeys.Stored st = MrAbcKeys.toStored(ed, d);
        check("kept: five rows, the new name, no badge (the default one)", st.rows.size() == 5 && "Meu ABC".equals(st.name) && st.badge == null);
        MrAbcKeys.Item q = st.rows.get(2).get(0);
        check("Q keeps the popup of the XML: named, not copied", "q".equals(q.popupOf) && q.spec.popupChars == null);
        MrAbcKeys.Item movedA = st.rows.get(2).get(st.rows.get(2).size() - 1);
        check("the A moved and renamed keeps the popup of the A of the XML", "a".equals(movedA.popupOf) && movedA.spec.popupChars == null
                && "à".equals(movedA.spec.label));
        MrAbcKeys.Item w = st.rows.get(2).get(1);
        check("W keeps its own popup", w.popupOf == null && "€£".equals(w.spec.popupChars));
        MrAbcKeys.Item c = st.rows.get(1).get(st.rows.get(1).size() - 1);
        check("the new key, with its width", c.popupOf == null && "ç".equals(c.spec.label) && Math.abs(c.spec.width - 1.5f) < 0.01f);
        check("the default name is not kept", MrAbcKeys.toStored(MrAbcKeys.copySheet(d), d).name == null);

        String json = MrAbcKeys.toJson(st);
        MrAbcKeys.Stored back = MrAbcKeys.parse(json);
        check("the JSON gives the same ABC back", back != null && back.rows.size() == 5 && "Meu ABC".equals(back.name) && back.badge == null
                && "q".equals(back.rows.get(2).get(0).popupOf) && "€£".equals(back.rows.get(2).get(1).spec.popupChars)
                && MrAbcKeys.isGap(back.rows.get(3).get(0).spec));
        check("a broken JSON, one without rows (the old format) or none: no ABC", MrAbcKeys.parse("{oops") == null
                && MrAbcKeys.parse("{\"v\":1,\"keys\":{\"q\":{}}}") == null && MrAbcKeys.parse("{\"v\":2,\"rows\":[]}") == null
                && MrAbcKeys.parse(null) == null);
        SheetModel.Sheet shown = MrAbcKeys.toSheet(back, d);
        check("the editor shows the popups of the XML where they were kept", "1".equals(at(shown, 2, 0).popupChars)
                && "áàâã".equals(at(shown, 2, shown.rows.get(2).keys.size() - 1).popupChars) && "€£".equals(at(shown, 2, 1).popupChars));
        check("... the name kept and the default badge", "Meu ABC".equals(shown.name) && "ABC".equals(shown.badge));
        check("... and it is the sheet that was saved", MrAbcKeys.same(shown, ed));

        // ---------------------------------------------------------------- save, restore, badge
        Prefs prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
        ContextWrapper ctx = new ContextWrapper(null);
        MrAbcKeys.Model m = new MrAbcKeys.Model(MrAbcKeys.copySheet(d), d);
        int changed = KeyboardSwitcher.stubSheetsChanged;
        check("ABC as in the XML: nothing kept", MrAbcKeys.save(ctx, m) && !prefs.m.containsKey(MrAbcKeys.PREF) && !MrAbcKeys.edited(m));
        m.sheet = MrAbcKeys.copySheet(ed);
        m.sheet.badge = "AZ";
        check("an edited ABC is kept", MrAbcKeys.save(ctx, m) && prefs.m.containsKey(MrAbcKeys.PREF) && MrAbcKeys.edited(m));
        check("each save builds the keyboards again", KeyboardSwitcher.stubSheetsChanged == changed + 2);
        check("the keys that name ABC show its new badge", "AZ".equals(MrAbcKeys.badge()));
        check("restore: nothing kept, the badge back to ABC", MrAbcKeys.reset(ctx) && !prefs.m.containsKey(MrAbcKeys.PREF)
                && "ABC".equals(MrAbcKeys.badge()));

        // ---------------------------------------------------------------- backup
        m.sheet.badge = "ABC";
        MrAbcKeys.save(ctx, m);
        String plain = "{\"version\":2,\"sheets\":[]}";
        String backup = MrAbcKeys.addToBackup(ctx, plain);
        check("the backup carries ABC", backup.contains("\"abc\"") && backup.contains("\"sheets\""));
        MrAbcKeys.reset(ctx);
        check("ABC as in the XML: the backup is the same text", MrAbcKeys.addToBackup(ctx, plain) == plain);
        check("import: a backup with ABC brings it back", MrAbcKeys.takeFromBackup(ctx, backup) && MrAbcKeys.parse(MrAbcKeys.read(ctx)) != null);
        check("import: a backup without it, or a broken one, leaves ABC as it is", !MrAbcKeys.takeFromBackup(ctx, plain)
                && !MrAbcKeys.takeFromBackup(ctx, "{oops") && MrAbcKeys.parse(MrAbcKeys.read(ctx)) != null);

        // ---------------------------------------------------------------- the keyboard laid out again
        MrAbcKeys.Stored two = new MrAbcKeys.Stored();
        ArrayList<MrAbcKeys.Item> r0 = new ArrayList<MrAbcKeys.Item>();
        r0.add(new MrAbcKeys.Item(new SheetModel.KeySpec("⇧", SheetModel.TYPE_SPECIAL, "-1", 1.5f), null));
        r0.add(new MrAbcKeys.Item(text("x", 1f), null));
        r0.add(new MrAbcKeys.Item(new SheetModel.KeySpec("", SheetModel.TYPE_SPACER, "", 0.5f), null));
        r0.add(new MrAbcKeys.Item(text("ç", 2f), null));
        two.rows.add(r0);
        ArrayList<MrAbcKeys.Item> r1 = new ArrayList<MrAbcKeys.Item>();
        r1.add(new MrAbcKeys.Item(text("1", 1f), "q"));
        r1.add(new MrAbcKeys.Item(new SheetModel.KeySpec("Control", SheetModel.TYPE_SPECIAL, "-113", 1f), null));
        r1.add(new MrAbcKeys.Item(new SheetModel.KeySpec("⇧", SheetModel.TYPE_SPECIAL, "-1", 1f), null));
        two.rows.add(r1);
        LatinKeyboard kb = keyboard();
        Keyboard.Key xmlShift = kb.keys.get(12), xmlCtrl = kb.keys.get(3), xmlDelete = kb.keys.get(14);
        List<Keyboard.Key> xmlBottom = new ArrayList<Keyboard.Key>(kb.keys.subList(15, 18));
        xmlBottom.get(1).popupReversed = true;
        check("laid out again", MrAbcKeys.relayout(null, null, kb, two));
        List<Keyboard.Key> now = kb.getKeys();
        check("the keys: 3, then 3 and delete, then the bottom row", now.size() == 10 && now.subList(7, 10).equals(xmlBottom));
        Keyboard.Key x = now.get(1), ce = now.get(2), one = now.get(3), shift2 = now.get(5);
        check("Shift of the XML in its new place (its icon and state); the second Shift is a new key", now.get(0) == xmlShift
                && shift2 != xmlShift && shift2.codes[0] == -1);
        check("Ctrl of the XML, with the label of the person", now.get(4) == xmlCtrl && "Control".equals(String.valueOf(xmlCtrl.label)));
        check("new keys made as on the sheets, with their capital", "x".equals(String.valueOf(x.label)) && x.codes[0] == 'x'
                && "X".equals(String.valueOf(x.shiftLabel)) && "Ç".equals(String.valueOf(ce.shiftLabel)) && kb.stubCreated == 4);
        check("a key with the popup of the XML takes the popup of Q", "1".equals(String.valueOf(one.popupCharacters)) && one.popupResId == 0x7f0f000a
                && one.codes[0] == '1' && one.shiftLabel == null);
        check("two rows in the room of six: rows of 300 px, keys of 280 px (the gap of the XML kept)", now.get(0).y == 0 && one.y == 300
                && now.get(0).height == 280 && one.height == 280);
        check("widths: a width of 1 is a tenth of the keyboard, the gap keeps its room", now.get(0).x == 0 && now.get(0).width == 150
                && x.x == 150 && x.width == 100 && ce.x == 300 && ce.width == 200);
        check("delete closes the last row, 1.5 wide", now.get(6) == xmlDelete && xmlDelete.y == 300 && xmlDelete.x == 300 && xmlDelete.width == 150);
        check("the bottom row untouched", xmlBottom.get(0).y == 600 && xmlBottom.get(0).x == 0 && xmlBottom.get(1).x == 200);
        check("the popups open again from where the keys are now", !xmlBottom.get(1).popupReversed);
        check("the keyboard finds its keys again (3 rows, same size)", kb.stubFinished != null && kb.stubFinished[0] == 1000
                && kb.stubFinished[1] == 700 && kb.stubFinished[2] == 100 && kb.stubFinished[3] == 3 && kb.stubFinished[4] == 7 && kb.stubBound == 1);

        MrAbcKeys.Stored wide = new MrAbcKeys.Stored();
        ArrayList<MrAbcKeys.Item> w12 = new ArrayList<MrAbcKeys.Item>();
        for (int i = 0; i < 12; i++) w12.add(new MrAbcKeys.Item(text(String.valueOf((char) ('a' + i)), 1f), null));
        wide.rows.add(new ArrayList<MrAbcKeys.Item>(w12.subList(0, 4)));
        wide.rows.add(w12);
        LatinKeyboard kbWide = keyboard();
        MrAbcKeys.relayout(null, null, kbWide, wide);
        Keyboard.Key l = find(kbWide.getKeys(), "l");
        check("a row wider than 10 (12 keys and delete) is narrowed to fit", l != null && l.width == Math.round(1000 / 13.5f)
                && l.x == Math.round(11 * 1000 / 13.5f));

        LatinKeyboard flat = new LatinKeyboard();
        for (Keyboard.Key k : abc()) if ((k.edgeFlags & Keyboard.EDGE_BOTTOM) == 0) flat.keys.add(k);
        check("a keyboard without a bottom row is left alone", !MrAbcKeys.relayout(null, null, flat, two) && flat.keys.size() == 15);
        LatinKeyboard kbEmpty = keyboard();
        check("an ABC without rows is not laid out", !MrAbcKeys.relayout(null, null, kbEmpty, new MrAbcKeys.Stored()) && kbEmpty.keys.size() == 18);

        // ---------------------------------------------------------------- apply (from KeyboardSwitcher.getKeyboard)
        prefs.m.put(MrAbcKeys.PREF, MrAbcKeys.toJson(two));
        LatinKeyboard viaPref = keyboard();
        MrAbcKeys.apply(ctx, viaPref, 0x7f0f000b);
        check("ABC of the preference on a layout of ABC", viaPref.keys.size() == 10 && viaPref.stubBound == 1);
        LatinKeyboard five = keyboard();
        MrAbcKeys.apply(ctx, five, 0x7f0f0005);
        check("... also on the 5-row layout", five.keys.size() == 10);
        LatinKeyboard sheet = keyboard();
        MrAbcKeys.apply(ctx, sheet, 0x7f0f000c);
        check("another keyboard is left alone", sheet.keys.size() == 18 && sheet.stubBound == 0);
        Keyboard plainKb = new Keyboard();
        plainKb.keys.addAll(abc());
        MrAbcKeys.apply(ctx, plainKb, 0x7f0f000b);
        check("a keyboard that is not a LatinKeyboard is left alone", plainKb.keys.size() == 18);
        prefs.m.put(MrAbcKeys.PREF, "{not json");
        LatinKeyboard broken = keyboard();
        boolean threw = false;
        try {
            MrAbcKeys.apply(ctx, broken, 0x7f0f000b);
        } catch (Throwable t) {
            threw = true;
        }
        check("a broken preference: ABC as in the XML, no exception", !threw && broken.keys.size() == 18 && broken.stubBound == 0);
        prefs.m.remove(MrAbcKeys.PREF);
        LatinKeyboard none = keyboard();
        MrAbcKeys.apply(ctx, none, 0x7f0f000b);
        MrAbcKeys.apply(null, none, 0x7f0f000b);
        MrAbcKeys.apply(ctx, null, 0x7f0f000b);
        check("ABC not edited: nothing touched", none.keys.size() == 18 && none.stubBound == 0);

        check("capital: one letter only", "Ç".equals(MrAbcKeys.capital(ce)) && MrAbcKeys.capital(one) == null
                && MrAbcKeys.capital(xmlShift) == null);

        System.out.println(ok + " OK, " + fail + " FAIL");
        System.exit(fail == 0 ? 0 : 1);
    }
}
