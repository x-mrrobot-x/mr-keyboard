package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the LatinKeyboardBaseView smali, a View). */
public class LatinKeyboardBaseView extends android.view.View {
    /** Tests only. */
    public Keyboard keyboard;

    public LatinKeyboardBaseView() { }

    public LatinKeyboardBaseView(android.content.Context c) { super(c); }

    public Keyboard getKeyboard() { return keyboard; }

    public void invalidateAllKeys() { }
}
