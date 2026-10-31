package android.content;

public class Intent {
    public static final int FLAG_ACTIVITY_NEW_TASK = 0x10000000;
    public static final String ACTION_VIEW = "android.intent.action.VIEW";
    public Intent(Context packageContext, Class<?> cls) { }
    public Intent(String action, android.net.Uri uri) { }
    public Intent addFlags(int flags) { return this; }
}
