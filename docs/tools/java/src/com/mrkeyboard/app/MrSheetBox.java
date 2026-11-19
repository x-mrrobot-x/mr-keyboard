package com.mrkeyboard.app;

import android.content.Context;
import android.widget.LinearLayout;

/**
 * The sheet of a dialog of the themes screen: a column that grows with what is in it up to a share of the screen height (the dialog of a background has
 * a lot in it). When what is in it is taller than that, the one view that scrolls ({@link MrCappedScroll}, the controls) takes what the others leave
 * and the keyboard above it and the buttons under it stay in sight; the sheet is never taller than the limit.
 */
final class MrSheetBox extends LinearLayout {
    private final int mMaxPx, mMinScrollPx;
    private MrCappedScroll mScroll;

    /** {@code maxPx}: the tallest the sheet gets; {@code minScrollPx}: the least that the scroll view keeps (a very short screen cuts the sheet instead). */
    MrSheetBox(Context c, int maxPx, int minScrollPx) {
        super(c);
        setOrientation(VERTICAL);
        mMaxPx = maxPx;
        mMinScrollPx = minScrollPx;
    }

    /** The view of the sheet that scrolls when the sheet reaches its limit. */
    void limit(MrCappedScroll scroll) {
        mScroll = scroll;
    }

    MrCappedScroll scroll() {
        return mScroll;
    }

    /** The tallest the sheet gets, in pixels (test help). */
    int maxPx() {
        return mMaxPx;
    }

    /** What the scroll view may take: the limit less what the others need ({@code fixed}), and never less than {@code min}. */
    static int room(int limit, int fixed, int min) {
        return Math.max(min, limit - fixed);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int size = MeasureSpec.getSize(heightMeasureSpec);
        int limit = MeasureSpec.getMode(heightMeasureSpec) == MeasureSpec.UNSPECIFIED || size <= 0 ? mMaxPx : Math.min(size, mMaxPx);
        int spec = MeasureSpec.makeMeasureSpec(limit, MeasureSpec.AT_MOST);
        if (mScroll == null || mScroll.getParent() != this) {
            super.onMeasure(widthMeasureSpec, spec);
            return;
        }
        // first with the scroll view empty, to see what the others take (the title, the keyboard, the buttons), then with all the room that is left
        mScroll.cap(0);
        super.onMeasure(widthMeasureSpec, spec);
        mScroll.cap(room(limit, getMeasuredHeight(), mMinScrollPx));
        super.onMeasure(widthMeasureSpec, spec);
    }
}
