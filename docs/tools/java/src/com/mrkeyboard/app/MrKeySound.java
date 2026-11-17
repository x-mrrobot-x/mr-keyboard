package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.media.AudioAttributes;
import android.media.AudioManager;
import android.media.SoundPool;
import android.preference.PreferenceManager;

/**
 * The sound of the keys. "Default" is the click of the system (as it always was: LatinIME.playKeyClick asks the AudioManager); the thirteen
 * other styles are short sounds made for the keyboard (res/raw/mr_snd_*.ogg, built by docs/tools/make_key_sounds.py) and played here with a
 * SoundPool, with the volume of the screen "Keyboard sound" (pref_click_volume).
 *
 * <p>The style is the preference {@link #KEY}; the person chooses it on MrSoundActivity, and "mute" there is the old preference sound_on
 * turned off (LatinIME only asks for a sound when sound_on is true and the phone is not in silent mode, so this class never has to
 * look at them). The sound is played on the sonification stream, the one of the system click: it follows the volume of the system and
 * the silent mode. One sound is kept loaded: the one of the style in use; a new style unloads the old one.
 *
 * <p>{@link #play} answers whether the key was handled: false means "play the system click" (Default, a style that cannot be played). While
 * a style is still loading the answer is true and nothing is heard, so the first key after a change is not a different sound. The preview of
 * the screen is the exception: a sound asked for while it loads is heard as soon as it is loaded (the first touch on a tile must be heard).
 * Nothing here can throw: a key sound must never be able to break typing.
 */
final class MrKeySound {
    static final String KEY = "pref_sound_style";
    static final String DEFAULT = "default";
    /** The volume of the screen (a float in a string, 0 to 1), the same preference that the settings screen has always had. */
    static final String VOLUME_KEY = "pref_click_volume";
    static final float VOLUME_DEFAULT = 0.8f;
    /** The styles that are sounds of the app, in the order of the files res/raw/mr_snd_&lt;style&gt;.ogg. */
    static final String[] STYLES = {"bubble", "bubble2", "bell", "duck", "keyboard", "fox", "pistol", "wand", "frog", "cat", "drop", "rocket", "mouse"};

    /** The effect types of the system click (AudioManager.FX_KEYPRESS_*): the key tells the sound apart a little (the pitch). */
    static final int FX_STANDARD = 5;
    static final int FX_SPACEBAR = 6;
    static final int FX_DELETE = 7;
    static final int FX_RETURN = 8;

    private static final int LOADING = 0;
    private static final int READY = 1;
    private static final int FAILED = 2;
    private static final int STREAMS = 4;

    private static SoundPool sPool;
    private static String sStyle;
    private static int sSample;
    private static int sState = FAILED;
    /** The volume of a preview asked for while the sound was loading (played when it is loaded); negative when there is none. */
    private static float sPending = -1f;

    private MrKeySound() { }

    static boolean known(String style) {
        for (String s : STYLES) if (s.equals(style)) return true;
        return false;
    }

    /** The style in the preferences: a known one, else DEFAULT (nothing chosen, a name that no longer exists). */
    static String style(SharedPreferences p) {
        String s = p == null ? null : p.getString(KEY, DEFAULT);
        return known(s) ? s : DEFAULT;
    }

    /** The volume of the screen, 0 to 1; a value that is missing or cannot be read is the default. */
    static float volume(SharedPreferences p) {
        float v = VOLUME_DEFAULT;
        try {
            String s = p == null ? null : p.getString(VOLUME_KEY, null);
            if (s != null) v = Float.parseFloat(s.trim());
        } catch (RuntimeException e) {
            v = VOLUME_DEFAULT;
        }
        if (!(v >= 0f)) return VOLUME_DEFAULT; // also NaN
        return v > 1f ? 1f : v;
    }

    /** How fast the sound is played for each key: delete a little lower, space and return a little different, the rest as it was made. */
    static float rate(int effect) {
        switch (effect) {
            case FX_DELETE: return 0.85f;
            case FX_SPACEBAR: return 0.92f;
            case FX_RETURN: return 1.08f;
            default: return 1f;
        }
    }

    /** True when the key was handled here (LatinIME then does not ask for the system click). */
    static boolean play(Context ctx, int effect) {
        try {
            SharedPreferences p = PreferenceManager.getDefaultSharedPreferences(ctx);
            String style = style(p);
            if (DEFAULT.equals(style)) return false;
            return start(ctx, style, volume(p), rate(effect), false);
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** What the person hears when a style is chosen or the volume is let go on the screen: the sound of the style, or the system click for Default. */
    static void preview(Context ctx, String style) {
        try {
            if (known(style)) {
                SharedPreferences p = PreferenceManager.getDefaultSharedPreferences(ctx);
                start(ctx, style, volume(p), 1f, true);
            } else {
                Object am = ctx.getSystemService(Context.AUDIO_SERVICE);
                if (am instanceof AudioManager) ((AudioManager) am).playSoundEffect(AudioManager.FX_KEYPRESS_STANDARD, -1f);
            }
        } catch (RuntimeException e) {
            // nothing to hear, nothing to break
        }
    }

    /** Loads the sound of a style ahead of the first key (the screen does it when a style is chosen). */
    static void preload(Context ctx, String style) {
        try {
            if (known(style)) ensure(ctx, style);
        } catch (RuntimeException e) {
            // it is loaded by the first key then
        }
    }

    /** Lets go of the pool (the tests do it between cases; the app keeps it as long as it lives). */
    static synchronized void release() {
        if (sPool != null) {
            try {
                sPool.release();
            } catch (RuntimeException e) {
                // gone already
            }
        }
        sPool = null;
        sStyle = null;
        sSample = 0;
        sState = FAILED;
        sPending = -1f;
    }

    private static boolean start(Context ctx, String style, float volume, float rate, boolean preview) {
        int state;
        SoundPool pool;
        int sample;
        synchronized (MrKeySound.class) {
            state = ensure(ctx, style);
            pool = sPool;
            sample = sSample;
            if (preview && state == LOADING) sPending = volume;
        }
        if (state == FAILED) return false;      // the file is missing or cannot be loaded: the system click, as before
        if (state == READY) pool.play(sample, volume, volume, 1, 0, rate);
        return true;
    }

    /** Makes the pool and the sample of the style; the state says whether it can be played already. */
    private static synchronized int ensure(Context ctx, String style) {
        if (sPool == null) {
            sPool = new SoundPool.Builder().setMaxStreams(STREAMS)
                    .setAudioAttributes(new AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_ASSISTANCE_SONIFICATION)
                            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION).build()).build();
            sPool.setOnLoadCompleteListener(new SoundPool.OnLoadCompleteListener() {
                public void onLoadComplete(SoundPool pool, int sampleId, int status) {
                    float pending = -1f;
                    synchronized (MrKeySound.class) {
                        if (sampleId == sSample) {
                            sState = status == 0 ? READY : FAILED;
                            if (sState == READY) pending = sPending;
                            sPending = -1f;
                        }
                    }
                    if (pending >= 0f) {
                        try {
                            pool.play(sampleId, pending, pending, 1, 0, 1f);
                        } catch (RuntimeException e) {
                            // nothing to hear, nothing to break
                        }
                    }
                }
            });
            sStyle = null;
        }
        if (!style.equals(sStyle)) {
            if (sSample != 0) sPool.unload(sSample);
            sStyle = style;
            sSample = 0;
            sState = FAILED;
            sPending = -1f;
            Context app = ctx.getApplicationContext();
            Context use = app != null ? app : ctx;
            int res = use.getResources().getIdentifier("mr_snd_" + style, "raw", use.getPackageName());
            if (res != 0) {
                sSample = sPool.load(use, res, 1);
                sState = sSample == 0 ? FAILED : LOADING;
            }
        }
        return sState;
    }
}
