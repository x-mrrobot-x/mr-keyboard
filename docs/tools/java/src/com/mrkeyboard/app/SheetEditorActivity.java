package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.TextWatcher;
import android.text.style.ForegroundColorSpan;
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
 * badge, the name and the count of rows and keys (a tap, or the pencil, changes the name and the badge), undo and the ⋮
 * menu, the hint, the buttons "+ Row" and "Arrange rows", the drawn key grid ({@link SheetGridView}) with the legend of
 * its colours, and the quick test field.
 *
 * The look is in XML, like the other settings screens: layout mr_sheet_ed_screen (the page), mr_sheet_ed_test_card (the
 * quick test card), mr_sheet_dialog_fields (name and badge, through SheetNameDialog, the same dialog as the list) and
 * mr_sheet_ed_dialog_rows + mr_sheet_ed_row_item (arrange rows), with the drawables mr_sheet_ed_*. The colors are the ones
 * of the settings palette (@color/mr_ui_*) and the texts are in mr_strings.xml (mr_sheet_ed_*, in English, Portuguese and
 * Spanish); this class only fills in what changes and keeps the behavior: the undo stack (every change can be undone, up
 * to {@link #UNDO_LIMIT}; undo is dimmed and off when there is nothing to undo), the drag of a key, the key editor, the
 * quick test field state (MrScreenIme) and the insets of the keyboard on Android 11+.
 *
 * Quick test: the field tells the keyboard which sheet it is testing (MrSheetTest.option in its privateImeOptions), so the
 * keyboard opens on this sheet and stays on it while the person types there; after a duplicate the field follows the copy.
 *
 * One dialog at a time: a second tap on a key, on "+" or on a button while a dialog of this screen is open is ignored
 * (two quick taps used to open two key editors, one over the other). A sheet that no longer exists (deleted while the
 * screen was in the background) closes the editor with a note, instead of editing another sheet in its place.
 * The views are found by android:tag, so no id is needed (public.xml is not touched).
 */
public class SheetEditorActivity extends Activity {
    /** Extra read by PrefScreenSheets and SettingsHeader: the id of the sheet to edit. */
    public static final String EXTRA_SHEET_ID = "sheet_id";

    /** How many changes can be undone (the old screen kept 20). */
    static final int UNDO_LIMIT = 20;

    /** Characters of the keys shown in the preview of a row of "Arrange rows" before it is cut. */
    static final int ROW_PREVIEW_MAX = 48;

    private List<SheetModel.Sheet> mAllSheets;
    private SheetModel.Sheet mSheet;
    private final ArrayList<SheetModel.Sheet> mUndoStack = new ArrayList<SheetModel.Sheet>();

    private TextView mBadgeChip;
    private TextView mTitleView;
    private TextView mSubtitleView;
    private ImageView mUndoBtn;
    private TextView mAddRowBtn;
    private TextView mLegend;
    private ScrollView mScrollView;
    private SheetGridView mGridView;
    private View mTestCard;
    private View mTestFieldRow;
    private View mTestClear;
    private ImageView mTestFieldIcon;
    private EditText mTestInput;
    private TextView mTestLiveBadge;
    /** The dialog this screen opened last (key editor, name and badge, rows, confirmations): one at a time. */
    private AlertDialog mDialog;

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

    /** A dialog of this screen is open: a second tap does not open another one over it. */
    boolean busy() {
        return mDialog != null && mDialog.isShowing();
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
            if (mSheet == null) {
                // the sheet was deleted (or the list replaced) while this screen waited in the background
                toast(t("mr_sheet_ed_gone"), false);
                finish();
                return;
            }
        } else if (mAllSheets != null && !mAllSheets.isEmpty()) {
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
        mUndoBtn = (ImageView) root.findViewWithTag("undo");
        mAddRowBtn = (TextView) root.findViewWithTag("add_row");
        mLegend = (TextView) root.findViewWithTag("legend");
        mScrollView = (ScrollView) root.findViewWithTag("scroll");

        bindHeader(root);
        bindToolbar(root);
        bindGrid(root);
        bindLegend();
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

        // badge + name + count, and the pencil: a tap changes the name and the badge
        View pill = root.findViewWithTag("header_pill");
        pill.setContentDescription(t("mr_sheet_ed_rename_desc"));
        pill.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showRenameDialog();
            }
        });
        ((ImageView) root.findViewWithTag("edit_icon")).setImageDrawable(
                new SheetUi.IconDrawable(this, SheetUi.ICON_RENAME, color("mr_ui_text3"), dp(16)));

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
    }

    private void addRow() {
        if (mSheet.rows.size() < SheetModel.MAX_ROWS) {
            pushUndoSnapshot();
            mSheet.rows.add(new SheetModel.Row());
            persistAndRefresh();
            return;
        }
        toast(t("mr_sheet_ed_rows_limit", Integer.valueOf(SheetModel.MAX_ROWS)), false);
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

            public void onDropRefused(int row) {
                toast(t("mr_sheet_ed_row_limit", Integer.valueOf(maxKeysOfRow(row))), false);
            }
        });
        LinearLayout slot = (LinearLayout) root.findViewWithTag("grid_slot");
        slot.addView(mGridView, new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT));
    }

    /** Maximum of keys of a row: the last row has the locked "⌫" of the grid, so it takes one key less. */
    private int maxKeysOfRow(int row) {
        return row == mSheet.rows.size() - 1 ? SheetModel.MAX_KEYS_LAST_ROW_ADD : SheetModel.MAX_KEYS_PER_ROW;
    }

    private void addNewKeyToRow(int row) {
        if (busy() || row < 0 || row >= mSheet.rows.size()) return;
        final SheetModel.Row target = mSheet.rows.get(row);
        if (target.keys.size() >= maxKeysOfRow(row)) {
            toast(t("mr_sheet_ed_row_limit", Integer.valueOf(maxKeysOfRow(row))), false);
            return;
        }
        // null label/value: SheetModel.KeySpec turns them into an empty text (a new key starts empty)
        mDialog = KeyEditDialog.show(this, mAllSheets, new SheetModel.KeySpec(null, SheetModel.TYPE_TEXT, null, 1.0f),
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
        if (busy() || row < 0 || row >= mSheet.rows.size()) return;
        final SheetModel.Row target = mSheet.rows.get(row);
        if (index < 0 || index >= target.keys.size()) return;
        final SheetModel.KeySpec key = target.keys.get(index);
        boolean canAddKey = target.keys.size() < maxKeysOfRow(row);
        mDialog = KeyEditDialog.show(this, mAllSheets, key, index > 0, index < target.keys.size() - 1, canAddKey, true,
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
        if (to.keys.size() >= maxKeysOfRow(toRow)) {
            toast(t("mr_sheet_ed_row_limit", Integer.valueOf(maxKeysOfRow(toRow))), false);
            return;
        }
        pushUndoSnapshot();
        to.keys.add(Math.max(0, Math.min(to.keys.size(), toIndex)), from.keys.remove(fromKey));
        persistAndRefresh();
    }

    // ------------------------------------------------------------------ legend

    /** The colours of the grid with their names, on one line that wraps: text, Tasker, sheet switch, special and gap. */
    private void bindLegend() {
        mLegend.setText(legend(new String[] { t("mr_sheet_ed_legend_text"), t("mr_sheet_ed_legend_tasker"),
                t("mr_sheet_ed_legend_sheet"), t("mr_sheet_ed_legend_special"), t("mr_sheet_ed_legend_spacer") },
                new int[] { color("mr_ui_text3"), color("mr_ui_amber"), color("mr_ui_blue"), color("mr_ui_violet"),
                        color("mr_ui_text3") }));
    }

    /**
     * The text of the legend: a coloured mark before each name ("●", the gap a hollow "○"), the mark and its name held together by a no-break
     * space, and the entries apart by spaces where the line can wrap.
     */
    static CharSequence legend(String[] names, int[] colors) {
        SpannableStringBuilder sb = new SpannableStringBuilder(new String());
        for (int i = 0; i < names.length; i++) {
            if (i > 0) sb.append("    ");
            int start = sb.length();
            sb.append(i == names.length - 1 ? "○" : "●");
            sb.setSpan(new ForegroundColorSpan(colors[i]), start, start + 1, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            sb.append(" " + names[i].replace(' ', ' '));
        }
        return sb;
    }

    // ------------------------------------------------------------------ quick test card

    private void bindTestCard(View root) {
        mTestCard = root.findViewWithTag("test_card");
        mTestFieldRow = root.findViewWithTag("test_field_row");
        mTestClear = root.findViewWithTag("test_clear");
        mTestFieldIcon = (ImageView) root.findViewWithTag("test_field_icon");
        mTestInput = (EditText) root.findViewWithTag("test_input");
        mTestLiveBadge = (TextView) root.findViewWithTag("test_badge");
        // the keyboard opens on this sheet and stays on it in this field (MrSheetTest)
        mTestInput.setPrivateImeOptions(MrSheetTest.option(mSheet.id));

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
                mTestCard.setBackgroundResource(drawable(focused ? "mr_sheet_ed_card_bg_on" : MrMatrix.wanted(SheetEditorActivity.this) ? "mr_ui_card_shape_glass" : "mr_ui_card_shape"));
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

    /** The sheet changed its id (a duplicate is edited now): the test field asks the keyboard for the new one at once if it has it open. */
    private void retargetTestField() {
        if (mTestInput == null) return;
        mTestInput.setPrivateImeOptions(MrSheetTest.option(mSheet.id));
        if (!mTestInput.hasFocus()) return;
        try {
            InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
            if (imm != null) imm.restartInput(mTestInput);
        } catch (Throwable ignored) {
        }
    }

    // ------------------------------------------------------------------ name/badge

    private void showRenameDialog() {
        if (busy()) return;
        mDialog = SheetNameDialog.show(this, t("mr_sheets_rename_title"), t("mr_sheets_save"), t("mr_sheet_ed_cancel"),
                mSheet.name, mSheet.badge, new SheetNameDialog.OnNamed() {
                    public void onNamed(String name, String badge) {
                        String newName = SheetModel.sanitizeName(name, mSheet.name);
                        String newBadge = SheetModel.sanitizeBadge(badge, mSheet.badge);
                        // nothing changed: no step to undo
                        if (newName.equals(mSheet.name) && newBadge.equals(mSheet.badge)) return;
                        pushUndoSnapshot();
                        mSheet.name = newName;
                        mSheet.badge = newBadge;
                        persistAndRefresh();
                    }
                });
    }

    // ------------------------------------------------------------------ rows

    private void showManageRowsDialog() {
        if (busy()) return;
        View content = inflate("mr_sheet_ed_dialog_rows", null);
        final LinearLayout list = (LinearLayout) content.findViewWithTag("rows_list");
        renderRows(list);
        mDialog = new AlertDialog.Builder(this)
                .setTitle(t("mr_sheet_ed_rows_title"))
                .setView(content)
                .setPositiveButton(t("mr_sheet_ed_close"), null)
                .show();
    }

    /**
     * The labels of the keys of a row, the way the grid shows them, apart by two spaces (a gap is "␣"), cut at {@link #ROW_PREVIEW_MAX}
     * characters with "…"; {@code empty} for a row with no keys. It tells the rows of "Arrange rows" apart.
     */
    static String rowPreview(SheetModel.Row row, List<SheetModel.Sheet> sheets, String empty) {
        if (row == null || row.keys.isEmpty()) return empty;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < row.keys.size(); i++) {
            SheetModel.KeySpec key = row.keys.get(i);
            String label = SheetModel.TYPE_SPACER.equals(key.type) ? "␣" : SheetKeyboardBuilder.effectiveDisplayLabel(key, sheets);
            if (label == null || label.trim().length() == 0) label = "␣";
            label = label.replace('\n', '↵');
            if (sb.length() > 0) sb.append("  ");
            sb.append(label);
            if (sb.length() > ROW_PREVIEW_MAX) return sb.substring(0, ROW_PREVIEW_MAX) + "…";
        }
        return sb.toString();
    }

    /** One mr_sheet_ed_row_item per editable row; the list is rebuilt after every move/copy/remove. */
    private void renderRows(final LinearLayout list) {
        list.removeAllViews();
        for (int i = 0; i < mSheet.rows.size(); i++) {
            final int idx = i;
            final SheetModel.Row row = mSheet.rows.get(i);
            View item = inflate("mr_sheet_ed_row_item", list);
            ((TextView) item.findViewWithTag("label")).setText(
                    t("mr_sheet_ed_row_line", Integer.valueOf(i + 1), Integer.valueOf(row.keys.size())));
            ((TextView) item.findViewWithTag("keys")).setText(rowPreview(row, mAllSheets, t("mr_sheet_ed_row_empty")));
            Integer number = Integer.valueOf(i + 1);

            rowButton(item, "up", SheetUi.ICON_ARROW_UP, i > 0, false, t("mr_sheet_ed_row_up", number),
                    new View.OnClickListener() {
                        public void onClick(View v) {
                            if (idx > 0) {
                                pushUndoSnapshot();
                                mSheet.rows.add(idx - 1, mSheet.rows.remove(idx));
                                persistAndRefresh();
                                renderRows(list);
                            }
                        }
                    });

            rowButton(item, "down", SheetUi.ICON_ARROW_DOWN, i < mSheet.rows.size() - 1, false,
                    t("mr_sheet_ed_row_down", number), new View.OnClickListener() {
                        public void onClick(View v) {
                            if (idx < mSheet.rows.size() - 1) {
                                pushUndoSnapshot();
                                mSheet.rows.add(idx + 1, mSheet.rows.remove(idx));
                                persistAndRefresh();
                                renderRows(list);
                            }
                        }
                    });

            rowButton(item, "dup", SheetUi.ICON_DUPLICATE, mSheet.rows.size() < SheetModel.MAX_ROWS, false,
                    t("mr_sheet_ed_row_dup", number), new View.OnClickListener() {
                        public void onClick(View v) {
                            if (mSheet.rows.size() < SheetModel.MAX_ROWS) {
                                pushUndoSnapshot();
                                mSheet.rows.add(idx + 1, mSheet.rows.get(idx).deepCopy());
                                persistAndRefresh();
                                renderRows(list);
                            }
                        }
                    });

            rowButton(item, "del", SheetUi.ICON_DELETE, mSheet.rows.size() > 1, true, t("mr_sheet_ed_row_del", number),
                    new View.OnClickListener() {
                        public void onClick(View v) {
                            if (mSheet.rows.size() > 1) {
                                boolean hadKeys = !mSheet.rows.get(idx).keys.isEmpty();
                                pushUndoSnapshot();
                                mSheet.rows.remove(idx);
                                persistAndRefresh();
                                renderRows(list);
                                // a row with keys can come back: say how
                                if (hadKeys) toast(t("mr_sheet_ed_row_deleted"), false);
                            }
                        }
                    });

            list.addView(item);
        }
    }

    /** Small drawn button of a row (up, down, duplicate, delete): a disabled one is dimmed, loses the ripple and does nothing. */
    private void rowButton(View item, String tag, int icon, boolean enabled, boolean danger, String description,
            View.OnClickListener click) {
        ImageView b = (ImageView) item.findViewWithTag(tag);
        b.setImageDrawable(new SheetUi.IconDrawable(this, icon,
                color(!enabled ? "mr_ui_text_dis" : danger ? "mr_ui_danger" : "mr_ui_cyan"), dp(18)));
        b.setContentDescription(description);
        b.setEnabled(enabled);
        if (enabled) {
            b.setOnClickListener(click);
        } else {
            b.setBackground(null);
        }
    }

    // ------------------------------------------------------------------ overflow menu

    private void showOverflowMenu(View anchor) {
        if (busy()) return;
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
            toast(t("mr_sheet_ed_limit_sheets", Integer.valueOf(SheetModel.MAX_SHEETS)), false);
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
        retargetTestField();
        toast(t("mr_sheet_ed_duplicated"), false);
    }

    private void confirmDeleteCurrentSheet() {
        if (busy()) return;
        final ArrayList<SheetModel.Sheet> all = SheetStore.getEditableCopy(this);
        mDialog = new AlertDialog.Builder(this)
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
        if (busy()) return;
        mDialog = new AlertDialog.Builder(this)
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
        mSubtitleView.setText(t("mr_sheet_ed_subtitle", Integer.valueOf(mSheet.rows.size()),
                Integer.valueOf(SheetModel.MAX_ROWS), Integer.valueOf(mSheet.countKeys())));
        boolean canUndo = !mUndoStack.isEmpty();
        mUndoBtn.setEnabled(canUndo);
        mUndoBtn.setAlpha(canUndo ? 1.0f : 0.35f);
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
