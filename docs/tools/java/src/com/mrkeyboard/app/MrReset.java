package com.mrkeyboard.app;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.preference.Preference;
import android.preference.PreferenceManager;
import android.widget.Toast;

/**
 * "Restaurar padrões" (Sobre, v1.69): apaga as configurações do teclado, as mesmas das telas de
 * configurações, e deixa o teclado nos valores padrão. Não mexe no que não é configuração: os
 * dicionários baixados (arquivos e estado dos pacotes), as folhas do usuário (files/sheets.json),
 * as palavras aprendidas e os avisos já vistos. Os idiomas do teclado voltam a ser os dos
 * dicionários instalados.
 *
 * KEYS tem de ter toda chave que as telas de configurações (res/xml/prefs*.xml) oferecem, a
 * "pref_sheet_return" (que fica na página Folhas do teclado) e as chaves que já saíram das telas; o
 * script docs/tools/check_reset_keys.py confere isso.
 */
public final class MrReset implements Preference.OnPreferenceClickListener {
    static final String[] KEYS = {
            "pref_keyboard_layout",
            "settings_height_portrait",
            "settings_height_landscape",
            "pref_bar_scale",
            "pref_keyboard_mode_portrait",
            "pref_keyboard_mode_landscape",
            "show_settings_key",
            "auto_cap",
            "voice_mode",
            "pref_long_press_duration",
            "pref_popup_content",
            "pref_ui_language",
            "keyboard_notification",
            "pref_key_spacing",
            "pref_key_radius",
            "pref_hint_mode",
            "pref_label_scale_v2",
            "vibrate_on",
            "vibrate_len",
            "sound_on",
            "pref_click_volume",
            "popup_on",
            "pref_swipe_up",
            "pref_swipe_down",
            "pref_swipe_left",
            "pref_swipe_right",
            "pref_vol_up",
            "pref_vol_down",
            "pref_ctrl_a_override",
            "pref_chording_ctrl_key",
            "pref_chording_alt_key",
            "fullscreen_override",
            "force_keyboard_on",
            "show_suggestions",
            "auto_complete",
            "quick_fixes",
            "recorrection_enabled",
            "suggestions_in_landscape",
            "pref_suggested_punctuation",
            "pref_candidate_scale",
            "pref_sheet_return",
            "pref_render_mode",
            "pref_slide_keys_int",
            "connectbot_tab_hack",
            "pref_touch_pos",
            "pref_click_method",
            "pref_top_row_scale",
            "pref_caps_lock",
            "pref_shift_lock_modifiers",
            "pref_chording_meta_key",
            "settings_key"
    };

    private final Context mContext;

    public MrReset(Context context) {
        mContext = context;
    }

    public boolean onPreferenceClick(Preference preference) {
        AlertDialog.Builder b = new AlertDialog.Builder(mContext);
        b.setTitle(MrPacks.text(mContext, "mr_reset_title"));
        b.setMessage(MrPacks.text(mContext, "mr_reset_confirm"));
        b.setPositiveButton(MrPacks.text(mContext, "mr_reset_do"), new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                apply(mContext);
                Toast.makeText(mContext.getApplicationContext(), MrPacks.text(mContext, "mr_reset_done"), Toast.LENGTH_SHORT).show();
                if (mContext instanceof Activity) ((Activity) mContext).recreate();
            }
        });
        b.setNegativeButton(MrPacks.text(mContext, "mr_reset_cancel"), null);
        b.show();
        return true;
    }

    /** Tira cada chave de configuração (o teclado e a tela voltam ao padrão) e acerta os idiomas. */
    static void apply(Context c) {
        SharedPreferences.Editor e = PreferenceManager.getDefaultSharedPreferences(c).edit();
        for (String k : KEYS) e.remove(k);
        e.apply();
        java.util.Locale ui = c.getResources().getConfiguration().locale;
        MrPacks.syncLanguages(c, MrPacks.cardIds(null, MrPacks.installedIds(c), ui.getLanguage()));
    }
}
