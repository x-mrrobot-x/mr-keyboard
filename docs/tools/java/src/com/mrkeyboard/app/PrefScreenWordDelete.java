package com.mrkeyboard.app;

import android.app.backup.BackupManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.preference.PreferenceManager;

/**
 * Settings → Touch and gestures → Delete by word (2.0.0): the screen of Ctrl + delete by words and of Ctrl + Z / Ctrl + Y word by word
 * (docs/word-delete.md). It is the same kind of screen as "Vibration, sound and preview": a PreferenceActivity filled from an XML
 * (res/xml/prefs_word_delete.xml), with the section headers of the settings palette. The XML has the switch (pref_word_delete), the
 * time between words when held (pref_word_delete_interval, only while the switch is on) and two rows of text that say how to use it
 * (they go grey with the switch). Nothing is read here: the class MrWordDelete follows the preferences by itself.
 * The title, the XML and the texts are looked up by name (the same way as the other screens written in Java), in the language of the app.
 */
public class PrefScreenWordDelete extends PreferenceActivity implements SharedPreferences.OnSharedPreferenceChangeListener {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(UiLocale.wrap(base));
    }

    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        setTitle(getResources().getString(getResources().getIdentifier("mr_word_delete_title", "string", getPackageName())));
        addPreferencesFromResource(getResources().getIdentifier("prefs_word_delete", "xml", getPackageName()));
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
