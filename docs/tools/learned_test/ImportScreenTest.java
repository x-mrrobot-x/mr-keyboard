package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The screen "Add words and texts" (MrImportActivity) run for real on the PC, against the stubs of Android: the views are built and the text of the box
 * is typed, pasted, restored and replaced the way the AI does it. It shows what the screen DOES (not how it looks): which button is under the box at each
 * moment ("Format with AI" from the start and for a text that is not a list yet, "See what will be added" once it is a list, whoever wrote it), the note that
 * the AI leaves, the summary card of the preview (the numbers, the notes, and why there is nothing to add) and that a preview does not outlive the text it was
 * made from. The file that the screen no longer opens, the warning under the AI card, the way back of the formatting and the texts of the box are checked in
 * the sources and in the three languages. What decides "is a list" is in ImportTest (MrImport.offer).
 */
public class ImportScreenTest {
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

    static final String LIST = "# mr-words 1\n# language: pt-BR\n[words]\nItaú\nNubank\t70\n[phrases]\nvou ver\n";
    static final String CHAT = "[12/03/24 14:05] Ana: vamos no Itaú hoje\n[12/03/24 14:06] Rui: bora no Itaú\n";

    /** The resources of the other screen test, with the configuration of a phone in Brazilian Portuguese. */
    static class Res extends TourScreenTest.Res {
        final android.content.res.Configuration conf = new android.content.res.Configuration();

        Res() {
            conf.locale = new java.util.Locale("pt", "BR");
        }

        public android.content.res.Configuration getConfiguration() { return conf; }
    }

    /** The screen, with the preferences and the stores that a phone would give it. */
    static class Screen extends MrImportActivity {
        final Res res = new Res();
        final Map<String, TourTest.Prefs> files = new HashMap<String, TourTest.Prefs>();
        final List<Intent> started = new ArrayList<Intent>();
        int finishes;

        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) {
            TourTest.Prefs p = files.get(name);
            if (p == null) {
                p = new TourTest.Prefs();
                files.put(name, p);
            }
            return p;
        }
        public void startActivity(Intent i) { started.add(i); }
        public Object getSystemService(String name) { return null; }
        public void finish() { finishes++; }
    }

    // ---------------------------------------------------------------- helpers

    static Object f(Object o, String name) {
        try {
            Field fl = MrImportActivity.class.getDeclaredField(name);
            fl.setAccessible(true);
            return fl.get(o);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    static void set(Object o, String name, Object v) {
        try {
            Field fl = MrImportActivity.class.getDeclaredField(name);
            fl.setAccessible(true);
            fl.set(o, v);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    static Object call(Object o, String name, Class<?>[] types, Object... args) {
        try {
            Method m = MrImportActivity.class.getDeclaredMethod(name, types);
            m.setAccessible(true);
            return m.invoke(o, args);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    static View view(Screen s, String name) { return (View) f(s, name); }
    static String text(Screen s, String name) { return String.valueOf(((TextView) f(s, name)).getText()); }
    static EditText box(Screen s) { return (EditText) f(s, "mText"); }
    static void type(Screen s, String text) { box(s).setText(text); }

    static boolean shown(Screen s, String name) { return view(s, name).getVisibility() == View.VISIBLE; }

    /** The Format with AI button is drawn like the See what will be added one (same text colour and size, which come with the accent fill). */
    static boolean primaryLook(Screen s, String name) {
        TextView t = (TextView) f(s, name), ref = (TextView) f(s, "mAnalyze");
        return t.stubTextColor == ref.stubTextColor && t.stubTextSize == ref.stubTextSize;
    }

    /** The dialog with the preview is open. */
    static boolean previewOpen(Screen s) {
        AlertDialog d = (AlertDialog) f(s, "mPreviewDialog");
        return d != null && d.stubShown && f(s, "mPreview") != null;
    }

    static AlertDialog dialog(Screen s) { return (AlertDialog) f(s, "mPreviewDialog"); }

    static String dialogTitle(Screen s) { return String.valueOf(dialog(s).stubTitle); }

    static String buttonText(android.widget.Button b) { return b == null ? null : String.valueOf(b.getText()); }

    /** Which of the two buttons under the box is on show: "format", "preview", "none" or "both" (neither of the last two ever happens). */
    static String under(Screen s) {
        boolean format = shown(s, "mAiButton"), preview = shown(s, "mAnalyze");
        return format && preview ? "both" : format ? "format" : preview ? "preview" : "none";
    }

    /** Every text that is on a view and under it, in the order of the screen. */
    static void texts(View v, List<String> out) {
        if (v instanceof TextView) out.add(String.valueOf(((TextView) v).getText()));
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) texts(g.getChildAt(i), out);
        }
    }

    static List<String> textsOf(Screen s, String field) {
        ArrayList<String> out = new ArrayList<String>();
        texts(view(s, field), out);
        return out;
    }

    static Screen open(Bundle state) {
        MrLearned.useStore(new MrMemStore());
        Screen s = new Screen();
        s.onCreate(state);
        s.onResume();
        return s;
    }

    static String file(String path) {
        try {
            return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
        } catch (Exception e) {
            throw new RuntimeException(path, e);
        }
    }

    static String string(String values, String name) {
        String x = file("res/" + values + "/mr_strings.xml");
        int a = x.indexOf("<string name=\"" + name + "\">");
        if (a < 0) return null;
        a = x.indexOf('>', a) + 1;
        return x.substring(a, x.indexOf("</string>", a));
    }

    static final String[] LANGS = {"values", "values-pt-rBR", "values-es"};

    // ---------------------------------------------------------------- the button under the box

    static void buttons() {
        Screen s = open(null);
        check("the screen is built with the box, the counter and the two buttons", f(s, "mText") != null && f(s, "mCount") != null && f(s, "mAiButton") != null && f(s, "mAnalyze") != null);
        check("nothing in the box yet: Format with AI is already there, See what will be added is not", under(s).equals("format"));
        check("... and it is quiet (not the colour of the main action) while there is nothing in the box", !primaryLook(s, "mAiButton") && ((TextView) f(s, "mAiButton")).stubTextSize == 14f);
        check("the buttons are the Format with AI one (wand) and the See what will be added one", text(s, "mAiButton").equals("mr_import_ai_button") && text(s, "mAnalyze").equals("mr_import_analyze"));

        type(s, "Itaú");
        check("a word typed alone is not a list: Format with AI appears, See what will be added does not", under(s).equals("format"));
        check("... and with one character in the box it is the colour of the main action, text and size as the See what will be added button", primaryLook(s, "mAiButton") && ((TextView) f(s, "mAiButton")).stubTextSize == 15f);
        check("... and the counter follows", text(s, "mCount").equals("mr_import_count[4]"));
        type(s, "a");
        check("a single character is enough", primaryLook(s, "mAiButton"));
        type(s, "");
        check("the box emptied again: Format with AI, quiet again", under(s).equals("format") && !primaryLook(s, "mAiButton"));
        type(s, "   \n  \n");
        check("only spaces and line breaks: Format with AI, still quiet (nothing to format)", under(s).equals("format") && !primaryLook(s, "mAiButton"));
        type(s, CHAT);
        check("a pasted chat is not a list: Format with AI, in the colour of the main action", under(s).equals("format") && primaryLook(s, "mAiButton"));
        type(s, LIST);
        check("a pasted list in the standard format: See what will be added (and no Format with AI)", under(s).equals("preview"));
        type(s, "[words]\nItaú");
        check("a section is enough to be a list", under(s).equals("preview"));
        type(s, "# mr-words");
        check("typing a list by hand: the header alone already makes it a list", under(s).equals("preview"));
        type(s, "# mr-word");
        check("... and a header that is not finished yet is not (Format with AI again)", under(s).equals("format"));
        type(s, LIST);
        type(s, "[word");
        check("a list that is changed into something else goes back to Format with AI", under(s).equals("format"));
        check("there is never both buttons at once", !under(s).equals("both"));

        // the buttons do what they did before: the one that shows is the one that can be tapped
        type(s, LIST);
        check("the buttons are tappable when nothing is running", view(s, "mAnalyze").isClickable() && view(s, "mAiButton").isClickable());
        call(s, "setBusy", new Class<?>[] {boolean.class, String.class}, true, "working");
        check("while something runs neither can be tapped, and the box is off", !view(s, "mAnalyze").isClickable() && !view(s, "mAiButton").isClickable() && !box(s).isEnabled());
        call(s, "setBusy", new Class<?>[] {boolean.class, String.class}, false, null);
        check("... and they come back", view(s, "mAnalyze").isClickable() && view(s, "mAiButton").isClickable() && box(s).isEnabled());
    }

    // ---------------------------------------------------------------- a text that comes with the screen

    static void restored() {
        Bundle b = new Bundle();
        b.putString("mr_import_s_text", LIST);
        Screen s = open(b);
        check("the screen rebuilt (the phone turned) with a list in the box: See what will be added is there at once", box(s).getText().toString().equals(LIST) && under(s).equals("preview"));
        Bundle c = new Bundle();
        c.putString("mr_import_s_text", CHAT);
        Screen s2 = open(c);
        check("... with a text that is not a list: Format with AI", under(s2).equals("format"));
        Screen s3 = open(new Bundle());
        check("... with nothing: Format with AI", under(s3).equals("format"));
    }

    // ---------------------------------------------------------------- the AI makes the list

    static void afterTheAi() {
        Screen s = open(null);
        type(s, CHAT);
        check("a chat in the box: Format with AI", under(s).equals("format"));
        check("no note about a formatting yet", !shown(s, "mAiNote"));
        MrImportAi.Result r = new MrImportAi.Result();
        r.parts = 1;
        r.done = 1;
        r.words = 2;
        r.phrases = 1;
        r.text = LIST;
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class}, r);
        check("the AI answered with a list: the box holds it", box(s).getText().toString().equals(LIST));
        check("... and now it is See what will be added that shows, not Format with AI", under(s).equals("preview"));
        check("... with the note of what the AI made, and only that (\"Formatted with AI: n words and n phrases\")", shown(s, "mAiNote") && text(s, "mAiNote").equals("mr_import_ai_done[2, 1]"));
        check("... and there is no Undo formatting (no button, no field, no code that brings the text back)",
                !hasField("mAiUndo") && !hasField("mAiBeforeBox") && !hasMethod("undoAi"));
        type(s, LIST + "Santander\n");
        check("the person edits the list that the AI made: the note goes, the button is still See what will be added", under(s).equals("preview") && !shown(s, "mAiNote"));

        // an answer with nothing usable leaves the box as it was
        type(s, CHAT);
        MrImportAi.Result empty = new MrImportAi.Result();
        empty.parts = 1;
        empty.failure = "";
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class}, empty);
        check("an answer with nothing usable leaves the chat in the box, Format with AI under it and no note", box(s).getText().toString().equals(CHAT) && under(s).equals("format") && !shown(s, "mAiNote"));

        // the AI makes the list again and the person goes on: a new text on the screen is not described by the old note
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class}, r);
        check("a second formatting shows the note again", shown(s, "mAiNote") && under(s).equals("preview"));
        type(s, "");
        check("the box emptied: the note goes and Format with AI is back", !shown(s, "mAiNote") && under(s).equals("format"));
    }

    static boolean hasField(String name) {
        try {
            MrImportActivity.class.getDeclaredField(name);
            return true;
        } catch (NoSuchFieldException e) {
            return false;
        }
    }

    static boolean hasMethod(String name) {
        for (Method m : MrImportActivity.class.getDeclaredMethods()) if (m.getName().equals(name)) return true;
        return false;
    }

    // ---------------------------------------------------------------- the words of the preview come 100 at a time, by scrolling

    static void previewPaging() {
        Screen s = open(null);
        StringBuilder text = new StringBuilder("[words]\n");
        for (int i = 0; i < 250; i++) text.append("pal").append((char) ('a' + i / 26)).append((char) ('a' + i % 26)).append("\n");
        type(s, text.toString());
        MrImport.Plan plan = MrImport.parse(text.toString(), new MrImport.Known() {
            public boolean knows(String w) { return false; }
        });
        set(s, "mPlan", plan);
        call(s, "showPreview", new Class<?>[] {});
        android.widget.ScrollView sv = (android.widget.ScrollView) dialog(s).stubView;
        android.widget.LinearLayout words = (android.widget.LinearLayout) f(s, "mWordBox");
        check("250 new words: the first " + MrImportActivity.PREVIEW_PAGE + " are drawn and there is no \"Show more\" button", plan.words.size() == 250
                && words.getChildCount() == MrImportActivity.PREVIEW_PAGE && !String.valueOf(textsOf(s, "mPreview")).contains("mr_learned_more") && sv.stubScrollListener != null);
        sv.stubSize(1000, 1000);
        words.getChildAt(words.getChildCount() - 1).stubTop(3000);
        sv.scrollTo(0, 1800);
        sv.stubScrollListener.onScrollChange(sv, 0, 1800, 0, 0);
        check("far from the last word: nothing more", words.getChildCount() == MrImportActivity.PREVIEW_PAGE);
        sv.scrollTo(0, 1930);
        sv.stubScrollListener.onScrollChange(sv, 0, 1930, 0, 0);
        check("75 dp before the last word: the next " + MrImportActivity.PREVIEW_PAGE + " are added at the end", words.getChildCount() == 2 * MrImportActivity.PREVIEW_PAGE);
        words.getChildAt(words.getChildCount() - 1).stubTop(6000);
        sv.scrollTo(0, 5900);
        sv.stubScrollListener.onScrollChange(sv, 0, 5900, 0, 0);
        check("... and the last 50", words.getChildCount() == 250);
        sv.stubScrollListener.onScrollChange(sv, 0, 5900, 0, 0);
        check("... then nothing more", words.getChildCount() == 250);
        call(s, "tickAll", new Class<?>[] {boolean.class}, false);
        check("ticking all starts again from the first page, and the scroll still works", words.getChildCount() == MrImportActivity.PREVIEW_PAGE);
    }

    // ---------------------------------------------------------------- a preview does not outlive its text

    static void preview() {
        Screen s = open(null);
        type(s, LIST);
        MrImport.Plan plan = MrImport.parse(LIST, new MrImport.Known() {
            public boolean knows(String w) { return false; }
        });
        set(s, "mPlan", plan);
        call(s, "showPreview", new Class<?>[] {});
        check("a preview is on show for the list, in a dialog (not in the screen)", previewOpen(s) && f(s, "mPlan") != null
                && dialogTitle(s).equals("mr_import_found_std") && dialog(s).stubView instanceof android.widget.ScrollView);
        AlertDialog first = dialog(s);
        type(s, LIST + "Santander\n");
        check("the person changes the text: the preview that was made from the old one is gone, and its dialog is closed", !previewOpen(s) && f(s, "mPlan") == null && f(s, "mPreview") == null && !first.stubShown);
        // the summary card
        MrImport.Plan fresh = MrImport.parse(LIST, new MrImport.Known() {
            public boolean knows(String w) { return false; }
        });
        set(s, "mPlan", fresh);
        call(s, "showPreview", new Class<?>[] {});
        List<String> card = textsOf(s, "mPreview");
        // the list has two words, a phrase of two words that the dictionary does not know either (4 new words) and the pair of the phrase
        check("the list gives 4 new words and 1 pair, none known", fresh.words.size() == 4 && fresh.pairs.size() == 1 && fresh.knownSkipped == 0);
        int iWords = card.indexOf("mr_import_stat_words"), iPairs = card.indexOf("mr_import_stat_pairs"), iKnown = card.indexOf("mr_import_stat_known");
        check("the dialog has the title of the list and, first of all, the three numbers each with what it counts: 4 new words, 1 word pair, 0 already in the dictionary (in that order)",
                dialogTitle(s).equals("mr_import_found_std") && iWords == 1 && iPairs > iWords && iKnown > iPairs && card.get(iWords - 1).equals("4") && card.get(iPairs - 1).equals("1") && card.get(iKnown - 1).equals("0"));
        check("... no sentence about \"nothing to add\"; the buttons are Cancel and Add, and Add says what will be added",
                !card.contains("mr_import_none_title") && f(s, "mApply") != null && text(s, "mApply").equals("mr_import_apply[4, 1]")
                && buttonText(dialog(s).getButton(AlertDialog.BUTTON_NEGATIVE)).equals("mr_words_cancel") && dialog(s).getButton(AlertDialog.BUTTON_POSITIVE) == f(s, "mApply"));
        check("... Add is on while there is something to add", ((TextView) f(s, "mApply")).isEnabled());
        call(s, "tickAll", new Class<?>[] {boolean.class}, false);
        check("every word unticked: Add says there is nothing to add and cannot be tapped", text(s, "mApply").equals("mr_import_apply_none") && !((TextView) f(s, "mApply")).isEnabled());
        call(s, "tickAll", new Class<?>[] {boolean.class}, true);
        check("... ticked again: it says the numbers and is on", text(s, "mApply").equals("mr_import_apply[4, 1]") && ((TextView) f(s, "mApply")).isEnabled());
        AlertDialog open = dialog(s);
        open.dismiss();
        check("the person closes the dialog: the plan and what the dialog held are dropped", f(s, "mPlan") == null && f(s, "mPreview") == null && f(s, "mPreviewDialog") == null && f(s, "mApply") == null);
        // the same list again for the checks that follow
        set(s, "mPlan", fresh);
        call(s, "showPreview", new Class<?>[] {});
        card = textsOf(s, "mPreview");
        check("... the way to leave a word out, Select all and Select none, one row for each word", card.contains("mr_import_untick") && card.contains("mr_import_all") && card.contains("mr_import_none")
                && card.contains("\u2713  Itaú") && card.contains("\u2713  Nubank"));
        check("a list in another language than the one chosen gets its note inside the card (the list says pt-BR; the screen starts on pt-BR: none)", !card.contains("mr_import_lang_note"));

        // nothing to add: a list whose words the dictionary already has
        MrImport.Plan known = MrImport.parse("# mr-words 1\n[words]\nItaú\nNubank\n", new MrImport.Known() {
            public boolean knows(String w) { return true; }
        });
        set(s, "mPlan", known);
        call(s, "showPreview", new Class<?>[] {});
        List<String> none = textsOf(s, "mPreview");
        check("nothing to add: the card says it with a title and the reason for a list (not the reason of a free text)",
                none.contains("mr_import_none_title") && none.contains("mr_import_none_std") && !none.contains("mr_import_none_new"));
        check("... the numbers say why: 0 new words, 0 pairs, 2 already in the dictionary", none.contains("2") && none.indexOf("mr_import_stat_known") == none.indexOf("2") + 1
                && none.indexOf("0") < none.indexOf("mr_import_stat_words"));
        check("... and there is no Add button (only OK), no list of words and no Select all", f(s, "mApply") == null && !none.contains("mr_import_all") && !none.contains("mr_import_untick")
                && buttonText(dialog(s).getButton(AlertDialog.BUTTON_POSITIVE)).equals("mr_words_ok") && dialog(s).getButton(AlertDialog.BUTTON_NEGATIVE) == null && dialogTitle(s).equals("mr_import_found_std"));
        check("... and the old loose lines are not there (the old sentence of the counts, the old sentence of the known words)", !none.contains("mr_import_counts[0, 0]") && !none.contains("mr_import_known[2]"));

        // nothing to add in a free text: the reason is the one of a free text
        MrImport.Plan freeNone = MrImport.parse("zzqx zzqx", new MrImport.Known() {
            public boolean knows(String w) { return true; }
        });
        set(s, "mPlan", freeNone);
        call(s, "showPreview", new Class<?>[] {});
        List<String> freeCard = textsOf(s, "mPreview");
        check("nothing to add in a free text: its own reason, and the title of a free text", freeCard.contains("mr_import_none_title") && freeCard.contains("mr_import_none_new") && !freeCard.contains("mr_import_none_std")
                && dialogTitle(s).equals("mr_import_found"));

        // lines left out: the button that shows them is in the card, under the reason
        MrImport.Plan lines = MrImport.parse("# mr-words 1\n[words]\nab cd\n12345\n", new MrImport.Known() {
            public boolean knows(String w) { return false; }
        });
        set(s, "mPlan", lines);
        call(s, "showPreview", new Class<?>[] {});
        List<String> withIgnored = textsOf(s, "mPreview");
        check("lines left out and no word to add: the reason and then the button that shows the lines (inside the same card)",
                withIgnored.contains("mr_import_none_title") && withIgnored.contains("mr_import_see_ignored[2]")
                && withIgnored.indexOf("mr_import_none_title") < withIgnored.indexOf("mr_import_see_ignored[2]"));

        // the preview is also gone when the text becomes something that is not a list
        set(s, "mPlan", plan);
        call(s, "showPreview", new Class<?>[] {});
        type(s, "Itaú");
        check("... and then the button is Format with AI and no preview is on show", under(s).equals("format") && !previewOpen(s));
        // a text that the screen sets by itself (the AI) clears its preview by itself, the watcher does not need to
        set(s, "mPlan", plan);
        call(s, "showPreview", new Class<?>[] {});
        call(s, "setBox", new Class<?>[] {String.class}, LIST);
        check("setBox (the screen's own text): the button follows the text", under(s).equals("preview"));
    }

    // ---------------------------------------------------------------- what the screen no longer has

    static void gone() {
        String act = file("docs/tools/java/src/com/mrkeyboard/app/MrImportActivity.java");
        String imp = file("docs/tools/java/src/com/mrkeyboard/app/MrImport.java");
        check("the screen does not open files any more (no picker, no result, no reader, no size limit, no file label)",
                !act.contains("ACTION_OPEN_DOCUMENT") && !act.contains("onActivityResult") && !act.contains("openInputStream") && !act.contains("REQ_OPEN")
                && !act.contains("MAX_FILE_BYTES") && !act.contains("mFileText") && !act.contains("mFileLabel") && !act.contains("showFile") && !act.contains("dropFile"));
        check("the reader of the bytes of a file (MrImport.decode) is gone with it", !imp.contains("static String decode(") && !imp.contains("Charset"));
        check("the folder icon of the button is gone with it (no code and no drawable)", !act.contains("mr_ui_ic_folder") && !new File("res/drawable/mr_ui_ic_folder.xml").exists());
        check("the warning under the AI card is gone, with its icon", !act.contains("mr_import_ai_warn") && !act.contains("mr_ui_ic_warn") && !new File("res/drawable/mr_ui_ic_warn.xml").exists());
        check("the button that shows the preview is in the card of the box, under it (one place), the same eye icon and the primary style",
                act.contains("main.addView(mAnalyze, k.wide(12))") && act.contains("k.iconButton(k.t(\"mr_import_analyze\"), \"mr_ui_ic_eye\", true,") && !act.contains("col.addView(mAnalyze"));
        check("the Format with AI button is in the same card and has the wand", act.contains("main.addView(mAiButton, k.wide(12))") && act.contains("\"mr_ui_ic_wand\""));
        check("it takes the look of the main action with the wand that sits on the accent fill (MrKit.restyleIconButton, drawable with the on-accent line)",
                act.contains("k.restyleIconButton(mAiButton, primary, primary ? \"mr_ui_ic_wand_on\" : \"mr_ui_ic_wand\")")
                && file("res/drawable/mr_ui_ic_wand_on.xml").contains("@color/mr_text_on_accent") && !file("res/drawable/mr_ui_ic_wand_on.xml").contains("@color/mr_accent\""));
        check("the See what will be added button and the Format with AI one use the same pill (iconButton, one place for the look)",
                file("docs/tools/java/src/com/mrkeyboard/app/MrKit.java").contains("void restyleIconButton(TextView b, boolean primary, String iconName)")
                && file("docs/tools/java/src/com/mrkeyboard/app/MrKit.java").contains("restyleIconButton(b, primary, iconName);"));
        check("the choice of the button is made by MrImport.offer", act.contains("MrImport.offer(") && act.contains("OFFER_FORMAT") && act.contains("OFFER_PREVIEW"));

        String[] dead = {"mr_import_open", "mr_import_reading", "mr_import_read_failed", "mr_import_file_empty", "mr_import_file_loaded", "mr_import_file_cut", "mr_import_ai_warn",
                "mr_import_ai_undo", "mr_import_ai_undone", "mr_import_counts", "mr_import_known"};
        boolean none = true;
        for (String lang : LANGS) for (String key : dead) if (string(lang, key) != null) none = false;
        check("the texts of the file button, of the reading of a file, of the warning, of Undo formatting and of the old loose lines of the preview are gone from the three languages", none);
        boolean used = true;
        for (String key : dead) if (act.contains("\"" + key + "\"")) used = false;
        check("... and no code asks for them", used);

        String[] fresh = {"mr_import_none_title", "mr_import_none_std", "mr_import_none_new", "mr_import_stat_words", "mr_import_stat_pairs", "mr_import_stat_known"};
        boolean have = true;
        for (String lang : LANGS) for (String key : fresh) {
            String t = string(lang, key);
            if (t == null || t.trim().length() == 0) have = false;
        }
        check("the texts of the summary card (title, the reasons, the three numbers) exist in the three languages", have);
        check("the reason of a free text does not repeat the title any more (the title says it)",
                !string("values", "mr_import_none_new").startsWith("Nothing") && !string("values-pt-rBR", "mr_import_none_new").startsWith("Nada") && !string("values-es", "mr_import_none_new").startsWith("Nada"));
        check("the note of the AI says only the numbers (en, pt-BR, es), with no text about checking or tapping",
                string("values", "mr_import_ai_done").equals("Formatted with AI: %1$d words and %2$d phrases")
                && string("values-pt-rBR", "mr_import_ai_done").equals("Formatado com IA: %1$d palavras e %2$d frases")
                && string("values-es", "mr_import_ai_done").equals("Formateado con IA: %1$d palabras y %2$d frases"));
        check("the preview is a dialog (AlertDialog with a scroll inside), not a part of the screen: the three numbers (MrKit.stat) and the check of the empty state in it; its icon exists",
                act.contains("new AlertDialog.Builder(this)") && act.contains(".setView(scroll)") && act.contains("k.stat(") && act.contains("k.emptyState(\"mr_ui_ic_check_mint\"")
                && !act.contains("col.addView(mPreview") && !act.contains("LinearLayout sum = k.panel();") && new File("res/drawable/mr_ui_ic_check_mint.xml").exists());
        check("the Add button is the positive button of the dialog and runs apply(); closing the dialog drops the plan; leaving the screen closes the dialog",
                act.contains("b.setPositiveButton(k.t(\"mr_import_apply_none\"), new DialogInterface.OnClickListener()") && act.contains("apply();") && act.contains("d.setOnDismissListener(")
                && act.contains("protected void onDestroy()") && act.contains("dismissPreview();"));
        check("the Format with AI button is not hidden by the empty box any more (no empty case in the offer)", !imp.contains("OFFER_NONE"));

        check("the button that takes the last addition back says \"addition\", with the number of items (en, pt-BR, es)",
                string("values", "mr_import_undo").equals("Undo the last addition (%1$d items)") && string("values-pt-rBR", "mr_import_undo").equals("Desfazer a última adição (%1$d itens)")
                && string("values-es", "mr_import_undo").equals("Deshacer la última adición (%1$d elementos)"));
        check("... and so do its question and its title (nothing says \"import\" any more)",
                string("values", "mr_import_undo_title").equals("Undo the last addition") && string("values-pt-rBR", "mr_import_undo_title").equals("Desfazer a última adição")
                && string("values-es", "mr_import_undo_title").equals("Deshacer la última adición")
                && !string("values", "mr_import_undo_ask").toLowerCase().contains("import") && !string("values-pt-rBR", "mr_import_undo_ask").toLowerCase().contains("importa")
                && !string("values-es", "mr_import_undo_ask").toLowerCase().contains("importa"));
        boolean noStale = true;
        for (String lang : LANGS) {
            String partial = string(lang, "mr_import_ai_partial"), cut = string(lang, "mr_import_ai_ask_cut");
            String all = (partial + " " + cut).toLowerCase();
            if (all.contains("undo") || all.contains("desfazer") || all.contains("deshacer") || all.contains("button below") || all.contains("botão abaixo") || all.contains("botón de abajo")) noStale = false;
        }
        check("the texts of a half formatted text and of a long text do not send the person to the Undo formatting that is gone, or to a button that is not there", noStale);

        String en = string("values", "mr_import_intro"), pt = string("values-pt-rBR", "mr_import_intro"), es = string("values-es", "mr_import_intro");
        check("the card of information does not say to open a file (3 languages)",
                !en.toLowerCase().contains("file") && !pt.toLowerCase().contains("arquivo") && !es.toLowerCase().contains("archivo"));
        check("... and keeps the rest of it (paste or type a list, nothing saved before the preview)",
                pt.startsWith("Ensine ao teclado nomes, gírias, lugares e frases. Cole um texto ou digite uma lista com uma palavra por linha. Nada é salvo antes de você ver a prévia.")
                && en.contains("Paste a text or type a list with one word per line.") && es.contains("Pega un texto o escribe una lista con una palabra por línea."));
        check("the note on a list for another language does not say \"file\" (3 languages)",
                !string("values", "mr_import_lang_note").contains("file") && !string("values-pt-rBR", "mr_import_lang_note").contains("arquivo")
                && !string("values-es", "mr_import_lang_note").contains("archivo"));
        check("the text inside the box says what to do: a word, or a text to add (3 languages)",
                string("values-pt-rBR", "mr_import_placeholder").equals("Digite uma palavra ou cole um texto que deseja adicionar")
                && string("values", "mr_import_placeholder").equals("Type a word or paste a text you want to add")
                && string("values-es", "mr_import_placeholder").equals("Escribe una palabra o pega un texto que quieras añadir"));
        check("the screen uses that text for the box", act.contains("k.field(k.t(\"mr_import_placeholder\")"));
    }

    // ---------------------------------------------------------------- the box does not grow without limit

    static void boxLimit() {
        Screen s = open(null);
        EditText box = box(s);
        check("the box has a minimum of 6 lines and a maximum of 12: from the 12th line it scrolls inside, it does not grow with the text",
                box.stubMinLines == MrImportActivity.TEXT_MIN_LINES && box.stubMaxLines == MrImportActivity.TEXT_MAX_LINES
                        && MrImportActivity.TEXT_MIN_LINES == 6 && MrImportActivity.TEXT_MAX_LINES == 12);
        check("... it shows a scroll bar", box.stubScrollBar);
        check("... and the page does not take the finger while the box can still scroll (a touch listener is set)", box.stubTouch != null);
    }

    public static void main(String[] args) {
        boxLimit();
        buttons();
        restored();
        afterTheAi();
        preview();
        previewPaging();
        gone();
        System.out.println();
        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAIL of " + (oks + fails));
        if (fails > 0) System.exit(1);
    }
}
