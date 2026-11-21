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
 * line of suggestions and five rows of keys (Ctrl, Alt and the arrows, three of letters and the bottom row) made with the key drawables of the theme and its colours, so that a theme or a background can be seen
 * on the keys before it is chosen. The themes screen has one for every theme and every background, and a big one for the choice in use.
 *
 * <p>{@link #setFull} makes it the complete keyboard (the dialog of a theme or of a background), as tall as the real one on this phone: the toolbar with its
 * eight buttons over the seven rows of keys (the row of the toolbar key, the row of Ctrl, Alt and Tab, the numbers, the three rows of letters and the
 * bottom row), every highlight key with the face of its kind, and the dash (off) under Ctrl, Alt and Shift, as the real keyboard draws them at rest:
 * nothing is lit or locked (no red shift) and no key but those three has a dash. {@link #fullAspect} is its shape, which the frame of the gallery shares.
 *
 * <p>The themes of the gradient styles (the roles {@code spectrum_*}) are drawn with the hue of each key's place, as {@link MrGlow} does on the real keyboard.
 * What the person tuned ({@link #setLook}, a {@link MrKeyLook}) is drawn the same way on a theme of the backgrounds: the opacity of the fill and of the
 * line of each face, the colour of the letters, the colours of the styles of their own colour (the end of a gradient included) and the faint dash that is off.
 * The line of suggestions is centred in the width and in the height of its part of the keyboard.
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
    /**
     * The real keyboard, which the complete one stands for: the toolbar ({@code mr_bar_height}, 48 dp) over the rows of keys ({@link #FULL_ROWS}, the
     * {@code layoutRows} of the layout) and the space under the last row ({@link MrBottom#GAP_DP}); the rows and that space take the share of the height of
     * the screen that the setting "Keyboard height" gives (34 % until the person changes it), the toolbar comes on top of it.
     */
    static final float BAR_DP = 48f;
    static final int FULL_ROWS = 7;
    static final int HEIGHT_DEFAULT = 34, HEIGHT_MIN = 15, HEIGHT_MAX = 75;
    static final String PREF_HEIGHT = "settings_height_portrait";
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
    /** The paint of the background picture: only for it, since the one above takes the colour (and its opacity) of the last thing drawn, and a picture drawn with that is faint. */
    private final Paint mBgPaint = new Paint(Paint.FILTER_BITMAP_FLAG);
    private final Paint mText = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint.FontMetrics mMetrics = new Paint.FontMetrics();
    private final float mDensity;

    private String mTag;
    /** What the person tuned about the keys of the background (the opacities, the colour of the letters, their own colour); only a theme of the backgrounds is drawn with it. */
    private MrKeyLook mLook = MrKeyLook.NONE;
    private MrBackdrop.Spec mSpec = MrBackdrop.Spec.NO;
    private Bitmap mImage;
    private int mSoft;
    private boolean mChecked;
    private boolean mFull;
    private int mRing = 0xff4f8cff, mCheck = 0xffffffff;
    private int mKeyWidthPx;
    /** The shape of the complete keyboard on this phone (width / height), with the height the person set for the keyboard. */
    private float mFullAspect = 1f;

    /** What the theme takes from the background under it (the tone of the ink, of the dash and of the clear glass: {@link MrAdapt}), made once for the same background and look. */
    private MrAdapt.Tone mTone = MrAdapt.Tone.OFF;
    private String mToneKey;
    private MrKeyLook mToneLook;

    private Bitmap mBg;
    private String mBgKey;
    private Drawable mFace, mAccent;
    private String mFaceTag;
    private MrKeyLook mFacesLook;
    private int mDrawn;
    /** The "add a picture" tile: a plain face with a plus, not a keyboard. */
    private boolean mPlus;
    private int mPlusFill, mPlusLine, mPlusInk;
    /**
     * The gradient themes (the roles spectrum_*, as the keyboard has them): the hue the key drawables are written in, the three hues the keyboard turns
     * through, the filters of the faces made once for each step, and the area of the keys that the position of a key is taken in. 0 in mFrom: no gradient.
     */
    private int mFrom, mStart, mMid, mEnd;
    private float[][] mMatrix;
    private android.graphics.ColorFilter[] mFilter;
    private float mAreaW, mAreaTop, mAreaH;
    private float[] mCurrent;       // the matrix of the key being drawn; null = the theme's own colours
    private android.graphics.ColorFilter mCurrentFilter;
    private int mCurrentHue;        // its hue, opaque

    MrThemePreview(Context c) {
        super(c);
        mDensity = c.getResources().getDisplayMetrics().density;
        // the keyboard is as wide as the narrow side of the screen (the screen handles its own turns, so this does not change while it is open)
        android.util.DisplayMetrics dm = c.getResources().getDisplayMetrics();
        mKeyWidthPx = Math.min(dm.widthPixels, dm.heightPixels);
        mFullAspect = fullAspect(c);
    }

    // ---- the shape of the complete keyboard

    /** Height, in pixels, of the real keyboard (the toolbar and the rows of keys) on a screen {@code screenHeightPx} tall, with {@code percent} for the keys. */
    static float fullHeight(float screenHeightPx, float density, int percent) {
        return BAR_DP * density + screenHeightPx * percent / 100f;
    }

    /** Width over height of the real keyboard: as wide as {@code widthPx} and as tall as {@link #fullHeight} says. */
    static float fullAspect(float widthPx, float screenHeightPx, float density, int percent) {
        return widthPx / fullHeight(screenHeightPx, density, percent);
    }

    /**
     * The shape (width over height) of the complete keyboard on this phone, as the person set its height: the narrow side of the screen is its width
     * (the keyboard of a phone held upright) and the long side the screen it takes the share from. The frame of the gallery has the same shape, so that
     * what it frames is what the keyboard shows.
     */
    static float fullAspect(Context c) {
        try {
            android.util.DisplayMetrics dm = c.getResources().getDisplayMetrics();
            float density = dm.density > 0f ? dm.density : 1f;
            float a = fullAspect(Math.min(dm.widthPixels, dm.heightPixels), Math.max(dm.widthPixels, dm.heightPixels), density, heightPercent(c));
            return a > 0f ? a : 1f;
        } catch (RuntimeException e) {
            return 1f;
        }
    }

    /** The share of the screen height that the person gave the keyboard held upright (15 .. 75; {@link #HEIGHT_DEFAULT} when it was not set). */
    static int heightPercent(Context c) {
        float v = HEIGHT_DEFAULT;
        try {
            android.content.SharedPreferences sp = android.preference.PreferenceManager.getDefaultSharedPreferences(c);
            String text = null;
            try {
                text = sp.getString(PREF_HEIGHT, null);
            } catch (ClassCastException e) {
                v = sp.getInt(PREF_HEIGHT, HEIGHT_DEFAULT);
            }
            if (text != null) {
                // the setting is kept as text ("34", or "34%" in the resources): the number at its start
                int end = 0;
                while (end < text.length() && (Character.isDigit(text.charAt(end)) || text.charAt(end) == '.')) end++;
                if (end > 0) v = Float.parseFloat(text.substring(0, end));
            }
        } catch (RuntimeException e) {
            v = HEIGHT_DEFAULT;
        }
        return Math.max(HEIGHT_MIN, Math.min(HEIGHT_MAX, Math.round(v)));
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

    /** The tuning of the keys to draw with (null = none): the opacity of the face and of the line, the colour of the letters, the colour of the person's own styles. Draws again. */
    void setLook(MrKeyLook look) {
        mLook = look == null ? MrKeyLook.NONE : look;
        invalidate();
    }

    /** What the keys are drawn with (test help). */
    MrKeyLook look() {
        return mLook;
    }

    /** Whether the tuning counts here: only for a theme of the backgrounds. */
    private boolean tuned() {
        return MrThemeColors.hidden(mTag);
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
        setMeasuredDimension(w, Math.round(w / (mFull ? mFullAspect : MrBackdrop.ASPECT)));
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
        float vh = vw / (mFull ? mFullAspect : MrBackdrop.ASPECT);
        float s = w / vw;
        canvas.save();
        canvas.scale(s, s);
        if (mFull) {
            toolbar(canvas, c, vw);
            fullKeys(canvas, c, vw, vh);
        } else {
            bar(canvas, c, vw, vh, BAR_SHARE);
            keys(canvas, c, vw, vh);
        }
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
        canvas.drawBitmap(mBg, new Rect(0, 0, w, h), new Rect(0, 0, w, h), mBgPaint);
    }

    /** The gap that the face of a key keeps round it, in dp (the first row of keys starts this much under the line of suggestions). */
    static final float FACE_GAP_DP = 3f;
    /** The space between two of the bars of the line of suggestions, as a share of the width. */
    static final float WORD_GAP = 0.11f;

    /**
     * The line of suggestions: three bars of the ink of the toolbar, between thin dividers. The group is centred in the width of the keyboard (the same
     * margin on both sides) and in the height between the top of the keyboard and the top of the first row of keys (the face of a key keeps a small gap).
     */
    private void bar(Canvas canvas, Context c, float vw, float vh, float share) {
        int ink = ink(c);
        float bottom = vh * share;
        float cy = (bottom + FACE_GAP_DP * mDensity) / 2f;
        float bh = bottom * 0.22f;
        float sum = WORD_GAP * vw * (WORDS.length - 1);
        for (float f : WORDS) sum += f * vw;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        float x = (vw - sum) / 2f;
        for (int i = 0; i < WORDS.length; i++) {
            float bw = vw * WORDS[i];
            mPaint.setColor(withAlpha(ink, 0.70f));
            canvas.drawRoundRect(x, cy - bh / 2f, x + bw, cy + bh / 2f, bh / 2f, bh / 2f, mPaint);
            x += bw + vw * WORD_GAP;
            if (i < WORDS.length - 1) {
                mPaint.setColor(withAlpha(ink, 0.25f));
                canvas.drawRect(x - vw * WORD_GAP / 2f - 1f, cy - bottom * 0.22f, x - vw * WORD_GAP / 2f + 1f, cy + bottom * 0.22f, mPaint);
            }
        }
    }

    /** The ink of the toolbar (its icons and its text): the colour that the person chose for them on a theme of the backgrounds, else the theme's (in the tone of the background). */
    private int ink(Context c) {
        if (!tuned()) return MrThemeColors.ink(c, mTag);
        return mLook.text != 0 ? mLook.text : tone(c).ink(MrThemeColors.ink(c, mTag));
    }

    /** The colour of the role {@code role} of the theme, the ink of a background in its tone (the colour that the person chose for the letters is applied by the callers). */
    private int text(Context c, String role, int fallback) {
        int v = MrThemeColors.colorOr(c, mTag, role, fallback);
        return tuned() ? tone(c).ink(v) : v;
    }

    /**
     * What the keyboard on a background takes from it, as {@link MrAdapt} works it out for the one on the screen: the tone of the keys or, when they have
     * none, of the colour that stands out in the background. {@link MrAdapt.Tone#OFF} when there is no background (or a theme of the list).
     */
    MrAdapt.Tone tone(Context c) {
        if (!tuned() || mSpec.kind == MrBackdrop.NONE || (MrBackdrop.needsBitmap(mSpec) && mImage == null)) return MrAdapt.Tone.OFF;
        String key = mTag + "|" + mSpec.format() + "|" + mSoft + "|" + System.identityHashCode(mImage);
        if (mToneKey != null && key.equals(mToneKey) && mToneLook == mLook) return mTone;
        MrAdapt.Tone t = MrAdapt.Tone.OFF;
        try {
            boolean dark = MrThemeColors.dark(c, mTag);
            MrBackdrop.Look bg = MrBackdrop.look(mSpec, mImage, dark, mSoft);
            if (bg != null) {
                boolean spectrum = MrBackdrop.isOwn(mTag) || MrThemeColors.own(c, mTag, "spectrum_start") != 0;
                t = MrAdapt.Tone.of(MrAdapt.base(MrAdapt.keyColour(mTag, mLook), bg.accent, bg.bottom), !dark, spectrum, MrBackdrop.TAG_LIGHT_INK.equals(mTag), bg.bottom);
            }
        } catch (RuntimeException e) {
            // no tone: the theme's own colours
        }
        mTone = t;
        mToneKey = key;
        mToneLook = mLook;
        return t;
    }

    private Drawable[] mToolIcons;
    private Drawable mToolbarKeyIcon;

    /** The drawable called {@code name} (a copy, so that tinting it does not touch the shared one); null when there is none. */
    private static Drawable icon(Context c, String name) {
        try {
            int id = c.getResources().getIdentifier(name, "drawable", c.getPackageName());
            return id == 0 ? null : face(c, id);
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** {@code d} (null: a small square outline, so that the place of the icon shows) drawn in {@code ink} at the size {@link #TOOL_ICON_DP}, centred at ({@code cx}, {@code cy}). */
    private void iconAt(Canvas canvas, Drawable d, int ink, float cx, float cy) {
        float side = TOOL_ICON_DP * mDensity;
        if (d == null) {
            mPaint.setShader(null);
            mPaint.setStyle(Paint.Style.STROKE);
            mPaint.setStrokeWidth(Math.max(1f, mDensity));
            mPaint.setColor(withAlpha(ink, 0.70f));
            float r = side * 0.3f;
            canvas.drawRoundRect(cx - r, cy - r, cx + r, cy + r, r / 3f, r / 3f, mPaint);
            mPaint.setStyle(Paint.Style.FILL);
            return;
        }
        d.setBounds(Math.round(cx - side / 2f), Math.round(cy - side / 2f), Math.round(cx + side / 2f), Math.round(cy + side / 2f));
        d.setColorFilter(new android.graphics.PorterDuffColorFilter(ink, android.graphics.PorterDuff.Mode.SRC_IN));
        d.draw(canvas);
        d.setColorFilter(null);
    }

    /**
     * The toolbar of the real keyboard: its eight buttons ({@link #TOOL_ICONS}) side by side, each as wide as the others (as the layout gives them), with
     * its icon in the ink of the toolbar, in the 48 dp the real one has at the top.
     */
    private void toolbar(Canvas canvas, Context c, float vw) {
        if (mToolIcons == null) {
            mToolIcons = new Drawable[TOOL_ICONS.length];
            for (int i = 0; i < TOOL_ICONS.length; i++) mToolIcons[i] = icon(c, TOOL_ICONS[i]);
        }
        int ink = ink(c);
        float pad = 4f * mDensity, bar = BAR_DP * mDensity;
        float cell = (vw - 2f * pad) / TOOL_ICONS.length;
        for (int i = 0; i < TOOL_ICONS.length; i++) {
            iconAt(canvas, mToolIcons[i], ink, pad + cell * (i + 0.5f), bar / 2f);
        }
    }

    /** The rows of keys of the small keyboard of a card: the row of Ctrl, Alt and the arrows, the three rows of letters and the bottom row. */
    static final int SMALL_ROWS = 5;

    private void keys(Canvas canvas, Context c, float vw, float vh) {
        faces(c);
        float top = vh * BAR_SHARE;
        area(vw, top, vh);
        float side = vw * 0.008f;
        float rowH = (vh - top) / SMALL_ROWS;
        float unit = (vw - 2f * side) / 10f;
        int text = text(c, "text", 0xffffffff);
        int accentText = text(c, "accent_text", text);
        if (tuned() && mLook.text != 0) text = accentText = mLook.text;
        // the neon themes light up their labels
        int glow = MrThemeColors.declared(c, mTag, "glow");
        float glowPx = glow == 0 ? 0f : 5f * mDensity;
        float letter = rowH * 0.42f, word = rowH * 0.30f;
        mText.setTextAlign(Paint.Align.CENTER);
        mText.setTextSize(letter);
        // the row of Ctrl, Alt, Tab and the arrows, over the letters as in the keyboard
        modRow(canvas, side, top, vw - 2f * side, rowH, text, accentText, glow, glowPx, letter, word);
        mText.setTextSize(letter);
        for (int r = 0; r < 4; r++) {
            float y = top + (r + 1) * rowH;
            if (r < 3) {
                String letters = ROWS[r];
                float rowW = letters.length() * unit;
                float left = side + (10f * unit - rowW) / 2f;
                if (r == 2) {
                    // shift and delete at the ends, as wide as the room that the seven letters leave
                    float edge = (10f * unit - rowW) / 2f - unit * 0.1f;
                    key(canvas, side, y, edge, rowH, false, "\u21e7", text, glow, glowPx);
                    key(canvas, side + 10f * unit - edge, y, edge, rowH, false, "\u232b", text, glow, glowPx);
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
                key(canvas, x, y, e, rowH, true, "\u23ce", accentText, glow, glowPx);
            }
        }
    }

    /** The row of the toolbar key (the top row of the layout): its keys, as wide as the layout gives them, which of them are highlight keys and what the others say. */
    private static final float[] TOP_WIDTHS = {10.2f, 10.2f, 10.2f, 10.2f, 10.2f, 13.1f, 13.1f, 13.1f, 10.2f};
    private static final String[] TOP_LABELS = {"", "-", "=", "=>", "/", "\u21e4", "\u2191", "\u21e5", "("};
    private static final boolean[] TOP_KEYS = {true, false, false, false, false, true, true, true, false};
    /** The drawable of the key at the start of the top row (the one that opens the toolbar), and those of the eight buttons of the toolbar. */
    static final String TOOLBAR_KEY_ICON = "sym_keyboard_mr_toolbar";
    static final String[] TOOL_ICONS = {"ic_mr_clip", "ic_mr_trans", "ic_mr_aied", "ic_mr_attach", "ic_mr_fonts", "ic_mr_emote", "ic_mr_sheets", "ic_mr_tune"};
    /** Size of an icon of the toolbar, in dp. */
    static final float TOOL_ICON_DP = 24f;

    /** The widths of the keys of the row of Ctrl, Alt and the arrows (share of the width, as the layout of the keyboard gives them) and what they say. */
    private static final float[] MOD_WIDTHS = {14.2f, 13.2f, 13.3f, 10.2f, 13.1f, 13.1f, 13.1f, 10.2f};
    private static final String[] MOD_LABELS = {"Ctrl", "Alt", "\u21b9", "<>", "\u2190", "\u2193", "\u2192", "{"};
    /** Which of them are modifier keys (the highlight ones, with a dash). */
    private static final boolean[] MOD_KEYS = {true, true, true, false, true, true, true, false};

    /**
     * The row of Ctrl, Alt, Tab and the arrows at ({@code x}, {@code y}), {@code width} wide: the keys as wide as the layout gives them. The dash of the
     * modifier keys (off) is under Ctrl and Alt only (Tab and the arrows have none). The size of the letters is left at {@code word} or {@code letter}.
     */
    private void modRow(Canvas canvas, float x, float y, float width, float rowH, int text, int accentText, int glow, float glowPx, float letter, float word) {
        float sum = 0f;
        for (float f : MOD_WIDTHS) sum += f;
        for (int i = 0; i < MOD_WIDTHS.length; i++) {
            float kw = width * MOD_WIDTHS[i] / sum;
            boolean mod = MOD_KEYS[i];
            String label = MOD_LABELS[i];
            key(canvas, x, y, kw, rowH, mod, label, mod ? accentText : text, glow, glowPx,
                    FACE_NORMAL, i < 2 ? DASH_OFF : DASH_NONE, label.length() > 1 && mod && i < 2 ? word : letter);
            x += kw;
        }
    }

    /**
     * The complete keyboard under the toolbar, at rest as the real one is when it opens: the seven rows of keys, each with the face of its kind (the row of
     * the toolbar key, the row of Ctrl, Alt and the arrows, the numbers, the three rows of letters and the bottom row). Only Ctrl, Alt and Shift have the dash
     * of the modifier keys (off); nothing is lit or locked, because the keyboard shows a lit face only while a key is on. The rows share what the toolbar
     * and the space under the last row leave of the height, as the real ones do.
     */
    private void fullKeys(Canvas canvas, Context c, float vw, float vh) {
        faces(c);
        float top = BAR_DP * mDensity;
        area(vw, top, vh);
        float side = vw * 0.008f;
        float rowH = (vh - top - MrBottom.GAP_DP * mDensity) / FULL_ROWS;
        float width = vw - 2f * side;
        float unit = width / 10f;
        int text = text(c, "text", 0xffffffff);
        int accentText = text(c, "accent_text", text);
        if (tuned() && mLook.text != 0) text = accentText = mLook.text;
        int glow = MrThemeColors.declared(c, mTag, "glow");
        float glowPx = glow == 0 ? 0f : 5f * mDensity;
        float letter = rowH * 0.42f, word = rowH * 0.30f;
        mText.setTextAlign(Paint.Align.CENTER);
        // the row of the toolbar key (the first row): the key that opens the toolbar, the symbols and the keys that move the cursor
        float topSum = 0f;
        for (float f : TOP_WIDTHS) topSum += f;
        float tx = side;
        for (int i = 0; i < TOP_WIDTHS.length; i++) {
            float kw = width * TOP_WIDTHS[i] / topSum;
            boolean mod = TOP_KEYS[i];
            key(canvas, tx, top, kw, rowH, mod, TOP_LABELS[i], mod ? accentText : text, glow, glowPx, FACE_NORMAL, DASH_NONE, letter);
            if (i == 0) {
                if (mToolbarKeyIcon == null) mToolbarKeyIcon = icon(c, TOOLBAR_KEY_ICON);
                iconAt(canvas, mToolbarKeyIcon, accentText, tx + kw / 2f, top + rowH / 2f);
            }
            tx += kw;
        }
        top += rowH;
        // the row of Ctrl, Alt and the arrows
        modRow(canvas, side, top, width, rowH, text, accentText, glow, glowPx, letter, word);
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
                // Shift and delete, 15% of the width each, as the layout gives them (Shift is at rest and has the dash of the modifier keys)
                float edge = width * 0.15f;
                key(canvas, side, y, edge, rowH, true, "\u21e7", accentText, glow, glowPx, FACE_NORMAL, DASH_OFF, letter);
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
        float x = side;
        key(canvas, x, y, a, rowH, true, "123", accentText, glow, glowPx, FACE_NORMAL, DASH_NONE, word);
        x += a;
        key(canvas, x, y, b, rowH, true, "F1", accentText, glow, glowPx, FACE_NORMAL, DASH_NONE, word);
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
        // on a gradient theme every key has the hue of its place, as on the keyboard: the face, the label, the dash and the light of the label
        spectrum(x, y, w, h);
        float[] m = mCurrent;
        if (m != null) {
            if (!(tuned() && mLook.text != 0)) ink = MrGlow.map(m, ink);
            if (glowPx > 0f) glow = (glow & 0xff000000) | (mCurrentHue & 0xffffff);
        }
        canvas.save();
        canvas.translate(x, y);
        if (face != null) {
            face.setBounds(0, 0, iw, ih);
            // a key of the keyboard is "single" at rest (the selector then takes its resting face) and checkable when it is a modifier key
            face.setState(state == FACE_LOCK ? STATE_LOCK : state == FACE_ON ? STATE_ON : dash != DASH_NONE ? STATE_MOD : STATE_NORMAL);
            KeyStyle.prepare(face, iw, ih, getContext());
            boolean tune = tuned() && mLook.faceTuned();
            // the colour of the line that the person chose is drawn over the face, as the keyboard does (the line of the style goes away)
            android.graphics.ColorFilter whole = mCurrentFilter != null ? mCurrentFilter : tone(getContext()).seeFilter();      // the clear glass takes the tone
            MrGlow.drawFace(face, canvas, iw, ih, whole, tune ? opacityFilter(true) : null, tune ? opacityFilter(false) : null,
                    tuned() ? mLook.line : 0, mLook.lineAlpha(), mDensity);
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
        if (mCurrent != null && state != DASH_LOCK) {
            colour = MrGlow.map(mCurrent, colour);
            if (state == DASH_ON && tuned()) colour = tone(c).ink(colour);       // the white of the dash that is on takes the tone as the letters do
        } else if (state != DASH_LOCK && tuned()) {
            colour = tone(c).dash(colour);
        }
        if (state == DASH_OFF && tuned()) colour = MrKeyLook.dashOff(colour);     // the dash that is off is only a hint: faint on the backgrounds
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
        // the key styles of the backgrounds draw the face with a line of 1 dp (the role key_<state>_edge)
        int edge = MrThemeColors.own(c, mTag, (accent ? "key_acc_" : "key_") + name + "_edge");
        if (mCurrent != null) {
            fill = MrGlow.map(mCurrent, fill);
            lip = MrGlow.map(mCurrent, lip);
            edge = MrGlow.map(mCurrent, edge);
        }
        boolean seeThrough = lip == fill && (fill >>> 24) != 255;
        if (tuned()) {
            // the opacities that the person chose
            fill = MrGlow.scale(fill, mLook.key / 100f);
            lip = seeThrough ? fill : MrGlow.scale(lip, mLook.key / 100f);
            edge = edge == 0 ? 0 : MrGlow.scale(edge, mLook.edge / 100f);
            // the colour that the person chose for the line: the line is that colour, whatever the style has (or has not)
            if (mLook.line != 0) edge = MrGlow.fade(mLook.line, mLook.lineAlpha());
        }
        float gap = 3f * mDensity, r = 8f * mDensity;
        mPaint.setShader(null);
        mPaint.setStyle(Paint.Style.FILL);
        if (seeThrough) {
            // a see-through face has no lip: drawn twice it would be less see-through
            mPaint.setColor(fill);
            canvas.drawRoundRect(gap, gap, w - gap, h - gap, r, r, mPaint);
            if (edge != 0) {
                mPaint.setStyle(Paint.Style.STROKE);
                mPaint.setStrokeWidth(mDensity);
                mPaint.setColor(edge);
                canvas.drawRoundRect(gap, gap, w - gap, h - gap, r, r, mPaint);
                mPaint.setStyle(Paint.Style.FILL);
            }
            return;
        }
        mPaint.setColor(lip);
        canvas.drawRoundRect(gap, gap, w - gap, h - gap, r, r, mPaint);
        mPaint.setColor(fill);
        canvas.drawRoundRect(gap, gap, w - gap, h - gap - 2f * mDensity, r, r, mPaint);
    }

    /** The key faces of the theme: made once for each theme (the drawable is a copy, so that making it ready does not change the shared one). */
    private void faces(Context c) {
        boolean same = mFace != null && (mTag == null ? mFaceTag == null : mTag.equals(mFaceTag));
        if (!same) {
            mFaceTag = mTag;
            mFace = face(c, MrThemeColors.keyDrawable(c, mTag, false));
            mAccent = face(c, MrThemeColors.keyDrawable(c, mTag, true));
            mFacesLook = null;
        }
        if (same && mFacesLook == mLook) return;
        mFacesLook = mLook;
        mStart = MrThemeColors.own(c, mTag, "spectrum_start");
        mMid = MrThemeColors.own(c, mTag, "spectrum_mid");
        mEnd = MrThemeColors.own(c, mTag, "spectrum_end");
        int[] own = tuned() ? MrKeyLook.spectrum(mTag, mLook) : null;      // the styles of the person's own colour
        if (own != null) {
            mStart = own[0];
            mMid = own[1];
            mEnd = own[2];
        }
        mFrom = mStart == 0 ? 0 : MrThemeColors.own(c, mTag, "glow");
        mMatrix = mFrom == 0 ? null : new float[MrGlow.STEPS + 1][];
        mFilter = mFrom == 0 ? null : new android.graphics.ColorFilter[MrGlow.STEPS + 1];
    }

    /** The filter that gives a face its opacity ({@code fill}: of the fill, else of the line) and, on a gradient theme, the hue of the key being drawn. */
    private android.graphics.ColorFilter opacityFilter(boolean fill) {
        float k = (fill ? mLook.key : mLook.edge) / 100f;
        return MrGlow.filter(mCurrent != null ? mCurrent : tone(getContext()).see, k);
    }

    /** Where the keys are (the area under the line of suggestions): the position of a key in it gives its hue on a gradient theme. */
    private void area(float w, float top, float h) {
        mAreaW = w;
        mAreaTop = top;
        mAreaH = h - top;
    }

    /** Chooses the hue of the key at ({@code x}, {@code y}) of size {@code w} x {@code h} on a gradient theme (as the keyboard does): sets mCurrent, null on any other. */
    private void spectrum(float x, float y, float w, float h) {
        mCurrent = null;
        mCurrentFilter = null;
        if (mFrom == 0 || mMatrix == null) return;
        int step = MrGlow.step(x + w / 2f, y + h / 2f - mAreaTop, Math.round(mAreaW), Math.round(mAreaH));
        float[] m = mMatrix[step];
        int hue = MrGlow.ramp(mStart, mMid, mEnd, step / (float) MrGlow.STEPS);
        if (m == null) {
            m = MrGlow.remap(mFrom, hue);
            if (m == null) return;
            mMatrix[step] = m;
            mFilter[step] = MrGlow.filter(m);
        }
        mCurrent = m;
        mCurrentFilter = mFilter[step];
        mCurrentHue = hue;
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
