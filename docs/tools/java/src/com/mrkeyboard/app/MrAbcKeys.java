package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * ABC (the main keyboard) edited as a sheet, in Settings → Keyboard sheets: rows, keys, widths, name and badge, with the same editor as the
 * other sheets. ABC cannot be deleted or moved: it is always the first sheet.
 *
 * <p>ABC as the editor starts it is the XML (kbd_qwerty) read as a sheet ({@link #fromKeys}): its rows above the bottom row, each key a key of
 * a sheet (a letter is a text key with the popup of the language, Shift, Ctrl and the arrows are special keys with their codes, the room
 * before the A row is a gap). The delete key and the bottom row are the ones the grid of the editor draws on every sheet.
 *
 * <p>Where: one JSON in the preferences ({@link #PREF}) only while ABC differs from the XML: {"v":2,"name":..,"badge":..,"rows":[[key, ...],
 * ...]}, each key as SheetModel.KeySpec.toJson; a key whose popup is the one of a key of the XML ("mrPopupOf":"a") keeps the popup of that key
 * for the language of the keyboard (the accents follow the language), and a name or badge that was not changed is not kept (the default one
 * is the one of the language of the app).
 *
 * <p>On the keyboard ({@link #apply}, from KeyboardSwitcher.getKeyboard right after it reads a layout of ABC): the rows above the bottom row
 * are laid out again from the edited ABC in the same room (the height of the keyboard and its bottom row stay): Shift, Ctrl, Alt and the other
 * keys of the system are the keys of the XML in their new place (they keep their icons and states), the other keys are made as the keys of the
 * sheets (SheetKeyboardBuilder.configureKeyFromSpec), a key that writes one letter gets its capital for Shift (Keyboard.Key.mrSetCase), and
 * the delete key of the XML closes the last row as on the sheets. Anything that fails leaves ABC as in the XML. A save asks the keyboard to
 * build its keyboards again (KeyboardSwitcher.onSheetsChanged), so the quick test field of the editor shows the change at once.
 */
public final class MrAbcKeys {
    /** Id of ABC in the sheet editor (SheetEditorActivity.EXTRA_SHEET_ID); also the target "abc" of a key that switches to ABC. */
    public static final String ID = "abc";
    /** Preference with ABC as edited. */
    static final String PREF = "pref_abc_keys";
    /** Field of a key: its popup is the one of the key of the XML with this label. */
    static final String POPUP_OF = "mrPopupOf";
    /** Badge of ABC when it was not changed. */
    static final String DEFAULT_BADGE = "ABC";

    /** The layouts of ABC: kbd_qwerty, kbd_full and kbd_compact. */
    static final int XML_QWERTY = 0x7f0f000b;
    static final int XML_FULL = 0x7f0f0005;
    static final int XML_COMPACT = 0x7f0f0001;
    /** Keyboard mode of the bottom row that ABC shows by default (mode_normal; the bottom row is not edited). */
    static final int MODE_NORMAL = 0x7f08005b;
    /** Delete: the grid of the editor and the keyboard put it at the end of the last row, as on every sheet. */
    static final int CODE_DELETE = -5;
    /** Width of the delete key at the end of the last row (the one of the sheets). */
    static final float DELETE_WIDTH = 1.5f;

    private static String sCachedRaw;
    private static Stored sCached;
    /** The badge of ABC for the keys that name it (popup of sheets, a key that switches to ABC); set when ABC is read or saved. */
    private static volatile String sBadge;

    private MrAbcKeys() { }

    /** A key of the edited ABC: the key, and the label of the key of the XML whose popup it keeps (null: its own popup). */
    static final class Item {
        final SheetModel.KeySpec spec;
        final String popupOf;

        Item(SheetModel.KeySpec spec, String popupOf) {
            this.spec = spec;
            this.popupOf = popupOf;
        }
    }

    /** ABC as kept: null name or badge = the default one. */
    static final class Stored {
        String name;
        String badge;
        final ArrayList<ArrayList<Item>> rows = new ArrayList<ArrayList<Item>>();
    }

    /** ABC in the editor: what it shows (and changes) and ABC as in the XML (for Restore ABC and for what is kept). */
    static final class Model {
        SheetModel.Sheet sheet;
        final SheetModel.Sheet defaults;

        Model(SheetModel.Sheet sheet, SheetModel.Sheet defaults) {
            this.sheet = sheet;
            this.defaults = defaults;
        }
    }

    // ------------------------------------------------------------------ the keys of the XML

    /** A key of the XML that writes a character (not a key of the system and not of the bottom row): a text key of the sheet. */
    static boolean editable(Keyboard.Key k) {
        if (k == null || k.modifier || k.icon != null || (k.edgeFlags & Keyboard.EDGE_BOTTOM) != 0) return false;
        if (k.label == null || k.label.length() == 0) return false;
        return k.codes != null && k.codes.length > 0 && k.codes[0] > 32;
    }

    /** One of the layouts of ABC. */
    static boolean isAbcXml(int xml) {
        return xml == XML_QWERTY || xml == XML_FULL || xml == XML_COMPACT;
    }

    private static int code(Keyboard.Key k) {
        return k.codes != null && k.codes.length > 0 ? k.codes[0] : 0;
    }

    /**
     * ABC of the XML as a sheet, from its keys in the order they were read (row by row): one row for each height, without the bottom row and
     * the delete key (the grid draws them). A width of 1 is a tenth of the keyboard ({@code totalWidth}), as in the sheets; the room before a
     * key (the A row) is a gap, and that row ends with the same gap so its keys keep the width of the others.
     */
    static SheetModel.Sheet fromKeys(List<Keyboard.Key> keys, int totalWidth, String name) {
        float unit = totalWidth > 0 ? totalWidth / 10f : 1f;
        ArrayList<SheetModel.Row> rows = new ArrayList<SheetModel.Row>();
        int lastY = Integer.MIN_VALUE;
        SheetModel.Row row = null;
        for (int i = 0; keys != null && i < keys.size(); i++) {
            Keyboard.Key k = keys.get(i);
            if (k == null || (k.edgeFlags & Keyboard.EDGE_BOTTOM) != 0 || code(k) == CODE_DELETE) continue;
            if (row == null || k.y != lastY) {
                if (rows.size() >= SheetModel.MAX_ROWS) break;
                row = new SheetModel.Row();
                rows.add(row);
                lastY = k.y;
            }
            float gap = k.gap / unit;
            if (gap >= 0.25f) row.keys.add(gap(gap));
            float width = SheetModel.clampWidth(k.width / unit);
            SheetModel.KeySpec spec;
            if (editable(k)) {
                String label = k.label.toString();
                String value = k.text != null && k.text.length() > 0 ? k.text.toString() : label;
                spec = new SheetModel.KeySpec(label, SheetModel.TYPE_TEXT, value, width);
                if (k.popupCharacters != null && k.popupCharacters.length() > 0) spec.popupChars = k.popupCharacters.toString();
            } else {
                String label = k.label != null && k.label.length() > 0 ? k.label.toString() : SpecialKeyPicker.defaultLabelForCode(code(k));
                spec = new SheetModel.KeySpec(label, SheetModel.TYPE_SPECIAL, String.valueOf(code(k)), width);
            }
            row.keys.add(spec);
        }
        for (int r = 0; r < rows.size(); r++) {
            ArrayList<SheetModel.KeySpec> ks = rows.get(r).keys;
            if (ks.size() > 1 && isGap(ks.get(0)) && !isGap(ks.get(ks.size() - 1))) ks.add(gap(ks.get(0).width));
        }
        SheetModel.Sheet s = new SheetModel.Sheet();
        s.id = ID;
        s.name = name;
        s.badge = DEFAULT_BADGE;
        s.builtin = true;
        s.rows = rows;
        return s;
    }

    private static SheetModel.KeySpec gap(float width) {
        return new SheetModel.KeySpec(new String(), SheetModel.TYPE_SPACER, new String(), SheetModel.clampWidth(width));
    }

    static boolean isGap(SheetModel.KeySpec k) {
        return k != null && SheetModel.TYPE_SPACER.equals(SheetModel.normalizeType(k.type));
    }

    /** ABC of the XML of the app (the editor and the card of the list); {@code name} is the default name in the language of the app. */
    static SheetModel.Sheet xmlSheet(Context c, String name) {
        Keyboard kb = new Keyboard(c, 0, XML_QWERTY, MODE_NORMAL, 40f);
        return fromKeys(kb.getKeys(), kb.getMinWidth(), name);
    }

    /** ABC for the editor: the XML, or ABC as edited (the popups of the XML filled in where they were kept). */
    static Model load(Context c, String defaultName) {
        SheetModel.Sheet defaults = xmlSheet(c, defaultName);
        Stored s = parse(read(c));
        sBadge = s == null || s.badge == null ? DEFAULT_BADGE : s.badge;
        return new Model(s == null ? copySheet(defaults) : toSheet(s, defaults), defaults);
    }

    /** ABC as edited, as a sheet: the default name and badge where none was kept, the popups of the XML where they were kept. */
    static SheetModel.Sheet toSheet(Stored s, SheetModel.Sheet defaults) {
        HashMap<String, SheetModel.KeySpec> byLabel = labels(defaults);
        SheetModel.Sheet out = new SheetModel.Sheet();
        out.id = ID;
        out.builtin = true;
        out.name = s.name != null ? s.name : defaults.name;
        out.badge = s.badge != null ? s.badge : DEFAULT_BADGE;
        out.rows = new ArrayList<SheetModel.Row>();
        for (int r = 0; r < s.rows.size() && r < SheetModel.MAX_ROWS; r++) {
            SheetModel.Row row = new SheetModel.Row();
            for (Item it : s.rows.get(r)) {
                SheetModel.KeySpec k = copy(it.spec);
                SheetModel.KeySpec from = it.popupOf == null ? null : byLabel.get(it.popupOf);
                if (from != null) {
                    k.popupChars = from.popupChars;
                    k.popupKeys = null;
                }
                row.keys.add(k);
            }
            out.rows.add(row);
        }
        return out;
    }

    /** The text keys of the XML by label (the first one of a label), in the order of the keyboard. */
    private static LinkedHashMap<String, SheetModel.KeySpec> labels(SheetModel.Sheet defaults) {
        LinkedHashMap<String, SheetModel.KeySpec> out = new LinkedHashMap<String, SheetModel.KeySpec>();
        for (SheetModel.Row row : defaults.rows) {
            for (SheetModel.KeySpec k : row.keys) {
                if (SheetModel.TYPE_TEXT.equals(SheetModel.normalizeType(k.type)) && k.label != null && !out.containsKey(k.label)) out.put(k.label, k);
            }
        }
        return out;
    }

    // ------------------------------------------------------------------ what is kept

    /** ABC as kept for the sheet of the editor: the popups that are the ones of the XML are named, not copied; the default name and badge are left out. */
    static Stored toStored(SheetModel.Sheet sheet, SheetModel.Sheet defaults) {
        HashMap<String, SheetModel.KeySpec> byLabel = labels(defaults);
        Stored s = new Stored();
        s.name = sheet.name == null || sheet.name.equals(defaults.name) ? null : sheet.name;
        s.badge = sheet.badge == null || DEFAULT_BADGE.equals(sheet.badge) ? null : sheet.badge;
        for (int r = 0; r < sheet.rows.size() && r < SheetModel.MAX_ROWS; r++) {
            ArrayList<Item> row = new ArrayList<Item>();
            for (SheetModel.KeySpec k : sheet.rows.get(r).keys) {
                String popupOf = popupOf(k, byLabel);
                SheetModel.KeySpec spec = copy(k);
                if (popupOf != null) {
                    spec.popupChars = null;
                    spec.popupKeys = null;
                }
                row.add(new Item(spec, popupOf));
            }
            s.rows.add(row);
        }
        return s;
    }

    /**
     * The label of the key of the XML whose popup this key has, or null: the key with its label or with what it writes, else any key of the
     * XML with the same popup (a letter moved or renamed keeps the accents of the language).
     */
    static String popupOf(SheetModel.KeySpec k, Map<String, SheetModel.KeySpec> byLabel) {
        if (k.popupChars == null || k.popupChars.length() == 0 || (k.popupKeys != null && !k.popupKeys.isEmpty())) return null;
        if (!SheetModel.TYPE_TEXT.equals(SheetModel.normalizeType(k.type))) return null;
        for (String l : new String[] {k.label, k.value}) {
            SheetModel.KeySpec x = l == null ? null : byLabel.get(l);
            if (x != null && k.popupChars.equals(x.popupChars)) return l;
        }
        for (Map.Entry<String, SheetModel.KeySpec> e : byLabel.entrySet()) {
            if (k.popupChars.equals(e.getValue().popupChars)) return e.getKey();
        }
        return null;
    }

    /** The same sheet: same name, badge, rows and keys (type, label, value, width, popup). */
    static boolean same(SheetModel.Sheet a, SheetModel.Sheet b) {
        if (!eq(a.name, b.name) || !eq(a.badge, b.badge) || a.rows.size() != b.rows.size()) return false;
        for (int r = 0; r < a.rows.size(); r++) {
            List<SheetModel.KeySpec> ka = a.rows.get(r).keys, kb = b.rows.get(r).keys;
            if (ka.size() != kb.size()) return false;
            for (int i = 0; i < ka.size(); i++) {
                if (!sameKey(ka.get(i), kb.get(i)) || Math.abs(ka.get(i).width - kb.get(i).width) > 0.01f) return false;
            }
        }
        return true;
    }

    static boolean sameKey(SheetModel.KeySpec a, SheetModel.KeySpec b) {
        if (!eq(SheetModel.normalizeType(a.type), SheetModel.normalizeType(b.type)) || !eq(a.label, b.label) || !eq(a.value, b.value)) return false;
        if (!eq(blankToNull(a.popupChars), blankToNull(b.popupChars))) return false;
        int na = a.popupKeys == null ? 0 : a.popupKeys.size();
        int nb = b.popupKeys == null ? 0 : b.popupKeys.size();
        if (na != nb) return false;
        for (int i = 0; i < na; i++) {
            if (!sameKey(a.popupKeys.get(i), b.popupKeys.get(i))) return false;
        }
        return true;
    }

    private static String blankToNull(String s) {
        return s == null || s.length() == 0 ? null : s;
    }

    private static boolean eq(String a, String b) {
        return a == null ? b == null : a.equals(b);
    }

    /** ABC differs from the XML (Restore ABC has something to do). */
    static boolean edited(Model m) {
        return !same(m.sheet, m.defaults);
    }

    /** The JSON of the preference. */
    static String toJson(Stored s) {
        try {
            JSONArray rows = new JSONArray();
            for (ArrayList<Item> row : s.rows) {
                JSONArray keys = new JSONArray();
                for (Item it : row) {
                    JSONObject j = it.spec.toJson();
                    if (it.popupOf != null) j.put(POPUP_OF, it.popupOf);
                    keys.put(j);
                }
                rows.put(keys);
            }
            JSONObject root = new JSONObject();
            root.put("v", 2);
            if (s.name != null) root.put("name", s.name);
            if (s.badge != null) root.put("badge", s.badge);
            root.put("rows", rows);
            return root.toString();
        } catch (Throwable t) {
            return null;
        }
    }

    /** ABC of a JSON of the preference, or null (none, unreadable, no row). */
    static Stored parse(String raw) {
        if (raw == null || raw.length() == 0) return null;
        try {
            JSONObject root = new JSONObject(raw);
            JSONArray rows = root.optJSONArray("rows");
            if (rows == null || rows.length() == 0) return null;
            Stored s = new Stored();
            String name = root.optString("name", new String()).trim();
            String badge = root.optString("badge", new String()).trim();
            s.name = name.length() == 0 ? null : SheetModel.sanitizeName(name, name);
            s.badge = badge.length() == 0 ? null : SheetModel.sanitizeBadge(badge, DEFAULT_BADGE);
            for (int r = 0; r < rows.length() && r < SheetModel.MAX_ROWS; r++) {
                JSONArray keys = rows.optJSONArray(r);
                ArrayList<Item> row = new ArrayList<Item>();
                for (int i = 0; keys != null && i < keys.length(); i++) {
                    JSONObject j = keys.optJSONObject(i);
                    SheetModel.KeySpec spec = j == null ? null : SheetModel.KeySpec.fromJson(j, true);
                    if (spec == null) continue;
                    String popupOf = j.optString(POPUP_OF, new String());
                    row.add(new Item(spec, popupOf.length() == 0 ? null : popupOf));
                }
                s.rows.add(row);
            }
            return s;
        } catch (Throwable t) {
            return null;
        }
    }

    static String read(Context c) {
        try {
            return PreferenceManager.getDefaultSharedPreferences(c).getString(PREF, null);
        } catch (Throwable t) {
            return null;
        }
    }

    /** Saves ABC of the editor (nothing kept when it is the XML) and asks the keyboard to build ABC again; false when it could not be written. */
    static boolean save(Context c, Model m) {
        sBadge = m.sheet.badge == null ? DEFAULT_BADGE : m.sheet.badge;
        return write(c, edited(m) ? toJson(toStored(m.sheet, m.defaults)) : null);
    }

    /** ABC as in the XML again. */
    static boolean reset(Context c) {
        sBadge = DEFAULT_BADGE;
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

    /** The badge of ABC (the popup of sheets and a key that switches to ABC show it). */
    public static String badge() {
        String b = sBadge;
        return b == null || b.length() == 0 ? DEFAULT_BADGE : b;
    }

    // ------------------------------------------------------------------ backup (the JSON of "Keyboard sheets")

    /** Field of the backup JSON of the sheets with ABC as edited. */
    static final String BACKUP_FIELD = "abc";

    /** The backup of the sheets with the edited ABC in it (the same JSON when ABC is the XML or something fails). */
    static String addToBackup(Context c, String json) {
        String mine = read(c);
        if (json == null || parse(mine) == null) return json;
        try {
            JSONObject root = new JSONObject(json);
            root.put(BACKUP_FIELD, new JSONObject(mine));
            return root.toString(2);
        } catch (Throwable t) {
            return json;
        }
    }

    /** After an import: the ABC that the file has replaces the current one; a file without it leaves ABC as it is. */
    static boolean takeFromBackup(Context c, String json) {
        if (json == null) return false;
        try {
            JSONObject mine = new JSONObject(json).optJSONObject(BACKUP_FIELD);
            Stored s = mine == null ? null : parse(mine.toString());
            if (s == null) return false;
            sBadge = s.badge == null ? DEFAULT_BADGE : s.badge;
            return write(c, toJson(s));
        } catch (Throwable t) {
            return false;
        }
    }

    // ------------------------------------------------------------------ the keyboard

    /**
     * Lays out again the rows of a keyboard of ABC just read from its XML (KeyboardSwitcher.getKeyboard) as the person edited them. Nothing
     * when ABC was not edited; anything that fails leaves the keyboard as the XML made it.
     */
    public static void apply(Context c, Keyboard kb, int xml) {
        if (c == null || kb == null || !isAbcXml(xml)) return;
        try {
            Stored s = cached(read(c));
            sBadge = s == null || s.badge == null ? DEFAULT_BADGE : s.badge;
            if (s == null || !(kb instanceof LatinKeyboard)) return;
            relayout(c.getResources(), SheetStore.getSheets(c), (LatinKeyboard) kb, s);
        } catch (Throwable ignored) {
        }
    }

    /** ABC of the preference, read again only when it changed (every keyboard of ABC asks). */
    private static synchronized Stored cached(String raw) {
        if (raw == null) return null;
        if (!raw.equals(sCachedRaw)) {
            sCached = parse(raw);
            sCachedRaw = raw;
        }
        return sCached;
    }

    /**
     * The rows above the bottom row of {@code kb} as in {@code s}, in the room those rows had: each row takes the same share of the height,
     * and its keys share the width the rows of the XML use (a width of 1 is a tenth of it; a row wider than 10 is narrowed to fit). Returns
     * false, with the keyboard untouched, when the keyboard does not have the shape of ABC (rows of keys above a bottom row).
     */
    static boolean relayout(Resources res, List<SheetModel.Sheet> sheets, LatinKeyboard kb, Stored s) {
        List<Keyboard.Key> keys = kb.getKeys();
        ArrayList<Keyboard.Key> upper = new ArrayList<Keyboard.Key>();
        ArrayList<Keyboard.Key> bottom = new ArrayList<Keyboard.Key>();
        Keyboard.Key delete = null;
        for (Keyboard.Key k : keys) {
            if ((k.edgeFlags & Keyboard.EDGE_BOTTOM) != 0) bottom.add(k);
            else if (code(k) == CODE_DELETE && delete == null) delete = k;
            else upper.add(k);
        }
        int n = Math.min(s.rows.size(), SheetModel.MAX_ROWS);
        if (upper.isEmpty() || bottom.isEmpty() || n == 0) return false;

        // the room of the rows of the XML
        int top = Integer.MAX_VALUE, left = Integer.MAX_VALUE, right = Integer.MIN_VALUE, bottomTop = Integer.MAX_VALUE, keyHeight = 0;
        ArrayList<Integer> ys = new ArrayList<Integer>();
        ArrayList<Keyboard.Key> rowKeys = new ArrayList<Keyboard.Key>(upper);
        if (delete != null) rowKeys.add(delete);
        for (Keyboard.Key k : rowKeys) {
            top = Math.min(top, k.y);
            left = Math.min(left, k.x - k.gap);
            right = Math.max(right, k.x + k.width);
            keyHeight = Math.max(keyHeight, k.height);
            if (!ys.contains(Integer.valueOf(k.y))) ys.add(Integer.valueOf(k.y));
        }
        for (Keyboard.Key k : bottom) bottomTop = Math.min(bottomTop, k.y);
        if (bottomTop <= top || right <= left) return false;
        float xmlPitch = (bottomTop - top) / (float) ys.size();
        float vgap = Math.max(0f, xmlPitch - keyHeight);
        float pitch = (bottomTop - top) / (float) n;
        int rowHeight = Math.max(1, Math.round(pitch - vgap));
        float span = right - left;

        // the keys of the system of the XML (to put in their new place) and the popups of its keys, by label
        ArrayList<Keyboard.Key> system = new ArrayList<Keyboard.Key>();
        HashMap<String, Keyboard.Key> byLabel = new HashMap<String, Keyboard.Key>();
        for (Keyboard.Key k : upper) {
            if (editable(k)) {
                String l = k.label.toString();
                if (!byLabel.containsKey(l)) byLabel.put(l, k);
            } else {
                system.add(k);
            }
        }

        ArrayList<Keyboard.Key> out = new ArrayList<Keyboard.Key>();
        // rows that got a key: the keyboard counts its rows by them (a row of gaps only is no row)
        int rowsMade = 0;
        for (int r = 0; r < n; r++) {
            int before = out.size();
            ArrayList<Item> row = s.rows.get(r);
            boolean last = r == n - 1;
            float weight = last && delete != null ? DELETE_WIDTH : 0f;
            for (Item it : row) weight += SheetModel.clampWidth(it.spec.width);
            float unit = span / Math.max(10f, weight);
            int y = Math.round(top + r * pitch);
            Keyboard.Row kr = new Keyboard.Row(kb);
            kr.defaultWidth = unit;
            kr.defaultHeight = rowHeight;
            kr.verticalGap = Math.round(vgap);
            kr.mode = 0;
            float x = left;
            for (Item it : row) {
                float w = SheetModel.clampWidth(it.spec.width) * unit;
                if (!isGap(it.spec)) {
                    Keyboard.Key k = keyFor(res, sheets, kb, kr, it, system, byLabel);
                    k.setCustomBounds(x, w, 0f, 0f, y, rowHeight);
                    out.add(k);
                }
                x += w;
            }
            if (last && delete != null) {
                delete.setCustomBounds(x, DELETE_WIDTH * unit, 0f, 0f, y, rowHeight);
                out.add(delete);
            }
            if (out.size() > before) rowsMade++;
        }
        keys.clear();
        keys.addAll(out);
        keys.addAll(bottom);
        for (Keyboard.Key k : keys) k.popupReversed = false;
        kb.finishCustomBuild(kb.getMinWidth(), kb.getHeight(), kb.getDefaultHeightPx(), rowsMade + 1, kb.mLayoutRows);
        kb.bindCustomSpecialKeys();
        return true;
    }

    /**
     * The key of the keyboard for a key of the edited ABC: a special key that the XML has (Shift, Ctrl...) is that key of the XML (its icon,
     * its state; a label of its own if it had one), any other key is made as on the sheets, with the popup of the XML where it was kept and
     * its capital for Shift.
     */
    static Keyboard.Key keyFor(Resources res, List<SheetModel.Sheet> sheets, LatinKeyboard kb, Keyboard.Row row, Item it,
            List<Keyboard.Key> system, Map<String, Keyboard.Key> byLabel) {
        SheetModel.KeySpec spec = it.spec;
        if (SheetModel.TYPE_SPECIAL.equals(SheetModel.normalizeType(spec.type))) {
            int code = parseInt(spec.value);
            for (int i = 0; i < system.size(); i++) {
                Keyboard.Key k = system.get(i);
                if (code(k) != code) continue;
                system.remove(i);
                if (k.icon == null && k.label != null && spec.label != null && spec.label.length() > 0) k.label = spec.label;
                return k;
            }
        }
        Keyboard.Key k = kb.createCustomKey(row);
        SheetKeyboardBuilder.configureKeyFromSpec(res, sheets, k, spec);
        Keyboard.Key from = it.popupOf == null ? null : byLabel.get(it.popupOf);
        if (from != null && from.popupCharacters != null) {
            k.popupCharacters = from.popupCharacters;
            k.popupResId = from.popupResId;
        }
        k.mrSetCase(capital(k));
        return k;
    }

    private static int parseInt(String s) {
        try {
            return Integer.parseInt(s == null ? new String() : s.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
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
