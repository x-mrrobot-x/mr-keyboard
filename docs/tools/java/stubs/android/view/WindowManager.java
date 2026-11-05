package android.view;

public interface WindowManager {
    public static class LayoutParams extends android.view.ViewGroup.LayoutParams {
        public static final int FLAG_DIM_BEHIND = 2;
        public static final int FLAG_HARDWARE_ACCELERATED = 0x01000000;
        public static final int TYPE_APPLICATION_ATTACHED_DIALOG = 1003;
        public android.os.IBinder token;
        public int type;
        public int gravity;
        public int flags;
        public LayoutParams() { super(0, 0); }
    }
}
