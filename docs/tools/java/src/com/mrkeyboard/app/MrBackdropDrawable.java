package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;

/**
 * The background of the keyboard that {@link MrBackdrop} describes: the background itself and, over it, the veil that keeps the toolbar readable.
 * What is drawn is the same on every frame, so it is made once for the size it has (a bitmap of that size) and drawn from there; a new size (the
 * phone turned, the height setting changed) makes it again. The picture of the gallery is read only while that bitmap is made and let go of
 * after it.
 *
 * <p>When the bitmap cannot be made (not enough memory, a picture that is gone) the drawable paints {@code fallback}, the colour of the theme,
 * so that the keyboard is never left see-through.
 */
final class MrBackdropDrawable extends Drawable {
    private final Context mContext;
    private final MrBackdrop.Spec mSpec;
    private final boolean mDark;
    private final int mSoft;
    private final int mFallback;
    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private Bitmap mCache;
    private boolean mFailed;

    private MrBackdropDrawable(Context c, MrBackdrop.Spec spec, boolean dark, int soft, int fallback) {
        mContext = c;
        mSpec = spec;
        mDark = dark;
        mSoft = soft;
        mFallback = fallback;
    }

    /** The drawable for a background, or null when it cannot be had (no background, or the picture is missing). */
    static MrBackdropDrawable create(Context c, MrBackdrop.Spec spec, boolean dark, int soft, int fallback) {
        if (c == null || spec == null || spec.kind == MrBackdrop.NONE) return null;
        if (spec.kind == MrBackdrop.IMAGE && !MrBackdrop.hasImage(c)) return null;
        return new MrBackdropDrawable(c, spec, dark, soft, fallback);
    }

    @Override
    public void draw(Canvas canvas) {
        Rect b = getBounds();
        int w = b.width(), h = b.height();
        if (w <= 0 || h <= 0) return;
        if ((mCache == null || mCache.getWidth() != w || mCache.getHeight() != h) && !mFailed) render(w, h);
        if (mCache == null) {
            canvas.drawColor(mFallback);
            return;
        }
        canvas.drawBitmap(mCache, new Rect(0, 0, w, h), new Rect(b.left, b.top, b.right, b.bottom), mPaint);
    }

    private void render(int w, int h) {
        Bitmap image = null;
        try {
            if (mCache != null) mCache.recycle();
            mCache = null;
            if (mSpec.kind == MrBackdrop.IMAGE) {
                image = MrBackdrop.load(mContext);
                if (image == null) {
                    mFailed = true;
                    return;
                }
            }
            Bitmap out = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
            Canvas c = new Canvas(out);
            MrBackdrop.draw(c, mSpec, w, h, image);
            c.drawColor(veilOver(MrBackdrop.look(mSpec, image, mDark, mSoft)));
            mCache = out;
        } catch (RuntimeException e) {
            mFailed = true;
        } catch (OutOfMemoryError e) {
            mFailed = true;
        } finally {
            if (image != null) image.recycle();
        }
    }

    /** The veil as one colour with its alpha (clear when there is none to lay). */
    static int veilOver(MrBackdrop.Look look) {
        if (look == null || look.veilAlpha <= 0) return 0;
        return (look.veilAlpha << 24) | (look.veilColor & 0xffffff);
    }

    @Override
    public void setAlpha(int alpha) {
        mPaint.setAlpha(alpha);
    }

    @Override
    public int getOpacity() {
        return -1; // PixelFormat.OPAQUE: the background covers everything it is given
    }
}
