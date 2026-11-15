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
 * PC test of delete by words (MrWordDelete, 2.0.0), run through docs/tools/run_java_tests.sh.
 *
 * It counts what can be counted: which text goes for each text before the cursor (a table, then random texts for what must always
 * hold), the setting and how it is read, the time held against the clock (a fake one), the interval, and a whole hold replayed the
 * way the keyboard replays it (a first delete on the touch, a repeat after 300 ms, then one every 50 ms or the interval that
 * MrWordDelete.interval gives) on a fake text field. No time of the device goes into it.
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
        int reads, deletes;

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
        public boolean finishComposingText() { return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }
    }

    static class Ime extends LatinIME {
        final Field ic = new Field();
        boolean hasIc = true;
        int composing;
        @Override public InputConnection getCurrentInputConnection() { return hasIc ? ic : null; }
        @Override public int mrComposingLength() { return composing; }
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
        check("after(): 1000.0 (how the seek bar stores it) -> 1000", MrWordDelete.after("1000.0") == 1000);
        check("after(): 1500 -> 1500", MrWordDelete.after("1500") == 1500);
        check("after(): 1234.6 -> rounded", MrWordDelete.after("1234.6") == 1235);
        check("after(): below the limit -> 500", MrWordDelete.after("100") == 500 && MrWordDelete.after("-5") == 500);
        check("after(): above the limit -> 3000", MrWordDelete.after("9999") == 3000);
        check("after(): missing or not a number -> the default",
                MrWordDelete.after(null) == 1000 && MrWordDelete.after("") == 1000 && MrWordDelete.after("abc") == 1000 && MrWordDelete.after("NaN") == 1000);
        check("after(): blanks around the number are fine", MrWordDelete.after(" 800 ") == 800);

        Prefs p = new Prefs();
        on(p);
        check("setting: off by default, 1000 ms, one listener", !MrWordDelete.sOn && MrWordDelete.sAfter == 1000 && p.listeners.size() == 1);
        MrWordDelete.init(new Ctx());
        check("setting: a second init adds no listener", p.listeners.size() == 1);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("setting: on", MrWordDelete.sOn);
        p.set(MrWordDelete.PREF_AFTER, "2000.0");
        check("setting: the time follows the seek bar (the listener)", MrWordDelete.sAfter == 2000);
        p.set("pref_long_press_duration", "300.0");
        check("setting: another key changes nothing", MrWordDelete.sOn && MrWordDelete.sAfter == 2000);
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        check("setting: switched off, off at once", !MrWordDelete.sOn);
        p.set(MrWordDelete.PREF_ON, null);
        p.set(MrWordDelete.PREF_AFTER, null);
        check("setting: restore defaults (keys removed): off, 1000 ms", !MrWordDelete.sOn && MrWordDelete.sAfter == 1000);

        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = null;
        MrWordDelete.init(new Ctx());
        MrWordDelete.init(null);
        check("setting: no preferences or no context: off, no fault", !MrWordDelete.sOn);
    }

    // ---------------------------------------------------------------- the time held
    static void hold() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        Ime ime = new Ime();
        ime.ic.text.append("one two three");

        MrWordDelete.sFakeNow = 10000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 10000 + 999;
        check("hold: 999 ms of 1000: the usual delete", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0);
        check("hold: the usual interval before it", MrWordDelete.interval(50) == 50);
        MrWordDelete.sFakeNow = 10000 + 1000;
        check("hold: 1000 ms: the word goes", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one two ") && ime.ic.deletes == 1);
        check("hold: and the next repeat is 4 times later", MrWordDelete.interval(50) == 200 && MrWordDelete.interval(40) == 160);
        MrWordDelete.sFakeNow = 10000 + 1200;
        check("hold: next word", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        check("hold: next word, the blank goes with it", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals(""));
        check("hold: nothing left: the usual delete, the interval stays", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 3);

        // a new touch starts again; letting go forgets
        MrWordDelete.down(DELETE);
        check("hold: a new touch: the time starts again and the interval is the usual one", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);
        ime.ic.text.setLength(0);
        ime.ic.text.append("alpha beta");
        MrWordDelete.sFakeNow += 1000;
        check("hold: the second hold also reaches the words", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("alpha "));
        MrWordDelete.up();
        MrWordDelete.sFakeNow += 5000;
        check("hold: after the key was let go, the usual delete and the usual interval", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);

        // another key that repeats does not touch the hold of the delete key
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow += 1000;
        MrWordDelete.down(LEFT);
        check("hold: another key that repeats leaves the hold as it is", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals(""));
        MrWordDelete.down(null);
        MrWordDelete.down(new Keyboard.Key(0, 0, 0, 1, 1));
        Keyboard.Key none = new Keyboard.Key(0, 0, 0, 1, 1);
        none.codes = null;
        MrWordDelete.down(none);
        none.codes = new int[0];
        MrWordDelete.down(none);
        check("hold: a missing key, no codes or an empty list: no fault", true);
        MrWordDelete.up();

        // the setting at 500 and at 3000 ms
        p.set(MrWordDelete.PREF_AFTER, "500.0");
        ime.ic.text.setLength(0);
        ime.ic.text.append("one two");
        MrWordDelete.sFakeNow = 20000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 20499;
        boolean early = MrWordDelete.onBackspace(ime);
        MrWordDelete.sFakeNow = 20500;
        check("hold: the time set (500 ms) decides", !early && MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        MrWordDelete.up();
        p.set(MrWordDelete.PREF_AFTER, "3000.0");
        MrWordDelete.sFakeNow = 30000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 32999;
        check("hold: 3000 ms: not at 2999", !MrWordDelete.onBackspace(ime));
        MrWordDelete.sFakeNow = 33000;
        check("hold: 3000 ms: at 3000", MrWordDelete.onBackspace(ime));
        MrWordDelete.up();
    }

    /** What is left to the usual delete whatever the time held. */
    static void left() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        Ime ime = new Ime();
        MrWordDelete.sFakeNow = 1000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 5000;

        ime.ic.text.append("one two");
        ime.composing = 3;
        check("left: a word being typed (composing text): the usual delete, nothing read from the app",
                !MrWordDelete.onBackspace(ime) && ime.ic.reads == 0 && ime.ic.deletes == 0 && MrWordDelete.interval(50) == 50);
        ime.composing = 0;

        ime.ic.selected = "two";
        check("left: text selected: the usual delete removes it", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0 && ime.ic.reads == 0);
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
        check("left: ... and it stays forgotten (no hold until the next touch)", !MrWordDelete.onBackspace(ime) && ime.ic.deletes == 0);
        MrWordDelete.sFakeNow = 6000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 7000;
        check("left: the next touch works again", MrWordDelete.onBackspace(ime) && ime.ic.text.toString().equals("one "));
        MrWordDelete.up();
    }

    /** Off, nothing happens, and nothing is read from the app. */
    static void off() {
        Prefs p = new Prefs();
        on(p);
        Ime ime = new Ime();
        ime.ic.text.append("one two");
        MrWordDelete.sFakeNow = 1000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 100000;
        check("off: a hold of any length is the usual delete, the app is not asked",
                !MrWordDelete.onBackspace(ime) && ime.ic.reads == 0 && ime.ic.deletes == 0 && MrWordDelete.interval(50) == 50);
        // switched on during a hold that began while it was off: the next touch counts, not this one
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);
        check("off: switched on in the middle of a hold: that hold stays the usual one", !MrWordDelete.onBackspace(ime));
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow += 1000;
        check("off: ... the next touch counts", MrWordDelete.onBackspace(ime));
        // switched off during a hold: the usual delete at once
        p.set(MrWordDelete.PREF_ON, Boolean.FALSE);
        check("off: switched off in the middle of a hold: the usual delete at once, the interval back", !MrWordDelete.onBackspace(ime) && MrWordDelete.interval(50) == 50);
        MrWordDelete.up();
    }

    // ---------------------------------------------------------------- a whole hold, replayed
    /** One delete as LatinIME does it for the keyboard: the words when MrWordDelete takes it, one letter otherwise. */
    static String press(Ime ime) {
        if (MrWordDelete.onBackspace(ime)) return "word";
        if (ime.ic.text.length() > 0) ime.ic.text.setLength(ime.ic.text.length() - 1);
        return "letter";
    }

    /**
     * The key down at t = 0, a repeat at 300 ms and then one after the interval the keyboard asks (50 ms, or what interval() gives),
     * until the finger lifts at endMs. Returns the log of what each delete was, with its time.
     */
    static List<String> replay(Ime ime, int endMs) {
        List<String> log = new ArrayList<String>();
        MrWordDelete.sFakeNow = 100000;
        final long t0 = 100000;
        MrWordDelete.down(DELETE);
        log.add("0:" + press(ime));
        int next = 300;
        while (next <= endMs) {
            MrWordDelete.sFakeNow = t0 + next;
            log.add(next + ":" + press(ime));
            next += MrWordDelete.interval(50);
        }
        MrWordDelete.up();
        return log;
    }

    static void replays() {
        Prefs p = new Prefs();
        on(p);
        p.set(MrWordDelete.PREF_ON, Boolean.TRUE);

        // 1. a long text and a 2.5 s hold, 1 s to start
        Ime ime = new Ime();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 40; i++) sb.append("palavra").append(i).append(' ');
        ime.ic.text.append(sb);
        int before = ime.ic.text.length();
        List<String> log = replay(ime, 2500);
        int letters = 0, wordsN = 0;
        long firstWord = -1, last = -1, minGap = Long.MAX_VALUE;
        for (String e : log) {
            String[] a = e.split(":");
            long t = Long.parseLong(a[0]);
            if (a[1].equals("letter")) letters++;
            else {
                wordsN++;
                if (firstWord < 0) firstWord = t;
                if (last >= 0) minGap = Math.min(minGap, t - last);
                last = t;
            }
        }
        check("replay: letters first (the touch and the repeats up to 1 s): " + letters, letters == 1 + (950 - 300) / 50 + 1, log);
        check("replay: the first word at the first repeat at or after 1 s", firstWord == 1000, "first at " + firstWord);
        check("replay: words every 200 ms from there (1000, 1200 ... 2400): " + wordsN, wordsN == 8 && minGap == 200, "n=" + wordsN + " gap=" + minGap);
        // 15 letters take "palavra39 " and the end of "palavra38" ("palav" is left); the first word step takes "palav", the seven
        // after it a blank and a word each: what is left is the text up to "palavra30 "
        check("replay: the text after it: the letters, then 8 words, to the last blank of palavra30",
                ime.ic.text.toString().equals(sb.substring(0, sb.indexOf("palavra31 "))), ime.ic.text.length() + " of " + before);

        // 2. a hold shorter than the time: letters only, same as before the feature
        Ime ime2 = new Ime();
        ime2.ic.text.append(sb);
        List<String> log2 = replay(ime2, 900);
        boolean allLetters = true;
        for (String e : log2) if (!e.endsWith(":letter")) allLetters = false;
        check("replay: a hold of 900 ms with 1 s set: letters only, every 50 ms", allLetters && log2.size() == 1 + (900 - 300) / 50 + 1, log2);

        // 3. the word being typed goes letter by letter, then the words
        Ime ime3 = new Ime();
        ime3.ic.text.append("one two three");
        ime3.composing = 5;                                   // "three" is the composing text
        MrWordDelete.sFakeNow = 200000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 202000;
        check("replay: composing text, held long: the usual delete (letter)", press(ime3).equals("letter") && ime3.ic.text.toString().equals("one two thre"));
        ime3.composing = 0;                                   // the usual delete took the last letter of it: nothing composed any more
        check("replay: nothing composed any more: the word goes", press(ime3).equals("word") && ime3.ic.text.toString().equals("one two "));
        MrWordDelete.up();

        // 4. many taps in a row never start the words, however long the series
        Ime ime4 = new Ime();
        ime4.ic.text.append(sb);
        boolean never = true;
        long t = 300000;
        for (int i = 0; i < 40; i++) {                        // a tap every 150 ms for 6 s: 150 ms apart is faster than the 200 ms of mDeleteCount
            MrWordDelete.sFakeNow = t;
            MrWordDelete.down(DELETE);
            if (!press(ime4).equals("letter")) never = false;
            MrWordDelete.sFakeNow = t + 60;
            MrWordDelete.up();
            t += 150;
        }
        check("replay: 40 quick taps over 6 s: always one letter", never && MrWordDelete.interval(50) == 50);

        // 5. a hold whose time comes while the finger moves to another repeating key and back is not special: a release forgets it
        Ime ime5 = new Ime();
        ime5.ic.text.append("one two");
        MrWordDelete.sFakeNow = 400000;
        MrWordDelete.down(DELETE);
        MrWordDelete.sFakeNow = 400800;
        MrWordDelete.up();                                    // the repeat was cancelled (a second finger, a slide off the key)
        MrWordDelete.sFakeNow = 402000;
        check("replay: the repeat cancelled at 800 ms, a delete at 2 s from the old touch: the usual one", !MrWordDelete.onBackspace(ime5));
    }

    public static void main(String[] args) {
        words();
        invariants();
        setting();
        hold();
        left();
        off();
        replays();
        MrWordDelete.resetForTest();
        PreferenceManager.stubDefault = null;
        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
