package android.app.job;

/** Compile stub: the job scheduler of the system (Android signatures; the tests give it a fake). */
public abstract class JobScheduler {
    public static final int RESULT_FAILURE = 0;
    public static final int RESULT_SUCCESS = 1;
    public abstract int schedule(JobInfo job);
    public abstract void cancel(int jobId);
    public abstract JobInfo getPendingJob(int jobId);
}
