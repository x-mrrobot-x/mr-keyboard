package android.os;

/** Compile and PC test stub: the native heap is a field that the tests set. */
public final class Debug {
    public static long stubNativeHeap;

    public static long getNativeHeapAllocatedSize() { return stubNativeHeap; }
}
