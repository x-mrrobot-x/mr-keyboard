package com.mrkeyboard.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * "Keyboard theme": the screen that replaces the list of names. At the top the keyboard as it is now, under it the themes, each one a small keyboard to
 * touch, and under them the colours, the gradients, the landscapes and the pictures of the gallery ({@link MrBackdrop}).
 *
 * <p>A theme and a background are never mixed. A touch on a theme is the choice: it is written at once and the background goes away. A touch on a
 * background opens a dialog with the keyboard as it will look, and only "Apply" writes it (the keyboard is then in one of the two themes of the
 * backgrounds: flat, see-through keys with light or dark ink). Only the keyboard at the top shows the choice in use; the tiles of the themes always
 * show the themes as they are.
 *
 * <p>A picture of the gallery is chosen with the photo picker of the system ({@link #pickers}) and read once into a waiting file
 * ({@link MrBackdrop#importPending}); a dialog shows it with the frame of the keyboard over it, to drag and to pinch ({@link MrCropView}), with
 * the softening of the background under it; "Next" shows the keyboard as it will look and "Apply" makes the waiting picture the background. A picture
 * that is not applied costs the one that was there nothing. Everything is in the preferences that the keyboard reads: {@code pref_keyboard_layout}
 * (the theme), {@code pref_kbd_bg} and {@code pref_kbd_bg_soft}. Nothing else is kept here, so the screen can be made again at any time.
 */
public class MrThemesActivity extends Activity {
    static final String THEME_KEY = "pref_keyboard_layout";
    static final int COLUMNS = 3;
    static final int REQ_PICK = 71;
    /** The longest side of the small copy of the picture that the tiles show. */
    static final int THUMB_SIDE = 320;
    /** The photo picker of Android 13 (and of the phones that got it later through the system updates). */
    static final String ACTION_PICK_IMAGES = "android.provider.action.PICK_IMAGES";
    static final String IMAGES_URI = "content://media/external/images/media";

    MrKit k;
    SharedPreferences mPrefs;
    String[] mTags = new String[0];
    String[] mNames = new String[0];
    /** What the theme preference holds for each theme (the same order). */
    String[] mValues = new String[0];
    /** How many themes the screen lists (the themes of the backgrounds come after them). */
    int mListed;
    int mTheme;
    /** The background in use: none unless the keyboard is in one of the themes of the backgrounds. */
    MrBackdrop.Spec mSpec = MrBackdrop.Spec.NO;
    int mSoft;
    /** The picture of the gallery that is the background (for the big keyboard and for the crop) and the small copy of it that the tiles show. */
    Bitmap mImage, mThumb;
    /** Bumped with every load of the picture, so that a slow one that comes late is let go. */
    int mLoad;
    /** The small copies of the landscapes that the tiles show (null until each one is read), and the whole one that the big keyboard shows. */
    final Bitmap[] mScenes = new Bitmap[MrScenes.COUNT];
    Bitmap mBigScene;
    int mBigSceneIndex = -1;
    /** The landscapes are read in halves of their size for the tiles. */
    static final int SCENE_SAMPLE = 2;

    MrThemePreview mBig;
    TextView mCaption;
    TextView mRemove;
    final List<MrThemePreview> mThemeTiles = new ArrayList<MrThemePreview>();
    /** The tiles of the backgrounds, in the order they were made, each with what it stands for. */
    final List<MrThemePreview> mBgTiles = new ArrayList<MrThemePreview>();
    final List<MrBackdrop.Spec> mBgSpecs = new ArrayList<MrBackdrop.Spec>();
    /** The tile of the picture of the gallery (hidden while there is none). */
    MrThemePreview mMineTile;

    /** The dialog that is open (the preview or the crop), and what is in it. */
    Dialog mDialog;
    MrThemePreview mDialogPreview;
    MrCropView mDialogCrop;
    SeekBar mDialogSoft;
    TextView mDialogApply, mDialogCancel, mDialogNext;

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
        mListed = MrThemeColors.listed(mTags);
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

        // the keyboard as it is now: the only place that shows the choice in use
        mBig = new MrThemePreview(this);
        col.addView(mBig, k.wide(14));
        mCaption = k.label("", 14f, k.text2, false);
        mCaption.setGravity(Gravity.CENTER);
        col.addView(mCaption, k.wide(8));

        // the themes
        col.addView(k.label(k.t("mr_themes_themes"), 16f, k.text2, true), k.wide(22));
        LinearLayout themes = k.column();
        col.addView(themes, k.wide(8));
        LinearLayout row = null;
        for (int i = 0; i < mListed; i++) {
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
        fillRow(row, mListed);

        // the backgrounds: colours, gradients, landscapes (drawings: the name goes in the description only), and the gallery
        col.addView(k.label(k.t("mr_themes_colors"), 16f, k.text2, true), k.wide(22));
        LinearLayout colours = k.column();
        col.addView(colours, k.wide(8));
        row = null;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            if (i % COLUMNS == 0) row = tileRow(colours);
            addBg(row, MrBackdrop.Spec.color(i), k.t("mr_themes_color", i + 1), i % COLUMNS);
        }
        fillRow(row, MrBackdrop.COLORS.length);

        col.addView(k.label(k.t("mr_themes_gradients"), 16f, k.text2, true), k.wide(18));
        LinearLayout gradients = k.column();
        col.addView(gradients, k.wide(8));
        row = null;
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) {
            if (i % COLUMNS == 0) row = tileRow(gradients);
            addBg(row, MrBackdrop.Spec.gradient(i), k.t("mr_themes_gradient", i + 1), i % COLUMNS);
        }
        fillRow(row, MrBackdrop.GRADIENT_COUNT);

        // the landscapes: six categories of six pictures (the pictures are not words: the name goes in the description only)
        col.addView(k.label(k.t("mr_themes_landscapes"), 16f, k.text2, true), k.wide(18));
        for (int cat = 0; cat < MrScenes.CATEGORIES; cat++) {
            col.addView(k.label(categoryName(this, cat), 14f, k.text2, false), k.wide(cat == 0 ? 8 : 14));
            LinearLayout scenes = k.column();
            col.addView(scenes, k.wide(6));
            row = null;
            for (int n = 0; n < MrScenes.PER_CATEGORY; n++) {
                int i = MrScenes.scene(cat, n);
                if (n % COLUMNS == 0) row = tileRow(scenes);
                addBg(row, MrBackdrop.Spec.scene(i), sceneName(this, i), n % COLUMNS);
            }
            fillRow(row, MrScenes.PER_CATEGORY);
        }

        col.addView(k.label(k.t("mr_themes_gallery"), 16f, k.text2, true), k.wide(18));
        LinearLayout gallery = k.row();
        gallery.setGravity(Gravity.TOP);
        col.addView(gallery, k.wide(8));
        addGallery(gallery);
        mMineTile = addMine(gallery);
        View gap = new View(this);
        gallery.addView(gap, tileParams(2));

        mRemove = k.button(k.t("mr_themes_remove"), false, new View.OnClickListener() {
            public void onClick(View v) {
                removeImage();
            }
        });
        col.addView(mRemove, k.wide(22));

        setContentView(scroll);
        refresh();
        loadImage();
        loadScenes();
    }

    @Override
    protected void onDestroy() {
        mLoad++;
        closeDialog();
        // a picture that was chosen and not applied is let go of
        MrBackdrop.discardPending(this);
        mImage = null;
        mThumb = null;
        mBigScene = null;
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
        return box;
    }

    /** The tile of a background (a drawing, not words: its name is the description for the screen readers). */
    private MrThemePreview addBg(LinearLayout row, final MrBackdrop.Spec spec, String name, int column) {
        MrThemePreview p = new MrThemePreview(this);
        mBgTiles.add(p);
        mBgSpecs.add(spec);
        row.addView(tileBox(p, name, column, new View.OnClickListener() {
            public void onClick(View v) {
                openBackdrop(spec);
            }
        }), tileParams(column));
        return p;
    }

    /** The tile that opens the photo picker. */
    private void addGallery(LinearLayout row) {
        MrThemePreview p = new MrThemePreview(this);
        p.showPlus(k.card, k.stroke, k.accent);
        row.addView(tileBox(p, k.t("mr_themes_gallery"), 0, new View.OnClickListener() {
            public void onClick(View v) {
                pick();
            }
        }), tileParams(0));
    }

    /** The tile of the picture that is kept: it opens the crop again. */
    private MrThemePreview addMine(LinearLayout row) {
        MrThemePreview p = new MrThemePreview(this);
        final MrBackdrop.Spec spec = MrBackdrop.Spec.image(100, 0, 0, 0L);
        mBgTiles.add(p);
        mBgSpecs.add(spec);
        row.addView(tileBox(p, k.t("mr_themes_mine"), 1, new View.OnClickListener() {
            public void onClick(View v) {
                editImage();
            }
        }), tileParams(1));
        return p;
    }

    // ---- state

    /** Reads what the keyboard reads. */
    void readPrefs() {
        mTheme = MrThemeColors.indexOf(mValues, mPrefs.getString(THEME_KEY, "0"));
        // a background counts only in the themes of the backgrounds: in any other theme an old value of the preference is let be
        boolean inBackdropTheme = mTheme < mTags.length && MrThemeColors.hidden(mTags[mTheme]);
        mSpec = inBackdropTheme ? MrBackdrop.current(this) : MrBackdrop.Spec.NO;
        mSoft = MrBackdrop.soft(this);
    }

    String tag() {
        return mTheme < mTags.length ? mTags[mTheme] : null;
    }

    /** The spec that a tile of the backgrounds stands for now: the picture keeps the zoom and the position it has when it is the one in use. */
    MrBackdrop.Spec tileSpec(MrBackdrop.Spec s) {
        return s.kind == MrBackdrop.IMAGE && mSpec.kind == MrBackdrop.IMAGE ? mSpec : s;
    }

    /** The small picture that a tile of the backgrounds shows: the copy of the picture of the gallery or of the landscape (null while it is being read). */
    Bitmap tileImage(MrBackdrop.Spec s) {
        if (s.kind == MrBackdrop.IMAGE) return mThumb;
        if (s.kind == MrBackdrop.SCENE && s.index >= 0 && s.index < mScenes.length) return mScenes[s.index];
        return null;
    }

    /** The picture that the big keyboard shows for a background: the one of the gallery, or the landscape as it is (read when it is asked for). */
    Bitmap bigImage(MrBackdrop.Spec s) {
        if (s.kind == MrBackdrop.IMAGE) return mImage;
        if (s.kind == MrBackdrop.SCENE) {
            if (mBigScene == null || mBigSceneIndex != s.index) {
                mBigScene = MrScenes.load(this, s.index);
                mBigSceneIndex = s.index;
            }
            return mBigScene;
        }
        return null;
    }

    /** Draws everything again from the state: the big keyboard, the tiles that are chosen, the controls that apply. */
    void refresh() {
        mBig.show(tag(), mSpec, bigImage(mSpec), mSoft);
        for (int i = 0; i < mThemeTiles.size(); i++) {
            MrThemePreview p = mThemeTiles.get(i);
            p.show(mTags[i], MrBackdrop.Spec.NO, null, 0);
            p.setChecked(mSpec.kind == MrBackdrop.NONE && i == mTheme, k.accent, k.onAccent);
        }
        boolean mine = MrBackdrop.hasImage(this);
        for (int i = 0; i < mBgTiles.size(); i++) {
            MrThemePreview p = mBgTiles.get(i);
            MrBackdrop.Spec s = tileSpec(mBgSpecs.get(i));
            p.show(MrBackdrop.themeTag(s), s, tileImage(s), s.kind == MrBackdrop.IMAGE ? mSoft : 0);
            p.setChecked(mSpec.kind != MrBackdrop.NONE && s.kind == mSpec.kind && (s.kind == MrBackdrop.IMAGE || s.index == mSpec.index), k.accent, k.onAccent);
        }
        if (mMineTile != null) {
            View box = (View) mMineTile.getParent();
            if (box != null) box.setVisibility(mine ? View.VISIBLE : View.INVISIBLE);
        }
        mCaption.setText(caption());
        mRemove.setVisibility(mine ? View.VISIBLE : View.GONE);
    }

    String caption() {
        if (mSpec.kind != MrBackdrop.NONE) return backgroundName(this, mSpec);
        return mTheme < mListed && mTheme < mNames.length ? mNames[mTheme] : "";
    }

    /** The name of the landscape {@code i}. */
    static String sceneName(Context c, int i) {
        String s = MrPacks.text(c, "mr_themes_scene_" + i);
        return s != null ? s : "";
    }

    /** The name of the category {@code cat} of the landscapes. */
    static String categoryName(Context c, int cat) {
        String s = MrPacks.text(c, "mr_themes_scene_cat_" + cat);
        return s != null ? s : "";
    }

    /** The name of a background for the captions and the summary of the setting. */
    static String backgroundName(Context c, MrBackdrop.Spec spec) {
        String s;
        switch (spec.kind) {
            case MrBackdrop.COLOR: s = MrPacks.text(c, "mr_themes_color", spec.index + 1); break;
            case MrBackdrop.GRADIENT: s = MrPacks.text(c, "mr_themes_gradient", spec.index + 1); break;
            case MrBackdrop.SCENE: s = categoryName(c, MrScenes.category(spec.index)) + " \u00b7 " + sceneName(c, spec.index); break;
            case MrBackdrop.IMAGE: s = MrPacks.text(c, "mr_themes_mine"); break;
            default: s = ""; break;
        }
        return s != null ? s : "";
    }

    // ---- choosing

    /** A theme of the list: it is the choice (written at once) and the background goes away, so the two are never mixed. */
    void chooseTheme(int index) {
        mPrefs.edit().putString(THEME_KEY, index < mValues.length ? mValues[index] : String.valueOf(index)).putString(MrBackdrop.PREF, "").apply();
        readPrefs();
        refresh();
    }

    /** A colour, a gradient or a landscape: the dialog that shows the keyboard with it, to apply or to cancel. Nothing is written yet. */
    void openBackdrop(MrBackdrop.Spec spec) {
        if (spec.kind == MrBackdrop.IMAGE) {
            editImage();
            return;
        }
        showPreview(spec, null, mSoft, false);
    }

    /** The background goes on the keyboard: the theme of the backgrounds that suits it, and the background itself (one write). */
    void applyBackdrop(MrBackdrop.Spec spec, int soft, boolean pending) {
        MrBackdrop.Spec chosen = spec;
        if (spec.kind == MrBackdrop.IMAGE && pending) {
            // the picture that was waiting becomes the one of the background; its time is the one of the file that is kept
            if (!MrBackdrop.commitPending(this)) {
                k.toast(k.t("mr_themes_image_failed"));
                return;
            }
            chosen = MrBackdrop.Spec.image(spec.zoom, spec.dx, spec.dy, MrBackdrop.imageStamp(this));
        }
        int index = MrThemeColors.indexOfTag(mTags, MrBackdrop.themeTag(chosen));
        if (index < 0) {
            k.toast(k.t("mr_themes_image_failed"));
            return;
        }
        SharedPreferences.Editor e = mPrefs.edit();
        e.putString(THEME_KEY, index < mValues.length ? mValues[index] : String.valueOf(index));
        e.putString(MrBackdrop.PREF, chosen.format());
        if (chosen.kind == MrBackdrop.IMAGE) e.putInt(MrBackdrop.PREF_SOFT, MrBackdrop.clamp(soft, 0, MrBackdrop.MAX_SOFT));
        e.apply();
        readPrefs();
        if (chosen.kind == MrBackdrop.IMAGE) loadImage();
        refresh();
    }

    // ---- the dialogs

    private Dialog newDialog(boolean full) {
        int theme = getResources().getIdentifier("Theme.MrKeyboard.Dialog", "style", getPackageName());
        Dialog d = new Dialog(this, theme);
        d.requestWindowFeature(1); // FEATURE_NO_TITLE: the content has its own
        Window w = d.getWindow();
        if (w != null) {
            // the crop is a black page; the preview is a sheet at the bottom with its own rounded background
            w.setBackgroundDrawable(new ColorDrawable(full ? 0xff000000 : 0));
            w.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, full ? ViewGroup.LayoutParams.MATCH_PARENT : ViewGroup.LayoutParams.WRAP_CONTENT);
            if (!full) w.setGravity(Gravity.BOTTOM);
        }
        return d;
    }

    void closeDialog() {
        Dialog d = mDialog;
        mDialog = null;
        mDialogPreview = null;
        mDialogCrop = null;
        mDialogSoft = null;
        mDialogApply = mDialogCancel = mDialogNext = null;
        if (d != null && d.isShowing()) d.dismiss();
    }

    /**
     * The keyboard as it will look with this background, over the screen: "Cancel" and "Apply". {@code image} is the picture of an IMAGE spec,
     * {@code pending} that it is the one that is waiting (it becomes the background only with "Apply"; with "Cancel" or back it is let go of).
     */
    void showPreview(final MrBackdrop.Spec spec, Bitmap image, final int soft, final boolean pending) {
        closeDialog();
        final Dialog d = newDialog(false);
        LinearLayout box = k.column();
        box.setPadding(k.dp(20), k.dp(18), k.dp(20), k.dp(18));
        box.setBackground(k.round(k.solidBg(), 0, 22, false));
        box.addView(k.label(backgroundName(this, spec), 16f, k.text, true), k.wide(0));
        MrThemePreview pv = new MrThemePreview(this);
        // the complete keyboard, so that the highlight keys and the dash of the modifier keys are seen on the background as well
        pv.setFull(true);
        pv.show(MrBackdrop.themeTag(spec), spec, image != null || spec.kind != MrBackdrop.SCENE ? image : MrScenes.load(this, spec.index), soft);
        box.addView(pv, k.wide(14));
        LinearLayout buttons = k.row();
        box.addView(buttons, k.wide(18));
        TextView cancel = k.button(k.t("mr_themes_cancel"), false, new View.OnClickListener() {
            public void onClick(View v) {
                closeDialog();
                if (pending) MrBackdrop.discardPending(MrThemesActivity.this);
            }
        });
        TextView apply = k.button(k.t("mr_themes_apply"), true, new View.OnClickListener() {
            public void onClick(View v) {
                closeDialog();
                applyBackdrop(spec, soft, pending);
            }
        });
        LinearLayout.LayoutParams left = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        left.setMargins(0, 0, k.dp(6), 0);
        LinearLayout.LayoutParams right = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        right.setMargins(k.dp(6), 0, 0, 0);
        buttons.addView(cancel, left);
        buttons.addView(apply, right);
        d.setContentView(box);
        d.setOnCancelListener(new DialogInterface.OnCancelListener() {
            public void onCancel(DialogInterface dialog) {
                if (pending) MrBackdrop.discardPending(MrThemesActivity.this);
            }
        });
        mDialog = d;
        mDialogPreview = pv;
        mDialogCancel = cancel;
        mDialogApply = apply;
        d.show();
    }

    /**
     * The picture with the frame of the keyboard over it (drag to move, pinch to resize) and the softening of the background under it; "Next" goes on
     * to the preview, "Cancel" and back let the picture go (a waiting one is deleted).
     */
    void showCrop(final Bitmap bitmap, MrBackdrop.Spec start, int soft, final boolean pending) {
        if (bitmap == null) return;
        closeDialog();
        final Dialog d = newDialog(true);
        LinearLayout root = k.column();
        root.setPadding(k.dp(16), k.dp(24), k.dp(16), k.dp(16));
        TextView hint = k.label(k.t("mr_themes_crop_hint"), 16f, 0xffffffff, false);
        hint.setGravity(Gravity.CENTER);
        root.addView(hint, k.wide(0));
        final MrCropView crop = new MrCropView(this);
        crop.set(bitmap, start.zoom, start.dx, start.dy, soft);
        LinearLayout.LayoutParams area = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f);
        area.setMargins(0, k.dp(14), 0, k.dp(10));
        root.addView(crop, area);

        LinearLayout softLine = k.row();
        root.addView(softLine, k.wide(0));
        softLine.addView(k.label(k.t("mr_themes_soften"), 16f, 0xffffffff, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        final TextView softText = k.label(soft + "%", 16f, 0xffc8ccd6, false);
        softLine.addView(softText, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        final int[] softNow = {soft};
        SeekBar bar = new SeekBar(this);
        bar.setMax(MrBackdrop.MAX_SOFT);
        bar.setProgress(soft);
        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int progress, boolean fromUser) {
                if (!fromUser) return;
                softNow[0] = MrBackdrop.clamp(progress, 0, MrBackdrop.MAX_SOFT);
                crop.setSoft(softNow[0]);
                softText.setText(softNow[0] + "%");
            }

            public void onStartTrackingTouch(SeekBar b) {
            }

            public void onStopTrackingTouch(SeekBar b) {
            }
        });
        root.addView(bar, k.wide(6));
        root.addView(k.label(k.t("mr_themes_soften_hint"), 13f, 0xffc8ccd6, false), k.wide(2));

        LinearLayout buttons = k.row();
        root.addView(buttons, k.wide(14));
        TextView cancel = k.button(k.t("mr_themes_cancel"), false, new View.OnClickListener() {
            public void onClick(View v) {
                closeDialog();
                if (pending) MrBackdrop.discardPending(MrThemesActivity.this);
            }
        });
        TextView next = k.button(k.t("mr_themes_next"), true, new View.OnClickListener() {
            public void onClick(View v) {
                long stamp = pending ? MrBackdrop.pendingStamp(MrThemesActivity.this) : MrBackdrop.imageStamp(MrThemesActivity.this);
                showPreview(MrBackdrop.Spec.image(crop.zoom(), crop.dx(), crop.dy(), stamp), bitmap, softNow[0], pending);
            }
        });
        LinearLayout.LayoutParams left = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        left.setMargins(0, 0, k.dp(6), 0);
        LinearLayout.LayoutParams right = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        right.setMargins(k.dp(6), 0, 0, 0);
        buttons.addView(cancel, left);
        buttons.addView(next, right);
        d.setContentView(root);
        d.setOnCancelListener(new DialogInterface.OnCancelListener() {
            public void onCancel(DialogInterface dialog) {
                if (pending) MrBackdrop.discardPending(MrThemesActivity.this);
            }
        });
        mDialog = d;
        mDialogCrop = crop;
        mDialogSoft = bar;
        mDialogCancel = cancel;
        mDialogNext = next;
        d.show();
    }

    // ---- the picture of the gallery

    /**
     * The intents that ask for a picture, in the order to try them: the photo picker of the system (Android 11 and later where it exists, and always on
     * 13), the gallery, and last the picker of documents, which is the file manager. Each one is tried when the one before it has no app to answer.
     */
    static List<Intent> pickers(int sdk) {
        List<Intent> list = new ArrayList<Intent>();
        if (sdk >= 30) list.add(new Intent(ACTION_PICK_IMAGES).setType("image/*"));
        list.add(new Intent(Intent.ACTION_PICK).setDataAndType(Uri.parse(IMAGES_URI), "image/*"));
        Intent doc = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        doc.addCategory(Intent.CATEGORY_OPENABLE);
        doc.setType("image/*");
        list.add(doc);
        return list;
    }

    void pick() {
        List<Intent> tries = pickers(Build.VERSION.SDK_INT);
        for (int i = 0; i < tries.size(); i++) {
            try {
                startActivityForResult(tries.get(i), REQ_PICK);
                return;
            } catch (ActivityNotFoundException e) {
                // no app answers this one: the next
            } catch (RuntimeException e) {
                // a picker that cannot be started is not the end: the next
            }
        }
        k.toast(k.t("mr_themes_image_failed"));
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
                Bitmap picture = null;
                try {
                    InputStream in = getContentResolver().openInputStream(uri);
                    if (in != null) {
                        try {
                            size = MrBackdrop.importPending(MrThemesActivity.this, in);
                        } finally {
                            in.close();
                        }
                    }
                    if (size != null) picture = MrBackdrop.loadPending(MrThemesActivity.this);
                } catch (Exception e) {
                    size = null;
                    picture = null;
                }
                final Bitmap shown = picture;
                runOnUiThread(new Runnable() {
                    public void run() {
                        imported(shown);
                    }
                });
            }
        }).start();
    }

    /** The picture was read into the waiting file (or not): the crop opens with it, centred and not zoomed. Nothing is the background yet. */
    void imported(Bitmap picture) {
        if (isFinishing()) {
            MrBackdrop.discardPending(this);
            return;
        }
        if (picture == null) {
            MrBackdrop.discardPending(this);
            k.toast(k.t("mr_themes_image_failed"));
            return;
        }
        showCrop(picture, MrBackdrop.Spec.image(100, 0, 0, MrBackdrop.pendingStamp(this)), mSoft, true);
    }

    /** The picture that is kept, to put the frame somewhere else (it starts where the frame is when it is the background in use). */
    void editImage() {
        if (mImage == null) return;
        MrBackdrop.Spec start = mSpec.kind == MrBackdrop.IMAGE ? mSpec : MrBackdrop.Spec.image(100, 0, 0, MrBackdrop.imageStamp(this));
        showCrop(mImage, start, mSoft, false);
    }

    void removeImage() {
        MrBackdrop.removeImage(this);
        if (mSpec.kind == MrBackdrop.IMAGE) {
            // the picture was the background: the keyboard goes back to the first theme, with none
            mPrefs.edit().putString(MrBackdrop.PREF, "").putString(THEME_KEY, mValues.length > 0 ? mValues[0] : "0").apply();
        }
        mImage = null;
        mThumb = null;
        mLoad++;
        readPrefs();
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

    /** Reads the small copies of the landscapes (one after the other, apart from the main thread); each tile is drawn as its copy is there. */
    void loadScenes() {
        new Thread(new Runnable() {
            public void run() {
                for (int i = 0; i < MrScenes.COUNT; i++) {
                    final int index = i;
                    final Bitmap small = MrScenes.load(MrThemesActivity.this, i, SCENE_SAMPLE);
                    runOnUiThread(new Runnable() {
                        public void run() {
                            if (isFinishing()) return;
                            sceneLoaded(index, small);
                        }
                    });
                }
            }
        }).start();
    }

    /** The small copy of landscape {@code index} is there: the tile that stands for it shows it. */
    void sceneLoaded(int index, Bitmap small) {
        if (index < 0 || index >= mScenes.length) return;
        mScenes[index] = small;
        for (int i = 0; i < mBgTiles.size(); i++) {
            MrBackdrop.Spec s = mBgSpecs.get(i);
            if (s.kind == MrBackdrop.SCENE && s.index == index) {
                mBgTiles.get(i).show(MrBackdrop.themeTag(s), s, small, 0);
            }
        }
    }

    /** The small copy of a picture for the tiles. */
    static Bitmap thumb(Bitmap big) {
        int longest = Math.max(big.getWidth(), big.getHeight());
        if (longest <= THUMB_SIDE) return big;
        float f = THUMB_SIDE / (float) longest;
        return Bitmap.createScaledBitmap(big, Math.max(1, Math.round(big.getWidth() * f)), Math.max(1, Math.round(big.getHeight() * f)), true);
    }
}
