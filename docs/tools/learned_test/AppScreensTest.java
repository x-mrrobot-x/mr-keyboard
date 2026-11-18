package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ScrollView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * PC test of the screens of the words for one app: the list of apps (MrAppList: no system apps, one from the store that updated a system app stays, search without
 * accents), the dialog that chooses an app (MrAppPicker), the choice on "Add words and texts" (MrImportActivity: what is saved, the note, the undo) and the one on "What the
 * keyboard learned" (MrLearnedActivity: the apps that have words, the list and the count of one app, no Block there, forget, export). Also the strings in three languages,
 * the manifest and the hooks in smali. Run against the stubs of Android through docs/tools/run_java_tests.sh.
 */
public class AppScreensTest {
    static int ok = 0, fail = 0;
    static final String L = "pt_BR";

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    // ---------------------------------------------------------------- a phone with apps

    /** How many names were asked of the system (the slow pass). */
    static int labelCalls;

    static ResolveInfo app(final String pkg, final String label, int flags) {
        ResolveInfo ri = new ResolveInfo() {
            public CharSequence loadLabel(PackageManager pm) {
                labelCalls++;
                if (label == null) throw new RuntimeException("no label");
                return label;
            }
        };
        ri.activityInfo = new ActivityInfo();
        ri.activityInfo.packageName = pkg;
        ri.activityInfo.applicationInfo = new ApplicationInfo();
        ri.activityInfo.applicationInfo.packageName = pkg;
        ri.activityInfo.applicationInfo.flags = flags;
        return ri;
    }

    static final class Phone extends PackageManager {
        final List<ResolveInfo> apps = new ArrayList<ResolveInfo>();
        boolean failing;

        public android.content.pm.PackageInfo getPackageInfo(String packageName, int flags) throws NameNotFoundException { throw new NameNotFoundException(); }

        public List<ResolveInfo> queryIntentActivities(android.content.Intent intent, int flags) {
            if (failing) throw new RuntimeException("the system is busy");
            return apps;
        }

        ApplicationInfo find(String pkg) {
            for (ResolveInfo r : apps) if (pkg.equals(r.activityInfo.packageName)) return r.activityInfo.applicationInfo;
            return null;
        }

        public ApplicationInfo getApplicationInfo(String packageName, int flags) throws NameNotFoundException {
            ApplicationInfo a = find(packageName);
            if (a == null) throw new NameNotFoundException();
            return a;
        }

        public CharSequence getApplicationLabel(ApplicationInfo info) {
            for (ResolveInfo r : apps) if (r.activityInfo.applicationInfo == info) return r.loadLabel(this);
            return info.packageName;
        }
    }

    static Phone phone() {
        Phone p = new Phone();
        p.apps.add(app("com.whatsapp", "WhatsApp", 0));
        p.apps.add(app("com.android.settings", "Configurações", ApplicationInfo.FLAG_SYSTEM));
        p.apps.add(app("com.android.chrome", "Chrome", ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP));
        p.apps.add(app("com.itau.app", "Itaú", 0));
        p.apps.add(app("com.whatsapp", "WhatsApp (de novo)", 0));          // a second launcher activity of the same app
        p.apps.add(app("com.alvaro.album", "Álbum", 0));
        p.apps.add(app("com.nolabel.app", "  ", 0));
        p.apps.add(app("com.broken.label", null, 0));
        p.apps.add(app("bad package", "Ruim", 0));
        p.apps.add(app(null, "Sem pacote", 0));
        p.apps.add(null);
        return p;
    }

    /** The screen of the other test, with a phone and with runOnUiThread that runs at once (the stub does nothing). */
    static class Screen extends ImportScreenTest.Screen {
        Phone pm = phone();

        public android.content.pm.PackageManager getPackageManager() { return pm; }
        public void runOnUiThread(Runnable r) { r.run(); }
    }

    static Context ctxOf(final PackageManager fake) {
        return new Screen() {
            public android.content.pm.PackageManager getPackageManager() { return fake; }
        };
    }

    static List<String> names(List<MrAppList.Entry> l) {
        ArrayList<String> out = new ArrayList<String>();
        for (MrAppList.Entry e : l) out.add(e.pkg + "=" + e.label);
        return out;
    }

    // ---------------------------------------------------------------- the list of apps

    static void list() {
        check("an app of the system is left out", !MrAppList.isUserApp(ApplicationInfo.FLAG_SYSTEM) && MrAppList.isUserApp(0));
        check("... unless it was updated from a store (it is then an app the person keeps up to date and types in)", MrAppList.isUserApp(ApplicationInfo.FLAG_SYSTEM | ApplicationInfo.FLAG_UPDATED_SYSTEM_APP));
        Phone p = phone();
        List<MrAppList.Entry> all = MrAppList.load(ctxOf(p));
        List<String> n = names(all);
        check("the list has the apps with a launcher icon that are not the system's, plus the updated one: " + n,
                n.contains("com.whatsapp=WhatsApp") && n.contains("com.itau.app=Itaú") && n.contains("com.android.chrome=Chrome") && n.contains("com.alvaro.album=Álbum")
                && !n.toString().contains("settings"));
        check("an app with two launcher activities is one row", countPkg(all, "com.whatsapp") == 1);
        check("a name that is empty or cannot be read is the package", n.contains("com.nolabel.app=com.nolabel.app") && n.contains("com.broken.label=com.broken.label"));
        check("a package that is not a package name (a bar, a space, null) and a null entry are not apps of the list", !n.toString().contains("bad package") && !n.toString().contains("Sem pacote") && all.size() == 6);
        check("the list is sorted by name, accents and case ignored (Álbum before Chrome and Itaú)", all.get(0).label.equals("Álbum") && indexOf(all, "com.android.chrome") < indexOf(all, "com.itau.app"));
        Phone empty = new Phone();
        check("a phone with no apps gives an empty list", MrAppList.load(ctxOf(empty)).isEmpty());
        Phone bad = phone();
        bad.failing = true;
        check("the system failing gives an empty list, not an exception", MrAppList.load(ctxOf(bad)).isEmpty());
        check("no context and no package manager give an empty list", MrAppList.load(null).isEmpty() && MrAppList.load(ctxOf(null)).isEmpty());

        check("an empty search gives every app", MrAppList.filter(all, "").size() == all.size() && MrAppList.filter(all, null).size() == all.size() && MrAppList.filter(all, "   ").size() == all.size());
        check("the search ignores accents and case (itau finds Itaú, ALBUM finds Álbum)", names(MrAppList.filter(all, "itau")).equals(java.util.Arrays.asList("com.itau.app=Itaú"))
                && MrAppList.filter(all, "ALBUM").size() == 1);
        check("... looks in the package too (whats)", names(MrAppList.filter(all, "whats")).equals(java.util.Arrays.asList("com.whatsapp=WhatsApp")));
        check("... every word of it has to match, in any order", MrAppList.filter(all, "app itau").size() == 1 && MrAppList.filter(all, "itau whatsapp").isEmpty());
        check("... and nothing that matches is an empty list", MrAppList.filter(all, "zzz").isEmpty());

        Context c = ctxOf(p);
        check("the name of an app by its package; an app that is gone is the package", MrAppList.label(c, "com.itau.app").equals("Itaú") && MrAppList.label(c, "com.gone.app").equals("com.gone.app")
                && MrAppList.label(ctxOf(null), "com.itau.app").equals("com.itau.app"));
        check("the icon of an app that is gone is nothing (no exception)", MrAppList.icon(c, "com.gone.app") == null && MrAppList.icon(ctxOf(null), "x.y") == null);
    }

    static int countPkg(List<MrAppList.Entry> l, String pkg) {
        int n = 0;
        for (MrAppList.Entry e : l) if (e.pkg.equals(pkg)) n++;
        return n;
    }

    static int indexOf(List<MrAppList.Entry> l, String pkg) {
        for (int i = 0; i < l.size(); i++) if (l.get(i).pkg.equals(pkg)) return i;
        return -1;
    }

    // ---------------------------------------------------------------- views

    static void texts(View v, List<String> out) {
        if (v instanceof TextView) out.add(String.valueOf(((TextView) v).getText()));
        if (v instanceof ViewGroup) {
            ViewGroup g = (ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) texts(g.getChildAt(i), out);
        }
    }

    static String all(View v) {
        ArrayList<String> t = new ArrayList<String>();
        texts(v, t);
        return t.toString();
    }

    /** The clickable view that has this text under it. */
    static View clickable(View v, String text) {
        if (v == null) return null;
        if (v.stubClick != null && all(v).contains(text)) {
            // the innermost one that has it
            if (v instanceof ViewGroup) {
                ViewGroup g = (ViewGroup) v;
                for (int i = 0; i < g.getChildCount(); i++) {
                    View in = clickable(g.getChildAt(i), text);
                    if (in != null) return in;
                }
            }
            return v;
        }
        if (v instanceof ViewGroup) {
            ViewGroup g = (ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) {
                View in = clickable(g.getChildAt(i), text);
                if (in != null) return in;
            }
        }
        return null;
    }

    static boolean waitUntil(java.util.concurrent.Callable<Boolean> c) {
        long end = System.currentTimeMillis() + 5000;
        while (System.currentTimeMillis() < end) {
            try {
                if (c.call()) return true;
                Thread.sleep(3);
            } catch (Exception e) {
                return false;
            }
        }
        return false;
    }

    static Object field(Object o, Class<?> cl, String name) {
        try {
            Field f = cl.getDeclaredField(name);
            f.setAccessible(true);
            return f.get(o);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    static Object call(Object o, Class<?> cl, String name, Class<?>[] types, Object... args) {
        try {
            Method m = cl.getDeclaredMethod(name, types);
            m.setAccessible(true);
            return m.invoke(o, args);
        } catch (Exception e) {
            throw new RuntimeException(name, e);
        }
    }

    // ---------------------------------------------------------------- the dialog

    static void picker() {
        final Screen s = new Screen();
        MrLearned.useStore(new MrMemStore());
        s.onCreate(null);
        MrKit k = (MrKit) field(s, MrImportActivity.class, "k");
        final List<String> picked = new ArrayList<String>();
        final List<MrAppList.Entry> src = new ArrayList<MrAppList.Entry>();
        for (int i = 0; i < 70; i++) src.add(new MrAppList.Entry("app.n" + i, "App " + i, i == 3 ? "12" : null));
        MrAppPicker p = MrAppPicker.show(k, "app.n5", "Add for", "Empty", new MrAppPicker.Once() {
            List<MrAppList.Entry> list() {
                return src;
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
                picked.add(String.valueOf(pkg));
            }
        });
        AlertDialog d = p.dialog();
        check("the dialog is open with the title and a Cancel button", d != null && d.stubShown && "Add for".equals(String.valueOf(d.stubTitle)) && d.stubNegative != null);
        check("it has every app first, then the apps, off the main thread (the list arrives after)", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(((AlertDialog) AlertDialog.stubLast).stubView).contains("App 0"); }
        }));
        String t = all(d.stubView);
        check("... " + MrAppPicker.PAGE + " apps at first, and no \"Show more\" button (the next ones come by scrolling)", t.contains("App 29") && !t.contains("App 30") && !t.contains("mr_learned_more"));
        check("... the app that is chosen has a mark, and a note is drawn at the right of its row", t.contains("✓") && t.contains("12"));
        check("... and with more than " + MrAppPicker.SEARCH_FROM + " apps there is a search field", t.contains("mr_app_search") || hasSearch(d.stubView));
        // scrolling: the next page is added when the bottom of the screen is 75 dp before the last card
        final ScrollView sv = (ScrollView) d.stubView;
        final LinearLayout listBox = (LinearLayout) field(p, MrAppPicker.class, "mListBox");
        sv.stubSize(1000, 1000);
        check("the dialog sets a scroll listener on its page", sv.stubScrollListener != null);
        int before = listBox.getChildCount();
        listBox.getChildAt(before - 1).stubTop(3000);
        sv.scrollTo(0, 1800);
        sv.stubScrollListener.onScrollChange(sv, 0, 1800, 0, 0);
        check("far from the last card (200 dp) nothing is added", listBox.getChildCount() == before && !all(d.stubView).contains("App 30"));
        sv.scrollTo(0, 1930);
        sv.stubScrollListener.onScrollChange(sv, 0, 1930, 0, 0);
        check("70 dp before the last card the next " + MrAppPicker.PAGE + " are added at the end", all(d.stubView).contains("App 59") && !all(d.stubView).contains("App 60")
                && listBox.getChildCount() == before + MrAppPicker.PAGE);
        check("... the rows that were there are the same views (nothing was redrawn, the page does not jump)", listBox.getChildAt(0) == listBox.getChildAt(0) && listBox.getChildCount() == 2 * MrAppPicker.PAGE);
        listBox.getChildAt(listBox.getChildCount() - 1).stubTop(5000);
        sv.scrollTo(0, 4000);
        sv.stubScrollListener.onScrollChange(sv, 0, 4000, 0, 0);
        check("at the end of the list nothing more is added (70 apps in all)", all(d.stubView).contains("App 69") && listBox.getChildCount() == 70);
        sv.stubScrollListener.onScrollChange(sv, 0, 4000, 0, 0);
        check("... and another scroll event adds nothing", listBox.getChildCount() == 70);
        View row = clickable(d.stubView, "App 7");
        row.performClick();
        check("tapping an app chooses it and closes the dialog", picked.equals(java.util.Arrays.asList("app.n7")) && !d.stubShown);
        check("a closed dialog keeps nothing of the list", !all(d.stubView).contains("App 7"));

        // every app
        picked.clear();
        MrAppPicker q = MrAppPicker.show(k, "app.n1", "T", "Empty", new MrAppPicker.Once() {
            List<MrAppList.Entry> list() {
                return src;
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
                picked.add(String.valueOf(pkg));
            }
        });
        clickable(q.dialog().stubView, "mr_app_all").performClick();
        check("the first row is every app (the choice is null)", picked.equals(java.util.Arrays.asList("null")));

        // empty list and failing source
        final AlertDialog[] last = new AlertDialog[1];
        MrAppPicker e = MrAppPicker.show(k, null, "T", "No apps here", new MrAppPicker.Once() {
            List<MrAppList.Entry> list() {
                return new ArrayList<MrAppList.Entry>();
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("with no apps the dialog says so (and has no search)", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("No apps here"); }
        }) && !searchShown(e.dialog().stubView));
        MrAppPicker f = MrAppPicker.show(k, null, "T", "Nothing", new MrAppPicker.Once() {
            List<MrAppList.Entry> list() {
                throw new RuntimeException("no");
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("a source that fails is an empty list, not a crash", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("Nothing"); }
        }));

        // closed before the list arrives
        final java.util.concurrent.CountDownLatch gate = new java.util.concurrent.CountDownLatch(1);
        MrAppPicker g = MrAppPicker.show(k, null, "T", "x", new MrAppPicker.Once() {
            List<MrAppList.Entry> list() {
                try {
                    gate.await();
                } catch (InterruptedException ex) {
                    // goes on
                }
                return src;
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        g.dialog().dismiss();
        gate.countDown();
        try {
            Thread.sleep(80);
        } catch (InterruptedException ex) {
            // goes on
        }
        check("a list that arrives after the dialog was closed is dropped (nothing is drawn)", !all(g.dialog().stubView).contains("App 0"));
    }

    static boolean hasSearch(View v) {
        return searchShown(v);
    }

    static boolean searchShown(View v) {
        if (v instanceof android.widget.EditText && v.getVisibility() == View.VISIBLE) return true;
        if (v instanceof ViewGroup) {
            ViewGroup g = (ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) if (searchShown(g.getChildAt(i))) return true;
        }
        return false;
    }

    // ---------------------------------------------------------------- Add words and texts, for an app

    static void importScreen() throws Exception {
        final MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        final Screen s = new Screen();
        s.onCreate(null);
        s.onResume();
        final Class<?> cl = MrImportActivity.class;
        check("the screen starts with every app and says the words work in any app", all((View) field(s, cl, "mAppBox")).contains("mr_app_all") && String.valueOf(((TextView) field(s, cl, "mAppNote")).getText()).equals("mr_app_note_all"));
        call(s, cl, "chooseApp", new Class<?>[0]);
        final AlertDialog d = AlertDialog.stubLast;
        check("the choice opens a dialog with the apps of the phone, without the ones of the system", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(d.stubView).contains("Itaú"); }
        }) && all(d.stubView).contains("WhatsApp") && !all(d.stubView).contains("Configurações") && all(d.stubView).contains("Chrome"));
        clickable(d.stubView, "Itaú").performClick();
        check("choosing an app shows it (and its note) on the screen", all((View) field(s, cl, "mAppBox")).contains("Itaú")
                && String.valueOf(((TextView) field(s, cl, "mAppNote")).getText()).startsWith("mr_app_note[") && String.valueOf(((TextView) field(s, cl, "mAppNote")).getText()).contains("Itaú"));
        check("the app is kept in the screen for the save (the package)", "com.itau.app".equals(field(s, cl, "mApp")));

        // save for the app, through the screen itself
        final MrImport.Plan plan = MrImport.parse("[words]\nitaucard\nitaupix\n[phrases]\nvou itaucard\n", AppWordsTest.PT);
        setField(s, cl, "mPlan", plan);
        call(s, cl, "apply", new Class<?>[0]);
        check("saving with an app chosen puts the words under that app, not under the language", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")) == 2; }
        }) && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 0 && st.count(MrWordStore.KIND_IMPORTED_PAIR, MrApp.scope(L, "com.itau.app")) == 1);
        android.content.SharedPreferences pr = s.getSharedPreferences("mr_words", 0);
        check("the screen remembers the app of the last addition, with its batch and its count", "com.itau.app".equals(pr.getString("last_app", null)) && pr.getLong("last_batch", 0) > 0 && pr.getInt("last_count", 0) == 3);
        check("the answer of the save says the words work only in that app", String.valueOf(AlertDialog.stubLastMessage).contains("mr_import_added_app"));
        check("after adding, the choice goes back to \"All apps\" (as the text box goes back to empty): the card and its note", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() throws Exception { return field(s, cl, "mApp") == null; }
        }) && all((View) field(s, cl, "mAppBox")).contains("mr_app_all") && !all((View) field(s, cl, "mAppBox")).contains("Itaú")
                && String.valueOf(((TextView) field(s, cl, "mAppNote")).getText()).equals("mr_app_note_all"));
        check("the Undo button is there", visible(field(s, cl, "mUndo")));
        call(s, cl, "undoLast", new Class<?>[0]);
        AlertDialog ask = AlertDialog.stubLast;
        check("Undo asks about the app (its name in the question)", String.valueOf(ask.stubTitle).equals("mr_import_undo_title") && String.valueOf(AlertDialog.stubLastMessage).contains("mr_import_undo_ask_app"));
        ask.stubPositiveListener.onClick(ask, -1);
        check("... and undoing takes back the words of that app only", st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")) == 0 && pr.getLong("last_batch", 0) == 0 && pr.getString("last_app", null) == null);

        // every app again
        clickable(openPicker(s, cl), "mr_app_all").performClick();
        check("choosing every app again goes back to the words for any app", field(s, cl, "mApp") == null && String.valueOf(((TextView) field(s, cl, "mAppNote")).getText()).equals("mr_app_note_all"));
        setField(s, cl, "mPlan", plan);
        call(s, cl, "apply", new Class<?>[0]);
        check("... and the words are saved under the language", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 2; }
        }) && st.scopes().isEmpty() && pr.getString("last_app", null) == null);
    }

    /** "What the keyboard learned": the next rows come by scrolling, 50 at a time, and there is no "Show more" button. */
    static void learnedPaging() throws Exception {
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        StringBuilder sb = new StringBuilder("[words]\n");
        for (int i = 0; i < 120; i++) sb.append("pal").append((char) ('a' + i / 26)).append((char) ('a' + i % 26)).append("\n");
        MrLearned.apply(st, MrImport.parse(sb.toString(), AppWordsTest.PT), L, null, 1);
        Learned s = new Learned();
        s.getIntent();
        s.onCreate(null);
        s.onResume();
        Class<?> cl = MrLearnedActivity.class;
        Field tab = cl.getDeclaredField("mTab");
        tab.setAccessible(true);
        Field loc = cl.getDeclaredField("mLocale");
        loc.setAccessible(true);
        loc.set(s, L);
        tab.setInt(s, 1);
        call(s, cl, "refreshAll", new Class<?>[0]);
        ScrollView sv = (ScrollView) field(s, cl, "mScroll");
        sv.stubSize(1000, 1000);
        LinearLayout table = (LinearLayout) field(s, cl, "mTable");
        check("the list shows the first " + MrLearnedActivity.PAGE + " rows (a line between them) and no button", (table.getChildCount() + 1) / 2 == MrLearnedActivity.PAGE
                && !all((View) field(s, cl, "mListBox")).contains("mr_learned_more") && sv.stubScrollListener != null);
        table.getChildAt(table.getChildCount() - 1).stubTop(3000);
        sv.scrollTo(0, 1800);
        sv.stubScrollListener.onScrollChange(sv, 0, 1800, 0, 0);
        check("far from the last row: nothing more", ((LinearLayout) field(s, cl, "mTable")).getChildCount() == table.getChildCount());
        sv.scrollTo(0, 1930);
        sv.stubScrollListener.onScrollChange(sv, 0, 1930, 0, 0);
        table = (LinearLayout) field(s, cl, "mTable");
        check("75 dp before the last row: the next " + MrLearnedActivity.PAGE + " rows", (table.getChildCount() + 1) / 2 == 2 * MrLearnedActivity.PAGE);
        table.getChildAt(table.getChildCount() - 1).stubTop(6000);
        sv.scrollTo(0, 5500);
        sv.stubScrollListener.onScrollChange(sv, 0, 5500, 0, 0);
        table = (LinearLayout) field(s, cl, "mTable");
        check("again: 100 rows were there, the next page has the 120", (table.getChildCount() + 1) / 2 == 120);
        table.getChildAt(table.getChildCount() - 1).stubTop(9000);
        sv.scrollTo(0, 8800);
        sv.stubScrollListener.onScrollChange(sv, 0, 8800, 0, 0);
        table = (LinearLayout) field(s, cl, "mTable");
        check("at the end (120 words) nothing more is asked", (table.getChildCount() + 1) / 2 == 120);
    }

    static void setField(Object o, Class<?> cl, String name, Object v) throws Exception {
        Field f = cl.getDeclaredField(name);
        f.setAccessible(true);
        f.set(o, v);
    }

    static View openPicker(Object s, Class<?> cl) {
        call(s, cl, "chooseApp", new Class<?>[0]);
        final AlertDialog d = AlertDialog.stubLast;
        waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(d.stubView).contains("Itaú") || all(d.stubView).contains("WhatsApp"); }
        });
        return d.stubView;
    }

    // ---------------------------------------------------------------- What the keyboard learned, for an app

    static final class Learned extends MrLearnedActivity {
        final Phone pm = phone();
        final ImportScreenTest.Res res = new ImportScreenTest.Res();
        final java.util.Map<String, TourTest.Prefs> files = new java.util.HashMap<String, TourTest.Prefs>();
        final List<android.content.Intent> started = new ArrayList<android.content.Intent>();

        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return null; }
        public android.content.res.Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return pm; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public android.content.SharedPreferences getSharedPreferences(String name, int mode) {
            TourTest.Prefs p = files.get(name);
            if (p == null) {
                p = new TourTest.Prefs();
                files.put(name, p);
            }
            return p;
        }
        public void startActivity(android.content.Intent i) { started.add(i); }
        public void runOnUiThread(Runnable r) { r.run(); }
        public Object getSystemService(String name) { return null; }
        public void finish() { }
    }

    static void learned() throws Exception {
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        MrLearned.apply(st, MrImport.parse("[words]\ngeralum\ngeraldois\ngeraltres\n", AppWordsTest.PT), L, null, 1);
        MrLearned.apply(st, MrImport.parse("[words]\nitaucard\nitaupix\n[phrases]\nvou itaucard\n", AppWordsTest.PT), L, "com.itau.app", 2);
        Learned s = new Learned();
        android.os.Bundle b = new android.os.Bundle();
        s.getIntent();
        s.onCreate(null);
        s.onResume();
        Class<?> cl = MrLearnedActivity.class;
        Field tab = cl.getDeclaredField("mTab");
        tab.setAccessible(true);
        Field loc = cl.getDeclaredField("mLocale");
        loc.setAccessible(true);
        check("the screen opens with a language (" + loc.get(s) + ")", loc.get(s) != null);
        loc.set(s, L);
        call(s, cl, "refreshAll", new Class<?>[0]);
        tab.setInt(s, 0);
        call(s, cl, "refreshAll", new Class<?>[0]);
        check("on the Learned tab there is no choice of app (what the keyboard learned is for every app)", !visible(field(s, cl, "mScopeBox")));
        tab.setInt(s, 1);
        call(s, cl, "refreshAll", new Class<?>[0]);
        check("on the Added tab, with an app that has words, the choice is there, on every app", visible(field(s, cl, "mScopeBox")) && all((View) field(s, cl, "mScopeBox")).contains("mr_app_all"));
        check("... and the list is the words of every app (3), not the ones of the app", st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 3 && all((View) field(s, cl, "mListBox")).contains("geralum")
                && !all((View) field(s, cl, "mListBox")).contains("itaucard"));
        call(s, cl, "chooseApp", new Class<?>[0]);
        final AlertDialog d = AlertDialog.stubLast;
        check("the dialog lists only the apps that have words in this language, each with how many (3 items)", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(d.stubView).contains("Itaú"); }
        }) && !all(d.stubView).contains("WhatsApp") && all(d.stubView).contains("3"));
        clickable(d.stubView, "Itaú").performClick();
        check("choosing it lists the words of the app, and the count of the tab is the app's", all((View) field(s, cl, "mListBox")).contains("itaucard") && !all((View) field(s, cl, "mListBox")).contains("geralum")
                && all((View) field(s, cl, "mTabBox")).contains("mr_learned_tab_added"));
        check("the pill shows the app with its name", all((View) field(s, cl, "mScopeBox")).contains("Itaú"));
        MrWordStore.Row appWord = st.all(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")).get(0);
        call(s, cl, "menu", new Class<?>[] {MrWordStore.Row.class}, appWord);
        String appMenu = java.util.Arrays.asList(AlertDialog.stubLast.stubItems).toString();
        check("a word of an app can be edited and forgotten, but not blocked (blocking is for every app): " + appMenu,
                appMenu.contains("mr_learned_act_edit") && appMenu.contains("mr_learned_act_forget") && !appMenu.contains("mr_learned_act_block"));
        call(s, cl, "menu", new Class<?>[] {MrWordStore.Row.class}, appWord);
        AlertDialog men = AlertDialog.stubLast;
        int forget = java.util.Arrays.asList(men.stubItems).indexOf("mr_learned_act_forget");
        men.stubItemsListener.onClick(men, forget);
        check("forgetting a word of the app takes only that one", st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")) == 1 && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 3);

        // forget all of the app
        call(s, cl, "askDeleteAll", new Class<?>[0]);
        AlertDialog del = AlertDialog.stubLast;
        check("forgetting all asks about the app (its name in the question)", String.valueOf(AlertDialog.stubLastMessage).contains("mr_learned_delete_ask_app"));
        del.stubPositiveListener.onClick(del, -1);
        check("... and only the words of the app go: the ones of every app stay", st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")) == 0
                && st.count(MrWordStore.KIND_IMPORTED_PAIR, MrApp.scope(L, "com.itau.app")) == 0 && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 3);
        check("the app that has nothing left stays on the screen with its own empty text, and the dialog no longer offers it", "com.itau.app".equals(field(s, cl, "mApp"))
                && String.valueOf(((TextView) field(s, cl, "mEmpty")).getText()).equals("mr_learned_empty_added_app") && !st.scopes().contains(MrApp.scope(L, "com.itau.app")));
        // back to the words of every app: there a word can be blocked again
        setField(s, cl, "mApp", null);
        call(s, cl, "refreshAll", new Class<?>[0]);
        MrWordStore.Row everyWord = st.all(MrWordStore.KIND_IMPORTED_WORD, L).get(0);
        call(s, cl, "menu", new Class<?>[] {MrWordStore.Row.class}, everyWord);
        check("with every app on, a word can be blocked again", java.util.Arrays.asList(AlertDialog.stubLast.stubItems).toString().contains("mr_learned_act_block"));
    }

    static boolean visible(Object v) {
        return ((View) v).getVisibility() == View.VISIBLE;
    }

    // ---------------------------------------------------------------- the files

    static String file(String path) {
        try {
            return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
        } catch (Exception e) {
            throw new RuntimeException(path, e);
        }
    }

    static void files() {
        String[] langs = {"values", "values-pt-rBR", "values-es"};
        String[] names = {"mr_app_card_title", "mr_app_all", "mr_app_only", "mr_app_search", "mr_app_loading", "mr_app_none", "mr_app_none_installed", "mr_app_note", "mr_app_note_all",
                "mr_app_scope_title", "mr_app_scope_pick", "mr_app_scope_empty", "mr_import_for_app", "mr_import_added_app", "mr_import_undo_ask_app", "mr_learned_empty_added_app",
                "mr_learned_empty_added_apps", "mr_learned_delete_ask_app"};
        boolean all = true;
        StringBuilder why = new StringBuilder();
        for (String n : names) {
            String[] v = new String[3];
            for (int i = 0; i < 3; i++) v[i] = ImportScreenTest.string(langs[i], n);
            if (v[0] == null || v[1] == null || v[2] == null || v[0].trim().isEmpty() || v[1].trim().isEmpty() || v[2].trim().isEmpty()) {
                all = false;
                why.append(' ').append(n);
                continue;
            }
            if (!holes(v[0]).equals(holes(v[1])) || !holes(v[0]).equals(holes(v[2]))) {
                all = false;
                why.append(" placeholders:").append(n);
            }
        }
        check("every text of the app choice is in 3 languages, with the same %1$s / %2$d holes" + why, all);
        check("the manifest asks to see the apps with a launcher icon (Android 11 and later hide the others)", file("AndroidManifest.xml").contains("android.intent.category.LAUNCHER")
                && file("AndroidManifest.xml").contains("<queries>") && !file("AndroidManifest.xml").contains("QUERY_ALL_PACKAGES"));
        String ime = file("smali/com/mrkeyboard/app/LatinIME.smali");
        check("LatinIME tells MrApp when a field opens", ime.contains("Lcom/mrkeyboard/app/MrApp;->onInput("));
        String auto = file("smali/com/mrkeyboard/app/AutoDictionary.smali");
        check("AutoDictionary asks the words of the app after its own and takes them as valid words", auto.contains("Lcom/mrkeyboard/app/MrApp;->words(") && auto.contains("Lcom/mrkeyboard/app/MrApp;->isValid("));
        String user = file("smali/com/mrkeyboard/app/UserBigramDictionary.smali");
        check("UserBigramDictionary asks for the next words of the app", user.contains("Lcom/mrkeyboard/app/MrApp;->getBigrams("));
        check("gesture typing reads the words of the app in front too", file("docs/tools/java/src/com/mrkeyboard/app/MrGestureWords.java").contains("MrApp.dictionary()"));
        String learned = file("docs/tools/java/src/com/mrkeyboard/app/MrLearned.java");
        check("what the keyboard loads tells MrApp (the tree is made again with the language) and a change of words too", learned.contains("MrApp.onLoad(") && learned.contains("MrApp.dataChanged()"));
    }

    static String holes(String s) {
        ArrayList<String> h = new ArrayList<String>();
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("%\\d\\$[sd]").matcher(s);
        while (m.find()) h.add(m.group());
        java.util.Collections.sort(h);
        return h.toString();
    }


    // ---------------------------------------------------------------- the cache of the list

    /** The database in memory. */
    static class MemStore implements MrAppCache.Store {
        MrAppCache.Snapshot snap = MrAppCache.Snapshot.empty();
        int writes;

        public MrAppCache.Snapshot read() {
            return snap;
        }

        public void write(MrAppCache.Snapshot s) {
            snap = s;
            writes++;
        }
    }

    static ResolveInfo appAt(String pkg, String label, String sourceDir) {
        ResolveInfo ri = app(pkg, label, 0);
        ri.activityInfo.applicationInfo.sourceDir = sourceDir;
        return ri;
    }

    /** Runs the refresh and returns what the sink heard, in order (the names of each list). */
    static List<List<String>> run(Phone p, MemStore store) {
        final List<List<String>> heard = new ArrayList<List<String>>();
        MrAppCache.refresh(ctxOf(p), store, new MrAppPicker.Sink() {
            public void publish(List<MrAppList.Entry> list) {
                heard.add(names(list));
            }
        });
        return heard;
    }

    static void cache() {
        Phone p = new Phone();
        p.apps.add(appAt("com.whatsapp", "WhatsApp", "/data/app/a/base.apk"));
        p.apps.add(appAt("com.itau.app", "Itaú", "/data/app/b/base.apk"));
        p.apps.add(appAt("com.alvaro.album", "Álbum", "/data/app/c/base.apk"));
        p.apps.add(app("com.android.settings", "Configurações", ApplicationInfo.FLAG_SYSTEM));
        MemStore store = new MemStore();

        // the fast pass and the signature
        List<MrAppList.Found> found = MrAppList.scan(ctxOf(p));
        labelCalls = 0;
        check("the fast pass finds the packages of the 3 apps and asks for no name", found.size() == 3 && labelCalls == 0);
        check("... a system that fails answers null (not 'no apps'), and no package manager too", MrAppList.scan(null) == null && MrAppList.scan(ctxOf(null)) == null);
        Phone bad0 = phone();
        bad0.failing = true;
        check("... and so does a system that throws", MrAppList.scan(ctxOf(bad0)) == null);
        String sig = MrAppCache.signature(found);
        ArrayList<MrAppList.Found> backwards = new ArrayList<MrAppList.Found>(found);
        java.util.Collections.reverse(backwards);
        check("the signature is 40 hexadecimal digits (SHA-1) and does not depend on the order", sig.matches("[0-9a-f]{40}") && sig.equals(MrAppCache.signature(backwards)));
        Phone moved = new Phone();
        moved.apps.add(appAt("com.whatsapp", "WhatsApp", "/data/app/NEW/base.apk"));
        moved.apps.add(appAt("com.itau.app", "Itaú", "/data/app/b/base.apk"));
        moved.apps.add(appAt("com.alvaro.album", "Álbum", "/data/app/c/base.apk"));
        check("... it changes when an app is updated (the place of its files changes) or when one is added", !sig.equals(MrAppCache.signature(MrAppList.scan(ctxOf(moved))))
                && !sig.equals(MrAppCache.signature(found.subList(0, 2))));

        // nothing kept: the slow pass runs once and is kept
        labelCalls = 0;
        List<List<String>> h = run(p, store);
        check("nothing kept yet: the names are asked (3) and the list is published once", labelCalls == 3 && h.size() == 1 && h.get(0).size() == 3 && h.get(0).get(0).equals("com.alvaro.album=Álbum"));
        check("... and kept, with the signature and the language", store.writes == 1 && sig.equals(store.snap.signature) && store.snap.locale != null && store.snap.entries.size() == 3);

        // the same apps: what was kept at once, and no name asked, nothing written
        labelCalls = 0;
        h = run(p, store);
        check("the same apps: the list that was kept is published once, no name is asked and nothing is written", h.size() == 1 && h.get(0).size() == 3 && labelCalls == 0 && store.writes == 1);

        // an app was installed: what was kept first, then the new list; only the new name is asked
        p.apps.add(appAt("com.new.app", "Novo", "/data/app/d/base.apk"));
        labelCalls = 0;
        h = run(p, store);
        check("an app was installed: the list that was kept, then the new one with 4 apps", h.size() == 2 && h.get(0).size() == 3 && h.get(1).size() == 4 && h.get(1).contains("com.new.app=Novo"));
        check("... only the name of the new app was asked, and the result is kept", labelCalls == 1 && store.writes == 2 && store.snap.entries.size() == 4);

        // an app was removed
        p.apps.remove(p.apps.size() - 1);
        p.apps.remove(p.apps.get(0));
        labelCalls = 0;
        h = run(p, store);
        check("an app was removed: it goes away from the list (and from what is kept), no name is asked", h.size() == 2 && h.get(1).size() == 2 && !h.get(1).toString().contains("whatsapp")
                && labelCalls == 0 && store.snap.entries.size() == 2);

        // an app was updated and has another name
        Phone q = new Phone();
        q.apps.add(appAt("com.itau.app", "Itaú Banco", "/data/app/b2/base.apk"));
        q.apps.add(appAt("com.alvaro.album", "Álbum", "/data/app/c/base.apk"));
        labelCalls = 0;
        h = run(q, store);
        check("an app was updated (its files moved): its name is asked again, the other one is not", labelCalls == 1 && h.size() == 2 && h.get(1).contains("com.itau.app=Itaú Banco"));

        // another language of the phone: every name is asked again
        java.util.Locale was = java.util.Locale.getDefault();
        try {
            java.util.Locale.setDefault(new java.util.Locale("es", "ES"));
            labelCalls = 0;
            h = run(q, store);
            check("another language of the phone: every name is asked again (2) and the list is published again only if it differs", labelCalls == 2 && h.size() >= 1
                    && "es_ES".equals(store.snap.locale));
        } finally {
            java.util.Locale.setDefault(was);
        }

        // the system cannot answer
        Phone down = new Phone();
        down.failing = true;
        int writes = store.writes;
        h = run(down, store);
        check("the system cannot answer: what was kept is shown and stays as it is", h.size() == 1 && h.get(0).size() == 2 && store.writes == writes);
        h = run(down, new MemStore());
        check("... and with nothing kept the sink hears an empty list (once)", h.size() == 1 && h.get(0).isEmpty());
        Phone none = new Phone();
        MemStore e2 = new MemStore();
        h = run(none, e2);
        check("a phone with no apps: an empty list is published once and kept (so the next time is fast)", h.size() == 1 && h.get(0).isEmpty() && e2.writes == 1);
        check("a store that throws on read is as if nothing was kept", run(p, new MemStore() {
            public MrAppCache.Snapshot read() {
                throw new RuntimeException("disk");
            }
        }).size() == 1);

        // same(): names and order
        check("same(): same packages and names in the same order only", MrAppCache.same(store.snap.entries, store.snap.entries) && !MrAppCache.same(store.snap.entries, null)
                && !MrAppCache.same(store.snap.entries, store.snap.entries.subList(0, 1)));
    }

    /** A source that answers twice (what was kept, then the changes): the dialog is updated and keeps the search and the page. */
    static void streaming() {
        final Screen s = new Screen();
        MrLearned.useStore(new MrMemStore());
        s.onCreate(null);
        MrKit k = (MrKit) field(s, MrImportActivity.class, "k");
        final List<MrAppList.Entry> a = new ArrayList<MrAppList.Entry>();
        for (int i = 0; i < 40; i++) a.add(new MrAppList.Entry("app.n" + i, "App " + i, null));
        final List<MrAppList.Entry> b = new ArrayList<MrAppList.Entry>(a);
        b.remove(3);
        b.add(2, new MrAppList.Entry("app.new", "Nova", null));
        final java.util.concurrent.CountDownLatch gate = new java.util.concurrent.CountDownLatch(1);
        MrAppPicker p = MrAppPicker.show(k, null, "T", "Empty", new MrAppPicker.Source() {
            public void load(MrAppPicker.Sink sink) {
                sink.publish(a);
                try {
                    gate.await();
                } catch (InterruptedException ex) {
                    // goes on
                }
                sink.publish(a);          // the same list again: nothing changes
                sink.publish(b);
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        final AlertDialog d = p.dialog();
        check("the list that was kept appears first", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(d.stubView).contains("App 3,"); }
        }) && !all(d.stubView).contains("Nova"));
        gate.countDown();
        final LinearLayout box = (LinearLayout) field(p, MrAppPicker.class, "mListBox");
        check("then the changes: the new app is added and the one that is gone is removed, on the page that was shown (30 rows)", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() {
                String t = all(d.stubView);
                return box.getChildCount() == MrAppPicker.PAGE && t.contains("Nova") && !t.contains("App 3,") && t.contains("App 4,");
            }
        }));
    }

    static void nearEnd() {
        Screen s = new Screen();
        s.onCreate(null);
        MrKit k = (MrKit) field(s, MrImportActivity.class, "k");
        ScrollView sv = new ScrollView(s);
        LinearLayout items = new LinearLayout(s);
        sv.addView(items);
        check("an empty list is never near its end", !k.nearEnd(sv, items) && !k.nearEnd(null, items) && !k.nearEnd(sv, null));
        View last = new View(s);
        items.addView(last);
        sv.stubSize(800, 800);
        last.stubTop(1000);
        sv.scrollTo(0, 0);
        check("the last card is 200 dp under the bottom of the screen: not yet", !k.nearEnd(sv, items));
        sv.scrollTo(0, 200 - k.dp(MrKit.NEAR_END_DP) + 1);
        check("... " + MrKit.NEAR_END_DP + " dp before the last card (just inside): yes", k.nearEnd(sv, items));
        sv.scrollTo(0, 200 - k.dp(MrKit.NEAR_END_DP) - 1);
        check("... one pixel before that: not yet", !k.nearEnd(sv, items));
        sv.scrollTo(0, 900);
        check("the last card on the screen (or past it): yes", k.nearEnd(sv, items));
    }

    public static void main(String[] args) throws Exception {
        list();
        cache();
        nearEnd();
        picker();
        streaming();
        importScreen();
        learned();
        learnedPaging();
        files();
        System.out.println();
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
