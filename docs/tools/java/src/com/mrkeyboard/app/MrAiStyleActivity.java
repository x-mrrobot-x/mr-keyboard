package com.mrkeyboard.app;

import android.app.Activity;
import android.content.Context;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

/**
 * "Novo Estilo" (New Style) screen of the AI Editor (v1.80), modelled on the Telegram screen that served as
 * a reference: round icon with the chosen emoji, name, instructions and the big Create button.
 * It is a separate screen from the AI Editor dialog because here the name and the
 * instructions must be typed with the normal keyboard. The dialog is closed before this Activity opens. With the extra EXTRA_STYLE >= 0
 * it edits the style at that position (and shows Delete, with confirmation on the second tap).
 * The styles live in MrAi (SharedPreferences "mr_ai"); colors from the mr_ui_* palette of the screens.
 */
public class MrAiStyleActivity extends Activity {
    private static final String[] EMOJIS = {
            "✨", "🏴", "☠️", "⚔️", "🛡️", "👑", "🧙", "🦸",
            "🤠", "🤖", "🧠", "💡", "📜", "📚", "🎓", "💼",
            "🏢", "💻", "🚀", "🔥", "⚡", "🌊", "🌿", "☀️",
            "🌙", "⭐", "😎", "😂", "🥰", "🤔", "😴", "🎭",
            "🎸", "🎯", "✍️", "📝", "💬", "📢", "❤️", "🔮"};
    private static final int C_CLOSE = 1;
    private static final int C_SAVE = 2;
    private static final int C_DELETE = 3;
    private static final int C_EMOJI = 100;
    // What the screen keeps when it is recreated (rotation, language, dark mode): the fields have no id, so the
    // system would not save what was typed.
    private static final String S_NAME = "mr_style_name";
    private static final String S_INSTR = "mr_style_instr";
    private static final String S_EMOJI = "mr_style_emoji";
    private static final String S_ARMED = "mr_style_delete_armed";

    /** Click bridge with code (as in the other panels): calls onAction of the live screen. */
    private final class Act implements View.OnClickListener {
        private final int code;

        Act(int c) {
            code = c;
        }

        public void onClick(View v) {
            onAction(code);
        }
    }

    private int mIndex = -1;
    private String mEmoji = EMOJIS[0];
    private TextView mCircle;
    private EditText mName;
    private EditText mInstr;
    private TextView mDelete;
    private boolean mDeleteArmed;
    private final ArrayList<TextView> mEmojiViews = new ArrayList<TextView>();

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onResume() {
        super.onResume();
        MrAiDialog.setAuxiliaryUiVisible(true);
    }

    @Override
    protected void onPause() {
        MrAiDialog.setAuxiliaryUiVisible(false);
        super.onPause();
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        if (mName == null || mInstr == null) return;
        out.putString(S_NAME, mName.getText() == null ? "" : mName.getText().toString());
        out.putString(S_INSTR, mInstr.getText() == null ? "" : mInstr.getText().toString());
        out.putString(S_EMOJI, mEmoji);
        out.putBoolean(S_ARMED, mDeleteArmed);
        MrScreenIme.save(out, mName, mInstr);
    }

    /** Puts back what was typed and chosen before the screen was recreated; wins over what is stored. */
    private void restoreDraft(Bundle state) {
        if (state == null || !state.containsKey(S_NAME)) return;
        mName.setText(state.getString(S_NAME));
        mInstr.setText(state.getString(S_INSTR));
        String emoji = state.getString(S_EMOJI);
        for (int i = 0; i < EMOJIS.length; i++) {
            if (EMOJIS[i].equals(emoji)) mEmoji = emoji;
        }
        if (state.getBoolean(S_ARMED, false) && mDelete != null) {
            mDeleteArmed = true;
            mDelete.setText(t("mr_ai_style_delete_again"));
        }
    }

    private String t(String name) {
        String s = MrPacks.text(this, name);
        return s != null ? s : name;
    }

    private int color(String name) {
        return getResources().getColor(getResources().getIdentifier(name, "color", getPackageName()));
    }

    private int dp(float v) {
        return Math.round(v * getResources().getDisplayMetrics().density);
    }

    private GradientDrawable round(int fill, int stroke, float radiusDp, boolean oval) {
        GradientDrawable d = new GradientDrawable();
        if (oval) d.setShape(GradientDrawable.OVAL);
        else d.setCornerRadius(dp(radiusDp));
        d.setColor(fill);
        if (stroke != 0) d.setStroke(Math.max(1, dp(1)), stroke);
        return d;
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        if (getIntent() != null) mIndex = getIntent().getIntExtra(MrAi.EXTRA_STYLE, -1);
        ArrayList<String[]> list = MrAi.loadCustom(this);
        final boolean editing = mIndex >= 0 && mIndex < list.size();
        if (!editing) mIndex = -1;

        int bg = color("mr_ui_bg");
        int card = color("mr_ui_card");
        int stroke = color("mr_ui_stroke_strong");
        int text = color("mr_ui_text");
        int text2 = color("mr_ui_text2");
        int accent = color("mr_accent");
        int onAccent = color("mr_text_on_accent");
        int rose = color("mr_ui_rose");

        ScrollView scroll = new ScrollView(this);
        scroll.setBackground(round(bg, 0, 0, false));
        LinearLayout col = new LinearLayout(this);
        col.setOrientation(LinearLayout.VERTICAL);
        col.setPadding(dp(20), dp(16), dp(20), dp(24));
        scroll.addView(col, new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        // Android 15+: the window is not resized for the keyboard; the column gets its height as bottom padding.
        MrScreenIme.lift(scroll, col, dp(20), dp(16), dp(20), dp(24), dp(12));

        // header: title + close (✕), as in the reference
        LinearLayout head = new LinearLayout(this);
        head.setOrientation(LinearLayout.HORIZONTAL);
        head.setGravity(Gravity.CENTER_VERTICAL);
        TextView title = new TextView(this);
        title.setText(t(editing ? "mr_ai_edit_style" : "mr_ai_new_style"));
        title.setTextColor(text);
        title.setTextSize(24f);
        title.setTypeface(null, Typeface.BOLD);
        head.addView(title, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView close = new TextView(this);
        close.setText("✕");
        close.setTextColor(text);
        close.setTextSize(20f);
        close.setGravity(Gravity.CENTER);
        close.setPadding(dp(10), dp(6), dp(10), dp(6));
        close.setOnClickListener(new Act(C_CLOSE));
        head.addView(close, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        col.addView(head, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        // icon circle
        LinearLayout circleRow = new LinearLayout(this);
        circleRow.setOrientation(LinearLayout.HORIZONTAL);
        circleRow.setGravity(Gravity.CENTER);
        circleRow.setPadding(0, dp(18), 0, dp(18));
        mCircle = new TextView(this);
        mCircle.setTextColor(text);
        mCircle.setTextSize(40f);
        mCircle.setGravity(Gravity.CENTER);
        mCircle.setBackground(round(card, stroke, 0, true));
        circleRow.addView(mCircle, new LinearLayout.LayoutParams(dp(88), dp(88)));
        col.addView(circleRow, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

        mName = field(card, stroke, text, text2, t("mr_ai_style_name_hint"),
                InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_CAP_SENTENCES);
        mName.setSingleLine(true);
        col.addView(mName, fieldParams(0));

        mInstr = field(card, stroke, text, text2, t("mr_ai_style_instr_hint"),
                InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_CAP_SENTENCES
                        | InputType.TYPE_TEXT_FLAG_MULTI_LINE);
        mInstr.setMinLines(3);
        mInstr.setGravity(Gravity.TOP);
        col.addView(mInstr, fieldParams(12));

        TextView iconLabel = new TextView(this);
        iconLabel.setText(t("mr_ai_style_icon"));
        iconLabel.setTextColor(text2);
        iconLabel.setTextSize(13f);
        LinearLayout.LayoutParams llp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        llp.setMargins(dp(4), dp(18), dp(4), dp(6));
        col.addView(iconLabel, llp);

        for (int row = 0; row * 8 < EMOJIS.length; row++) {
            LinearLayout r = new LinearLayout(this);
            r.setOrientation(LinearLayout.HORIZONTAL);
            for (int j = 0; j < 8 && row * 8 + j < EMOJIS.length; j++) {
                int idx = row * 8 + j;
                TextView e = new TextView(this);
                e.setText(EMOJIS[idx]);
                e.setTextSize(22f);
                e.setGravity(Gravity.CENTER);
                e.setOnClickListener(new Act(C_EMOJI + idx));
                mEmojiViews.add(e);
                r.addView(e, new LinearLayout.LayoutParams(0, dp(44), 1f));
            }
            col.addView(r, new LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, dp(44)));
        }

        TextView save = new TextView(this);
        save.setText(t(editing ? "mr_ai_style_save_btn" : "mr_ai_style_create_btn"));
        save.setTextColor(onAccent);
        save.setTextSize(16f);
        save.setTypeface(null, Typeface.BOLD);
        save.setGravity(Gravity.CENTER);
        save.setBackground(round(accent, 0, 26, false));
        save.setOnClickListener(new Act(C_SAVE));
        LinearLayout.LayoutParams slp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, dp(52));
        slp.setMargins(0, dp(22), 0, 0);
        col.addView(save, slp);

        if (editing) {
            mDelete = new TextView(this);
            mDelete.setText(t("mr_ai_style_delete"));
            mDelete.setTextColor(rose);
            mDelete.setTextSize(14f);
            mDelete.setGravity(Gravity.CENTER);
            mDelete.setPadding(dp(8), dp(12), dp(8), dp(4));
            mDelete.setOnClickListener(new Act(C_DELETE));
            LinearLayout.LayoutParams dlp = new LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            dlp.setMargins(0, dp(10), 0, 0);
            col.addView(mDelete, dlp);
        }

        if (editing) {
            String[] st = list.get(mIndex);
            mEmoji = st[0];
            mName.setText(st[1]);
            mInstr.setText(st[2]);
        }
        restoreDraft(state);
        refreshEmoji();
        setContentView(scroll);
        MrScreenIme.restore(state, mName, mInstr);
    }

    private EditText field(int card, int stroke, int text, int text2, String hint, int inputType) {
        EditText e = new EditText(this);
        e.setHint(hint);
        e.setHintTextColor(text2);
        e.setTextColor(text);
        e.setTextSize(16f);
        e.setInputType(inputType);
        e.setPadding(dp(14), dp(12), dp(14), dp(12));
        e.setBackground(round(card, stroke, 16, false));
        return e;
    }

    private LinearLayout.LayoutParams fieldParams(int topDp) {
        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        if (topDp > 0) lp.setMargins(0, dp(topDp), 0, 0);
        return lp;
    }

    private void refreshEmoji() {
        mCircle.setText(mEmoji);
        int selBg = color("mr_ui_cyan_soft");
        for (int i = 0; i < mEmojiViews.size(); i++) {
            boolean on = EMOJIS[i].equals(mEmoji);
            mEmojiViews.get(i).setBackground(on ? round(selBg, 0, 12, false) : null);
        }
    }

    private void onAction(int code) {
        if (code >= C_EMOJI && code < C_EMOJI + EMOJIS.length) {
            mEmoji = EMOJIS[code - C_EMOJI];
            refreshEmoji();
            return;
        }
        switch (code) {
            case C_CLOSE:
                finish();
                return;
            case C_SAVE:
                save();
                return;
            case C_DELETE:
                delete();
                return;
            default:
                break;
        }
    }

    private void save() {
        String name = mName.getText() == null ? "" : mName.getText().toString().trim();
        String instr = mInstr.getText() == null ? "" : mInstr.getText().toString().trim();
        if (name.length() == 0) {
            Toast.makeText(this, t("mr_ai_style_need_name"), Toast.LENGTH_SHORT).show();
            return;
        }
        if (instr.length() == 0) {
            Toast.makeText(this, t("mr_ai_style_need_instr"), Toast.LENGTH_SHORT).show();
            return;
        }
        if (name.length() > 40) name = name.substring(0, 40);
        ArrayList<String[]> list = MrAi.loadCustom(this);
        String[] st = new String[]{mEmoji, name, instr};
        if (mIndex >= 0 && mIndex < list.size()) list.set(mIndex, st);
        else if (list.size() < MrAi.MAX_STYLES) list.add(st);
        else list.set(list.size() - 1, st);
        MrAi.saveCustom(this, list);
        Toast.makeText(this, t("mr_ai_style_saved"), Toast.LENGTH_SHORT).show();
        finish();
    }

    private void delete() {
        if (!mDeleteArmed) {
            mDeleteArmed = true;
            if (mDelete != null) mDelete.setText(t("mr_ai_style_delete_again"));
            return;
        }
        ArrayList<String[]> list = MrAi.loadCustom(this);
        if (mIndex >= 0 && mIndex < list.size()) {
            list.remove(mIndex);
            MrAi.saveCustom(this, list);
            Toast.makeText(this, t("mr_ai_style_deleted"), Toast.LENGTH_SHORT).show();
        }
        finish();
    }
}
