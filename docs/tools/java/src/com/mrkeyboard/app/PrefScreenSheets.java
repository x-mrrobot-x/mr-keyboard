package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.SystemClock;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

/**
 * "Folhas do teclado" (keyboard sheets) page: the "return to the main sheet" switch, the list of sheets with ABC as its first card (it is
 * edited as any sheet, MrAbcKeys, but has a padlock where the others have up and down, and no Delete), the list of the
 * sheets in the order of the cycle (with its note) and, on each card, move up/down and the menu (edit, name and badge, move,
 * duplicate, restore, delete); the "+ New sheet" button with its templates; and the backup section (export, import, restore
 * the default sheets). The backup lives in that section only: the ⋮ of the header that repeated it is gone.
 *
 * The look is in XML, like the other settings screens: layout/mr_sheets_screen (the page), mr_sheet_card (one sheet, ABC
 * too), mr_sheet_button (+ _danger), mr_sheet_empty and mr_sheet_dialog_fields (SheetNameDialog), with
 * the drawables mr_sheet_* and mr_ui_card_ripple. The colors come from the settings palette (@color/mr_ui_*) and the texts
 * from mr_strings.xml (mr_sheets_*, in English, Portuguese and Spanish); this class only fills in what changes (texts of the
 * sheets, the drawn icons, the clicks). The views are found by android:tag, so no id is needed.
 * The icons are the drawn ones of SheetUi and the data is the SheetStore/SheetModel (smali, hand written).
 *
 * Taps: the buttons of a card have 40 dp and say what they do to TalkBack ("Move Symbols up"); a second tap that comes within
 * {@link #TAP_GAP_MS} of one that opened something (the editor, a dialog, the file picker) is ignored, so two quick taps do
 * not open the editor twice. With the list full, "+ New sheet" says so on the button itself.
 *
 * Import: the file is read up to {@link #IMPORT_MAX_BYTES} (a backup of twelve full sheets is far smaller; a larger file is
 * refused before it is read into memory), and a file with no sheet the app understands says so in the language of the app,
 * with no technical message.
 */
public class PrefScreenSheets extends Activity {
    private static final int REQ_EXPORT_JSON = 0x1005;
    private static final int REQ_IMPORT_JSON = 0x1006;

    /** Two taps closer than this open one thing only (ms). */
    static final long TAP_GAP_MS = 700L;

    /** The largest file the import reads (bytes). */
    static final int IMPORT_MAX_BYTES = 1024 * 1024;

    private ArrayList<SheetModel.Sheet> mSheets;
    private LinearLayout mListContainer;
    private TextView mSubtitleView;
    private TextView mNewSheetBtn;
    private long mLastOpen = -TAP_GAP_MS;

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

    /** True for the first tap; false for one that comes right after another tap that opened something. */
    boolean firstTap() {
        long now = SystemClock.uptimeMillis();
        if (now - mLastOpen < TAP_GAP_MS) return false;
        mLastOpen = now;
        return true;
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

        // header: back (drawn icon of the sheet screens)
        ImageView back = SheetUi.makeIconButton(this, SheetUi.ICON_BACK, color("mr_ui_text"), 40, t("mr_sheets_back"));
        back.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        slot(root, "back_slot").addView(back, new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));


        // switch "return to the main sheet when typing"
        slot(root, "option_slot").addView(MrSheetOpt.row(this));

        mNewSheetBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showNewSheetTemplatePicker();
            }
        });

        // backup: export, import and restore the default sheets
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
        if (mSheets == null) mSheets = new ArrayList<SheetModel.Sheet>();
        mSubtitleView.setText(t("mr_sheets_subtitle", Integer.valueOf(mSheets.size()), Integer.valueOf(SheetModel.MAX_SHEETS)));
        boolean room = mSheets.size() < SheetModel.MAX_SHEETS;
        mNewSheetBtn.setText(room ? t("mr_sheets_new") : t("mr_sheets_new_full", Integer.valueOf(SheetModel.MAX_SHEETS)));
        mNewSheetBtn.setAlpha(room ? 1.0f : 0.45f);
        mListContainer.removeAllViews();
        // ABC is always the first sheet
        View abc = buildAbcCard();
        if (abc != null) mListContainer.addView(abc);
        int n = mSheets.size();
        if (n == 0) {
            mListContainer.addView(inflate("mr_sheet_empty", mListContainer));
            return;
        }
        for (int i = 0; i < n; i++) {
            mListContainer.addView(buildSheetCard(i, mSheets.get(i)));
        }
    }

    /**
     * The card of ABC, as the others (badge, name, rows and keys) with a padlock in the place of up and down: ABC does not move and is not
     * deleted. Null when ABC cannot be read (the list goes on without it).
     */
    private View buildAbcCard() {
        final MrAbcKeys.Model abc;
        try {
            abc = MrAbcKeys.load(this, t("mr_sheets_main_title"));
        } catch (Throwable t) {
            return null;
        }
        final SheetModel.Sheet sheet = abc.sheet;
        View card = inflate("mr_sheet_card", mListContainer);
        ((TextView) card.findViewWithTag("badge")).setText(SheetModel.sanitizeBadge(sheet.badge, "ABC"));
        ((TextView) card.findViewWithTag("name")).setText(sheet.name);
        ((TextView) card.findViewWithTag("info")).setText(t("mr_sheets_card_info", Integer.valueOf(sheet.rows.size()),
                Integer.valueOf(sheet.countKeys()), t("mr_sheets_builtin")));
        card.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                openEditor(MrAbcKeys.ID);
            }
        });
        // the padlock takes the room of up and down
        card.findViewWithTag("up").setVisibility(View.GONE);
        ImageView lock = (ImageView) card.findViewWithTag("down");
        lock.setImageDrawable(new SheetUi.IconDrawable(this, SheetUi.ICON_LOCK, color("mr_ui_text3"), dp(20)));
        lock.setContentDescription(t("mr_sheets_abc_locked_desc"));
        lock.setBackground(null);
        lock.setClickable(false);
        android.view.ViewGroup.LayoutParams lp = lock.getLayoutParams();
        if (lp != null) {
            lp.width = dp(80);
            lock.setLayoutParams(lp);
        }
        final ImageView more = actionIcon(card, "more", SheetUi.ICON_MORE_VERT, true, t("mr_sheets_options_desc", sheet.name));
        more.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showAbcMenu(more, abc);
            }
        });
        return card;
    }

    private View buildSheetCard(final int idx, final SheetModel.Sheet sheet) {
        View card = inflate("mr_sheet_card", mListContainer);
        ((TextView) card.findViewWithTag("badge")).setText(SheetModel.sanitizeBadge(sheet.badge, "123"));
        ((TextView) card.findViewWithTag("name")).setText(sheet.name);
        String kind = t(sheet.builtin ? "mr_sheets_builtin" : "mr_sheets_custom");
        ((TextView) card.findViewWithTag("info")).setText(
                t("mr_sheets_card_info", Integer.valueOf(sheet.rows.size()), Integer.valueOf(sheet.countKeys()), kind));
        card.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                openEditor(sheet.id);
            }
        });

        ImageView up = actionIcon(card, "up", SheetUi.ICON_ARROW_UP, idx > 0, t("mr_sheets_up_desc", sheet.name));
        if (idx > 0) {
            up.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    moveSheet(idx, idx - 1);
                }
            });
        }
        boolean canDown = idx < mSheets.size() - 1;
        ImageView down = actionIcon(card, "down", SheetUi.ICON_ARROW_DOWN, canDown, t("mr_sheets_down_desc", sheet.name));
        if (canDown) {
            down.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    moveSheet(idx, idx + 1);
                }
            });
        }
        final ImageView more = actionIcon(card, "more", SheetUi.ICON_MORE_VERT, true, t("mr_sheets_options_desc", sheet.name));
        more.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showCardContextMenu(more, idx, sheet);
            }
        });
        return card;
    }

    /** Small drawn icon of a card; a disabled one is dimmed and has no ripple (the ripple is in the XML). */
    private ImageView actionIcon(View card, String tag, int kind, boolean enabled, String description) {
        ImageView v = (ImageView) card.findViewWithTag(tag);
        v.setImageDrawable(new SheetUi.IconDrawable(this, kind,
                color(enabled ? "mr_ui_text2" : "mr_ui_text_dis"), dp(20)));
        v.setContentDescription(description);
        v.setEnabled(enabled);
        if (!enabled) v.setBackground(null);
        return v;
    }

    // ------------------------------------------------------------------ menus

    private void showCardContextMenu(View anchor, final int idx, final SheetModel.Sheet sheet) {
        ArrayList<SheetUi.MenuEntry> items = new ArrayList<SheetUi.MenuEntry>(6);
        items.add(new SheetUi.MenuEntry(1, SheetUi.ICON_EDIT_KEYS, t("mr_sheets_menu_edit")));
        items.add(new SheetUi.MenuEntry(2, SheetUi.ICON_RENAME, t("mr_sheets_menu_rename")));
        if (idx > 0) items.add(new SheetUi.MenuEntry(3, SheetUi.ICON_ARROW_UP, t("mr_sheets_menu_up")));
        if (idx < mSheets.size() - 1) items.add(new SheetUi.MenuEntry(4, SheetUi.ICON_ARROW_DOWN, t("mr_sheets_menu_down")));
        if (mSheets.size() < SheetModel.MAX_SHEETS) {
            items.add(new SheetUi.MenuEntry(5, SheetUi.ICON_DUPLICATE, t("mr_sheets_menu_duplicate")));
        }
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

    /** The ⋮ of ABC: edit, rename, duplicate and Restore ABC; Delete greyed (ABC is always the first sheet). */
    private void showAbcMenu(View anchor, final MrAbcKeys.Model abc) {
        ArrayList<SheetUi.MenuEntry> items = new ArrayList<SheetUi.MenuEntry>(5);
        items.add(new SheetUi.MenuEntry(1, SheetUi.ICON_EDIT_KEYS, t("mr_sheets_menu_edit")));
        items.add(new SheetUi.MenuEntry(2, SheetUi.ICON_RENAME, t("mr_sheets_menu_rename")));
        if (mSheets.size() < SheetModel.MAX_SHEETS) {
            items.add(new SheetUi.MenuEntry(5, SheetUi.ICON_DUPLICATE, t("mr_sheets_menu_duplicate")));
        }
        items.add(new SheetUi.MenuEntry(6, SheetUi.ICON_RESTORE, t("mr_abc_menu_restore"), SheetUi.TONE_WARNING, MrAbcKeys.edited(abc)));
        items.add(new SheetUi.MenuEntry(7, SheetUi.ICON_DELETE, t("mr_sheets_menu_delete"), SheetUi.TONE_DANGER, false));
        SheetUi.showPopupMenu(this, anchor, SheetModel.sanitizeBadge(abc.sheet.badge, "ABC"), abc.sheet.name, items,
                new SheetUi.OnMenuSelect() {
                    public void onSelect(int id) {
                        switch (id) {
                            case 1: openEditor(MrAbcKeys.ID); break;
                            case 2: showRenameAbcDialog(abc); break;
                            case 5: duplicateAbc(abc); break;
                            case 6: confirmRestoreAbc(); break;
                            default: break;
                        }
                    }
                });
    }

    private void showRenameAbcDialog(final MrAbcKeys.Model abc) {
        SheetNameDialog.show(this, t("mr_sheets_rename_title"), t("mr_sheets_save"), t("mr_sheets_cancel"),
                abc.sheet.name, abc.sheet.badge, new SheetNameDialog.OnNamed() {
                    public void onNamed(String name, String badge) {
                        abc.sheet.name = SheetModel.sanitizeName(name, abc.sheet.name);
                        abc.sheet.badge = SheetModel.sanitizeBadge(badge, abc.sheet.badge);
                        if (!MrAbcKeys.save(PrefScreenSheets.this, abc)) toast(t("mr_abc_save_failed"), false);
                        reloadAndRender();
                    }
                });
    }

    /** A copy of ABC as a sheet of the person, the first one after ABC. */
    private void duplicateAbc(MrAbcKeys.Model abc) {
        if (limitReached()) return;
        SheetModel.Sheet copy = MrAbcKeys.copySheet(abc.sheet);
        copy.id = SheetModel.makeUniqueId(mSheets, "copy");
        copy.builtin = false;
        copy.name = SheetModel.sanitizeName(t("mr_sheets_copy_name", abc.sheet.name), abc.sheet.name);
        mSheets.add(0, copy);
        SheetStore.save(this, mSheets);
        reloadAndRender();
    }

    private void confirmRestoreAbc() {
        new AlertDialog.Builder(this)
                .setTitle(t("mr_abc_restore_title"))
                .setMessage(t("mr_abc_restore_msg"))
                .setPositiveButton(t("mr_sheets_reset_one_ok"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        MrAbcKeys.reset(PrefScreenSheets.this);
                        reloadAndRender();
                        toast(t("mr_abc_restored"), false);
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
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
        if (!firstTap()) return;
        Intent i = new Intent(this, SheetEditorActivity.class);
        i.putExtra(SheetEditorActivity.EXTRA_SHEET_ID, sheetId);
        startActivity(i);
    }

    private boolean limitReached() {
        if (mSheets.size() >= SheetModel.MAX_SHEETS) {
            toast(t("mr_sheets_limit", Integer.valueOf(SheetModel.MAX_SHEETS)), false);
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
        if (limitReached() || !firstTap()) return;
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
            items[i] = t("mr_key_ed_target_sheet", SheetModel.sanitizeBadge(s.badge, "123"), s.name);
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
            fallbackName = SheetModel.sanitizeName(t("mr_sheets_copy_name", source.name), source.name);
            fallbackBadge = source.badge;
        } else {
            int n = mSheets.size() + 1;
            fallbackName = t("mr_sheets_default_name", Integer.valueOf(n));
            fallbackBadge = "F" + n;
        }
        SheetNameDialog.show(this, t("mr_sheets_new_title"), t("mr_sheets_create_edit"), t("mr_sheets_cancel"),
                fallbackName, fallbackBadge, new SheetNameDialog.OnNamed() {
                    public void onNamed(String typedName, String typedBadge) {
                        if (limitReached()) return;
                        String id = SheetModel.makeUniqueId(mSheets, "custom");
                        String name = SheetModel.sanitizeName(typedName, fallbackName);
                        String badge = SheetModel.sanitizeBadge(typedBadge, fallbackBadge);
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
                        mLastOpen = -TAP_GAP_MS;
                        openEditor(s.id);
                    }
                });
    }

    private void showRenameSheetDialog(final SheetModel.Sheet sheet) {
        SheetNameDialog.show(this, t("mr_sheets_rename_title"), t("mr_sheets_save"), t("mr_sheets_cancel"),
                sheet.name, sheet.badge, new SheetNameDialog.OnNamed() {
                    public void onNamed(String name, String badge) {
                        sheet.name = SheetModel.sanitizeName(name, sheet.name);
                        sheet.badge = SheetModel.sanitizeBadge(badge, sheet.badge);
                        SheetStore.save(PrefScreenSheets.this, mSheets);
                        reloadAndRender();
                    }
                });
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
        if (!firstTap()) return;
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
        if (!firstTap()) return;
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
        if (!firstTap()) return;
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

    /**
     * The text of the file in UTF-8, or null when it has more than {@code max} bytes (it stops reading there, so a large file that was picked by
     * mistake is never held in memory).
     */
    static String readCapped(InputStream in, int max) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream(8192);
        byte[] buf = new byte[8192];
        int n;
        while ((n = in.read(buf)) != -1) {
            if (out.size() + n > max) return null;
            out.write(buf, 0, n);
        }
        return out.toString("UTF-8");
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode != RESULT_OK || data == null) return;
        final Uri uri = data.getData();
        if (uri == null) return;
        if (requestCode == REQ_EXPORT_JSON) {
            exportTo(uri);
        } else if (requestCode == REQ_IMPORT_JSON) {
            importFrom(uri);
        }
    }

    private void exportTo(Uri uri) {
        try {
            // the backup of the sheets also carries the keys of ABC that were changed
            String json = MrAbcKeys.addToBackup(this, SheetStore.exportJsonString(this));
            OutputStream os = getContentResolver().openOutputStream(uri);
            if (os == null) {
                toast(t("mr_sheets_export_failed"), true);
                return;
            }
            try {
                os.write(json.getBytes("UTF-8"));
                os.flush();
            } finally {
                os.close();
            }
            toast(t("mr_sheets_exported"), false);
        } catch (Exception e) {
            toast(t("mr_sheets_export_failed"), true);
        }
    }

    private void importFrom(Uri uri) {
        final String raw;
        try {
            InputStream in = getContentResolver().openInputStream(uri);
            if (in == null) {
                toast(t("mr_sheets_import_bad"), true);
                return;
            }
            try {
                raw = readCapped(in, IMPORT_MAX_BYTES);
            } finally {
                in.close();
            }
        } catch (Exception e) {
            toast(t("mr_sheets_import_bad"), true);
            return;
        }
        if (raw == null) {
            toast(t("mr_sheets_import_too_big"), true);
            return;
        }
        ArrayList<SheetModel.Sheet> parsed;
        try {
            parsed = SheetModel.parseSheets(raw);
        } catch (Exception e) {
            parsed = null;
        }
        if (parsed == null || parsed.isEmpty()) {
            // not JSON, JSON of something else, or no sheet that the app understands
            toast(t("mr_sheets_import_bad_file"), true);
            return;
        }
        new AlertDialog.Builder(this)
                .setTitle(t("mr_sheets_import_title"))
                .setMessage(t("mr_sheets_import_msg", Integer.valueOf(Math.min(parsed.size(), SheetModel.MAX_SHEETS))))
                .setPositiveButton(t("mr_sheets_import"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        try {
                            int n = SheetStore.importJsonString(PrefScreenSheets.this, raw);
                            // the keys of ABC that the file has (a backup without them leaves ABC as it is)
                            MrAbcKeys.takeFromBackup(PrefScreenSheets.this, raw);
                            reloadAndRender();
                            toast(t("mr_sheets_imported", Integer.valueOf(n)), false);
                        } catch (Exception e) {
                            toast(t("mr_sheets_import_bad"), true);
                        }
                    }
                })
                .setNegativeButton(t("mr_sheets_cancel"), null)
                .show();
    }
}
