package com.mrkeyboard.app;

import java.nio.ByteBuffer;

/**
 * Cópia SÓ das declarações nativas de MrNative.java do app (docs/tools/java/src/com/mrkeyboard/app/MrNative.java).
 * Serve para o JniSmoke provar que as assinaturas registradas em mr_jni.cpp (RegisterNatives) batem com o Java.
 * Se mudar uma assinatura, mude aqui, em mr_jni.cpp e no app, e suba kEngineVersion / ENGINE_VERSION.
 */
final class MrNative {
    static native int nVersion();

    static native boolean nInit(int[] costs, char[] lower, byte[] upper, char[] base256, double[] pow2);

    static native boolean nSetRules(byte[] pairs, char[] t2, char[] d2, char[] sil, short[] silCost,
                                    short[] silentStart, short[] silentAny, boolean[] extra, boolean[] oneLetter);

    static native int nSearch(ByteBuffer dict, int size, int n, char[] tb, char[] near, int[] nearCount,
                              char[] outWords, int[] outInfo, long[] outScores);

    static native boolean nTriOpen(String path);

    static native void nTriClose();

    static native int nTriFind(String a1, String a2, String b1, String b2, String[] outWords, int[] outScores);
}
