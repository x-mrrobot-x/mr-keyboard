package com.mrkeyboard.app;

import android.app.Dialog;
import android.content.DialogInterface;
import android.graphics.drawable.ColorDrawable;
import android.os.IBinder;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.EditorInfo;

/**
 * Modal dialog of the AI Editor, attached to the IME window like the Preferences dialog
 * of MrTune. It sits above the keyboard, keeps the keyboard visible and uses exclusively
 * Theme.MrKeyboard.Dialog (the settings palette), in portrait and landscape.
 */
final class MrAiDialog implements View.OnClickListener, View.OnLayoutChangeListener,
        DialogInterface.OnDismissListener {
    private static Dialog sDialog;
    private static View sImeDecor;
    private static MrAiDialog sListener;
    private static boolean sReopenAfterAuxiliaryUi;
    private static boolean sAuxiliaryUiVisible;
    private static boolean sSawAuxiliaryUi;
    private static String sReturnPackage;

    private MrAiDialog() { }

    /** Opens or closes from the AI Editor button of the toolbar. */
    static void toggle() {
        try {
            if (sDialog != null && sDialog.isShowing()) {
                dismiss();
            } else {
                showDialog();
            }
        } catch (Throwable e) {
            dismiss();
        }
    }

    /** Closes the dialog and invalidates any network response still in progress. */
    static void dismiss() {
        close(sDialog, true);
    }

    /** Stores the current editor before opening Settings or the style editor. */
    static void requestReopenOnReturn() {
        sReopenAfterAuxiliaryUi = true;
        sAuxiliaryUiVisible = false;
        sSawAuxiliaryUi = false;
        sReturnPackage = null;
        try {
            LatinIME ime = MrTools.sIme;
            EditorInfo info = ime != null ? ime.getCurrentInputEditorInfo() : null;
            if (info != null) sReturnPackage = info.packageName;
        } catch (RuntimeException e) {
            // The request remains valid even if the editor cannot be queried right now.
        }
    }

    static void cancelReopenOnReturn() {
        sReopenAfterAuxiliaryUi = false;
        sAuxiliaryUiVisible = false;
        sSawAuxiliaryUi = false;
        sReturnPackage = null;
    }

    /** Marks when an auxiliary Activity (Preferences or Styles) is in the foreground. */
    static void setAuxiliaryUiVisible(boolean visible) {
        sAuxiliaryUiVisible = visible;
        if (visible) sSawAuxiliaryUi = true;
    }

    /** Called when the IME window reappears, including when returning to the previous field. */
    static void onImeWindowShown() {
        if (!sReopenAfterAuxiliaryUi || !sSawAuxiliaryUi || sAuxiliaryUiVisible) return;
        LatinIME ime = MrTools.sIme;
        if (ime == null) return;
        EditorInfo info = ime.getCurrentInputEditorInfo();
        if (info == null) return;
        if (sReturnPackage != null && !sReturnPackage.equals(info.packageName)) return;
        reopenPendingDialog();
    }

    /** Discards the reopening if, instead of the original editor, another app got the field. */
    static void onInputViewStarted(String packageName) {
        if (!sReopenAfterAuxiliaryUi || !sSawAuxiliaryUi || sAuxiliaryUiVisible
                || sReturnPackage == null || packageName == null) return;
        LatinIME ime = MrTools.sIme;
        String ownPackage = ime != null ? ime.getPackageName() : null;
        if (!sReturnPackage.equals(packageName)
                && (ownPackage == null || !ownPackage.equals(packageName))) {
            cancelReopenOnReturn();
        }
    }

    private static void reopenPendingDialog() {
        if (!sReopenAfterAuxiliaryUi) return;
        sReopenAfterAuxiliaryUi = false;
        sSawAuxiliaryUi = false;
        sReturnPackage = null;
        showDialog();
    }

    private static void close(Dialog dialog, boolean dismissWindow) {
        View decor = sImeDecor;
        MrAiDialog listener = sListener;
        sDialog = null;
        sImeDecor = null;
        sListener = null;
        if (decor != null && listener != null) {
            try {
                decor.removeOnLayoutChangeListener(listener);
            } catch (RuntimeException e) {
                // The IME window may already be torn down.
            }
        }
        MrAi.dialogClosed();
        if (dismissWindow && dialog != null) {
            try {
                dialog.dismiss();
            } catch (RuntimeException e) {
                // The token may have been revoked during the window switch.
            }
        }
    }

    private static void showDialog() {
        LatinIME ime = MrTools.sIme;
        if (ime == null) return;
        dismiss();

        View decor = imeDecor();
        if (decor == null) return;
        IBinder token = decor.getWindowToken();
        if (token == null) return;

        Dialog dialog = null;
        try {
            int themeId = ime.getResources().getIdentifier(
                    "Theme.MrKeyboard.Dialog", "style", ime.getPackageName());
            if (themeId == 0) themeId = 0x7f0d00a1;
            dialog = new Dialog(ime, themeId);
            dialog.requestWindowFeature(1);

            int layoutId = dialog.getContext().getResources().getIdentifier(
                    "mr_ai_dialog", "layout", ime.getPackageName());
            if (layoutId == 0) layoutId = 0x7f0a0042;
            View root = LayoutInflater.from(MrLocaleCtx.of(dialog.getContext()))
                    .inflate(layoutId, null);
            View card = root.findViewWithTag("ai_card");
            if (card == null) return;

            MrAiDialog listener = new MrAiDialog();
            sDialog = dialog;
            sImeDecor = decor;
            sListener = listener;
            root.setOnClickListener(listener);
            card.setClickable(true);
            dialog.setCancelable(true);
            dialog.setCanceledOnTouchOutside(true);
            dialog.setOnDismissListener(listener);
            dialog.setContentView(root);
            MrAi.setup(root);

            Window window = dialog.getWindow();
            if (window == null) {
                dismiss();
                return;
            }
            window.setBackgroundDrawable(new ColorDrawable(0x00000000));
            window.clearFlags(2); // The dark layer is in the layout, as in the Preferences dialog.
            window.clearFlags(0x20000); // Do not let the window compete for IME focus.
            window.addFlags(0x308); // NOT_FOCUSABLE | LAYOUT_IN_SCREEN | LAYOUT_NO_LIMITS.
            WindowManager.LayoutParams attrs = window.getAttributes();
            attrs.token = token;
            attrs.type = 0x3eb; // TYPE_APPLICATION_ATTACHED_DIALOG
            attrs.gravity = Gravity.TOP | Gravity.FILL_HORIZONTAL;
            attrs.width = ViewGroup.LayoutParams.MATCH_PARENT;
            int top = imeTop();
            attrs.height = top > 0 ? top : ViewGroup.LayoutParams.MATCH_PARENT;
            window.setAttributes(attrs);

            decor.addOnLayoutChangeListener(listener);
            dialog.show();
        } catch (Throwable e) {
            if (dialog != null && dialog == sDialog) close(dialog, true);
            else MrAi.dialogClosed();
        }
    }

    private static View imeDecor() {
        LatinIME ime = MrTools.sIme;
        if (ime == null) return null;
        Dialog imeWindow = ime.getWindow();
        if (imeWindow == null || imeWindow.getWindow() == null) return null;
        return imeWindow.getWindow().getDecorView();
    }

    private static int imeTop() {
        View decor = sImeDecor != null ? sImeDecor : imeDecor();
        if (decor == null) return -1;
        int[] location = new int[2];
        decor.getLocationOnScreen(location);
        return location[1] > 0 ? location[1] : -1;
    }

    public void onClick(View view) {
        dismiss();
    }

    public void onDismiss(DialogInterface dialog) {
        if (dialog == sDialog) close(sDialog, false);
    }

    public void onLayoutChange(View view, int left, int top, int right, int bottom,
            int oldLeft, int oldTop, int oldRight, int oldBottom) {
        Dialog dialog = sDialog;
        if (dialog == null) return;
        try {
            Window window = dialog.getWindow();
            if (window == null) return;
            WindowManager.LayoutParams attrs = window.getAttributes();
            int nextHeight = imeTop();
            if (nextHeight <= 0) nextHeight = ViewGroup.LayoutParams.MATCH_PARENT;
            if (attrs.height != nextHeight) {
                attrs.height = nextHeight;
                window.setAttributes(attrs);
            }
        } catch (RuntimeException e) {
            // The window may be closed between the callback and the update.
        }
    }
}
