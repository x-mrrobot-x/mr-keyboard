package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Rect;
import android.os.SystemClock;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ScrollView;

/**
 * The scrolling page of a list that grows while the person reads it (the apps dialog, the learned words, the import preview): when the next cards are
 * added at the end, the page stays where it is and a fling that was running goes on.
 *
 * <p>Two things made the page jump when a page of cards arrived:
 * <ul>
 * <li>A field that has the focus (the search field, even after its text was cleared) asks the page to show it again whenever the layout changes, and the
 * page scrolls back up to it. Every way that leads there ends in {@link #computeScrollDeltaToGetChildRectOnScreen}, so for a short time after the cards are
 * added the page does not move to show a child ({@link #quiet}).</li>
 * <li>A fling has its end fixed when it starts. The cards added in the middle of it did not move the end: the page ran past it and the spring of the end
 * pulled it back up, as if the list had bounced. So the fling is started again, with the speed it had, once the new cards are laid out
 * ({@link #keepPosition}).</li>
 * </ul>
 */
final class MrPage extends ScrollView {
    /** How long after the cards are added the page refuses to scroll to a child, in ms. */
    static final int QUIET_MS = 800;
    /** A speed (px/s) below this is not a fling, and the speed is only trusted when the page moved in the last {@link #FRESH_MS}. */
    static final float MIN_SPEED = 120f;
    static final int FRESH_MS = 100;

    private long mQuietUntil;
    private int mPin = -1;                  // the page does not go above this while it is quiet and the finger is up; -1 = none
    private boolean mTouching;
    private float mSpeed;                   // px/s, positive toward the end of the list; smoothed over the last scroll steps
    private long mMovedAt;                  // when the page moved last

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

    /** The list was drawn again from its start (a new search): nothing of the last cards is kept. */
    void release() {
        mQuietUntil = 0;
        mPin = -1;
        mSpeed = 0f;
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
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);
        long now = SystemClock.uptimeMillis();
        long dt = now - mMovedAt;
        if (dt > 0 && dt < FRESH_MS) {
            mSpeed = mSpeed * 0.5f + ((t - oldt) * 1000f / dt) * 0.5f;
        } else if (dt >= FRESH_MS) {
            mSpeed = 0f;                    // it had stopped: the first step has no speed yet
        }
        mMovedAt = now;
    }

    /** True when the page is still running after the finger left it, toward the end of the list. */
    boolean flinging() {
        return !mTouching && mSpeed > MIN_SPEED && SystemClock.uptimeMillis() - mMovedAt < FRESH_MS;
    }

    /** The speed (px/s) of the fling that is running toward the end, 0 when there is none. */
    float flingSpeed() {
        return flinging() ? mSpeed : 0f;
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

    /**
     * Runs {@code change} (it adds cards at the end of the page) and keeps the page where it was: no scrolling to a child while the change settles, the
     * position put back right after it and once more after the next layout, when the page went up, and a fling that was running started again with the
     * speed it had, now that the end is further. It never moves the page down by itself or further than where it was.
     */
    void keepPosition(Runnable change) {
        final int y = getScrollY();
        final float speed = flingSpeed();
        mPin = y;
        quiet(QUIET_MS);
        change.run();
        if (getScrollY() < y) scrollTo(getScrollX(), y);
        addOnLayoutChangeListener(new View.OnLayoutChangeListener() {
            public void onLayoutChange(View v, int left, int top, int right, int bottom, int oldLeft, int oldTop, int oldRight, int oldBottom) {
                // once: the first layout after the change
                removeOnLayoutChangeListener(this);
                if (getScrollY() < y) scrollTo(getScrollX(), y);
                if (speed > 0f && !mTouching) fling((int) speed);
            }
        });
    }
}
