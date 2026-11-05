package android.os;

public class Build {
    public static class VERSION {
        /** Cannot be final: javac inlines the constant (0) and the "if (SDK_INT >= N)" would vanish from the generated code. */
        public static int SDK_INT = 0;
    }
}
