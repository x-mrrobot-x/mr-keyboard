package android.os;

/** Compile and PC test stub: the values are kept so that the tests can read them. */
public final class Bundle {
    private final java.util.HashMap<String, Object> map = new java.util.HashMap<String, Object>();

    public boolean containsKey(String key) { return map.containsKey(key); }
    public void putInt(String key, int value) { map.put(key, Integer.valueOf(value)); }
    public int getInt(String key, int def) { Object v = map.get(key); return v instanceof Integer ? ((Integer) v).intValue() : def; }
    public void putString(String key, String value) { map.put(key, value); }
    public String getString(String key) { Object v = map.get(key); return v instanceof String ? (String) v : null; }
    public void putBoolean(String key, boolean value) { map.put(key, Boolean.valueOf(value)); }
    public boolean getBoolean(String key, boolean def) { Object v = map.get(key); return v instanceof Boolean ? ((Boolean) v).booleanValue() : def; }
    public int size() { return map.size(); }
}
