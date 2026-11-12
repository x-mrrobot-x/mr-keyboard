package android.os;

public class Handler {
    private final java.util.List<Runnable> stubQueue = java.util.Collections.synchronizedList(new java.util.ArrayList<Runnable>());
    public Handler(Looper looper) { }
    public final boolean post(Runnable r) { stubQueue.add(r); return true; }
    public final boolean postDelayed(Runnable r, long delayMillis) { stubQueue.add(r); return true; }
    public final void removeCallbacks(Runnable r) { stubQueue.remove(r); }
    /** Runs what is pending: the PC tests use it to reach the long press of the drag. */
    public void stubRunPending() {
        while (true) {
            Runnable r;
            synchronized (stubQueue) {
                if (stubQueue.isEmpty()) return;
                r = stubQueue.remove(0);
            }
            r.run();
        }
    }
    /** Runs only what is pending now (work that posts itself again, like a key repeat, runs once). */
    public void stubRunOnce() {
        java.util.ArrayList<Runnable> now;
        synchronized (stubQueue) {
            now = new java.util.ArrayList<Runnable>(stubQueue);
            stubQueue.clear();
        }
        for (Runnable r : now) r.run();
    }
    /** Work waiting (a thread may post from the background). */
    public int stubPending() { return stubQueue.size(); }
}
