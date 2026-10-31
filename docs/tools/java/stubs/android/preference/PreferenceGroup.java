package android.preference;

public abstract class PreferenceGroup extends Preference {
    public PreferenceGroup(android.content.Context context) { super(context); }
    public boolean addPreference(Preference preference) { return true; }
    public boolean removePreference(Preference preference) { return true; }
    public void removeAll() { }
}
