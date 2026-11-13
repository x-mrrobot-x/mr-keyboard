package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.style.ForegroundColorSpan;
import android.text.style.LeadingMarginSpan;
import android.text.style.RelativeSizeSpan;
import android.text.style.StyleSpan;
import android.widget.TextView;

import java.util.Locale;

/**
 * The notes of a new version as the update dialog shows them (v1.98.0). The notes are simple Markdown ("- " items,
 * **bold**, `code`); MrUpdate.plain turns them into plain text, this class into a styled one:
 *   - each item is a paragraph that starts with a bullet, with a hanging indent (the lines after the first one line up
 *     with the text, not with the bullet);
 *   - the label of the item ("Novo:", "Fixed:") is bold and the bullet and the label take the color of its kind: new
 *     green, improved blue, fixed amber, how to get it violet, any other label gray;
 *   - **bold** in the text stays bold; `code` marks are dropped;
 *   - a thin empty line separates the paragraphs.
 * The kind comes from the first word of the label, in Portuguese and English (the notes come in both); a label that is
 * not one of them, or an item with no label, is gray. A label is what comes before the first ": " when it is short
 * (32 characters), so a long sentence with a colon in the middle is not taken for one.
 */
final class MrNotesText {
    static final int NEW = 0;
    static final int IMPROVED = 1;
    static final int FIXED = 2;
    static final int HOW = 3;
    static final int OTHER = 4;
    /** How many kinds there are: the size of the color table that format() takes. */
    static final int KINDS = 5;

    private static final int LABEL_MAX = 32;
    /** Height of the empty line between two paragraphs, in relation to a text line. */
    private static final float GAP = 0.5f;
    private static final String BULLET = "• ";

    private MrNotesText() { }

    /** The kind of a label: NEW, IMPROVED, FIXED, HOW, or OTHER (any other text). */
    static int kindOf(String label) {
        String s = label.toLowerCase(Locale.ROOT);
        if (s.startsWith("novo") || s.startsWith("new")) return NEW;
        if (s.startsWith("melhor") || s.startsWith("improv")) return IMPROVED;
        if (s.startsWith("corrig") || s.startsWith("corre") || s.startsWith("fix")) return FIXED;
        if (s.startsWith("como receber") || s.startsWith("how to get")) return HOW;
        return OTHER;
    }

    /** Where the label of an item ends (just after its colon), or 0 when the item has none. */
    static int labelEnd(String text) {
        int i = text.indexOf(": ");
        return i > 0 && i <= LABEL_MAX ? i + 1 : 0;
    }

    /**
     * The notes as a styled text. colors: one for each kind (KINDS of them); indent: the width in pixels of the hanging
     * indent, which is the width of the bullet and the space after it.
     */
    static CharSequence format(String md, int[] colors, int indent) {
        SpannableStringBuilder out = new SpannableStringBuilder("");
        if (md == null) return out;
        String[] lines = md.replace("\r\n", "\n").split("\n", -1);
        for (String line : lines) {
            String t = line.replace("`", "").trim();
            if (t.length() == 0) continue;
            boolean item = t.startsWith("- ") || t.startsWith("* ");
            if (item) t = t.substring(2);
            if (out.length() > 0) {
                out.append("\n\n");
                out.setSpan(new RelativeSizeSpan(GAP), out.length() - 1, out.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            }
            int start = out.length();
            if (item) out.append(BULLET);
            int body = out.length();
            appendBold(out, t);
            if (item) {
                out.setSpan(new LeadingMarginSpan.Standard(0, indent), start, out.length(), Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
                styleHead(out, start, body, t.replace("**", ""), colors);
            }
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
     * Gives the bullet and the label of the item that starts at start the color of its kind, and the label bold. body is
     * where the text of the item begins (after the bullet) and clean is that text without marks.
     */
    private static void styleHead(SpannableStringBuilder out, int start, int body, String clean, int[] colors) {
        int lab = labelEnd(clean);
        int color = colors[lab > 0 ? kindOf(clean.substring(0, lab - 1)) : OTHER];
        out.setSpan(new ForegroundColorSpan(color), start, body + lab, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        if (lab > 0) out.setSpan(new StyleSpan(Typeface.BOLD), body, body + lab, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
    }

    /** The name of the palette color (mr_colors.xml) of a kind. */
    static String colorName(int kind) {
        if (kind == NEW) return "mr_ui_mint";
        if (kind == IMPROVED) return "mr_ui_blue";
        if (kind == FIXED) return "mr_ui_amber";
        if (kind == HOW) return "mr_ui_violet";
        return "mr_ui_slate";
    }

    /**
     * The notes ready for this text view: the colors from the resources (white if one is missing) and the hanging
     * indent as wide as the bullet in the font and size of the view.
     */
    static CharSequence forView(TextView view, String md) {
        Context c = view.getContext();
        Resources r = c.getResources();
        String pkg = c.getPackageName();
        int[] colors = new int[KINDS];
        for (int i = 0; i < KINDS; i++) {
            int id = r.getIdentifier(colorName(i), "color", pkg);
            colors[i] = id != 0 ? r.getColor(id) : 0xffffffff;
        }
        return format(md, colors, Math.round(view.getPaint().measureText(BULLET)));
    }
}
