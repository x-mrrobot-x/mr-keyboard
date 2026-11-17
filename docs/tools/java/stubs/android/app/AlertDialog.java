package android.app;

public class AlertDialog implements android.content.DialogInterface {
    public static final int BUTTON_POSITIVE = -1;
    public static final int BUTTON_NEGATIVE = -2;
    public static final int BUTTON_NEUTRAL = -3;
    // Not in Android: what the Builder was given, so that a test can read it (the stub draws nothing).
    public CharSequence stubTitle;
    public android.view.View stubView;
    public android.widget.Button stubPositive, stubNegative;
    public android.content.DialogInterface.OnClickListener stubPositiveListener;
    public android.content.DialogInterface.OnDismissListener stubDismissListener;
    public boolean stubShown;
    /** Not in Android: the items of setItems and what a tap on one of them does. */
    public CharSequence[] stubItems;
    public android.content.DialogInterface.OnClickListener stubItemsListener;
    /** Not in Android: the last dialog a Builder made (a test reaches a dialog that the screen keeps no handle of). */
    public static AlertDialog stubLast;
    /** Not in Android: the message the last Builder was given. */
    public static CharSequence stubLastMessage;
    public void dismiss() {
        boolean was = stubShown;
        stubShown = false;
        if (was && stubDismissListener != null) stubDismissListener.onDismiss(this);
    }
    public void show() { stubShown = true; }
    public android.widget.Button getButton(int whichButton) {
        return whichButton == BUTTON_POSITIVE ? stubPositive : whichButton == BUTTON_NEGATIVE ? stubNegative : null;
    }
    public void setOnShowListener(android.content.DialogInterface.OnShowListener listener) { }
    public void setOnDismissListener(android.content.DialogInterface.OnDismissListener listener) { stubDismissListener = listener; }
    public static class Builder {
        private CharSequence title, positive, negative;
        private android.view.View view;
        private android.content.DialogInterface.OnClickListener positiveListener;
        public Builder(android.content.Context context) { }
        public Builder setTitle(CharSequence title) { this.title = title; return this; }
        public Builder setMessage(CharSequence message) { stubLastMessage = message; return this; }
        public Builder setPositiveButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { positive = text; positiveListener = l; return this; }
        public Builder setNegativeButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { negative = text; return this; }
        public Builder setNeutralButton(CharSequence text, android.content.DialogInterface.OnClickListener l) { return this; }
        private CharSequence[] items;
        private android.content.DialogInterface.OnClickListener itemsListener;
        public Builder setItems(CharSequence[] items, android.content.DialogInterface.OnClickListener l) { this.items = items; itemsListener = l; return this; }
        public Builder setSingleChoiceItems(CharSequence[] items, int checkedItem, android.content.DialogInterface.OnClickListener l) { return this; }
        public Builder setView(android.view.View view) { this.view = view; return this; }
        public Builder setCancelable(boolean cancelable) { return this; }
        /** As Android: makes the dialog and shows it (it used to answer null; a test reads the dialog through AlertDialog.stubLast or the answer). */
        public AlertDialog show() { AlertDialog d = create(); d.show(); return d; }
        public AlertDialog create() {
            AlertDialog d = new AlertDialog();
            stubLast = d;
            d.stubTitle = title;
            d.stubView = view;
            d.stubPositiveListener = positiveListener;
            d.stubItems = items;
            d.stubItemsListener = itemsListener;
            if (positive != null) {
                d.stubPositive = new android.widget.Button(null);
                d.stubPositive.setText(positive);
            }
            if (negative != null) {
                d.stubNegative = new android.widget.Button(null);
                d.stubNegative.setText(negative);
            }
            return d;
        }
    }
}
