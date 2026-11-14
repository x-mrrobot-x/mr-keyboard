package android.content.pm;

public abstract class PackageManager {
    public static final int GET_SIGNATURES = 0x00000040;
    public static final int GET_SIGNING_CERTIFICATES = 0x08000000;
    public boolean canRequestPackageInstalls() { return false; }
    public PackageInstaller getPackageInstaller() { return null; }
    public abstract PackageInfo getPackageInfo(String packageName, int flags) throws NameNotFoundException;

    /**
     * The look-up of the dictionary apps (PluginManager.ensurePlugins, run the first time a language without a pack needs it).
     * The PC has no other apps installed, so both answer with an empty list, like a phone with none of them.
     */
    public java.util.List<ResolveInfo> queryBroadcastReceivers(android.content.Intent intent, int flags) { return new java.util.ArrayList<ResolveInfo>(); }
    public java.util.List<ResolveInfo> queryIntentActivities(android.content.Intent intent, int flags) { return new java.util.ArrayList<ResolveInfo>(); }

    public static class NameNotFoundException extends android.util.AndroidException {
    }
}
