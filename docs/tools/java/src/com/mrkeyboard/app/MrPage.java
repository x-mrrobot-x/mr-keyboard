package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Rect;
import android.os.SystemClock;
import android.view.View;
import android.widget.ScrollView;

/**
 * The scrolling page of a list that grows while the person reads it (the apps dialog, the learned words): when the next cards are added at the end, the
 * page stays where it is.
 *
 * <p>Without this the page jumped when a page of cards arrived: a field that has the focus (the search field, even after its text was cleared) asks the
 * page to show it again whenever the layout changes, and the page scrolls back up to it. So, for a short time after the cards are added, the page does
 * not move to show a child ({@link #quiet}); and what the layout of the new cards moved anyway is put back ({@link #keepPosition}).
 */
final class MrPage extends ScrollView {
    /** How long after the cards are added the page refuses to scroll to a child, in ms. */
    static final int QUIET_MS = 400;

    private long mQuietUntil;

    MrPage(Context context) {
        super(context);
    }

    /** For the next {@code ms} the page does not scroll to show a child that asks for it (the finger and the program still scroll it). */
    void quiet(int ms) {
        mQuietUntil = SystemClock.uptimeMillis() + ms;
    }

    boolean isQuiet() {
        return SystemClock.uptimeMillis() < mQuietUntil;
    }

    @Override
    public boolean requestChildRectangleOnScreen(View child, Rect rectangle, boolean immediate) {
        // false = "nothing was scrolled": the child is not shown, the page stays
        if (isQuiet()) return false;
        return super.requestChildRectangleOnScreen(child, rectangle, immediate);
    }

    /**
     * Runs {@code change} (it adds cards at the end of the page) and keeps the page where it was: no scrolling to a child while the change settles, the
     * position put back right after it and once more after the next layout, when the page went up. It never moves the page down or further than where it was.
     */
    void keepPosition(Runnable change) {
        final int y = getScrollY();
        quiet(QUIET_MS);
        change.run();
        if (getScrollY() < y) scrollTo(getScrollX(), y);
        addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
            public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
                // once: the first layout after the change
                removeOnLayoutChangeListener(this);
                if (getScrollY() < y) scrollTo(getScrollX(), y);
            }
        });
    }
}
