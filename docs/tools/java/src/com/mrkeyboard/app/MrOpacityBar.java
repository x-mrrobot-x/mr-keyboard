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
 * The bar of the opacity of a colour, under the colour picker ({@link MrColorPicker}): the colour fades in from clear (left) to full (right) over a
 * chequered ground, with a notch where the opacity that the keys have by default is and a round knob at the value. The value is a share of the opacity
 * that the style gives (see {@link MrKeyLook}): 0 .. {@code max} per cent, {@code reference} (100) being the style's own. Dragging moves the knob and tells the
 * listener the value.
 */
final class MrOpacityBar extends View {
    /** Told every time the value changes by the finger. */
    interface Listener {
        void onOpacity(int percent);
    }

    /** Height of the bar, in dp (the one of the bar of the hues). */
    static final int BAR_DP = MrColorPicker.BAR_DP;
    /** Side of a square of the chequered ground, in dp. */
    static final float CHECK_DP = 6f;

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float mDensity;
    private final int mMax, mReference;
    private int mValue;
    private int mColor = 0xffffffff;
    private Listener mListener;

    MrOpacityBar(Context c, int max, int reference) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
        mMax = Math.max(1, max);
        mReference = Math.max(0, Math.min(mMax, reference));
    }

    void setListener(Listener l) {
        mListener = l;
    }

    /** Sets the colour that fades in (opaque RGB). */
    void setColor(int rgb) {
        mColor = 0xff000000 | rgb;
        invalidate();
    }

    /** Sets the value (the knob moves; the listener is not told). */
    void setValue(int percent) {
        mValue = clamp(percent);
        invalidate();
    }

    /** The value now, 0 .. max per cent. */
    int value() {
        return mValue;
    }

    /** The colour that fades in, opaque. */
    int color() {
        return mColor;
    }

    int max() {
        return mMax;
    }

    private int clamp(int v) {
        return v < 0 ? 0 : v > mMax ? mMax : v;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        setMeasuredDimension(MeasureSpec.getSize(widthMeasureSpec), Math.round(BAR_DP * mDensity));
    }

    /** Moves the knob to the point {@code x} of the view and tells the listener. */
    void drag(float x) {
        int w = getWidth();
        if (w <= 0) return;
        float f = Math.max(0f, Math.min(1f, x / w));
        int v = clamp(Math.round(f * mMax));
        if (v == mValue) return;
        mValue = v;
        invalidate();
        if (mListener != null) mListener.onOpacity(v);
    }

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        int action = e.getActionMasked();
        if (action == MotionEvent.ACTION_DOWN) {
            ViewParent p = getParent();
            if (p != null) p.requestDisallowInterceptTouchEvent(true);
        }
        if (action == MotionEvent.ACTION_DOWN || action == MotionEvent.ACTION_MOVE) {
            drag(e.getX());
            return true;
        }
        if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) return true;
        return super.onTouchEvent(e);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        int w = getWidth(), h = getHeight();
        if (w <= 0 || h <= 0) return;
        // the bar is a pill: the chequered ground and the colour fading in are clipped to it
        canvas.save();
        canvas.clipPath(MrThemePreview.roundRect(w, h, h / 2f));
        float square = CHECK_DP * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        int rows = (int) Math.ceil(h / square), cols = (int) Math.ceil(w / square);
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                mPaint.setColor(((r + c) & 1) == 0 ? 0xffffffff : 0xffc4c4c4);
                canvas.drawRect(c * square, r * square, (c + 1) * square, (r + 1) * square, mPaint);
            }
        }
        mPaint.setShader(new LinearGradient(0, 0, w, 0, mColor & 0x00ffffff, mColor, Shader.TileMode.CLAMP));
        canvas.drawRect(0, 0, w, h, mPaint);
        mPaint.setShader(null);
        canvas.restore();
        // the notch of the opacity that the style gives: a thin line, light with a dark edge so that it shows over any colour
        float nx = (float) mReference / mMax * w;
        mPaint.setColor(0x66000000);
        canvas.drawRect(nx - 1.5f * mDensity, h * 0.18f, nx + 1.5f * mDensity, h * 0.82f, mPaint);
        mPaint.setColor(0xccffffff);
        canvas.drawRect(nx - 0.75f * mDensity, h * 0.18f, nx + 0.75f * mDensity, h * 0.82f, mPaint);
        // the knob: the colour at the opacity it has, with a white ring inside a dark one
        float r = h / 2f - 2f * mDensity;
        float kx = (float) mValue / mMax * w;
        kx = Math.max(r + 2f * mDensity, Math.min(w - r - 2f * mDensity, kx));
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(mColor);
        canvas.drawCircle(kx, h / 2f, r, mPaint);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(2.5f * mDensity);
        mPaint.setColor(0xffffffff);
        canvas.drawCircle(kx, h / 2f, r, mPaint);
        mPaint.setStrokeWidth(mDensity);
        mPaint.setColor(0x66000000);
        canvas.drawCircle(kx, h / 2f, r + 1.5f * mDensity, mPaint);
        mPaint.setStyle(Paint.Style.FILL);
    }
}
