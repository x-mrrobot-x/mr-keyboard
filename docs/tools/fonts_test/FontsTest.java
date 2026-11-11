package com.mrkeyboard.app;

/**
 * MrFonts (fonts tool): the Unicode styles. Checks that the 27 styles have a table of the right size, the code points of
 * the block styles (with the letters that live outside their block), small caps, superscript, subscript, the combining
 * marks (strikethrough, underline, overline, double underline, slashed) and Parenthesized, the letters that a style leaves
 * as they are (digits, letters without a form, symbols), the accented letters, which keep their accent after the styled
 * base letter, that no two styles give the same letter, the fields that do not take a style (passwords, e-mail, web
 * addresses, numbers) and the delete of a styled letter (a whole letter; with a selection the normal delete runs).
 */
public class FontsTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) fails++;
        System.out.println((ok ? "OK    " : "FAIL  ") + what);
    }

    static String cp(int code) {
        return new String(Character.toChars(code));
    }

    /** The code points of a text, for the messages ("U+1D41A U+0301"): the letters themselves do not show on every console. */
    static String hex(String s) {
        if (s == null) return "null";
        StringBuilder b = new StringBuilder();
        for (int i = 0; i < s.length(); i += Character.charCount(s.codePointAt(i))) b.append(i == 0 ? "" : " ").append(String.format("U+%04X", s.codePointAt(i)));
        return b.toString();
    }

    static void checkEquals(String got, String want, String what) {
        check(want.equals(got), what + (want.equals(got) ? "" : " (got " + hex(got) + ", want " + hex(want) + ")"));
    }

    static android.view.inputmethod.EditorInfo info(int type) {
        android.view.inputmethod.EditorInfo e = new android.view.inputmethod.EditorInfo();
        e.inputType = type;
        return e;
    }

    /** The saved choice of the tool (private): 0 = system font, 1 = style 0. */
    static void setChoice(int c) {
        try {
            java.lang.reflect.Field f = MrFonts.class.getDeclaredField("sChoice");
            f.setAccessible(true);
            f.setInt(null, c);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** The keyboard service of the test: the editor info and the connection are set by the test. */
    static class FakeIme extends LatinIME {
        android.view.inputmethod.EditorInfo info;
        android.view.inputmethod.InputConnection ic;

        @Override public android.view.inputmethod.InputConnection getCurrentInputConnection() { return ic; }

        @Override public android.view.inputmethod.EditorInfo getCurrentInputEditorInfo() { return info; }
    }

    /** The text field of the test: the text before the cursor, a selection, and what was committed or deleted. */
    static class FakeConn implements android.view.inputmethod.InputConnection {
        final String before, selected;
        String committed = "";
        int deleted = 0;

        FakeConn(String before, String selected) {
            this.before = before;
            this.selected = selected;
        }

        @Override public CharSequence getTextBeforeCursor(int n, int flags) { return before; }
        @Override public CharSequence getSelectedText(int flags) { return selected.isEmpty() ? null : selected; }
        @Override public boolean commitText(CharSequence text, int pos) { committed += text; return true; }
        @Override public boolean deleteSurroundingText(int b, int a) { deleted += b; return true; }
        @Override public boolean finishComposingText() { return true; }
        @Override public boolean beginBatchEdit() { return true; }
        @Override public boolean endBatchEdit() { return true; }
    }

    public static void main(String[] args) {
        // ---- sizes: every table has one entry per style (the letters: 26 upper + 26 lower)
        check(MrFonts.STYLES == 27, "27 styles");
        check(MrFonts.UP.length == 27 && MrFonts.LOW.length == 27, "block tables have 27 entries");
        check(MrFonts.EXC.length == 27, "exceptions have 27 entries");
        check(MrFonts.TAB.length == 27 && MrFonts.COMB.length == 27, "table and mark tables have 27 entries");
        check(MrFonts.SMALL_CAPS.length == 52 && MrFonts.SUPER.length == 52 && MrFonts.SUB.length == 52,
              "letter tables have 52 entries (26 upper, 26 lower)");

        // ---- known code points of each family of styles (the style index is the place of its button in the row)
        checkEquals(MrFonts.styled(0, 'a'), cp(0x1D41A), "Bold: a is U+1D41A");
        checkEquals(MrFonts.styled(0, 'A'), cp(0x1D400), "Bold: A is U+1D400");
        checkEquals(MrFonts.styled(8, 'B'), cp(0x212C), "Script: B is the letter-like U+212C");
        checkEquals(MrFonts.styled(12, 'C'), cp(0x2102), "Double-struck: C is the letter-like U+2102");
        checkEquals(MrFonts.styled(1, 'h'), cp(0x210E), "Italic: h is U+210E");
        checkEquals(MrFonts.styled(13, 'a'), cp(0x24D0), "Circled: a is U+24D0");
        checkEquals(MrFonts.styled(21, 'a'), cp(0xFF41), "Fullwidth: a is U+FF41");
        checkEquals(MrFonts.styled(18, 'a'), cp(0x1D00), "Small caps: a is U+1D00");
        checkEquals(MrFonts.styled(19, 'b'), cp(0x1D47), "Superscript: b is U+1D47");
        checkEquals(MrFonts.styled(24, 'a'), "a\u0336", "Strikethrough: a with U+0336");
        checkEquals(MrFonts.styled(22, 'a'), "a\u0332", "Underline: a with U+0332");

        // ---- Subscript (20): only the letters that Unicode has a subscript for; the others stay
        checkEquals(MrFonts.styled(20, 'a'), cp(0x2090), "Subscript: a is U+2090");
        checkEquals(MrFonts.styled(20, 'e'), cp(0x2091), "Subscript: e is U+2091");
        checkEquals(MrFonts.styled(20, 'i'), cp(0x1D62), "Subscript: i is U+1D62");
        checkEquals(MrFonts.styled(20, 'j'), cp(0x2C7C), "Subscript: j is U+2C7C");
        checkEquals(MrFonts.styled(20, 'x'), cp(0x2093), "Subscript: x is U+2093");
        checkEquals(MrFonts.styled(20, 'b'), "b", "Subscript: b has no subscript, stays b");
        checkEquals(MrFonts.styled(20, 'A'), "A", "Subscript: capitals have none, stay A");
        int subLetters = 0;
        for (char c = 'a'; c <= 'z'; c++) {
            String r = MrFonts.styled(20, c);
            if (r != null && r.length() > 0 && r.charAt(0) != c) subLetters++;
        }
        check(subLetters == 17, "Subscript: 17 lower-case letters have a form (got " + subLetters + ")");

        // ---- Overline (25): the letter followed by U+0305, for every letter; not for other characters
        checkEquals(MrFonts.styled(25, 'a'), "a\u0305", "Overline: a with U+0305");
        checkEquals(MrFonts.styled(25, 'Z'), "Z\u0305", "Overline: Z with U+0305");
        check(MrFonts.styled(25, '1') == null, "Overline: a digit is not styled (null, the key types as usual)");
        check(MrFonts.styled(25, ' ') == null, "Overline: a space is not styled");

        // ---- Parenthesized (17): one alphabet, both cases give the parenthesized small letter
        checkEquals(MrFonts.styled(17, 'a'), cp(0x249C), "Parenthesized: a is U+249C");
        checkEquals(MrFonts.styled(17, 'A'), cp(0x249C), "Parenthesized: A gives the same letter as a");
        checkEquals(MrFonts.styled(17, 'z'), cp(0x24B5), "Parenthesized: z is U+24B5");
        // ---- Double underline (23) and Slashed (26): the letter followed by a mark
        checkEquals(MrFonts.styled(23, 'a'), "a\u0333", "Double underline: a with U+0333");
        checkEquals(MrFonts.styled(26, 'Q'), "Q\u0338", "Slashed: Q with U+0338");
        check(MrFonts.styled(23, '7') == null && MrFonts.styled(26, ' ') == null, "the marks are for letters only");

        // ---- the names in res/values/mr_strings.xml match the styles: the style N is the one named mr_font_style_N. The expected 'a' and 'Z'
        // come from Unicode (block starts and the letter-like holes), not from the tables, so a wrong table order is caught here.
        java.util.HashMap<String, String[]> gold = new java.util.HashMap<String, String[]>();
        gold.put("Bold", new String[] {cp(0x1D41A), cp(0x1D419)});
        gold.put("Italic", new String[] {cp(0x1D44E), cp(0x1D44D)});
        gold.put("Bold italic", new String[] {cp(0x1D482), cp(0x1D481)});
        gold.put("Sans", new String[] {cp(0x1D5BA), cp(0x1D5B9)});
        gold.put("Sans bold", new String[] {cp(0x1D5EE), cp(0x1D5ED)});
        gold.put("Sans italic", new String[] {cp(0x1D622), cp(0x1D621)});
        gold.put("Sans bold italic", new String[] {cp(0x1D656), cp(0x1D655)});
        gold.put("Monospace", new String[] {cp(0x1D68A), cp(0x1D689)});
        gold.put("Cursive", new String[] {cp(0x1D4B6), cp(0x1D4B5)});
        gold.put("Bold cursive", new String[] {cp(0x1D4EA), cp(0x1D4E9)});
        gold.put("Gothic", new String[] {cp(0x1D51E), cp(0x2128)});
        gold.put("Bold gothic", new String[] {cp(0x1D586), cp(0x1D585)});
        gold.put("Outline", new String[] {cp(0x1D552), cp(0x2124)});
        gold.put("Bubble", new String[] {cp(0x24D0), cp(0x24CF)});
        gold.put("Filled bubble", new String[] {cp(0x1F150), cp(0x1F169)});
        gold.put("Square", new String[] {cp(0x1F130), cp(0x1F149)});
        gold.put("Filled square", new String[] {cp(0x1F170), cp(0x1F189)});
        gold.put("Parenthesized", new String[] {cp(0x249C), cp(0x24B5)});
        gold.put("Small caps", new String[] {cp(0x1D00), cp(0x1D22)});
        gold.put("Superscript", new String[] {cp(0x1D43), "Z"});
        gold.put("Subscript", new String[] {cp(0x2090), "Z"});
        gold.put("Wide", new String[] {cp(0xFF41), cp(0xFF3A)});
        gold.put("Underline", new String[] {"a\u0332", "Z\u0332"});
        gold.put("Double underline", new String[] {"a\u0333", "Z\u0333"});
        gold.put("Strikethrough", new String[] {"a\u0336", "Z\u0336"});
        gold.put("Overline", new String[] {"a\u0305", "Z\u0305"});
        gold.put("Slashed", new String[] {"a\u0338", "Z\u0338"});
        check(gold.size() == MrFonts.STYLES, "the golden table has one entry per style");
        try {
            String xml = new String(java.nio.file.Files.readAllBytes(java.nio.file.Paths.get("res/values/mr_strings.xml")), "UTF-8");
            java.util.regex.Matcher m = java.util.regex.Pattern.compile("<string name=\"mr_font_style_(\\d+)\"[^>]*>([^<]*)</string>").matcher(xml);
            String[] names = new String[MrFonts.STYLES];
            int found = 0;
            boolean inRange = true, dup = false;
            while (m.find()) {
                int n = Integer.parseInt(m.group(1));
                found++;
                if (n < 0 || n >= MrFonts.STYLES) { inRange = false; continue; }
                if (names[n] != null) dup = true;
                names[n] = m.group(2);
            }
            check(found == MrFonts.STYLES && inRange && !dup, "values/mr_strings.xml has mr_font_style_0..26, each once (found " + found + ")");
            java.util.HashSet<String> uniq = new java.util.HashSet<String>();
            boolean allMatch = true;
            for (int n = 0; n < MrFonts.STYLES; n++) {
                String[] g = names[n] == null ? null : gold.get(names[n]);
                if (g == null) { allMatch = false; System.out.println("      style " + n + ": no golden entry for the name " + names[n]); continue; }
                uniq.add(names[n]);
                String a = MrFonts.styled(n, 'a'), z = MrFonts.styled(n, 'Z');
                if (!g[0].equals(a) || !g[1].equals(z)) {
                    allMatch = false;
                    System.out.println("      style " + n + " (" + names[n] + "): a = " + hex(a) + ", Z = " + hex(z) + ", expected " + hex(g[0]) + " and " + hex(g[1]));
                }
            }
            check(allMatch, "each style gives the letters its name promises (a and Z)");
            check(uniq.size() == MrFonts.STYLES, "the 27 style names are different from each other");
        } catch (java.io.IOException e) {
            check(false, "reads res/values/mr_strings.xml (run the tests from the project root): " + e);
        }

        // ---- upper and lower case: every style tells them apart, except the ones with one alphabet only
        java.util.HashSet<Integer> oneCase = new java.util.HashSet<Integer>(java.util.Arrays.asList(14, 15, 16, 17, 18));
        boolean caseOk = true;
        for (int style = 0; style < MrFonts.STYLES; style++) {
            boolean same = MrFonts.styled(style, 'A').equals(MrFonts.styled(style, 'a'));
            if (same != oneCase.contains(style)) { caseOk = false; System.out.println("      style " + style + ": A and a " + (same ? "are" : "are not") + " the same"); }
        }
        check(caseOk, "A and a differ in every style but Filled bubble, Square, Filled square, Parenthesized and Small caps");

        // ---- no two styles give the same 'a' (a repeated style would be a button that does nothing new)
        boolean distinct = true;
        for (int x = 0; x < MrFonts.STYLES; x++) {
            for (int y = x + 1; y < MrFonts.STYLES; y++) {
                if (MrFonts.styled(x, 'a').equals(MrFonts.styled(y, 'a'))) distinct = false;
            }
        }
        check(distinct, "every style gives a different letter");

        // ---- every letter of every style has a value (no null for a letter)
        boolean allLetters = true;
        for (int style = 0; style < MrFonts.STYLES; style++) {
            for (char c = 'a'; c <= 'z'; c++) if (MrFonts.styled(style, c) == null) allLetters = false;
            for (char c = 'A'; c <= 'Z'; c++) if (MrFonts.styled(style, c) == null) allLetters = false;
        }
        check(allLetters, "every letter has an answer in every style");

        // ---- out-of-range styles give null (no style, no crash)
        check(MrFonts.styled(-1, 'a') == null, "style -1 gives null");
        check(MrFonts.styled(MrFonts.STYLES, 'a') == null, "a style past the end gives null");

        // ---- accented letters: the base letter is styled, the accent stays after it
        checkEquals(MrFonts.styled(20, '\u00e7'), "c\u0327", "Subscript: c-cedilla keeps the cedilla after the base c");
        checkEquals(MrFonts.styled(25, '\u00e3'), "a\u0305\u0303", "Overline: a-tilde keeps its tilde after the styled a");
        checkEquals(MrFonts.styledText(20, "Ana 12"), "A\u2099\u2090 12", "styledText: letters change, capitals and digits stay");
        checkEquals(MrFonts.styled(0, '\u00c1'), cp(0x1D400) + "\u0301", "Bold: A-acute is the bold A and the acute mark");
        checkEquals(MrFonts.styled(0, '\u00e9'), cp(0x1D41E) + "\u0301", "Bold: e-acute is the bold e and the acute mark");
        checkEquals(MrFonts.styled(24, '\u00f1'), "n\u0336\u0303", "Strikethrough: n-tilde keeps the tilde after the marked n");
        check(MrFonts.styled(0, '\u00df') == null, "a letter without a base in the alphabet (sharp s) is not styled");
        check(MrFonts.styled(0, '\u0436') == null && MrFonts.styled(0, '\u4e2d') == null, "other alphabets (Cyrillic, Chinese) are not styled");
        check(MrFonts.styled(0, '\u00a9') == null && MrFonts.styled(0, '\u20ac') == null, "symbols above ASCII are not styled");
        check(MrFonts.styled(0, '@') == null && MrFonts.styled(0, '_') == null && MrFonts.styled(0, '\n') == null, "ASCII symbols and the new line are not styled");

        // ---- fields that take a style: plain text only
        check(MrFonts.fieldTakesStyle(null), "no editor info: styles allowed");
        check(MrFonts.fieldTakesStyle(info(0x1)), "plain text takes a style");
        check(MrFonts.fieldTakesStyle(info(0x1 | 0x4000 | 0x20000)), "text with capitals and multi-line takes a style");
        check(MrFonts.fieldTakesStyle(info(0x1 | 0xa0)), "web edit text takes a style");
        check(MrFonts.fieldTakesStyle(info(0x1 | 0x2000)), "text that asks for no suggestions takes a style");
        check(MrFonts.fieldTakesStyle(info(0x1 | 0x70)), "a person name takes a style");
        check(MrFonts.fieldTakesStyle(info(0x1 | 0x40)), "a short message takes a style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0x80)), "password: no style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0x90)), "visible password: no style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0xe0)), "web password: no style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0x20)), "e-mail address: no style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0xd0)), "web e-mail address: no style");
        check(!MrFonts.fieldTakesStyle(info(0x1 | 0x10)), "web address: no style");
        check(!MrFonts.fieldTakesStyle(info(0x2)), "number: no style");
        check(!MrFonts.fieldTakesStyle(info(0x3)), "phone: no style");
        check(!MrFonts.fieldTakesStyle(info(0x4)), "date and time: no style");
        check(!MrFonts.fieldTakesStyle(info(0)), "no type (terminal, game): no style");

        // ---- typing and delete with a style chosen (Bold = choice 1)
        setChoice(1);
        FakeIme ime = new FakeIme();
        ime.info = info(0x1);
        ime.ic = new FakeConn("ab" + cp(0x1D41A), "");
        check(MrFonts.typeStyled(ime, 'a') && ((FakeConn) ime.ic).committed.equals(cp(0x1D41A)),
              "a styled letter is committed in the style");
        check(!MrFonts.typeStyled(ime, '1') && !MrFonts.typeStyled(ime, ' '), "digit and space go the normal way");
        check(MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == 2,
              "delete removes a whole styled letter (two chars)");
        ime.ic = new FakeConn("abc", "xyz");
        check(!MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == 0,
              "delete with a selection is left to the normal delete");
        ime.info = info(0x1 | 0x80);
        ime.ic = new FakeConn("abc", "");
        check(!MrFonts.typeStyled(ime, 'a') && ((FakeConn) ime.ic).committed.isEmpty(),
              "a password field gets the plain letter (the normal way)");
        check(!MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == 0,
              "a password field: delete is the normal delete");
        // typed letters: capitals, accents, and the keys that must go the normal way (a plain text field)
        ime.info = info(0x1);
        ime.ic = new FakeConn("", "");
        check(MrFonts.typeStyled(ime, 'A') && ((FakeConn) ime.ic).committed.equals(cp(0x1D400)), "a capital is committed as the bold capital");
        ime.ic = new FakeConn("", "");
        check(MrFonts.typeStyled(ime, 0xE9) && ((FakeConn) ime.ic).committed.equals(cp(0x1D41E) + "\u0301"), "an accented key is committed as the bold letter and its mark");
        ime.ic = new FakeConn("", "");
        check(!MrFonts.typeStyled(ime, -1) && !MrFonts.typeStyled(ime, -2) && !MrFonts.typeStyled(ime, 0x1F600) && !MrFonts.typeStyled(ime, 0x20) && !MrFonts.typeStyled(ime, '.'),
              "Shift (-1), a symbol key, a code past the BMP, space and a dot go the normal way");
        check(((FakeConn) ime.ic).committed.isEmpty(), "...and nothing was committed for them");
        ime.ic = null;
        check(!MrFonts.typeStyled(ime, 'a') && !MrFonts.typeStyled(ime, MrFonts.CODE_DELETE), "no input connection: the normal way");
        check(!MrFonts.typeStyled(null, 'a'), "no keyboard service: the normal way");

        // delete: one whole letter, whatever it is made of
        String[][] dels = {
            {"ab" + cp(0x1D41A), "2", "a letter outside the BMP (two chars)"},
            {"ab" + cp(0x1D41E) + "\u0301", "3", "an accented bold letter (surrogate pair and a mark: three chars)"},
            {"ab" + "x\u0336", "2", "a struck letter (letter and mark)"},
            {"ab" + "x\u0332\u0301", "3", "an underlined and accented letter (letter and two marks)"},
            {"ab" + cp(0x1F600), "2", "an emoji (two chars)"},
            {"ab" + "\u0063\u0327", "2", "a letter with a loose cedilla (c and the mark)"},
        };
        for (String[] d : dels) {
            ime.ic = new FakeConn(d[0], "");
            check(MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == Integer.parseInt(d[1]), "delete removes " + d[2]);
        }
        String[] plain = {"abc", "a1", "\u00e7", "a\r\n", "a "};
        for (String t : plain) {
            ime.ic = new FakeConn(t, "");
            check(!MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == 0, "delete after the plain text '" + t.replace("\r", "\\r").replace("\n", "\\n") + "' is left to the normal delete");
        }
        ime.ic = new FakeConn("", "");
        check(!MrFonts.typeStyled(ime, MrFonts.CODE_DELETE) && ((FakeConn) ime.ic).deleted == 0, "delete in an empty field is left to the normal delete");

        // the label of a key
        MrTools.sIme = ime;
        ime.info = info(0x1);
        check(MrFonts.styleLabel("A").equals(cp(0x1D400)), "key label: a capital letter is the bold capital");
        check(MrFonts.styleLabel("1").equals("1") && MrFonts.styleLabel("@").equals("@") && MrFonts.styleLabel(" ").equals(" "), "key label: digits and symbols stay");
        check(MrFonts.styleLabel("ab").equals("ab") && MrFonts.styleLabel("").equals("") && MrFonts.styleLabel(null) == null, "key label: a longer text, an empty one and null stay");
        MrTools.sIme = null;
        ime.info = info(0x1 | 0x80);   // back to the password field of the checks that follow
        MrTools.sIme = ime;
        check(MrFonts.styleLabel("a").equals("a"), "a password field: the key label stays plain");
        ime.info = info(0x1);
        check(MrFonts.styleLabel("a").equals(cp(0x1D41A)), "a text field: the key label is in the style");
        MrTools.sIme = null;
        setChoice(0);
        ime.info = info(0x1);
        check(!MrFonts.typeStyled(ime, 'a'), "no style chosen: every key goes the normal way");

        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) of " + checks);
        if (fails != 0) System.exit(1);
    }
}
