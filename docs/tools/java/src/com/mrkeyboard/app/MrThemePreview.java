package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.view.View;

/**
 * A small keyboard drawn the way the real one looks: the background (the colour of the theme, or the {@link MrBackdrop} chosen, with its veil), a
 * line of suggestions and four rows of keys made with the key drawables of the theme and its colours, so that a theme or a background can be seen
 * on the keys before it is chosen. The themes screen has one for every theme and every background, and a big one for the choice in use.
 *
 * <p>The keys are drawn as large as the real ones on this phone (the width of the screen is the width of the keyboard) and the whole is scaled to
 * the size of the view, so the radius, the lips and the gaps of the key faces are the ones of the keyboard. A theme that has no key drawable falls
 * back to flat faces in its colours. The corners of the view are rounded; a ring and a check mark show that it is the one chosen.
 */
final class MrThemePreview extends View {
    /** Rows of letters of the keyboard, top to bottom. */
    static final String[] ROWS = {"QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"};
    /** Share of the height of the keyboard that the line of suggestions takes (the part of the background whose brightness the veil also looks at). */
    static final float BAR_SHARE = MrBackdrop.BAR_SHARE;
    static final float CORNER_DP = 12f;
    /** What the line of suggestions says: three bars of these widths (share of the width), in the ink of the toolbar. */
    static final float[] WORDS = {0.20f, 0.14f, 0.18f};

    private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint mText = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint.FontMetrics mMetrics = new Paint.FontMetrics();
    private final float mDensity;

    private String mTag;
    private MrBackdrop.Spec mSpec = MrBackdrop.Spec.NO;
    private Bitmap mImage;
    private int mSoft;
    private boolean mChecked;
    private int mRing = 0xff4f8cff, mCheck = 0xffffffff;
    private int mKeyWidthPx;

    private Bitmap mBg;
    private String mBgKey;
    private Drawable mFace, mAccent;
    private String mFaceTag;
    private int mDrawn;
    /** The "add a picture" tile: a plain face with a plus, not a keyboard. */
    private boolean mPlus;
    private int mPlusFill, mPlusLine, mPlusInk;

    MrThemePreview(Context c) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
        // the keyboard is as wide as the narrow side of the screen (the screen handles its own turns, so this does not change while it is open)
        android.util.DisplayMetrics dm = c.getResources().getDisplayMetrics();
        mKeyWidthPx = Math.min(dm.widthPixels, dm.heightPixels);
    }

    /**
     * What to draw: the theme {@code tag} (null: the colours that every theme shares), the background {@link MrBackdrop.Spec} with the picture that
     * an IMAGE spec shows, and how much the background is softened. Draws again.
     */
    void show(String tag, MrBackdrop.Spec spec, Bitmap image, int soft) {
        mPlus = false;
        mTag = tag;
        mSpec = spec == null ? MrBackdrop.Spec.NO : spec;
        mImage = image;
        mSoft = soft;
        invalidate();
    }

    /** Draws the tile that adds a picture (a plus on a plain face) instead of a keyboard. */
    void showPlus(int fill, int line, int ink) {
        mPlus = true;
        mPlusFill = fill;
        mPlusLine = line;
        mPlusInk = ink;
        invalidate();
    }

    /** The ring and the check mark of the one that is chosen, in these colours. */
    void setChecked(boolean checked, int ring, int check) {
        mChecked = checked;
        mRing = ring;
        mCheck = check;
        invalidate();
    }

    /** The theme and the background that this keyboard shows (what the screen asked it to show; test help). */
    String tag() {
        return mTag;
    }

    MrBackdrop.Spec spec() {
        return mSpec;
    }

    /** Whether the ring and the check mark are on (test help). */
    boolean checked() {
        return mChecked;
    }

    /** Test and layout help: how many views of this kind were drawn so far (the key faces made once per theme). */
    int drawn() {
        return mDrawn;
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int w = MeasureSpec.getSize(widthMeasureSpec);
        setMeasuredDimension(w, Math.round(w / MrBackdrop.ASPECT));
    }

    @Override
    protected void onDraw(Canvas canvas) {
        int w = getWidth(), h = getHeight();
        if (w <= 0 || h <= 0) return;
        mDrawn++;
        Context c = getContext();
        if (mPlus) {
            plus(canvas, w, h);
            return;
        }
        boolean dark = MrThemeColors.dark(c, mTag);
        canvas.save();
        canvas.clipPath(roundRect(w, h, CORNER_DP * mDensity));
        background(canvas, c, w, h, dark);
        // the keys: drawn at the size of the real ones, then scaled to the view
        float vw = mKeyWidthPx;
        float vh = vw / MrBackdrop.ASPECT;
        float s = w / vw;
        canvas.save();
        canvas.scale(s, s);
        bar(canvas, c, vw, vh);
        keys(canvas, c, vw, vh);
        canvas.restore();
        canvas.restore();
        if (mChecked) badge(canvas, w, h);
    }

    // ---- the pieces

    /** The tile that adds a picture: the face, its line and a plus in the middle. */
    private void plus(Canvas canvas, int w, int h) {
        float r = CORNER_DP * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(mPlusFill);
        canvas.drawRoundRect(0f, 0f, w, h, r, r, mPaint);
        float line = Math.max(1f, mDensity);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(line);
        mPaint.setColor(mPlusLine);
        canvas.drawRoundRect(line / 2f, line / 2f, w - line / 2f, h - line / 2f, r, r, mPaint);
        float arm = Math.min(w, h) * 0.17f;
        mPaint.setStrokeWidth(2.5f * mDensity);
        mPaint.setColor(mPlusInk);
        canvas.drawLine(w / 2f - arm, h / 2f, w / 2f + arm, h / 2f, mPaint);
        canvas.drawLine(w / 2f, h / 2f - arm, w / 2f, h / 2f + arm, mPaint);
        mPaint.setStyle(Paint.Style.FILL);
        if (mChecked) badge(canvas, w, h);
    }

    private void background(Canvas canvas, Context c, int w, int h, boolean dark) {
        if (mSpec.kind == MrBackdrop.NONE || (mSpec.kind == MrBackdrop.IMAGE && mImage == null)) {
            canvas.drawColor(MrThemeColors.colorOr(c, mTag, "kbd_bg", 0xff202020));
            return;
        }
        String key = mSpec.format() + "|" + dark + "|" + mSoft + "|" + w + "x" + h + "|" + System.identityHashCode(mImage);
        if (mBg == null || !key.equals(mBgKey)) {
            try {
                Bitmap out = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
                Canvas oc = new Canvas(out);
                MrBackdrop.draw(oc, mSpec, w, h, mImage);
                oc.drawColor(MrBackdropDrawable.veilOver(MrBackdrop.look(mSpec, mImage, dark, mSoft)));
                mBg = out;
                mBgKey = key;
            } catch (RuntimeException e) {
                mBg = null;
            } catch (OutOfMemoryError e) {
                mBg = null;
            }
        }
        if (mBg == null) {
            canvas.drawColor(MrThemeColors.colorOr(c, mTag, "kbd_bg", 0xff202020));
            return;
        }
        canvas.drawBitmap(mBg, new Rect(0, 0, w, h), new Rect(0, 0, w, h), mPaint);
    }

    /** The line of suggestions: three bars of the ink of the toolbar, between thin dividers. */
    private void bar(Canvas canvas, Context c, float vw, float vh) {
        int ink = MrThemeColors.ink(c, mTag);
        float top = 0f, bottom = vh * BAR_SHARE;
        float cy = (top + bottom) / 2f;
        float bh = bottom * 0.22f;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        float x = vw * 0.09f;
        for (int i = 0; i < WORDS.length; i++) {
            float bw = vw * WORDS[i];
            mPaint.setColor(withAlpha(ink, 0.70f));
            canvas.drawRoundRect(x, cy - bh / 2f, x + bw, cy + bh / 2f, bh / 2f, bh / 2f, mPaint);
            x += bw + vw * 0.11f;
            if (i < WORDS.length - 1) {
                mPaint.setColor(withAlpha(ink, 0.25f));
                canvas.drawRect(x - vw * 0.055f - 1f, bottom * 0.28f, x - vw * 0.055f + 1f, bottom * 0.72f, mPaint);
            }
        }
    }

    private void keys(Canvas canvas, Context c, float vw, float vh) {
        faces(c);
        float top = vh * BAR_SHARE;
        float side = vw * 0.008f;
        float rowH = (vh - top) / 4f;
        float unit = (vw - 2f * side) / 10f;
        int text = MrThemeColors.colorOr(c, mTag, "text", 0xffffffff);
        int accentText = MrThemeColors.colorOr(c, mTag, "accent_text", text);
        // the neon themes light up their labels
        int glow = MrThemeColors.declared(c, mTag, "glow");
        float glowPx = glow == 0 ? 0f : 5f * mDensity;
        mText.setTextAlign(Paint.Align.CENTER);
        mText.setTextSize(rowH * 0.42f);
        for (int r = 0; r < 4; r++) {
            float y = top + r * rowH;
            if (r < 3) {
                String letters = ROWS[r];
                float rowW = letters.length() * unit;
                float left = side + (10f * unit - rowW) / 2f;
                if (r == 2) {
                    // shift and delete at the ends, as wide as the room that the seven letters leave
                    float edge = (10f * unit - rowW) / 2f - unit * 0.1f;
                    key(canvas, side, y, edge, rowH, false, "⇧", text, glow, glowPx);
                    key(canvas, side + 10f * unit - edge, y, edge, rowH, false, "⌫", text, glow, glowPx);
                }
                for (int i = 0; i < letters.length(); i++) {
                    key(canvas, left + i * unit, y, unit, rowH, false, String.valueOf(letters.charAt(i)), text, glow, glowPx);
                }
            } else {
                float a = unit * 1.3f, b = unit * 1.0f, e = unit * 1.7f;
                float space = 10f * unit - a - 2f * b - e;
                float x = side;
                key(canvas, x, y, a, rowH, false, "?123", text, glow, glowPx);
                x += a;
                key(canvas, x, y, b, rowH, false, ",", text, glow, glowPx);
                x += b;
                key(canvas, x, y, space, rowH, false, "", text, glow, glowPx);
                x += space;
                key(canvas, x, y, b, rowH, false, ".", text, glow, glowPx);
                x += b;
                key(canvas, x, y, e, rowH, true, "⏎", accentText, glow, glowPx);
            }
        }
    }

    /** One key: its face in the room {@code w} x {@code h} at ({@code x}, {@code y}) (the face keeps its own gap) and its label. */
    private void key(Canvas canvas, float x, float y, float w, float h, boolean accent, String label, int ink, int glow, float glowPx) {
        int iw = Math.max(1, Math.round(w)), ih = Math.max(1, Math.round(h));
        Drawable face = accent ? mAccent : mFace;
        canvas.save();
        canvas.translate(x, y);
        if (face != null) {
            face.setBounds(0, 0, iw, ih);
            KeyStyle.prepare(face, iw, ih, getContext());
            KeyStyle.drawKey(face, canvas, iw, ih);
        } else {
            flat(canvas, iw, ih, accent);
        }
        if (label.length() > 0) {
            mText.setColor(ink);
            if (glowPx > 0f) mText.setShadowLayer(glowPx, 0f, 0f, glow);
            else mText.clearShadowLayer();
            mText.getFontMetrics(mMetrics);
            canvas.drawText(label, iw / 2f, ih / 2f - (mMetrics.ascent + mMetrics.descent) / 2f, mText);
            mText.clearShadowLayer();
        }
        canvas.restore();
    }

    /** The face of a theme that has no key drawable: the fill and the lip of its colours. */
    private void flat(Canvas canvas, int w, int h, boolean accent) {
        Context c = getContext();
        String pre = accent ? "key_acc_normal_" : "key_normal_";
        // the solid themes say fill and lip; the neon and gloss ones say top and bottom of their gradient
        int fill = MrThemeColors.colorOr(c, mTag, pre + "fill", MrThemeColors.colorOr(c, mTag, pre + "top", 0xff3a3f47));
        int lip = MrThemeColors.colorOr(c, mTag, pre + "lip", MrThemeColors.colorOr(c, mTag, pre + "bottom", fill));
        float gap = 3f * mDensity, r = 8f * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        if (lip == fill && (fill >>> 24) != 255) {
            // a see-through face has no lip: drawn twice it would be less see-through
            mPaint.setColor(fill);
            canvas.drawRoundRect(gap, gap, w - gap, h - gap, r, r, mPaint);
            return;
        }
        mPaint.setColor(lip);
        canvas.drawRoundRect(gap, gap, w - gap, h - gap, r, r, mPaint);
        mPaint.setColor(fill);
        canvas.drawRoundRect(gap, gap, w - gap, h - gap - 2f * mDensity, r, r, mPaint);
    }

    /** The key faces of the theme: made once for each theme (the drawable is a copy, so that making it ready does not change the shared one). */
    private void faces(Context c) {
        if (mFace != null && (mTag == null ? mFaceTag == null : mTag.equals(mFaceTag))) return;
        mFaceTag = mTag;
        mFace = face(c, MrThemeColors.keyDrawable(c, mTag, false));
        mAccent = face(c, MrThemeColors.keyDrawable(c, mTag, true));
    }

    private static Drawable face(Context c, int id) {
        if (id == 0) return null;
        try {
            Drawable d = c.getResources().getDrawable(id);
            if (d == null) return null;
            Drawable.ConstantState cs = d.getConstantState();
            return (cs == null ? d : cs.newDrawable()).mutate();
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** The ring around the view and the round badge with the check mark. */
    private void badge(Canvas canvas, int w, int h) {
        float ringW = 2.5f * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(ringW);
        mPaint.setColor(mRing);
        float r = CORNER_DP * mDensity;
        canvas.drawRoundRect(ringW / 2f, ringW / 2f, w - ringW / 2f, h - ringW / 2f, r, r, mPaint);
        float br = 9f * mDensity;
        float cx = w - br - 6f * mDensity, cy = br + 6f * mDensity;
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(mRing);
        canvas.drawCircle(cx, cy, br, mPaint);
        mPaint.setStyle(Paint.Style.STROKE);
        mPaint.setStrokeWidth(2f * mDensity);
        mPaint.setColor(mCheck);
        canvas.drawLine(cx - br * 0.45f, cy + br * 0.02f, cx - br * 0.12f, cy + br * 0.36f, mPaint);
        canvas.drawLine(cx - br * 0.12f, cy + br * 0.36f, cx + br * 0.48f, cy - br * 0.34f, mPaint);
        mPaint.setStyle(Paint.Style.FILL);
    }

    /** A rectangle with round corners as a path (a polyline of short steps, so that it needs nothing but lines). */
    static Path roundRect(float w, float h, float r) {
        float k = Math.min(r, Math.min(w, h) / 2f);
        Path p = new Path();
        int steps = 8;
        p.moveTo(k, 0f);
        p.lineTo(w - k, 0f);
        corner(p, w - k, k, k, -90f, steps);
        p.lineTo(w, h - k);
        corner(p, w - k, h - k, k, 0f, steps);
        p.lineTo(k, h);
        corner(p, k, h - k, k, 90f, steps);
        p.lineTo(0f, k);
        corner(p, k, k, k, 180f, steps);
        p.close();
        return p;
    }

    /** The quarter circle of {@code radius} round ({@code cx}, {@code cy}) that starts at {@code from} degrees. */
    private static void corner(Path p, float cx, float cy, float radius, float from, int steps) {
        for (int i = 1; i <= steps; i++) {
            double a = Math.toRadians(from + 90.0 * i / steps);
            p.lineTo(cx + radius * (float) Math.cos(a), cy + radius * (float) Math.sin(a));
        }
    }

    static int withAlpha(int rgb, float alpha) {
        return (Math.round(Math.max(0f, Math.min(1f, alpha)) * 255f) << 24) | (rgb & 0xffffff);
    }
}
