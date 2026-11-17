package android.content.pm;

/** Compile stub: what PluginManager reads from the dictionary apps it finds and what MrAppList reads from the apps with a launcher icon. */
public class ResolveInfo {
    public ActivityInfo activityInfo;

    /** The name the launcher shows for the app (a test answers it through its own subclass). */
    public CharSequence loadLabel(PackageManager pm) { return activityInfo != null ? activityInfo.packageName : ""; }
}
