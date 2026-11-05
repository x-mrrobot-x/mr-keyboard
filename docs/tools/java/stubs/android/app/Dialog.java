package android.app;

public class Dialog implements android.content.DialogInterface {
    public Dialog(android.content.Context context, int themeResId) { }
    public android.content.Context getContext() { return null; }
    public boolean requestWindowFeature(int featureId) { return true; }
    public void setContentView(android.view.View view) { }
    public android.view.Window getWindow() { return null; }
    public void setCancelable(boolean flag) { }
    public void setCanceledOnTouchOutside(boolean cancel) { }
    public void setOnCancelListener(android.content.DialogInterface.OnCancelListener listener) { }
    public void setOnDismissListener(android.content.DialogInterface.OnDismissListener listener) { }
    public boolean isShowing() { return false; }
    public void dismiss() { }
    public void show() { }
}
