package android.os;

/** Compile and PC test stub: the native heap is a field that the tests set. */
public final class Debug {
    public static long stubNativeHeap;

    public static long getNativeHeapAllocatedSize() { return stubNativeHeap; }

    /** The PC tests read what was asked and set stubDumpFails to make the call throw, like a full disk. */
    public static String stubDumpedTo;
    public static boolean stubDumpFails;

    public static void dumpHprofData(String fileName) throws java.io.IOException {
        if (stubDumpFails) throw new java.io.IOException("no space");
        stubDumpedTo = fileName;
        java.io.FileOutputStream out = new java.io.FileOutputStream(fileName);
        try {
            out.write("JAVA PROFILE STUB".getBytes("UTF-8"));
        } finally {
            out.close();
        }
    }
}
