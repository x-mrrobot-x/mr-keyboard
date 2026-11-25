package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.text.InputFilter;
import android.text.InputType;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.LinearLayout;

/**
 * The dialog with the name and the badge of a sheet, the same on the "Keyboard sheets" page (a new sheet, "Name and badge" of a card) and in the
 * sheet editor ("Name and badge"): layout mr_sheet_dialog_fields, with the two fields of SheetUi.makeEditText in its slots and the note that says
 * where the badge shows. The name field opens with the keyboard and its text selected, so typing replaces it; the name is cut at
 * {@link #MAX_NAME} characters and the badge at SheetModel.MAX_BADGE_LEN, both while typing (the same limits SheetModel applies when it saves),
 * and the badge is typed in capitals like the badges that come with the app. What is typed goes to the caller as it is: SheetModel.sanitizeName
 * and sanitizeBadge (in the caller) keep the old value for an empty field.
 */
final class SheetNameDialog {
    /** The longest name of a sheet (SheetModel.sanitizeName cuts there). */
    static final int MAX_NAME = 40;

    /** What the caller does with the two fields when the person confirms. */
    interface OnNamed {
        void onNamed(String name, String badge);
    }

    /** Empty text, built here: the resource check of the project reads the Java sources by their quotes, and an empty literal would hide the names
     * that come after it. */
    private static final String EMPTY = new String();

    private SheetNameDialog() { }

    /** Opens the dialog; the answer is the dialog, already shown (the screens keep it to ignore a second tap while it is open). */
    static AlertDialog show(Activity a, String title, String positive, String cancel, String name, String badge, final OnNamed done) {
        View content = LayoutInflater.from(a).inflate(
                a.getResources().getIdentifier("mr_sheet_dialog_fields", "layout", a.getPackageName()), null);
        final EditText nameField = SheetUi.makeEditText(a, null, true);
        nameField.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_CAP_SENTENCES);
        nameField.setFilters(new InputFilter[] { new InputFilter.LengthFilter(MAX_NAME) });
        nameField.setText(name == null ? EMPTY : name);
        ((LinearLayout) content.findViewWithTag("name_slot")).addView(nameField);
        final EditText badgeField = SheetUi.makeEditText(a, null, true);
        badgeField.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_CAP_CHARACTERS
                | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);
        badgeField.setFilters(new InputFilter[] { new InputFilter.LengthFilter(SheetModel.MAX_BADGE_LEN) });
        badgeField.setText(badge == null ? EMPTY : badge);
        ((LinearLayout) content.findViewWithTag("badge_slot")).addView(badgeField);

        AlertDialog dialog = new AlertDialog.Builder(a)
                .setTitle(title)
                .setView(content)
                .setPositiveButton(positive, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface d, int which) {
                        if (done != null) done.onNamed(nameField.getText().toString(), badgeField.getText().toString());
                    }
                })
                .setNegativeButton(cancel, null)
                .create();
        // the keyboard comes up with the dialog, on the name, with the name selected (typing replaces it)
        Window window = dialog.getWindow();
        if (window != null) window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_VISIBLE);
        nameField.requestFocus();
        nameField.selectAll();
        dialog.show();
        return dialog;
    }
}
