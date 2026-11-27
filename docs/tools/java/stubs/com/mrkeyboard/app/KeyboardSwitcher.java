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

    /** Tests only: the keyboards the next dropUnused reports, and how many times it ran. */
    public static int stubUnused;
    public static int stubDrops;
    /** Tests only: dropUnused throws. */
    public static boolean stubFail;

    /** Lets go of the keyboards that are not on screen (onTrimMemory); how many. */
    public static int dropUnused() {
        stubDrops++;
        if (stubFail) throw new IllegalStateException("stub");
        int n = stubUnused;
        stubUnused = 0;
        return n;
    }

    public LatinKeyboardView getInputView() { return view; }

    /** The sheets (or the keys of ABC) changed: the keyboards are built again. Tests only: how many times it was asked. */
    public static int stubSheetsChanged;
    public void onSheetsChanged() { stubSheetsChanged++; }

    public boolean isAlphabetMode() { return stubAlphabet; }

    public int getSheet() { return stubSheet; }
}
