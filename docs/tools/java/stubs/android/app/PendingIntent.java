package android.app;

/** Compile stub: the PendingIntents of the install session and of the notification (values are Android's); it keeps what it is given. */
public final class PendingIntent {
    public static final int FLAG_UPDATE_CURRENT = 0x08000000;
    public static final int FLAG_IMMUTABLE = 0x04000000;
    public static final int FLAG_MUTABLE = 0x02000000;

    public android.content.Intent intent;
    public int flags;
    public boolean activity;

    public static PendingIntent getBroadcast(android.content.Context context, int requestCode, android.content.Intent intent, int flags) {
        PendingIntent p = new PendingIntent();
        p.intent = intent;
        p.flags = flags;
        return p;
    }
    public static PendingIntent getActivity(android.content.Context context, int requestCode, android.content.Intent intent, int flags) {
        PendingIntent p = getBroadcast(context, requestCode, intent, flags);
        p.activity = true;
        return p;
    }
    public android.content.IntentSender getIntentSender() { return new android.content.IntentSender(); }
}
