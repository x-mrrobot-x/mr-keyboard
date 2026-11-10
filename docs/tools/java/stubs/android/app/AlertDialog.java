package android.app;

public class AlertDialog implements android.content.DialogInterface {
    public static final int BUTTON_POSITIVE = -1;
    public static final int BUTTON_NEUTRAL = -3;
    public void dismiss() { }
    public void show() { }
    public android.widget.Button getButton(int whichButton) { return null; }
    public void setOnShowListener(android.content.DialogInterface.OnShowListener listener) { }
    public static class Builder {
        public Builder(android.content.Context context) { }
        public Builder setTitle(CharSequence title) { return this; }
        public Builder setMessage(CharSequence message) { return this; }
        public Builder setPositiveButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setNegativeButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setNeutralButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setItems(CharSequence[] items, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setSingleChoiceItems(CharSequence[] items, int checkedItem, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setView(android.view.View view) { return this; }
        public Builder setCancelable(boolean cancelable) { return this; }
        public AlertDialog show() { return null; }
        public AlertDialog create() { return new AlertDialog(); }
    }
}
