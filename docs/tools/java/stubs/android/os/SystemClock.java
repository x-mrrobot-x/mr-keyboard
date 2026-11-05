package android.os;

/** Compile and PC test stub: the clock is a field that the tests move. */
public final class SystemClock {
    public static long now;

    public static long elapsedRealtime() { return now; }
}
