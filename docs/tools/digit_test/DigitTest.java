package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * PC test of the digits typed for letters (the number row sits right above q..p): what may be replaced on its own (MrFuzzy.digitSlip and
 * confident), the suggestions with another number (MrFuzzy.dropOtherNumbers), and the lone digit that starts a word (MrDigitStart: "5udo").
 * The search itself (the strip of "obr8gado", "5udo") is checked by S30 of docs/tools/e2e/StrategyTest.java. Runs through
 * docs/tools/run_java_tests.sh.
 */
public class DigitTest {
    static int ok = 0, fail = 0;

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    /** Fake field: the text before the cursor, the text after it, and what the keyboard asked. */
    static class Field implements InputConnection {
        final StringBuilder before;
        final String after;
        int deletes;
        boolean refuseDelete, throwing;

        Field(String before, String after) { this.before = new StringBuilder(before); this.after = after; }

        public CharSequence getTextBeforeCursor(int n, int flags) {
            if (throwing) throw new IllegalStateException("dead connection");
            return before.substring(Math.max(0, before.length() - n));
        }
        public CharSequence getTextAfterCursor(int n, int flags) { return after.substring(0, Math.min(n, after.length())); }
        public CharSequence getSelectedText(int flags) { return null; }
        public boolean commitText(CharSequence text, int newCursorPosition) { before.append(text); return true; }
        public boolean deleteSurroundingText(int beforeLength, int afterLength) {
            if (refuseDelete) return false;
            deletes++;
            before.setLength(Math.max(0, before.length() - beforeLength));
            return true;
        }
        public boolean finishComposingText() { return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }
    }

    static class Ime extends LatinIME {
        InputConnection ic;
        Ime(InputConnection ic) { this.ic = ic; }
        @Override public InputConnection getCurrentInputConnection() { return ic; }
    }

    /** The touch on a digit: the digit, the letters under it and the digits beside it. */
    static int[] touch(String keys) {
        int[] out = new int[keys.length()];
        for (int i = 0; i < out.length; i++) out[i] = keys.charAt(i);
        return out;
    }

    static List<CharSequence> list(String... s) { return new ArrayList<CharSequence>(Arrays.asList(s)); }

    public static void main(String[] a) {
        // ---------------------------------------------------------------- MrFuzzy: the helpers
        check("letter under each digit (1 -> q ... 0 -> p)", MrFuzzy.letterUnder('1') == 'q' && MrFuzzy.letterUnder('5') == 't'
                && MrFuzzy.letterUnder('8') == 'i' && MrFuzzy.letterUnder('0') == 'p');
        check("no letter under anything else", MrFuzzy.letterUnder('a') == 0 && MrFuzzy.letterUnder(' ') == 0);
        check("digits of a word (4h30 -> 430, obrigado -> none)", MrFuzzy.digitCount("4h30") == 3 && "430".equals(MrFuzzy.digitsOf("4h30"))
                && MrFuzzy.digitCount("obrigado") == 0 && MrFuzzy.digitsOf("obrigado").length() == 0);

        // ---------------------------------------------------------------- digitSlip: the digit is the slip
        MrFuzzy.sCapTyped = null;
        check("a digit in the middle for any letter (obr8gado -> obrigado, t3m -> tem)", MrFuzzy.digitSlip("obr8gado", "obrigado")
                && MrFuzzy.digitSlip("t3m", "tem"));
        check("the first letter (5udo -> tudo, 3ntão -> então, 8sso -> isso)", MrFuzzy.digitSlip("5udo", "tudo")
                && MrFuzzy.digitSlip("3ntão", "então") && MrFuzzy.digitSlip("8sso", "isso"));
        check("3 characters, digit at an end: the letter right under it (qu3 -> que, 4ua -> rua)", MrFuzzy.digitSlip("qu3", "que")
                && MrFuzzy.digitSlip("4ua", "rua"));
        check("3 characters, digit at an end, another letter: no (mp3 -> mpo, 2go -> ego)", !MrFuzzy.digitSlip("mp3", "mpo")
                && !MrFuzzy.digitSlip("2go", "ego"));
        check("accents of the other letters ignored (n3o -> não)", MrFuzzy.digitSlip("n3o", "não"));
        check("a digit added, not a letter: no (teste1 -> teste, aula2 -> aula)", !MrFuzzy.digitSlip("teste1", "teste")
                && !MrFuzzy.digitSlip("aula2", "aula"));
        check("two digits: no (iphone11, 4h30)", !MrFuzzy.digitSlip("iphone11", "iphones") && !MrFuzzy.digitSlip("4h30", "ahora"));
        check("two characters: no (a4 -> ar, 3u -> eu)", !MrFuzzy.digitSlip("a4", "ar") && !MrFuzzy.digitSlip("3u", "eu"));
        check("another letter changed too: no (obr8gado -> abrigado)", !MrFuzzy.digitSlip("obr8gado", "abrigado"));
        check("a suggestion with a digit or a symbol in its place: no", !MrFuzzy.digitSlip("obr8gado", "obr1gado")
                && !MrFuzzy.digitSlip("obr8gado", "obr-gado"));
        check("no digit typed: no", !MrFuzzy.digitSlip("obrigado", "obrigado"));
        check("lowercase typed, a name or acronym: no (obr8gado -> Obrigado, ps4 -> PSR)", !MrFuzzy.digitSlip("obr8gado", "Obrigado")
                && !MrFuzzy.digitSlip("ps4", "PSR"));
        check("a capital typed keeps it (Obr8gado -> Obrigado)", MrFuzzy.digitSlip("Obr8gado", "Obrigado"));
        check("start of a sentence not asked: 5udo -> Tudo no", !MrFuzzy.digitSlip("5udo", "Tudo"));
        MrFuzzy.sCapTyped = "5udo";
        check("start of a sentence (the field asked for a capital): 5udo -> Tudo", MrFuzzy.digitSlip("5udo", "Tudo"));
        check("... only the first letter (5udo -> TUDO no)", !MrFuzzy.digitSlip("5udo", "TUDO"));
        check("... only when the digit is that first letter (obr8gado -> Obrigado no)", !MrFuzzy.digitSlip("obr8gado", "Obrigado"));
        check("... only for that word (8sso -> Isso no)", !MrFuzzy.digitSlip("8sso", "Isso"));
        MrFuzzy.sCapTyped = null;

        // ---------------------------------------------------------------- confident: what space replaces on its own
        check("confident: obr8gado -> obrigado", MrFuzzy.confident("obr8gado", "obrigado"));
        check("confident: teste1 -> teste no, mp3 -> MP4 no, 9h -> oh no, 4h30 -> Theo no", !MrFuzzy.confident("teste1", "teste")
                && !MrFuzzy.confident("mp3", "MP4") && !MrFuzzy.confident("9h", "oh") && !MrFuzzy.confident("4h30", "Theo"));
        check("confident without digits as before (obrogado -> obrigado)", MrFuzzy.confident("obrogado", "obrigado"));

        // ---------------------------------------------------------------- dropOtherNumbers
        List<CharSequence> l = list("mp3", "MP4", "MP3", "MPE");
        MrFuzzy.dropOtherNumbers(l, "mp3");
        check("mp3: MP4 leaves, MP3 and the words stay", l.equals(list("mp3", "MP3", "MPE")));
        l = list("4h30", "4h3", "4h30m", "Theo");
        MrFuzzy.dropOtherNumbers(l, "4h30");
        check("4h30: another number leaves, the same digits stay", l.equals(list("4h30", "4h30m", "Theo")));
        l = list("teste", "teste1", "testes");
        MrFuzzy.dropOtherNumbers(l, "teste");
        check("no digit typed: nothing changes", l.equals(list("teste", "teste1", "testes")));
        l = list("x9", "x8");
        MrFuzzy.dropOtherNumbers(l, "x9");
        check("the typed word (index 0) always stays", l.equals(list("x9")));

        // ---------------------------------------------------------------- MrDigitStart.lone
        check("lone: at the start of the text", MrDigitStart.lone("5", "", '5'));
        check("lone: after a space, a line break, a bracket or a quote", MrDigitStart.lone(" 5", "", '5') && MrDigitStart.lone("\n5", null, '5')
                && MrDigitStart.lone("(5", "", '5') && MrDigitStart.lone("\"5", "", '5') && MrDigitStart.lone("¿5", "", '5'));
        check("lone: a space or a sign after the cursor", MrDigitStart.lone(" 5", " ", '5') && MrDigitStart.lone(" 5", ".", '5'));
        check("not lone: after a letter (a5) or a digit (15)", !MrDigitStart.lone("a5", "", '5') && !MrDigitStart.lone("15", "", '5'));
        check("not lone: a letter or a digit glued after the cursor", !MrDigitStart.lone(" 5", "x", '5') && !MrDigitStart.lone(" 5", "3", '5'));
        check("not lone: another digit, nothing, null", !MrDigitStart.lone(" 4", "", '5') && !MrDigitStart.lone("", "", '5')
                && !MrDigitStart.lone(null, "", '5'));

        // ---------------------------------------------------------------- MrDigitStart.sent / take
        KeyboardSwitcher sw = KeyboardSwitcher.getInstance();
        sw.stubAlphabet = true;
        Field f = new Field("oi 5", "");
        Ime ime = new Ime(f);
        MrDigitStart.sent(ime, '5', touch("5try46"));
        int[] codes = MrDigitStart.take(ime);
        check("5 then a letter: the codes of the 5 come back (5, t, r, y, 4, 6)", codes != null && Arrays.equals(codes, touch("5try46")));
        check("... and the 5 left the field", "oi ".equals(f.before.toString()) && f.deletes == 1);
        check("asked once: the second time nothing", MrDigitStart.take(ime) == null && f.deletes == 1);

        f = new Field("5", "");
        ime = new Ime(f);
        int[] mine = touch("4ret35");
        MrDigitStart.sent(ime, '5', mine);
        mine[1] = 'x';
        codes = MrDigitStart.take(ime);
        check("the touch is copied, and the digit typed is its first code", codes != null && codes[0] == '5' && codes[1] == 'r');

        f = new Field("10", "");
        ime = new Ime(f);
        MrDigitStart.sent(ime, '1', touch("1qw2"));
        MrDigitStart.sent(ime, '0', touch("0po9"));
        check("a number (10h): nothing taken, the field unchanged", MrDigitStart.take(ime) == null && "10".equals(f.before.toString()));

        f = new Field("ok 5", "");
        ime = new Ime(f);
        sw.stubAlphabet = false;
        MrDigitStart.sent(ime, '5', touch("5"));
        sw.stubAlphabet = true;
        check("a digit of the symbols sheet: nothing taken", MrDigitStart.take(ime) == null && f.deletes == 0);

        MrDigitStart.sent(ime, '5', touch("5try46"));
        MrDigitStart.sent(ime, ',', touch(","));
        check("anything sent after the digit forgets it", MrDigitStart.take(ime) == null && f.deletes == 0);
        MrDigitStart.sent(ime, 'a', touch("a"));
        check("a letter sent outside a word is not kept", MrDigitStart.take(ime) == null);
        MrDigitStart.sent(ime, '5', null);
        check("a digit with no touch is not kept", MrDigitStart.take(ime) == null);

        f = new Field("ok 5", "");
        f.refuseDelete = true;
        ime = new Ime(f);
        MrDigitStart.sent(ime, '5', touch("5t"));
        check("the field refuses to delete: nothing taken", MrDigitStart.take(ime) == null && "ok 5".equals(f.before.toString()));

        f = new Field("ok 5", "");
        f.throwing = true;
        ime = new Ime(f);
        MrDigitStart.sent(ime, '5', touch("5t"));
        boolean threw = false;
        try { codes = MrDigitStart.take(ime); } catch (Throwable t) { threw = true; }
        check("a dead connection: nothing taken, no exception", !threw && codes == null);

        ime = new Ime(null);
        MrDigitStart.sent(ime, '5', touch("5t"));
        check("no connection: nothing taken", MrDigitStart.take(ime) == null);
        MrDigitStart.sent(ime, '5', touch("5t"));
        check("no keyboard service: nothing taken", MrDigitStart.take(null) == null);

        System.out.println(ok + " OK, " + fail + " FAIL");
        System.exit(fail == 0 ? 0 : 1);
    }
}
