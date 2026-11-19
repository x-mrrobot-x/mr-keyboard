package com.mrkeyboard.app;

import android.content.Context;
import android.widget.ScrollView;

/** A scroll view that is never taller than a given height: the controls of a dialog scroll inside it while the keyboard above and the buttons below stay in sight. */
final class MrCappedScroll extends ScrollView {
    private final int mMaxPx;

    MrCappedScroll(Context c, int maxPx) {
        super(c);
        mMaxPx = maxPx;
    }

    /** The most it measures, in pixels (test help). */
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
