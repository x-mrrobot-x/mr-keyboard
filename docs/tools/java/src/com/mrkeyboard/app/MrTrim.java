package com.mrkeyboard.app;

import android.util.Log;

/**
 * Memory cleanup: what the keyboard lets go of when the system asks the process for memory (LatinIME.onTrimMemory,
 * the levels of ComponentCallbacks2). Everything let go is made again when it is needed. Nothing that is on screen is touched, and no
 * bitmap is recycled: whether a frame is drawn later by a render thread (a window drawn by the GPU) or at once by the CPU depends on the
 * phone, and where it is drawn later it may still use one, and drawing a recycled bitmap throws; so on no phone is one recycled, the
 * references are dropped and the garbage collector frees them.
 *
 * It goes by what the keyboard can count, not by a threshold of memory:
 *  - any level: the keyboards that are not on screen (KeyboardSwitcher.dropUnused; the one on screen stays);
 *  - the level LOW (10) or more, or the keyboard not on screen: the popups of variants and the measures that the view keeps
 *    (LatinKeyboardBaseView.trimCaches);
 *  - the keyboard not on screen (no view, detached from the window, or hidden): the kept shadows of the icons (ShadowDrawHelper.release).
 * The emoji search index is not here: it already goes when its panel is left (MrEmojiSearch.release). The native engine is not here
 * either: it is closed when the service ends (LatinIME.onDestroy), and letting it go earlier would mean building it again on the next
 * field.
 *
 * What it did is kept for the meter (the line of the last cleanup and the TRIM time), and the Advanced screen can run it by hand.
 */
final class MrTrim {
    private static final String TAG = "MrTrim";

    /** Key of the row of the Advanced screen that runs a cleanup by hand. */
    static final String ROW = "mr_perf_trim";

    /** ComponentCallbacks2.TRIM_MEMORY_RUNNING_MODERATE: the lowest level the system sends to a process that is running. */
    static final int MODERATE = 5;
    /** ComponentCallbacks2.TRIM_MEMORY_RUNNING_LOW. */
    static final int LOW = 10;
    /** ComponentCallbacks2.TRIM_MEMORY_COMPLETE: what the row of the Advanced screen asks for. */
    static final int COMPLETE = 80;

    /** Cleanups since the start of the process or the last reset of the meter, and what the last one did. */
    static int sCount;
    static int sLevel;
    static int sKeyboards;
    static int sPopups;
    static int sShadows;
    static int sBytes;

    private MrTrim() { }

    /** The meter was reset: the line of the last cleanup goes too. */
    static void forget() {
        sCount = 0;
    }

    /** LatinIME.onTrimMemory. Never throws: the system is waiting. */
    static void onTrim(int level) {
        if (level < MODERATE) return;
        MrPerf.begin(MrPerf.TRIM);
        int keyboards = 0;
        int popups = 0;
        int shadows = 0;
        int bytes = 0;
        try {
            keyboards = KeyboardSwitcher.dropUnused();
            LatinKeyboardView view = KeyboardSwitcher.getInstance().getInputView();
            boolean shown = view != null && view.isShown();
            if (view != null && (!shown || level >= LOW)) popups = view.trimCaches();
            if (!shown) {
                bytes = ShadowDrawHelper.heldBytes();
                shadows = ShadowDrawHelper.release();
            }
        } catch (Throwable t) {
            Log.i(TAG, "trim " + level + " stopped: " + t);
        }
        MrPerf.end(MrPerf.TRIM);
        sLevel = level;
        sKeyboards = keyboards;
        sPopups = popups;
        sShadows = shadows;
        sBytes = bytes;
        sCount++;
    }
}
