package android.content;

/** Compile stub: it keeps the action, the class, the flags and the extras so that the PC tests can read them. */
public class Intent implements android.os.Parcelable {
    public static final int FLAG_ACTIVITY_NEW_TASK = 0x10000000;
    public static final int FLAG_ACTIVITY_CLEAR_TASK = 0x00008000;
    public static final int FLAG_ACTIVITY_REORDER_TO_FRONT = 0x00020000;
    public static final int FLAG_ACTIVITY_CLEAR_TOP = 0x04000000;
    public static final int FLAG_ACTIVITY_MULTIPLE_TASK = 0x08000000;
    public static final String ACTION_VIEW = "android.intent.action.VIEW";
    public static final String ACTION_MY_PACKAGE_REPLACED = "android.intent.action.MY_PACKAGE_REPLACED";
    public static final String EXTRA_INTENT = "android.intent.extra.INTENT";
    public static final String ACTION_CREATE_DOCUMENT = "android.intent.action.CREATE_DOCUMENT";
    public static final String ACTION_OPEN_DOCUMENT = "android.intent.action.OPEN_DOCUMENT";
    public static final String CATEGORY_OPENABLE = "android.intent.category.OPENABLE";
    public static final String EXTRA_TITLE = "android.intent.extra.TITLE";
    public static final String EXTRA_MIME_TYPES = "android.intent.extra.MIME_TYPES";

    public String action, packageName, className;
    public int flags;
    public final java.util.Map<String, Object> extras = new java.util.HashMap<String, Object>();

    public Intent() { }
    public Intent(String action) { this.action = action; }
    public Intent(Context packageContext, Class<?> cls) { className = cls.getName(); }
    public Intent(String action, android.net.Uri uri) { this.action = action; }
    public Intent addFlags(int flags) { this.flags |= flags; return this; }
    public Intent setAction(String action) { this.action = action; return this; }
    public Intent setClassName(String packageName, String className) {
        this.packageName = packageName;
        this.className = className;
        return this;
    }
    public String getAction() { return action; }
    public Intent addCategory(String category) { return this; }
    public Intent setType(String type) { return this; }
    public android.net.Uri getData() { return null; }
    public <T extends android.os.Parcelable> T getParcelableExtra(String name) { return null; }
    public Intent putExtra(String name, int value) { extras.put(name, value); return this; }
    public Intent putExtra(String name, boolean value) { extras.put(name, value); return this; }
    public Intent putExtra(String name, String value) { extras.put(name, value); return this; }
    public Intent putExtra(String name, String[] value) { extras.put(name, value); return this; }
    public String getStringExtra(String name) {
        Object v = extras.get(name);
        return v instanceof String ? (String) v : null;
    }
    public boolean getBooleanExtra(String name, boolean defaultValue) {
        Object v = extras.get(name);
        return v instanceof Boolean ? (Boolean) v : defaultValue;
    }
    public void removeExtra(String name) { extras.remove(name); }
    public int getIntExtra(String name, int defaultValue) {
        Object v = extras.get(name);
        return v instanceof Integer ? (Integer) v : defaultValue;
    }
}
