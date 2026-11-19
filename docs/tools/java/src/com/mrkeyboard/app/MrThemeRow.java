package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.Preference;
import android.preference.PreferenceManager;
import android.util.AttributeSet;

/**
 * The "Keyboard theme" row of the settings: it opens the themes screen ({@link MrThemesActivity}, through the intent that the XML gives it) and
 * says on its second line what is chosen now, the theme and, when there is one, its background ("Midnight Steel · Dusk"). The summary is read
 * from the preferences every time it is drawn, and the row draws itself again when the screen changes them, so it is right when the person comes
 * back from the themes screen. The row stores nothing; the theme is still the preference {@code pref_keyboard_layout}.
 */
public class MrThemeRow extends Preference implements SharedPreferences.OnSharedPreferenceChangeListener {
    private SharedPreferences mWatched;

    public MrThemeRow(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    public CharSequence getSummary() {
        return summary(getContext());
    }

    /** What the row says: the name of the theme in use, and after a dot the background when there is one. */
    static String summary(Context c) {
        try {
            SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(c);
            String[] names = MrThemeColors.names(c);
            int i = MrThemeColors.indexOf(MrThemeColors.values(c), sp == null ? "0" : sp.getString(MrThemesActivity.THEME_KEY, "0"));
            String name = i < names.length ? names[i] : "";
            MrBackdrop.Spec spec = MrBackdrop.current(c);
            return spec.kind == MrBackdrop.NONE ? name : name + " · " + MrThemesActivity.backgroundName(c, spec);
        } catch (RuntimeException e) {
            return "";
        }
    }

    @Override
    protected void onAttachedToHierarchy(PreferenceManager preferenceManager) {
        super.onAttachedToHierarchy(preferenceManager);
        watch(true);
    }

    @Override
    protected void onPrepareForRemoval() {
        watch(false);
        super.onPrepareForRemoval();
    }

    private void watch(boolean on) {
        if (on && mWatched == null) {
            mWatched = PreferenceManager.getDefaultSharedPreferences(getContext());
            if (mWatched != null) mWatched.registerOnSharedPreferenceChangeListener(this);
        } else if (!on && mWatched != null) {
            mWatched.unregisterOnSharedPreferenceChangeListener(this);
            mWatched = null;
        }
    }

    public void onSharedPreferenceChanged(SharedPreferences sp, String key) {
        if (MrThemesActivity.THEME_KEY.equals(key) || MrBackdrop.PREF.equals(key)) notifyChanged();
    }
}
