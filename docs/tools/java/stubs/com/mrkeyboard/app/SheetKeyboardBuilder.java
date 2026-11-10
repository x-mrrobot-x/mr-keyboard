package com.mrkeyboard.app;

import java.util.List;

/** Compile stub (APK class, smali): builds the keys of the sheets; here only the label of a sheet target. */
public final class SheetKeyboardBuilder {
    private SheetKeyboardBuilder() { }

    public static String effectiveDisplayLabel(SheetModel.KeySpec key, List<SheetModel.Sheet> sheets) {
        return key != null ? key.label : null;   // stub: the label of the key, which is what the grid draws
    }
}
