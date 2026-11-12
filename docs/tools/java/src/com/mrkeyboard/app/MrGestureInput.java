package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.preference.PreferenceManager;
import android.view.MotionEvent;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;

import java.io.File;
import java.lang.ref.WeakReference;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Gesture typing in the keyboard (1.96.0, docs/gesture-typing.md): the finger goes down on the first letter of a
 * word, slides over the others and lifts on the last, and the word is written. MrGesture (over the native engine) says which
 * word a trace is; this class is everything around it: which touches are gestures, the trail under the finger, the text that
 * goes to the app, the strip with the other candidates, the backspace that takes the whole word back. Besides, the
 * words of the person are searched too (MrGestureWords), a blocked word is never written, and the strip shows the word so far
 * while the finger slides.
 *
 * It is off unless the setting "pref_gesture_typing" is on AND the weights pack is installed (MrPacks, "models"); while it is
 * off every method below returns on its first line and the keyboard behaves exactly as before.
 *
 * It is called at seven points, six of them in hand-edited smali (each catches whatever is thrown here: a fault never stops typing):
 *   LatinKeyboardView.onTouchEvent   first line: onTouch(); true = the event is taken, the usual path does not see it
 *   LatinKeyboardView.draw           last line: draw(), the trail over the keys
 *   PointerTracker.startLongPressTimer  longPress(): the long-press time of the key under a possible gesture
 *   LatinIME.pickSuggestionManually  first line: onPick(); true = it was one of the gesture's other candidates
 *   LatinIME.handleBackspace         first line: onBackspace()
 *   LatinIME.onKey                   first line: onKey()
 *   MrPacks.mainDictionary (Java)    init(): reads the setting and opens the weights when the keyboard loads a dictionary
 * and it uses two small methods added to LatinIME for it: mrSuggest() (the engine of the language in use) and mrStrip(list).
 *
 * How a touch is read (the numbers come from real gestures, docs/gesture-typing.md has the tables):
 *   - A touch may be a gesture when ONE finger goes down on a letter key of the main keyboard (letters layout, main sheet), in
 *     a plain text field (not a password, an address or an e-mail field, not a field that refuses suggestions), with no Ctrl,
 *     Alt or Meta switched on, no font style chosen, the weights open and the dictionary of the language loaded.
 *   - While it only may be one, the events go on to the usual path too: a tap is typed exactly as before. The one difference:
 *     the long press of that key waits at least LONG_PRESS_MIN ms (the default of the app, 100 ms, would open the accents
 *     popup before the finger of one gesture in five has left its place).
 *   - It IS a gesture once the finger is START_KEYS key widths away from where it went down. At that moment the usual path
 *     gets a cancel event (the key is let go without being typed, its timers stop, the detector of the slide actions forgets
 *     the touch) and every event from there to the last finger up is taken here. So, with gesture typing on, a slide action
 *     (next sheet, close the keyboard...) only happens when the finger starts outside the letters.
 *   - A second finger before that point: it is not a gesture (two-thumb typing). A second finger after it: ignored.
 *   - While it slides (setting "pref_gesture_preview", on unless switched off): every PREVIEW_MS or so the trace so
 *     far is recognised as if the finger had lifted there, and the best word goes to the middle of the strip. It is what
 *     would be written at that moment; it changes as the finger goes on (docs/gesture-typing.md has how often it is the final
 *     word). The strip is given back when the gesture writes nothing. A tap on that word does nothing. With the tool bar
 *     hidden (the strip lives in it) there is no word to show and nothing is recognised until the finger lifts.
 *   - Finger up: the trace goes to MrGesture.decode. Nothing is written when the finger lifted outside the rows of letters
 *     (a slide that left the letters is no word), when there is no word, or when the best word is under MIN_LOGP. A word on
 *     the list of blocked words (MrLearned.isBlocked) is passed over, here and among the other candidates.
 *   - The word is written the way a tap on a suggestion is (LatinIME.pickSuggestionManually): same text path, same learning
 *     of the pair with the previous word, same automatic space, same state for the keys that follow. A space goes in before
 *     it when the text needs one; the Shift key decides the capitals.
 *   - The strip then shows up to ALTERNATIVES other candidates; a tap on one swaps the word. Backspace right after the gesture
 *     removes the whole word. Any other key ends both.
 *
 * The recognition runs on the keyboard thread when the finger lifts, so the word is in the text before the next key is read.
 * How long it takes on the device is kept (stats()) and shown in Settings, Suggestions and dictionaries. The recognitions of
 * the preview run on the same thread, between two touch events, and are spaced so that they never take more than one part in
 * PREVIEW_LOAD of the time: a slow phone shows the word less often instead of letting the trail fall behind the finger.
 */
public final class MrGestureInput {
    private MrGestureInput() { }

    static final String PREF_ON = "pref_gesture_typing";
    static final String PREF_TRAIL = "pref_gesture_trail";
    static final String PREF_PREVIEW = "pref_gesture_preview";

    /** A touch becomes a gesture when the finger is this far from where it went down, in widths of the key it went down on... */
    static final float START_KEYS = 0.7f;
    /** ...and never less than this, in dp (3.5 mm): a finger that rolls during a tap moves a millimetre or two, whatever the key size. */
    static final float START_MIN_DP = 22f;
    /** While a touch may still become a gesture, the long press of its key waits at least this long, in ms. */
    static final int LONG_PRESS_MIN = 300;
    /** A gesture whose finger lifts further than this outside the rows of letters, in rows, writes nothing. */
    static final float END_MARGIN_ROWS = 0.5f;
    /** Nothing is written when the best word has a log-probability under this (it only stops traces that are absurd). */
    static final float MIN_LOGP = -30f;
    /** Other candidates shown on the strip after a gesture. */
    static final int ALTERNATIVES = 3;
    /** Characters read before the cursor to find the previous word and to know whether a space is needed. */
    static final int LOOKBACK = 96;
    /** The word so far is recognised again, while the finger slides, at most once in this many ms... */
    static final int PREVIEW_MS = 120;
    /** ...and never sooner than this many times what the last of those recognitions took (they then use 1/6 of the time at most). */
    static final int PREVIEW_LOAD = 6;

    private static final int KEYCODE_DELETE = -5;
    private static final int TRAIL_ALPHA = 0xCC000000;
    private static final int TRAIL_RGB = 0x40C4FF;      // when the theme has not said its accent colour yet

    // ------------------------------------------------------------------ what the recognition needs from outside

    /** The recognition and the dictionary, behind an interface so that the PC tests can put a fake in their place. */
    interface Engine {
        /** Are the weights open in the lib? */
        boolean ready();
        /** MrGesture.setLayout. */
        boolean layout(char[] keys, float[] xy);
        /** Is the dictionary of the language loaded? */
        boolean hasDictionary(LatinIME ime);
        /** A gesture began: what its recognition will need is made ready now, not when the finger lifts (the words of the person). */
        void prepare(LatinIME ime);
        /** MrGesture.decode over the main dictionary the keyboard is using and the words of the person. */
        int decode(LatinIME ime, float[] x, float[] y, int[] t, int n, String prev, MrGesture.Result out);
    }

    static final Engine REAL = new Engine() {
        public boolean ready() {
            return MrGesture.ready();
        }

        public boolean layout(char[] keys, float[] xy) {
            return MrGesture.setLayout(keys, xy);
        }

        public boolean hasDictionary(LatinIME ime) {
            return buffer(ime) != null;
        }

        public void prepare(LatinIME ime) {
            MrGestureWords.get(ime);
        }

        public int decode(LatinIME ime, float[] x, float[] y, int[] t, int n, String prev, MrGesture.Result out) {
            final Suggest s = ime.mrSuggest();
            final BinaryDictionary d = s != null ? s.mrMainDict() : null;
            final ByteBuffer b = d != null ? d.mrBuffer() : null;
            if (b == null) return -1;
            // the copy of the words of the person is the one prepare() made, unless something changed since
            return MrGesture.decode(b, d.mrLength(), MrGestureWords.get(ime), x, y, t, n, prev, out);
        }

        private ByteBuffer buffer(LatinIME ime) {
            final Suggest s = ime.mrSuggest();
            final BinaryDictionary d = s != null ? s.mrMainDict() : null;
            return d != null ? d.mrBuffer() : null;
        }
    };

    static Engine sEngine = REAL;

    // ------------------------------------------------------------------ the setting and the weights

    /** Gesture typing is on: the setting is on and the weights file is installed. Read on every touch. */
    static volatile boolean sOn;
    /** The trail is drawn. */
    static volatile boolean sTrail = true;
    /** The strip shows the word so far while the finger slides. */
    static volatile boolean sPreview = true;
    private static Context sApp;
    private static SharedPreferences.OnSharedPreferenceChangeListener sListener;   // kept here: the preferences only hold it weakly

    /**
     * Reads the setting and opens (or frees) the weights. Called when the keyboard loads a dictionary (MrPacks.mainDictionary),
     * which is before the first key of a session; from then on a listener follows the setting.
     */
    static synchronized void init(Context c) {
        try {
            if (c == null) return;
            if (sApp == null) {
                final Context app = c.getApplicationContext();
                sApp = app != null ? app : c;
                final SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(sApp);
                if (sp != null) {
                    sListener = new SharedPreferences.OnSharedPreferenceChangeListener() {
                        public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
                            if (key == null || PREF_ON.equals(key) || PREF_TRAIL.equals(key) || PREF_PREVIEW.equals(key)) reload(null);
                        }
                    };
                    sp.registerOnSharedPreferenceChangeListener(sListener);
                }
            }
            reload(null);
        } catch (Throwable t) {
            sOn = false;
        }
    }

    /**
     * The setting or the installed weights changed (the listener above; MrPacks after installing or removing the pack; the
     * settings screen). c: any context, or null to use the one init() kept.
     */
    static synchronized void reload(Context c) {
        try {
            if (c == null) c = sApp;
            if (c == null) return;
            final SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(c);
            final boolean wanted = sp != null && sp.getBoolean(PREF_ON, false);
            sTrail = sp == null || sp.getBoolean(PREF_TRAIL, true);
            sPreview = sp == null || sp.getBoolean(PREF_PREVIEW, true);
            final File weights = wanted ? MrPacks.modelFile(c, MrPacks.MODEL_GESTURE, MrPacks.ENCODER) : null;
            sOn = weights != null;
            MrGesture.use(weights);      // null frees the 2.8 MB the lib holds; the same file again does nothing
        } catch (Throwable t) {
            sOn = false;
        }
    }

    // ------------------------------------------------------------------ the touch being followed

    private static final int IDLE = 0;       // nothing is followed
    private static final int TRACK = 1;      // a finger went down on a letter: it may become a gesture; the usual path sees every event
    private static final int GESTURE = 2;    // it is a gesture: the events are taken here
    private static final int DEAD = 3;       // the gesture is over and a finger is still on the keys: the rest is swallowed

    private static int sState = IDLE;
    private static LatinKeyboardView sView;
    private static int sPointer;             // id of the finger of the gesture
    private static long sDownTime;
    private static float sStart2;            // square of the distance that makes the touch a gesture, in pixels
    private static float[] sPx, sPy;         // the trace, in pixels of the view
    private static int[] sPt;                // milliseconds since the finger went down
    private static int sCount;
    private static boolean sFull;            // more points than the lib takes: the gesture is dropped
    private static float[] sFx, sFy;         // the trace in the frame of MrGesture
    private static final MrGesture.Result sResult = new MrGesture.Result();

    /**
     * First line of LatinKeyboardView.onTouchEvent. true = the event belongs to a gesture and the usual path must not see it.
     */
    public static boolean onTouch(LatinKeyboardView view, MotionEvent me) {
        final int was = sState;
        if (was == IDLE && !sOn) return false;        // off: the common case, two static reads
        int action = -1;
        try {
            action = me.getActionMasked();
            return touch(view, me, action);
        } catch (Throwable t) {
            // never break typing: the touch goes on as a plain one when the usual path still has it, and is swallowed when it
            // was already cancelled there (handing the rest back would type the key under the finger)
            final boolean taken = was == GESTURE || was == DEAD || sState == GESTURE || sState == DEAD;
            final boolean over = action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL || action == -1;
            try {
                trailEnd(view);
            } catch (Throwable ignored) {
                // nothing else to do
            }
            try {
                previewEnd(true);
            } catch (Throwable ignored) {
                // the strip keeps the word until the next key
            }
            if (taken && !over) sState = DEAD; else toIdle();
            return taken;
        }
    }

    private static boolean touch(LatinKeyboardView view, MotionEvent me, int action) {
        if (sState != IDLE) {
            if (view != sView) {
                // another view: the extension row above the keys is a LatinKeyboardView too and gets its events from the main one
                if (action != MotionEvent.ACTION_DOWN || !isMain(view)) return false;
                previewEnd(true);
                toIdle();        // the main view was made again while a touch was followed on the old one
            } else if (action == MotionEvent.ACTION_DOWN) {
                trailEnd(view);
                previewEnd(true);
                toIdle();        // the end of the last touch never came
            }
        }
        switch (sState) {
            case IDLE:
                if (action == MotionEvent.ACTION_DOWN && sOn) begin(view, me);
                return false;
            case TRACK:
                return track(view, me, action);
            case GESTURE:
                gesture(view, me, action);
                return true;
            default:
                if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) toIdle();
                return true;
        }
    }

    private static boolean isMain(LatinKeyboardView view) {
        final KeyboardSwitcher sw = KeyboardSwitcher.getInstance();
        return sw != null && sw.getInputView() == view;
    }

    private static void toIdle() {
        sState = IDLE;
        sView = null;
        sCount = 0;
        sFull = false;
    }

    /** A finger went down: starts following it if every condition for a gesture holds. */
    private static void begin(LatinKeyboardView view, MotionEvent me) {
        if (me.getPointerCount() != 1) return;
        final Engine eng = sEngine;
        if (!eng.ready()) return;
        final LatinIME ime = LatinIME.sInstance;
        if (ime == null || !isMain(view)) return;
        final KeyboardSwitcher sw = KeyboardSwitcher.getInstance();
        if (!sw.isAlphabetMode() || sw.getSheet() != 0) return;
        if (view.popupKeyboardIsShowing() || styled()) return;
        final Keyboard kb = view.getKeyboard();
        if (kb == null || !layoutFor(kb)) return;
        final float x = me.getX(0), y = me.getY(0);
        final int key = letterAt((int) x, (int) y);
        if (key < 0 || modifierOn(kb) || !editorOk(ime) || !eng.hasDictionary(ime)) return;
        if (sPx == null) {
            sPx = new float[MrGesture.MAX_TOUCHES];
            sPy = new float[MrGesture.MAX_TOUCHES];
            sPt = new int[MrGesture.MAX_TOUCHES];
        }
        final float d = density(view);
        final float start = Math.max(START_KEYS * sKw[key], START_MIN_DP * d);
        sStart2 = start * start;
        sTrailWidth = Math.max(3f * d, Math.min(8f * d, 0.12f * sKw[key]));
        sView = view;
        sPointer = me.getPointerId(0);
        sDownTime = me.getEventTime();
        sCount = 0;
        sFull = false;
        add(x, y, sDownTime);
        sState = TRACK;
    }

    /**
     * Is a style chosen in the fonts tool? Its letters are not the ones of the dictionary, so gesture typing stays out of the
     * way. MrFonts has no method that says it; the label of a letter key does (every style changes the "a").
     */
    private static boolean styled() {
        return !"a".equals(MrFonts.styleLabel("a"));
    }

    private static float density(LatinKeyboardView view) {
        try {
            final float d = view.getResources().getDisplayMetrics().density;
            return d > 0f ? d : 1f;
        } catch (RuntimeException e) {
            return 1f;
        }
    }

    /** It may still be a tap: the usual path sees the event unless this is the one that makes it a gesture. */
    private static boolean track(LatinKeyboardView view, MotionEvent me, int action) {
        if (action != MotionEvent.ACTION_MOVE || me.getPointerCount() != 1 || view.popupKeyboardIsShowing()) {
            toIdle();       // a tap, a second finger (two thumbs), the long-press popup: not a gesture, and nothing was held back
            return false;
        }
        final int idx = me.findPointerIndex(sPointer);
        if (idx < 0) {
            toIdle();
            return false;
        }
        final int from = sCount;
        addAll(me, idx);
        if (!farEnough(from)) return false;
        sState = GESTURE;
        final MotionEvent cancel = MotionEvent.obtain(me);
        try {
            cancel.setAction(MotionEvent.ACTION_CANCEL);
            // the two-argument method is the one of LatinKeyboardBaseView: it does not come back through onTouch()
            view.onTouchEvent(cancel, false);
        } finally {
            cancel.recycle();
        }
        trailStart(view);
        previewStart();
        return true;
    }

    private static boolean farEnough(int from) {
        if (sFull) return true;
        final float x0 = sPx[0], y0 = sPy[0];
        for (int i = Math.max(from, 1); i < sCount; i++) {
            final float dx = sPx[i] - x0, dy = sPy[i] - y0;
            if (dx * dx + dy * dy >= sStart2) return true;
        }
        return false;
    }

    /** It is a gesture: every event is taken. */
    private static void gesture(LatinKeyboardView view, MotionEvent me, int action) {
        final int idx = me.findPointerIndex(sPointer);
        switch (action) {
            case MotionEvent.ACTION_MOVE:
                if (idx >= 0) {
                    final int from = sCount;
                    addAll(me, idx);
                    trailGrow(view, from);
                    if (sPreviewOn) previewMove(view);
                }
                return;
            case MotionEvent.ACTION_POINTER_UP:
                if (idx < 0 || me.getActionIndex() != idx) return;     // another finger went up
                end(view, me, idx, false);
                return;
            case MotionEvent.ACTION_UP:
                end(view, me, idx, true);
                return;
            case MotionEvent.ACTION_CANCEL:
                trailEnd(view);
                previewEnd(true);
                toIdle();
                return;
            default:
                return;      // ACTION_POINTER_DOWN: another finger, ignored until the gesture ends
        }
    }

    /** The finger of the gesture went up. last: no other finger is left on the keys. */
    private static void end(LatinKeyboardView view, MotionEvent me, int idx, boolean last) {
        sState = DEAD;       // whatever happens below, the rest of this touch is swallowed
        boolean wrote = false;
        try {
            if (idx >= 0) addAll(me, idx);
            trailEnd(view);
            wrote = finish(view);
        } finally {
            try {
                previewEnd(!wrote);      // a gesture that wrote nothing gives the strip back
            } finally {
                if (last) toIdle();
            }
        }
    }

    /** The points of one event: the ones recorded since the previous event, then the current one. */
    private static void addAll(MotionEvent me, int idx) {
        final int h = me.getHistorySize();
        for (int i = 0; i < h; i++) add(me.getHistoricalX(idx, i), me.getHistoricalY(idx, i), me.getHistoricalEventTime(i));
        add(me.getX(idx), me.getY(idx), me.getEventTime());
    }

    private static void add(float x, float y, long time) {
        int t = (int) (time - sDownTime);
        final int n = sCount;
        if (n > 0) {
            if (t < sPt[n - 1]) t = sPt[n - 1];                        // time never goes back
            if (t == sPt[n - 1] && x == sPx[n - 1] && y == sPy[n - 1]) return;   // the same point twice
        }
        if (n >= MrGesture.MAX_TOUCHES) {
            sFull = true;
            return;
        }
        sPx[n] = x;
        sPy[n] = y;
        sPt[n] = t;
        sCount = n + 1;
    }

    /** Is the editor a place for words? */
    private static boolean editorOk(LatinIME ime) {
        final EditorInfo ei = ime.getCurrentInputEditorInfo();
        if (ei == null || ime.getCurrentInputConnection() == null) return false;
        final int type = ei.inputType;
        if ((type & 0xf) != 1) return false;                        // only text fields (TYPE_CLASS_TEXT)
        if ((type & 0x80000) != 0) return false;                    // the field refuses suggestions (TYPE_TEXT_FLAG_NO_SUGGESTIONS)
        final int variation = type & 0xff0;
        return variation != 0x80 && variation != 0x90 && variation != 0xe0     // passwords
                && variation != 0x10 && variation != 0x20 && variation != 0xd0;   // address, e-mail, e-mail on a web page
    }

    /** Is Ctrl, Alt or Meta switched on? (A letter is then a shortcut.) */
    private static boolean modifierOn(Keyboard kb) {
        final List<Keyboard.Key> keys = kb.getKeys();
        for (int i = 0, n = keys.size(); i < n; i++) {
            final Keyboard.Key k = keys.get(i);
            if (k == null || !k.on || k.codes == null || k.codes.length == 0) continue;
            final int c = k.codes[0];
            if (c == -113 || c == -57 || c == -117) return true;    // key_ctrl_left, key_alt_left, key_meta_left
        }
        return false;
    }

    // ------------------------------------------------------------------ the letters of the keyboard on screen

    private static WeakReference<Keyboard> sLayoutOf;
    private static int sLayoutW, sLayoutH;
    private static boolean sLayoutOk;
    private static int sKeyCount;
    private static final int[] sKx = new int[MrGesture.MAX_KEYS], sKy = new int[MrGesture.MAX_KEYS];
    private static final int[] sKw = new int[MrGesture.MAX_KEYS], sKh = new int[MrGesture.MAX_KEYS];
    private static final int[] sKe = new int[MrGesture.MAX_KEYS];
    private static final char[] sKc = new char[MrGesture.MAX_KEYS];
    private static float sTop, sHeight, sWidth;      // the frame: y of its top, its height and its width, in pixels
    private static int sRows;

    /** The letters of this keyboard are the layout of the lib (handed over again only when the keyboard or its size changes). */
    private static boolean layoutFor(Keyboard kb) {
        final int w = kb.getMinWidth(), h = kb.getHeight();
        if (sLayoutOf != null && sLayoutOf.get() == kb && w == sLayoutW && h == sLayoutH) return sLayoutOk;
        sLayoutOf = new WeakReference<Keyboard>(kb);
        sLayoutW = w;
        sLayoutH = h;
        sLayoutOk = false;
        sLayoutOk = buildLayout(kb, w);
        return sLayoutOk;
    }

    /**
     * Reads the letter keys and hands their centres to the lib in the frame of MrGesture: x from 0 to 1 across the keyboard,
     * y = 0 at the top of the first row of letters and 1 at the bottom of the last one.
     */
    private static boolean buildLayout(Keyboard kb, int width) {
        sKeyCount = 0;
        final List<Keyboard.Key> keys = kb.getKeys();
        int n = 0;
        for (int i = 0, size = keys.size(); i < size; i++) {
            final Keyboard.Key k = keys.get(i);
            if (k == null || k.codes == null || k.codes.length == 0 || k.text != null || k.width <= 0 || k.height <= 0) continue;
            final int code = k.codes[0];
            if (code <= 0 || code > 0xFFFF || !Character.isLetter(code)) continue;
            final char c = Character.toLowerCase((char) code);
            boolean seen = false;
            for (int j = 0; j < n && !seen; j++) seen = sKc[j] == c;
            if (seen) continue;
            if (n == MrGesture.MAX_KEYS) return false;
            sKc[n] = c;
            sKx[n] = k.x;
            sKy[n] = k.y;
            sKw[n] = k.width;
            sKh[n] = k.height;
            sKe[n] = k.edgeFlags;
            n++;
        }
        if (n < 2 || width <= 0) return false;
        // the rows of letters: the distinct tops, from the highest row down
        final int[] tops = new int[n];
        for (int i = 0; i < n; i++) tops[i] = sKy[i];
        Arrays.sort(tops);
        int rows = 1;
        for (int i = 1; i < n; i++) if (tops[i] != tops[i - 1]) rows++;
        final int first = tops[0], last = tops[n - 1];
        int keyHeight = 0;
        for (int i = 0; i < n; i++) if (sKy[i] == first) keyHeight = Math.max(keyHeight, sKh[i]);
        final float pitch = rows > 1 ? (last - first) / (float) (rows - 1) : keyHeight;
        if (pitch <= 0f) return false;
        sTop = first - (pitch - keyHeight) / 2f;       // half of the gap between two rows belongs to each of them
        sHeight = rows * pitch;
        sWidth = width;
        sRows = rows;
        final char[] letters = new char[n];
        final float[] xy = new float[2 * n];
        for (int i = 0; i < n; i++) {
            letters[i] = sKc[i];
            xy[2 * i] = (sKx[i] + sKw[i] / 2f) / sWidth;
            xy[2 * i + 1] = (sKy[i] + sKh[i] / 2f - sTop) / sHeight;
        }
        if (!sEngine.layout(letters, xy)) return false;
        sKeyCount = n;
        return true;
    }

    /** The letter key this point is on (the test of Keyboard.Key.isInside, with the sides that reach the edge), or -1. */
    private static int letterAt(int x, int y) {
        for (int i = 0; i < sKeyCount; i++) {
            final int e = sKe[i], left = sKx[i], top = sKy[i], right = left + sKw[i], bottom = top + sKh[i];
            if ((x >= left || ((e & 1) != 0 && x <= right)) && (x < right || ((e & 2) != 0 && x >= left))
                    && (y >= top || ((e & 4) != 0 && y <= bottom)) && (y < bottom || ((e & 8) != 0 && y >= top))) {
                return i;
            }
        }
        return -1;
    }

    // ------------------------------------------------------------------ the long press

    /**
     * PointerTracker.startLongPressTimer: the time before the long press of a key, in ms. While a touch may become a gesture
     * the popup of accents waits at least LONG_PRESS_MIN: in real gestures the finger is still within a quarter of a key of
     * where it went down after 100 ms in 19% of them, after 300 ms in 0.5%.
     */
    public static int longPress(int ms) {
        return sState == TRACK && ms < LONG_PRESS_MIN ? LONG_PRESS_MIN : ms;
    }

    // ------------------------------------------------------------------ the trail

    private static Path sPath;
    private static Paint sPaint;
    private static boolean sTrailOn;
    private static float sTrailWidth;
    private static float sBoundL, sBoundT, sBoundR, sBoundB;

    private static void trailStart(LatinKeyboardView view) {
        sTrailOn = sTrail && sCount > 0;
        if (!sTrailOn) return;
        if (sPath == null) {
            sPath = new Path();
            sPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
            sPaint.setStyle(Paint.Style.STROKE);
            sPaint.setStrokeCap(Paint.Cap.ROUND);
            sPaint.setStrokeJoin(Paint.Join.ROUND);
        }
        final int rgb = MrTools.accent();
        sPaint.setColor(TRAIL_ALPHA | (rgb != 0 ? rgb : TRAIL_RGB));
        sPaint.setStrokeWidth(sTrailWidth);
        sPath.reset();
        sPath.moveTo(sPx[0], sPy[0]);
        sBoundL = sBoundR = sPx[0];
        sBoundT = sBoundB = sPy[0];
        trailGrow(view, 1);
    }

    /** Adds the points from index from on and asks only the rectangle around them to be drawn again. */
    private static void trailGrow(LatinKeyboardView view, int from) {
        if (!sTrailOn) return;
        if (from < 1) from = 1;
        if (from >= sCount) return;
        float l = sPx[from - 1], r = l, t = sPy[from - 1], b = t;
        for (int i = from; i < sCount; i++) {
            final float x = sPx[i], y = sPy[i];
            sPath.lineTo(x, y);
            if (x < l) l = x;
            if (x > r) r = x;
            if (y < t) t = y;
            if (y > b) b = y;
        }
        if (l < sBoundL) sBoundL = l;
        if (r > sBoundR) sBoundR = r;
        if (t < sBoundT) sBoundT = t;
        if (b > sBoundB) sBoundB = b;
        final int pad = (int) sTrailWidth + 2;
        view.invalidate((int) l - pad, (int) t - pad, (int) r + pad, (int) b + pad);
    }

    private static void trailEnd(LatinKeyboardView view) {
        if (!sTrailOn) return;
        sTrailOn = false;
        if (sPath != null) sPath.reset();
        final int pad = (int) sTrailWidth + 2;
        if (view != null) view.invalidate((int) sBoundL - pad, (int) sBoundT - pad, (int) sBoundR + pad, (int) sBoundB + pad);
    }

    /** Last line of LatinKeyboardView.draw: the trail, over the keys. */
    public static void draw(LatinKeyboardView view, Canvas canvas) {
        if (sState != GESTURE || !sTrailOn || view != sView) return;
        try {
            canvas.drawPath(sPath, sPaint);
        } catch (Throwable t) {
            sTrailOn = false;
        }
    }

    // ------------------------------------------------------------------ from the trace to the text

    private static final List<CharSequence> NONE = new ArrayList<CharSequence>(0);

    private static String sLastWord;          // the word the last gesture left in the text, as written
    private static boolean sLastSpace;        // a space was put before it
    private static EditorInfo sLastEditor;    // in which field
    private static String[] sAlts;            // the other candidates on the strip, best first
    private static boolean sWriting;          // pickSuggestionManually is being called from here

    /** The finger lifted: recognises the trace and writes the word. false = nothing was written. */
    private static boolean finish(LatinKeyboardView view) {
        final int n = sCount;
        if (sFull || n < 2 || sHeight <= 0f || sRows <= 0) return false;
        final float fy = (sPy[n - 1] - sTop) / sHeight;
        final float margin = END_MARGIN_ROWS / sRows;
        if (fy < -margin || fy > 1f + margin) return false;    // the finger lifted outside the letters: a slide, not a word
        final LatinIME ime = LatinIME.sInstance;
        if (ime == null) return false;
        final int shift = view.getShiftState();
        ime.mrCommit();                                     // a word being typed by taps stays as it is
        final InputConnection ic = ime.getCurrentInputConnection();
        if (ic == null) return false;
        ic.finishComposingText();                           // and a word underlined for re-correction is not replaced by this one
        final CharSequence before = ic.getTextBeforeCursor(LOOKBACK, 0);
        final String prev = MrText.lastWord(before);
        frame(n);
        final long t0 = System.nanoTime();
        final int count = sEngine.decode(ime, sFx, sFy, sPt, n, prev, sResult);
        stat(System.nanoTime() - t0);
        if (count <= 0) return false;
        final String[] words = new String[1 + ALTERNATIVES];
        final int k = candidates(sResult, words);
        if (k <= 0) return false;
        for (int i = 0; i < k; i++) words[i] = withCase(words[i], shift);
        write(ime, ic, needsSpace(before), words, k);
        return true;
    }

    /** The first n points of the trace, from pixels of the view to the frame of MrGesture (sFx, sFy). */
    private static void frame(int n) {
        if (sFx == null) {
            sFx = new float[MrGesture.MAX_TOUCHES];
            sFy = new float[MrGesture.MAX_TOUCHES];
        }
        for (int i = 0; i < n; i++) {
            sFx[i] = sPx[i] / sWidth;
            sFy[i] = (sPy[i] - sTop) / sHeight;
        }
    }

    /**
     * The words a gesture may write, best first: the results without the blocked words (MrLearned.isBlocked: the person asked
     * never to see them) and without the repetitions that differ only in upper and lower case ("the" and "The" are two
     * dictionary entries and one gesture). None when the best word left is under MIN_LOGP. Fills out from 0; returns how many.
     */
    static int candidates(MrGesture.Result r, String[] out) {
        int n = 0;
        final int count = r.count();
        for (int i = 0; i < count && n < out.length; i++) {
            final String w = r.word(i);
            if (MrLearned.isBlocked(w)) continue;
            if (n == 0 && r.logp(i) < MIN_LOGP) return 0;
            boolean seen = false;
            for (int k = 0; k < n && !seen; k++) seen = MrGesture.sameIgnoringCase(out[k], w);
            if (!seen) out[n++] = w;
        }
        return n;
    }

    // ------------------------------------------------------------------ the word so far, on the strip, while the finger slides

    /** This gesture shows its word so far (the setting, read when the gesture began; false after a failure). Read on every move. */
    private static boolean sPreviewOn;
    private static boolean sPreviewShown;        // the strip holds the word of the gesture in progress
    private static String sPreviewWord;          // that word
    private static long sPreviewDue;             // no recognition for the preview before this time (uptime, ms)
    private static int sPreviewCount;            // points of the trace the last one read
    private static boolean sPreviewPosted;       // PREVIEW is waiting in the handler
    private static boolean sPrevRead;            // the word before the cursor was read for this gesture
    private static String sPrevWord;
    private static final String[] sPreviewBest = new String[1];
    private static Handler sHandler;

    /** The finger stopped (no touch event came) before the next preview was due: the preview catches up with the trace. */
    private static final Runnable PREVIEW = new Runnable() {
        public void run() {
            sPreviewPosted = false;
            try {
                if (sState == GESTURE && sPreviewOn && sView != null && sCount > sPreviewCount) previewNow(sView);
            } catch (Throwable t) {
                sPreviewOn = false;              // this gesture goes on without it
            }
        }
    };

    /** The touch became a gesture. */
    private static void previewStart() {
        sPreviewShown = false;
        sPreviewWord = null;
        sPreviewCount = 0;
        sPreviewPosted = false;
        sPrevRead = false;
        sPrevWord = null;
        sPreviewOn = false;
        try {
            final LatinIME ime = LatinIME.sInstance;
            if (ime == null) return;
            sEngine.prepare(ime);                // now, while the finger still has a way to go, not when it lifts
            sPreviewDue = SystemClock.uptimeMillis() + PREVIEW_MS;
            sPreviewOn = sPreview && stripInView();
        } catch (Throwable t) {
            sPreviewOn = false;
        }
    }

    /**
     * Can the strip be seen? It lives in the tool bar, in the place of the tools (MrSugg): not while the bar is hidden or
     * another bar is in its place, nor while the tools are pinned over it. Then nothing is recognised for a word nobody sees.
     */
    private static boolean stripInView() {
        final android.view.View bar = MrTools.sBarMain;
        return bar != null && bar.getVisibility() == android.view.View.VISIBLE && !MrSugg.sPinned;
    }

    /** The finger moved: recognises the trace so far if it is time, or leaves it for when it is. Never throws. */
    private static void previewMove(LatinKeyboardView view) {
        try {
            final long wait = sPreviewDue - SystemClock.uptimeMillis();
            if (wait <= 0) {
                previewNow(view);
            } else if (!sPreviewPosted) {
                if (sHandler == null) sHandler = new Handler(Looper.getMainLooper());
                sPreviewPosted = sHandler.postDelayed(PREVIEW, wait);
            }
        } catch (Throwable t) {
            sPreviewOn = false;                  // this gesture goes on without it; the word is still written when the finger lifts
        }
    }

    private static void previewNow(LatinKeyboardView view) {
        final int n = sCount;
        sPreviewCount = n;
        if (sFull || n < 2 || sHeight <= 0f) return;
        final LatinIME ime = LatinIME.sInstance;
        if (ime == null) return;
        if (!sPrevRead) {
            // read once per gesture (a question to the app each time would cost more than the recognition); the word that is
            // written is decided with a fresh reading when the finger lifts
            sPrevRead = true;
            final InputConnection ic = ime.getCurrentInputConnection();
            sPrevWord = ic != null ? MrText.lastWord(ic.getTextBeforeCursor(LOOKBACK, 0)) : null;
        }
        frame(n);
        final long t0 = System.nanoTime();
        final int count = sEngine.decode(ime, sFx, sFy, sPt, n, sPrevWord, sResult);
        final long ns = System.nanoTime() - t0;
        statPreview(ns);
        sPreviewDue = SystemClock.uptimeMillis() + Math.max((long) PREVIEW_MS, PREVIEW_LOAD * (ns / 1000000L));
        if (count <= 0 || candidates(sResult, sPreviewBest) <= 0) return;        // no word yet: what is shown stays
        final String word = withCase(sPreviewBest[0], view.getShiftState());
        if (sPreviewShown && word.equals(sPreviewWord)) return;
        final ArrayList<CharSequence> list = new ArrayList<CharSequence>(1);
        list.add(word);                          // one word: the strip puts it in the middle
        ime.mrStrip(list);
        sPreviewShown = true;
        sPreviewWord = word;
    }

    /**
     * The gesture is over. restore: it wrote nothing, so the strip goes back to what it would show without it (the other
     * candidates of the gesture before, if they are still pending; else the suggestions of the word being typed or of the
     * next word).
     */
    private static void previewEnd(boolean restore) {
        sPreviewOn = false;
        if (sPreviewPosted && sHandler != null) sHandler.removeCallbacks(PREVIEW);
        sPreviewPosted = false;
        final boolean shown = sPreviewShown;
        sPreviewShown = false;
        sPreviewWord = null;
        sPrevWord = null;
        if (!shown || !restore) return;
        final LatinIME ime = LatinIME.sInstance;
        if (ime == null) return;
        if (sAlts != null && sLastWord != null) showAlternatives(ime); else ime.mrStrip(null);
    }

    /** The Shift key decides: 1 (tapped) or 3 (automatic, start of a sentence) = first letter; 2 or 4 (locked) = every letter. */
    static String withCase(String w, int shift) {
        if (w == null || w.length() == 0) return w;
        if (shift == Keyboard.SHIFT_LOCKED || shift == Keyboard.SHIFT_CAPS_LOCKED) return w.toUpperCase();
        if (shift == Keyboard.SHIFT_ON || shift == Keyboard.SHIFT_CAPS) {
            final char c = w.charAt(0), u = Character.toUpperCase(c);
            return u == c ? w : u + w.substring(1);
        }
        return w;
    }

    /**
     * Does the text before the cursor need a space before a new word? Not at the start, after a space or a line break, after
     * an opening sign or a sign that joins ("(", "¿", "/", "@", "#", "-"...), nor after a straight quote that opens.
     */
    static boolean needsSpace(CharSequence before) {
        if (before == null) return false;      // the editor did not answer: no guess
        final int n = before.length();
        if (n == 0) return false;
        final char c = before.charAt(n - 1);
        if (Character.isWhitespace(c) || opens(c)) return false;
        if (c == '"' || c == '\'') {
            if (n == 1) return false;
            final char p = before.charAt(n - 2);
            return !(Character.isWhitespace(p) || opens(p));
        }
        return true;
    }

    private static boolean opens(char c) {
        return "([{<\u00ab\u201c\u2018\u00bf\u00a1/\\@#_-".indexOf(c) >= 0;
    }

    private static void write(LatinIME ime, InputConnection ic, boolean space, String[] words, int k) {
        final String word = words[0];
        sWriting = true;
        ic.beginBatchEdit();
        try {
            if (space) ic.commitText(" ", 1);
            ime.mrStrip(NONE);                          // the strip exists from here on, even with "show suggestions" off
            ime.pickSuggestionManually(-1, word);       // as a tap on a suggestion; -1: no place on the strip, the pair is learned
        } finally {
            sWriting = false;
            ic.endBatchEdit();
        }
        sLastWord = word;
        sLastSpace = space;
        sLastEditor = ime.getCurrentInputEditorInfo();
        sAlts = null;
        if (k > 1) {
            sAlts = new String[k - 1];
            System.arraycopy(words, 1, sAlts, 0, k - 1);
            showAlternatives(ime);
        }
    }

    /** The other candidates on the strip, in its order: second, first (the middle), third. */
    private static void showAlternatives(LatinIME ime) {
        final String[] a = sAlts;
        final ArrayList<CharSequence> list = new ArrayList<CharSequence>(ALTERNATIVES);
        if (a.length >= 2) list.add(a[1]);
        list.add(a[0]);
        for (int i = 2; i < a.length; i++) list.add(a[i]);
        ime.mrStrip(list);
    }

    private static void forget() {
        sLastWord = null;
        sLastEditor = null;
        sAlts = null;
    }

    /**
     * How many characters before the cursor are the word of the last gesture, with its automatic space when there is one;
     * -1 when the text is no longer what was written (another field, the cursor moved, something was typed).
     */
    private static int written(LatinIME ime, InputConnection ic) {
        final String word = sLastWord;
        if (word == null || ic == null || ime.getCurrentInputEditorInfo() != sLastEditor) return -1;
        final int n = word.length();
        final CharSequence b = ic.getTextBeforeCursor(n + 1, 0);
        if (b == null) return -1;
        final String s = b.toString();
        if (s.length() == n + 1 && s.charAt(n) == ' ' && s.startsWith(word)) return n + 1;
        return s.endsWith(word) ? n : -1;
    }

    /**
     * First line of LatinIME.pickSuggestionManually. true = the tap is dealt with here: the word tapped on the strip was
     * another candidate of the last gesture and took the place of the one in the text, or it was the word so far of a
     * gesture still in progress (another finger tapped it), which is not a suggestion to pick.
     */
    public static boolean onPick(LatinIME ime, int index, CharSequence picked) {
        if (sWriting) return false;
        if (sPreviewShown) return true;        // the strip holds the word of a gesture in progress: the finger lifting writes it
        if (sAlts == null) return false;
        try {
            final String[] alts = sAlts;
            int at = -1;
            for (int i = 0; i < alts.length; i++) if (alts[i] == picked) at = i;     // the very object that went to the strip
            final InputConnection ic = at >= 0 ? ime.getCurrentInputConnection() : null;
            final int del = at >= 0 ? written(ime, ic) : -1;
            if (del < 0) {
                forget();          // another word of the strip, or the text changed: the tap is an ordinary one
                return false;
            }
            final String chosen = alts[at];
            alts[at] = sLastWord;  // the word that leaves the text takes the place of the one that enters it
            sWriting = true;
            ic.beginBatchEdit();
            try {
                ic.deleteSurroundingText(del, 0);
                ime.pickSuggestionManually(-1, chosen);
            } finally {
                sWriting = false;
                ic.endBatchEdit();
            }
            sLastWord = chosen;
            showAlternatives(ime);
            return true;
        } catch (Throwable t) {
            sWriting = false;
            forget();
            return false;
        }
    }

    /**
     * First line of LatinIME.handleBackspace. Right after a gesture the backspace takes the whole word back (and the space
     * put before it): everything but its last character is removed here, and the backspace itself removes that one.
     */
    public static void onBackspace(LatinIME ime) {
        if (sLastWord == null || sWriting) return;
        try {
            final InputConnection ic = ime.getCurrentInputConnection();
            int del = written(ime, ic);
            if (del > 0) {
                if (sLastSpace) {
                    final CharSequence b = ic.getTextBeforeCursor(del + 1, 0);
                    if (b != null && b.length() == del + 1 && b.charAt(0) == ' ') del++;
                }
                if (del > 1) ic.deleteSurroundingText(del - 1, 0);
            }
            final boolean strip = sAlts != null;
            forget();
            if (strip) ime.mrStrip(null);
        } catch (Throwable t) {
            forget();
        }
    }

    /** First line of LatinIME.onKey: any key but the backspace ends what the last gesture left pending. */
    public static void onKey(LatinIME ime, int code) {
        if (sLastWord == null && sAlts == null) return;       // nothing pending: the common case
        if (code == KEYCODE_DELETE || sWriting) return;       // onBackspace() decides; and the word being written is not a key
        try {
            final boolean strip = sAlts != null;
            forget();
            if (strip) ime.mrStrip(null);                     // the strip goes back to what it shows between two words
        } catch (Throwable t) {
            forget();
        }
    }

    // ------------------------------------------------------------------ how long the recognition takes on this device

    private static int sStatCount, sStatPreviews;
    private static long sStatLast, sStatSum, sStatMax, sStatPreviewSum, sStatPreviewMax;

    private static synchronized void stat(long ns) {
        sStatCount++;
        sStatLast = ns;
        sStatSum += ns;
        if (ns > sStatMax) sStatMax = ns;
    }

    private static synchronized void statPreview(long ns) {
        sStatPreviews++;
        sStatPreviewSum += ns;
        if (ns > sStatPreviewMax) sStatPreviewMax = ns;
    }

    /**
     * {gestures recognised since the keyboard process started, the last one in ns, the sum, the longest; recognitions made for
     * the preview while the finger slid, their sum in ns, the longest}. The first four count only the recognition that writes
     * the word.
     */
    static synchronized long[] stats() {
        return new long[] {sStatCount, sStatLast, sStatSum, sStatMax, sStatPreviews, sStatPreviewSum, sStatPreviewMax};
    }

    /** Tests only: everything back to the state of a process that has just started. */
    static synchronized void resetForTest() {
        toIdle();
        sOn = false;
        sTrail = true;
        sPreview = true;
        sPreviewOn = sPreviewShown = sPreviewPosted = sPrevRead = false;
        sPreviewWord = sPrevWord = null;
        sPreviewDue = 0;
        sPreviewCount = 0;
        sHandler = null;
        sEngine = REAL;
        sApp = null;
        sListener = null;
        sLayoutOf = null;
        sLayoutOk = false;
        sKeyCount = 0;
        sTrailOn = false;
        sWriting = false;
        forget();
        sLastSpace = false;
        sStatCount = sStatPreviews = 0;
        sStatLast = sStatSum = sStatMax = sStatPreviewSum = sStatPreviewMax = 0;
    }

    /** Tests only: the handler the preview waits in (null until it waited once). */
    static Handler handlerForTest() {
        return sHandler;
    }

    /** Tests only: what is being followed (0 nothing, 1 a possible gesture, 2 a gesture, 3 swallowing the rest of a touch). */
    static int stateForTest() {
        return sState;
    }
}
