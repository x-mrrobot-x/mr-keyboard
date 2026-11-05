package com.mrkeyboard.app;
import java.util.ArrayList;
/** Test version: keeps what the new layer adds. */
public class Suggest implements Dictionary.WordCallback {
    final BinaryDictionary main; Dictionary userBigrams;
    public final ArrayList<String> words = new ArrayList<String>();
    public final ArrayList<Integer> freqs = new ArrayList<Integer>();
    public Suggest(BinaryDictionary m) { main = m; }
    public BinaryDictionary mrMainDict() { return main; }
    public Dictionary mrUserBigrams() { return userBigrams; }
    public boolean isValidWord(CharSequence w) { return main.isValidWord(w) || main.isValidWord(w.toString().toLowerCase()); }
    public boolean addWord(char[] w, int off, int len, int f, int id, Dictionary.DataType t) {
        String s = new String(w, off, len);
        int i = 0; while (i < freqs.size() && freqs.get(i) >= f) i++;
        words.add(i, s); freqs.add(i, f); return true;
    }
}
