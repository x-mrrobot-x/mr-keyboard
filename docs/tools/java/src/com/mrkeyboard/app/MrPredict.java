package com.mrkeyboard.app;

import android.view.inputmethod.InputConnection;

import java.util.ArrayList;
import java.util.List;

/**
 * Previsão da próxima palavra depois do espaço (v1.60). Lê a palavra antes do cursor e junta as
 * continuações do dicionário principal (bigramas do .dict, todas as iniciais) com as que o usuário
 * já escolheu (UserBigramDictionary). Até 3 previsões; a melhor vai para o centro da faixa.
 * Sem previsão, LatinIME.setNextSuggestions mostra a pontuação, como antes.
 *
 * Pontuação: freq do bigrama do dicionário (1-127) + 2 x freq do bigrama do usuário, para que o
 * hábito do usuário passe à frente depois de poucas escolhas.
 */
public final class MrPredict {
    private MrPredict() { }

    static final int MAX_WORD = 48;   // BinaryDictionary.MAX_WORD_LENGTH
    static final int MAX_BIGRAMS = 60; // BinaryDictionary.MAX_BIGRAMS
    static final int SHOW = 3;
    static final int LOOKBACK = 64;
    static final int USER_WEIGHT = 2;
    private static final int MAX_CAND = MAX_BIGRAMS * 4;

    private static final int[] sInitials = new int[96];
    private static int sInitialCount;
    private static final char[] sOut = new char[MAX_WORD * MAX_BIGRAMS];
    private static final int[] sFreq = new int[MAX_BIGRAMS];

    private static final String[] sWord = new String[MAX_CAND];
    private static final int[] sMain = new int[MAX_CAND];
    private static final int[] sUser = new int[MAX_CAND];
    private static int sCount;
    private static String sPrev;

    /** Coleta os bigramas do usuário (ExpandableDictionary.getBigrams chama addWord). */
    private static final class UserCollector implements Dictionary.WordCallback {
        UserCollector() { }

        public boolean addWord(char[] word, int offset, int length, int freq, int dicTypeId,
                Dictionary.DataType dataType) {
            if (word != null && length > 0 && freq > 0) {
                add(new String(word, offset, length), 0, freq);
            }
            return true;
        }
    }

    private static final UserCollector sUserCollector = new UserCollector();

    /**
     * Lista para a faixa (ordem: 2ª, 1ª, 3ª; com 2: 2ª, 1ª; com 1: só ela), ou null se não houver
     * previsão. Nunca lança exceção.
     */
    public static List<CharSequence> list(Suggest suggest, InputConnection ic) {
        try {
            if (suggest == null || ic == null) return null;
            CharSequence before = ic.getTextBeforeCursor(LOOKBACK, 0);
            String prev = MrText.lastWord(before);
            if (prev == null) return null;
            return forWord(suggest, prev);
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** As previsões para a palavra anterior, já na ordem da faixa. */
    static synchronized List<CharSequence> forWord(Suggest suggest, String prev) {
        sCount = 0;
        sPrev = prev;
        String lower = prev.toLowerCase();
        boolean hasLower = !lower.equals(prev);
        BinaryDictionary main = suggest.mrMainDict();
        if (main != null) {
            if (sInitialCount == 0) sInitialCount = MrText.allInitials(sInitials);
            mainBigrams(main, prev);
            if (hasLower && main.isValidWord(lower)) mainBigrams(main, lower);
        }
        Dictionary user = suggest.mrUserBigrams();
        if (user != null) {
            user.getBigrams(null, prev, sUserCollector, null);
            if (hasLower) user.getBigrams(null, lower, sUserCollector, null);
        }
        if (sCount == 0) return null;
        // 3 melhores
        int[] best = {-1, -1, -1};
        for (int i = 0; i < sCount; i++) {
            int s = score(i);
            for (int k = 0; k < SHOW; k++) {
                if (best[k] < 0 || s > score(best[k])) {
                    for (int m = SHOW - 1; m > k; m--) best[m] = best[m - 1];
                    best[k] = i;
                    break;
                }
            }
        }
        ArrayList<CharSequence> out = new ArrayList<CharSequence>(SHOW);
        if (best[1] >= 0) out.add(sWord[best[1]]);
        out.add(sWord[best[0]]);
        if (best[2] >= 0) out.add(sWord[best[2]]);
        return out;
    }

    private static int score(int i) {
        return sMain[i] + USER_WEIGHT * sUser[i];
    }

    private static void mainBigrams(BinaryDictionary main, String prev) {
        char[] p = prev.toCharArray();
        main.mrBigrams(p, sInitials, sInitialCount, sOut, sFreq);
        for (int i = 0; i < MAX_BIGRAMS; i++) {
            int f = sFreq[i];
            if (f <= 0) break;
            int off = i * MAX_WORD;
            int len = 0;
            while (len < MAX_WORD && sOut[off + len] != 0) len++;
            if (len > 0) add(new String(sOut, off, len), f, 0);
        }
    }

    private static void add(String w, int mainFreq, int userFreq) {
        if (w.equalsIgnoreCase(sPrev)) return;
        for (int i = 0; i < sCount; i++) {
            if (sWord[i].equals(w)) {
                if (mainFreq > sMain[i]) sMain[i] = mainFreq;
                if (userFreq > sUser[i]) sUser[i] = userFreq;
                return;
            }
        }
        if (sCount >= MAX_CAND) return;
        sWord[sCount] = w;
        sMain[sCount] = mainFreq;
        sUser[sCount] = userFreq;
        sCount++;
    }
}
