package com.mrkeyboard.app;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.WindowInsets;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ScrollView;

/**
 * The keyboard on the app's own editor screens (the sheet editor and the AI style editor), which have text fields in
 * the Activity window itself.
 * <p>
 * Rotation: since Android 17 the system no longer brings the keyboard back by itself when the screen is recreated, so
 * the screen saves which field had it open ({@link #save}) and asks for it again ({@link #restore}) once the new window
 * has the focus. The calls need Android 11 to know that the keyboard is open; below that nothing is saved and nothing
 * is shown, which is what those versions already did.
 * <p>
 * Edge-to-edge (Android 15+): the window is no longer resized for the keyboard, only told its height. {@link #lift}
 * adds that height as bottom padding of the scrolled column, so that the last fields can be scrolled above the keyboard.
 */
public final class MrScreenIme {
    static final String KEY_FIELD = "mr_ime_field";
    static final String KEY_START = "mr_ime_start";
    static final String KEY_END = "mr_ime_end";
    /** WindowInsets.Type and isVisible(ime) arrived with Android 11. */
    static final int IME_API_SDK = 30;

    private MrScreenIme() { }

    /** Index (0 or 1) of the field that has the focus with the keyboard open, or -1. */
    static int fieldWithKeyboard(EditText first, EditText second) {
        if (Build.VERSION.SDK_INT < IME_API_SDK) return -1;
        if (first != null && first.hasFocus() && Api30.imeVisible(first)) return 0;
        if (second != null && second.hasFocus() && Api30.imeVisible(second)) return 1;
        return -1;
    }

    /** Call from onSaveInstanceState: remembers the field with the open keyboard, and where its cursor was. */
    public static void save(Bundle out, EditText first, EditText second) {
        if (out == null) return;
        try {
            int index = fieldWithKeyboard(first, second);
            if (index < 0) return;
            EditText field = index == 0 ? first : second;
            out.putInt(KEY_FIELD, index);
            out.putInt(KEY_START, field.getSelectionStart());
            out.putInt(KEY_END, field.getSelectionEnd());
        } catch (RuntimeException e) {
            // Without it the screen just comes back without the keyboard, as before Android 17.
        }
    }

    /** Call at the end of onCreate (with the saved state, null on the first start): puts the keyboard back. */
    public static void restore(Bundle in, EditText first, EditText second) {
        if (in == null || !in.containsKey(KEY_FIELD)) return;
        try {
            int index = in.getInt(KEY_FIELD, -1);
            EditText field = index == 0 ? first : index == 1 ? second : null;
            if (field == null) return;
            int length = field.length();
            int start = in.getInt(KEY_START, -1);
            int end = in.getInt(KEY_END, -1);
            field.requestFocus();
            if (start >= 0 && end >= 0 && start <= length && end <= length) field.setSelection(start, end);
            new Show(field).arm();
        } catch (RuntimeException e) {
            // Same: no keyboard, nothing else lost.
        }
    }

    /** Shows the keyboard for the field once its window has the focus (before that the system ignores the request). */
    private static final class Show implements Runnable, ViewTreeObserver.OnWindowFocusChangeListener {
        private final EditText mField;

        Show(EditText field) {
            mField = field;
        }

        void arm() {
            if (mField.hasWindowFocus()) mField.post(this);
            else mField.getViewTreeObserver().addOnWindowFocusChangeListener(this);
        }

        public void onWindowFocusChanged(boolean hasFocus) {
            if (!hasFocus) return;
            ViewTreeObserver observer = mField.getViewTreeObserver();
            if (observer.isAlive()) observer.removeOnWindowFocusChangeListener(this);
            // After the system has finished handling the focus (it only then binds the field to the keyboard).
            mField.post(this);
        }

        public void run() {
            try {
                mField.requestFocus();
                InputMethodManager imm = (InputMethodManager) mField.getContext()
                        .getSystemService(Context.INPUT_METHOD_SERVICE);
                if (imm != null) imm.showSoftInput(mField, InputMethodManager.SHOW_IMPLICIT);
            } catch (RuntimeException e) {
                // The screen may have been closed in the meantime.
            }
        }
    }

    /**
     * Makes room for the keyboard in a scrolled column: the height of the keyboard that is left over after the bars
     * (the content area already has them as padding) is added to the bottom padding, and when the keyboard appears
     * the field that has the focus scrolls to the top margin. Same arithmetic as the sheet editor.
     * The fields must be direct children of the column.
     */
    public static void lift(ScrollView scroll, View column, int padLeft, int padTop, int padRight, int padBottom,
            int margin) {
        if (scroll == null || column == null || Build.VERSION.SDK_INT < IME_API_SDK) return;
        scroll.setOnApplyWindowInsetsListener(
                new Lift(scroll, column, padLeft, padTop, padRight, padBottom, margin));
        scroll.requestApplyInsets();
    }

    private static final class Lift implements View.OnApplyWindowInsetsListener, Runnable {
        private final ScrollView mScroll;
        private final View mColumn;
        private final int mLeft, mTop, mRight, mBottom, mMargin;
        private int mLastExtra;

        Lift(ScrollView scroll, View column, int left, int top, int right, int bottom, int margin) {
            mScroll = scroll;
            mColumn = column;
            mLeft = left;
            mTop = top;
            mRight = right;
            mBottom = bottom;
            mMargin = margin;
        }

        public WindowInsets onApplyWindowInsets(View view, WindowInsets insets) {
            int extra = Api30.extra(insets);
            if (extra != mLastExtra) {
                boolean appeared = extra > mLastExtra && extra > 0;
                mLastExtra = extra;
                mColumn.setPadding(mLeft, mTop, mRight, mBottom + extra);
                if (appeared) mScroll.post(this);
            }
            return insets;
        }

        public void run() {
            View field = mScroll.findFocus();
            if (field != null && field != mColumn) mScroll.scrollTo(0, Math.max(0, field.getTop() - mMargin));
        }
    }

    /** Calls that exist only from Android 11, apart so that older versions never load them. */
    private static final class Api30 {
        static boolean imeVisible(View view) {
            WindowInsets root = view.getRootWindowInsets();
            return root != null && root.isVisible(WindowInsets.Type.ime());
        }

        /** Keyboard height beyond the system bars, never negative. */
        static int extra(WindowInsets insets) {
            int ime = insets.getInsets(WindowInsets.Type.ime()).bottom;
            int bars = insets.getInsets(WindowInsets.Type.systemBars()).bottom;
            return Math.max(0, ime - bars);
        }
    }
}
