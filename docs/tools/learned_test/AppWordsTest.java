package com.mrkeyboard.app;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.view.inputmethod.EditorInfo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

/**
 * PC test of the words that are added for ONE app (MrApp): the key of the app in the store, the rules of the added words on it (caps, undo, forget, edit,
 * export, the blocked words that stay for every app), and what the keyboard does with it while it runs: the tree of the app in front is made off the main
 * thread when a field opens in that app, it is kept while the person is away until a field opens in another app, an app with no words costs a comparison
 * and a set lookup, the last request wins, and nothing breaks when the store fails. The screens are in AppScreensTest. Runs through docs/tools/run_java_tests.sh.
 */
public class AppWordsTest {
    static int ok = 0, fail = 0;
    static final String L = "pt_BR";
    static final String A = "com.whatsapp";
    static final String B = "com.example.notes";
    static final String C = "org.telegram.messenger";

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    static MrImport.Known known(String... words) {
        final HashSet<String> set = new HashSet<String>(Arrays.asList(words));
        return new MrImport.Known() {
            public boolean knows(String w) {
                return set.contains(w);
            }
        };
    }

    static final MrImport.Known PT = known("vou", "ver", "a", "o", "hoje");

    /** A context that only knows itself (the tree of the app keeps the application context). */
    static final class Ctx extends Context {
        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public android.content.res.Resources getResources() { return null; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
        public java.io.File getFilesDir() { return null; }
        public java.io.File getCacheDir() { return null; }
        public void startActivity(Intent intent) { }
    }

    static final Ctx CTX = new Ctx();

    static EditorInfo field(String pkg) {
        EditorInfo ei = new EditorInfo();
        ei.packageName = pkg;
        return ei;
    }

    /** A store that is slow, records the threads that read it, and can fail: it hands everything to a store in memory. */
    static final class Probe implements MrWordStore {
        final MrMemStore in = new MrMemStore();
        volatile long delayMs;
        volatile boolean failing;
        volatile int reads;
        final List<String> threads = new ArrayList<String>();

        private void note() {
            reads++;
            synchronized (threads) {
                threads.add(Thread.currentThread().getName());
            }
            if (failing) throw new RuntimeException("the database is not there");
            if (delayMs > 0) {
                try {
                    Thread.sleep(delayMs);
                } catch (InterruptedException e) {
                    // goes on
                }
            }
        }

        public int count(int kind, String locale) { return in.count(kind, locale); }
        public List<Row> list(int kind, String locale, String filter, int sort, int offset, int limit) { return in.list(kind, locale, filter, sort, offset, limit); }
        public List<Row> all(int kind, String locale) { note(); return in.all(kind, locale); }
        public long add(int kind, String locale, Row row) { return in.add(kind, locale, row); }
        public boolean delete(int kind, long id) { return in.delete(kind, id); }
        public int deleteAll(int kind, String locale) { return in.deleteAll(kind, locale); }
        public int deleteBatch(String locale, long batch) { return in.deleteBatch(locale, batch); }
        public long newBatch() { return in.newBatch(); }
        public List<String> locales() { return in.locales(); }
        public List<String> scopes() { note(); return in.scopes(); }
        public void begin() { in.begin(); }
        public void end() { in.end(); }
    }

    static void add(MrWordStore st, String pkg, String text) {
        MrLearned.apply(st, MrImport.parse(text, PT), L, pkg, 1000);
    }

    static boolean has(ExpandableDictionary d, String word) {
        return d != null && d.getWordFrequency(word) >= MrLearned.COMPLETE_MIN_FREQ;
    }

    static boolean waitFor(Probe p, long ms) {
        return MrApp.idle(ms);
    }

    public static void main(String[] args) throws Exception {
        keys();
        store();
        running();
        System.out.println();
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }

    // ---------------------------------------------------------------- the key of an app

    static void keys() {
        check("the key of an app is the language, a bar and the package", MrApp.scope(L, A).equals("pt_BR|com.whatsapp"));
        check("no package = the language itself (the words of every app)", MrApp.scope(L, null).equals(L));
        check("the language and the package come back out of the key", MrApp.localeOf("pt_BR|com.whatsapp").equals(L) && MrApp.packageOf("pt_BR|com.whatsapp").equals(A));
        check("a language alone has no package and is not the key of an app", MrApp.packageOf(L) == null && !MrApp.isScope(L) && MrApp.localeOf(L).equals(L) && MrApp.isScope("pt_BR|a.b"));
        check("a null key is neither", !MrApp.isScope(null) && MrApp.packageOf(null) == null && MrApp.localeOf(null) == null);
        check("a package is letters, digits, dots and underscores", MrApp.validPackage(A) && MrApp.validPackage("com.a_b.C9") && !MrApp.validPackage("") && !MrApp.validPackage(null)
                && !MrApp.validPackage("a|b") && !MrApp.validPackage("a b") && !MrApp.validPackage("a/b") && !MrApp.validPackage("é.a"));
        StringBuilder big = new StringBuilder();
        for (int i = 0; i < 256; i++) big.append('a');
        check("... and not more than 255 characters", MrApp.validPackage(big.substring(0, 255)) && !MrApp.validPackage(big.toString()));
        HashSet<String> pk = MrApp.packages(Arrays.asList("pt_BR|a.b", "en_US|a.b", "pt_BR|c.d", "pt_BR"));
        check("the packages of a list of keys: each one once, a language has none", pk.size() == 2 && pk.contains("a.b") && pk.contains("c.d"));
        check("... and a null list is an empty set", MrApp.packages(null).isEmpty());
    }

    // ---------------------------------------------------------------- the words of an app in the store

    static void store() {
        MrMemStore st = new MrMemStore();
        MrLearned.useStore(st);
        MrImport.Plan plan = MrImport.parse("[words]\nzapword\nnubankx\n[phrases]\nvou zapword\n", PT);
        MrLearned.Result r = MrLearned.apply(st, plan, L, A, 1000);
        check("words added for an app are saved under the key of the app", r.words == 2 && r.pairs >= 1 && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A)) == 2);
        check("... and none of them under the language (every app) or under another app", st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 0
                && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, B)) == 0 && MrLearned.counts(st, L)[MrWordStore.KIND_IMPORTED_WORD] == 0);
        check("the screens list the language without the apps (scopes() has the apps, locales() has not)", st.scopes().equals(Arrays.asList("pt_BR|com.whatsapp")) && st.locales().isEmpty());
        MrLearned.Result again = MrLearned.apply(st, plan, L, A, 1001);
        check("the same words for the same app again add nothing", again.total() == 0 && again.dupWords == 2 && again.batch == 0);
        MrLearned.Result other = MrLearned.apply(st, plan, L, B, 1002);
        check("... but they can be added for another app, and for every app", other.words == 2 && MrLearned.apply(st, plan, L, null, 1003).words == 2);
        check("the apps keep each its own list", st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A)) == 2 && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, B)) == 2
                && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 2);
        check("locales() lists the language once and scopes() the two apps", st.locales().equals(Arrays.asList(L)) && st.scopes().size() == 2);

        // undo
        check("undoing the batch of one app leaves the others", MrLearned.undo(st, MrApp.scope(L, A), r.batch) == r.words + r.pairs
                && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A)) == 0 && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, B)) == 2
                && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 2);
        check("an app with nothing left is gone from scopes()", st.scopes().equals(Arrays.asList("pt_BR|com.example.notes")));

        // delete all, edit, export
        check("forgetting everything added for an app leaves the others", MrLearned.deleteAllImported(st, MrApp.scope(L, B)) >= 2
                && st.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, B)) == 0 && st.count(MrWordStore.KIND_IMPORTED_WORD, L) == 2);
        MrMemStore s2 = new MrMemStore();
        MrLearned.useStore(s2);
        add(s2, A, "[words]\nzapword\nnubankx\t70\n[phrases]\nvou zapword\n");
        String text = MrLearned.exportApp(s2, L, A);
        check("the export of an app is the standard list, with the app as a comment", text.startsWith("# mr-words 1\n# language: pt-BR\n# app: com.whatsapp\n[words]\n") && text.contains("zapword\n")
                && text.contains("nubankx\t70\n") && text.contains("[phrases]\nvou zapword\n") && !text.contains("[blocked]"));
        MrMemStore s3 = new MrMemStore();
        MrLearned.apply(s3, MrImport.parse(text, PT), L, A, 2000);
        check("... and importing it again for the app gives the same text (it is also the backup)", MrLearned.exportApp(s3, L, A).equals(text));
        check("the export of an app does not have what the keyboard learned nor the words of every app", !MrLearned.exportApp(s3, L, B).contains("zapword"));
        List<MrWordStore.Row> rows = s2.all(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A));
        MrWordStore.Row z = null;
        for (MrWordStore.Row w : rows) if (w.a.equals("zapword")) z = w;
        check("editing a word of an app changes it there", z != null && MrLearned.edit(s2, MrApp.scope(L, A), z, "zapwordx") >= 0
                && has(MrApp.build(s2, CTX, L, A), "zapwordx") && !has(MrApp.build(s2, CTX, L, A), "zapword"));

        // blocked words
        MrMemStore s4 = new MrMemStore();
        MrLearned.useStore(s4);
        MrLearned.block(s4, L, "bloqueada", 1);
        MrLearned.Result b = MrLearned.apply(s4, MrImport.parse("[words]\nbloqueada\nlivre\n", PT), L, A, 3000);
        check("a word the person blocked is not added for an app either", b.words == 1 && b.blockedSkipped == 1 && s4.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A)) == 1);
        MrLearned.Result bl = MrLearned.apply(s4, MrImport.parse("[words]\nnova\n[blocked]\nlixo\n", PT), L, A, 3001);
        check("a [blocked] part of a list is not applied to an app (blocking is for every app)", bl.blocked == 0 && s4.count(MrWordStore.KIND_BLOCKED, L) == 1 && s4.count(MrWordStore.KIND_BLOCKED, MrApp.scope(L, A)) == 0);
        MrLearned.Result gl = MrLearned.apply(s4, MrImport.parse("[words]\nnova2\n[blocked]\nlixo\n", PT), L, null, 3002);
        check("... while the list for every app still blocks them", gl.blocked == 1 && s4.count(MrWordStore.KIND_BLOCKED, L) == 2);

        // caps
        StringBuilder many = new StringBuilder("[words]\n");
        for (int i = 0; i < MrApp.MAX_WORDS + 50; i++) many.append("palavra").append(letters(i)).append('\n');
        MrMemStore s5 = new MrMemStore();
        MrLearned.Result cap = MrLearned.apply(s5, MrImport.parse(many.toString(), PT), L, A, 4000);
        check("an app holds at most " + MrApp.MAX_WORDS + " words (the rest is counted as left out)", cap.words == MrApp.MAX_WORDS && cap.cappedWords >= 50
                && s5.count(MrWordStore.KIND_IMPORTED_WORD, MrApp.scope(L, A)) == MrApp.MAX_WORDS);
        check("... and that cap is its own: another app has all of its room", MrLearned.apply(s5, MrImport.parse("[words]\noutra\n", PT), L, B, 4001).words == 1);
        check("the caps of an app are smaller than the ones of every app", MrApp.MAX_WORDS <= MrLearned.IMPORT_MAX_WORDS && MrApp.MAX_PAIRS <= MrLearned.IMPORT_MAX_PAIRS);

        // the tree of an app
        MrMemStore s6 = new MrMemStore();
        MrLearned.useStore(s6);
        add(s6, A, "[words]\nzapword\n[phrases]\nvou zapword\n");
        MrLearned.refreshBlocked(s6, L);
        ExpandableDictionary tree = MrApp.build(s6, CTX, L, A);
        check("the tree of an app has its words (and they complete: frequency 6 or more) and its pairs", tree != null && has(tree, "zapword") && !has(tree, "outra")
                && tree.stubType == 3 && tree.stubPairs.size() == 1 && tree.stubPairs.get(0)[0].equals("vou") && tree.stubPairs.get(0)[1].equals("zapword"));
        check("an app with nothing has no tree at all (null, not an empty one)", MrApp.build(s6, CTX, L, B) == null && MrApp.build(s6, CTX, "en_US", A) == null);
        MrLearned.block(s6, L, "zapword", 5);
        MrLearned.refreshBlocked(s6, L);       // what the keyboard does when it loads its dictionaries
        ExpandableDictionary t2 = MrApp.build(s6, CTX, L, A);
        check("a word that is blocked is left out of the tree, and so is the pair that has it", t2 == null || (!has(t2, "zapword") && t2.stubPairs.isEmpty()));
        MrLearned.refreshBlocked(new MrMemStore(), L);
    }

    static String letters(int n) {
        StringBuilder sb = new StringBuilder();
        do {
            sb.append((char) ('a' + n % 26));
            n /= 26;
        } while (n > 0);
        return sb.toString();
    }

    // ---------------------------------------------------------------- the keyboard

    static WordComposer typed(String s) {
        WordComposer w = new WordComposer();
        for (int i = 0; i < s.length(); i++) w.add(s.charAt(i), new int[] {s.charAt(i)});
        return w;
    }

    static void running() throws Exception {
        final Probe st = new Probe();
        MrLearned.useStore(st);
        MrApp.resetForTest();

        // nothing added for any app: one read, and then the fields of other apps cost nothing
        MrApp.onLoad(CTX, L);
        MrApp.onInput(CTX, field(A));
        check("the first field reads which apps have words (off the main thread) and finds none", MrApp.idle(5000) && MrApp.dictionary() == null && MrApp.sBuilds == 1);
        int reads = st.reads, builds = MrApp.sBuilds;
        for (int i = 0; i < 200; i++) MrApp.onInput(CTX, field(i % 2 == 0 ? B : C));
        check("with no words for any app, 200 fields in other apps read nothing and start no thread", st.reads == reads && MrApp.sBuilds == builds && MrApp.idle(1));
        MrApp.onInput(CTX, null);
        MrApp.onInput(CTX, field(null));
        MrApp.onInput(CTX, field(""));
        check("a field without a package changes nothing (and does not throw)", MrApp.current().equals(C) || MrApp.current().equals(B));
        check("the words of the keyboard are asked and answered with no tree", MrApp.isValid("zapword") == false && noTreeCallsAreSafe());

        // words for A and B
        add(st, A, "[words]\nzapword\n[phrases]\nvou zapword\n");
        add(st, B, "[words]\nnotinha\n");
        MrApp.dataChanged();
        check("a change of the added words reads the apps again (the app in front has none yet)", MrApp.idle(5000) && MrApp.dictionary() == null);
        st.threads.clear();
        MrApp.onInput(CTX, field(A));
        check("a field of an app that has words makes its tree, in a thread that is not the main one", MrApp.idle(5000) && has(MrApp.dictionary(), "zapword") && !has(MrApp.dictionary(), "notinha")
                && onlyThread(st, "MrApp"));
        ExpandableDictionary treeA = MrApp.dictionary();
        check("the keyboard finds the words of the app: valid, asked for completions and for next words", MrApp.isValid("zapword") && !MrApp.isValid("notinha")
                && asked(treeA));
        builds = MrApp.sBuilds;
        reads = st.reads;
        MrApp.onInput(CTX, field(A));
        MrApp.onInput(CTX, field(A));
        check("another field of the same app does nothing (the same tree, no read, no thread)", MrApp.dictionary() == treeA && MrApp.sBuilds == builds && st.reads == reads);
        MrApp.onInput(CTX, null);
        MrApp.onInput(CTX, field(null));
        check("... and so does a field with no package: the tree stays", MrApp.dictionary() == treeA);

        // another app
        MrApp.onInput(CTX, field(C));
        check("a field of another app without words lets the tree go at once, with no thread", MrApp.dictionary() == null && MrApp.sBuilds == builds && !MrApp.isValid("zapword"));
        MrApp.onInput(CTX, field(B));
        check("a field of another app with words replaces it with its own", MrApp.idle(5000) && has(MrApp.dictionary(), "notinha") && !has(MrApp.dictionary(), "zapword"));
        MrApp.onInput(CTX, field(A));
        check("coming back to the first app makes its tree again", MrApp.idle(5000) && has(MrApp.dictionary(), "zapword") && !has(MrApp.dictionary(), "notinha"));
        ExpandableDictionary back = MrApp.dictionary();

        // the person goes away and comes back: no field opened in between
        for (int i = 0; i < 50; i++) MrApp.words(typed("zap"), null, null);
        check("while the person is away from the app (no field opens), the tree is kept", MrApp.dictionary() == back && MrApp.current().equals(A));
        MrApp.onInput(CTX, field(A));
        check("... and it is the same one when a field of the app opens again", MrApp.dictionary() == back);

        // a slow store: the keyboard is not held, and the last request wins
        st.delayMs = 120;
        long t0 = System.currentTimeMillis();
        MrApp.onInput(CTX, field(B));
        MrApp.onInput(CTX, field(A));
        MrApp.onInput(CTX, field(B));
        long took = System.currentTimeMillis() - t0;
        check("the field does not wait for the store (three fields in a row take far less than one read)", took < 60);
        check("... the old tree is gone while the new one is made (the words of A do not show up in B)", MrApp.dictionary() == null || !has(MrApp.dictionary(), "zapword"));
        check("... and what is published at the end is the tree of the last field, only", MrApp.idle(8000) && has(MrApp.dictionary(), "notinha") && !has(MrApp.dictionary(), "zapword"));
        st.delayMs = 0;

        // the language of the keyboard changes
        MrApp.onLoad(CTX, "en_US");
        check("when the language changes the tree is made again for it (this app has no words in it)", MrApp.idle(5000) && MrApp.dictionary() == null);
        MrApp.onLoad(CTX, L);
        check("... and when the language comes back, so do the words", MrApp.idle(5000) && has(MrApp.dictionary(), "notinha"));

        // blocked word
        MrLearned.block(st, L, "notinha", 9);
        MrLearned.refreshBlocked(st, L);
        MrApp.onLoad(CTX, L);
        check("when the blocked words change the keyboard loads again and the tree leaves the word out", MrApp.idle(5000) && (MrApp.dictionary() == null || !has(MrApp.dictionary(), "notinha")));
        MrLearned.refreshBlocked(new MrMemStore(), L);

        // words are saved while the app is in front
        MrApp.onInput(CTX, field(A));
        MrApp.idle(5000);
        add(st, A, "[words]\nnovinha\n");
        MrApp.dataChanged();
        check("words added while the app is in front are in the tree when the save ends", MrApp.idle(5000) && has(MrApp.dictionary(), "novinha") && has(MrApp.dictionary(), "zapword"));
        MrLearned.deleteAllImported(st, MrApp.scope(L, A));
        MrApp.dataChanged();
        check("forgetting them takes the tree away (and the app leaves the list of apps)", MrApp.idle(5000) && MrApp.dictionary() == null);
        builds = MrApp.sBuilds;
        reads = st.reads;
        MrApp.onInput(CTX, field(C));
        MrApp.onInput(CTX, field(A));
        check("... and a field of that app does not make anything any more", MrApp.dictionary() == null && MrApp.sBuilds == builds && st.reads == reads);

        // the store fails
        st.failing = true;
        MrApp.dataChanged();
        boolean threw = false;
        try {
            MrApp.onInput(CTX, field(B));
            MrApp.onLoad(CTX, L);
            MrApp.dataChanged();
        } catch (Throwable t) {
            threw = true;
        }
        check("a store that fails costs the app words only: nothing is thrown and the thread ends", !threw && MrApp.idle(5000) && MrApp.dictionary() == null);
        st.failing = false;
        MrApp.onInput(CTX, field(C));
        MrApp.onInput(CTX, field(B));
        check("... and the next field reads again, with the words back", MrApp.idle(5000) && has(MrApp.dictionary(), "notinha"));

        // no store at all
        MrLearned.useStore(null);
        MrApp.resetForTest();
        boolean ok2 = true;
        try {
            MrApp.onLoad(null, L);
            MrApp.onInput(null, field(A));
            MrApp.dataChanged();
            ok2 = MrApp.idle(5000);
        } catch (Throwable t) {
            ok2 = false;
        }
        check("with no context and no store nothing is thrown", ok2 && MrApp.dictionary() == null);
        MrLearned.useStore(new MrMemStore());
        MrApp.resetForTest();
    }

    static boolean onlyThread(Probe st, String name) {
        synchronized (st.threads) {
            if (st.threads.isEmpty()) return false;
            for (String t : st.threads) if (!t.equals(name)) return false;
            return true;
        }
    }

    static boolean noTreeCallsAreSafe() {
        try {
            MrApp.words(typed("zap"), null, null);
            MrApp.getBigrams(typed(""), "vou", null, null);
            return MrApp.dictionary() == null;
        } catch (Throwable t) {
            return false;
        }
    }

    static boolean asked(ExpandableDictionary tree) {
        int w = tree.stubWordsAsked, b = tree.stubBigramsAsked;
        MrApp.words(typed("zap"), null, null);
        MrApp.getBigrams(typed(""), "vou", null, null);
        return tree.stubWordsAsked == w + 1 && tree.stubBigramsAsked == b + 1 && "vou".equals(String.valueOf(tree.stubLastPrevious));
    }
}
