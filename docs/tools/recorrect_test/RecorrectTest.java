package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

/**
* PC test of the re-correction (v1.74): MrRecorrect.eligible (which words get suggestions) and
* MrRecorrect.wordAt (finding the word under the cursor through the API 31 text snapshot or the
* usual path). Runs through docs/tools/run_java_tests.sh.
 */
public class RecorrectTest {
    static int ok = 0, fail = 0;
    static final String SEP = " .,;:!?\n()\"";

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FAIL  " + name); }
    }

    /** Fake editor: a text, a selection, and what getSurroundingText answers. */
    static class Editor implements InputConnection {
        String text;
        int selStart, selEnd;
        boolean unknownOffset, returnNull, throwing, incoherent;
        int snapshots;

        Editor(String text, int selStart, int selEnd) { this.text = text; this.selStart = selStart; this.selEnd = selEnd; }

        public CharSequence getTextBeforeCursor(int n, int flags) { return ""; }
        public CharSequence getSelectedText(int flags) { return null; }
        public boolean commitText(CharSequence text, int newCursorPosition) { return false; }
        public boolean deleteSurroundingText(int beforeLength, int afterLength) { return false; }
        public boolean finishComposingText() { return true; }
        public boolean beginBatchEdit() { return true; }
        public boolean endBatchEdit() { return true; }

        public SurroundingText getSurroundingText(int before, int after, int flags) {
            snapshots++;
            if (throwing) throw new IllegalStateException("invalid connection");
            if (returnNull) return null;
            int lo = Math.min(selStart, selEnd), hi = Math.max(selStart, selEnd);
            int from = Math.max(0, lo - before), to = Math.min(text.length(), hi + after);
            int s = selStart - from, e = selEnd - from;   // may end up reversed, as the editor returns it
            if (incoherent) e = to - from + 5;
            return new SurroundingText(text.substring(from, to), s, e, unknownOffset ? -1 : from);
        }
    }

    static boolean contains(int[] codes, int c) { return contains(codes, c, 0); }

    static boolean contains(int[] codes, int c, int from) {
        for (int i = from; i < codes.length; i++) if (codes[i] == c) return true;
        return false;
    }

    static String str(EditingUtil.SelectedWord w) { return w == null ? "null" : w.word + "[" + w.start + "," + w.end + ")"; }

    static boolean is(EditingUtil.SelectedWord w, String word, int start, int end) {
        return w != null && word.equals(String.valueOf(w.word)) && w.start == start && w.end == end;
    }

    static EditingUtil.SelectedWord at(Editor ed, int cachedStart, int cachedEnd) {
        return MrRecorrect.wordAt(ed, cachedStart, cachedEnd, SEP);
    }

    public static void main(String[] a) {
        // ---------------------------------------------------------------- eligible
        check("ordinary word", MrRecorrect.eligible("obrigado"));
        check("misspelled word too", MrRecorrect.eligible("obrogado"));
        check("2 letters (minimum)", MrRecorrect.eligible("ds"));
        check("1 letter no", !MrRecorrect.eligible("a"));
        check("empty and null no", !MrRecorrect.eligible("") && !MrRecorrect.eligible(null));
        check("accent and ç", MrRecorrect.eligible("coração") && MrRecorrect.eligible("ação"));
        check("apostrophe in the middle (don't)", MrRecorrect.eligible("don't"));
        check("hyphen in the middle", MrRecorrect.eligible("guarda-chuva"));
        check("with a digit no (4g, abc123, 2024)", !MrRecorrect.eligible("4g") && !MrRecorrect.eligible("abc123")
                && !MrRecorrect.eligible("2024"));
        check("only symbols no", !MrRecorrect.eligible("--") && !MrRecorrect.eligible("'\""));
        StringBuilder w48 = new StringBuilder(), w49 = new StringBuilder();
        for (int i = 0; i < 48; i++) w48.append('a');
        for (int i = 0; i < 49; i++) w49.append('a');
        check("48 characters fit, 49 do not", MrRecorrect.eligible(w48) && !MrRecorrect.eligible(w49));
        check("accepts a CharSequence that is not a String", MrRecorrect.eligible(new StringBuilder("casa")));

        // ---------------------------------------------------------------- wordAt, Android 14 (text snapshot)
        Build.VERSION.SDK_INT = 34;
        EditingUtil.calls = 0;
        // "ola obrogado pessoal": the cursor after deleting the space ends up at the end of the word
        Editor ed = new Editor("ola obrogado pessoal", 12, 12);
        EditingUtil.SelectedWord w = at(ed, 12, 12);
        check("API 34: cursor at the end of the word (deleted the space)", is(w, "obrogado", 4, 12) && EditingUtil.calls == 0);
        check("API 34: cursor in the middle of the word", is(at(new Editor("ola obrogado pessoal", 7, 7), 7, 7), "obrogado", 4, 12));
        check("API 34: cursor at the start of the word", is(at(new Editor("ola obrogado pessoal", 4, 4), 4, 4), "obrogado", 4, 12));
        check("API 34: cursor after the space (between words) = no word", at(new Editor("ola obrogado  pessoal", 13, 13), 13, 13) == null);
        check("API 34: cursor at the start of the text", is(at(new Editor("ola obrogado", 0, 0), 0, 0), "ola", 0, 3));
        check("API 34: cursor at the end of the text", is(at(new Editor("ola obrogado", 12, 12), 12, 12), "obrogado", 4, 12));
        check("API 34: empty field = no word", at(new Editor("", 0, 0), 0, 0) == null);
        check("API 34: accent and punctuation around", is(at(new Editor("não, coração!", 9, 9), 9, 9), "coração", 5, 12));

        // position comes from the snapshot, not from the last stored selection (which may be stale)
        w = at(new Editor("ola obrogado pessoal", 7, 7), 99, 99);
        check("API 34: stale stored selection does not interfere (the editor offset rules)", is(w, "obrogado", 4, 12));
        Editor unk = new Editor("ola obrogado pessoal", 7, 7);
        unk.unknownOffset = true;
        check("API 34: unknown offset (-1): uses the stored selection", is(at(unk, 7, 7), "obrogado", 4, 12));
        unk.selStart = unk.selEnd = 0;
        check("API 34: unknown offset and a coherent stored selection at the start", is(at(unk, 0, 0), "ola", 0, 3));

        // large text: the snapshot is only a window, but the positions are those of the whole editor
        StringBuilder big = new StringBuilder();
        for (int i = 0; i < 400; i++) big.append("palavra ");
        big.append("obrogado final");
        int cur = big.indexOf("obrogado") + 3;
        w = at(new Editor(big.toString(), cur, cur), cur, cur);
        check("API 34: large text, positions of the whole editor", is(w, "obrogado", big.indexOf("obrogado"), big.indexOf("obrogado") + 8));

        // selection
        check("API 34: selection that is a whole word", is(at(new Editor("ola obrogado pessoal", 4, 12), 4, 12), "obrogado", 4, 12));
        check("API 34: reversed selection too", is(at(new Editor("ola obrogado pessoal", 12, 4), 12, 4), "obrogado", 4, 12));
        check("API 34: selection of part of the word = no word", at(new Editor("ola obrogado pessoal", 5, 9), 5, 9) == null);
        check("API 34: selection that spans two words = no word", at(new Editor("ola obrogado pessoal", 4, 20), 4, 20) == null);
        check("API 34: selection that covers the whole text with a separator = no word", at(new Editor("ola obrogado", 0, 12), 0, 12) == null);
        check("API 34: selection of the first word of the text", is(at(new Editor("ola obrogado", 0, 3), 0, 3), "ola", 0, 3));

        // ---------------------------------------------------------------- usual paths
        EditingUtil.SelectedWord marker = new EditingUtil.SelectedWord();
        marker.word = "legado"; marker.start = 1; marker.end = 7;
        EditingUtil.result = marker;

        Editor nul = new Editor("ola obrogado", 12, 12);
        nul.returnNull = true;
        EditingUtil.calls = 0;
        check("API 34: editor without a snapshot (null) uses EditingUtil", at(nul, 12, 12) == marker && EditingUtil.calls == 1);

        Editor thr = new Editor("ola obrogado", 12, 12);
        thr.throwing = true;
        EditingUtil.calls = 0;
        check("API 34: snapshot that throws an error uses EditingUtil (without crashing)", at(thr, 12, 12) == marker && EditingUtil.calls == 1);

        Editor inc = new Editor("ola obrogado", 12, 12);
        inc.incoherent = true;
        EditingUtil.calls = 0;
        check("API 34: incoherent snapshot uses EditingUtil", at(inc, 12, 12) == marker && EditingUtil.calls == 1);

        for (int sdk : new int[] {26, 28, 30}) {
            Build.VERSION.SDK_INT = sdk;
            Editor old = new Editor("ola obrogado", 12, 12);
            EditingUtil.calls = 0;
            check("API " + sdk + ": does not even ask for the snapshot, uses EditingUtil", at(old, 12, 12) == marker && EditingUtil.calls == 1 && old.snapshots == 0);
        }
        Build.VERSION.SDK_INT = 31;
        EditingUtil.calls = 0;
        check("API 31 (first with the snapshot) already uses the snapshot", is(at(new Editor("ola obrogado", 12, 12), 12, 12), "obrogado", 4, 12) && EditingUtil.calls == 0);

        check("no connection or no separators = no word", MrRecorrect.wordAt(null, 0, 0, SEP) == null
                && MrRecorrect.wordAt(new Editor("ola", 1, 1), 1, 1, null) == null);

        // ---------------------------------------------------------------- composer: reopened word with neighbours
        Keyboard qwerty = new Keyboard();
        String[] rows = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
        int[] x0 = {0, 50, 150};
        for (int r = 0; r < 3; r++) {
            for (int k = 0; k < rows[r].length(); k++) {
                qwerty.keys.add(new Keyboard.Key(rows[r].charAt(k), x0[r] + k * 100, r * 120, 100, 120));
            }
        }
        qwerty.keys.add(new Keyboard.Key(' ', 250, 360, 500, 120));   // space: is never a neighbour
        KeyboardSwitcher ks = new KeyboardSwitcher();
        ks.view = new LatinKeyboardView();
        ks.view.keyboard = qwerty;

        WordComposer wc = MrRecorrect.composer(ks, "gato");
        int[] g = wc.getCodesAt(0);
        check("composer: 1 position per letter and the same word", wc.size() == 4 && "gato".contentEquals(wc.getTypedWord()));
        check("composer: the 1st code is the letter and the vector has the size of the typing",
                g[0] == 'g' && g.length == MrRecorrect.NEARBY);
        check("composer: neighbours of g in distance order (f,h at 100; v at 120; t,y at 130; b and c are out of reach)",
                (g[1] == 'f' && g[2] == 'h' || g[1] == 'h' && g[2] == 'f') && g[3] == 'v'
                        && (g[4] == 't' && g[5] == 'y' || g[4] == 'y' && g[5] == 't') && g[6] == -1
                        && !contains(g, 'b') && !contains(g, 'c'));
        check("composer: far key (p) and the space do not get in", !contains(g, 'p') && !contains(g, ' ') && !contains(g, 'g', 1));
        int[] a0 = MrRecorrect.composer(ks, "azul").getCodesAt(0);
        check("composer: edge letter has fewer neighbours (a: s at 100, q and w at 130; z out of reach)", a0[0] == 'a'
                && a0[1] == 's' && contains(a0, 'q') && contains(a0, 'w') && !contains(a0, 'z') && a0[4] == -1 && !contains(a0, 'a', 1));
        WordComposer up = MrRecorrect.composer(ks, "Obrigado");
        check("composer: initial capital flagged and code 0 is the letter as typed",
                up.isFirstCharCapitalized() && up.getCodesAt(0)[0] == 'O' && contains(up.getCodesAt(0), 'i') && contains(up.getCodesAt(0), 'p'));
        WordComposer acc = MrRecorrect.composer(ks, "ação");
        check("composer: accented letter (ã, ç) uses the neighbours of the base letter's key and keeps the typed letter",
                acc.getCodesAt(0)[0] == 'a' && acc.getCodesAt(1)[0] == 'ç' && contains(acc.getCodesAt(1), 'x')
                && contains(acc.getCodesAt(1), 'v') && contains(acc.getCodesAt(1), 'f') && !contains(acc.getCodesAt(1), 'c')
                && contains(MrRecorrect.composer(ks, "ã").getCodesAt(0), 's'));
        check("composer: character with no key at all (@) stays alone", MrRecorrect.composer(ks, "@").getCodesAt(0)[1] == -1);
        int[] solo = MrRecorrect.composer(null, "casa").getCodesAt(0);
        check("composer: no keyboard (null) only the letters", solo[0] == 'c' && solo[1] == -1);
        KeyboardSwitcher noView = new KeyboardSwitcher();
        check("composer: no keyboard view only the letters", MrRecorrect.composer(noView, "casa").getCodesAt(0)[1] == -1);
        KeyboardSwitcher sym = new KeyboardSwitcher();
        sym.view = new LatinKeyboardView();
        sym.view.keyboard = new Keyboard();
        sym.view.keyboard.keys.add(new Keyboard.Key('1', 0, 0, 100, 120));
        sym.view.keyboard.keys.add(new Keyboard.Key('2', 100, 0, 100, 120));
        check("composer: symbols keyboard (without the letter) only the letters", MrRecorrect.composer(sym, "casa").getCodesAt(0)[1] == -1);
        Keyboard broken = new Keyboard() {
            public java.util.List<Key> getKeys() { throw new IllegalStateException("keyboard switching"); }
        };
        KeyboardSwitcher bad = new KeyboardSwitcher();
        bad.view = new LatinKeyboardView();
        bad.view.keyboard = broken;
        check("composer: error reading the keyboard does not crash, only the letters", MrRecorrect.composer(bad, "casa").getCodesAt(0)[1] == -1);
        Keyboard dense = new Keyboard();
        String dcodes = "abcdefghijklmnopqrstuvwxyz!@#$";
        for (int i = 0; i < dcodes.length(); i++) dense.keys.add(new Keyboard.Key(dcodes.charAt(i), (i % 6) * 40, (i / 6) * 40, 100, 100));
        KeyboardSwitcher ds = new KeyboardSwitcher();
        ds.view = new LatinKeyboardView();
        ds.view.keyboard = dense;
        int[] dc = MrRecorrect.composer(ds, "m").getCodesAt(0);
        Keyboard.Key km = dense.keys.get(dcodes.indexOf('m'));
        boolean sorted = true;
        for (int j = 2; j < dc.length; j++) {
            Keyboard.Key kp = dense.keys.get(dcodes.indexOf(dc[j - 1])), kj = dense.keys.get(dcodes.indexOf(dc[j]));
            if (kp.squaredDistanceFrom(km.x + 50, km.y + 50) > kj.squaredDistanceFrom(km.x + 50, km.y + 50)) sorted = false;
        }
        check("composer: never exceeds " + MrRecorrect.NEARBY + " codes and comes in distance order", dc.length == MrRecorrect.NEARBY && sorted);

        // ---------------------------------------------------------------- strip: valid reopened word goes to the center
        Suggest dic = new Suggest();
        dic.valid.addAll(java.util.Arrays.asList("gato", "fato", "casa"));
        check("isValid: dictionary word", MrRecorrect.isValid(dic, "gato"));
        check("isValid: with an initial capital counts as the lowercase (Gato)", MrRecorrect.isValid(dic, "Gato") && MrRecorrect.isValid(dic, "CASA"));
        check("isValid: misspelled word does not count (gaato) and neither does a name outside the dictionary", !MrRecorrect.isValid(dic, "gaato") && !MrRecorrect.isValid(dic, "Fernanda"));
        check("isValid: null, empty and no Suggest give false, without throwing", !MrRecorrect.isValid(dic, null) && !MrRecorrect.isValid(dic, "")
                && !MrRecorrect.isValid(null, "gato"));

        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        if (fail != 0) System.exit(1);
    }
}
