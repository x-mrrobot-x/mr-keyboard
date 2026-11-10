package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.RectF;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * PC test of the drawn key grid (SheetGridView, Java since 1.92.0): the geometry of the cells (8/10 dp margins, 4/5 dp
 * gaps, 48 dp of key height, the "+" of 30 dp at the right edge, the locked "⌫" with weight 1.5 and the bottom row
 * with the weights 0.2/0.1/0.4/0.1/0.2), the limits (6 rows, 10 keys per row and 9 in the last one) and the touch
 * rules of the old smali: a tap opens the key ("+", "⌫" and the bottom row go to the locked callbacks), a finger that
 * walks away cancels, a long press starts the drag and drops the key on the row/position under it, and a full target
 * row refuses the drop.
 *
 * It runs the real class over the compile stubs (fake context, resources and handler) and reads the built cells by
 * reflection, so the numbers below are the ones the grid uses on the device (density 2, width 1080 px).
 */
public class SheetGridViewTest {
    private static int checks = 0;
    private static int failures = 0;

    private static final float DENSITY = 2f;
    private static final float PAD_X = 8 * DENSITY;       // margin of the keys
    private static final float PAD_TOP = 10 * DENSITY;    // top of the first row
    private static final float GAP = 4 * DENSITY;         // between the keys of a row
    private static final float ROW_GAP = 5 * DENSITY;     // between the rows
    private static final float KEY_H = 48 * DENSITY;      // height of a key
    private static final float ADD_W = 30 * DENSITY;      // the "+" of a row
    private static final int WIDTH = 1080;

    public static void main(String[] args) throws Exception {
        measure();
        oneRowLayout();
        proportions();
        limits();
        taps();
        cancelAndScroll();
        drag();
        dropOnFullRow();
        System.out.println(failures == 0
                ? "ALL OK (" + checks + " checks)"
                : failures + " FAILURE(S) of " + checks);
        System.exit(failures == 0 ? 0 : 1);
    }

    // ------------------------------------------------------------------ onMeasure

    private static void measure() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a"}, new float[]{1f});
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        // 2 blocks (the row + the bottom row): 2*10dp + 2*48dp + 1*5dp = 121dp
        check("height with 1 row = 121dp", Math.round(121 * DENSITY), grid.stubMeasuredHeight());

        SheetModel.Sheet many = oneRow(new String[]{"a"}, new float[]{1f});
        for (int i = 0; i < 8; i++) many.rows.add(new SheetModel.Row());
        SheetGridView grid2 = grid();
        grid2.setData(many, sheets(many));
        grid2.measure(WIDTH, 4000);
        // 7 blocks (6 rows + the bottom row): 2*10dp + 7*48dp + 6*5dp = 386dp
        check("height with more than 6 rows stops at 6 (+ the bottom row)",
                Math.round(386 * DENSITY), grid2.stubMeasuredHeight());
    }

    // ------------------------------------------------------------------ the cells of one row

    private static void oneRowLayout() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a", "b", "c"}, new float[]{1f, 1f, 1f});
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);

        // 3 keys + the locked "⌫" (this row is also the last one) + the "+" + 5 of the bottom row
        check("cells: 3 keys + \"⌫\" + \"+\" + 5 of the bottom row", 10, cells.size());
        check("first cell is a key", 0, cells.get(0).kind);
        check("first key starts at 8dp", PAD_X, cells.get(0).rect.left);
        check("first key top = 10dp", PAD_TOP, cells.get(0).rect.top);
        check("key height = 48dp", KEY_H, cells.get(0).rect.height());
        check("second key starts after the first + 4dp", cells.get(0).rect.right + GAP, cells.get(1).rect.left);
        check("the keys keep the order", "a|b|c", cells.get(0).label + "|" + cells.get(1).label + "|" + cells.get(2).label);

        // the locked "⌫" closes the row: weight 1.5 against 3 keys of weight 1
        float usable = WIDTH - (2 * PAD_X);
        float rowW = Math.max(20f, (usable - ADD_W) - GAP);
        float avail = rowW - (3 * GAP);                    // 4 slots: 3 keys + the "⌫"
        check("the locked \"⌫\" comes after the last key", 2, cells.get(3).kind);
        check("the locked \"⌫\" closes the row, with weight 1.5", avail * (1.5f / 4.5f), cells.get(3).rect.width(), 0.05f);
        check("the locked \"⌫\" is labelled with the arrow", "⌫", cells.get(3).label);

        // the "+" of the row is the last one and touches the right margin
        check("\"+\" is the cell after the \"⌫\"", 1, cells.get(4).kind);
        check("\"+\" is 30dp wide", ADD_W, cells.get(4).rect.width(), 0.05f);
        check("\"+\" ends at the right margin", WIDTH - PAD_X, cells.get(4).rect.right, 0.05f);
        check("the keys stop before the \"+\"", true, cells.get(3).rect.right < cells.get(4).rect.left);

        // the locked bottom row: badge, comma, space, dot and enter
        float bottomTop = PAD_TOP + KEY_H + ROW_GAP;
        check("the bottom row starts after the row + 5dp", bottomTop, cells.get(5).rect.top);
        check("the bottom row has 5 cells", 5, countKind(cells, 3));
        check("bottom row labels", "TST|,|␣|.|⏎",
                cells.get(5).label + "|" + cells.get(6).label + "|" + cells.get(7).label + "|" + cells.get(8).label + "|" + cells.get(9).label);
        float bottomUsable = usable - (4 * GAP);
        check("the space of the bottom row is 0.4 of it", bottomUsable * 0.4f, cells.get(7).rect.width(), 0.05f);
        check("the comma of the bottom row is 0.1 of it", bottomUsable * 0.1f, cells.get(6).rect.width(), 0.05f);
        check("the bottom row ends at the right margin", WIDTH - PAD_X, cells.get(9).rect.right, 0.05f);
    }

    // ------------------------------------------------------------------ proportions

    private static void proportions() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"x", "y"}, new float[]{1f, 2f});
        sheet.rows.get(0).keys.add(new SheetModel.KeySpec("z", SheetModel.TYPE_SPACER, "", 0.5f));
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);
        // weights 1 + 2 + 0.5, plus 1.5 of the locked "⌫" (this row is the last one)
        check("a 2x key takes twice the width of a 1x key", 2f, cells.get(1).rect.width() / cells.get(0).rect.width(), 0.01f);
        check("a 0.5x key takes half the width of a 1x key", 0.5f, cells.get(2).rect.width() / cells.get(0).rect.width(), 0.01f);
    }

    // ------------------------------------------------------------------ limits

    private static void limits() throws Exception {
        // an empty row (not the last one) is one "+ add key" cell across the row
        SheetGridView emptyGrid = grid();
        SheetModel.Sheet emptySheet = new SheetModel.Sheet();
        emptySheet.id = "e";
        emptySheet.badge = "E";
        emptySheet.rows = new ArrayList<SheetModel.Row>();
        emptySheet.rows.add(new SheetModel.Row());
        emptySheet.rows.add(oneRow(new String[]{"a"}, new float[]{1f}).rows.get(0));
        emptyGrid.setData(emptySheet, sheets(emptySheet));
        emptyGrid.measure(WIDTH, 2000);
        List<Cell> emptyCells = cells(emptyGrid);
        check("an empty row is one cell", 1, emptyCells.get(0).kind);
        check("an empty row keeps the text of mr_grid_add_key", "+ Adicionar tecla", emptyCells.get(0).label);

        // a row with 10 keys has no "+"
        String[] ten = new String[10];
        float[] ones = new float[10];
        for (int i = 0; i < 10; i++) { ten[i] = "k" + i; ones[i] = 1f; }
        SheetGridView fullGrid = grid();
        SheetModel.Sheet fullSheet = oneRow(new String[]{"a"}, new float[]{1f});
        SheetModel.Row full = new SheetModel.Row();
        for (int i = 0; i < 10; i++) full.keys.add(new SheetModel.KeySpec(ten[i], SheetModel.TYPE_TEXT, "v", 1f));
        fullSheet.rows.add(full);
        fullGrid.setData(fullSheet, sheets(fullSheet));
        fullGrid.measure(WIDTH, 2000);
        List<Cell> fullCells = cells(fullGrid);
        check("a full row (10 keys) has no \"+\"", 1, countKind(fullCells, 1));   // only the first row has one
        check("the full row keeps the 10 keys", 10, countKind(fullCells, 0) - 1);

        // the last row takes 9 keys + the locked "⌫"
        SheetGridView lastGrid = grid();
        SheetModel.Sheet lastSheet = oneRow(new String[]{"a"}, new float[]{1f});
        SheetModel.Row nine = new SheetModel.Row();
        for (int i = 0; i < 9; i++) nine.keys.add(new SheetModel.KeySpec("L" + i, SheetModel.TYPE_TEXT, "v", 1f));
        lastSheet.rows.add(nine);
        lastGrid.setData(lastSheet, sheets(lastSheet));
        lastGrid.measure(WIDTH, 2000);
        List<Cell> lastCells = cells(lastGrid);
        check("the last row has the locked \"⌫\"", 1, countKind(lastCells, 2));
        check("the last row (9 keys) has no \"+\" of its own", 1, countKind(lastCells, 1));   // only the first row has one
        check("the locked \"⌫\" is the last key of the last row", "⌫", lastCells.get(11).label);
    }

    // ------------------------------------------------------------------ tap

    private static void taps() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a", "b", "c"}, new float[]{1f, 1f, 1f});
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);
        Rec rec = lastRec;

        tap(grid, cells.get(1).rect.centerX(), cells.get(1).rect.centerY());
        check("tap on a key: onKeyTapped(0, 1)", "tap 0 1", rec.lastEvent);

        tap(grid, cells.get(4).rect.centerX(), cells.get(4).rect.centerY());
        check("tap on \"+\": onAddKeyTapped(0)", "add 0", rec.lastEvent);

        tap(grid, cells.get(3).rect.centerX(), cells.get(3).rect.centerY());
        check("tap on the locked \"⌫\": onLockedKeyTapped(true)", "locked true", rec.lastEvent);

        tap(grid, cells.get(7).rect.centerX(), cells.get(7).rect.centerY());
        check("tap on the bottom row: onLockedKeyTapped(false)", "locked false", rec.lastEvent);

        rec.lastEvent = "none";
        tap(grid, 2f, 2f);
        check("tap outside the cells does nothing", "none", rec.lastEvent);
    }

    // ------------------------------------------------------------------ a finger that walks away

    private static void cancelAndScroll() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a", "b", "c"}, new float[]{1f, 1f, 1f});
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);
        Rec rec = lastRec;
        float x = cells.get(0).rect.centerX();
        float y = cells.get(0).rect.centerY();

        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, x, y));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, x + 60f, y + 60f));   // past the slop
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, x + 60f, y + 60f));
        check("a finger that walks away does not open the key", "none", rec.lastEvent);

        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, x, y));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_CANCEL, x, y));
        check("a cancelled touch does nothing", "none", rec.lastEvent);
    }

    // ------------------------------------------------------------------ drag

    private static void drag() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a", "b", "c"}, new float[]{1f, 1f, 1f});
        sheet.rows.add(new SheetModel.Row());                 // an empty second row (not empty for the grid: it is not the last)
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);
        Rec rec = lastRec;

        float fromX = cells.get(0).rect.centerX();
        float fromY = cells.get(0).rect.centerY();
        float toY = cells.get(5).rect.centerY();              // the middle of the second row

        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, fromX, fromY));
        runPending(grid);                                    // the long press
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, fromX, toY));
        check("the long press starts the drag", true, dragging(grid));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, fromX, toY));
        check("the drop position is the first slot of that row", "drag 0 0 1 0", rec.lastEvent);
        check("after the drop the grid is no longer dragging", false, dragging(grid));

        // drag to the right end of the first row: the key goes to the last position
        grid.setData(sheet, sheets(sheet));                   // rebuild the cells
        List<Cell> cells2 = cells(grid);
        float x0 = cells2.get(0).rect.centerX();
        float y0 = cells2.get(0).rect.centerY();
        float farRight = cells2.get(2).rect.right + 40f;
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, x0, y0));
        runPending(grid);
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, farRight, y0));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, farRight, y0));
        check("dropping after the last key of the row: index 3", "drag 0 0 0 3", rec.lastEvent);
    }

    private static void dropOnFullRow() throws Exception {
        SheetGridView grid = grid();
        SheetModel.Sheet sheet = oneRow(new String[]{"a", "b", "c"}, new float[]{1f, 1f, 1f});
        SheetModel.Row fullRow = new SheetModel.Row();
        for (int i = 0; i < 10; i++) fullRow.keys.add(new SheetModel.KeySpec("F" + i, SheetModel.TYPE_TEXT, "v", 1f));
        sheet.rows.add(fullRow);
        grid.setData(sheet, sheets(sheet));
        grid.measure(WIDTH, 2000);
        List<Cell> cells = cells(grid);
        Rec rec = lastRec;

        float fromX = cells.get(0).rect.centerX();
        float fromY = cells.get(0).rect.centerY();
        float toY = cells.get(5).rect.centerY();
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, fromX, fromY));
        runPending(grid);
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, fromX, toY));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, fromX, toY));
        check("a full row does not take a key from another row", "none", rec.lastEvent);
    }

    // ------------------------------------------------------------------ reading the cells

    /** One cell of the grid, as the class built it. */
    private static final class Cell {
        int kind;
        String label;
        RectF rect;
    }

    @SuppressWarnings("unchecked")
    private static List<Cell> cells(SheetGridView grid) throws Exception {
        // the grid builds the cells on the first draw (or on the first touch): here the test asks for them
        java.lang.reflect.Method build = SheetGridView.class.getDeclaredMethod("ensureCellsBuilt");
        build.setAccessible(true);
        build.invoke(grid);
        Field cellsField = SheetGridView.class.getDeclaredField("mCells");
        cellsField.setAccessible(true);
        List<Object> raw = (List<Object>) cellsField.get(grid);
        ArrayList<Cell> out = new ArrayList<Cell>();
        for (Object hit : raw) {
            Cell c = new Cell();
            c.kind = intField(hit, "kind");
            c.label = (String) stringField(hit, "displayLabel");
            c.rect = (RectF) objectField(hit, "rect");
            out.add(c);
        }
        return out;
    }

    private static int intField(Object target, String name) throws Exception {
        Field f = target.getClass().getDeclaredField(name);
        f.setAccessible(true);
        return f.getInt(target);
    }

    private static String stringField(Object target, String name) throws Exception {
        Field f = target.getClass().getDeclaredField(name);
        f.setAccessible(true);
        return (String) f.get(target);
    }

    private static Object objectField(Object target, String name) throws Exception {
        Field f = target.getClass().getDeclaredField(name);
        f.setAccessible(true);
        return f.get(target);
    }

    /** Runs what the grid posted to its Handler (the long press that starts the drag). */
    private static void runPending(SheetGridView grid) throws Exception {
        android.os.Handler handler = (android.os.Handler) objectField(grid, "mHandler");
        handler.stubRunPending();
    }

    private static boolean dragging(SheetGridView grid) throws Exception {
        Field f = SheetGridView.class.getDeclaredField("mDragging");
        f.setAccessible(true);
        boolean[] holder = new boolean[1];
        holder[0] = f.getBoolean(grid);
        return holder[0];
    }

    private static int countKind(List<Cell> cells, int kind) {
        int n = 0;
        for (Cell c : cells) if (c.kind == kind) n++;
        return n;
    }

    // ------------------------------------------------------------------ the grid over the stubs

    private static Rec lastRec;

    private static SheetGridView grid() {
        final HashMap<String, Integer> colors = new HashMap<String, Integer>();
        colors.put("mr_ui_sunken", 0xff08111f);
        colors.put("mr_ui_bg", 0xff060c17);
        colors.put("mr_ui_card", 0xff0d1626);
        colors.put("mr_ui_faint", 0xff0f1c30);
        colors.put("mr_ui_raised", 0xff111d31);
        colors.put("mr_ui_stroke", 0xff132036);
        colors.put("mr_ui_stroke_strong", 0xff1a2a45);
        colors.put("mr_ui_text", 0xffffffff);
        colors.put("mr_ui_text2", 0xffc2dcf6);
        colors.put("mr_ui_text3", 0xff8aa4cc);
        colors.put("mr_ui_text_dis", 0xff4a5c7a);
        colors.put("mr_ui_cyan", 0xff1b97fc);
        colors.put("mr_ui_cyan_soft", 0x241b97fc);
        colors.put("mr_ui_cyan_line", 0x331b97fc);
        colors.put("mr_ui_blue", 0xff60a5fa);
        colors.put("mr_ui_blue_soft", 0x2460a5fa);
        colors.put("mr_ui_blue_line", 0x3360a5fa);
        colors.put("mr_ui_violet", 0xffa78bfa);
        colors.put("mr_ui_violet_soft", 0x24a78bfa);
        colors.put("mr_ui_violet_line", 0x33a78bfa);
        colors.put("mr_ui_slate", 0xff94a3b8);
        final HashMap<String, String> texts = new HashMap<String, String>();
        texts.put("mr_grid_add_key", "+ Adicionar tecla");

        Resources res = new Resources() {
            public int getIdentifier(String name, String defType, String defPackage) {
                if ("color".equals(defType)) return colors.containsKey(name) ? name.hashCode() : 0;
                if ("string".equals(defType)) return texts.containsKey(name) ? name.hashCode() : 0;
                return 0;
            }
            public int getColor(int id) { return colors.get(nameOf(colors, id)); }
            public String getString(int id) { return texts.get(nameOf(texts, id)); }
            public DisplayMetrics getDisplayMetrics() {
                DisplayMetrics dm = new DisplayMetrics();
                dm.density = DENSITY;
                return dm;
            }
            private String nameOf(HashMap<String, ?> map, int id) {
                for (String k : map.keySet()) if (k.hashCode() == id) return k;
                return "";
            }
        };
        Context context = new Context() {
            public android.content.res.AssetManager getAssets() { return null; }
            public Context getApplicationContext() { return this; }
            public Resources getResources() { return res; }
            public String getPackageName() { return "com.mrkeyboard.app"; }
            public android.content.pm.PackageManager getPackageManager() { return null; }
            public android.content.SharedPreferences getSharedPreferences(String n, int m) { return null; }
            public java.io.File getFilesDir() { return null; }
            public java.io.File getCacheDir() { return null; }
            public void startActivity(android.content.Intent i) { }
        };
        SheetGridView grid = new SheetGridView(context);
        grid.stubSize(WIDTH, 2000);
        lastRec = new Rec();
        grid.setGridListener(lastRec);
        return grid;
    }

    private static SheetModel.Sheet oneRow(String[] labels, float[] widths) {
        SheetModel.Sheet sheet = new SheetModel.Sheet();
        sheet.id = "t";
        sheet.name = "Test";
        sheet.badge = "TST";
        sheet.rows = new ArrayList<SheetModel.Row>();
        SheetModel.Row row = new SheetModel.Row();
        for (int i = 0; i < labels.length; i++) {
            row.keys.add(new SheetModel.KeySpec(labels[i], SheetModel.TYPE_TEXT, labels[i], widths[i]));
        }
        sheet.rows.add(row);
        return sheet;
    }

    private static List<SheetModel.Sheet> sheets(SheetModel.Sheet sheet) {
        ArrayList<SheetModel.Sheet> all = new ArrayList<SheetModel.Sheet>();
        all.add(sheet);
        return all;
    }

    private static void tap(SheetGridView grid, float x, float y) {
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, x, y));
        grid.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, x, y));
    }

    // ------------------------------------------------------------------ checks

    private static void check(String name, int expected, int actual) {
        checks++;
        if (expected != actual) { failures++; System.out.println("FAIL " + name + ": " + expected + " != " + actual); }
    }

    private static void check(String name, float expected, float actual) {
        check(name, expected, actual, 0.01f);
    }

    private static void check(String name, float expected, float actual, float tolerance) {
        checks++;
        if (Math.abs(expected - actual) > tolerance) { failures++; System.out.println("FAIL " + name + ": " + expected + " != " + actual); }
    }

    private static void check(String name, String expected, String actual) {
        checks++;
        if (!expected.equals(actual)) { failures++; System.out.println("FAIL " + name + ": \"" + expected + "\" != \"" + actual + "\""); }
    }

    private static void check(String name, boolean expected, boolean actual) {
        checks++;
        if (expected != actual) { failures++; System.out.println("FAIL " + name + ": " + expected + " != " + actual); }
    }

    /** What the grid asks the editor to do. */
    private static class Rec implements SheetGridView.GridListener {
        String lastEvent = "none";

        public void onAddKeyTapped(int row) { lastEvent = "add " + row; }
        public void onKeyDragged(int fromRow, int fromKey, int toRow, int toIndex) {
            lastEvent = "drag " + fromRow + " " + fromKey + " " + toRow + " " + toIndex;
        }
        public void onKeyTapped(int row, int key) { lastEvent = "tap " + row + " " + key; }
        public void onLockedKeyTapped(boolean deleteKey) { lastEvent = "locked " + deleteKey; }
    }
}
