package com.mrkeyboard.app;

import android.content.Context;
import android.widget.ScrollView;

/**
 * A scroll view that is never taller than a given height, that the sheet it is in ({@link MrSheetBox}) sets: the controls of a dialog scroll inside it
 * while the keyboard above and the buttons below stay in sight. Until it is told, it is as tall as its content (up to the room the parent gives).
 */
final class MrCappedScroll extends ScrollView {
    /** No limit: the largest size a measure spec can hold. */
    static final int FREE = 0x3fffffff;

    private int mMaxPx = FREE;

    MrCappedScroll(Context c) {
        super(c);
    }

    /** Sets the most it measures, in pixels (0 .. {@link #FREE}). */
    void cap(int px) {
        mMaxPx = px < 0 ? 0 : px > FREE ? FREE : px;
    }

    /** The most it measures, in pixels. */
    int maxPx() {
        return mMaxPx;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int size = MeasureSpec.getSize(heightMeasureSpec);
        int cap = size > 0 ? Math.min(size, mMaxPx) : mMaxPx;
        super.onMeasure(widthMeasureSpec, MeasureSpec.makeMeasureSpec(cap, MeasureSpec.AT_MOST));
    }
}
