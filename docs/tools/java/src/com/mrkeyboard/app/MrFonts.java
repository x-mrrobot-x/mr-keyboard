package com.mrkeyboard.app;

import android.content.Context;
import android.graphics.drawable.GradientDrawable;
import android.preference.PreferenceManager;
import android.text.InputType;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.text.BreakIterator;
import java.text.Normalizer;
import java.util.Locale;

/**
 * Fonts tool. The fonts are buttons in the toolbar row (in place of the main bar, with the back button). Each button
 * shows the name of its style, written in the style (for example BOLD in bold letters). The keyboard stays on screen
 * under the row: the letters of its keys show the chosen style, and a tapped letter is sent to the app in that style.
 * Only letters are styled; the other keys work as before. An app cannot be given a font by a keyboard, so the styled
 * letters are real characters (Unicode look-alikes), and they are the text the app receives.
 *
 * Choice: 0 = normal (no style), 1..STYLES = style choice - 1. Kept in the default preferences (KEY).
 */
final class MrFonts {
    static final int MODE = 6;
    static final String KEY = "pref_font_style";
    /** Keyboard key code of delete (Keyboard.KEYCODE_DELETE). */
    static final int CODE_DELETE = -5;

    /**
     * Number of styles. The style index is also the place of its button in the row (after the system font), and its name
     * is the string mr_font_style_<index> (in the app language: en, pt-BR and es, as the other texts). The tables
     * below have one entry per style, in this order: weights and slants (0..7: Bold, Italic, Bold italic, Sans, Sans bold,
     * Sans italic, Sans bold italic, Monospace), fancy letters (8..12: Cursive, Bold cursive, Gothic, Bold gothic,
     * Outline), enclosed (13..17: Bubble, Filled bubble, Square, Filled square, Parenthesized), size and width (18..21:
     * Small caps, Superscript, Subscript, Wide) and lines (22..26: Underline, Double underline, Strikethrough, Overline,
     * Slashed).
     */
    static final int STYLES = 27;

    /**
     * Code point of 'A' and of 'a' in each block style (the letters follow in code point order). 0 = not a block.
     * Squared, Negative squared, Negative circled and Parenthesized have one alphabet only: both cases use it.
     */
    static final int[] UP = {
        0x1D400, 0x1D434, 0x1D468, 0x1D5A0, 0x1D5D4, 0x1D608, 0x1D63C, 0x1D670,
        0x1D49C, 0x1D4D0, 0x1D504, 0x1D56C, 0x1D538,
        0x24B6, 0x1F150, 0x1F130, 0x1F170, 0x249C,
        0, 0, 0, 0xFF21,
        0, 0, 0, 0, 0
    };
    static final int[] LOW = {
        0x1D41A, 0x1D44E, 0x1D482, 0x1D5BA, 0x1D5EE, 0x1D622, 0x1D656, 0x1D68A,
        0x1D4B6, 0x1D4EA, 0x1D51E, 0x1D586, 0x1D552,
        0x24D0, 0x1F150, 0x1F130, 0x1F170, 0x249C,
        0, 0, 0, 0xFF41,
        0, 0, 0, 0, 0
    };
    /**
     * Letters that are not in their block (the block has a hole for them), as pairs: letter, code point.
     * Example: in Script the B is U+212C, not U+1D49D.
     */
    static final String[] EXC = {
        "", "h\u210E", "", "", "", "", "", "",
        "B\u212CE\u2130F\u2131H\u210BI\u2110L\u2112M\u2133R\u211Be\u212Fg\u210Ao\u2134", "",
        "C\u212DH\u210CI\u2111R\u211CZ\u2128", "",
        "C\u2102H\u210DN\u2115P\u2119Q\u211AR\u211DZ\u2124",
        "", "", "", "", "",
        "", "", "", "",
        "", "", "", "", ""
    };

    /** Small capitals: 26 upper-case entries (A..Z), then 26 lower-case (a..z). Small caps have no upper/lower difference. */
    static final int[] SMALL_CAPS = {
        0x1D00, 0x299, 0x1D04, 0x1D05,
        0x1D07, 0xA730, 0x262, 0x29C,
        0x26A, 0x1D0A, 0x1D0B, 0x29F,
        0x1D0D, 0x274, 0x1D0F, 0x1D18,
        0x1EB, 0x280, 0xA731, 0x1D1B,
        0x1D1C, 0x1D20, 0x1D21, 0x78,
        0x28F, 0x1D22, 0x1D00, 0x299,
        0x1D04, 0x1D05, 0x1D07, 0xA730,
        0x262, 0x29C, 0x26A, 0x1D0A,
        0x1D0B, 0x29F, 0x1D0D, 0x274,
        0x1D0F, 0x1D18, 0x1EB, 0x280,
        0xA731, 0x1D1B, 0x1D1C, 0x1D20,
        0x1D21, 0x78, 0x28F, 0x1D22,
    };
    /** Superscript: same layout (0 = no superscript letter, the letter stays as it is). */
    static final int[] SUPER = {
        0x1D2C, 0x1D2E, 0x0, 0x1D30,
        0x1D31, 0x0, 0x1D33, 0x1D34,
        0x1D35, 0x1D36, 0x1D37, 0x1D38,
        0x1D39, 0x1D3A, 0x1D3C, 0x1D3E,
        0x0, 0x1D3F, 0x0, 0x1D40,
        0x1D41, 0x2C7D, 0x1D42, 0x0,
        0x0, 0x0, 0x1D43, 0x1D47,
        0x1D9C, 0x1D48, 0x1D49, 0x1DA0,
        0x1D4D, 0x2B0, 0x2071, 0x2B2,
        0x1D4F, 0x2E1, 0x1D50, 0x207F,
        0x1D52, 0x1D56, 0x0, 0x2B3,
        0x2E2, 0x1D57, 0x1D58, 0x1D5B,
        0x2B7, 0x2E3, 0x2B8, 0x1DBB,
    };
    /** Subscript: same layout (0 = no subscript letter, the letter stays as it is). Unicode has them for
     *  a e h i j k l m n o p r s t u v x only (U+2090..U+209C, U+1D62..U+1D65, U+2C7C, U+2093). */
    static final int[] SUB = {
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x0, 0x0,
        0x0, 0x0, 0x2090, 0x0,
        0x0, 0x0, 0x2091, 0x0,
        0x0, 0x2095, 0x1D62, 0x2C7C,
        0x2096, 0x2097, 0x2098, 0x2099,
        0x2092, 0x209A, 0x0, 0x1D63,
        0x209B, 0x209C, 0x1D64, 0x1D65,
        0x0, 0x2093, 0x0, 0x0,
    };
    /** Table styles: null when the style is a block (UP/LOW) or a combining style. */
    static final int[][] TAB = {
        null, null, null, null, null, null, null, null,
        null, null, null, null, null,
        null, null, null, null, null,
        SMALL_CAPS, SUPER, SUB, null,
        null, null, null, null, null
    };
    /**
     * Combining styles: the letter followed by this mark (0 = none). Strikethrough = U+0336, Underline = U+0332,
     * Overline = U+0305, Double underline = U+0333, Slashed = U+0338.
     */
    static final int[] COMB = {
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0, 0,
        0, 0, 0, 0,
        0x0332, 0x0333, 0x0336, 0x0305, 0x0338
    };

    private static View sBar;              // bar_fonts: the row with the back button and the font buttons
    private static View sMainBar;          // bar_main: hidden while the tool is open
    private static LinearLayout sRow;      // f_row: the font buttons, inside the scrolling part of the bar
    private static TextView[] sButtons;    // one button per row of the list: 0 = normal, i = style i - 1
    private static Context sCtx;
    private static int sChoice;            // 0 = normal
    private static int sTextOff;           // text color of the buttons not in use (set by MrTools.btn)

    private MrFonts() { }

    /** Called by MrTools.wrap with the root of the toolbar, each time a keyboard view is made. */
    static void setup(View root) {
        sBar = null;
        sMainBar = null;
        sRow = null;
        sButtons = null;
        sCtx = null;
        if (root == null) return;
        Context c = root.getContext();
        sCtx = c;
        sChoice = PreferenceManager.getDefaultSharedPreferences(c).getInt(KEY, 0);
        View bar = root.findViewWithTag("bar_fonts");
        View row = root.findViewWithTag("f_row");
        View back = root.findViewWithTag("f_back");
        View main = root.findViewWithTag("bar_main");
        if (bar == null || !(row instanceof LinearLayout)) return;
        sBar = bar;
        sRow = (LinearLayout) row;
        sMainBar = main;
        if (back != null) {
            MrTools.btn(root, "f_back", -1); // painted like the back button of the other tool bars (tune_back)
            back.setOnClickListener(new Back());
        }
        sBar.setVisibility(View.GONE);
    }

    /** Called by MrTools.showPanel before the panels change: shows the tool for MODE, hides it for the others. */
    static void onPanel(int mode) {
        boolean on = mode == MODE;
        if (sBar != null) sBar.setVisibility(on ? View.VISIBLE : View.GONE);
        if (on) build();
    }

    /**
     * Called by MrTools.showPanel at the end: the main bar stays hidden while the tool is open, and the keyboard is
     * shown under the font row (showPanel hides it for every mode but 0).
     */
    static void afterPanel(int mode) {
        if (mode != MODE) return;
        if (sMainBar != null) sMainBar.setVisibility(View.GONE);
        View kbd = MrTools.sKbd;
        if (kbd != null) kbd.setVisibility(View.VISIBLE);
    }

    /**
     * True when the field takes styled letters: plain text fields. Not the number, phone and date fields (a digit or a
     * letter in a style would be refused or would break the value), passwords, e-mail addresses and web addresses (the
     * text must be exactly what was typed), nor a field without a type (terminals, games: the keys are key events).
     */
    static boolean fieldTakesStyle(EditorInfo ei) {
        if (ei == null) return true;
        int type = ei.inputType;
        if ((type & InputType.TYPE_MASK_CLASS) != InputType.TYPE_CLASS_TEXT) return false;
        int v = type & InputType.TYPE_MASK_VARIATION;
        return v != InputType.TYPE_TEXT_VARIATION_URI
            && v != InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS
            && v != InputType.TYPE_TEXT_VARIATION_PASSWORD
            && v != InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD
            && v != InputType.TYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS
            && v != InputType.TYPE_TEXT_VARIATION_WEB_PASSWORD;
    }

    /**
     * Used by Keyboard.Key.getCaseLabel: the label of a letter key in the chosen style (the plain letter in a field
     * that does not take styles, see fieldTakesStyle).
     */
    static String styleLabel(String s) {
        if (sChoice <= 0 || s == null || s.length() != 1) return s;
        LatinIME ime = MrTools.sIme;
        if (ime != null && !fieldTakesStyle(ime.getCurrentInputEditorInfo())) return s;
        String r = styled(sChoice - 1, s.charAt(0));
        return r == null ? s : r;
    }

    /**
     * Used by LatinIME.onKey before the normal key handling. Sends a letter in the chosen style. Delete removes a
     * styled letter as a whole (a letter outside the BMP has two chars, a letter with a mark has two or more).
     * Returns false when the key is not handled here, so the normal handling runs: no style chosen, a field that does
     * not take styles (fieldTakesStyle) or a key that is not a letter.
     */
    static boolean typeStyled(LatinIME ime, int code) {
        if (ime == null || sChoice <= 0) return false;
        if (!fieldTakesStyle(ime.getCurrentInputEditorInfo())) return false;
        InputConnection ic = ime.getCurrentInputConnection();
        if (ic == null) return false;
        if (code == CODE_DELETE) return deleteCluster(ic);
        if (code < 0 || code > 0xFFFF) return false;
        String s = styled(sChoice - 1, (char) code);
        if (s == null) return false;
        // commitText replaces the text that is marked as composing: a word the keyboard still holds (the one being typed, or
        // one reopened by the re-correction) must be let go first, or the styled letter would erase it.
        ime.mrEndWord();
        ic.commitText(s, 1);
        return true;
    }

    /**
     * True when what is typed comes out in a style: a style is chosen (even with the tool closed) and the field takes it.
     * The dictionary has nothing for such text, so LatinIME stops the suggestions (search, next word, re-correction) while it
     * is true: they would only cost work and give nothing.
     */
    static boolean styleOn(EditorInfo ei) {
        return sChoice > 0 && fieldTakesStyle(ei);
    }

    /**
     * Deletes the last character as a whole: the base letter together with its marks or its low surrogate. With a
     * selection it does nothing (false): the normal delete removes the selected text.
     */
    private static boolean deleteCluster(InputConnection ic) {
        CharSequence selected = ic.getSelectedText(0);
        if (selected != null && selected.length() > 0) return false;
        CharSequence before = ic.getTextBeforeCursor(16, 0);
        if (before == null || before.length() == 0) return false;
        String t = before.toString();
        BreakIterator bi = BreakIterator.getCharacterInstance();
        bi.setText(t);
        int start = bi.preceding(t.length());
        if (start == BreakIterator.DONE) return false;
        int len = t.length() - start;
        if (len < 2 || "\r\n".equals(t.substring(start))) return false;
        ic.deleteSurroundingText(len, 0);
        return true;
    }

    /** The letter c in the style (or null when it is not a letter of the alphabet). Accents are kept after the letter. */
    static String styled(int style, char c) {
        if (style < 0 || style >= STYLES) return null;
        if (c < 128) return letter(style, c);
        // An accented letter (\u00e7, \u00e3...): style the base letter, keep the accent marks after it
        String d = Normalizer.normalize(String.valueOf(c), Normalizer.Form.NFD);
        String b = letter(style, d.charAt(0));
        if (b == null) return null;
        return b + d.substring(1);
    }

    /** The ASCII letter c in the style, or null. */
    private static String letter(int style, char c) {
        String ex = EXC[style];
        for (int i = 0; i + 1 < ex.length(); i += 2) {
            if (ex.charAt(i) == c) return new String(Character.toChars(ex.charAt(i + 1)));
        }
        boolean up = c >= 'A' && c <= 'Z';
        boolean low = c >= 'a' && c <= 'z';
        if (!up && !low) return null;
        if (COMB[style] != 0) {
            return String.valueOf(c) + new String(Character.toChars(COMB[style]));
        }
        if (TAB[style] != null) {
            int cp = TAB[style][up ? c - 'A' : 26 + (c - 'a')];
            return new String(Character.toChars(cp == 0 ? c : cp));
        }
        int base = up ? UP[style] + (c - 'A') : LOW[style] + (c - 'a');
        return new String(Character.toChars(base));
    }

    /** The whole text in the style: letters change, the rest stays. */
    static String styledText(int style, String text) {
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            String r = styled(style, text.charAt(i));
            b.append(r == null ? String.valueOf(text.charAt(i)) : r);
        }
        return b.toString();
    }

    /** The name of style i (0-based) in the app's language, from the string mr_font_style_i. */
    static String styleName(int i) {
        int id = sCtx.getResources().getIdentifier("mr_font_style_" + i, "string", sCtx.getPackageName());
        return id == 0 ? "" : sCtx.getString(id);
    }

    /** Builds the row: the system font first, then one button per style, in order. Built when the tool opens. */
    private static void build() {
        if (sRow == null || sCtx == null) return;
        sRow.removeAllViews();
        sButtons = new TextView[STYLES + 1];
        for (int i = 0; i <= STYLES; i++) sButtons[i] = button(i);
    }

    /**
     * Button i: 0 = normal, i > 0 = style i - 1. The text is the name in capitals, written in its own style, so the
     * button shows the font itself. The style in use is the selected one (see select).
     */
    private static TextView button(int i) {
        TextView t;
        int layout = sCtx.getResources().getIdentifier("mr_font_btn", "layout", sCtx.getPackageName());
        if (layout != 0) {
            t = (TextView) LayoutInflater.from(sCtx).inflate(layout, sRow, false);
        } else {
            t = new TextView(sCtx);
            t.setTextSize(12);
            t.setGravity(Gravity.CENTER);
            t.setPadding(dp(10), 0, dp(10), 0);
        }
        String plain = i == 0 ? normalName() : styleName(i - 1);
        String tag = "f_btn_" + i;
        t.setTag(tag);
        t.setContentDescription(plain);
        sRow.addView(t);
        // the theme of the other tool buttons: text colour, background, padding (MrTools.btn)
        MrTools.btn(sRow, tag, -1);
        sTextOff = t.getCurrentTextColor();
        t.setOnClickListener(new Pick(i));
        select(t, i, i == sChoice);
        return t;
    }

    /** The name of button i in capitals, written in its own style (Normal is plain). */
    private static String label(int i) {
        if (i == 0) return normalName().toUpperCase(Locale.ROOT);
        return styledText(i - 1, styleName(i - 1).toUpperCase(Locale.ROOT));
    }

    /** The name of Normal (no style) in the app's language. */
    private static String normalName() {
        int id = sCtx.getResources().getIdentifier("mr_font_default", "string", sCtx.getPackageName());
        return id == 0 ? "Normal" : sCtx.getString(id);
    }

    /**
     * The buttons that are not in use have the look of the other buttons of the tools (MrTools.flatBg, MrTools.btn).
     * The style in use takes the face color of the highlight (Ctrl) key of the theme, with the text of that key.
     */
    private static void select(TextView t, int i, boolean on) {
        t.setText(label(i));
        if (on) {
            t.setBackground(activeBg());
            t.setTextColor(MrTheme.color("accent_text"));
        } else {
            t.setBackground(MrTools.flatBg());
            t.setTextColor(sTextOff);
        }
    }

    /** The face of the highlight key (ctrl_bg), at full opacity, with the corners (10 dp) of the other tool buttons. */
    private static GradientDrawable activeBg() {
        GradientDrawable g = new GradientDrawable();
        g.setColor(MrTheme.color("ctrl_bg"));
        g.setCornerRadius(MrTools.radius(2.0f));
        return g;
    }

    private static int dp(int v) {
        float d = sCtx.getResources().getDisplayMetrics().density;
        return (int) (v * d + 0.5f);
    }

    /** Picks a style: the row keeps its place (no rebuild), the keys are redrawn in the new style. */
    private static void choose(int i) {
        sChoice = i;
        if (sCtx != null) {
            PreferenceManager.getDefaultSharedPreferences(sCtx).edit().putInt(KEY, i).apply();
        }
        if (sButtons != null) {
            for (int k = 0; k < sButtons.length; k++) {
                if (sButtons[k] != null) select(sButtons[k], k, k == i);
            }
        }
        refreshKeys();
    }

    /** The keyboard keeps a picture of its keys: redraw them, so the letters show the new style. */
    private static void refreshKeys() {
        View kbd = MrTools.sKbd;
        if (kbd instanceof LatinKeyboardBaseView) {
            ((LatinKeyboardBaseView) kbd).invalidateAllKeys();
        }
    }

    private static final class Pick implements View.OnClickListener {
        private final int index;

        Pick(int index) {
            this.index = index;
        }

        @Override
        public void onClick(View v) {
            choose(index);
        }
    }

    private static final class Back implements View.OnClickListener {
        @Override
        public void onClick(View v) {
            MrTools.showPanel(0);
        }
    }
}
