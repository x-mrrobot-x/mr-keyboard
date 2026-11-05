package com.mrkeyboard.app;
import java.nio.ByteBuffer;
import java.util.Set;
/** Test version: the .dict buffer and isValidWord by set. */
public class BinaryDictionary extends Dictionary {
    final ByteBuffer buf; final int len; final Set<String> words;
    public BinaryDictionary(ByteBuffer b, int l, Set<String> w) { buf = b; len = l; words = w; }
    public ByteBuffer mrBuffer() { return buf; }
    public int mrLength() { return len; }
    public int mrBigrams(char[] prevWord, int[] codes, int codeCount, char[] outChars, int[] outFreqs) { return 0; }
    public void getWords(WordComposer composer, WordCallback callback, int[] next) { }
    public boolean isValidWord(CharSequence word) { return words.contains(word.toString()); }
}
