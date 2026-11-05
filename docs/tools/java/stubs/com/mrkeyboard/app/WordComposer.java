package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.List;

/** Compile and PC test stub: same signature as the APK class (does not go into the dex). */
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
