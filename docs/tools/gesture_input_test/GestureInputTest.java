package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.os.SystemClock;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

/**
 * PC test of gesture typing in the keyboard (MrGestureInput, 1.96.0), with a fake keyboard view, a fake text field and a
 * fake recognition (the real one, with the real dictionaries and real gestures, is GestureInputE2E).
 *
 * What it checks: with the setting off nothing is looked at; a tap and a short slide go on as before; when a touch becomes a
 * gesture, what the usual path receives (one cancel event) and what it stops receiving; the long-press time; two fingers; the
 * popup; the conditions on the keyboard and on the text field; the frame of the points and of the keys handed to the
 * recognition; the trail; which traces write nothing; the text written (space before, capitals, automatic space), the other
 * candidates on the strip and the swap, the backspace that takes the word back; that an exception anywhere never stops the
 * touch; the setting and the weights file (init, reload); the word so far on the strip while the finger slides
 * (when it is recognised, how often, what the strip gets and gets back, a tap on it, its setting), the blocked words, and
 * that what the recognition needs is made ready when the gesture begins.
 */
public class GestureInputTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) { fails++; System.out.println("  FAIL " + what); }
    }

    // ---------------------------------------------------------------- the fake keyboard: the standard one of the app, 1000 x 700
    static final int W = 1000, ROW = 100;
    static final String[] ROWS = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
    static final int[] ROW_X = {0, 50, 150};
    static final int LETTERS_TOP = 3 * ROW;      // two rows of tools and one of digits above the letters

    static Keyboard.Key ctrl, alt;

    static Keyboard keyboard() {
        Keyboard kb = new Keyboard();
        kb.stubWidth = W;
        kb.stubHeight = 7 * ROW;
        ctrl = new Keyboard.Key(-113, 0, ROW, 140, ROW);
        alt = new Keyboard.Key(-57, 140, ROW, 130, ROW);
        kb.keys.add(ctrl);
        kb.keys.add(alt);
        for (int i = 0; i < 10; i++) kb.keys.add(new Keyboard.Key('0' + (i + 1) % 10, i * 100, 2 * ROW, 100, ROW));
        for (int r = 0; r < 3; r++) {
            for (int i = 0; i < ROWS[r].length(); i++) {
                Keyboard.Key k = new Keyboard.Key(ROWS[r].charAt(i), ROW_X[r] + i * 100, LETTERS_TOP + r * ROW, 100, ROW);
                if (i == 0 && r < 2) k.edgeFlags = Keyboard.EDGE_LEFT;
                if (i == ROWS[r].length() - 1 && r < 2) k.edgeFlags = Keyboard.EDGE_RIGHT;
                kb.keys.add(k);
            }
        }
        kb.keys.add(new Keyboard.Key(-1, 0, LETTERS_TOP + 2 * ROW, 150, ROW));       // Shift
        kb.keys.add(new Keyboard.Key(-5, 850, LETTERS_TOP + 2 * ROW, 150, ROW));     // backspace
        kb.keys.add(new Keyboard.Key(' ', 300, 6 * ROW, 400, ROW));
        Keyboard.Key text = new Keyboard.Key(0, 700, 6 * ROW, 100, ROW);              // a key that writes a text: not a letter
        text.text = "ok";
        kb.keys.add(text);
        return kb;
    }

    static float cx(char c) {
        for (int r = 0; r < 3; r++) { int i = ROWS[r].indexOf(c); if (i >= 0) return ROW_X[r] + i * 100 + 50; }
        throw new IllegalArgumentException("" + c);
    }

    static float cy(char c) {
        for (int r = 0; r < 3; r++) if (ROWS[r].indexOf(c) >= 0) return LETTERS_TOP + r * ROW + 50;
        throw new IllegalArgumentException("" + c);
    }

    static class Res extends Resources {
        final DisplayMetrics dm = new DisplayMetrics();
        Res(float density) { dm.density = density; }
        @Override public DisplayMetrics getDisplayMetrics() { return dm; }
    }

    /** The view: keeps what the usual path received; can be told to fail there. */
    static class View extends LatinKeyboardView {
        boolean failBase;
        @Override public boolean onTouchEvent(MotionEvent me, boolean continuing) {
            if (failBase) throw new IllegalStateException("base");
            return super.onTouchEvent(me, continuing);
        }
    }

    static View view(Keyboard kb, float density) {
        View v = new View();
        v.keyboard = kb;
        v.stubSize(W, 7 * ROW);
        v.stubResources = new Res(density);
        return v;
    }

    // ---------------------------------------------------------------- the fake text field
    static class Ic implements InputConnection {
        final StringBuilder text = new StringBuilder();
        int batch, finished, reads;
        boolean dead;                // the editor does not answer
        public CharSequence getTextBeforeCursor(int n, int flags) {
            reads++;
            if (dead) return null;
            return text.substring(Math.max(0, text.length() - n));
        }
        public CharSequence getSelectedText(int flags) { return null; }
        public boolean commitText(CharSequence t, int pos) { text.append(t); return true; }
        public boolean deleteSurroundingText(int before, int after) { text.setLength(Math.max(0, text.length() - before)); return true; }
        public boolean finishComposingText() { finished++; return true; }
        public boolean beginBatchEdit() { batch++; return true; }
        public boolean endBatchEdit() { batch--; return true; }
    }

    /** The fake keyboard service: writes a picked word as the real one does (the word, then the automatic space). */
    static class Ime extends LatinIME {
        final Ic ic = new Ic();
        final EditorInfo ei = new EditorInfo();
        boolean autoSpace = true, hasIc = true, failPick, modifierOn;
        int commits, glues;
        final List<String> picks = new ArrayList<String>();
        final List<List<CharSequence>> strips = new ArrayList<List<CharSequence>>();   // every mrStrip call; null = "between words"
        Ime() { ei.inputType = 0x1; }
        @Override public InputConnection getCurrentInputConnection() { return hasIc ? ic : null; }
        @Override public EditorInfo getCurrentInputEditorInfo() { return ei; }
        @Override public void mrCommit() { commits++; }
        @Override public void mrStrip(List<CharSequence> words) { strips.add(words); }
        /** LatinIME.mrGlue: the sign takes the place of the automatic space, with a space after it; not while a modifier is on. */
        @Override public boolean mrGlue(int code) {
            if (modifierOn) return false;
            glues++;
            ic.deleteSurroundingText(1, 0);
            ic.commitText(String.valueOf((char) code) + " ", 1);
            return true;
        }
        @Override public void pickSuggestionManually(int index, CharSequence word) {
            if (MrGestureInput.onPick(this, index, word)) return;       // the hook at the top of the real method
            if (failPick) throw new IllegalStateException("pick");
            picks.add(index + ":" + word);
            ic.commitText(word, 1);
            if (autoSpace) ic.commitText(" ", 1);
        }
        List<CharSequence> strip() { return strips.isEmpty() ? null : strips.get(strips.size() - 1); }
        /** A key that is not the backspace, as LatinIME.onKey does. */
        void key(char c) { if (!MrGestureInput.onKey(this, c)) ic.commitText(String.valueOf(c), 1); }
        /** The backspace key: onKey, then handleBackspace (the hook, then one character). */
        void backspace() { MrGestureInput.onKey(this, -5); MrGestureInput.onBackspace(this); ic.deleteSurroundingText(1, 0); }
    }

    // ---------------------------------------------------------------- the fake recognition
    static class Eng implements MrGestureInput.Engine {
        boolean ready = true, dict = true, failDecode, failPrepare, layoutOk = true;
        int layouts, decodes, lastN, prepares, sleepMs;
        char[] keys;
        float[] xy;
        float[] x, y;
        int[] t;
        String prev;
        String[] words = {"casa", "caso", "cada", "cara"};
        float logp = -2f;
        int answer = Integer.MIN_VALUE;        // what decode returns when set
        public boolean ready() { return ready; }
        public boolean layout(char[] k, float[] p) { layouts++; keys = k; xy = p; return layoutOk; }
        public boolean hasDictionary(LatinIME ime) { return dict; }
        public void prepare(LatinIME ime) {
            prepares++;
            if (failPrepare) throw new IllegalStateException("prepare");
        }
        public int decode(LatinIME ime, float[] px, float[] py, int[] pt, int n, String prevWord, MrGesture.Result out) {
            decodes++;
            if (failDecode) throw new IllegalStateException("decode");
            if (sleepMs > 0) {
                try { Thread.sleep(sleepMs); } catch (InterruptedException e) { throw new IllegalStateException(e); }
            }
            lastN = n;
            x = java.util.Arrays.copyOf(px, n);
            y = java.util.Arrays.copyOf(py, n);
            t = java.util.Arrays.copyOf(pt, n);
            prev = prevWord;
            if (answer != Integer.MIN_VALUE) { out.count = Math.max(0, answer); return answer; }
            for (int i = 0; i < words.length; i++) {
                String w = words[i];
                w.getChars(0, w.length(), out.words, i * MrGesture.RESULT_CHARS);
                out.info[2 + 4 * i] = w.length();
                out.info[3 + 4 * i] = w.length();
                out.scores[2 * i] = 10 - i;
                out.scores[2 * i + 1] = logp;
            }
            out.count = words.length;
            return words.length;
        }
    }

    // ---------------------------------------------------------------- the scene
    static Keyboard kb;
    static View v;
    static Ime ime;
    static Eng eng;
    static final long T0 = 5000;

    /** The main row of the tool bar, where the strip lives: in view unless a test hides it. */
    static int barVisibility;

    static void scene() throws Exception {
        MrGestureInput.resetForTest();
        SystemClock.now = 50000;
        barVisibility = android.view.View.VISIBLE;
        MrTools.sBarMain = new android.view.View() {
            @Override public int getVisibility() { return barVisibility; }
        };
        blocked();
        setFontChoice(0);
        kb = keyboard();
        v = view(kb, 1f);
        ime = new Ime();
        eng = new Eng();
        LatinIME.sInstance = ime;
        KeyboardSwitcher sw = KeyboardSwitcher.getInstance();
        sw.view = v;
        sw.stubAlphabet = true;
        sw.stubSheet = 0;
        MrGestureInput.sEngine = eng;
        MrGestureInput.sOn = true;
        MotionEvent.stubLive = 0;
    }

    /** The words the person blocked (MrLearned keeps them in lower case). */
    static void blocked(String... words) throws Exception {
        Field f = MrLearned.class.getDeclaredField("sBlocked");
        f.setAccessible(true);
        f.set(null, new HashSet<String>(java.util.Arrays.asList(words)));
    }

    /** What the keyboard does when its handler comes round to a delayed task: runs what is waiting. */
    static void runPending() {
        if (MrGestureInput.handlerForTest() != null) MrGestureInput.handlerForTest().stubRunPending();
    }

    static void setFontChoice(int choice) throws Exception {
        Field f = MrFonts.class.getDeclaredField("sChoice");
        f.setAccessible(true);
        f.setInt(null, choice);
    }

    static MotionEvent ev(int action, long t, float x, float y) {
        return MotionEvent.stub(action, 0, T0, t, new int[] {0}, new float[] {x}, new float[] {y});
    }

    static boolean down(float x, float y) { return MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_DOWN, T0, x, y)); }
    static boolean move(long t, float x, float y) { return MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_MOVE, T0 + t, x, y)); }
    static boolean up(long t, float x, float y) { return MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_UP, T0 + t, x, y)); }

    /** A whole gesture over the centres of these letters, 4 steps between two letters, 16 ms apart. Returns what UP answered. */
    static boolean swipe(String letters) {
        long t = 0;
        down(cx(letters.charAt(0)), cy(letters.charAt(0)));
        for (int i = 1; i < letters.length(); i++) {
            float x0 = cx(letters.charAt(i - 1)), y0 = cy(letters.charAt(i - 1)), x1 = cx(letters.charAt(i)), y1 = cy(letters.charAt(i));
            for (int s = 1; s <= 4; s++) move(t += 16, x0 + (x1 - x0) * s / 4f, y0 + (y1 - y0) * s / 4f);
        }
        char last = letters.charAt(letters.length() - 1);
        return up(t + 16, cx(last), cy(last));
    }

    static boolean near(float a, float b) { return Math.abs(a - b) < 1e-4f; }

    static String strip(List<CharSequence> l) { return l == null ? "null" : l.toString(); }

    public static void main(String[] a) throws Exception {
        // ---- A. the setting off: nothing is looked at, nothing changes
        scene();
        MrGestureInput.sOn = false;
        check(!down(cx('c'), cy('c')) && !move(16, cx('c') + 300, cy('c')) && !up(32, cx('c') + 300, cy('c')), "off: no event is taken");
        check(MrGestureInput.stateForTest() == 0 && eng.layouts == 0 && eng.decodes == 0 && v.stubBase.isEmpty() && v.stubInvalidates == 0,
                "off: nothing is followed, read or drawn");
        check(MrGestureInput.longPress(100) == 100, "off: the long press keeps its time");
        MrGestureInput.onKey(ime, 'x');
        MrGestureInput.onBackspace(ime);
        check(!MrGestureInput.onPick(ime, 0, "casa") && ime.strips.isEmpty() && ime.ic.text.length() == 0, "off: the three hooks of the text do nothing");
        Canvas canvas = new Canvas();
        MrGestureInput.draw(v, canvas);
        check(canvas.stubPaths == 0, "off: nothing is drawn");

        // ---- B. a tap and a short slide stay with the usual path
        scene();
        check(!down(cx('c'), cy('c')) && MrGestureInput.stateForTest() == 1, "tap: the touch is followed and the event goes on");
        check(MrGestureInput.longPress(100) == 300 && MrGestureInput.longPress(250) == 300 && MrGestureInput.longPress(500) == 500,
                "tap: while it may become a gesture the long press waits at least 300 ms, and a longer setting stays");
        check(!up(60, cx('c'), cy('c')) && MrGestureInput.stateForTest() == 0, "tap: the up goes on and nothing is followed any more");
        check(MrGestureInput.longPress(100) == 100, "tap: after it the long press is back to its time");
        check(v.stubBase.isEmpty() && eng.decodes == 0 && ime.ic.text.length() == 0 && ime.commits == 0, "tap: nothing was cancelled, recognised or written");
        down(cx('c'), cy('c'));
        check(!move(16, cx('c') + 40, cy('c') + 30) && !move(32, cx('c') + 69, cy('c')) && MrGestureInput.stateForTest() == 1,
                "short slide (under 0.7 key): still a possible tap, events go on");
        check(!up(48, cx('c') + 69, cy('c')) && v.stubBase.isEmpty() && eng.decodes == 0, "short slide: the up goes on, the usual path types the key");

        // ---- C. a gesture: the moment it becomes one
        scene();
        down(cx('c'), cy('c'));
        check(!move(16, cx('c') - 30, cy('c')), "gesture: the first move, still near, goes on");
        check(move(32, cx('c') - 70, cy('c')) && MrGestureInput.stateForTest() == 2, "gesture: at 0.7 key from the start the event is taken");
        check(v.stubBase.size() == 1 && v.stubBase.get(0)[0] == MotionEvent.ACTION_CANCEL && v.stubBase.get(0)[1] == (int) (cx('c') - 70),
                "gesture: the usual path receives one cancel event, at the place of the finger");
        check(MotionEvent.stubLive == 0, "gesture: the copy of the event made for the cancel is recycled");
        check(MrGestureInput.longPress(100) == 100, "gesture: the long press is no longer held back (the key was let go)");
        int inval = v.stubInvalidates;
        check(inval >= 1, "gesture: the trail asks for a redraw");
        check(move(48, cx('a'), cy('a')) && move(64, cx('s'), cy('s')) && v.stubBase.size() == 1, "gesture: the moves are taken and the usual path sees none");
        check(v.stubInvalidates > inval && v.stubDirty != null && v.stubDirty[2] - v.stubDirty[0] < 300,
                "gesture: each move redraws only the rectangle around the new piece of the trail");
        MrGestureInput.draw(v, canvas);
        check(canvas.stubPaths == 1, "gesture: the trail is drawn");
        MrGestureInput.draw(view(kb, 1f), canvas);
        check(canvas.stubPaths == 1, "gesture: not on another view");
        inval = v.stubInvalidates;
        check(up(80, cx('a'), cy('a')) && MrGestureInput.stateForTest() == 0, "gesture: the up is taken and it is over");
        check(v.stubInvalidates == inval + 1, "gesture: the trail is erased when the finger lifts");
        MrGestureInput.draw(v, canvas);
        check(canvas.stubPaths == 1, "gesture: nothing is drawn after it");
        check(v.stubBase.size() == 1, "gesture: the usual path never sees the up (it would type the key under the finger)");

        // ---- D. what the recognition receives: the keys and the points, in its frame
        check(eng.layouts == 1 && eng.keys.length == 26, "frame: the 26 letter keys are handed over once (digits, Ctrl, space and the text key are not letters)");
        boolean keysOk = true;
        for (int i = 0; i < eng.keys.length; i++) {
            char c = eng.keys[i];
            int row = ROWS[0].indexOf(c) >= 0 ? 0 : ROWS[1].indexOf(c) >= 0 ? 1 : 2;
            keysOk &= near(eng.xy[2 * i], cx(c) / W) && near(eng.xy[2 * i + 1], (2 * row + 1) / 6f);
        }
        check(keysOk, "frame: every key centre is x/width and 1/6, 1/2 or 5/6 (q 0.05, a 0.10, z 0.20, like gesture/test)");
        check(eng.decodes == 1 && eng.lastN == 6, "frame: every point from the finger down to the finger up goes to the recognition");
        check(near(eng.x[0], cx('c') / W) && near(eng.y[0], 5 / 6f) && eng.t[0] == 0, "frame: the first point is the centre of c, time 0");
        check(near(eng.x[5], 0.10f) && near(eng.y[5], 0.5f) && eng.t[5] == 80, "frame: the last point is the centre of a, 80 ms later");
        check(eng.prev == null, "frame: no previous word in an empty field");

        // ---- E. the text: the word as a picked suggestion, the automatic space, the other candidates
        check(ime.ic.text.toString().equals("casa ") && ime.picks.toString().equals("[-1:casa]"), "text: the best word, picked with index -1, and the automatic space");
        check(ime.commits == 1 && ime.ic.finished == 1 && ime.ic.batch == 0, "text: a word being typed is committed first, a composing region is closed, the batch is balanced");
        check(ime.strips.size() == 2 && ime.strips.get(0) != null && ime.strips.get(0).isEmpty(), "strip: it is made (empty) before the pick, which needs it");
        check(strip(ime.strip()).equals("[cada, caso, cara]"), "strip: the other candidates, second in the middle: " + strip(ime.strip()));
        check(MrGestureInput.stats()[0] == 1 && MrGestureInput.stats()[1] >= 0, "time: one recognition counted");

        // ---- F. the swap: a tap on another candidate
        List<CharSequence> s1 = ime.strip();
        ime.pickSuggestionManually(1, s1.get(1));                       // "caso", the middle one
        check(ime.ic.text.toString().equals("caso ") && ime.picks.toString().equals("[-1:casa, -1:caso]"), "swap: the word in the text is replaced: " + ime.ic.text);
        check(strip(ime.strip()).equals("[cada, casa, cara]"), "swap: the word that left takes its place on the strip: " + strip(ime.strip()));
        ime.pickSuggestionManually(1, ime.strip().get(1));
        check(ime.ic.text.toString().equals("casa ") && strip(ime.strip()).equals("[cada, caso, cara]"), "swap: and back again");
        ime.pickSuggestionManually(0, ime.strip().get(0));
        check(ime.ic.text.toString().equals("cada ") && strip(ime.strip()).equals("[casa, caso, cara]"), "swap: the left one, and the word that left sits where it was: " + strip(ime.strip()));
        ime.pickSuggestionManually(0, "previsão");                      // a word that is not one of the candidates
        check(ime.ic.text.toString().equals("cada previsão ") && ime.picks.get(ime.picks.size() - 1).equals("0:previsão"),
                "swap: any other word of the strip is an ordinary pick");
        int n = ime.picks.size();
        ime.pickSuggestionManually(1, s1.get(1));
        check(ime.picks.size() == n + 1 && ime.picks.get(n).equals("1:caso") && ime.ic.text.toString().equals("cada previsão caso "),
                "swap: after that the old candidates are ordinary words too");

        // ---- G. the backspace takes the whole word back
        scene();
        ime.ic.text.append("foo");
        swipe("casa");
        check(ime.ic.text.toString().equals("foo casa "), "space: a space goes in before the word after a letter: [" + ime.ic.text + "]");
        check("foo".equals(eng.prev), "context: the word before the cursor is the previous word");
        ime.backspace();
        check(ime.ic.text.toString().equals("foo"), "backspace: the word, its automatic space and the space put before it are gone: [" + ime.ic.text + "]");
        check(ime.strip() == null, "backspace: the strip goes back to what it shows between two words");
        ime.backspace();
        check(ime.ic.text.toString().equals("fo"), "backspace: the next one removes one character");
        scene();
        ime.autoSpace = false;
        ime.ic.text.append("foo ");
        swipe("casa");
        check(ime.ic.text.toString().equals("foo casa"), "space: none before the word after a space; no automatic space in this field");
        ime.backspace();
        check(ime.ic.text.toString().equals("foo "), "backspace: without the automatic space, and the space that was already there stays");
        scene();
        swipe("casa");
        ime.key('x');
        check(ime.strip() == null, "any key: the candidates leave the strip");
        ime.backspace();
        check(ime.ic.text.toString().equals("casa "), "any key: after it the backspace removes one character: [" + ime.ic.text + "]");
        // a sentence sign right after the word and its automatic space goes glued to the word, with the space after it
        for (char sign : ".,!?);:".toCharArray()) {
            scene();
            swipe("casa");
            ime.key(sign);
            check(ime.ic.text.toString().equals("casa" + sign + " ") && ime.glues == 1 && ime.strip() == null,
                    "sign " + sign + ": glued to the word, the space after it, the strip back to between words: [" + ime.ic.text + "]");
        }
        scene();
        swipe("casa");
        ime.key(',');
        ime.backspace();
        check(ime.ic.text.toString().equals("casa,"), "sign: the backspace after it removes one character: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.key(' ');
        check(ime.ic.text.toString().equals("casa  ") && ime.glues == 0, "a space is not glued: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.key('a');
        check(ime.ic.text.toString().equals("casa a") && ime.glues == 0, "a letter is not glued: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.key('x');
        ime.key(',');
        check(ime.ic.text.toString().equals("casa x,") && ime.glues == 0, "a sign after another key: nothing pending, typed as it is: [" + ime.ic.text + "]");
        scene();
        ime.autoSpace = false;
        swipe("casa");
        ime.key(',');
        check(ime.ic.text.toString().equals("casa,") && ime.glues == 0, "sign: no automatic space in this field, nothing to glue: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.ic.text.append("mais ");                      // the text changed without a key
        ime.key(',');
        check(ime.ic.text.toString().equals("casa mais ,") && ime.glues == 0, "sign: when the text is no longer what was written, it goes the usual way: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.modifierOn = true;
        ime.key(',');
        check(ime.ic.text.toString().equals("casa ,") && ime.glues == 0 && ime.strip() == null, "sign: with a modifier on LatinIME does not glue it: it goes the usual way: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        ime.key(',');
        ime.key(',');
        check(ime.ic.text.toString().equals("casa, ,") && ime.glues == 1, "sign: only the first one after the word is glued: [" + ime.ic.text + "]");
        scene();
        swipe("casa");
        List<CharSequence> old = ime.strip();
        ime.ic.text.append("mais ");                      // the text changed without a key (a paste, another keyboard tool)
        ime.backspace();
        check(ime.ic.text.toString().equals("casa mais"), "backspace: when the text is no longer what was written, one character");
        ime.pickSuggestionManually(1, old.get(1));
        check(ime.ic.text.toString().equals("casa maiscaso "), "swap: when the text is no longer what was written the tap is an ordinary pick");
        scene();
        swipe("casa");
        Ime other = new Ime();
        other.ic.text.append("casa ");
        LatinIME.sInstance = other;
        other.backspace();
        check(other.ic.text.toString().equals("casa"), "backspace: another field with the same text is not the gesture's");

        // ---- H. where a space is needed, and the capitals
        String[][] spaces = {{"", "casa "}, {"foo ", "foo casa "}, {"foo\n", "foo\ncasa "}, {"foo.", "foo. casa "}, {"foo,", "foo, casa "},
            {"(", "(casa "}, {"foo (", "foo (casa "}, {"\u00bf", "\u00bfcasa "}, {"guarda-", "guarda-casa "}, {"a/", "a/casa "}, {"@", "@casa "},
            {"#", "#casa "}, {"2", "2 casa "}, {"\"", "\"casa "}, {"disse \"", "disse \"casa "}, {"\"oi\"", "\"oi\" casa "}, {"'", "'casa "},
            {"oi'", "oi' casa "}, {"\u201c", "\u201ccasa "}, {"oi\u201d", "oi\u201d casa "}, {"ok)", "ok) casa "}};
        for (String[] sp : spaces) {
            scene();
            ime.ic.text.append(sp[0]);
            swipe("casa");
            check(ime.ic.text.toString().equals(sp[1]), "space: after [" + sp[0] + "] -> [" + ime.ic.text + "]");
        }
        check(!MrGestureInput.needsSpace(null), "space: none when the editor does not answer");
        int[] shifts = {Keyboard.SHIFT_OFF, Keyboard.SHIFT_ON, Keyboard.SHIFT_CAPS, Keyboard.SHIFT_LOCKED, Keyboard.SHIFT_CAPS_LOCKED};
        String[] cased = {"casa ", "Casa ", "Casa ", "CASA ", "CASA "};
        String[] casedStrip = {"[cada, caso, cara]", "[Cada, Caso, Cara]", "[Cada, Caso, Cara]", "[CADA, CASO, CARA]", "[CADA, CASO, CARA]"};
        for (int i = 0; i < shifts.length; i++) {
            scene();
            v.stubShift = shifts[i];
            swipe("casa");
            check(ime.ic.text.toString().equals(cased[i]) && strip(ime.strip()).equals(casedStrip[i]),
                    "capitals: Shift state " + shifts[i] + " -> [" + ime.ic.text + "] " + strip(ime.strip()));
        }
        check(MrGestureInput.withCase("S\u00e3o", Keyboard.SHIFT_ON).equals("S\u00e3o") && MrGestureInput.withCase("\u00e1gua", Keyboard.SHIFT_CAPS).equals("\u00c1gua")
                && MrGestureInput.withCase("\u00e1gua", Keyboard.SHIFT_LOCKED).equals("\u00c1GUA") && MrGestureInput.withCase("", 1).equals(""),
                "capitals: accented letters, a word already capitalised, an empty word");
        scene();
        ime.ic.text.append("Bom dia. ");
        swipe("casa");
        check(eng.prev == null, "context: none after the end of a sentence");
        scene();
        ime.ic.text.append("muito bom ");
        swipe("casa");
        check("bom".equals(eng.prev), "context: the last word before the space");
        scene();
        ime.ic.dead = true;
        swipe("casa");
        check(ime.ic.text.toString().equals("casa ") && eng.prev == null, "text: an editor that does not answer still gets the word (no space guessed, no context)");

        // ---- I. traces that write nothing
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('c'), cy('c') + 100);
        up(32, cx('c'), LETTERS_TOP + 3 * ROW + 51);            // lifted 0.51 row under the letters
        check(eng.decodes == 0 && ime.ic.text.length() == 0 && ime.commits == 0 && v.stubBase.size() == 1,
                "no word: a slide that ends under the letters is dropped before anything is touched");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('c'), cy('c') + 100);
        up(32, cx('c'), LETTERS_TOP + 3 * ROW + 49);
        check(eng.decodes == 1 && ime.ic.text.toString().equals("casa "), "no word: within half a row under the letters it is still a gesture");
        scene();
        down(cx('e'), cy('e'));
        move(16, cx('e'), cy('e') - 100);
        up(32, cx('e'), LETTERS_TOP - 51);
        check(eng.decodes == 0 && ime.ic.text.length() == 0, "no word: a slide that ends above the letters is dropped");
        scene();
        eng.logp = -30.5f;
        swipe("casa");
        check(eng.decodes == 1 && ime.ic.text.length() == 0 && ime.picks.isEmpty() && ime.strips.isEmpty(), "no word: a best word under logp -30 writes nothing");
        scene();
        eng.logp = -29.5f;
        swipe("casa");
        check(ime.ic.text.toString().equals("casa "), "no word: at -29.5 it is written");
        for (int answer : new int[] {0, -1}) {
            scene();
            eng.answer = answer;
            check(swipe("casa") && ime.ic.text.length() == 0 && ime.picks.isEmpty(), "no word: the recognition answers " + answer);
        }
        scene();
        eng.words = new String[] {"casa", "Casa", "CASA"};
        swipe("casa");
        check(ime.ic.text.toString().equals("casa ") && ime.strips.size() == 1, "strip: no candidates when the others are the same word in other capitals");
        scene();
        eng.words = new String[] {"casa", "caso"};
        swipe("casa");
        check(strip(ime.strip()).equals("[caso]"), "strip: a single other candidate");
        scene();
        eng.words = new String[] {"casa", "caso", "cada"};
        swipe("casa");
        check(strip(ime.strip()).equals("[cada, caso]"), "strip: two other candidates, the best in the middle");
        scene();
        eng.words = new String[] {"casa", "caso", "cada", "cara", "cava", "cama"};
        swipe("casa");
        check(strip(ime.strip()).equals("[cada, caso, cara]"), "strip: at most three other candidates");

        // ---- J. when a touch is not followed at all
        String[] names = {"symbols keyboard", "another sheet", "popup open", "another view", "password", "visible password", "web password",
            "address", "e-mail", "web e-mail", "no suggestions", "number field", "no field type", "no connection", "no dictionary",
            "weights not open", "Ctrl on", "Alt on", "font style", "no keyboard service", "layout refused"};
        for (int i = 0; i < names.length; i++) {
            scene();
            LatinKeyboardView target = v;
            switch (i) {
                case 0: KeyboardSwitcher.getInstance().stubAlphabet = false; break;
                case 1: KeyboardSwitcher.getInstance().stubSheet = 2; break;
                case 2: v.stubPopup = true; break;
                case 3: target = view(kb, 1f); break;
                case 4: ime.ei.inputType = 0x81; break;
                case 5: ime.ei.inputType = 0x91; break;
                case 6: ime.ei.inputType = 0xe1; break;
                case 7: ime.ei.inputType = 0x11; break;
                case 8: ime.ei.inputType = 0x21; break;
                case 9: ime.ei.inputType = 0xd1; break;
                case 10: ime.ei.inputType = 0x80001; break;
                case 11: ime.ei.inputType = 0x2; break;
                case 12: ime.ei.inputType = 0; break;
                case 13: ime.hasIc = false; break;
                case 14: eng.dict = false; break;
                case 15: eng.ready = false; break;
                case 16: ctrl.on = true; break;
                case 17: alt.on = true; break;
                case 18: setFontChoice(3); break;
                case 19: LatinIME.sInstance = null; break;
                default: eng.layoutOk = false; break;
            }
            boolean taken = MrGestureInput.onTouch(target, ev(MotionEvent.ACTION_DOWN, T0, cx('c'), cy('c')));
            taken |= MrGestureInput.onTouch(target, ev(MotionEvent.ACTION_MOVE, T0 + 16, cx('a'), cy('a')));
            taken |= MrGestureInput.onTouch(target, ev(MotionEvent.ACTION_UP, T0 + 32, cx('a'), cy('a')));
            check(!taken && MrGestureInput.stateForTest() == 0 && eng.decodes == 0 && target.stubBase.isEmpty() && MrGestureInput.longPress(100) == 100,
                    "not followed: " + names[i]);
        }
        setFontChoice(0);
        scene();
        ime.ei.inputType = 0x4001 | 0x20000 | 0x8000;       // a chat field: capital sentences, several lines, auto-correct
        check(swipe("casa") && ime.ic.text.toString().equals("casa "), "followed: an ordinary chat field");
        float[][] notLetters = {{350, 250}, {500, 650}, {50, 550}, {900, 550}, {750, 650}, {70, 150}};
        for (float[] p : notLetters) {
            scene();
            down(p[0], p[1]);
            check(MrGestureInput.stateForTest() == 0 && !move(16, p[0] + 200, p[1]) && !up(32, p[0] + 200, p[1]) && eng.decodes == 0,
                    "not followed: a touch that starts outside the letters (" + (int) p[0] + ", " + (int) p[1] + "), so the slide actions stay");
        }
        scene();
        down(20, cy('a'));                                    // left of the "a", in the half key of margin of its row
        check(MrGestureInput.stateForTest() == 1, "followed: the margin beside the a belongs to it, as for a tap");
        up(16, 20, cy('a'));
        scene();
        down(980, cy('l'));
        check(MrGestureInput.stateForTest() == 1, "followed: and the one beside the l");
        up(16, 980, cy('l'));

        // ---- K. two fingers
        scene();
        down(cx('c'), cy('c'));
        boolean t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_POINTER_DOWN, 1, T0, T0 + 20, new int[] {0, 1},
                new float[] {cx('c'), cx('k')}, new float[] {cy('c'), cy('k')}));
        check(!t2 && MrGestureInput.stateForTest() == 0, "two fingers: a second finger before the touch is a gesture ends the following (two thumbs)");
        t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_MOVE, 0, T0, T0 + 40, new int[] {0, 1},
                new float[] {cx('c') + 300, cx('k')}, new float[] {cy('c'), cy('k')}));
        check(!t2 && v.stubBase.isEmpty() && eng.decodes == 0, "two fingers: and what follows is the usual path's");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_POINTER_DOWN, 1, T0, T0 + 20, new int[] {0, 1},
                new float[] {cx('a'), cx('k')}, new float[] {cy('a'), cy('k')}));
        check(t2 && MrGestureInput.stateForTest() == 2, "two fingers: a second finger during a gesture is ignored");
        t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_MOVE, 0, T0, T0 + 40, new int[] {0, 1},
                new float[] {cx('s'), cx('j')}, new float[] {cy('s'), cy('j')}));
        t2 &= MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_POINTER_UP, 1, T0, T0 + 60, new int[] {0, 1},
                new float[] {cx('s'), cx('j')}, new float[] {cy('s'), cy('j')}));
        check(t2 && MrGestureInput.stateForTest() == 2 && eng.decodes == 0, "two fingers: it lifts, the gesture goes on");
        check(up(80, cx('a'), cy('a')) && ime.ic.text.toString().equals("casa ") && near(eng.x[eng.lastN - 2], cx('s') / W),
                "two fingers: the gesture ends with its own finger and only its points");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_POINTER_DOWN, 1, T0, T0 + 20, new int[] {0, 1},
                new float[] {cx('a'), cx('k')}, new float[] {cy('a'), cy('k')}));
        t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_POINTER_UP, 0, T0, T0 + 40, new int[] {0, 1},
                new float[] {cx('s'), cx('k')}, new float[] {cy('s'), cy('k')}));
        check(t2 && ime.ic.text.toString().equals("casa ") && MrGestureInput.stateForTest() == 3, "two fingers: the finger of the gesture lifts first: the word is written");
        t2 = MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_MOVE, 0, T0, T0 + 60, new int[] {1}, new float[] {cx('j')}, new float[] {cy('j')}));
        t2 &= MrGestureInput.onTouch(v, MotionEvent.stub(MotionEvent.ACTION_UP, 0, T0, T0 + 80, new int[] {1}, new float[] {cx('j')}, new float[] {cy('j')}));
        check(t2 && MrGestureInput.stateForTest() == 0 && v.stubBase.size() == 1 && eng.decodes == 1,
                "two fingers: the other finger is swallowed to its end (the usual path never saw it go down)");

        // ---- L. the popup, a cancel, a touch that never ended, another view
        scene();
        down(cx('e'), cy('e'));
        v.stubPopup = true;                                   // the long press fired: the accents are open
        check(!move(400, cx('e') + 200, cy('e')) && MrGestureInput.stateForTest() == 0 && v.stubBase.isEmpty(), "popup: once it is open the touch is the popup's");
        scene();
        down(cx('c'), cy('c'));
        check(!MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_CANCEL, T0 + 16, cx('c'), cy('c'))) && MrGestureInput.stateForTest() == 0,
                "cancel: before the gesture it goes on to the usual path");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        inval = v.stubInvalidates;
        check(MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_CANCEL, T0 + 32, cx('a'), cy('a'))) && MrGestureInput.stateForTest() == 0
                && eng.decodes == 0 && ime.ic.text.length() == 0 && v.stubInvalidates == inval + 1, "cancel: during the gesture nothing is written and the trail is erased");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        check(!down(cx('m'), cy('m')) && MrGestureInput.stateForTest() == 1, "a new touch while the last one never ended starts afresh");
        check(up(48, cx('m'), cy('m')) == false && eng.decodes == 0, "and is a tap");
        scene();
        down(cx('c'), cy('c'));
        View ext = view(kb, 1f);
        check(!MrGestureInput.onTouch(ext, ev(MotionEvent.ACTION_DOWN, T0 + 5, 100, 50)) && !MrGestureInput.onTouch(ext, ev(MotionEvent.ACTION_UP, T0 + 9, 100, 50))
                && MrGestureInput.stateForTest() == 1, "another view (the extension row): its events are not looked at and the following goes on");
        check(move(16, cx('a'), cy('a')) && up(32, cx('a'), cy('a')) && ime.ic.text.toString().equals("casa "), "and the gesture on the main view ends as usual");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        View remade = view(kb, 1f);
        KeyboardSwitcher.getInstance().view = remade;         // the keyboard made its view again in the middle of a gesture
        v = remade;
        check(!down(cx('c'), cy('c')) && MrGestureInput.stateForTest() == 1 && swipe("casa") && ime.ic.text.toString().equals("casa "),
                "a view made again: the touch on the new one is followed");

        // ---- M. the points between two events, time, too many points
        scene();
        down(cx('c'), cy('c'));
        MotionEvent hist = ev(MotionEvent.ACTION_MOVE, T0 + 48, cx('c') - 60, cy('c'))
                .stubHistory(new long[] {T0 + 16, T0 + 32}, new float[][] {{cx('c') - 30}, {cx('c') - 90}}, new float[][] {{cy('c')}, {cy('c')}});
        check(MrGestureInput.onTouch(v, hist) && MrGestureInput.stateForTest() == 2, "history: a point recorded between two events can make the gesture");
        up(64, cx('x'), cy('x'));
        check(eng.lastN == 5 && eng.t[1] == 16 && eng.t[2] == 32 && eng.t[3] == 48 && near(eng.x[2], (cx('c') - 90) / W), "history: those points go to the recognition, in order");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        move(10, cx('s'), cy('s'));                           // a time that goes back
        move(10, cx('s'), cy('s'));                           // the same point again
        up(40, cx('a'), cy('a'));
        check(eng.lastN == 4 && eng.t[2] == 16 && eng.t[3] == 40, "time: it never goes back and a repeated point is left out");
        scene();
        down(cx('q'), cy('q'));
        for (int i = 1; i <= 4200; i++) move(i * 8, cx('q') + (i % 100) * 9, cy('q'));
        check(up(40000, cx('p'), cy('p')) && eng.decodes == 0 && ime.ic.text.length() == 0 && MrGestureInput.stateForTest() == 0,
                "too many points (over 4096): the gesture is dropped");

        // ---- N. the size of the keys and of the screen
        scene();
        v = view(kb, 4f);                                     // 22 dp = 88 px: more than 0.7 of a 100 px key
        KeyboardSwitcher.getInstance().view = v;
        down(cx('c'), cy('c'));
        check(!move(16, cx('c') - 87, cy('c')) && move(32, cx('c') - 88, cy('c')), "threshold: never under 22 dp, whatever the key size");
        up(48, cx('x'), cy('x'));
        scene();
        swipe("casa");
        swipe("casa");
        check(eng.layouts == 1, "layout: handed over once for the same keyboard");
        kb.stubWidth = 2 * W;                                 // the same keyboard object, resized (the app resizes it in place)
        for (Keyboard.Key k : kb.keys) { k.x *= 2; k.width *= 2; }
        down(2 * cx('c'), cy('c'));
        up(16, 2 * cx('c'), cy('c'));
        check(eng.layouts == 2 && near(eng.xy[0], 0.05f), "layout: handed over again when the size changes, with the same fractions");
        Keyboard kb2 = keyboard();
        v.keyboard = kb2;
        down(cx('c'), cy('c'));
        up(16, cx('c'), cy('c'));
        check(eng.layouts == 3, "layout: and for another keyboard");
        scene();
        Keyboard few = new Keyboard();
        few.stubWidth = W;
        few.stubHeight = 700;
        few.keys.add(new Keyboard.Key('a', 0, 300, 100, 100));
        few.keys.add(new Keyboard.Key('1', 100, 300, 100, 100));
        v.keyboard = few;
        down(50, 350);
        check(MrGestureInput.stateForTest() == 0 && eng.layouts == 0, "layout: a keyboard with fewer than two letters has no gestures");
        scene();
        Keyboard dup = keyboard();
        dup.keys.add(new Keyboard.Key('A', 900, 600, 100, 100));     // the same letter on a second key
        dup.keys.add(new Keyboard.Key('\u00e7', 950, 400, 50, 100)); // and a letter that is not ASCII
        v.keyboard = dup;
        down(cx('c'), cy('c'));
        check(eng.keys.length == 27 && eng.keys[26] == '\u00e7', "layout: a repeated letter counts once; any letter key counts");
        up(16, cx('c'), cy('c'));
        scene();
        Keyboard one = new Keyboard();                        // a single row of letters
        one.stubWidth = W;
        one.stubHeight = 100;
        for (int i = 0; i < 10; i++) one.keys.add(new Keyboard.Key(ROWS[0].charAt(i), i * 100, 0, 100, 100));
        v.keyboard = one;
        down(50, 50);
        check(near(eng.xy[1], 0.5f), "layout: one row of letters is the whole height of the frame");
        up(16, 50, 50);

        // ---- O. the trail switched off
        scene();
        MrGestureInput.sTrail = false;
        swipe("casa");
        canvas = new Canvas();
        MrGestureInput.draw(v, canvas);
        check(v.stubInvalidates == 0 && canvas.stubPaths == 0 && ime.ic.text.toString().equals("casa "), "trail off: nothing is redrawn, the word is written");

        // ---- P. a fault anywhere never stops the touch
        scene();
        eng.failDecode = true;
        check(swipe("casa") && MrGestureInput.stateForTest() == 0 && ime.ic.text.length() == 0, "fault in the recognition: the up is taken, nothing written, nothing left pending");
        eng.failDecode = false;
        check(swipe("casa") && ime.ic.text.toString().equals("casa "), "fault in the recognition: the next gesture works");
        scene();
        v.failBase = true;
        down(cx('c'), cy('c'));
        check(move(16, cx('a'), cy('a')) && MrGestureInput.stateForTest() == 3 && MotionEvent.stubLive == 0,
                "fault in the usual path while cancelling: the rest of the touch is swallowed, the event copy recycled");
        check(move(32, cx('s'), cy('s')) && up(48, cx('s'), cy('s')) && MrGestureInput.stateForTest() == 0 && eng.decodes == 0, "and it ends with the finger");
        scene();
        ime.failPick = true;
        check(swipe("casa") && MrGestureInput.stateForTest() == 0 && ime.ic.batch == 0, "fault while writing: taken, the batch is closed");
        ime.failPick = false;
        check(!MrGestureInput.onPick(ime, 0, "x"), "fault while writing: the pick hook is not left thinking a write is in progress");
        check(swipe("casa") && ime.ic.text.toString().endsWith("casa "), "fault while writing: the next gesture works");
        scene();
        check(!MrGestureInput.onTouch(v, null) && !MrGestureInput.onTouch(null, ev(MotionEvent.ACTION_DOWN, T0, 1, 1)), "a null event or view is not taken");
        MrGestureInput.draw(null, null);
        MrGestureInput.onKey(null, 'x');
        MrGestureInput.onBackspace(null);
        check(!MrGestureInput.onPick(null, 0, null), "the hooks take null without a fault");
        swipe("casa");
        MrGestureInput.onKey(null, 'x');
        swipe("casa");
        MrGestureInput.onBackspace(null);
        swipe("casa");
        check(!MrGestureInput.onPick(null, 0, ime.strip().get(0)), "even with something pending");

        // ---- Q. the word so far on the strip, while the finger slides (1.96.0)
        preview();

        // ---- R. the blocked words (1.96.0)
        blockedWords();

        // ---- S. the setting and the weights file
        settings();

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }

    // ---------------------------------------------------------------- the word so far on the strip
    static void preview() throws Exception {
        // when the trace is recognised: not before PREVIEW_MS, then at most once in PREVIEW_MS
        scene();
        down(cx('c'), cy('c'));
        check(eng.prepares == 0, "preview: nothing is made ready for a touch that may be a tap");
        move(16, cx('c') - 80, cy('c'));
        check(MrGestureInput.stateForTest() == 2 && eng.prepares == 1 && eng.decodes == 0 && ime.strips.isEmpty() && ime.ic.reads == 0,
                "preview: when the touch becomes a gesture the recognition is made ready, and nothing else happens yet");
        SystemClock.now += 119;
        move(32, cx('x'), cy('x'));
        check(eng.decodes == 0 && ime.strips.isEmpty(), "preview: no recognition before 120 ms of gesture");
        SystemClock.now += 1;
        move(48, cx('a'), cy('a'));
        check(eng.decodes == 1 && eng.lastN == 4 && strip(ime.strip()).equals("[casa]") && ime.strips.size() == 1,
                "preview: at 120 ms the trace so far is recognised and its best word goes to the strip, alone: " + strip(ime.strip()));
        check(ime.ic.reads == 1 && ime.ic.text.length() == 0 && ime.picks.isEmpty() && ime.commits == 0, "preview: the text is read once and nothing is written");
        check(near(eng.x[3], cx('a') / W) && near(eng.y[3], 0.5f), "preview: the points go to the recognition in the same frame as at the end");
        move(64, cx('s'), cy('s'));
        SystemClock.now += 119;
        move(80, cx('d'), cy('d'));
        check(eng.decodes == 1, "preview: not again before another 120 ms");
        SystemClock.now += 1;
        eng.words = new String[] {"caso", "casa"};
        move(96, cx('f'), cy('f'));
        check(eng.decodes == 2 && eng.lastN == 7 && strip(ime.strip()).equals("[caso]") && ime.strips.size() == 2, "preview: then again, and the word on the strip changes");
        SystemClock.now += 120;
        move(112, cx('g'), cy('g'));
        check(eng.decodes == 3 && ime.strips.size() == 2 && ime.ic.reads == 1, "preview: the same word again leaves the strip alone, and the text is not read again");
        // the finger stops: no event comes, and the preview catches up by itself
        move(128, cx('h'), cy('h'));
        check(eng.decodes == 3, "preview: a move that comes too soon is left for later");
        SystemClock.now += 120;
        eng.words = new String[] {"cash", "caso"};
        runPending();
        check(eng.decodes == 4 && eng.lastN == 9 && strip(ime.strip()).equals("[cash]"), "preview: the finger stopped: the trace up to where it is gets recognised when the time comes");
        SystemClock.now += 500;
        runPending();
        check(eng.decodes == 4, "preview: and not again while nothing moves");
        // a tap on that word (another finger) is not a pick
        check(MrGestureInput.onPick(ime, 1, ime.strip().get(0)) && ime.ic.text.length() == 0 && ime.picks.isEmpty(), "preview: a tap on the word so far does nothing");
        // the finger lifts: the word is written as before and the strip gets the other candidates
        eng.words = new String[] {"casa", "caso", "cada", "cara"};
        up(144, cx('a'), cy('a'));
        check(eng.decodes == 5 && ime.ic.text.toString().equals("casa ") && strip(ime.strip()).equals("[cada, caso, cara]") && ime.ic.reads == 2,
                "preview: at the end the whole trace is recognised again, with a fresh reading of the text: [" + ime.ic.text + "] " + strip(ime.strip()));
        long[] st = MrGestureInput.stats();
        check(st[0] == 1 && st[4] == 4 && st[5] >= 0 && st[6] <= st[5], "preview: its recognitions are counted apart from the one that writes: " + st[0] + " and " + st[4]);
        ime.pickSuggestionManually(1, ime.strip().get(1));
        check(ime.ic.text.toString().equals("caso ") && strip(ime.strip()).equals("[cada, casa, cara]"),
                "preview: after the gesture the strip is the candidates' again (a tap swaps the word): [" + ime.ic.text + "]");
        runPending();
        check(eng.decodes == 5, "preview: nothing is left waiting after the gesture");

        // a gesture that writes nothing gives the strip back
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('c'), cy('c') + 100);
        SystemClock.now += 120;
        move(32, cx('c'), cy('c') + 110);
        check(strip(ime.strip()).equals("[casa]"), "preview: shown");
        up(48, cx('c'), LETTERS_TOP + 3 * ROW + 51);          // lifted under the letters: a slide, not a word
        check(ime.strips.size() == 2 && ime.strip() == null && ime.ic.text.length() == 0, "preview: a gesture that writes nothing gives the strip back");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(MrGestureInput.onTouch(v, ev(MotionEvent.ACTION_CANCEL, T0 + 48, cx('s'), cy('s'))) && ime.strips.size() == 2 && ime.strip() == null,
                "preview: a cancelled gesture gives the strip back");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        eng.answer = 0;
        up(48, cx('a'), cy('a'));
        check(ime.strips.size() == 2 && ime.strip() == null && ime.ic.text.length() == 0, "preview: so does one whose whole trace is no word");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(!down(cx('m'), cy('m')) && ime.strips.size() == 2 && ime.strip() == null && MrGestureInput.stateForTest() == 1,
                "preview: and one whose end never came, when the next touch begins");
        up(16, cx('m'), cy('m'));
        // with the candidates of the gesture before still on the strip: they come back
        scene();
        swipe("casa");
        List<CharSequence> alts = ime.strip();
        down(cx('c'), cy('c'));
        move(16, cx('c'), cy('c') + 100);
        SystemClock.now += 120;
        eng.words = new String[] {"coxa"};
        move(32, cx('c'), cy('c') + 110);
        check(strip(ime.strip()).equals("[coxa]"), "preview: over the candidates of the gesture before");
        up(48, cx('c'), LETTERS_TOP + 3 * ROW + 51);
        check(strip(ime.strip()).equals("[cada, caso, cara]") && ime.ic.text.toString().equals("casa "), "preview: a gesture that writes nothing puts those candidates back: " + strip(ime.strip()));
        ime.pickSuggestionManually(1, ime.strip().get(1));
        check(ime.ic.text.toString().equals("caso "), "preview: and a tap on one of them still swaps the word");
        check(alts != ime.strip(), "preview: (the strip got a new list)");

        // what is shown: the capitals of the Shift key, no word under the floor, no blocked word
        scene();
        v.stubShift = Keyboard.SHIFT_ON;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(strip(ime.strip()).equals("[Casa]"), "preview: with the capitals the word will have");
        up(48, cx('a'), cy('a'));
        check(ime.ic.text.toString().equals("Casa "), "preview: (and has)");
        scene();
        eng.logp = -31f;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(eng.decodes == 1 && ime.strips.isEmpty(), "preview: a best word under logp -30 is not shown");
        eng.logp = -2f;
        SystemClock.now += 120;
        move(48, cx('d'), cy('d'));
        eng.answer = 0;
        SystemClock.now += 120;
        move(64, cx('f'), cy('f'));
        check(eng.decodes == 3 && ime.strips.size() == 1 && strip(ime.strip()).equals("[casa]"), "preview: no word for the trace so far: the one shown stays");
        eng.answer = Integer.MIN_VALUE;
        up(80, cx('a'), cy('a'));
        scene();
        blocked("casa");
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(strip(ime.strip()).equals("[caso]"), "preview: a blocked word is passed over: " + strip(ime.strip()));
        up(48, cx('a'), cy('a'));

        // the previous word is the context of the preview too
        scene();
        ime.ic.text.append("minha ");
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check("minha".equals(eng.prev) && ime.ic.text.toString().equals("minha "), "preview: the word before the cursor goes to the recognition");
        up(48, cx('a'), cy('a'));

        // a slow phone: the recognitions are spaced so that they take a sixth of the time at most
        scene();
        eng.sleepMs = 40;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(eng.decodes == 1, "slow recognition: the first one");
        SystemClock.now += 230;
        move(48, cx('d'), cy('d'));
        check(eng.decodes == 1, "slow recognition: 40 ms each: not again within 6 x 40 ms");
        SystemClock.now += 250;
        move(64, cx('f'), cy('f'));
        check(eng.decodes == 2, "slow recognition: then again");
        eng.sleepMs = 0;
        up(80, cx('a'), cy('a'));
        check(ime.ic.text.toString().equals("casa ") && MrGestureInput.stats()[6] >= 40000000L, "slow recognition: the word is written; the longest preview is kept: " + MrGestureInput.stats()[6]);

        // the setting off: the finger slides and nothing is recognised until it lifts
        scene();
        MrGestureInput.sPreview = false;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        for (int i = 1; i <= 5; i++) {
            SystemClock.now += 200;
            move(16 + 16 * i, cx('s') + i, cy('s'));
        }
        runPending();
        check(eng.decodes == 0 && ime.strips.isEmpty() && eng.prepares == 1 && MrGestureInput.handlerForTest() == null,
                "preview off: nothing is recognised or shown while the finger slides (the recognition is still made ready)");
        up(200, cx('a'), cy('a'));
        check(eng.decodes == 1 && ime.ic.text.toString().equals("casa ") && MrGestureInput.stats()[4] == 0, "preview off: the word is written when the finger lifts");
        check(!MrGestureInput.onPick(ime, 0, "outra"), "preview off: a tap on the strip is an ordinary pick");

        // the strip out of view (it lives in the tool bar): nothing is recognised for a word nobody would see
        String[] hidden = {"the tool bar hidden", "another bar in its place (invisible)", "no tool bar yet"};
        for (int i = 0; i < hidden.length; i++) {
            scene();
            if (i == 0) barVisibility = android.view.View.GONE;
            if (i == 1) barVisibility = android.view.View.INVISIBLE;
            if (i == 2) MrTools.sBarMain = null;
            down(cx('c'), cy('c'));
            move(16, cx('a'), cy('a'));
            SystemClock.now += 300;
            move(32, cx('s'), cy('s'));
            runPending();
            check(eng.decodes == 0 && ime.strips.isEmpty() && eng.prepares == 1, "strip out of view (" + hidden[i] + "): no recognition while the finger slides");
            up(48, cx('a'), cy('a'));
            check(eng.decodes == 1 && ime.ic.text.toString().equals("casa "), "strip out of view (" + hidden[i] + "): the word is written as usual");
        }
        // (the tools in the row after the debounce of MrSugg count as in view: the bar is visible and the first list of the preview brings the strip back)

        // faults: the gesture goes on without its preview
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        eng.failDecode = true;
        check(move(32, cx('s'), cy('s')) && MrGestureInput.stateForTest() == 2 && eng.decodes == 1 && ime.strips.isEmpty(), "fault in a preview: the move is taken, the gesture goes on");
        SystemClock.now += 500;
        check(move(48, cx('d'), cy('d')) && eng.decodes == 1, "fault in a preview: no other one in this gesture");
        eng.failDecode = false;
        check(up(64, cx('a'), cy('a')) && ime.ic.text.toString().equals("casa "), "fault in a preview: the word is still written");
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(eng.decodes == 3 && strip(ime.strip()).equals("[casa]"), "fault in a preview: the next gesture has its preview");
        up(48, cx('a'), cy('a'));
        scene();
        eng.failPrepare = true;
        down(cx('c'), cy('c'));
        check(move(16, cx('a'), cy('a')) && MrGestureInput.stateForTest() == 2, "fault while making ready: the touch is a gesture all the same");
        SystemClock.now += 300;
        move(32, cx('s'), cy('s'));
        check(eng.decodes == 0 && up(48, cx('a'), cy('a')) && ime.ic.text.toString().equals("casa "), "fault while making ready: no preview, and the word is written");
        scene();
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        LatinIME.sInstance = null;                            // the keyboard service went away in the middle of a gesture
        check(move(32, cx('s'), cy('s')) && eng.decodes == 0 && up(48, cx('a'), cy('a')) && ime.ic.text.length() == 0, "no keyboard service: no preview, nothing written, no fault");
        scene();
        ime.hasIc = true;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        ime.hasIc = false;                                    // the field went away
        SystemClock.now += 120;
        check(move(32, cx('s'), cy('s')) && eng.decodes == 1 && eng.prev == null && strip(ime.strip()).equals("[casa]"), "no text field during the preview: recognised without a previous word");
        check(up(48, cx('a'), cy('a')) && ime.ic.text.length() == 0 && ime.strip() == null, "no text field at the end: nothing written, the strip given back");
        // the trail and the preview do not depend on each other
        scene();
        MrGestureInput.sTrail = false;
        down(cx('c'), cy('c'));
        move(16, cx('a'), cy('a'));
        SystemClock.now += 120;
        move(32, cx('s'), cy('s'));
        check(strip(ime.strip()).equals("[casa]") && v.stubInvalidates == 0, "preview with the trail off");
        up(48, cx('a'), cy('a'));
    }

    // ---------------------------------------------------------------- the blocked words
    static void blockedWords() throws Exception {
        scene();
        blocked("caso");
        swipe("casa");
        check(ime.ic.text.toString().equals("casa ") && strip(ime.strip()).equals("[cara, cada]"), "blocked: a blocked word is not among the other candidates: " + strip(ime.strip()));
        scene();
        blocked("casa");
        swipe("casa");
        check(ime.ic.text.toString().equals("caso ") && strip(ime.strip()).equals("[cara, cada]"), "blocked: a blocked best word is passed over: [" + ime.ic.text + "] " + strip(ime.strip()));
        scene();
        blocked("casa");
        eng.words = new String[] {"Casa", "CASA", "caso"};
        swipe("casa");
        check(ime.ic.text.toString().equals("caso ") && ime.strips.size() == 1, "blocked: in any capitals");
        scene();
        blocked("casa", "caso", "cada", "cara");
        swipe("casa");
        check(eng.decodes == 1 && ime.ic.text.length() == 0 && ime.picks.isEmpty() && ime.strips.isEmpty(), "blocked: every word blocked: nothing is written");
        scene();
        blocked("casa");
        eng.words = new String[] {"casa", "caso", "cada", "cara", "cava", "cama"};
        swipe("casa");
        check(ime.ic.text.toString().equals("caso ") && strip(ime.strip()).equals("[cara, cada, cava]"), "blocked: the next ones take the places: " + strip(ime.strip()));
        // the floor of the log-probability is asked of the word that is written
        String[] w = {"casa", "caso"};
        MrGesture.Result r = new MrGesture.Result();
        for (int i = 0; i < 2; i++) {
            w[i].getChars(0, 4, r.words, i * MrGesture.RESULT_CHARS);
            r.info[2 + 4 * i] = 4;
        }
        r.count = 2;
        r.scores[1] = -2f;
        r.scores[3] = -31f;
        String[] out = new String[4];
        blocked();
        check(MrGestureInput.candidates(r, out) == 2 && out[0].equals("casa") && out[1].equals("caso"), "candidates: the floor is asked of the first word only");
        blocked("casa");
        check(MrGestureInput.candidates(r, out) == 0, "candidates: with the first one blocked, the next is the one that must pass the floor");
        r.scores[1] = -31f;
        r.scores[3] = -2f;
        check(MrGestureInput.candidates(r, out) == 1 && out[0].equals("caso"), "candidates: a blocked word under the floor does not stop the others");
        blocked();
        check(MrGestureInput.candidates(r, out) == 0, "candidates: a best word under the floor: none");
        r.count = 0;
        check(MrGestureInput.candidates(r, out) == 0 && MrGestureInput.candidates(r, new String[0]) == 0, "candidates: no results, no room");
    }

    // ---------------------------------------------------------------- init() and reload(): the setting, the listener, the file
    static class Prefs implements SharedPreferences {
        final HashMap<String, Object> m = new HashMap<String, Object>();
        final HashSet<OnSharedPreferenceChangeListener> listeners = new HashSet<OnSharedPreferenceChangeListener>();
        public Map<String, ?> getAll() { return m; }
        public String getString(String k, String d) { Object o = m.get(k); return o instanceof String ? (String) o : d; }
        public int getInt(String k, int d) { Object o = m.get(k); return o instanceof Integer ? (Integer) o : d; }
        public long getLong(String k, long d) { Object o = m.get(k); return o instanceof Long ? (Long) o : d; }
        public boolean getBoolean(String k, boolean d) { Object o = m.get(k); return o instanceof Boolean ? (Boolean) o : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { listeners.add(l); }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { listeners.remove(l); }
        void set(String k, Object value) {
            if (value == null) m.remove(k); else m.put(k, value);
            for (OnSharedPreferenceChangeListener l : new ArrayList<OnSharedPreferenceChangeListener>(listeners)) l.onSharedPreferenceChanged(this, k);
        }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String k, String v) { set(k, v); return this; }
                public Editor putInt(String k, int v) { set(k, v); return this; }
                public Editor putLong(String k, long v) { set(k, v); return this; }
                public Editor putBoolean(String k, boolean v) { set(k, v); return this; }
                public Editor remove(String k) { set(k, null); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
    }

    static class Ctx extends Context {
        final File dir;
        final Prefs packs = new Prefs();
        Ctx(File dir) { this.dir = dir; }
        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return null; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return packs; }
        public File getFilesDir() { return new File(dir, "files"); }
        public File getCacheDir() { return new File(dir, "cache"); }
        public void startActivity(android.content.Intent i) { }
    }

    static void settings() throws Exception {
        MrGestureInput.resetForTest();
        File dir = java.nio.file.Files.createTempDirectory("mrgi").toFile();
        Ctx c = new Ctx(dir);
        Prefs def = new Prefs();
        PreferenceManager.stubDefault = def;
        MrGestureInput.init(c);
        check(!MrGestureInput.sOn && MrGestureInput.sTrail && MrGestureInput.sPreview && def.listeners.size() == 1, "setting: off by default, the trail and the preview on, one listener");
        MrGestureInput.init(c);
        check(def.listeners.size() == 1, "setting: a second init adds no listener");
        def.set(MrGestureInput.PREF_ON, Boolean.TRUE);
        check(!MrGestureInput.sOn, "setting: on, but the weights are not installed: gesture typing stays off");
        File model = MrPacks.modelDir(c, MrPacks.MODEL_GESTURE, 1);
        model.mkdirs();
        FileOutputStream out = new FileOutputStream(new File(model, MrPacks.ENCODER));
        out.write(new byte[2048]);
        out.close();
        c.packs.m.put(MrPacks.KEY_MODEL + MrPacks.MODEL_GESTURE, 1);
        check(MrPacks.modelFile(c, MrPacks.MODEL_GESTURE, MrPacks.ENCODER) != null && MrPacks.modelVersion(c, MrPacks.MODEL_GESTURE) == 1,
                "weights: the installed file is found");
        MrGestureInput.reload(c);
        check(MrGestureInput.sOn, "setting: on and the weights installed: gesture typing is on");
        def.set(MrGestureInput.PREF_TRAIL, Boolean.FALSE);
        check(!MrGestureInput.sTrail && MrGestureInput.sOn && MrGestureInput.sPreview, "setting: the trail follows its own switch");
        def.set(MrGestureInput.PREF_PREVIEW, Boolean.FALSE);
        check(!MrGestureInput.sPreview && MrGestureInput.sOn, "setting: the word while sliding follows its own switch (the listener)");
        def.set(MrGestureInput.PREF_ON, Boolean.FALSE);
        check(!MrGestureInput.sOn, "setting: switched off, it is off at once (the listener)");
        def.set(MrGestureInput.PREF_ON, Boolean.TRUE);
        check(MrGestureInput.sOn, "setting: and on again");
        def.set("show_suggestions", Boolean.TRUE);
        check(MrGestureInput.sOn, "setting: another key changes nothing");
        MrPacks.removeModel(c, MrPacks.MODEL_GESTURE);
        check(!MrGestureInput.sOn && !model.exists() && MrPacks.modelVersion(c, MrPacks.MODEL_GESTURE) == 0, "weights removed: off, the folder is gone");
        def.set(MrGestureInput.PREF_ON, null);
        def.set(MrGestureInput.PREF_TRAIL, null);
        def.set(MrGestureInput.PREF_PREVIEW, null);
        check(!MrGestureInput.sOn && MrGestureInput.sTrail && MrGestureInput.sPreview, "setting: restore defaults (the keys removed) leaves it off with the trail and the preview on");
        MrGestureInput.resetForTest();
        PreferenceManager.stubDefault = null;
        MrGestureInput.init(c);
        MrGestureInput.init(null);
        MrGestureInput.reload(null);
        check(!MrGestureInput.sOn, "setting: no preferences or no context: off, no fault");
        MrPacks.deleteTree(dir);
    }
}
