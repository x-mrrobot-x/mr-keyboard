package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

/**
 * Teste de PC da recorreção (v1.74): MrRecorrect.eligible (quais palavras ganham sugestões) e
 * MrRecorrect.wordAt (achar a palavra sob o cursor pelo retrato do texto da API 31 ou pelo caminho
 * de sempre). Roda pelo docs/tools/run_java_tests.sh.
 */
public class RecorrectTest {
    static int ok = 0, fail = 0;
    static final String SEP = " .,;:!?\n()\"";

    static void check(String name, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + name); }
        else { fail++; System.out.println("FALHA " + name); }
    }

    /** Editor de mentira: um texto, uma seleção, e o que getSurroundingText responde. */
    static class Editor implements InputConnection {
        String text;
        int selStart, selEnd;
        boolean unknownOffset, returnNull, throwing, incoherent;
        int snapshots;

        Editor(String text, int selStart, int selEnd) { this.text = text; this.selStart = selStart; this.selEnd = selEnd; }

        public CharSequence getTextBeforeCursor(int n, int flags) { return ""; }

        public SurroundingText getSurroundingText(int before, int after, int flags) {
            snapshots++;
            if (throwing) throw new IllegalStateException("conexão inválida");
            if (returnNull) return null;
            int lo = Math.min(selStart, selEnd), hi = Math.max(selStart, selEnd);
            int from = Math.max(0, lo - before), to = Math.min(text.length(), hi + after);
            int s = selStart - from, e = selEnd - from;   // pode ficar invertida, como o editor devolve
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
        check("palavra comum", MrRecorrect.eligible("obrigado"));
        check("palavra errada também", MrRecorrect.eligible("obrogado"));
        check("2 letras (mínimo)", MrRecorrect.eligible("ds"));
        check("1 letra não", !MrRecorrect.eligible("a"));
        check("vazia e nula não", !MrRecorrect.eligible("") && !MrRecorrect.eligible(null));
        check("acento e ç", MrRecorrect.eligible("coração") && MrRecorrect.eligible("ação"));
        check("apóstrofo no meio (don't)", MrRecorrect.eligible("don't"));
        check("hífen no meio", MrRecorrect.eligible("guarda-chuva"));
        check("com dígito não (4g, abc123, 2024)", !MrRecorrect.eligible("4g") && !MrRecorrect.eligible("abc123")
                && !MrRecorrect.eligible("2024"));
        check("só símbolos não", !MrRecorrect.eligible("--") && !MrRecorrect.eligible("'\""));
        StringBuilder w48 = new StringBuilder(), w49 = new StringBuilder();
        for (int i = 0; i < 48; i++) w48.append('a');
        for (int i = 0; i < 49; i++) w49.append('a');
        check("48 caracteres cabe, 49 não", MrRecorrect.eligible(w48) && !MrRecorrect.eligible(w49));
        check("aceita CharSequence que não é String", MrRecorrect.eligible(new StringBuilder("casa")));

        // ---------------------------------------------------------------- wordAt, Android 14 (retrato do texto)
        Build.VERSION.SDK_INT = 34;
        EditingUtil.calls = 0;
        // "ola obrogado pessoal": o cursor depois de apagar o espaço fica no fim da palavra
        Editor ed = new Editor("ola obrogado pessoal", 12, 12);
        EditingUtil.SelectedWord w = at(ed, 12, 12);
        check("API 34: cursor no fim da palavra (apagou o espaço)", is(w, "obrogado", 4, 12) && EditingUtil.calls == 0);
        check("API 34: cursor no meio da palavra", is(at(new Editor("ola obrogado pessoal", 7, 7), 7, 7), "obrogado", 4, 12));
        check("API 34: cursor no começo da palavra", is(at(new Editor("ola obrogado pessoal", 4, 4), 4, 4), "obrogado", 4, 12));
        check("API 34: cursor depois do espaço (entre palavras) = sem palavra", at(new Editor("ola obrogado  pessoal", 13, 13), 13, 13) == null);
        check("API 34: cursor no começo do texto", is(at(new Editor("ola obrogado", 0, 0), 0, 0), "ola", 0, 3));
        check("API 34: cursor no fim do texto", is(at(new Editor("ola obrogado", 12, 12), 12, 12), "obrogado", 4, 12));
        check("API 34: campo vazio = sem palavra", at(new Editor("", 0, 0), 0, 0) == null);
        check("API 34: acento e pontuação em volta", is(at(new Editor("não, coração!", 9, 9), 9, 9), "coração", 5, 12));

        // posição vem do retrato, não da última seleção guardada (que pode estar velha)
        w = at(new Editor("ola obrogado pessoal", 7, 7), 99, 99);
        check("API 34: seleção guardada velha não atrapalha (deslocamento do editor manda)", is(w, "obrogado", 4, 12));
        Editor unk = new Editor("ola obrogado pessoal", 7, 7);
        unk.unknownOffset = true;
        check("API 34: deslocamento desconhecido (-1): usa a seleção guardada", is(at(unk, 7, 7), "obrogado", 4, 12));
        unk.selStart = unk.selEnd = 0;
        check("API 34: deslocamento desconhecido e guardada coerente no começo", is(at(unk, 0, 0), "ola", 0, 3));

        // texto grande: o retrato é só uma janela, mas as posições são do editor inteiro
        StringBuilder big = new StringBuilder();
        for (int i = 0; i < 400; i++) big.append("palavra ");
        big.append("obrogado final");
        int cur = big.indexOf("obrogado") + 3;
        w = at(new Editor(big.toString(), cur, cur), cur, cur);
        check("API 34: texto grande, posições do editor inteiro", is(w, "obrogado", big.indexOf("obrogado"), big.indexOf("obrogado") + 8));

        // seleção
        check("API 34: seleção que é uma palavra inteira", is(at(new Editor("ola obrogado pessoal", 4, 12), 4, 12), "obrogado", 4, 12));
        check("API 34: seleção invertida também", is(at(new Editor("ola obrogado pessoal", 12, 4), 12, 4), "obrogado", 4, 12));
        check("API 34: seleção de parte da palavra = sem palavra", at(new Editor("ola obrogado pessoal", 5, 9), 5, 9) == null);
        check("API 34: seleção que pega duas palavras = sem palavra", at(new Editor("ola obrogado pessoal", 4, 20), 4, 20) == null);
        check("API 34: seleção que cobre o texto todo com separador = sem palavra", at(new Editor("ola obrogado", 0, 12), 0, 12) == null);
        check("API 34: seleção da primeira palavra do texto", is(at(new Editor("ola obrogado", 0, 3), 0, 3), "ola", 0, 3));

        // ---------------------------------------------------------------- caminhos de sempre
        EditingUtil.SelectedWord marca = new EditingUtil.SelectedWord();
        marca.word = "legado"; marca.start = 1; marca.end = 7;
        EditingUtil.result = marca;

        Editor nul = new Editor("ola obrogado", 12, 12);
        nul.returnNull = true;
        EditingUtil.calls = 0;
        check("API 34: editor sem retrato (null) usa o EditingUtil", at(nul, 12, 12) == marca && EditingUtil.calls == 1);

        Editor thr = new Editor("ola obrogado", 12, 12);
        thr.throwing = true;
        EditingUtil.calls = 0;
        check("API 34: retrato que lança erro usa o EditingUtil (sem derrubar)", at(thr, 12, 12) == marca && EditingUtil.calls == 1);

        Editor inc = new Editor("ola obrogado", 12, 12);
        inc.incoherent = true;
        EditingUtil.calls = 0;
        check("API 34: retrato incoerente usa o EditingUtil", at(inc, 12, 12) == marca && EditingUtil.calls == 1);

        for (int sdk : new int[] {26, 28, 30}) {
            Build.VERSION.SDK_INT = sdk;
            Editor old = new Editor("ola obrogado", 12, 12);
            EditingUtil.calls = 0;
            check("API " + sdk + ": nem pede o retrato, usa o EditingUtil", at(old, 12, 12) == marca && EditingUtil.calls == 1 && old.snapshots == 0);
        }
        Build.VERSION.SDK_INT = 31;
        EditingUtil.calls = 0;
        check("API 31 (primeira com o retrato) já usa o retrato", is(at(new Editor("ola obrogado", 12, 12), 12, 12), "obrogado", 4, 12) && EditingUtil.calls == 0);

        check("sem conexão ou sem separadores = sem palavra", MrRecorrect.wordAt(null, 0, 0, SEP) == null
                && MrRecorrect.wordAt(new Editor("ola", 1, 1), 1, 1, null) == null);

        // ---------------------------------------------------------------- composer: palavra reaberta com vizinhas
        Keyboard qwerty = new Keyboard();
        String[] rows = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
        int[] x0 = {0, 50, 150};
        for (int r = 0; r < 3; r++) {
            for (int k = 0; k < rows[r].length(); k++) {
                qwerty.keys.add(new Keyboard.Key(rows[r].charAt(k), x0[r] + k * 100, r * 120, 100, 120));
            }
        }
        qwerty.keys.add(new Keyboard.Key(' ', 250, 360, 500, 120));   // espaço: nunca é vizinha
        KeyboardSwitcher ks = new KeyboardSwitcher();
        ks.view = new LatinKeyboardView();
        ks.view.keyboard = qwerty;

        WordComposer wc = MrRecorrect.composer(ks, "gato");
        int[] g = wc.getCodesAt(0);
        check("composer: 1 posição por letra e a palavra igual", wc.size() == 4 && "gato".contentEquals(wc.getTypedWord()));
        check("composer: o 1º código é a letra e o vetor tem o tamanho da digitação",
                g[0] == 'g' && g.length == MrRecorrect.NEARBY);
        check("composer: vizinhas do g em ordem de distância (f,h a 100; v a 120; t,y a 130; b e c ficam fora do alcance)",
                (g[1] == 'f' && g[2] == 'h' || g[1] == 'h' && g[2] == 'f') && g[3] == 'v'
                        && (g[4] == 't' && g[5] == 'y' || g[4] == 'y' && g[5] == 't') && g[6] == -1
                        && !contains(g, 'b') && !contains(g, 'c'));
        check("composer: tecla longe (p) e o espaço não entram", !contains(g, 'p') && !contains(g, ' ') && !contains(g, 'g', 1));
        int[] a0 = MrRecorrect.composer(ks, "azul").getCodesAt(0);
        check("composer: letra da borda tem menos vizinhas (a: s a 100, q e w a 130; z fora do alcance)", a0[0] == 'a'
                && a0[1] == 's' && contains(a0, 'q') && contains(a0, 'w') && !contains(a0, 'z') && a0[4] == -1 && !contains(a0, 'a', 1));
        WordComposer up = MrRecorrect.composer(ks, "Obrigado");
        check("composer: maiúscula inicial marcada e o código 0 é a letra como foi digitada",
                up.isFirstCharCapitalized() && up.getCodesAt(0)[0] == 'O' && contains(up.getCodesAt(0), 'i') && contains(up.getCodesAt(0), 'p'));
        WordComposer acc = MrRecorrect.composer(ks, "ação");
        check("composer: letra com acento (ã, ç) usa as vizinhas da tecla da letra base e mantém a letra digitada",
                acc.getCodesAt(0)[0] == 'a' && acc.getCodesAt(1)[0] == 'ç' && contains(acc.getCodesAt(1), 'x')
                && contains(acc.getCodesAt(1), 'v') && contains(acc.getCodesAt(1), 'f') && !contains(acc.getCodesAt(1), 'c')
                && contains(MrRecorrect.composer(ks, "ã").getCodesAt(0), 's'));
        check("composer: caractere sem tecla nenhuma (@) fica só ele", MrRecorrect.composer(ks, "@").getCodesAt(0)[1] == -1);
        int[] solo = MrRecorrect.composer(null, "casa").getCodesAt(0);
        check("composer: sem teclado (nulo) só as letras", solo[0] == 'c' && solo[1] == -1);
        KeyboardSwitcher noView = new KeyboardSwitcher();
        check("composer: sem a tela do teclado só as letras", MrRecorrect.composer(noView, "casa").getCodesAt(0)[1] == -1);
        KeyboardSwitcher sym = new KeyboardSwitcher();
        sym.view = new LatinKeyboardView();
        sym.view.keyboard = new Keyboard();
        sym.view.keyboard.keys.add(new Keyboard.Key('1', 0, 0, 100, 120));
        sym.view.keyboard.keys.add(new Keyboard.Key('2', 100, 0, 100, 120));
        check("composer: teclado de símbolos (sem a letra) só as letras", MrRecorrect.composer(sym, "casa").getCodesAt(0)[1] == -1);
        Keyboard broken = new Keyboard() {
            public java.util.List<Key> getKeys() { throw new IllegalStateException("teclado trocando"); }
        };
        KeyboardSwitcher bad = new KeyboardSwitcher();
        bad.view = new LatinKeyboardView();
        bad.view.keyboard = broken;
        check("composer: erro ao ler o teclado não derruba, só as letras", MrRecorrect.composer(bad, "casa").getCodesAt(0)[1] == -1);
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
        check("composer: nunca passa de " + MrRecorrect.NEARBY + " códigos e vem em ordem de distância", dc.length == MrRecorrect.NEARBY && sorted);

        System.out.println(fail == 0 ? "TUDO OK (" + ok + " verificações)" : fail + " FALHA(S)");
        if (fail != 0) System.exit(1);
    }
}
