package com.mrkeyboard.app;

import java.nio.ByteBuffer;

/**
 * COPY of ONLY the native declarations of the app's MrNative.java (docs/tools/java/src/com/mrkeyboard/app/MrNative.java).
 * It lets JniSmoke prove that the signatures registered in mr_jni.cpp (RegisterNatives) match the Java ones.
 * If a signature changes, change it here, in mr_jni.cpp and in the app, and raise kEngineVersion / ENGINE_VERSION.
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

    static native boolean nGestureOpen(String path);

    static native void nGestureClose();

    static native boolean nGestureConfig(float[] params, int[] limits);

    static native boolean nGestureLayout(char[] keys, float[] xy, char[] free);

    static native int nGesture(ByteBuffer dict, int size, int n, float[] x, float[] y, int[] t, char[] prev,
                               int[] prevLen, char[] outWords, int[] outInfo, float[] outScores);

    static native int nGestureMore(ByteBuffer dict, int size, char[] prev, int[] prevLen, char[] outWords, int[] outInfo,
                                   float[] outScores);
}
