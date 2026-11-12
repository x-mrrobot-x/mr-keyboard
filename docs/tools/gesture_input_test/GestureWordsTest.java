package com.mrkeyboard.app;

import java.lang.reflect.Field;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;

/**
 * PC test of the words of the person in gesture typing (MrGestureWords, 1.96.0): the copy of the learned and added words that
 * the recognition searches as a second dictionary.
 *
 * What it checks: the frequency a word gets in the copy; the dictionary written (read back here by a reader of the format that
 * is not the lib's: every word, every frequency, every byte of the buffer accounted for; characters of one and of three bytes;
 * a group that is full; no words); which words are read from the trees of the keyboard (the frequency from which a learned word
 * counts, the blocked ones, a word in both trees, too many words); and when the copy is made again (a word added, a tree
 * thrown away, the blocked words read, another language, a tree still being loaded).
 *
 * The lib reading this dictionary is the job of docs/tools/e2e/GestureInputE2E.java (and, with a second writer, of
 * engine/test/java/.../JniSmoke.java).
 */
public class GestureWordsTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("  FAIL " + what); }
    }

    // ---------------------------------------------------------------- a reader of the format, for the test
    static int visited;

    /** Every word of a dictionary of the main.dict format (two-byte header, pair lists empty) and its frequency; null if it is not one. */
    static Map<String, Integer> read(ByteBuffer b) {
        if (b == null || !b.isDirect() || b.capacity() < 3 || (b.get(0) & 0xFF) != 200 || b.get(1) != 1) return null;
        Map<String, Integer> out = new LinkedHashMap<String, Integer>();
        visited = 2;
        try {
            if (!group(b, 2, "", out, 0)) return null;
        } catch (IndexOutOfBoundsException e) {
            return null;
        }
        return visited == b.capacity() ? out : null;          // every byte belongs to the header or to an entry
    }

    static boolean group(ByteBuffer b, int pos, String prefix, Map<String, Integer> out, int depth) {
        if (depth > 60) return false;
        final int count = b.get(pos++) & 0xFF;
        visited++;
        if (count == 0) return false;                          // the writer never leaves an empty group
        for (int i = 0; i < count; i++) {
            int c = b.get(pos++) & 0xFF;
            visited++;
            if (c == 0xFF) {
                c = ((b.get(pos) & 0xFF) << 8) | (b.get(pos + 1) & 0xFF);
                pos += 2;
                visited += 2;
                if (c < 0xFF) return false;                    // the short form was due
            }
            final int flags = b.get(pos) & 0xFF;
            int kids = 0;
            if ((flags & 0x40) != 0) {
                kids = ((flags & 0x3F) << 16) | ((b.get(pos + 1) & 0xFF) << 8) | (b.get(pos + 2) & 0xFF);
                pos += 3;
                visited += 3;
                if (kids <= pos - 1) return false;             // a group comes after the entry that points to it
            } else {
                pos += 1;
                visited++;
            }
            final String word = prefix + (char) c;
            if ((flags & 0x80) != 0) {
                final int freq = b.get(pos++) & 0xFF;
                if (b.get(pos++) != 0) return false;           // no pairs
                visited += 2;
                if (out.put(word, freq) != null) return false;
            } else if (kids == 0) {
                return false;                                  // an entry that ends no word and leads nowhere
            }
            if (kids != 0 && !group(b, kids, word, out, depth + 1)) return false;
        }
        return true;
    }

    static ByteBuffer build(Object... wordsAndFreqs) {
        final int n = wordsAndFreqs.length / 2;
        String[] w = new String[n];
        int[] f = new int[n];
        for (int i = 0; i < n; i++) {
            w[i] = (String) wordsAndFreqs[2 * i];
            f[i] = (Integer) wordsAndFreqs[2 * i + 1];
        }
        return MrGestureWords.build(w, f, n);
    }

    static void blocked(String... words) throws Exception {
        Field f = MrLearned.class.getDeclaredField("sBlocked");
        f.setAccessible(true);
        f.set(null, new HashSet<String>(Arrays.asList(words)));
    }

    /** The keyboard service of the test: only the suggestion engine, which holds the two dictionaries. */
    static class Ime extends LatinIME {
        Suggest s = new Suggest();
        boolean fail;
        @Override public Suggest mrSuggest() {
            if (fail) throw new IllegalStateException("suggest");
            return s;
        }
    }

    /** A dictionary that is not a tree of words (the keyboard has none of these in the two places, but the type allows it). */
    static class Other extends Dictionary {
        public void getWords(WordComposer composer, WordCallback callback, int[] next) { }
        public boolean isValidWord(CharSequence word) { return true; }
    }

    public static void main(String[] a) throws Exception {
        // ---- A. the frequency in the copy
        check(MrGestureWords.FREQ_LOW == 100 && MrGestureWords.FREQ_HIGH == 130, "frequency: the measured range, 100 to 130 (docs/gesture-typing.md)");
        check(MrGestureWords.freq(6) == 100 && MrGestureWords.freq(0) == 100 && MrGestureWords.freq(-3) == 100, "frequency: a word just learned (6) or below: 100");
        check(MrGestureWords.freq(250) == 130 && MrGestureWords.freq(255) == 130 && MrGestureWords.freq(100000) == 130, "frequency: a word used often (250) or above: 130");
        check(MrGestureWords.freq(128) == 115 && MrGestureWords.freq(7) == 100 && MrGestureWords.freq(249) == 129, "frequency: in between, in proportion");
        boolean rising = true;
        for (int f = 1; f <= 255; f++) rising &= MrGestureWords.freq(f) >= MrGestureWords.freq(f - 1);
        check(rising, "frequency: it never goes down as the word is used more");

        // ---- B. the dictionary written
        check(MrGestureWords.build(null, null, 0) == null && MrGestureWords.build(new String[0], new int[0], 0) == null
                && MrGestureWords.build(new String[] {"a"}, new int[] {9}, 0) == null && MrGestureWords.build(new String[] {"a"}, null, 1) == null,
                "written: no words, no dictionary");
        ByteBuffer one = build("casa", 6);
        Map<String, Integer> m = read(one);
        check(one != null && one.isDirect() && one.capacity() == 2 + 3 * (1 + 1 + 3) + (1 + 1 + 1 + 2) && m != null && m.size() == 1 && m.get("casa") == 100,
                "written: one word, a direct buffer of exactly its size: " + (one == null ? -1 : one.capacity()) + " bytes, " + m);
        ByteBuffer some = build("casa", 6, "caso", 250, "Itapetinga", 128, "pé", 30, "ação", 255, "x", 6, "don't", 12, "guarda-chuva", 60, "a", 250, "as", 6, "asa", 128);
        m = read(some);
        check(m != null && m.size() == 11 && m.get("casa") == 100 && m.get("caso") == 130 && m.get("Itapetinga") == 115 && m.get("pé") == 102 && m.get("ação") == 130
                && m.get("x") == 100 && m.get("don't") == 100 && m.get("guarda-chuva") == 106 && m.get("a") == 130 && m.get("as") == 100 && m.get("asa") == 115,
                "written: every word comes back with its frequency (a word inside another, capitals, accents, ' and -): " + m);
        ByteBuffer wide = build("\u00ff\u00fe", 6, "\u0142\u00f3d\u017a", 250, "\u65e5\u672c", 128, "a\ud83d\ude00", 6);
        m = read(wide);
        check(m != null && m.size() == 4 && m.get("\u00ff\u00fe") == 100 && m.get("\u0142\u00f3d\u017a") == 130 && m.get("\u65e5\u672c") == 115 && m.get("a\ud83d\ude00") == 100,
                "written: characters from U+00FF on take three bytes and come back: " + m);
        m = read(build("casa", 6, "casa", 250, "casa", 30));
        check(m != null && m.size() == 1 && m.get("casa") == 130, "written: a word given twice keeps the larger frequency");
        char[] big = new char[49];
        Arrays.fill(big, 'a');
        String long48 = new String(big, 0, 48), long49 = new String(big);
        m = read(build("ok", 6, long49, 250, "", 250, null, 250, long48, 250));
        check(m != null && m.size() == 2 && m.get("ok") == 100 && m.get(long48) == 130, "written: an empty word and one of 49 characters are left out, one of 48 goes in");
        check(read(MrGestureWords.build(new String[] {"um", "dois", "tres"}, new int[] {6, 6, 6}, 2)).size() == 2, "written: only the first n words");
        check(build(long49, 6, "", 6) == null, "written: nothing but words that cannot go in: no dictionary");
        // a group holds 255 entries: the 256th different first letter does not fit, and neither does the word behind it
        String[] many = new String[300];
        int[] manyF = new int[300];
        for (int i = 0; i < 300; i++) {
            many[i] = (char) (0x4e00 + i) + "x";
            manyF[i] = 6;
        }
        m = read(MrGestureWords.build(many, manyF, 300));
        boolean first255 = m != null && m.size() == 255;
        for (int i = 0; i < 255 && first255; i++) first255 = m.containsKey(many[i]);
        check(first255, "written: a full group (255 first letters) keeps its words and the others are left out, with no trace: " + (m == null ? "unreadable" : "" + m.size()));
        many[299] = many[3].substring(0, 1) + "yz";      // one that shares a first letter still goes in
        m = read(MrGestureWords.build(many, manyF, 300));
        check(m != null && m.size() == 256 && m.containsKey(many[299]), "written: and a word that starts with a letter already there still goes in");
        // many words: every one comes back
        Random rnd = new Random(42);
        final int N = 20000;
        String[] lots = new String[N];
        int[] lotsF = new int[N];
        Map<String, Integer> want = new LinkedHashMap<String, Integer>();
        String letters = "abcdefghijklmnopqrstuvwxyz\u00e1\u00e9\u00ed\u00f3\u00fa\u00e3\u00f5\u00e7'-\u0142";
        for (int i = 0; i < N; i++) {
            StringBuilder sb = new StringBuilder();
            final int len = 2 + rnd.nextInt(11);
            for (int k = 0; k < len; k++) sb.append(letters.charAt(rnd.nextInt(letters.length())));
            lots[i] = sb.toString();
            lotsF[i] = rnd.nextInt(256);
            final int f = MrGestureWords.freq(lotsF[i]);
            final Integer had = want.get(lots[i]);
            if (had == null || had < f) want.put(lots[i], f);
        }
        long t0 = System.nanoTime();
        ByteBuffer lot = MrGestureWords.build(lots, lotsF, N);
        final double ms = (System.nanoTime() - t0) / 1e6;
        m = read(lot);
        check(m != null && m.equals(want), "written: " + N + " words come back, each with its frequency");
        System.out.printf("  %d words -> %d bytes, written in %.1f ms%n", want.size(), lot.capacity(), ms);
        // the size of a person's own words: read from a tree and written, as when a gesture begins after a change
        ExpandableDictionary tree = new ExpandableDictionary();
        for (int i = 0; i < 2000; i++) tree.addWord(lots[i], 6 + lotsF[i] % 250);
        double best = 1e9;
        ByteBuffer made = null;
        for (int round = 0; round < 30; round++) {
            t0 = System.nanoTime();
            MrGestureWords.Collector col = new MrGestureWords.Collector();
            col.read(tree.mrRoots(), MrGestureWords.LEARNED_MIN);
            col.keepBest(MrGestureWords.MAX_WORDS);
            made = MrGestureWords.build(col.words, col.freqs, col.n);
            best = Math.min(best, (System.nanoTime() - t0) / 1e6);
        }
        m = read(made);
        check(m != null && m.size() >= 1990 && m.size() <= 2000, "written: 2,000 words read from a tree and written: " + (m == null ? -1 : m.size()));
        System.out.printf("  %d words read from the tree and written: %d bytes, %.2f ms (the best of 30)%n", m.size(), made.capacity(), best);

        // ---- C. the words read from the trees of the keyboard
        blocked();
        ExpandableDictionary auto = new ExpandableDictionary(), user = new ExpandableDictionary();
        auto.addWord("itapetinga", 6);
        auto.addWord("vixe", 5);                           // typed, not yet a word the keyboard suggests
        auto.addWord("vixi", 30);
        auto.addWord("vix", 250);
        auto.addWord("Zeca", 12);
        user.addWord("Zeca", 250);                         // a word in both
        user.addWord("uai", 1);                            // the user dictionary has no floor
        user.addWord("so", 0);
        MrGestureWords.Collector c = new MrGestureWords.Collector();
        c.read(auto.mrRoots(), MrGestureWords.LEARNED_MIN);
        check(c.n == 4 && Arrays.asList(c.words).subList(0, 4).containsAll(Arrays.asList("itapetinga", "vixi", "vix", "Zeca")), "read: the learned words from frequency 6 on: " + c.n);
        c.read(user.mrRoots(), 0);
        int zeca = Arrays.asList(c.words).indexOf("Zeca");
        check(c.n == 6 && c.freqs[zeca] == 250 && Arrays.asList(c.words).containsAll(Arrays.asList("uai", "so")), "read: every word of the user dictionary; a word in both keeps the larger frequency");
        blocked("vixi", "zeca");
        c = new MrGestureWords.Collector();
        c.read(auto.mrRoots(), MrGestureWords.LEARNED_MIN);
        c.read(user.mrRoots(), 0);
        check(c.n == 4 && !Arrays.asList(c.words).contains("vixi") && !Arrays.asList(c.words).contains("Zeca"), "read: a blocked word is left out, in any capitals: " + c.n);
        blocked();
        c = new MrGestureWords.Collector();
        c.read(null, 0);
        c.read(new ExpandableDictionary().mrRoots(), 0);
        check(c.n == 0, "read: no tree, an empty tree");
        // a tree with something odd in it is read as far as it makes sense
        ExpandableDictionary odd = new ExpandableDictionary();
        odd.addWord("ok", 9);
        odd.mrRoots().length = 5;                          // a length larger than the array
        ExpandableDictionary.Node loop = odd.mrRoots().data[0];
        loop.children.data[0].children = odd.mrRoots();    // a branch that comes back to the root: ok, okok, okokok...
        c = new MrGestureWords.Collector();
        c.read(odd.mrRoots(), 0);
        int longest = 0;
        for (int i = 0; i < c.n; i++) longest = Math.max(longest, c.words[i].length());
        check(c.n == 24 && longest == 48, "read: a length larger than its array, an empty place and a branch that loops: read up to the longest word the lib takes: " + c.n + ", " + longest);
        // too many words: the ones of the highest frequency stay
        c = new MrGestureWords.Collector();
        for (int i = 0; i < 1000; i++) c.add("w" + i, i % 250);
        c.keepBest(100);
        int low = 255;
        for (int i = 0; i < c.n; i++) low = Math.min(low, c.freqs[i]);
        check(c.n == 100 && low == 225, "read: over the limit, the words of the highest frequency stay: " + c.n + " words, the lowest " + low);
        c = new MrGestureWords.Collector();
        for (int i = 0; i < 10; i++) c.add("w" + i, 50);
        c.add("top", 200);
        c.keepBest(4);
        check(c.n == 4 && c.words[0].equals("w0") && c.words[1].equals("w1") && c.words[2].equals("w2") && c.words[3].equals("top"),
                "read: with the same frequency, the first ones read stay: " + Arrays.asList(c.words).subList(0, c.n));
        c = new MrGestureWords.Collector();
        for (int i = 0; i < 10; i++) c.add("w" + i, 50);
        c.keepBest(10);
        check(c.n == 10, "read: at the limit nothing is dropped");
        c = new MrGestureWords.Collector();
        c.add(null, 9);
        c.add("", 9);
        c.add(long49, 9);
        check(c.n == 0, "read: no word, an empty word and a word too long are not words");

        // ---- D. the copy in use: when it is made again
        ExpandableDictionary.stubChanged = new Runnable() {
            public void run() { MrGestureWords.changed(); }    // what the real addWord and clearDictionary do first (smali)
        };
        MrGestureWords.resetForTest();
        check(MrGestureWords.get(null) == null, "copy: no keyboard service");
        Ime ime = new Ime();
        check(MrGestureWords.get(ime) == null && MrGestureWords.stats()[0] == 0, "copy: no dictionaries: none");
        ime.s.stubAuto = auto;
        ime.s.stubUser = user;
        ByteBuffer b1 = MrGestureWords.get(ime);
        m = read(b1);
        check(m != null && m.size() == 6 && m.get("itapetinga") == 100 && m.get("vixi") == 102 && m.get("vix") == 130 && m.get("Zeca") == 130 && m.get("uai") == 100
                && m.get("so") == 100 && !m.containsKey("vixe"), "copy: the words of the two trees, each with the frequency of the copy: " + m);
        long[] st = MrGestureWords.stats();
        check(st[0] == 6 && st[1] > 0 && st[2] == b1.capacity(), "copy: the count, the time and the size are kept");
        int asked = auto.stubReloadChecks;
        check(MrGestureWords.get(ime) == b1 && MrGestureWords.get(ime) == b1 && auto.stubReloadChecks == asked, "copy: nothing changed: the same buffer, and the trees are not even asked");
        auto.addWord("novidade", 7);
        ByteBuffer b2 = MrGestureWords.get(ime);
        check(b2 != b1 && read(b2).containsKey("novidade") && read(b2).size() == 7, "copy: a word learned: made again, with it");
        auto.addWord("vixe", 6);                           // typed once more: now the keyboard suggests it
        check(read(MrGestureWords.get(ime)).containsKey("vixe"), "copy: a word that reaches frequency 6 comes in");
        blocked("novidade");
        check(read(MrGestureWords.get(ime)).containsKey("novidade"), "copy: (the blocked set alone is not looked at on every gesture)");
        MrLearned.refreshBlocked(new MrMemStore(), "pt_BR");     // what the keyboard runs when it loads its dictionaries: the set is read again
        blocked("novidade");
        check(!read(MrGestureWords.get(ime)).containsKey("novidade"), "copy: when the keyboard reads the blocked words the copy is made again, without them");
        blocked();
        MrGestureWords.changed();
        // a tree being filled by its loading thread is not read
        ByteBuffer b3 = MrGestureWords.get(ime);
        auto.stubLoading = true;
        auto.addWord("carregando", 50);
        asked = auto.stubReloadChecks;
        check(MrGestureWords.get(ime) == b3 && auto.stubReloadChecks == asked + 1, "copy: while a tree is being loaded the copy there is stays in use");
        auto.stubLoading = false;
        ByteBuffer b4 = MrGestureWords.get(ime);
        check(b4 != b3 && read(b4).containsKey("carregando"), "copy: once it is loaded the copy is made again");
        // the user dictionary read again from Android: the tree is thrown away, then filled
        user.stubClear();
        check(read(MrGestureWords.get(ime)).size() == read(b4).size() - 2 && !read(MrGestureWords.get(ime)).containsKey("uai"), "copy: a tree thrown away: its words leave the copy");
        user.addWord("uai", 250);
        check(read(MrGestureWords.get(ime)).get("uai") == 130, "copy: and come back when it is filled again");
        // another language: other dictionary objects
        ByteBuffer pt = MrGestureWords.get(ime);
        ExpandableDictionary autoEs = new ExpandableDictionary(), userEs = new ExpandableDictionary();
        autoEs.stubLoading = true;
        ime.s.stubAuto = autoEs;
        ime.s.stubUser = userEs;
        check(MrGestureWords.get(ime) == null, "copy: another language still loading: no copy (never the words of the language before)");
        autoEs.stubLoading = false;
        autoEs.addWord("chido", 40);
        ByteBuffer es = MrGestureWords.get(ime);
        m = read(es);
        check(m != null && m.size() == 1 && m.containsKey("chido") && es != pt, "copy: another language: its own words");
        ime.s.stubAuto = auto;
        ime.s.stubUser = user;
        check(read(MrGestureWords.get(ime)).containsKey("itapetinga"), "copy: and back");
        // one of the two missing, or of another kind
        ime.s.stubUser = null;
        m = read(MrGestureWords.get(ime));
        check(m != null && m.containsKey("itapetinga") && !m.containsKey("uai"), "copy: without a user dictionary, the learned words alone");
        ime.s.stubAuto = new Other();
        ime.s.stubUser = user;
        m = read(MrGestureWords.get(ime));
        check(m != null && m.containsKey("uai") && !m.containsKey("itapetinga"), "copy: a dictionary that is not a tree of words is passed over");
        ime.s.stubAuto = new ExpandableDictionary();
        ime.s.stubUser = new ExpandableDictionary();
        check(MrGestureWords.get(ime) == null && MrGestureWords.stats()[0] == 0 && MrGestureWords.stats()[2] == 0, "copy: two empty trees: none");
        ime.fail = true;
        check(MrGestureWords.get(ime) == null, "copy: a fault while reading: none, and no exception");
        ime.fail = false;
        ime.s.stubAuto = auto;
        check(read(MrGestureWords.get(ime)).containsKey("itapetinga"), "copy: and the next call works");
        // the trees are held weakly: a language that is gone does not stay in memory because of the copy
        MrGestureWords.resetForTest();
        Ime gone = new Ime();
        gone.s.stubAuto = new ExpandableDictionary();
        ((ExpandableDictionary) gone.s.stubAuto).addWord("some", 99);
        check(MrGestureWords.get(gone) != null, "copy: (made)");
        java.lang.ref.WeakReference<Dictionary> ref = new java.lang.ref.WeakReference<Dictionary>(gone.s.stubAuto);
        gone.s.stubAuto = null;
        gone = null;
        for (int i = 0; i < 20 && ref.get() != null; i++) {
            System.gc();
            Thread.sleep(20);
        }
        check(ref.get() == null, "copy: it does not keep the dictionaries of a language that is gone");

        // ---- E. MrGesture.decode with a second dictionary, without the lib (-Dmr.native=off): no answer, no fault
        MrGesture.Result r = new MrGesture.Result();
        r.extra = 5;
        ByteBuffer dict = ByteBuffer.allocateDirect(64);
        float[] x = {0.1f, 0.2f}, y = {0.5f, 0.5f};
        int[] t = {0, 16};
        check(MrGesture.decode(dict, 64, b1, x, y, t, 2, "a", r) == -1 && r.count() == 0 && r.extra == 0 && !r.fromExtra(0), "decode: without the weights -1, with or without a second dictionary");
        check(MrGesture.decode(dict, 64, null, x, y, t, 2, null, r) == -1 && MrGesture.decode(dict, 64, x, y, t, 2, null, r) == -1, "decode: the second dictionary may be null");
        r.extra = 0b101;
        check(r.fromExtra(0) && !r.fromExtra(1) && r.fromExtra(2) && !r.fromExtra(15), "result: which words came from the second dictionary");

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
