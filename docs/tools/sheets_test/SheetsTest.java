package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.util.DisplayMetrics;
import android.view.inputmethod.EditorInfo;

import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * The "Keyboard sheets" page and the sheet editor, in what can run on the PC (the screens are XML that the stubs do not inflate; the grid is in
 * SheetGridViewTest):
 *   - the quick test field (MrSheetTest): the option of the field, which fields are honoured (only this app's, with an id), where the sheet is,
 *     the keyboard sent to it (and not again when it is already there), "return to the main sheet" held there, and the hooks in LatinIME;
 *   - the texts that the screens make: the target of a "switch sheet" key with the name of the sheet (the popup list used to show the id of the
 *     file), the preview of a row in "Arrange rows", the legend of the colours of the grid;
 *   - the import that reads at most 1 MB;
 *   - the files: the key editor that scrolls, the page without the ⋮ that repeated the backup, the buttons of 40 dp, the editor without the
 *     third button, the strings in three languages (with the limits as values, never written in the text, and the summary of "return to the main
 *     sheet" without the names of the sheets), and the sources (one dialog at a time, a sheet that is gone, no change no undo).
 * The texts are the real ones of res/values-pt-rBR (run at the project root).
 */
public class SheetsTest {
    static int oks, fails;

    static void check(String name, boolean ok) {
        if (ok) {
            oks++;
            System.out.println("OK    " + name);
        } else {
            fails++;
            System.out.println("FAIL  " + name);
        }
    }

    static String read(String path) throws Exception {
        return new String(Files.readAllBytes(Paths.get(path)), StandardCharsets.UTF_8);
    }

    /** The strings of one values folder, as Android gives them (the escapes undone). */
    static Map<String, String> strings(String... paths) throws Exception {
        Map<String, String> out = new HashMap<String, String>();
        Pattern p = Pattern.compile("<string name=\"([^\"]+)\">(.*?)</string>", Pattern.DOTALL);
        for (String path : paths) {
            Matcher m = p.matcher(read(path));
            while (m.find()) {
                out.put(m.group(1), m.group(2).replace("\\n", "\n").replace("\\\"", "\"").replace("\\'", "'").replace("&amp;", "&"));
            }
        }
        return out;
    }

    /** Resources with the real Brazilian Portuguese texts. */
    static class Res extends Resources {
        final Map<String, String> texts;
        final Map<String, Integer> ids = new HashMap<String, Integer>();
        final Map<Integer, String> names = new HashMap<Integer, String>();
        final DisplayMetrics dm = new DisplayMetrics();

        Res(Map<String, String> texts) {
            this.texts = texts;
            dm.density = 2f;
        }

        public int getIdentifier(String name, String type, String pkg) {
            if ("string".equals(type) && !texts.containsKey(name)) return 0;
            String key = type + ":" + name;
            Integer id = ids.get(key);
            if (id == null) {
                id = ids.size() + 1;
                ids.put(key, id);
                names.put(id, name);
            }
            return id;
        }

        public String getString(int id) { return texts.get(names.get(id)); }
        public String getString(int id, Object... args) { return String.format(Locale.ROOT, texts.get(names.get(id)), args); }
        public int getColor(int id) { return 0xff000000 | id; }
        public DisplayMetrics getDisplayMetrics() { return dm; }
    }

    static class Ctx extends Context {
        final Res res;
        final String pkg;

        Ctx(Res res, String pkg) {
            this.res = res;
            this.pkg = pkg;
        }

        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return res; }
        public String getPackageName() { return pkg; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public android.content.SharedPreferences getSharedPreferences(String n, int m) { return null; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }
    }

    /** The keyboard service, with the field that it has open. */
    static class Ime extends LatinIME {
        EditorInfo field;
        boolean fails;

        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.view.inputmethod.EditorInfo getCurrentInputEditorInfo() {
            if (fails) throw new IllegalStateException("gone");
            return field;
        }
    }

    static SheetModel.Sheet sheet(String id, String badge, String name) {
        SheetModel.Sheet s = new SheetModel.Sheet();
        s.id = id;
        s.badge = badge;
        s.name = name;
        s.rows = new ArrayList<SheetModel.Row>();
        return s;
    }

    static EditorInfo field(String pkg, String options) {
        EditorInfo e = new EditorInfo();
        e.packageName = pkg;
        e.privateImeOptions = options;
        return e;
    }

    public static void main(String[] args) throws Exception {
        Map<String, String> pt = strings("res/values-pt-rBR/mr_strings.xml", "res/values-pt-rBR/strings.xml");
        Map<String, String> en = strings("res/values/mr_strings.xml", "res/values/strings.xml");
        Map<String, String> es = strings("res/values-es/mr_strings.xml", "res/values-es/strings.xml");
        Res res = new Res(pt);
        Ctx ctx = new Ctx(res, "com.mrkeyboard.app");

        testField();
        testKeyboard();
        testTexts(ctx);
        testImport();
        testFiles(pt, en, es);

        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAILURE(S) of " + (oks + fails));
        System.exit(fails == 0 ? 0 : 1);
    }

    // ------------------------------------------------------------------ the quick test field

    static void testField() {
        String own = "com.mrkeyboard.app";
        check("option: the id after the prefix", "com.mrkeyboard.app.sheet=symbols".equals(MrSheetTest.option("symbols")));
        check("field of this app with the option: its id", "symbols".equals(MrSheetTest.sheetId(field(own, MrSheetTest.option("symbols")), own)));
        check("the option among others (comma separated, spaces around)",
                "custom_7".equals(MrSheetTest.sheetId(field(own, "nm, com.mrkeyboard.app.sheet=custom_7 ,x"), own)));
        check("a field of another app with the same option: nothing (only this app's field is honoured)",
                MrSheetTest.sheetId(field("com.other.app", MrSheetTest.option("symbols")), own) == null);
        check("no option, an empty id, no field, no package: nothing",
                MrSheetTest.sheetId(field(own, null), own) == null && MrSheetTest.sheetId(field(own, "com.mrkeyboard.app.sheet= "), own) == null
                        && MrSheetTest.sheetId(null, own) == null && MrSheetTest.sheetId(field(own, MrSheetTest.option("a")), null) == null
                        && MrSheetTest.sheetId(field(own, "other.option=1"), own) == null);

        SheetStore.stubSheets.clear();
        SheetStore.stubSheets.add(sheet("symbols", "123", "Símbolos"));
        SheetStore.stubSheets.add(sheet("tasker", "TSK", "Tasker"));
        Ctx c = new Ctx(new Res(new HashMap<String, String>()), own);
        check("position: 1 for the first sheet, 2 for the second (0 is ABC)",
                MrSheetTest.position(c, field(own, MrSheetTest.option("symbols"))) == 1 && MrSheetTest.position(c, field(own, MrSheetTest.option("tasker"))) == 2);
        check("position: 0 for a sheet that is gone, for another app's field and with no context",
                MrSheetTest.position(c, field(own, MrSheetTest.option("deleted"))) == 0
                        && MrSheetTest.position(c, field("com.other.app", MrSheetTest.option("tasker"))) == 0
                        && MrSheetTest.position(null, field(own, MrSheetTest.option("tasker"))) == 0);
    }

    static void testKeyboard() {
        KeyboardSwitcher ks = KeyboardSwitcher.getInstance();
        Ime ime = new Ime();
        ime.field = field("com.mrkeyboard.app", MrSheetTest.option("tasker"));
        ks.stubSheet = 0;
        MrSheetTest.show(ime);
        check("test field of the second sheet: the keyboard goes to position 2 (changeSheet(3), it counts from 1)", ime.stubChangedTo == 3);
        ime.stubChangedTo = Integer.MIN_VALUE;
        ks.stubSheet = 2;
        MrSheetTest.show(ime);
        check("already on that sheet: no change (the keyboard is not rebuilt for nothing)", ime.stubChangedTo == Integer.MIN_VALUE);
        check("return to the main sheet: held on the test field", MrSheetTest.holds(ime));

        ime.field = field("com.mrkeyboard.app", null);
        ks.stubSheet = 0;
        MrSheetTest.show(ime);
        check("any other field of the app: nothing changes, and return to the main sheet works as always",
                ime.stubChangedTo == Integer.MIN_VALUE && !MrSheetTest.holds(ime));
        ime.field = field("com.whatsapp", MrSheetTest.option("tasker"));
        MrSheetTest.show(ime);
        check("a field of another app that writes the option: nothing", ime.stubChangedTo == Integer.MIN_VALUE && !MrSheetTest.holds(ime));
        ime.field = field("com.mrkeyboard.app", MrSheetTest.option("deleted"));
        MrSheetTest.show(ime);
        check("the sheet of the field was deleted: nothing (the keyboard stays on ABC)", ime.stubChangedTo == Integer.MIN_VALUE && !MrSheetTest.holds(ime));
        ime.field = null;
        MrSheetTest.show(ime);
        check("no field: nothing", ime.stubChangedTo == Integer.MIN_VALUE && !MrSheetTest.holds(ime));
        ime.fails = true;
        boolean quiet = true;
        try {
            MrSheetTest.show(ime);
            quiet = !MrSheetTest.holds(ime);
        } catch (Throwable t) {
            quiet = false;
        }
        check("a failure inside never reaches the keyboard (show does nothing, holds says no)", quiet && ime.stubChangedTo == Integer.MIN_VALUE);
    }

    // ------------------------------------------------------------------ texts made by the screens

    static void testTexts(Ctx c) {
        List<SheetModel.Sheet> sheets = new ArrayList<SheetModel.Sheet>();
        sheets.add(sheet("custom_1712", "NUM", "Numérico"));
        check("target of a sheet: its badge and name", "[NUM] Numérico".equals(KeyEditDialog.describeTarget(c, sheets, "custom_1712")));
        check("targets next, previous and ABC", "Próxima folha (ciclo)".equals(KeyEditDialog.describeTarget(c, sheets, SheetModel.TARGET_NEXT))
                && "Folha anterior (ciclo)".equals(KeyEditDialog.describeTarget(c, sheets, SheetModel.TARGET_PREV))
                && KeyEditDialog.describeTarget(c, sheets, SheetModel.TARGET_ABC).startsWith("ABC"));
        check("a sheet that is gone (or no list) reads as the next one, as the keyboard does",
                "Próxima folha (ciclo)".equals(KeyEditDialog.describeTarget(c, sheets, "gone"))
                        && "Próxima folha (ciclo)".equals(KeyEditDialog.describeTarget(c, null, "custom_1712"))
                        && "Próxima folha (ciclo)".equals(KeyEditDialog.describeTarget(c, sheets, null)));
        SheetModel.KeySpec go = new SheetModel.KeySpec("NUM", SheetModel.TYPE_SHEET, "custom_1712", 1f);
        String desc = PopupEditDialog.describeActionShort(c, sheets, go);
        check("item of a popup that switches sheet: the name of the sheet, not the id of the file (" + desc + ")",
                "Ir para: [NUM] Numérico".equals(desc) && !desc.contains("custom_"));
        check("item of a popup with text: as before", "Texto: a↵b".equals(PopupEditDialog.describeActionShort(c, sheets,
                new SheetModel.KeySpec("a", SheetModel.TYPE_TEXT, "a\nb", 1f))));

        SheetModel.Row row = new SheetModel.Row();
        row.keys.add(new SheetModel.KeySpec("1", SheetModel.TYPE_TEXT, "1", 1f));
        row.keys.add(new SheetModel.KeySpec("", SheetModel.TYPE_SPACER, "", 1f));
        row.keys.add(new SheetModel.KeySpec("<b>\n</b>", SheetModel.TYPE_TEXT, "<b></b>", 1f));
        check("preview of a row: the labels apart, a gap as ␣ and a line break as ↵",
                "1  ␣  <b>↵</b>".equals(SheetEditorActivity.rowPreview(row, sheets, "Vazia")));
        check("preview of an empty row: the word for it", "Vazia".equals(SheetEditorActivity.rowPreview(new SheetModel.Row(), sheets, "Vazia"))
                && "Vazia".equals(SheetEditorActivity.rowPreview(null, sheets, "Vazia")));
        SheetModel.Row longRow = new SheetModel.Row();
        for (int i = 0; i < 10; i++) longRow.keys.add(new SheetModel.KeySpec("label" + i, SheetModel.TYPE_TEXT, "x", 1f));
        String cut = SheetEditorActivity.rowPreview(longRow, sheets, "Vazia");
        check("preview of a long row: cut with … at " + SheetEditorActivity.ROW_PREVIEW_MAX + " characters",
                cut.endsWith("…") && cut.length() == SheetEditorActivity.ROW_PREVIEW_MAX + 1 && cut.startsWith("label0  label1"));

        CharSequence legend = SheetEditorActivity.legend(new String[] { "Texto", "Tasker", "Troca de folha", "Especial", "Espaço vazio" },
                new int[] { 1, 2, 3, 4, 5 });
        String l = legend.toString();
        List<Object[]> spans = ((SpannableStringBuilder) legend).stubSpans;
        boolean colours = spans.size() == 5;
        for (int i = 0; i < spans.size() && colours; i++) {
            Object[] s = spans.get(i);
            colours = s[0] instanceof ForegroundColorSpan && ((ForegroundColorSpan) s[0]).stubColor == i + 1
                    && ((Integer) s[2]) - ((Integer) s[1]) == 1 && "●○".indexOf(l.charAt((Integer) s[1])) >= 0;
        }
        check("legend: five marks, each in its colour, the gap hollow", colours && l.indexOf('○') == l.lastIndexOf('○') && l.contains("○ Espaço vazio"));
        check("legend: a mark and its name never split across lines (no-break spaces), the entries apart where the line can wrap",
                l.contains("● Troca de folha") && l.contains("Texto    ●"));
    }

    // ------------------------------------------------------------------ import

    static void testImport() throws Exception {
        byte[] small = "{\"sheets\":[]}".getBytes(StandardCharsets.UTF_8);
        check("import: a small file is read whole, as UTF-8", "{\"sheets\":[]}".equals(PrefScreenSheets.readCapped(new ByteArrayInputStream(small), 1024)));
        byte[] accents = "{\"name\":\"Símbolos\"}".getBytes(StandardCharsets.UTF_8);
        check("import: accents survive (UTF-8)", PrefScreenSheets.readCapped(new ByteArrayInputStream(accents), 1024).contains("Símbolos"));
        byte[] big = new byte[PrefScreenSheets.IMPORT_MAX_BYTES + 1];
        check("import: a file over the limit is refused (null), not held in memory", PrefScreenSheets.readCapped(new ByteArrayInputStream(big),
                PrefScreenSheets.IMPORT_MAX_BYTES) == null);
        byte[] exact = new byte[PrefScreenSheets.IMPORT_MAX_BYTES];
        check("import: a file of exactly the limit is read", PrefScreenSheets.readCapped(new ByteArrayInputStream(exact),
                PrefScreenSheets.IMPORT_MAX_BYTES).length() == PrefScreenSheets.IMPORT_MAX_BYTES);
        check("import: the limit is 1 MB (a backup of 12 full sheets is far smaller)", PrefScreenSheets.IMPORT_MAX_BYTES == 1024 * 1024);
    }

    // ------------------------------------------------------------------ files

    static void testFiles(Map<String, String> pt, Map<String, String> en, Map<String, String> es) throws Exception {
        String ime = read("smali/com/mrkeyboard/app/LatinIME.smali");
        String start = method(ime, ".method public onStartInputView(");
        String shown = method(ime, ".method public onWindowShown()V");
        String back = method(ime, ".method private returnToMainSheet(I)V");
        String show = "invoke-static {p0}, Lcom/mrkeyboard/app/MrSheetTest;->show(Lcom/mrkeyboard/app/LatinIME;)V";
        check("LatinIME.onStartInputView: MrSheetTest.show at the end, after the field is set up (before MrPerf.openEnd)",
                start.contains(show) && start.indexOf(show) > start.indexOf("checkReCorrectionOnStart") && start.indexOf(show) < start.lastIndexOf("MrPerf;->openEnd"));
        check("LatinIME.onWindowShown: MrSheetTest.show after resetSheetToAbc", shown.contains(show) && shown.indexOf(show) > shown.indexOf("resetSheetToAbc"));
        check("LatinIME.returnToMainSheet: MrSheetTest.holds before going back to ABC",
                back.contains("MrSheetTest;->holds(Lcom/mrkeyboard/app/LatinIME;)Z") && back.indexOf("MrSheetTest;->holds") < back.indexOf("changeSheet"));
        check("MrSheetTest is called nowhere else in LatinIME", count(ime, "MrSheetTest;->") == 3);

        String keyEd = read("res/layout/mr_key_ed_dialog.xml");
        check("key editor: the content scrolls (root ScrollView), so width, popup and actions are reached with the keyboard open",
                keyEd.replaceAll("(?s)<!--.*?-->", "").replaceFirst("(?s)^<\\?xml.*?\\?>\\s*", "").startsWith("<ScrollView"));
        String page = read("res/layout/mr_sheets_screen.xml");
        check("page: no ⋮ in the header (it repeated the backup section), the backup section with its note",
                !page.contains("more_slot") && page.contains("@string/mr_sheets_backup_section") && page.contains("@string/mr_sheets_backup_note")
                        && page.contains("@string/mr_sheets_section_note"));
        String card = read("res/layout/mr_sheet_card.xml");
        check("card: up, down and options of 40 dp", count(card, "android:layout_width=\"40dp\"") == 3 && count(card, "android:layout_height=\"40dp\"") == 3);
        String ed = read("res/layout/mr_sheet_ed_screen.xml");
        check("editor: no third button (name and badge are the header and the menu), the pencil, undo as an icon and the legend",
                !ed.contains("name_btn") && ed.contains("android:tag=\"edit_icon\"") && ed.contains("@drawable/mr_ui_ic_undo")
                        && ed.contains("android:tag=\"legend\""));
        String rows = read("res/layout/mr_sheet_ed_row_item.xml");
        check("arrange rows: drawn buttons (no ⧉ that some fonts lack) and the preview of the keys",
                !rows.contains("⧉") && rows.contains("<ImageView") && rows.contains("android:tag=\"keys\""));

        String[] names = { "mr_sheets_section_note", "mr_sheets_new_full", "mr_sheets_backup_section", "mr_sheets_backup_note", "mr_sheets_badge_label",
                "mr_sheets_badge_note", "mr_sheets_up_desc", "mr_sheets_down_desc", "mr_sheets_options_desc", "mr_sheets_import_too_big",
                "mr_sheet_ed_rename_desc", "mr_sheet_ed_legend_text", "mr_sheet_ed_legend_tasker", "mr_sheet_ed_legend_special",
                "mr_sheet_ed_legend_sheet", "mr_sheet_ed_legend_spacer", "mr_sheet_ed_row_empty", "mr_sheet_ed_row_up", "mr_sheet_ed_row_down",
                "mr_sheet_ed_row_dup", "mr_sheet_ed_row_del", "mr_sheet_ed_row_deleted", "mr_sheet_ed_gone", "mr_grid_desc" };
        boolean all = true;
        for (String n : names) all &= pt.containsKey(n) && en.containsKey(n) && es.containsKey(n);
        check("the new texts in Portuguese, English and Spanish", all);
        boolean gone = true;
        for (String n : new String[] { "mr_sheets_more", "mr_sheets_menu_export", "mr_sheets_menu_import", "mr_sheets_menu_subtitle",
                "mr_sheet_ed_name_btn", "mr_sheet_ed_name_label", "mr_sheet_ed_badge_label", "mr_sheet_ed_rename_title" }) {
            gone &= !pt.containsKey(n) && !en.containsKey(n) && !es.containsKey(n);
        }
        check("the texts of what left the screens are gone", gone);
        check("the limits are values, not written in the text (rows, sheets, keys of a row)",
                pt.get("mr_sheet_ed_subtitle").contains("%2$d") && pt.get("mr_sheet_ed_rows_limit").contains("%1$d")
                        && pt.get("mr_sheet_ed_limit_sheets").contains("%1$d") && pt.get("mr_sheet_ed_row_limit").contains("%1$d")
                        && !en.get("mr_sheet_ed_subtitle").contains("/6") && !es.get("mr_sheet_ed_limit_sheets").contains("12"));
        boolean noNames = true;
        for (Map<String, String> m : new ArrayList<Map<String, String>>(java.util.Arrays.asList(pt, en, es))) {
            noNames &= !m.get("summary_sheet_return_true").contains("TSK") && !m.get("mr_sheets_reset_all_msg").contains("TSK");
        }
        check("\"Return to the main sheet\" and \"Restore default sheets\" do not name the sheets (they can be renamed or deleted)", noNames);
        check("the error messages carry no technical detail (no %1$s from an exception)",
                !pt.get("mr_sheets_export_failed").contains("%") && !pt.get("mr_sheets_import_bad").contains("%")
                        && !pt.get("mr_sheets_import_bad_file").contains("%"));

        String edSrc = read("docs/tools/java/src/com/mrkeyboard/app/SheetEditorActivity.java");
        check("editor: the test field asks for its sheet, and asks again after a duplicate",
                edSrc.contains("mTestInput.setPrivateImeOptions(MrSheetTest.option(mSheet.id))") && edSrc.contains("imm.restartInput(mTestInput)"));
        check("editor: one dialog at a time (key, new key, name, rows, menu, delete, restore)", count(edSrc, "if (busy()") >= 4
                && edSrc.contains("if (busy() || row < 0") && edSrc.contains("mDialog = KeyEditDialog.show("));
        check("editor: a sheet that is gone closes the editor with a note (it no longer edits the first sheet in its place)",
                edSrc.contains("toast(t(\"mr_sheet_ed_gone\"), false);"));
        check("editor: a name and badge that did not change leave no step to undo",
                edSrc.contains("if (newName.equals(mSheet.name) && newBadge.equals(mSheet.badge)) return;"));
        String keySrc = read("docs/tools/java/src/com/mrkeyboard/app/KeyEditDialog.java");
        check("key editor: a key being added has no row of greyed actions",
                keySrc.contains("if (mPopup || !(mCanMoveLeft || mCanMoveRight || mCanDuplicate || mCanDelete))"));
        String listSrc = read("docs/tools/java/src/com/mrkeyboard/app/PrefScreenSheets.java");
        check("page: two quick taps open the editor once", listSrc.contains("if (!firstTap()) return;") && listSrc.contains("TAP_GAP_MS = 700L"));

        // the keys of ABC (MrAbcKeys): the keyboard puts them on ABC, the editor and the page reach them
        String switcher = read("smali/com/mrkeyboard/app/KeyboardSwitcher.smali");
        String getKb = method(switcher, ".method private getKeyboard(");
        String apply = "invoke-static {v5, v4, v6}, Lcom/mrkeyboard/app/MrAbcKeys;->apply(Landroid/content/Context;Lcom/mrkeyboard/app/Keyboard;I)V";
        check("KeyboardSwitcher.getKeyboard: the edits of ABC go on the keyboard read from the XML (after it is made, before it is kept)",
                getKb.contains(apply) && getKb.indexOf(apply) > getKb.indexOf("LatinKeyboard;-><init>(Landroid/content/Context;IIF)V")
                        && getKb.indexOf(apply) < getKb.lastIndexOf(":goto_after_kbd") && count(switcher, "MrAbcKeys;->") == 1);
        String key = read("smali/com/mrkeyboard/app/Keyboard$Key.smali");
        String setCase = method(key, ".method public mrSetCase(Ljava/lang/CharSequence;)V");
        check("Keyboard.Key.mrSetCase: the capital for Shift, and the old hints forgotten", setCase.contains("->shiftLabel:")
                && setCase.contains("->isSimpleUppercase:Z") && setCase.contains("->isDistinctUppercase:Z") && setCase.contains("->hint:")
                && setCase.contains("->altHint:") && setCase.contains("->capsLabel:"));
        check("SheetKeyboardBuilder.configureKeyFromSpec is public (the keys of ABC use it)",
                read("smali/com/mrkeyboard/app/SheetKeyboardBuilder.smali").contains(".method public static configureKeyFromSpec("));
        String builder = read("smali/com/mrkeyboard/app/SheetKeyboardBuilder.smali");
        check("the popup of sheets and a key that switches to ABC show the badge of ABC (it can be renamed)",
                count(builder, "Lcom/mrkeyboard/app/MrAbcKeys;->badge()Ljava/lang/String;") == 2 && !builder.contains("const-string v5, \"ABC\"")
                        && !builder.contains("const-string p0, \"ABC\""));
        check("page: no separate card of ABC (it is the first card of the list)", !page.contains("mr_sheet_fixed_card")
                && !new java.io.File("res/layout/mr_sheet_fixed_card.xml").exists());
        check("page: the card of ABC is the card of the sheets, first, with a padlock in the place of up and down and the same line of rows and keys",
                listSrc.contains("View abc = buildAbcCard();") && listSrc.indexOf("buildAbcCard();") < listSrc.indexOf("buildSheetCard(i, mSheets.get(i))")
                        && listSrc.contains("SheetUi.ICON_LOCK") && listSrc.contains("card.findViewWithTag(\"up\").setVisibility(View.GONE);")
                        && listSrc.contains("t(\"mr_sheets_card_info\", Integer.valueOf(sheet.rows.size())"));
        check("page: the ⋮ of ABC has no up, no down, and a greyed Delete", listSrc.contains("t(\"mr_sheets_menu_delete\"), SheetUi.TONE_DANGER, false)")
                && listSrc.contains("openEditor(MrAbcKeys.ID)") && listSrc.contains("MrAbcKeys.addToBackup(") && listSrc.contains("MrAbcKeys.takeFromBackup("));
        check("editor: ABC is edited as a sheet and saved as ABC, with a greyed Delete and Restore ABC",
                edSrc.contains("MrAbcKeys.load(this, t(\"mr_sheets_main_title\"))") && edSrc.contains("MrAbcKeys.save(this, mAbc)")
                        && edSrc.contains("t(\"mr_sheet_ed_menu_delete\"), SheetUi.TONE_DANGER, false)") && edSrc.contains("t(\"mr_abc_menu_restore\")")
                        && !edSrc.contains("setFixed(") && !keySrc.contains("showForFixedKey"));
        String test = read("res/layout/mr_sheet_ed_test_card.xml");
        check("quick test: no badge \"live\"", !test.contains("test_badge") && !edSrc.contains("mr_sheet_ed_live")
                && !pt.containsKey("mr_sheet_ed_live") && !en.containsKey("mr_sheet_ed_live") && !es.containsKey("mr_sheet_ed_live"));
        check("quick test: short texts that say what to do and what happens", pt.get("mr_sheet_ed_test_footer").length() < 40
                && !pt.get("mr_sheet_ed_test_footer").contains("fica nela") && en.get("mr_sheet_ed_test_footer").length() < 40
                && es.get("mr_sheet_ed_test_footer").length() < 45);
        boolean abcTexts = true;
        for (String n : new String[] { "mr_sheets_abc_locked_desc", "mr_abc_menu_restore", "mr_abc_restore_title", "mr_abc_restore_msg", "mr_abc_restored",
                "mr_abc_save_failed" }) {
            abcTexts &= pt.containsKey(n) && en.containsKey(n) && es.containsKey(n);
        }
        boolean abcGone = true;
        for (String n : new String[] { "mr_sheets_main_desc", "mr_sheets_main_edited", "mr_abc_fixed_key", "mr_abc_ed_hint" }) {
            abcGone &= !pt.containsKey(n) && !en.containsKey(n) && !es.containsKey(n);
        }
        check("the texts of ABC in Portuguese, English and Spanish, and the long description of the old card gone", abcTexts && abcGone);
    }

    static String method(String smali, String head) {
        int i = smali.indexOf(head);
        if (i < 0) return "";
        int j = smali.indexOf(".end method", i);
        return smali.substring(i, j);
    }

    static int count(String s, String what) {
        int n = 0;
        for (int i = s.indexOf(what); i >= 0; i = s.indexOf(what, i + what.length())) n++;
        return n;
    }
}
