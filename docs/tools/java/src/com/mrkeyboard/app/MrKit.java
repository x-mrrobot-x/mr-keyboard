package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.List;

/**
 * v1.85: the little pieces of view that the two word screens (MrLearnedActivity, MrImportActivity) share: the mr_ui_* palette, rounded
 * backgrounds, pills, language chips, fields and rows. Plain views, built in code like MrAiStyleActivity, so the screens need no layout file.
 */
final class MrKit {
    final Activity act;
    final int bg;
    final int card;
    final int stroke;
    final int text;
    final int text2;
    final int accent;
    final int onAccent;
    final int rose;
    final int soft;

    MrKit(Activity a) {
        act = a;
        bg = color("mr_ui_bg");
        card = color("mr_ui_card");
        stroke = color("mr_ui_stroke_strong");
        text = color("mr_ui_text");
        text2 = color("mr_ui_text2");
        accent = color("mr_accent");
        onAccent = color("mr_text_on_accent");
        rose = color("mr_ui_rose");
        soft = color("mr_ui_cyan_soft");
    }

    private int color(String name) {
        return act.getResources().getColor(act.getResources().getIdentifier(name, "color", act.getPackageName()));
    }

    int dp(float v) {
        return Math.round(v * act.getResources().getDisplayMetrics().density);
    }

    /** A text from the string resources; the name itself if it is missing (so a typo shows on the screen). */
    String t(String name, Object... args) {
        String s = MrPacks.text(act, name, args);
        return s != null ? s : name;
    }

    void toast(String msg) {
        Toast.makeText(act, msg, Toast.LENGTH_SHORT).show();
    }

    GradientDrawable round(int fill, int line, float radiusDp, boolean oval) {
        GradientDrawable d = new GradientDrawable();
        if (oval) d.setShape(GradientDrawable.OVAL);
        else d.setCornerRadius(dp(radiusDp));
        d.setColor(fill);
        if (line != 0) d.setStroke(Math.max(1, dp(1)), line);
        return d;
    }

    LinearLayout.LayoutParams lp(int w, int h, int topDp) {
        LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(w, h);
        if (topDp != 0) p.setMargins(0, dp(topDp), 0, 0);
        return p;
    }

    LinearLayout.LayoutParams wide(int topDp) {
        return lp(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT, topDp);
    }

    LinearLayout column() {
        LinearLayout c = new LinearLayout(act);
        c.setOrientation(LinearLayout.VERTICAL);
        return c;
    }

    LinearLayout row() {
        LinearLayout r = new LinearLayout(act);
        r.setOrientation(LinearLayout.HORIZONTAL);
        r.setGravity(Gravity.CENTER_VERTICAL);
        return r;
    }

    TextView label(String s, float sp, int colour, boolean bold) {
        TextView v = new TextView(act);
        v.setText(s);
        v.setTextColor(colour);
        v.setTextSize(sp);
        if (bold) v.setTypeface(null, Typeface.BOLD);
        return v;
    }

    /** The title line with the close mark on the right. */
    LinearLayout header(String title, View.OnClickListener onClose) {
        LinearLayout head = row();
        TextView ti = label(title, 24f, text, true);
        head.addView(ti, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView close = label("✕", 20f, text, false);
        close.setGravity(Gravity.CENTER);
        close.setPadding(dp(10), dp(6), dp(10), dp(6));
        close.setOnClickListener(onClose);
        head.addView(close, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return head;
    }

    /** A big pill: the main action (accent fill) or a quiet one (card with a line). */
    TextView button(String s, boolean primary, View.OnClickListener l) {
        TextView b = label(s, 15f, primary ? onAccent : text, primary);
        b.setGravity(Gravity.CENTER);
        b.setPadding(dp(14), dp(12), dp(14), dp(12));
        b.setBackground(primary ? round(accent, 0, 26, false) : round(card, stroke, 26, false));
        b.setClickable(true);
        b.setOnClickListener(l);
        return b;
    }

    /** A small selectable pill (language, list, type): the selected one is filled. */
    TextView chip(String s, boolean on, View.OnClickListener l) {
        TextView c = label(s, 14f, on ? onAccent : text, on);
        c.setGravity(Gravity.CENTER);
        c.setPadding(dp(12), dp(8), dp(12), dp(8));
        c.setBackground(on ? round(accent, 0, 18, false) : round(card, stroke, 18, false));
        c.setClickable(true);
        c.setOnClickListener(l);
        return c;
    }

    /** Puts the chips in rows of {@code perRow} (they share the width), into {@code box} (emptied first). */
    void fill(LinearLayout box, List<TextView> chips, int perRow) {
        box.removeAllViews();
        LinearLayout r = null;
        for (int i = 0; i < chips.size(); i++) {
            if (i % perRow == 0) {
                r = row();
                box.addView(r, wide(i == 0 ? 0 : 8));
            }
            LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f);
            if (i % perRow != 0) p.setMargins(dp(8), 0, 0, 0);
            r.addView(chips.get(i), p);
        }
    }

    /**
     * A select card, like the choices of the Settings: the title small on top, the chosen value below and an arrow on the right.
     * A tap on it is the caller's {@code l} (usually the list of choices).
     */
    LinearLayout select(String title, String value, View.OnClickListener l) {
        LinearLayout c = row();
        c.setPadding(dp(16), dp(12), dp(14), dp(12));
        c.setBackground(round(card, stroke, 16, false));
        c.setClickable(true);
        c.setOnClickListener(l);
        LinearLayout words = column();
        words.addView(label(title, 12f, text2, false), wide(0));
        words.addView(label(value, 17f, text, true), wide(2));
        c.addView(words, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        TextView arrow = label("▾", 18f, text2, false);
        arrow.setPadding(dp(10), 0, 0, 0);
        c.addView(arrow, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        return c;
    }

    /** What happens when a language is chosen on a language card. */
    interface LangPick {
        void onPick(String locale);
    }

    /**
     * The language card of the word screens: shows the language that is on and, on a tap, a list with a radio mark to choose another
     * (the same dialog as the Settings). {@code onPick} is called only when the choice changes.
     */
    void languageCard(LinearLayout box, final List<String> langs, final String current, final LangPick onPick) {
        box.removeAllViews();
        box.addView(select(t("mr_lang_card_title"), langName(current), new View.OnClickListener() {
            public void onClick(View v) {
                CharSequence[] names = new CharSequence[langs.size()];
                int on = -1;
                for (int i = 0; i < names.length; i++) {
                    names[i] = langName(langs.get(i));
                    if (langs.get(i).equals(current)) on = i;
                }
                new AlertDialog.Builder(act)
                        .setTitle(t("mr_lang_card_title"))
                        .setSingleChoiceItems(names, on, new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.dismiss();
                                String pick = langs.get(which);
                                if (!pick.equals(current)) onPick.onPick(pick);
                            }
                        })
                        .setNegativeButton(t("mr_words_cancel"), null)
                        .show();
            }
        }), wide(0));
    }

    EditText field(String hint, int inputType) {
        EditText e = new EditText(act);
        e.setHint(hint);
        e.setHintTextColor(text2);
        e.setTextColor(text);
        e.setTextSize(16f);
        e.setInputType(inputType);
        e.setPadding(dp(14), dp(12), dp(14), dp(12));
        e.setBackground(round(card, stroke, 16, false));
        return e;
    }

    /** A card-like row for lists: the text on the left (as large as it needs) and a small note on the right. */
    LinearLayout item(String main, String note, View.OnClickListener l) {
        LinearLayout r = row();
        r.setPadding(dp(14), dp(12), dp(14), dp(12));
        r.setBackground(round(card, stroke, 14, false));
        r.setClickable(true);
        r.setOnClickListener(l);
        TextView a = label(main, 16f, text, false);
        r.addView(a, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        if (note != null && note.length() > 0) {
            TextView n = label(note, 13f, text2, false);
            n.setPadding(dp(10), 0, 0, 0);
            r.addView(n, new LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT));
        }
        return r;
    }

    /** The language of a locale ("pt_BR") by name: the string mr_lang_pt_BR if there is one, otherwise the tag. */
    String langName(String locale) {
        String key = "mr_lang_" + locale;
        return act.getResources().getIdentifier(key, "string", act.getPackageName()) != 0 ? t(key) : MrLearned.tag(locale);
    }
}
