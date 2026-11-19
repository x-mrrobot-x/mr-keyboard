package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Shader;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewParent;

/**
 * A colour picker of two parts: a square of the saturation (left to right) and the brightness (bottom to top) of a hue, and a bar of the hues under it.
 * Dragging in either part moves its knob and tells the listener the colour (opaque RGB). Used by the dialog of a background to pick the colour of the
 * letters and the colour of the styles of the keys of the person's own.
 */
final class MrColorPicker extends View {
    /** Told every time the colour changes by the finger. */
    interface Listener {
        void onColor(int rgb);
    }

    /** Height of the square, the gap and the bar, in dp. */
    static final int SQUARE_DP = 150, GAP_DP = 14, BAR_DP = 30;

    private static final int[] HUES = {0xffff0000, 0xffffff00, 0xff00ff00, 0xff00ffff, 0xff0000ff, 0xffff00ff, 0xffff0000};

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float mDensity;
    private final float[] mHsv = {210f, 0.6f, 1f};
    private Listener mListener;
    /** Which part the finger that is down started in: 0 none, 1 the square, 2 the bar. */
    private int mPart;

    MrColorPicker(Context c) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
    }

    void setListener(Listener l) {
        mListener = l;
    }

    /** Sets the colour (the knobs move; the listener is not told). */
    void setColor(int rgb) {
        MrGlow.hsv(rgb, mHsv);
        invalidate();
    }

    /** The colour now, opaque. */
    int color() {
        return MrGlow.rgb(mHsv[0], mHsv[1], mHsv[2]);
    }

    /** The hue now, 0..360 (test help). */
    float hue() {
        return mHsv[0];
    }

    private int squareH() {
        return Math.round(SQUARE_DP * mDensity);
    }

    private int barTop() {
        return squareH() + Math.round(GAP_DP * mDensity);
    }

    private int barH() {
        return Math.round(BAR_DP * mDensity);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int w = MeasureSpec.getSize(widthMeasureSpec);
        setMeasuredDimension(w, barTop() + barH());
    }

    /** Moves the knob of the part {@code part} to the point (x, y) of the view and tells the listener. */
    void drag(int part, float x, float y) {
        int w = getWidth();
        if (w <= 0) return;
        float fx = Math.max(0f, Math.min(1f, x / w));
        if (part == 1) {
            float fy = Math.max(0f, Math.min(1f, y / squareH()));
            mHsv[1] = fx;
            mHsv[2] = 1f - fy;
        } else if (part == 2) {
            mHsv[0] = fx * 359.99f;
        } else {
            return;
        }
        invalidate();
        if (mListener != null) mListener.onColor(color());
    }

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        int action = e.getActionMasked();
        if (action == MotionEvent.ACTION_DOWN) {
            float y = e.getY();
            mPart = y <= squareH() + mDensity * GAP_DP / 2f ? 1 : y >= barTop() - mDensity * GAP_DP / 2f ? 2 : 0;
            ViewParent p = getParent();
            if (p != null) p.requestDisallowInterceptTouchEvent(true);
        }
        if (action == MotionEvent.ACTION_DOWN || action == MotionEvent.ACTION_MOVE) {
            drag(mPart, e.getX(), e.getY());
            return true;
        }
        if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) {
            mPart = 0;
            return true;
        }
        return super.onTouchEvent(e);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        int w = getWidth();
        if (w <= 0) return;
        int sh = squareH(), bt = barTop(), bh = barH();
        float radius = 8f * mDensity;
        // the square: white to the pure hue from left to right, then clear to black from top to bottom
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setShader(new LinearGradient(0, 0, w, 0, 0xffffffff, MrGlow.rgb(mHsv[0], 1f, 1f), Shader.TileMode.CLAMP));
        canvas.drawRoundRect(0, 0, w, sh, radius, radius, mPaint);
        mPaint.setShader(new LinearGradient(0, 0, 0, sh, 0x00000000, 0xff000000, Shader.TileMode.CLAMP));
        canvas.drawRoundRect(0, 0, w, sh, radius, radius, mPaint);
        mPaint.setShader(new LinearGradient(0, bt, w, bt, HUES, null, Shader.TileMode.CLAMP));
        canvas.drawRoundRect(0, bt, w, bt + bh, bh / 2f, bh / 2f, mPaint);
        mPaint.setShader(null);
        knob(canvas, mHsv[1] * w, (1f - mHsv[2]) * sh, color(), 11f * mDensity);
        knob(canvas, mHsv[0] / 359.99f * w, bt + bh / 2f, MrGlow.rgb(mHsv[0], 1f, 1f), bh / 2f - 2f * mDensity);
    }

    /** A round knob filled with the colour, with a white ring inside a dark one so that it is seen over any colour. */
    private void knob(Canvas canvas, float x, float y, int fill, float r) {
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(fill);
        canvas.drawCircle(x, y, r, mPaint);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(2.5f * mDensity);
        mPaint.setColor(0xffffffff);
        canvas.drawCircle(x, y, r, mPaint);
        mPaint.setStrokeWidth(mDensity);
        mPaint.setColor(0x66000000);
        canvas.drawCircle(x, y, r + 1.5f * mDensity, mPaint);
        mPaint.setStyle(Paint.Style.FILL);
    }
}
