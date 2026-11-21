package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Shader;
import android.view.View;

/**
 * The dot that stands for one style of keys in the dialog of a background ({@link MrBackdrop#STYLE_TAGS}), drawn the way the keys of that style look:
 * glass is a disc of its tint, an outline is a ring of its hue with an empty middle, a gradient is a ring (and a faint disc) in the three hues that
 * the keyboard turns through. The one that is chosen has a second ring, in the accent colour of the screen.
 *
 * <p>The dot of a style of the person's own colour ({@link MrBackdrop#isOwnStyle}) is drawn the same way with that colour (and the end of the gradient),
 * and has a ring of all the hues round it: it is the one that opens the colour picker. While no colour was picked, it is that ring with a plus inside.
 */
final class MrStyleDot extends View {
    /** Side of the dot, in dp. */
    static final int SIZE_DP = 40;

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final float mDensity;
    private final int mStyle;
    private final boolean mChosen;
    private final int mRing;
    /** The colour of a style of the person's own (0 = none picked yet) and, for the gradient, its end (0 = the one the keyboard makes up). */
    private final int mOwn, mOwn2;
    /** A swatch of a colour that is offered: the colour as it is, without the ring of all the hues that says "pick another". */
    private boolean mSwatch;
    /** The tone of the background that the keys are over (0 = none known): the see-through glass is a white pulled towards it. */
    private int mTone;
    /** How far the white of the see-through glass is pulled towards the tone of the background (0 = pure white), so that it does not look like a solid white key. */
    static final float SEE_PULL = 0.28f;

    private static final int[] RAINBOW = {0xffff4d4d, 0xffffc83d, 0xff3ddc97, 0xff4da3ff, 0xffa77bff, 0xffff5fd2, 0xffff4d4d};

    MrStyleDot(Context c, int style, boolean chosen, int ring) {
        this(c, style, chosen, ring, 0, 0);
    }

    MrStyleDot(Context c, int style, boolean chosen, int ring, int own, int own2) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
        mStyle = style;
        mChosen = chosen;
        mRing = ring;
        mOwn = own;
        mOwn2 = own2;
    }

    /** This dot is a swatch of a colour that was suggested: it shows the style in that colour with no ring of hues. Returns it. */
    MrStyleDot swatch() {
        mSwatch = true;
        return this;
    }

    /** The tone of the background under the keys, for the see-through glass to be drawn the colour that it has over it (0 = none known). Returns it. */
    MrStyleDot tone(int tone) {
        mTone = tone;
        return this;
    }

    /** The colour of the see-through glass over a background of the tone {@code tone}: white pulled towards it (white itself when there is no tone). Opaque. */
    static int seeThrough(int tone) {
        return tone == 0 ? 0xffffffff : MrThemesActivity.towards(0xffffffff, 0xff000000 | tone, SEE_PULL);
    }

    /** Whether it is a swatch (test help). */
    boolean isSwatch() {
        return mSwatch;
    }

    /** The colour that the dot shows when it is of the person's own colour (0 = none; test help). */
    int own() {
        return mOwn;
    }

    /** The style that this dot stands for (test help). */
    int style() {
        return mStyle;
    }

    /** Whether it is the one chosen (test help). */
    boolean chosen() {
        return mChosen;
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
        boolean own = MrBackdrop.isOwnStyle(mStyle);
        int kind = MrBackdrop.kindOf(mStyle);
        int[] colours = own ? ownColours(kind) : MrBackdrop.STYLE_COLORS[Math.max(0, Math.min(mStyle, MrBackdrop.PRESETS - 1))];
        mPaint.setShader(null);
        // a dark disc under every dot: the glass and the lines are seen over a background, not over the white of a card
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(0xff1b2030);
        canvas.drawCircle(cx, cy, r, mPaint);
        if (colours == null) {
            // no colour picked yet: a plus, to say that it opens the picker
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setColor(0xffffffff);
            canvas.drawLine(cx - r * 0.45f, cy, cx + r * 0.45f, cy, mPaint);
            canvas.drawLine(cx, cy - r * 0.45f, cx, cy + r * 0.45f, mPaint);
        } else if (kind == MrBackdrop.KIND_GLASS) {
            int glass = !own && mStyle == 0 ? seeThrough(mTone) : colours[0];
            mPaint.setColor(MrThemePreview.withAlpha(glass, mStyle == 0 ? 0.30f : 0.55f));
            canvas.drawCircle(cx, cy, r, mPaint);
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(mDensity);
            mPaint.setColor(MrThemePreview.withAlpha(glass, mStyle == 0 ? 0.55f : 0.75f));
            canvas.drawCircle(cx, cy, r - mDensity / 2f, mPaint);
        } else if (kind == MrBackdrop.KIND_OUTLINE) {
            mPaint.setColor(MrThemePreview.withAlpha(colours[0], 0.12f));
            canvas.drawCircle(cx, cy, r, mPaint);
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setColor(colours[0]);
            canvas.drawCircle(cx, cy, r - mDensity, mPaint);
        } else {
            Shader sh = new LinearGradient(cx - r, cy - r * 0.4f, cx + r, cy + r * 0.4f, colours, null, Shader.TileMode.CLAMP);
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setShader(sh);
            canvas.drawCircle(cx, cy, r - mDensity, mPaint);
            mPaint.setShader(null);
        }
        mPaint.setShader(null);
        if (own && !mSwatch) {
            // the ring of all the hues, between the dot and the ring of the one chosen
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setShader(new LinearGradient(cx - outer, cy, cx + outer, cy, RAINBOW, null, Shader.TileMode.CLAMP));
            canvas.drawCircle(cx, cy, r + 2.5f * mDensity, mPaint);
            mPaint.setShader(null);
        }
        if (mChosen) {
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(2f * mDensity);
            mPaint.setColor(mRing);
            canvas.drawCircle(cx, cy, outer, mPaint);
        }
        mPaint.setStyle(Paint.Style.FILL);
    }

    /** The colours a style of the person's own shows: its colour, or the three of the gradient; null while none was picked. */
    private int[] ownColours(int kind) {
        if (mOwn == 0) return null;
        if (kind != MrBackdrop.KIND_GRADIENT) return new int[] {mOwn};
        int end = mOwn2 != 0 ? mOwn2 : MrKeyLook.partner(mOwn);
        return new int[] {mOwn, MrKeyLook.middle(mOwn, end), end};
    }
}
