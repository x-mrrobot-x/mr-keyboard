package com.mrkeyboard.app;

import java.nio.ByteBuffer;

/**
 * Motor nativo (v1.77, etapa 1): a busca de correção do MrFuzzy e a consulta de trigramas do MrTrigram
 * feitas em C++ (libmrengine.so, repositório mr-engine). Esta classe só carrega a lib, entrega os custos e as
 * regras e faz a ponte; quem decide é o Java:
 *   - sem a lib (não copiada para lib/<abi>/, ABI sem ela, versão do contrato diferente, qualquer erro ao
 *     carregar) tudo segue pelo código Java de antes, sem aviso e sem perda de função;
 *   - a fonte da verdade dos custos, das regras e das tabelas de letras continua no Java: aqui eles são
 *     entregues à lib uma vez (init) ou quando o pacote de idioma muda (regras);
 *   - o resultado do caminho nativo é idêntico ao do Java (teste de paridade: docs/tools/e2e/NativeParity.java).
 *
 * Desligar de propósito (testes): -Dmr.native=off, ou MrNative.sForceJava = true.
 */
public final class MrNative {
    private MrNative() { }

    /** Contrato com a lib: igual a mr::kEngineVersion em mr_engine.h do mr-engine. Sobe junto com ele. */
    static final int ENGINE_VERSION = 1;

    /** Caracteres de cada resultado no buffer de saída (palavra + espaço + palavra): igual a kResultChars. */
    static final int RESULT_CHARS = MrFuzzy.MAX_WORD * 2 + 2;
    /** Tamanho de outInfo: nós visitados + (tamanho, custo) de cada resultado. */
    static final int INFO_SIZE = 1 + 2 * MrFuzzy.MAX_RESULTS;

    private static final int UNKNOWN = 0;
    private static final int READY = 1;
    private static final int OFF = -1;

    private static volatile int sState = UNKNOWN;
    private static boolean sPreloading;
    private static MrRules sPushed;

    /** Testes e diagnóstico: true faz tudo passar pelo Java mesmo com a lib carregada. */
    static volatile boolean sForceJava;

    /** A lib está carregada, na versão certa e com as tabelas entregues? */
    static boolean ready() {
        if (sForceJava) return false;
        int s = sState;
        if (s == UNKNOWN) return load();
        return s == READY;
    }

    /**
     * Para a digitação: nunca espera a carga. Se ainda não tentou carregar a lib, dispara a carga em segundo plano e
     * responde false (esta consulta segue pelo Java, que dá o mesmo resultado); as próximas já usam a lib.
     */
    private static boolean readyNow() {
        if (sForceJava) return false;
        int s = sState;
        if (s == READY) return true;
        if (s == UNKNOWN) preload();
        return false;
    }

    private static synchronized void preload() {
        if (sPreloading || sState != UNKNOWN) return;
        sPreloading = true;
        Thread t = new Thread(new Runnable() {
            public void run() {
                load();
            }
        }, "MrNative");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
    }

    private static synchronized boolean load() {
        if (sState != UNKNOWN) return sState == READY;
        boolean ok = false;
        try {
            if (!"off".equals(System.getProperty("mr.native"))) {
                System.loadLibrary("mrengine");
                ok = nVersion() == ENGINE_VERSION && init();
            }
        } catch (Throwable e) {
            ok = false;   // UnsatisfiedLinkError (lib ausente ou JNI_OnLoad falhou) e qualquer outra coisa
        }
        sState = ok ? READY : OFF;
        return ok;
    }

    /** Custos e limites, na ordem de Costs em mr_engine.h. */
    static int[] costs() {
        return new int[] {
            MrFuzzy.C_PROX_1, MrFuzzy.C_PROX_2, MrFuzzy.C_PROX_FAR, MrFuzzy.C_DEL_FIRST, MrFuzzy.C_PHON,
            MrFuzzy.C_VOWEL, MrFuzzy.C_SUB, MrFuzzy.C_INS, MrFuzzy.C_INS_DOUBLE, MrFuzzy.C_INS_H,
            MrFuzzy.C_INS_NEAR, MrFuzzy.C_DEL, MrFuzzy.C_DEL_DOUBLE, MrFuzzy.C_TRANS, MrFuzzy.C_MULTI,
            MrFuzzy.C_SPLIT, MrFuzzy.NODE_BUDGET
        };
    }

    /** Character.toLowerCase de U+0000 a U+FFFF (a lib não tem tabela de Unicode própria). */
    static char[] lowerTable() {
        char[] t = new char[65536];
        for (int i = 0; i < 65536; i++) t[i] = Character.toLowerCase((char) i);
        return t;
    }

    /** Character.isUpperCase de U+0000 a U+FFFF (1 = maiúscula). */
    static byte[] upperTable() {
        byte[] t = new byte[65536];
        for (int i = 0; i < 65536; i++) t[i] = (byte) (Character.isUpperCase((char) i) ? 1 : 0);
        return t;
    }

    /** MrText.base de 0 a 255. */
    static char[] baseTable() {
        char[] t = new char[256];
        for (int i = 0; i < 256; i++) t[i] = MrText.base(i);
        return t;
    }

    /** O Java pontua com Math.pow(2.0, -custo / 25.0): a lib usa estes valores para arredondar igual. */
    static double[] powTable() {
        double[] t = new double[256];
        for (int i = 0; i < 256; i++) t[i] = Math.pow(2.0, -i / 25.0);
        return t;
    }

    private static boolean init() {
        return nInit(costs(), lowerTable(), upperTable(), baseTable(), powTable());
    }

    /** Grupos digitado (2 letras) -> dicionário (1): a, b, d de cada regra em sequência. */
    static char[] packT2(MrRules r) {
        char[] t = new char[r.t2a.length * 3];
        for (int i = 0; i < r.t2a.length; i++) {
            t[3 * i] = r.t2a[i]; t[3 * i + 1] = r.t2b[i]; t[3 * i + 2] = r.t2d[i];
        }
        return t;
    }

    /** Grupos dicionário (2 letras) -> digitado (1): p, c, t de cada regra em sequência. */
    static char[] packD2(MrRules r) {
        char[] t = new char[r.d2p.length * 3];
        for (int i = 0; i < r.d2p.length; i++) {
            t[3 * i] = r.d2p[i]; t[3 * i + 1] = r.d2c[i]; t[3 * i + 2] = r.d2t[i];
        }
        return t;
    }

    /** Letras mudas depois de outra: anterior e letra de cada regra em sequência (o custo vai em silCost). */
    static char[] packSil(MrRules r) {
        char[] t = new char[r.silPrev.length * 2];
        for (int i = 0; i < r.silPrev.length; i++) {
            t[2 * i] = r.silPrev[i]; t[2 * i + 1] = r.silChar[i];
        }
        return t;
    }

    private static boolean pushRules(MrRules r) {
        return nSetRules(r.pairs, packT2(r), packD2(r), packSil(r), r.silCost, r.silentStart, r.silentAny, r.extra,
                r.oneLetter);
    }

    /**
     * Busca de correção em C++. Devolve quantos resultados (0 a 5) foram escritos em outWords (resultado i a partir
     * de i * RESULT_CHARS), outInfo (0 = nós visitados; depois tamanho e custo de cada um) e outScores, ou -1 se
     * não foi possível (o chamador então usa o Java).
     */
    static int search(ByteBuffer dict, int size, int n, char[] tb, char[] near, int[] nearCount, MrRules rules,
                      char[] outWords, int[] outInfo, long[] outScores) {
        if (!readyNow() || dict == null || rules == null) return -1;
        try {
            synchronized (MrNative.class) {
                if (sPushed != rules) {
                    sPushed = null;
                    if (!pushRules(rules)) return -1;
                    sPushed = rules;
                }
            }
            return nSearch(dict, size, n, tb, near, nearCount, outWords, outInfo, outScores);
        } catch (Throwable e) {
            return -1;
        }
    }

    /** Abre o trigrams.bin na lib. false = não abriu (arquivo ruim ou sem lib): o MrTrigram usa o Java. */
    static boolean triOpen(String path) {
        if (!ready()) return false;
        try {
            return nTriOpen(path);
        } catch (Throwable e) {
            return false;
        }
    }

    static void triClose() {
        if (sState != READY) return;
        try {
            nTriClose();
        } catch (Throwable e) {
            // nada a fazer
        }
    }

    /** Continuações de (w1, w2) como em MrTrigram.find; a1/a2 são as grafias de w1 e b1/b2 as de w2. */
    static int triFind(String a1, String a2, String b1, String b2, String[] outWords, int[] outScores) {
        try {
            return nTriFind(a1, a2, b1, b2, outWords, outScores);
        } catch (Throwable e) {
            return 0;
        }
    }

    private static native int nVersion();

    private static native boolean nInit(int[] costs, char[] lower, byte[] upper, char[] base256, double[] pow2);

    private static native boolean nSetRules(byte[] pairs, char[] t2, char[] d2, char[] sil, short[] silCost,
                                            short[] silentStart, short[] silentAny, boolean[] extra, boolean[] oneLetter);

    private static native int nSearch(ByteBuffer dict, int size, int n, char[] tb, char[] near, int[] nearCount,
                                      char[] outWords, int[] outInfo, long[] outScores);

    private static native boolean nTriOpen(String path);

    private static native void nTriClose();

    private static native int nTriFind(String a1, String a2, String b1, String b2, String[] outWords, int[] outScores);
}
