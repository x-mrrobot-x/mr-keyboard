package android.preference;

public abstract class PreferenceActivity extends android.app.ListActivity {
    public PreferenceManager getPreferenceManager() { return null; }
    public void setPreferenceScreen(PreferenceScreen preferenceScreen) { }
}
