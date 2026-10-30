package com.mrkeyboard.app;
public abstract class Dictionary {
    public interface WordCallback {
        boolean addWord(char[] word, int wordOffset, int wordLength, int frequency, int dicTypeId, DataType dataType);
    }
    public enum DataType { UNIGRAM, BIGRAM }
    public void getBigrams(WordComposer composer, CharSequence previousWord, WordCallback callback, int[] next) { }
    public abstract void getWords(WordComposer composer, WordCallback callback, int[] next);
    public abstract boolean isValidWord(CharSequence word);
}
