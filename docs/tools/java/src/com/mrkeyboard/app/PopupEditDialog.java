package com.mrkeyboard.app;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.List;

/**
 * Editor of the long-press popup of one key: nothing, a sequence of characters or a list of action keys (up to ten).
 * The list rows carry the label of the key, a short description of its action and the buttons to reorder (↑ ↓) and to
 * remove (✕); tapping a row opens the key editor of that item (KeyEditDialog.showForPopupItem).
 *
 * The look is in XML, like the other screens: layouts mr_pop_ed_dialog (the dialog) and mr_pop_ed_item (one row), with
 * the drawables mr_pop_ed_*, the colors of the settings palette (@color/mr_ui_*) and the texts of mr_strings.xml
 * (mr_pop_ed_*, in English, Portuguese and Spanish). This class only builds the rows that change, swaps the state of
 * the mode chips and keeps the behavior of the old dialog: the initial mode comes from what the key already has, the
 * "Done" button returns null for "no popup", the characters come from the field (empty becomes null) and the list is
 * dropped to null when it is empty.
 * The views are found by android:tag, so no id is needed (public.xml is not touched). Done/Cancel are the buttons of
 * Theme.MrKeyboard.Dialog.
 */
public final class PopupEditDialog {
    /** What the caller does with the result of the editor. */
    public interface OnPopupSavedListener {
        void onPopupSaved(String popupChars, ArrayList<SheetModel.KeySpec> popupKeys);
    }

    /** Result of the item editor (the item editor is the key editor in its popup mode). */
    private interface OnItemEdited {
        void onSaved(SheetModel.KeySpec key);
    }

    private static final int MODE_NONE = 0;
    private static final int MODE_CHARS = 1;
    private static final int MODE_KEYS = 2;

    /** Maximum of items of a popup (the same limit of the old dialog). */
    private static final int MAX_ITEMS = 10;

    /** Empty text, built here: the resource check of the project reads the Java sources by their quotes, and an empty
     * literal would hide the names that come after it. */
    private static final String EMPTY = new String();

    private PopupEditDialog() { }

    // ------------------------------------------------------------------ one line of the list

    /** Short description of the action of a key ("tskcmd:wifi", the name of a special key, "Go to: …", "Text: …"). */
    public static String describeActionShort(Context context, SheetModel.KeySpec key) {
        if (SheetModel.TYPE_TASKER.equals(key.type)) return TaskerCmd.PREFIX + key.value;
        if (SheetModel.TYPE_SPECIAL.equals(key.type)) {
            int code;
            try {
                code = Integer.parseInt(key.value.trim());
            } catch (Exception e) {
                code = 0;
            }
            return SpecialKeyPicker.describeCode(context, code);
        }
        if (SheetModel.TYPE_SHEET.equals(key.type)) return text(context, "mr_pop_ed_action_sheet", key.value);
        return text(context, "mr_pop_ed_action_text",
                key.value == null ? EMPTY : key.value.replace('\n', '↵'));
    }

    /**
     * Row of the list of items (mr_pop_ed_item): the label of the key, its action and the buttons ↑ ↓ ✕. The four
     * runnables are the actions of the row itself (edit) and of the buttons (up, down, delete); a button that cannot
     * be used in this position comes disabled.
     */
    public static View buildPopupItemRow(Context context, List<SheetModel.Sheet> sheets, SheetModel.KeySpec key,
            int index, int count, final Runnable onUp, final Runnable onDown, final Runnable onEdit,
            final Runnable onDelete) {
        View row = LayoutInflater.from(context).inflate(res(context, "mr_pop_ed_item", "layout"), null);
        String label = SheetKeyboardBuilder.effectiveDisplayLabel(key, sheets);
        ((TextView) row.findViewWithTag("item_label")).setText(label.isEmpty() ? "?" : label);
        ((TextView) row.findViewWithTag("item_desc")).setText(describeActionShort(context, key));
        row.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                onEdit.run();
            }
        });
        TextView up = (TextView) row.findViewWithTag("item_up");
        up.setEnabled(index > 0);
        up.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                onUp.run();
            }
        });
        TextView down = (TextView) row.findViewWithTag("item_down");
        down.setEnabled(index < count - 1);
        down.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                onDown.run();
            }
        });
        TextView delete = (TextView) row.findViewWithTag("item_delete");
        delete.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                onDelete.run();
            }
        });
        return row;
    }

    // ------------------------------------------------------------------ the dialog

    /** Opens the editor of the long-press popup of a key with what the key has today. */
    public static void show(Context context, List<SheetModel.Sheet> sheets, String popupChars,
            List<SheetModel.KeySpec> popupKeys, OnPopupSavedListener listener) {
        new Editor(context, sheets, popupChars, popupKeys, listener).show();
    }

    /** State of one open dialog: the views of mr_pop_ed_dialog and the copy of the list being edited. */
    private static final class Editor {
        private final Context mContext;
        private final List<SheetModel.Sheet> mSheets;
        private final OnPopupSavedListener mListener;
        private final String mChars;
        private final ArrayList<SheetModel.KeySpec> mKeys = new ArrayList<SheetModel.KeySpec>();

        private AlertDialog mDialog;
        private TextView mChipNone;
        private TextView mChipChars;
        private TextView mChipKeys;
        private View mBoxChars;
        private View mBoxKeys;
        private View mBoxNone;
        private TextView mKeysHeader;
        private LinearLayout mKeysList;
        private TextView mAddItem;
        private EditText mCharsField;
        private int mMode;

        Editor(Context context, List<SheetModel.Sheet> sheets, String popupChars,
                List<SheetModel.KeySpec> popupKeys, OnPopupSavedListener listener) {
            mContext = context;
            mSheets = sheets;
            mListener = listener;
            mChars = popupChars;
            if (popupKeys != null) {
                for (int i = 0; i < popupKeys.size(); i++) {
                    SheetModel.KeySpec key = popupKeys.get(i);
                    if (key != null) mKeys.add(key.deepCopy());
                }
            }
            if (!mKeys.isEmpty()) {
                mMode = MODE_KEYS;
            } else if (popupChars == null || popupChars.isEmpty()) {
                mMode = MODE_NONE;
            } else {
                mMode = MODE_CHARS;
            }
        }

        void show() {
            View content = LayoutInflater.from(mContext).inflate(res(mContext, "mr_pop_ed_dialog", "layout"), null);
            mChipNone = (TextView) content.findViewWithTag("mode_none");
            mChipChars = (TextView) content.findViewWithTag("mode_chars");
            mChipKeys = (TextView) content.findViewWithTag("mode_keys");
            mBoxNone = content.findViewWithTag("box_none");
            mBoxChars = content.findViewWithTag("box_chars");
            mBoxKeys = content.findViewWithTag("box_keys");
            mKeysHeader = (TextView) content.findViewWithTag("keys_header");
            mKeysList = (LinearLayout) content.findViewWithTag("keys_list");
            mAddItem = (TextView) content.findViewWithTag("add_item");
            mCharsField = (EditText) content.findViewWithTag("field_chars");
            mCharsField.setText(mChars == null ? EMPTY : mChars);

            mChipNone.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    setMode(MODE_NONE);
                }
            });
            mChipChars.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    setMode(MODE_CHARS);
                }
            });
            mChipKeys.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    setMode(MODE_KEYS);
                }
            });
            mAddItem.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    addItem();
                }
            });

            mDialog = new AlertDialog.Builder(mContext)
                    .setView(content)
                    .setPositiveButton(text(mContext, "mr_pop_ed_done"), new DialogInterface.OnClickListener() {
                        public void onClick(DialogInterface dialog, int which) {
                            save();
                        }
                    })
                    .setNegativeButton(text(mContext, "mr_pop_ed_cancel"), null)
                    .create();
            refresh();
            mDialog.show();
        }

        private void setMode(int mode) {
            mMode = mode;
            refresh();
        }

        /** Repaints the chips and shows only the box of the current mode; in the list mode rebuilds the rows. */
        private void refresh() {
            style(mChipNone, mMode == MODE_NONE);
            style(mChipChars, mMode == MODE_CHARS);
            style(mChipKeys, mMode == MODE_KEYS);
            mBoxNone.setVisibility(mMode == MODE_NONE ? View.VISIBLE : View.GONE);
            mBoxChars.setVisibility(mMode == MODE_CHARS ? View.VISIBLE : View.GONE);
            mBoxKeys.setVisibility(mMode == MODE_KEYS ? View.VISIBLE : View.GONE);
            if (mMode != MODE_KEYS) return;
            mKeysHeader.setText(text(mContext, "mr_pop_ed_keys_header", Integer.valueOf(mKeys.size())));
            mKeysList.removeAllViews();
            for (int i = 0; i < mKeys.size(); i++) {
                final int index = i;
                final SheetModel.KeySpec key = mKeys.get(i);
                mKeysList.addView(buildPopupItemRow(mContext, mSheets, key, i, mKeys.size(),
                        new Runnable() {
                            public void run() {
                                if (index > 0) {
                                    mKeys.add(index - 1, mKeys.remove(index));
                                    refresh();
                                }
                            }
                        },
                        new Runnable() {
                            public void run() {
                                if (index < mKeys.size() - 1) {
                                    mKeys.add(index + 1, mKeys.remove(index));
                                    refresh();
                                }
                            }
                        },
                        new Runnable() {
                            public void run() {
                                editItem(index);
                            }
                        },
                        new Runnable() {
                            public void run() {
                                mKeys.remove(index);
                                refresh();
                            }
                        }));
            }
            mAddItem.setAlpha(mKeys.size() < MAX_ITEMS ? 1.0f : 0.45f);
        }

        private void style(TextView chip, boolean selected) {
            chip.setBackgroundResource(res(mContext, selected ? "mr_pop_ed_chip_on" : "mr_pop_ed_chip", "drawable"));
            chip.setTextColor(color(mContext, selected ? "mr_ui_text" : "mr_ui_text2"));
        }

        private void addItem() {
            if (mKeys.size() >= MAX_ITEMS) {
                Toast.makeText(mContext, text(mContext, "mr_pop_ed_limit"), Toast.LENGTH_SHORT).show();
                return;
            }
            editItem(-1);
        }

        /** Opens the key editor for an item of the list; position -1 adds a new item at the end. */
        private void editItem(final int position) {
            SheetModel.KeySpec key = position < 0
                    ? new SheetModel.KeySpec(null, SheetModel.TYPE_TEXT, null, 1.0f)
                    : mKeys.get(position);
            KeyEditDialog.showForPopupItem(mContext, mSheets, key, new KeyEditDialog.OnKeyActionListener() {
                public void onDelete() { }

                public void onDuplicate() { }

                public void onMoveLeft() { }

                public void onMoveRight() { }

                public void onSave(SheetModel.KeySpec saved) {
                    if (position < 0) {
                        mKeys.add(saved);
                    } else {
                        mKeys.set(position, saved);
                    }
                    refresh();
                }
            });
        }

        /** Done: returns what the mode keeps (no popup, the chars of the field or the list of keys). */
        private void save() {
            if (mListener == null) return;
            if (mMode == MODE_CHARS) {
                String chars = mCharsField.getText().toString();
                mListener.onPopupSaved(chars.isEmpty() ? null : chars, null);
            } else if (mMode == MODE_KEYS) {
                mListener.onPopupSaved(null, mKeys.isEmpty() ? null : mKeys);
            } else {
                mListener.onPopupSaved(null, null);
            }
        }
    }

    // ------------------------------------------------------------------ resources by name

    private static String text(Context context, String name, Object... args) {
        int id = res(context, name, "string");
        if (id == 0) return name;
        return args.length == 0
                ? context.getResources().getString(id)
                : context.getResources().getString(id, args);
    }

    private static int res(Context context, String name, String type) {
        return context.getResources().getIdentifier(name, type, context.getPackageName());
    }

    private static int color(Context context, String name) {
        return context.getResources().getColor(res(context, name, "color"));
    }
}
