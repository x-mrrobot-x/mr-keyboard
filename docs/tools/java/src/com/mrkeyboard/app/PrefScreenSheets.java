package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.InputFilter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

/**
 * "Folhas do teclado" (keyboard sheets) page: the fixed ABC card, the "return to the main sheet" switch, the list of editable
 * sheets (order of the cycle) with move up/down, rename, duplicate, restore and delete, the "new sheet" templates and the JSON
 * backup (export, import, restore all).
 *
 * The look is in XML, like the other settings screens: layout/mr_sheets_screen (the page), mr_sheet_card (one sheet),
 * mr_sheet_fixed_card (ABC), mr_sheet_button (+ _danger), mr_sheet_empty and mr_sheet_dialog_fields, with the drawables
 * mr_sheet_* and mr_ui_card_ripple. The colors come from the settings palette (@color/mr_ui_*) and the texts from
 * mr_strings.xml (mr_sheets_*, in English, Portuguese and Spanish); this class only fills in what changes (texts of the
 * sheets, the drawn icons, the clicks). The views are found by android:tag, so no id is needed.
 * The icons are the drawn ones of SheetUi and the data is the SheetStore/SheetModel (smali, hand written).
 */
public class PrefScreenSheets extends Activity {
    private static final int REQ_EXPORT_JSON = 0x1005;
    private static final int REQ_IMPORT_JSON = 0x1006;

    private ArrayList<SheetModel.Sheet> mSheets;
    private LinearLayout mListContainer;
    private TextView mSubtitleView;
    private TextView mNewSheetBtn;

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

    private int dp(float v) {
        return SheetUi.dp(this, v);
    }

    private void toast(String text, boolean longer) {
        Toast.makeText(this, text, longer ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT).show();
    }

    // ------------------------------------------------------------------ life cycle

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        View root = inflate("mr_sheets_screen", null);
        mSubtitleView = (TextView) root.findViewWithTag("subtitle");
        mListContainer = (LinearLayout) root.findViewWithTag("list");
        mNewSheetBtn = (TextView) root.findViewWithTag("new_btn");

        // header: back and more (drawn icons of the sheet screens)
        ImageView back = SheetUi.makeIconButton(this, SheetUi.ICON_BACK, color("mr_ui_text"), 40, t("mr_sheets_back"));
        back.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        slot(root, "back_slot").addView(back, new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
        final ImageView menuBtn = SheetUi.makeIconButton(this, SheetUi.ICON_MORE_VERT, color("mr_ui_text"), 40, t("mr_sheets_more"));
        menuBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showHeaderMenu(menuBtn);
            }
        });
        slot(root, "more_slot").addView(menuBtn, new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));

        // fixed ABC card: just the lock icon is drawn
        ImageView lock = (ImageView) root.findViewWithTag("lock");
        lock.setImageDrawable(new SheetUi.IconDrawable(this, SheetUi.ICON_LOCK, color("mr_ui_text3"), dp(20)));

        // switch "return to the main sheet when typing"
        slot(root, "option_slot").addView(MrSheetOpt.row(this));

        mNewSheetBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showNewSheetTemplatePicker();
            }
        });

        // export, import and restore all
        LinearLayout ioRow = slot(root, "io_row");
        View export = secondaryButton(ioRow, false, SheetUi.ICON_EXPORT, "mr_ui_mint", "mr_sheets_export_btn");
        export.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                startExportJson();
            }
        });
        LinearLayout.LayoutParams first = new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f);
        first.setMargins(0, 0, dp(8), 0);
        ioRow.addView(export, first);
        View imp = secondaryButton(ioRow, false, SheetUi.ICON_IMPORT, "mr_ui_cyan", "mr_sheets_import_btn");
        imp.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                startImportJson();
            }
        });
        ioRow.addView(imp, new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1f));

        LinearLayout restoreSlot = slot(root, "restore_slot");
        View restore = secondaryButton(restoreSlot, true, SheetUi.ICON_RESTORE, "mr_ui_danger", "mr_sheets_restore_all");
        restore.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                confirmResetAll();
            }
        });
        restoreSlot.addView(restore);

        setContentView(root);
    }

    @Override
    protected void onResume() {
        super.onResume();
        reloadAndRender();
        if (SheetStore.consumeCorruptRecoveryFlag()) {
            toast(t("mr_sheets_corrupt"), true);
        }
    }

    private LinearLayout slot(View root, String tag) {
        return (LinearLayout) root.findViewWithTag(tag);
    }

    /** Button of the bottom of the page (layout mr_sheet_button / mr_sheet_button_danger) with a drawn icon. */
    private View secondaryButton(ViewGroup parent, boolean danger, int icon, String iconColor, String label) {
        View b = inflate(danger ? "mr_sheet_button_danger" : "mr_sheet_button", parent);
        ((ImageView) b.findViewWithTag("icon")).setImageDrawable(
                new SheetUi.IconDrawable(this, icon, color(iconColor), dp(16)));
        ((TextView) b.findViewWithTag("label")).setText(t(label));
        return b;
    }

    // ------------------------------------------------------------------ list

    private void reloadAndRender() {
        mSheets = SheetStore.getEditableCopy(this);
        mSubtitleView.setText(t("mr_sheets_subtitle", mSheets.size(), SheetModel.MAX_SHEETS));
        mNewSheetBtn.setAlpha(mSheets.size() < SheetModel.MAX_SHEETS ? 1.0f : 0.45f);
        mListContainer.removeAllViews();
        int n = mSheets.size();
        if (n == 0) {
            mListContainer.addView(inflate("mr_sheet_empty", mListContainer));
            return;
        }
        for (int i = 0; i < n; i++) {
            mListContainer.addView(buildSheetCard(i, mSheets.get(i)));
        }
    }

    private View buildSheetCard(final int idx, final SheetModel.Sheet sheet) {
        View card = inflate("mr_sheet_card", mListContainer);
        ((TextView) card.findViewWithTag("badge")).setText(SheetModel.sanitizeBadge(sheet.badge, "123"));
        ((TextView) card.findViewWithTag("name")).setText(sheet.name);
        String kind = t(sheet.builtin ? "mr_sheets_builtin" : "mr_sheets_custom");
        ((TextView) card.findViewWithTag("info")).setText(
                t("mr_sheets_card_info", sheet.rows.size(), sheet.countKeys(), kind));
        card.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                openEditor(sheet.id);
            }
        });

        ImageView up = actionIcon(card, "up", SheetUi.ICON_ARROW_UP, idx > 0);
        if (idx > 0) {
            up.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    moveSheet(idx, idx - 1);
                }
            });
        }
        boolean canDown = idx < mSheets.size() - 1;
        ImageView down = actionIcon(card, "down", SheetUi.ICON_ARROW_DOWN, canDown);
        if (canDown) {
            down.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    moveSheet(idx, idx + 1);
                }
            });
        }
        final ImageView more = actionIcon(card, "more", SheetUi.ICON_MORE_VERT, true);
        more.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showCardContextMenu(more, idx, sheet);
            }
        });
        return card;
    }

    /** Small drawn icon of a card; a disabled one is dimmed and has no ripple (the ripple is in the XML). */
    private ImageView actionIcon(View card, String tag, int kind, boolean enabled) {
        ImageView v = (ImageView) card.findViewWithTag(tag);
        v.setImageDrawable(new SheetUi.IconDrawable(this, kind,
                color(enabled ? "mr_ui_text2" : "mr_ui_text_dis"), dp(18)));
        v.setEnabled(enabled);
        if (!enabled) v.setBackground(null);
        return v;
    }

    // ------------------------------------------------------------------ menus

    private void showHeaderMenu(View anchor) {
        ArrayList<SheetUi.MenuEntry> items = new ArrayList<SheetUi.MenuEntry>(3);
        items.add(new SheetUi.MenuEntry(1, SheetUi.ICON_EXPORT, t("mr_sheets_menu_export")));
        items.add(new SheetUi.MenuEntry(2, SheetUi.ICON_IMPORT, t("mr_sheets_menu_import")));
        items.add(new SheetUi.MenuEntry(3, SheetUi.ICON_RESTORE, t("mr_sheets_restore_all"), SheetUi.TONE_WARNING, true));
        SheetUi.showPopupMenu(this, anchor, "JSON", t("mr_sheets_menu_subtitle"), items, new SheetUi.OnMenuSelect() {
            public void onSelect(int id) {
                if (id == 1) startExportJson();
                else if (id == 2) startImportJson();
                else if (id == 3) confirmResetAll();
            }
        });
    }

    private void showCardContextMenu(View anchor, final int idx, final SheetModel.Sheet sheet) {
        ArrayList<SheetUi.MenuEntry> items = new ArrayList<SheetUi.MenuEntry>(6);
        items.add(new SheetUi.MenuEntry(1, SheetUi.ICON_EDIT_KEYS, t("mr_sheets_menu_edit")));
        items.add(new SheetUi.MenuEntry(2, SheetUi.ICON_RENAME, t("mr_sheets_menu_rename")));
        if (idx > 0) items.add(new SheetUi.MenuEntry(3, SheetUi.ICON_ARROW_UP, t("mr_sheets_menu_up")));
        if (idx < mSheets.size() - 1) items.add(new SheetUi.MenuEntry(4, SheetUi.ICON_ARROW_DOWN, t("mr_sheets_menu_down")));
        items.add(new SheetUi.MenuEntry(5, SheetUi.ICON_DUPLICATE, t("mr_sheets_menu_duplicate")));
        if (sheet.builtin) {
            items.add(new SheetUi.MenuEntry(6, SheetUi.ICON_RESTORE, t("mr_sheets_menu_restore"), SheetUi.TONE_WARNING, true));
        }
        items.add(new SheetUi.MenuEntry(7, SheetUi.ICON_DELETE, t("mr_sheets_menu_delete"), SheetUi.TONE_DANGER, !sheet.builtin));
        SheetUi.showPopupMenu(this, anchor, SheetModel.sanitizeBadge(sheet.badge, "123"), sheet.name, items,
                new SheetUi.OnMenuSelect() {
                    public void onSelect(int id) {
                        switch (id) {
                            case 1: openEditor(sheet.id); break;
                            case 2: showRenameSheetDialog(sheet); break;
                            case 3: moveSheet(idx, idx - 1); break;
                            case 4: moveSheet(idx, idx + 1); break;
                            case 5: duplicateSheet(idx, sheet); break;
                            case 6: confirmResetSingleBuiltin(sheet); break;
                            case 7: confirmDeleteSheet(idx, sheet); break;
                            default: break;
                        }
                    }
                });
    }

    // ------------------------------------------------------------------ actions on the list

    private void moveSheet(int from, int to) {
        if (from < 0 || from >= mSheets.size() || to < 0 || to >= mSheets.size()) return;
        SheetModel.Sheet s = mSheets.remove(from);
        mSheets.add(to, s);
        SheetStore.save(this, mSheets);
        reloadAndRender();
    }

    private void openEditor(String sheetId) {
        Intent i = new Intent(this, SheetEditorActivity.class);
        i.putExtra("sheet_id", sheetId);
        startActivity(i);
    }

    private boolean limitReached() {
        if (mSheets.size() >= SheetModel.MAX_SHEETS) {
            toast(t("mr_sheets_limit", SheetModel.MAX_SHEETS), false);
            return true;
        }
        return false;
    }

    private void duplicateSheet(int idx, SheetModel.Sheet sheet) {
        if (limitReached()) return;
        SheetModel.Sheet copy = sheet.deepCopy();
        copy.id = SheetModel.makeUniqueId(mSheets, "copy");
        copy.builtin = false;
        copy.name = SheetModel.sanitizeName(t("mr_sheets_copy_name", sheet.name), sheet.name);
        mSheets.add(idx + 1, copy);
        SheetStore.save(this, mSheets);
        reloadAndRender();
    }

    private void showNewSheetTemplatePicker() {
        if (limitReached()) return;
        boolean hasSheets = !mSheets.isEmpty();
        CharSequence[] items = new CharSequence[hasSheets ? 4 : 3];
        items[0] = t("mr_sheets_tpl_blank");
        items[1] = t("mr_sheets_tpl_numpad");
        items[2] = t("mr_sheets_tpl_nav");
        if (hasSheets) items[3] = t("mr_sheets_tpl_copy");
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_tpl_title"))
                .setItems(items, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        if (which == 3) pickExistingSheetToCopy();
                        else promptNameForNewSheet(which, null);
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    private void pickExistingSheetToCopy() {
        int n = mSheets.size();
        if (n <= 0) return;
        CharSequence[] items = new CharSequence[n];
        for (int i = 0; i < n; i++) {
            SheetModel.Sheet s = mSheets.get(i);
            items[i] = "[" + s.badge + "] " + s.name;
        }
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_copy_title"))
                .setItems(items, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        promptNameForNewSheet(3, mSheets.get(which));
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    /** Dialog with the name and the badge fields (layout mr_sheet_dialog_fields); the two fields are made by SheetUi. */
    private View dialogFields(String badgeLabel, String name, String badge, EditText[] out) {
        View v = inflate("mr_sheet_dialog_fields", null);
        ((TextView) v.findViewWithTag("badge_label")).setText(badgeLabel);
        EditText nameEt = SheetUi.makeEditText(this, name, true);
        nameEt.setText(name);
        slot(v, "name_slot").addView(nameEt);
        EditText badgeEt = SheetUi.makeEditText(this, badge, true);
        badgeEt.setFilters(new InputFilter[] { new InputFilter.LengthFilter(SheetModel.MAX_BADGE_LEN) });
        badgeEt.setText(badge);
        slot(v, "badge_slot").addView(badgeEt);
        out[0] = nameEt;
        out[1] = badgeEt;
        return v;
    }

    /** templateKind: 0 blank, 1 numpad, 2 navigation/editing, 3 copy of {@code source}. */
    private void promptNameForNewSheet(final int templateKind, final SheetModel.Sheet source) {
        final String fallbackName;
        final String fallbackBadge;
        if (templateKind == 1) {
            fallbackName = t("mr_sheets_default_numpad");
            fallbackBadge = "NUM";
        } else if (templateKind == 2) {
            fallbackName = t("mr_sheets_default_nav");
            fallbackBadge = "NAV";
        } else if (source != null) {
            fallbackName = source.name + " 2";
            fallbackBadge = source.badge;
        } else {
            int n = mSheets.size() + 1;
            fallbackName = t("mr_sheets_default_name", n);
            fallbackBadge = "F" + n;
        }
        final EditText[] fields = new EditText[2];
        View content = dialogFields(t("mr_sheets_badge_label_new"), fallbackName, fallbackBadge, fields);
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_new_title"))
                .setView(content)
                .setPositiveButton(t("mr_sheets_create_edit"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        String id = SheetModel.makeUniqueId(mSheets, "custom");
                        String name = SheetModel.sanitizeName(fields[0].getText().toString(), fallbackName);
                        String badge = SheetModel.sanitizeBadge(fields[1].getText().toString(), fallbackBadge);
                        SheetModel.Sheet s;
                        if (templateKind == 1) {
                            s = SheetModel.createNumpadTemplate(id, name, badge);
                        } else if (templateKind == 2) {
                            s = SheetModel.createNavEditTemplate(id, name, badge);
                        } else if (source != null) {
                            s = source.deepCopy();
                            s.id = id;
                            s.name = name;
                            s.badge = badge;
                            s.builtin = false;
                        } else {
                            s = SheetModel.createBlankTemplate(id, name, badge);
                        }
                        mSheets.add(s);
                        SheetStore.save(PrefScreenSheets.this, mSheets);
                        reloadAndRender();
                        openEditor(s.id);
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    private void showRenameSheetDialog(final SheetModel.Sheet sheet) {
        final EditText[] fields = new EditText[2];
        View content = dialogFields(t("mr_sheets_badge_label_edit"), sheet.name, sheet.badge, fields);
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_rename_title"))
                .setView(content)
                .setPositiveButton(t("mr_sheets_save"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        sheet.name = SheetModel.sanitizeName(fields[0].getText().toString(), sheet.name);
                        sheet.badge = SheetModel.sanitizeBadge(fields[1].getText().toString(), sheet.badge);
                        SheetStore.save(PrefScreenSheets.this, mSheets);
                        reloadAndRender();
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    private void confirmDeleteSheet(final int idx, SheetModel.Sheet sheet) {
        if (idx < 0 || idx >= mSheets.size()) return;
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_delete_title"))
                .setMessage(t("mr_sheets_delete_msg", sheet.name))
                .setPositiveButton(t("mr_sheets_delete"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        mSheets.remove(idx);
                        SheetStore.save(PrefScreenSheets.this, mSheets);
                        reloadAndRender();
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    private void confirmResetSingleBuiltin(final SheetModel.Sheet sheet) {
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_reset_one_title"))
                .setMessage(t("mr_sheets_reset_one_msg", sheet.name))
                .setPositiveButton(t("mr_sheets_reset_one_ok"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        if (SheetStore.resetBuiltinSheet(PrefScreenSheets.this, sheet.id)) {
                            reloadAndRender();
                            toast(t("mr_sheets_toast_restored"), false);
                        }
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    private void confirmResetAll() {
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_reset_all_title"))
                .setMessage(t("mr_sheets_reset_all_msg"))
                .setPositiveButton(t("mr_sheets_reset_all_ok"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        if (SheetStore.resetAllToDefaults(PrefScreenSheets.this)) {
                            reloadAndRender();
                            toast(t("mr_sheets_toast_restored_all"), false);
                        }
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }

    // ------------------------------------------------------------------ JSON backup

    private void startExportJson() {
        try {
            Intent i = new Intent(Intent.ACTION_CREATE_DOCUMENT);
            i.addCategory(Intent.CATEGORY_OPENABLE);
            i.setType("application/json");
            i.putExtra(Intent.EXTRA_TITLE, "mr-keyboard-sheets.json");
            startActivityForResult(i, REQ_EXPORT_JSON);
        } catch (Exception e) {
            toast(t("mr_sheets_picker_error"), false);
        }
    }

    private void startImportJson() {
        try {
            Intent i = new Intent(Intent.ACTION_OPEN_DOCUMENT);
            i.addCategory(Intent.CATEGORY_OPENABLE);
            i.setType("*/*");
            i.putExtra(Intent.EXTRA_MIME_TYPES, new String[] { "application/json", "text/plain", "application/octet-stream" });
            startActivityForResult(i, REQ_IMPORT_JSON);
        } catch (Exception e) {
            toast(t("mr_sheets_picker_error"), false);
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null) return;
        final Uri uri = data.getData();
        if (uri == null) return;
        if (requestCode == REQ_EXPORT_JSON) {
            try {
                String json = SheetStore.exportJsonString(this);
                OutputStream os = getContentResolver().openOutputStream(uri);
                if (os == null) return;
                try {
                    os.write(json.getBytes("UTF-8"));
                    os.flush();
                } finally {
                    os.close();
                }
                toast(t("mr_sheets_exported"), false);
            } catch (Exception e) {
                toast(t("mr_sheets_export_failed", e.getMessage()), true);
            }
        } else if (requestCode == REQ_IMPORT_JSON) {
            try {
                InputStream in = getContentResolver().openInputStream(uri);
                if (in == null) return;
                final String raw;
                try {
                    raw = SheetStore.readStreamUtf8(in);
                } finally {
                    in.close();
                }
                ArrayList<SheetModel.Sheet> parsed = SheetModel.parseSheets(raw);
                new AlertDialog.Builder(this)
                        .setTitle(t("mr_sheets_import_title"))
                        .setMessage(t("mr_sheets_import_msg", parsed.size()))
                        .setPositiveButton(t("mr_sheets_import"), new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                try {
                                    int n = SheetStore.importJsonString(PrefScreenSheets.this, raw);
                                    reloadAndRender();
                                    toast(t("mr_sheets_imported", n), false);
                                } catch (Exception e) {
                                    toast(t("mr_sheets_import_bad", e.getMessage()), true);
                                }
                            }
                        })
                        .setNegativeButton(t("mr_sheets_cancel"), null)
                        .show();
            } catch (Exception e) {
                toast(t("mr_sheets_import_bad_file", e.getMessage()), true);
            }
        }
    }
}
