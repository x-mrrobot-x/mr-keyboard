package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Handler;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewPropertyAnimator;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

/**
 * The emoji search and delete in the panel (MrEmojiSearch, 1.97.0) with fake views: what showPanel asks of it (setup, onPanel,
 * afterPanel) and what comes out: the redirect and the field of the keyboard, the height of the header, what the buttons do,
 * what a tap on a result writes and where, the words read in the background and dropped, and a keyboard view made again.
 */
public class EmojiPanelTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final String HEART = "❤️";
    static final String GRIN = "😀";
    static final String EN = line(GRIN, "grinning face|face") + line(HEART, "red heart|heart");
    static final String PT = line(GRIN, "rosto sorrindo|rosto") + line(HEART, "coração vermelho|coração");
    static final String ES = line(GRIN, "cara sonriendo|cara") + line(HEART, "corazón rojo|corazón");
    static String line(String e, String body) { return e + "\t" + body + "\n"; }

    // ---- the fakes

    static class Res extends Resources {
        final HashMap<String, Integer> ids = new HashMap<String, Integer>();
        Configuration conf = new Configuration();
        int opened;
        Res(String lang) {
            ids.put("mr_emoji_en", 1); ids.put("mr_emoji_pt", 2); ids.put("mr_emoji_es", 3);
            ids.put("mr_es_height", 10); ids.put("mr_es_rows", 11);
            conf.locale = new Locale(lang);
        }
        public int getIdentifier(String name, String type, String pkg) { Integer i = ids.get(name); return i == null ? 0 : i.intValue(); }
        public float getDimension(int id) { return id == 10 ? 390f : 0f; }
        public int getInteger(int id) { return id == 11 ? 2 : 0; }
        public Configuration getConfiguration() { return conf; }
        public DisplayMetrics getDisplayMetrics() { DisplayMetrics d = new DisplayMetrics(); d.density = 2f; return d; }
        public InputStream openRawResource(int id) {
            opened++;
            try {
                return new ByteArrayInputStream((id == 1 ? EN : id == 2 ? PT : ES).getBytes("UTF-8"));
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    static class Ctx extends Context {
        final Res res;
        Ctx(Res r) { res = r; }
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

    /** The root of the toolbar: finds a view by its tag. */
    static class Root extends TextView {
        final HashMap<String, View> byTag = new HashMap<String, View>();
        Root(Context c) { super(c); }
        public View findViewWithTag(Object tag) { return byTag.get(tag); }
    }

    /** What the entrance of the header asked of the animator of the view. */
    static class Anim extends ViewPropertyAnimator {
        float alpha = -1f, scaleY = -1f;
        long duration;
        int starts, cancels;
        public ViewPropertyAnimator alpha(float v) { alpha = v; return this; }
        public ViewPropertyAnimator scaleY(float v) { scaleY = v; return this; }
        public ViewPropertyAnimator setDuration(long d) { duration = d; return this; }
        public void start() { starts++; }
        public void cancel() { cancels++; }
    }

    static class Bar extends View {
        ViewGroup.LayoutParams lp = new ViewGroup.LayoutParams(-1, 96);
        float alpha = 1f, scaleY = 1f, pivotY = -1f;
        final Anim anim = new Anim();
        public ViewGroup.LayoutParams getLayoutParams() { return lp; }
        public void setLayoutParams(ViewGroup.LayoutParams p) { lp = p; }
        public void setAlpha(float v) { alpha = v; }
        public void setScaleY(float v) { scaleY = v; }
        public void setPivotY(float v) { pivotY = v; }
        public ViewPropertyAnimator animate() { return anim; }
    }

    static class Field2 extends EditText {
        TextWatcher watcher;
        boolean boom;           // the test makes setText fail, as a bug in the search would
        int connections;
        final FakeIc ic = new FakeIc("field");
        Field2(Context c) { super(c); }
        public void addTextChangedListener(TextWatcher w) { watcher = w; }
        public void setText(CharSequence t) { if (boom) throw new IllegalStateException("boom"); super.setText(t); if (watcher != null) watcher.afterTextChanged(getText()); }
        public InputConnection onCreateInputConnection(EditorInfo e) { connections++; return ic; }
        void type(String s) { setText(s); }
    }

    static class Grid extends LinearLayout {
        Grid(Context c) { super(c); }
        final ArrayList<View> kids = new ArrayList<View>();
        public void addView(View v, ViewGroup.LayoutParams p) { kids.add(v); }
        public View getChildAt(int i) { return kids.get(i); }
        public int getChildCount() { return kids.size(); }
    }

    static class Btn extends View {
        View.OnClickListener click;
        View.OnTouchListener touch;
        float alpha = 1f;
        public void setOnClickListener(View.OnClickListener l) { click = l; }
        public void setOnTouchListener(View.OnTouchListener l) { touch = l; }
        public void setAlpha(float a) { alpha = a; }
    }

    static class FakeIc implements InputConnection {
        final String name;
        final StringBuilder log = new StringBuilder();
        FakeIc(String n) { name = n; }
        public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
        public CharSequence getSelectedText(int f) { return null; }
        public boolean commitText(CharSequence t, int c) { log.append("commit:").append(t).append(';'); return true; }
        public boolean deleteSurroundingText(int b, int a) { log.append("del;"); return true; }
        public boolean finishComposingText() { log.append("finish;"); return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }
    }

    static class Ime extends LatinIME {
        final FakeIc app = new FakeIc("app");
        final ArrayList<String> calls = new ArrayList<String>();
        public InputConnection getAppInputConnection() { return app; }
        public void mrCommit() { calls.add("mrCommit"); }
        public void onKey(int c, int[] k, int x, int y) { calls.add("key" + c); }
        public void onPress(int c) { calls.add("press" + c); }
        public void onRelease(int c) { calls.add("release" + c); }
        int count(String s) { int n = 0; for (String c : calls) if (c.equals(s)) n++; return n; }
    }

    static Object get(String name) throws Exception {
        Field f = MrEmojiSearch.class.getDeclaredField(name);
        f.setAccessible(true);
        return f.get(null);
    }

    static Handler handler() throws Exception { return (Handler) get("sHandler"); }

    @SuppressWarnings("unchecked")
    static ArrayList<TextView> cells() throws Exception { return (ArrayList<TextView>) get("sCells"); }

    /** The texts of the cells that are showing, in order. */
    static ArrayList<String> shown() throws Exception {
        ArrayList<String> out = new ArrayList<String>();
        for (TextView c : cells()) if (c.getVisibility() == View.VISIBLE) out.add(c.getText().toString());
        return out;
    }

    /** Runs what the background thread posted to the main thread, waiting for it (at most 5 seconds). */
    static void settle() throws Exception {
        Handler h = handler();
        long end = System.currentTimeMillis() + 5000;
        while (System.currentTimeMillis() < end) {
            h.stubRunPending();
            Thread.sleep(10);
            if (!((Boolean) isLoading()).booleanValue()) break;
        }
        h.stubRunPending();
    }

    static Object isLoading() throws Exception {
        Field f = MrEmojiSearch.class.getDeclaredField("sLoading");
        f.setAccessible(true);
        return f.get(null);
    }

    static class World {
        Res res; Ctx ctx; Root root; Bar bar, main; Field2 field; Grid grid; TextView empty; View scroll;
        Btn search, del; TextView back; Ime ime; TextView translatorField;
    }

    static World build(String lang) {
        World w = new World();
        w.res = new Res(lang);
        w.ctx = new Ctx(w.res);
        w.root = new Root(w.ctx);
        w.bar = new Bar();
        w.main = new Bar();
        w.field = new Field2(w.ctx);
        w.grid = new Grid(w.ctx);
        w.empty = new TextView(w.ctx);
        w.scroll = new View();
        w.search = new Btn();
        w.del = new Btn();
        w.back = new TextView(w.ctx);
        w.root.byTag.put("bar_es", w.bar);
        w.root.byTag.put("bar_main", w.main);
        w.root.byTag.put("es_field", w.field);
        w.root.byTag.put("es_grid", w.grid);
        w.root.byTag.put("es_scroll", w.scroll);
        w.root.byTag.put("es_empty", w.empty);
        w.root.byTag.put("es_back", w.back);
        w.root.byTag.put("emote_search", w.search);
        w.root.byTag.put("emote_del", w.del);
        w.ime = new Ime();
        MrTools.sIme = w.ime;
        MrTools.sKbd = new View();
        w.translatorField = new TextView(w.ctx);
        MrTools.sField = w.translatorField;
        MrTools.sRedirect = null;
        MrEmotes.sRecent = new ArrayList<String>();
        MrEmojiSearch.setup(w.root);
        return w;
    }

    /** What MrTools.showPanel does around the search for a panel mode. */
    static void panel(int mode) {
        MrEmojiSearch.onPanel(mode);
        MrEmojiSearch.afterPanel(mode);
    }

    static MotionEvent ev(int action) { return MotionEvent.obtain(action, 0f, 0f); }

    public static void main(String[] a) throws Exception {
        // ---- setup
        World w = build("pt");
        check("setup: the header starts hidden", w.bar.getVisibility() == View.GONE);
        check("setup: two rows for the results (resource mr_es_rows)", w.grid.getChildCount() == 2);
        check("setup: the field is watched (a text change searches)", w.field.watcher != null);
        MrEmojiSearch.setup(null);
        check("setup with no root: nothing breaks", get("sBar") == null);
        w = build("pt");

        // ---- opening the search
        panel(4);
        check("the emoji panel (mode 4) does not open the search", w.bar.getVisibility() == View.GONE && MrTools.sRedirect == null);
        w.search.click.onClick(w.search);   // showPanel is a stub here: the click asks for the mode, the test plays showPanel
        panel(MrEmojiSearch.MODE);
        check("open: the header shows", w.bar.getVisibility() == View.VISIBLE);
        check("open: the header is taller (the height of mr_es_height: 390 px)", w.bar.lp.height == 195 * 2 && MrBar.expanded(w.bar));
        check("open: the header starts transparent and short, and grows from its bottom edge (pivot = its height)",
                w.bar.alpha == 0f && w.bar.scaleY == MrEmojiSearch.ENTER_FROM && w.bar.pivotY == 390f);
        check("open: the entrance runs to full opacity and size in ENTER_MS, started once",
                w.bar.anim.alpha == 1f && w.bar.anim.scaleY == 1f && w.bar.anim.duration == MrEmojiSearch.ENTER_MS && w.bar.anim.starts == 1);
        check("open: a running entrance was cancelled before the new one", w.bar.anim.cancels == 1);
        check("open: the keyboard types in the field of the header (redirect)", MrTools.sRedirect == w.field.ic && w.field.connections == 1);
        check("open: the keys that are events go to the field too", MrTools.sField == w.field);
        check("open: the word being typed in the app was committed before the change", w.ime.count("mrCommit") == 1);
        check("open: the main bar is hidden and the keyboard shows", w.main.getVisibility() == View.GONE && MrTools.sKbd.getVisibility() == View.VISIBLE);
        check("open: the field has the focus", w.field.hasFocus());
        panel(MrEmojiSearch.MODE);
        check("asking for the mode again does not open it twice", w.field.connections == 1 && w.ime.count("mrCommit") == 1);

        // ---- the words load in the background
        settle();
        check("the three files were read once", w.res.opened == 3);
        w.field.type("heart");
        check("typing 'heart': the heart shows, nothing else", shown().size() == 1 && shown().get(0).equals(HEART));
        check("no empty message while there are results", w.empty.getVisibility() == View.GONE);
        w.field.type("coração");
        check("typing in Portuguese: the same heart", shown().size() == 1 && shown().get(0).equals(HEART));
        w.field.type("zzzz");
        check("nothing found: the cells are hidden and the message shows", shown().isEmpty() && w.empty.getVisibility() == View.VISIBLE);
        w.field.type("");
        check("text cleared: the message goes and the recents come back", w.empty.getVisibility() == View.GONE);
        MrEmotes.sRecent.add(GRIN);
        w.field.type("");
        check("with a recent emoji: it is what shows while the field is empty", shown().size() == 1 && shown().get(0).equals(GRIN));
        w.field.type("face");
        check("typing 'face': the grin (English word, app in Portuguese)", shown().size() == 1 && shown().get(0).equals(GRIN));

        // ---- a tap on a result: written in the app, the search stays open
        TextView cell = cells().get(0);
        w.ime.app.log.setLength(0);
        w.field.ic.log.setLength(0);
        ((View.OnClickListener) get("sPick")).onClick(cell);
        check("tap on a result: written in the app, not in the field of the search", w.ime.app.log.toString().equals("finish;commit:" + GRIN + ";") && w.field.ic.log.length() == 0);
        check("tap on a result: it goes to the recents of the panel", MrEmotes.sRecent.size() > 0);
        check("tap on a result: the search stays open with the same text", w.bar.getVisibility() == View.VISIBLE && MrTools.sRedirect == w.field.ic);

        // ---- the delete button
        w.ime.calls.clear();
        w.del.touch.onTouch(w.del, ev(MotionEvent.ACTION_DOWN));
        check("delete, press: the feedback of the key, then the Backspace code", w.ime.calls.equals(java.util.Arrays.asList("press-5", "key-5")));
        check("delete, press: the button dims", w.del.alpha < 1f);
        check("delete, press: the repeat is armed after the pause of the key", handler().stubPending() == 1);
        handler().stubRunOnce();
        check("delete, held: one more Backspace each time the repeat runs", w.ime.count("key-5") == 2);
        check("delete, held: and it asks for the next one", handler().stubPending() == 1);
        w.del.touch.onTouch(w.del, ev(MotionEvent.ACTION_UP));
        check("delete, release: stops, the key is released, the button is back", handler().stubPending() == 0 && w.ime.count("release-5") == 1 && w.del.alpha == 1f);
        w.del.touch.onTouch(w.del, ev(MotionEvent.ACTION_DOWN));
        w.del.touch.onTouch(w.del, ev(MotionEvent.ACTION_CANCEL));
        check("delete, cancel: stops like a release", handler().stubPending() == 0 && w.ime.count("release-5") == 2);
        int before = w.ime.count("key-5");
        w.del.click.onClick(w.del);
        check("delete by an assistive click (no touch): one Backspace", w.ime.count("key-5") == before + 1);

        // ---- back to the emoji panel
        int commitsBefore = w.ime.count("mrCommit");
        panel(4);
        check("back: the header goes", w.bar.getVisibility() == View.GONE);
        check("back: the height goes back to what it was", w.bar.lp.height == 96 && !MrBar.expanded(w.bar));
        check("back: the entrance is ended and the header is left as the layout made it (opaque, full size)",
                w.bar.anim.cancels == 2 && w.bar.alpha == 1f && w.bar.scaleY == 1f);
        check("back: the keyboard types in the app again", MrTools.sRedirect == null && MrTools.sField == w.translatorField);
        check("back: the field is empty for the next time", w.field.getText().length() == 0);
        check("back: the word typed in the field of the search was committed (as leaving the translator does)", w.ime.count("mrCommit") == commitsBefore + 1);
        check("back: the words stay in memory while the emoji panel is open", get("sIndex") != null);
        panel(MrEmojiSearch.MODE);
        check("open again: no new reading of the files", w.res.opened == 3 && w.field.connections == 2);
        w.field.type("heart");
        check("open again: the search works at once", shown().size() == 1 && shown().get(0).equals(HEART));

        // ---- leaving the emoji panel drops the words
        panel(0);
        check("to the keyboard (mode 0): the search closes", w.bar.getVisibility() == View.GONE && MrTools.sRedirect == null && w.bar.lp.height == 96);
        check("to the keyboard: the words are dropped from memory", get("sIndex") == null);
        panel(4);
        panel(MrEmojiSearch.MODE);
        settle();
        check("opening the search again after that reads the files again", w.res.opened == 6);
        panel(1);
        check("to another panel (clipboard): the search closes and the words go", MrTools.sRedirect == null && get("sIndex") == null && w.bar.getVisibility() == View.GONE);

        // ---- the app language wins a tie; a late arrival of the words
        World es = build("es");
        panel(4);
        panel(MrEmojiSearch.MODE);
        es.field.type("heart");
        check("before the words arrive: the message of 'not found' is not shown", es.empty.getVisibility() == View.GONE && shown().isEmpty());
        settle();
        check("when the words arrive the results come without another key", shown().size() == 1 && shown().get(0).equals(HEART));
        panel(0);

        // ---- the words arrive after the panel was left: they are thrown away
        World late = build("en");
        panel(4);
        panel(MrEmojiSearch.MODE);
        panel(0);
        settle();
        check("words that arrive after leaving the panel are not kept", get("sIndex") == null);

        // ---- the keyboard view is made again while the search is open (rotation, theme)
        World re = build("en");
        panel(4);
        panel(MrEmojiSearch.MODE);
        MrTools.sRedirect = null;   // MrTools.wrap clears the redirect and makes the translator field again
        World re2 = build("en");
        check("a new keyboard view: the search starts closed, and nothing of the old one is left", re2.bar.getVisibility() == View.GONE && !MrBar.expanded(re2.bar) && get("sOpen").equals(Boolean.FALSE));
        panel(4);
        panel(MrEmojiSearch.MODE);
        check("and it opens on the new view", re2.bar.getVisibility() == View.VISIBLE && MrTools.sRedirect == re2.field.ic);
        panel(0);

        // ---- a layout without the header (an old layout): the hooks do nothing
        World bare = build("en");
        Root nobar = new Root(bare.ctx);
        MrEmojiSearch.setup(nobar);
        panel(MrEmojiSearch.MODE);
        panel(4);
        panel(0);
        check("no header in the layout: the hooks do nothing and do not break", MrTools.sRedirect == null);

        // ---- an error inside the search never reaches the keyboard (setup runs while the keyboard is made, onPanel when a field is bound)
        Root broken = new Root(build("en").ctx) {
            public View findViewWithTag(Object tag) { throw new IllegalStateException("boom"); }
        };
        boolean escaped = false;
        try {
            MrEmojiSearch.setup(broken);
        } catch (Throwable t) {
            escaped = true;
        }
        check("setup that fails: nothing escapes, the keyboard starts without the search", !escaped && get("sBar") == null && get("sCtx") == null);
        World bad = build("en");
        panel(4);
        bad.field.boom = true;
        escaped = false;
        try {
            panel(MrEmojiSearch.MODE);
        } catch (Throwable t) {
            escaped = true;
        }
        check("opening that fails: nothing escapes", !escaped);
        check("opening that fails: the keyboard types in the app again and the header is closed",
                MrTools.sRedirect == null && MrTools.sField == bad.translatorField && bad.bar.getVisibility() == View.GONE && !MrBar.expanded(bad.bar));
        check("opening that fails: the search is forgotten (it does not act on later hooks)", get("sBar") == null && get("sOpen").equals(Boolean.FALSE));
        panel(4);
        panel(0);

        // ---- the service is destroyed with the search open and the delete button held (MrTools.release calls setup with no root)
        World gone = build("en");
        panel(4);
        panel(MrEmojiSearch.MODE);
        settle();
        gone.del.touch.onTouch(gone.del, ev(MotionEvent.ACTION_DOWN));
        Handler hg = handler();
        check("destroy: the repeat of the delete button is armed before", hg.stubPending() == 1 && get("sBar") != null && get("sCtx") != null);
        MrEmojiSearch.setup(null);
        check("destroy: the repeat is stopped (it would run for ever on a handler of a dead service)", hg.stubPending() == 0);
        check("destroy: the views, the context and the words are let go, the search is closed",
                get("sBar") == null && get("sField") == null && get("sCtx") == null && get("sHandler") == null && get("sIndex") == null
                && get("sOpen").equals(Boolean.FALSE));
        MrTools.sRedirect = null;   // MrTools.release clears the redirect itself, before it calls setup
        panel(MrEmojiSearch.MODE);
        panel(4);
        check("destroy: the hooks that still come do nothing (the search does not open on a view that is gone)", MrTools.sRedirect == null);

        System.out.println("\n" + ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
