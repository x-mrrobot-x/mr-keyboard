package android.preference;

/** Stub de teste: preferências padrão = arquivo "default" do próprio Context. */
public class PreferenceManager {
    public static android.content.SharedPreferences getDefaultSharedPreferences(android.content.Context context) {
        return context.getSharedPreferences("default", 0);
    }
    public PreferenceScreen createPreferenceScreen(android.content.Context context) { return null; }
    public void setSharedPreferencesName(String name) { }
}
