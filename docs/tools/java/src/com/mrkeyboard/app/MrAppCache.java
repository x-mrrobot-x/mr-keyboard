package com.mrkeyboard.app;

import android.content.Context;
import android.content.pm.PackageManager;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * The list of apps of the dialog that chooses an app (MrAppPicker), kept in a small local database so that it opens at once.
 *
 * What happens when the dialog opens (off the main thread, {@link #refresh}):
 * <ol>
 * <li>what was kept the last time is shown right away (nothing is asked of the system);</li>
 * <li>the fast pass asks the system only for the packages (MrAppList.scan) and makes a signature of them: the SHA-1 of the sorted packages with the place
 *     of their files (it changes when an app is installed, removed or updated);</li>
 * <li>if the signature and the language of the phone are the ones that were kept, that is all: no name is asked;</li>
 * <li>otherwise the slow pass asks for the names, only of the apps that are new or were updated (the others keep the name that was kept, unless the language
 *     of the phone changed: the names are then asked again), keeps the result and tells the dialog, which adds and removes the rows that changed.</li>
 * </ol>
 * With nothing kept yet, the slow pass runs at once and its result is kept. A phone that cannot answer (the fast pass fails) leaves what was kept as it is.
 * The database (mr_apps.db, {@link MrAppCacheDb}) has only the package, the name and the place of the files of each app: no icon, no other data.
 */
final class MrAppCache {
    private MrAppCache() { }

    /** What was kept: the signature, the language of the names, the apps and the place of the files of each one (by package). */
    static final class Snapshot {
        final String signature;
        final String locale;
        final List<MrAppList.Entry> entries;
        final Map<String, String> sources;

        Snapshot(String signature, String locale, List<MrAppList.Entry> entries, Map<String, String> sources) {
            this.signature = signature;
            this.locale = locale;
            this.entries = entries;
            this.sources = sources;
        }

        static Snapshot empty() {
            return new Snapshot(null, null, new ArrayList<MrAppList.Entry>(), new HashMap<String, String>());
        }
    }

    /** Where it is kept (the database on the phone; a list in memory in the tests). */
    interface Store {
        /** What was kept, never null. */
        Snapshot read();

        /** Replaces what was kept. */
        void write(Snapshot s);
    }

    /** The signature of the apps: SHA-1, in hexadecimal, of the packages in order with the place of their files. */
    static String signature(List<MrAppList.Found> found) {
        ArrayList<String> keys = new ArrayList<String>();
        for (MrAppList.Found f : found) keys.add(f.pkg + "\n" + f.source);
        Collections.sort(keys);
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            for (String key : keys) {
                md.update(key.getBytes("UTF-8"));
                md.update((byte) 0);
            }
            byte[] d = md.digest();
            StringBuilder sb = new StringBuilder(d.length * 2);
            for (byte b : d) {
                sb.append(Character.forDigit((b >> 4) & 15, 16)).append(Character.forDigit(b & 15, 16));
            }
            return sb.toString();
        } catch (Exception e) {
            // no SHA-1 on this phone (it always has): the list itself is the signature, only longer
            return String.valueOf(keys);
        }
    }

    /** True when both lists have the same apps with the same names in the same order. */
    static boolean same(List<MrAppList.Entry> a, List<MrAppList.Entry> b) {
        if (a == null || b == null || a.size() != b.size()) return false;
        for (int i = 0; i < a.size(); i++) {
            if (!a.get(i).pkg.equals(b.get(i).pkg) || !a.get(i).label.equals(b.get(i).label)) return false;
        }
        return true;
    }

    /**
     * The steps above. Calls {@code sink} with the list that was kept (when there is one) and then with the new one (when it differs, or when nothing was
     * published yet: the sink always hears at least once, unless the phone could not answer and nothing was kept). Off the main thread. Never throws.
     */
    static void refresh(Context c, Store store, MrAppPicker.Sink sink) {
        Snapshot old;
        try {
            old = store.read();
        } catch (RuntimeException e) {
            old = null;
        }
        if (old == null) old = Snapshot.empty();
        boolean published = false;
        if (!old.entries.isEmpty()) {
            sink.publish(old.entries);
            published = true;
        }
        final List<MrAppList.Found> found = MrAppList.scan(c);
        if (found == null) {
            if (!published) sink.publish(new ArrayList<MrAppList.Entry>());
            return;
        }
        final String locale = Locale.getDefault().toString();
        final String sig = signature(found);
        if (published && sig.equals(old.signature) && locale.equals(old.locale)) return;

        final boolean sameLanguage = locale.equals(old.locale);
        final HashMap<String, MrAppList.Entry> known = new HashMap<String, MrAppList.Entry>();
        if (sameLanguage) {
            for (MrAppList.Entry e : old.entries) known.put(e.pkg, e);
        }
        final ArrayList<MrAppList.Entry> fresh = new ArrayList<MrAppList.Entry>();
        final HashMap<String, String> sources = new HashMap<String, String>();
        PackageManager pm = null;
        try {
            pm = c.getPackageManager();
        } catch (RuntimeException e) {
            // the package is the name then (entry() copes with it)
        }
        for (MrAppList.Found f : found) {
            MrAppList.Entry e = known.get(f.pkg);
            if (e == null || !f.source.equals(old.sources.get(f.pkg))) e = MrAppList.entry(pm, f);
            fresh.add(e);
            sources.put(f.pkg, f.source);
        }
        MrAppList.sort(fresh);
        try {
            store.write(new Snapshot(sig, locale, fresh, sources));
        } catch (RuntimeException e) {
            // not kept: it is made again next time
        }
        if (!published || !same(old.entries, fresh)) sink.publish(fresh);
    }

    /** The source of the dialog that chooses among every app of the phone: what was kept first, then the changes. */
    static MrAppPicker.Source source(final Context c) {
        return new MrAppPicker.Source() {
            public void load(MrAppPicker.Sink sink) {
                // the helper keeps the context it is given: the one of the application, never the screen; and it is closed when the pass ends
                MrAppCacheDb store = null;
                try {
                    store = new MrAppCacheDb(c.getApplicationContext() != null ? c.getApplicationContext() : c);
                } catch (RuntimeException e) {
                    // no database: the list is made every time, as before
                }
                if (store == null) {
                    sink.publish(MrAppList.load(c));
                    return;
                }
                try {
                    refresh(c, store, sink);
                } finally {
                    store.close();
                }
            }
        };
    }
}
