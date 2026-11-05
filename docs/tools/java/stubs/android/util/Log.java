package android.util;

/** Compile stub: keeps what was logged so that the PC tests can read it. */
public final class Log {
    public static final java.util.ArrayList<String> stubLines = new java.util.ArrayList<String>();
    public static int i(String tag, String msg) { stubLines.add(tag + ": " + msg); return 0; }
}
