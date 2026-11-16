package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import android.view.inputmethod.InputConnection;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * PC test of Ctrl + delete by words (MrWordDelete, 2.0.0), run through docs/tools/run_java_tests.sh.
 *
 * It counts what can be counted: which text goes for each text before the cursor (a table, then random texts for what must always
 * hold), the setting and how it is read, Ctrl read at the touch and kept for the hold, the interval, the word being typed, and a
 * whole hold replayed the way the keyboard replays it (a first delete on the touch, a repeat after 300 ms, then one every 50 ms
 * or the interval that MrWordDelete.interval gives; a one-shot Ctrl goes off after the first key) on a fake text field. No time
 * of the device goes into it: a hold is a list of counted repeats.
 */
public class WordDelTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond, Object extra) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name + (extra == null ? "" : " | " + extra)); }
    }

    static void check(String name, boolean cond) { check(name, cond, null); }

    // ---------------------------------------------------------------- fakes
    /**
     * A fake text field, the cursor at the end. It has the composing region (the underlined word) and deletes the way Android's
     * BaseInputConnection.deleteSurroundingText does: the composing region counts as part of the selection, so what is deleted is
     * what comes before ITS start (and the region stays, moved with the text).
     */
    static class Field implements InputConnection {
        StringBuilder text = new StringBuilder();
        String selected;
        boolean silent, fall;
        String after = "";                   // the text after the cursor (never touched by the fake)
        boolean noAfter;                     // the text after the cursor cannot be read
        int reads, deletes, begins, ends, finishes, commits, lastPos;
        String lastCommit;
        int compStart = -1;                  // the composing region runs from here to the end of the text; -1 = none

        public CharSequence getTextBeforeCursor(int n, int flags) {
            reads++;
            if (fall) throw new IllegalStateException("the app fell over");
            if (silent) return null;
            return text.substring(Math.max(0, text.length() - n));
        }
        public CharSequence getSelectedText(int flags) { return selected; }
        public CharSequence getTextAfterCursor(int n, int flags) {
            if (fall) throw new IllegalStateException("the app fell over");
            if (noAfter) return null;
            return after.substring(0, Math.min(n, after.length()));
        }
        /** Like Android: the composing region, when there is one, is replaced by the text. */
        public boolean commitText(CharSequence t, int pos) {
            commits++;
            lastCommit = t.toString();
            lastPos = pos;
            if (compStart >= 0 && compStart <= text.length()) text.setLength(compStart);
            compStart = -1;
            text.append(t);
            return true;
        }
        public boolean deleteSurroundingText(int before, int after) {
            deletes++;
            int a = text.length();
            if (compStart >= 0 && compStart < a) a = compStart;          // "ignore the composing text": the delete starts at its start
            final int start = Math.max(0, a - before);
            text.delete(start, a);
            if (compStart >= 0) compStart = Math.min(compStart, start);   // the region follows the text
            if (compStart >= 0 && compStart > text.length()) compStart = text.length();
            return true;
        }
        public boolean finishComposingText() { finishes++; compStart = -1; return true; }
        public boolean beginBatchEdit() { begins++; return true; }
        public boolean endBatchEdit() { ends++; return true; }
    }

    /**
     * The keyboard as far as MrWordDelete sees it: Ctrl, and the word it holds. Two ways to hold one, as in the real keyboard:
     * a word being typed (composing = letters in mComposing, and the app has them as composing text) and a word reopened by the
     * correction under the cursor (correcting: the app has the word as composing text, the strip shows its suggestions and
     * mComposing is EMPTY). reopenAtCursor() is what the keyboard does when the selection report arrives: the word touching the cursor
     * is reopened.
     */
    static class Ime extends LatinIME {
        final Field ic = new Field();
        boolean hasIc = true;
        boolean ctrl;                // mModCtrl
        boolean other;               // Shift, Alt or Meta is on too
        int ctrlOnlyAsked;           // times mrCtrlOnly was asked
        boolean ctrlFall;            // asking for Ctrl throws
        int composing;               // letters of the word being typed (mComposing)
        boolean correcting;          // a word reopened by the correction (TextEntryState.isCorrecting)
        boolean reopens;             // the keyboard reopens the word under the cursor after every delete, as the selection report makes it do
        int drops;                   // times the keyboard was told to let go of its word
        int dropsAtDelete = -1;      // the deletes done when it was told to (to see the order)
        @Override public InputConnection getCurrentInputConnection() { return hasIc ? ic : null; }
        @Override public boolean mrHoldsWord() { return composing > 0 || correcting; }
        @Override public boolean mrCtrlOnly() { ctrlOnlyAsked++; return ctrl && !other; }
        @Override public boolean mrCtrlOn() {
            if (ctrlFall) throw new IllegalStateException("no keyboard");
            return ctrl;
        }
        /** The keyboard lets go (mComposing empty, mPredicting off; a reopened word: the app is told to finish it): the text is not touched. */
        @Override public void mrDropComposing() {
            drops++;
            dropsAtDelete = ic.deletes;
            if (correcting) ic.finishComposingText();
            composing = 0;
            correcting = false;
        }
        /** A word being typed: its last n letters are composing text in the app. */
        void type(int n) { composing = n; ic.compStart = ic.text.length() - n; }
        /** A word reopened by the correction: its last n letters are marked in the app; the keyboard's mComposing stays empty. */
        void reopen(int n) { correcting = true; composing = 0; ic.compStart = ic.text.length() - n; }
        /** The selection report: when the cursor touches a word (a run without blanks), the keyboard reopens it. */
        void reopenAtCursor() {
            int i = ic.text.length();
            while (i > 0 && ic.text.charAt(i - 1) != ' ' && ic.text.charAt(i - 1) != '\n') i--;
            if (i < ic.text.length()) reopen(ic.text.length() - i);
        }
    }

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
        public Editor edit() { return null; }
    }

    static class Ctx extends Context {
        public android.content.res.AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return null; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(android.content.Intent i) { }
    }

    static Keyboard.Key key(int code) { return new Keyboard.Key(code, 0, 0, 10, 10); }

    static final Keyboard.Key DELETE = key(-5);
    static final Keyboard.Key LEFT = key(-20);      // any other key that repeats

    static void on(Prefs p) {
        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = p;
        MrWordDelete.init(new Ctx());
        LatinIME.sInstance = null;
    }

    /** The delete key goes down on this keyboard (the one the keyboard service is). */
    static void touch(Ime ime) {
        LatinIME.sInstance = ime;
        MrWordDelete.down(DELETE);
    }

    // ---------------------------------------------------------------- what a word is
    static void rule(String before, int expected) {
        int got = MrWordDelete.wordLength(before);
        check("word: \"" + before.replace("\n", "\\n").replace("\r", "\\r") + "\" -> " + expected, got == expected, "got " + got);
    }

    static void words() {
        check("word: nothing before the cursor: 0", MrWordDelete.wordLength("") == 0 && MrWordDelete.wordLength(null) == 0);
        rule("hello world", 5);
        rule("hello world ", 6);
        rule("hello world   ", 8);
        rule("hello", 5);
        rule("   ", 3);
        rule("hello, ", 2);                         // the sign, then the word on the next repeat
        rule("hello,", 1);
        rule("hello...", 3);
        rule("hello?!", 2);
        rule("don't", 5);
        rule("don\u2019t", 5);
        rule("state-of-the-art", 16);
        rule("foo-", 1);                            // a hyphen with no letter after it is a sign
        rule("foo-bar", 7);
        rule("well - known", 5);                    // " - " : known goes alone
        rule("it's ", 5);
        rule("a.b", 1);
        rule("x_y2 ", 5);
        rule("caf\u00e9 ", 5);
        rule("cafe\u0301 ", 6);                      // the accent written as a mark stays with its letter
        rule("na\u00efve", 5);
        rule("\u00e7a va", 2);
        rule("\u3053\u3093\u306b\u3061\u306f", 5);   // no spaces in the text: one run of letters
        rule("abc\n", 1);                           // a line break goes alone
        rule("abc\r\n", 2);
        rule("abc\n\n", 1);
        rule("abc  \n  ", 2);                       // blanks up to the line break, not across it
        rule("abc\n  ", 2);
        rule("\n", 1);
        rule("abc\t", 4);                           // a tab is a blank
        rule("abc\u00a0", 4);                       // so is the no-break space
        rule("hi \uD83D\uDE00\uD83D\uDE00 ", 5);       // the blank and the two emojis (two units each)
        rule("hi \uD83D\uDE00", 2);
        rule("hi \uD83D\uDE00\uFE0F", 3);           // the emoji with its variation mark
        rule("x \uD83D\uDC68\u200D\uD83D\uDC69\u200D\uD83D\uDC67", 8);          // the family, one unit
        rule("tel 555-1234", 8);
        rule("2024-11-15", 10);
        rule("(hello)", 1);
        rule("(hello", 5);
        rule("a  b", 1);
        rule("@user", 4);
        rule("#tag", 3);
        // a window that ends in the middle of a word: what is there goes, the rest on the next repeat
        StringBuilder longWord = new StringBuilder();
        for (int i = 0; i < MrWordDelete.LOOKBACK; i++) longWord.append('a');
        check("word: a run as long as the window: all of it", MrWordDelete.wordLength(longWord) == MrWordDelete.LOOKBACK);
    }

    /** What must hold for any text: some progress, never beyond the text, no half pair, no line break crossed with the word. */
    static void invariants() {
        final String alphabet = "ab c\u00e9 ,.!-'\n\r\t\u00a0\uD83D\uDE00\u200D\uFE0F\u0301\u3042_9";
        final Random rnd = new Random(7);
        int texts = 0, steps = 0;
        boolean progress = true, bounded = true, noPair = true, noBreakCross = true;
        String why = null;
        for (int t = 0; t < 4000; t++) {
            int len = rnd.nextInt(40);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < len; i++) {
                int pick = rnd.nextInt(alphabet.length());
                char c = alphabet.charAt(pick);
                // keep surrogate pairs whole: a high surrogate takes its low one
                if (Character.isHighSurrogate(c)) { sb.append(c).append(alphabet.charAt(pick + 1)); i++; }
                else if (Character.isLowSurrogate(c)) continue;
                else sb.append(c);
            }
            texts++;
            String s = sb.toString();
            while (s.length() > 0) {
                int n = MrWordDelete.wordLength(s);
                steps++;
                if (n <= 0) { progress = false; why = "no progress on [" + s + "]"; break; }
                if (n > s.length()) { bounded = false; why = "beyond the text [" + s + "]"; break; }
                String rest = s.substring(0, s.length() - n);
                if (rest.length() > 0 && Character.isHighSurrogate(rest.charAt(rest.length() - 1))) { noPair = false; why = "half pair [" + s + "]"; break; }
                String gone = s.substring(s.length() - n);
                if ((gone.indexOf('\n') >= 0 || gone.indexOf('\r') >= 0)
                        && !(gone.equals("\n") || gone.equals("\r") || gone.equals("\r\n"))) {
                    // a line break inside what goes: only allowed when it is the whole step
                    noBreakCross = false;
                    why = "crossed a break [" + s + "]";
                    break;
                }
                s = rest;
            }
            if (!(progress && bounded && noPair && noBreakCross)) break;
        }
        check("invariants: every step removes at least one character (" + steps + " steps over " + texts + " texts)", progress, why);
        check("invariants: a step never removes more than there is", bounded, why);
        check("invariants: a step never splits a pair of surrogates", noPair, why);
        check("invariants: a step never takes a line break along with a word", noBreakCross, why);
    }

    // ---------------------------------------------------------------- the setting
    static void setting() {
        check("limits: 100 to 600 ms, 200 by default", MrWordDelete.INTERVAL_MIN == 100 && MrWordDelete.INTERVAL_MAX == 600 && MrWordDelete.INTERVAL_DEFAULT == 200);
        final int d = MrWordDelete.INTERVAL_DEFAULT;
        check("interval(): 200.0 (how the seek bar stores it) -> 200", MrWordDelete.interval("200.0", d) == 200);
        check("interval(): 350 -> 350", MrWordDelete.interval("350", d) == 350);
        check("interval(): 149.6 -> rounded", MrWordDelete.interval("149.6", d) == 150);
        check("interval(): below the limit -> 100", MrWordDelete.interval("50", d) == 100 && MrWordDelete.interval("-5", d) == 100);
        check("interval(): above the limit -> 600", MrWordDelete.interval("9999", d) == 600);
        check("interval(): missing or not a number -> the fallback",
                MrWordDelete.interval(null, d) == d && MrWordDelete.interval("", d) == d && MrWordDelete.interval("abc", d) == d && MrWordDelete.interval("NaN", d) == d);
        check("interval(): blanks around the number are fine", MrWordDelete.interval(" 400 ", d) == 400);

        Prefs p = new Prefs();
        on(p);
        check("setting: off by default, 200 ms, one listener", !MrWordDelete.sOn && MrWordDelete.sInterval == 200 && p.listeners.size() == 1);
        MrWordDelete.init(new Ctx());
        check("setting: a second init adds no listener", p.listeners.size() == 1);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("setting: on", MrWordDelete.sOn);
        p.set(MrWordDelete.PREF_INTERVAL, "400.0");
        check("setting: the interval follows the seek bar (the listener)", MrWordDelete.sInterval == 400);
        p.set("pref_long_press_duration", "300.0");
        check("setting: another key changes nothing", MrWordDelete.sOn && MrWordDelete.sInterval == 400);
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        check("setting: switched off, off at once", !MrWordDelete.sOn);
        p.set(MrWordDelete.PREF_ON, null);
        p.set(MrWordDelete.PREF_INTERVAL, null);
        check("setting: restore defaults (keys removed): off, 200 ms", !MrWordDelete.sOn && MrWordDelete.sInterval == 200);

        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = null;
        MrWordDelete.init(new Ctx());
        MrWordDelete.init(null);
        check("setting: no preferences or no context: off, no fault", !MrWordDelete.sOn);
    }

    // ---------------------------------------------------------------- Ctrl at the touch
    static void ctrlAtTouch() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        Ime ime = new Ime();
        ime.ic.text.append("one two three");

        // a tap with Ctrl: one word at once, no time to wait
        ime.ctrl = true;
        touch(ime);
        check("ctrl: a touch with Ctrl on: the word goes at once", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one two ") && ime.ic.deletes == 1);
        ime.ctrl = false;       // a one-shot Ctrl goes off after the first key
        check("ctrl: Ctrl off after the first key: the hold goes on by words", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        check("ctrl: and the interval is the one set", MrWordDelete.interval(50) == 200);
        MrWordDelete.up();
        check("ctrl: let go: back to the usual delete and the usual interval", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);

        // no Ctrl at the touch: the usual delete, even when Ctrl is armed during the hold
        ime.ic.text.setLength(0);
        ime.ic.text.append("one two three");
        ime.ctrl = false;
        touch(ime);
        ime.ctrl = true;
        ime.ic.reads = 0;
        ime.ic.deletes = 0;
        check("ctrl: no Ctrl at the touch: the usual delete (Ctrl turned on later does not count), nothing read from the app",
                !MrWordDelete.onBackspace(ime) && ime.ic.reads == 0 && ime.ic.deletes == 0 && MrWordDelete.interval(50) == 50);
        MrWordDelete.up();

        // a new touch asks again
        touch(ime);
        check("ctrl: a new touch with Ctrl on works again", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one two "));
        ime.ctrl = false;
        touch(ime);
        check("ctrl: a new touch without Ctrl forgets the hold by words", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);
        MrWordDelete.up();

        // another key that repeats (arrows) never starts a hold, and does not touch the hold of the delete key
        ime.ctrl = true;
        ime.ic.text.setLength(0);
        ime.ic.text.append("one two");
        MrWordDelete.up();
        MrWordDelete.down(LEFT);
        check("ctrl: an arrow key with Ctrl on starts nothing", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);
        touch(ime);
        MrWordDelete.down(LEFT);
        check("ctrl: an arrow key during the hold leaves it as it is", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        MrWordDelete.up();

        // a keyboard that is not there, a Ctrl that cannot be asked, odd keys: the usual delete, no fault
        LatinIME.sInstance = null;
        MrWordDelete.down(DELETE);
        check("ctrl: no keyboard service yet: no hold", !MrWordDelete.onBackspace(ime));
        ime.ctrlFall = true;
        touch(ime);
        check("ctrl: asking for Ctrl throws: no hold, no fault", !MrWordDelete.onBackspace(ime));
        ime.ctrlFall = false;
        MrWordDelete.down(null);
        MrWordDelete.down(new Keyboard.Key(0, 0, 0, 1, 1));
        Keyboard.Key none = new Keyboard.Key(0, 0, 0, 1, 1);
        none.codes = null;
        MrWordDelete.down(none);
        none.codes = new int[0];
        MrWordDelete.down(none);
        check("ctrl: a missing key, no codes or an empty list: no fault", true);
        MrWordDelete.up();
    }

    // ---------------------------------------------------------------- the interval
    static void intervals() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        Ime ime = new Ime();
        check("interval: not held: the usual one, whatever the setting", MrWordDelete.interval(50) == 50 && MrWordDelete.interval(7) == 7);
        ime.ctrl = true;
        touch(ime);
        check("interval: held with Ctrl: 200 ms (the default) in place of 50", MrWordDelete.interval(50) == 200);
        p.set(MrWordDelete.PREF_INTERVAL, "100.0");
        check("interval: 100 ms", MrWordDelete.interval(50) == 100);
        p.set(MrWordDelete.PREF_INTERVAL, "600.0");
        check("interval: 600 ms", MrWordDelete.interval(50) == 600);
        check("interval: never shorter than the usual one", MrWordDelete.interval(900) == 900);
        p.set(MrWordDelete.PREF_INTERVAL, null);
        check("interval: the default again when the setting is removed", MrWordDelete.interval(50) == 200);
        MrWordDelete.up();
        check("interval: let go: the usual one", MrWordDelete.interval(50) == 50);
    }

    /** What is left to the usual delete. */
    static void left() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        Ime ime = new Ime();
        ime.ctrl = true;
        touch(ime);

        ime.ic.text.append("one two");
        ime.ic.selected = "two";
        check("left: text selected: the usual delete removes it", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0);
        ime.ic.selected = "";
        check("left: an empty selection is none", MrWordDelete.onBackspace(ime));
        ime.ic.selected = null;
        ime.ic.deletes = 0;
        ime.ic.reads = 0;

        ime.ic.text.setLength(0);
        check("left: the start of the field: the usual delete", !MrWordDelete.onBackspace(ime));

        ime.ic.text.append("one two");
        ime.ic.silent = true;
        check("left: the app gives no text: the usual delete", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0);
        ime.ic.silent = false;

        ime.hasIc = false;
        check("left: no connection: the usual delete", !MrWordDelete.onBackspace(ime));
        ime.hasIc = true;

        ime.ic.fall = true;
        check("left: the app throws: the usual delete and the hold is forgotten", !MrWordDelete.onBackspace(ime));
        ime.ic.fall = false;
        check("left: ... and it stays forgotten until the next touch", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0 && MrWordDelete.interval(50) == 50);
        touch(ime);
        check("left: the next touch works again", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        MrWordDelete.up();
    }

    /** Off, nothing happens, and nothing is read from the app. */
    static void off() {
        Prefs p = new Prefs();
        on(p);
        Ime ime = new Ime();
        ime.ic.text.append("one two");
        ime.ctrl = true;
        touch(ime);
        check("off: with Ctrl on: the usual delete, the app is not asked, the usual interval",
                !MrWordDelete.onBackspace(ime) && ime.ic.reads == 0 && ime.ic.deletes == 0 && MrWordDelete.interval(50) == 50);
        // switched on during a hold that began while it was off: the next touch counts, not this one
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("off: switched on in the middle of a hold: that hold stays the usual one", !MrWordDelete.onBackspace(ime));
        MrWordDelete.up();
        touch(ime);
        check("off: ... the next touch counts", MrWordDelete.onBackspace(ime));
        // switched off during a hold: the usual delete at once
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        check("off: switched off in the middle of a hold: the usual delete at once, the interval back", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);
        MrWordDelete.up();
    }

    // ---------------------------------------------------------------- the word being typed or reopened
    static void typed() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);

        // a word being typed (composing text, part of the text of the app) goes like any other word, by position
        Ime ime = new Ime();
        ime.ic.text.append("one two three");
        ime.type(5);                                          // "three" is the composing text
        ime.ctrl = true;
        touch(ime);
        check("typed: Ctrl + delete takes the word being typed whole, from the text", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one two "));
        check("typed: the keyboard lets go of the word, once, BEFORE the delete; the app's composing text is finished", 
                ime.drops == 1 && ime.dropsAtDelete == 0 && ime.ic.finishes >= 1 && ime.ic.deletes == 1 && ime.ic.compStart == -1 && ime.composing == 0,
                "drops=" + ime.drops + " at=" + ime.dropsAtDelete + " finishes=" + ime.ic.finishes + " deletes=" + ime.ic.deletes);
        check("typed: all in one batch of edits, closed", ime.ic.begins == 1 && ime.ic.ends == 1);
        check("typed: the next repeat goes on by words, with nothing more to let go of", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one ") && ime.drops == 1);
        MrWordDelete.up();

        // THE BUG OF THE VIDEO: the word touching the cursor is reopened by the correction (underlined in the app) and the keyboard
        // holds nothing in mComposing. The delete of the app starts before the underlined word: it must be finished first.
        Ime re = new Ime();
        re.ic.text.append("inseridos diretamente no c\u00f3digo-fonte");
        re.reopen(12);
        re.ctrl = true;
        touch(re);
        check("reopened: the word under the cursor (underlined in the app) goes whole, not a word before it",
                MrWordDelete.onBackspace(re) && re.ic.text.toString().equals("inseridos diretamente no "), re.ic.text);
        check("reopened: the keyboard lets go of it and the app's composing text is finished before the delete",
                re.drops == 1 && re.dropsAtDelete == 0 && re.ic.compStart == -1 && !re.correcting);
        check("reopened: and the next repeats go by words from there",
                MrWordDelete.onBackspace(re) && re.ic.text.toString().equals("inseridos diretamente ")
                        && MrWordDelete.onBackspace(re) && re.ic.text.toString().equals("inseridos ")
                        && MrWordDelete.onBackspace(re) && re.ic.text.toString().equals(""));
        MrWordDelete.up();

        // the same with the keyboard reopening the word under the cursor after every delete (the selection report) while the hold goes on
        Ime again = new Ime();
        again.ic.text.append("inseridos diretamente no c\u00f3digo-fonte");
        again.reopen(12);
        again.ctrl = true;
        touch(again);
        boolean piled = false;
        for (int i = 0; i < 4; i++) {
            if (!MrWordDelete.onBackspace(again)) piled = true;
            again.reopenAtCursor();
        }
        check("reopened: four words in a row with the keyboard reopening the touched word each time: the field is empty, nothing left glued",
                !piled && again.ic.text.length() == 0, again.ic.text);
        MrWordDelete.up();

        // the app has composing text that the keyboard knows nothing about (the two disagree): the delete is still by position
        Ime lost = new Ime();
        lost.ic.text.append("one two three");
        lost.ic.compStart = 8;
        lost.ctrl = true;
        touch(lost);
        check("desync: composing text in the app that the keyboard does not hold: still the word before the cursor, and nothing to let go of",
                MrWordDelete.onBackspace(lost) && lost.ic.text.toString().equals("one two ") && lost.drops == 0 && lost.ic.compStart == -1);
        MrWordDelete.up();

        // nothing held and nothing composed: the app is told all the same (one batch, one finish), the keyboard is not touched
        Ime clean = new Ime();
        clean.ic.text.append("one two");
        clean.ctrl = true;
        touch(clean);
        check("clean: nothing held: the delete, one batch, the app told to finish (a no-op), the keyboard not touched",
                MrWordDelete.onBackspace(clean) && clean.ic.text.toString().equals("one ") && clean.ic.finishes == 1 && clean.ic.begins == 1 && clean.drops == 0);
        MrWordDelete.up();

        // what the keyboard holds does not change what is deleted: only the text of the app does
        Ime off = new Ime();
        off.ic.text.append("one two three");
        off.type(2);                                          // the keyboard holds only 2 letters of the word: the app's text decides
        off.ctrl = true;
        touch(off);
        check("typed: the keyboard's idea of the word does not matter: the word of the text goes", MrWordDelete.onBackspace(off) && off.ic.text.toString().equals("one two "));
        MrWordDelete.up();

        // the app gives no text: nothing is let go of, the usual delete runs (and does what it always did)
        Ime silent = new Ime();
        silent.ic.text.append("one two");
        silent.ic.silent = true;
        silent.type(3);
        silent.ctrl = true;
        touch(silent);
        check("typed: the app gives no text: the usual delete runs, the word is left as it is", !MrWordDelete.onBackspace(silent) && silent.drops == 0 && silent.ic.finishes == 0 && silent.composing == 3);
        MrWordDelete.up();

        // a selection: the usual delete removes it, the word is left
        Ime sel = new Ime();
        sel.ic.text.append("one two");
        sel.ic.selected = "two";
        sel.type(3);
        sel.ctrl = true;
        touch(sel);
        check("typed: text selected: the usual delete, nothing let go of", !MrWordDelete.onBackspace(sel) && sel.drops == 0 && sel.ic.deletes == 0 && sel.ic.finishes == 0);
        MrWordDelete.up();

        // the app fails: nothing is left open
        Ime bad = new Ime();
        bad.ic.text.append("one two");
        bad.type(3);
        bad.ic.fall = true;
        bad.ctrl = true;
        touch(bad);
        check("typed: the app throws: the usual delete runs (false) and nothing is left open", !MrWordDelete.onBackspace(bad) && bad.ic.begins == bad.ic.ends && bad.drops == 0);
        MrWordDelete.up();

        // no connection with a word being typed: the usual delete
        Ime none = new Ime();
        none.composing = 2;
        none.hasIc = false;
        none.ctrl = true;
        touch(none);
        check("typed: no connection: the usual delete", !MrWordDelete.onBackspace(none) && none.drops == 0);
        MrWordDelete.up();

        // an empty field: the usual delete, nothing let go of
        Ime empty = new Ime();
        empty.composing = 1;
        empty.ctrl = true;
        touch(empty);
        check("typed: nothing to delete: the usual delete, nothing let go of", !MrWordDelete.onBackspace(empty) && empty.drops == 0 && empty.ic.finishes == 0);
        MrWordDelete.up();

        // without Ctrl the word goes as always (the class does not touch it)
        Ime plain = new Ime();
        plain.ic.text.append("one two");
        plain.type(3);
        touch(plain);
        check("typed: no Ctrl: not for this class", !MrWordDelete.onBackspace(plain) && plain.drops == 0 && plain.ic.finishes == 0 && plain.composing == 3 && plain.ic.compStart == 4);
        MrWordDelete.up();
    }

    // ---------------------------------------------------------------- a whole hold, replayed
    /** One delete as LatinIME does it for the keyboard: the words when MrWordDelete takes it, one letter otherwise. A one-shot Ctrl goes off after it. */
    static String press(Ime ime) {
        final String what;
        if (MrWordDelete.onBackspace(ime)) what = "word";
        else {
            if (ime.composing > 0) ime.composing--;
            if (ime.ic.text.length() > 0) ime.ic.text.setLength(ime.ic.text.length() - 1);
            what = "letter";
        }
        ime.ctrl = false;
        if (ime.reopens) ime.reopenAtCursor();
        return what;
    }

    /**
     * The key down at t = 0, a repeat at 300 ms and then one after the interval the keyboard asks (50 ms, or what interval() gives),
     * until the finger lifts at endMs. Returns the log of what each delete was, with its time.
     */
    static List<String> replay(Ime ime, int endMs, boolean ctrl) {
        List<String> log = new ArrayList<String>();
        ime.ctrl = ctrl;
        touch(ime);
        log.add("0:" + press(ime));
        int next = 300;
        while (next <= endMs) {
            log.add(next + ":" + press(ime));
            next += MrWordDelete.interval(50);
        }
        MrWordDelete.up();
        return log;
    }

    static String text40() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 40; i++) sb.append("palavra").append(i).append(' ');
        return sb.toString();
    }

    static int count(List<String> log, String what) {
        int n = 0;
        for (String e : log) if (e.endsWith(":" + what)) n++;
        return n;
    }

    static void replays() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        final String sb = text40();

        // 1. Ctrl + a 2.5 s hold, 200 ms: the words from the touch, at 0, 300, 500 ... 2500; Ctrl went off after the first one
        Ime ime = new Ime();
        ime.ic.text.append(sb);
        List<String> log = replay(ime, 2500, true);
        check("replay: Ctrl, 2.5 s, 200 ms: 13 words (0, 300, 500 ... 2500) and no letter", count(log, "word") == 13 && count(log, "letter") == 0, log);
        check("replay: the repeats after the first 300 ms come 200 ms apart", log.get(1).equals("300:word") && log.get(2).equals("500:word") && log.get(12).equals("2500:word"), log);
        check("replay: the text after it: 13 words gone, to the last blank of palavra26", ime.ic.text.toString().equals(sb.substring(0, sb.indexOf("palavra27 "))), ime.ic.text.length() + "");

        // 2. the interval set: 100 and 600
        p.set(MrWordDelete.PREF_INTERVAL, "100.0");
        Ime fast = new Ime();
        fast.ic.text.append(sb);
        List<String> logF = replay(fast, 2500, true);
        check("replay: 100 ms: 24 words (0, 300, 400 ... 2500)", count(logF, "word") == 24 && count(logF, "letter") == 0, logF);
        p.set(MrWordDelete.PREF_INTERVAL, "600.0");
        Ime slow = new Ime();
        slow.ic.text.append(sb);
        List<String> logS = replay(slow, 2500, true);
        check("replay: 600 ms: 5 words (0, 300, 900, 1500, 2100) and the text left is exactly that",
                count(logS, "word") == 5 && slow.ic.text.toString().equals(sb.substring(0, sb.indexOf("palavra35 "))), logS);
        p.set(MrWordDelete.PREF_INTERVAL, null);

        // 3. no Ctrl: as before the feature, one letter every 50 ms
        Ime plain = new Ime();
        plain.ic.text.append(sb);
        List<String> logP = replay(plain, 2500, false);
        check("replay: no Ctrl, 2.5 s: letters only, every 50 ms (46 deletes)", count(logP, "letter") == 46 && count(logP, "word") == 0, logP);
        check("replay: ... the text is shorter by exactly that", plain.ic.text.length() == sb.length() - 46);

        // 4. setting off, Ctrl on: the usual delete
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        Ime offIme = new Ime();
        offIme.ic.text.append(sb);
        List<String> logO = replay(offIme, 2500, true);
        check("replay: setting off, Ctrl on: letters only", count(logO, "letter") == 46 && count(logO, "word") == 0, logO);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);

        // 5. taps: with Ctrl one word each, without it one letter each
        Ime taps = new Ime();
        taps.ic.text.append("one two three");
        List<String> got = new ArrayList<String>();
        for (int i = 0; i < 3; i++) {
            taps.ctrl = true;
            touch(taps);
            got.add(press(taps));
            MrWordDelete.up();
        }
        check("replay: three taps with Ctrl: three words, the text is gone", got.equals(java.util.Arrays.asList("word", "word", "word")) && taps.ic.text.length() == 0, got + " " + taps.ic.text);
        Ime taps2 = new Ime();
        taps2.ic.text.append(sb);
        boolean letters = true;
        for (int i = 0; i < 40; i++) {                        // many quick taps without Ctrl never start the words
            taps2.ctrl = false;
            touch(taps2);
            if (!press(taps2).equals("letter")) letters = false;
            MrWordDelete.up();
        }
        check("replay: 40 taps without Ctrl: one letter each", letters && taps2.ic.text.length() == sb.length() - 40 && MrWordDelete.interval(50) == 50);

        // 6. Autocompletar on: the word being typed whole on the touch, then the words
        Ime typedIme = new Ime();
        typedIme.ic.text.append("alpha beta gam");
        typedIme.type(3);
        List<String> logT = replay(typedIme, 700, true);
        check("replay: a word being typed and Ctrl held: whole on the touch, then a word per repeat (0, 300, 500) and nothing left to take",
                logT.subList(0, 3).equals(java.util.Arrays.asList("0:word", "300:word", "500:word")) && typedIme.ic.text.length() == 0
                        && typedIme.drops == 1 && typedIme.ic.begins == typedIme.ic.ends, logT + " | " + typedIme.ic.text);

        // 6b. the video: the keyboard reopens the word touching the cursor after every delete; a hold with Ctrl goes through the whole text
        Ime video = new Ime();
        video.reopens = true;
        video.ic.text.append("Ferramenta nativa do ecossistema Java utilizada para gerar p\u00e1ginas HTML de documenta\u00e7\u00e3o a partir de coment\u00e1rios inseridos diretamente no c\u00f3digo-fonte");
        video.reopen(12);
        List<String> logV = replay(video, 6000, true);
        check("replay (the video): the 20 words of the phrase held with Ctrl, the first one reopened: 20 words, the field ends empty, nothing glued or left over",
                video.ic.text.length() == 0 && count(logV, "word") == 20, video.ic.text + " | " + logV);

        // 6c. the delete of a sign leaves the cursor touching a word, and the keyboard reopens it; the hold goes on through all of it
        Ime touching = new Ime();
        touching.reopens = true;
        touching.ic.text.append("inseridos diretamente (no c\u00f3digo) e state-of-the-art, fim.");
        touching.reopenAtCursor();
        List<String> logR = replay(touching, 8000, true);
        check("replay (signs): signs and words held with Ctrl, the word touching the cursor reopened after each delete: the field ends empty",
                touching.ic.text.length() == 0 && touching.ic.compStart == -1 && count(logR, "letter") == logR.size() - count(logR, "word"), touching.ic.text + " | " + logR);

        // 7. the repeat cancelled (a second finger, a slide off the key): the next delete is the usual one
        Ime cut = new Ime();
        cut.ic.text.append("one two");
        cut.ctrl = true;
        touch(cut);
        press(cut);
        MrWordDelete.up();
        check("replay: the repeat cancelled: the next delete is the usual one", !MrWordDelete.onBackspace(cut) && MrWordDelete.interval(50) == 50);
    }


    // ---------------------------------------------------------------- Ctrl + Z, word by word
    /** One Ctrl + delete: a touch with Ctrl on, the word goes, the key is let go. */
    static boolean cut(Ime ime) {
        ime.ctrl = true;
        touch(ime);
        final boolean done = MrWordDelete.onBackspace(ime);
        MrWordDelete.up();
        return done;
    }

    /** A Ctrl + Z the keyboard sends as a character: true = it was done by the class and the key must not go to the app. */
    static boolean undo(Ime ime) {
        ime.ctrl = true;
        return MrWordDelete.onUndoRedo(ime, 'z');
    }

    static Ime on4(Prefs p) {
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        final Ime ime = new Ime();
        ime.ic.text.append("one two three four");
        return ime;
    }

    static void undoing() {
        // two words, then Ctrl + Z one at a time, the last one first
        Prefs p = new Prefs();
        Ime ime = on4(p);
        check("undo: two words taken", cut(ime) && cut(ime) && ime.ic.text.toString().equals("one two "), ime.ic.text);
        check("undo: the first Ctrl + Z gives back the LAST word taken (and the key is not sent to the app)",
                undo(ime) && ime.ic.text.toString().equals("one two three "), ime.ic.text);
        check("undo: the cursor goes after the word written (newCursorPosition 1), the word is what was taken, and the field is not left in a batch",
                ime.ic.lastPos == 1 && ime.ic.lastCommit.equals("three ") && ime.ic.begins == ime.ic.ends);
        check("undo: the second gives back the one before: the text is the original again",
                undo(ime) && ime.ic.text.toString().equals("one two three four"), ime.ic.text);
        check("undo: a third one is not for the class (nothing left): the key goes to the app", !undo(ime) && ime.ic.text.toString().equals("one two three four"));

        // a capital Z counts, other keys and other modifiers do not
        ime = on4(p = new Prefs());
        cut(ime); cut(ime); cut(ime);
        ime.ctrl = true;
        check("undo: Ctrl + X is not for the class", !MrWordDelete.onUndoRedo(ime, 'x') && ime.ic.text.toString().equals("one "));
        check("undo: the letter alone, without Ctrl, is not for the class", !(ime.ctrl = false) && !MrWordDelete.onUndoRedo(ime, 'z') && ime.ic.text.toString().equals("one "));
        ime.ctrl = true;
        ime.other = true;
        check("undo: Ctrl with Shift, Alt or Meta (Ctrl + Shift + Z is the redo of the app) is not for the class", !MrWordDelete.onUndoRedo(ime, 'z') && ime.ic.text.toString().equals("one "));
        ime.other = false;
        check("undo: ... and what was kept is still there when Ctrl comes alone", MrWordDelete.onUndoRedo(ime, 'Z') && ime.ic.text.toString().equals("one two "), ime.ic.text);
        check("undo: ... a capital Z does the same (CapsLock, a layout)", undo(ime) && undo(ime) && ime.ic.text.toString().equals("one two three four"));

        // one word alone: the undo of the app gives it back, the class does not take part
        ime = on4(p = new Prefs());
        cut(ime);
        check("undo: one word alone is left to the undo of the app (it gives the same and keeps its own history)",
                !undo(ime) && ime.ic.commits == 0 && ime.ic.text.toString().equals("one two three "));
        check("undo: ... and it is let go: nothing stays kept after it", !undo(ime));
        // ... but after one was written back by the class, the last one is the class's too (the app's step has more words)
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        check("undo: the last one of several is given back by the class as well", undo(ime) && ime.ic.commits == 2 && ime.ic.text.toString().equals("one two three four"));

        // many words, held: a hold takes them one after the other
        ime = on4(p = new Prefs());
        ime.ctrl = true;
        touch(ime);
        MrWordDelete.onBackspace(ime); MrWordDelete.onBackspace(ime); MrWordDelete.onBackspace(ime);
        MrWordDelete.up();
        check("undo: the words of one hold come back one by one, in reverse order",
                undo(ime) && ime.ic.text.toString().equals("one two ") && undo(ime) && ime.ic.text.toString().equals("one two three ")
                        && undo(ime) && ime.ic.text.toString().equals("one two three four") && !undo(ime));
    }

    static void undoValid() {
        Prefs p = new Prefs();
        Ime ime = on4(p);
        cut(ime); cut(ime);
        // text typed after: the text is not the one the words left
        ime.ic.text.append("x");
        check("undo valid: text typed after the delete: not for the class, and everything kept is let go", !undo(ime) && ime.ic.commits == 0);
        ime.ic.text.setLength(ime.ic.text.length() - 1);
        check("undo valid: ... even if the text is the same again", !undo(ime) && ime.ic.commits == 0);

        // the cursor moved: the text before it or after it is not the one left
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        ime.ic.after = "tail";
        check("undo valid: the cursor moved (other text after it): not for the class", !undo(ime) && ime.ic.commits == 0);

        // a selection: Ctrl + Z of the app, not ours (commitText would replace it)
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        ime.ic.selected = "ab";
        check("undo valid: text selected: not for the class", !undo(ime) && ime.ic.commits == 0);
        ime.ic.selected = null;
        check("undo valid: ... and what was kept is let go", !undo(ime));

        // text after the cursor, the same before and after
        ime = on4(p = new Prefs());
        ime.ic.after = " tail of the line";
        cut(ime); cut(ime);
        check("undo valid: text after the cursor that did not change: the words come back", undo(ime) && undo(ime) && ime.ic.text.toString().equals("one two three four"));

        // the text kept by the first delete is not the one before the second: what was kept is let go first
        ime = on4(p = new Prefs());
        cut(ime);                                   // one two three |
        ime.ic.text.append("zz");                   // typed
        cut(ime);                                   // takes zz: one two three |
        check("undo valid: the text changed between two deletes: only the last word is kept (and one alone is the app's)", !undo(ime) && ime.ic.commits == 0);

        // the app holds composing text the keyboard knows nothing of (mrHoldsWord false): it is finished all the same
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        ime.ic.compStart = 4;                       // "one " is underlined in the app; the keyboard holds nothing
        check("undo valid: composing text the keyboard does not hold is finished by the class: the word is written after it, nothing replaced",
                undo(ime) && ime.ic.text.toString().equals("one two three ") && ime.ic.finishes >= 1, ime.ic.text);
        // a word reopened by the correction when the next Ctrl + Z comes: the app holds it as composing text
        ime = on4(p = new Prefs());
        ime.ic.text.setLength(0);
        ime.ic.text.append("alpha beta gamma");
        cut(ime); cut(ime);                         // alpha |
        undo(ime);                                  // alpha beta |
        ime.ic.text.setLength(ime.ic.text.length() - 1);       // put the cursor against "beta" the way a re-correction sees it
        ime.ic.text.append(' ');
        ime.ic.compStart = 6;                       // the app holds "beta " as composing text
        ime.correcting = true;
        // the text is the one the first word left? "alpha beta |" yes: so the last kept word comes back over a composing region
        boolean back = undo(ime);
        check("undo valid: the composing text is finished before the word is written (commitText would replace it)",
                back && ime.ic.text.toString().equals("alpha beta gamma") && ime.ic.finishes >= 1 && ime.drops >= 1 && ime.ic.compStart == -1, ime.ic.text);
    }

    static void undoExpires() {
        Prefs p = new Prefs();
        Ime ime = on4(p);
        MrWordDelete.sClock = 1000;
        cut(ime); cut(ime);
        MrWordDelete.sClock = 1000 + MrWordDelete.UNDO_LIFETIME_MS - 1;
        check("expire: just before its time a word is still there", undo(ime) && ime.ic.text.toString().equals("one two three "));
        MrWordDelete.sClock = 1000 + MrWordDelete.UNDO_LIFETIME_MS;
        check("expire: at its time it is gone: the key goes to the app and the text is left as it is", !undo(ime) && ime.ic.text.toString().equals("one two three "));
        MrWordDelete.sClock = 1000;
        check("expire: and it does not come back", !undo(ime) && ime.ic.commits == 1);

        // only the old ones go
        ime = on4(p = new Prefs());
        MrWordDelete.sClock = 0;
        cut(ime);                                   // one two three |
        MrWordDelete.sClock = MrWordDelete.UNDO_LIFETIME_MS - 10;
        cut(ime);                                   // one two |
        MrWordDelete.sClock = MrWordDelete.UNDO_LIFETIME_MS + 5;
        check("expire: the old one went, the new one is still there: the class gives that one back, not the pair (so not the app's step)",
                undo(ime) && ime.ic.text.toString().equals("one two three "), ime.ic.text);
        check("expire: ... and then nothing is left", !undo(ime));

        // letting go happens with the next key typed, not only with a Ctrl + Z: a key other than Z purges too
        ime = on4(p = new Prefs());
        MrWordDelete.sClock = 0;
        cut(ime); cut(ime);
        MrWordDelete.sClock = MrWordDelete.UNDO_LIFETIME_MS;
        ime.ctrl = true;
        check("expire: another key after the time: not for the class", !MrWordDelete.onUndoRedo(ime, 'a'));
        MrWordDelete.sClock = 0;                     // even if the clock went back, what expired is gone
        check("expire: ... and what expired was let go with it", !undo(ime) && ime.ic.commits == 0);

        // the oldest goes when there are more than the limit
        ime = on4(p = new Prefs());
        MrWordDelete.sClock = 0;
        ime.ic.text.setLength(0);
        final int words = MrWordDelete.UNDO_MAX + 5;
        for (int i = 0; i < words; i++) ime.ic.text.append("w").append(i).append(' ');
        for (int i = 0; i < words; i++) cut(ime);
        int given = 0;
        while (undo(ime)) given++;
        check("expire: at most UNDO_MAX words are kept (the oldest goes first)", given == MrWordDelete.UNDO_MAX, given);
        final StringBuilder expected = new StringBuilder();
        for (int i = 0; i < MrWordDelete.UNDO_MAX; i++) expected.append("w").append(i).append(' ');
        check("expire: ... and they are the newest ones taken: the words nearest the start of the text, the oldest cuts are lost",
                ime.ic.text.toString().equals(expected.toString()), ime.ic.text);
        MrWordDelete.sClock = -1;
    }

    static void undoOff() {
        Prefs p = new Prefs();
        Ime ime = on4(p);
        cut(ime); cut(ime);
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("undo off: setting turned off and on again: what was kept is gone (nothing is asked of the keyboard or the app)",
                !undo(ime) && ime.ic.commits == 0 && ime.ctrlOnlyAsked == 0);
        cut(ime); cut(ime);
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        check("undo off: setting off: the key goes to the app", !undo(ime) && ime.ic.commits == 0);

        // nothing kept: the first line, the app is not asked, the keyboard is not asked
        on(p = new Prefs());
        ime = new Ime();
        ime.ic.text.append("one two");
        ime.ctrl = true;
        check("undo off: nothing kept: false at once, nothing read, nothing asked of the keyboard",
                !MrWordDelete.onUndoRedo(ime, 'z') && ime.ic.reads == 0 && ime.ctrlOnlyAsked == 0 && ime.ic.commits == 0);
        // the setting off: a Ctrl + delete never keeps anything
        cut(ime);
        check("undo off: setting off: Ctrl + delete keeps nothing", !undo(ime) && ime.ctrlOnlyAsked == 0);
    }

    static void undoFaults() {
        Prefs p = new Prefs();
        Ime ime = on4(p);
        cut(ime); cut(ime);
        ime.ic.fall = true;
        boolean threw = false, r = true;
        try { r = undo(ime); } catch (Throwable t) { threw = true; }
        check("undo fault: the app falls over: nothing is thrown, the key goes to the app", !threw && !r);
        ime.ic.fall = false;
        check("undo fault: ... and what was kept is let go", !undo(ime));

        // the text after the cursor cannot be read: the delete is done, nothing is kept
        ime = on4(p = new Prefs());
        ime.ic.noAfter = true;
        check("undo fault: text after the cursor unreadable: the word still goes", cut(ime) && ime.ic.text.toString().equals("one two three "));
        check("undo fault: ... nothing is kept", !cut(ime) || !undo(ime));
        ime.ic.noAfter = false;
        check("undo fault: ... (the one word of the second delete is the app's)", !undo(ime));

        // the keyboard asked for Ctrl falls over: not for the class
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        ime.ic.silent = true;
        check("undo fault: the text before the cursor unreadable: not for the class", !undo(ime) && ime.ic.commits == 0);
        ime.ic.silent = false;
        check("undo fault: ... and what was kept is let go", !undo(ime));

        // no field
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        ime.hasIc = false;
        check("undo fault: no field: not for the class", !undo(ime));
    }

    // ---------------------------------------------------------------- Ctrl + Y, the redo
    static boolean redo(Ime ime) {
        ime.ctrl = true;
        return MrWordDelete.onUndoRedo(ime, 'y');
    }

    static void redoing() {
        Prefs p = new Prefs();
        Ime ime = on4(p);
        cut(ime); cut(ime);
        check("redo: nothing given back yet: Ctrl + Y is not for the class", !redo(ime) && ime.ic.text.toString().equals("one two "));
        check("redo: ... and what was kept is still there (Ctrl + Z gives the last word)", undo(ime) && ime.ic.text.toString().equals("one two three "), ime.ic.text);
        check("redo: Ctrl + Y takes out again the word given back (the key is not sent to the app)", redo(ime) && ime.ic.text.toString().equals("one two "), ime.ic.text);
        check("redo: the field is not left in a batch and the delete took exactly the word", ime.ic.begins == ime.ic.ends && ime.ic.deletes == 3);
        check("redo: nothing more to redo: not for the class", !redo(ime));
        check("redo: the word taken again can be given back again by Ctrl + Z", undo(ime) && ime.ic.text.toString().equals("one two three "), ime.ic.text);

        // two words given back, taken again in the original order
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime); undo(ime);
        check("redo: both words are back", ime.ic.text.toString().equals("one two three four"));
        check("redo: Ctrl + Y repeats the deletes in the order they were done: the nearest to the cursor first",
                redo(ime) && ime.ic.text.toString().equals("one two three ") && redo(ime) && ime.ic.text.toString().equals("one two ") && !redo(ime), ime.ic.text);
        check("redo: ... and then Ctrl + Z goes through them again, last first",
                undo(ime) && ime.ic.text.toString().equals("one two three ") && undo(ime) && ime.ic.text.toString().equals("one two three four"), ime.ic.text);

        // other keys, other modifiers
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.ctrl = true;
        ime.other = true;
        check("redo: Ctrl with Shift, Alt or Meta is not for the class", !MrWordDelete.onUndoRedo(ime, 'y') && ime.ic.text.toString().equals("one two three "));
        ime.other = false;
        ime.ctrl = false;
        check("redo: the letter alone, without Ctrl, is not for the class", !MrWordDelete.onUndoRedo(ime, 'y') && ime.ic.text.toString().equals("one two three "));
        check("redo: a capital Y counts, with Ctrl alone", (ime.ctrl = true) && MrWordDelete.onUndoRedo(ime, 'Y') && ime.ic.text.toString().equals("one two "), ime.ic.text);

        // a new Ctrl + delete ends the redo
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);                                  // one two three |
        cut(ime);                                   // takes "three ": one two |
        check("redo: a new Ctrl + delete ends the redo", !redo(ime) && ime.ic.text.toString().equals("one two "));

        // the text is not the one the return left
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.ic.text.append("x");
        check("redo valid: text typed after the word came back: not for the class", !redo(ime) && ime.ic.deletes == 2);
        ime.ic.text.setLength(ime.ic.text.length() - 1);
        check("redo valid: ... and everything is let go, even if the text is the same again", !redo(ime) && !undo(ime));
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.ic.after = "tail";
        check("redo valid: the cursor moved (other text after it): not for the class", !redo(ime) && ime.ic.deletes == 2);
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.ic.selected = "ab";
        check("redo valid: text selected: not for the class", !redo(ime) && ime.ic.deletes == 2);
        ime.ic.selected = null;
        check("redo valid: ... and what was kept is let go", !redo(ime) && !undo(ime));

        // text after the cursor and a long text before it (the window is the last 64 characters)
        ime = on4(p = new Prefs());
        final StringBuilder lead = new StringBuilder();
        for (int i = 0; i < 40; i++) lead.append("long ");
        ime.ic.text.insert(0, lead);
        ime.ic.after = " the rest of the line";
        cut(ime); cut(ime);
        undo(ime); undo(ime);
        check("redo valid: a long text before the cursor and text after it: the words go again in order",
                redo(ime) && ime.ic.text.toString().endsWith("three ") && redo(ime) && ime.ic.text.toString().endsWith("two ") && !redo(ime)
                        && undo(ime) && undo(ime) && ime.ic.text.toString().equals(lead + "one two three four"), ime.ic.text.length());

        // composing text the keyboard does not hold: finished first, the delete is not taken by it
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);                                  // one two three |
        ime.ic.compStart = 4;                       // "two three " is composing text in the app
        check("redo valid: the app's composing text is finished before the delete: only the word goes",
                redo(ime) && ime.ic.text.toString().equals("one two ") && ime.ic.compStart == -1, ime.ic.text);

        // a word alone: the undo of the app gives it back, Ctrl + Y is checked against the text
        ime = on4(p = new Prefs());
        cut(ime);                                   // one two three |
        check("redo: a word alone: Ctrl + Z is the app's", !undo(ime) && ime.ic.commits == 0);
        ime.ic.text.append("four");                 // what the app's undo did
        check("redo: ... and Ctrl + Y takes it out again once the app gave it back", redo(ime) && ime.ic.text.toString().equals("one two three "), ime.ic.text);
        check("redo: ... a word taken again alone is again left to the app's undo", !undo(ime) && ime.ic.commits == 0);
        ime = on4(p = new Prefs());
        cut(ime);
        undo(ime);                                  // the app did NOT give it back: the text is still "one two three "
        check("redo: a word alone and the app did not give it back: Ctrl + Y is not for the class", !redo(ime) && ime.ic.text.toString().equals("one two three "));

        // expiry of the second list
        ime = on4(p = new Prefs());
        MrWordDelete.sClock = 5;
        cut(ime); cut(ime);
        undo(ime);
        MrWordDelete.sClock = 5 + MrWordDelete.UNDO_LIFETIME_MS - 1;
        check("redo expire: just before its time the word is still there", redo(ime) && ime.ic.text.toString().equals("one two "));
        undo(ime);
        MrWordDelete.sClock = 5 + 2 * MrWordDelete.UNDO_LIFETIME_MS;
        check("redo expire: after its time it is gone: the key goes to the app", !redo(ime) && ime.ic.text.toString().equals("one two three "));
        MrWordDelete.sClock = -1;

        // the limit holds for both lists together: a word only changes list
        ime = on4(p = new Prefs());
        ime.ic.text.setLength(0);
        final int words = MrWordDelete.UNDO_MAX + 5;
        for (int i = 0; i < words; i++) ime.ic.text.append("w").append(i).append(' ');
        for (int i = 0; i < words; i++) cut(ime);
        int back = 0, again = 0;
        while (undo(ime)) back++;
        while (redo(ime)) again++;
        check("redo: all the words given back can be taken again: no more than the limit, the same number both ways", back == MrWordDelete.UNDO_MAX && again == back && ime.ic.text.length() == 0, back + "," + again);

        // release: both lists
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        MrWordDelete.release();
        check("release: nothing is kept in either list: Ctrl + Y and Ctrl + Z are not for the class", !redo(ime) && !undo(ime) && ime.ic.text.toString().equals("one two three "));
        MrWordDelete.release();
        check("release: with nothing kept it does nothing and does not throw", true);
        ime.ic.reads = 0;
        ime.ctrlOnlyAsked = 0;
        ime.ctrl = true;
        check("release: nothing kept: Ctrl + Y returns at once (nothing read, the keyboard not asked)", !MrWordDelete.onUndoRedo(ime, 'y') && ime.ic.reads == 0 && ime.ctrlOnlyAsked == 0);

        // the setting off
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("redo off: setting turned off and on again: the second list is gone too", !redo(ime) && ime.ic.deletes == 2);

        // a failing app
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.ic.fall = true;
        boolean threw = false, r = true;
        try { r = redo(ime); } catch (Throwable t) { threw = true; }
        ime.ic.fall = false;
        check("redo fault: the app falls over: nothing is thrown, the key goes to the app, and everything is let go", !threw && !r && !redo(ime) && !undo(ime));
        ime = on4(p = new Prefs());
        cut(ime); cut(ime);
        undo(ime);
        ime.hasIc = false;
        check("redo fault: no field: not for the class", !redo(ime));
    }

    public static void main(String[] args) {
        words();
        invariants();
        setting();
        ctrlAtTouch();
        intervals();
        left();
        off();
        typed();
        replays();
        undoing();
        undoValid();
        undoExpires();
        undoOff();
        undoFaults();
        redoing();
        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = null;
        LatinIME.sInstance = null;
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
