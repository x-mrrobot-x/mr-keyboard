package com.mrkeyboard.app;

/** Compile stub. The mr* methods are added to the real class in the smali. */
public class BinaryDictionary extends Dictionary {
    public BinaryDictionary(android.content.Context context, java.nio.ByteBuffer byteBuffer, int dicTypeId) { }
    public java.nio.ByteBuffer mrBuffer() { return null; }
    public int mrLength() { return 0; }
    public int mrBigrams(char[] prevWord, int[] codes, int codeCount, char[] outChars, int[] outFreqs) { return 0; }
    public void getWords(WordComposer composer, WordCallback callback, int[] nextLettersFrequencies) { }
    public boolean isValidWord(CharSequence word) { return false; }
    public int getSize() { return 0; }
    public synchronized void close() { }
}
