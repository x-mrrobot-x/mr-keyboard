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
    /** The cards in a row, in every tab: two (the small keyboard of a card is a hint of the theme, the complete one opens with a touch). */
    static final int COLUMNS = 2;
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
    /** The card in use is rolled to once its row has a place: how many times to look again, and how long to wait between them. */
    static final int REVEAL_TRIES = 8, REVEAL_WAIT_MS = 40;

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
    /** What the person tuned about the keys of the background in use (opacities, colour of the letters, own colour); none when the keyboard is in a theme of the list. */
    MrKeyLook mLook = MrKeyLook.NONE;
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
    /** The colour picker, over the dialog of a background, and what it is in. */
    Dialog mPicker;
    MrColorPicker mPickerView;
    /** The bar of the opacity under the picker (the colours that have one: the keys and their line) and the value that it shows; null for the others. */
    MrOpacityBar mPickerOpacity;
    TextView mPickerOpacityValue;
    TextView mPickerOk, mPickerCancel;
    /** The dialog of a background is for one that needs dark ink (a pale colour): its presets are the colour of the person's own written for it. */
    boolean mDialogPale;
    /** What the dialog of a background has now: the tuning of its keys (test help; the dialog keeps it, see {@link #showPreview}). */
    MrKeyLook[] mDialogLook;
    int[] mDialogStyle;
    /** The rows of the dialog of a background that the tests press: the dots of the style, the picker of the own colour, the one of the letters. */
    LinearLayout mDialogKeys, mDialogLine, mDialogText;

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
        // touching it takes the list to the choice in use: its tab opens and the list rolls, softly, to its card
        top.setClickable(true);
        top.setContentDescription(k.t("mr_themes_current"));
        top.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showChoice();
            }
        });
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

    /** The place of the choice in use among the cards of the tab that holds it (-1 when it has no card there). */
    int choicePosition() {
        if (mCards == null) return -1;
        for (int i = 0; i < mCards.size(); i++) {
            Card c = mCards.get(i);
            if (mSpec.kind == MrBackdrop.NONE) {
                if (c.kind == CARD_THEME && c.index == mTheme) return i;
            } else if (c.spec != null && c.spec.kind == mSpec.kind && (mSpec.kind == MrBackdrop.IMAGE || c.spec.index == mSpec.index)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * The card of the choice in use comes into view: its tab is opened (when another is) and the cards up to it are made (the others stay for the
     * posted steps), and then the list rolls to its row, softly. It waits for the row to have its place, which it has only after the first layout.
     */
    void showChoice() {
        int tab = tabOfChoice();
        if (tab != mTab || mCards == null) showTab(tab);
        int position = choicePosition();
        if (position < 0) return;
        while (mBuilt <= position && mBuilt < mCards.size()) {
            addCard(mCards.get(mBuilt), mBuilt);
            mBuilt++;
        }
        revealRow(mGrid.getChildAt(position / COLUMNS), REVEAL_TRIES);
    }

    /** Rolls the list, softly, so that {@code row} is at its top; tries again a few times while the row has no place yet. */
    private void revealRow(final View row, final int tries) {
        if (row == null) return;
        if (row.getHeight() <= 0 && tries > 0) {
            mScroll.postDelayed(new Runnable() {
                public void run() {
                    revealRow(row, tries - 1);
                }
            }, REVEAL_WAIT_MS);
            return;
        }
        mScroll.smoothScrollTo(0, Math.max(0, row.getTop() - k.dp(8)));
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
        mLook = inBackdropTheme ? MrKeyLook.read(mPrefs) : MrKeyLook.NONE;
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
        mBig.setLook(mLook);
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

    /**
     * Whether the dialog of {@code spec} opens on the background that is in use (it keeps the style and the tuning of its keys) or on another one (it
     * starts clean: the see-through glass, nothing tuned, so that what was chosen for one background is not carried to the next). A picture that is
     * waiting is another one.
     */
    boolean inUse(MrBackdrop.Spec spec, boolean pending) {
        if (pending || mSpec.kind == MrBackdrop.NONE || mSpec.kind != spec.kind) return false;
        return spec.kind == MrBackdrop.IMAGE || mSpec.index == spec.index;
    }

    /** The style of the keys that the dialog of {@code spec} starts with: the one in use for the background in use, else the see-through glass. */
    int startStyle(MrBackdrop.Spec spec, boolean pending) {
        return inUse(spec, pending) ? mStyle : 0;
    }

    /** The tuning of the keys that the dialog of {@code spec} starts with: the one in use for the background in use, else none. */
    MrKeyLook startLook(MrBackdrop.Spec spec, boolean pending) {
        return inUse(spec, pending) ? mLook : MrKeyLook.NONE;
    }

    /** The softening the dialog of a background starts with: the one in use when this is the background in use, else none. */
    int startSoft(MrBackdrop.Spec spec) {
        if (spec.kind != MrBackdrop.GRADIENT && spec.kind != MrBackdrop.SCENE) return 0;
        return mSpec.kind == spec.kind && mSpec.index == spec.index ? mSoft : 0;
    }

    /**
     * The background goes on the keyboard: the theme of the backgrounds that suits it with the style of keys chosen, and the background itself (one
     * write). A gradient, a landscape or a picture also writes its softening; every one writes how the keys were tuned ({@link MrKeyLook}).
     */
    void applyBackdrop(MrBackdrop.Spec spec, int soft, int style, MrKeyLook look, boolean pending) {
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
        (look == null ? MrKeyLook.NONE : look).write(e);
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
        mDialogPale = false;
        mDialogApply = mDialogCancel = mDialogNext = null;
        mDialogLook = null;
        mDialogStyle = null;
        mDialogKeys = mDialogLine = mDialogText = null;
        closePicker();
        if (d != null && d.isShowing()) d.dismiss();
    }

    /** Closes the colour picker, if it is open. */
    void closePicker() {
        Dialog p = mPicker;
        mPicker = null;
        mPickerView = null;
        mPickerOpacity = null;
        mPickerOpacityValue = null;
        mPickerOk = mPickerCancel = null;
        if (p != null && p.isShowing()) p.dismiss();
    }

    /** The sheet of a preview: its rounded box with the title on top, that grows up to {@link #SHEET_SHARE} of the screen height. */
    private MrSheetBox sheetBox(String title) {
        MrSheetBox box = new MrSheetBox(this, Math.round(getResources().getDisplayMetrics().heightPixels * SHEET_SHARE), k.dp(MIN_CONTROLS_DP));
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
     * A gradient, a landscape or a picture has the softening of the background under the keyboard (that of a picture is set here, after the part of it
     * was chosen), and every background but a light colour has the styles of the keys, so that the letters can be made to stand out from a busy picture.
     */
    void showPreview(final MrBackdrop.Spec spec, Bitmap image, final int soft, final boolean pending) {
        closeDialog();
        final Dialog d = newDialog(false);
        final MrSheetBox box = sheetBox(backgroundName(this, spec));
        final MrThemePreview pv = new MrThemePreview(this);
        // the complete keyboard, so that the highlight keys and the dash of the modifier keys are seen on the background as well
        pv.setFull(true);
        final Bitmap shown = image != null || spec.kind != MrBackdrop.SCENE ? image : MrScenes.load(this, spec.index);
        final int[] softNow = {soft};
        // the background in use keeps its style and its tuning; any other starts with the see-through glass and nothing tuned
        final int[] style = {startStyle(spec, pending)};
        final MrKeyLook[] look = {startLook(spec, pending)};
        final Runnable redraw = new Runnable() {
            public void run() {
                pv.show(MrBackdrop.themeTag(spec, style[0]), spec, shown, softNow[0]);
                pv.setLook(look[0]);
            }
        };
        redraw.run();
        box.addView(pv, k.wide(14));

        // the controls scroll between the keyboard and the buttons, so that they are all within reach on a short screen
        final LinearLayout controls = k.column();
        MrCappedScroll scroll = new MrCappedScroll(this);
        scroll.addView(controls, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        box.addView(scroll, k.wide(0));
        box.limit(scroll);

        SeekBar bar = null;
        if (spec.kind == MrBackdrop.GRADIENT || spec.kind == MrBackdrop.SCENE || spec.kind == MrBackdrop.IMAGE) {
            bar = slider(controls, k.t("mr_themes_soften"), MrBackdrop.MAX_SOFT, soft, 14, new Setter() {
                public void set(int v) {
                    softNow[0] = MrBackdrop.clamp(v, 0, MrBackdrop.MAX_SOFT);
                    redraw.run();
                }
            });
            controls.addView(k.label(k.t("mr_themes_soften_hint"), 13f, k.text2, false), k.wide(2));
        }

        final boolean styled = MrBackdrop.hasStyles(spec);
        final LinearLayout keysBox = styled ? k.column() : null;
        final LinearLayout lineBox = styled ? k.column() : null;
        final LinearLayout textBox = k.column();
        // the order of the controls, each colour in a card of its own: the colour of the keys (the styles on the left, the picker on the right; the opacity
        // is in the picker), the colour of the line of the keys (the opacity of the line in its picker), then the colour of the text and of the icons of the toolbar
        if (styled) {
            card(controls, k.t("mr_themes_key_color"), keysBox, 14);
            card(controls, k.t("mr_themes_line_color"), lineBox, 12);
        }
        card(controls, k.t("mr_themes_text_color"), textBox, 12);
        final boolean pale = MrBackdrop.darkInk(spec);
        // the colours that stand out in the background, offered as the colour of the keys (none for a plain colour)
        final int[] suggested = styled ? MrPalette.of(spec, shown) : new int[0];
        final Runnable[] draw = new Runnable[1];
        draw[0] = new Runnable() {
            public void run() {
                if (keysBox != null) fillKeys(keysBox, pale, suggested, style, look, redraw, draw);
                if (lineBox != null) fillLine(lineBox, style, look, redraw, draw);
                fillText(textBox, style, look, redraw, draw);
            }
        };
        draw[0].run();

        sheetShow(d, box, pv, bar, pending, new Runnable() {
            public void run() {
                applyBackdrop(spec, softNow[0], style[0], look[0], pending);
            }
        });
        // after sheetShow, which lets go of what the dialog before it had
        mDialogPale = pale;
        mDialogLook = look;
        mDialogStyle = style;
        mDialogKeys = keysBox;
        mDialogLine = lineBox;
        mDialogText = textBox;
    }

    /** How much of the screen height the sheet of a dialog can take: the controls of a background scroll when the sheet reaches it. At least {@code MIN_CONTROLS_DP} of them show. */
    static final float SHEET_SHARE = 0.98f;
    static final int MIN_CONTROLS_DP = 96;

    /** How far from the background of the dialog the fill and the line of a card go, towards the colours of the cards of the screens (0 = the background itself): a step, not a block. */
    static final float CARD_FILL = 0.45f, CARD_LINE = 0.60f;

    /** The colour {@code t} of the way from {@code from} to {@code to} (opaque). */
    static int towards(int from, int to, float t) {
        int r = Math.round(((from >> 16) & 0xff) + (((to >> 16) & 0xff) - ((from >> 16) & 0xff)) * t);
        int g = Math.round(((from >> 8) & 0xff) + (((to >> 8) & 0xff) - ((from >> 8) & 0xff)) * t);
        int b = Math.round((from & 0xff) + ((to & 0xff) - (from & 0xff)) * t);
        return 0xff000000 | (r << 16) | (g << 8) | b;
    }

    /**
     * A section of colour of the dialog: its name and what sets it, in a card of its own, {@code topDp} under the one before. The card is only a little
     * lighter than the dialog (a subtle fill and a thin line: the controls are what has to be seen, not the box).
     */
    private LinearLayout card(LinearLayout into, String name, LinearLayout box, int topDp) {
        LinearLayout c = k.column();
        c.setPadding(k.dp(14), k.dp(12), k.dp(14), k.dp(14));
        int base = k.solidBg();
        c.setBackground(k.round(towards(base, k.faint, CARD_FILL), towards(base, k.line, CARD_LINE), 14, false));
        c.addView(k.label(name, 15f, k.text, true), k.wide(0));
        c.addView(box, k.wide(8));
        into.addView(c, k.wide(topDp));
        return c;
    }

    /** Takes the value of a slider while the finger moves it. */
    interface Setter {
        void set(int value);
    }

    /** A line with a name and the value (per cent) on its right, and the slider under it; {@code onChange} is told what the finger sets. Returns the slider. */
    private SeekBar slider(LinearLayout into, String name, final int max, int start, int topDp, final Setter onChange) {
        LinearLayout line = k.row();
        into.addView(line, k.wide(topDp));
        line.addView(k.label(name, 15f, k.text, true), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        final TextView value = k.label(start + "%", 15f, k.text2, false);
        line.addView(value, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        SeekBar bar = new SeekBar(this);
        bar.setMax(max);
        bar.setProgress(start);
        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int progress, boolean fromUser) {
                if (!fromUser) return;
                int v = MrBackdrop.clamp(progress, 0, max);
                value.setText(v + "%");
                onChange.set(v);
            }

            public void onStartTrackingTouch(SeekBar b) {
            }

            public void onStopTrackingTouch(SeekBar b) {
            }
        });
        into.addView(bar, k.wide(4));
        return bar;
    }

    /**
     * The kind chips (glass, outline, gradient), the dots of the styles of the kind chosen with the one of the colour the person picks at the end, the name
     * of the style chosen and, for the gradient of the person's own colour, the line of the colour where it ends. Made again at every change. {@code pale}: the
     * background needs dark ink, so the dots are colours that the person's own style takes (see {@link #choosePreset}).
     */
    private void fillKeys(final LinearLayout box, final boolean pale, final int[] suggested, final int[] style, final MrKeyLook[] look, final Runnable redraw, final Runnable[] draw) {
        box.removeAllViews();
        int kind = MrBackdrop.kindOf(style[0]);
        // two levels: the kind (glass, outline, gradient) as chips, then the colours of that kind as dots, and the name of the one chosen under them
        LinearLayout kinds = k.row();
        box.addView(kinds, k.wide(8));
        for (int i = 0; i < MrBackdrop.KINDS; i++) {
            final int n = i;
            TextView c = k.chip(kindName(this, n), n == kind, new View.OnClickListener() {
                public void onClick(View v) {
                    if (MrBackdrop.kindOf(style[0]) == n) return;
                    choosePreset(MrBackdrop.KIND_FIRST[n], pale, style, look);
                    redraw.run();
                    draw[0].run();
                }
            });
            LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
            if (n > 0) p.setMargins(k.dp(8), 0, 0, 0);
            kinds.addView(c, p);
        }
        // the colours of the kind on the left (they scroll when they do not fit) and the round button of the picker of the person's own on the right
        LinearLayout colours = k.row();
        colours.setGravity(Gravity.CENTER_VERTICAL);
        box.addView(colours, k.wide(10));
        HorizontalScrollView scroll = new HorizontalScrollView(this);
        scroll.setHorizontalScrollBarEnabled(false);
        LinearLayout dots = k.row();
        scroll.addView(dots, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        colours.addView(scroll, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        final int shown = presetShown(kind, pale, style[0], look[0]);
        for (int i = MrBackdrop.KIND_FIRST[kind]; i < MrBackdrop.KIND_FIRST[kind + 1]; i++) {
            final int n = i;
            MrStyleDot dot = new MrStyleDot(this, n, n == shown, k.accent);
            dot.setContentDescription(styleName(this, n));
            dot.setClickable(true);
            dot.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    choosePreset(n, pale, style, look);
                    redraw.run();
                    draw[0].run();
                }
            });
            addDot(dots, dot, i > MrBackdrop.KIND_FIRST[kind]);
        }
        // the colour that the person picks: touching it opens the picker, with the colour that the keys have now; the style of the person's own colour is the
        // one chosen as soon as the colour is moved (the opacity of the keys is in the picker as well, and moving it leaves the style as it is)
        final int own = MrBackdrop.ownStyle(kind);
        MrStyleDot pick = new MrStyleDot(this, own, own == style[0] && shown < 0, k.accent, look[0].hue, look[0].hue2);
        pick.setContentDescription(k.t("mr_themes_pick_color"));
        pick.setClickable(true);
        pick.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showColorPicker(k.t("mr_themes_pick_color"), PICK_HUE, style, look, redraw, draw);
            }
        });
        LinearLayout.LayoutParams pp = new LinearLayout.LayoutParams(k.dp(MrStyleDot.SIZE_DP), k.dp(MrStyleDot.SIZE_DP));
        pp.setMargins(k.dp(12), 0, 0, 0);
        colours.addView(pick, pp);
        TextView label = k.label(styleName(this, shown >= 0 ? shown : style[0]), 14f, k.text2, false);
        label.setGravity(Gravity.CENTER);
        box.addView(label, k.wide(4));
        if (suggested.length > 0) {
            // the colours that stand out in the background, as the person's own colour of the kind that is open: touching one chooses it (the opacity stays)
            box.addView(k.label(k.t("mr_themes_from_background"), 14f, k.text2, false), k.wide(12));
            LinearLayout row = k.row();
            box.addView(row, k.wide(6));
            for (int i = 0; i < suggested.length; i++) {
                final int rgb = suggested[i];
                boolean chosen = style[0] == own && (look[0].hue & 0xffffff) == (rgb & 0xffffff);
                MrStyleDot dot = new MrStyleDot(this, own, chosen, k.accent, rgb, look[0].hue2).swatch();
                dot.setContentDescription(k.t("mr_themes_from_background") + " #" + String.format("%06X", rgb & 0xffffff));
                dot.setClickable(true);
                dot.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        chooseSuggested(rgb, style, look);
                        redraw.run();
                        draw[0].run();
                    }
                });
                addDot(row, dot, i > 0);
            }
        }
        if (style[0] == MrBackdrop.ownStyle(MrBackdrop.KIND_GRADIENT)) {
            // the end of the gradient: the one the keyboard makes up until the person picks it
            int end = look[0].hue2 != 0 ? look[0].hue2 : 0;
            box.addView(k.label(k.t("mr_themes_grad_end"), 14f, k.text2, false), k.wide(12));
            box.addView(colourLine(end, look[0].hue2 == 0, PICK_HUE2, style, look, redraw, draw), k.wide(6));
        }
    }

    /**
     * Chooses the preset {@code n}: its style, and the line that goes with its colour (the same colour, one tone above). On a background with dark ink
     * ({@code pale}) the presets other than the clear glass are not themes of their own: the style of the person's own colour of their kind is chosen, with
     * their colour (and the end of a gradient) as its colours.
     */
    static void choosePreset(int n, boolean pale, int[] style, MrKeyLook[] look) {
        if (pale && n != 0) {
            int kind = MrBackdrop.kindOf(n);
            style[0] = MrBackdrop.ownStyle(kind);
            MrKeyLook l = look[0].withHue(MrBackdrop.presetColour(n, true));
            if (kind == MrBackdrop.KIND_GRADIENT) l = l.withHue2(MrBackdrop.presetEnd(n, true));
            look[0] = l.withLine(MrKeyLook.lineFor(style[0], l.hue));
        } else {
            style[0] = n;
            look[0] = look[0].withLine(MrKeyLook.lineFor(n, look[0].hue));
        }
    }

    /**
     * Chooses a colour that was suggested from the background: the style of the person's own colour of the kind that is open, with that colour and the
     * line that goes with it (as when the colour is picked). The opacities are the ones that the keys have (a colour does not change them).
     */
    static void chooseSuggested(int rgb, int[] style, MrKeyLook[] look) {
        style[0] = MrBackdrop.ownStyle(MrBackdrop.kindOf(style[0]));
        look[0] = withPicked(look[0], PICK_HUE, style[0], rgb);
    }

    /**
     * The preset of the kind {@code kind} that the keys are in: the style itself, or, on a background with dark ink (where a preset chosen is the person's own
     * colour of its kind), the one whose colours are the person's own now. -1 when none is (the person's own colour is).
     */
    static int presetShown(int kind, boolean pale, int style, MrKeyLook look) {
        if (!pale || style == 0) return MrBackdrop.isOwnStyle(style) ? -1 : style;
        if (!MrBackdrop.isOwnStyle(style)) return style;
        for (int n = MrBackdrop.KIND_FIRST[kind]; n < MrBackdrop.KIND_FIRST[kind + 1]; n++) {
            if (n == 0) continue;
            boolean same = look.hue == (0xff000000 | MrBackdrop.presetColour(n, true));
            if (kind == MrBackdrop.KIND_GRADIENT) same = same && look.hue2 == (0xff000000 | MrBackdrop.presetEnd(n, true));
            if (same) return n;
        }
        return -1;
    }

    /** The colour of the line of the keys: "Automatic" (the line of the style) on the left and the round button of the picker on the right. */
    private void fillLine(LinearLayout box, int[] style, MrKeyLook[] look, Runnable redraw, Runnable[] draw) {
        box.removeAllViews();
        box.addView(colourLine(look[0].line, look[0].line == 0, PICK_LINE, style, look, redraw, draw), k.wide(0));
    }

    /** The colour of the letters and of the icons of the toolbar: "Automatic" (the colour of the theme) on the left and the round button of the picker on the right. */
    private void fillText(LinearLayout box, int[] style, MrKeyLook[] look, Runnable redraw, Runnable[] draw) {
        box.removeAllViews();
        box.addView(colourLine(look[0].text, look[0].text == 0, PICK_TEXT, style, look, redraw, draw), k.wide(0));
    }

    private void addDot(LinearLayout dots, View dot, boolean gap) {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(k.dp(MrStyleDot.SIZE_DP), k.dp(MrStyleDot.SIZE_DP));
        if (gap) p.setMargins(k.dp(12), 0, 0, 0);
        dots.addView(dot, p);
    }

    /**
     * A line of a colour: "Automatic" on the left (on when no colour was picked; touching it lets the colour go) and the round button that opens the picker
     * on the right (the colour that was picked, if any).
     */
    private LinearLayout colourLine(int colour, boolean auto, final int which, final int[] style, final MrKeyLook[] look, final Runnable redraw, final Runnable[] draw) {
        LinearLayout line = k.row();
        line.setGravity(Gravity.CENTER_VERTICAL);
        TextView autoChip = k.chip(k.t("mr_themes_auto"), auto, new View.OnClickListener() {
            public void onClick(View v) {
                look[0] = withColor(look[0], which, 0);
                redraw.run();
                draw[0].run();
            }
        });
        line.addView(autoChip, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        line.addView(new View(this), new LinearLayout.LayoutParams(0, 1, 1f));
        MrColorDot dot = new MrColorDot(this, colour);
        dot.setContentDescription(k.t("mr_themes_pick_color"));
        dot.setClickable(true);
        dot.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showColorPicker(k.t("mr_themes_pick_color"), which, style, look, redraw, draw);
            }
        });
        line.addView(dot, new LinearLayout.LayoutParams(k.dp(MrColorDot.SIZE_DP), k.dp(MrColorDot.SIZE_DP)));
        return line;
    }

    /** What the picker colours: the letters and the icons of the toolbar, the colour of the keys of the person's own, the end of its gradient, the line of the keys. */
    static final int PICK_TEXT = 0, PICK_HUE = 1, PICK_HUE2 = 2, PICK_LINE = 3;

    /** {@code look} with the colour {@code which} set to {@code rgb} (0 = none). */
    static MrKeyLook withColor(MrKeyLook look, int which, int rgb) {
        return which == PICK_TEXT ? look.withText(rgb) : which == PICK_HUE ? look.withHue(rgb) : which == PICK_LINE ? look.withLine(rgb) : look.withHue2(rgb);
    }

    /**
     * The same, for a colour picked in the picker: the colour of the keys of the person's own takes its line with it (the same colour one tone above,
     * for the style {@code style}, as when a colour of the list is chosen).
     */
    static MrKeyLook withPicked(MrKeyLook look, int which, int style, int rgb) {
        MrKeyLook now = withColor(look, which, rgb);
        return which == PICK_HUE ? now.withLine(MrKeyLook.lineFor(style, rgb)) : now;
    }

    /** The colour {@code which} of {@code look} (0 = none). */
    static int colorOf(MrKeyLook look, int which) {
        return which == PICK_TEXT ? look.text : which == PICK_HUE ? look.hue : which == PICK_LINE ? look.line : look.hue2;
    }

    /**
     * The picker of a colour, over the dialog of the background, which stays where it is: the keyboard in it follows the finger, "Done" keeps the colour
     * and "Cancel" (or back) gives the one there was back. The colour of the keys and the colour of their line have the bar of their opacity under the picker
     * (it starts at the opacity they have now, so choosing a colour does not change it). The colour of the keys of a preset starts at the colour of the
     * preset, and it is the person's own colour only once it is moved; a colour that was not moved is left as it was ("Automatic" stays so).
     */
    void showColorPicker(String title, final int which, final int[] style, final MrKeyLook[] look, final Runnable redraw, final Runnable[] draw) {
        closePicker();
        final MrKeyLook before = look[0];
        final int styleBefore = style[0];
        final boolean pale = mDialogPale;
        int start = colorOf(before, which);
        if (which == PICK_HUE && !MrBackdrop.isOwnStyle(style[0])) {
            // a preset is not the person's colour yet: the picker starts at the colour that the keys have
            start = MrBackdrop.presetColour(style[0], pale);
        } else if (start == 0) {
            if (which == PICK_TEXT) start = pale ? 0xff202124 : 0xffffffff;
            else if (which == PICK_HUE) start = MrBackdrop.OWN_DEFAULT;
            else if (which == PICK_LINE) {
                // the line that goes with the colour of the keys, or white (a dark slate on a pale background) where the style has none to go with
                int goes = MrKeyLook.lineFor(style[0], before.hue);
                start = goes != 0 ? goes : pale ? MrBackdrop.DARK_SLATE : 0xffffffff;
            } else start = MrKeyLook.partner(before.hue != 0 ? before.hue : MrBackdrop.OWN_DEFAULT);
        }
        final Dialog p = newDialog(false);
        Window w = p.getWindow();
        // the keyboard under it is looked at while the colour is moved, so it is not dimmed
        if (w != null) w.clearFlags(android.view.WindowManager.LayoutParams.FLAG_DIM_BEHIND);
        LinearLayout pbox = sheetBox(title);
        final MrColorPicker cp = new MrColorPicker(this);
        cp.setColor(start);
        // the opacity: of the face of the keys for the colour of the keys, of the line for the colour of the line (none for the others)
        final boolean hasOpacity = which == PICK_HUE || which == PICK_LINE;
        final MrOpacityBar bar = hasOpacity ? new MrOpacityBar(this, MrKeyLook.OPACITY_MAX, MrKeyLook.OPACITY_DEFAULT) : null;
        final TextView value = hasOpacity ? k.label("", 15f, k.text2, false) : null;
        final boolean[] moved = {false};
        cp.setListener(new MrColorPicker.Listener() {
            public void onColor(int rgb) {
                moved[0] = true;
                // the keys have the person's own colour of their kind from the moment that it is moved
                if (which == PICK_HUE && !MrBackdrop.isOwnStyle(style[0])) style[0] = MrBackdrop.ownStyle(MrBackdrop.kindOf(style[0]));
                look[0] = withPicked(look[0], which, style[0], rgb);
                if (bar != null) bar.setColor(rgb);
                redraw.run();
            }
        });
        pbox.addView(cp, k.wide(16));
        if (hasOpacity) {
            int now = which == PICK_HUE ? before.key : before.edge;
            LinearLayout line = k.row();
            line.addView(k.label(k.t(which == PICK_HUE ? "mr_themes_key_opacity" : "mr_themes_edge_opacity"), 14f, k.text2, false),
                    new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
            value.setText(now + "%");
            line.addView(value, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            pbox.addView(line, k.wide(14));
            bar.setColor(start);
            bar.setValue(now);
            bar.setListener(new MrOpacityBar.Listener() {
                public void onOpacity(int percent) {
                    look[0] = which == PICK_HUE ? look[0].withKey(percent) : look[0].withEdge(percent);
                    value.setText(percent + "%");
                    redraw.run();
                }
            });
            pbox.addView(bar, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, k.dp(MrOpacityBar.BAR_DP)));
        }
        LinearLayout buttons = k.row();
        pbox.addView(buttons, k.wide(18));
        final Runnable cancelNow = new Runnable() {
            public void run() {
                look[0] = before;
                style[0] = styleBefore;
                redraw.run();
                closePicker();
                draw[0].run();
            }
        };
        TextView cancel = k.button(k.t("mr_themes_cancel"), false, new View.OnClickListener() {
            public void onClick(View v) {
                cancelNow.run();
            }
        });
        TextView ok = k.button(k.t("mr_themes_done"), true, new View.OnClickListener() {
            public void onClick(View v) {
                // the colour that was not moved stays as it was where it has a way of being nothing: "Automatic" (the line), a preset (the keys)
                if (moved[0] || !hasOpacity) {
                    if (which == PICK_HUE && !MrBackdrop.isOwnStyle(style[0])) style[0] = MrBackdrop.ownStyle(MrBackdrop.kindOf(style[0]));
                    look[0] = withPicked(look[0], which, style[0], cp.color());
                }
                redraw.run();
                closePicker();
                draw[0].run();
            }
        });
        LinearLayout.LayoutParams left = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        left.setMargins(0, 0, k.dp(6), 0);
        LinearLayout.LayoutParams right = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        right.setMargins(k.dp(6), 0, 0, 0);
        buttons.addView(cancel, left);
        buttons.addView(ok, right);
        p.setContentView(pbox);
        p.setOnCancelListener(new DialogInterface.OnCancelListener() {
            public void onCancel(DialogInterface dialog) {
                if (mPicker == p) cancelNow.run();
            }
        });
        mPicker = p;
        mPickerView = cp;
        mPickerOpacity = bar;
        mPickerOpacityValue = value;
        mPickerOk = ok;
        mPickerCancel = cancel;
        p.show();
    }

    /**
     * The picture with the frame of the keyboard over it (drag to move, pinch to resize); "Next" goes on to the preview, where the background is softened
     * (it starts at {@code soft}), "Cancel" and back let the picture go (a waiting one is deleted).
     */
    void showCrop(final Bitmap bitmap, MrBackdrop.Spec start, final int soft, final boolean pending) {
        if (bitmap == null) return;
        closeDialog();
        final Dialog d = newDialog(true);
        LinearLayout root = k.column();
        root.setPadding(k.dp(16), k.dp(24), k.dp(16), k.dp(16));
        TextView hint = k.label(k.t("mr_themes_crop_hint"), 16f, 0xffffffff, false);
        hint.setGravity(Gravity.CENTER);
        root.addView(hint, k.wide(0));
        final MrCropView crop = new MrCropView(this);
        crop.set(bitmap, start.zoom, start.dx, start.dy);
        LinearLayout.LayoutParams area = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f);
        area.setMargins(0, k.dp(14), 0, k.dp(10));
        root.addView(crop, area);

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
                showPreview(MrBackdrop.Spec.image(crop.zoom(), crop.dx(), crop.dy(), stamp), bitmap, soft, pending);
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
