package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Debug;
import android.os.SystemClock;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.util.Log;
import android.view.MotionEvent;

import java.util.Arrays;

/**
 * Performance meter of the keyboard: how long the keyboard takes for the things the person
 * feels, measured on the phone itself, so each stage of the plan can be judged by numbers and not by guesses.
 *
 * <p>The smali of the keyboard calls a begin and an end around each piece of work (no register taken; only the key code goes to
 * {@link #keyBegin}):
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
 * <li>KEY: LatinIME.onKey, all the work of a key, the questions to the app included. The same time is also counted by kind of
 *     key: KEY_LETTER (letters and digits), KEY_SEP (space, punctuation, Enter and the other positive codes), KEY_DEL (delete)
 *     and KEY_OTHER (shift, symbols, modes: the negative codes), to see which kind of key has the slow tail;</li>
 * <li>TOUCH: how late a touch (finger down) reaches the keyboard: the time of the event against the clock when the keyboard
 *     view gets it. A busy main thread shows here;</li>
 * <li>APP: the questions that wait for the app: every InputConnection.getTextBeforeCursor, getTextAfterCursor and
 *     getCursorCapsMode of LatinIME and of EditingUtil (the previous word, the word under the cursor), and the getExtractedText
 *     that a field without a reported selection still needs when it opens;</li>
 * <li>SUGG: LatinIME.updateSuggestions, the suggestions of the strip computed (native engine). Inside it: SUGG_ENGINE, the
 *     call to the engine (Suggest.getSuggestions), and SUGG_SHOW, the strip filled and drawn (setSuggestions);</li>
 * <li>OPEN_KB: inside OPEN, the keyboard chosen and put on the view for the field (makeKeyboards, setKeyboardMode and the
 *     reading of the field type); OPEN_SET: inside OPEN, loadSettings;</li>
 * <li>POPUP: the popup of variants (long press) built and shown (LatinKeyboardBaseView.onLongPress). Inside it: POPUP_BUILD, the
 *     variants of the key put together (Key.getPopupKeyboard; only when the popup of that key was not kept from before), and
 *     POPUP_SHOW, the popup window shown (PopupWindow.showAtLocation). Counting POPUP against POPUP_BUILD gives how many
 *     long presses found the variants ready;</li>
 * <li>LONG_LATE: how much later than the set time the popup of a long press came (any key with a popup): the time from the touch
 *     to the popup shown, minus the set time. Its pieces (the touch seen late, the timer run late, the popup) are kept for the
 *     worst one, which the Advanced screen shows as a line of its own with the key it was ({@link #longShown}, MrLongPress);</li>
 * <li>SEL: the keyboard told by the app about a new selection (LatinIME.onUpdateSelection), the whole reaction. MSG: a delayed
 *     message of the keyboard handled (suggestions, shift state, old-word suggestions; LatinIME$1.handleMessage);</li>
 * <li>ECHO_CUT, ECHO_FULL: inside SEL, the check "is the cursor touching a word" after a new selection (re-correction). ECHO_CUT: the
 *     report was the echo of a separator the keyboard typed itself, and only the character after the cursor was asked;
 *     ECHO_FULL: any other report, the full check. Their counts say how many echoes took the short way;</li>
 * <li>ECHO_ONE: inside ECHO_CUT, on Android 12+, the one question (getSurroundingText, MrSurround) that gave the character after the
 *     cursor and the text before it for the next-word prediction. Its count says how many echoes were answered by one question
 *     instead of two; a phone or an app that does not answer it shows no such line;</li>
 * <li>ECHO_RUN, ECHO_DROP: the reaction to the echo of our own separator can wait a little (stage 6, part 7: the app is busy with the
 *     key it just got, and the first question after a change is the slow one; a little later it is idle). ECHO_RUN: how long a
 *     reaction waited before it ran (the count says how many ran). ECHO_DROP: how long it had waited when a key, a new report of the
 *     selection, the end of the field or the window hiding ended the wait before it ran (the count says how many did not run; their
 *     question to the app was never asked). With the switch off neither line shows;</li>
 * <li>CAPS_RUN, CAPS_FLUSH: the update of the shift state at the end of a separator asks the app for the caps mode of the cursor, and
 *     the app has just been given the separator, so the answer is the slow one (stage 6, part 8). It can wait a little. CAPS_RUN: how
 *     long it waited before the message ran it (the count says how many ran that way). CAPS_FLUSH: how long it had waited when a
 *     key, a text or a suggestion came first and it was asked at once (the count says how many). With the switch off neither line shows;</li>
 * <li>CREATE_SUPER, CREATE_SUGG: inside CREATE, what <code>onCreate</code> spends where the keyboard cannot change it and where it can:
 *     CREATE_SUPER is <code>super.onCreate()</code> (the part of Android: the service and its window), CREATE_SUGG the set-up of the
 *     suggestion engine (<code>initSuggest</code> in <code>onCreate</code>: the language, the dictionary, the engine). What is left of
 *     CREATE is the rest: the settings read, the languages, the receivers;</li>
 * <li>APP_KEY, APP_SUGG, APP_OPEN, APP_SEL, APP_MSG, APP_OTHER: the same questions as APP, counted again by where they are asked:
 *     inside a key (not in its suggestions), inside the suggestions, inside an open, inside the reaction to a new selection,
 *     inside a delayed message, and anywhere else. The innermost piece of work under way decides; every wait is counted once in
 *     APP and once here.</li>
 * </ul>
 * Times are kept in microseconds: the last {@link #SIZE} of each kind for the average and the p95, the count and the maximum
 * since the last reset. All of it runs on the main thread (the keyboard and the screens share the process and its main thread),
 * takes no lock and allocates nothing while the keyboard works. The Advanced screen shows it (row {@link #ROW}, a tap resets),
 * with the memory of the process; when the keyboard hides after keys were typed, one line goes to the log
 * (<code>adb logcat -s MrPerf</code>).
 *
 * <p>The start of the keyboard (CREATE), the building of its view (VIEW) and the two parts of CREATE (CREATE_SUPER, CREATE_SUGG)
 * happen once per process, so one process gives one sample and the time of the same build changes a lot from one start to the next (cold files, the clock of the processor). The
 * Advanced screen therefore keeps the last {@link #STARTS_MAX} starts it saw and shows their minimum, median and maximum under
 * each of those lines: {@link #saveStart} runs only when the screen is opened ({@link #fill}), never while the keyboard works, and
 * writes a file of its own ({@link #STARTS_PREFS}), not the default preferences, which the keyboard listens to. A tap on the row
 * clears the history with the numbers.
 */
public final class MrPerf {
    static final String TAG = "MrPerf";
    /** Key of the row of the Advanced screen. */
    static final String ROW = "mr_perf";

    static final int CREATE = 0, VIEW = 1, OPEN = 2, SHOWN = 3, FRAME = 4, KEY = 5, TOUCH = 6, APP = 7, SUGG = 8,
            KEY_LETTER = 9, KEY_SEP = 10, KEY_DEL = 11, KEY_OTHER = 12, SUGG_ENGINE = 13, SUGG_SHOW = 14,
            OPEN_KB = 15, OPEN_SET = 16, POPUP = 17, APP_KEY = 18, APP_SUGG = 19, APP_OPEN = 20, APP_OTHER = 21,
            POPUP_BUILD = 22, POPUP_SHOW = 23, SEL = 24, MSG = 25, APP_SEL = 26, APP_MSG = 27, ECHO_CUT = 28, ECHO_FULL = 29, ECHO_ONE = 30, ECHO_RUN = 31, ECHO_DROP = 32,
            CAPS_RUN = 33, CAPS_FLUSH = 34, CREATE_SUPER = 35, CREATE_SUGG = 36, TRIM = 37, LONG_LATE = 38, KINDS = 39;
    /** A piece of work that began longer ago than this (milliseconds) and never ended is not taken as the place of a wait. */
    static final int PLACE_MAX_MS = 10000;
    /** Samples kept per kind (a power of two) for the average and the p95. */
    static final int SIZE = 256;
    /** A first frame later than this (in microseconds) after the field opened is not counted. */
    static final int SHOWN_MAX_US = 2000000;
    /**
     * File of the history of the starts. Not the default preferences of the app: the keyboard listens to those and would read all its
     * settings again at every change.
     */
    static final String STARTS_PREFS = "mr_perf";
    static final String STARTS_KEY = "starts";
    /** Starts kept (the last ones). Odd, so that the median of a full history is one of them. */
    static final int STARTS_MAX = 9;
    /** Names of the strings of each kind, in the order of the kinds. */
    static final String[] NAMES = {
            "mr_ui_perf_create", "mr_ui_perf_view", "mr_ui_perf_open", "mr_ui_perf_shown", "mr_ui_perf_frame",
            "mr_ui_perf_key", "mr_ui_perf_touch", "mr_ui_perf_app", "mr_ui_perf_sugg",
            "mr_ui_perf_key_letter", "mr_ui_perf_key_sep", "mr_ui_perf_key_del", "mr_ui_perf_key_other",
            "mr_ui_perf_sugg_engine", "mr_ui_perf_sugg_show", "mr_ui_perf_open_kb", "mr_ui_perf_open_set", "mr_ui_perf_popup",
            "mr_ui_perf_app_key", "mr_ui_perf_app_sugg", "mr_ui_perf_app_open", "mr_ui_perf_app_other",
            "mr_ui_perf_popup_build", "mr_ui_perf_popup_show", "mr_ui_perf_sel", "mr_ui_perf_msg",
            "mr_ui_perf_app_sel", "mr_ui_perf_app_msg", "mr_ui_perf_echo_cut", "mr_ui_perf_echo_full", "mr_ui_perf_echo_one",
            "mr_ui_perf_echo_run", "mr_ui_perf_echo_drop", "mr_ui_perf_caps_run", "mr_ui_perf_caps_flush",
            "mr_ui_perf_create_super", "mr_ui_perf_create_sugg", "mr_ui_perf_trim", "mr_ui_perf_long_late" };
    /** Names of the kinds in the log line. */
    static final String[] LOG = { "create", "view", "open", "shown", "frame", "key", "touch", "app", "sugg",
            "key-letter", "key-sep", "key-del", "key-other", "sugg-engine", "sugg-show", "open-kb", "open-set", "popup",
            "app-key", "app-sugg", "app-open", "app-other", "popup-build", "popup-show", "sel", "msg", "app-sel", "app-msg",
            "echo-cut", "echo-full", "echo-one", "echo-run", "echo-drop", "caps-run", "caps-flush", "create-super", "create-sugg", "trim",
            "long-late" };

    private static final int[] sRing = new int[KINDS * SIZE];
    private static final int[] sCount = new int[KINDS];
    private static final int[] sMax = new int[KINDS];
    private static final int[] sLast = new int[KINDS];
    /** Start (System.nanoTime) of the piece of work of each kind under way; -1 = none. */
    private static final long[] sStart = new long[KINDS];
    /** The split kind (KEY_LETTER...) of the key under way, so that its end closes the same one. */
    private static int sKeyKind = KEY_OTHER;
    /** When the reaction to the echo of our own separator was told to wait (System.nanoTime); -1 = nothing waits. */
    private static long sEchoAt = -1;
    /** Start of the wait of the update of the shift state that waits after a separator (stage 6, part 8); -1 when none waits. */
    private static long sCapsAt = -1;
    /** Start of the last open whose first frame is awaited; -1 = none. */
    private static long sShownFrom = -1;
    /** True once the start of this process went to the history (one process is one start). */
    static boolean sStartSaved;
    /** Count of KEY when the log line was last written. */
    private static int sLoggedKeys;
    /** The code of the key whose popup is being opened (LatinKeyboardBaseView.onLongPress), for the worst long press. */
    private static int sPopupCode;
    /**
     * The worst long press since the reset: how much later than the set time its popup came (ms; -1 = none yet), and its parts (ms):
     * the set time, how long after the touch the keyboard armed the timer, how late the timer ran, how long the popup took; and its key.
     */
    private static long sWorstLate = -1, sWorstPlanned, sWorstSeen, sWorstTimer, sWorstPopup;
    private static int sWorstCode;
    /** The code of the sheet key (123 / ABC / TSK), the one the worst long press line names. */
    static final int SHEET_KEY = -300;
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
    public static void createSuperBegin() { begin(CREATE_SUPER); }
    public static void createSuperEnd() { end(CREATE_SUPER); }
    public static void createSuggBegin() { begin(CREATE_SUGG); }
    public static void createSuggEnd() { end(CREATE_SUGG); }
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

    /** LatinIME.onKey, first line: <code>code</code> is the primary code of the key. */
    public static void keyBegin(int code) {
        sKeyKind = keyKind(code);
        begin(KEY);
        begin(sKeyKind);
    }

    public static void keyEnd() {
        end(KEY);
        end(sKeyKind);
    }

    /** The split kind of a key: delete, the other special keys (negative codes), letters and digits, and the rest (separators). */
    static int keyKind(int code) {
        if (code == -5) return KEY_DEL;             // Keyboard.KEYCODE_DELETE
        if (code <= 0) return KEY_OTHER;
        return Character.isLetterOrDigit(code) ? KEY_LETTER : KEY_SEP;
    }

    public static void appBegin() { begin(APP); }

    /** The wait ends: counted in APP and, by where it was asked, in APP_KEY, APP_SUGG, APP_OPEN or APP_OTHER. */
    public static void appEnd() {
        long start = sStart[APP];
        if (start < 0) return;
        sStart[APP] = -1;
        long us = (nanos() - start) / 1000;
        add(APP, us);
        add(appPlace(), us);
    }

    /**
     * Where a wait for the app is asked: the one of OPEN, SUGG, KEY, SEL and MSG that began last (the innermost, whatever the
     * nesting), or APP_OTHER when none is under way. One that began more than {@link #PLACE_MAX_MS} ago is left out: it lost its end.
     */
    static int appPlace() {
        long now = nanos();
        int place = APP_OTHER;
        long latest = -1;
        long s = sStart[OPEN];
        if (s > latest && (now - s) / 1000000 <= PLACE_MAX_MS) { latest = s; place = APP_OPEN; }
        s = sStart[SUGG];
        if (s > latest && (now - s) / 1000000 <= PLACE_MAX_MS) { latest = s; place = APP_SUGG; }
        s = sStart[KEY];
        if (s > latest && (now - s) / 1000000 <= PLACE_MAX_MS) { latest = s; place = APP_KEY; }
        s = sStart[SEL];
        if (s > latest && (now - s) / 1000000 <= PLACE_MAX_MS) { latest = s; place = APP_SEL; }
        s = sStart[MSG];
        if (s > latest && (now - s) / 1000000 <= PLACE_MAX_MS) place = APP_MSG;
        return place;
    }

    public static void suggBegin() { begin(SUGG); }
    public static void suggEnd() { end(SUGG); }
    public static void suggEngineBegin() { begin(SUGG_ENGINE); }
    public static void suggEngineEnd() { end(SUGG_ENGINE); }
    public static void suggShowBegin() { begin(SUGG_SHOW); }
    public static void suggShowEnd() { end(SUGG_SHOW); }
    public static void openKbBegin() { begin(OPEN_KB); }
    public static void openKbEnd() { end(OPEN_KB); }
    public static void openSetBegin() { begin(OPEN_SET); }
    public static void openSetEnd() { end(OPEN_SET); }
    public static void popupBegin() { begin(POPUP); }
    public static void popupEnd() { end(POPUP); }
    public static void popupBuildBegin() { begin(POPUP_BUILD); }
    public static void popupBuildEnd() { end(POPUP_BUILD); }
    public static void popupShowBegin() { begin(POPUP_SHOW); }
    public static void popupShowEnd() { end(POPUP_SHOW); }
    /** LatinIME.onUpdateSelection: the whole reaction of the keyboard to a new selection. */
    public static void selBegin() { begin(SEL); }
    public static void selEnd() { end(SEL); }
    /** LatinIME$1.handleMessage: one delayed message of the keyboard handled. */
    public static void msgBegin() { begin(MSG); }
    public static void msgEnd() { end(MSG); }
    /** LatinIME.mrEchoTouchingWord: the short check after the echo of our own separator, and the full check. */
    public static void echoCutBegin() { begin(ECHO_CUT); }
    public static void echoCutEnd() { end(ECHO_CUT); }
    public static void echoFullBegin() { begin(ECHO_FULL); }
    public static void echoFullEnd() { end(ECHO_FULL); }
    /** MrSurround.echo: the one question (Android 12+) that served both the check after the echo and the next-word prediction. */
    public static void echoOneBegin() { begin(ECHO_ONE); }
    public static void echoOneEnd() { end(ECHO_ONE); }

    /** LatinIME.mrEchoPost: the reaction to the echo of our own separator is told to wait; the clock of its wait starts. */
    public static void echoPosted() { sEchoAt = nanos(); }

    /** LatinIME.mrEchoRun: the reaction that waited ran. ECHO_RUN is how long it waited. */
    public static void echoRan() {
        long at = sEchoAt;
        if (at < 0) return;
        sEchoAt = -1;
        add(ECHO_RUN, (nanos() - at) / 1000);
    }

    /**
     * LatinIME.mrEchoCancel, called by every key and report of the selection, so it does nothing when no reaction waits: the wait
     * ended before the reaction ran. ECHO_DROP is how long it had waited.
     */
    public static void echoDropped() {
        long at = sEchoAt;
        if (at < 0) return;
        sEchoAt = -1;
        add(ECHO_DROP, (nanos() - at) / 1000);
    }

    /** LatinIME.mrShiftPost: the update of the shift state after a separator is told to wait; the clock of its wait starts. */
    public static void capsPosted() { sCapsAt = nanos(); }

    /** LatinIME.mrShiftRun: the message ran the update that waited. CAPS_RUN is how long it waited. */
    public static void capsRan() {
        long at = sCapsAt;
        if (at < 0) return;
        sCapsAt = -1;
        add(CAPS_RUN, (nanos() - at) / 1000);
    }

    /** LatinIME.mrShiftFlush: a key, a text or a suggestion came first and the update was asked at once. CAPS_FLUSH is how long it had waited. */
    public static void capsFlushed() {
        long at = sCapsAt;
        if (at < 0) return;
        sCapsAt = -1;
        add(CAPS_FLUSH, (nanos() - at) / 1000);
    }

    /** LatinIME.mrShiftCancel: the update that waited was dropped without being asked (replaced by another, or the field ended): not counted. */
    public static void capsForget() { sCapsAt = -1; }

    /** LatinKeyboardBaseView.onLongPress, right after popupBegin: the code of the key whose popup is being opened. */
    public static void popupKey(int code) { sPopupCode = code; }

    /**
     * MrLongPress.shown: a long press showed its popup. <code>totalMs</code> is the time from the touch to the popup shown,
     * <code>plannedMs</code> the set time, and the rest where the time beyond it went: the keyboard armed the timer
     * <code>seenMs</code> after the touch, its message ran <code>timerMs</code> after it was due, and the popup took
     * <code>popupMs</code>. LONG_LATE counts the time beyond the set one; the worst one keeps its parts.
     */
    static void longShown(long totalMs, long plannedMs, long seenMs, long timerMs, long popupMs) {
        long late = totalMs - plannedMs;
        if (late < 0) late = 0;
        add(LONG_LATE, late * 1000);
        if (late > sWorstLate) {
            sWorstLate = late;
            sWorstPlanned = plannedMs;
            sWorstSeen = seenMs < 0 ? 0 : seenMs;
            sWorstTimer = timerMs < 0 ? 0 : timerMs;
            sWorstPopup = popupMs < 0 ? 0 : popupMs;
            sWorstCode = sPopupCode;
        }
    }

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
        sEchoAt = -1;
        sCapsAt = -1;
        sWorstLate = -1;
        MrTrim.forget();
        MrLive.forget();
    }

    // ------------------------------------------------------------------ the history of the starts

    /**
     * The column of a kind in a record of the history ("create,view,super,sugg"): 0 CREATE, 1 VIEW, 2 CREATE_SUPER, 3 CREATE_SUGG;
     * -1 for a kind whose starts are not kept.
     */
    static int startColumn(int kind) {
        return kind == CREATE ? 0 : kind == VIEW ? 1 : kind == CREATE_SUPER ? 2 : kind == CREATE_SUGG ? 3 : -1;
    }

    /** The first sample of a kind since the process began, in microseconds; -1 when it was not measured. */
    private static int firstOf(int kind) {
        return sCount[kind] == 0 ? -1 : sRing[kind * SIZE];
    }

    /** The history as the file keeps it: "create,view,super,sugg;..." in microseconds, oldest first; "" when there is none. */
    static String startsOf(Context c) {
        try {
            String v = c.getSharedPreferences(STARTS_PREFS, Context.MODE_PRIVATE).getString(STARTS_KEY, "");
            return v == null ? "" : v;
        } catch (RuntimeException e) {
            return "";
        }
    }

    /**
     * Adds the start of this process to the history, once: the first CREATE and the first VIEW measured since the process began.
     * It waits until both exist (the keyboard was shown once), so every record has the two numbers. Called when the Advanced
     * screen opens, never while the keyboard works.
     */
    static void saveStart(Context c) {
        if (sStartSaved || sCount[CREATE] == 0 || sCount[VIEW] == 0) return;
        try {
            SharedPreferences sp = c.getSharedPreferences(STARTS_PREFS, Context.MODE_PRIVATE);
            String now = firstOf(CREATE) + "," + firstOf(VIEW) + "," + firstOf(CREATE_SUPER) + "," + firstOf(CREATE_SUGG);
            sp.edit().putString(STARTS_KEY, addStart(sp.getString(STARTS_KEY, ""), now)).apply();
            sStartSaved = true;
        } catch (RuntimeException e) {
            // a phone that cannot write the file: the screen keeps showing this process only
        }
    }

    /** The history with <code>record</code> at the end, and only the last {@link #STARTS_MAX} records. */
    static String addStart(String stored, String record) {
        String all = stored == null || stored.length() == 0 ? record : stored + ";" + record;
        int records = 1;
        for (int i = 0; i < all.length(); i++) if (all.charAt(i) == ';') records++;
        for (; records > STARTS_MAX; records--) all = all.substring(all.indexOf(';') + 1);
        return all;
    }

    /** A tap on the row: the history goes with the numbers. */
    static void clearStarts(Context c) {
        try {
            c.getSharedPreferences(STARTS_PREFS, Context.MODE_PRIVATE).edit().remove(STARTS_KEY).apply();
        } catch (RuntimeException e) {
            // nothing to clear
        }
    }

    /**
     * {count, minimum, median, maximum} of one column of the history (see {@link #startColumn}), in microseconds. The median is the
     * nearest rank (the lower one of the two in the middle when the count is even). A record without that column, with it empty or
     * not a number, or with a number below 0 (-1 is "not measured"), is left out of that column. All 0 when there is nothing.
     */
    static int[] startStats(String stored, int column) {
        int[] v = new int[STARTS_MAX];
        int n = 0;
        int from = 0;
        while (stored != null && from <= stored.length() && n < STARTS_MAX) {
            int end = stored.indexOf(';', from);
            if (end < 0) end = stored.length();
            int f = from;
            for (int c = 0; c < column && f >= 0; c++) {
                f = stored.indexOf(',', f);
                f = f < 0 || f >= end ? -1 : f + 1;
            }
            if (f >= 0) {
                int e = stored.indexOf(',', f);
                if (e < 0 || e > end) e = end;
                if (e > f) {
                    try {
                        int x = Integer.parseInt(stored.substring(f, e));
                        if (x >= 0) v[n++] = x;
                    } catch (NumberFormatException ex) {
                        // a damaged record: left out
                    }
                }
            }
            from = end + 1;
        }
        int[] out = new int[4];
        out[0] = n;
        if (n == 0) return out;
        Arrays.sort(v, 0, n);
        out[1] = v[0];
        out[2] = v[(n * 50 + 99) / 100 - 1];
        out[3] = v[n - 1];
        return out;
    }

    static long heapUsed() {
        Runtime r = Runtime.getRuntime();
        return r.totalMemory() - r.freeMemory();
    }

    static String ms(int us) {
        return MrDiag.msText(us * 1000L);
    }

    // ------------------------------------------------------------------ the texts

    /** What the window of the keyboard is drawn by (MrAccel.UNKNOWN, ACCELERATED or SOFTWARE); a test can set {@link #sFakeMode}. */
    static int sFakeMode = -1;

    static int mode(Context c) {
        return sFakeMode >= 0 ? sFakeMode : MrAccel.state(c);
    }

    /**
     * The name of the frame line: it says if the window is drawn by the GPU (the time is the time to record the drawing) or by the
     * processor (the time is the whole drawing), because the same number means two different things.
     */
    static String frameName(int mode) {
        if (mode == MrAccel.ACCELERATED) return "mr_ui_perf_frame_gpu";
        if (mode == MrAccel.SOFTWARE) return "mr_ui_perf_frame_cpu";
        return NAMES[FRAME];
    }

    /** The text of the row: one line per kind measured (or "nothing yet"), the memory, and how to reset. */
    static String summary(Context c) {
        StringBuilder sb = new StringBuilder();
        String starts = startsOf(c);
        for (int kind = 0; kind < KINDS; kind++) {
            int[] s = stats(kind);
            int column = startColumn(kind);
            boolean start = column >= 0;
            // the lines of the start also show the starts of the other processes, even if this one has no sample yet
            if (s[0] == 0 && !start) continue;
            String name = MrPacks.text(c, kind == FRAME ? frameName(mode(c)) : NAMES[kind]);
            // the text of the drawing mode missing: the plain name; no name at all: the line is left out
            if (name == null && kind == FRAME) name = MrPacks.text(c, NAMES[FRAME]);
            if (name == null) continue;
            if (s[0] > 0) {
                String line = s[0] == 1
                        ? MrPacks.text(c, "mr_ui_perf_one", name, ms(s[4]))
                        : MrPacks.text(c, "mr_ui_perf_stat", name, ms(s[1]), ms(s[2]), ms(s[3]), Integer.valueOf(s[0]));
                if (line != null) {
                    if (sb.length() > 0) sb.append('\n');
                    sb.append(line);
                }
            }
            if (start) {
                // one start is the line above; from two on the spread between starts is what says if a change helped
                int[] h = startStats(starts, column);
                String line = h[0] < 2 ? null
                        : MrPacks.text(c, "mr_ui_perf_starts", name, Integer.valueOf(h[0]), ms(h[1]), ms(h[2]), ms(h[3]));
                if (line != null) {
                    if (sb.length() > 0) sb.append('\n');
                    sb.append(line);
                }
            }
        }
        if (sWorstLate >= 0) {
            // the worst long press: how long from the touch to the popup, and where the time beyond the set one went
            String key = MrPacks.text(c, sWorstCode == SHEET_KEY ? "mr_ui_perf_long_key_sheet" : "mr_ui_perf_long_key_other");
            String worst = key == null ? null : MrPacks.text(c, "mr_ui_perf_long_worst", key, ms((int) ((sWorstPlanned + sWorstLate) * 1000)),
                    ms((int) (sWorstPlanned * 1000)), ms((int) (sWorstSeen * 1000)), ms((int) (sWorstTimer * 1000)),
                    ms((int) (sWorstPopup * 1000)));
            if (worst != null) {
                if (sb.length() > 0) sb.append('\n');
                sb.append(worst);
            }
        }
        if (MrTrim.sCount > 0) {
            // what the last memory cleanup let go of (the time of it is the line above)
            String last = MrPacks.text(c, "mr_ui_perf_trim_last", Integer.valueOf(MrTrim.sLevel), Integer.valueOf(MrTrim.sKeyboards),
                    Integer.valueOf(MrTrim.sPopups), Integer.valueOf(MrTrim.sShadows), MrDiag.bytesText(MrTrim.sBytes));
            if (last != null) {
                if (sb.length() > 0) sb.append('\n');
                sb.append(last);
            }
        }
        if (MrLive.sMeasured) {
            // how many services and input views of the keyboard are alive after the collection of the "free memory now" row
            String alive = MrPacks.text(c, "mr_ui_perf_alive", Integer.valueOf(MrLive.sServices), Integer.valueOf(MrLive.sViews));
            if (alive != null) {
                if (sb.length() > 0) sb.append('\n');
                sb.append(alive);
            }
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
            saveStart(screen);
            row.setSummary(summary(screen));
            row.setOnPreferenceClickListener(new Reset(screen));
            Preference trim = screen.findPreference(MrTrim.ROW);
            if (trim != null) trim.setOnPreferenceClickListener(new Trim(screen, row));
        } catch (RuntimeException e) {
            // the row keeps the text of the XML
        }
    }

    /**
     * A tap on the row of the cleanup: it runs the cleanup of the highest level, as if the system had asked for memory, asks for a
     * collection (here and nowhere else; the system does it by itself), counts what is still alive after it (MrLive) and shows the meter
     * again. The line of the last cleanup says what the keyboard let go of; the memory line also has what the collection freed.
     */
    static final class Trim implements Preference.OnPreferenceClickListener {
        private final Context mContext;
        private final Preference mRow;

        Trim(Context c, Preference row) {
            mContext = c;
            mRow = row;
        }

        public boolean onPreferenceClick(Preference p) {
            MrTrim.onTrim(MrTrim.COMPLETE);
            System.gc();
            MrLive.measure();
            mRow.setSummary(summary(mContext));
            return true;
        }
    }

    /** A tap on the row: the numbers start again from zero. */
    static final class Reset implements Preference.OnPreferenceClickListener {
        private final Context mContext;

        Reset(Context c) { mContext = c; }

        public boolean onPreferenceClick(Preference p) {
            reset();
            clearStarts(mContext);
            p.setSummary(summary(mContext));
            return true;
        }
    }
}
