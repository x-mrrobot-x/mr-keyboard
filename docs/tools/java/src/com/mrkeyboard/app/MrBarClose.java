package com.mrkeyboard.app;

/**
 * The buttons of the tool bar of the keyboard (clipboard, translate, attachments, emoji, sheets, Customize keyboard, AI
 * Editor) and the dialogs of the tools. (The bar itself is MrBar.)
 * <p>
 * The dialogs of the AI Editor and of Customize keyboard are windows attached to the keyboard window and cover the area
 * above the keyboard, so the bar stays within reach while one is open. Pressing any button of the bar closes the dialogs
 * that are open, and the button then does what it always does. The dialog that the button itself controls is left to the
 * button (its toggle closes it): closing it here first would make the toggle open it again.
 */
final class MrBarClose {
    /** Codes (MrTools.mCode) of the seven buttons of the bar, as MrTools binds them: clipboard, translate, attachments,
     *  Customize keyboard, emoji, sheets, AI Editor. res_check.py compares this list with the smali. */
    static final int[] TOOLBAR = {0x0, 0x1, 0x8, 0x13, 0x14, 0x15, 0x18};
    static final int TUNE = 0x13;
    static final int AI = 0x18;

    private MrBarClose() { }

    static boolean isToolbar(int code) {
        for (int i = 0; i < TOOLBAR.length; i++) {
            if (TOOLBAR[i] == code) return true;
        }
        return false;
    }

    /** A button of MrTools was pressed (MrTools.onClick, before it acts). */
    static void onClick(int code) {
        if (!isToolbar(code)) return;
        try {
            if (code != AI && MrAiDialog.isShowing()) MrAiDialog.dismiss();
            if (code != TUNE) MrTune.dismissDialog();
        } catch (RuntimeException e) {
            // Closing a dialog is a courtesy; the button must still do its job.
        }
    }
}
