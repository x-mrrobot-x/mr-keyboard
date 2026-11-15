package com.mrkeyboard.app;

import java.lang.ref.WeakReference;
import java.util.ArrayList;

/**
 * Stage 4 of docs/plan-performance.md (build _84): how many of the big objects of the keyboard are still alive once the garbage
 * collector ran, counted instead of guessed from megabytes. The memory lines (Java heap, native heap) move with what was typed, with
 * which keyboards were made and with when the collector ran, so they cannot say whether something stayed behind after the service
 * ended and was made again. A count can: the service (LatinIME) and the input view of the keyboard are 1 each while the service lives,
 * and after a switch to another keyboard and back it must still be 1 after a collection; a 2 means the old one is held by something.
 *
 * It holds only weak references, so it cannot be what keeps them alive. Nothing runs while the keyboard works besides one registration
 * per service and one per input view; the count is made by the Advanced screen, right after the collection that its row "free memory
 * now" asks for (MrPerf.Trim), and the meter shows it in a line (MrPerf.summary).
 */
final class MrLive {
    private static final ArrayList<WeakReference<Object>> sServiceRefs = new ArrayList<WeakReference<Object>>();
    private static final ArrayList<WeakReference<Object>> sViewRefs = new ArrayList<WeakReference<Object>>();

    /** What the last count found; sMeasured says there was one since the start of the process or the last reset of the meter. */
    static boolean sMeasured;
    static int sServices;
    static int sViews;

    private MrLive() { }

    /** LatinIME.onCreate: the service that was just made. */
    static synchronized void service(Object service) {
        watch(sServiceRefs, service);
    }

    /** KeyboardSwitcher, where the input view of the keyboard is made (every time a new one is inflated). */
    static synchronized void view(Object view) {
        watch(sViewRefs, view);
    }

    private static void watch(ArrayList<WeakReference<Object>> list, Object o) {
        if (o == null) return;
        for (int i = list.size() - 1; i >= 0; i--) {
            Object held = list.get(i).get();
            if (held == null) {
                list.remove(i);
            } else if (held == o) {
                return;     // the same object registered again is still one
            }
        }
        list.add(new WeakReference<Object>(o));
    }

    private static int alive(ArrayList<WeakReference<Object>> list) {
        int n = 0;
        for (int i = list.size() - 1; i >= 0; i--) {
            if (list.get(i).get() == null) list.remove(i);
            else n++;
        }
        return n;
    }

    /** Counts what is alive now. Call it right after System.gc(): before it, what is only waiting to be collected would count too. */
    static synchronized void measure() {
        sServices = alive(sServiceRefs);
        sViews = alive(sViewRefs);
        sMeasured = true;
    }

    /** The meter was reset: the line of the count goes too. */
    static synchronized void forget() {
        sMeasured = false;
    }
}
