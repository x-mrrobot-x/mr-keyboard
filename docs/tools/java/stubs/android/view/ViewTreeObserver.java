package android.view;

/** Compile and PC test stub: only the window-focus listeners, which the tests can fire. */
public final class ViewTreeObserver {
    public interface OnWindowFocusChangeListener { void onWindowFocusChanged(boolean hasFocus); }

    private final java.util.ArrayList<OnWindowFocusChangeListener> focus = new java.util.ArrayList<OnWindowFocusChangeListener>();

    public void addOnWindowFocusChangeListener(OnWindowFocusChangeListener l) { focus.add(l); }
    public void removeOnWindowFocusChangeListener(OnWindowFocusChangeListener l) { focus.remove(l); }
    public boolean isAlive() { return true; }

    public int stubListeners() { return focus.size(); }
    public void stubDispatch(boolean hasFocus) {
        for (OnWindowFocusChangeListener l : new java.util.ArrayList<OnWindowFocusChangeListener>(focus)) l.onWindowFocusChanged(hasFocus);
    }
}
