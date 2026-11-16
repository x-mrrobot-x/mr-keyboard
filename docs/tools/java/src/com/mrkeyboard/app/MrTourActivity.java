package com.mrkeyboard.app;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * "First steps": the screen that asks, once, for what suggestions, gesture typing and delete by word need (the rules are in MrTour). One
 * card per step, "Step 1 of 3" with a bar of segments, and for each card the choices: Download (or Keep on), Turn off, and "Skip" at the
 * top, which closes everything and leaves the options as they are. Plain views built in code with MrKit, in the palette of the settings.
 *
 * <p>The download runs in MrTour (statics), so the screen only shows it: while it runs a handler paints it again every 400 ms; the screen
 * can be turned, left or closed with the file still coming. Nothing here connects to the network except the button "Download".
 */
public class MrTourActivity extends Activity {
    private static final String S_STEPS = "mr_tour_steps";
    private static final String S_INDEX = "mr_tour_index";

    private MrKit k;
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private ArrayList<String> mSteps = new ArrayList<String>();
    private int mIndex;
    private LinearLayout mCol;
    /** What the screen shows now (see {@link #signature}): it is drawn again only when it changes, so a tap is never lost to a redraw. */
    private String mSig;

    private final Runnable mPoll = new Runnable() {
        public void run() {
            if (isFinishing() || mCol == null) return;
            String now = signature();
            if (!now.equals(mSig)) {
                mSig = now;
                render();
            }
            if (MrTour.sBusy) mHandler.postDelayed(this, 400);
        }
    };

    /** Everything the card depends on: the step, the download (state and percent), a failure, the file and the dictionary on offer. */
    private String signature() {
        String step = mSteps.get(mIndex);
        boolean busy = MrTour.sBusy && step.equals(MrTour.sStep);
        String error = step.equals(MrTour.sErrorStep) ? MrTour.sError : null;
        return mIndex + "|" + busy + "|" + MrPacks.sJobPercent + "|" + MrPacks.sJobInstalling + "|" + error + "|" + MrTour.ready(this, step) + "|"
                + (MrTour.DICT.equals(step) ? MrTour.packIdForSystem(this) : "");
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        k = new MrKit(this);
        if (state != null) {
            String saved = state.getString(S_STEPS);
            if (saved != null) for (String s : saved.split(",")) if (s.length() > 0) mSteps.add(s);
            mIndex = state.getInt(S_INDEX, 0);
        }
        if (mSteps.isEmpty()) mSteps = MrTour.steps(this);
        if (mSteps.isEmpty()) {
            finish();
            return;
        }
        if (mIndex < 0 || mIndex >= mSteps.size()) mIndex = 0;

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        mCol = k.column();
        mCol.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(mCol, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        setContentView(scroll);
        mSig = signature();
        render();
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        StringBuilder b = new StringBuilder();
        for (String s : mSteps) b.append(s).append(',');
        out.putString(S_STEPS, b.toString());
        out.putInt(S_INDEX, mIndex);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mCol == null) return;
        mHandler.removeCallbacks(mPoll);
        mHandler.post(mPoll);   // paints again (a dictionary may have been picked on the other screen) and follows a download that is running
    }

    @Override
    protected void onPause() {
        mHandler.removeCallbacks(mPoll);
        super.onPause();
    }

    // ------------------------------------------------------------------ the screen

    private int uiColor(String name) {
        return getResources().getColor(getResources().getIdentifier(name, "color", getPackageName()));
    }

    private static String iconOf(String step) {
        if (MrTour.DICT.equals(step)) return "mr_ui_ic_book_mint";
        if (MrTour.GESTURE.equals(step)) return "mr_ui_ic_swipe_amber";
        return "mr_ui_ic_keycap_blue";
    }

    private void render() {
        if (mCol == null || mSteps.isEmpty()) return;
        mCol.removeAllViews();
        final String step = mSteps.get(mIndex);
        final boolean last = mIndex == mSteps.size() - 1;
        final boolean busy = MrTour.sBusy && step.equals(MrTour.sStep);
        final boolean ready = MrTour.ready(this, step);
        final String error = step.equals(MrTour.sErrorStep) ? MrTour.sError : null;
        final boolean download = !MrTour.WORD.equals(step);

        // the title and "Skip"
        LinearLayout head = k.row();
        TextView title = k.label(k.t("mr_tour_title"), 24f, k.text, true);
        head.addView(title, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView skip = k.label(k.t("mr_tour_skip"), 15f, k.accent, true);
        skip.setPadding(k.dp(12), k.dp(8), k.dp(4), k.dp(8));
        skip.setClickable(true);
        skip.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        head.addView(skip);
        mCol.addView(head, k.wide(0));

        // "Step 1 of 3" and the bar
        mCol.addView(k.label(k.t("mr_tour_step", mIndex + 1, mSteps.size()), 14f, k.text2, false), k.wide(4));
        LinearLayout bar = k.row();
        for (int i = 0; i < mSteps.size(); i++) {
            View seg = new View(this);
            seg.setBackground(k.round(i <= mIndex ? k.accent : k.line, 0, 2, false));
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(0, k.dp(4), 1f);
            lp.setMargins(i == 0 ? 0 : k.dp(3), 0, i == mSteps.size() - 1 ? 0 : k.dp(3), 0);
            bar.addView(seg, lp);
        }
        mCol.addView(bar, k.wide(10));

        // the card of the step
        LinearLayout card = k.panel();
        card.addView(k.iconView(iconOf(step), 30f));
        TextView name = k.label(k.t("mr_tour_" + step + "_title"), 20f, k.text, true);
        card.addView(name, k.wide(12));
        card.addView(k.label(k.t("mr_tour_" + step + "_text"), 14f, k.text2, false), k.wide(8));
        String packId = MrTour.DICT.equals(step) ? MrTour.packIdForSystem(this) : null;
        boolean noPack = MrTour.DICT.equals(step) && packId == null && !ready;
        String status;
        int statusColor;
        if (busy) {
            status = MrPacks.sJobInstalling ? k.t("mr_dicts_state_installing") : k.t("mr_dicts_state_downloading", MrPacks.sJobPercent);
            statusColor = uiColor("mr_ui_amber");
        } else if (error != null) {
            status = error;
            statusColor = k.rose;
        } else if (ready && download) {
            status = k.t("mr_tour_ready");
            statusColor = uiColor("mr_ui_mint");
        } else if (noPack) {
            status = k.t("mr_tour_dict_nopack");
            statusColor = k.text2;
        } else if (MrTour.DICT.equals(step)) {
            status = k.t("mr_tour_dict_missing", k.langName(packId.replace('-', '_')));
            statusColor = k.text2;
        } else if (download) {
            status = k.t("mr_tour_gesture_missing");
            statusColor = k.text2;
        } else {
            status = k.t("mr_tour_word_on");
            statusColor = uiColor("mr_ui_mint");
        }
        TextView st = k.label(status, 14f, statusColor, true);
        st.setPadding(k.dp(12), k.dp(10), k.dp(12), k.dp(10));
        st.setBackground(k.round(k.raised, k.line, 12, false));
        card.addView(st, k.wide(14));
        if (download && !ready) card.addView(k.label(k.t("mr_tour_net_note"), 12f, k.hint, false), k.wide(10));
        mCol.addView(card, k.wide(16));

        // the choices
        TextView primary;
        TextView secondary = null;
        if (busy) {
            primary = k.button(status, true, null);
            primary.setAlpha(0.6f);
        } else if (download && !ready) {
            String label = noPack ? k.t("mr_tour_choose") : k.t(error != null ? "mr_tour_retry" : "mr_tour_download");
            final boolean choose = noPack;
            primary = k.button(label, true, new View.OnClickListener() {
                public void onClick(View v) {
                    if (choose) {
                        startActivity(MrNav.intent(MrTourActivity.this, MrPacksActivity.class));
                        return;
                    }
                    MrTour.download(MrTourActivity.this, step);
                    mHandler.removeCallbacks(mPoll);
                    mHandler.post(mPoll);
                }
            });
            secondary = k.button(k.t("mr_tour_" + step + "_off"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    MrTour.turnOff(MrTourActivity.this, step);
                    next();
                }
            });
        } else {
            primary = k.button(k.t(download ? (last ? "mr_tour_finish" : "mr_tour_continue") : (last ? "mr_tour_keep_finish" : "mr_tour_keep")), true,
                    new View.OnClickListener() {
                        public void onClick(View v) {
                            next();
                        }
                    });
            if (!download) {
                secondary = k.button(k.t("mr_tour_word_off"), false, new View.OnClickListener() {
                    public void onClick(View v) {
                        MrTour.turnOff(MrTourActivity.this, step);
                        next();
                    }
                });
            }
        }
        mCol.addView(primary, k.wide(16));
        if (secondary != null) mCol.addView(secondary, k.wide(8));
        mCol.addView(k.label(k.t("mr_tour_later"), 12f, k.hint, false), k.wide(14));
    }

    private void next() {
        if (mIndex + 1 >= mSteps.size()) {
            finish();
            return;
        }
        mIndex++;
        mSig = signature();
        render();
    }

    @Override
    protected void onDestroy() {
        mHandler.removeCallbacks(mPoll);
        super.onDestroy();
    }
}
