package android.preference;

public class Preference {
    public interface OnPreferenceClickListener {
        boolean onPreferenceClick(Preference preference);
    }
    public Preference(android.content.Context context) { }
    public void setKey(String key) { }
    public void setTitle(CharSequence title) { }
    public void setSummary(CharSequence summary) { }
    public void setPersistent(boolean persistent) { }
    public void setSelectable(boolean selectable) { }
    public void setDefaultValue(Object defaultValue) { }
    public void setIcon(int iconResId) { }
    public void setOnPreferenceClickListener(OnPreferenceClickListener l) { }
}
