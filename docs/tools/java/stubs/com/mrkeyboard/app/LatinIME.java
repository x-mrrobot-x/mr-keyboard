package com.mrkeyboard.app;

/** Compile stub (APK class): only what the Java layer uses. */
public class LatinIME extends android.inputmethodservice.InputMethodService {
    /** The keyboard service that is running (set in onCreate, cleared in onDestroy). */
    static LatinIME sInstance;

    public android.view.inputmethod.InputConnection getAppInputConnection() { return null; }
    public void mrCommit() { }
    /** Lets go of every word the keyboard still holds as composing (the typed one, one reopened by re-correction). Added to the real class in the smali (fonts tool). */
    public void mrEndWord() { }
    /** The keyboard holds a word: one being typed (composing text) or one reopened by the correction under the cursor. Added to the real class in the smali (Ctrl + delete by words). */
    public boolean mrHoldsWord() { return false; }
    /** Ctrl is on (armed or held). Added to the real class in the smali (Ctrl + delete by words). */
    public boolean mrCtrlOn() { return false; }
    /** Ctrl is on and nothing else (no Shift, Alt or Meta). Added to the real class in the smali (Ctrl + Z by words). */
    public boolean mrCtrlOnly() { return false; }
    /** Lets go of the word the keyboard holds without committing it (not learned); the text stays. Added to the real class in the smali (Ctrl + delete by words). */
    public void mrDropComposing() { }
    /** The suggestion engine of the language in use. Added to the real class in the smali (gesture typing). */
    public Suggest mrSuggest() { return null; }
    /** Puts these words on the strip; null = what the strip shows between two words. Added to the real class in the smali (gesture typing). */
    public void mrStrip(java.util.List<CharSequence> words) { }
    /** Writes the sentence sign (code) in place of the automatic space before the cursor, followed by a space; false = it did not (a modifier is on). Added to the real class in the smali (gesture typing). */
    public boolean mrGlue(int code) { return false; }
    public void pickSuggestionManually(int index, CharSequence suggestion) { }
    public void updateShiftKeyState(android.view.inputmethod.EditorInfo attr) { }
    /** Goes to a sheet: 0 = next, -1 = previous, n = position n - 1 (1 = ABC, 2 = the first sheet...). Tests only: the last one asked. */
    public int stubChangedTo = Integer.MIN_VALUE;
    public void changeSheet(int which) { stubChangedTo = which; }
    /** The key listener of the keyboard (the real methods are public): the delete button of the emoji panel calls them. */
    public void onKey(int primaryCode, int[] keyCodes, int x, int y) { }
    public void onPress(int primaryCode) { }
    public void onRelease(int primaryCode) { }
}
