package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.json.JSONObject;

/**
 * The keys of ABC (the main keyboard) that the person edited, in Settings → Keyboard sheets → ABC. The layout of ABC stays the one of the
 * XML (kbd_qwerty: rows, places, widths, Shift, delete, space and the keys of the language); what changes is what a key does: its label,
 * what it writes, its type (text, Tasker, special key, switch sheet) and its long-press popup.
 *
 * <p>Which keys: the ones that write a character (letters, digits, symbols) above the bottom row; Shift, delete, Ctrl, the arrows and the
 * other keys of the system stay fixed (they carry a padlock in the editor). A key is known by its label in the XML ("q", "1", "-"), so the
 * same edit applies in every language and in the other layouts of ABC (5 rows) that have that key.
 *
 * <p>Where: one JSON in the preferences ({@link #PREF}): {"v":1,"keys":{"q":{key of the sheet, as SheetModel.KeySpec.toJson},...}}; a key
 * whose popup was not touched keeps the popup of the XML ({@link #DEFAULT_POPUP}: the accents of the language of the keyboard) instead of
 * the one the editor showed. The keyboard puts the edits on ABC when it reads the XML ({@link #apply}, from KeyboardSwitcher.getKeyboard),
 * with the same code that builds the keys of the sheets (SheetKeyboardBuilder.configureKeyFromSpec); a key that writes one letter gets its
 * capital for Shift again (Keyboard.Key.mrSetCase). A save asks the keyboard to build its keyboards again (KeyboardSwitcher.onSheetsChanged),
 * so the quick test field of the editor shows the change at once.
 */
public final class MrAbcKeys {
    /** Id of ABC in the sheet editor (SheetEditorActivity.EXTRA_SHEET_ID) and in the quick test field. */
    public static final String ID = "abc";
    /** Preference with the edited keys. */
    static final String PREF = "pref_abc_keys";
    /** Field of an edited key: its popup is the one of the XML (not touched in the editor). */
    static final String DEFAULT_POPUP = "mrDefaultPopup";

    /** The layouts of ABC: kbd_qwerty, kbd_full and kbd_compact. */
    static final int XML_QWERTY = 0x7f0f000b;
    static final int XML_FULL = 0x7f0f0005;
    static final int XML_COMPACT = 0x7f0f0001;
    /** Keyboard mode of the bottom row that ABC shows by default (mode_normal; the bottom row is not edited). */
    static final int MODE_NORMAL = 0x7f08005b;
    /** Key codes of the XML that the editor draws in its own way: delete (the "⌫" of the grid). */
    static final int CODE_DELETE = -5;

    private static String sCachedRaw;
    private static Map<String, Entry> sCached = new HashMap<String, Entry>();

    private MrAbcKeys() { }

    /** An edited key: what it does now and whether it keeps the popup of the XML. */
    static final class Entry {
        final SheetModel.KeySpec spec;
        final boolean defaultPopup;

        Entry(SheetModel.KeySpec spec, boolean defaultPopup) {
            this.spec = spec;
            this.defaultPopup = defaultPopup;
        }
    }

    /** ABC as the editor shows it: the keys (a sheet of 6 rows), the keys of the XML, and the label of the XML of each key that changes. */
    static final class Model {
        /** What the grid shows and the editor changes. */
        SheetModel.Sheet sheet;
        /** The keys as the XML has them. */
        final SheetModel.Sheet defaults;
        /** Label of the XML of each key, or null for a fixed key (and for a gap). */
        final String[][] ids;

        Model(SheetModel.Sheet sheet, SheetModel.Sheet defaults, String[][] ids) {
            this.sheet = sheet;
            this.defaults = defaults;
            this.ids = ids;
        }

        /** A fixed key: it does not open the key editor. */
        boolean locked(int row, int key) {
            return row < 0 || row >= ids.length || key < 0 || key >= ids[row].length || ids[row][key] == null;
        }

        /** The grid needs it as booleans. */
        boolean[][] lockedMap() {
            boolean[][] out = new boolean[ids.length][];
            for (int r = 0; r < ids.length; r++) {
                out[r] = new boolean[ids[r].length];
                for (int k = 0; k < ids[r].length; k++) out[r][k] = ids[r][k] == null;
            }
            return out;
        }
    }

    // ------------------------------------------------------------------ the keys of the XML

    /** A key of ABC that the editor lets change: it writes a character, it is not a key of the system and not of the bottom row. */
    static boolean editable(Keyboard.Key k) {
        if (k == null || k.modifier || k.icon != null || (k.edgeFlags & Keyboard.EDGE_BOTTOM) != 0) return false;
        if (k.label == null || k.label.length() == 0) return false;
        return k.codes != null && k.codes.length > 0 && k.codes[0] > 32;
    }

    /** One of the layouts of ABC. */
    static boolean isAbcXml(int xml) {
        return xml == XML_QWERTY || xml == XML_FULL || xml == XML_COMPACT;
    }

    /**
     * ABC from the keys of the XML in the order they were read (row by row): one row of the sheet for each height, the bottom row left out
     * (it is the same on every sheet in the grid) and the delete key too (the grid draws its "⌫" at the end of the last row). A key that
     * changes is a text key with its popup; a fixed one is a special key with its code; the space before a key (the row of A) is a gap.
     * {@code totalWidth} is the width of the keyboard: a width of 1 is a tenth of it, as in the sheets.
     */
    static Model fromKeys(List<Keyboard.Key> keys, int totalWidth) {
        float unit = totalWidth > 0 ? totalWidth / 10f : 1f;
        ArrayList<SheetModel.Row> rows = new ArrayList<SheetModel.Row>();
        ArrayList<ArrayList<String>> ids = new ArrayList<ArrayList<String>>();
        int lastY = Integer.MIN_VALUE;
        SheetModel.Row row = null;
        ArrayList<String> rowIds = null;
        for (int i = 0; keys != null && i < keys.size(); i++) {
            Keyboard.Key k = keys.get(i);
            if (k == null || (k.edgeFlags & Keyboard.EDGE_BOTTOM) != 0) continue;
            if (k.codes != null && k.codes.length > 0 && k.codes[0] == CODE_DELETE) continue;
            if (row == null || k.y != lastY) {
                if (rows.size() >= SheetModel.MAX_ROWS) break;
                row = new SheetModel.Row();
                rowIds = new ArrayList<String>();
                rows.add(row);
                ids.add(rowIds);
                lastY = k.y;
            }
            float gap = k.gap / unit;
            if (gap >= 0.25f) {
                row.keys.add(new SheetModel.KeySpec(new String(), SheetModel.TYPE_SPACER, new String(), SheetModel.clampWidth(gap)));
                rowIds.add(null);
            }
            float width = SheetModel.clampWidth(k.width / unit);
            if (editable(k)) {
                String label = k.label.toString();
                String value = k.text != null && k.text.length() > 0 ? k.text.toString() : label;
                SheetModel.KeySpec spec = new SheetModel.KeySpec(label, SheetModel.TYPE_TEXT, value, width);
                if (k.popupCharacters != null && k.popupCharacters.length() > 0) spec.popupChars = k.popupCharacters.toString();
                row.keys.add(spec);
                rowIds.add(label);
            } else {
                int code = k.codes != null && k.codes.length > 0 ? k.codes[0] : 0;
                String label = k.label != null && k.label.length() > 0 ? k.label.toString() : SpecialKeyPicker.defaultLabelForCode(code);
                row.keys.add(new SheetModel.KeySpec(label, SheetModel.TYPE_SPECIAL, String.valueOf(code), width));
                rowIds.add(null);
            }
        }
        // a row that starts with a gap (the row of A) ends with the same gap, so its keys keep the width of the others in the grid
        for (int r = 0; r < rows.size(); r++) {
            ArrayList<SheetModel.KeySpec> keysOfRow = rows.get(r).keys;
            if (keysOfRow.size() > 1 && SheetModel.TYPE_SPACER.equals(keysOfRow.get(0).type)
                    && !SheetModel.TYPE_SPACER.equals(keysOfRow.get(keysOfRow.size() - 1).type)) {
                keysOfRow.add(new SheetModel.KeySpec(new String(), SheetModel.TYPE_SPACER, new String(), keysOfRow.get(0).width));
                ids.get(r).add(null);
            }
        }
        SheetModel.Sheet defaults = sheet(rows);
        String[][] idArray = new String[ids.size()][];
        for (int r = 0; r < ids.size(); r++) idArray[r] = ids.get(r).toArray(new String[0]);
        return new Model(copySheet(defaults), defaults, idArray);
    }

    private static SheetModel.Sheet sheet(ArrayList<SheetModel.Row> rows) {
        SheetModel.Sheet s = new SheetModel.Sheet();
        s.id = ID;
        s.name = "ABC";
        s.badge = "ABC";
        s.builtin = true;
        s.rows = rows;
        return s;
    }

    /** ABC of the XML with the keys the person edited, for the editor. */
    static Model load(Context c) {
        Keyboard kb = new Keyboard(c, 0, XML_QWERTY, MODE_NORMAL, 40f);
        Model m = fromKeys(kb.getKeys(), kb.getMinWidth());
        m.sheet = withEdits(m, entries(read(c)));
        return m;
    }

    /** The keys of the model with the edits on them (a key whose popup was not touched shows the one of the XML). */
    static SheetModel.Sheet withEdits(Model m, Map<String, Entry> edits) {
        SheetModel.Sheet out = copySheet(m.defaults);
        for (int r = 0; r < m.ids.length && r < out.rows.size(); r++) {
            for (int k = 0; k < m.ids[r].length && k < out.rows.get(r).keys.size(); k++) {
                String id = m.ids[r][k];
                Entry e = id == null ? null : edits.get(id);
                if (e == null) continue;
                SheetModel.KeySpec def = m.defaults.rows.get(r).keys.get(k);
                SheetModel.KeySpec spec = copy(e.spec);
                spec.width = def.width;
                if (e.defaultPopup) {
                    spec.popupChars = def.popupChars;
                    spec.popupKeys = def.popupKeys == null ? null : copyList(def.popupKeys);
                }
                out.rows.get(r).keys.set(k, spec);
            }
        }
        return out;
    }

    // ------------------------------------------------------------------ what is saved

    /** The edits of the keys of the sheet against the XML: one entry per key that is not the same any more. */
    static Map<String, Entry> diff(Model m, SheetModel.Sheet sheet) {
        LinkedHashMap<String, Entry> out = new LinkedHashMap<String, Entry>();
        for (int r = 0; r < m.ids.length && r < sheet.rows.size() && r < m.defaults.rows.size(); r++) {
            for (int k = 0; k < m.ids[r].length && k < sheet.rows.get(r).keys.size(); k++) {
                String id = m.ids[r][k];
                if (id == null) continue;
                SheetModel.KeySpec now = sheet.rows.get(r).keys.get(k);
                SheetModel.KeySpec def = m.defaults.rows.get(r).keys.get(k);
                boolean samePopup = samePopup(now, def);
                if (samePopup && sameAction(now, def)) continue;
                SheetModel.KeySpec spec = copy(now);
                if (samePopup) {
                    spec.popupChars = null;
                    spec.popupKeys = null;
                }
                out.put(id, new Entry(spec, samePopup));
            }
        }
        return out;
    }

    static boolean sameAction(SheetModel.KeySpec a, SheetModel.KeySpec b) {
        return eq(SheetModel.normalizeType(a.type), SheetModel.normalizeType(b.type)) && eq(a.label, b.label) && eq(a.value, b.value);
    }

    static boolean samePopup(SheetModel.KeySpec a, SheetModel.KeySpec b) {
        if (!eq(blankToNull(a.popupChars), blankToNull(b.popupChars))) return false;
        int na = a.popupKeys == null ? 0 : a.popupKeys.size();
        int nb = b.popupKeys == null ? 0 : b.popupKeys.size();
        if (na != nb) return false;
        for (int i = 0; i < na; i++) {
            if (!sameAction(a.popupKeys.get(i), b.popupKeys.get(i))) return false;
        }
        return true;
    }

    private static String blankToNull(String s) {
        return s == null || s.length() == 0 ? null : s;
    }

    private static boolean eq(String a, String b) {
        return a == null ? b == null : a.equals(b);
    }

    /** The JSON of the preference (keys in a stable order: the one of the model). */
    static String toJson(Map<String, Entry> edits) {
        if (edits == null || edits.isEmpty()) return null;
        try {
            JSONObject keys = new JSONObject();
            for (Map.Entry<String, Entry> e : edits.entrySet()) {
                JSONObject j = e.getValue().spec.toJson();
                if (e.getValue().defaultPopup) j.put(DEFAULT_POPUP, true);
                keys.put(e.getKey(), j);
            }
            JSONObject root = new JSONObject();
            root.put("v", 1);
            root.put("keys", keys);
            return root.toString();
        } catch (Throwable t) {
            return null;
        }
    }

    /** The edits of a JSON of the preference (an unreadable one is no edit at all). */
    static Map<String, Entry> entries(String raw) {
        LinkedHashMap<String, Entry> out = new LinkedHashMap<String, Entry>();
        if (raw == null || raw.length() == 0) return out;
        try {
            JSONObject keys = new JSONObject(raw).optJSONObject("keys");
            if (keys == null) return out;
            Iterator<String> it = keys.keys();
            while (it.hasNext()) {
                String id = it.next();
                JSONObject j = keys.optJSONObject(id);
                if (id == null || id.length() == 0 || j == null) continue;
                SheetModel.KeySpec spec = SheetModel.KeySpec.fromJson(j, true);
                if (spec == null || SheetModel.TYPE_SPACER.equals(SheetModel.normalizeType(spec.type))) continue;
                out.put(id, new Entry(spec, j.optBoolean(DEFAULT_POPUP, false)));
            }
        } catch (Throwable t) {
            out.clear();
        }
        return out;
    }

    static String read(Context c) {
        try {
            return PreferenceManager.getDefaultSharedPreferences(c).getString(PREF, null);
        } catch (Throwable t) {
            return null;
        }
    }

    /** How many keys of ABC are edited (the line of the ABC card). */
    public static int count(Context c) {
        return entries(read(c)).size();
    }

    /** Saves the keys of the editor and asks the keyboard to build ABC again; false when the preference could not be written. */
    static boolean save(Context c, Model m) {
        return write(c, toJson(diff(m, m.sheet)));
    }

    /** ABC as in the XML again. */
    static boolean reset(Context c) {
        return write(c, null);
    }

    private static boolean write(Context c, String json) {
        boolean ok;
        try {
            SharedPreferences.Editor ed = PreferenceManager.getDefaultSharedPreferences(c).edit();
            if (json == null) ed.remove(PREF);
            else ed.putString(PREF, json);
            ok = ed.commit();
        } catch (Throwable t) {
            ok = false;
        }
        try {
            KeyboardSwitcher ks = KeyboardSwitcher.getInstance();
            if (ks != null) ks.onSheetsChanged();
        } catch (Throwable ignored) {
        }
        return ok;
    }

    // ------------------------------------------------------------------ backup (the JSON of "Keyboard sheets")

    /** Field of the backup JSON of the sheets with the edits of ABC. */
    static final String BACKUP_FIELD = "abcKeys";

    /** The backup of the sheets with the edits of ABC in it (the same JSON when there is none or it cannot be read). */
    static String addToBackup(Context c, String json) {
        String mine = read(c);
        if (json == null || mine == null || entries(mine).isEmpty()) return json;
        try {
            JSONObject root = new JSONObject(json);
            root.put(BACKUP_FIELD, new JSONObject(mine));
            return root.toString(2);
        } catch (Throwable t) {
            return json;
        }
    }

    /** After an import: the edits of ABC that the file has replace the current ones; a file without them leaves ABC as it is. */
    static boolean takeFromBackup(Context c, String json) {
        if (json == null) return false;
        try {
            JSONObject mine = new JSONObject(json).optJSONObject(BACKUP_FIELD);
            if (mine == null) return false;
            Map<String, Entry> edits = entries(mine.toString());
            return write(c, edits.isEmpty() ? null : toJson(edits));
        } catch (Throwable t) {
            return false;
        }
    }

    // ------------------------------------------------------------------ the keyboard

    /**
     * Puts the edited keys on a keyboard of ABC just read from its XML (KeyboardSwitcher.getKeyboard). Anything that fails leaves the keyboard
     * as the XML made it.
     */
    public static void apply(Context c, Keyboard kb, int xml) {
        if (c == null || kb == null || !isAbcXml(xml)) return;
        try {
            Map<String, Entry> edits = cached(read(c));
            if (edits.isEmpty()) return;
            List<SheetModel.Sheet> sheets = SheetStore.getSheets(c);
            Resources res = c.getResources();
            List<Keyboard.Key> keys = kb.getKeys();
            for (int i = 0; i < keys.size(); i++) {
                Keyboard.Key k = keys.get(i);
                if (!editable(k)) continue;
                Entry e = edits.get(k.label.toString());
                if (e != null) put(res, sheets, k, e);
            }
        } catch (Throwable ignored) {
        }
    }

    /** The edits of the preference, read again only when it changed (every keyboard of ABC asks). */
    private static synchronized Map<String, Entry> cached(String raw) {
        if (raw == null) return new HashMap<String, Entry>();
        if (!raw.equals(sCachedRaw)) {
            sCached = entries(raw);
            sCachedRaw = raw;
        }
        return sCached;
    }

    /** One key of the XML takes what the person set: what it writes and does, its label, its popup and its capital. */
    static void put(Resources res, List<SheetModel.Sheet> sheets, Keyboard.Key k, Entry e) {
        k.text = null;
        k.popupKeys = null;
        if (!e.defaultPopup) {
            k.popupCharacters = null;
            k.popupResId = 0;
        }
        SheetKeyboardBuilder.configureKeyFromSpec(res, sheets, k, e.spec);
        k.mrSetCase(capital(k));
    }

    /** The capital that Shift writes on a key that writes one letter ("ç" -> "Ç"), or null. */
    static String capital(Keyboard.Key k) {
        if (k == null || k.modifier || k.text != null || k.codes == null || k.codes.length == 0 || k.codes[0] <= 32) return null;
        String one = String.valueOf((char) k.codes[0]);
        String up = one.toUpperCase(Locale.ROOT);
        return up.length() == 1 && !up.equals(one) ? up : null;
    }

    // ------------------------------------------------------------------ copies (plain Java: the editor and the tests use them)

    static SheetModel.KeySpec copy(SheetModel.KeySpec s) {
        SheetModel.KeySpec c = new SheetModel.KeySpec(s.label, s.type, s.value, s.width);
        c.popupChars = s.popupChars;
        c.popupKeys = s.popupKeys == null ? null : copyList(s.popupKeys);
        return c;
    }

    static ArrayList<SheetModel.KeySpec> copyList(List<SheetModel.KeySpec> list) {
        ArrayList<SheetModel.KeySpec> out = new ArrayList<SheetModel.KeySpec>(list.size());
        for (int i = 0; i < list.size(); i++) out.add(copy(list.get(i)));
        return out;
    }

    static SheetModel.Sheet copySheet(SheetModel.Sheet s) {
        SheetModel.Sheet c = new SheetModel.Sheet();
        c.id = s.id;
        c.name = s.name;
        c.badge = s.badge;
        c.builtin = s.builtin;
        c.rows = new ArrayList<SheetModel.Row>(s.rows.size());
        for (int r = 0; r < s.rows.size(); r++) {
            SheetModel.Row row = new SheetModel.Row();
            row.keys = copyList(s.rows.get(r).keys);
            c.rows.add(row);
        }
        return c;
    }
}
