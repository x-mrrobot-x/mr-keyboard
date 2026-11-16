package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.provider.Settings;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.LinearInterpolator;
import android.view.animation.OvershootInterpolator;
import android.view.animation.PathInterpolator;
import android.view.inputmethod.InputMethodManager;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * "First steps": the screen that sets the keyboard up, one step at a time (the rules are in MrTour): turn Mr Keyboard on in Android, choose
 * it as the keyboard in use, download the dictionary, download the gesture file. Plain views built in code with MrKit, in the palette of
 * the settings.
 *
 * <p>Layout, from top to bottom: "Step 2 of 4" and "Skip"; a bar with one segment per step; the step centred in the middle of the screen
 * (a round icon with a ring that pulses while the step waits for the person, the title, the text and a chip with the state); and, at the
 * bottom where the thumb is, the main button, the quiet one ("Turn off ...") and a short note. A step that is too tall for the screen
 * (a phone on its side, big text) scrolls; the buttons stay.
 *
 * <p>Motion (the easings and times of Material, which says an onboarding moves along the horizontal axis): the step leaves to the left and
 * the next one comes from the right; the segment of the bar of the new step fills; the first step settles in item by item; the icon turns
 * into a check with a small bounce when the step is done; the main button is the progress bar of a download. Everything runs on the
 * animators of the system, so the "remove animations" setting of Android turns it all off (the ring then stays still).
 *
 * <p>The download runs in MrTour (statics), so the screen only shows it: while it runs, and while a step of Android waits for the person
 * in the settings of Android, a handler looks at the state twice a second and the screen changes only when something is different, so a
 * tap is never lost to a redraw. The screen can be turned, left or closed with the file still coming. Nothing here connects to the
 * network except the button "Download" (MrTour.download).
 */
public class MrTourActivity extends Activity {
    private static final String S_STEPS = "mr_tour_steps";
    private static final String S_INDEX = "mr_tour_index";

    /** What a step shows (see {@link #stateOf}). */
    private static final int WAIT = 0;
    private static final int BUSY = 1;
    private static final int ERROR = 2;
    private static final int READY = 3;
    private static final int NOPACK = 4;

    /** The width of the column of the screen on a wide phone or a tablet, in dp. */
    private static final float COLUMN_DP = 440f;
    private static final long T_EXIT = 160;
    private static final long T_ENTER = 340;
    private static final long T_BAR = 460;

    // the easings of Material: the one that leaves starts slowly and ends fast, the one that comes starts fast and ends slowly
    private final PathInterpolator mOut = new PathInterpolator(0.3f, 0f, 1f, 1f);
    private final PathInterpolator mIn = new PathInterpolator(0f, 0f, 0f, 1f);
    private final LinearInterpolator mLinear = new LinearInterpolator();

    private MrKit k;
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private ArrayList<String> mSteps = new ArrayList<String>();
    private int mIndex;
    /** A change of step is running: taps and repaints wait for it. */
    private boolean mMoving;
    /** What the screen shows now (see {@link #signature}). */
    private String mSig;
    /** The state painted now ({@link #stateOf}), to tell a new state from a new percent. */
    private int mState = -1;

    // the parts that stay
    private LinearLayout mTop;
    private LinearLayout mBarBox;
    private LinearLayout mBody;
    private LinearLayout mStage;
    private LinearLayout mActions;
    private TextView mCounter;
    private final ArrayList<View> mFills = new ArrayList<View>();

    // the parts of the step on show (built again at each step)
    private FrameLayout mArt;
    private View mHalo;
    private View mRing;
    private View mDisc;
    private ImageView mGlyph;
    private String mGlyphName;
    private TextView mTitle;
    private TextView mText;
    private LinearLayout mChip;
    private View mChipDot;
    private TextView mChipText;
    private FrameLayout mPrimary;
    private View mPrimaryFill;
    private TextView mPrimaryLabel;
    private TextView mSecondary;
    private TextView mNote;

    private int mPulseGen;
    private boolean mPulsing;

    private final Runnable mPoll = new Runnable() {
        public void run() {
            if (isFinishing() || mBody == null) return;
            if (!mMoving) {
                String now = signature();
                if (!now.equals(mSig)) {
                    mSig = now;
                    update(true);
                }
            }
            if (keepPolling()) mHandler.postDelayed(this, MrTour.sBusy ? 400 : 500);
        }
    };

    /** A change of step that never ended (the animation was cancelled by the system): lets go of the screen. */
    private final Runnable mUnstick = new Runnable() {
        public void run() {
            if (!mMoving) return;
            mMoving = false;
            if (mBody != null) {
                mBody.setAlpha(1f);
                mBody.setTranslationX(0f);
            }
        }
    };

    // ------------------------------------------------------------------ state

    private String step() {
        return mSteps.get(mIndex);
    }

    private int stateOf(String step) {
        boolean download = !MrTour.isSetup(step);
        if (download && MrTour.sBusy && step.equals(MrTour.sStep)) return BUSY;
        if (MrTour.ready(this, step)) return READY;
        if (download && step.equals(MrTour.sErrorStep) && MrTour.sError != null) return ERROR;
        if (MrTour.DICT.equals(step) && MrTour.packIdForSystem(this) == null) return NOPACK;
        return WAIT;
    }

    /** Everything the step depends on: the state, the percent of a download, a failure and the dictionary on offer. */
    private String signature() {
        String step = step();
        int st = stateOf(step);
        return mIndex + "|" + st + "|" + (st == BUSY ? MrPacks.sJobPercent + "|" + MrPacks.sJobInstalling : "") + "|"
                + (st == ERROR ? MrTour.sError : "") + "|" + (MrTour.DICT.equals(step) ? MrTour.packIdForSystem(this) : "");
    }

    /** A download is running, or a step of Android waits for the person to come back from the settings or the picker. */
    private boolean keepPolling() {
        String step = step();
        if (MrTour.sBusy && step.equals(MrTour.sStep)) return true;
        return MrTour.isSetup(step) && !MrTour.ready(this, step);
    }

    private void kick() {
        mHandler.removeCallbacks(mPoll);
        mHandler.post(mPoll);
    }

    // ------------------------------------------------------------------ the screen

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

        LinearLayout root = k.column();
        root.setBackground(k.round(k.bg, 0, 0, false));

        mTop = k.row();
        mCounter = k.label("", 13f, k.text2, true);
        mTop.addView(mCounter, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView skip = k.label(k.t("mr_tour_skip"), 15f, k.accent, true);
        skip.setPadding(k.dp(14), k.dp(12), k.dp(2), k.dp(12));
        skip.setClickable(true);
        skip.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        pressable(skip);
        mTop.addView(skip);
        root.addView(mTop, k.wide(0));

        mBarBox = k.row();
        for (int i = 0; i < mSteps.size(); i++) {
            FrameLayout seg = new FrameLayout(this);
            seg.setBackground(k.round(k.stroke, 0, 3, false));
            View fill = new View(this);
            fill.setBackground(k.round(k.accent, 0, 3, false));
            fill.setPivotX(0f);
            fill.setScaleX(0f);
            seg.addView(fill, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
            mFills.add(fill);
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(0, k.dp(5), 1f);
            lp.setMargins(i == 0 ? 0 : k.dp(3), 0, i == mSteps.size() - 1 ? 0 : k.dp(3), 0);
            mBarBox.addView(seg, lp);
        }
        root.addView(mBarBox, k.wide(4));

        // the step, in the middle of what is left; the buttons under it
        mBody = k.column();
        ScrollView scroll = new ScrollView(this);
        scroll.setFillViewport(true);
        mStage = k.column();
        mStage.setGravity(Gravity.CENTER);
        scroll.addView(mStage, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mBody.addView(scroll, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f));
        mActions = k.column();
        mBody.addView(mActions, k.wide(0));
        root.addView(mBody, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 0, 1f));
        setContentView(root);
        applySide();

        buildBody();
        updateBar(state == null);
        update(false);
        mSig = signature();
        if (state == null) enter();
    }

    /** The column of the screen is at most {@link #COLUMN_DP} wide and in the middle; on a phone it only keeps its margins. */
    private void applySide() {
        if (mTop == null) return;
        int w = getResources().getDisplayMetrics().widthPixels;
        int side = Math.max(k.dp(24), (w - k.dp(COLUMN_DP)) / 2);
        mTop.setPadding(side, k.dp(6), side, 0);
        mBarBox.setPadding(side, k.dp(2), side, 0);
        mStage.setPadding(side + k.dp(4), k.dp(16), side + k.dp(4), k.dp(16));
        mActions.setPadding(side, k.dp(8), side, k.dp(20));
    }

    @Override
    public void onConfigurationChanged(Configuration c) {
        super.onConfigurationChanged(c);
        applySide();
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
        if (mBody == null) return;
        mSig = null;   // paints again: a dictionary may have been picked on another screen, the keyboard turned on in the settings
        kick();
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus && mBody != null) kick();   // the picker of keyboards of Android closed
    }

    @Override
    protected void onPause() {
        mHandler.removeCallbacks(mPoll);
        stopPulse();
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        mHandler.removeCallbacks(mPoll);
        mHandler.removeCallbacks(mUnstick);
        stopPulse();
        super.onDestroy();
    }

    /** Closing it, by Skip, Back or the last button, is what marks the first steps as done (MrTour has the reasons). */
    @Override
    public void finish() {
        MrTour.markDone(this);
        super.finish();
    }

    // ------------------------------------------------------------------ one step

    private int uiColor(String name) {
        return getResources().getColor(getResources().getIdentifier(name, "color", getPackageName()));
    }

    private static int tint(int color, int alpha) {
        return (alpha << 24) | (color & 0x00ffffff);
    }

    private int stepColor(String step) {
        if (MrTour.ENABLE.equals(step)) return uiColor("mr_ui_cyan");
        if (MrTour.SELECT.equals(step)) return uiColor("mr_ui_violet");
        if (MrTour.DICT.equals(step)) return uiColor("mr_ui_mint");
        return uiColor("mr_ui_amber");
    }

    private static String glyphOf(String step) {
        if (MrTour.ENABLE.equals(step)) return "mr_tour_ic_keyboard";
        if (MrTour.SELECT.equals(step)) return "mr_tour_ic_pick";
        if (MrTour.DICT.equals(step)) return "mr_tour_ic_book";
        return "mr_tour_ic_swipe";
    }

    private GradientDrawable disc(int color) {
        GradientDrawable d = new GradientDrawable();
        d.setShape(GradientDrawable.OVAL);
        d.setColor(tint(color, 0x24));
        d.setStroke(Math.max(1, k.dp(1.5f)), tint(color, 0x8c));
        return d;
    }

    private TextView centred(String s, float sp, int colour, boolean bold) {
        TextView v = k.label(s, sp, colour, bold);
        v.setGravity(Gravity.CENTER);
        return v;
    }

    /** The views of the step at hand: the round icon, the title, the text and the chip in the stage; the buttons and the note under it. */
    private void buildBody() {
        stopPulse();
        String step = step();
        if (!MrTour.isSetup(step)) MrTour.markDone(this);   // the two steps of Android are behind: the screen is not needed again
        mGlyphName = null;
        mStage.removeAllViews();
        mActions.removeAllViews();

        int art = k.dp(168);
        int core = k.dp(116);
        mArt = new FrameLayout(this);
        mHalo = new View(this);
        mArt.addView(mHalo, new FrameLayout.LayoutParams(art, art, Gravity.CENTER));
        mRing = new View(this);
        GradientDrawable ring = new GradientDrawable();
        ring.setShape(GradientDrawable.OVAL);
        ring.setStroke(Math.max(1, k.dp(2)), tint(stepColor(step), 0xcc));
        mRing.setBackground(ring);
        mRing.setAlpha(0f);
        mArt.addView(mRing, new FrameLayout.LayoutParams(core, core, Gravity.CENTER));
        mDisc = new View(this);
        mArt.addView(mDisc, new FrameLayout.LayoutParams(core, core, Gravity.CENTER));
        mGlyph = new ImageView(this);
        mArt.addView(mGlyph, new FrameLayout.LayoutParams(k.dp(52), k.dp(52), Gravity.CENTER));
        mStage.addView(mArt, new LinearLayout.LayoutParams(art, art));

        mTitle = centred(k.t("mr_tour_" + step + "_title"), 26f, k.text, true);
        mStage.addView(mTitle, k.wide(26));
        mText = centred(k.t("mr_tour_" + step + "_text"), 15.5f, k.text2, false);
        mText.setLineSpacing(0f, 1.2f);
        mStage.addView(mText, k.wide(12));

        mChip = k.row();
        mChip.setPadding(k.dp(14), k.dp(9), k.dp(16), k.dp(9));
        mChip.setBackground(k.round(k.raised, k.line, 18, false));
        mChipDot = new View(this);
        LinearLayout.LayoutParams dot = new LinearLayout.LayoutParams(k.dp(8), k.dp(8));
        dot.setMargins(0, 0, k.dp(8), 0);
        mChip.addView(mChipDot, dot);
        mChipText = k.label("", 13f, k.text2, true);
        mChip.addView(mChipText);
        mStage.addView(mChip, k.lp(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT, 22));

        // the main button: a pill that is also the progress bar of a download
        mPrimary = new FrameLayout(this);
        mPrimary.setClickable(true);
        mPrimaryFill = new View(this);
        mPrimaryFill.setBackground(k.round(k.accent, 0, 27, false));
        mPrimaryFill.setPivotX(0f);
        mPrimaryFill.setScaleX(0f);
        mPrimaryFill.setVisibility(View.GONE);
        mPrimary.addView(mPrimaryFill, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        mPrimaryLabel = k.label("", 16f, k.onAccent, true);
        mPrimaryLabel.setGravity(Gravity.CENTER);
        mPrimary.addView(mPrimaryLabel, new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, Gravity.CENTER));
        pressable(mPrimary);
        mActions.addView(mPrimary, k.lp(ViewGroup.LayoutParams.MATCH_PARENT, k.dp(54), 0));

        mSecondary = centred("", 15f, k.text2, true);
        mSecondary.setPadding(k.dp(12), k.dp(14), k.dp(12), k.dp(14));
        mSecondary.setClickable(true);
        pressable(mSecondary);
        mActions.addView(mSecondary, k.wide(4));
        mNote = centred("", 12f, k.hint, false);
        mActions.addView(mNote, k.wide(0));
    }

    /** Paints the step for what is true now. With {@code animate} a change of state is shown with motion; without it, it is just drawn. */
    private void update(boolean animate) {
        if (mDisc == null || mSteps.isEmpty()) return;
        final String step = step();
        final int st = stateOf(step);
        final boolean changed = st != mState;
        final boolean first = mState == -1;
        mState = st;
        final boolean setup = MrTour.isSetup(step);
        final boolean last = mIndex == mSteps.size() - 1;
        String packId = MrTour.DICT.equals(step) ? MrTour.packIdForSystem(this) : null;
        int mint = uiColor("mr_ui_mint");
        int amber = uiColor("mr_ui_amber");

        // the chip: what is true about the step
        String chip;
        int dot;
        int chipColor = k.text2;
        if (st == BUSY) {
            chip = k.t("mr_tour_downloading");
            dot = k.accent;
        } else if (st == ERROR) {
            chip = MrTour.sError;
            dot = k.rose;
            chipColor = k.rose;
        } else if (st == READY) {
            chip = k.t(setup ? "mr_tour_" + step + "_on" : "mr_tour_ready");
            dot = mint;
            chipColor = mint;
        } else if (st == NOPACK) {
            chip = k.t("mr_tour_dict_nopack");
            dot = amber;
        } else if (MrTour.DICT.equals(step)) {
            chip = k.t("mr_tour_dict_missing", k.langName(packId.replace('-', '_')));
            dot = amber;
        } else {
            chip = k.t("mr_tour_" + step + "_missing");
            dot = amber;
        }
        mChipText.setText(chip);
        mChipText.setTextColor(chipColor);
        mChipDot.setBackground(k.round(dot, 0, 0, true));

        // the round icon: the colour of the step, a check in green when it is done
        int col = st == READY ? mint : stepColor(step);
        mDisc.setBackground(disc(col));
        mHalo.setBackground(k.round(tint(col, 0x14), 0, 0, true));
        String glyph = st == READY ? "mr_tour_ic_check" : glyphOf(step);
        if (!glyph.equals(mGlyphName)) {
            mGlyphName = glyph;
            mGlyph.setImageDrawable(k.icon(glyph, 52f));
        }
        mGlyph.setColorFilter(col);
        if (animate && changed && !first) {
            fade(mChip);
            if (st == READY) {
                popIn(mGlyph, 0);
                bump(mDisc);
            }
        }
        if (st == WAIT || st == BUSY || st == NOPACK) startPulse();
        else stopPulse();

        paintButtons(step, st, setup, last);
    }

    private void paintButtons(final String step, final int st, boolean setup, boolean last) {
        String label;
        if (st == BUSY) {
            label = MrPacks.sJobInstalling ? k.t("mr_dicts_state_installing") : k.t("mr_dicts_state_downloading", MrPacks.sJobPercent);
        } else if (st == READY) {
            label = k.t(last ? "mr_tour_finish" : "mr_tour_continue");
        } else if (MrTour.ENABLE.equals(step) || MrTour.SELECT.equals(step)) {
            label = k.t("mr_tour_" + step + "_open");
        } else if (st == NOPACK) {
            label = k.t("mr_tour_choose");
        } else {
            label = k.t(st == ERROR ? "mr_tour_retry" : "mr_tour_download");
        }
        mPrimaryLabel.setText(label);
        mPrimaryFill.animate().cancel();
        if (st == BUSY) {
            mPrimary.setBackground(k.round(k.raised, k.line, 27, false));
            mPrimaryLabel.setTextColor(k.text);
            mPrimaryFill.setVisibility(View.VISIBLE);
            float f = MrPacks.sJobInstalling ? 1f : Math.max(0.05f, Math.min(1f, MrPacks.sJobPercent / 100f));
            mPrimaryFill.animate().scaleX(f).setDuration(380).setInterpolator(mLinear).start();
            mPrimary.setOnClickListener(null);   // stays touchable (the press is shown and ends), but does nothing while it runs
        } else {
            mPrimary.setBackground(k.round(k.accent, 0, 27, false));
            mPrimaryLabel.setTextColor(k.onAccent);
            mPrimaryFill.setVisibility(View.GONE);
            mPrimaryFill.setScaleX(0f);
            mPrimary.setClickable(true);
            mPrimary.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    onPrimary(step, st);
                }
            });
        }

        // the quiet button: turn the option off. Only for a download that has not been done; not for the steps of Android
        if (setup) {
            mSecondary.setVisibility(View.GONE);
        } else {
            mSecondary.setText(k.t("mr_tour_" + step + "_off"));
            mSecondary.setVisibility(st == BUSY || st == READY ? View.INVISIBLE : View.VISIBLE);
            mSecondary.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mMoving) return;
                    MrTour.turnOff(MrTourActivity.this, step);
                    next();
                }
            });
        }
        if (setup) {
            mNote.setText(k.t("mr_tour_" + step + "_note"));
            mNote.setVisibility(View.VISIBLE);
        } else {
            mNote.setText(k.t("mr_tour_net_note"));
            mNote.setVisibility(st == READY ? View.INVISIBLE : View.VISIBLE);
        }
    }

    // ------------------------------------------------------------------ what the buttons do

    private void onPrimary(String step, int st) {
        if (mMoving) return;
        if (st == READY) {
            next();
        } else if (MrTour.ENABLE.equals(step)) {
            openKeyboardSettings();
        } else if (MrTour.SELECT.equals(step)) {
            pickKeyboard();
        } else if (st == NOPACK) {
            startActivity(MrNav.intent(this, MrPacksActivity.class));
        } else {
            MrTour.download(this, step);
            kick();
        }
    }

    /** The list of keyboards of Android, where Mr Keyboard is turned on. The screen follows the answer when the person comes back. */
    private void openKeyboardSettings() {
        try {
            startActivity(new Intent(Settings.ACTION_INPUT_METHOD_SETTINGS));
        } catch (RuntimeException e) {
            k.toast(k.t("mr_tour_settings_error"));
        }
        kick();
    }

    /** The picker of keyboards of Android; it is a window of the system over this screen, and the answer is read when this one has the focus back. */
    private void pickKeyboard() {
        try {
            Object o = getSystemService(Context.INPUT_METHOD_SERVICE);
            if (o instanceof InputMethodManager) ((InputMethodManager) o).showInputMethodPicker();
        } catch (RuntimeException e) {
            k.toast(k.t("mr_tour_settings_error"));
        }
        kick();
    }

    private void next() {
        if (mIndex + 1 >= mSteps.size()) {
            finish();
            return;
        }
        go(mIndex + 1);
    }

    // ------------------------------------------------------------------ motion

    /** To the next step along the horizontal axis: the one on show leaves to the left, the next comes from the right. */
    private void go(final int target) {
        if (mMoving) return;
        mMoving = true;
        stopPulse();
        mHandler.removeCallbacks(mUnstick);
        mHandler.postDelayed(mUnstick, 1200);
        final float dist = k.dp(36);
        mBody.animate().alpha(0f).translationX(-dist).setDuration(T_EXIT).setInterpolator(mOut).withEndAction(new Runnable() {
            public void run() {
                mIndex = target;
                buildBody();
                mState = -1;
                update(false);
                mSig = signature();
                updateBar(true);
                mBody.setTranslationX(dist);
                mBody.animate().alpha(1f).translationX(0f).setDuration(T_ENTER).setInterpolator(mIn).withEndAction(new Runnable() {
                    public void run() {
                        mMoving = false;
                        mHandler.removeCallbacks(mUnstick);
                        kick();
                    }
                }).start();
            }
        }).start();
    }

    /** The bar: the segments before the step are full, the one of the step fills, the others are empty. */
    private void updateBar(boolean animate) {
        mCounter.setText(k.t("mr_tour_step", mIndex + 1, mSteps.size()));
        mCounter.setContentDescription(k.t("mr_tour_step", mIndex + 1, mSteps.size()));
        for (int i = 0; i < mFills.size(); i++) {
            View f = mFills.get(i);
            f.animate().cancel();
            if (i < mIndex) {
                f.setScaleX(1f);
            } else if (i == mIndex) {
                if (animate) {
                    f.setScaleX(0f);
                    f.animate().scaleX(1f).setDuration(T_BAR).setInterpolator(mIn).start();
                } else {
                    f.setScaleX(1f);
                }
            } else {
                f.setScaleX(0f);
            }
        }
    }

    /** The first step settles in: the icon pops, the title, the text and the chip rise one after the other, the buttons come last. */
    private void enter() {
        popIn(mArt, 40);
        View[] items = {mTitle, mText, mChip};
        for (int i = 0; i < items.length; i++) {
            View v = items[i];
            v.setAlpha(0f);
            v.setTranslationY(k.dp(14));
            v.animate().alpha(1f).translationY(0f).setStartDelay(160 + 70 * i).setDuration(380).setInterpolator(mIn).start();
        }
        mActions.setAlpha(0f);
        mActions.animate().alpha(1f).setStartDelay(420).setDuration(300).setInterpolator(mIn).start();
    }

    private void popIn(View v, long delay) {
        v.setScaleX(0.4f);
        v.setScaleY(0.4f);
        v.setAlpha(0f);
        v.animate().scaleX(1f).scaleY(1f).alpha(1f).setStartDelay(delay).setDuration(420).setInterpolator(new OvershootInterpolator(2.2f)).start();
    }

    /** A short swell and a return, to say that something just happened to the view. */
    private void bump(final View v) {
        v.animate().scaleX(1.12f).scaleY(1.12f).setStartDelay(0).setDuration(140).setInterpolator(mIn).withEndAction(new Runnable() {
            public void run() {
                v.animate().scaleX(1f).scaleY(1f).setDuration(300).setInterpolator(new OvershootInterpolator(2.4f)).start();
            }
        }).start();
    }

    private void fade(View v) {
        v.setAlpha(0.3f);
        v.animate().alpha(1f).setStartDelay(0).setDuration(240).setInterpolator(mIn).start();
    }

    /** The ring that leaves the icon while the step waits for the person (it does not loop if the animations are turned off). */
    private void startPulse() {
        if (mPulsing || mRing == null) return;
        mPulsing = true;
        loopPulse(++mPulseGen);
    }

    private void loopPulse(final int gen) {
        if (gen != mPulseGen || mRing == null || isFinishing()) return;
        final long t0 = SystemClock.uptimeMillis();
        mRing.setScaleX(1f);
        mRing.setScaleY(1f);
        mRing.setAlpha(0.6f);
        mRing.animate().scaleX(1.45f).scaleY(1.45f).alpha(0f).setStartDelay(0).setDuration(1700).setInterpolator(mIn).withEndAction(new Runnable() {
            public void run() {
                if (gen != mPulseGen) return;
                if (SystemClock.uptimeMillis() - t0 < 300) {   // it ended at once: the animations are off
                    mPulsing = false;
                    return;
                }
                mHandler.postDelayed(new Runnable() {
                    public void run() {
                        loopPulse(gen);
                    }
                }, 350);
            }
        }).start();
    }

    private void stopPulse() {
        mPulsing = false;
        mPulseGen++;
        if (mRing != null) {
            mRing.animate().cancel();
            mRing.setAlpha(0f);
        }
    }

    /** A touch that a button answers by shrinking a little; the touch itself goes on to the click. */
    private void pressable(View v) {
        v.setOnTouchListener(new View.OnTouchListener() {
            public boolean onTouch(View view, MotionEvent e) {
                int a = e.getActionMasked();
                if (a == MotionEvent.ACTION_DOWN) {
                    view.animate().scaleX(0.97f).scaleY(0.97f).setStartDelay(0).setDuration(90).setInterpolator(mIn).start();
                } else if (a == MotionEvent.ACTION_UP || a == MotionEvent.ACTION_CANCEL) {
                    view.animate().scaleX(1f).scaleY(1f).setStartDelay(0).setDuration(180).setInterpolator(mIn).start();
                }
                return false;
            }
        });
    }
}
