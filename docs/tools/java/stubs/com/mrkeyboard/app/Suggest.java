package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Compile and PC test stub. mrMainDict/mrUserBigrams/mrAutoDict/mrUserDict are added to the real class in the smali.
 * For the tests: valid = "dictionary" words; added = what was handed over by addWord; stubMain, stubAuto and stubUser are
 * the dictionaries the mr* methods answer with.
 */
public class Suggest implements Dictionary.WordCallback {
    public final Set<String> valid = new HashSet<String>();
    public final List<Object[]> added = new ArrayList<Object[]>();
    public BinaryDictionary stubMain;
    public Dictionary stubAuto, stubUser;

    public BinaryDictionary mrMainDict() { return stubMain; }
    public Dictionary mrUserBigrams() { return null; }
    public Dictionary mrAutoDict() { return stubAuto; }
    public Dictionary mrUserDict() { return stubUser; }
    public boolean hasMainDictionary() { return false; }
    public boolean isValidWord(CharSequence word) { return valid.contains(word.toString()); }
    public boolean addWord(char[] word, int offset, int length, int freq, int dicTypeId, Dictionary.DataType dataType) {
        added.add(new Object[] {new String(word, offset, length), freq, dataType});
        return true;
    }
}
