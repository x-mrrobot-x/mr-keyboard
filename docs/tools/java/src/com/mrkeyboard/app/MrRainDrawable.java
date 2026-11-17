package com.mrkeyboard.app;

import android.animation.ValueAnimator;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.SystemClock;

/**
 * The background of a settings screen when the Matrix effect is on: the flat colour of the screens with the falling letters of {@link MrRain}
 * over it, in the colour of the theme (the accent; the head of every drop is that colour made lighter). It is the <b>window background</b>, so it is
 * drawn behind everything the screen draws (the cards of the settings cover it, it shows around them, behind the header and the bars) and no view
 * of the screen has to know about it.
 *
 * <p>It animates itself: the first draw asks for the next beat ({@link #STEP_MS} later, about 12 beats a second: the drops move in whole rows, so
 * more would only cost battery), the beat moves the rain and invalidates, the draw asks for the next one. The window tells a background when the
 * window is shown or hidden ({@link #setVisible}): hidden, the beats stop and nothing is drawn until it is shown again. When the phone has the
 * animations turned off (the accessibility setting "remove animations", or the battery saver: {@link ValueAnimator#areAnimatorsEnabled}) it does not
 * ask for beats at all: the letters stay where they are, one frame, and the screen costs nothing.
 *
 * <p>The glyphs are digits, capital letters and a few signs, plus the half-width katakana of the film when the font of the phone has them
 * (Paint.hasGlyph, asked once); the ones it lacks are left out, so there is never a "missing character" box.
 */
final class MrRainDrawable extends Drawable {
    /** Time between two beats of the rain. */
    static final long STEP_MS = 80;
    /** Size of a glyph, in dp. */
    static final float TEXT_DP = 15f;
    /** How much of the head is the accent made lighter (0 = the accent, 1 = white). */
    static final float HEAD_LIGHT = 0.55f;
    /** Opacity of the head and of the start of a trail (the rest fades from there): low, so the text of the screen stays easy to read. */
    static final float HEAD_ALPHA = 0.70f;
    static final float TRAIL_ALPHA = 0.30f;
    /** Steps of opacity along a trail (the colours are made once). */
    static final int LEVELS = 12;
    /** Always there: digits, capitals and signs. */
    static final String BASE = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ=+-*/<>:.";
    /** Half-width katakana (U+FF71..U+FF9D), kept only when the font draws them. */
    static final String KANA = "ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄ"
            + "ﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ";

    private final int mBackground;
    private final int[] mTrail = new int[LEVELS + 1];
    private final int mHead;
    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final String[] mGlyphs;
    private final MrRain mRain;
    private final float mTextPx;
    private float mCellW;
    private float mCellH;
    private int mWidth = -1;
    private int mHeight = -1;
    private boolean mScheduled;
    private final Runnable mBeat = new Runnable() {
        public void run() {
            mScheduled = false;
            mRain.step();
            invalidateSelf();
        }
    };

    /** {@code background}: the colour of the screens; {@code accent}: the colour of the theme; {@code density}: of the display (dp to pixels). */
    MrRainDrawable(int background, int accent, float density) {
        mBackground = background;
        for (int i = 0; i <= LEVELS; i++) mTrail[i] = withAlpha(accent, TRAIL_ALPHA * i / LEVELS);
        mHead = withAlpha(lighter(accent, HEAD_LIGHT), HEAD_ALPHA);
        mTextPx = TEXT_DP * density;
        mPaint.setTypeface(Typeface.MONOSPACE);
        mPaint.setTextSize(mTextPx);
        mPaint.setTextAlign(Paint.Align.CENTER);
        mGlyphs = glyphs(mPaint);
        mRain = new MrRain(mGlyphs.length, SystemClock.uptimeMillis());
    }

    /** The glyphs to draw: the base set and the katakana that the font has, one string each (so that drawing allocates nothing). */
    static String[] glyphs(Paint paint) {
        String all = BASE + KANA;
        String[] out = new String[all.length()];
        int n = 0;
        for (int i = 0; i < all.length(); i++) {
            String g = String.valueOf(all.charAt(i));
            if (i < BASE.length() || paint.hasGlyph(g)) out[n++] = g;
        }
        String[] kept = new String[n];
        System.arraycopy(out, 0, kept, 0, n);
        return kept;
    }

    static int withAlpha(int rgb, float alpha) {
        int a = Math.round(Math.max(0f, Math.min(1f, alpha)) * 255f);
        return (a << 24) | (rgb & 0xffffff);
    }

    /** The colour moved towards white by {@code amount} (0 = the same, 1 = white). */
    static int lighter(int rgb, float amount) {
        int r = (rgb >> 16) & 0xff, g = (rgb >> 8) & 0xff, b = rgb & 0xff;
        r += Math.round((255 - r) * amount);
        g += Math.round((255 - g) * amount);
        b += Math.round((255 - b) * amount);
        return 0xff000000 | (r << 16) | (g << 8) | b;
    }

    @Override
    public void draw(Canvas canvas) {
        canvas.drawColor(mBackground);
        Rect bounds = getBounds();
        fit(bounds.width(), bounds.height());
        for (int c = 0; c < mRain.cols(); c++) {
            float x = c * mCellW + mCellW / 2f;
            int last = mRain.last(c);
            for (int r = mRain.first(c); r <= last; r++) {
                float level = mRain.level(c, r);
                if (level <= 0f) continue;
                mPaint.setColor(level >= 1f ? mHead : mTrail[Math.round(level * LEVELS)]);
                canvas.drawText(mGlyphs[mRain.glyphAt(c, r)], x, (r + 1) * mCellH - mCellH * 0.22f, mPaint);
            }
        }
        if (!mScheduled && isVisible() && ValueAnimator.areAnimatorsEnabled()) {
            mScheduled = true;
            scheduleSelf(mBeat, SystemClock.uptimeMillis() + STEP_MS);
        }
    }

    /** The grid follows the size of the window (turning the phone makes another one). */
    private void fit(int width, int height) {
        if (width == mWidth && height == mHeight) return;
        mWidth = width;
        mHeight = height;
        mCellW = Math.max(1f, mPaint.measureText("0") * 1.05f);
        mCellH = Math.max(1f, mTextPx * 1.15f);
        mRain.resize((int) Math.ceil(width / mCellW), (int) Math.ceil(height / mCellH) + 1);
    }

    /** The window shows or hides its background: hidden, the beats stop; shown, the next draw starts them again. */
    @Override
    public boolean setVisible(boolean visible, boolean restart) {
        boolean changed = super.setVisible(visible, restart);
        if (!visible) {
            unscheduleSelf(mBeat);
            mScheduled = false;
        } else if (changed) {
            invalidateSelf();
        }
        return changed;
    }

    @Override
    public void setAlpha(int alpha) { }

    @Override
    public void setColorFilter(ColorFilter colorFilter) { }

    @Override
    public int getOpacity() {
        return -1;   // PixelFormat.OPAQUE: the whole window is painted
    }
}
