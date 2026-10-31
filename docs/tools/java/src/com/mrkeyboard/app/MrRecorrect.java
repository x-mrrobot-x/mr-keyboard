package com.mrkeyboard.app;

import android.os.Build;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.SurroundingText;

/**
 * Recorreção (v1.74, "Tocar para corrigir palavras"): acha a palavra sob o cursor e decide se ela
 * merece sugestões. LatinIME.setOldSuggestions chama {@link #wordAt} e {@link #eligible}.
 *
 * Antes o método só mostrava sugestões de palavras que o dicionário já conhecia ou que tinham sido
 * digitadas na sessão; uma palavra errada fora disso (a que mais precisa de correção) ficava sem nada.
 * Agora toda palavra com letras serve; só ficam de fora o que não é palavra para corrigir.
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
}
