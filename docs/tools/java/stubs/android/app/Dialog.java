package android.app;

/**
 * Compile and PC test stub (Android signatures). Not in Android: it keeps the view that was given as its content, the window it has and
 * whether it is showing, and the last one made, so that the PC tests can read what a dialog of the screens shows and press its buttons.
 */
public class Dialog implements android.content.DialogInterface {
    public static Dialog stubLast;
    public android.view.View stubContent;
    public boolean stubShowing;
    private final android.view.Window stubWindow = new android.view.Window();
    private android.content.DialogInterface.OnCancelListener stubCancel;
    private android.content.DialogInterface.OnDismissListener stubDismiss;

    public Dialog(android.content.Context context, int themeResId) { stubLast = this; }
    public android.content.Context getContext() { return null; }
    public boolean requestWindowFeature(int featureId) { return true; }
    public void setContentView(android.view.View view) { stubContent = view; }
    public android.view.Window getWindow() { return stubWindow; }
    public void setCancelable(boolean flag) { }
    public void setCanceledOnTouchOutside(boolean cancel) { }
    public void setOnCancelListener(android.content.DialogInterface.OnCancelListener listener) { stubCancel = listener; }
    public void setOnDismissListener(android.content.DialogInterface.OnDismissListener listener) { stubDismiss = listener; }
    public void onWindowFocusChanged(boolean hasFocus) { }
    public boolean isShowing() { return stubShowing; }
    public void dismiss() {
        if (!stubShowing) return;
        stubShowing = false;
        if (stubDismiss != null) stubDismiss.onDismiss(this);
    }
    public void show() { stubShowing = true; }
    /** The back button: the dialog is cancelled and closed. */
    public void stubBack() {
        if (!stubShowing) return;
        if (stubCancel != null) stubCancel.onCancel(this);
        dismiss();
    }
}
