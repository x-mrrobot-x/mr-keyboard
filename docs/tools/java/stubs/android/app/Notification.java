package android.app;

/** Compile stub: the builder keeps what it is given so that the PC tests can read it. */
public class Notification {
    public String channelId;
    public int smallIcon;
    public CharSequence contentTitle, contentText;
    public PendingIntent contentIntent;
    public boolean autoCancel;

    public static class Builder {
        private final Notification n = new Notification();
        public Builder(android.content.Context context, String channelId) { n.channelId = channelId; }
        public Builder setSmallIcon(int icon) { n.smallIcon = icon; return this; }
        public Builder setContentTitle(CharSequence title) { n.contentTitle = title; return this; }
        public Builder setContentText(CharSequence text) { n.contentText = text; return this; }
        public Builder setContentIntent(PendingIntent intent) { n.contentIntent = intent; return this; }
        public Builder setAutoCancel(boolean autoCancel) { n.autoCancel = autoCancel; return this; }
        public Notification build() { return n; }
    }
}
