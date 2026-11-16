package android.view.inputmethod;

/** Compile and PC test stub: remembers the requests to show the keyboard and the picker, and answers with the list the tests set. */
public final class InputMethodManager {
    public static final int SHOW_IMPLICIT = 1;

    public int shows;
    public android.view.View lastView;
    public int lastFlags = -1;
    /** Tests only: the keyboards that getEnabledInputMethodList answers, and how many times the picker was asked for. */
    public java.util.List<InputMethodInfo> stubEnabled = new java.util.ArrayList<InputMethodInfo>();
    public int pickers;

    public boolean showSoftInput(android.view.View view, int flags) {
        shows++;
        lastView = view;
        lastFlags = flags;
        return true;
    }

    public java.util.List<InputMethodInfo> getEnabledInputMethodList() {
        return stubEnabled;
    }

    public void showInputMethodPicker() {
        pickers++;
    }
}
