package com.mrkeyboard.app;

/** Stub de compilação. mrMainDict/mrUserBigrams são acrescentados à classe real no smali. */
public class Suggest implements Dictionary.WordCallback {
    public BinaryDictionary mrMainDict() { return null; }
    public Dictionary mrUserBigrams() { return null; }
    public boolean hasMainDictionary() { return false; }
    public boolean isValidWord(CharSequence word) { return false; }
    public boolean addWord(char[] word, int offset, int length, int freq, int dicTypeId, Dictionary.DataType dataType) {
        return true;
    }
}
