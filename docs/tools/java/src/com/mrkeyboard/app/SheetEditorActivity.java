package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowInsets;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.List;

/**
 * Editor of one keyboard sheet, opened from "Keyboard sheets" with the extra {@link #EXTRA_SHEET_ID}: the header with the
 * badge, the title and the subtitle (rows/keys), undo and the ⋮ menu, the hint line, the tabs "+ Add row", "Rows" and
 * "Name/Badge", the drawn key grid ({@link SheetGridView}, Java since 1.92.0 too) and the quick test field.
 *
 * The look is in XML, like the other settings screens: layout mr_sheet_ed_screen (the page), mr_sheet_ed_test_card (the
 * quick test card), mr_sheet_ed_dialog_fields (rename) and mr_sheet_ed_dialog_rows + mr_sheet_ed_row_item (manage rows),
 * with the drawables mr_sheet_ed_*. The colors are the ones of the settings palette (@color/mr_ui_*) and the texts are in
 * mr_strings.xml (mr_sheet_ed_*, in English, Portuguese and Spanish); this class only fills in what changes (badge, title,
 * subtitle, the drawn icons, the clicks) and keeps the behavior of the old screen: the undo stack, the drag of a key, the
 * key editor, the quick test field state (MrScreenIme) and the insets of the keyboard on Android 11+.
 * The views are found by android:tag, so no id is needed (public.xml is not touched).
 */
public class SheetEditorActivity extends Activity {
    /** Extra read by PrefScreenSheets and SettingsHeader: the id of the sheet to edit. */
    public static final String EXTRA_SHEET_ID = "sheet_id";

    /** How many sheets can be undone (the old screen kept 20). */
    private static final int UNDO_LIMIT = 20;

    private List<SheetModel.Sheet> mAllSheets;
    private SheetModel.Sheet mSheet;
    private final ArrayList<SheetModel.Sheet> mUndoStack = new ArrayList<SheetModel.Sheet>();

    private TextView mBadgeChip;
    private TextView mTitleView;
    private TextView mSubtitleView;
    private TextView mUndoBtn;
    private TextView mAddRowBtn;
    private ScrollView mScrollView;
    private SheetGridView mGridView;
    private View mTestCard;
    private View mTestFieldRow;
    private View mTestClear;
    private ImageView mTestFieldIcon;
    private EditText mTestInput;
    private TextView mTestLiveBadge;

    // ------------------------------------------------------------------ resources by name

    /** Text of mr_strings.xml by name, in the language of the app (the context is wrapped in attachBaseContext). */
    private String t(String name, Object... args) {
        int id = getResources().getIdentifier(name, "string", getPackageName());
        if (id == 0) return name;
        return args.length == 0 ? getResources().getString(id) : getResources().getString(id, args);
    }

    private int color(String name) {
        return getResources().getColor(getResources().getIdentifier(name, "color", getPackageName()));
    }

    private View inflate(String layout, ViewGroup parent) {
        int id = getResources().getIdentifier(layout, "layout", getPackageName());
        return LayoutInflater.from(this).inflate(id, parent, false);
    }

    /** Background drawable by name (the quick test card and the field switch between the idle and the focused one). */
    private int drawable(String name) {
        return getResources().getIdentifier(name, "drawable", getPackageName());
    }

    private int dp(float v) {
        return SheetUi.dp(this, v);
    }

    private void toast(String text, boolean longer) {
        Toast.makeText(this, text, longer ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show();
    }

    private static LinearLayout.LayoutParams fill() {
        return new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.MATCH_PARENT);
    }

    // ------------------------------------------------------------------ life cycle

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String id = getIntent() != null ? getIntent().getStringExtra(EXTRA_SHEET_ID) : null;
        mAllSheets = SheetStore.getEditableCopy(this);
        if (id != null) {
            mSheet = SheetStore.getSheetCopyById(this, id);
        }
        if (mSheet == null && !mAllSheets.isEmpty()) {
            mSheet = mAllSheets.get(0).deepCopy();
        }
        if (mSheet == null) {
            finish();
            return;
        }

        View root = inflate("mr_sheet_ed_screen", null);
        mBadgeChip = (TextView) root.findViewWithTag("badge");
        mTitleView = (TextView) root.findViewWithTag("title");
        mSubtitleView = (TextView) root.findViewWithTag("subtitle");
        mUndoBtn = (TextView) root.findViewWithTag("undo");
        mAddRowBtn = (TextView) root.findViewWithTag("add_row");
        mScrollView = (ScrollView) root.findViewWithTag("scroll");

        bindHeader(root);
        bindToolbar(root);
        bindGrid(root);
        bindTestCard(root);

        setContentView(root);
        MrScreenIme.restore(savedInstanceState, mTestInput, null);
        refreshUi();
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        MrScreenIme.save(outState, mTestInput, null);
    }

    // ------------------------------------------------------------------ header

    private void bindHeader(View root) {
        LinearLayout backSlot = (LinearLayout) root.findViewWithTag("back_slot");
        ImageView back = SheetUi.makeIconButton(this, SheetUi.ICON_BACK, color("mr_ui_text"), 40,
                t("mr_sheet_ed_back"));
        back.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        backSlot.addView(back, fill());

        // badge + title + subtitle: tap opens the name/badge dialog (as the old screen did)
        View pill = root.findViewWithTag("header_pill");
        pill.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showRenameDialog();
            }
        });

        mUndoBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                performUndo();
            }
        });

        LinearLayout moreSlot = (LinearLayout) root.findViewWithTag("more_slot");
        final ImageView more = SheetUi.makeIconButton(this, SheetUi.ICON_MORE_VERT, color("mr_ui_text"), 40,
                t("mr_sheet_ed_more"));
        more.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showOverflowMenu(more);
            }
        });
        moreSlot.addView(more, fill());
    }

    private void bindToolbar(View root) {
        mAddRowBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                addRow();
            }
        });
        root.findViewWithTag("rows_btn").setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showManageRowsDialog();
            }
        });
        root.findViewWithTag("name_btn").setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showRenameDialog();
            }
        });
    }

    private void addRow() {
        if (mSheet.rows.size() < SheetModel.MAX_ROWS) {
            pushUndoSnapshot();
            mSheet.rows.add(new SheetModel.Row());
            persistAndRefresh();
            return;
        }
        toast(t("mr_sheet_ed_rows_limit"), false);
    }

    // ------------------------------------------------------------------ grid

    private void bindGrid(View root) {
        mGridView = new SheetGridView(this);
        mGridView.setGridListener(new SheetGridView.GridListener() {
            public void onAddKeyTapped(int row) {
                addNewKeyToRow(row);
            }

            public void onKeyDragged(int fromRow, int fromKey, int toRow, int toIndex) {
                handleKeyDragMove(fromRow, fromKey, toRow, toIndex);
            }

            public void onKeyTapped(int row, int key) {
                openKeyEditor(row, key);
            }

            public void onLockedKeyTapped(boolean deleteKey) {
                toast(t(deleteKey ? "mr_sheet_ed_locked_delete" : "mr_sheet_ed_locked_row"), false);
            }
        });
        LinearLayout slot = (LinearLayout) root.findViewWithTag("grid_slot");
        slot.addView(mGridView, new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT));
    }

    /** Maximum of keys of a row: the last row has the "+" of the grid, so it takes one key less. */
    private int maxKeysOfRow(int row) {
        return row == mSheet.rows.size() - 1 ? SheetModel.MAX_KEYS_LAST_ROW_ADD : SheetModel.MAX_KEYS_PER_ROW;
    }

    private void addNewKeyToRow(int row) {
        if (row < 0 || row >= mSheet.rows.size()) return;
        final SheetModel.Row target = mSheet.rows.get(row);
        if (target.keys.size() >= maxKeysOfRow(row)) {
            toast(t("mr_sheet_ed_row_limit"), false);
            return;
        }
        // null label/value: SheetModel.KeySpec turns them into an empty text (a new key starts empty)
        KeyEditDialog.show(this, mAllSheets, new SheetModel.KeySpec(null, SheetModel.TYPE_TEXT, null, 1.0f),
                false, false, false, false, new KeyEditDialog.OnKeyActionListener() {
                    public void onDelete() { }

                    public void onDuplicate() { }

                    public void onMoveLeft() { }

                    public void onMoveRight() { }

                    public void onSave(SheetModel.KeySpec key) {
                        pushUndoSnapshot();
                        target.keys.add(key);
                        persistAndRefresh();
                    }
                });
    }

    private void openKeyEditor(final int row, final int index) {
        if (row < 0 || row >= mSheet.rows.size()) return;
        final SheetModel.Row target = mSheet.rows.get(row);
        if (index < 0 || index >= target.keys.size()) return;
        final SheetModel.KeySpec key = target.keys.get(index);
        boolean canAddKey = target.keys.size() < maxKeysOfRow(row);
        KeyEditDialog.show(this, mAllSheets, key, index > 0, index < target.keys.size() - 1, canAddKey, true,
                new KeyEditDialog.OnKeyActionListener() {
                    public void onDelete() {
                        pushUndoSnapshot();
                        target.keys.remove(index);
                        persistAndRefresh();
                    }

                    public void onDuplicate() {
                        if (target.keys.size() < maxKeysOfRow(row)) {
                            pushUndoSnapshot();
                            target.keys.add(index + 1, key.deepCopy());
                            persistAndRefresh();
                        }
                    }

                    public void onMoveLeft() {
                        if (index > 0) {
                            pushUndoSnapshot();
                            target.keys.add(index - 1, target.keys.remove(index));
                            persistAndRefresh();
                        }
                    }

                    public void onMoveRight() {
                        if (index < target.keys.size() - 1) {
                            pushUndoSnapshot();
                            target.keys.add(index + 1, target.keys.remove(index));
                            persistAndRefresh();
                        }
                    }

                    public void onSave(SheetModel.KeySpec saved) {
                        pushUndoSnapshot();
                        target.keys.set(index, saved);
                        persistAndRefresh();
                    }
                });
    }

    /** Key dropped on another place: same row (reorder) or another row (move), as the old screen did. */
    private void handleKeyDragMove(int fromRow, int fromKey, int toRow, int toIndex) {
        if (fromRow < 0 || fromRow >= mSheet.rows.size() || toRow < 0 || toRow >= mSheet.rows.size()) return;
        SheetModel.Row from = mSheet.rows.get(fromRow);
        SheetModel.Row to = mSheet.rows.get(toRow);
        if (fromKey < 0 || fromKey >= from.keys.size()) return;
        if (fromRow == toRow) {
            int at = toIndex;
            if (at > fromKey) at--;
            at = Math.max(0, Math.min(from.keys.size() - 1, at));
            if (at == fromKey) return;
            pushUndoSnapshot();
            from.keys.add(at, from.keys.remove(fromKey));
            persistAndRefresh();
            return;
        }
        if (to.keys.size() >= maxKeysOfRow(toRow)) return;
        pushUndoSnapshot();
        to.keys.add(Math.max(0, Math.min(to.keys.size(), toIndex)), from.keys.remove(fromKey));
        persistAndRefresh();
    }

    // ------------------------------------------------------------------ quick test card

    private void bindTestCard(View root) {
        mTestCard = root.findViewWithTag("test_card");
        mTestFieldRow = root.findViewWithTag("test_field_row");
        mTestClear = root.findViewWithTag("test_clear");
        mTestFieldIcon = (ImageView) root.findViewWithTag("test_field_icon");
        mTestInput = (EditText) root.findViewWithTag("test_input");
        mTestLiveBadge = (TextView) root.findViewWithTag("test_badge");

        mTestFieldIcon.setImageDrawable(
                new SheetUi.IconDrawable(this, SheetUi.ICON_KEYBOARD, color("mr_ui_text3"), dp(22)));
        ImageView clearIcon = (ImageView) root.findViewWithTag("test_clear_icon");
        clearIcon.setImageDrawable(
                new SheetUi.IconDrawable(this, SheetUi.ICON_CLEAR, color("mr_ui_text3"), dp(12)));

        mTestFieldRow.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                mTestInput.requestFocus();
                try {
                    InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
                    if (imm != null) {
                        imm.showSoftInput(mTestInput, InputMethodManager.SHOW_IMPLICIT);
                    }
                } catch (Throwable ignored) {
                }
            }
        });
        mTestInput.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            public void onFocusChange(View v, boolean focused) {
                mTestFieldIcon.setImageDrawable(new SheetUi.IconDrawable(SheetEditorActivity.this,
                        SheetUi.ICON_KEYBOARD, color(focused ? "mr_ui_cyan" : "mr_ui_text3"), dp(22)));
                mTestFieldRow.setBackgroundResource(drawable(focused ? "mr_sheet_ed_field_bg_on" : "mr_sheet_ed_field_bg"));
                mTestCard.setBackgroundResource(drawable(focused ? "mr_sheet_ed_card_bg_on" : "mr_sheet_ed_card_bg"));
                if (focused && mScrollView != null) {
                    mScrollView.postDelayed(new Runnable() {
                        public void run() {
                            mScrollView.fullScroll(View.FOCUS_DOWN);
                        }
                    }, 120L);
                }
            }
        });
        mTestInput.addTextChangedListener(new TextWatcher() {
            public void beforeTextChanged(CharSequence s, int start, int count, int after) { }

            public void onTextChanged(CharSequence s, int start, int before, int count) { }

            public void afterTextChanged(Editable s) {
                mTestClear.setVisibility(s == null || s.length() == 0 ? View.GONE : View.VISIBLE);
            }
        });
        mTestClear.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                mTestInput.getText().clear();
                mTestInput.requestFocus();
            }
        });

        // Android 11+: the keyboard shrinks the scroll area instead of covering the test field
        if (Build.VERSION.SDK_INT >= 30) {
            LinearLayout content = (LinearLayout) root.findViewWithTag("content");
            Api30ImeHelper.attach(mScrollView, content, dp(12.0f), dp(12.0f), dp(12.0f), dp(20.0f), new Runnable() {
                public void run() {
                    if (mTestInput != null && mTestInput.hasFocus()) {
                        mScrollView.post(new Runnable() {
                            public void run() {
                                mScrollView.fullScroll(View.FOCUS_DOWN);
                            }
                        });
                    }
                }
            });
        }
    }

    // ------------------------------------------------------------------ name/badge

    private void showRenameDialog() {
        View content = inflate("mr_sheet_ed_dialog_fields", null);
        final EditText nameField = SheetUi.makeEditText(this, mSheet.name, true);
        nameField.setText(mSheet.name);
        ((LinearLayout) content.findViewWithTag("name_slot")).addView(nameField);
        final EditText badgeField = SheetUi.makeEditText(this, mSheet.badge, true);
        badgeField.setFilters(new InputFilter[] { new InputFilter.LengthFilter(SheetModel.MAX_BADGE_LEN) });
        badgeField.setText(mSheet.badge);
        ((LinearLayout) content.findViewWithTag("badge_slot")).addView(badgeField);

        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheet_ed_rename_title"))
                .setView(content)
                .setPositiveButton(t("mr_sheet_ed_save"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        pushUndoSnapshot();
                        mSheet.name = SheetModel.sanitizeName(nameField.getText().toString(), mSheet.name);
                        mSheet.badge = SheetModel.sanitizeBadge(badgeField.getText().toString(), mSheet.badge);
                        persistAndRefresh();
                    }
                })
                .setNegativeButton(t("mr_sheet_ed_cancel"), null)
                .show();
    }

    // ------------------------------------------------------------------ rows

    private void showManageRowsDialog() {
        View content = inflate("mr_sheet_ed_dialog_rows", null);
        final LinearLayout list = (LinearLayout) content.findViewWithTag("rows_list");
        renderRows(list);
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheet_ed_rows_title"))
                .setView(content)
                .setPositiveButton(t("mr_sheet_ed_close"), null)
                .show();
    }

    /** One mr_sheet_ed_row_item per editable row; the list is rebuilt after every move/copy/remove. */
    private void renderRows(final LinearLayout list) {
        list.removeAllViews();
        for (int i = 0; i < mSheet.rows.size(); i++) {
            final int idx = i;
            final SheetModel.Row row = mSheet.rows.get(i);
            View item = inflate("mr_sheet_ed_row_item", list);
            ((TextView) item.findViewWithTag("label")).setText(t("mr_sheet_ed_row_line", i + 1, row.keys.size()));

            TextView up = rowButton(item, "up", i > 0, false);
            up.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (idx > 0) {
                        pushUndoSnapshot();
                        mSheet.rows.add(idx - 1, mSheet.rows.remove(idx));
                        persistAndRefresh();
                        renderRows(list);
                    }
                }
            });

            TextView down = rowButton(item, "down", i < mSheet.rows.size() - 1, false);
            down.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (idx < mSheet.rows.size() - 1) {
                        pushUndoSnapshot();
                        mSheet.rows.add(idx + 1, mSheet.rows.remove(idx));
                        persistAndRefresh();
                        renderRows(list);
                    }
                }
            });

            TextView dup = rowButton(item, "dup", mSheet.rows.size() < SheetModel.MAX_ROWS, false);
            dup.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mSheet.rows.size() < SheetModel.MAX_ROWS) {
                        pushUndoSnapshot();
                        mSheet.rows.add(idx + 1, mSheet.rows.get(idx).deepCopy());
                        persistAndRefresh();
                        renderRows(list);
                    }
                }
            });

            TextView del = rowButton(item, "del", mSheet.rows.size() > 1, true);
            del.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (mSheet.rows.size() > 1) {
                        pushUndoSnapshot();
                        mSheet.rows.remove(idx);
                        persistAndRefresh();
                        renderRows(list);
                    }
                }
            });

            list.addView(item);
        }
    }

    /** Small button of a row (↑ ↓ ⧉ ✕): a disabled one is dimmed and loses the ripple. */
    private TextView rowButton(View item, String tag, boolean enabled, boolean danger) {
        TextView b = (TextView) item.findViewWithTag(tag);
        b.setEnabled(enabled);
        if (!enabled) {
            b.setTextColor(color("mr_ui_text_dis"));
            b.setBackground(null);
        } else {
            b.setTextColor(color(danger ? "mr_ui_danger" : "mr_ui_cyan"));
        }
        return b;
    }

    // ------------------------------------------------------------------ overflow menu

    private void showOverflowMenu(View anchor) {
        ArrayList<SheetUi.MenuEntry> items = new ArrayList<SheetUi.MenuEntry>(5);
        items.add(new SheetUi.MenuEntry(1, SheetUi.ICON_RENAME, t("mr_sheet_ed_menu_rename")));
        items.add(new SheetUi.MenuEntry(2, SheetUi.ICON_ROWS, t("mr_sheet_ed_menu_rows")));
        if (mAllSheets != null && mAllSheets.size() < SheetModel.MAX_SHEETS) {
            items.add(new SheetUi.MenuEntry(3, SheetUi.ICON_DUPLICATE, t("mr_sheet_ed_menu_duplicate")));
        }
        if (mSheet.builtin) {
            items.add(new SheetUi.MenuEntry(4, SheetUi.ICON_RESTORE, t("mr_sheet_ed_menu_restore"),
                    SheetUi.TONE_WARNING, true));
        }
        items.add(new SheetUi.MenuEntry(5, SheetUi.ICON_DELETE, t("mr_sheet_ed_menu_delete"),
                SheetUi.TONE_DANGER, !mSheet.builtin));
        SheetUi.showPopupMenu(this, anchor, SheetModel.sanitizeBadge(mSheet.badge, "123"), mSheet.name, items,
                new SheetUi.OnMenuSelect() {
                    public void onSelect(int id) {
                        switch (id) {
                            case 1:
                                showRenameDialog();
                                break;
                            case 2:
                                showManageRowsDialog();
                                break;
                            case 3:
                                duplicateCurrentSheet();
                                break;
                            case 4:
                                confirmRestoreDefault();
                                break;
                            case 5:
                                confirmDeleteCurrentSheet();
                                break;
                            default:
                                break;
                        }
                    }
                });
    }

    private void duplicateCurrentSheet() {
        ArrayList<SheetModel.Sheet> all = SheetStore.getEditableCopy(this);
        if (all.size() >= SheetModel.MAX_SHEETS) {
            toast(t("mr_sheet_ed_limit_sheets"), false);
            return;
        }
        SheetModel.Sheet copy = mSheet.deepCopy();
        copy.id = SheetModel.makeUniqueId(all, "copy");
        copy.builtin = false;
        copy.name = SheetModel.sanitizeName(t("mr_sheet_ed_copy_suffix", mSheet.name), mSheet.name);
        int at = all.size();
        for (int i = 0; i < all.size(); i++) {
            if (all.get(i).id.equals(mSheet.id)) {
                at = i + 1;
                break;
            }
        }
        all.add(at, copy);
        SheetStore.save(this, all);
        mUndoStack.clear();
        mSheet = copy.deepCopy();
        mAllSheets = SheetStore.getEditableCopy(this);
        refreshUi();
        toast(t("mr_sheet_ed_duplicated"), false);
    }

    private void confirmDeleteCurrentSheet() {
        final ArrayList<SheetModel.Sheet> all = SheetStore.getEditableCopy(this);
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheet_ed_delete_title"))
                .setMessage(t("mr_sheet_ed_delete_msg", mSheet.name))
                .setPositiveButton(t("mr_sheet_ed_delete"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        for (int i = 0; i < all.size(); i++) {
                            if (all.get(i).id.equals(mSheet.id)) {
                                all.remove(i);
                                break;
                            }
                        }
                        SheetStore.save(SheetEditorActivity.this, all);
                        toast(t("mr_sheet_ed_deleted"), false);
                        finish();
                    }
                })
                .setNegativeButton(t("mr_sheet_ed_cancel"), null)
                .show();
    }

    private void confirmRestoreDefault() {
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheet_ed_restore_title"))
                .setMessage(t("mr_sheet_ed_restore_msg"))
                .setPositiveButton(t("mr_sheet_ed_restore"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        SheetModel.Sheet restored = SheetStore.loadDefaultBuiltinSheet(SheetEditorActivity.this, mSheet.id);
                        if (restored != null) {
                            pushUndoSnapshot();
                            mSheet = restored;
                            persistAndRefresh();
                            toast(t("mr_sheet_ed_restored"), false);
                        }
                    }
                })
                .setNegativeButton(t("mr_sheet_ed_cancel"), null)
                .show();
    }

    // ------------------------------------------------------------------ undo and render

    private void pushUndoSnapshot() {
        if (mUndoStack.size() >= UNDO_LIMIT) {
            mUndoStack.remove(0);
        }
        mUndoStack.add(mSheet.deepCopy());
    }

    private void performUndo() {
        if (mUndoStack.isEmpty()) {
            toast(t("mr_sheet_ed_nothing_undo"), false);
            return;
        }
        mSheet = mUndoStack.remove(mUndoStack.size() - 1);
        persistAndRefresh();
        toast(t("mr_sheet_ed_undone"), false);
    }

    private void persistAndRefresh() {
        SheetStore.updateSingleSheet(this, mSheet);
        mAllSheets = SheetStore.getEditableCopy(this);
        refreshUi();
    }

    private void refreshUi() {
        String badge = SheetModel.sanitizeBadge(mSheet.badge, "123");
        mBadgeChip.setText(badge);
        mTitleView.setText(mSheet.name);
        mSubtitleView.setText(t("mr_sheet_ed_subtitle", mSheet.rows.size(), mSheet.countKeys()));
        mUndoBtn.setAlpha(mUndoStack.isEmpty() ? 0.4f : 1.0f);
        mAddRowBtn.setAlpha(mSheet.rows.size() >= SheetModel.MAX_ROWS ? 0.45f : 1.0f);
        if (mTestLiveBadge != null) {
            mTestLiveBadge.setText(t("mr_sheet_ed_live", badge));
        }
        mGridView.setData(mSheet, mAllSheets);
    }

    // ------------------------------------------------------------------ keyboard insets (Android 11+)

    /** Keeps the quick test field above the keyboard: the scroll area gets the IME height as bottom padding. */
    private static final class Api30ImeHelper {
        private Api30ImeHelper() { }

        static void attach(View scroll, final View content, final int padLeft, final int padTop, final int padRight,
                final int padBottom, final Runnable onKeyboardShown) {
            scroll.setOnApplyWindowInsetsListener(new View.OnApplyWindowInsetsListener() {
                private int mLastExtra;

                public WindowInsets onApplyWindowInsets(View v, WindowInsets insets) {
                    int extra = insets.getInsets(WindowInsets.Type.ime()).bottom
                            - insets.getInsets(WindowInsets.Type.systemBars()).bottom;
                    extra = Math.max(0, extra);
                    if (extra != mLastExtra) {
                        boolean opened = extra > mLastExtra && extra > 0;
                        mLastExtra = extra;
                        content.setPadding(padLeft, padTop, padRight, padBottom + extra);
                        if (opened && onKeyboardShown != null) {
                            onKeyboardShown.run();
                        }
                    }
                    return insets;
                }
            });
            scroll.requestApplyInsets();
        }
    }
}
