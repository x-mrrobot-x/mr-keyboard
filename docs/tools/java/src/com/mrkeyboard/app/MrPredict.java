package com.mrkeyboard.app;

import android.content.Context;
import android.view.inputmethod.InputConnection;

import java.util.ArrayList;
import java.util.List;

/**
 * Previsão da próxima palavra (v1.60, v1.62). Junta:
 *  - as continuações das DUAS palavras anteriores (MrTrigram, quando o contexto existe);
 *  - as continuações da última palavra no dicionário principal (bigramas do .dict);
 *  - as do usuário (UserBigramDictionary, já na escala de MrText.userBigramScore).
 * No começo do texto ou depois de . ! ? mostra as palavras que mais abrem frase (do pacote,
 * [sentence_start] do rules.txt). Sem dicionário do idioma, mostra o item "Baixar dicionário"
 * (MrPacks.offerList), que abre a tela de dicionários.
 * Até 3 previsões; a melhor vai para o centro da faixa. Sem previsão (depois de vírgula, número),
 * LatinIME.setNextSuggestions mostra a pontuação, como antes.
 */
public final class MrPredict {
    private MrPredict() { }

    static final int MAX_WORD = 48;   // BinaryDictionary.MAX_WORD_LENGTH
    static final int MAX_BIGRAMS = 60; // BinaryDictionary.MAX_BIGRAMS
    static final int SHOW = 3;
    static final int LOOKBACK = 96;
    /** Continuação de duas palavras vale mais que a de uma (é o contexto mais específico). */
    static final int TRIGRAM_BONUS = 128;
    private static final int MAX_CAND = MAX_BIGRAMS * 4 + 8;

    private static final int[] sInitials = new int[96];
    private static int sInitialCount;
    private static final char[] sOut = new char[MAX_WORD * MAX_BIGRAMS];
    private static final int[] sFreq = new int[MAX_BIGRAMS];
    private static final String[] sTriWords = new String[3];
    private static final int[] sTriScores = new int[3];

    private static final String[] sWord = new String[MAX_CAND];
    private static final int[] sMain = new int[MAX_CAND];
    private static final int[] sUser = new int[MAX_CAND];
    private static int sCount;
    private static String sPrev;

    /** Contexto da última previsão, para a 1ª letra da palavra seguinte. */
    private static String sCtx1;
    private static String sCtx2;

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
    public static List<CharSequence> list(Context context, Suggest suggest, InputConnection ic) {
        try {
            if (suggest == null || ic == null) return null;
            if (!suggest.hasMainDictionary()) return MrPacks.offerList(context);
            CharSequence before = ic.getTextBeforeCursor(LOOKBACK, 0);
            if (MrText.atSentenceStart(before)) {
                sCtx1 = null;
                sCtx2 = null;
                MrRecent.breakPair();   // v1.75: a frase nova não forma par com a anterior
                String[] starters = MrRules.get().starters;
                if (starters.length == 0) return null;
                // rules.txt lista da mais provável para a menos; na faixa: 2ª, 1ª (centro), 3ª
                ArrayList<CharSequence> out = new ArrayList<CharSequence>(SHOW);
                if (starters.length >= 2) out.add(starters[1]);
                out.add(starters[0]);
                if (starters.length >= 3) out.add(starters[2]);
                return out;
            }
            String[] two = MrText.lastTwoWords(before);
            if (two == null) {
                sCtx1 = null;
                sCtx2 = null;
                return null;
            }
            return forWords(suggest, two[0], two[1]);
        } catch (RuntimeException e) {
            return null;
        }
    }

    /** As previsões para a palavra anterior (sem contexto de duas palavras). */
    static List<CharSequence> forWord(Suggest suggest, String prev) {
        return forWords(suggest, null, prev);
    }

    /** As previsões para (penúltima, última), já na ordem da faixa. */
    static synchronized List<CharSequence> forWords(Suggest suggest, String prev2, String prev) {
        sCount = 0;
        sPrev = prev;
        sCtx1 = prev2;
        sCtx2 = prev;
        String lower = prev.toLowerCase();
        boolean hasLower = !lower.equals(prev);
        if (prev2 != null) {
            int n = MrTrigram.find(prev2, prev, sTriWords, sTriScores);
            for (int i = 0; i < n; i++) add(sTriWords[i], TRIGRAM_BONUS + sTriScores[i], 0);
        }
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
        // v1.75: o que foi escrito há pouco nesta conversa: pares recentes entram como candidatos e quem já é
        // candidato e foi digitado há pouco sobe
        String[] after = MrRecent.nextAfter(prev, 2);
        for (int i = 0; i < after.length; i++) add(after[i], 0, MrRecent.PAIR_SCORE - 5 * i);
        for (int i = 0; i < sCount; i++) {
            int bonus = MrRecent.bonus(sWord[i]);
            if (bonus > 0) sUser[i] += bonus;
        }
        if (sCount == 0) return null;
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

    /**
     * Suggest, 1ª letra: acrescenta as continuações de duas palavras que começam pela letra
     * digitada (como bigramas de prioridade alta). Só vale se a palavra anterior é a mesma da última
     * previsão (o contexto foi lido do texto naquele momento).
     */
    public static void firstLetter(Suggest suggest, WordComposer composer, CharSequence prev) {
        try {
            String c1 = sCtx1, c2 = sCtx2;
            if (suggest == null || composer == null) return;
            // v1.75: palavras recentes que começam pela letra digitada
            MrRecent.complete(suggest, composer);
            if (prev == null || c1 == null || c2 == null) return;
            if (composer.size() != 1 || !c2.equalsIgnoreCase(prev.toString())) return;
            int typed = composer.getTypedWord().charAt(0);
            String[] w = new String[3];
            int[] f = new int[3];
            int n;
            synchronized (MrPredict.class) {
                n = MrTrigram.find(c1, c2, w, f);
            }
            for (int i = 0; i < n; i++) {
                if (!MrText.sameInitial(w[i], typed)) continue;
                char[] c = w[i].toCharArray();
                suggest.addWord(c, 0, c.length, 127, 1, Dictionary.DataType.BIGRAM);
            }
        } catch (RuntimeException e) {
            // a 1ª letra continua com os bigramas
        }
    }

    private static int score(int i) {
        return sMain[i] + sUser[i];
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
