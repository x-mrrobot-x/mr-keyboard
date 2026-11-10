package android.os;

public class Handler {
    private final java.util.ArrayList<Runnable> stubQueue = new java.util.ArrayList<Runnable>();
    public Handler(Looper looper) { }
    public final boolean post(Runnable r) { stubQueue.add(r); return true; }
    public final boolean postDelayed(Runnable r, long delayMillis) { stubQueue.add(r); return true; }
    public final void removeCallbacks(Runnable r) { stubQueue.remove(r); }
    /** Runs what is pending: the PC tests use it to reach the long press of the drag. */
    public void stubRunPending() {
        while (!stubQueue.isEmpty()) stubQueue.remove(0).run();
    }
}
