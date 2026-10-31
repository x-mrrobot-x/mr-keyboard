package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

import java.util.Arrays;
import java.util.List;

/**
 * Recorreção (v1.74, "Tocar para corrigir palavras"): acha a palavra sob o cursor e decide se ela
 * merece sugestões. LatinIME.setOldSuggestions chama {@link #wordAt} e {@link #eligible}.
 *
 * Antes o método só mostrava sugestões de palavras que o dicionário já conhecia ou que tinham sido
 * digitadas na sessão; uma palavra errada fora disso (a que mais precisa de correção) ficava sem nada.
 * Agora toda palavra com letras serve; só ficam de fora o que não é palavra para corrigir.
 *
 * Teclas vizinhas (v1.75): a palavra reaberta é remontada com as teclas ao redor de cada letra, tiradas do
 * teclado que está na tela, como na digitação ({@link #composer}). Antes ela levava só as letras e a correção
 * por tecla vizinha ("fato" para gato) não funcionava na palavra reaberta.
 *
 * Leitura do texto (por versão do Android, conforme a documentação):
 *  - API 31+: InputConnection.getSurroundingText devolve o texto em volta, a seleção e o
 *    deslocamento dele no editor numa chamada só. A posição vem do mesmo retrato do texto, sem depender
 *    da última seleção guardada (que pode estar velha) e sem o getExtractedText (texto inteiro do campo).
 *  - API 26 a 30, ou editor que não devolve o retrato: EditingUtil.getWordAtCursorOrSelection, como sempre.
 */
public final class MrRecorrect {
    private MrRecorrect() { }

    /** Mesmo limite do dicionário (BinaryDictionary.MAX_WORD_LENGTH): acima disso a busca não roda. */
    static final int MAX_WORD = 48;
    /** Caracteres lidos de cada lado do cursor (o mesmo do EditingUtil). */
    static final int REACH = 1000;

    /** Resposta interna: o retrato do texto não serve, use o caminho de sempre (nunca sai desta classe). */
    static final EditingUtil.SelectedWord NO_SNAPSHOT = new EditingUtil.SelectedWord();

    /**
     * Palavra de 2 a 48 caracteres, com pelo menos uma letra e nenhum dígito (códigos, senhas,
     * "4g", "abc123" não ganham sugestões).
     */
    static boolean eligible(CharSequence word) {
        if (word == null) return false;
        int n = word.length();
        if (n < 2 || n > MAX_WORD) return false;
        boolean letter = false;
        for (int i = 0; i < n; i++) {
            char c = word.charAt(i);
            if (Character.isDigit(c)) return false;
            if (Character.isLetter(c)) letter = true;
        }
        return letter;
    }

    /**
     * A palavra sob o cursor, ou a seleção quando ela é uma palavra inteira; null se não há palavra.
     * start e end são posições no texto do editor (o que o setComposingRegion espera).
     */
    static EditingUtil.SelectedWord wordAt(InputConnection ic, int selStart, int selEnd, String separators) {
        if (ic == null || separators == null) return null;
        if (Build.VERSION.SDK_INT >= 31) {
            EditingUtil.SelectedWord w = Api31.wordAt(ic, selStart, selEnd, separators);
            if (w != NO_SNAPSHOT) return w;
        }
        return EditingUtil.getWordAtCursorOrSelection(ic, selStart, selEnd, separators);
    }

    /** Separado para o Android 8 a 11 nunca carregar SurroundingText (API 31). */
    static final class Api31 {
        private Api31() { }

        static EditingUtil.SelectedWord wordAt(InputConnection ic, int selStart, int selEnd, String separators) {
            SurroundingText st;
            try {
                st = ic.getSurroundingText(REACH, REACH, 0);
            } catch (RuntimeException e) {
                return NO_SNAPSHOT;
            }
            if (st == null) return NO_SNAPSHOT;
            return fromSnapshot(st.getText(), st.getSelectionStart(), st.getSelectionEnd(), st.getOffset(),
                    selStart, selEnd, separators);
        }
    }

    /**
     * Acha a palavra dentro do retrato do texto. text = o texto lido; s/e = a seleção dentro dele (pode
     * vir invertida); offset = onde o texto começa no editor (-1 se o editor não sabe; aí a posição
     * sai da última seleção guardada, cachedStart/cachedEnd).
     */
    static EditingUtil.SelectedWord fromSnapshot(CharSequence text, int s, int e, int offset,
            int cachedStart, int cachedEnd, String separators) {
        if (text == null) return NO_SNAPSHOT;
        int n = text.length();
        if (s > e) { int t = s; s = e; e = t; }
        if (s < 0 || e > n) return NO_SNAPSHOT;
        int base = offset >= 0 ? offset : Math.min(cachedStart, cachedEnd) - s;
        if (base < 0) return NO_SNAPSHOT;
        int a, b;
        if (s == e) {
            a = s;
            while (a > 0 && !isSeparator(text.charAt(a - 1), separators)) a--;
            b = e;
            while (b < n && !isSeparator(text.charAt(b), separators)) b++;
            if (a == b) return null;
        } else {
            // seleção: só vale se for uma palavra inteira (separador ou borda do texto de cada lado,
            // nenhum separador dentro)
            if (s == 0 ? offset > 0 : !isSeparator(text.charAt(s - 1), separators)) return null;
            if (e < n && !isSeparator(text.charAt(e), separators)) return null;
            for (int i = s; i < e; i++) {
                if (isSeparator(text.charAt(i), separators)) return null;
            }
            a = s;
            b = e;
        }
        EditingUtil.SelectedWord w = new EditingUtil.SelectedWord();
        w.word = text.subSequence(a, b).toString();
        w.start = base + a;
        w.end = base + b;
        return w;
    }

    private static boolean isSeparator(char c, String separators) {
        return separators.indexOf(c) >= 0;
    }

    // ------------------------------------------------------------------ faixa da palavra reaberta

    /**
     * A palavra reaberta é uma palavra do dicionário (como está ou em minúsculas)? Se for, a faixa a mostra no
     * centro, como na digitação ("gato" no meio e "fato", "gatos" nos lados); se não for, no centro fica a
     * melhor correção. Sem isso, as teclas vizinhas faziam "fato" tomar o centro de uma palavra certa (1.75).
     */
    static boolean isValid(Suggest suggest, CharSequence word) {
        if (suggest == null || word == null || word.length() == 0) return false;
        try {
            String w = word.toString();
            return suggest.isValidWord(w) || suggest.isValidWord(w.toLowerCase());
        } catch (RuntimeException e) {
            return false;
        }
    }

    // ------------------------------------------------------------------ palavra reaberta com teclas vizinhas

    /** Tamanho do vetor de códigos da digitação (ProximityKeyDetector.getMaxNearbyKeys). */
    static final int NEARBY = 12;

    /**
     * A palavra como se tivesse sido digitada agora: cada letra leva, depois dela, as teclas vizinhas do
     * teclado atual, da mais perto para a mais longe (o mesmo que o ProximityKeyDetector faz no toque,
     * com o centro da tecla no lugar do dedo). Sem teclado de letras na tela, só as letras.
     */
    static WordComposer composer(KeyboardSwitcher switcher, CharSequence word) {
        WordComposer wc = new WordComposer();
        Keyboard kb = null;
        List<Keyboard.Key> keys = null;
        try {
            LatinKeyboardView view = switcher != null ? switcher.getInputView() : null;
            kb = view != null ? view.getKeyboard() : null;
            keys = kb != null ? kb.getKeys() : null;
        } catch (RuntimeException e) {
            kb = null;
            keys = null;
        }
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            wc.add(c, codesFor(kb, keys, c));
        }
        wc.setFirstCharCapitalized(word.length() > 0 && Character.isUpperCase(word.charAt(0)));
        return wc;
    }

    /** [c, vizinhas da mais perto à mais longe, -1 ...], com NEARBY posições. */
    static int[] codesFor(Keyboard kb, List<Keyboard.Key> keys, char c) {
        int[] codes = new int[NEARBY];
        Arrays.fill(codes, -1);
        codes[0] = c;
        if (kb == null || keys == null) return codes;
        try {
            Keyboard.Key key = keyFor(keys, c);
            if (key == null) return codes;
            int cx = key.x + key.width / 2;
            int cy = key.y + key.height / 2;
            int[] near = kb.getNearestKeys(cx, cy);
            if (near == null) return codes;
            int reach = (int) (1.4f * key.width);
            reach *= reach;
            int[] dist = new int[NEARBY];
            int n = 1;
            char base = MrText.base(c);
            for (int idx : near) {
                if (idx < 0 || idx >= keys.size()) continue;
                Keyboard.Key k = keys.get(idx);
                if (k == key || k.codes == null || k.codes.length == 0) continue;
                int code = k.codes[0];
                if (code <= 32 || MrText.base(code) == base) continue;
                int d = k.squaredDistanceFrom(cx, cy);
                if (d > reach) continue;
                boolean seen = false;
                for (int j = 1; j < n; j++) {
                    if (MrText.base(codes[j]) == MrText.base(code)) { seen = true; break; }
                }
                if (seen) continue;
                int at = n < NEARBY ? n : NEARBY - 1;
                if (n >= NEARBY && dist[at] <= d) continue;
                while (at > 1 && dist[at - 1] > d) {
                    codes[at] = codes[at - 1];
                    dist[at] = dist[at - 1];
                    at--;
                }
                codes[at] = code;
                dist[at] = d;
                if (n < NEARBY) n++;
            }
        } catch (RuntimeException e) {
            // fica o que já foi montado
        }
        return codes;
    }

    /** A tecla da letra c (sem acento nem caixa) no teclado, ou null (teclado de símbolos, p. ex.). */
    private static Keyboard.Key keyFor(List<Keyboard.Key> keys, char c) {
        char base = MrText.base(c);
        for (int i = 0, n = keys.size(); i < n; i++) {
            Keyboard.Key k = keys.get(i);
            if (k.codes == null || k.codes.length == 0 || k.codes[0] <= 32) continue;
            if (k.codes[0] == c || MrText.base(k.codes[0]) == base) return k;
        }
        return null;
    }
}
