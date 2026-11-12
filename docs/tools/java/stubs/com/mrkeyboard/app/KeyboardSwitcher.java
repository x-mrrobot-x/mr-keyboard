package com.mrkeyboard.app;

/** Compile and PC test stub. */
public class KeyboardSwitcher {
    private static final KeyboardSwitcher sInstance = new KeyboardSwitcher();

    /** Tests only. */
    public LatinKeyboardView view;
    /** Tests only: the letters keyboard is on screen, and which sheet (0 = the main one). */
    public boolean stubAlphabet = true;
    public int stubSheet;

    public static KeyboardSwitcher getInstance() { return sInstance; }

    public LatinKeyboardView getInputView() { return view; }

    public boolean isAlphabetMode() { return stubAlphabet; }

    public int getSheet() { return stubSheet; }
}
