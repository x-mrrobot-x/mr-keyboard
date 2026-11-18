package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.view.View;
import android.view.ViewGroup;
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

    static int labelReads;

    static ResolveInfo app(final String pkg, final String label, int flags) {
        ResolveInfo ri = new ResolveInfo() {
            public CharSequence loadLabel(PackageManager pm) {
                labelReads++;
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
        MrAppPicker p = MrAppPicker.show(k, "app.n5", "Add for", "Empty", new MrAppPicker.Source() {
            public List<MrAppList.Entry> load() {
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
            public Boolean call() { return all(((AlertDialog) AlertDialog.stubLast).stubView).contains("App 29"); }
        }));
        String t = all(d.stubView);
        check("... " + MrAppPicker.PAGE + " apps at first, and no Show more button", t.contains("App 29") && !t.contains("App 30") && !t.contains("mr_learned_more"));
        check("... the app that is chosen has a mark, and a note is drawn at the right of its row", t.contains("✓") && t.contains("12"));
        check("... and with more than " + MrAppPicker.SEARCH_FROM + " apps there is a search field", t.contains("mr_app_search") || hasSearch(d.stubView));
        android.widget.ScrollView sv = (android.widget.ScrollView) d.stubView;
        sv.stubSize(300, 400);
        sv.getChildAt(0).stubBottom(2000);
        sv.scrollTo(0, 300);
        sv.stubScroll.onScrollChange(sv, 0, 300, 0, 0);
        check("scrolling far from the last row loads nothing", !all(d.stubView).contains("App 30"));
        sv.scrollTo(0, 1700);
        sv.stubScroll.onScrollChange(sv, 0, 1700, 0, 300);
        check("reaching the last row adds the next " + MrAppPicker.PAGE + " apps", all(d.stubView).contains("App 59") && !all(d.stubView).contains("App 60"));
        sv.stubScroll.onScrollChange(sv, 0, 1700, 0, 1700);
        check("a scroll that does not go down adds nothing", !all(d.stubView).contains("App 60"));
        sv.stubScroll.onScrollChange(sv, 0, 1800, 0, 1700);
        check("the last page ends the list (the 70 apps, no more)", all(d.stubView).contains("App 69") && ((ViewGroup) field(p, MrAppPicker.class, "mListBox")).getChildCount() == 70);
        View row = clickable(d.stubView, "App 7");
        row.performClick();
        check("tapping an app chooses it and closes the dialog", picked.equals(java.util.Arrays.asList("app.n7")) && !d.stubShown);
        check("a closed dialog keeps nothing of the list", !all(d.stubView).contains("App 7"));

        // every app
        picked.clear();
        MrAppPicker q = MrAppPicker.show(k, "app.n1", "T", "Empty", new MrAppPicker.Source() {
            public List<MrAppList.Entry> load() {
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
        MrAppPicker e = MrAppPicker.show(k, null, "T", "No apps here", new MrAppPicker.Source() {
            public List<MrAppList.Entry> load() {
                return new ArrayList<MrAppList.Entry>();
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("with no apps the dialog says so (and has no search)", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("No apps here"); }
        }) && !searchShown(e.dialog().stubView));
        MrAppPicker f = MrAppPicker.show(k, null, "T", "Nothing", new MrAppPicker.Source() {
            public List<MrAppList.Entry> load() {
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
        MrAppPicker g = MrAppPicker.show(k, null, "T", "x", new MrAppPicker.Source() {
            public List<MrAppList.Entry> load() {
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

    static final class MemDisk implements MrAppCache.Disk {
        java.util.Map<String, String[]> rows = new java.util.HashMap<String, String[]>();
        String sig;
        int saves;
        int closes;

        public java.util.Map<String, String[]> rows() {
            return new java.util.HashMap<String, String[]>(rows);
        }

        public String signature() {
            return sig;
        }

        public void save(java.util.Map<String, String[]> r, String s) {
            rows = new java.util.HashMap<String, String[]>(r);
            sig = s;
            saves++;
        }

        public void close() {
            closes++;
        }
    }

    static void cache() {
        Phone p = phone();
        Context c = ctxOf(p);
        MemDisk disk = new MemDisk();
        MrAppCache cache = new MrAppCache(c, disk);
        check("nothing saved yet: the saved list is empty", cache.cached().isEmpty());
        labelReads = 0;
        List<MrAppList.Entry> first = cache.refresh();
        check("the first time there is no signature: the list is made, with the names, and saved", first != null && names(first).equals(names(MrAppList.load(c))) && disk.saves == 1 && disk.sig != null && disk.rows.size() == first.size());
        check("the signature is a SHA-256 in hex", disk.sig.length() == 64 && disk.sig.matches("[0-9a-f]+"));
        check("the saved list is what the next opening shows at once, by name", names(cache.cached()).equals(names(first)));
        labelReads = 0;
        check("the same phone again: the signature is the same and nothing changes (null)", cache.refresh() == null && disk.saves == 1);
        check("... and no name was read for it", labelReads == 0);
        check("the signature of the phone is the one that was saved", MrAppList.signature(MrAppList.scan(c)).equals(disk.sig));

        p.apps.add(app("com.new.app", "Novo", 0));
        labelReads = 0;
        List<MrAppList.Entry> added = cache.refresh();
        check("an app that came: the new list has it and is saved", added != null && names(added).contains("com.new.app=Novo") && disk.saves == 2 && disk.rows.containsKey("com.new.app"));
        check("... and only the name of the new app was read (the others come from the saved list)", labelReads == 1);

        p.apps.remove(findInfo(p, "com.itau.app"));
        List<MrAppList.Entry> removed = cache.refresh();
        check("an app that went: the new list does not have it and the saved one does not either", removed != null && !names(removed).toString().contains("com.itau.app") && !disk.rows.containsKey("com.itau.app")
                && !names(cache.cached()).toString().contains("com.itau.app"));

        ResolveInfo wa = findInfo(p, "com.whatsapp");
        wa.activityInfo.labelRes = 7;
        labelReads = 0;
        List<MrAppList.Entry> renamed = cache.refresh();
        check("an app whose name resource changed (an update) is read again", renamed != null && labelReads == 1);

        java.util.Locale was = java.util.Locale.getDefault();
        try {
            java.util.Locale.setDefault(new java.util.Locale("es", "ES"));
            labelReads = 0;
            List<MrAppList.Entry> lang = cache.refresh();
            check("another language of the system: every name is read again", lang != null && labelReads > 1);
        } finally {
            java.util.Locale.setDefault(was);
        }
        cache.close();
        check("closing the cache closes its disk", disk.closes == 1);

        MemDisk fresh = new MemDisk();
        check("a phone with no apps: the list is empty and saved, the next time is unchanged", new MrAppCache(ctxOf(new Phone()), fresh).refresh().isEmpty() && fresh.sig != null
                && new MrAppCache(ctxOf(new Phone()), fresh).refresh() == null);
    }

    static ResolveInfo findInfo(Phone p, String pkg) {
        for (ResolveInfo r : p.apps) if (r != null && r.activityInfo != null && pkg.equals(r.activityInfo.packageName)) return r;
        return null;
    }

    static void live() {
        final Screen s = new Screen();
        MrLearned.useStore(new MrMemStore());
        s.onCreate(null);
        MrKit k = (MrKit) field(s, MrImportActivity.class, "k");
        final List<MrAppList.Entry> old = new ArrayList<MrAppList.Entry>();
        for (int i = 0; i < 5; i++) old.add(new MrAppList.Entry("app.n" + i, "App " + i));
        final List<MrAppList.Entry> now = new ArrayList<MrAppList.Entry>(old);
        now.remove(1);
        now.add(new MrAppList.Entry("app.new", "App 9"));
        final java.util.concurrent.CountDownLatch gate = new java.util.concurrent.CountDownLatch(1);
        final int[] closed = new int[1];
        MrAppPicker p = MrAppPicker.show(k, null, "T", "Empty", new MrAppPicker.Live() {
            public List<MrAppList.Entry> cached() {
                return old;
            }

            public List<MrAppList.Entry> refresh() {
                try {
                    gate.await();
                } catch (InterruptedException ex) {
                }
                return now;
            }

            public void close() {
                closed[0]++;
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("the saved list is on the screen before the phone has answered", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("App 1"); }
        }) && !all(p.dialog().stubView).contains("App 9"));
        gate.countDown();
        check("when the phone answers with a difference, the apps that went are taken out and the new ones come in", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("App 9"); }
        }) && !all(p.dialog().stubView).contains("App 1,") && !all(p.dialog().stubView).contains("App 1]"));
        check("the source is closed when its work is done", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return closed[0] == 1; }
        }));

        MrAppPicker q = MrAppPicker.show(k, null, "T", "Empty", new MrAppPicker.Live() {
            public List<MrAppList.Entry> cached() {
                return old;
            }

            public List<MrAppList.Entry> refresh() {
                return null;
            }

            public void close() {
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("an unchanged phone (null) keeps the saved list as it is", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("App 4"); }
        }));

        MrAppPicker r = MrAppPicker.show(k, null, "T", "Nothing saved", new MrAppPicker.Live() {
            public List<MrAppList.Entry> cached() {
                throw new RuntimeException("disk");
            }

            public List<MrAppList.Entry> refresh() {
                return new ArrayList<MrAppList.Entry>();
            }

            public void close() {
            }
        }, new MrAppPicker.Pick() {
            public void onPick(String pkg) {
            }
        });
        check("a saved list that cannot be read is the same as none: the phone is asked", waitUntil(new java.util.concurrent.Callable<Boolean>() {
            public Boolean call() { return all(AlertDialog.stubLast.stubView).contains("Nothing saved"); }
        }));
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
        Class<?> cl = MrImportActivity.class;
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
            public Boolean call() { return st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, "com.itau.app")) == 2 && visible(field(s, cl, "mUndo")); }
        }) && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 0 && st.count(MrWordStore.KIND_IMPORTED_PAIR, MrApp.scope(L, "com.itau.app")) == 1);
        android.content.SharedPreferences pr = s.getSharedPreferences("mr_words", 0);
        check("the screen remembers the app of the last addition, with its batch and its count", "com.itau.app".equals(pr.getString("last_app", null)) && pr.getLong("last_batch", 0) > 0 && pr.getInt("last_count", 0) == 3);
        check("the answer of the save says the words work only in that app", String.valueOf(AlertDialog.stubLastMessage).contains("mr_import_added_app"));
        check("after saving, the app goes back to every app, as the text box goes back to empty", field(s, cl, "mApp") == null && all((View) field(s, cl, "mAppBox")).contains("mr_app_all")
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

    public static void main(String[] args) throws Exception {
        list();
        cache();
        picker();
        live();
        importScreen();
        learned();
        files();
        System.out.println();
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
