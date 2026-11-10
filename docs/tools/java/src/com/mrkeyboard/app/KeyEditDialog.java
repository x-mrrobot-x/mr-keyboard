package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * Editor of one key of a sheet (or of one item of a long-press popup), opened by the key grid of the sheet screen and by
 * the popup editor: the type chips (Text, Tasker, Special, Sheet, Spacer), the label shown on the key, the text committed
 * on tap, the Tasker command with its presets, the selected special key and the target sheet, the proportional width with
 * its presets and the long-press popup; for an existing key also the "move left / move right / duplicate / delete" chips.
 *
 * The look is in XML, like the other screens: layout mr_key_ed_dialog with the drawables mr_key_ed_*, the colors of the
 * settings palette (@color/mr_ui_*) and the texts of mr_strings.xml (mr_key_ed_*, in English, Portuguese and Spanish).
 * This class only fills in what changes (the title, the texts that depend on the key, the state of the chips, the
 * visibility of the sections) and keeps the behavior of the old dialog: the automatic label that follows the typed text,
 * the toasts that keep the dialog open, the values written back to the key on Save and, in the popup item mode, the fixed
 * width of one key and the absence of the spacer, of the width and of the actions.
 * The views are found by android:tag, so no id is needed (public.xml is not touched). The dialog is the platform
 * AlertDialog of the screen (Theme.MrKeyboard.Dialog): the Save/Cancel buttons are the ones of the theme, and the Save
 * click is replaced on show so that an invalid key keeps the dialog open.
 */
public final class KeyEditDialog {
    /** What the caller does with the result of the editor. */
    public interface OnKeyActionListener {
        void onDelete();

        void onDuplicate();

        void onMoveLeft();

        void onMoveRight();

        void onSave(SheetModel.KeySpec key);
    }

    /** Result of the target sheet picker: the value stored in the key and the texts that go to the screen. */
    private interface OnTargetPicked {
        void onPicked(String value, String badge, String label);
    }

    /** Proportional widths of the presets row, in the order of the width_presets children of mr_key_ed_dialog. */
    private static final float[] WIDTH_PRESETS = {0.5f, 1.0f, 1.5f, 2.0f, 3.0f};

    /** Last step of the width bar: 0.5x + 14 * 0.25x = 4x (the same range of the old dialog). */
    private static final int WIDTH_MAX = 14;

    /** Empty text, built here: the resource check of the project reads the Java sources by their quotes, and an empty
     * literal would hide the names that come after it. */
    private static final String EMPTY = new String();

    /** Decoration of the buttons that open another screen (the old dialog added it to the text); it is not a text. */
    private static final String MORE = "  ▾";

    /** Chips of the actions row. */
    private static final int ACTION_LEFT = 1;
    private static final int ACTION_RIGHT = 2;
    private static final int ACTION_DUPLICATE = 3;
    private static final int ACTION_DELETE = 4;

    private KeyEditDialog() { }

    /** Editor of a key of a row: fromNew is true for a key being added (no move, no duplicate, no delete). */
    public static void show(Context context, List<SheetModel.Sheet> sheets, SheetModel.KeySpec key,
            boolean canMoveLeft, boolean canMoveRight, boolean canDuplicate, boolean canDelete,
            OnKeyActionListener listener) {
        new Editor(context, sheets, key, false, canMoveLeft, canMoveRight, canDuplicate, canDelete, listener).show();
    }

    /** Editor of one item of a long-press popup: no spacer type, no width, no popup of its own and no actions. */
    public static void showForPopupItem(Context context, List<SheetModel.Sheet> sheets, SheetModel.KeySpec key,
            OnKeyActionListener listener) {
        new Editor(context, sheets, key, true, false, false, false, false, listener).show();
    }

    // ------------------------------------------------------------------ width text

    /** "1x", "1.5x", "0.75x": the smallest number of decimals that shows the width exactly. */
    private static String formatWidth(float width) {
        if (Math.abs(width - Math.round(width)) < 0.01f) {
            return String.format(Locale.US, "%.0fx", Float.valueOf(width));
        }
        if (Math.abs((2.0f * width) - Math.round(2.0f * width)) < 0.01f) {
            return String.format(Locale.US, "%.1fx", Float.valueOf(width));
        }
        return String.format(Locale.US, "%.2fx", Float.valueOf(width));
    }

    /** Integer of the key value, or the fallback when it is empty or not a number. */
    private static int safeInt(String raw, int fallback) {
        if (raw == null) return fallback;
        try {
            return Integer.parseInt(raw.trim());
        } catch (Exception e) {
            return fallback;
        }
    }

    // ------------------------------------------------------------------ the dialog

    /** State of one open dialog: the views of mr_key_ed_dialog and the copy of the key being edited. */
    private static final class Editor {
        private final Context mContext;
        private final List<SheetModel.Sheet> mSheets;
        private final SheetModel.KeySpec mKey;
        private final boolean mPopup;
        private final boolean mCanMoveLeft;
        private final boolean mCanMoveRight;
        private final boolean mCanDuplicate;
        private final boolean mCanDelete;
        private final OnKeyActionListener mListener;

        private AlertDialog mDialog;
        private TextView[] mChips;
        private String[] mTypes;
        private LinearLayout mGroupLabel;
        private LinearLayout mGroupValue;
        private LinearLayout mGroupTasker;
        private LinearLayout mGroupSpecial;
        private LinearLayout mGroupSheet;
        private LinearLayout mGroupWidth;
        private LinearLayout mGroupPopup;
        private TextView mSpacerHint;
        private EditText mLabelField;
        private EditText mValueField;
        private EditText mTaskerField;
        private TextView mWidthTitle;
        private SeekBar mWidthBar;
        private TextView mSpecialBtn;
        private TextView mSheetBtn;
        private TextView mPopupBtn;

        /** Integer of the selected special key (the default is the left arrow, as in the old dialog). */
        private int mSpecialCode;
        /** Value of the target sheet ("next", "prev", "abc" or the id of a sheet). */
        private String mTarget;
        /** Step of the width bar: 0 = 0.5x, 14 = 4x. */
        private int mStep;
        /** True while the label is only a copy of the committed text (then it follows what is typed). */
        private boolean mAutoLabel;

        Editor(Context context, List<SheetModel.Sheet> sheets, SheetModel.KeySpec key, boolean popup,
                boolean canMoveLeft, boolean canMoveRight, boolean canDuplicate, boolean canDelete,
                OnKeyActionListener listener) {
            mContext = context;
            mSheets = sheets;
            mKey = key != null ? key.deepCopy() : new SheetModel.KeySpec(null, SheetModel.TYPE_TEXT, null, 1.0f);
            mPopup = popup;
            mCanMoveLeft = canMoveLeft;
            mCanMoveRight = canMoveRight;
            mCanDuplicate = canDuplicate;
            mCanDelete = canDelete;
            mListener = listener;
        }

        void show() {
            View content = LayoutInflater.from(mContext).inflate(res("mr_key_ed_dialog", "layout"), null);
            mDialog = new AlertDialog.Builder(mContext)
                    .setView(content)
                    .setPositiveButton(t("mr_key_ed_save"), null)
                    .setNegativeButton(t("mr_key_ed_cancel"), null)
                    .create();
            bind(content);
            refresh();
            // Save keeps the dialog open when the key is not valid (the toast explains what is missing)
            mDialog.setOnShowListener(new DialogInterface.OnShowListener() {
                public void onShow(DialogInterface dialog) {
                    mDialog.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener(new View.OnClickListener() {
                        public void onClick(View v) {
                            save();
                        }
                    });
                }
            });
            mDialog.show();
        }

        // -------------------------------------------------------------- build

        private void bind(View content) {
            ((TextView) content.findViewWithTag("title"))
                    .setText(t(mPopup ? "mr_key_ed_title_popup" : "mr_key_ed_title"));

            TextView textChip = (TextView) content.findViewWithTag("chip_text");
            TextView taskerChip = (TextView) content.findViewWithTag("chip_tasker");
            TextView specialChip = (TextView) content.findViewWithTag("chip_special");
            TextView sheetChip = (TextView) content.findViewWithTag("chip_sheet");
            TextView spacerChip = (TextView) content.findViewWithTag("chip_spacer");
            if (mPopup) {
                // a popup item is a key of the keyboard: no spacer
                spacerChip.setVisibility(View.GONE);
                mChips = new TextView[] { textChip, taskerChip, specialChip, sheetChip };
                mTypes = new String[] { SheetModel.TYPE_TEXT, SheetModel.TYPE_TASKER, SheetModel.TYPE_SPECIAL,
                        SheetModel.TYPE_SHEET };
            } else {
                mChips = new TextView[] { textChip, taskerChip, specialChip, sheetChip, spacerChip };
                mTypes = new String[] { SheetModel.TYPE_TEXT, SheetModel.TYPE_TASKER, SheetModel.TYPE_SPECIAL,
                        SheetModel.TYPE_SHEET, SheetModel.TYPE_SPACER };
            }
            for (int i = 0; i < mChips.length; i++) {
                final String type = mTypes[i];
                mChips[i].setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        selectType(type);
                    }
                });
            }

            mGroupLabel = (LinearLayout) content.findViewWithTag("group_label");
            mGroupValue = (LinearLayout) content.findViewWithTag("group_value");
            mGroupTasker = (LinearLayout) content.findViewWithTag("group_tasker");
            mGroupSpecial = (LinearLayout) content.findViewWithTag("group_special");
            mGroupSheet = (LinearLayout) content.findViewWithTag("group_sheet");
            mGroupWidth = (LinearLayout) content.findViewWithTag("group_width");
            mGroupPopup = (LinearLayout) content.findViewWithTag("group_popup");
            mSpacerHint = (TextView) content.findViewWithTag("spacer_hint");

            mLabelField = (EditText) content.findViewWithTag("field_label");
            mValueField = (EditText) content.findViewWithTag("field_value");
            mTaskerField = (EditText) content.findViewWithTag("field_tasker");
            mSpecialBtn = (TextView) content.findViewWithTag("btn_special");
            mSheetBtn = (TextView) content.findViewWithTag("btn_sheet");
            mPopupBtn = (TextView) content.findViewWithTag("btn_popup");
            mWidthTitle = (TextView) content.findViewWithTag("width_title");
            mWidthBar = (SeekBar) content.findViewWithTag("width_seek");

            // the fields start with what the key has (a new key starts empty; the label of a text key is the text)
            mLabelField.setText(mKey.label == null ? EMPTY : mKey.label);
            if (SheetModel.TYPE_TEXT.equals(mKey.type)) {
                mValueField.setText(mKey.value == null ? EMPTY : mKey.value);
            }
            if (SheetModel.TYPE_TASKER.equals(mKey.type)) {
                mTaskerField.setText(SheetModel.stripTaskerPrefix(mKey.value));
            }

            bindTaskerPresets(content);
            bindWidth(content);
            bindSpecial();
            bindSheet();
            bindPopup();

            if (mPopup) {
                // a popup item keeps the width of one key and has no actions and no popup of its own
                mGroupWidth.setVisibility(View.GONE);
                mGroupPopup.setVisibility(View.GONE);
                content.findViewWithTag("group_actions").setVisibility(View.GONE);
            } else {
                bindActions(content);
            }

            bindLabelSync();
            mAutoLabel = mKey.label == null || mKey.label.isEmpty() || mKey.label.equals(mKey.value);
        }

        private void bindTaskerPresets(View content) {
            LinearLayout presets = (LinearLayout) content.findViewWithTag("tasker_presets");
            for (int i = 0; i < presets.getChildCount(); i++) {
                final TextView pill = (TextView) presets.getChildAt(i);
                pill.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        String command = pill.getText().toString();
                        mTaskerField.setText(command);
                        if (mLabelField.getText().toString().trim().isEmpty()) mLabelField.setText(command);
                    }
                });
            }
        }

        private void bindWidth(View content) {
            mStep = Math.round((SheetModel.clampWidth(mKey.width) - 0.5f) / 0.25f);
            mWidthBar.setMax(WIDTH_MAX);
            mWidthBar.setProgress(Math.max(0, Math.min(WIDTH_MAX, mStep)));
            mWidthBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
                public void onProgressChanged(SeekBar bar, int progress, boolean fromUser) {
                    mStep = progress;
                    refreshWidthTitle();
                }

                public void onStartTrackingTouch(SeekBar bar) { }

                public void onStopTrackingTouch(SeekBar bar) { }
            });
            LinearLayout presets = (LinearLayout) content.findViewWithTag("width_presets");
            for (int i = 0; i < presets.getChildCount() && i < WIDTH_PRESETS.length; i++) {
                final float width = WIDTH_PRESETS[i];
                presets.getChildAt(i).setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        mWidthBar.setProgress(Math.round((width - 0.5f) / 0.25f));
                    }
                });
            }
            refreshWidthTitle();
        }

        private void bindSpecial() {
            mSpecialCode = SheetModel.TYPE_SPECIAL.equals(mKey.type) ? safeInt(mKey.value, -21) : -21;
            mSpecialBtn.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    SpecialKeyPicker.show(mContext, mSpecialCode, new SpecialKeyPicker.OnSpecialKeySelectedListener() {
                        public void onSpecialKeySelected(int code, String label) {
                            // the label typed by the user stays; the automatic one follows the new key
                            String previous = SpecialKeyPicker.defaultLabelForCode(mSpecialCode);
                            mSpecialCode = code;
                            mSpecialBtn.setText(SpecialKeyPicker.describeCode(mContext, code) + MORE);
                            String typed = mLabelField.getText().toString().trim();
                            if (typed.isEmpty() || typed.equals(previous)) mLabelField.setText(label);
                        }
                    });
                }
            });
        }

        private void bindSheet() {
            mTarget = SheetModel.TYPE_SHEET.equals(mKey.type) && mKey.value != null && !mKey.value.isEmpty()
                    ? mKey.value : SheetModel.TARGET_NEXT;
            mSheetBtn.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    showTargetPicker(mTarget, new OnTargetPicked() {
                        public void onPicked(String value, String badge, String label) {
                            mTarget = value;
                            mSheetBtn.setText(label + MORE);
                            if (mLabelField.getText().toString().trim().isEmpty()) mLabelField.setText(badge);
                        }
                    });
                }
            });
        }

        private void bindPopup() {
            if (mPopup) return;
            mPopupBtn.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    PopupEditDialog.show(mContext, mSheets, mKey.popupChars, mKey.popupKeys,
                            new PopupEditDialog.OnPopupSavedListener() {
                                public void onPopupSaved(String chars, ArrayList<SheetModel.KeySpec> keys) {
                                    mKey.popupChars = chars;
                                    mKey.popupKeys = keys;
                                    refreshPopupLabel();
                                }
                            });
                }
            });
        }

        private void bindActions(View content) {
            bindAction(content, "act_left", mCanMoveLeft, ACTION_LEFT);
            bindAction(content, "act_right", mCanMoveRight, ACTION_RIGHT);
            bindAction(content, "act_duplicate", mCanDuplicate, ACTION_DUPLICATE);
            bindAction(content, "act_delete", mCanDelete, ACTION_DELETE);
        }

        private void bindAction(View content, String tag, boolean enabled, final int action) {
            TextView chip = (TextView) content.findViewWithTag(tag);
            chip.setEnabled(enabled);
            chip.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    perform(action);
                }
            });
        }

        /** The label follows the committed text while the user did not type a label of his own. */
        private void bindLabelSync() {
            mLabelField.addTextChangedListener(new TextWatcher() {
                public void beforeTextChanged(CharSequence s, int start, int count, int after) { }

                public void onTextChanged(CharSequence s, int start, int before, int count) { }

                public void afterTextChanged(Editable s) {
                    String typed = s.toString();
                    mAutoLabel = typed.isEmpty() || typed.equals(mValueField.getText().toString());
                }
            });
            mValueField.addTextChangedListener(new TextWatcher() {
                public void beforeTextChanged(CharSequence s, int start, int count, int after) { }

                public void onTextChanged(CharSequence s, int start, int before, int count) { }

                public void afterTextChanged(Editable s) {
                    // a label of the old keys is short and on one line: longer texts and line breaks stay out
                    if (mAutoLabel && s.length() <= 6 && s.toString().indexOf('\n') < 0) {
                        mLabelField.setText(s.toString());
                        mAutoLabel = true;
                    }
                }
            });
        }

        // -------------------------------------------------------------- state

        private void selectType(String type) {
            mKey.type = type;
            if (SheetModel.TYPE_SPECIAL.equals(type) && mLabelField.getText().toString().trim().isEmpty()) {
                mLabelField.setText(SpecialKeyPicker.defaultLabelForCode(mSpecialCode));
            }
            refresh();
        }

        /** Repaints the chips and shows only the sections of the selected type. */
        private void refresh() {
            for (int i = 0; i < mChips.length; i++) {
                boolean selected = mTypes[i].equals(mKey.type);
                mChips[i].setBackgroundResource(res(selected ? "mr_key_ed_chip_on" : "mr_key_ed_chip", "drawable"));
                mChips[i].setTextColor(color(selected ? "mr_ui_text" : "mr_ui_text2"));
            }
            boolean spacer = SheetModel.TYPE_SPACER.equals(mKey.type);
            mGroupLabel.setVisibility(spacer ? View.GONE : View.VISIBLE);
            mGroupValue.setVisibility(SheetModel.TYPE_TEXT.equals(mKey.type) ? View.VISIBLE : View.GONE);
            mGroupTasker.setVisibility(SheetModel.TYPE_TASKER.equals(mKey.type) ? View.VISIBLE : View.GONE);
            mGroupSpecial.setVisibility(SheetModel.TYPE_SPECIAL.equals(mKey.type) ? View.VISIBLE : View.GONE);
            mGroupSheet.setVisibility(SheetModel.TYPE_SHEET.equals(mKey.type) ? View.VISIBLE : View.GONE);
            mSpacerHint.setVisibility(spacer ? View.VISIBLE : View.GONE);
            if (!mPopup) mGroupPopup.setVisibility(spacer ? View.GONE : View.VISIBLE);
            mSpecialBtn.setText(SpecialKeyPicker.describeCode(mContext, mSpecialCode) + MORE);
            mSheetBtn.setText(describeTarget(mTarget) + MORE);
            refreshPopupLabel();
        }

        private void refreshWidthTitle() {
            mWidthTitle.setText(t("mr_key_ed_width_title", formatWidth(mStep * 0.25f + 0.5f)));
        }

        private void refreshPopupLabel() {
            if (mPopupBtn == null) return;
            if (mKey.hasPopupKeys()) {
                mPopupBtn.setText(t("mr_key_ed_popup_keys", Integer.valueOf(mKey.popupKeys.size())));
            } else if (mKey.hasPopupChars()) {
                mPopupBtn.setText(t("mr_key_ed_popup_chars", mKey.popupChars));
            } else {
                mPopupBtn.setText(t("mr_key_ed_popup_none"));
            }
        }

        /** Text of the current target: the two cycles, ABC or the badge and the name of the sheet. */
        private String describeTarget(String target) {
            if (SheetModel.TARGET_PREV.equals(target)) return t("mr_key_ed_target_prev");
            if (SheetModel.TARGET_ABC.equals(target)) return t("mr_key_ed_target_abc");
            if (mSheets != null) {
                for (int i = 0; i < mSheets.size(); i++) {
                    SheetModel.Sheet sheet = mSheets.get(i);
                    if (sheet.id.equals(target)) return t("mr_key_ed_target_sheet", sheet.badge, sheet.name);
                }
            }
            return t("mr_key_ed_target_next");
        }

        // -------------------------------------------------------------- actions

        /** Leaves the editor for an action of the bottom row (the old dialog closed before calling back). */
        private void perform(int action) {
            mDialog.dismiss();
            if (mListener == null) return;
            if (action == ACTION_LEFT) {
                mListener.onMoveLeft();
            } else if (action == ACTION_RIGHT) {
                mListener.onMoveRight();
            } else if (action == ACTION_DUPLICATE) {
                mListener.onDuplicate();
            } else {
                mListener.onDelete();
            }
        }

        /** Save of the platform dialog: writes the key and closes, or explains what is missing and stays open. */
        private void save() {
            String label = mLabelField.getText().toString();
            float width = mPopup ? 1.0f : SheetModel.clampWidth(mStep * 0.25f + 0.5f);
            if (SheetModel.TYPE_SPACER.equals(mKey.type)) {
                mKey.label = EMPTY;
                mKey.value = EMPTY;
                mKey.popupChars = null;
                mKey.popupKeys = null;
            } else if (SheetModel.TYPE_TEXT.equals(mKey.type)) {
                String value = mValueField.getText().toString();
                if (value.isEmpty() && label.isEmpty()) {
                    toast(t("mr_key_ed_toast_text"));
                    return;
                }
                if (value.isEmpty()) value = label;
                if (label.trim().isEmpty()) {
                    // the label of a text key is the beginning of the text, on one line
                    label = value.replace('\n', '↵');
                    if (label.length() > 6) label = label.substring(0, 6);
                }
                mKey.label = label;
                mKey.value = value;
            } else if (SheetModel.TYPE_TASKER.equals(mKey.type)) {
                String command = SheetModel.stripTaskerPrefix(mTaskerField.getText().toString());
                if (command.isEmpty()) {
                    toast(t("mr_key_ed_toast_tasker"));
                    return;
                }
                mKey.value = command;
                if (label.trim().isEmpty()) label = command;
                mKey.label = label;
            } else if (SheetModel.TYPE_SPECIAL.equals(mKey.type)) {
                mKey.value = String.valueOf(mSpecialCode);
                if (label.trim().isEmpty()) label = SpecialKeyPicker.defaultLabelForCode(mSpecialCode);
                mKey.label = label;
            } else if (SheetModel.TYPE_SHEET.equals(mKey.type)) {
                mKey.value = mTarget;
                if (label.trim().isEmpty()) label = SheetKeyboardBuilder.effectiveDisplayLabel(mKey, mSheets);
                mKey.label = label;
            }
            mKey.width = width;
            mDialog.dismiss();
            if (mListener != null) mListener.onSave(mKey);
        }

        /** Single-choice list of the target sheets, as the old dialog (the current one comes checked). */
        private void showTargetPicker(final String current, final OnTargetPicked picked) {
            final ArrayList<String> values = new ArrayList<String>();
            final ArrayList<String> badges = new ArrayList<String>();
            final ArrayList<String> labels = new ArrayList<String>();
            values.add(SheetModel.TARGET_NEXT);
            badges.add("123▸");
            labels.add(t("mr_key_ed_target_next"));
            values.add(SheetModel.TARGET_PREV);
            badges.add("◂123");
            labels.add(t("mr_key_ed_target_prev"));
            values.add(SheetModel.TARGET_ABC);
            badges.add("ABC");
            labels.add(t("mr_key_ed_target_abc"));
            if (mSheets != null) {
                for (int i = 0; i < mSheets.size(); i++) {
                    SheetModel.Sheet sheet = mSheets.get(i);
                    values.add(sheet.id);
                    badges.add(sheet.badge);
                    labels.add(t("mr_key_ed_target_sheet", sheet.badge, sheet.name));
                }
            }
            int checked = 0;
            for (int i = 0; i < values.size(); i++) {
                if (values.get(i).equals(current)) checked = i;
            }
            CharSequence[] items = labels.toArray(new CharSequence[labels.size()]);
            new AlertDialog.Builder(mContext)
                    .setTitle(t("mr_key_ed_choose_sheet"))
                    .setSingleChoiceItems(items, checked, new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();
                            picked.onPicked(values.get(which), badges.get(which), labels.get(which));
                        }
                    })
                    .setNegativeButton(t("mr_key_ed_cancel"), null)
                    .show();
        }

        // -------------------------------------------------------------- resources by name

        private String t(String name, Object... args) {
            int id = res(name, "string");
            if (id == 0) return name;
            return args.length == 0
                    ? mContext.getResources().getString(id)
                    : mContext.getResources().getString(id, args);
        }

        private int res(String name, String type) {
            return mContext.getResources().getIdentifier(name, type, mContext.getPackageName());
        }

        private int color(String name) {
            return mContext.getResources().getColor(res(name, "color"));
        }

        private void toast(String message) {
            Toast.makeText(mContext, message, Toast.LENGTH_SHORT).show();
        }
    }
}
