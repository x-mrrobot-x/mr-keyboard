package com.mrkeyboard.app;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.drawable.Drawable;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

/**
 * The apps that the person can choose on "Add words and texts" (MrAppPicker) and the name and icon of one app by its package.
 *
 * What is offered: the apps that have an icon on the launcher (the ones the person opens and types in) and are not part of the system. "Not part of the
 * system" is {@link #isUserApp}: an app that came with the phone is left out, except one that was updated from a store (Chrome, Gmail, Google Messages... are
 * system apps that the person keeps updated and types in). Android 11 and later only lets an app see the others it declares: the manifest asks for the apps
 * with a launcher icon (the same question as here), not for the list of every package.
 *
 * The package list is cheap and the names are not: {@link #scan} reads only the packages (and what says a name may have changed), {@link #signature} makes one
 * hash of them, and MrAppCache keeps the names with that hash, so the names are read again only for the apps that are new or changed. The icons are loaded one by
 * one for the rows on screen (an icon can be a large bitmap, a list of all of them would not fit in a small heap).
 */
final class MrAppList {
    private MrAppList() { }

    /** An app of the list: its package and the name the launcher shows. */
    static final class Entry {
        final String pkg;
        final String label;
        /** The name without accents and in lower case, to search and to sort. */
        final String folded;
        /** A short note drawn on the right of the row (how many words the app has, on the screen of what was learned), or null. */
        final String note;

        Entry(String pkg, String label) {
            this(pkg, label, null);
        }

        Entry(String pkg, String label, String note) {
            this.pkg = pkg;
            this.label = label;
            this.folded = MrMemStore.fold(label).toLowerCase(java.util.Locale.ROOT);
            this.note = note;
        }
    }

    /** An app that came with the phone does not count, unless the person updated it (it is then in the data partition and has the update flag). */
    static boolean isUserApp(int flags) {
        return (flags & ApplicationInfo.FLAG_SYSTEM) == 0 || (flags & ApplicationInfo.FLAG_UPDATED_SYSTEM_APP) != 0;
    }

    static final class Found {
        final String pkg;
        final String stamp;
        final ResolveInfo info;

        Found(String pkg, String stamp, ResolveInfo info) {
            this.pkg = pkg;
            this.stamp = stamp;
            this.info = info;
        }
    }

    private static String stampOf(ActivityInfo ai, ApplicationInfo app) {
        return java.util.Locale.getDefault().toString() + "|" + ai.labelRes + "|" + app.labelRes;
    }

    /** The apps with a launcher icon that are not part of the system, without their names, by package. Never null, never throws. */
    static List<Found> scan(Context c) {
        ArrayList<Found> out = new ArrayList<Found>();
        try {
            final PackageManager pm = c == null ? null : c.getPackageManager();
            if (pm == null) return out;
            final Intent launcher = new Intent(Intent.ACTION_MAIN);
            launcher.addCategory(Intent.CATEGORY_LAUNCHER);
            final List<ResolveInfo> found = pm.queryIntentActivities(launcher, 0);
            if (found == null) return out;
            final HashSet<String> seen = new HashSet<String>();
            for (ResolveInfo ri : found) {
                final ActivityInfo ai = ri == null ? null : ri.activityInfo;
                final ApplicationInfo app = ai == null ? null : ai.applicationInfo;
                final String pkg = app != null && app.packageName != null ? app.packageName : ai != null ? ai.packageName : null;
                if (!MrApp.validPackage(pkg) || app == null || !isUserApp(app.flags) || !seen.add(pkg)) continue;
                out.add(new Found(pkg, stampOf(ai, app), ri));
            }
        } catch (RuntimeException e) {
            // what was read stays
        }
        Collections.sort(out, new Comparator<Found>() {
            public int compare(Found a, Found b) {
                return a.pkg.compareTo(b.pkg);
            }
        });
        return out;
    }

    /** One hash of the packages and their stamps: the same phone gives the same text, an app that came, went or changed its name gives another. Null if it cannot be made. */
    static String signature(List<Found> found) {
        try {
            final MessageDigest md = MessageDigest.getInstance("SHA-256");
            for (Found f : found) md.update((f.pkg + "\t" + f.stamp + "\n").getBytes(StandardCharsets.UTF_8));
            final byte[] d = md.digest();
            final StringBuilder sb = new StringBuilder(d.length * 2);
            for (byte b : d) sb.append(Character.forDigit((b >> 4) & 15, 16)).append(Character.forDigit(b & 15, 16));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    /** The name the launcher shows for the app: the slow part. The package when it cannot be read or is empty. */
    static String name(PackageManager pm, Found f) {
        CharSequence name = null;
        try {
            name = f.info.loadLabel(pm);
        } catch (RuntimeException e) {
            // the package is the name then
        }
        return name != null && name.toString().trim().length() > 0 ? name.toString().trim() : f.pkg;
    }

    static void sort(List<Entry> list) {
        Collections.sort(list, new Comparator<Entry>() {
            public int compare(Entry a, Entry b) {
                int d = a.folded.compareTo(b.folded);
                return d != 0 ? d : a.pkg.compareTo(b.pkg);
            }
        });
    }

    /** The apps found, with a name each, by name. {@code known}: package to {name, stamp} of an earlier reading; a name whose stamp is the same is not read again. */
    static List<Entry> named(Context c, List<Found> found, Map<String, String[]> known, Map<String, String[]> now) {
        final ArrayList<Entry> out = new ArrayList<Entry>();
        final PackageManager pm = c == null ? null : c.getPackageManager();
        for (Found f : found) {
            final String[] was = known == null ? null : known.get(f.pkg);
            final String label = was != null && f.stamp.equals(was[1]) ? was[0] : pm == null ? f.pkg : name(pm, f);
            if (now != null) now.put(f.pkg, new String[] {label, f.stamp});
            out.add(new Entry(f.pkg, label));
        }
        sort(out);
        return out;
    }

    /** The apps with a launcher icon that are not part of the system, by name. Off the main thread: it asks the system for every label. Never null, never throws. */
    static List<Entry> load(Context c) {
        return named(c, scan(c), null, null);
    }

    /** The entries that match what was typed: every word of it is part of the name or of the package (accents and case ignored). All of them for an empty text. */
    static List<Entry> filter(List<Entry> all, String typed) {
        final String q = typed == null ? "" : MrMemStore.fold(typed.trim()).toLowerCase(java.util.Locale.ROOT);
        if (q.length() == 0) return all;
        final String[] parts = q.split("\\s+");
        ArrayList<Entry> out = new ArrayList<Entry>();
        for (Entry e : all) {
            final String hay = e.folded + " " + e.pkg.toLowerCase(java.util.Locale.ROOT);
            boolean every = true;
            for (String p : parts) {
                if (!hay.contains(p)) {
                    every = false;
                    break;
                }
            }
            if (every) out.add(e);
        }
        return out;
    }

    /** The name of an app by its package: the one the system gives, or the package itself when the app is not on the phone any more. Never null. */
    static String label(Context c, String pkg) {
        try {
            final PackageManager pm = c.getPackageManager();
            if (pm != null) {
                final CharSequence name = pm.getApplicationLabel(pm.getApplicationInfo(pkg, 0));
                if (name != null && name.toString().trim().length() > 0) return name.toString().trim();
            }
        } catch (PackageManager.NameNotFoundException e) {
            // removed: the package says which app it was
        } catch (RuntimeException e) {
            // the same
        }
        return pkg;
    }

    /** The icon of an app by its package, or null when it is not on the phone (the caller draws nothing). Loads a bitmap: not for hundreds at once. */
    static Drawable icon(Context c, String pkg) {
        try {
            final PackageManager pm = c.getPackageManager();
            return pm == null ? null : pm.getApplicationIcon(pkg);
        } catch (PackageManager.NameNotFoundException e) {
            return null;
        } catch (RuntimeException e) {
            return null;
        }
    }
}
