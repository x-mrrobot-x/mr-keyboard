package com.mrkeyboard.app;

/** Compile stub (APK class): only what the Java layer uses. */
public class LatinIME extends android.inputmethodservice.InputMethodService {
    /** The keyboard service that is running (set in onCreate, cleared in onDestroy). */
    static LatinIME sInstance;

    public android.view.inputmethod.InputConnection getAppInputConnection() { return null; }
    public void mrCommit() { }
    /** The suggestion engine of the language in use. Added to the real class in the smali (gesture typing). */
    public Suggest mrSuggest() { return null; }
    /** Puts these words on the strip; null = what the strip shows between two words. Added to the real class in the smali (gesture typing). */
    public void mrStrip(java.util.List<CharSequence> words) { }
    public void pickSuggestionManually(int index, CharSequence suggestion) { }
    public void updateShiftKeyState(android.view.inputmethod.EditorInfo attr) { }
    /** The key listener of the keyboard (the real methods are public): the delete button of the emoji panel calls them. */
    public void onKey(int primaryCode, int[] keyCodes, int x, int y) { }
    public void onPress(int primaryCode) { }
    public void onRelease(int primaryCode) { }
}
