package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Stub de compilação e de teste de PC. mrMainDict/mrUserBigrams são acrescentados à classe real no smali.
 * Para os testes: valid = palavras "do dicionário"; added = o que foi entregue por addWord.
 */
public class Suggest implements Dictionary.WordCallback {
    public final Set<String> valid = new HashSet<String>();
    public final List<Object[]> added = new ArrayList<Object[]>();

    public BinaryDictionary mrMainDict() { return null; }
    public Dictionary mrUserBigrams() { return null; }
    public boolean hasMainDictionary() { return false; }
    public boolean isValidWord(CharSequence word) { return valid.contains(word.toString()); }
    public boolean addWord(char[] word, int offset, int length, int freq, int dicTypeId, Dictionary.DataType dataType) {
        added.add(new Object[] {new String(word, offset, length), freq, dataType});
        return true;
    }
}
