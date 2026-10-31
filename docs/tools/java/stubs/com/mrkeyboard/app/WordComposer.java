package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Stub de compilação e de teste de PC: mesma assinatura da classe do APK (não vai para o dex). */
public class WordComposer {
    private final List<int[]> mCodes = new ArrayList<int[]>();
    private final StringBuilder mTyped = new StringBuilder();
    private boolean mCapitalized;

    public void add(int primaryCode, int[] codes) {
        mTyped.append((char) primaryCode);
        mCodes.add(codes);
    }

    public void setFirstCharCapitalized(boolean capitalized) { mCapitalized = capitalized; }
    public int size() { return mCodes.size(); }
    public int[] getCodesAt(int index) { return mCodes.get(index); }
    public CharSequence getTypedWord() { return mTyped; }
    public boolean isFirstCharCapitalized() { return mCapitalized; }
}
