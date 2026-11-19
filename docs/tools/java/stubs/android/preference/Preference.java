package android.preference;

public class Preference {
    public interface OnPreferenceClickListener {
        boolean onPreferenceClick(Preference preference);
    }
    public interface OnPreferenceChangeListener {
        boolean onPreferenceChange(Preference preference, Object newValue);
    }
    private final android.content.Context stubContext;
    private PreferenceManager stubManager;
    public CharSequence stubSummary;
    public int stubNotified;
    public Preference(android.content.Context context) { stubContext = context; }
    public Preference(android.content.Context context, android.util.AttributeSet attrs) { stubContext = context; }
    public android.content.Context getContext() { return stubContext; }
    public void setKey(String key) { }
    public void setTitle(CharSequence title) { }
    public void setSummary(CharSequence summary) { stubSummary = summary; }
    public CharSequence getSummary() { return stubSummary; }
    public void setPersistent(boolean persistent) { }
    public void setSelectable(boolean selectable) { }
    public void setDefaultValue(Object defaultValue) { }
    public void setIcon(int iconResId) { }
    public void setLayoutResource(int layoutResId) { }
    public void setOnPreferenceClickListener(OnPreferenceClickListener l) { }
    public void setOnPreferenceChangeListener(OnPreferenceChangeListener l) { }
    public android.content.SharedPreferences getSharedPreferences() { return stubManager == null ? null : stubManager.getSharedPreferences(); }
    /** The row asks to be drawn again (its summary changed). */
    protected void notifyChanged() { stubNotified++; }
    protected void onAttachedToHierarchy(PreferenceManager preferenceManager) { stubManager = preferenceManager; }
    protected void onPrepareForRemoval() { }
    /** Tests only: what the real class does when the row joins the screen. */
    public void stubAttach(PreferenceManager manager) { onAttachedToHierarchy(manager); }
    public void stubRemove() { onPrepareForRemoval(); }
}
