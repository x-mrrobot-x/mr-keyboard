package com.mrkeyboard.app;

import java.util.Arrays;

/**
 * Palavras recentes (v1.75): o que você acabou de digitar na conversa (nomes, o assunto) ganha peso nas
 * sugestões. Só na memória (nada vai para o disco), só neste campo de texto e apagado quando o campo ou o
 * aplicativo muda ({@link #onField}); não anota em campo de senha nem no modo anônimo (quem chama é o mesmo
 * gancho que já respeita isso, LatinIME.checkAddToDictionary).
 *
 * Três usos, todos com a lista curta dos últimos {@link #CAP} termos, do mais novo ao mais velho:
 *  1) completar enquanto digita: a palavra recente que começa pelo que foi digitado entra na lista
 *     ({@link #complete}); é o que faz "Mar" sugerir "Maria" na 2ª vez, sem esperar o aprendizado;
 *  2) previsão depois do espaço: quem já é candidato e foi digitado há pouco sobe ({@link #bonus});
 *  3) pares recentes: se você escreveu "reunião de amanhã", depois de "reunião de" vem "amanhã" ({@link #nextAfter}).
 */
public final class MrRecent {
    private MrRecent() { }

    /** Quantos termos guardar. */
    static final int CAP = 96;
    static final int MIN_LEN = 3;
    static final int MAX_LEN = 30;

    /** Previsão: bônus (na escala do MrPredict) de uma palavra candidata digitada agora há pouco; cai com a idade. */
    static final int PRED_BOOST = 40;
    /** Previsão: pontos de um par recente (palavra anterior -> esta) que entra como candidato. 0 = desligado. */
    static final int PAIR_SCORE = 70;
    /**
     * Palavra que o dicionário não conhece e foi escrita só em minúsculas: 1 = anota; 0 = ignora. Ela quase
     * sempre é erro de digitação ("obrogado"), e anotá-lo faria o teclado oferecer o erro de volta; nome,
     * marca e sigla vêm com maiúscula ("Maria", "iPhone", "NASA") e entram sempre.
     */
    static final int OOV_LOWER = 0;
    /** Completar: "frequência de dicionário" de uma palavra recente (0 a 255; cai com a idade). 0 = desligado. */
    static final int COMP_V = 200;
    /** Completar: quantas palavras recentes no máximo entram por consulta. */
    static final int COMP_MAX = 2;
    /** Com 1 letra digitada (a lista é a de bigramas): quantas e com que prioridade (0 a 127). 0 = desligado. */
    static final int COMP1_MAX = 1;
    static final int COMP1_V = 60;
    /** Com 1 letra: 1 = qualquer palavra recente; 0 = só as que o dicionário não conhece (nomes, gírias). */
    static final int COMP1_ALL = 0;

    // mais novo primeiro: sShow[0] é a última palavra anotada
    private static final String[] sShow = new String[CAP];
    private static final String[] sKey = new String[CAP];
    /** true quando a palavra não é do dicionário (nome, gíria, termo raro). */
    private static final boolean[] sOov = new boolean[CAP];
    private static int sCount;
    // pares (anterior -> próxima), mais novo primeiro
    private static final String[] sPairPrev = new String[CAP];
    private static final String[] sPairNext = new String[CAP];
    private static int sPairCount;
    private static String sLastKey;
    private static String sPkg;
    private static int sField = -1;

    // ------------------------------------------------------------------ ciclo de vida

    /** Campo de texto novo (outro aplicativo ou outro campo): começa do zero. */
    public static synchronized void onField(String pkg, int fieldId) {
        boolean same = pkg != null && pkg.equals(sPkg) && fieldId == sField;
        sPkg = pkg;
        sField = fieldId;
        if (!same) clear();
    }

    public static synchronized void clear() {
        Arrays.fill(sShow, null);
        Arrays.fill(sKey, null);
        Arrays.fill(sPairPrev, null);
        Arrays.fill(sPairNext, null);
        sCount = 0;
        sPairCount = 0;
        sLastKey = null;
    }

    /** Fim de frase ou texto apagado: o próximo termo não forma par com o anterior. */
    public static synchronized void breakPair() {
        sLastKey = null;
    }

    // ------------------------------------------------------------------ anotar

    /**
     * Anota uma palavra que acabou de ser escrita. Palavra comum do dicionário vai em minúsculas (a caixa
     * se acerta na hora de mostrar); nome, gíria e termo raro ficam como foram digitados ("Maria", "iPhone").
     */
    public static synchronized void record(Suggest suggest, CharSequence word) {
        if (word == null) return;
        String w = word.toString().trim();
        int n = w.length();
        if (n < MIN_LEN || n > MAX_LEN) return;
        boolean letter = false;
        for (int i = 0; i < n; i++) {
            char c = w.charAt(i);
            if (Character.isDigit(c) || c == ' ') return;
            if (Character.isLetter(c)) letter = true;
        }
        if (!letter) return;
        String show = w;
        boolean oov = true;
        if (suggest != null) {
            String lower = w.toLowerCase();
            if (suggest.isValidWord(lower)) { show = lower; oov = false; }
            else if (suggest.isValidWord(w)) oov = false;
        }
        if (oov && OOV_LOWER == 0 && w.equals(w.toLowerCase())) return;
        String key = key(show);
        if (sLastKey != null) addPair(sLastKey, show);
        sLastKey = key;
        int at = -1;
        for (int i = 0; i < sCount; i++) {
            if (sKey[i].equals(key)) { at = i; break; }
        }
        if (at < 0) at = Math.min(sCount, CAP - 1);
        for (int i = at; i > 0; i--) {
            sShow[i] = sShow[i - 1];
            sKey[i] = sKey[i - 1];
            sOov[i] = sOov[i - 1];
        }
        sShow[0] = show;
        sKey[0] = key;
        sOov[0] = oov;
        if (at == sCount && sCount < CAP) sCount++;
    }

    private static void addPair(String prevKey, String next) {
        String nk = key(next);
        int at = -1;
        for (int i = 0; i < sPairCount; i++) {
            if (sPairPrev[i].equals(prevKey) && key(sPairNext[i]).equals(nk)) { at = i; break; }
        }
        if (at < 0) at = Math.min(sPairCount, CAP - 1);
        for (int i = at; i > 0; i--) {
            sPairPrev[i] = sPairPrev[i - 1];
            sPairNext[i] = sPairNext[i - 1];
        }
        sPairPrev[0] = prevKey;
        sPairNext[0] = next;
        if (at == sPairCount && sPairCount < CAP) sPairCount++;
    }

    /** Minúscula e sem acento: a comparação que o resto do motor usa. */
    static String key(CharSequence s) {
        char[] c = new char[s.length()];
        for (int i = 0; i < c.length; i++) c[i] = MrText.base(s.charAt(i));
        return new String(c);
    }

    // ------------------------------------------------------------------ usar

    /** Idade 0 (a mais nova) a CAP-1 vira um fator de 1 a 1/4. */
    private static int scaled(int max, int rank) {
        return max - (max * 3 / 4) * rank / (CAP - 1);
    }

    /** Previsão: bônus da palavra se ela foi digitada há pouco; 0 se não. */
    static synchronized int bonus(String word) {
        if (PRED_BOOST <= 0 || sCount == 0) return 0;
        String k = key(word);
        for (int i = 0; i < sCount; i++) {
            if (sKey[i].equals(k)) return scaled(PRED_BOOST, i);
        }
        return 0;
    }

    /** Previsão: palavras que vieram logo depois de prev nesta conversa, a mais nova primeiro (até max). */
    static synchronized String[] nextAfter(String prev, int max) {
        if (PAIR_SCORE <= 0 || sPairCount == 0 || prev == null) return EMPTY;
        String k = key(prev);
        String[] out = new String[max];
        int n = 0;
        for (int i = 0; i < sPairCount && n < max; i++) {
            if (sPairPrev[i].equals(k)) out[n++] = sPairNext[i];
        }
        return n == 0 ? EMPTY : Arrays.copyOf(out, n);
    }

    static final String[] EMPTY = new String[0];

    /**
     * Completar: entrega ao Suggest as palavras recentes que começam pelo que foi digitado (sem acento nem
     * caixa), no máximo COMP_MAX. Com 1 letra a lista vai como bigrama (é o que o Suggest mostra nessa hora);
     * com 2 ou mais, como palavra do dicionário com a pontuação na escala da lib (frequência x 2^letras).
     */
    public static void complete(Suggest suggest, WordComposer composer) {
        if (COMP_V <= 0 || suggest == null || composer == null) return;
        try {
            CharSequence typed = composer.getTypedWord();
            int n = typed == null ? 0 : typed.length();
            if (n < 1 || n > 12) return;
            int max = n == 1 ? COMP1_MAX : COMP_MAX;
            if (max <= 0) return;
            String pre = key(typed);
            String[] pick = new String[max];
            int[] rank = new int[max];
            int found = 0;
            synchronized (MrRecent.class) {
                for (int i = 0; i < sCount && found < max; i++) {
                    String k = sKey[i];
                    if (k.length() > n && k.startsWith(pre) && (n > 1 || COMP1_ALL > 0 || sOov[i])) {
                        pick[found] = sShow[i];
                        rank[found] = i;
                        found++;
                    }
                }
            }
            for (int f = 0; f < found; f++) {
                char[] c = pick[f].toCharArray();
                if (n == 1) {
                    suggest.addWord(c, 0, c.length, Math.min(127, scaled(COMP1_V, rank[f])), 1, Dictionary.DataType.BIGRAM);
                } else {
                    suggest.addWord(c, 0, c.length, scaled(COMP_V, rank[f]) << Math.min(n, 16), 1, Dictionary.DataType.UNIGRAM);
                }
            }
        } catch (RuntimeException e) {
            // as sugestões seguem sem as palavras recentes
        }
    }
}
