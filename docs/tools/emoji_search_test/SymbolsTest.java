package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.TextView;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

/**
 * The symbols of the emoji panel (MrSymbols, 2.0.0): the data (eight categories of single code points, none twice, the ones of the
 * reference pictures among them, nothing that the font of the phone cannot draw), the swap between the emojis and the symbols (the two
 * buttons, the tabs with a symbol in place of the icon, the list built again), the recent symbols (their own list, 24 at most, saved,
 * a long press removes), the names of the tabs, the way back to the emojis when the panel is left, and the hooks in the smali of
 * the panel.
 */
public class SymbolsTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final String NAMES_PT = "Recentes|Estrelas e flores|Corações e rostos|Setas e mãos|Matemática e números|Música e natureza|Formas e linhas|Animais e jogos|Moedas e sinais";

    // ---- the fakes

    static class Res extends Resources {
        boolean hasNames = true;
        public int getIdentifier(String name, String type, String pkg) { return name.equals("mr_sym_cats") && hasNames ? 7 : 0; }
        public String getString(int id) { return id == 7 ? NAMES_PT : null; }
    }

    static class Ctx extends Context {
        final Res res = new Res();
        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String n, int m) { return null; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }
    }

    static class Mem implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();
        int saves;
        public Map<String, ?> getAll() { return m; }
        public String getString(String key, String def) { return m.containsKey(key) ? (String) m.get(key) : def; }
        public int getInt(String key, int def) { return def; }
        public long getLong(String key, long def) { return def; }
        public boolean getBoolean(String key, boolean def) { return def; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String key, String v) { m.put(key, v); saves++; return this; }
                public Editor putInt(String key, int v) { m.put(key, v); return this; }
                public Editor putLong(String key, long v) { m.put(key, v); return this; }
                public Editor putBoolean(String key, boolean v) { m.put(key, v); return this; }
                public Editor remove(String key) { m.remove(key); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
    }

    static class Btn extends TextView {
        View.OnClickListener click;
        Btn(Context c) { super(c); }
        public void setOnClickListener(View.OnClickListener l) { click = l; }
    }

    static class Root extends TextView {
        final HashMap<String, View> byTag = new HashMap<String, View>();
        Root(Context c) { super(c); }
        public View findViewWithTag(Object tag) { return byTag.get(tag); }
    }

    static final Drawable[] ICONS = new Drawable[9];

    /** The nine category tabs of the panel, each with the icon of its category. */
    static TextView[] tabs(Context c) {
        TextView[] t = new TextView[9];
        for (int i = 0; i < t.length; i++) {
            t[i] = new TextView(c);
            ICONS[i] = new Drawable() { };
            t[i].setCompoundDrawables(ICONS[i], null, null, null);
        }
        return t;
    }

    static String text(TextView t) { return t.getText() == null ? "" : t.getText().toString(); }

    static String[] cells(String joined) { return joined.length() == 0 ? new String[0] : joined.split("[|]"); }

    static boolean has(String joined, String symbol) {
        for (String s : cells(joined)) if (s.equals(symbol)) return true;
        return false;
    }

    public static void main(String[] a) throws Exception {
        Ctx ctx = new Ctx();
        MrTools.sApp = ctx;
        Mem prefs = new Mem();
        PreferenceManager.stubDefault = prefs;
        Paint.stubNoGlyph.clear();

        // ---- the data
        check("data: eight categories, one tab symbol for each", MrSymbols.SETS.length == MrSymbols.CATS && MrSymbols.CATS == 8 && MrSymbols.TAB.length == 8);
        HashSet<Integer> seen = new HashSet<Integer>();
        boolean single = true, twice = false, empty = false;
        int total = 0;
        for (String set : MrSymbols.SETS) {
            if (set.length() == 0) empty = true;
            for (int i = 0; i < set.length(); ) {
                int cp = set.codePointAt(i);
                i += Character.charCount(cp);
                total++;
                if (!seen.add(cp)) twice = true;
                if (Character.isWhitespace(cp) || Character.isISOControl(cp) || Character.getType(cp) == Character.NON_SPACING_MARK
                        || Character.getType(cp) == Character.SURROGATE || Character.getType(cp) == Character.UNASSIGNED) single = false;
            }
        }
        check("data: no empty category and a good number of symbols (" + total + ")", !empty && total > 900);
        check("data: every one is a printable code point of its own (no space, control, mark, surrogate or hole)", single);
        check("data: no symbol in two categories", !twice);
        boolean all = true;
        for (String set : MrSymbols.SETS) if (set.length() < 40) all = false;
        check("data: every category has at least 40 symbols", all);

        // the symbols of the reference pictures
        String pics = "☯♪☘☁✌☜☝☞☟✍☕✈☮⚠☂☔⌨⌫★☆✿❀❄♡♥☺☻☹☠✝✔☎♔♕⚢⚣⚤⚥⚦웃ツッ";
        boolean allPics = true;
        StringBuilder missing = new StringBuilder();
        for (int i = 0; i < pics.length(); i++) {
            boolean found = false;
            for (String set : MrSymbols.SETS) if (set.indexOf(pics.charAt(i)) >= 0) found = true;
            if (!found) { allPics = false; missing.append(Integer.toHexString(pics.charAt(i))).append(' '); }
        }
        check("data: the symbols of the reference pictures are all there " + missing, allPics);
        check("data: the Egyptian hieroglyph animals of the picture are in the animals category (the owl G017, the eye of Horus)",
                MrSymbols.SETS[6].indexOf("𓅓") >= 0 && MrSymbols.SETS[6].indexOf("𓂀") >= 0);
        check("data: arrows have the whole Arrows block", MrSymbols.SETS[2].indexOf('←') >= 0 && MrSymbols.SETS[2].indexOf('⇿') >= 0);

        File src = new File("docs/tools/java/src/com/mrkeyboard/app/MrSymbols.java");
        if (src.exists()) {
            byte[] b = Files.readAllBytes(src.toPath());
            boolean ascii = true;
            for (byte x : b) if (x < 0) ascii = false;
            check("source: MrSymbols.java is ASCII (the symbols are \\u escapes, whatever the encoding of the compiler)", ascii);
        }

        // ---- off: the panel is the one of the emojis
        check("off: the symbols are not on", !MrSymbols.on());
        check("off: the rows are the ones of the emoji panel", MrSymbols.rows(3).equals(MrEmotes.data(3)));
        check("off: names and recents are given back as they came", MrSymbols.names("a|b").equals("a|b") && MrSymbols.recent("x|y").equals("x|y"));
        MrSymbols.addRecent("★");
        check("off: a tap does not touch the recent symbols", !prefs.m.containsKey(MrSymbols.PREF_RECENT) && prefs.saves == 0);

        // ---- setup and the two buttons
        Root root = new Root(ctx);
        Btn sym = new Btn(ctx), emo = new Btn(ctx);
        root.byTag.put("emote_sym", sym);
        root.byTag.put("emote_emo", emo);
        emo.setVisibility(View.GONE);
        TextView[] t = tabs(ctx);
        MrEmotes.sTabs = t;
        MrSymbols.setup(root);
        check("setup: the symbols button shows and the emoji button is hidden", sym.getVisibility() == View.VISIBLE && emo.getVisibility() == View.GONE);
        check("setup: both buttons swap", sym.click != null && emo.click != null);
        MrSymbols.setup(new Root(ctx));
        check("setup: a root without the buttons breaks nothing", !MrSymbols.on());
        MrSymbols.setup(null);
        check("setup: no root lets everything go", !MrSymbols.on());
        MrSymbols.setup(root);

        // ---- to the symbols
        int before = MrEmotes.stubRefreshes;
        sym.click.onClick(sym);
        check("on: the symbols are on", MrSymbols.on());
        check("on: the buttons trade places", sym.getVisibility() == View.GONE && emo.getVisibility() == View.VISIBLE);
        check("on: the list is built again, once", MrEmotes.stubRefreshes == before + 1);
        boolean glyphs = text(t[0]).length() == 0 && t[0].getCompoundDrawables()[0] == ICONS[0];
        boolean tabsOk = true;
        for (int i = 1; i < 9; i++) {
            if (!text(t[i]).equals(MrSymbols.TAB[i - 1]) || t[i].getCompoundDrawables()[0] != null) tabsOk = false;
        }
        check("on: the recent tab keeps its clock", glyphs);
        check("on: the other eight tabs show a symbol of their category in place of the icon", tabsOk);
        String stars = MrSymbols.rows(0);
        check("on: the rows are the symbols of the category, one by one", cells(stars).length > 40 && has(stars, "★") && has(stars, "✿"));
        check("on: a category has the symbols of its own (arrows, not stars)", has(MrSymbols.rows(2), "➜") && !has(MrSymbols.rows(2), "★"));
        check("on: a category out of range is empty", MrSymbols.rows(8).length() == 0 && MrSymbols.rows(-1).length() == 0);
        check("on: the tabs are named by the symbols, in the language of the app", MrSymbols.names("emoji names").equals(NAMES_PT));
        ctx.res.hasNames = false;
        check("on: without the names the emoji ones stay (nothing breaks)", MrSymbols.names("emoji names").equals("emoji names"));
        ctx.res.hasNames = true;

        // ---- recents of the symbols
        String r = MrSymbols.recent("emoji recents");
        check("recent: before any tap, a list of the usual ones, not the emoji recents", !r.equals("emoji recents") && r.startsWith("★|♥"));
        MrSymbols.addRecent("♣");
        MrSymbols.addRecent("★");
        check("recent: a tapped symbol goes to the front, once", MrSymbols.recent("").startsWith("★|♣|♥") && MrSymbols.recent("").split("[|]").length == MrSymbols.RECENT_DEFAULT.split("[|]").length + 1);
        check("recent: it is saved in its own preference, apart from the emoji recents", prefs.m.containsKey(MrSymbols.PREF_RECENT) && !prefs.m.containsKey("emote_recent"));
        for (int i = 0; i < 40; i++) MrSymbols.addRecent(new String(Character.toChars(0x2660 + i)));
        check("recent: 24 at most, the oldest go first", MrSymbols.recent("").split("[|]").length == MrSymbols.RECENT_MAX
                && MrSymbols.recent("").startsWith(new String(Character.toChars(0x2660 + 39))));
        int refreshes = MrEmotes.stubRefreshes;
        String last = new String(Character.toChars(0x2660 + 39));
        check("recent: a long press removes the symbol, saves, and builds the list again", MrSymbols.forget(last)
                && !has(MrSymbols.recent(""), last) && !((String) prefs.m.get(MrSymbols.PREF_RECENT)).contains(last) && MrEmotes.stubRefreshes == refreshes + 1);
        check("recent: a symbol that is not there is left alone (no list built again)", !MrSymbols.forget("⭐") && MrEmotes.stubRefreshes == refreshes + 1);
        prefs.m.put(MrSymbols.PREF_RECENT, "★|♥|★||☺");
        MrSymbols.setup(root);
        sym.click.onClick(sym);
        check("recent: read back from the preference (no blanks, no copies)", MrSymbols.recent("").equals("★|♥|☺"));

        // ---- the way back
        refreshes = MrEmotes.stubRefreshes;
        emo.click.onClick(emo);
        check("off again: the emoji button swaps back", !MrSymbols.on() && sym.getVisibility() == View.VISIBLE && emo.getVisibility() == View.GONE);
        boolean back = true;
        for (int i = 0; i < 9; i++) {
            if (text(t[i]).length() != 0 || t[i].getCompoundDrawables()[0] != ICONS[i]) back = false;
        }
        check("off again: the tabs have their icons back, and no text", back);
        check("off again: the list is built again", MrEmotes.stubRefreshes == refreshes + 1);
        check("off again: the rows are the emoji ones", MrSymbols.rows(1).equals(MrEmotes.data(1)));
        refreshes = MrEmotes.stubRefreshes;
        MrSymbols.leave();
        check("leave with the emojis on: nothing happens", MrEmotes.stubRefreshes == refreshes && !MrSymbols.on());
        sym.click.onClick(sym);
        MrSymbols.leave();
        check("leave with the symbols on: back to the emojis (the search opens, the panel is left)", !MrSymbols.on() && sym.getVisibility() == View.VISIBLE);
        sym.click.onClick(sym);
        MrSymbols.setup(root);
        check("a keyboard view made again: the emojis, the buttons as at the start", !MrSymbols.on() && sym.getVisibility() == View.VISIBLE && emo.getVisibility() == View.GONE);

        // ---- the panel not built, or built another way
        MrEmotes.sTabs = null;
        sym.click.onClick(sym);
        check("no tabs yet: the swap still works", MrSymbols.on());
        emo.click.onClick(emo);
        MrEmotes.sTabs = new TextView[3];
        sym.click.onClick(sym);
        emo.click.onClick(emo);
        check("tabs of another count are left alone", !MrSymbols.on());
        MrEmotes.sTabs = t;

        // ---- what the font of the phone cannot draw
        Paint.stubNoGlyph.add("★");
        Paint.stubNoGlyph.add("𓅓");
        MrSymbols.setup(root);
        String out = MrSymbols.drawable(MrSymbols.SETS[0] + MrSymbols.SETS[6].substring(0, 4));
        check("font: a symbol the font lacks is left out, a sequence of the surrogate pair is asked whole", !has(out, "★") && has(out, "☆"));
        int calls = Paint.stubGlyphCalls;
        MrSymbols.setup(root);
        sym.click.onClick(sym);
        String first = MrSymbols.rows(6);
        int after = Paint.stubGlyphCalls;
        String second = MrSymbols.rows(6);
        check("font: the owl the font lacks is not in the animals", !has(first, "𓅓") && has(first, "𓂀"));
        check("font: asked once per category, then kept", after > calls && Paint.stubGlyphCalls == after && first.equals(second));
        sym.click.onClick(emo);
        Paint.stubNoGlyph.clear();

        // ---- the hooks in the smali of the panel
        File smali = new File("smali/com/mrkeyboard/app/MrEmotes.smali");
        if (smali.exists()) {
            String s = new String(Files.readAllBytes(smali.toPath()), "UTF-8");
            check("smali: the rows of a category come from MrSymbols", s.contains("MrSymbols;->rows(I)Ljava/lang/String;"));
            check("smali: the names of the tabs come from MrSymbols", s.contains("MrSymbols;->names(Ljava/lang/String;)Ljava/lang/String;"));
            check("smali: the recents come from MrSymbols", s.contains("MrSymbols;->recent(Ljava/lang/String;)Ljava/lang/String;"));
            check("smali: a tap goes to the recents of what is showing (MrSymbols), not straight to the emoji ones", s.contains("MrSymbols;->addRecent(Ljava/lang/String;)V") && !s.contains("invoke-static {v0}, Lcom/mrkeyboard/app/MrEmotes;->addRecent") && !java.util.regex.Pattern.compile("invoke-static \\{[^}]*\\}, Lcom/mrkeyboard/app/MrEmotes;->addRecent").matcher(s).find());
            check("smali: a long press asks MrSymbols first", s.contains("MrSymbols;->on()Z") && s.contains("MrSymbols;->forget(Ljava/lang/String;)Z"));
            int build = s.indexOf(".method static build()");
            int end = s.indexOf(".end method", build);
            check("smali: build() no longer reads the emoji table itself", build > 0 && !s.substring(build, end).contains("MrEmotes;->data(I)"));
        } else {
            System.out.println("SKIP  smali hooks (run at the project root)");
        }

        System.out.println(ok + " ok, " + fail + " fail");
        if (fail > 0) System.exit(1);
    }
}
