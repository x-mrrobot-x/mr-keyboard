package android.app;

/** Compile stub. */
public class NotificationChannel {
    private final String id;
    private final CharSequence name;
    private int importance;
    public NotificationChannel(String id, CharSequence name, int importance) {
        this.id = id;
        this.name = name;
        this.importance = importance;
    }
    public String getId() { return id; }
    public CharSequence getName() { return name; }
    public int getImportance() { return importance; }
    public void setImportance(int importance) { this.importance = importance; }
}
