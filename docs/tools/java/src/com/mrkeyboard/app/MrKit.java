package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
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
    /** Quiet controls (fields, select, quiet buttons): a step above the card, with a thin line. */
    final int raised;
    /** The very faint tint behind the quiet buttons with a vector (almost see-through). */
    final int faint;
    final int sunken;
    final int line;
    final int hint;

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
        raised = color("mr_ui_raised");
        faint = color("mr_ui_faint");
        sunken = color("mr_ui_sunken");
        line = color("mr_ui_stroke");
        hint = color("mr_ui_text3");
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
        b.setBackground(primary ? round(accent, 0, 12, false) : round(raised, line, 12, false));
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
     * A select pill, like the choices of the Settings: the chosen value and a chevron on the right; {@code title} (small, on top of the
     * value) only if it is not empty. A tap on it is the caller's {@code l} (usually the list of choices).
     */
    LinearLayout select(String title, String value, View.OnClickListener l) {
        LinearLayout c = row();
        c.setPadding(dp(16), dp(13), dp(14), dp(13));
        c.setBackground(round(faint, line, 12, false));
        c.setClickable(true);
        c.setOnClickListener(l);
        LinearLayout words = column();
        boolean titled = title.length() > 0;
        if (titled) words.addView(label(title, 12f, text2, false), wide(0));
        words.addView(label(value, 16f, text, false), wide(titled ? 2 : 0));
        c.addView(words, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        c.addView(iconView("mr_ui_ic_chev_down", 18f));
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
    void languageCard(LinearLayout box, List<String> langs, String current, LangPick onPick) {
        languageCard(box, langs, current, onPick, true);
    }

    /** The same, with {@code titled} false the pill has no small title (the screen already has a heading for it). */
    void languageCard(LinearLayout box, final List<String> langs, final String current, final LangPick onPick, boolean titled) {
        box.removeAllViews();
        box.addView(select(titled ? t("mr_lang_card_title") : "", langName(current), new View.OnClickListener() {
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
        e.setHintTextColor(this.hint);
        e.setTextColor(text);
        e.setTextSize(16f);
        e.setInputType(inputType);
        e.setPadding(dp(14), dp(12), dp(14), dp(12));
        e.setBackground(round(raised, line, 12, false));
        return e;
    }

    /** A vector of the screens (res/drawable/mr_ui_ic_*), square, {@code sizeDp} wide, ready to be a compound drawable. */
    Drawable icon(String name, float sizeDp) {
        Drawable d = act.getResources().getDrawable(act.getResources().getIdentifier(name, "drawable", act.getPackageName()));
        int px = dp(sizeDp);
        d.setBounds(0, 0, px, px);
        return d;
    }

    /** A box of {@code sizeDp} with the vector in it (for a row of a LinearLayout). */
    ImageView iconView(String name, float sizeDp) {
        ImageView v = new ImageView(act);
        v.setImageDrawable(icon(name, sizeDp));
        int px = dp(sizeDp);
        v.setLayoutParams(new LinearLayout.LayoutParams(px, px));
        return v;
    }

    /** The title line with a back arrow before the title; both centred on the same line. */
    LinearLayout backHeader(String title, View.OnClickListener onBack) {
        LinearLayout head = row();
        ImageView back = iconView("mr_ui_ic_back", 40f);
        back.setPadding(dp(9), dp(9), dp(9), dp(9));
        back.setContentDescription(t("mr_back_desc"));
        back.setOnClickListener(onBack);
        head.addView(back);
        TextView ti = label(title, 22f, text, true);
        ti.setPadding(dp(6), 0, 0, 0);
        head.addView(ti, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        return head;
    }

    /** A card of the screens: the content in a column, on the card colour with the strong line. */
    LinearLayout panel() {
        LinearLayout c = column();
        c.setPadding(dp(16), dp(16), dp(16), dp(16));
        c.setBackground(round(card, stroke, 20, false));
        return c;
    }

    /** A vector and a text side by side (the text takes the rest of the width). */
    LinearLayout iconRow(String iconName, float iconDp, String msg, float sp, int colour, boolean bold) {
        LinearLayout r = row();
        r.addView(iconView(iconName, iconDp));
        TextView t = label(msg, sp, colour, bold);
        t.setPadding(dp(10), 0, 0, 0);
        r.addView(t, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        return r;
    }

    /** The note card at the top of a screen: the info mark and the text. */
    LinearLayout infoCard(String msg) {
        LinearLayout c = iconRow("mr_ui_ic_info", 22f, msg, 14f, text2, false);
        c.setPadding(dp(16), dp(16), dp(16), dp(16));
        c.setBackground(round(card, stroke, 20, false));
        return c;
    }

    /** A text field with its counter inside the same rounded box (the field loses its own background). */
    LinearLayout fieldBox(EditText e, TextView counter) {
        LinearLayout box = column();
        box.setBackground(round(raised, line, 12, false));
        e.setBackground(null);
        box.addView(e, wide(0));
        box.addView(counter, wide(0));
        return box;
    }

    /** Like {@link #button}, with a vector before the text; the vector and the text are centred together. */
    TextView iconButton(String s, String iconName, boolean primary, View.OnClickListener l) {
        MrIconButton b = new MrIconButton(act);
        b.setText(s);
        b.setTextColor(primary ? onAccent : text);
        b.setTextSize(primary ? 15f : 14f);
        if (primary) b.setTypeface(null, Typeface.BOLD);
        b.setGravity(Gravity.CENTER);
        b.setPadding(dp(14), dp(13), dp(14), dp(13));
        b.setBackground(primary ? round(accent, 0, 12, false) : round(faint, line, 12, false));
        b.setClickable(true);
        b.setOnClickListener(l);
        b.setIcon(icon(iconName, 16f), dp(8));
        return b;
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

    /**
     * A tab of the word screens: the name on the first line and the count under it, both centred (the strings carry the line break, so
     * each language decides it and every tab has the same two lines). The tab that is on is filled with the accent; the others are a card
     * with a thin line.
     */
    TextView tabChip(String s, boolean on, View.OnClickListener l) {
        TextView c = label(s, 13f, on ? onAccent : text, on);
        c.setGravity(Gravity.CENTER);
        c.setMaxLines(2);
        c.setPadding(dp(6), dp(9), dp(6), dp(9));
        c.setBackground(on ? round(accent, 0, 14, false) : round(card, stroke, 14, false));
        c.setClickable(true);
        c.setOnClickListener(l);
        return c;
    }

    /** The table of the word screens: one card with a thin line around it; its rows are added with {@link #tableRow}. */
    LinearLayout table() {
        LinearLayout t = column();
        t.setBackground(round(card, stroke, 14, false));
        return t;
    }

    /**
     * A row of a table: the word on the left and, when there is a number, a thin vertical line and the number in a fixed column on the
     * right (the number has no background and no round border). The rows are separated by a thin horizontal line, put above every row
     * but the first.
     */
    void tableRow(LinearLayout table, String main, String note, View.OnClickListener l) {
        if (table.getChildCount() > 0) {
            View sep = new View(act);
            sep.setBackgroundColor(line);
            table.addView(sep, lp(ViewGroup.LayoutParams.MATCH_PARENT, hair(), 0));
        }
        LinearLayout r = row();
        r.setClickable(true);
        r.setOnClickListener(l);
        TextView a = label(main, 16f, text, false);
        a.setPadding(dp(14), dp(12), dp(12), dp(12));
        r.addView(a, new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f));
        if (note != null && note.length() > 0) {
            View div = new View(act);
            div.setBackgroundColor(stroke);
            r.addView(div, new LinearLayout.LayoutParams(hair(), ViewGroup.LayoutParams.MATCH_PARENT));
            TextView n = label(note, 15f, accent, false);
            n.setGravity(Gravity.CENTER);
            r.addView(n, new LinearLayout.LayoutParams(dp(56), ViewGroup.LayoutParams.WRAP_CONTENT));
        }
        table.addView(r, wide(0));
    }

    /** A thin line: half a dp, never less than one pixel. */
    private int hair() {
        return Math.max(1, dp(0.5f));
    }

    /** The language of a locale ("pt_BR") by name: the string mr_lang_pt_BR if there is one, otherwise the tag. */
    String langName(String locale) {
        String key = "mr_lang_" + locale;
        return act.getResources().getIdentifier(key, "string", act.getPackageName()) != 0 ? t(key) : MrLearned.tag(locale);
    }
}
