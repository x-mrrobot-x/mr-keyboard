package android.view.inputmethod;

/** Compile and PC test stub: remembers the requests to show the keyboard. */
public final class InputMethodManager {
    public static final int SHOW_IMPLICIT = 1;

    public int shows;
    public android.view.View lastView;
    public int lastFlags = -1;

    public boolean showSoftInput(android.view.View view, int flags) {
        shows++;
        lastView = view;
        lastFlags = flags;
        return true;
    }
}
