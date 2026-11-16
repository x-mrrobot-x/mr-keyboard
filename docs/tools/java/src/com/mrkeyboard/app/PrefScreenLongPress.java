package com.mrkeyboard.app;

import android.app.backup.BackupManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;

/**
 * Settings → Touch and gestures → Long press on keys (2.0.0): the two settings of the long press of a key, in a screen of their own,
 * each in a section with a text that says what it does: the time to hold a key (pref_long_press_duration) and what opens when it is
 * held (pref_popup_content). Before they were two loose rows among the screens of Touch and gestures. The keys, the values and the
 * code that reads them (LatinIME, GlobalKeyboardSettings) are the same as before; only the place changed. It is the same kind of
 * screen as "Delete by word": a PreferenceActivity filled from an XML (res/xml/prefs_long_press.xml). The title and the XML are
 * looked up by name, in the language of the app.
 */
public class PrefScreenLongPress extends PreferenceActivity implements SharedPreferences.OnSharedPreferenceChangeListener {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        setTitle(getResources().getString(getResources().getIdentifier("mr_longpress_title", "string", getPackageName())));
        addPreferencesFromResource(getResources().getIdentifier("prefs_long_press", "xml", getPackageName()));
        ListDividerFix.apply(this);
        PreferenceManager.getDefaultSharedPreferences(this).registerOnSharedPreferenceChangeListener(this);
    }

    @Override
    protected void onDestroy() {
        PreferenceManager.getDefaultSharedPreferences(this).unregisterOnSharedPreferenceChangeListener(this);
        super.onDestroy();
    }

    /** The settings are part of the backup of the app, like on the other screens. */
    public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
        new BackupManager(this).dataChanged();
    }
}
