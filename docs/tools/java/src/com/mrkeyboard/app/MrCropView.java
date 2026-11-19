package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.view.MotionEvent;
import android.view.View;

/**
 * The picture of the gallery with the frame of the keyboard over it, to choose which part of the picture the keyboard will show: the whole picture is
 * drawn as large as the view allows, the part outside the frame is dimmed, and the frame has the shape of the keyboard
 * ({@link MrBackdrop#ASPECT}). One finger drags the frame; two fingers pinched make it smaller, spread make it bigger (the zoom of the picture goes
 * the other way: a smaller frame is a bigger zoom). The frame is the {@link MrBackdrop#crop} of the zoom and the position, so what is chosen here
 * is what the keyboard shows. How much the background is softened is drawn as a veil over what is inside the frame (a hint: the preview that
 * follows is the exact one).
 */
final class MrCropView extends View {
    /** What the person did to the frame. */
    interface Listener {
        void changed();
    }

    private static final int OUTSIDE = 0x99000000;

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float mDensity;
    private Bitmap mImage;
    private int mZoom = MrBackdrop.ZOOM_MIN, mDx, mDy, mSoft;
    private Listener mListener;
    /** Where the picture is drawn in the view, and how many pixels of the view one pixel of the picture takes. */
    private final Rect mDest = new Rect();
    private float mScale = 1f;
    /** The fingers: where the one that drags was last, and, with two, how far apart they were and the zoom then. */
    private float mLastX, mLastY, mStartDistance;
    private int mStartZoom;
    private boolean mPinching;

    MrCropView(Context c) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
    }

    /** The picture and where the frame is on it (zoom 100 .. 400, position -100 .. 100), and how much is softened. */
    void set(Bitmap image, int zoom, int dx, int dy, int soft) {
        mImage = image;
        mZoom = MrBackdrop.clamp(zoom, MrBackdrop.ZOOM_MIN, MrBackdrop.ZOOM_MAX);
        mDx = MrBackdrop.clamp(dx, -100, 100);
        mDy = MrBackdrop.clamp(dy, -100, 100);
        mSoft = MrBackdrop.clamp(soft, 0, MrBackdrop.MAX_SOFT);
        invalidate();
    }

    void setSoft(int soft) {
        mSoft = MrBackdrop.clamp(soft, 0, MrBackdrop.MAX_SOFT);
        invalidate();
    }

    void setListener(Listener l) {
        mListener = l;
    }

    int zoom() {
        return mZoom;
    }

    int dx() {
        return mDx;
    }

    int dy() {
        return mDy;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        setMeasuredDimension(MeasureSpec.getSize(widthMeasureSpec), MeasureSpec.getSize(heightMeasureSpec));
    }

    /** The picture fits the view (nothing is cut, nothing is stretched) and is centred in it. */
    private void place(int w, int h) {
        int iw = mImage.getWidth(), ih = mImage.getHeight();
        mScale = Math.min(w / (float) iw, h / (float) ih);
        int dw = Math.max(1, Math.round(iw * mScale)), dh = Math.max(1, Math.round(ih * mScale));
        int l = (w - dw) / 2, t = (h - dh) / 2;
        mDest.set(l, t, l + dw, t + dh);
    }

    /** The shape of the frame as two whole numbers (what {@link MrBackdrop#crop} takes). */
    private static int shapeW() {
        return Math.round(MrBackdrop.ASPECT * 100f);
    }

    /** The frame on the view: the {@link MrBackdrop#crop} of the picture, moved to where the picture is drawn. */
    Rect frame() {
        if (mImage == null || getWidth() <= 0 || getHeight() <= 0) return new Rect(0, 0, 0, 0);
        place(getWidth(), getHeight());
        Rect s = MrBackdrop.crop(mImage.getWidth(), mImage.getHeight(), shapeW(), 100, mZoom, mDx, mDy);
        return new Rect(mDest.left + Math.round(s.left * mScale), mDest.top + Math.round(s.top * mScale),
                mDest.left + Math.round(s.right * mScale), mDest.top + Math.round(s.bottom * mScale));
    }

    @Override
    protected void onDraw(Canvas canvas) {
        int w = getWidth(), h = getHeight();
        if (mImage == null || w <= 0 || h <= 0) return;
        Rect f = frame();
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setFilterBitmap(true);
        canvas.drawBitmap(mImage, new Rect(0, 0, mImage.getWidth(), mImage.getHeight()), new Rect(mDest.left, mDest.top, mDest.right, mDest.bottom), mPaint);
        // what is outside the frame is dimmed, what is inside is the keyboard (with the softening laid on it)
        mPaint.setColor(OUTSIDE);
        canvas.drawRect(mDest.left, mDest.top, mDest.right, f.top, mPaint);
        canvas.drawRect(mDest.left, f.bottom, mDest.right, mDest.bottom, mPaint);
        canvas.drawRect(mDest.left, f.top, f.left, f.bottom, mPaint);
        canvas.drawRect(f.right, f.top, mDest.right, f.bottom, mPaint);
        if (mSoft > 0) {
            mPaint.setColor(((mSoft * 255 / 100) << 24));
            canvas.drawRect(f.left, f.top, f.right, f.bottom, mPaint);
        }
        float line = Math.max(1f, mDensity * 1.2f);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(line);
        mPaint.setColor(0xffffffff);
        canvas.drawRect(f.left + line / 2f, f.top + line / 2f, f.right - line / 2f, f.bottom - line / 2f, mPaint);
        mPaint.setStyle(Paint.Style.FILL);
    }

    // ---- the fingers

    @Override
    public boolean onTouchEvent(MotionEvent e) {
        if (mImage == null || getWidth() <= 0 || getHeight() <= 0) return false;
        int action = e.getActionMasked();
        switch (action) {
            case MotionEvent.ACTION_DOWN:
                mLastX = e.getX();
                mLastY = e.getY();
                mPinching = false;
                return true;
            case MotionEvent.ACTION_POINTER_DOWN:
                if (e.getPointerCount() >= 2) {
                    mPinching = true;
                    mStartDistance = distance(e);
                    mStartZoom = mZoom;
                }
                return true;
            case MotionEvent.ACTION_POINTER_UP:
                if (e.getPointerCount() <= 2) {
                    // one finger is left: it carries on dragging from where it is, with no jump
                    mPinching = false;
                    int left = e.getActionIndex() == 0 ? 1 : 0;
                    mLastX = e.getX(left);
                    mLastY = e.getY(left);
                }
                return true;
            case MotionEvent.ACTION_MOVE:
                if (mPinching && e.getPointerCount() >= 2) {
                    pinch(distance(e));
                } else if (!mPinching && e.getPointerCount() >= 1) {
                    drag(e.getX() - mLastX, e.getY() - mLastY);
                    mLastX = e.getX();
                    mLastY = e.getY();
                }
                return true;
            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_CANCEL:
                mPinching = false;
                return true;
            default:
                return false;
        }
    }

    private static float distance(MotionEvent e) {
        float dx = e.getX(0) - e.getX(1), dy = e.getY(0) - e.getY(1);
        return (float) Math.sqrt(dx * dx + dy * dy);
    }

    /** The frame follows the finger by ({@code moveX}, {@code moveY}) pixels of the view. */
    private void drag(float moveX, float moveY) {
        if (mScale <= 0f) return;
        int[] now = MrBackdrop.shift(mImage.getWidth(), mImage.getHeight(), shapeW(), 100, mZoom, mDx, mDy, moveX / mScale, moveY / mScale);
        if (now[0] == mDx && now[1] == mDy) return;
        mDx = now[0];
        mDy = now[1];
        changed();
    }

    /** Spreading the fingers makes the frame bigger (a smaller zoom), pinching makes it smaller; its middle stays where it is. */
    private void pinch(float distance) {
        if (mStartDistance < 1f || distance < 1f) return;
        int zoom = MrBackdrop.clamp(Math.round(mStartZoom * mStartDistance / distance), MrBackdrop.ZOOM_MIN, MrBackdrop.ZOOM_MAX);
        if (zoom == mZoom) return;
        int[] now = MrBackdrop.rezoom(mImage.getWidth(), mImage.getHeight(), shapeW(), 100, mZoom, mDx, mDy, zoom);
        mZoom = zoom;
        mDx = now[0];
        mDy = now[1];
        changed();
    }

    private void changed() {
        invalidate();
        if (mListener != null) mListener.changed();
    }
}
