package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the LatinKeyboard smali). */
public class LatinKeyboard extends Keyboard {
    /** The real one makes a LatinKey of the row; here a plain key. Tests only: how many. */
    public Keyboard.Key createCustomKey(Keyboard.Row row) {
        stubCreated++;
        return new Keyboard.Key(0, 0, 0, 0, 0);
    }
    public int stubCreated;

    /** The real one finds F1, the sheet key, Enter and space again. Tests only: how many times. */
    public void bindCustomSpecialKeys() { stubBound++; }
    public int stubBound;
}
