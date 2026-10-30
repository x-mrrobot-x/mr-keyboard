package android.content;

public interface SharedPreferences {
    java.util.Map<String, ?> getAll();
    String getString(String key, String defValue);
    int getInt(String key, int defValue);
    long getLong(String key, long defValue);
    boolean getBoolean(String key, boolean defValue);
    Editor edit();

    interface Editor {
        Editor putString(String key, String value);
        Editor putInt(String key, int value);
        Editor putLong(String key, long value);
        Editor putBoolean(String key, boolean value);
        Editor remove(String key);
        boolean commit();
        void apply();
    }
}
