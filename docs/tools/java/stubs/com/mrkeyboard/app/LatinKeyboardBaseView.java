package com.mrkeyboard.app;

/** Compile and PC test stub (the real class is the LatinKeyboardBaseView smali, a View). */
public class LatinKeyboardBaseView extends android.view.View {
    /** Tests only. */
    public Keyboard keyboard;
    /** Tests only: the state of the Shift key (Keyboard.SHIFT_*), whether the long-press popup is open, the resources. */
    public int stubShift;
    public boolean stubPopup;
    public android.content.res.Resources stubResources;
    /** Tests only: the events handed straight to the tap path (onTouchEvent with two arguments): {action, x, y}. */
    public final java.util.ArrayList<int[]> stubBase = new java.util.ArrayList<int[]>();

    public LatinKeyboardBaseView() { }

    public LatinKeyboardBaseView(android.content.Context c) { super(c); }

    public Keyboard getKeyboard() { return keyboard; }

    public void invalidateAllKeys() { }

    public int getShiftState() { return stubShift; }

    protected boolean popupKeyboardIsShowing() { return stubPopup; }

    /** The tap path of the real class: fling detector, then the key under each finger. */
    public boolean onTouchEvent(android.view.MotionEvent me, boolean continuing) {
        stubBase.add(new int[] {me.getActionMasked(), (int) me.getX(), (int) me.getY()});
        return true;
    }

    @Override
    public android.content.res.Resources getResources() { return stubResources; }
}
