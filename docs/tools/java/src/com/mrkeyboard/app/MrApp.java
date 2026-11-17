package com.mrkeyboard.app;

import android.content.Context;
import android.view.inputmethod.EditorInfo;

import java.util.HashSet;
import java.util.List;

/**
 * Words and phrases that the person added for ONE app (screen "Add words and texts", choice "Add to": all apps, or an app from the list).
 *
 * Storage: the same rows as the words added for every app (imported words and pairs of MrWordStore), with the app in the key that holds the
 * language: "pt_BR|com.whatsapp" (scope(locale, pkg)). Nothing new in the database, and every rule of the added words (batches, undo, forget, edit,
 * caps) works on a scope as it does on a language.
 *
 * On the keyboard: the words of the app in front are one small tree (an ExpandableDictionary, the same class and the same search as the
 * words the keyboard learned), made in a thread and published in one step, so the keyboard thread reads either the whole tree or none and
 * never waits for it:
 *  - a field opens (LatinIME.onStartInput -> {@link #onInput}): when it is in another app than the last field, the tree of the last one is let go
 *    and the new one is made (only when that app has words). A field of the same app does nothing (one comparison). The tree is kept while the person
 *    is away from the app, also when the keyboard did not open in between and the person comes back, until a field opens in another app;
 *  - the typing asks the tree after AutoDictionary ({@link #words}: completions and corrections, with the same gate of frequency 6), asks it whether
 *    a word is valid ({@link #isValid}: the word is not corrected away) and asks it for the next words after a word ({@link #getBigrams}, called by
 *    UserBigramDictionary); gesture typing reads its words too (MrGestureWords);
 *  - the language of the keyboard changing makes the tree again (MrLearned.load -> {@link #onLoad}); a change of the added words, too ({@link #dataChanged}).
 * Which apps have words at all is read once per process (and after a change): while no app has any, a field that opens in another app costs
 * one comparison, one set lookup and nothing else: no thread, no query, no tree.
 * Only one thread at a time makes a tree; a request that arrives while it works is answered when it ends, from the state of that moment
 * (the old answer is never published).
 */
public final class MrApp {
    private MrApp() { }

    /** Between the language and the package in the key. Neither "pt_BR" nor a package name can have it. */
    static final char SEP = '|';
    /** Per app and language: smaller than the caps of the words for every app (MrLearned.IMPORT_MAX_*), because the whole list is in memory while the app is in front. */
    static final int MAX_WORDS = 5000;
    static final int MAX_PAIRS = 10000;
    /** The kind of dictionary of the tree: the one of the added words (Suggest.DIC_AUTO). */
    private static final int DIC_TYPE = 3;
    /** A word of the tree completes what is typed from this frequency on (the gate of AutoDictionary). */
    private static final int MIN_FREQ = 6;

    // ------------------------------------------------------------------ the key

    /** "pt_BR" + "com.whatsapp" -> "pt_BR|com.whatsapp". */
    static String scope(String locale, String pkg) {
        return pkg == null ? locale : locale + SEP + pkg;
    }

    /** Is this key the one of an app (and not of a language)? */
    static boolean isScope(String key) {
        return key != null && key.indexOf(SEP) >= 0;
    }

    /** The language of a key ("pt_BR|com.whatsapp" -> "pt_BR"; a language stays). */
    static String localeOf(String key) {
        int i = key == null ? -1 : key.indexOf(SEP);
        return i < 0 ? key : key.substring(0, i);
    }

    /** The package of a key, or null for a language. */
    static String packageOf(String key) {
        int i = key == null ? -1 : key.indexOf(SEP);
        return i < 0 ? null : key.substring(i + 1);
    }

    /** A package name as Android writes it: letters, digits, dots and underscores. Anything else is not an app of the list. */
    static boolean validPackage(String pkg) {
        if (pkg == null || pkg.length() == 0 || pkg.length() > 255) return false;
        for (int i = 0; i < pkg.length(); i++) {
            char c = pkg.charAt(i);
            if (!(c >= 'a' && c <= 'z') && !(c >= 'A' && c <= 'Z') && !(c >= '0' && c <= '9') && c != '.' && c != '_') return false;
        }
        return true;
    }

    // ------------------------------------------------------------------ what is in front

    /** The app of the last field and the language of the dictionaries; the state of the tree. Read and written under the lock of the class. */
    private static String sPkg;
    private static String sLocale;
    private static Context sCtx;
    /** The packages that have words of their own (any language); null = not read yet, or a change made it stale. */
    private static HashSet<String> sApps;
    /** The tree of the app in front, or null. The keyboard thread only reads it. */
    private static volatile ExpandableDictionary sDict;
    private static int sGen;
    private static boolean sRunning;
    /** How many trees were made since the process began (the tests and the diagnosis read it). */
    static volatile int sBuilds;

    /**
     * LatinIME.onStartInput: a field opened. Main thread, called for every field; it only works when the app is not the one of the last field.
     * Never throws.
     */
    public static void onInput(Context c, EditorInfo ei) {
        try {
            final String pkg = ei == null ? null : ei.packageName;
            if (pkg == null || pkg.length() == 0) return;
            synchronized (MrApp.class) {
                if (pkg.equals(sPkg)) return;
                sPkg = pkg;
                if (sCtx == null && c != null) sCtx = c.getApplicationContext();
                drop();           // the words of the last app do not show up in this one, not even while its own are being made
                if (sApps != null && !sApps.contains(pkg)) return;   // this app has no words of its own
            }
            request();
        } catch (Throwable t) {
            // a field without the words of its app is still a field
        }
    }

    /**
     * MrLearned.load: the dictionaries of the keyboard were loaded for this language (at the start, when the language changes, when the added or
     * the blocked words changed: the tree is made again, because it leaves the blocked words out). Runs on the thread that loads them.
     */
    static void onLoad(Context c, String locale) {
        try {
            if (locale == null) return;
            synchronized (MrApp.class) {
                if (sCtx == null && c != null) sCtx = c.getApplicationContext();
                sLocale = locale;
                if (sPkg == null) return;                       // no field yet: the first one makes the tree
                if (sApps != null && !sApps.contains(sPkg)) return;   // the app in front has no words: nothing to make
            }
            request();
        } catch (Throwable t) {
            // the tree is made at the next field
        }
    }

    /** The added words changed (a save, an undo, a forget, an edit, a delete): the list of apps and the tree of the app in front are read again. */
    static void dataChanged() {
        try {
            synchronized (MrApp.class) {
                sApps = null;
                if (sPkg == null || sCtx == null) return;
            }
            request();
        } catch (Throwable t) {
            // read again at the next field
        }
    }

    /** The tree of the app in front is let go (no words for this app). Under the lock. */
    private static void drop() {
        sGen++;                      // a tree that is being made for the app that was in front is not published any more
        if (sDict != null) {
            sDict = null;
            MrGestureWords.changed();
        }
    }

    /** Asks for the tree of the state of now; starts the thread when none is working. */
    private static void request() {
        synchronized (MrApp.class) {
            sGen++;
            if (sRunning) return;
            sRunning = true;
        }
        Thread th = new Thread(new Runnable() {
            public void run() {
                work();
            }
        }, "MrApp");
        th.setPriority(Thread.MIN_PRIORITY);
        th.start();
    }

    private static void work() {
        try {
            while (true) {
                final String pkg;
                final String locale;
                final int gen;
                final Context c;
                synchronized (MrApp.class) {
                    pkg = sPkg;
                    locale = sLocale;
                    gen = sGen;
                    c = sCtx;
                }
                HashSet<String> apps = null;
                ExpandableDictionary tree = null;
                try {
                    final MrWordStore st = MrLearned.store(c);
                    if (st != null) {
                        apps = packages(st.scopes());
                        if (pkg != null && locale != null && apps.contains(pkg)) tree = build(st, c, locale, pkg);
                    }
                } catch (Throwable t) {
                    apps = null;
                    tree = null;
                }
                synchronized (MrApp.class) {
                    if (gen != sGen) continue;            // asked again while this was working: again, from the state of now
                    sApps = apps;
                    ExpandableDictionary before = sDict;
                    sDict = tree;
                    if (before != null || tree != null) MrGestureWords.changed();
                    sBuilds++;
                    sRunning = false;
                    return;
                }
            }
        } catch (Throwable t) {
            synchronized (MrApp.class) {
                sRunning = false;
            }
        }
    }

    /** The packages of a list of keys ("pt_BR|com.whatsapp" -> "com.whatsapp"). */
    static HashSet<String> packages(List<String> scopes) {
        HashSet<String> set = new HashSet<String>();
        if (scopes == null) return set;
        for (String s : scopes) {
            String p = packageOf(s);
            if (p != null && p.length() > 0) set.add(p);
        }
        return set;
    }

    /** The tree of an app and a language: its added words and pairs (not the blocked ones), or null when there are none. Runs off the main thread. */
    static ExpandableDictionary build(MrWordStore st, Context c, String locale, String pkg) {
        final String key = scope(locale, pkg);
        final List<MrWordStore.Row> words = st.all(MrWordStore.KIND_IMPORTED_WORD, key);
        final List<MrWordStore.Row> pairs = st.all(MrWordStore.KIND_IMPORTED_PAIR, key);
        if (words.isEmpty() && pairs.isEmpty()) return null;
        // the blocked words are the ones of the language (MrLearned.refreshBlocked ran for it when its dictionaries loaded)
        final ExpandableDictionary tree = new ExpandableDictionary(c, DIC_TYPE);
        for (MrWordStore.Row r : words) {
            if (r.a != null && !MrLearned.isBlocked(r.a)) tree.addWord(r.a, MrLearned.wordFreq(r.freq));
        }
        for (MrWordStore.Row r : pairs) {
            if (r.a != null && r.b != null && !MrLearned.isBlocked(r.a) && !MrLearned.isBlocked(r.b)) {
                tree.setBigram(r.a, r.b, MrLearned.pairFreq(r.freq));
            }
        }
        return tree;
    }

    // ------------------------------------------------------------------ what the keyboard asks

    /**
     * AutoDictionary.getWords, after its own words: the words of the app in front that complete or correct what is typed. {@code gate} is the callback
     * of AutoDictionary (the words under frequency 6 are held back). Nothing at all when the app has no words.
     */
    public static void words(WordComposer composer, Dictionary.WordCallback gate, int[] nextLetters) {
        final ExpandableDictionary d = sDict;
        if (d == null) return;
        d.getWords(composer, gate, nextLetters);
    }

    /** AutoDictionary.isValidWord, when the word is not one of its own: is it one of the words of the app in front? */
    public static boolean isValid(CharSequence word) {
        final ExpandableDictionary d = sDict;
        return d != null && word != null && d.getWordFrequency(word) >= MIN_FREQ;
    }

    /** UserBigramDictionary.getBigrams, after its own pairs: what the person added for the app in front as the words that follow {@code previous}. */
    public static void getBigrams(WordComposer composer, CharSequence previous, Dictionary.WordCallback callback, int[] nextLetters) {
        final ExpandableDictionary d = sDict;
        if (d == null) return;
        d.getBigrams(composer, previous, callback, nextLetters);
    }

    /** The tree of the app in front for gesture typing (MrGestureWords reads its words), or null. */
    static ExpandableDictionary dictionary() {
        return sDict;
    }

    /** The app of the last field (null before the first one). */
    static synchronized String current() {
        return sPkg;
    }

    /** Tests only: forgets everything, as a new process. Waits for the thread that is working, if any. */
    static void resetForTest() {
        long end = System.currentTimeMillis() + 10000;
        while (System.currentTimeMillis() < end) {
            synchronized (MrApp.class) {
                if (!sRunning) break;
            }
            try {
                Thread.sleep(2);
            } catch (InterruptedException e) {
                break;
            }
        }
        synchronized (MrApp.class) {
            sPkg = null;
            sLocale = null;
            sCtx = null;
            sApps = null;
            sDict = null;
            sGen = 0;
            sRunning = false;
            sBuilds = 0;
        }
    }

    /** Tests only: waits until no thread is working. */
    static boolean idle(long timeoutMs) {
        long end = System.currentTimeMillis() + timeoutMs;
        while (System.currentTimeMillis() < end) {
            synchronized (MrApp.class) {
                if (!sRunning) return true;
            }
            try {
                Thread.sleep(2);
            } catch (InterruptedException e) {
                return false;
            }
        }
        return false;
    }
}
