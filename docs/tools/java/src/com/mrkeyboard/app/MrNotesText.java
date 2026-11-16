package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.style.ForegroundColorSpan;
import android.text.style.StyleSpan;
import android.util.DisplayMetrics;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * The notes of a version as the update dialog and the "Version" dialog show them (v1.98.0; cards since v2.0.0). The
 * notes are simple Markdown ("- " items, **bold**, `code`); MrUpdate.plain turns them into plain text, this class
 * into cards:
 *   - each item is a card: a TextView with a very faint background and rounded corners (drawable mr_ui_note_card),
 *     with a gap between the cards; the items have no bullet and no color by kind, the card is the separation;
 *   - the label of the item ("Novo:", "Fixed:") is bold and white, the rest of the text has the softer text color;
 *   - **bold** in the text stays bold; `code` marks are dropped;
 *   - a line that is not an item (plain text) is a card too, so nothing in the notes is lost.
 * A label is what comes before the first ": " when it is short (32 characters), so a long sentence with a colon in
 * the middle is not taken for one.
 */
final class MrNotesText {
    private static final int LABEL_MAX = 32;
    /** Space between two cards, and the padding inside a card, in dp. */
    private static final int GAP_DP = 8;
    private static final int PAD_H_DP = 12;
    private static final int PAD_V_DP = 10;
    private static final int TEXT_SP = 14;

    private MrNotesText() { }

    /** Where the label of an item ends (just after its colon), or 0 when the item has none. */
    static int labelEnd(String text) {
        int i = text.indexOf(": ");
        return i > 0 && i <= LABEL_MAX ? i + 1 : 0;
    }

    /**
     * The items of the notes, one for each non-empty line, as written (** marks stay): the "- " or "* " of a list item
     * and the ` marks are taken out and the line is trimmed. Null and blank notes give no item, nor does a line that is
     * only a dash or an asterisk.
     */
    static List<String> items(String md) {
        List<String> out = new ArrayList<String>();
        if (md == null) return out;
        String[] lines = md.replace("\r\n", "\n").split("\n", -1);
        for (String line : lines) {
            String t = line.replace("`", "").trim();
            if (t.startsWith("- ") || t.startsWith("* ")) t = t.substring(2).trim();
            if (t.length() > 0 && !t.equals("-") && !t.equals("*")) out.add(t);
        }
        return out;
    }

    /** One item as a styled text: the label bold and in labelColor, the **bold** parts bold, the marks dropped. */
    static CharSequence format(String item, int labelColor) {
        SpannableStringBuilder out = new SpannableStringBuilder("");
        if (item == null) return out;
        appendBold(out, item);
        int lab = labelEnd(item.replace("**", ""));
        if (lab > 0) {
            out.setSpan(new ForegroundColorSpan(labelColor), 0, lab, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            out.setSpan(new StyleSpan(Typeface.BOLD), 0, lab, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        }
        return out;
    }

    /** Adds the text without its ** marks, the part between two marks in bold (an odd mark makes the rest bold). */
    private static void appendBold(SpannableStringBuilder out, String t) {
        boolean bold = false;
        int pos = 0;
        while (true) {
            int k = t.indexOf("**", pos);
            int stop = k < 0 ? t.length() : k;
            int from = out.length();
            out.append(t.substring(pos, stop));
            if (bold && out.length() > from) {
                out.setSpan(new StyleSpan(Typeface.BOLD), from, out.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            }
            if (k < 0) return;
            bold = !bold;
            pos = k + 2;
        }
    }

    /**
     * Puts the notes in the box as cards, replacing what it had, and says how many cards there are. With no item at all
     * and a none text, that text is the only card (so the dialog is never empty); with none, the box stays empty.
     */
    static int fill(LinearLayout box, String md, String none) {
        box.removeAllViews();
        List<String> items = items(md);
        if (items.isEmpty() && none != null && none.length() > 0) items.add(none);
        Context c = box.getContext();
        Resources r = c.getResources();
        String pkg = c.getPackageName();
        int text = color(r, pkg, "mr_ui_text2");
        int label = color(r, pkg, "mr_ui_text");
        int card = r.getIdentifier("mr_ui_note_card", "drawable", pkg);
        DisplayMetrics dm = r.getDisplayMetrics();
        float density = dm != null && dm.density > 0 ? dm.density : 1f;
        for (int i = 0; i < items.size(); i++) {
            TextView tv = new TextView(c);
            tv.setTextSize(TEXT_SP);
            tv.setTextColor(text);
            tv.setLineSpacing(Math.round(3 * density), 1f);
            tv.setPadding(dp(PAD_H_DP, density), dp(PAD_V_DP, density), dp(PAD_H_DP, density), dp(PAD_V_DP, density));
            if (card != 0) tv.setBackgroundResource(card);
            tv.setText(format(items.get(i), label));
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            if (i > 0) lp.setMargins(0, dp(GAP_DP, density), 0, 0);
            box.addView(tv, lp);
        }
        return items.size();
    }

    private static int dp(int v, float density) {
        return Math.round(v * density);
    }

    /** A palette color by name (mr_colors.xml); white if the name is missing. */
    private static int color(Resources r, String pkg, String name) {
        int id = r.getIdentifier(name, "color", pkg);
        return id != 0 ? r.getColor(id) : 0xffffffff;
    }
}
