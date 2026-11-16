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
    /** A fake text field: the text before the cursor is all there is. */
    static class Field implements InputConnection {
        StringBuilder text = new StringBuilder();
        String selected;
        boolean silent, fall;
        int reads, deletes, begins, ends, finishes;

        public CharSequence getTextBeforeCursor(int n, int flags) {
            reads++;
            if (fall) throw new IllegalStateException("the app fell over");
            if (silent) return null;
            return text.substring(Math.max(0, text.length() - n));
        }
        public CharSequence getSelectedText(int flags) { return selected; }
        public boolean commitText(CharSequence t, int pos) { text.append(t); return true; }
        public boolean deleteSurroundingText(int before, int after) {
            deletes++;
            text.setLength(Math.max(0, text.length() - before));
            return true;
        }
        public boolean finishComposingText() { finishes++; return true; }
        public boolean beginBatchEdit() { begins++; return true; }
        public boolean endBatchEdit() { ends++; return true; }
    }

    /** The keyboard as far as MrWordDelete sees it: Ctrl, and the word held as composing text. */
    static class Ime extends LatinIME {
        final Field ic = new Field();
        boolean hasIc = true;
        boolean ctrl;                // mModCtrl
        boolean ctrlFall;            // asking for Ctrl throws
        int composing;               // letters of the word being typed (composing text, the last ones of the text)
        int drops;                   // times the keyboard was told to let go of the composing text
        int dropsAtDelete = -1;      // the deletes done when it was told to (to see the order)
        @Override public InputConnection getCurrentInputConnection() { return hasIc ? ic : null; }
        @Override public int mrComposingLength() { return composing; }
        @Override public boolean mrCtrlOn() {
            if (ctrlFall) throw new IllegalStateException("no keyboard");
            return ctrl;
        }
        /** The keyboard lets go of the word (mComposing empty, mPredicting off): the text is not touched. */
        @Override public void mrDropComposing() {
            drops++;
            dropsAtDelete = ic.deletes;
            composing = 0;
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

    // ---------------------------------------------------------------- the word being typed
    static void typed() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);

        // a word being typed (composing text, part of the text of the app) goes like any other word, by position
        Ime ime = new Ime();
        ime.ic.text.append("one two three");
        ime.composing = 5;                                    // "three" is the composing text
        ime.ctrl = true;
        touch(ime);
        check("typed: Ctrl + delete takes the word being typed whole, from the text", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one two "));
        check("typed: the keyboard lets go of the word, once, BEFORE the delete; the app is told to finish its composing text, once",
                ime.drops == 1 && ime.dropsAtDelete == 0 && ime.ic.finishes == 1 && ime.ic.deletes == 1 && ime.composing == 0,
                "drops=" + ime.drops + " at=" + ime.dropsAtDelete + " finishes=" + ime.ic.finishes + " deletes=" + ime.ic.deletes);
        check("typed: all in one batch of edits, closed", ime.ic.begins == 1 && ime.ic.ends == 1);
        check("typed: the next repeat goes on by words, with nothing more to let go of", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one ") && ime.drops == 1 && ime.ic.finishes == 1);
        check("typed: no batch when nothing is composing", ime.ic.begins == 1);
        MrWordDelete.up();

        // the word reopened is the end of a longer run: the rule decides (the hyphen belongs to the word)
        Ime hy = new Ime();
        hy.ic.text.append("no c\u00f3digo-fonte");
        hy.composing = 5;                                     // "fonte": the keyboard reopens what follows the hyphen
        hy.ctrl = true;
        touch(hy);
        check("typed: a reopened part of a word with a hyphen: the whole word goes", MrWordDelete.onBackspace(hy) && hy.ic.text.toString().equals("no "));
        MrWordDelete.up();

        // what the keyboard holds does not change what is deleted: only the text of the app does
        Ime off = new Ime();
        off.ic.text.append("one two three");
        off.composing = 2;                                    // the keyboard holds less (or more) than the word: the app decides
        off.ctrl = true;
        touch(off);
        check("typed: the keyboard's idea of the word does not matter: the word of the text goes", MrWordDelete.onBackspace(off) && off.ic.text.toString().equals("one two "));
        off.composing = 40;
        check("typed: ... even a composing text longer than the text", MrWordDelete.onBackspace(off) && off.ic.text.toString().equals("one "));
        MrWordDelete.up();

        // the app gives no text: nothing is let go of, the usual delete runs (and does what it always did)
        Ime silent = new Ime();
        silent.ic.text.append("one two");
        silent.ic.silent = true;
        silent.composing = 3;
        silent.ctrl = true;
        touch(silent);
        check("typed: the app gives no text: the usual delete runs, the word is left as it is", !MrWordDelete.onBackspace(silent) && silent.drops == 0 && silent.ic.finishes == 0 && silent.composing == 3);
        MrWordDelete.up();

        // a selection: the usual delete removes it, the word being typed is left
        Ime sel = new Ime();
        sel.ic.text.append("one two");
        sel.ic.selected = "two";
        sel.composing = 3;
        sel.ctrl = true;
        touch(sel);
        check("typed: text selected: the usual delete, nothing let go of", !MrWordDelete.onBackspace(sel) && sel.drops == 0 && sel.ic.deletes == 0);
        MrWordDelete.up();

        // the app fails in the middle: the batch is closed
        Ime bad = new Ime();
        bad.ic.text.append("one two");
        bad.composing = 3;
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

        // nothing before the cursor but the word being typed is not possible; an empty field: the usual delete, nothing let go of
        Ime empty = new Ime();
        empty.composing = 1;
        empty.ctrl = true;
        touch(empty);
        check("typed: nothing to delete: the usual delete, the composing text is not let go of", !MrWordDelete.onBackspace(empty) && empty.drops == 0 && empty.ic.finishes == 0);
        MrWordDelete.up();

        // without Ctrl the word being typed goes as always (the class does not touch it)
        Ime plain = new Ime();
        plain.ic.text.append("one two");
        plain.composing = 3;
        touch(plain);
        check("typed: no Ctrl: not for this class", !MrWordDelete.onBackspace(plain) && plain.drops == 0 && plain.ic.finishes == 0 && plain.composing == 3);
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
        typedIme.composing = 3;
        List<String> logT = replay(typedIme, 700, true);
        check("replay: a word being typed and Ctrl held: whole on the touch, then a word per repeat (0, 300, 500) and nothing left to take",
                logT.subList(0, 3).equals(java.util.Arrays.asList("0:word", "300:word", "500:word")) && typedIme.ic.text.length() == 0
                        && typedIme.drops == 1 && typedIme.ic.begins == typedIme.ic.ends, logT + " | " + typedIme.ic.text);

        // 7. the repeat cancelled (a second finger, a slide off the key): the next delete is the usual one
        Ime cut = new Ime();
        cut.ic.text.append("one two");
        cut.ctrl = true;
        touch(cut);
        press(cut);
        MrWordDelete.up();
        check("replay: the repeat cancelled: the next delete is the usual one", !MrWordDelete.onBackspace(cut) && MrWordDelete.interval(50) == 50);
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
        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = null;
        LatinIME.sInstance = null;
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
