package com.mrkeyboard.app;

import android.content.Context;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/** Compile stub (APK class, smali): the store of the sheets (sheets.json). Only what the Java layer calls. */
public final class SheetStore {
    private SheetStore() { }

    public static ArrayList<SheetModel.Sheet> getEditableCopy(Context c) { return null; }
    public static SheetModel.Sheet getSheetCopyById(Context c, String id) { return null; }
    public static boolean updateSingleSheet(Context c, SheetModel.Sheet sheet) { return false; }
    public static SheetModel.Sheet loadDefaultBuiltinSheet(Context c, String id) { return null; }
    public static boolean save(Context c, List<SheetModel.Sheet> sheets) { return false; }
    public static String exportJsonString(Context c) { return null; }
    public static int importJsonString(Context c, String raw) { return 0; }
    public static String readStreamUtf8(InputStream in) { return null; }
    public static boolean resetAllToDefaults(Context c) { return false; }
    public static boolean resetBuiltinSheet(Context c, String id) { return false; }
    public static boolean consumeCorruptRecoveryFlag() { return false; }
}
