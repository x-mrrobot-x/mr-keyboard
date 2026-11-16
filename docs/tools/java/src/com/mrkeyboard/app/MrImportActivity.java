package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;

/**
 * v1.85: "Add words and texts" (screen B of Phase 2). The user types or pastes a text and the keyboard learns from it:
 *  - a list in the standard format (mr-words 1: [words] / [phrases] / [blocked]) is taken as it is;
 *  - any other text (a chat export, an essay, notes) is read as free text: only the words the dictionary does not know and that show up
 *    at least twice are proposed, and pairs of words that are both valid and show up at least twice.
 * Nothing is saved before the preview: the user sees the new words (and can untick a typo), the pairs, what was ignored and why, in a dialog. "Add"
 * saves one addition (one batch) that "Undo the last addition" takes back. A prompt for an AI is offered to turn a big text into the standard list.
 * Under the box there is one button, chosen by what the box holds ({@link MrImport#offer}): "Format with AI" from the start (quiet while the box is
 * empty, in the colour of the main action as soon as there is a character) for a text that is not a list yet, "See what will be added" (the preview)
 * once it is a list, typed, pasted or made by the AI.
 * The rules live in MrImport / MrLearned (tested on the PC); this class is only views and threads. The analysis and the saving run off the main thread.
 */
public class MrImportActivity extends Activity {
    static final String EXTRA_LOCALE = "mr_words_locale";
    /** How many words of the preview are drawn at a time. */
    static final int PREVIEW_PAGE = 100;
    private static final String PREFS = "mr_words";
    private static final String P_BATCH = "last_batch";
    private static final String P_LOCALE = "last_locale";
    private static final String P_COUNT = "last_count";
    private static final String S_LOCALE = "mr_import_s_locale";
    private static final String S_TEXT = "mr_import_s_text";
    /** The typed text is kept through a recreation only when it is small (a Bundle that is too large makes the system fail). */
    private static final int SAVE_TEXT_MAX = 100000;

    private MrKit k;
    private MrWordStore mStore;
    private String mLocale;
    private List<String> mLangs = new ArrayList<String>();
    private boolean mBusy;
    private MrImport.Plan mPlan;
    private int mShown;

    private LinearLayout mLangBox;
    private EditText mText;
    private TextView mCount;
    private TextView mAnalyze;
    /** What the preview dialog holds (null while no preview is open). */
    private LinearLayout mPreview;
    private AlertDialog mPreviewDialog;
    private LinearLayout mWordBox;
    private TextView mApply;
    private TextView mMoreWords;
    private TextView mUndo;
    private TextView mStatus;
    private TextView mAiButton;
    /** How the Format with AI button is drawn now (null: not drawn yet): the main-action look once there is something typed. */
    private Boolean mAiPrimary;
    private TextView mAiCancel;
    private TextView mAiNote;
    /** The cancel button was tapped while the AI was working (read by the thread that sends). */
    private volatile boolean mAiCancelled;
    /** The text of the box is being set by the screen itself (not typed by the person). */
    private boolean mSetting;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        out.putString(S_LOCALE, mLocale);
        CharSequence typed = mText == null ? null : mText.getText();
        if (typed != null && typed.length() > 0 && typed.length() <= SAVE_TEXT_MAX) out.putString(S_TEXT, typed.toString());
        MrScreenIme.save(out, mText, null);
    }

    @Override
    protected void onDestroy() {
        // a dialog left open with its screen is a leaked window
        mPlan = null;
        mPreview = null;
        dismissPreview();
        super.onDestroy();
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        k = new MrKit(this);
        mStore = MrLearned.store(this);
        if (mStore == null) {
            k.toast(k.t("mr_learned_unavailable"));
            finish();
            return;
        }
        if (state != null) mLocale = state.getString(S_LOCALE);
        if (mLocale == null && getIntent() != null) mLocale = getIntent().getStringExtra(EXTRA_LOCALE);
        loadLanguages();
        MrLang.remember(prefs(), mLocale);

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        LinearLayout col = k.column();
        col.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        MrScreenIme.lift(scroll, col, k.dp(20), k.dp(16), k.dp(20), k.dp(24), k.dp(12));

        col.addView(k.backHeader(k.t("mr_import_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), k.wide(0));
        col.addView(k.infoCard(k.t("mr_import_intro")), k.wide(16));

        // The card with the language, the text and, under it, the one button that fits the text (format with AI, or see what will be added).
        LinearLayout main = k.panel();
        col.addView(main, k.wide(14));
        main.addView(k.iconRow("mr_ui_ic_globe", 16f, k.t("mr_lang_card_title"), 15f, k.text, false), k.wide(0));
        mLangBox = k.column();
        main.addView(mLangBox, k.wide(10));
        main.addView(k.iconRow("mr_ui_ic_keyboard", 16f, k.t("mr_import_hint"), 15f, k.text, false), k.wide(18));

        mText = k.field(k.t("mr_import_placeholder"), InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_MULTI_LINE
                | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        mText.setMinLines(6);
        mText.setGravity(Gravity.TOP);
        if (state != null && state.getString(S_TEXT) != null) mText.setText(state.getString(S_TEXT));
        mText.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            public void afterTextChanged(Editable s) {
                updateCount();
                refreshOffer();
                if (!mSetting) {
                    // Another text than the one the AI made: what the note says about it is not true any more.
                    hideAiNote();
                    // and the preview was made from the text that is gone
                    clearPreview();
                }
            }
        });
        mCount = k.label("", 12f, k.hint, false);
        mCount.setGravity(Gravity.END);
        mCount.setPadding(k.dp(14), 0, k.dp(14), k.dp(10));
        main.addView(k.fieldBox(mText, mCount), k.wide(10));
        updateCount();

        // Only one of the two shows at a time (see refreshOffer): a text that is already a list is read as it is, any other one is formatted first.
        mAiButton = k.iconButton(k.t("mr_import_ai_button"), "mr_ui_ic_wand", false, new View.OnClickListener() {
            public void onClick(View v) {
                formatTapped();
            }
        });
        main.addView(mAiButton, k.wide(12));
        mAnalyze = k.iconButton(k.t("mr_import_analyze"), "mr_ui_ic_eye", true, new View.OnClickListener() {
            public void onClick(View v) {
                analyze();
            }
        });
        main.addView(mAnalyze, k.wide(12));
        mAiNote = k.label("", 13f, k.text2, false);
        mAiNote.setPadding(k.dp(4), k.dp(6), k.dp(4), 0);
        mAiNote.setVisibility(View.GONE);
        main.addView(mAiNote, k.wide(0));

        mStatus = k.label("", 14f, k.text2, false);
        mStatus.setPadding(k.dp(4), k.dp(8), k.dp(4), 0);
        mStatus.setVisibility(View.GONE);
        col.addView(mStatus, k.wide(0));
        mAiCancel = k.button(k.t("mr_words_cancel"), false, new View.OnClickListener() {
            public void onClick(View v) {
                mAiCancelled = true;
                mAiCancel.setVisibility(View.GONE);
            }
        });
        mAiCancel.setVisibility(View.GONE);
        col.addView(mAiCancel, k.wide(8));

        // Turning a big text into the standard list with an AI.
        LinearLayout ai = k.panel();
        ai.addView(k.iconRow("mr_ui_ic_sparkle", 20f, k.t("mr_import_ai_title"), 17f, k.text, true), k.wide(0));
        ai.addView(k.label(k.t("mr_import_ai_text"), 14f, k.text2, false), k.wide(8));
        ai.addView(k.iconButton(k.t("mr_import_ai_copy"), "mr_ui_ic_copy", false, new View.OnClickListener() {
            public void onClick(View v) {
                copyPrompt();
            }
        }), k.wide(12));
        col.addView(ai, k.wide(22));

        mUndo = k.iconButton("", "mr_ui_ic_undo", false, new View.OnClickListener() {
            public void onClick(View v) {
                undoLast();
            }
        });
        col.addView(mUndo, k.wide(18));

        setContentView(scroll);
        MrScreenIme.restore(state, mText, null);
        refreshOffer();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mStore == null) return;
        refreshLanguages();
        refreshUndo();
    }

    // ------------------------------------------------------------------ languages

    private void loadLanguages() {
        List<String> have;
        try {
            have = mStore.locales();
        } catch (RuntimeException e) {
            have = new ArrayList<String>();
        }
        mLangs = MrLang.offered(MrPacks.installedIds(this), have);
        mLocale = MrLang.pick(mLangs, mLocale, MrLang.last(prefs()), getResources().getConfiguration().locale.getLanguage());
    }

    private void refreshLanguages() {
        k.languageCard(mLangBox, mLangs, mLocale, new MrKit.LangPick() {
            public void onPick(String locale) {
                if (mBusy) return;
                mLocale = locale;
                MrLang.remember(prefs(), locale);
                // A preview was made for another language: the words may be known there.
                clearPreview();
                refreshLanguages();
            }
        }, false);
    }

    // ------------------------------------------------------------------ input

    /** The counter inside the text box: how many characters are in it. */
    private void updateCount() {
        mCount.setText(k.t("mr_import_count", mText.length()));
    }

    /**
     * The button under the box: "Format with AI" for a text that is not a list yet (quiet while the box is empty, in the colour of the main action, like
     * the other button, as soon as there is something in it), "See what will be added" for a list.
     */
    private void refreshOffer() {
        if (mAiButton == null || mAnalyze == null) return;
        String typed = mText.getText() == null ? null : mText.getText().toString();
        int offer = MrImport.offer(typed);
        mAiButton.setVisibility(offer == MrImport.OFFER_FORMAT ? View.VISIBLE : View.GONE);
        mAnalyze.setVisibility(offer == MrImport.OFFER_PREVIEW ? View.VISIBLE : View.GONE);
        boolean primary = typed != null && typed.trim().length() > 0;
        if (mAiPrimary == null || mAiPrimary.booleanValue() != primary) {
            mAiPrimary = Boolean.valueOf(primary);
            k.restyleIconButton(mAiButton, primary, primary ? "mr_ui_ic_wand_on" : "mr_ui_ic_wand");
        }
    }

    private void copyPrompt() {
        try {
            ClipboardManager cm = (ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE);
            cm.setPrimaryClip(ClipData.newPlainText("Mr Keyboard", k.t("mr_import_prompt")));
            k.toast(k.t("mr_import_ai_copied"));
        } catch (RuntimeException e) {
            k.toast(k.t("mr_import_clip_empty"));
        }
    }

    private void setBox(String text) {
        mSetting = true;
        try {
            mText.setText(text);
        } finally {
            mSetting = false;
        }
    }

    private String source() {
        CharSequence t = mText.getText();
        return t == null ? "" : t.toString();
    }

    // ------------------------------------------------------------------ analysis

    private void setBusy(boolean busy, String message) {
        mBusy = busy;
        mAnalyze.setClickable(!busy);
        mAiButton.setClickable(!busy);
        mText.setEnabled(!busy);
        mStatus.setText(message == null ? "" : message);
        mStatus.setVisibility(busy ? View.VISIBLE : View.GONE);
    }

    private void analyze() {
        if (mBusy) return;
        final String text = source();
        if (text.trim().length() == 0) {
            k.toast(k.t("mr_import_nothing"));
            return;
        }
        final String locale = mLocale;
        final boolean standard = MrImport.isStandard(text);
        setBusy(true, k.t("mr_import_working"));
        clearPreview();
        new Thread(new Runnable() {
            public void run() {
                MrImport.Plan plan = null;
                boolean noDict = false;
                final BinaryDictionary dict = MrPacks.openDictionary(MrImportActivity.this, locale);
                try {
                    if (dict == null && !standard) {
                        noDict = true;
                    } else {
                        plan = MrImport.parse(text, new MrImport.Known() {
                            public boolean knows(String word) {
                                return dict != null && dict.isValidWord(word);
                            }
                        });
                        // The words seen most often first: the preview shows the first ones, and the cap keeps them.
                        Collections.sort(plan.words, new Comparator<MrImport.NewWord>() {
                            public int compare(MrImport.NewWord a, MrImport.NewWord b) {
                                return b.count != a.count ? (b.count > a.count ? 1 : -1) : a.word.compareTo(b.word);
                            }
                        });
                    }
                } catch (RuntimeException e) {
                    plan = null;
                } catch (OutOfMemoryError e) {
                    plan = null;
                } finally {
                    if (dict != null) dict.close();
                }
                final MrImport.Plan done = plan;
                final boolean missing = noDict;
                runOnUiThread(new Runnable() {
                    public void run() {
                        if (isFinishing()) return;
                        setBusy(false, null);
                        if (missing) {
                            k.toast(k.t("mr_import_need_dict"));
                        } else if (done == null) {
                            k.toast(k.t("mr_import_failed"));
                        } else {
                            mPlan = done;
                            showPreview();
                        }
                    }
                });
            }
        }).start();
    }

    // ------------------------------------------------------------------ preview

    /** Drops the preview: the plan, what the dialog holds and the dialog itself if it is open. */
    private void clearPreview() {
        mPlan = null;
        mShown = 0;
        mPreview = null;
        mWordBox = null;
        mMoreWords = null;
        mApply = null;
        dismissPreview();
    }

    private void dismissPreview() {
        AlertDialog d = mPreviewDialog;
        mPreviewDialog = null;
        if (d == null) return;
        try {
            d.dismiss();
        } catch (RuntimeException e) {
            // the window may already be gone with its screen
        }
    }

    /**
     * What will be added, in a dialog: the three numbers, the notes that apply, why there is nothing to add when that is so, and the new words with a
     * tick each. The Add button is the one of the dialog (it stays in view while the list scrolls); closing the dialog drops the preview.
     */
    private void showPreview() {
        final MrImport.Plan plan = mPlan;
        final LinearLayout box = k.column();
        box.setPadding(k.dp(20), k.dp(8), k.dp(20), k.dp(4));
        ScrollView scroll = new ScrollView(this);
        scroll.addView(box, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        mPreview = box;
        mShown = 0;
        mWordBox = null;
        mMoreWords = null;
        mApply = null;
        LinearLayout tiles = k.row();
        tiles.addView(k.stat(plan.words.size(), k.t("mr_import_stat_words")), new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        LinearLayout.LayoutParams gap = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        gap.setMargins(k.dp(8), 0, 0, 0);
        tiles.addView(k.stat(plan.pairs.size(), k.t("mr_import_stat_pairs")), gap);
        LinearLayout.LayoutParams gap2 = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        gap2.setMargins(k.dp(8), 0, 0, 0);
        tiles.addView(k.stat(plan.knownSkipped, k.t("mr_import_stat_known")), gap2);
        box.addView(tiles, k.wide(0));
        if (plan.blocked.size() > 0) {
            box.addView(k.label(k.t("mr_import_blocked_found", plan.blocked.size()), 14f, k.text2, false), k.wide(12));
        }
        if (plan.pairsCut) {
            box.addView(k.label(k.t("mr_import_pairs_cut"), 14f, k.text2, false), k.wide(12));
        }
        String hint = plan.languageHint;
        if (hint != null && hint.length() > 0 && !MrLearned.localeOf(hint).equalsIgnoreCase(mLocale)) {
            box.addView(k.label(k.t("mr_import_lang_note", hint, MrLearned.tag(mLocale)), 14f, k.rose, false), k.wide(12));
        }
        final boolean nothing = plan.words.isEmpty() && plan.pairs.isEmpty() && plan.blocked.isEmpty();
        if (nothing) {
            box.addView(k.emptyState("mr_ui_ic_check_mint", k.t("mr_import_none_title"), k.t(plan.standard ? "mr_import_none_std" : "mr_import_none_new")), k.wide(14));
        }
        if (plan.ignoredCount > 0) {
            box.addView(k.button(k.t("mr_import_see_ignored", plan.ignoredCount), false, new View.OnClickListener() {
                public void onClick(View v) {
                    showIgnored();
                }
            }), k.wide(12));
        }
        if (!nothing && !plan.words.isEmpty()) {
            box.addView(k.label(k.t("mr_import_untick"), 13f, k.text2, false), k.wide(16));
            LinearLayout both = k.row();
            TextView all = k.chip(k.t("mr_import_all"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    tickAll(true);
                }
            });
            TextView none = k.chip(k.t("mr_import_none"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    tickAll(false);
                }
            });
            both.addView(all, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
            lp.setMargins(k.dp(8), 0, 0, 0);
            both.addView(none, lp);
            box.addView(both, k.wide(8));
            mWordBox = k.column();
            box.addView(mWordBox, k.wide(8));
            mMoreWords = k.button(k.t("mr_learned_more"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    drawWords();
                }
            });
            box.addView(mMoreWords, k.wide(8));
            drawWords();
        }
        AlertDialog.Builder b = new AlertDialog.Builder(this)
                .setTitle(k.t(plan.standard ? "mr_import_found_std" : "mr_import_found"))
                .setView(scroll);
        if (nothing) {
            b.setPositiveButton(k.t("mr_words_ok"), null);
        } else {
            b.setNegativeButton(k.t("mr_words_cancel"), null);
            b.setPositiveButton(k.t("mr_import_apply_none"), new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    apply();
                }
            });
        }
        AlertDialog d = b.create();
        d.setOnDismissListener(new DialogInterface.OnDismissListener() {
            public void onDismiss(DialogInterface dialog) {
                // closed by the person (or after Add): the plan goes with it; a newer preview is left alone
                if (mPreview == box) {
                    mPlan = null;
                    mPreview = null;
                    mPreviewDialog = null;
                    mWordBox = null;
                    mMoreWords = null;
                    mApply = null;
                }
            }
        });
        mPreviewDialog = d;
        d.show();
        if (!nothing) {
            mApply = d.getButton(AlertDialog.BUTTON_POSITIVE);
            updateApply();
        }
    }

    /** Draws the next page of words of the preview. */
    private void drawWords() {
        MrImport.Plan plan = mPlan;
        if (plan == null || mWordBox == null) return;
        int end = Math.min(plan.words.size(), mShown + PREVIEW_PAGE);
        for (int i = mShown; i < end; i++) {
            final MrImport.NewWord w = plan.words.get(i);
            final LinearLayout item = k.item(mark(w), plan.standard ? String.valueOf(w.weight) : "×" + w.count, null);
            item.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    w.checked = !w.checked;
                    ((TextView) item.getChildAt(0)).setText(mark(w));
                    updateApply();
                }
            });
            mWordBox.addView(item, k.wide(i == 0 ? 0 : 6));
        }
        mShown = end;
        mMoreWords.setVisibility(mShown < plan.words.size() ? View.VISIBLE : View.GONE);
    }

    private static String mark(MrImport.NewWord w) {
        return (w.checked ? "✓  " : "○  ") + w.word;
    }

    private void tickAll(boolean on) {
        MrImport.Plan plan = mPlan;
        if (plan == null) return;
        for (MrImport.NewWord w : plan.words) w.checked = on;
        mWordBox.removeAllViews();
        mShown = 0;
        drawWords();
        updateApply();
    }

    /** The pairs that will really be saved: the ones whose words are all still ticked. */
    private int pairsToAdd() {
        MrImport.Plan plan = mPlan;
        HashSet<String> unticked = new HashSet<String>();
        for (MrImport.NewWord w : plan.words) if (!w.checked) unticked.add(w.word);
        if (unticked.isEmpty()) return plan.pairs.size();
        int n = 0;
        for (MrImport.NewPair p : plan.pairs) if (!unticked.contains(p.a) && !unticked.contains(p.b)) n++;
        return n;
    }

    /** What the Add button of the dialog says now: how many words and pairs it will save (or that there is nothing to save). */
    private String applyLabel() {
        int words = mPlan.checkedWords();
        int pairs = pairsToAdd();
        return applyAny() ? k.t("mr_import_apply", words, pairs) : k.t("mr_import_apply_none");
    }

    private boolean applyAny() {
        return mPlan.checkedWords() + pairsToAdd() + mPlan.blocked.size() > 0;
    }

    private void updateApply() {
        if (mApply == null || mPlan == null) return;
        mApply.setText(applyLabel());
        mApply.setEnabled(applyAny());
    }

    private void showIgnored() {
        MrImport.Plan plan = mPlan;
        if (plan == null) return;
        StringBuilder sb = new StringBuilder();
        for (MrImport.Ignored g : plan.ignored) {
            sb.append(k.t("mr_import_line", g.line)).append(": ").append(g.text).append("\n   → ").append(k.t("mr_import_why_" + g.reason)).append("\n");
        }
        if (plan.ignoredCount > plan.ignored.size()) {
            sb.append("\n").append(k.t("mr_import_ignored_more", plan.ignoredCount - plan.ignored.size()));
        }
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_import_see_ignored", plan.ignoredCount))
                .setMessage(sb.toString())
                .setPositiveButton(k.t("mr_words_ok"), null)
                .show();
    }

    // ------------------------------------------------------------------ saving

    private void apply() {
        if (mBusy || mPlan == null) return;
        final MrImport.Plan plan = mPlan;
        final String locale = mLocale;
        final MrWordStore store = mStore;
        setBusy(true, k.t("mr_import_saving"));
        new Thread(new Runnable() {
            public void run() {
                MrLearned.Result res = null;
                try {
                    res = MrLearned.apply(store, plan, locale, System.currentTimeMillis());
                } catch (RuntimeException e) {
                    res = null;
                }
                final MrLearned.Result done = res;
                runOnUiThread(new Runnable() {
                    public void run() {
                        setBusy(false, null);
                        if (done == null) {
                            if (!isFinishing()) k.toast(k.t("mr_import_failed"));
                            return;
                        }
                        if (done.total() > 0) MrLearned.changed(MrImportActivity.this);
                        remember(done, locale);
                        if (isFinishing()) return;
                        report(done);
                        mPlan = null;
                        clearPreview();
                        mText.setText("");
                        refreshUndo();
                    }
                });
            }
        }).start();
    }

    private void report(MrLearned.Result r) {
        StringBuilder sb = new StringBuilder();
        if (r.total() == 0) sb.append(k.t("mr_import_added_none"));
        else sb.append(k.t("mr_import_added", r.words, r.pairs));
        if (r.blocked > 0) sb.append("\n").append(k.t("mr_import_added_blocked", r.blocked));
        if (r.dupWords + r.dupPairs > 0) sb.append("\n").append(k.t("mr_import_dups", r.dupWords + r.dupPairs));
        if (r.cappedWords + r.cappedPairs > 0) sb.append("\n").append(k.t("mr_import_capped", r.cappedWords + r.cappedPairs));
        if (r.blockedSkipped > 0) sb.append("\n").append(k.t("mr_import_blocked_skipped", r.blockedSkipped));
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_import_done_title"))
                .setMessage(sb.toString())
                .setPositiveButton(k.t("mr_words_ok"), null)
                .show();
    }

    // ------------------------------------------------------------------ formatting with the AI

    /** The "Format with AI" button. */
    private void formatTapped() {
        if (mBusy) return;
        String text = source();
        if (text.trim().length() == 0) {
            k.toast(k.t("mr_import_nothing"));
            return;
        }
        if (MrImport.isStandard(text)) {
            k.toast(k.t("mr_import_ai_already"));
            return;
        }
        if (!MrAi.configured(this)) {
            new AlertDialog.Builder(this)
                    .setTitle(k.t("mr_import_ai_nokey_title"))
                    .setMessage(k.t("mr_import_ai_nokey_text"))
                    .setNegativeButton(k.t("mr_words_cancel"), null)
                    .setPositiveButton(k.t("mr_import_ai_nokey_open"), new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            try {
                                startActivity(MrNav.intent(MrImportActivity.this, MrAiPrefs.class));
                            } catch (RuntimeException e) {
                                k.toast(k.t("mr_words_no_files"));
                            }
                        }
                    })
                    .show();
            return;
        }
        prepareAi(text);
    }

    /** Takes out what must not leave the phone and cuts the text in parts (off the main thread: a file can be large), then asks. */
    private void prepareAi(final String text) {
        if (mBusy) return;
        setBusy(true, k.t("mr_import_ai_preparing"));
        new Thread(new Runnable() {
            public void run() {
                MrImportAi.Plan plan = null;
                try {
                    plan = MrImportAi.plan(text);
                } catch (RuntimeException e) {
                    plan = null;
                } catch (OutOfMemoryError e) {
                    plan = null;
                }
                final MrImportAi.Plan done = plan;
                runOnUiThread(new Runnable() {
                    public void run() {
                        setBusy(false, null);
                        if (isFinishing()) return;
                        if (done == null) k.toast(k.t("mr_import_failed"));
                        else if (done.requests() == 0) k.toast(k.t("mr_import_ai_nothing"));
                        else askToSend(done);
                    }
                });
            }
        }).start();
    }

    /** The question before anything leaves the phone: where it goes, how much, and the choice of not sending (not remembered). */
    private void askToSend(final MrImportAi.Plan plan) {
        String host = MrAi.serviceHost(this);
        if (host.length() == 0) host = k.t("mr_import_ai_your_service");
        StringBuilder sb = new StringBuilder(k.t("mr_import_ai_ask_text", host, plan.chars, plan.requests()));
        if (plan.truncated) sb.append("\n\n").append(k.t("mr_import_ai_ask_cut", plan.chars, plan.requests()));
        if (plan.requests() > MrImportAi.MANY_REQUESTS) sb.append("\n\n").append(k.t("mr_import_ai_ask_many", plan.requests()));
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_import_ai_ask_title"))
                .setMessage(sb.toString())
                .setNegativeButton(k.t("mr_import_ai_dont"), null)
                .setPositiveButton(k.t("mr_import_ai_send"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        runAi(plan);
                    }
                })
                .show();
    }

    private void runAi(final MrImportAi.Plan plan) {
        if (mBusy) return;
        final String tag = MrLearned.tag(mLocale);
        mAiCancelled = false;
        setBusy(true, k.t("mr_import_ai_progress", 1, plan.requests()));
        mAiCancel.setVisibility(View.VISIBLE);
        final MrImportAi.Sender sender = new MrImportAi.Sender() {
            public String send(String system, String user) throws MrImportAi.Fail {
                try {
                    return MrAi.complete(MrImportActivity.this, system, user, MrImportAi.TEMPERATURE);
                } catch (MrAi.AiFail f) {
                    throw new MrImportAi.Fail(f.getMessage());
                }
            }
        };
        final MrImportAi.Control control = new MrImportAi.Control() {
            public boolean cancelled() {
                // leaving the screen stops the requests too: nothing more is spent on a result nobody will see
                return mAiCancelled || isFinishing();
            }

            public void progress(final int done, final int total) {
                runOnUiThread(new Runnable() {
                    public void run() {
                        if (mBusy) mStatus.setText(k.t("mr_import_ai_progress", done + 1, total));
                    }
                });
            }
        };
        new Thread(new Runnable() {
            public void run() {
                MrImportAi.Result res;
                try {
                    res = MrImportAi.run(plan, tag, sender, control);
                } catch (RuntimeException e) {
                    res = new MrImportAi.Result();
                    res.parts = plan.requests();
                    res.failure = "";
                } catch (OutOfMemoryError e) {
                    res = new MrImportAi.Result();
                    res.parts = plan.requests();
                    res.failure = "";
                }
                final MrImportAi.Result result = res;
                runOnUiThread(new Runnable() {
                    public void run() {
                        finishAi(result);
                    }
                });
            }
        }).start();
    }

    private String failureText(String failure) {
        return failure == null || failure.length() == 0 ? k.t("mr_ai_net_fail") : failure;
    }

    private void finishAi(MrImportAi.Result r) {
        setBusy(false, null);
        mAiCancel.setVisibility(View.GONE);
        if (isFinishing()) return;
        if (r.empty()) {
            // nothing usable came back: the text stays as it was
            if (r.failure != null) {
                new AlertDialog.Builder(this)
                        .setTitle(k.t("mr_import_ai_fail_title"))
                        .setMessage(failureText(r.failure))
                        .setPositiveButton(k.t("mr_words_ok"), null)
                        .show();
            } else {
                k.toast(k.t(r.cancelled ? "mr_import_ai_cancelled" : "mr_import_ai_back_nothing"));
            }
            return;
        }
        setBox(r.text);
        clearPreview();
        mAiNote.setText(k.t("mr_import_ai_done", r.words, r.phrases));
        mAiNote.setVisibility(View.VISIBLE);
        if (!r.complete()) {
            String why = r.failure != null ? failureText(r.failure) : k.t(r.cancelled ? "mr_import_ai_why_cancel" : "mr_import_ai_why_unreadable");
            new AlertDialog.Builder(this)
                    .setTitle(k.t("mr_import_ai_partial_title"))
                    .setMessage(k.t("mr_import_ai_partial", r.done, r.parts, why))
                    .setPositiveButton(k.t("mr_words_ok"), null)
                    .show();
        }
    }

    private void hideAiNote() {
        if (mAiNote == null) return;
        mAiNote.setVisibility(View.GONE);
    }

    // ------------------------------------------------------------------ undo the last import

    private SharedPreferences prefs() {
        return getSharedPreferences(PREFS, MODE_PRIVATE);
    }

    private void remember(MrLearned.Result r, String locale) {
        if (r.batch <= 0 || r.words + r.pairs == 0) return;
        prefs().edit().putLong(P_BATCH, r.batch).putString(P_LOCALE, locale).putInt(P_COUNT, r.words + r.pairs).apply();
    }

    private void refreshUndo() {
        long batch = prefs().getLong(P_BATCH, 0);
        if (batch <= 0) {
            mUndo.setVisibility(View.GONE);
            return;
        }
        mUndo.setText(k.t("mr_import_undo", prefs().getInt(P_COUNT, 0)));
        mUndo.setVisibility(View.VISIBLE);
    }

    private void undoLast() {
        final long batch = prefs().getLong(P_BATCH, 0);
        final String locale = prefs().getString(P_LOCALE, mLocale);
        if (batch <= 0 || locale == null) return;
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_import_undo_title"))
                .setMessage(k.t("mr_import_undo_ask", prefs().getInt(P_COUNT, 0), k.langName(locale)))
                .setNegativeButton(k.t("mr_words_cancel"), null)
                .setPositiveButton(k.t("mr_words_undo"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        int n;
                        try {
                            n = MrLearned.undo(mStore, locale, batch);
                        } catch (RuntimeException e) {
                            k.toast(k.t("mr_learned_unavailable"));
                            return;
                        }
                        prefs().edit().remove(P_BATCH).remove(P_LOCALE).remove(P_COUNT).apply();
                        MrLearned.changed(MrImportActivity.this);
                        k.toast(k.t("mr_import_undone", n));
                        refreshUndo();
                    }
                })
                .show();
    }
}
