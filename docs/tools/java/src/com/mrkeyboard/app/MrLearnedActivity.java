package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * v1.85: "What the keyboard learned" (screen A of Phase 2). Shows, per language, three lists: what the keyboard learned on its own, what the user
 * added on purpose (screen B) and the blocked words. Each row can be fixed, blocked (never suggested nor learned again), forgotten or, for a blocked
 * word, allowed again. The lists are paged (50 at a time) and searchable; "Export" writes the standard word list (mr-words 1) to a file the user picks.
 * The data lives in MrLearned / MrWordStore (the rules are tested on the PC); this class is only views. Every change tells the keyboard to read its
 * dictionaries again (MrLearned.changed).
 */
public class MrLearnedActivity extends Activity {
    /** The language the screen opens on ("pt_BR"). */
    static final String EXTRA_LOCALE = "mr_words_locale";
    static final int PAGE = 50;
    private static final int REQ_EXPORT = 7101;
    static final int TAB_LEARNED = 0;
    static final int TAB_ADDED = 1;
    static final int TAB_BLOCKED = 2;
    private static final int A_EDIT = 1;
    private static final int A_BLOCK = 2;
    private static final int A_FORGET = 3;
    private static final int A_ALLOW = 4;
    private static final String S_LOCALE = "mr_words_s_locale";
    private static final String S_TAB = "mr_words_s_tab";
    private static final String S_TYPE = "mr_words_s_type";
    private static final String S_SORT = "mr_words_s_sort";
    private static final String S_FILTER = "mr_words_s_filter";

    private MrKit k;
    private MrWordStore mStore;
    private String mLocale;
    private int mTab = TAB_LEARNED;
    /** 0 = words, 1 = pairs of words. */
    private int mType;
    private int mSort = MrWordStore.SORT_USED;
    private String mFilter = "";
    private int mLimit = PAGE;
    private List<String> mLangs = new ArrayList<String>();
    private String mExportLocale;

    private LinearLayout mLangBox;
    private LinearLayout mTabBox;
    private LinearLayout mTypeBox;
    private LinearLayout mListBox;
    private TextView mSortChip;
    private TextView mEmpty;
    private TextView mMore;
    private EditText mSearch;
    private TextView mDeleteAll;

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        out.putString(S_LOCALE, mLocale);
        out.putInt(S_TAB, mTab);
        out.putInt(S_TYPE, mType);
        out.putInt(S_SORT, mSort);
        out.putString(S_FILTER, mFilter);
        MrScreenIme.save(out, mSearch, null);
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
        if (state != null) {
            mLocale = state.getString(S_LOCALE);
            mTab = clamp(state.getInt(S_TAB, TAB_LEARNED), 0, 2);
            mType = clamp(state.getInt(S_TYPE, 0), 0, 1);
            mSort = state.getInt(S_SORT, MrWordStore.SORT_USED) == MrWordStore.SORT_NEW ? MrWordStore.SORT_NEW : MrWordStore.SORT_USED;
            String f = state.getString(S_FILTER);
            mFilter = f == null ? "" : f;
        }
        if (mLocale == null && getIntent() != null) mLocale = getIntent().getStringExtra(EXTRA_LOCALE);
        loadLanguages();
        MrLang.remember(getSharedPreferences(MrLang.PREFS, MODE_PRIVATE), mLocale);

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(k.round(k.bg, 0, 0, false));
        LinearLayout col = k.column();
        col.setPadding(k.dp(20), k.dp(16), k.dp(20), k.dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        MrScreenIme.lift(scroll, col, k.dp(20), k.dp(16), k.dp(20), k.dp(24), k.dp(12));

        col.addView(k.backHeader(k.t("mr_learned_title"), new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        }), k.wide(0));
        TextView intro = k.label(k.t("mr_learned_intro"), 14f, k.text2, false);
        col.addView(intro, k.wide(8));

        mLangBox = k.column();
        col.addView(mLangBox, k.wide(16));
        mTabBox = k.column();
        col.addView(mTabBox, k.wide(12));
        mTypeBox = k.column();
        col.addView(mTypeBox, k.wide(8));

        LinearLayout find = k.row();
        mSearch = k.field(k.t("mr_learned_search_hint"), InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        mSearch.setSingleLine(true);
        mSearch.setText(mFilter);
        mSearch.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            public void afterTextChanged(Editable s) {
                String now = s == null ? "" : s.toString().trim();
                if (now.equals(mFilter)) return;
                mFilter = now;
                mLimit = PAGE;
                refreshList();
            }
        });
        find.addView(mSearch, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        mSortChip = k.chip("", false, new View.OnClickListener() {
            public void onClick(View v) {
                mSort = mSort == MrWordStore.SORT_USED ? MrWordStore.SORT_NEW : MrWordStore.SORT_USED;
                mLimit = PAGE;
                refreshList();
            }
        });
        mSortChip.setBackground(k.round(k.card, k.stroke, 12f, false));
        LinearLayout.LayoutParams sp = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.MATCH_PARENT);
        sp.setMargins(k.dp(8), 0, 0, 0);
        find.addView(mSortChip, sp);
        col.addView(find, k.wide(12));

        mListBox = k.column();
        col.addView(mListBox, k.wide(12));
        mEmpty = k.label("", 14f, k.text2, false);
        mEmpty.setPadding(k.dp(4), k.dp(12), k.dp(4), k.dp(12));
        col.addView(mEmpty, k.wide(0));
        mMore = k.button(k.t("mr_learned_more"), false, new View.OnClickListener() {
            public void onClick(View v) {
                mLimit += PAGE;
                refreshList();
            }
        });
        col.addView(mMore, k.wide(10));

        col.addView(k.iconButton(k.t("mr_learned_add"), "mr_ui_ic_plus", true, new View.OnClickListener() {
            public void onClick(View v) {
                Intent i = MrNav.intent(MrLearnedActivity.this, MrImportActivity.class);
                i.putExtra(MrImportActivity.EXTRA_LOCALE, mLocale);
                startActivity(i);
            }
        }), k.wide(22));
        col.addView(k.iconButton(k.t("mr_learned_export"), "mr_ui_ic_export", false, new View.OnClickListener() {
            public void onClick(View v) {
                startExport();
            }
        }), k.wide(10));
        mDeleteAll = k.label("", 14f, k.rose, false);
        mDeleteAll.setGravity(android.view.Gravity.CENTER);
        mDeleteAll.setPadding(k.dp(8), k.dp(14), k.dp(8), k.dp(4));
        mDeleteAll.setClickable(true);
        mDeleteAll.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                askDeleteAll();
            }
        });
        col.addView(mDeleteAll, k.wide(8));

        setContentView(scroll);
        MrScreenIme.restore(state, mSearch, null);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (mStore == null) return;
        // The import screen may have added words while this one was behind it, perhaps for another language: follow the last choice.
        String last = MrLang.last(getSharedPreferences(MrLang.PREFS, MODE_PRIVATE));
        if (last != null) mLocale = last;
        loadLanguages();
        refreshAll();
    }

    private static int clamp(int v, int lo, int hi) {
        return Math.max(lo, Math.min(hi, v));
    }

    // ------------------------------------------------------------------ languages

    /** The languages to offer (MrLang.offered) and the one on: this screen's own choice, else the last one chosen on a word screen, else the UI language. */
    private void loadLanguages() {
        List<String> have;
        try {
            have = mStore.locales();
        } catch (RuntimeException e) {
            have = new ArrayList<String>();
        }
        mLangs = MrLang.offered(MrPacks.installedIds(this), have);
        mLocale = MrLang.pick(mLangs, mLocale, MrLang.last(getSharedPreferences(MrLang.PREFS, MODE_PRIVATE)),
                getResources().getConfiguration().locale.getLanguage());
    }

    // ------------------------------------------------------------------ drawing

    private void refreshAll() {
        int[] n;
        try {
            n = MrLearned.counts(mStore, mLocale);
        } catch (RuntimeException e) {
            n = new int[5];
        }
        k.languageCard(mLangBox, mLangs, mLocale, new MrKit.LangPick() {
            public void onPick(String locale) {
                mLocale = locale;
                MrLang.remember(getSharedPreferences(MrLang.PREFS, MODE_PRIVATE), locale);
                mLimit = PAGE;
                refreshAll();
            }
        });

        ArrayList<TextView> tabs = new ArrayList<TextView>();
        tabs.add(tabChip(TAB_LEARNED, k.t("mr_learned_tab_learned", n[MrWordStore.KIND_LEARNED_WORD] + n[MrWordStore.KIND_LEARNED_PAIR])));
        tabs.add(tabChip(TAB_ADDED, k.t("mr_learned_tab_added", n[MrWordStore.KIND_IMPORTED_WORD] + n[MrWordStore.KIND_IMPORTED_PAIR])));
        tabs.add(tabChip(TAB_BLOCKED, k.t("mr_learned_tab_blocked", n[MrWordStore.KIND_BLOCKED])));
        k.fill(mTabBox, tabs, 3);

        ArrayList<TextView> types = new ArrayList<TextView>();
        if (mTab != TAB_BLOCKED) {
            int w = mTab == TAB_LEARNED ? n[MrWordStore.KIND_LEARNED_WORD] : n[MrWordStore.KIND_IMPORTED_WORD];
            int p = mTab == TAB_LEARNED ? n[MrWordStore.KIND_LEARNED_PAIR] : n[MrWordStore.KIND_IMPORTED_PAIR];
            types.add(typeChip(0, k.t("mr_learned_type_words", w)));
            types.add(typeChip(1, k.t("mr_learned_type_pairs", p)));
        }
        k.fill(mTypeBox, types, 2);
        mTypeBox.setVisibility(types.isEmpty() ? View.GONE : View.VISIBLE);
        refreshList();
    }

    private TextView tabChip(final int tab, String label) {
        return k.tabChip(label, mTab == tab, new View.OnClickListener() {
            public void onClick(View v) {
                mTab = tab;
                mLimit = PAGE;
                refreshAll();
            }
        });
    }

    private TextView typeChip(final int type, String label) {
        return k.chip(label, mType == type, new View.OnClickListener() {
            public void onClick(View v) {
                mType = type;
                mLimit = PAGE;
                refreshAll();
            }
        });
    }

    private int kind() {
        if (mTab == TAB_BLOCKED) return MrWordStore.KIND_BLOCKED;
        if (mTab == TAB_LEARNED) return mType == 0 ? MrWordStore.KIND_LEARNED_WORD : MrWordStore.KIND_LEARNED_PAIR;
        return mType == 0 ? MrWordStore.KIND_IMPORTED_WORD : MrWordStore.KIND_IMPORTED_PAIR;
    }

    private void refreshList() {
        mListBox.removeAllViews();
        mSortChip.setText(k.t(mSort == MrWordStore.SORT_USED ? "mr_learned_sort_used" : "mr_learned_sort_new"));
        mSortChip.setVisibility(mTab == TAB_BLOCKED ? View.GONE : View.VISIBLE);
        List<MrWordStore.Row> rows;
        try {
            rows = mStore.list(kind(), mLocale, mFilter, mSort, 0, mLimit + 1);
        } catch (RuntimeException e) {
            rows = new ArrayList<MrWordStore.Row>();
            k.toast(k.t("mr_learned_unavailable"));
        }
        boolean more = rows.size() > mLimit;
        int shown = Math.min(rows.size(), mLimit);
        // The list is a table: the word, a thin line and the number (the blocked words have no number, so only the word).
        LinearLayout table = k.table();
        for (int i = 0; i < shown; i++) {
            final MrWordStore.Row r = rows.get(i);
            String note = r.kind == MrWordStore.KIND_BLOCKED ? ""
                    : String.valueOf(r.kind == MrWordStore.KIND_LEARNED_WORD || r.kind == MrWordStore.KIND_LEARNED_PAIR
                            ? MrLearned.weightOfLearned(r.freq) : r.freq);
            k.tableRow(table, r.text(), note, new View.OnClickListener() {
                public void onClick(View v) {
                    menu(r);
                }
            });
        }
        if (shown > 0) mListBox.addView(table, k.wide(0));
        String empty = "";
        if (shown == 0) {
            if (mFilter.length() > 0) empty = k.t("mr_learned_empty_search");
            else empty = k.t(mTab == TAB_LEARNED ? "mr_learned_empty_learned"
                    : mTab == TAB_ADDED ? "mr_learned_empty_added" : "mr_learned_empty_blocked");
        }
        mEmpty.setText(empty);
        mEmpty.setVisibility(shown == 0 ? View.VISIBLE : View.GONE);
        mMore.setVisibility(more ? View.VISIBLE : View.GONE);
        int total = 0;
        try {
            if (mTab == TAB_BLOCKED) total = mStore.count(MrWordStore.KIND_BLOCKED, mLocale);
            else total = mStore.count(mTab == TAB_LEARNED ? MrWordStore.KIND_LEARNED_WORD : MrWordStore.KIND_IMPORTED_WORD, mLocale)
                    + mStore.count(mTab == TAB_LEARNED ? MrWordStore.KIND_LEARNED_PAIR : MrWordStore.KIND_IMPORTED_PAIR, mLocale);
        } catch (RuntimeException e) {
            total = 0;
        }
        mDeleteAll.setText(k.t("mr_learned_delete_all"));
        mDeleteAll.setVisibility(total > 0 ? View.VISIBLE : View.GONE);
    }

    // ------------------------------------------------------------------ a row

    private void menu(final MrWordStore.Row r) {
        final ArrayList<Integer> codes = new ArrayList<Integer>();
        ArrayList<String> labels = new ArrayList<String>();
        if (r.kind == MrWordStore.KIND_BLOCKED) {
            codes.add(A_ALLOW);
            labels.add(k.t("mr_learned_act_allow"));
        } else {
            codes.add(A_EDIT);
            labels.add(k.t("mr_learned_act_edit"));
            if (r.b == null) {
                codes.add(A_BLOCK);
                labels.add(k.t("mr_learned_act_block"));
            }
            codes.add(A_FORGET);
            labels.add(k.t("mr_learned_act_forget"));
        }
        new AlertDialog.Builder(this)
                .setTitle(r.text())
                .setItems(labels.toArray(new CharSequence[0]), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        if (which >= 0 && which < codes.size()) act(codes.get(which), r);
                    }
                })
                .show();
    }

    private void act(int code, MrWordStore.Row r) {
        try {
            switch (code) {
                case A_EDIT:
                    askEdit(r);
                    return;
                case A_BLOCK: {
                    int n = MrLearned.block(mStore, mLocale, r.a, System.currentTimeMillis());
                    if (n < 0) k.toast(k.t("mr_learned_cannot_block"));
                    else k.toast(k.t("mr_learned_blocked_done", r.a, n));
                    break;
                }
                case A_FORGET:
                    MrLearned.forget(mStore, r.kind, r.id);
                    k.toast(k.t("mr_learned_forgotten"));
                    break;
                case A_ALLOW:
                    MrLearned.unblock(mStore, r.id);
                    k.toast(k.t("mr_learned_allowed"));
                    break;
                default:
                    return;
            }
        } catch (RuntimeException e) {
            k.toast(k.t("mr_learned_unavailable"));
            return;
        }
        MrLearned.changed(this);
        refreshAll();
    }

    private void askEdit(final MrWordStore.Row r) {
        final EditText box = k.field("", InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        box.setSingleLine(true);
        box.setText(r.text());
        box.setSelection(box.length());
        LinearLayout wrap = k.column();
        wrap.setPadding(k.dp(20), k.dp(8), k.dp(20), 0);
        wrap.addView(box, k.wide(0));
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_learned_edit_title"))
                .setView(wrap)
                .setNegativeButton(k.t("mr_words_cancel"), null)
                .setPositiveButton(k.t("mr_words_ok"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        saveEdit(r, box.getText() == null ? "" : box.getText().toString());
                    }
                })
                .show();
    }

    private void saveEdit(MrWordStore.Row r, String text) {
        boolean pair = r.b != null;
        if (pair && MrImport.splitWords(text.replace('’', '\''), 2) == null) {
            k.toast(k.t("mr_learned_need_two"));
            return;
        }
        int res;
        try {
            res = MrLearned.edit(mStore, mLocale, r, text);
        } catch (RuntimeException e) {
            k.toast(k.t("mr_learned_unavailable"));
            return;
        }
        if (res == 0) {
            k.toast(k.t("mr_learned_saved"));
            MrLearned.changed(this);
            refreshAll();
        } else if (res > 0) {
            k.toast(k.t("mr_import_why_" + res));
        } else {
            k.toast(k.t("mr_learned_unavailable"));
        }
    }

    // ------------------------------------------------------------------ delete the whole list

    private void askDeleteAll() {
        final int tab = mTab;
        new AlertDialog.Builder(this)
                .setTitle(k.t("mr_learned_delete_all"))
                .setMessage(k.t(tab == TAB_LEARNED ? "mr_learned_delete_ask_learned"
                        : tab == TAB_ADDED ? "mr_learned_delete_ask_added" : "mr_learned_delete_ask_blocked", k.langName(mLocale)))
                .setNegativeButton(k.t("mr_words_cancel"), null)
                .setPositiveButton(k.t("mr_words_delete"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        deleteAll(tab);
                    }
                })
                .show();
    }

    private void deleteAll(int tab) {
        int n;
        try {
            if (tab == TAB_LEARNED) n = MrLearned.deleteAllLearned(mStore, mLocale);
            else if (tab == TAB_ADDED) n = MrLearned.deleteAllImported(mStore, mLocale);
            else n = mStore.deleteAll(MrWordStore.KIND_BLOCKED, mLocale);
        } catch (RuntimeException e) {
            k.toast(k.t("mr_learned_unavailable"));
            return;
        }
        k.toast(k.t("mr_learned_deleted", n));
        MrLearned.changed(this);
        refreshAll();
    }

    // ------------------------------------------------------------------ export

    private void startExport() {
        mExportLocale = mLocale;
        Intent i = new Intent(Intent.ACTION_CREATE_DOCUMENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("text/plain");
        i.putExtra(Intent.EXTRA_TITLE, "mr-keyboard-words-" + MrLearned.tag(mLocale) + ".txt");
        try {
            startActivityForResult(i, REQ_EXPORT);
        } catch (RuntimeException e) {
            k.toast(k.t("mr_words_no_files"));
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode != REQ_EXPORT || resultCode != RESULT_OK || data == null || data.getData() == null) return;
        final Uri uri = data.getData();
        final String locale = mExportLocale != null ? mExportLocale : mLocale;
        final MrWordStore store = mStore;
        new Thread(new Runnable() {
            public void run() {
                boolean ok = false;
                try {
                    byte[] bytes = MrLearned.export(store, locale).getBytes("UTF-8");
                    OutputStream os = getContentResolver().openOutputStream(uri, "wt");
                    if (os != null) {
                        try {
                            os.write(bytes);
                            os.flush();
                            ok = true;
                        } finally {
                            os.close();
                        }
                    }
                } catch (Exception e) {
                    ok = false;
                }
                final boolean done = ok;
                runOnUiThread(new Runnable() {
                    public void run() {
                        if (!isFinishing()) k.toast(k.t(done ? "mr_learned_export_done" : "mr_learned_export_failed"));
                    }
                });
            }
        }).start();
    }
}
