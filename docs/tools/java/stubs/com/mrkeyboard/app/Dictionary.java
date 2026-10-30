package com.mrkeyboard.app;

/** Stub de compilação: mesma assinatura da classe do APK (não vai para o dex). */
public abstract class Dictionary {
    public interface WordCallback {
        boolean addWord(char[] word, int wordOffset, int wordLength, int frequency, int dicTypeId,
                DataType dataType);
    }

    public enum DataType { UNIGRAM, BIGRAM }

    public void getBigrams(WordComposer composer, CharSequence previousWord, WordCallback callback,
            int[] nextLettersFrequencies) {
    }

    public abstract void getWords(WordComposer composer, WordCallback callback, int[] nextLettersFrequencies);

    public abstract boolean isValidWord(CharSequence word);
}
