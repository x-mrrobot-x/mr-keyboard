package com.mrkeyboard.app;

import android.content.Context;
import android.os.Debug;
import android.os.SystemClock;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.util.Log;
import android.view.MotionEvent;

import java.util.Arrays;

/**
 * Performance meter of the keyboard (docs/plan-performance.md, stage 2): how long the keyboard takes for the things the person
 * feels, measured on the phone itself, so each stage of the plan can be judged by numbers and not by guesses.
 *
 * <p>The smali of the keyboard calls a begin and an end around each piece of work (no argument, no register taken):
 * <ul>
 * <li>CREATE: LatinIME.onCreate, the start of the keyboard service (a new process: after a reboot, an update, or when Android
 *     killed the keyboard);</li>
 * <li>VIEW: LatinIME.onCreateInputView, the keyboard view and the tool bar built (first open of a process, theme, app
 *     language, rotation);</li>
 * <li>OPEN: LatinIME.onStartInputView, the keyboard getting ready for a field;</li>
 * <li>SHOWN: from the start of OPEN to the end of the first frame drawn after it (not counted after {@link #SHOWN_MAX_US}: the
 *     open redrew nothing and the next frame came from something else);</li>
 * <li>FRAME: LatinKeyboardBaseView.onDraw (the keyboard and the popups of variants). With a window drawn by the GPU this is
 *     the time to record the drawing, not the time of the GPU;</li>
 * <li>KEY: LatinIME.onKey, all the work of a key, the questions to the app included;</li>
 * <li>TOUCH: how late a touch (finger down) reaches the keyboard: the time of the event against the clock when the keyboard
 *     view gets it. A busy main thread shows here;</li>
 * <li>APP: the questions that wait for the app (InputConnection.getCursorCapsMode, getExtractedText when a field opens);</li>
 * <li>SUGG: LatinIME.updateSuggestions, the suggestions of the strip computed (native engine).</li>
 * </ul>
 * Times are kept in microseconds: the last {@link #SIZE} of each kind for the average and the p95, the count and the maximum
 * since the last reset. All of it runs on the main thread (the keyboard and the screens share the process and its main thread),
 * takes no lock and allocates nothing while the keyboard works. The Advanced screen shows it (row {@link #ROW}, a tap resets),
 * with the memory of the process; when the keyboard hides after keys were typed, one line goes to the log
 * (<code>adb logcat -s MrPerf</code>).
 */
public final class MrPerf {
    static final String TAG = "MrPerf";
    /** Key of the row of the Advanced screen. */
    static final String ROW = "mr_perf";

    static final int CREATE = 0, VIEW = 1, OPEN = 2, SHOWN = 3, FRAME = 4, KEY = 5, TOUCH = 6, APP = 7, SUGG = 8, KINDS = 9;
    /** Samples kept per kind (a power of two) for the average and the p95. */
    static final int SIZE = 256;
    /** A first frame later than this (in microseconds) after the field opened is not counted. */
    static final int SHOWN_MAX_US = 2000000;
    /** Names of the strings of each kind, in the order of the kinds. */
    static final String[] NAMES = {
            "mr_ui_perf_create", "mr_ui_perf_view", "mr_ui_perf_open", "mr_ui_perf_shown", "mr_ui_perf_frame",
            "mr_ui_perf_key", "mr_ui_perf_touch", "mr_ui_perf_app", "mr_ui_perf_sugg" };
    /** Names of the kinds in the log line. */
    static final String[] LOG = { "create", "view", "open", "shown", "frame", "key", "touch", "app", "sugg" };

    private static final int[] sRing = new int[KINDS * SIZE];
    private static final int[] sCount = new int[KINDS];
    private static final int[] sMax = new int[KINDS];
    private static final int[] sLast = new int[KINDS];
    /** Start (System.nanoTime) of the piece of work of each kind under way; -1 = none. */
    private static final long[] sStart = new long[KINDS];
    /** Start of the last open whose first frame is awaited; -1 = none. */
    private static long sShownFrom = -1;
    /** Count of KEY when the log line was last written. */
    private static int sLoggedKeys;
    private static final int[] sScratch = new int[SIZE];
    /** Tests: the clock in nanoseconds; -1 = System.nanoTime. */
    static long sFakeNanos = -1;

    static {
        Arrays.fill(sStart, -1L);
    }

    private MrPerf() { }

    static long nanos() {
        return sFakeNanos >= 0 ? sFakeNanos : System.nanoTime();
    }

    // ------------------------------------------------------------------ calls from the smali (no argument, nothing returned)

    public static void createBegin() { begin(CREATE); }
    public static void createEnd() { end(CREATE); }
    public static void viewBegin() { begin(VIEW); }
    public static void viewEnd() { end(VIEW); }

    public static void openBegin() {
        begin(OPEN);
        sShownFrom = sStart[OPEN];
    }

    public static void openEnd() { end(OPEN); }
    public static void frameBegin() { begin(FRAME); }

    public static void frameEnd() {
        end(FRAME);
        long from = sShownFrom;
        if (from < 0) return;
        sShownFrom = -1;
        long us = (nanos() - from) / 1000;
        if (us <= SHOWN_MAX_US) add(SHOWN, us);
    }

    public static void keyBegin() { begin(KEY); }
    public static void keyEnd() { end(KEY); }
    public static void appBegin() { begin(APP); }
    public static void appEnd() { end(APP); }
    public static void suggBegin() { begin(SUGG); }
    public static void suggEnd() { end(SUGG); }

    /** LatinKeyboardView.onTouchEvent, first line: how late a finger down (first or another) reached the keyboard. */
    public static void touch(MotionEvent e) {
        if (e == null) return;
        int action = e.getActionMasked();
        if (action != 0 && action != 5) return;     // ACTION_DOWN, ACTION_POINTER_DOWN
        add(TOUCH, (SystemClock.uptimeMillis() - e.getEventTime()) * 1000);
    }

    /** LatinIME.onWindowHidden: one line in the log when keys were typed since the last one. */
    public static void onHidden() {
        int keys = sCount[KEY];
        if (keys == sLoggedKeys) return;
        sLoggedKeys = keys;
        Log.i(TAG, line());
    }

    // ------------------------------------------------------------------ the numbers

    static void begin(int kind) {
        sStart[kind] = nanos();
    }

    static void end(int kind) {
        long start = sStart[kind];
        if (start < 0) return;
        sStart[kind] = -1;
        add(kind, (nanos() - start) / 1000);
    }

    /** One sample of <code>kind</code>, in microseconds (below 0 counts as 0; the top is Integer.MAX_VALUE). */
    static void add(int kind, long us) {
        int v = us < 0 ? 0 : us > Integer.MAX_VALUE ? Integer.MAX_VALUE : (int) us;
        int n = sCount[kind];
        sRing[kind * SIZE + (n & (SIZE - 1))] = v;
        sCount[kind] = n + 1;
        if (v > sMax[kind]) sMax[kind] = v;
        sLast[kind] = v;
    }

    /**
     * {count, average, p95, maximum, last} of <code>kind</code>, in microseconds; the average and the p95 of the last
     * {@link #SIZE} samples, the count and the maximum since the last reset. All 0 when nothing was measured.
     */
    static int[] stats(int kind) {
        int[] out = new int[5];
        int n = sCount[kind];
        out[0] = n;
        int k = n < SIZE ? n : SIZE;
        if (k == 0) return out;
        long sum = 0;
        int base = kind * SIZE;
        for (int i = 0; i < k; i++) {
            int v = sRing[base + i];
            sScratch[i] = v;
            sum += v;
        }
        Arrays.sort(sScratch, 0, k);
        out[1] = (int) (sum / k);
        out[2] = sScratch[p95(k)];
        out[3] = sMax[kind];
        out[4] = sLast[kind];
        return out;
    }

    /** Index of the p95 in <code>k</code> sorted samples (nearest rank: the ceiling of 0.95 k, counted from 1). */
    static int p95(int k) {
        int i = (k * 95 + 99) / 100 - 1;
        return i < 0 ? 0 : i;
    }

    /** Forgets every number (the row of the Advanced screen, when it is tapped). */
    static void reset() {
        Arrays.fill(sCount, 0);
        Arrays.fill(sMax, 0);
        Arrays.fill(sLast, 0);
        Arrays.fill(sStart, -1L);
        sShownFrom = -1;
        sLoggedKeys = 0;
    }

    static long heapUsed() {
        Runtime r = Runtime.getRuntime();
        return r.totalMemory() - r.freeMemory();
    }

    static String ms(int us) {
        return MrDiag.msText(us * 1000L);
    }

    // ------------------------------------------------------------------ the texts

    /** The text of the row: one line per kind measured (or "nothing yet"), the memory, and how to reset. */
    static String summary(Context c) {
        StringBuilder sb = new StringBuilder();
        for (int kind = 0; kind < KINDS; kind++) {
            int[] s = stats(kind);
            if (s[0] == 0) continue;
            String name = MrPacks.text(c, NAMES[kind]);
            String line = s[0] == 1
                    ? MrPacks.text(c, "mr_ui_perf_one", name, ms(s[4]))
                    : MrPacks.text(c, "mr_ui_perf_stat", name, ms(s[1]), ms(s[2]), ms(s[3]), Integer.valueOf(s[0]));
            if (line == null) continue;
            if (sb.length() > 0) sb.append('\n');
            sb.append(line);
        }
        boolean measured = sb.length() > 0;
        if (!measured) {
            String none = MrPacks.text(c, "mr_ui_perf_none");
            if (none != null) sb.append(none);
        }
        String mem = MrPacks.text(c, "mr_ui_perf_mem", MrDiag.bytesText(heapUsed()), MrDiag.bytesText(Debug.getNativeHeapAllocatedSize()));
        if (mem != null) sb.append('\n').append(mem);
        if (measured) {
            String reset = MrPacks.text(c, "mr_ui_perf_reset");
            if (reset != null) sb.append('\n').append(reset);
        }
        return sb.toString();
    }

    /** The log line: "open 4.2/8.0/15.1 ms (23) ... heap 24.1 MB native 18.3 MB" (average/p95/maximum, count). */
    static String line() {
        StringBuilder sb = new StringBuilder();
        for (int kind = 0; kind < KINDS; kind++) {
            int[] s = stats(kind);
            if (s[0] == 0) continue;
            sb.append(LOG[kind]).append(' ').append(ms(s[1])).append('/').append(ms(s[2])).append('/').append(ms(s[3]))
                    .append(" ms (").append(s[0]).append(") ");
        }
        sb.append("heap ").append(MrDiag.bytesText(heapUsed())).append(" native ")
                .append(MrDiag.bytesText(Debug.getNativeHeapAllocatedSize()));
        return sb.toString();
    }

    /** PrefScreenAdvanced.onResume: the numbers in the row, and a tap on it resets them. */
    public static void fill(PreferenceActivity screen) {
        try {
            Preference row = screen.findPreference(ROW);
            if (row == null) return;
            row.setSummary(summary(screen));
            row.setOnPreferenceClickListener(new Reset(screen));
        } catch (RuntimeException e) {
            // the row keeps the text of the XML
        }
    }

    /** A tap on the row: the numbers start again from zero. */
    static final class Reset implements Preference.OnPreferenceClickListener {
        private final Context mContext;

        Reset(Context c) { mContext = c; }

        public boolean onPreferenceClick(Preference p) {
            reset();
            p.setSummary(summary(mContext));
            return true;
        }
    }
}
