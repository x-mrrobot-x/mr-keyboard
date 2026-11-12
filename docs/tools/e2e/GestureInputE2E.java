package com.mrkeyboard.app;

import android.content.res.Resources;
import android.os.SystemClock;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;

import java.io.File;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * Gesture typing in the keyboard, from the touch events to the text, with the REAL recognition: MrGestureInput (compiled from
 * docs/tools/java/src against the stubs, like the PC tests of the Java layer) over MrGesture, MrNative and libmrengine.so
 * built for the PC, with the dictionaries of dicts/, the weights of gesture/ and the gestures of gesture/test.
 *
 * Each gesture of gesture/test is drawn again as touch events on a fake keyboard of 1080 pixels that has the keys where the
 * gesture was made: finger down, one move per recorded point, finger up. What is then in the fake text field is compared with
 * the word the person meant. It is the path of the app but for two things this test cannot reach: the smali that calls
 * MrGestureInput and Android itself.
 *
 * What it proves: the frame of the keys and of the points that MrGestureInput hands to the lib is the one the recognition
 * expects (a slip there would cost words on the phone and nothing else would show it): the counts must be the ones of
 * GestureTest for the same files, less the gestures this keyboard does not take as gestures (they are counted and printed):
 * the ones that start outside every letter key and the ones that never get 0.7 key away from where they started.
 *
 * Each language is drawn three times: first with main.dict alone and the finger never seen sliding; then with
 * the words of the person, where every word of the file is a word the keyboard learned (MrGestureWords reads them from a
 * tree like the keyboard's, writes its small dictionary, and the lib searches it after main.dict): the words main.dict
 * lacks must now be written, and the others must stay; then with the clock following the gesture, so that the strip gets
 * the word so far every 120 ms: what is written must be exactly what was written without it.
 *
 * Usage: java -Djava.library.path=<lib> -cp test:stubs:main com.mrkeyboard.app.GestureInputE2E <dicts dir> <gesture/encoder.bin> <gesture/test>
 *        -Dexplore=1 prints every gesture whose word did not come first and why.
 */
public class GestureInputE2E {
    static final boolean EXPLORE = System.getProperty("explore") != null;
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("  FAIL " + what); }
    }

    static final int W = 1080, ROW = 150, TOP = 3 * ROW;      // three rows of other keys above the letters, as in the standard keyboard

    static class Sample {
        String word, prev;
        float[] x, y;
        int[] t;
    }

    static char[] keyChar;
    static float[] keyXY;

    static List<Sample> load(File f) throws Exception {
        List<Sample> out = new ArrayList<Sample>();
        for (String line : Files.readAllLines(f.toPath(), StandardCharsets.UTF_8)) {
            if (line.isEmpty() || line.startsWith("#")) continue;
            if (line.startsWith("@keys")) {
                String[] p = line.trim().split(" +");
                int n = (p.length - 1) / 3;
                keyChar = new char[n];
                keyXY = new float[2 * n];
                for (int i = 0; i < n; i++) {
                    keyChar[i] = p[1 + 3 * i].charAt(0);
                    keyXY[2 * i] = Float.parseFloat(p[2 + 3 * i]);
                    keyXY[2 * i + 1] = Float.parseFloat(p[3 + 3 * i]);
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

    /** A keyboard in pixels with the letter keys where the file says they are (a tenth of the width each, rows of ROW pixels). */
    static Keyboard keyboard() {
        Keyboard kb = new Keyboard();
        kb.stubWidth = W;
        kb.stubHeight = 7 * ROW;
        int kw = W / 10;
        for (int i = 0; i < keyChar.length; i++) {
            int row = Math.round(keyXY[2 * i + 1] * 3f - 0.5f);
            Keyboard.Key k = new Keyboard.Key(keyChar[i], Math.round(keyXY[2 * i] * W - kw / 2f), TOP + row * ROW, kw, ROW);
            kb.keys.add(k);
        }
        // the first and the last key of the two upper rows reach the edge of the keyboard, as in res/xml/kbd_qwerty.xml
        for (int row = 0; row < 2; row++) {
            Keyboard.Key first = null, last = null;
            for (Keyboard.Key k : kb.keys) {
                if (k.y != TOP + row * ROW) continue;
                if (first == null || k.x < first.x) first = k;
                if (last == null || k.x > last.x) last = k;
            }
            if (first != null) first.edgeFlags = Keyboard.EDGE_LEFT;
            if (last != null) last.edgeFlags = Keyboard.EDGE_RIGHT;
        }
        return kb;
    }

    static class Res extends Resources {
        final DisplayMetrics dm = new DisplayMetrics();
        Res() { dm.density = 3f; }                 // 1080 pixels across at 3 pixels per dp: a common phone
        @Override public DisplayMetrics getDisplayMetrics() { return dm; }
    }

    static class Ic implements InputConnection {
        final StringBuilder text = new StringBuilder();
        public CharSequence getTextBeforeCursor(int n, int flags) { return text.substring(Math.max(0, text.length() - n)); }
        public CharSequence getSelectedText(int flags) { return null; }
        public boolean commitText(CharSequence t, int pos) { text.append(t); return true; }
        public boolean deleteSurroundingText(int before, int after) { text.setLength(Math.max(0, text.length() - before)); return true; }
        public boolean finishComposingText() { return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }
    }

    static class Dict extends BinaryDictionary {
        final ByteBuffer buf;
        final int size;
        Dict(ByteBuffer buf, int size) { super(null, null, 0); this.buf = buf; this.size = size; }
        @Override public ByteBuffer mrBuffer() { return buf; }
        @Override public int mrLength() { return size; }
    }

    static class Sugg extends Suggest {
        Dict dict;
        @Override public BinaryDictionary mrMainDict() { return dict; }
    }

    /** The keyboard service: the dictionary, the text field, and a pick that writes the word and the automatic space. */
    static class Ime extends LatinIME {
        final Ic ic = new Ic();
        final EditorInfo ei = new EditorInfo();
        final Sugg sugg = new Sugg();
        List<CharSequence> strip;
        int strips;                    // times the strip was given a list
        String lastShown;              // the last single word it was given (the word so far of a gesture)
        Ime() { ei.inputType = 0x1; }
        @Override public InputConnection getCurrentInputConnection() { return ic; }
        @Override public EditorInfo getCurrentInputEditorInfo() { return ei; }
        @Override public Suggest mrSuggest() { return sugg; }
        @Override public void mrStrip(List<CharSequence> words) {
            strip = words;
            strips++;
            if (words != null && words.size() == 1 && MrGestureInput.stateForTest() == 2) lastShown = words.get(0).toString();
        }
        @Override public void pickSuggestionManually(int index, CharSequence word) {
            if (MrGestureInput.onPick(this, index, word)) return;
            ic.commitText(word, 1);
            ic.commitText(" ", 1);
        }
    }

    static LatinKeyboardView view;
    static Ime ime;
    /** Does the clock of the keyboard follow the times of the gesture? (Then the word so far is recognised while it is drawn.) */
    static boolean clock;
    static final long CLOCK0 = 1000000;

    static MotionEvent ev(int action, long t, float x, float y) {
        return MotionEvent.stub(action, 0, 0, t, new int[] {0}, new float[] {x}, new float[] {y});
    }

    static float px(float fx) { return fx * W; }
    static float py(float fy) { return TOP + fy * 3 * ROW; }

    /**
     * Draws one gesture. Returns 0 = it wrote something, 1 = the touch did not start on a letter key, 2 = it never became a
     * gesture (the finger stayed within 0.7 key of where it went down), 3 = it was a gesture and nothing was written.
     */
    static int draw(Sample s) {
        int n = s.x.length;
        ime.ic.text.setLength(0);
        if (s.prev != null) ime.ic.text.append(s.prev).append(' ');
        ime.strip = null;
        ime.lastShown = null;
        int before = ime.ic.text.length();
        if (clock) SystemClock.now = CLOCK0 + s.t[0];
        MrGestureInput.onTouch(view, ev(MotionEvent.ACTION_DOWN, s.t[0], px(s.x[0]), py(s.y[0])));
        boolean followed = MrGestureInput.stateForTest() == 1;
        boolean taken = false;
        for (int i = 1; i < n; i++) {
            if (clock) SystemClock.now = CLOCK0 + s.t[i];
            taken |= MrGestureInput.onTouch(view, ev(MotionEvent.ACTION_MOVE, s.t[i], px(s.x[i]), py(s.y[i])));
        }
        MrGestureInput.onTouch(view, ev(MotionEvent.ACTION_UP, s.t[n - 1], px(s.x[n - 1]), py(s.y[n - 1])));
        if (!followed) return 1;
        if (!taken) return 2;
        return ime.ic.text.length() > before ? 0 : 3;
    }

    /** The words of the last gesture, best first: the one written, then the strip (second, first, third). */
    static List<String> words(Sample s) {
        List<String> out = new ArrayList<String>();
        String text = ime.ic.text.toString();
        int from = s.prev != null ? s.prev.length() + 1 : 0;
        out.add(text.substring(from).trim());
        List<CharSequence> st = ime.strip;
        if (st != null && !st.isEmpty()) {
            if (st.size() == 1) out.add(st.get(0).toString());
            else {
                out.add(st.get(1).toString());
                out.add(st.get(0).toString());
                for (int i = 2; i < st.size(); i++) out.add(st.get(i).toString());
            }
        }
        return out;
    }

    /** What drawing every gesture of a file gave. */
    static class Pass {
        int first, among3, among4, notOnLetter, notGesture, nothing, written;
        double ms;
        int[] at;                  // place of the right word for each gesture (0 = written; -1 = not among the words shown)
        String[] text, wrote, shown;   // the words of each gesture (written and on the strip); the one written; the last one shown while sliding
    }

    static Pass pass(List<Sample> samples) {
        Pass p = new Pass();
        p.at = new int[samples.size()];
        p.text = new String[samples.size()];
        p.wrote = new String[samples.size()];
        p.shown = new String[samples.size()];
        long t0 = System.nanoTime();
        for (int g = 0; g < samples.size(); g++) {
            Sample s = samples.get(g);
            int r = draw(s);
            if (r == 1) p.notOnLetter++;
            if (r == 2) p.notGesture++;
            if (r == 3) p.nothing++;
            List<String> w = r == 0 ? words(s) : new ArrayList<String>();
            if (r == 0) p.written++;
            int at = -1;
            for (int i = 0; i < w.size() && at < 0; i++) if (MrGesture.sameIgnoringCase(w.get(i), s.word)) at = i;
            if (at == 0) p.first++;
            if (at >= 0 && at < 3) p.among3++;
            if (at >= 0) p.among4++;
            p.at[g] = at;
            p.text[g] = r + ":" + w;
            p.wrote[g] = w.isEmpty() ? null : w.get(0);
            p.shown[g] = ime.lastShown;
            if (EXPLORE && at != 0) {
                String why = r == 1 ? "started outside the letters" : r == 2 ? "never 0.7 key from the start" : r == 3 ? "nothing written" : w.toString();
                System.out.println("    " + s.word + (s.prev != null ? " (after " + s.prev + ")" : "") + " -> " + why);
            }
        }
        p.ms = (System.nanoTime() - t0) / 1e6 / samples.size();
        return p;
    }

    public static void main(String[] a) throws Exception {
        File dicts = new File(a[0]), weights = new File(a[1]), data = new File(a[2]);
        // {language, right word first, among the first three, gestures that became gestures}: floors, two under what was
        // measured when this test was written (in the comment of each line). GestureTest, which hands the same points straight
        // to MrGesture, measured 256/272 (en-US), 260/276 (es) and 288/294 (pt-BR): the difference is the gestures this
        // keyboard does not take (printed below), not the frame.
        // The last two numbers: how many more words come first and among three with the words of the person (every word of the
        // file learned), at least. English and Spanish have words main.dict lacks (17 and 7); the Portuguese file has none.
        String[][] floors = {
            {"en-US", "254", "269", "294", "17", "19"},   // measured: 256, 271, 296 written (3 of the 300 are taps in the file, 1 gives no word); with the words of the person 19 and 21 more
            {"es", "258", "274", "281", "6", "6"},        // measured: 260, 276, 283 written (16 are one-letter words, taps; 1 gives no word); with the words of the person 8 and 8 more
            {"pt-BR", "278", "283", "288", "0", "0"},     // measured: 280, 285, 290 written (10 synthetic traces start beside the letters: on Shift, backspace, the digits or the space row); 0 and 0 more
        };

        MrGestureInput.resetForTest();
        check(MrGesture.useNow(weights) && MrGesture.ready(), "the weights open (" + weights + ")");
        check(MrNative.ready(), "the native engine is loaded (contract " + MrNative.ENGINE_VERSION + ")");
        MrGestureInput.sOn = true;

        for (String[] fl : floors) {
            String lang = fl[0];
            byte[] bytes = Files.readAllBytes(new File(dicts, lang + "/main.dict").toPath());
            ByteBuffer buf = ByteBuffer.allocateDirect(bytes.length);
            buf.put(bytes);
            buf.rewind();
            List<Sample> samples = load(new File(data, "gestures_" + lang + ".tsv"));
            view = new LatinKeyboardView();
            view.keyboard = keyboard();
            view.stubSize(W, 7 * ROW);
            view.stubResources = new Res();
            KeyboardSwitcher.getInstance().view = view;
            ime = new Ime();
            ime.sugg.dict = new Dict(buf, bytes.length);
            LatinIME.sInstance = ime;

            // ---- 1. as in 1.96.0: main.dict alone
            clock = false;
            MrGestureWords.resetForTest();
            final long[] st0 = MrGestureInput.stats();
            Pass one = pass(samples);
            long[] st = MrGestureInput.stats();
            System.out.printf("%-6s %d gestures: %d written (%d started outside the letter keys, %d never left the start, %d gave no word); "
                    + "right word first in %d, among 3 in %d, among the 4 shown in %d; %.2f ms per gesture%n",
                    lang, samples.size(), one.written, one.notOnLetter, one.notGesture, one.nothing, one.first, one.among3, one.among4, one.ms);
            check(samples.size() == 300, lang + ": 300 gestures");
            check(one.first >= Integer.parseInt(fl[1]), lang + ": right word first in " + one.first + ", floor " + fl[1]);
            check(one.among3 >= Integer.parseInt(fl[2]), lang + ": right word among 3 in " + one.among3 + ", floor " + fl[2]);
            check(one.written >= Integer.parseInt(fl[3]), lang + ": " + one.written + " gestures written, floor " + fl[3]);
            check(st[0] - st0[0] >= one.written && st[3] > 0 && st[4] == st0[4], lang + ": the time of each recognition is kept, and none was made while the finger slid");
            check(MrGestureWords.stats()[0] == 0, lang + ": no words of the person so far");

            // ---- 2. with the words of the person: every word of the file is one the keyboard learned (frequency 6, the lowest
            //         from which it counts), in the tree the keyboard keeps them in
            ExpandableDictionary.stubChanged = new Runnable() {
                public void run() { MrGestureWords.changed(); }
            };
            ExpandableDictionary learned = new ExpandableDictionary();
            HashSet<String> own = new HashSet<String>();
            for (Sample s : samples) {
                if (own.add(s.word.toLowerCase())) learned.addWord(s.word.toLowerCase(), MrGestureWords.LEARNED_MIN);
            }
            learned.addWord("xqzv", 5);                         // typed, not yet learned: stays out
            ime.sugg.stubAuto = learned;
            Pass two = pass(samples);
            final ByteBuffer copy = MrGestureWords.get(ime);
            int lost = 0, gained = 0;
            for (int i = 0; i < samples.size(); i++) {
                if (one.at[i] == 0 && two.at[i] != 0) lost++;
                if (one.at[i] != 0 && two.at[i] == 0) gained++;
            }
            System.out.printf("%-6s with the words of the person (%d words, %d bytes): right word first in %d (%d more, %d fewer), among 3 in %d; "
                    + "%.2f ms per gesture%n", lang, MrGestureWords.stats()[0], MrGestureWords.stats()[2], two.first, gained, lost, two.among3, two.ms);
            check(MrGestureWords.stats()[0] == own.size() && copy != null, lang + ": the copy has the " + own.size() + " learned words and not the one below frequency 6");
            check(two.first >= one.first + Integer.parseInt(fl[4]) && two.among3 >= one.among3 + Integer.parseInt(fl[5]),
                    lang + ": with the words of the person " + two.first + " first and " + two.among3 + " among 3: at least " + fl[4] + " and " + fl[5] + " more than without");
            check(lost <= 1, lang + ": the words main.dict got right stay right: " + lost + " lost");
            check(two.written >= one.written, lang + ": no gesture stops being written");
            check(MrGestureWords.get(ime) == copy, lang + ": the copy was made once for the 300 gestures");

            // ---- 3. the same, with the clock following the gesture: the strip gets the word so far, and what is written is the same
            MrTools.sBarMain = new android.view.View();           // the tool bar in view: the strip lives in it
            clock = true;
            final long[] st1 = MrGestureInput.stats();
            Pass three = pass(samples);
            clock = false;
            st = MrGestureInput.stats();
            boolean sameText = true;
            int lastRight = 0, shown = 0;
            for (int i = 0; i < samples.size(); i++) {
                sameText &= two.text[i].equals(three.text[i]);
                if (three.shown[i] != null) shown++;
                if (three.shown[i] != null && three.shown[i].equals(three.wrote[i])) lastRight++;
            }
            final long previews = st[4] - st1[4];
            System.out.printf("%-6s with the word so far on the strip: %d recognitions while sliding (%.1f per gesture, %.2f ms each, the longest %.1f ms); "
                    + "%d gestures showed a word, in %d the last one shown was the word written%n",
                    lang, previews, previews / (double) Math.max(1, three.written), (st[5] - st1[5]) / 1e6 / Math.max(1, previews), st[6] / 1e6, shown, lastRight);
            check(sameText, lang + ": the word so far changes nothing in what is written and in the candidates");
            // (a gesture that ends before its first 120 ms shows nothing: 3 to 7 in a hundred of these files)
            check(previews > 3L * three.written && shown >= three.written * 90 / 100, lang + ": the trace is recognised while the finger slides: " + previews + " times, " + shown + " gestures showed a word");
            check(lastRight >= shown * 80 / 100, lang + ": the last word shown is the one written in most gestures: " + lastRight + " of " + shown);
            check(st[0] - st1[0] == three.written + three.nothing, lang + ": the recognitions of the preview are counted apart");
            if (lang.equals("en-US")) {
                // a blocked word is never written: a gesture whose word came first writes another one, and the strip does not have it
                int which = -1;
                for (int i = 0; i < samples.size() && which < 0; i++) if (two.at[i] == 0 && samples.get(i).word.length() > 3) which = i;
                check(which >= 0, "en-US: a gesture to block");
                if (which >= 0) {
                    Sample sb = samples.get(which);
                    java.lang.reflect.Field f = MrLearned.class.getDeclaredField("sBlocked");
                    f.setAccessible(true);
                    HashSet<String> set = new HashSet<String>();
                    set.add(sb.word.toLowerCase());
                    f.set(null, set);
                    MrGestureWords.changed();                  // what MrLearned does when it reads the blocked words
                    int r = draw(sb);
                    List<String> w = r == 0 ? words(sb) : new ArrayList<String>();
                    boolean there = false;
                    for (String x : w) there |= x.equalsIgnoreCase(sb.word);
                    check(!there && MrGestureWords.get(ime) != copy && MrGestureWords.stats()[0] == own.size() - 1,
                            "en-US: the blocked word \"" + sb.word + "\" is not written, not offered, and not in the copy any more: " + w);
                    f.set(null, new HashSet<String>());
                    MrGestureWords.changed();
                    check(draw(sb) == 0 && words(sb).get(0).equalsIgnoreCase(sb.word), "en-US: unblocked, it is written again");
                }
            }
            ime.sugg.stubAuto = null;
            ExpandableDictionary.stubChanged = null;
        }

        // one gesture again, to the end: the text, the swap, the backspace, with the real words
        List<Sample> pt = load(new File(data, "gestures_pt-BR.tsv"));
        Sample chosen = null;
        for (Sample s : pt) {
            if (draw(s) == 0 && ime.strip != null && ime.strip.size() >= 2 && MrGesture.sameIgnoringCase(words(s).get(0), s.word)) { chosen = s; break; }
        }
        check(chosen != null, "a Portuguese gesture with the right word first and other candidates on the strip");
        if (chosen != null) {
            String prev = chosen.prev != null ? chosen.prev + " " : "";
            String wrote = words(chosen).get(0), alt = ime.strip.get(1).toString();
            check(ime.ic.text.toString().equals(prev + wrote + " "), "text: [" + ime.ic.text + "]");
            ime.pickSuggestionManually(1, ime.strip.get(1));
            check(ime.ic.text.toString().equals(prev + alt + " ") && ime.strip.get(1).toString().equals(wrote), "swap with a real candidate: [" + ime.ic.text + "]");
            MrGestureInput.onKey(ime, -5);
            MrGestureInput.onBackspace(ime);
            ime.ic.deleteSurroundingText(1, 0);
            check(ime.ic.text.toString().equals(prev), "backspace takes the swapped word back: [" + ime.ic.text + "]");
        }

        MrGesture.use(null);
        System.out.println(fails == 0 ? "GESTURE INPUT OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }
}
