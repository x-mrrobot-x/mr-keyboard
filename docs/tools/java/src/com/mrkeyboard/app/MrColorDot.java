package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Shader;
import android.view.View;

/**
 * The round button that opens the colour picker: a disc of the colour picked inside a ring of all the hues; while no colour was picked (0), the ring with
 * a plus inside.
 */
final class MrColorDot extends View {
    /** Side of the dot, in dp. */
    static final int SIZE_DP = 40;

    private static final int[] RAINBOW = {0xffff4d4d, 0xffffc83d, 0xff3ddc97, 0xff4da3ff, 0xffa77bff, 0xffff5fd2, 0xffff4d4d};

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float mDensity;
    private final int mColor;

    MrColorDot(Context c, int color) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
        mColor = color == 0 ? 0 : 0xff000000 | color;
    }

    /** The colour that it shows, opaque (0 = none picked; test help). */
    int color() {
        return mColor;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int side = Math.round(SIZE_DP * mDensity);
        setMeasuredDimension(side, side);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        int w = getWidth(), h = getHeight();
        if (w <= 0 || h <= 0) return;
        float cx = w / 2f, cy = h / 2f;
        float outer = Math.min(w, h) / 2f - 1.5f * mDensity;
        float r = outer - 5f * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(mColor != 0 ? mColor : 0xff1b2030);
        canvas.drawCircle(cx, cy, r, mPaint);
        if (mColor == 0) {
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setColor(0xffffffff);
            canvas.drawLine(cx - r * 0.45f, cy, cx + r * 0.45f, cy, mPaint);
            canvas.drawLine(cx, cy - r * 0.45f, cx, cy + r * 0.45f, mPaint);
        }
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(2.5f * mDensity);
        mPaint.setShader(new LinearGradient(cx - outer, cy, cx + outer, cy, RAINBOW, null, Shader.TileMode.CLAMP));
        canvas.drawCircle(cx, cy, outer - mDensity, mPaint);
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
    }
}
