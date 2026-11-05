package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
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

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;

/**
 * v1.85: "Add words and texts" (screen B of Phase 2). The user types or pastes a text, or opens a file, and the keyboard learns from it:
 *  - a list in the standard format (mr-words 1: [words] / [phrases] / [blocked]) is taken as it is;
 *  - any other text (a chat export, an essay, notes) is read as free text: only the words the dictionary does not know and that show up
 *    at least twice are proposed, and pairs of words that are both valid and show up at least twice.
 * Nothing is saved before the preview: the user sees the new words (and can untick a typo), the pairs, what was ignored and why. "Add" saves one
 * import (one batch) that "Undo the last import" takes back. A prompt for an AI is offered to turn a big text into the standard list.
 * The rules live in MrImport / MrLearned (tested on the PC); this class is only views and threads. The analysis and the saving run off the main thread.
 */
public class MrImportActivity extends Activity {
    static final String EXTRA_LOCALE = "mr_words_locale";
    /** A file larger than this is cut (a chat export of years is a few MB of text). */
    static final int MAX_FILE_BYTES = 8 * 1024 * 1024;
    /** How many words of the preview are drawn at a time. */
    static final int PREVIEW_PAGE = 100;
    private static final int REQ_OPEN = 7102;
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
    /** The text of an opened file (kept off the field: a few MB in an EditText would be slow). Null when none is loaded. */
    private String mFileText;
    private int mFileKb;
    private MrImport.Plan mPlan;
    private int mShown;

    private LinearLayout mLangBox;
    private EditText mText;
    private TextView mFileLabel;
    private TextView mAnalyze;
    private LinearLayout mPreview;
    private LinearLayout mWordBox;
    private TextView mApply;
    private TextView mMoreWords;
    private TextView mUndo;
    private TextView mStatus;

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

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        LinearLayout col = k.column();
        col.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        MrScreenIme.lift(scroll, col, k.dp(20), k.dp(16), k.dp(20), k.dp(24), k.dp(12));

        col.addView(k.header(k.t("mr_import_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), k.wide(0));
        col.addView(k.label(k.t("mr_import_intro"), 14f, k.text2, false), k.wide(8));

        mLangBox = k.column();
        col.addView(mLangBox, k.wide(16));

        mText = k.field(k.t("mr_import_hint"), InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_MULTI_LINE
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
                // Typing over an opened file means the user wants the typed text now.
                if (mFileText != null && s != null && s.length() > 0) dropFile();
            }
        });
        col.addView(mText, k.wide(14));

        mFileLabel = k.label("", 13f, k.text2, false);
        mFileLabel.setPadding(k.dp(4), k.dp(6), k.dp(4), 0);
        mFileLabel.setVisibility(View.GONE);
        col.addView(mFileLabel, k.wide(0));

        LinearLayout tools = k.row();
        TextView paste = k.button(k.t("mr_import_paste"), false, new View.OnClickListener() {
            public void onClick(View v) {
                paste();
            }
        });
        TextView open = k.button(k.t("mr_import_open"), false, new View.OnClickListener() {
            public void onClick(View v) {
                openFile();
            }
        });
        tools.addView(paste, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        LinearLayout.LayoutParams second = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
        second.setMargins(k.dp(8), 0, 0, 0);
        tools.addView(open, second);
        col.addView(tools, k.wide(10));

        mAnalyze = k.button(k.t("mr_import_analyze"), true, new View.OnClickListener() {
            public void onClick(View v) {
                analyze();
            }
        });
        col.addView(mAnalyze, k.wide(12));
        mStatus = k.label("", 14f, k.text2, false);
        mStatus.setPadding(k.dp(4), k.dp(8), k.dp(4), 0);
        mStatus.setVisibility(View.GONE);
        col.addView(mStatus, k.wide(0));

        mPreview = k.column();
        mPreview.setVisibility(View.GONE);
        col.addView(mPreview, k.wide(10));

        // Turning a big text into the standard list with an AI.
        col.addView(k.label(k.t("mr_import_ai_title"), 18f, k.text, true), k.wide(26));
        col.addView(k.label(k.t("mr_import_ai_text"), 14f, k.text2, false), k.wide(6));
        col.addView(k.button(k.t("mr_import_ai_copy"), false, new View.OnClickListener() {
            public void onClick(View v) {
                copyPrompt();
            }
        }), k.wide(10));
        col.addView(k.label(k.t("mr_import_ai_warn"), 13f, k.rose, false), k.wide(8));

        mUndo = k.button("", false, new View.OnClickListener() {
            public void onClick(View v) {
                undoLast();
            }
        });
        col.addView(mUndo, k.wide(24));

        setContentView(scroll);
        MrScreenIme.restore(state, mText, null);
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
        mLangs = MrLearned.languages(MrPacks.installedIds(this), have);
        if (mLangs.isEmpty()) {
            mLangs.add("pt_BR");
            mLangs.add("en_US");
            mLangs.add("es");
        }
        if (mLocale == null || !mLangs.contains(mLocale)) {
            String ui = getResources().getConfiguration().locale.getLanguage();
            String pick = mLangs.get(0);
            for (String l : mLangs) {
                if (MrPacks.splitLocale(l)[0].equals(ui)) {
                    pick = l;
                    break;
                }
            }
            mLocale = pick;
        }
    }

    private void refreshLanguages() {
        ArrayList<TextView> chips = new ArrayList<TextView>();
        for (final String l : mLangs) {
            chips.add(k.chip(k.langName(l), l.equals(mLocale), new View.OnClickListener() {
                public void onClick(View v) {
                    if (mBusy) return;
                    mLocale = l;
                    // A preview was made for another language: the words may be known there.
                    clearPreview();
                    refreshLanguages();
                }
            }));
        }
        k.fill(mLangBox, chips, 2);
    }

    // ------------------------------------------------------------------ input

    private void paste() {
        try {
            ClipboardManager cm = (ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE);
            ClipData cd = cm == null ? null : cm.getPrimaryClip();
            CharSequence cs = cd != null && cd.getItemCount() > 0 ? cd.getItemAt(0).coerceToText(this) : null;
            if (cs == null || cs.length() == 0) {
                k.toast(k.t("mr_import_clip_empty"));
                return;
            }
            dropFile();
            mText.setText(cs);
            clearPreview();
        } catch (RuntimeException e) {
            k.toast(k.t("mr_import_clip_empty"));
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

    private void openFile() {
        Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("*/*");
        try {
            startActivityForResult(i, REQ_OPEN);
        } catch (RuntimeException e) {
            k.toast(k.t("mr_words_no_files"));
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != REQ_OPEN || resultCode != RESULT_OK || data == null || data.getData() == null) return;
        final Uri uri = data.getData();
        setBusy(true, k.t("mr_import_reading"));
        new Thread(new Runnable() {
            public void run() {
                String text = null;
                boolean cut = false;
                try {
                    InputStream in = getContentResolver().openInputStream(uri);
                    if (in != null) {
                        try {
                            ByteArrayOutputStream buf = new ByteArrayOutputStream();
                            byte[] chunk = new byte[16384];
                            int n;
                            while ((n = in.read(chunk)) > 0) {
                                if (buf.size() + n > MAX_FILE_BYTES) {
                                    buf.write(chunk, 0, MAX_FILE_BYTES - buf.size());
                                    cut = true;
                                    break;
                                }
                                buf.write(chunk, 0, n);
                            }
                            text = MrImport.decode(buf.toByteArray(), cut);
                        } finally {
                            in.close();
                        }
                    }
                } catch (Exception e) {
                    text = null;
                } catch (OutOfMemoryError e) {
                    text = null;
                }
                final String loaded = text;
                final boolean wasCut = cut;
                runOnUiThread(new Runnable() {
                    public void run() {
                        if (isFinishing()) return;
                        setBusy(false, null);
                        if (loaded == null || loaded.trim().length() == 0) {
                            k.toast(k.t(loaded == null ? "mr_import_read_failed" : "mr_import_file_empty"));
                            return;
                        }
                        mText.setText("");
                        mFileText = loaded;
                        mFileKb = Math.max(1, loaded.length() / 1024);
                        mFileLabel.setText(k.t("mr_import_file_loaded", mFileKb));
                        mFileLabel.setVisibility(View.VISIBLE);
                        clearPreview();
                        if (wasCut) k.toast(k.t("mr_import_file_cut", MAX_FILE_BYTES / (1024 * 1024)));
                    }
                });
            }
        }).start();
    }

    private void dropFile() {
        mFileText = null;
        mFileLabel.setVisibility(View.GONE);
    }

    private String source() {
        if (mFileText != null) return mFileText;
        CharSequence t = mText.getText();
        return t == null ? "" : t.toString();
    }

    // ------------------------------------------------------------------ analysis

    private void setBusy(boolean busy, String message) {
        mBusy = busy;
        mAnalyze.setClickable(!busy);
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

    private void clearPreview() {
        mPlan = null;
        mShown = 0;
        if (mPreview != null) {
            mPreview.removeAllViews();
            mPreview.setVisibility(View.GONE);
        }
    }

    private void showPreview() {
        final MrImport.Plan plan = mPlan;
        mPreview.removeAllViews();
        mPreview.setVisibility(View.VISIBLE);
        mShown = 0;
        mPreview.addView(k.label(k.t(plan.standard ? "mr_import_found_std" : "mr_import_found"), 18f, k.text, true), k.wide(0));
        mPreview.addView(k.label(k.t("mr_import_counts", plan.words.size(), plan.pairs.size()), 15f, k.text, false), k.wide(6));
        if (plan.blocked.size() > 0) {
            mPreview.addView(k.label(k.t("mr_import_blocked_found", plan.blocked.size()), 14f, k.text2, false), k.wide(4));
        }
        if (plan.knownSkipped > 0) {
            mPreview.addView(k.label(k.t("mr_import_known", plan.knownSkipped), 14f, k.text2, false), k.wide(4));
        }
        if (plan.pairsCut) {
            mPreview.addView(k.label(k.t("mr_import_pairs_cut"), 14f, k.text2, false), k.wide(4));
        }
        String hint = plan.languageHint;
        if (hint != null && hint.length() > 0 && !MrLearned.localeOf(hint).equalsIgnoreCase(mLocale)) {
            mPreview.addView(k.label(k.t("mr_import_lang_note", hint, MrLearned.tag(mLocale)), 14f, k.rose, false), k.wide(6));
        }
        if (plan.ignoredCount > 0) {
            mPreview.addView(k.button(k.t("mr_import_see_ignored", plan.ignoredCount), false, new View.OnClickListener() {
                public void onClick(View v) {
                    showIgnored();
                }
            }), k.wide(10));
        }
        if (plan.words.isEmpty() && plan.pairs.isEmpty() && plan.blocked.isEmpty()) {
            mPreview.addView(k.label(k.t("mr_import_none_new"), 14f, k.text2, false), k.wide(10));
            mApply = null;
            return;
        }
        if (!plan.words.isEmpty()) {
            mPreview.addView(k.label(k.t("mr_import_untick"), 13f, k.text2, false), k.wide(14));
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
            mPreview.addView(both, k.wide(8));
            mWordBox = k.column();
            mPreview.addView(mWordBox, k.wide(8));
            mMoreWords = k.button(k.t("mr_learned_more"), false, new View.OnClickListener() {
                public void onClick(View v) {
                    drawWords();
                }
            });
            mPreview.addView(mMoreWords, k.wide(8));
            drawWords();
        }
        mApply = k.button("", true, new View.OnClickListener() {
            public void onClick(View v) {
                apply();
            }
        });
        mPreview.addView(mApply, k.wide(16));
        updateApply();
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

    private void updateApply() {
        if (mApply == null || mPlan == null) return;
        int words = mPlan.checkedWords();
        int pairs = pairsToAdd();
        int blocked = mPlan.blocked.size();
        boolean any = words + pairs + blocked > 0;
        mApply.setText(any ? k.t("mr_import_apply", words, pairs) : k.t("mr_import_apply_none"));
        mApply.setClickable(any);
        mApply.setAlpha(any ? 1f : 0.5f);
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
                        dropFile();
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
