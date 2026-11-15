package com.mrkeyboard.app;

import android.os.SystemClock;
import android.view.MotionEvent;

/**
 * The time of a long press counts from the touch, not from the moment the keyboard got to see it.
 *
 * <p>The popup of a key (variants, or the sheets of the 123 key) opens when a message of the keyboard's handler runs, a set time
 * after the finger went down (the setting, 150 ms for the sheet key, longer while a touch may become a gesture). The message used
 * to be sent "that time from now", where "now" is when the keyboard handled the touch. When the main thread was busy and the touch
 * reached the keyboard late, the whole delay was added to the wait (a touch seen 150 ms late made the long press of a 150 ms key
 * come at 300 ms). Now the message is due that time after the <b>event</b>, the way the long press of Android's own gesture
 * detector is timed: a touch seen late shortens the wait by what was already lost, down to none. A finger that already left has
 * its release handled next, and that release cancels the timer, so a short tap seen late is still a tap.
 *
 * <p>The same clocks give the meter its numbers ({@link MrPerf#longShown}): how long after the touch the popup came, and where the
 * time beyond the set one went: the touch seen late, the timer run late, the popup itself.
 *
 * <p>All of it runs on the main thread. The calls from the smali: {@link #event} (LatinKeyboardView.onTouchEvent, first lines),
 * {@link #arm} (LatinKeyboardBaseView$UIHandler.startLongPressTimer, the delay it is going to send), {@link #ran} (the handler,
 * when the message runs) and {@link #shown} (LatinKeyboardBaseView.onLongPress, after the popup window was shown).
 */
public final class MrLongPress {
    private static final long NONE = Long.MIN_VALUE;

    /** Tests: the clock (uptime, ms); -1 = SystemClock.uptimeMillis. */
    static long sFakeNow = -1;

    /** Time of the touch event under way (its event time); NONE when none is under way or the timer of it was already armed. */
    private static long sEvent = NONE;
    /** The timer last armed: what the delay counts from (the event, or the clock when no event was in hand). */
    private static long sFrom;
    /** The timer last armed: the clock when it was armed, and when its message is due. */
    private static long sArmedAt, sDue;
    /** The timer last armed: the set time (what the delay asked for, before it was counted from the event), in ms. */
    private static long sPlanned;
    /** When the message of the timer last armed ran; NONE until it does (and again once its popup was counted). */
    private static long sRan = NONE;

    private MrLongPress() { }

    static long now() {
        return sFakeNow >= 0 ? sFakeNow : SystemClock.uptimeMillis();
    }

    /** LatinKeyboardView.onTouchEvent: the event time of the touch that the keyboard is about to handle. */
    public static void event(MotionEvent e) {
        if (e != null) sEvent = e.getEventTime();
    }

    /**
     * The delay (ms) for the long press timer that is going to be armed, when it was asked <code>planned</code> ms after the touch.
     * What the keyboard already took to see the touch is taken off, down to 0. Without an event in hand (a timer not armed by
     * a touch) or with one that is in the future of the clock, the delay counts from now, as before.
     */
    public static long arm(long planned) {
        long now = now();
        long from = sEvent;
        sEvent = NONE;       // an event arms at most one timer: a later arm that no touch asked for is not counted from an old one
        if (from == NONE || from > now) from = now;
        long delay = planned - (now - from);
        if (delay < 0) delay = 0;
        sFrom = from;
        sArmedAt = now;
        sDue = now + delay;
        sPlanned = planned;
        sRan = NONE;
        return delay;
    }

    /** The handler runs the message of the long press timer. */
    public static void ran() {
        sRan = now();
    }

    /** The popup window of the long press was shown: the meter gets the numbers of this long press (once). */
    public static void shown() {
        long ran = sRan;
        if (ran == NONE) return;       // a popup that no timer of ours asked for
        sRan = NONE;
        long now = now();
        MrPerf.longShown(now - sFrom, sPlanned, sArmedAt - sFrom, ran - sDue, now - ran);
    }

    /** Tests: forgets the timer and the event. */
    static void forget() {
        sEvent = NONE;
        sRan = NONE;
    }
}
