package android.app;

/** Compile stub: keeps the registered callbacks so that the PC tests can fire the lifecycle by hand. */
public class Application extends android.content.ContextWrapper {
    public interface ActivityLifecycleCallbacks {
        void onActivityCreated(Activity activity, android.os.Bundle savedInstanceState);
        void onActivityStarted(Activity activity);
        void onActivityResumed(Activity activity);
        void onActivityPaused(Activity activity);
        void onActivityStopped(Activity activity);
        void onActivitySaveInstanceState(Activity activity, android.os.Bundle outState);
        void onActivityDestroyed(Activity activity);
    }

    public final java.util.ArrayList<ActivityLifecycleCallbacks> registered =
            new java.util.ArrayList<ActivityLifecycleCallbacks>();

    public void registerActivityLifecycleCallbacks(ActivityLifecycleCallbacks callback) {
        registered.add(callback);
    }
}
