package com.mrkeyboard.app;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

/**
 * Gesture typing, the recognition, through the APK's real classes (classes.dex -> jar) and the native lib compiled for the PC,
 * like the other classes of this folder: MrGesture (values, weights file, layout, previous word, results) over MrNative (which
 * hands the app's real letter tables to the lib) over libmrengine.so.
 *
 * What it checks, in the three languages, with the dictionaries of dicts/ and the gestures of gesture/test (real ones for
 * English and Spanish, synthetic for Portuguese; README.md there):
 *   - before the weights are open, and after they are closed, decode() answers -1 and nothing throws;
 *   - how many gestures give the right word first, and among the first three, does not fall under the floor of the language.
 *     The counts must be the ones mr_gesture_test prints for the same files (the C++ test uses letter tables of its own; here
 *     they are the app's);
 *   - the answer does not depend on the gestures before it, nor on closing and opening the weights;
 *   - use() opens in the background, like MrTrigram; bad arguments are refused;
 *   - the words of the person (1.96.0): the APK's own ExpandableDictionary, the tree the keyboard keeps learned and added
 *     words in, is filled with the words of each file through its real addWord (hand-edited smali: it must tell
 *     MrGestureWords that something changed), read by MrGestureWords, written as a small dictionary and searched by the lib
 *     as the second dictionary of each gesture: the words main.dict lacks now come first, the others keep their place.
 * It does not touch the keyboard: it drives MrGesture directly. The keyboard side (MrGestureInput, 1.96.0) has its own tests,
 * GestureInputTest and GestureInputE2E (docs/gesture-typing.md).
 *
 * Usage: java -Djava.library.path=<libs> -cp app.jar:stubs:. com.mrkeyboard.app.GestureTest <dicts dir> <gesture/encoder.bin> <gesture/test>
 *        -Dexplore=1 prints every gesture whose word did not come first.
 */
public class GestureTest {
    static final boolean EXPLORE = System.getProperty("explore") != null;
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("  FAIL " + what); }
    }

    static class Sample {
        String word, prev;
        float[] x, y;
        int[] t;
    }

    static char[] keys;
    static float[] xy;

    /** gestures_<language>.tsv: "# comment", one "@keys letter x y ..." line, then word TAB previous word TAB "x y t ...". */
    static List<Sample> load(File f) throws Exception {
        List<Sample> out = new ArrayList<Sample>();
        keys = null;
        for (String line : Files.readAllLines(f.toPath(), StandardCharsets.UTF_8)) {
            if (line.isEmpty() || line.startsWith("#")) continue;
            if (line.startsWith("@keys")) {
                String[] p = line.trim().split(" +");
                int n = (p.length - 1) / 3;
                keys = new char[n];
                xy = new float[2 * n];
                for (int i = 0; i < n; i++) {
                    keys[i] = p[1 + 3 * i].charAt(0);
                    xy[2 * i] = Float.parseFloat(p[2 + 3 * i]);
                    xy[2 * i + 1] = Float.parseFloat(p[3 + 3 * i]);
                }
                continue;
            }
            String[] c = line.split("\t", -1);
            String[] p = c[2].trim().split(" +");
            int n = p.length / 3;
            Sample s = new Sample();
            s.word = c[0];
            s.prev = c[1].isEmpty() ? null : c[1];
            s.x = new float[n];
            s.y = new float[n];
            s.t = new int[n];
            for (int i = 0; i < n; i++) {
                s.x[i] = Float.parseFloat(p[3 * i]);
                s.y[i] = Float.parseFloat(p[3 * i + 1]);
                s.t[i] = (int) Double.parseDouble(p[3 * i + 2]);
            }
            out.add(s);
        }
        return out;
    }

    /** Right word first / among the first three (words that differ only in upper and lower case count once), per gesture. */
    static int[] run(List<Sample> samples, ByteBuffer dict, int size, boolean context, List<String> firsts, boolean backwards) {
        return run(samples, dict, size, null, context, firsts, backwards);
    }

    /** Words of the last run that came from the second dictionary, and how many of them were not words of it. */
    static int fromExtra, wrongExtra;
    static java.util.Set<String> extraWords;

    /** The same with a second dictionary (the words of the person), or null. */
    static int[] run(List<Sample> samples, ByteBuffer dict, int size, ByteBuffer extra, boolean context, List<String> firsts, boolean backwards) {
        MrGesture.Result r = new MrGesture.Result();
        String[] words = new String[3];
        int first = 0, among3 = 0, unanswered = 0, withContext = 0, visited = 0;
        fromExtra = wrongExtra = 0;
        for (int k = 0; k < samples.size(); k++) {
            Sample s = samples.get(backwards ? samples.size() - 1 - k : k);
            int c = MrGesture.decode(dict, size, extra, s.x, s.y, s.t, s.x.length, context ? s.prev : null, r);
            if (c < 0) unanswered++;
            for (int i = 0; i < c; i++) {
                if (!r.fromExtra(i)) continue;
                fromExtra++;
                if (extraWords == null || !extraWords.contains(r.word(i))) wrongExtra++;
            }
            if (r.hadContext()) withContext++;
            visited = Math.max(visited, r.visited());
            int n = r.distinct(words);
            int at = -1;
            for (int i = 0; i < n; i++) if (MrGesture.sameIgnoringCase(words[i], s.word)) { at = i; break; }
            if (at == 0) first++;
            if (at >= 0) among3++;
            if (firsts != null) firsts.add(n > 0 ? words[0] : "");
            if (EXPLORE && at != 0 && !backwards && context) {
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < n; i++) sb.append(words[i]).append(' ');
                System.out.println("    " + s.word + (s.prev != null ? " (after " + s.prev + ")" : "") + " -> " + sb.toString().trim());
            }
        }
        return new int[] {first, among3, unanswered, withContext, visited};
    }

    public static void main(String[] a) throws Exception {
        File dicts = new File(a[0]), weights = new File(a[1]), data = new File(a[2]);
        // {language, right word first, among the first three, first without the previous word}: floors, two gestures under
        // what was measured when the files were added (in the comment of each line; the C++ test, the JNI test and this one
        // gave the same counts). They must not go down: a change that loses words has to explain itself and lower them here
        // and in engine/test/mr_gesture_test.cpp.
        // The last two: how many more words come first and among three when every word of the file is a word the person
        // taught the keyboard (1.96.0), at least; measured 20 and 21 (en-US), 8 and 8 (es), 0 and 0 (pt-BR: main.dict has them all).
        String[][] floors = {
            {"en-US", "254", "270", "248", "18", "19"},   // measured: 256, 272, 250 (of 300 gestures; 281 words are in the dictionary); with the words of the person 276 and 293
            {"es", "258", "274", "254", "6", "6"},        // measured: 260, 276, 256 (277 words); with the words of the person 268 and 284
            {"pt-BR", "286", "292", "281", "0", "0"},     // measured: 288, 294, 283 (300 words; synthetic gestures); with the words of the person the same
        };

        // the values the lib receives are the ones of MrGesture
        check(MrGesture.params().length == 6 && MrGesture.limits().length == 3, "six values and three limits");
        check(MrGesture.limits()[0] == MrGesture.BEAM && MrGesture.limits()[1] == MrGesture.MIN_KEYS && MrGesture.limits()[2] == MrGesture.NODE_BUDGET, "limits in order");
        check(MrGesture.RESULT_CHARS == 48 && MrGesture.MAX_RESULTS == 16 && MrGesture.INFO_SIZE == 66, "sizes equal to the lib's");

        // before the weights are open
        byte[] en = Files.readAllBytes(new File(dicts, "en-US/main.dict").toPath());
        ByteBuffer enBuf = ByteBuffer.allocateDirect(en.length);
        enBuf.put(en);
        enBuf.rewind();
        List<Sample> enSamples = load(new File(data, "gestures_en-US.tsv"));
        Sample one = enSamples.get(0);
        MrGesture.Result r = new MrGesture.Result();
        check(!MrGesture.ready(), "not ready before use()");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, null, r) == -1 && r.count() == 0, "decode before use(): -1");
        check(!MrGesture.useNow(new File(dicts, "en-US/main.dict")) && !MrGesture.ready(), "a file that is not weights does not open");
        check(!MrGesture.useNow(new File("/does/not/exist.bin")) && !MrGesture.ready(), "a missing file does not open");
        check(!MrGesture.useNow(null), "useNow(null) opens nothing");
        check(MrNative.ready(), "the native engine is loaded (libmrengine.so on java.library.path, contract " + MrNative.ENGINE_VERSION + ")");

        // layout before the weights: the two do not depend on each other
        check(MrGesture.setLayout(keys, xy), "setLayout before the weights are open");
        check(!MrGesture.setLayout(null, xy) && !MrGesture.setLayout(keys, new float[3]) && !MrGesture.setLayout(new char[1], new float[2]), "setLayout refuses bad arrays");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, null, r) == -1, "decode with layout and no weights: -1");
        check(MrGesture.setLayout(keys, xy), "setLayout again after the refused ones");

        long t0 = System.nanoTime();
        check(MrGesture.useNow(weights) && MrGesture.ready(), "useNow(" + weights + ")");
        System.out.printf("weights open in %.1f ms%n", (System.nanoTime() - t0) / 1e6);

        // bad arguments through the app class
        int c = MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, null, r);
        check(c >= 1 && c == r.count() && c <= MrGesture.MAX_RESULTS, "a real gesture gives words (" + c + ")");
        String firstWord = c > 0 ? r.word(0) : "";
        check(MrGesture.decode(null, en.length, one.x, one.y, one.t, one.x.length, null, r) == -1 && r.count() == 0, "null dictionary: -1 and no words left in the result");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, 0, null, r) == -1, "no points: -1");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length + 1, null, r) == -1, "more points than the arrays have: -1");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, MrGesture.MAX_TOUCHES + 1, null, r) == -1, "too many points: -1");
        check(MrGesture.decode(enBuf, en.length, null, one.y, one.t, one.x.length, null, r) == -1, "null x: -1");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, null, null) == -1, "null result: -1");
        float[] bad = one.x.clone();
        bad[1] = Float.NaN;
        check(MrGesture.decode(enBuf, en.length, bad, one.y, one.t, one.x.length, null, r) == -1 && r.count() == 0, "NaN coordinate: -1");
        StringBuilder longWord = new StringBuilder();
        for (int i = 0; i < 300; i++) longWord.append('a');
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, longWord, r) == c && !r.hadContext(), "an absurd previous word is no previous word");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, "", r) == c && !r.hadContext(), "an empty previous word is no previous word");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, "OF", r) >= 1 && r.hadContext(), "OF is looked up as of");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, "paris", r) >= 1 && r.hadContext(), "paris is looked up as Paris");
        check(MrGesture.decode(enBuf, en.length, one.x, one.y, one.t, one.x.length, "zzqzz", r) == c && !r.hadContext(), "a previous word the dictionary does not have");
        // only the first n points count
        float[] longer = java.util.Arrays.copyOf(one.x, one.x.length + 50), longerY = java.util.Arrays.copyOf(one.y, one.y.length + 50);
        int[] longerT = java.util.Arrays.copyOf(one.t, one.t.length + 50);
        check(MrGesture.decode(enBuf, en.length, longer, longerY, longerT, one.x.length, null, r) == c && r.word(0).equals(firstWord), "only the first n points of the arrays count");

        // distinct(): of the words that differ only in upper and lower case, the best stays
        MrGesture.Result d = new MrGesture.Result();
        String[] fake = {"the", "The", "tie", "THE", "Tie", "toe"};
        for (int i = 0; i < fake.length; i++) {
            fake[i].getChars(0, fake[i].length(), d.words, i * MrGesture.RESULT_CHARS);
            d.info[2 + 4 * i] = fake[i].length();
        }
        d.count = fake.length;
        String[] three = new String[3], ten = new String[10];
        check(d.distinct(three) == 3 && three[0].equals("the") && three[1].equals("tie") && three[2].equals("toe"), "distinct: the, tie, toe");
        check(d.distinct(ten) == 3 && d.distinct(new String[1]) == 1 && d.distinct(new String[0]) == 0, "distinct respects the size of the output");
        check(MrGesture.sameIgnoringCase("\u00C1rea", "\u00E1REA") && !MrGesture.sameIgnoringCase("area", "\u00E1rea") && !MrGesture.sameIgnoringCase("a", "ab"), "sameIgnoringCase keeps the accents apart");

        for (String[] fl : floors) {
            String lang = fl[0];
            byte[] bytes = Files.readAllBytes(new File(dicts, lang + "/main.dict").toPath());
            ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
            buf.put(bytes);
            buf.rewind();
            List<Sample> samples = load(new File(data, "gestures_" + lang + ".tsv"));
            check(keys != null && samples.size() == 300, lang + ": layout and 300 gestures (" + samples.size() + ")");
            check(MrGesture.setLayout(keys, xy), lang + ": setLayout (" + keys.length + " keys)");
            List<String> firsts = new ArrayList<String>(), firstsBack = new ArrayList<String>(), firstsAgain = new ArrayList<String>();
            t0 = System.nanoTime();
            int[] ctx = run(samples, buf, bytes.length, true, firsts, false);
            double ms = (System.nanoTime() - t0) / 1e6 / samples.size();
            int[] noCtx = run(samples, buf, bytes.length, false, null, false);
            System.out.printf("%-6s %d gestures: right word first in %d, among 3 in %d; without the previous word %d and %d; previous word found in %d; "
                    + "%.2f ms per gesture; at most %d dictionary entries read%n", lang, samples.size(), ctx[0], ctx[1], noCtx[0], noCtx[1], ctx[3], ms, ctx[4]);
            check(ctx[2] == 0 && noCtx[2] == 0, lang + ": every gesture answered");
            check(ctx[0] >= Integer.parseInt(fl[1]), lang + ": right word first in " + ctx[0] + ", floor " + fl[1]);
            check(ctx[1] >= Integer.parseInt(fl[2]), lang + ": right word among 3 in " + ctx[1] + ", floor " + fl[2]);
            check(noCtx[0] >= Integer.parseInt(fl[3]), lang + ": without the previous word, right word first in " + noCtx[0] + ", floor " + fl[3]);
            check(ctx[3] > samples.size() / 2 && noCtx[3] == 0, lang + ": the previous word is found in most gestures (" + ctx[3] + ")");
            check(ctx[4] <= MrGesture.NODE_BUDGET + 256, lang + ": dictionary entries read under the ceiling (" + ctx[4] + ")");
            // backwards: a gesture does not depend on the ones before it
            int[] back = run(samples, buf, bytes.length, true, firstsBack, true);
            java.util.Collections.reverse(firstsBack);
            check(back[0] == ctx[0] && back[1] == ctx[1] && firstsBack.equals(firsts), lang + ": the same answers with the gestures in the opposite order");
            // closed and opened again
            MrGesture.use(null);
            check(!MrGesture.ready() && MrGesture.decode(buf, bytes.length, samples.get(0).x, samples.get(0).y, samples.get(0).t, samples.get(0).x.length, null, r) == -1,
                    lang + ": use(null) closes; decode answers -1");
            MrGesture.use(weights);   // opens in the background
            long limit = System.currentTimeMillis() + 10000;
            while (!MrGesture.ready() && System.currentTimeMillis() < limit) Thread.sleep(2);
            check(MrGesture.ready(), lang + ": use() opens in the background");
            MrGesture.use(weights);   // already the file in use: nothing happens
            check(MrGesture.ready(), lang + ": use() of the file in use keeps it open");
            int[] again = run(samples, buf, bytes.length, true, firstsAgain, false);
            check(again[0] == ctx[0] && again[1] == ctx[1] && firstsAgain.equals(firsts), lang + ": the same answers after closing and opening, with the layout set before");

            // ---- the words of the person (1.96.0), through the APK's own tree of learned words
            java.lang.reflect.Field counter = MrGestureWords.class.getDeclaredField("sChanges");
            counter.setAccessible(true);
            final java.util.concurrent.atomic.AtomicInteger changes = (java.util.concurrent.atomic.AtomicInteger) counter.get(null);
            ExpandableDictionary learned = new ExpandableDictionary(null, 0);
            final int before = changes.get();
            extraWords = new java.util.LinkedHashSet<String>();
            for (Sample s : samples) {
                if (extraWords.add(s.word.toLowerCase())) learned.addWord(s.word.toLowerCase(), MrGestureWords.LEARNED_MIN);
            }
            learned.addWord("xqzv", MrGestureWords.LEARNED_MIN - 1);       // typed, not yet a word the keyboard suggests
            check(changes.get() == before + extraWords.size() + 1, lang + ": every addWord of the real tree tells MrGestureWords (the smali hook): " + (changes.get() - before));
            check(!learned.reloadDictionaryIfRequired() && learned.getWordFrequency("xqzv") == MrGestureWords.LEARNED_MIN - 1, lang + ": the real tree is not loading; it has the words");
            MrGestureWords.Collector col = new MrGestureWords.Collector();
            col.read(learned.mrRoots(), MrGestureWords.LEARNED_MIN);
            java.util.Set<String> got = new java.util.HashSet<String>(java.util.Arrays.asList(col.words).subList(0, col.n));
            check(col.n == extraWords.size() && got.equals(extraWords), lang + ": MrGestureWords reads the " + extraWords.size() + " learned words back from the real tree (got " + col.n + ")");
            boolean freqs = true;
            for (int i = 0; i < col.n; i++) freqs &= col.freqs[i] == MrGestureWords.LEARNED_MIN;
            check(freqs, lang + ": with their frequency");
            ByteBuffer own = MrGestureWords.build(col.words, col.freqs, col.n);
            check(own != null && own.isDirect() && own.capacity() > 2, lang + ": the small dictionary is written");
            t0 = System.nanoTime();
            int[] both = run(samples, buf, bytes.length, own, true, null, false);
            double msBoth = (System.nanoTime() - t0) / 1e6 / samples.size();
            System.out.printf("%-6s with the words of the person (%d words from the APK's tree, %d bytes): right word first in %d, among 3 in %d; "
                    + "%d words came from them; %.2f ms per gesture%n", lang, col.n, own.capacity(), both[0], both[1], fromExtra, msBoth);
            check(both[2] == 0 && wrongExtra == 0 && fromExtra > 0, lang + ": every gesture answered; the words marked as the person's are words of the tree (" + wrongExtra + " wrong)");
            check(both[0] >= ctx[0] + Integer.parseInt(fl[4]) && both[1] >= ctx[1] + Integer.parseInt(fl[5]),
                    lang + ": with the words of the person " + both[0] + " first and " + both[1] + " among 3: at least " + fl[4] + " and " + fl[5] + " more than without");
            check(both[3] == ctx[3], lang + ": the previous word still counts for the words of main.dict (" + both[3] + ")");
            check(both[4] <= 2 * (MrGesture.NODE_BUDGET + 256), lang + ": entries read in the two searches under the two ceilings (" + both[4] + ")");
            int[] none = run(samples, buf, bytes.length, null, true, firstsAgain, false);
            check(none[0] == ctx[0] && none[1] == ctx[1] && fromExtra == 0, lang + ": and without them the answers are the ones of before");
            // the tree thrown away (a reload): MrGestureWords is told, and reads nothing
            final int mid = changes.get();
            learned.clearDictionary();
            col = new MrGestureWords.Collector();
            col.read(learned.mrRoots(), 0);
            check(changes.get() == mid + 1 && col.n == 0, lang + ": clearDictionary of the real tree tells MrGestureWords too, and leaves no word");
        }

        MrGesture.use(null);
        check(!MrGesture.ready(), "closed at the end");
        System.out.println(fails == 0 ? "GESTURES OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
