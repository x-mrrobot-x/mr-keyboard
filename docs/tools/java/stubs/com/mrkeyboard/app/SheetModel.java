package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Compile stub (APK class, smali): the sheet data model. Only what the Java layer reads. */
public final class SheetModel {
    private SheetModel() { }

    public static final String TYPE_TEXT = "text";
    public static final String TYPE_TASKER = "tasker";
    public static final String TYPE_SPECIAL = "special";
    public static final String TYPE_SHEET = "sheet";
    public static final String TYPE_SPACER = "spacer";
    public static final String TARGET_ABC = "abc";
    public static final String TARGET_NEXT = "next";
    public static final String TARGET_PREV = "prev";
    /** Codes of the "next/previous sheet" keys of the special-key catalog. */
    public static final int CODE_SHEET_NEXT = -300;
    public static final int CODE_SHEET_PREV = -299;
    public static final int MAX_BADGE_LEN = 5;
    public static final int MAX_KEYS_LAST_ROW_ADD = 9;
    public static final int MAX_KEYS_PER_ROW = 10;
    public static final int MAX_ROWS = 6;
    public static final int MAX_SHEETS = 12;

    public static final class KeySpec {
        public String label;
        public String type;
        public String value;
        public float width;
        public String popupChars;
        public ArrayList<KeySpec> popupKeys;
        public KeySpec(String label, String type, String value, float width) {
            this.label = label;
            this.type = type;
            this.value = value;
            this.width = width;
        }
        public KeySpec deepCopy() { return null; }
        public boolean hasAnyPopup() { return false; }
        public boolean hasPopupKeys() { return false; }
        public boolean hasPopupChars() { return false; }
    }

    public static final class Row {
        public ArrayList<KeySpec> keys = new ArrayList<KeySpec>();
        public Row deepCopy() { return null; }
    }

    public static final class Sheet {
        public String id;
        public String name;
        public String badge;
        public boolean builtin;
        public ArrayList<Row> rows;
        public Sheet deepCopy() { return null; }
        public int countKeys() { return 0; }
    }

    public static String sanitizeName(String raw, String fallback) { return null; }
    public static String sanitizeBadge(String raw, String fallback) {
        return raw == null || raw.isEmpty() ? fallback : raw;   // stub
    }
    public static String makeUniqueId(List<Sheet> sheets, String base) { return null; }
    public static float clampWidth(float width) { return width; }
    public static String stripTaskerPrefix(String command) { return command; }
    public static ArrayList<Sheet> parseSheets(String json) { return null; }
    public static Sheet createBlankTemplate(String id, String name, String badge) { return null; }
    public static Sheet createNumpadTemplate(String id, String name, String badge) { return null; }
    public static Sheet createNavEditTemplate(String id, String name, String badge) { return null; }
}
