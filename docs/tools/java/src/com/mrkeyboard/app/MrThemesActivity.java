package com.mrkeyboard.app;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * "Keyboard theme": the screen that replaces the list of names. At the top the keyboard as it is now (the theme
 * with its background, drawn with its real keys); under it the themes, each one a small keyboard to touch, and the backgrounds: none (the colour
 * of the theme), the picture of the gallery, the landscapes and the gradients ({@link MrBackdrop}). The theme and the background are chosen
 * apart: every tile of the themes shows the background in use, and every tile of the backgrounds shows the theme in use, so what a touch gives is
 * what the tile shows.
 *
 * <p>A picture of the gallery is read once ({@link MrBackdrop#importImage}) and kept; it is moved by dragging the big keyboard and zoomed with a
 * slider. How much the background is softened is a slider too. Everything is in the
 * preferences that the keyboard reads: {@code pref_keyboard_layout} (the theme, as it always was), {@code pref_kbd_bg} and
 * {@code pref_kbd_bg_soft}. Nothing is kept here, so the screen can be made again at any time. The keys that change often (the zoom, the
 * position, the softening) are written when the finger lets go, not on every step, because the keyboard is made again at every write.
 */
public class MrThemesActivity extends Activity {
    static final String THEME_KEY = "pref_keyboard_layout";
    static final int COLUMNS = 3;
    static final int REQ_PICK = 71;
    /** The longest side of the small copy of the picture that the tiles show. */
    static final int THUMB_SIDE = 320;

    MrKit k;
    SharedPreferences mPrefs;
    String[] mTags = new String[0];
    String[] mNames = new String[0];
    /** What the theme preference holds for each theme (the same order). */
    String[] mValues = new String[0];
    int mTheme;
    MrBackdrop.Spec mSpec = MrBackdrop.Spec.NO;
    int mSoft;
    /** The picture of the gallery (to move and zoom on the big keyboard) and the small copy of it that the tiles show. */
    Bitmap mImage, mThumb;
    /** Bumped with every load of the picture, so that a slow one that comes late is let go. */
    int mLoad;

    MrThemePreview mBig;
    TextView mCaption;
    LinearLayout mEditor, mSoftBox;
    SeekBar mZoom, mSoftBar;
    TextView mZoomText, mSoftText, mRemove;
    final List<MrThemePreview> mThemeTiles = new ArrayList<MrThemePreview>();
    /** The tiles of the backgrounds, in the order they were made, each with what it stands for. */
    final List<MrThemePreview> mBgTiles = new ArrayList<MrThemePreview>();
    final List<MrBackdrop.Spec> mBgSpecs = new ArrayList<MrBackdrop.Spec>();
    /** The tile of the picture of the gallery (hidden while there is none). */
    MrThemePreview mMineTile;
    /** The finger on the big keyboard: where it was last. */
    float mLastX, mLastY;
    boolean mDragging;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        k = new MrKit(this);
        mPrefs = PreferenceManager.getDefaultSharedPreferences(this);
        mTags = MrThemeColors.tags(this);
        mNames = MrThemeColors.names(this);
        mValues = MrThemeColors.values(this);
        readPrefs();

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        LinearLayout col = k.column();
        col.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        col.addView(k.backHeader(k.t("mr_themes_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), k.wide(0));

        // the keyboard as it is now: to see the choice, and (with a picture) to drag
        mBig = new MrThemePreview(this);
        col.addView(mBig, k.wide(14));
        mBig.setOnTouchListener(new View.OnTouchListener() {
            public boolean onTouch(View v, MotionEvent e) {
                return drag(v, e);
            }
        });
        mCaption = k.label("", 14f, k.text2, false);
        mCaption.setGravity(Gravity.CENTER);
        col.addView(mCaption, k.wide(8));

        mEditor = k.panel();
        col.addView(mEditor, k.wide(12));
        mEditor.addView(k.label(k.t("mr_themes_drag"), 13f, k.text2, false), k.wide(0));
        LinearLayout zoomLine = k.row();
        mEditor.addView(zoomLine, k.wide(10));
        zoomLine.addView(k.label(k.t("mr_themes_zoom"), 16f, k.text, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        mZoomText = k.label("", 16f, k.text2, false);
        zoomLine.addView(mZoomText, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mZoom = new SeekBar(this);
        mZoom.setMax(MrBackdrop.ZOOM_MAX - MrBackdrop.ZOOM_MIN);
        mZoom.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                if (fromUser) zoomChanged(MrBackdrop.ZOOM_MIN + progress);
            }

            public void onStartTrackingTouch(SeekBar bar) {
            }

            public void onStopTrackingTouch(SeekBar bar) {
                saveSpec();
            }
        });
        mEditor.addView(mZoom, k.wide(6));

        mSoftBox = k.panel();
        col.addView(mSoftBox, k.wide(12));
        LinearLayout softLine = k.row();
        mSoftBox.addView(softLine, k.wide(0));
        softLine.addView(k.label(k.t("mr_themes_soften"), 16f, k.text, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        mSoftText = k.label("", 16f, k.text2, false);
        softLine.addView(mSoftText, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mSoftBar = new SeekBar(this);
        mSoftBar.setMax(MrBackdrop.MAX_SOFT);
        mSoftBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                if (fromUser) softChanged(progress);
            }

            public void onStartTrackingTouch(SeekBar bar) {
            }

            public void onStopTrackingTouch(SeekBar bar) {
                saveSoft();
            }
        });
        mSoftBox.addView(mSoftBar, k.wide(6));
        mSoftBox.addView(k.label(k.t("mr_themes_soften_hint"), 13f, k.text2, false), k.wide(4));

        // the themes
        col.addView(k.label(k.t("mr_themes_themes"), 16f, k.text2, true), k.wide(22));
        LinearLayout themes = k.column();
        col.addView(themes, k.wide(8));
        LinearLayout row = null;
        for (int i = 0; i < mTags.length; i++) {
            if (i % COLUMNS == 0) {
                row = tileRow(themes);
            }
            final int index = i;
            MrThemePreview p = new MrThemePreview(this);
            mThemeTiles.add(p);
            row.addView(tileBox(p, i < mNames.length ? mNames[i] : mTags[i], i % COLUMNS, new View.OnClickListener() {
                public void onClick(View v) {
                    chooseTheme(index);
                }
            }), tileParams(i % COLUMNS));
        }
        fillRow(row, mTags.length);

        // the backgrounds
        col.addView(k.label(k.t("mr_themes_backgrounds"), 16f, k.text2, true), k.wide(22));
        LinearLayout first = k.row();
        col.addView(first, k.wide(8));
        addBg(first, MrBackdrop.Spec.NO, k.t("mr_themes_none"), 0, false);
        addGallery(first);
        mMineTile = addBg(first, MrBackdrop.Spec.image(100, 0, 0, 0L), k.t("mr_themes_mine"), 2, false);

        col.addView(k.label(k.t("mr_themes_landscapes"), 16f, k.text2, true), k.wide(18));
        LinearLayout scenes = k.column();
        col.addView(scenes, k.wide(8));
        row = null;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            if (i % COLUMNS == 0) row = tileRow(scenes);
            addBg(row, MrBackdrop.Spec.scene(i), sceneName(this, i), i % COLUMNS, true);
        }
        fillRow(row, MrScenes.COUNT);

        col.addView(k.label(k.t("mr_themes_gradients"), 16f, k.text2, true), k.wide(18));
        LinearLayout gradients = k.column();
        col.addView(gradients, k.wide(8));
        row = null;
        for (int i = 0; i < MrBackdrop.GRADIENTS.length; i++) {
            if (i % COLUMNS == 0) row = tileRow(gradients);
            addBg(row, MrBackdrop.Spec.gradient(i), k.t("mr_themes_gradient", i + 1), i % COLUMNS, true);
        }
        fillRow(row, MrBackdrop.GRADIENTS.length);

        mRemove = k.button(k.t("mr_themes_remove"), false, new View.OnClickListener() {
            public void onClick(View v) {
                removeImage();
            }
        });
        col.addView(mRemove, k.wide(22));

        setContentView(scroll);
        refresh();
        loadImage();
    }

    @Override
    protected void onDestroy() {
        mLoad++;
        mImage = null;
        mThumb = null;
        super.onDestroy();
    }

    // ---- the tiles

    private LinearLayout tileRow(LinearLayout parent) {
        LinearLayout row = k.row();
        row.setGravity(Gravity.TOP);
        parent.addView(row, k.wide(parent.getChildCount() == 0 ? 0 : 10));
        return row;
    }

    private LinearLayout.LayoutParams tileParams(int column) {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        p.setMargins(column == 0 ? 0 : k.dp(5), 0, column == COLUMNS - 1 ? 0 : k.dp(5), 0);
        return p;
    }

    /** A row that does not end on a full line gets empty places, so that its tiles are as wide as the others. */
    private void fillRow(LinearLayout row, int count) {
        if (row == null) return;
        for (int c = count % COLUMNS; c != 0 && c < COLUMNS; c++) {
            View gap = new View(this);
            row.addView(gap, tileParams(c));
        }
    }

    /** A tile: the preview with its name under it (no name when {@code name} is null), touched to choose. */
    private LinearLayout tileBox(MrThemePreview p, String name, int column, View.OnClickListener l) {
        LinearLayout box = k.column();
        box.setClickable(true);
        box.setOnClickListener(l);
        box.setContentDescription(name);
        box.addView(p, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        if (name != null) {
            TextView t = k.label(name, 12f, k.text2, false);
            t.setGravity(Gravity.CENTER);
            t.setSingleLine(true);
            box.addView(t, k.wide(4));
        }
        return box;
    }

    /** The tile of a background. {@code captioned}: the name goes in the description only (landscapes and gradients are drawings, not words). */
    private MrThemePreview addBg(LinearLayout row, final MrBackdrop.Spec spec, String name, int column, boolean captioned) {
        MrThemePreview p = new MrThemePreview(this);
        mBgTiles.add(p);
        mBgSpecs.add(spec);
        LinearLayout box = tileBox(p, captioned ? null : name, column, new View.OnClickListener() {
            public void onClick(View v) {
                chooseBackground(spec);
            }
        });
        if (captioned) box.setContentDescription(name);
        row.addView(box, tileParams(column));
        return p;
    }

    /** The tile that opens the gallery. */
    private void addGallery(LinearLayout row) {
        MrThemePreview p = new MrThemePreview(this);
        p.showPlus(k.card, k.stroke, k.accent);
        row.addView(tileBox(p, k.t("mr_themes_gallery"), 1, new View.OnClickListener() {
            public void onClick(View v) {
                pick();
            }
        }), tileParams(1));
    }

    // ---- state

    /** Reads what the keyboard reads. */
    void readPrefs() {
        mSpec = MrBackdrop.current(this);
        mSoft = MrBackdrop.soft(this);
        mTheme = MrThemeColors.indexOf(mValues, mPrefs.getString(THEME_KEY, "0"));
    }

    String tag() {
        return mTheme < mTags.length ? mTags[mTheme] : null;
    }

    /** Draws everything again from the state: the big keyboard, the tiles that are chosen, the controls that apply. */
    void refresh() {
        String tag = tag();
        boolean image = mSpec.kind == MrBackdrop.IMAGE;
        mBig.show(tag, mSpec, mImage, mSoft);
        for (int i = 0; i < mThemeTiles.size(); i++) {
            MrThemePreview p = mThemeTiles.get(i);
            p.show(i < mTags.length ? mTags[i] : null, mSpec, mThumb, mSoft);
            p.setChecked(i == mTheme, k.accent, k.onAccent);
        }
        boolean mine = MrBackdrop.hasImage(this);
        for (int i = 0; i < mBgTiles.size(); i++) {
            MrThemePreview p = mBgTiles.get(i);
            MrBackdrop.Spec s = mBgSpecs.get(i);
            p.show(tag, s, mThumb, mSoft);
            p.setChecked(s.kind == mSpec.kind && (s.kind == MrBackdrop.NONE || s.kind == MrBackdrop.IMAGE || s.index == mSpec.index), k.accent, k.onAccent);
        }
        if (mMineTile != null) {
            View box = (View) mMineTile.getParent();
            if (box != null) box.setVisibility(mine ? View.VISIBLE : View.INVISIBLE);
        }
        mCaption.setText(caption());
        mEditor.setVisibility(image ? View.VISIBLE : View.GONE);
        mSoftBox.setVisibility(mSpec.kind == MrBackdrop.NONE ? View.GONE : View.VISIBLE);
        mZoom.setProgress(mSpec.zoom - MrBackdrop.ZOOM_MIN);
        mZoomText.setText((mSpec.zoom) + "%");
        mSoftBar.setProgress(mSoft);
        mSoftText.setText(mSoft + "%");
        mRemove.setVisibility(mine ? View.VISIBLE : View.GONE);
    }

    String caption() {
        String name = mTheme < mNames.length ? mNames[mTheme] : "";
        if (mSpec.kind == MrBackdrop.NONE) return name;
        return name + " · " + backgroundName(this, mSpec);
    }

    /** The name of the landscape {@code i}. */
    static String sceneName(Context c, int i) {
        String s = MrPacks.text(c, "mr_themes_scene_" + i);
        return s != null ? s : "";
    }

    /** The name of a background for the captions and the summary of the setting. */
    static String backgroundName(Context c, MrBackdrop.Spec spec) {
        String s;
        switch (spec.kind) {
            case MrBackdrop.GRADIENT: s = MrPacks.text(c, "mr_themes_gradient", spec.index + 1); break;
            case MrBackdrop.SCENE: s = sceneName(c, spec.index); break;
            case MrBackdrop.IMAGE: s = MrPacks.text(c, "mr_themes_mine"); break;
            default: s = MrPacks.text(c, "mr_themes_none"); break;
        }
        return s != null ? s : "";
    }

    // ---- choosing

    void chooseTheme(int index) {
        mTheme = index;
        mPrefs.edit().putString(THEME_KEY, index < mValues.length ? mValues[index] : String.valueOf(index)).apply();
        refresh();
    }

    void chooseBackground(MrBackdrop.Spec spec) {
        MrBackdrop.Spec next = spec;
        if (spec.kind == MrBackdrop.IMAGE) {
            // the picture keeps the zoom and the position it had; its time is the one of the file that is kept
            next = mSpec.kind == MrBackdrop.IMAGE ? mSpec : MrBackdrop.Spec.image(100, 0, 0, MrBackdrop.imageStamp(this));
        }
        mSpec = next;
        mPrefs.edit().putString(MrBackdrop.PREF, next.format()).apply();
        refresh();
    }

    void zoomChanged(int zoom) {
        mSpec = mSpec.moved(zoom, mSpec.dx, mSpec.dy);
        mBig.show(tag(), mSpec, mImage, mSoft);
        mZoomText.setText(mSpec.zoom + "%");
    }

    void softChanged(int percent) {
        mSoft = MrBackdrop.clamp(percent, 0, MrBackdrop.MAX_SOFT);
        mBig.show(tag(), mSpec, mImage, mSoft);
        mSoftText.setText(mSoft + "%");
    }

    /** The finger let go of the zoom or of the picture: the position is kept (the keyboard is made again once). */
    void saveSpec() {
        mPrefs.edit().putString(MrBackdrop.PREF, mSpec.format()).apply();
        refresh();
    }

    void saveSoft() {
        mPrefs.edit().putInt(MrBackdrop.PREF_SOFT, mSoft).apply();
        refresh();
    }

    /** The finger on the big keyboard moves the picture under it. */
    boolean drag(View v, MotionEvent e) {
        if (mSpec.kind != MrBackdrop.IMAGE || mImage == null) return false;
        int action = e.getActionMasked();
        if (action == MotionEvent.ACTION_DOWN) {
            mLastX = e.getX();
            mLastY = e.getY();
            mDragging = true;
            ViewParent parent = v.getParent();
            if (parent != null) parent.requestDisallowInterceptTouchEvent(true);
            return true;
        }
        if (!mDragging) return false;
        if (action == MotionEvent.ACTION_MOVE) {
            int[] now = MrBackdrop.pan(mImage.getWidth(), mImage.getHeight(), v.getWidth(), v.getHeight(), mSpec.zoom, mSpec.dx, mSpec.dy,
                    e.getX() - mLastX, e.getY() - mLastY);
            mLastX = e.getX();
            mLastY = e.getY();
            mSpec = mSpec.moved(mSpec.zoom, now[0], now[1]);
            mBig.show(tag(), mSpec, mImage, mSoft);
            return true;
        }
        if (action == MotionEvent.ACTION_UP || action == MotionEvent.ACTION_CANCEL) {
            mDragging = false;
            saveSpec();
            return true;
        }
        return false;
    }

    // ---- the picture of the gallery

    void pick() {
        try {
            Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
            i.addCategory(Intent.CATEGORY_OPENABLE);
            i.setType("image/*");
            startActivityForResult(i, REQ_PICK);
        } catch (ActivityNotFoundException e) {
            k.toast(k.t("mr_themes_image_failed"));
        } catch (RuntimeException e) {
            k.toast(k.t("mr_themes_image_failed"));
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != REQ_PICK || resultCode != RESULT_OK || data == null) return;
        final Uri uri = data.getData();
        if (uri == null) return;
        // a photo is decoded and written: not on the main thread
        new Thread(new Runnable() {
            public void run() {
                int[] size = null;
                try {
                    InputStream in = getContentResolver().openInputStream(uri);
                    if (in != null) {
                        try {
                            size = MrBackdrop.importImage(MrThemesActivity.this, in);
                        } finally {
                            in.close();
                        }
                    }
                } catch (Exception e) {
                    size = null;
                }
                final boolean ok = size != null;
                runOnUiThread(new Runnable() {
                    public void run() {
                        imported(ok);
                    }
                });
            }
        }).start();
    }

    /** The picture was read (or not): it becomes the background, centred and not zoomed. */
    void imported(boolean ok) {
        if (isFinishing()) return;
        if (!ok) {
            k.toast(k.t("mr_themes_image_failed"));
            return;
        }
        mSpec = MrBackdrop.Spec.image(100, 0, 0, System.currentTimeMillis());
        mPrefs.edit().putString(MrBackdrop.PREF, mSpec.format()).apply();
        loadImage();
        refresh();
    }

    void removeImage() {
        MrBackdrop.removeImage(this);
        if (mSpec.kind == MrBackdrop.IMAGE) {
            mSpec = MrBackdrop.Spec.NO;
            mPrefs.edit().putString(MrBackdrop.PREF, "").apply();
        }
        mImage = null;
        mThumb = null;
        refresh();
    }

    /** Reads the picture (and makes its small copy) apart from the main thread, and draws again when it is there. */
    void loadImage() {
        if (!MrBackdrop.hasImage(this)) {
            mImage = null;
            mThumb = null;
            return;
        }
        final int load = ++mLoad;
        new Thread(new Runnable() {
            public void run() {
                final Bitmap big = MrBackdrop.load(MrThemesActivity.this);
                final Bitmap small = big == null ? null : thumb(big);
                runOnUiThread(new Runnable() {
                    public void run() {
                        if (load != mLoad || isFinishing()) return;
                        mImage = big;
                        mThumb = small;
                        refresh();
                    }
                });
            }
        }).start();
    }

    /** The small copy of a picture for the tiles. */
    static Bitmap thumb(Bitmap big) {
        int longest = Math.max(big.getWidth(), big.getHeight());
        if (longest <= THUMB_SIDE) return big;
        float f = THUMB_SIDE / (float) longest;
        return Bitmap.createScaledBitmap(big, Math.max(1, Math.round(big.getWidth() * f)), Math.max(1, Math.round(big.getHeight() * f)), true);
    }
}
