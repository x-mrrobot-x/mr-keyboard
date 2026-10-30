package com.mrkeyboard.app;

/** Stub de compilação. Os métodos mr* são acrescentados à classe real no smali. */
public class BinaryDictionary extends Dictionary {
    public java.nio.ByteBuffer mrBuffer() { return null; }
    public int mrLength() { return 0; }
    public int mrBigrams(char[] prevWord, int[] codes, int codeCount, char[] outChars, int[] outFreqs) { return 0; }
    public void getWords(WordComposer composer, WordCallback callback, int[] nextLettersFrequencies) { }
    public boolean isValidWord(CharSequence word) { return false; }
}
