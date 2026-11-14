package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

import java.util.Random;
import java.util.regex.Pattern;

/**
 * PC test of the two cuts of stage 6, part 5 (docs/plan-performance.md): MrPrevWord (the word before the one being typed, asked of the
 * app once per word instead of once per letter) and MrSurround (one question after the echo of our own separator, Android 12+).
 * Runs through docs/tools/run_java_tests.sh.
 *
 * Every question to the app blocks the keyboard for as long as the app takes to answer, and that depends on the app and the device,
 * so the test counts questions, not milliseconds. And the answers must not change at all: MrPrevWord.get is compared with a port of
 * EditingUtil.getPreviousWord (the original, on the same fake app) for every letter of thousands of random words.
 */
public class PrevWordTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond, Object extra) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name + (extra == null ? "" : " | " + extra)); }
    }

    static void check(String name, boolean cond) { check(name, cond, null); }

    /** What the keyboard passes as the word separators (a list like LatinIME's). */
    static final String SEPARATORS = " \n\t.,;:!?()[]{}\"-/\\*&@#<>=+|_%";

    /** A fake app: a text and a cursor; every question is counted. */
    static class Editor implements InputConnection {
        StringBuilder text = new StringBuilder();
        int cursor;
        int before, surround;
        /** "ok": answers getSurroundingText; "null": the app does not implement it; "select": the answer has a selection; "throw". */
        String surroundMode = "ok";
        /** The app returns null for getTextBeforeCursor. */
        boolean silent;

        void set(String t, int c) { text = new StringBuilder(t); cursor = c; }
        void type(String s) { text.insert(cursor, s); cursor += s.length(); }
        void reset() { before = surround = 0; }

        public CharSequence getTextBeforeCursor(int n, int flags) {
            before++;
            if (silent) return null;
            return text.substring(Math.max(0, cursor - n), cursor);
        }

        public SurroundingText getSurroundingText(int b, int a, int flags) {
            surround++;
            if (surroundMode.equals("null")) return null;
            if (surroundMode.equals("throw")) throw new IllegalStateException("the app fell over");
            int from = Math.max(0, cursor - b);
            int to = Math.min(text.length(), cursor + a);
            int s = cursor - from;
            return new SurroundingText(text.substring(from, to), s, surroundMode.equals("select") ? s + 1 : s, from);
        }

        public CharSequence getSelectedText(int flags) { return null; }
        public boolean commitText(CharSequence t, int p) { return true; }
        public boolean deleteSurroundingText(int b, int a) { return true; }
        public boolean finishComposingText() { return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }
    }

    /** EditingUtil.getPreviousWord as it was (smali port): 15 characters before the cursor, the word before the last one. */
    static CharSequence original(InputConnection ic, String separators) {
        CharSequence prev = ic.getTextBeforeCursor(15, 0);
        if (prev == null) return null;
        String[] w = Pattern.compile("\\s+").split(prev);
        if (w.length >= 2 && w[w.length - 2].length() > 0) {
            char c = w[w.length - 2].charAt(w[w.length - 2].length() - 1);
            if (separators.contains(String.valueOf(c))) return null;
            return w[w.length - 2];
        }
        return null;
    }

    static boolean same(CharSequence a, CharSequence b) {
        return a == null ? b == null : b != null && a.toString().equals(b.toString());
    }

    static String show(CharSequence c) { return c == null ? "null" : "'" + c + "'"; }

    /** What LatinIME.mSentenceSeparators holds for the learning of the pairs. */
    static final String SENTENCE_SEPARATORS = ".!?";

    static int WINDOW() { return MrPrevWord.WINDOW; }

    static final String LETTERS = "abcdefghijklmnopqrstuvwxyzáéíóõçABCDEFG";
    static final String OTHERS = " \n\t.,;:!?()-'\"@#/ 0123456789";

    static String randomText(Random r, int max) {
        int n = r.nextInt(max + 1);
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < n; i++) {
            int kind = r.nextInt(10);
            b.append(kind < 6 ? LETTERS.charAt(r.nextInt(LETTERS.length())) : OTHERS.charAt(r.nextInt(OTHERS.length())));
        }
        return b.toString();
    }

    static String randomWord(Random r, int max) {
        int n = 1 + r.nextInt(max);
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < n; i++) b.append(LETTERS.charAt(r.nextInt(LETTERS.length())));
        return b.toString();
    }

    public static void main(String[] args) {
        Random r = new Random(6);

        // ---------------------------------------------------------------- A: MrPrevWord
        // 1. one question for the first run of a word, none for the next letters, and the same answer as the original for every letter
        {
            int words = 0, letters = 0, wrong = 0, extra = 0, nulls = 0, nonNull = 0, longWords = 0, longPrev = 0;
            String firstWrong = null;
            for (int t = 0; t < 4000; t++) {
                Editor e = new Editor();
                String base = randomText(r, 40);
                if (!base.isEmpty() && r.nextInt(3) > 0 && !Character.isWhitespace(base.charAt(base.length() - 1))) base += " ";
                if (r.nextInt(8) == 0) base += randomWord(r, 25) + " ";           // a long previous word, cut by the 15 characters
                e.set(base, base.length());
                String word = randomWord(r, r.nextInt(6) == 0 ? 24 : 9);            // sometimes longer than the 15-character window
                if (word.length() > 15) longWords++;
                MrPrevWord.clear();
                e.reset();
                int firstRun = -1;
                for (int k = 1; k <= word.length(); k++) {
                    e.type(word.substring(k - 1, k));
                    String composing = word.substring(0, k);
                    int before = e.before;
                    CharSequence got = MrPrevWord.get(e, SEPARATORS, new StringBuilder(composing));
                    int asked = e.before - before;
                    // the original, on the same app (its question is counted in e.before too: take it out)
                    CharSequence want = original(e, SEPARATORS);
                    letters++;
                    if (!same(got, want)) {
                        wrong++;
                        if (firstWrong == null) firstWrong = "text='" + e.text + "' composing='" + composing + "' got " + show(got) + " want " + show(want);
                    }
                    if (k == 1) firstRun = asked;
                    else if (asked != 0) extra++;
                    if (want == null) nulls++; else nonNull++;
                }
                if (firstRun != 1) extra++;
                words++;
                if (base.length() > 0 && base.trim().length() > 15) longPrev++;
            }
            check(words + " random words, every letter (" + letters + " letters, " + nonNull + " with a previous word, " + nulls
                    + " without): the answer is the one of EditingUtil.getPreviousWord", wrong == 0, firstWrong);
            check("... one question to the app for the first letter of a word and none for the others (before: one per letter)", extra == 0, extra);
            check("... the random words include words longer than the 15-character window (" + longWords + ") and long texts before them (" + longPrev + ")",
                    longWords > 100 && longPrev > 100 && nonNull > 1000 && nulls > 1000, longWords + "," + longPrev + "," + nonNull + "," + nulls);
        }

        // 2. the numbers of a typed sentence (the original answer is read on the same app after each letter; its questions are taken out)
        {
            Editor e = new Editor();
            MrPrevWord.clear();
            String[] sentence = {"eu", "queria", "informacao", "sobre", "tudo"};
            int letters = 0, originals = 0, mine = 0;
            boolean allRight = true;
            boolean truncated = false;
            for (String w : sentence) {
                for (int k = 1; k <= w.length(); k++) {
                    e.type(w.substring(k - 1, k));
                    letters++;
                    int b0 = e.before;
                    CharSequence got = MrPrevWord.get(e, SEPARATORS, new StringBuilder(w.substring(0, k)));
                    mine += e.before - b0;
                    CharSequence want = original(e, SEPARATORS);
                    originals++;
                    if (!same(got, want)) allRight = false;
                    if (want != null && w.equals("informacao") && want.toString().length() < "queria".length()) truncated = true;
                }
                e.type(" ");
                MrPrevWord.clear();                     // LatinIME: a separator ends the word
            }
            check("'eu queria informacao sobre tudo' (" + letters + " letters): " + mine + " questions to the app, one per word (before: one per letter)",
                    mine == sentence.length && letters == 27 && originals == 27, mine + "," + letters);
            check("... and the previous word was the original's for every letter (the window of 15 characters cuts 'queria' while 'informacao' is typed, as before)",
                    allRight && truncated, allRight + "," + truncated);
        }

        // 3. when the keyboard is not certain, it asks as before
        {
            // the text before the cursor does not end with the word the keyboard is composing: nothing is kept
            Editor e = new Editor();
            e.set("abc def", 7);
            MrPrevWord.clear();
            CharSequence a = MrPrevWord.get(e, SEPARATORS, "xyz");
            CharSequence b = MrPrevWord.get(e, SEPARATORS, "xyzw");
            check("the composing word is not what the app shows before the cursor: asked every time, never kept", e.before == 2 && same(a, "abc") && same(b, "abc"),
                    e.before + "," + show(a) + "," + show(b));

            // no word being composed: nothing is kept either
            e = new Editor();
            e.set("abc def ", 8);
            MrPrevWord.clear();
            MrPrevWord.get(e, SEPARATORS, "");
            MrPrevWord.get(e, SEPARATORS, null);
            check("nothing composed (empty or null): asked every time", e.before == 2, e.before);

            // clear() makes the next run ask
            e = new Editor();
            e.set("um dois", 7);
            MrPrevWord.clear();
            MrPrevWord.get(e, SEPARATORS, "dois");
            MrPrevWord.get(e, SEPARATORS, "dois");
            int kept = e.before;
            MrPrevWord.clear();
            MrPrevWord.get(e, SEPARATORS, "dois");
            check("the same word again: not asked (1); after clear(): asked again (2)", kept == 1 && e.before == 2, kept + "," + e.before);

            // a shorter word (backspace inside the word) or another word starts again from the app
            e = new Editor();
            e.set("um tres", 7);
            MrPrevWord.clear();
            MrPrevWord.get(e, SEPARATORS, "tres");
            e.set("um tre", 6);
            CharSequence shorter = MrPrevWord.get(e, SEPARATORS, "tre");
            e.set("um tre", 6);
            int n1 = e.before;
            check("a shorter word than the one kept (a delete): asked, and the answer is the original's", n1 == 2 && same(shorter, original(e, SEPARATORS)) && same(shorter, "um"), e.before + "," + show(shorter));
            e.set("um outra", 8);
            int n2 = e.before;
            CharSequence other = MrPrevWord.get(e, SEPARATORS, "outra");
            check("another word (it does not start with the word kept): asked", e.before == n2 + 1 && same(other, "um"), e.before + "," + show(other));

            // the app does not answer: null, nothing kept
            e = new Editor();
            e.set("um dois", 7);
            e.silent = true;
            MrPrevWord.clear();
            CharSequence none = MrPrevWord.get(e, SEPARATORS, "dois");
            MrPrevWord.get(e, SEPARATORS, "dois");
            check("the app answers null: null (as before), and asked every time", none == null && e.before == 2, e.before);

            check("no input connection or no separators: null, no exception", MrPrevWord.get(null, SEPARATORS, "a") == null && MrPrevWord.get(e, null, "a") == null);
        }

        // 4. every question is timed by the performance meter (appBegin/appEnd around it)
        {
            MrPerf.reset();
            MrPerf.sFakeNanos = 100_000_000_000L;
            Editor e = new Editor();
            e.set("um dois", 7);
            MrPrevWord.clear();
            MrPrevWord.get(e, SEPARATORS, "dois");
            MrPrevWord.get(e, SEPARATORS, "dois");
            check("the question of the first run is counted by the meter as a wait for the app, the cached run is not", MrPerf.stats(MrPerf.APP)[0] == 1, MrPerf.stats(MrPerf.APP)[0]);
            MrPerf.reset();
        }

        // ---------------------------------------------------------------- B: MrSurround
        {
            Editor e = new Editor();
            e.set("hello ", 6);
            Build.VERSION.SDK_INT = 30;
            MrSurround.fieldChanged();
            int got = MrSurround.echo(e);
            check("Android 11 or older: NONE and no question at all", got == MrSurround.NONE && e.surround == 0 && e.before == 0 && MrSurround.takeBefore() == null, got);

            Build.VERSION.SDK_INT = 31;
            MrSurround.fieldChanged();
            e.reset();
            got = MrSurround.echo(e);
            CharSequence kept = MrSurround.takeBefore();
            check("Android 12: ONE question; nothing after the cursor (END) and the text before it is kept", got == MrSurround.END && e.surround == 1 && e.before == 0
                    && same(kept, "hello "), got + "," + e.surround + "," + show(kept));
            check("... the kept text is taken once", MrSurround.takeBefore() == null);

            e.set("hello world", 6);
            e.reset();
            got = MrSurround.echo(e);
            check("a word after the cursor: its first character is the answer, the text before the cursor (not the word after) is kept", got == 'w'
                    && same(MrSurround.takeBefore(), "hello "), got);

            e.set("hello  world", 6);
            got = MrSurround.echo(e);
            check("a space after the cursor: the space is the answer (the keyboard decides it is not a word)", got == ' ');

            // the same text as getTextBeforeCursor(96) gives, also with more than 96 characters before the cursor
            StringBuilder longText = new StringBuilder();
            for (int i = 0; i < 40; i++) longText.append("palavra ");
            e.set(longText.toString() + "fim", longText.length());
            got = MrSurround.echo(e);
            CharSequence viaSurround = MrSurround.takeBefore();
            check("more than 96 characters before the cursor: the text kept is the same 96 as getTextBeforeCursor(96) gives",
                    got == 'f' && viaSurround.length() == MrPredict.LOOKBACK && same(viaSurround, e.getTextBeforeCursor(MrPredict.LOOKBACK, 0)), viaSurround.length());
            e.set("ab", 0);
            got = MrSurround.echo(e);
            check("cursor at the start of the field: the text before it is empty, the answer is the first character", got == 'a' && same(MrSurround.takeBefore(), ""), got);

            // an app that does not answer: asked once, never again in that field
            e.set("hello ", 6);
            e.surroundMode = "null";
            MrSurround.fieldChanged();
            e.reset();
            got = MrSurround.echo(e);
            int first = e.surround;
            got = MrSurround.echo(e);
            got = MrSurround.echo(e);
            check("an app that answers null: NONE (ask as before), the surround question is asked ONCE in the field", got == MrSurround.NONE && first == 1 && e.surround == 1
                    && MrSurround.takeBefore() == null, first + "," + e.surround);
            MrSurround.fieldChanged();
            e.surroundMode = "ok";
            got = MrSurround.echo(e);
            check("... and again after a new field (fieldChanged)", got == MrSurround.END && e.surround == 2, e.surround);

            // a selection, an exception
            e.surroundMode = "select";
            MrSurround.fieldChanged();
            e.reset();
            got = MrSurround.echo(e);
            check("a selection in the answer: NONE and nothing kept (the usual two questions run)", got == MrSurround.NONE && MrSurround.takeBefore() == null && e.surround == 1, got);
            e.surroundMode = "throw";
            got = MrSurround.echo(e);
            check("an exception of the app: NONE, no exception out, nothing kept", got == MrSurround.NONE && MrSurround.takeBefore() == null);
            e.surroundMode = "ok";
            got = MrSurround.echo(e);
            check("... and a later field state is not poisoned by a selection or an exception (asked again, answered)", got == MrSurround.END);

            check("no input connection: NONE", MrSurround.echo(null) == MrSurround.NONE);

            // the text kept dies with clear() and with the next echo
            e.set("hello ", 6);
            MrSurround.echo(e);
            MrSurround.clear();
            check("clear() drops the text kept", MrSurround.takeBefore() == null);
            MrSurround.echo(e);
            e.surroundMode = "null";
            MrSurround.fieldChanged();
            MrSurround.echo(e);
            check("a new echo that cannot answer drops what the last one kept", MrSurround.takeBefore() == null);

            // the meter: one echo-one sample per answered question, and the wait counted as a wait for the app
            MrPerf.reset();
            MrPerf.sFakeNanos = 100_000_000_000L;
            e.surroundMode = "ok";
            MrSurround.fieldChanged();
            MrSurround.echo(e);
            e.surroundMode = "null";
            MrSurround.fieldChanged();
            MrSurround.echo(e);
            check("the meter counts the answered question as echo-one (1) and both questions as waits for the app (2)",
                    MrPerf.stats(MrPerf.ECHO_ONE)[0] == 1 && MrPerf.stats(MrPerf.APP)[0] == 2, MrPerf.stats(MrPerf.ECHO_ONE)[0] + "," + MrPerf.stats(MrPerf.APP)[0]);
            MrPerf.reset();
            e.surroundMode = "ok";
            MrSurround.fieldChanged();
            MrSurround.takeBefore();

            // the whole point: next-word prediction takes the kept text and asks nothing, so the echo costs ONE question
            Suggest dict = new Suggest() {
                public boolean hasMainDictionary() { return true; }
            };
            e.set("hello ", 6);
            e.reset();
            MrSurround.echo(e);
            MrPredict.list(null, dict, e);
            check("the echo of a separator on Android 12+ followed by the next-word prediction: ONE question to the app in all (before: two)",
                    e.surround == 1 && e.before == 0, e.surround + "," + e.before);
            e.reset();
            MrPredict.list(null, dict, e);
            check("the prediction with nothing kept asks as before (one question)", e.before == 1 && e.surround == 0, e.before + "," + e.surround);
            e.reset();
            Build.VERSION.SDK_INT = 30;
            MrSurround.echo(e);
            MrPredict.list(null, dict, e);
            check("Android 11: the same two questions as before (the character after the cursor is asked by LatinIME; here the prediction's own)", e.surround == 0 && e.before == 1,
                    e.surround + "," + e.before);
            Build.VERSION.SDK_INT = 0;
        }

        // ---------------------------------------------------------------- C: the pair learned with the word before (stage 7)
        // checkAddToDictionary asked the app for the word before the one a separator commits. MrPrevWord.hold keeps what is known about the
        // word for that key; previousForLearning gives the same answer as the original, with no question when it is certain.
        {
            final String SENTENCE = ".!?";
            int trials = 0, wrong = 0, asked0 = 0, asked1 = 0, badCount = 0;
            String firstWrong = null;
            for (int t = 0; t < 6000; t++) {
                Editor e = new Editor();
                String base = randomText(r, 40);
                if (!base.isEmpty() && r.nextInt(3) > 0 && !Character.isWhitespace(base.charAt(base.length() - 1))) base += " ";
                if (r.nextInt(8) == 0) base += randomWord(r, 25) + " ";
                e.set(base, base.length());
                String typed = randomWord(r, r.nextInt(6) == 0 ? 24 : 9);
                // the suggestions ran for the first letters only (the strip lags behind a fast typist), or for all of them
                int ran = 1 + r.nextInt(typed.length());
                MrPrevWord.reset();
                for (int k = 1; k <= typed.length(); k++) {
                    e.type(typed.substring(k - 1, k));
                    if (k <= ran) MrPrevWord.get(e, SEPARATORS, new StringBuilder(typed.substring(0, k)));
                }
                // the key: the separator holds what is known and forgets the word as before; then the word is committed (as typed, or another
                // word that replaces it: an autocorrection, a suggestion in capitals), which writes mPredicting and clears the word kept
                MrPrevWord.hold(new StringBuilder(typed));
                MrPrevWord.clear();
                String committed = r.nextInt(3) == 0 ? randomWord(r, r.nextInt(5) == 0 ? 24 : 9) : typed;
                e.set(base + committed, base.length() + committed.length());
                String seps = r.nextBoolean() ? SENTENCE : SEPARATORS;
                e.reset();
                CharSequence got = MrPrevWord.previousForLearning(e, seps, committed.length());
                int asked = e.before;
                e.reset();
                CharSequence want = original(e, seps);
                trials++;
                if (!same(got, want)) {
                    wrong++;
                    if (firstWrong == null) firstWrong = "text='" + e.text + "' typed='" + typed + "' ran=" + ran + " seps=" + seps + " got " + show(got) + " want " + show(want);
                }
                // certain when the 15 characters are filled by what was kept plus the word, or what was kept is all there is
                int k0 = 1;
                int tail = Math.min(WINDOW(), base.length() + k0) - k0;
                boolean complete = base.length() + k0 < WINDOW();
                int need = WINDOW() - Math.min(committed.length(), WINDOW());
                boolean sure = tail >= need || complete;
                if (asked == 0) asked0++; else asked1++;
                if (asked != (sure ? 0 : 1)) badCount++;
                MrPrevWord.release();
            }
            check("learning: the answer is the one of the original on " + trials + " random texts, words typed or replaced by another, two separator lists",
                    wrong == 0, firstWrong);
            // the word is read at its first letter here, so the text kept always fills the window; the case where it does not (the word was
            // first read at a later letter and the one committed is shorter) is the next block
            check("learning: no question when the 15 characters are known (" + asked0 + " of " + trials + " without, " + asked1 + " with)",
                    badCount == 0 && asked1 == 0, badCount + "," + asked0 + "," + asked1);
        }
        {
            // what is held survives the writes of mPredicting that the commit makes (clear), not the end of the key (release)
            Editor e = new Editor();
            e.set("um dois ", 8);
            MrPrevWord.reset();
            e.type("t");
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("t"));
            e.type("res");
            MrPrevWord.hold(new StringBuilder("tres"));
            MrPrevWord.clear();
            e.reset();
            CharSequence got = MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, 4);
            check("learning: held for the key, the commit clears the word kept and the learning still has its answer, with no question",
                    same(got, "dois") && e.before == 0, show(got) + "," + e.before);
            MrPrevWord.release();
            e.reset();
            got = MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, 4);
            check("learning: after the key (release) it asks the app as before", same(got, "dois") && e.before == 1, show(got) + "," + e.before);
        }
        {
            Editor e = new Editor();
            e.set("um dois ", 8);
            // the word was never kept (the strip was off or nothing ran yet)
            MrPrevWord.reset();
            e.type("tres");
            MrPrevWord.hold(new StringBuilder("tres"));
            e.reset();
            CharSequence got = MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, 4);
            check("learning: a word that was never kept is not held, one question", same(got, "dois") && e.before == 1, show(got) + "," + e.before);
            MrPrevWord.release();
            // the word kept is not the one being committed (it does not start with it)
            MrPrevWord.reset();
            e.set("um dois ", 8);
            e.type("t");
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("t"));
            e.set("um dois x", 9);
            MrPrevWord.hold(new StringBuilder("x"));
            e.reset();
            got = MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, 1);
            check("learning: a word that is not the one kept grown by letters is not held, one question", same(got, "dois") && e.before == 1, show(got) + "," + e.before);
            MrPrevWord.release();
            // the kept text was a short window of a long field and the word committed is shorter than the one it was read with
            MrPrevWord.reset();
            e.set("um dois tres quatro cinco seis ", 31);
            e.type("abc");
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("abc"));   // asked at the third letter: 12 characters before the word kept
            MrPrevWord.hold(new StringBuilder("abc"));
            MrPrevWord.clear();
            e.set("um dois tres quatro cinco seis ab", 33);
            e.reset();
            got = MrPrevWord.previousForLearning(e, SEPARATORS, 2);
            check("learning: when what was kept does not fill the 15 characters and is not all there is, it asks, and the answer is the original's",
                    e.before == 1 && same(got, original(e, SEPARATORS)), show(got) + "," + e.before);
            MrPrevWord.release();
            e.reset();
            e.surround = 0;
            check("learning: nothing to work with and no connection: null, no exception", MrPrevWord.previousForLearning(null, SENTENCE_SEPARATORS, 4) == null);
        }
        {
            // what stays in memory: one window at most, dropped with the word, with the key and with the end of the input
            Editor e = new Editor();
            e.set("um dois tres", 12);
            MrPrevWord.reset();
            check("memory: nothing kept at the start", MrPrevWord.textInMemory() == 0, MrPrevWord.textInMemory());
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("tres"));
            int kept = MrPrevWord.textInMemory();
            check("memory: after one word, no more than the 15 characters of the window (and the word) are kept", kept > 0 && kept <= 15 + 24, kept);
            for (int i = 0; i < 50; i++) {
                e.set("a" + i + " b" + i + " word" + i, ("a" + i + " b" + i + " word" + i).length());
                MrPrevWord.clear();
                MrPrevWord.get(e, SEPARATORS, new StringBuilder("word" + i));
            }
            check("memory: fifty words later it is still one window, nothing piled up", MrPrevWord.textInMemory() <= 15 + 24, MrPrevWord.textInMemory());
            MrPrevWord.clear();
            check("memory: forgetting the word drops its text, not only the flag", MrPrevWord.textInMemory() == 0, MrPrevWord.textInMemory());
            e.set("um dois tres", 12);
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("tres"));
            MrPrevWord.hold(new StringBuilder("tres"));
            MrPrevWord.clear();
            check("memory: what is held stays after the word is forgotten (the key is not over)", MrPrevWord.textInMemory() > 0);
            MrPrevWord.release();
            check("memory: the end of the key drops it", MrPrevWord.textInMemory() == 0, MrPrevWord.textInMemory());
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("tres"));
            MrPrevWord.hold(new StringBuilder("tres"));
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("tres"));
            MrPrevWord.reset();
            check("memory: the end of the input, the keyboard hidden or destroyed (reset) drops everything", MrPrevWord.textInMemory() == 0, MrPrevWord.textInMemory());
            e.reset();
            MrPrevWord.get(e, SEPARATORS, new StringBuilder("tres"));
            check("memory: after a reset the next word asks the app, it does not use what the last field left", e.before == 1, e.before);
            MrPrevWord.reset();
        }
        {
            check("endsPlain: a word", MrPrevWord.endsPlain("casa"));
            check("endsPlain: a word with an apostrophe or a hyphen at the end", MrPrevWord.endsPlain("d'") && MrPrevWord.endsPlain("guarda-"));
            check("endsPlain: a space, a tab, a line break or a no-break space at the end", !MrPrevWord.endsPlain("casa ") && !MrPrevWord.endsPlain("casa\t")
                    && !MrPrevWord.endsPlain("casa\n") && !MrPrevWord.endsPlain("casa "));
            check("endsPlain: empty and null", !MrPrevWord.endsPlain("") && !MrPrevWord.endsPlain(null));
        }
        {
            // a typed sentence: the questions of the learning, word by word (the first word of a field has no word before it)
            Editor e = new Editor();
            e.set("", 0);
            MrPrevWord.reset();
            String[] words = {"eu", "queria", "uma", "casa", "grande", "perto", "do", "mar"};
            int learningAsks = 0, wrong = 0;
            for (String w : words) {
                for (int k = 1; k <= w.length(); k++) {
                    e.type(w.substring(k - 1, k));
                    MrPrevWord.get(e, SEPARATORS, new StringBuilder(w.substring(0, k)));
                }
                MrPrevWord.hold(new StringBuilder(w));
                MrPrevWord.clear();
                e.reset();
                CharSequence got = MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, w.length());
                learningAsks += e.before;
                e.reset();
                if (!same(got, original(e, SENTENCE_SEPARATORS))) wrong++;
                MrPrevWord.release();
                e.type(" ");
            }
            check("a typed sentence of " + words.length + " words: the learning asks the app " + learningAsks + " times (before: " + words.length + "), the answers are the original's",
                    learningAsks <= 2 && wrong == 0, learningAsks + "," + wrong);
            MrPrevWord.reset();
        }
        {
            // the question that is left is timed by the meter like every other
            MrPerf.reset();
            MrPerf.sFakeNanos = 100_000_000_000L;
            Editor e = new Editor();
            e.set("um dois", 7);
            MrPrevWord.reset();
            MrPrevWord.previousForLearning(e, SENTENCE_SEPARATORS, 4);
            check("learning: the question that is left is counted by the meter as a wait for the app", MrPerf.stats(MrPerf.APP)[0] == 1, MrPerf.stats(MrPerf.APP)[0]);
            MrPerf.reset();
        }

        System.out.println();
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
