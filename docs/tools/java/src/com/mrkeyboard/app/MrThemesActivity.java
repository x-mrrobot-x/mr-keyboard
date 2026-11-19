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
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * "Keyboard theme": the screen that replaces the list of names. At the top the keyboard as it is now, with its name; under it a row of tabs, one
 * for each category (the themes, the colours, the gradients, each category of landscapes and the gallery), and under the tabs the cards of the one
 * that is open: a small keyboard with the name of the theme or of the background under it and a "View" on the right.
 *
 * <p>Only the tab that is open is made. Its cards are added a few at a time (so the screen answers while they come) and the small copies of the
 * landscapes are read apart from the main thread, one category when its tab opens.
 *
 * <p>A theme and a background are never mixed. A touch on any card opens a dialog with the complete keyboard as it will look, and only "Apply"
 * writes it: a theme goes in at once and takes the background away; a background puts the keyboard in one of the themes of the backgrounds (flat
 * keys with light or dark ink, in the style of keys chosen in the dialog, {@link MrBackdrop#STYLE_TAGS}). The dialog of a gradient or a landscape
 * also has the softening of the background, and the one of any background but a light colour the style of the keys. Only the keyboard at the top
 * shows the choice in use; the cards of the themes always show the themes as they are.
 *
 * <p>A picture of the gallery is chosen with the photo picker of the system ({@link #pickers}) and read once into a waiting file
 * ({@link MrBackdrop#importPending}); a dialog shows it with the frame of the keyboard over it, to drag and to pinch ({@link MrCropView}), with
 * the softening of the background under it; "Next" shows the keyboard as it will look and "Apply" makes the waiting picture the background. A picture
 * that is not applied costs the one that was there nothing. Everything is in the preferences that the keyboard reads: {@code pref_keyboard_layout}
 * (the theme, which also says the style of the keys), {@code pref_kbd_bg} and {@code pref_kbd_bg_soft}. Nothing else is kept here, so the screen
 * can be made again at any time.
 */
public class MrThemesActivity extends Activity {
    static final String THEME_KEY = "pref_keyboard_layout";
    /** The cards in a row: one, so that each keyboard is as wide as the screen allows and its keys can be seen. */
    static final int COLUMNS = 1;
    /** How many cards are added in one go (the rest follow, so that a long tab does not hold the screen). */
    static final int CHUNK = 3;
    /** The tabs: the themes, the colours, the gradients, then one for each category of landscapes, and the gallery last. */
    static final int TAB_THEMES = 0, TAB_COLORS = 1, TAB_GRADIENTS = 2, TAB_SCENES = 3;
    static final int TAB_GALLERY = TAB_SCENES + MrScenes.CATEGORIES;
    static final int TABS = TAB_GALLERY + 1;
    static final int REQ_PICK = 71;
    /** The longest side of the small copy of the picture that the cards show. */
    static final int THUMB_SIDE = 320;
    /** The photo picker of Android 13 (and of the phones that got it later through the system updates). */
    static final String ACTION_PICK_IMAGES = "android.provider.action.PICK_IMAGES";
    static final String IMAGES_URI = "content://media/external/images/media";

    /** The margin on the right of the list of cards (where its scroll bar is, not over the cards) and the opacity (0..255) of the thumb of the bar. */
    static final int SCROLL_MARGIN_DP = 20, SCROLL_THUMB_ALPHA = 0x59;

    /** What a card stands for. */
    static final int CARD_THEME = 0, CARD_BACKGROUND = 1, CARD_PLUS = 2, CARD_MINE = 3;

    /** A card to make: what it stands for, and its name. */
    static final class Card {
        final int kind;
        final int index;
        final MrBackdrop.Spec spec;
        final String name;

        Card(int kind, int index, MrBackdrop.Spec spec, String name) {
            this.kind = kind;
            this.index = index;
            this.spec = spec;
            this.name = name;
        }
    }

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
    /** The style of the keys in use (the position in {@link MrBackdrop#STYLE_TAGS}); 0 when the keyboard is in a theme of the list. */
    int mStyle;
    /** The picture of the gallery that is the background (for the big keyboard and for the crop) and the small copy of it that the cards show. */
    Bitmap mImage, mThumb;
    /** Bumped with every load of the picture, so that a slow one that comes late is let go. */
    int mLoad;
    /** The small copies of the landscapes that the cards show (null until each one is read, read once), and the whole one that the big keyboard shows. */
    final Bitmap[] mScenes = new Bitmap[MrScenes.COUNT];
    final boolean[] mSceneBusy = new boolean[MrScenes.COUNT];
    Bitmap mBigScene;
    int mBigSceneIndex = -1;
    /** The landscapes are read in halves of their size for the cards. */
    static final int SCENE_SAMPLE = 2;

    MrThemePreview mBig;
    TextView mCaption, mDetail;
    TextView mRemove;
    HorizontalScrollView mStrip;
    ScrollView mScroll;
    LinearLayout mGrid;
    final List<TextView> mTabViews = new ArrayList<TextView>();
    /** The tab that is open, how many times a tab was opened (a slow step of an old one is let go), the cards it has and how many are made. */
    int mTab = -1;
    int mTabLoad;
    List<Card> mCards = new ArrayList<Card>();
    int mBuilt;
    LinearLayout mRow;
    /** The cards of the tab that is open: the preview of each and the "View" of each (the same order). */
    final List<MrThemePreview> mThemeTiles = new ArrayList<MrThemePreview>();
    final List<TextView> mThemeActions = new ArrayList<TextView>();
    /** The cards of the backgrounds, in the order they were made, each with what it stands for. */
    final List<MrThemePreview> mBgTiles = new ArrayList<MrThemePreview>();
    final List<MrBackdrop.Spec> mBgSpecs = new ArrayList<MrBackdrop.Spec>();
    final List<TextView> mBgActions = new ArrayList<TextView>();
    /** The card of the picture of the gallery (null while there is none, or the tab is not the gallery). */
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

        LinearLayout root = k.column();
        root.setBackground(k.round(k.bg, 0, 0, false));
        // no padding on the right: the list of cards takes the margin for itself, so that its scroll bar sits at the edge of the screen and not over the cards
        root.setPadding(k.dp(20), k.dp(16), 0, 0);
        root.addView(k.backHeader(k.t("mr_themes_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), side(0));

        // the choice in use, in a card of its own: the keyboard as it is now on the left and, on the right, the tag, its name and what it is (the only
        // place that shows the choice in use besides the "In use" pill of the card that is chosen)
        LinearLayout top = k.row();
        top.setGravity(Gravity.CENTER_VERTICAL);
        top.setPadding(k.dp(10), k.dp(10), k.dp(12), k.dp(10));
        top.setBackground(k.round(k.card, MrBackdrop.mix(k.card, k.accent, 0.55f), 14, false));
        mBig = new MrThemePreview(this);
        top.addView(mBig, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1.3f));
        LinearLayout info = k.column();
        info.setPadding(k.dp(14), 0, 0, 0);
        info.setGravity(Gravity.CENTER_VERTICAL);
        TextView tag = k.label(k.t("mr_themes_current").toUpperCase(java.util.Locale.ROOT), 11f, k.onAccent, true);
        tag.setPadding(k.dp(8), k.dp(3), k.dp(8), k.dp(3));
        tag.setBackground(k.round(k.accent, 0, 8, false));
        info.addView(tag, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mCaption = k.label("", 17f, k.text, true);
        mCaption.setMaxLines(2);
        info.addView(mCaption, k.wide(8));
        mDetail = k.label("", 13f, k.text2, false);
        mDetail.setMaxLines(3);
        info.addView(mDetail, k.wide(4));
        top.addView(info, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        root.addView(top, side(12));

        // the tabs: one for each category
        mStrip = new HorizontalScrollView(this);
        mStrip.setHorizontalScrollBarEnabled(false);
        LinearLayout tabs = k.row();
        for (int i = 0; i < TABS; i++) {
            final int tab = i;
            TextView t = k.label(tabName(i), 15f, k.text2, false);
            t.setGravity(Gravity.CENTER);
            t.setPadding(k.dp(14), k.dp(8), k.dp(14), k.dp(8));
            t.setClickable(true);
            t.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (tab != mTab) showTab(tab);
                }
            });
            LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            if (i > 0) p.setMargins(k.dp(6), 0, 0, 0);
            tabs.addView(t, p);
            mTabViews.add(t);
        }
        mStrip.addView(tabs, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        root.addView(mStrip, side(14));

        // the cards of the tab that is open. The margin of the right side is the padding of the list (not clipped), and the scroll bar is drawn outside of the
        // content, in that margin: thin, in a faint tone of the secondary text, and it fades when the list is still
        mScroll = new ScrollView(this);
        mScroll.setPadding(0, 0, k.dp(SCROLL_MARGIN_DP), 0);
        mScroll.setClipToPadding(false);
        mScroll.setScrollBarStyle(View.SCROLLBARS_OUTSIDE_OVERLAY);
        mScroll.setScrollBarSize(k.dp(3));
        mScroll.setScrollbarFadingEnabled(true);
        if (Build.VERSION.SDK_INT >= 29) mScroll.setVerticalScrollbarThumbDrawable(k.round((SCROLL_THUMB_ALPHA << 24) | (k.text2 & 0xffffff), 0, 2, false));
        mGrid = k.column();
        mGrid.setPadding(0, 0, 0, k.dp(24));
        mScroll.addView(mGrid, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        LinearLayout.LayoutParams area = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f);
        area.setMargins(0, k.dp(12), 0, 0);
        root.addView(mScroll, area);

        setContentView(root);
        refresh();
        showTab(tabOfChoice());
        loadImage();
    }

    @Override
    protected void onDestroy() {
        mLoad++;
        mTabLoad++;
        closeDialog();
        // a picture that was chosen and not applied is let go of
        MrBackdrop.discardPending(this);
        mImage = null;
        mThumb = null;
        mBigScene = null;
        super.onDestroy();
    }

    // ---- the tabs

    /** The name of tab {@code tab}. */
    String tabName(int tab) {
        if (tab == TAB_THEMES) return k.t("mr_themes_themes");
        if (tab == TAB_COLORS) return k.t("mr_themes_colors");
        if (tab == TAB_GRADIENTS) return k.t("mr_themes_gradients");
        if (tab == TAB_GALLERY) return k.t("mr_themes_gallery");
        return categoryName(this, tab - TAB_SCENES);
    }

    /** The tab that the choice in use lives in (the themes when there is no background), so that the card that is chosen is in view. */
    int tabOfChoice() {
        switch (mSpec.kind) {
            case MrBackdrop.COLOR: return TAB_COLORS;
            case MrBackdrop.GRADIENT: return TAB_GRADIENTS;
            case MrBackdrop.SCENE: return TAB_SCENES + MrScenes.category(mSpec.index);
            case MrBackdrop.IMAGE: return TAB_GALLERY;
            default: return TAB_THEMES;
        }
    }

    /** The cards of tab {@code tab}, in order. */
    List<Card> cardsOf(int tab) {
        List<Card> list = new ArrayList<Card>();
        if (tab == TAB_THEMES) {
            for (int i = 0; i < mListed; i++) {
                list.add(new Card(CARD_THEME, i, null, i < mNames.length ? mNames[i] : mTags[i]));
            }
        } else if (tab == TAB_COLORS) {
            for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
                list.add(new Card(CARD_BACKGROUND, i, MrBackdrop.Spec.color(i), k.t("mr_themes_color", i + 1)));
            }
        } else if (tab == TAB_GRADIENTS) {
            for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) {
                list.add(new Card(CARD_BACKGROUND, i, MrBackdrop.Spec.gradient(i), k.t("mr_themes_gradient", i + 1)));
            }
        } else if (tab == TAB_GALLERY) {
            list.add(new Card(CARD_PLUS, 0, null, k.t("mr_themes_photo")));
            if (MrBackdrop.hasImage(this)) list.add(new Card(CARD_MINE, 0, MrBackdrop.Spec.image(100, 0, 0, 0L), k.t("mr_themes_mine")));
        } else {
            int cat = tab - TAB_SCENES;
            for (int n = 0; n < MrScenes.PER_CATEGORY; n++) {
                int i = MrScenes.scene(cat, n);
                list.add(new Card(CARD_BACKGROUND, i, MrBackdrop.Spec.scene(i), sceneName(this, i)));
            }
        }
        return list;
    }

    /**
     * Opens tab {@code tab}: the cards of the one that was open are let go, the first few of this one are made now and the rest a few at a time (each
     * step is posted, so a tab of twenty cards does not stop the screen), and the landscapes of its category are read apart from the main thread.
     */
    void showTab(int tab) {
        mTab = tab;
        int load = ++mTabLoad;
        mGrid.removeAllViews();
        mThemeTiles.clear();
        mThemeActions.clear();
        mBgTiles.clear();
        mBgSpecs.clear();
        mBgActions.clear();
        mMineTile = null;
        mRemove = null;
        mRow = null;
        mCards = cardsOf(tab);
        mBuilt = 0;
        styleTabs();
        mScroll.scrollTo(0, 0);
        if (tab >= TAB_SCENES && tab < TAB_GALLERY) loadScenes(tab - TAB_SCENES);
        buildMore(load);
    }

    /** The next few cards of the tab that is open (nothing if another tab was opened since this step was posted). */
    void buildMore(final int load) {
        if (load != mTabLoad || isFinishing()) return;
        int end = Math.min(mCards.size(), mBuilt + CHUNK);
        while (mBuilt < end) {
            addCard(mCards.get(mBuilt), mBuilt);
            mBuilt++;
        }
        if (mBuilt < mCards.size()) {
            mGrid.post(new Runnable() {
                public void run() {
                    buildMore(load);
                }
            });
            return;
        }
        fillRow(mRow, mCards.size());
        if (mTab == TAB_GALLERY && MrBackdrop.hasImage(this)) {
            mRemove = k.button(k.t("mr_themes_remove"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    removeImage();
                }
            });
            mGrid.addView(mRemove, k.wide(20));
        }
    }

    /** The tabs as they are now: the one that is open filled, the others plain; the strip is moved so that the open one shows. */
    void styleTabs() {
        for (int i = 0; i < mTabViews.size(); i++) {
            TextView t = mTabViews.get(i);
            boolean on = i == mTab;
            t.setTextColor(on ? k.onAccent : k.text2);
            t.setTypeface(null, on ? android.graphics.Typeface.BOLD : android.graphics.Typeface.NORMAL);
            t.setBackground(on ? k.round(k.accent, 0, 18, false) : new ColorDrawable(0));
        }
        if (mTab >= 0 && mTab < mTabViews.size()) {
            final TextView open = mTabViews.get(mTab);
            mStrip.post(new Runnable() {
                public void run() {
                    mStrip.smoothScrollTo(Math.max(0, open.getLeft() - k.dp(48)), 0);
                }
            });
        }
    }

    // ---- the cards

    /** The width of the screen less the margin on the right (the screen has no padding on that side), {@code topDp} from what is above. */
    private LinearLayout.LayoutParams side(int topDp) {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        p.setMargins(0, k.dp(topDp), k.dp(SCROLL_MARGIN_DP), 0);
        return p;
    }

    private LinearLayout.LayoutParams cardParams(int column) {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        p.setMargins(column == 0 ? 0 : k.dp(6), 0, column == COLUMNS - 1 ? 0 : k.dp(6), 0);
        return p;
    }

    /** A row that does not end on a full line gets empty places, so that its cards are as wide as the others. */
    private void fillRow(LinearLayout row, int count) {
        if (row == null) return;
        for (int c = count % COLUMNS; c != 0 && c < COLUMNS; c++) {
            View gap = new View(this);
            row.addView(gap, cardParams(c));
        }
    }

    /** Makes the card {@code card}, the {@code position}-th of the tab, and puts it in its row. */
    private void addCard(final Card card, int position) {
        int column = position % COLUMNS;
        if (column == 0) {
            mRow = k.row();
            mRow.setGravity(Gravity.TOP);
            mGrid.addView(mRow, k.wide(mGrid.getChildCount() == 0 ? 0 : 12));
        }
        MrThemePreview p = new MrThemePreview(this);
        TextView action = new TextView(this);
        View.OnClickListener open;
        switch (card.kind) {
            case CARD_THEME:
                open = new View.OnClickListener() {
                    public void onClick(View v) {
                        showThemePreview(card.index);
                    }
                };
                mThemeTiles.add(p);
                mThemeActions.add(action);
                break;
            case CARD_PLUS:
                p.showPlus(k.card, k.stroke, k.accent);
                open = new View.OnClickListener() {
                    public void onClick(View v) {
                        pick();
                    }
                };
                break;
            case CARD_MINE:
                open = new View.OnClickListener() {
                    public void onClick(View v) {
                        editImage();
                    }
                };
                mBgTiles.add(p);
                mBgSpecs.add(card.spec);
                mBgActions.add(action);
                mMineTile = p;
                break;
            default:
                open = new View.OnClickListener() {
                    public void onClick(View v) {
                        openBackdrop(card.spec);
                    }
                };
                mBgTiles.add(p);
                mBgSpecs.add(card.spec);
                mBgActions.add(action);
                break;
        }
        mRow.addView(cardBox(p, card.name, action, card.kind == CARD_PLUS ? k.t("mr_themes_choose") : null, open), cardParams(column));
        bindCard(card.kind, p, card.kind == CARD_THEME ? card.index : mBgTiles.size() - 1);
    }

    /**
     * A card: the small keyboard with its name under it on the left and the "View" pill on the right, in a rounded frame; the whole card is touched
     * to open it. {@code word} is the text of the pill when it is not "View" (the card that picks a photo).
     */
    private LinearLayout cardBox(MrThemePreview p, String name, TextView action, String word, View.OnClickListener l) {
        LinearLayout box = k.column();
        box.setPadding(k.dp(6), k.dp(6), k.dp(6), k.dp(6));
        box.setBackground(k.round(k.card, k.stroke, 12, false));
        box.setClickable(true);
        box.setOnClickListener(l);
        box.setContentDescription(name);
        box.addView(p, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        LinearLayout foot = k.row();
        foot.setPadding(k.dp(4), 0, k.dp(2), 0);
        TextView label = k.label(name, 13f, k.text, false);
        label.setMaxLines(2);
        foot.addView(label, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        action.setTextSize(12f);
        action.setGravity(Gravity.CENTER);
        action.setPadding(k.dp(10), k.dp(4), k.dp(10), k.dp(4));
        action.setMinWidth(k.dp(40));
        action.setText(word != null ? word : k.t("mr_themes_view"));
        action.setTextColor(k.accent);
        action.setBackground(k.round(k.raised, MrBackdrop.mix(k.card, k.accent, 0.5f), 8, false));
        foot.addView(action, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        LinearLayout.LayoutParams fp = k.wide(8);
        fp.setMargins(0, k.dp(8), 0, k.dp(2));
        box.addView(foot, fp);
        return box;
    }

    /** Draws card {@code p} for what it stands for ({@code index}: the theme, or the position among the cards of the backgrounds). */
    private void bindCard(int kind, MrThemePreview p, int index) {
        if (kind == CARD_THEME) {
            p.show(mTags[index], MrBackdrop.Spec.NO, null, 0);
            boolean on = mSpec.kind == MrBackdrop.NONE && index == mTheme;
            p.setChecked(on, k.accent, k.onAccent);
            markAction(mThemeActions.get(index), on, (View) p.getParent());
        } else if (kind == CARD_BACKGROUND || kind == CARD_MINE) {
            MrBackdrop.Spec s = tileSpec(mBgSpecs.get(index));
            p.show(MrBackdrop.themeTag(s), s, tileImage(s), s.kind == MrBackdrop.IMAGE ? mSoft : 0);
            boolean on = mSpec.kind != MrBackdrop.NONE && s.kind == mSpec.kind && (s.kind == MrBackdrop.IMAGE || s.index == mSpec.index);
            p.setChecked(on, k.accent, k.onAccent);
            markAction(mBgActions.get(index), on, (View) p.getParent());
        }
    }

    /** The pill of a card and the frame of it: the card in use has the pill filled and says so, and a frame in the colour of the accent. */
    private void markAction(TextView action, boolean on, View frame) {
        action.setText(k.t(on ? "mr_themes_in_use" : "mr_themes_view"));
        action.setTextColor(on ? k.onAccent : k.accent);
        action.setBackground(on ? k.round(k.accent, 0, 8, false) : k.round(k.raised, MrBackdrop.mix(k.card, k.accent, 0.5f), 8, false));
        if (frame != null) frame.setBackground(k.round(k.card, on ? k.accent : k.stroke, 12, false));
    }

    // ---- state

    /** Reads what the keyboard reads. */
    void readPrefs() {
        mTheme = MrThemeColors.indexOf(mValues, mPrefs.getString(THEME_KEY, "0"));
        // a background counts only in the themes of the backgrounds: in any other theme an old value of the preference is let be
        boolean inBackdropTheme = mTheme < mTags.length && MrThemeColors.hidden(mTags[mTheme]);
        mSpec = inBackdropTheme ? MrBackdrop.current(this) : MrBackdrop.Spec.NO;
        mStyle = inBackdropTheme ? MrBackdrop.styleOf(mTags[mTheme]) : 0;
        mSoft = MrBackdrop.soft(this);
    }

    String tag() {
        return mTheme < mTags.length ? mTags[mTheme] : null;
    }

    /** The spec that a card of the backgrounds stands for now: the picture keeps the zoom and the position it has when it is the one in use. */
    MrBackdrop.Spec tileSpec(MrBackdrop.Spec s) {
        return s.kind == MrBackdrop.IMAGE && mSpec.kind == MrBackdrop.IMAGE ? mSpec : s;
    }

    /** The small picture that a card of the backgrounds shows: the copy of the picture of the gallery or of the landscape (null while it is being read). */
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

    /** Draws everything again from the state: the big keyboard and its name, the cards of the tab that is open, the controls that apply. */
    void refresh() {
        mBig.show(tag(), mSpec, bigImage(mSpec), mSoft);
        mCaption.setText(caption());
        mDetail.setText(detail());
        for (int i = 0; i < mThemeTiles.size(); i++) bindCard(CARD_THEME, mThemeTiles.get(i), i);
        for (int i = 0; i < mBgTiles.size(); i++) bindCard(CARD_BACKGROUND, mBgTiles.get(i), i);
    }

    /** The gallery got or lost its picture: that tab is made again (the card of my image comes or goes); any other only draws again. */
    void galleryChanged() {
        refresh();
        if (mTab == TAB_GALLERY) showTab(TAB_GALLERY);
    }

    String caption() {
        if (mSpec.kind != MrBackdrop.NONE) return backgroundName(this, mSpec);
        return mTheme < mListed && mTheme < mNames.length ? mNames[mTheme] : "";
    }

    /**
     * What the choice in use is, under its name: "Theme" for a theme of the list; for a background the tab it is in and, when it has the style of the
     * keys to choose, the kind and the name of the style ("Keys: Outline · Violet").
     */
    String detail() {
        if (mSpec.kind == MrBackdrop.NONE) return k.t("mr_themes_theme_one");
        String line = tabName(tabOfChoice());
        if (MrBackdrop.hasStyles(mSpec)) {
            line += "\n" + k.t("mr_themes_keys") + ": " + kindName(this, MrBackdrop.kindOf(mStyle)) + " \u00b7 " + styleName(this, mStyle);
        }
        return line;
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

    /** The name of the kind of style of keys {@code kind} (glass, outline, gradient). */
    static String kindName(Context c, int kind) {
        String s = MrPacks.text(c, "mr_themes_kind_" + kind);
        return s != null ? s : "";
    }

    /** The name of the style of keys {@code style}. */
    static String styleName(Context c, int style) {
        String s = MrPacks.text(c, "mr_themes_style_" + style);
        return s != null ? s : "";
    }

    /** The name of a background for the captions and the summary of the setting. */
    static String backgroundName(Context c, MrBackdrop.Spec spec) {
        String s;
        switch (spec.kind) {
            case MrBackdrop.COLOR: s = MrPacks.text(c, "mr_themes_color", spec.index + 1); break;
            case MrBackdrop.GRADIENT: s = MrPacks.text(c, "mr_themes_gradient", spec.index + 1); break;
            case MrBackdrop.SCENE: s = categoryName(c, MrScenes.category(spec.index)) + " · " + sceneName(c, spec.index); break;
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
        showPreview(spec, null, startSoft(spec), false);
    }

    /** The softening the dialog of a background starts with: the one in use when this is the background in use, else none. */
    int startSoft(MrBackdrop.Spec spec) {
        if (spec.kind != MrBackdrop.GRADIENT && spec.kind != MrBackdrop.SCENE) return 0;
        return mSpec.kind == spec.kind && mSpec.index == spec.index ? mSoft : 0;
    }

    /**
     * The background goes on the keyboard: the theme of the backgrounds that suits it with the style of keys chosen, and the background itself (one
     * write). A gradient, a landscape or a picture also writes its softening.
     */
    void applyBackdrop(MrBackdrop.Spec spec, int soft, int style, boolean pending) {
        MrBackdrop.Spec chosen = spec;
        if (spec.kind == MrBackdrop.IMAGE && pending) {
            // the picture that was waiting becomes the one of the background; its time is the one of the file that is kept
            if (!MrBackdrop.commitPending(this)) {
                k.toast(k.t("mr_themes_image_failed"));
                return;
            }
            chosen = MrBackdrop.Spec.image(spec.zoom, spec.dx, spec.dy, MrBackdrop.imageStamp(this));
        }
        int index = MrThemeColors.indexOfTag(mTags, MrBackdrop.themeTag(chosen, style));
        if (index < 0) {
            k.toast(k.t("mr_themes_image_failed"));
            return;
        }
        SharedPreferences.Editor e = mPrefs.edit();
        e.putString(THEME_KEY, index < mValues.length ? mValues[index] : String.valueOf(index));
        e.putString(MrBackdrop.PREF, chosen.format());
        if (chosen.kind != MrBackdrop.COLOR) e.putInt(MrBackdrop.PREF_SOFT, MrBackdrop.clamp(soft, 0, MrBackdrop.MAX_SOFT));
        e.apply();
        readPrefs();
        if (chosen.kind == MrBackdrop.IMAGE) loadImage();
        galleryChanged();
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

    /** The sheet of a preview: its rounded box with the title on top. */
    private LinearLayout sheetBox(String title) {
        LinearLayout box = k.column();
        box.setPadding(k.dp(20), k.dp(18), k.dp(20), k.dp(18));
        box.setBackground(k.round(k.solidBg(), 0, 22, false));
        box.addView(k.label(title, 16f, k.text, true), k.wide(0));
        return box;
    }

    /** "Cancel" and "Apply" under the sheet; {@code pending}: a waiting picture that "Cancel" lets go of. Shows the dialog. */
    private void sheetShow(Dialog d, LinearLayout box, MrThemePreview pv, SeekBar soft, final boolean pending, final Runnable onApply) {
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
                onApply.run();
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
        mDialogSoft = soft;
        mDialogCancel = cancel;
        mDialogApply = apply;
        d.show();
    }

    /** A theme of the list, as the complete keyboard: "Cancel" and "Apply" (which chooses it). */
    void showThemePreview(final int index) {
        closeDialog();
        Dialog d = newDialog(false);
        LinearLayout box = sheetBox(index < mNames.length ? mNames[index] : mTags[index]);
        MrThemePreview pv = new MrThemePreview(this);
        pv.setFull(true);
        pv.show(mTags[index], MrBackdrop.Spec.NO, null, 0);
        box.addView(pv, k.wide(14));
        sheetShow(d, box, pv, null, false, new Runnable() {
            public void run() {
                chooseTheme(index);
            }
        });
    }

    /**
     * The complete keyboard as it will look with this background, over the screen: "Cancel" and "Apply". {@code image} is the picture of an IMAGE spec,
     * {@code pending} that it is the one that is waiting (it becomes the background only with "Apply"; with "Cancel" or back it is let go of).
     * A gradient or a landscape has the softening of the background under the keyboard (a picture has it in the crop already), and every background
     * but a light colour has the styles of the keys, so that the letters can be made to stand out from a busy picture.
     */
    void showPreview(final MrBackdrop.Spec spec, Bitmap image, final int soft, final boolean pending) {
        closeDialog();
        final Dialog d = newDialog(false);
        final LinearLayout box = sheetBox(backgroundName(this, spec));
        final MrThemePreview pv = new MrThemePreview(this);
        // the complete keyboard, so that the highlight keys and the dash of the modifier keys are seen on the background as well
        pv.setFull(true);
        final Bitmap shown = image != null || spec.kind != MrBackdrop.SCENE ? image : MrScenes.load(this, spec.index);
        final int[] softNow = {soft};
        final int[] style = {mStyle};
        final Runnable redraw = new Runnable() {
            public void run() {
                pv.show(MrBackdrop.themeTag(spec, style[0]), spec, shown, softNow[0]);
            }
        };
        redraw.run();
        box.addView(pv, k.wide(14));

        SeekBar bar = null;
        if (spec.kind == MrBackdrop.GRADIENT || spec.kind == MrBackdrop.SCENE) {
            LinearLayout softLine = k.row();
            box.addView(softLine, k.wide(14));
            softLine.addView(k.label(k.t("mr_themes_soften"), 15f, k.text, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
            final TextView softText = k.label(soft + "%", 15f, k.text2, false);
            softLine.addView(softText, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            bar = new SeekBar(this);
            bar.setMax(MrBackdrop.MAX_SOFT);
            bar.setProgress(soft);
            bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                public void onProgressChanged(SeekBar b, int progress, boolean fromUser) {
                    if (!fromUser) return;
                    softNow[0] = MrBackdrop.clamp(progress, 0, MrBackdrop.MAX_SOFT);
                    softText.setText(softNow[0] + "%");
                    redraw.run();
                }

                public void onStartTrackingTouch(SeekBar b) {
                }

                public void onStopTrackingTouch(SeekBar b) {
                }
            });
            box.addView(bar, k.wide(4));
        }

        if (MrBackdrop.hasStyles(spec)) {
            box.addView(k.label(k.t("mr_themes_keys"), 15f, k.text, true), k.wide(12));
            // two levels: the kind (glass, outline, gradient) as chips, then the colours of that kind as dots, and the name of the one chosen under them
            final LinearLayout kinds = k.row();
            box.addView(kinds, k.wide(8));
            HorizontalScrollView scroll = new HorizontalScrollView(this);
            scroll.setHorizontalScrollBarEnabled(false);
            final LinearLayout dots = k.row();
            scroll.addView(dots, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            box.addView(scroll, k.wide(10));
            final TextView styleLabel = k.label("", 14f, k.text2, false);
            styleLabel.setGravity(Gravity.CENTER);
            box.addView(styleLabel, k.wide(4));
            final Runnable[] draw = new Runnable[1];
            draw[0] = new Runnable() {
                public void run() {
                    int kind = MrBackdrop.kindOf(style[0]);
                    kinds.removeAllViews();
                    for (int i = 0; i < MrBackdrop.KINDS; i++) {
                        final int n = i;
                        TextView c = k.chip(kindName(MrThemesActivity.this, n), n == kind, new View.OnClickListener() {
                            public void onClick(View v) {
                                if (MrBackdrop.kindOf(style[0]) == n) return;
                                style[0] = MrBackdrop.KIND_FIRST[n];
                                redraw.run();
                                draw[0].run();
                            }
                        });
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
                        if (n > 0) p.setMargins(k.dp(8), 0, 0, 0);
                        kinds.addView(c, p);
                    }
                    dots.removeAllViews();
                    for (int i = MrBackdrop.KIND_FIRST[kind]; i < MrBackdrop.KIND_FIRST[kind + 1]; i++) {
                        final int n = i;
                        MrStyleDot dot = new MrStyleDot(MrThemesActivity.this, n, n == style[0], k.accent);
                        dot.setContentDescription(styleName(MrThemesActivity.this, n));
                        dot.setClickable(true);
                        dot.setOnClickListener(new View.OnClickListener() {
                            public void onClick(View v) {
                                style[0] = n;
                                redraw.run();
                                draw[0].run();
                            }
                        });
                        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(k.dp(MrStyleDot.SIZE_DP), k.dp(MrStyleDot.SIZE_DP));
                        if (i > MrBackdrop.KIND_FIRST[kind]) p.setMargins(k.dp(12), 0, 0, 0);
                        dots.addView(dot, p);
                    }
                    styleLabel.setText(styleName(MrThemesActivity.this, style[0]));
                }
            };
            draw[0].run();
        }
        sheetShow(d, box, pv, bar, pending, new Runnable() {
            public void run() {
                applyBackdrop(spec, softNow[0], style[0], pending);
            }
        });
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
        galleryChanged();
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

    /**
     * Reads the small copies of the landscapes of category {@code cat} that are not read yet (one after the other, apart from the main thread);
     * each card is drawn as its copy is there. A copy is read once for the whole life of the screen.
     */
    void loadScenes(int cat) {
        final List<Integer> todo = new ArrayList<Integer>();
        for (int n = 0; n < MrScenes.PER_CATEGORY; n++) {
            int i = MrScenes.scene(cat, n);
            if (mScenes[i] == null && !mSceneBusy[i]) {
                mSceneBusy[i] = true;
                todo.add(i);
            }
        }
        if (todo.isEmpty()) return;
        new Thread(new Runnable() {
            public void run() {
                for (int n = 0; n < todo.size(); n++) {
                    final int index = todo.get(n);
                    final Bitmap small = MrScenes.load(MrThemesActivity.this, index, SCENE_SAMPLE);
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

    /** The small copy of landscape {@code index} is there: the card that stands for it (if its tab is open) shows it. */
    void sceneLoaded(int index, Bitmap small) {
        if (index < 0 || index >= mScenes.length) return;
        mScenes[index] = small;
        mSceneBusy[index] = false;
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
