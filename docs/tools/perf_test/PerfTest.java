package com.mrkeyboard.app;

import android.content.res.Resources;
import android.os.Debug;
import android.os.SystemClock;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.util.Log;
import android.view.MotionEvent;

import java.util.ArrayList;
import java.util.Locale;

/**
 * MrPerf (docs/plan-performance.md, stage 2): the performance meter of the keyboard. The begin/end pairs measure in
 * microseconds; the average and the p95 come from the last 256 samples, the count and the maximum from the last reset; the
 * first frame after a field opens is timed from the start of the open (not after 2 s); a touch counts how late a finger down
 * reached the keyboard; the Advanced row shows it with the memory and a tap resets it; the log gets one line per hide with keys.
 */
public class PerfTest {
    static int ok, fail;

    static void check(String w, boolean c) {
        if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); }
    }

    static void check(String w, Object want, Object got) {
        boolean c = want == null ? got == null : want.equals(got);
        if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w + " | want " + want + " got " + got); }
    }

    /** The texts of the row, as the three languages have them (the English ones). */
    static final String[][] TEXTS = {
            {"mr_ui_perf_create", "Start the keyboard"}, {"mr_ui_perf_view", "Build the view"}, {"mr_ui_perf_open", "Open in a field"},
            {"mr_ui_perf_shown", "Until the first frame"}, {"mr_ui_perf_frame", "Draw a frame"}, {"mr_ui_perf_key", "Handle a key"},
            {"mr_ui_perf_touch", "Touch wait"}, {"mr_ui_perf_app", "Questions to the app"}, {"mr_ui_perf_sugg", "Suggestions"},
            {"mr_ui_perf_key_letter", "Key letter"}, {"mr_ui_perf_key_sep", "Key separator"}, {"mr_ui_perf_key_del", "Key delete"},
            {"mr_ui_perf_key_other", "Key other"}, {"mr_ui_perf_sugg_engine", "Suggestions engine"},
            {"mr_ui_perf_sugg_show", "Suggestions strip"}, {"mr_ui_perf_open_kb", "Open keyboard"},
            {"mr_ui_perf_open_set", "Open settings"}, {"mr_ui_perf_popup", "Popup"},
            {"mr_ui_perf_stat", "%1$s: average %2$s ms · p95 %3$s · max %4$s (%5$d×)"}, {"mr_ui_perf_one", "%1$s: %2$s ms (once)"},
            {"mr_ui_perf_none", "Nothing measured yet."}, {"mr_ui_perf_mem", "Memory: Java %1$s · native %2$s"},
            {"mr_ui_perf_reset", "Tap to start again from zero."}};

    static String text(String name) {
        for (String[] t : TEXTS) if (t[0].equals(name)) return t[1];
        return null;
    }

    static class Row extends Preference {
        CharSequence summary;
        OnPreferenceClickListener click;
        Row() { super(null); }
        public void setSummary(CharSequence s) { summary = s; }
        public void setOnPreferenceClickListener(OnPreferenceClickListener l) { click = l; }
    }

    static class Advanced extends PreferenceActivity {
        final Row row = new Row();
        final ArrayList<String> asked = new ArrayList<String>();
        boolean hasRow = true, broken;
        public Preference findPreference(CharSequence key) {
            if (broken) throw new IllegalStateException("no screen");
            asked.add(String.valueOf(key));
            return hasRow && "mr_perf".equals(String.valueOf(key)) ? row : null;
        }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public Resources getResources() {
            return new Resources() {
                public int getIdentifier(String name, String defType, String defPackage) {
                    return "string".equals(defType) && text(name) != null ? name.hashCode() : 0;
                }
                String byId(int id) {
                    for (String[] t : TEXTS) if (t[0].hashCode() == id) return t[1];
                    return null;
                }
                public String getString(int id) { return byId(id); }
                public String getString(int id, Object... args) { return String.format(Locale.US, byId(id), args); }
            };
        }
    }

    static int[] st(int kind) { return MrPerf.stats(kind); }

    static String join(int[] a) {
        StringBuilder sb = new StringBuilder();
        for (int v : a) sb.append(sb.length() > 0 ? "," : "").append(v);
        return sb.toString();
    }

    /** The clock moves by <code>us</code> microseconds. */
    static void tick(long us) { MrPerf.sFakeNanos += us * 1000; }

    public static void main(String[] a) {
        Locale.setDefault(Locale.US);
        MrPerf.sFakeNanos = 0;
        Debug.stubNativeHeap = 18300000L;

        // ---------------------------------------------------------------- nothing yet
        MrPerf.reset();
        for (int k = 0; k < MrPerf.KINDS; k++) check("kind " + k + ": nothing measured", "0,0,0,0,0", join(st(k)));
        Advanced scr = new Advanced();
        MrPerf.fill(scr);
        String sum = String.valueOf(scr.row.summary);
        check("empty: 'nothing yet', the memory, no reset line", sum.startsWith("Nothing measured yet.\nMemory: Java ")
                && sum.endsWith(" · native 18.3 MB") && !sum.contains("Tap"));
        check("the row was looked up by its key", "[mr_perf]", scr.asked.toString());
        check("a tap listener is set", scr.row.click != null);

        // ---------------------------------------------------------------- begin / end
        MrPerf.keyBegin('a'); tick(1500); MrPerf.keyEnd();
        check("a key of 1.5 ms: 1500 us", "1,1500,1500,1500,1500", join(st(MrPerf.KEY)));
        check("... also counted as a letter", "1,1500,1500,1500,1500", join(st(MrPerf.KEY_LETTER)));
        MrPerf.keyEnd();
        check("an end with no begin is ignored", 1, st(MrPerf.KEY)[0] + st(MrPerf.KEY_LETTER)[0] - 1);
        MrPerf.keyBegin('a'); tick(900); MrPerf.keyBegin('a'); tick(300); MrPerf.keyEnd();
        check("a second begin starts again", 300, st(MrPerf.KEY)[4]);
        check("the kind of each key code: letters, digits, accents",
                MrPerf.keyKind('a') == MrPerf.KEY_LETTER && MrPerf.keyKind('Z') == MrPerf.KEY_LETTER
                        && MrPerf.keyKind('7') == MrPerf.KEY_LETTER && MrPerf.keyKind('\u00e9') == MrPerf.KEY_LETTER
                        && MrPerf.keyKind('\u00e7') == MrPerf.KEY_LETTER);
        check("... space, Enter, punctuation",
                MrPerf.keyKind(' ') == MrPerf.KEY_SEP && MrPerf.keyKind('\n') == MrPerf.KEY_SEP && MrPerf.keyKind('.') == MrPerf.KEY_SEP
                        && MrPerf.keyKind(',') == MrPerf.KEY_SEP && MrPerf.keyKind('?') == MrPerf.KEY_SEP && MrPerf.keyKind('\'') == MrPerf.KEY_SEP);
        check("... delete, and the negative codes and 0 (shift, symbols, modes)",
                MrPerf.keyKind(-5) == MrPerf.KEY_DEL && MrPerf.keyKind(-1) == MrPerf.KEY_OTHER && MrPerf.keyKind(-2) == MrPerf.KEY_OTHER
                        && MrPerf.keyKind(-3) == MrPerf.KEY_OTHER && MrPerf.keyKind(0) == MrPerf.KEY_OTHER
                        && MrPerf.keyKind(-100) == MrPerf.KEY_OTHER);
        MrPerf.reset();
        int[] kinds = {MrPerf.KEY_LETTER, MrPerf.KEY_SEP, MrPerf.KEY_DEL, MrPerf.KEY_OTHER};
        int[] codes = {'d', ' ', -5, -1};
        for (int i = 0; i < 4; i++) {
            MrPerf.keyBegin(codes[i]); tick(700); MrPerf.keyEnd();
            boolean only = st(kinds[i])[4] == 700;
            for (int j = 0; j < 4; j++) if (j != i && st(kinds[j])[0] != 0) only = false;
            check("key code " + codes[i] + ": KEY and its own kind, no other kind", only && st(MrPerf.KEY)[0] == 1);
            MrPerf.reset();
        }
        for (int c : codes) { MrPerf.keyBegin(c); tick(10); MrPerf.keyEnd(); }
        check("four keys: KEY counts 4, each kind 1", "4,1,1,1,1",
                st(MrPerf.KEY)[0] + "," + st(MrPerf.KEY_LETTER)[0] + "," + st(MrPerf.KEY_SEP)[0] + "," + st(MrPerf.KEY_DEL)[0]
                        + "," + st(MrPerf.KEY_OTHER)[0]);
        MrPerf.reset();
        MrPerf.sFakeNanos = 5_000_000;
        MrPerf.appBegin(); MrPerf.sFakeNanos = 4_000_000; MrPerf.appEnd();
        check("a clock going back counts 0", 0, st(MrPerf.APP)[4]);
        MrPerf.sFakeNanos = 10_000_000;
        MrPerf.appBegin(); tick(250); MrPerf.appEnd();
        check("sub-millisecond: 250 us", 250, st(MrPerf.APP)[4]);

        MrPerf.createBegin(); tick(180000); MrPerf.createEnd();
        MrPerf.viewBegin(); tick(95000); MrPerf.viewEnd();
        MrPerf.suggBegin(); tick(2000); MrPerf.suggEnd();
        check("create, view and sugg go to their kinds", "180000,95000,2000",
                st(MrPerf.CREATE)[4] + "," + st(MrPerf.VIEW)[4] + "," + st(MrPerf.SUGG)[4]);
        check("... and nowhere else", st(MrPerf.OPEN)[0] == 0 && st(MrPerf.FRAME)[0] == 0);
        MrPerf.suggEngineBegin(); tick(1200); MrPerf.suggEngineEnd();
        MrPerf.suggShowBegin(); tick(800); MrPerf.suggShowEnd();
        MrPerf.openKbBegin(); tick(6000); MrPerf.openKbEnd();
        MrPerf.openSetBegin(); tick(1500); MrPerf.openSetEnd();
        MrPerf.popupBegin(); tick(9000); MrPerf.popupEnd();
        check("engine, strip, open keyboard, open settings and popup go to their kinds", "1200,800,6000,1500,9000",
                st(MrPerf.SUGG_ENGINE)[4] + "," + st(MrPerf.SUGG_SHOW)[4] + "," + st(MrPerf.OPEN_KB)[4] + ","
                        + st(MrPerf.OPEN_SET)[4] + "," + st(MrPerf.POPUP)[4]);
        check("... and they leave the whole-open and whole-suggestion kinds alone", st(MrPerf.OPEN)[0] == 0 && st(MrPerf.SUGG)[0] == 1);

        // ---------------------------------------------------------------- statistics
        MrPerf.reset();
        for (int i = 1; i <= 20; i++) MrPerf.add(MrPerf.FRAME, i * 100);
        check("20 frames: count, average, p95 (19th), max, last", "20,1050,1900,2000,2000", join(st(MrPerf.FRAME)));
        MrPerf.reset();
        for (int i = 0; i < 300; i++) MrPerf.add(MrPerf.FRAME, i == 10 ? 99999 : 1000);
        int[] s = st(MrPerf.FRAME);
        check("300 frames: the count is all of them", 300, s[0]);
        check("the average and the p95 are of the last 256 (the old peak left the window)", "1000,1000", s[1] + "," + s[2]);
        check("the maximum is of all of them", 99999, s[3]);
        MrPerf.reset();
        for (int i = 0; i < 256; i++) MrPerf.add(MrPerf.KEY, i < 243 ? 10 : 500);
        check("p95 of 256: the 244th", 500, st(MrPerf.KEY)[2]);
        MrPerf.reset();
        for (int i = 0; i < 256; i++) MrPerf.add(MrPerf.KEY, i < 244 ? 10 : 500);
        check("p95 of 256 with 12 slow: still fast", 10, st(MrPerf.KEY)[2]);
        check("p95 index of 1, 2, 20, 100, 256", "0,1,18,94,243",
                MrPerf.p95(1) + "," + MrPerf.p95(2) + "," + MrPerf.p95(20) + "," + MrPerf.p95(100) + "," + MrPerf.p95(256));
        check("p95 index of 0 is 0", 0, MrPerf.p95(0));
        MrPerf.reset();
        MrPerf.add(MrPerf.KEY, -5);
        MrPerf.add(MrPerf.KEY, 1L << 40);
        check("below 0 counts 0, too big counts Integer.MAX_VALUE (average of the two, max)",
                (Integer.MAX_VALUE / 2) + "," + Integer.MAX_VALUE, st(MrPerf.KEY)[1] + "," + st(MrPerf.KEY)[3]);
        check("the last is the clamped value", Integer.MAX_VALUE, st(MrPerf.KEY)[4]);

        // ---------------------------------------------------------------- open and first frame
        MrPerf.reset();
        MrPerf.sFakeNanos = 1_000_000_000L;
        MrPerf.openBegin(); tick(4000); MrPerf.openEnd();
        tick(10000);
        MrPerf.frameBegin(); tick(3000); MrPerf.frameEnd();
        check("open: 4 ms", 4000, st(MrPerf.OPEN)[4]);
        check("first frame: 17 ms from the start of the open", "1,17000", st(MrPerf.SHOWN)[0] + "," + st(MrPerf.SHOWN)[4]);
        check("the frame itself: 3 ms", 3000, st(MrPerf.FRAME)[4]);
        MrPerf.frameBegin(); tick(2000); MrPerf.frameEnd();
        check("a second frame is not a first frame", 1, st(MrPerf.SHOWN)[0]);
        MrPerf.openBegin(); MrPerf.openEnd(); tick(2_000_001);
        MrPerf.frameBegin(); MrPerf.frameEnd();
        check("a first frame later than 2 s is not counted", 1, st(MrPerf.SHOWN)[0]);
        MrPerf.frameBegin(); MrPerf.frameEnd();
        check("... nor the frames after it", 1, st(MrPerf.SHOWN)[0]);
        MrPerf.openBegin(); MrPerf.openEnd(); tick(2_000_000);
        MrPerf.frameBegin(); MrPerf.frameEnd();
        check("exactly 2 s is counted", "2,2000000", st(MrPerf.SHOWN)[0] + "," + st(MrPerf.SHOWN)[4]);
        MrPerf.openBegin(); tick(100); MrPerf.openBegin(); tick(100); MrPerf.openEnd();
        MrPerf.frameBegin(); MrPerf.frameEnd();
        check("two opens in a row: the first frame is timed from the last one", 100, st(MrPerf.SHOWN)[4]);

        // ---------------------------------------------------------------- touch
        MrPerf.reset();
        SystemClock.now = 50_000;
        MrPerf.touch(MotionEvent.stub(0, 0, 49_990, 49_996, new int[] {0}, new float[] {1}, new float[] {1}));
        check("a finger down 4 ms late: 4000 us", "1,4000", st(MrPerf.TOUCH)[0] + "," + st(MrPerf.TOUCH)[4]);
        MrPerf.touch(MotionEvent.stub(5, 1, 49_990, 49_980, new int[] {0, 1}, new float[] {1, 2}, new float[] {1, 2}));
        check("a second finger down counts too (20 ms)", "2,20000", st(MrPerf.TOUCH)[0] + "," + st(MrPerf.TOUCH)[4]);
        for (int action : new int[] {1, 2, 3, 6})
            MrPerf.touch(MotionEvent.stub(action, 0, 49_990, 49_000, new int[] {0}, new float[] {1}, new float[] {1}));
        check("up, move, cancel and pointer up do not count", 2, st(MrPerf.TOUCH)[0]);
        MrPerf.touch(null);
        check("no event: nothing", 2, st(MrPerf.TOUCH)[0]);
        MrPerf.touch(MotionEvent.stub(0, 0, 0, 50_010, new int[] {0}, new float[] {1}, new float[] {1}));
        check("an event from the future counts 0", 0, st(MrPerf.TOUCH)[4]);

        // ---------------------------------------------------------------- the row
        MrPerf.reset();
        MrPerf.sFakeNanos = 0;
        MrPerf.createBegin(); tick(182400); MrPerf.createEnd();
        MrPerf.add(MrPerf.KEY, 1000);
        MrPerf.add(MrPerf.KEY, 3000);
        scr = new Advanced();
        MrPerf.fill(scr);
        sum = String.valueOf(scr.row.summary);
        String[] lines = sum.split("\n");
        check("4 lines: start, key, memory, reset", 4, lines.length);
        check("a kind measured once", "Start the keyboard: 182.4 ms (once)", lines[0]);
        check("a kind measured more times", "Handle a key: average 2.0 ms · p95 3.0 · max 3.0 (2×)", lines[1]);
        check("the memory", true, lines[2].startsWith("Memory: Java ") && lines[2].endsWith("native 18.3 MB"));
        check("how to reset", "Tap to start again from zero.", lines[3]);
        boolean handled = scr.row.click.onPreferenceClick(scr.row);
        check("a tap is handled", handled);
        check("a tap resets the numbers", 0, st(MrPerf.KEY)[0] + st(MrPerf.CREATE)[0]);
        check("... and the row says so at once", true, String.valueOf(scr.row.summary).startsWith("Nothing measured yet.\n"));

        for (int k = 0; k < MrPerf.KINDS; k++) MrPerf.add(k, 1000 * (k + 1));
        for (int k = 0; k < MrPerf.KINDS; k++) MrPerf.add(k, 1000 * (k + 1));
        scr = new Advanced();
        MrPerf.fill(scr);
        lines = String.valueOf(scr.row.summary).split("\n");
        check("every kind: " + MrPerf.KINDS + " lines, memory, reset", MrPerf.KINDS + 2, lines.length);
        String[] order = {"Start the keyboard", "Build the view", "Open in a field", "Until the first frame", "Draw a frame",
                "Handle a key", "Touch wait", "Questions to the app", "Suggestions", "Key letter", "Key separator", "Key delete",
                "Key other", "Suggestions engine", "Suggestions strip", "Open keyboard", "Open settings", "Popup"};
        boolean inOrder = true;
        for (int k = 0; k < order.length; k++) inOrder &= lines[k].startsWith(order[k] + ": average " + (k + 1) + ".0 ms");
        check("in the order of the kinds", inOrder);

        scr = new Advanced();
        scr.hasRow = false;
        MrPerf.fill(scr);
        check("no row: nothing set", scr.row.summary == null && scr.row.click == null);
        scr = new Advanced();
        scr.broken = true;
        boolean thrown = false;
        try { MrPerf.fill(scr); } catch (RuntimeException e) { thrown = true; }
        check("a broken screen: no exception", !thrown);

        // ---------------------------------------------------------------- the log
        MrPerf.reset();
        Log.stubLines.clear();
        MrPerf.onHidden();
        check("no key typed: no line", 0, Log.stubLines.size());
        MrPerf.add(MrPerf.KEY, 1500);
        MrPerf.add(MrPerf.FRAME, 4200);
        MrPerf.onHidden();
        check("keys typed: one line", 1, Log.stubLines.size());
        String line = Log.stubLines.isEmpty() ? "" : Log.stubLines.get(0);
        check("the line", true, line.startsWith("MrPerf: frame 4.2/4.2/4.2 ms (1) key 1.5/1.5/1.5 ms (1) heap ")
                && line.endsWith(" native 18.3 MB"));
        MrPerf.onHidden();
        check("hidden again with no new key: no line", 1, Log.stubLines.size());
        MrPerf.add(MrPerf.KEY, 1500);
        MrPerf.onHidden();
        check("a new key: a new line", 2, Log.stubLines.size());
        MrPerf.reset();
        MrPerf.onHidden();
        check("after a reset with no key: no line", 2, Log.stubLines.size());

        System.out.println(ok + " OK, " + fail + " FAIL");
        if (fail > 0) System.exit(1);
    }
}
