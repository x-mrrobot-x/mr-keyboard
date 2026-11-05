package android.preference;

public class PreferenceManager {
    /** The default preferences that the PC tests hand to the code (null: none, as before). */
    public static android.content.SharedPreferences stubDefault;
    public static android.content.SharedPreferences getDefaultSharedPreferences(android.content.Context context) { return stubDefault; }
    public PreferenceScreen createPreferenceScreen(android.content.Context context) { return null; }
    public void setSharedPreferencesName(String name) { }
}
