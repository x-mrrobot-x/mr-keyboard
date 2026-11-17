package android.media;

/** Compile stub: the sound effects that were asked for (the PC tests read them back). */
public class AudioManager {
    public static final int FX_KEYPRESS_STANDARD = 5;
    public final java.util.List<float[]> stubEffects = new java.util.ArrayList<float[]>();
    public void playSoundEffect(int effectType, float volume) { stubEffects.add(new float[] {effectType, volume}); }
}
