package com.mrkeyboard.app;

import java.util.List;

/** Compile stub (APK class, smali): builds the keys of the sheets; here only the label of a sheet target. */
public final class SheetKeyboardBuilder {
    private SheetKeyboardBuilder() { }

    /**
     * The real one configures a key of the keyboard from a key of a sheet (codes, label, text, popup, traits of a special key). Here the same
     * for text and special keys, enough for the tests of MrAbcKeys.
     */
    public static void configureKeyFromSpec(android.content.res.Resources res, List<SheetModel.Sheet> sheets, Keyboard.Key key,
            SheetModel.KeySpec spec) {
        String type = SheetModel.normalizeType(spec.type);
        String label = spec.label == null ? new String() : spec.label;
        String value = spec.value == null ? new String() : spec.value;
        if (SheetModel.TYPE_SPECIAL.equals(type)) {
            key.codes = new int[] {Integer.parseInt(value)};
            key.label = label;
            key.modifier = true;
        } else {
            if (value.isEmpty()) value = label;
            if (label.isEmpty()) label = value;
            key.label = label;
            if (value.length() == 1) {
                key.codes = new int[] {value.charAt(0)};
                key.text = null;
            } else {
                key.codes = new int[] {0};
                key.text = value;
            }
            key.modifier = false;
        }
        if (spec.popupChars != null && !spec.popupChars.isEmpty()) {
            key.popupCharacters = spec.popupChars;
            key.popupResId = 0x7f0f000a;
        }
    }

    public static String effectiveDisplayLabel(SheetModel.KeySpec key, List<SheetModel.Sheet> sheets) {
        return key != null ? key.label : null;   // stub: the label of the key, which is what the grid draws
    }
}
