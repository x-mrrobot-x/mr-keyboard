package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Rect;
import android.os.SystemClock;
import android.view.MotionEvent;
import android.view.View;
import android.widget.OverScroller;
import android.widget.ScrollView;

/**
 * The scrolling page of a list that grows while the person reads it (the apps dialog, the learned words, the import preview): when the next cards are
 * added at the end, the page stays where it is and a fling goes on as if the list had always been that long.
 *
 * <p>Two things made the page misbehave when a page of cards arrived:
 * <ul>
 * <li>A field that has the focus (the search field, even after its text was cleared) asks the page to show it again whenever the layout changes, and the
 * page scrolls back up to it. Every way that leads there ends in {@link #computeScrollDeltaToGetChildRectOnScreen}, so for a short time after the cards are
 * added the page does not move to show a child ({@link #quiet}), and it does not go up by itself either ({@link #keepPosition}).</li>
 * <li>A fling has its end fixed when it starts. Cards added in the middle of it do not move the end: the page ran past it and the spring of the end
 * pulled it back up, as if the list had bounced. Starting the fling again with the speed it had made it faster than it was. So the cards are added
 * before the fling starts: {@link #fling} asks where it would stop and, when too little of the list is left after that place, adds the next page first and
 * starts the fling, with the same speed, when the new cards are laid out ({@link Pager}).</li>
 * </ul>
 */
final class MrPage extends ScrollView {
    /** How long after the cards are added the page refuses to scroll to a child, in ms. */
    static final int QUIET_MS = 800;

    /** What adds the next page of cards at the end of the list. */
    interface Pager {
        /** Adds the next page (through {@link MrPage#keepPosition}); false when there is none. */
        boolean more();
    }

    private long mQuietUntil;
    private int mPin = -1;                  // the page does not go above this while it is quiet and the finger is up; -1 = none
    private boolean mTouching;
    private Pager mPager;
    private int mWaiting;                   // speed of a fling that waits for the new cards to be laid out; 0 = none
    private OverScroller mProbe;            // only to ask where a fling would stop

    MrPage(Context context) {
        super(context);
    }

    /** Sets what adds the next page of the list, so that a fling that would reach the end of the list finds the next page there. */
    void setPager(Pager pager) {
        mPager = pager;
    }

    /** For the next {@code ms} the page does not scroll to show a child that asks for it (the finger and the program still scroll it). */
    void quiet(int ms) {
        mQuietUntil = SystemClock.uptimeMillis() + ms;
    }

    boolean isQuiet() {
        return SystemClock.uptimeMillis() < mQuietUntil;
    }

    /** The list was drawn again from its start (a new search): nothing of the last cards is kept. */
    void release() {
        mQuietUntil = 0;
        mPin = -1;
        mWaiting = 0;
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent e) {
        int action = e.getActionMasked();
        if (action == MotionEvent.ACTION_DOWN) {
            mTouching = true;
            release();                      // the finger takes over: it decides where the page goes
        } else if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) {
            mTouching = false;
        }
        return super.dispatchTouchEvent(e);
    }

    @Override
    protected int computeScrollDeltaToGetChildRectOnScreen(Rect rect) {
        // the one place every "show this child" ends in (the child asks, the page lays out with a child in focus, the page is resized): 0 = stay
        if (isQuiet()) return 0;
        return super.computeScrollDeltaToGetChildRectOnScreen(rect);
    }

    @Override
    public boolean requestChildRectangleOnScreen(View child, Rect rectangle, boolean immediate) {
        // false = "nothing was scrolled": the child is not shown, the page stays
        if (isQuiet()) return false;
        return super.requestChildRectangleOnScreen(child, rectangle, immediate);
    }

    /** The lowest place the page may be at while it is pinned: where it was, or the end of the content when that is nearer. */
    private int floor() {
        View child = getChildAt(0);
        int range = child == null ? 0 : Math.max(0, child.getHeight() - (getHeight() - getPaddingTop() - getPaddingBottom()));
        return Math.min(mPin, range);
    }

    private boolean pinned() {
        return mPin >= 0 && !mTouching && isQuiet();
    }

    @Override
    public void scrollTo(int x, int y) {
        if (pinned() && y < floor()) y = floor();
        super.scrollTo(x, y);
    }

    @Override
    protected void onOverScrolled(int scrollX, int scrollY, boolean clampedX, boolean clampedY) {
        // while a fling runs the page sets its place without scrollTo
        if (pinned() && scrollY < floor()) scrollY = floor();
        super.onOverScrolled(scrollX, scrollY, clampedX, clampedY);
    }

    /** How far a fling of {@code velocityY} px/s goes, with no end in the way (the same physics as the page: a scroller of the same kind). */
    private int distance(int velocityY) {
        if (mProbe == null) mProbe = new OverScroller(getContext());
        mProbe.forceFinished(true);
        mProbe.fling(0, 0, 0, velocityY, 0, 0, Integer.MIN_VALUE, Integer.MAX_VALUE);
        return mProbe.getFinalY();
    }

    /** True when a fling of this speed would stop with less than a screen of the list left below it. */
    boolean reachesEnd(int velocityY) {
        View child = getChildAt(0);
        if (child == null) return false;
        int viewport = getHeight() - getPaddingTop() - getPaddingBottom();
        int bottom = getScrollY() + distance(velocityY) + viewport;      // the lower edge of the page where the fling would stop
        return bottom + viewport > child.getHeight();
    }

    /**
     * A fling toward the end: when it would run into the end of the list while the list has more cards, the next page is added first and the fling starts
     * (with the speed it was given) once the new cards are laid out, so it runs over the whole list and nothing bounces. Any other fling goes as usual.
     */
    @Override
    public void fling(int velocityY) {
        if (velocityY > 0 && mPager != null && !mTouching && reachesEnd(velocityY) && mPager.more()) {
            mWaiting = velocityY;
            addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
                public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
                    removeOnLayoutChangeListener(this);
                    int speed = mWaiting;
                    mWaiting = 0;
                    if (speed != 0 && !mTouching) fling(speed);     // asks again: a very fast fling may need one more page
                }
            });
            return;
        }
        super.fling(velocityY);
    }

    /**
     * Runs {@code change} (it adds cards at the end of the page) and keeps the page where it was: no scrolling to a child while the change settles, the
     * position put back right after it and once more after the next layout, when the page went up. It never moves the page down by itself or further than
     * where it was.
     */
    void keepPosition(Runnable change) {
        final int y = getScrollY();
        mPin = y;
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
