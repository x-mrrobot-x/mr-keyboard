package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.drawable.Drawable;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * The dialog where the person chooses "every app" or one app ("Add to" on the screen "Add words and texts"; the same dialog, with the apps that have
 * words, filters "What the keyboard learned"). The first row is every app; under it, the apps with their icon and name and a field to search them.
 *
 * The apps are drawn {@link #PAGE} at a time: when the person scrolls to {@link MrKit#NEAR_END_DP} dp before the last card, the next ones are added at the
 * end (nothing is redrawn, so the page does not jump). The list is made off the main thread when the dialog opens ({@link Source}); a source may answer
 * more than once (MrAppCache: what was kept at once, then the changes) and every answer replaces the list: the rows that appeared or went away are
 * added or removed, and what the person typed in the search field and the page they reached stay. Nothing of the list is kept after the dialog is closed
 * (the cache of the apps is in the database, not here). The icons are loaded one at a time by a thread, for the new rows only; a row that is gone by then is
 * not touched, and closing the dialog stops that thread at the next icon.
 */
final class MrAppPicker {
    /** The choice: the package of the app, or null for every app. */
    interface Pick {
        void onPick(String pkg);
    }

    /** Receives a list of apps (any thread); every call replaces the list that was shown. */
    interface Sink {
        void publish(List<MrAppList.Entry> list);
    }

    /** Where the apps come from (run off the main thread): the apps of the phone, or the apps that already have words. It answers through the sink, once or more. */
    interface Source {
        void load(Sink sink);
    }

    /** A source that answers once, with {@link #list}. */
    abstract static class Once implements Source {
        abstract List<MrAppList.Entry> list();

        public void load(Sink sink) {
            sink.publish(list());
        }
    }

    /** How many apps are drawn at a time. */
    static final int PAGE = 30;
    /** With this many apps or fewer there is no search field: the whole list is on the screen. */
    static final int SEARCH_FROM = 8;

    private final Activity act;
    private final MrKit k;
    private final String mCurrent;
    private final Pick mPick;
    private final String mEmpty;
    private AlertDialog mDialog;
    private LinearLayout mListBox;
    private TextView mStatus;
    private MrPage mScroll;
    private EditText mSearch;
    private List<MrAppList.Entry> mAll;
    private List<MrAppList.Entry> mMatches;
    private int mLimit = PAGE;
    /** How many rows of mMatches are drawn. */
    private int mCount;
    private volatile boolean mClosed;
    /** Counts the drawings of the list: the thread of the icons of an older drawing stops at its next icon. */
    private volatile int mDrawn;

    private MrAppPicker(MrKit kit, String current, String emptyText, Pick pick) {
        k = kit;
        act = kit.act;
        mCurrent = current;
        mEmpty = emptyText;
        mPick = pick;
    }

    /**
     * Opens the dialog. {@code current}: the package that is chosen now (null = every app). {@code title}, {@code emptyText}: its texts. Returns the picker
     * (the tests read its dialog); the dialog is already on the screen with "Loading apps…".
     */
    static MrAppPicker show(MrKit kit, String current, String title, String emptyText, final Source source, Pick pick) {
        final MrAppPicker p = new MrAppPicker(kit, current, emptyText, pick);
        p.open(title);
        Thread th = new Thread(new Runnable() {
            public void run() {
                final boolean[] answered = new boolean[1];
                final Sink sink = new Sink() {
                    public void publish(List<MrAppList.Entry> list) {
                        answered[0] = true;
                        final List<MrAppList.Entry> done = list == null ? new ArrayList<MrAppList.Entry>() : list;
                        p.act.runOnUiThread(new Runnable() {
                            public void run() {
                                p.loaded(done);
                            }
                        });
                    }
                };
                try {
                    source.load(sink);
                } catch (RuntimeException e) {
                    // what was answered stays
                }
                if (!answered[0]) sink.publish(new ArrayList<MrAppList.Entry>());
            }
        }, "MrAppList");
        th.setPriority(Thread.MIN_PRIORITY);
        th.start();
        return p;
    }

    AlertDialog dialog() {
        return mDialog;
    }

    private void open(String title) {
        final LinearLayout box = k.column();
        box.setPadding(k.dp(20), k.dp(8), k.dp(20), k.dp(4));
        final MrPage scroll = new MrPage(act);
        mScroll = scroll;
        scroll.addView(box, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        // every app: always there, first, with the mark when it is the choice
        box.addView(k.item(k.t("mr_app_all"), mCurrent == null ? "✓" : "", new View.OnClickListener() {
            public void onClick(View v) {
                choose(null);
            }
        }), k.wide(0));
        box.addView(k.label(k.t("mr_app_only"), 13f, k.text2, false), k.wide(16));

        mSearch = k.field(k.t("mr_app_search"), InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        mSearch.setSingleLine(true);
        mSearch.setVisibility(View.GONE);
        mSearch.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            public void afterTextChanged(Editable s) {
                if (mAll == null) return;
                mMatches = MrAppList.filter(mAll, s == null ? "" : s.toString());
                mLimit = PAGE;
                draw();
            }
        });
        box.addView(mSearch, k.wide(8));
        mStatus = k.label(k.t("mr_app_loading"), 14f, k.text2, false);
        mStatus.setPadding(k.dp(4), k.dp(12), k.dp(4), k.dp(12));
        box.addView(mStatus, k.wide(0));
        mListBox = k.column();
        box.addView(mListBox, k.wide(8));
        // the next page comes by itself when the person scrolls near the last card
        k.onScroll(scroll, new Runnable() {
            public void run() {
                checkMore();
            }
        });
        // a fling that would reach the last card finds the next page there already
        scroll.setPager(new MrPage.Pager() {
            public boolean more() {
                return addPage();
            }
        });

        AlertDialog d = new AlertDialog.Builder(act)
                .setTitle(title)
                .setView(scroll)
                .setNegativeButton(k.t("mr_words_cancel"), null)
                .create();
        d.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public void onDismiss(DialogInterface dialog) {
                // nothing of the list is kept
                mClosed = true;
                mAll = null;
                mMatches = null;
                mListBox.removeAllViews();
            }
        });
        mDialog = d;
        d.show();
    }

    /** A list arrived (main thread): the first one, or a newer one that replaces it (the search and the page reached stay). */
    private void loaded(List<MrAppList.Entry> all) {
        if (mClosed || act.isFinishing()) return;
        if (mAll != null && MrAppCache.same(mAll, all)) return;
        mAll = all;
        mMatches = MrAppList.filter(all, mSearch.getText() == null ? "" : mSearch.getText().toString());
        mSearch.setVisibility(all.size() > SEARCH_FROM ? View.VISIBLE : View.GONE);
        draw();
    }

    private void choose(String pkg) {
        AlertDialog d = mDialog;
        if (d != null) d.dismiss();
        mPick.onPick(pkg);
    }

    /** Draws the rows of the matches from the first one up to the page reached ({@link #mLimit}), and the note when there are none. */
    private void draw() {
        final List<MrAppList.Entry> list = mMatches;
        mDrawn++;
        mScroll.release();      // drawn again from the start: the place of the last cards is not kept
        mListBox.removeAllViews();
        mCount = 0;
        if (list == null) return;
        final int from = 0;
        append(list, from, Math.min(list.size(), mLimit));
        mStatus.setText(list.isEmpty() ? (mAll != null && mAll.isEmpty() ? mEmpty : k.t("mr_app_none")) : "");
        mStatus.setVisibility(list.isEmpty() ? View.VISIBLE : View.GONE);
    }

    /** Adds the rows from..to of the list at the end and loads their icons. */
    private void append(List<MrAppList.Entry> list, int from, int to) {
        final ArrayList<MrAppList.Entry> entries = new ArrayList<MrAppList.Entry>();
        final ArrayList<ImageView> icons = new ArrayList<ImageView>();
        for (int i = from; i < to; i++) {
            final MrAppList.Entry e = list.get(i);
            mListBox.addView(row(e, icons), k.wide(i == 0 ? 0 : 6));
            entries.add(e);
        }
        mCount = to;
        if (!entries.isEmpty()) loadIcons(entries, icons);
        // a page that does not fill the dialog asks for the next one (only once the dialog has a size)
        if (mCount < list.size() && mScroll.getHeight() > 0) {
            mScroll.post(new Runnable() {
                public void run() {
                    checkMore();
                }
            });
        }
    }

    /** More apps to show and the person is near the last card: the next page. */
    private void checkMore() {
        if (k.nearEnd(mScroll, mListBox)) addPage();
    }

    /** Adds the next page of apps at the end of the list; false when there is none. */
    private boolean addPage() {
        final List<MrAppList.Entry> list = mMatches;
        if (mClosed || list == null || mCount >= list.size()) return false;
        mLimit += PAGE;
        final int from = mCount;
        final int to = Math.min(list.size(), mLimit);
        // the page stays where it is while the cards are added at its end
        mScroll.keepPosition(new Runnable() {
            public void run() {
                append(list, from, to);
            }
        });
        return true;
    }

    private View row(final MrAppList.Entry e, ArrayList<ImageView> icons) {
        LinearLayout r = k.row();
        r.setPadding(k.dp(14), k.dp(10), k.dp(14), k.dp(10));
        r.setBackground(k.round(k.card, k.stroke, 14, false));
        r.setClickable(true);
        r.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                choose(e.pkg);
            }
        });
        ImageView icon = new ImageView(act);
        LinearLayout.LayoutParams ip = new LinearLayout.LayoutParams(k.dp(36), k.dp(36));
        ip.setMargins(0, 0, k.dp(12), 0);
        r.addView(icon, ip);
        icons.add(icon);
        TextView name = k.label(e.label, 16f, k.text, false);
        r.addView(name, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        String note = e.pkg.equals(mCurrent) ? "✓" : e.note;
        if (note != null && note.length() > 0) {
            TextView n = k.label(note, 13f, k.text2, false);
            n.setPadding(k.dp(10), 0, 0, 0);
            r.addView(n, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        }
        return r;
    }

    /** One thread loads the icons of the rows just drawn, one after the other; a row that was redrawn or a dialog that was closed in the meantime is left alone. */
    private void loadIcons(final ArrayList<MrAppList.Entry> entries, final ArrayList<ImageView> views) {
        final int drawing = mDrawn;
        Thread th = new Thread(new Runnable() {
            public void run() {
                for (int i = 0; i < entries.size(); i++) {
                    if (mClosed || drawing != mDrawn) return;
                    final Drawable d = MrAppList.icon(act, entries.get(i).pkg);
                    if (d == null) continue;
                    final ImageView v = views.get(i);
                    act.runOnUiThread(new Runnable() {
                        public void run() {
                            if (!mClosed && drawing == mDrawn) v.setImageDrawable(d);
                        }
                    });
                }
            }
        }, "MrAppIcons");
        th.setPriority(Thread.MIN_PRIORITY);
        th.start();
    }
}
