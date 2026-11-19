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
 * <p>{@link #setFull} makes it the complete keyboard (the dialog of a background): the row of Ctrl, Alt and the arrows, the numbers, the three rows
 * of letters and the bottom row, every highlight key with the face of its kind, and the dash of the modifier keys in its three states (off, on and
 * locked), as the real keyboard draws them.
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
    /** The complete keyboard: its shape (width / height) and the share of the height that the line of suggestions takes. */
    static final float FULL_ASPECT = 1.7f;
    static final float FULL_BAR_SHARE = 0.12f;
    /** The dash of a modifier key: none, off, on, locked (the colours are the roles modifier_indicator_*). */
    static final int DASH_NONE = 0, DASH_OFF = 1, DASH_ON = 2, DASH_LOCK = 3;
    /** The state of a key face: at rest, on (Ctrl lit) and locked (Shift locked). */
    static final int FACE_NORMAL = 0, FACE_ON = 1, FACE_LOCK = 2;
    /** The state attributes of the key faces, as the keyboard sets them: checkable, checked and active (android.R.attr). */
    private static final int ATTR_CHECKABLE = 0x101009f, ATTR_CHECKED = 0x10100a0, ATTR_ACTIVE = 0x10100a2;
    private static final int[] STATE_NORMAL = new int[0];
    private static final int[] STATE_MOD = {ATTR_CHECKABLE};
    private static final int[] STATE_ON = {ATTR_CHECKABLE, ATTR_CHECKED};
    private static final int[] STATE_LOCK = {ATTR_ACTIVE, ATTR_CHECKABLE, ATTR_CHECKED};
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
    private boolean mFull;
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

    /** The complete keyboard (true) or the small one (false). It changes the shape of the view. */
    void setFull(boolean full) {
        if (mFull == full) return;
        mFull = full;
        requestLayout();
        invalidate();
    }

    boolean full() {
        return mFull;
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
        setMeasuredDimension(w, Math.round(w / (mFull ? FULL_ASPECT : MrBackdrop.ASPECT)));
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
        float vh = vw / (mFull ? FULL_ASPECT : MrBackdrop.ASPECT);
        float s = w / vw;
        canvas.save();
        canvas.scale(s, s);
        bar(canvas, c, vw, vh, mFull ? FULL_BAR_SHARE : BAR_SHARE);
        if (mFull) fullKeys(canvas, c, vw, vh);
        else keys(canvas, c, vw, vh);
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
        if (mSpec.kind == MrBackdrop.NONE || (MrBackdrop.needsBitmap(mSpec) && mImage == null)) {
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
    private void bar(Canvas canvas, Context c, float vw, float vh, float share) {
        int ink = MrThemeColors.ink(c, mTag);
        float top = 0f, bottom = vh * share;
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

    /** The widths of the keys of the row of Ctrl, Alt and the arrows (share of the width, as the layout of the keyboard gives them) and what they say. */
    private static final float[] MOD_WIDTHS = {14.2f, 13.2f, 13.3f, 10.2f, 13.1f, 13.1f, 13.1f, 10.2f};
    private static final String[] MOD_LABELS = {"Ctrl", "Alt", "\u21b9", "<>", "\u2190", "\u2193", "\u2192", "{"};
    /** Which of them are modifier keys (the highlight ones, with a dash). */
    private static final boolean[] MOD_KEYS = {true, true, true, false, true, true, true, false};

    /**
     * The complete keyboard under the line of suggestions: the row of Ctrl, Alt and the arrows (Ctrl lit, to show the dash that is on), the numbers,
     * the three rows of letters (Shift locked, to show the one that is locked) and the bottom row, each key with the face of its kind.
     */
    private void fullKeys(Canvas canvas, Context c, float vw, float vh) {
        faces(c);
        float top = vh * FULL_BAR_SHARE;
        float side = vw * 0.008f;
        float rowH = (vh - top) / 6f;
        float width = vw - 2f * side;
        float unit = width / 10f;
        int text = MrThemeColors.colorOr(c, mTag, "text", 0xffffffff);
        int accentText = MrThemeColors.colorOr(c, mTag, "accent_text", text);
        int glow = MrThemeColors.declared(c, mTag, "glow");
        float glowPx = glow == 0 ? 0f : 5f * mDensity;
        float letter = rowH * 0.42f, word = rowH * 0.30f;
        mText.setTextAlign(Paint.Align.CENTER);
        // the row of Ctrl, Alt and the arrows
        float sum = 0f;
        for (float f : MOD_WIDTHS) sum += f;
        float x = side;
        for (int i = 0; i < MOD_WIDTHS.length; i++) {
            float kw = width * MOD_WIDTHS[i] / sum;
            boolean mod = MOD_KEYS[i];
            String label = MOD_LABELS[i];
            key(canvas, x, top, kw, rowH, mod, label, mod ? accentText : text, glow, glowPx,
                    i == 0 ? FACE_ON : FACE_NORMAL, !mod ? DASH_NONE : i == 0 ? DASH_ON : DASH_OFF, label.length() > 1 && mod && i < 2 ? word : letter);
            x += kw;
        }
        // the numbers and the letters
        String numbers = "1234567890";
        for (int i = 0; i < numbers.length(); i++) {
            key(canvas, side + i * unit, top + rowH, unit, rowH, false, String.valueOf(numbers.charAt(i)), text, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
        }
        for (int r = 0; r < 3; r++) {
            String letters = ROWS[r];
            float y = top + (2 + r) * rowH;
            float rowW = letters.length() * unit;
            float left = side + (10f * unit - rowW) / 2f;
            if (r == 2) {
                // Shift (locked) and delete, 15% of the width each, as the layout gives them
                float edge = width * 0.15f;
                key(canvas, side, y, edge, rowH, true, "\u21e7", accentText, glow, glowPx, FACE_LOCK, DASH_LOCK, letter);
                key(canvas, side + width - edge, y, edge, rowH, true, "\u232b", accentText, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
                left = side + edge;
            }
            for (int i = 0; i < letters.length(); i++) {
                key(canvas, left + i * unit, y, unit, rowH, false, String.valueOf(letters.charAt(i)), text, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
            }
        }
        // the bottom row: 123, F1, space, the full stop and enter
        float y = top + 5f * rowH;
        float a = width * 0.20f, b = unit, space = width * 0.40f;
        x = side;
        key(canvas, x, y, a, rowH, true, "123", accentText, glow, glowPx, FACE_NORMAL, DASH_NONE, word);
        x += a;
        key(canvas, x, y, b, rowH, true, "F1", accentText, glow, glowPx, FACE_NORMAL, DASH_OFF, word);
        x += b;
        key(canvas, x, y, space, rowH, false, "", text, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
        x += space;
        key(canvas, x, y, b, rowH, false, ".", text, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
        x += b;
        key(canvas, x, y, a, rowH, true, "\u23ce", accentText, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
    }

    /** One key at rest: its face in the room {@code w} x {@code h} at ({@code x}, {@code y}) (the face keeps its own gap) and its label. */
    private void key(Canvas canvas, float x, float y, float w, float h, boolean accent, String label, int ink, int glow, float glowPx) {
        key(canvas, x, y, w, h, accent, label, ink, glow, glowPx, FACE_NORMAL, DASH_NONE, 0f);
    }

    /**
     * One key: its face in the room {@code w} x {@code h} at ({@code x}, {@code y}) (the face keeps its own gap) in the state {@code state}, the
     * dash of the modifier keys (none, off, on or locked) and its label ({@code size}: the size of the letters, 0 = the one set before).
     */
    private void key(Canvas canvas, float x, float y, float w, float h, boolean accent, String label, int ink, int glow, float glowPx, int state, int dash, float size) {
        int iw = Math.max(1, Math.round(w)), ih = Math.max(1, Math.round(h));
        Drawable face = accent ? mAccent : mFace;
        canvas.save();
        canvas.translate(x, y);
        if (face != null) {
            face.setBounds(0, 0, iw, ih);
            // a key of the keyboard is "single" at rest (the selector then takes its resting face) and checkable when it is a modifier key
            face.setState(state == FACE_LOCK ? STATE_LOCK : state == FACE_ON ? STATE_ON : dash != DASH_NONE ? STATE_MOD : STATE_NORMAL);
            KeyStyle.prepare(face, iw, ih, getContext());
            KeyStyle.drawKey(face, canvas, iw, ih);
        } else {
            flat(canvas, iw, ih, accent, state);
        }
        if (dash != DASH_NONE) dash(canvas, iw, ih, dash);
        if (label.length() > 0) {
            if (size > 0f) mText.setTextSize(size);
            mText.setColor(ink);
            if (glowPx > 0f) mText.setShadowLayer(glowPx, 0f, 0f, glow);
            else mText.clearShadowLayer();
            mText.getFontMetrics(mMetrics);
            canvas.drawText(label, iw / 2f, ih / 2f - (mMetrics.ascent + mMetrics.descent) / 2f, mText);
            mText.clearShadowLayer();
        }
        canvas.restore();
    }

    /** The dash of a modifier key, where the keyboard puts it: low in the key, as wide as 14 dp or a third of the key, 3 dp thick. */
    private void dash(Canvas canvas, int w, int h, int state) {
        Context c = getContext();
        String role = state == DASH_LOCK ? "modifier_indicator_lock" : state == DASH_ON ? "modifier_indicator_on" : "modifier_indicator_off";
        int colour = MrThemeColors.colorOr(c, mTag, role, 0xff808080);
        float dw = Math.min(14f * mDensity, w * 0.3f), dh = 3f * mDensity;
        float bottom = h - 8f * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setColor(colour);
        canvas.drawRoundRect(w / 2f - dw / 2f, bottom - dh, w / 2f + dw / 2f, bottom, dh / 2f, dh / 2f, mPaint);
    }

    /** The face of a theme that has no key drawable: the fill and the lip of its colours (the ones of the state: at rest, on or locked). */
    private void flat(Canvas canvas, int w, int h, boolean accent, int state) {
        Context c = getContext();
        String name = state == FACE_LOCK ? "lock" : state == FACE_ON ? "on" : "normal";
        String rest = accent ? "key_acc_normal_" : "key_normal_";
        String pre = accent ? "key_acc_" + name + "_" : "key_" + name + "_";
        // the solid themes say fill and lip; the neon and gloss ones say top and bottom of their gradient
        int restFill = MrThemeColors.colorOr(c, mTag, rest + "fill", MrThemeColors.colorOr(c, mTag, rest + "top", 0xff3a3f47));
        int restLip = MrThemeColors.colorOr(c, mTag, rest + "lip", MrThemeColors.colorOr(c, mTag, rest + "bottom", restFill));
        int fill = MrThemeColors.colorOr(c, mTag, pre + "fill", MrThemeColors.colorOr(c, mTag, pre + "top", restFill));
        int lip = MrThemeColors.colorOr(c, mTag, pre + "lip", MrThemeColors.colorOr(c, mTag, pre + "bottom", state == FACE_NORMAL ? restLip : fill));
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
