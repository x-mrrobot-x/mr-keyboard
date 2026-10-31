package android.os;

public class Build {
    public static class VERSION {
        /** Não pode ser final: constante o javac embute (0) e o "if (SDK_INT >= N)" sumiria do código gerado. */
        public static int SDK_INT = 0;
    }
}
