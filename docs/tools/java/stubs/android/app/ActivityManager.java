package android.app;

/** Compile stub: what MrScreens gives the task of the app (its title in the list of recent apps). */
public class ActivityManager {
    public static class TaskDescription {
        private final String mLabel;

        public TaskDescription(String label) { mLabel = label; }

        public String getLabel() { return mLabel; }
    }
}
