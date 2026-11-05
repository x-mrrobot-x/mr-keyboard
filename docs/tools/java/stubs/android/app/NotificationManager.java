package android.app;

/** Compile stub (the tests give it a fake). */
public class NotificationManager {
    public static final int IMPORTANCE_NONE = 0;
    public static final int IMPORTANCE_LOW = 2;
    public void createNotificationChannel(NotificationChannel channel) { }
    public NotificationChannel getNotificationChannel(String channelId) { return null; }
    public void notify(int id, Notification notification) { }
    public void cancel(int id) { }
    public boolean areNotificationsEnabled() { return true; }
}
