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
 * "Restaurar padrões" (Restore defaults) (About, v1.69): erases the keyboard settings, the same as on the
 * settings screens, and leaves the keyboard on the default values. It does not touch what is not a setting: the
 * downloaded dictionaries and gesture recognition (files and pack state), the user's sheets (files/sheets.json),
 * the learned words and the notices already seen. The keyboard languages go back to those of the
 * installed dictionaries. Gesture typing goes back to off (1.96.0), with its trail and its word while sliding on; its
 * downloaded file stays.
 *
 * KEYS must have every key that the settings screens (res/xml/prefs*.xml) offer, the
 * "pref_sheet_return" (which is on the keyboard Sheets page) and the old keys, which the keyboard no longer
 * reads and are only here to clear stored values; the script docs/tools/check_reset_keys.py checks this.
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
            "vibrate_strength",
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
            "pref_ui_hw_accel",
            "pref_mr_echo_defer",
            "show_suggestions",
            "auto_complete",
            "quick_fixes",
            "recorrection_enabled",
            "suggestions_in_landscape",
            "pref_ai_provider",
            "pref_ai_endpoint",
            "pref_ai_model",
            "pref_ai_key",
            "pref_candidate_scale",
            "pref_gesture_typing",
            "pref_gesture_trail",
            "pref_gesture_preview",
            "pref_sugg_idle",
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

    /** Removes each setting key (the keyboard and the screen go back to the default) and fixes the languages. */
    static void apply(Context c) {
        SharedPreferences.Editor e = PreferenceManager.getDefaultSharedPreferences(c).edit();
        for (String k : KEYS) e.remove(k);
        e.apply();
        MrAi.setApiKey(c, ""); // the API key stays in "mr_ai", outside KEYS and the backup
        java.util.Locale ui = c.getResources().getConfiguration().locale;
        MrPacks.syncLanguages(c, MrPacks.cardIds(null, MrPacks.installedIds(c), ui.getLanguage()));
    }
}
