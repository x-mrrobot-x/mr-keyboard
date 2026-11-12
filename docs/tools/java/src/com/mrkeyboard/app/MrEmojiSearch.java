package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.os.Handler;
import android.os.Looper;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Locale;

/**
 * Search and delete of the emoji panel (1.97.0).
 *
 * The emoji panel (MrEmotes, panel mode 4) got a floating bar at the bottom with two buttons: search and delete.
 *  - Delete does what the Backspace key does (LatinIME.onKey with the delete code, with the press feedback and the repeat
 *    while it is held), in the field of the app.
 *  - Search is a panel mode of its own, MODE (7), built like the Fonts tool (MrFonts): the toolbar row is replaced by the
 *    search header (bar_es: back button and title, the results in two rows, the field), the keyboard shows under it, and
 *    what is typed goes to the field of the header through the same redirect the translator uses (MrTools.sRedirect), so
 *    the keyboard works as it always does. Each text change searches again (MrEmojiIndex) and the emojis found replace
 *    those of the card; a tap on one writes it in the app (and in the recents of the panel) and the search stays open.
 *    Back goes back to the emoji panel.
 *
 * The header is taller than the bar: MrBar.expand makes it so while the search is open, and MrBar.restore gives the old
 * height back on the way out (the same two calls serve any other tool that needs more room).
 *
 * The words of the search (res/raw/mr_emoji_*) are read in a background thread when the search opens and dropped when the
 * panel is left, so the keyboard carries nothing for them the rest of the time.
 *
 * Everything runs on the main thread, except the reading of the files.
 */
final class MrEmojiSearch {
    /** Panel mode of the search (0 keyboard, 1 clipboard, 2 translator, 3 attachments, 4 emojis, 6 fonts). */
    static final int MODE = 7;
    private static final int EMOJI_MODE = 4;
    /** The delete code of the keyboard (Keyboard.KEYCODE_DELETE). */
    private static final int DELETE = -5;
    /** Emojis shown at most (the card scrolls sideways). */
    static final int MAX_RESULTS = 60;
    /** Press and repeat of the Backspace key of the keyboard (LatinKeyboardBaseView). */
    static final int REPEAT_START = 400;
    static final int REPEAT_EVERY = 50;
    private static final int CELL_DP = 44;
    private static final int CELL_SP = 26;
    /** Corners of the card: MrTools.radius(p) is 8 dp plus p dp, so 8 gives 16 dp (the other cards of the panels have 10 dp). */
    private static final float CARD_RADIUS_PLUS = 8f;
    /** The header comes in growing upward from its bottom edge while it fades in. */
    static final int ENTER_MS = 240;
    static final float ENTER_FROM = 0.6f;

    private static View sBar;                 // bar_es: the header of the search
    private static View sMainBar;             // bar_main: hidden while the search is open
    private static EditText sField;           // es_field: where the keyboard types
    private static LinearLayout sGrid;        // es_grid: one row per line of results
    private static View sScroll;              // es_scroll: the results, scrolling sideways
    private static TextView sEmpty;           // es_empty: "no emoji found"
    private static Context sCtx;
    private static Handler sHandler;
    private static int sRows = 2;

    private static final ArrayList<TextView> sCells = new ArrayList<TextView>();
    private static MrEmojiIndex sIndex;       // null until the files are read and again after the panel is left
    private static boolean sLoading;
    private static boolean sWanted;           // the emoji panel or the search is open: the words may stay in memory
    private static boolean sOpen;             // the search is open: the keyboard types in the field of the header
    private static TextView sPrevField;       // MrTools.sField before the search (the translator field), given back on leaving

    private static final View.OnClickListener sPick = new View.OnClickListener() {
        public void onClick(View v) {
            if (v instanceof TextView) insert(((TextView) v).getText().toString());
        }
    };
    private static final Runnable sRepeat = new Runnable() {
        public void run() {
            deleteKey();
            if (sHandler != null) sHandler.postDelayed(this, REPEAT_EVERY);
        }
    };
    private static final TextWatcher sWatcher = new TextWatcher() {
        public void beforeTextChanged(CharSequence s, int start, int count, int after) { }
        public void onTextChanged(CharSequence s, int start, int before, int count) { }
        public void afterTextChanged(Editable s) {
            update();
        }
    };

    private MrEmojiSearch() { }

    // ------------------------------------------------------------------ setup

    /**
     * Called by MrTools.wrap with the root of the toolbar, each time a keyboard view is made, and by MrTools.release with no
     * root when the service is destroyed (everything is let go: views, context, the repeat of the delete button).
     *
     * This runs while the keyboard is being made, so nothing that goes wrong in here may leave it: the search is a convenience and
     * the keyboard has to start without it (the same rule as MrKeep and MrGestureInput.init).
     */
    static void setup(View root) {
        forget();
        if (root == null) return;
        try {
            build(root);
        } catch (Throwable t) {
            forget();
        }
    }

    /** Lets go of everything of the search (the state of a keyboard view that is gone). */
    private static void forget() {
        stopRepeat();
        sBar = null;
        sMainBar = null;
        sField = null;
        sGrid = null;
        sScroll = null;
        sEmpty = null;
        sCtx = null;
        sHandler = null;
        sCells.clear();
        sIndex = null;
        sLoading = false;
        sWanted = false;
        sOpen = false;
        sPrevField = null;
    }

    private static void build(View root) {
        View bar = root.findViewWithTag("bar_es");
        View field = root.findViewWithTag("es_field");
        View grid = root.findViewWithTag("es_grid");
        if (bar == null || !(field instanceof EditText) || !(grid instanceof LinearLayout)) return;
        sCtx = root.getContext();
        sHandler = new Handler(Looper.getMainLooper());
        sBar = bar;
        sMainBar = root.findViewWithTag("bar_main");
        sField = (EditText) field;
        sGrid = (LinearLayout) grid;
        sScroll = root.findViewWithTag("es_scroll");
        sEmpty = root.findViewWithTag("es_empty") instanceof TextView ? (TextView) root.findViewWithTag("es_empty") : null;
        sRows = Math.max(1, intRes("mr_es_rows", 2));
        for (int r = 0; r < sRows; r++) {
            LinearLayout row = new LinearLayout(sCtx);
            row.setOrientation(LinearLayout.HORIZONTAL);
            sGrid.addView(row, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, 0, 1f));
        }
        paint(root);
        View back = root.findViewWithTag("es_back");
        if (back != null) back.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                MrTools.showPanel(EMOJI_MODE);
            }
        });
        sField.addTextChangedListener(sWatcher);
        sBar.setVisibility(View.GONE);
        View search = root.findViewWithTag("emote_search");
        if (search != null) search.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                MrTools.showPanel(MODE);
            }
        });
        View del = root.findViewWithTag("emote_del");
        if (del != null) {
            del.setOnTouchListener(new DeleteTouch());
            del.setOnClickListener(new View.OnClickListener() {   // an assistive service "clicks" without a touch
                public void onClick(View v) {
                    deleteKey();
                }
            });
        }
    }

    /** The card of the other panels (same colors, flat themes included) with rounder corners. */
    private static Drawable cardBackground() {
        Drawable d = MrTools.cardBg();
        if (d instanceof GradientDrawable) ((GradientDrawable) d).setCornerRadius(MrTools.radius(CARD_RADIUS_PLUS));
        return d;
    }

    /** The colors of the theme: the same roles the other panels use (MrTools). */
    private static void paint(View root) {
        MrTools.btn(root, "es_back", -1);   // like the back button of the other tool bars
        View card = root.findViewWithTag("es_card");
        if (card != null) card.setBackgroundDrawable(cardBackground());
        View div = root.findViewWithTag("es_div");
        if (div != null) div.setBackgroundColor(MrTheme.color("panel_divider"));
        View title = root.findViewWithTag("es_title");
        if (title instanceof TextView) ((TextView) title).setTextColor(MrTools.sTextColor);
        View icon = root.findViewWithTag("es_icon");
        if (icon instanceof TextView) MrTools.tintColor((TextView) icon, MrTools.sHint);
        sField.setTextColor(MrTools.sTextColor);
        sField.setHintTextColor(MrTools.sHint);
        if (sEmpty != null) sEmpty.setTextColor(MrTools.sHint);
        // the floating bar: a pill, opaque, in a neutral colour of the theme (the face of a letter key, with the border of the fields)
        View fab = root.findViewWithTag("emote_fab");
        if (fab != null) fab.setBackgroundDrawable(MrTools.floatBg());
        // what sits on it takes the colour of the labels of the keys, which is the one that reads on that face
        int ink = MrTools.sKeyText;
        String[] tags = {"emote_search", "emote_del"};
        for (String tag : tags) {
            View b = root.findViewWithTag(tag);
            if (b == null) continue;
            b.setBackgroundDrawable(MrTools.flatPill());   // no fill at rest; round (pill) fill while pressed
            if (b instanceof TextView) MrTools.tintColor((TextView) b, ink);
        }
    }

    // ------------------------------------------------------------------ panel modes

    /** Called by MrTools.showPanel before the panels change: opens the search for MODE and closes it for any other mode. */
    static void onPanel(int mode) {
        if (sBar == null) return;
        try {
            stopRepeat();
            if (mode == MODE) {
                if (!sOpen) open();
                return;
            }
            if (sOpen) close();
            if (mode != EMOJI_MODE) release();   // out of the emoji panel: the words of the search are dropped
        } catch (Throwable t) {
            abandon();   // showPanel also runs when a field is bound (MrTools.reset): the keyboard must not fail because of the search
        }
    }

    /** After an error: the keyboard goes back to typing in the app, the header is closed and the search is forgotten. */
    private static void abandon() {
        try {
            if (sOpen) {
                MrTools.sRedirect = null;
                MrTools.sField = sPrevField;
            }
            if (sBar != null) {
                sBar.setVisibility(View.GONE);
                MrBar.restore(sBar);
            }
        } catch (Throwable t) {
            // nothing else to do: the state is dropped below
        }
        forget();
    }

    /**
     * Called by MrTools.showPanel at the end: the main bar stays hidden while the search is open and the keyboard shows
     * under the header (showPanel hides it for every mode but 0), as the Fonts tool does.
     */
    static void afterPanel(int mode) {
        if (mode != MODE || sBar == null) return;
        try {
            if (sMainBar != null) sMainBar.setVisibility(View.GONE);
            View kbd = MrTools.sKbd;
            if (kbd != null) kbd.setVisibility(View.VISIBLE);
        } catch (Throwable t) {
            abandon();
        }
    }

    private static void open() {
        sOpen = true;
        sWanted = true;
        LatinIME ime = MrTools.sIme;
        if (ime != null) ime.mrCommit();            // the word being typed in the app goes in before the keyboard changes field
        sPrevField = MrTools.sField;
        MrTools.sField = sField;                    // sendKey (the keys that are events) goes to this field
        sField.setText("");
        int height = heightPx();
        sBar.setVisibility(View.VISIBLE);
        MrBar.expand(sBar, height);
        enter(height);
        MrTools.sRedirect = sField.onCreateInputConnection(new EditorInfo());
        sField.requestFocus();
        ensureLoaded();
        update();
    }

    private static void close() {
        sOpen = false;
        LatinIME ime = MrTools.sIme;
        if (MrTools.sRedirect != null && ime != null) ime.mrCommit();   // the word typed in the field, as leaving the translator does
        MrTools.sRedirect = null;
        MrTools.sField = sPrevField;
        sPrevField = null;
        sField.setText("");
        settle();
        sBar.setVisibility(View.GONE);
        MrBar.restore(sBar);
    }

    /**
     * The header grows upward from its bottom edge (the window is already as tall as it will be, so only the drawing moves,
     * the keyboard is not resized on each frame) and fades in, so it does not pop in. With the animations of the system off
     * the animator ends at once.
     */
    private static void enter(int height) {
        sBar.animate().cancel();
        sBar.setPivotY(height);
        sBar.setScaleY(ENTER_FROM);
        sBar.setAlpha(0f);
        sBar.animate().alpha(1f).scaleY(1f).setDuration(ENTER_MS).start();
    }

    /** Ends an entrance that is still running and leaves the header as the layout made it (for the next time it opens). */
    private static void settle() {
        sBar.animate().cancel();
        sBar.setScaleY(1f);
        sBar.setAlpha(1f);
    }

    private static void release() {
        sWanted = false;
        sIndex = null;
    }

    // ------------------------------------------------------------------ results

    /** The emojis for what is in the field: the best matches, or the recent ones while it is empty. */
    private static void update() {
        if (!sOpen || sField == null) return;
        String q = sField.getText().toString();
        if (MrEmojiIndex.normalize(q).length() == 0) {
            show(recents(), false);
            return;
        }
        if (sIndex == null) {
            show(new String[0], false);   // the words are still being read: the results come when they are
            return;
        }
        show(MrEmojiNew.filter(sIndex.search(q, language(), MAX_RESULTS)), true);   // not the ones this phone cannot draw
    }

    private static void show(String[] found, boolean asked) {
        while (sCells.size() < found.length) sCells.add(newCell(sCells.size()));
        for (int i = 0; i < sCells.size(); i++) {
            TextView c = sCells.get(i);
            if (i < found.length) {
                c.setText(found[i]);
                c.setVisibility(View.VISIBLE);
            } else {
                c.setVisibility(View.GONE);
            }
        }
        if (sScroll != null) sScroll.scrollTo(0, 0);
        if (sEmpty != null) sEmpty.setVisibility(asked && found.length == 0 ? View.VISIBLE : View.GONE);
    }

    private static TextView newCell(int index) {
        TextView c = new TextView(sCtx);
        c.setTextSize(CELL_SP);
        c.setGravity(Gravity.CENTER);
        c.setSingleLine(true);
        c.setOnClickListener(sPick);
        ((LinearLayout) sGrid.getChildAt(index % sRows)).addView(c, new LinearLayout.LayoutParams(dp(CELL_DP), ViewGroup.LayoutParams.MATCH_PARENT));
        return c;
    }

    /** Recent emojis of the panel; with none yet, the first of the first category. */
    private static String[] recents() {
        ArrayList<String> r = MrEmotes.sRecent;
        ArrayList<String> out = new ArrayList<String>();
        if (r != null) {
            for (int i = 0; i < r.size() && out.size() < MAX_RESULTS; i++) out.add(r.get(i));
        }
        if (out.isEmpty()) {
            String all = MrEmotes.data(0);
            if (all != null && all.length() > 0) {
                String[] list = all.split("[|]");
                for (int i = 0; i < list.length && i < 2 * 12; i++) out.add(list[i]);
            }
        }
        return out.toArray(new String[out.size()]);
    }

    /** Writes the emoji in the app (not in the field of the search: the redirect is skipped) and in the recents; the search stays open. */
    static void insert(String emoji) {
        if (emoji == null || emoji.length() == 0) return;
        LatinIME ime = MrTools.sIme;
        InputConnection ic = ime == null ? null : ime.getAppInputConnection();
        if (ic == null) return;
        ic.finishComposingText();
        ic.commitText(emoji, 1);
        MrEmotes.addRecent(emoji);
    }

    // ------------------------------------------------------------------ the words of the search

    private static void ensureLoaded() {
        if (sIndex != null || sLoading || sCtx == null) return;
        sLoading = true;
        final Resources res = sCtx.getResources();
        final String pkg = sCtx.getPackageName();
        Thread t = new Thread(new Runnable() {
            public void run() {
                MrEmojiIndex x = null;
                try {
                    InputStream[] in = new InputStream[MrEmojiIndex.LANGS.length];
                    for (int l = 0; l < in.length; l++) {
                        int id = res.getIdentifier("mr_emoji_" + MrEmojiIndex.LANGS[l], "raw", pkg);
                        in[l] = id == 0 ? null : res.openRawResource(id);
                    }
                    x = MrEmojiIndex.parse(in);
                } catch (java.io.IOException e) {
                    x = null;
                } catch (RuntimeException e) {
                    x = null;
                }
                final MrEmojiIndex built = x;
                if (sHandler != null) sHandler.post(new Runnable() {
                    public void run() {
                        loaded(built);
                    }
                });
            }
        });
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    /** The words arrived (main thread): kept while the panel is open, dropped if it was left meanwhile. */
    static void loaded(MrEmojiIndex built) {
        sLoading = false;
        if (!sWanted) return;
        sIndex = built;
        if (sOpen) update();
    }

    /** The language of the app: wins a tie among results. */
    private static String language() {
        if (sCtx == null) return "";
        android.content.res.Configuration c = sCtx.getResources().getConfiguration();
        Locale l = c == null ? null : c.locale;
        return l == null ? "" : l.getLanguage();
    }

    // ------------------------------------------------------------------ delete

    /** The Backspace key of the keyboard, in the app. */
    private static void deleteKey() {
        LatinIME ime = MrTools.sIme;
        if (ime != null) ime.onKey(DELETE, new int[] {DELETE}, -1, -1);
    }

    private static void stopRepeat() {
        if (sHandler != null) sHandler.removeCallbacks(sRepeat);
    }

    /** Press: the feedback of the key, one delete, and the repeat after the pause of the key. Release or cancel: stop. */
    private static final class DeleteTouch implements View.OnTouchListener {
        public boolean onTouch(View v, MotionEvent e) {
            int a = e.getActionMasked();
            LatinIME ime = MrTools.sIme;
            if (a == MotionEvent.ACTION_DOWN) {
                v.setAlpha(0.6f);
                if (ime != null) ime.onPress(DELETE);
                deleteKey();
                if (sHandler != null) {
                    sHandler.removeCallbacks(sRepeat);
                    sHandler.postDelayed(sRepeat, REPEAT_START);
                }
                return true;
            }
            if (a == MotionEvent.ACTION_UP || a == MotionEvent.ACTION_CANCEL) {
                v.setAlpha(1f);
                stopRepeat();
                if (ime != null) ime.onRelease(DELETE);
                return true;
            }
            return true;
        }
    }

    // ------------------------------------------------------------------ sizes

    private static int heightPx() {
        Resources r = sCtx.getResources();
        int id = r.getIdentifier("mr_es_height", "dimen", sCtx.getPackageName());
        return id == 0 ? dp(184) : (int) (r.getDimension(id) + 0.5f);
    }

    private static int intRes(String name, int fallback) {
        Resources r = sCtx.getResources();
        int id = r.getIdentifier(name, "integer", sCtx.getPackageName());
        return id == 0 ? fallback : r.getInteger(id);
    }

    private static int dp(int v) {
        float d = sCtx.getResources().getDisplayMetrics().density;
        return (int) (v * d + 0.5f);
    }
}
