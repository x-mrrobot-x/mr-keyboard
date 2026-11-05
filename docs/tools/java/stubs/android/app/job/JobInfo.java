package android.app.job;

/** Compile stub: only what the Mr Keyboard Java layer uses; it keeps the values so that the PC tests can read them. */
public class JobInfo {
    public static final int NETWORK_TYPE_NONE = 0;
    public static final int NETWORK_TYPE_ANY = 1;

    private final int id;
    private final android.content.ComponentName service;
    private final long minLatency;
    private final int networkType;
    private final boolean persisted;

    private JobInfo(Builder b) {
        id = b.id;
        service = b.service;
        minLatency = b.minLatency;
        networkType = b.networkType;
        persisted = b.persisted;
    }

    public int getId() { return id; }
    public android.content.ComponentName getService() { return service; }
    public long getMinLatencyMillis() { return minLatency; }
    public int getNetworkType() { return networkType; }
    public boolean isPersisted() { return persisted; }

    public static final class Builder {
        private final int id;
        private final android.content.ComponentName service;
        private long minLatency;
        private int networkType;
        private boolean persisted;

        public Builder(int jobId, android.content.ComponentName jobService) {
            id = jobId;
            service = jobService;
        }

        public Builder setMinimumLatency(long minLatencyMillis) { minLatency = minLatencyMillis; return this; }
        public Builder setRequiredNetworkType(int networkType) { this.networkType = networkType; return this; }
        public Builder setPersisted(boolean isPersisted) { persisted = isPersisted; return this; }
        public JobInfo build() { return new JobInfo(this); }
    }
}
