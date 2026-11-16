package com.mrkeyboard.app;

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
 * moment (none while it is empty, "Format with AI" for a text that is not a list yet, "See what will be added" once it is a list, whoever wrote it), and that
 * a preview does not outlive the text it was made from. The file that the screen no longer opens, the warning under the AI card and the texts of the
 * box are checked in the sources and in the three languages. What decides "is a list" is in ImportTest (MrImport.offer).
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

    /** Which of the two buttons under the box is on show: "none", "format", "preview" or "both" (never). */
    static String under(Screen s) {
        boolean format = shown(s, "mAiButton"), preview = shown(s, "mAnalyze");
        return format && preview ? "both" : format ? "format" : preview ? "preview" : "none";
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
        check("nothing in the box: no button under it", under(s).equals("none"));
        check("the buttons are the Format with AI one (wand) and the See what will be added one", text(s, "mAiButton").equals("mr_import_ai_button") && text(s, "mAnalyze").equals("mr_import_analyze"));

        type(s, "Itaú");
        check("a word typed alone is not a list: Format with AI appears, See what will be added does not", under(s).equals("format"));
        check("... and the counter follows", text(s, "mCount").equals("mr_import_count[4]"));
        type(s, "");
        check("the box emptied again: no button", under(s).equals("none"));
        type(s, "   \n  \n");
        check("only spaces and line breaks: no button", under(s).equals("none"));
        type(s, CHAT);
        check("a pasted chat is not a list: Format with AI", under(s).equals("format"));
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
        check("... with nothing: no button", under(s3).equals("none"));
    }

    // ---------------------------------------------------------------- the AI makes the list

    static void afterTheAi() {
        Screen s = open(null);
        type(s, CHAT);
        check("a chat in the box: Format with AI", under(s).equals("format"));
        MrImportAi.Result r = new MrImportAi.Result();
        r.parts = 1;
        r.done = 1;
        r.words = 2;
        r.phrases = 1;
        r.text = LIST;
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class, String.class}, r, CHAT);
        check("the AI answered with a list: the box holds it", box(s).getText().toString().equals(LIST));
        check("... and now it is See what will be added that shows, not Format with AI", under(s).equals("preview"));
        check("... with the note of what the AI made and the way back (Undo formatting)", shown(s, "mAiNote") && shown(s, "mAiUndo") && text(s, "mAiNote").equals("mr_import_ai_done[2, 1]"));
        check("... and no other button was added (the warning under the AI card is not a button, and there is no file button)", under(s).equals("preview"));
        call(s, "undoAi", new Class<?>[] {});
        check("Undo formatting brings the chat back: Format with AI again, and the note and the way back go", box(s).getText().toString().equals(CHAT) && under(s).equals("format")
                && !shown(s, "mAiNote") && !shown(s, "mAiUndo"));

        // an answer with nothing usable leaves the box as it was
        MrImportAi.Result empty = new MrImportAi.Result();
        empty.parts = 1;
        empty.failure = "";
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class, String.class}, empty, CHAT);
        check("an answer with nothing usable leaves the chat in the box and Format with AI under it", box(s).getText().toString().equals(CHAT) && under(s).equals("format"));

        // the person edits the list that the AI made: the way back goes (it would throw the edit away), the button stays the one of the text
        MrImportAi.Result ok = new MrImportAi.Result();
        ok.parts = 1;
        ok.done = 1;
        ok.words = 2;
        ok.phrases = 1;
        ok.text = LIST;
        call(s, "finishAi", new Class<?>[] {MrImportAi.Result.class, String.class}, ok, CHAT);
        type(s, LIST + "Santander\n");
        check("editing the list that the AI made: the way back goes, the button is still See what will be added", under(s).equals("preview") && !shown(s, "mAiUndo") && !shown(s, "mAiNote"));
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
        check("a preview is on show for the list", shown(s, "mPreview") && f(s, "mPlan") != null);
        type(s, LIST + "Santander\n");
        check("the person changes the text: the preview that was made from the old one is gone", !shown(s, "mPreview") && f(s, "mPlan") == null);
        // the preview is also gone when the text becomes something that is not a list
        set(s, "mPlan", plan);
        call(s, "showPreview", new Class<?>[] {});
        type(s, "Itaú");
        check("... and then the button is Format with AI and no preview is on show", under(s).equals("format") && !shown(s, "mPreview"));
        // a text that the screen sets by itself (the AI, Undo formatting) clears its preview by itself, the watcher does not need to
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
        check("the choice of the button is made by MrImport.offer", act.contains("MrImport.offer(") && act.contains("OFFER_FORMAT") && act.contains("OFFER_PREVIEW"));

        String[] dead = {"mr_import_open", "mr_import_reading", "mr_import_read_failed", "mr_import_file_empty", "mr_import_file_loaded", "mr_import_file_cut", "mr_import_ai_warn"};
        boolean none = true;
        for (String lang : LANGS) for (String key : dead) if (string(lang, key) != null) none = false;
        check("the texts of the file button, of the reading of a file and of the warning are gone from the three languages", none);
        boolean used = true;
        for (String key : dead) if (act.contains("\"" + key + "\"")) used = false;
        check("... and no code asks for them", used);

        String en = string("values", "mr_import_intro"), pt = string("values-pt-rBR", "mr_import_intro"), es = string("values-es", "mr_import_intro");
        check("the card of information does not say to open a file (3 languages)",
                !en.toLowerCase().contains("file") && !pt.toLowerCase().contains("arquivo") && !es.toLowerCase().contains("archivo"));
        check("... and keeps the rest of it (paste or type a list, nothing saved before the preview)",
                pt.equals("Ensine ao teclado nomes, gírias, lugares e frases. Cole um texto ou digite uma lista com uma palavra por linha. Nada é salvo antes de você ver a prévia.")
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

    public static void main(String[] args) {
        buttons();
        restored();
        afterTheAi();
        preview();
        gone();
        System.out.println();
        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAIL of " + (oks + fails));
        if (fails > 0) System.exit(1);
    }
}
