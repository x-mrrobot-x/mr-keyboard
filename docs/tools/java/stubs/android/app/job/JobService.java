package android.app.job;

/**
 * Compile stub (in Android jobFinished is final and the system calls the two methods on the main thread). Here it
 * only records what the service said, for the PC tests.
 */
public abstract class JobService extends android.app.Service {
    public int finishedCount;
    public boolean lastWantsReschedule;

    public abstract boolean onStartJob(JobParameters params);
    public abstract boolean onStopJob(JobParameters params);

    public void jobFinished(JobParameters params, boolean wantsReschedule) {
        finishedCount++;
        lastWantsReschedule = wantsReschedule;
    }
}
