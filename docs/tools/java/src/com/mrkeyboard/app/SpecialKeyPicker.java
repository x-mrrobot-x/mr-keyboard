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
import android.widget.TextView;
import android.widget.Toast;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * Picker of the special keys of the sheet editor: the catalog of the keys that the keyboard understands (backspace,
 * arrows, modifiers, F1..F12, toolbar, settings…), the search by name, category or code and the "custom code" dialog
 * for an integer key code that is not in the catalog.
 *
 * The look is in XML, like the other screens: layouts mr_pick_dialog (the picker), mr_pick_row (one key), mr_pick_header
 * (the category line) and mr_pick_custom (the code dialog), with the drawables mr_pick_*, the colors of the settings
 * palette (@color/mr_ui_*) and the texts of mr_strings.xml (mr_pick_*, in English, Portuguese and Spanish).
 * The names and the categories of the catalog are data, not screen text: they are kept in the table of the class in
 * Portuguese and go through SheetStrings.p() when they are shown (that is the only part of the sheet editor that still
 * uses the Spanish table of MrEs). The behavior is the one of the old picker: the search filters by the text of the
 * language in use and by the code, the category line appears when the category changes, the current key comes marked
 * and the return is the code with the label of the key.
 * The views are found by android:tag, so no id is needed (public.xml is not touched).
 */
public final class SpecialKeyPicker {
    /** One key of the catalog: the code sent to the keyboard, the label used on the key and the texts of the app. */
    public static final class SpecialEntry {
        public final String catEn;
        public final String catPt;
        public final int code;
        public final String defaultLabel;
        public final String nameEn;
        public final String namePt;
        final String searchKeyEn;
        final String searchKeyPt;

        public SpecialEntry(int code, String defaultLabel, String namePt, String nameEn, String catPt, String catEn) {
            this.code = code;
            this.defaultLabel = defaultLabel;
            this.namePt = namePt;
            this.nameEn = nameEn;
            this.catPt = catPt;
            this.catEn = catEn;
            this.searchKeyPt = (namePt + " " + catPt + " " + defaultLabel + " " + code).toLowerCase(Locale.US);
            this.searchKeyEn = (nameEn + " " + catEn + " " + defaultLabel + " " + code).toLowerCase(Locale.US);
        }
    }

    /** What the caller does with the key picked (its integer code and the label to use on the key). */
    public interface OnSpecialKeySelectedListener {
        void onSpecialKeySelected(int code, String label);
    }

    /** The keys of the catalog, in the order they appear on the screen. */
    private static final SpecialEntry[] CATALOG = {
            new SpecialEntry(-5, "⌫", "Backspace (apagar)", "Backspace", "Edição", "Editing"),
            new SpecialEntry(-112, "Del→", "Delete à frente", "Forward Delete", "Edição", "Editing"),
            new SpecialEntry(10, "⏎", "Enter / Retorno", "Enter / Return", "Edição", "Editing"),
            new SpecialEntry(9, "⇥", "Tab (tabulação)", "Tab", "Edição", "Editing"),
            new SpecialEntry(32, "␣", "Espaço", "Space", "Edição", "Editing"),
            new SpecialEntry(-124, "Ins", "Insert", "Insert", "Edição", "Editing"),
            new SpecialEntry(-111, "Esc", "Escape (Esc)", "Escape (Esc)", "Edição", "Editing"),
            new SpecialEntry(-21, "←", "Seta esquerda", "Arrow Left", "Navegação", "Navigation"),
            new SpecialEntry(-22, "→", "Seta direita", "Arrow Right", "Navegação", "Navigation"),
            new SpecialEntry(-19, "↑", "Seta cima", "Arrow Up", "Navegação", "Navigation"),
            new SpecialEntry(-20, "↓", "Seta baixo", "Arrow Down", "Navegação", "Navigation"),
            new SpecialEntry(-23, "⊙", "Centro D-Pad", "D-Pad Center", "Navegação", "Navigation"),
            new SpecialEntry(-122, "Home", "Home (início)", "Home", "Navegação", "Navigation"),
            new SpecialEntry(-123, "End", "End (fim)", "End", "Navegação", "Navigation"),
            new SpecialEntry(-92, "PgUp", "Page Up", "Page Up", "Navegação", "Navigation"),
            new SpecialEntry(-93, "PgDn", "Page Down", "Page Down", "Navegação", "Navigation"),
            new SpecialEntry(-1, "⇧", "Shift", "Shift", "Modificadores", "Modifiers"),
            new SpecialEntry(-113, "Ctrl", "Ctrl", "Ctrl", "Modificadores", "Modifiers"),
            new SpecialEntry(-57, "Alt", "Alt", "Alt", "Modificadores", "Modifiers"),
            new SpecialEntry(-117, "Meta", "Meta / Super", "Meta / Super", "Modificadores", "Modifiers"),
            new SpecialEntry(-119, "Fn", "Fn", "Fn", "Modificadores", "Modifiers"),
            new SpecialEntry(-131, "F1", "Tecla F1", "Function F1", "Função", "Function Keys"),
            new SpecialEntry(-132, "F2", "Tecla F2", "Function F2", "Função", "Function Keys"),
            new SpecialEntry(-133, "F3", "Tecla F3", "Function F3", "Função", "Function Keys"),
            new SpecialEntry(-134, "F4", "Tecla F4", "Function F4", "Função", "Function Keys"),
            new SpecialEntry(-135, "F5", "Tecla F5", "Function F5", "Função", "Function Keys"),
            new SpecialEntry(-136, "F6", "Tecla F6", "Function F6", "Função", "Function Keys"),
            new SpecialEntry(-137, "F7", "Tecla F7", "Function F7", "Função", "Function Keys"),
            new SpecialEntry(-138, "F8", "Tecla F8", "Function F8", "Função", "Function Keys"),
            new SpecialEntry(-139, "F9", "Tecla F9", "Function F9", "Função", "Function Keys"),
            new SpecialEntry(-140, "F10", "Tecla F10", "Function F10", "Função", "Function Keys"),
            new SpecialEntry(-141, "F11", "Tecla F11", "Function F11", "Função", "Function Keys"),
            new SpecialEntry(-142, "F12", "Tecla F12", "Function F12", "Função", "Function Keys"),
            new SpecialEntry(-306, "Barra", "Barra Mr Keyboard", "Mr Keyboard Toolbar", "Sistema", "System"),
            new SpecialEntry(-100, "⚙", "Configurações", "Settings", "Sistema", "System"),
            new SpecialEntry(-102, "🎤", "Entrada por voz", "Voice Input", "Sistema", "System"),
            new SpecialEntry(-103, ",", "Tecla auxiliar (vírgula/voz)", "Auxiliary Key (comma/voice)", "Sistema", "System"),
            new SpecialEntry(SheetModel.CODE_SHEET_NEXT, "123", "Próxima folha (ciclo)", "Next Sheet (cycle)", "Sistema", "System"),
            new SpecialEntry(SheetModel.CODE_SHEET_PREV, "◀Fol", "Folha anterior (ciclo)", "Previous Sheet (cycle)", "Sistema", "System"),
            new SpecialEntry(-120, "SysRq", "SysRq / Print Screen", "SysRq / Print Screen", "Sistema", "System"),
            new SpecialEntry(-121, "Break", "Break / Pause", "Break / Pause", "Sistema", "System"),
            new SpecialEntry(-143, "NumLk", "Num Lock", "Num Lock", "Sistema", "System"),
            new SpecialEntry(-116, "ScrLk", "Scroll Lock", "Scroll Lock", "Sistema", "System"),
    };

    private SpecialKeyPicker() { }

    /** Key of the catalog with this code, or null when the code is not in it. */
    public static SpecialEntry findByCode(int code) {
        for (int i = 0; i < CATALOG.length; i++) {
            if (CATALOG[i].code == code) return CATALOG[i];
        }
        return null;
    }

    /** Label to use on a key of this code: the label of the catalog, the character itself or the number. */
    public static String defaultLabelForCode(int code) {
        SpecialEntry entry = findByCode(code);
        if (entry != null) return entry.defaultLabel;
        if (code < 33 || code > 126) return String.valueOf(code);
        return String.valueOf((char) code);
    }

    /** Text of a code ("Arrow Left (-21)", "Custom code (77)") in the language of the app. */
    public static String describeCode(Context context, int code) {
        SpecialEntry entry = findByCode(code);
        if (entry != null) {
            boolean isPt = SheetStrings.isPt(context);
            return text(context, "mr_pick_describe", isPt ? SheetStrings.p(entry.namePt) : entry.nameEn,
                    Integer.valueOf(code));
        }
        return text(context, "mr_pick_custom_code", Integer.valueOf(code));
    }

    /** Every key of the catalog (copy of the list). */
    public static List<SpecialEntry> getAllEntries() {
        ArrayList<SpecialEntry> list = new ArrayList<SpecialEntry>(CATALOG.length);
        for (int i = 0; i < CATALOG.length; i++) {
            list.add(CATALOG[i]);
        }
        return list;
    }

    // ------------------------------------------------------------------ the picker

    /** Opens the picker with the key of this code marked. */
    public static void show(Context context, int code, OnSpecialKeySelectedListener listener) {
        new Picker(context, code, listener).show();
    }

    /** State of one open picker: the views of mr_pick_dialog and the code that comes marked. */
    private static final class Picker {
        private final Context mContext;
        private final int mSelected;
        private final OnSpecialKeySelectedListener mListener;

        private AlertDialog mDialog;
        private EditText mSearch;
        private LinearLayout mList;

        Picker(Context context, int selected, OnSpecialKeySelectedListener listener) {
            mContext = context;
            mSelected = selected;
            mListener = listener;
        }

        void show() {
            View content = LayoutInflater.from(mContext).inflate(res(mContext, "mr_pick_dialog", "layout"), null);
            mSearch = (EditText) content.findViewWithTag("search");
            mList = (LinearLayout) content.findViewWithTag("key_list");
            mSearch.addTextChangedListener(new TextWatcher() {
                public void beforeTextChanged(CharSequence s, int start, int count, int after) { }

                public void onTextChanged(CharSequence s, int start, int before, int count) { }

                public void afterTextChanged(Editable s) {
                    fillList();
                }
            });
            mDialog = new AlertDialog.Builder(mContext)
                    .setView(content)
                    .setNeutralButton(text(mContext, "mr_pick_custom_btn"), null)
                    .setNegativeButton(text(mContext, "mr_pick_cancel"), null)
                    .create();
            // the neutral button opens the dialog of an integer code (the same as the old picker)
            mDialog.setOnShowListener(new DialogInterface.OnShowListener() {
                public void onShow(DialogInterface dialog) {
                    mDialog.getButton(AlertDialog.BUTTON_NEUTRAL).setOnClickListener(new View.OnClickListener() {
                        public void onClick(View v) {
                            mDialog.dismiss();
                            showCustomCodeDialog(mContext, mSelected, mListener);
                        }
                    });
                }
            });
            fillList();
            mDialog.show();
        }

        /**
         * Rebuilds the list with the keys of the catalog that match the search: the category line comes when the
         * category changes and the row of the current key comes marked.
         */
        private void fillList() {
            boolean isPt = SheetStrings.isPt(mContext);
            String query = mSearch.getText().toString().trim().toLowerCase(Locale.US);
            mList.removeAllViews();
            String lastCategory = EMPTY;
            int shown = 0;
            for (int i = 0; i < CATALOG.length; i++) {
                SpecialEntry entry = CATALOG[i];
                String name = isPt ? SheetStrings.p(entry.namePt) : entry.nameEn;
                String category = isPt ? SheetStrings.p(entry.catPt) : entry.catEn;
                if (!query.isEmpty()
                        && !(isPt ? entry.searchKeyPt : entry.searchKeyEn).contains(query)
                        && !name.toLowerCase(Locale.US).contains(query)) {
                    continue;
                }
                if (!category.equals(lastCategory)) {
                    TextView header = (TextView) LayoutInflater.from(mContext)
                            .inflate(res(mContext, "mr_pick_header", "layout"), mList, false);
                    header.setText(category.toUpperCase(Locale.US));
                    mList.addView(header);
                    lastCategory = category;
                }
                mList.addView(buildRow(entry, name));
                shown++;
            }
            if (shown == 0) {
                TextView empty = (TextView) LayoutInflater.from(mContext)
                        .inflate(res(mContext, "mr_pick_empty", "layout"), mList, false);
                mList.addView(empty);
            }
        }

        private View buildRow(final SpecialEntry entry, String name) {
            View row = LayoutInflater.from(mContext).inflate(res(mContext, "mr_pick_row", "layout"), mList, false);
            ((TextView) row.findViewWithTag("key_label")).setText(entry.defaultLabel);
            ((TextView) row.findViewWithTag("key_name")).setText(name);
            ((TextView) row.findViewWithTag("key_code")).setText(String.valueOf(entry.code));
            if (entry.code == mSelected) {
                row.setBackgroundResource(res(mContext, "mr_pick_row_on", "drawable"));
            }
            row.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    mDialog.dismiss();
                    if (mListener != null) mListener.onSpecialKeySelected(entry.code, entry.defaultLabel);
                }
            });
            return row;
        }
    }

    // ------------------------------------------------------------------ the custom code

    /** Dialog of an integer key code that is not in the catalog (opened by the neutral button of the picker). */
    public static void showCustomCodeDialog(final Context context, int code,
            final OnSpecialKeySelectedListener listener) {
        View content = LayoutInflater.from(context).inflate(res(context, "mr_pick_custom", "layout"), null);
        final EditText field = (EditText) content.findViewWithTag("code_field");
        field.setInputType(4098);
        field.setText(String.valueOf(code));
        field.setSelection(field.getText().length());
        new AlertDialog.Builder(context)
                .setTitle(text(context, "mr_pick_custom_title"))
                .setView(content)
                .setPositiveButton(text(context, "mr_pick_apply"), new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        try {
                            int parsed = Integer.parseInt(field.getText().toString().trim());
                            if (listener != null) listener.onSpecialKeySelected(parsed, defaultLabelForCode(parsed));
                        } catch (NumberFormatException e) {
                            Toast.makeText(context, text(context, "mr_pick_invalid"), Toast.LENGTH_SHORT).show();
                        }
                    }
                })
                .setNegativeButton(text(context, "mr_pick_cancel"), null)
                .show();
    }

    // ------------------------------------------------------------------ resources by name

    /** Empty text, built here: the resource check reads the Java sources by their quotes. */
    private static final String EMPTY = new String();

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
}
