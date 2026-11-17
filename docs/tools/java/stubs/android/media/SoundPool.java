package android.media;

/** Compile stub (API 21): the PC tests read back what was loaded and played, and finish a load by hand. */
public class SoundPool {
    public interface OnLoadCompleteListener {
        void onLoadComplete(SoundPool soundPool, int sampleId, int status);
    }

    public static class Builder {
        private int maxStreams = 1;
        private AudioAttributes attributes;
        public Builder() { }
        public Builder setMaxStreams(int maxStreams) { this.maxStreams = maxStreams; return this; }
        public Builder setAudioAttributes(AudioAttributes attributes) { this.attributes = attributes; return this; }
        public SoundPool build() {
            SoundPool p = new SoundPool();
            p.stubMaxStreams = maxStreams;
            p.stubAttributes = attributes;
            stubCreated.add(p);
            return p;
        }
    }

    /** Every pool made since the last reset (the tests clear it). */
    public static final java.util.List<SoundPool> stubCreated = new java.util.ArrayList<SoundPool>();
    public int stubMaxStreams;
    public AudioAttributes stubAttributes;
    public boolean stubReleased;
    /** The resource ids passed to load, in order; the id that load answers with is its index + 1 (0 when stubFailLoad). */
    public final java.util.List<Integer> stubLoaded = new java.util.ArrayList<Integer>();
    public final java.util.List<Integer> stubUnloaded = new java.util.ArrayList<Integer>();
    /** One entry per play: sample id, left, right, rate. */
    public final java.util.List<float[]> stubPlays = new java.util.ArrayList<float[]>();
    public boolean stubFailLoad;
    /** Makes every load of every pool fail (the PC tests cannot reach the pool that MrKeySound makes by itself). */
    public static boolean stubFailAllLoads;
    public boolean stubThrowOnPlay;
    private OnLoadCompleteListener listener;

    public void setOnLoadCompleteListener(OnLoadCompleteListener l) { listener = l; }
    public int load(android.content.Context context, int resId, int priority) {
        if (stubFailLoad || stubFailAllLoads) return 0;
        stubLoaded.add(resId);
        return stubLoaded.size();
    }
    public boolean unload(int soundId) { stubUnloaded.add(soundId); return true; }
    public int play(int soundId, float leftVolume, float rightVolume, int priority, int loop, float rate) {
        if (stubThrowOnPlay) throw new IllegalStateException("released");
        stubPlays.add(new float[] {soundId, leftVolume, rightVolume, rate});
        return stubPlays.size();
    }
    public void release() { stubReleased = true; }
    /** The tests finish a load: the listener hears it as the framework would say it. */
    public void stubComplete(int sampleId, int status) { if (listener != null) listener.onLoadComplete(this, sampleId, status); }
}
