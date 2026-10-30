package com.mrkeyboard.app;

import java.nio.ByteBuffer;
import java.util.Arrays;

/**
 * Camada Java de reserva (v1.60): busca aproximada sobre o trie do .dict já carregado pela lib
 * nativa (mesmo ByteBuffer, sem cópia). Cobre o que a lib não faz: letra sobrando, letra faltando,
 * transposição, trocas fonéticas do pt-BR (inclusive 2 letras por 1, como ch/x e ss/ç) e espaço
 * faltando (porisso -> por isso).
 *
 * Formato lido (o mesmo de dictionary.cpp): grupo = [count] + entradas; entrada = char (1 byte ou
 * 0xFF + 2 bytes), flags/endereço (0x80 terminal, 0x40 com filhos + 22 bits), freq se terminal e,
 * no formato "latest" (byte 0 >= 200 e byte 1 em {0,1}), a lista de bigramas depois da freq.
 *
 * Busca: distância de edição com pesos (programação dinâmica linha a linha enquanto desce o trie),
 * podando quando o menor custo da linha passa do limite. A 1ª letra do dicionário precisa ser a
 * digitada, uma vizinha, um par fonético, a vogal trocada (e/i, o/u), um h mudo ou a 2ª letra
 * digitada: erros fora disso na 1ª letra são raros e abrir todas as iniciais custa 10 vezes mais.
 * Há um teto de nós visitados por consulta (NODE_BUDGET) para o pior caso.
 *
 * Pontuação na mesma escala da lib: freq * 2^(n+1) para acerto exato, e cada 0,25 de custo
 * divide por 2 (é o que a lib faz por tecla vizinha).
 */
public final class MrFuzzy {
    // custos (x100)
    static final int C_PROX = 25;
    static final int C_PHON = 25;
    static final int C_VOWEL = 45;
    static final int C_SUB = 75;
    static final int C_INS = 60;
    static final int C_INS_DOUBLE = 30;
    static final int C_INS_H = 40;
    static final int C_INS_NEAR = 45;
    static final int C_DEL = 60;
    static final int C_DEL_DOUBLE = 30;
    static final int C_DEL_H0 = 30;
    static final int C_DEL_U = 40;
    static final int C_DEL_H = 45;
    static final int C_TRANS = 40;
    static final int C_MULTI = 35;
    static final int C_SPLIT = 35;

    static final int MAX_TYPED = 20;
    static final int MIN_TYPED = 3;
    static final int MAX_EXTRA_DEPTH = 3;
    static final int MAX_RESULTS = 5;
    static final int NODE_BUDGET = 12000;
    static final int MAX_WORD = 48;

    private static final char[] BASE = new char[256];
    private static final char[] LOWER = new char[256];

    static {
        for (int c = 0; c < 256; c++) {
            BASE[c] = MrText.base(c);
            LOWER[c] = Character.toLowerCase((char) c);
        }
    }

    private static MrFuzzy sCache;
    /** Nós visitados na última consulta (testes). */
    static int sLastVisits;

    private final ByteBuffer mDict;
    private final int mSize;
    private final int mRoot;
    private final boolean mLatest;

    // estado da consulta
    private int mN;
    private final char[] mTb = new char[MAX_TYPED];
    private final char[][] mNear = new char[MAX_TYPED][16];
    private final int[] mNearCount = new int[MAX_TYPED];
    private final short[][] mSub = new short[MAX_TYPED][256];
    private final int[] mIns = new int[MAX_TYPED];
    private final boolean[] mFirst = new boolean[256];
    private final boolean[] mTwoX = new boolean[MAX_TYPED + 1];
    private final boolean[] mTwoC = new boolean[MAX_TYPED + 1];
    private final int[][] mRows = new int[MAX_TYPED + MAX_EXTRA_DEPTH + 2][MAX_TYPED + 1];
    private final char[] mPath = new char[MAX_WORD + 2];
    private int mMaxCost;
    private int mBand;
    private int mVisits;
    static final int INF = 1 << 20;
    /** Na raiz: 1 = só a inicial digitada, 2 = só as outras iniciais aceitas, 0 = todas. */
    private int mOnlyTyped;

    // melhores resultados
    private final char[][] mResWord = new char[MAX_RESULTS][MAX_WORD * 2 + 2];
    private final int[] mResLen = new int[MAX_RESULTS];
    private final long[] mResScore = new long[MAX_RESULTS];
    private int mResCount;

    MrFuzzy(ByteBuffer dict, int size) {
        mDict = dict;
        mSize = size;
        boolean latest = false;
        if (size > 2) {
            int v = dict.get(0) & 0xFF;
            int b = dict.get(1) & 0xFF;
            latest = v >= 200 && (b == 0 || b == 1);
        }
        mLatest = latest;
        mRoot = latest ? 2 : 0;
    }

    static synchronized MrFuzzy forDict(ByteBuffer dict, int size) {
        if (dict == null || size <= 2) return null;
        MrFuzzy f = sCache;
        if (f == null || f.mDict != dict || f.mSize != size) {
            f = new MrFuzzy(dict, size);
            sCache = f;
        }
        return f;
    }

    // ------------------------------------------------------------------ ponto de entrada (Suggest)

    /**
     * Chamado por Suggest.getSuggestions depois do dicionário principal. Acrescenta a correção do
     * mapa (MrFix) e, se a palavra digitada não for válida, os candidatos da busca aproximada.
     */
    public static void afterWords(Suggest suggest, WordComposer composer) {
        try {
            if (suggest == null || composer == null) return;
            int n = composer.size();
            if (n < 2 || n > MAX_TYPED) return;
            CharSequence typed = composer.getTypedWord();
            if (typed == null) return;
            String fix = MrFix.lookup(typed);
            if (fix != null) {
                char[] c = fix.toCharArray();
                suggest.addWord(c, 0, c.length, Integer.MAX_VALUE / 4, 1, Dictionary.DataType.UNIGRAM);
                return;
            }
            if (n < MIN_TYPED) return;
            if (suggest.isValidWord(typed)) return;
            BinaryDictionary main = suggest.mrMainDict();
            if (main == null) return;
            MrFuzzy f = forDict(main.mrBuffer(), main.mrLength());
            if (f == null) return;
            synchronized (f) {
                f.search(composer, typed);
                f.emit(suggest);
            }
        } catch (RuntimeException e) {
            // nunca derrubar a digitação por causa da camada de reserva
        }
    }

    // ------------------------------------------------------------------ busca

    int resultCount() { return mResCount; }
    String resultWord(int i) { return new String(mResWord[i], 0, mResLen[i]); }
    long resultScore(int i) { return mResScore[i]; }

    void search(WordComposer composer, CharSequence typed) {
        int n = Math.min(typed.length(), MAX_TYPED);
        mN = n;
        for (int j = 0; j < n; j++) {
            mTb[j] = MrText.base(typed.charAt(j));
            int cnt = 0;
            int[] codes = composer != null ? composer.getCodesAt(j) : null;
            if (codes != null) {
                for (int k = 1; k < codes.length && cnt < 16; k++) {
                    int code = codes[k];
                    if (code <= 0) break;
                    char b = MrText.base(code);
                    if (b != mTb[j]) mNear[j][cnt++] = b;
                }
            }
            mNearCount[j] = cnt;
            Arrays.fill(mSub[j], (short) -1);
        }
        for (int j = 0; j < n; j++) mIns[j] = insCost(j);
        for (int j = 2; j <= n; j++) {
            char a = mTb[j - 2], b = mTb[j - 1];
            mTwoX[j] = (a == 'c' && b == 'h') || (a == 'k' && b == 's');
            mTwoC[j] = (a == 's' && (b == 's' || b == 'c')) || (a == 'x' && b == 'c');
        }
        firstLetters();
        mResCount = 0;
        mVisits = 0;
        int[] row0 = mRows[0];
        row0[0] = 0;
        for (int j = 1; j <= n; j++) row0[j] = Math.min(INF, row0[j - 1] + mIns[j - 1]);
        // 1ª passada: um erro (custo de 1 letra a mais/a menos ou troca); quase todo erro de
        // digitação é assim e a busca é umas 5 vezes menor. Se a digitada ainda é começo de uma
        // palavra do dicionário, a pessoa provavelmente está no meio dela e os complementos da lib
        // já servem: com 4 letras só os erros baratos (letra dobrada, h, troca de lugar, fonética:
        // asim -> assim, omem -> homem), a partir de 5 a 1ª passada inteira (prota -> porta).
        boolean prefix = isPrefix();
        if (!prefix || n >= 4) {
            setMaxCost(prefix && n == 4 ? 40 : n <= 3 ? 45 : n == 4 ? 60 : 75);
            walkRoot();
            if (mResCount == 0 && !prefix && n >= 6) {
                // 2ª passada: até dois erros, para palavras mais longas
                setMaxCost(n <= 7 ? 100 : 120);
                walkRoot();
            }
        }
        sLastVisits = mVisits;
        if (n >= 4) split();
    }

    /**
     * Limite de custo e largura da faixa da programação dinâmica: com custo mínimo de 30 para
     * mudar o tamanho (letra dobrada, h, 2 por 1), a coluna j só pode ficar dentro do limite se
     * |profundidade - j| <= limite / 30. Fora da faixa a célula vale INF.
     */
    private void setMaxCost(int max) {
        mMaxCost = max;
        mBand = max / 30;
    }

    /** Raiz em duas voltas: primeiro a inicial digitada, depois as outras aceitas. */
    private void walkRoot() {
        mOnlyTyped = 1;
        walk(mRoot, 0, 0, (char) 0);
        if (mVisits > NODE_BUDGET) return;
        mOnlyTyped = 2;
        walk(mRoot, 0, 0, (char) 0);
        mOnlyTyped = 0;
    }

    /** A digitada (sem acento/caixa) é o começo de alguma palavra do dicionário? */
    private boolean isPrefix() {
        return prefixRec(mRoot, 0);
    }

    private boolean prefixRec(int pos, int j) {
        if (pos < 0 || pos >= mSize) return false;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        char want = mTb[j];
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return false;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return false;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + 2 >= mSize) return false;
                child = ((flags & 0x3F) << 16) | ((mDict.get(pos + 1) & 0xFF) << 8) | (mDict.get(pos + 2) & 0xFF);
                pos += 3;
            } else {
                pos += 1;
            }
            if ((flags & 0x80) != 0) {
                if (pos >= mSize) return false;
                pos++;
                if (mLatest) pos = skipBigrams(pos);
            }
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (cb != want) continue;
            if (j + 1 == mN) {
                if (child != 0) return true;
            } else if (child != 0 && prefixRec(child, j + 1)) {
                return true;
            }
        }
        return false;
    }

    /** Iniciais aceitas para a palavra do dicionário. */
    private void firstLetters() {
        Arrays.fill(mFirst, false);
        char t = mTb[0];
        mFirst[t & 0xFF] = t < 256;
        for (int k = 0; k < mNearCount[0]; k++) {
            char c = mNear[0][k];
            if (c < 256) mFirst[c] = true;
        }
        for (char c = 'a'; c <= 'z'; c++) {
            if (phonetic(c, t)) mFirst[c] = true;
        }
        mFirst['h'] = true;
        if (t == 'e') mFirst['i'] = true;
        if (t == 'i') mFirst['e'] = true;
        if (t == 'o') mFirst['u'] = true;
        if (t == 'u') mFirst['o'] = true;
        if (t == 'c' && mN > 1 && mTb[1] == 'h') mFirst['x'] = true;
        if (t == 'x') mFirst['c'] = true;
        if (mN > 1 && mTb[1] < 256) mFirst[mTb[1]] = true;
    }

    private int sub(int j, int cb) {
        if (cb >= 256) return cb == mTb[j] ? 0 : C_SUB;
        short s = mSub[j][cb];
        if (s < 0) {
            s = (short) subCost((char) cb, j);
            mSub[j][cb] = s;
        }
        return s;
    }

    private void walk(int pos, int depth, int pcb, char parentRaw) {
        if (pos < 0 || pos >= mSize) return;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        int[] prev = mRows[depth];
        int[] prev2 = depth > 0 ? mRows[depth - 1] : null;
        int n = mN;
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            boolean terminal = (flags & 0x80) != 0;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + 2 >= mSize) return;
                child = ((flags & 0x3F) << 16) | ((mDict.get(pos + 1) & 0xFF) << 8) | (mDict.get(pos + 2) & 0xFF);
                pos += 3;
            } else {
                pos += 1;
            }
            int freq = 0;
            if (terminal) {
                if (pos >= mSize) return;
                freq = mDict.get(pos++) & 0xFF;
                if (mLatest) pos = skipBigrams(pos);
            }
            if (++mVisits > NODE_BUDGET) return;
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (depth == 0) {
                if (cb >= 256 || !mFirst[cb]) continue;
                if (mOnlyTyped == 1 && cb != mTb[0]) continue;
                if (mOnlyTyped == 2 && cb == mTb[0]) continue;
            }
            char raw = (char) c;
            char rl = c < 256 ? LOWER[c] : Character.toLowerCase(raw);
            int del = delCost(cb, pcb, depth);
            // o dicionário tem 2 letras (pai + esta) para 1 digitada? (x -> ch, ç -> ss/sc...)
            int d1 = -1, d2 = -1;
            if (prev2 != null) {
                char p = parentRaw < 256 ? LOWER[parentRaw] : Character.toLowerCase(parentRaw);
                if (p == 'c' && rl == 'h') d1 = 'x';
                else if (p == 's' && rl == 'c') { d1 = 'c'; d2 = 's'; }
                else if (p == 's' && rl == 's') d1 = 'c';
                else if (p == 'x' && rl == 'c') { d1 = 's'; d2 = 'c'; }
            }
            int[] cur = mRows[depth + 1];
            int r = depth + 1;
            int lo = r - mBand;
            int hi = r + mBand;
            if (hi > n) hi = n;
            int rowMin = INF;
            if (lo <= 0) {
                int best0 = prev[0] + del;
                if (best0 > INF) best0 = INF;
                cur[0] = best0;
                rowMin = best0;
                lo = 1;
            } else {
                cur[lo - 1] = INF;
            }
            if (hi + 1 <= n) cur[hi + 1] = INF;
            if (hi + 2 <= n) cur[hi + 2] = INF;
            for (int j = lo; j <= hi; j++) {
                int tj1 = mTb[j - 1];
                int best = prev[j - 1] + sub(j - 1, cb);
                int v = cur[j - 1] + mIns[j - 1];
                if (v < best) best = v;
                v = prev[j] + del;
                if (v < best) best = v;
                if (j >= 2) {
                    if (prev2 != null && cb == mTb[j - 2] && pcb == tj1 && cb != pcb) {
                        v = prev2[j - 2] + C_TRANS;
                        if (v < best) best = v;
                    }
                    if ((mTwoX[j] && rl == 'x') || (mTwoC[j] && rl == 'ç')) {
                        v = prev[j - 2] + C_MULTI;
                        if (v < best) best = v;
                    }
                }
                if (d1 >= 0 && (tj1 == d1 || tj1 == d2)) {
                    v = prev2[j - 1] + C_MULTI;
                    if (v < best) best = v;
                }
                if (best > INF) best = INF;
                cur[j] = best;
                if (best < rowMin) rowMin = best;
            }
            if (depth < MAX_WORD) mPath[depth] = raw;
            if (terminal && hi == n && cur[n] <= mMaxCost && depth + 1 <= MAX_WORD && freq > 0) {
                offer(mPath, depth + 1, freq, cur[n]);
            }
            if (child != 0 && rowMin <= mMaxCost && depth + 1 < n + mBand
                    && depth + 2 < mRows.length && depth + 1 < MAX_WORD) {
                walk(child, depth + 1, cb, raw);
                if (mVisits > NODE_BUDGET) return;
                // a recursão sobrescreveu mRows[depth + 2..]; mRows[depth + 1] é desta entrada
                prev = mRows[depth];
                prev2 = depth > 0 ? mRows[depth - 1] : null;
            }
        }
    }

    private int skipBigrams(int pos) {
        if (pos >= mSize) return pos;
        if ((mDict.get(pos) & 0x80) != 0) {
            int guard = 0;
            while (pos + 3 < mSize && guard++ < 10000) {
                pos += 3;
                int more = mDict.get(pos++) & 0x80;
                if (more == 0) break;
            }
            return pos;
        }
        return pos + 1;
    }

    private boolean isNear(int j, char cb) {
        char[] near = mNear[j];
        for (int k = mNearCount[j] - 1; k >= 0; k--) {
            if (near[k] == cb) return true;
        }
        return false;
    }

    private int subCost(char cb, int j) {
        char t = mTb[j];
        if (cb == t) return 0;
        if (isNear(j, cb)) return C_PROX;
        if (phonetic(cb, t)) return C_PHON;
        if ((cb == 'e' && t == 'i') || (cb == 'i' && t == 'e') || (cb == 'o' && t == 'u') || (cb == 'u' && t == 'o')) {
            return C_VOWEL;
        }
        return C_SUB;
    }

    private static boolean pair(char a, char b, char x, char y) {
        return (a == x && b == y) || (a == y && b == x);
    }

    static boolean phonetic(char a, char b) {
        return pair(a, b, 's', 'z') || pair(a, b, 's', 'c') || pair(a, b, 'c', 'k') || pair(a, b, 'k', 'q')
                || pair(a, b, 'g', 'j') || pair(a, b, 'x', 'z') || pair(a, b, 'x', 's') || pair(a, b, 'w', 'v')
                || pair(a, b, 'w', 'u') || pair(a, b, 'y', 'i') || pair(a, b, 'l', 'u') || pair(a, b, 'm', 'n');
    }

    /** Letra digitada a mais na posição j. */
    private int insCost(int j) {
        char t = mTb[j];
        if (j > 0 && mTb[j - 1] == t) return C_INS_DOUBLE;
        if (t == 'h') return C_INS_H;
        if (j > 0 && isNear(j - 1, t)) return C_INS_NEAR;
        if (j + 1 < mN && isNear(j + 1, t)) return C_INS_NEAR;
        return C_INS;
    }

    /** Letra do dicionário que não foi digitada. */
    private static int delCost(int cb, int pcb, int depth) {
        if (depth == 0 && cb == 'h') return C_DEL_H0;
        if (depth > 0 && cb == pcb) return C_DEL_DOUBLE;
        if (cb == 'u' && (pcb == 'q' || pcb == 'g')) return C_DEL_U;
        if (cb == 'h' && (pcb == 'c' || pcb == 'l' || pcb == 'n')) return C_DEL_H;
        return C_DEL;
    }

    private long scoreFor(int freq, int cost) {
        int n = Math.min(mN, 24);
        double base = (double) freq * (double) (1L << (n + 1));
        double s = base * Math.pow(2.0, -cost / 25.0);
        if (s > Integer.MAX_VALUE / 8) s = Integer.MAX_VALUE / 8;
        return (long) s;
    }

    private void offer(char[] word, int len, int freq, int cost) {
        long score = scoreFor(freq, cost);
        if (score <= 0) return;
        insert(word, 0, len, score);
    }

    private void insert(char[] word, int off, int len, long score) {
        // repetida? fica a de maior pontuação
        for (int i = 0; i < mResCount; i++) {
            if (mResLen[i] == len && same(mResWord[i], word, off, len)) {
                if (score <= mResScore[i]) return;
                remove(i);
                break;
            }
        }
        int at = mResCount;
        while (at > 0 && mResScore[at - 1] < score) at--;
        if (at >= MAX_RESULTS) return;
        int last = Math.min(mResCount, MAX_RESULTS - 1);
        for (int i = last; i > at; i--) {
            char[] tmp = mResWord[i];
            mResWord[i] = mResWord[i - 1];
            mResWord[i - 1] = tmp;
            mResLen[i] = mResLen[i - 1];
            mResScore[i] = mResScore[i - 1];
        }
        System.arraycopy(word, off, mResWord[at], 0, len);
        mResLen[at] = len;
        mResScore[at] = score;
        if (mResCount < MAX_RESULTS) mResCount++;
    }

    private void remove(int i) {
        char[] tmp = mResWord[i];
        for (int k = i; k < mResCount - 1; k++) {
            mResWord[k] = mResWord[k + 1];
            mResLen[k] = mResLen[k + 1];
            mResScore[k] = mResScore[k + 1];
        }
        mResWord[mResCount - 1] = tmp;
        mResCount--;
    }

    private static boolean same(char[] a, char[] b, int off, int len) {
        for (int i = 0; i < len; i++) if (a[i] != b[off + i]) return false;
        return true;
    }

    void emit(Dictionary.WordCallback cb) {
        for (int i = 0; i < mResCount; i++) {
            long s = mResScore[i];
            cb.addWord(mResWord[i], 0, mResLen[i], (int) Math.min(s, Integer.MAX_VALUE / 8), 1,
                    Dictionary.DataType.UNIGRAM);
        }
    }

    // ------------------------------------------------------------------ espaço faltando

    private final char[] mSplitBuf = new char[MAX_WORD * 2 + 2];
    private final char[] mLeftBuf = new char[MAX_WORD + 1];
    private final char[] mLookBuf = new char[MAX_WORD + 1];
    private final char[] mLookPath = new char[MAX_WORD + 1];
    private int mLookFreq;
    private int mLookLen;

    private void split() {
        int n = mN;
        long bestScore = 0;
        int bestLen = 0;
        for (int k = 1; k <= n - 2; k++) {
            if (k == 1 && !oneLetterWord(mTb[0])) continue;
            int fl = lookup(0, k);
            if (fl <= 0) continue;
            int leftLen = mLookLen;
            System.arraycopy(mLookBuf, 0, mLeftBuf, 0, leftLen);
            int fr = lookup(k, n);
            if (fr <= 0) continue;
            long score = scoreFor(Math.min(fl, fr), C_SPLIT);
            if (score > bestScore) {
                bestScore = score;
                System.arraycopy(mLeftBuf, 0, mSplitBuf, 0, leftLen);
                mSplitBuf[leftLen] = ' ';
                System.arraycopy(mLookBuf, 0, mSplitBuf, leftLen + 1, mLookLen);
                bestLen = leftLen + 1 + mLookLen;
            }
        }
        if (bestLen > 0) insert(mSplitBuf, 0, bestLen, bestScore);
    }

    private static boolean oneLetterWord(char b) {
        return b == 'a' || b == 'e' || b == 'o';
    }

    /** Procura mTb[from..to) no trie sem considerar acento; guarda em mLookBuf a grafia mais frequente. */
    private int lookup(int from, int to) {
        mLookFreq = 0;
        mLookLen = 0;
        if (to - from > MAX_WORD) return 0;
        lookupRec(mRoot, from, to, 0);
        return mLookFreq;
    }

    private void lookupRec(int pos, int j, int to, int depth) {
        if (pos < 0 || pos >= mSize) return;
        int count = mDict.get(pos) & 0xFF;
        pos++;
        char want = mTb[j];
        for (int i = 0; i < count; i++) {
            if (pos >= mSize) return;
            int c = mDict.get(pos++) & 0xFF;
            if (c == 0xFF) {
                if (pos + 1 >= mSize) return;
                c = ((mDict.get(pos) & 0xFF) << 8) | (mDict.get(pos + 1) & 0xFF);
                pos += 2;
            }
            int flags = mDict.get(pos) & 0xFF;
            boolean terminal = (flags & 0x80) != 0;
            int child = 0;
            if ((flags & 0x40) != 0) {
                if (pos + 2 >= mSize) return;
                child = ((flags & 0x3F) << 16) | ((mDict.get(pos + 1) & 0xFF) << 8) | (mDict.get(pos + 2) & 0xFF);
                pos += 3;
            } else {
                pos += 1;
            }
            int freq = 0;
            if (terminal) {
                if (pos >= mSize) return;
                freq = mDict.get(pos++) & 0xFF;
                if (mLatest) pos = skipBigrams(pos);
            }
            int cb = c < 256 ? BASE[c] : MrText.base(c);
            if (cb != want) continue;
            char raw = (char) c;
            mLookPath[depth] = raw;
            if (j + 1 == to) {
                if (terminal && freq > mLookFreq && !Character.isUpperCase(mLookPath[0])) {
                    mLookFreq = freq;
                    mLookLen = depth + 1;
                    System.arraycopy(mLookPath, 0, mLookBuf, 0, depth + 1);
                }
            } else if (child != 0) {
                lookupRec(child, j + 1, to, depth + 1);
            }
        }
    }
}
