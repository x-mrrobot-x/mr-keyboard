package com.mrkeyboard.app;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.IOException;
import java.io.InputStream;

/**
 * The landscapes that can be the background of the keyboard: 48 pictures, eight in each of six categories (sports, animals, snow, nature, anime and AI).
 * They are stored in the app as small WebP files ({@code assets/mr_scenes/<category>_<number>.webp}, 10 to 40 KB each). The first six of each category are the
 * part of a sheet that is the picture, at the size it was made, without the frame; the seventh and the eighth are drawn by {@code docs/tools/make_scenes.py} and read when one is shown. They are dark on purpose (the keys over a background carry light
 * ink; {@link MrBackdrop#look} sets the veil for what is not).
 *
 * <p>A keyboard is a wide strip and a picture is not, so every picture says where its strip goes ({@link #focus}: the vertical position of the part
 * that is shown, as the {@code dy} of {@link MrBackdrop#crop}): the one that keeps the subject in the strip. {@link MrBackdrop.Spec#scene} puts it in the
 * spec, so a landscape is drawn as a picture of the gallery is, from a bitmap that the caller reads with {@link #load}.
 */
final class MrScenes {
    /** The categories, eight pictures in each. */
    static final int CATEGORIES = 6;
    static final int PER_CATEGORY = 8;
    /** The number of landscapes. */
    static final int COUNT = CATEGORIES * PER_CATEGORY;

    /** Sports, animals, snow, nature, anime, AI (the order of the sections on the screen). */
    static final int SPORTS = 0, ANIMALS = 1, SNOW = 2, NATURE = 3, ANIME = 4, AI = 5;

    /** The name of the category in the files, in the order above. */
    private static final String[] SLUGS = {"sports", "animals", "snow", "nature", "anime", "ai"};

    /** Where the strip goes in each picture, -100 (the top of the picture) .. 100 (the bottom), 0 = the middle; in the order of the landscapes. */
    private static final int[] FOCUS = {
            0, -25, 10, -15, -35, -25, -10, 0,
            0, -10, 0, -30, -40, -30, 0, 0,
            30, 0, 40, 0, -20, 10, 30, 0,
            0, -40, 10, 0, 10, 0, 10, 20,
            -10, 0, 0, 0, 0, -30, 0, 10,
            0, 0, 0, 0, 0, 0, 0, 15};

    private MrScenes() { }

    /** The category (0 .. CATEGORIES - 1) of landscape {@code scene}; -1 when there is no such landscape. */
    static int category(int scene) {
        return valid(scene) ? scene / PER_CATEGORY : -1;
    }

    /** The place of the landscape in its category (0 .. PER_CATEGORY - 1); -1 when there is no such landscape. */
    static int number(int scene) {
        return valid(scene) ? scene % PER_CATEGORY : -1;
    }

    /** The landscape that is number {@code number} of {@code category}. */
    static int scene(int category, int number) {
        return category * PER_CATEGORY + number;
    }

    static boolean valid(int scene) {
        return scene >= 0 && scene < COUNT;
    }

    /** The vertical position of the strip of landscape {@code scene} ({@link MrBackdrop#crop}); 0 for an unknown one. */
    static int focus(int scene) {
        return valid(scene) ? FOCUS[scene] : 0;
    }

    /** The path of the file of landscape {@code scene} in the assets; null for an unknown one. */
    static String path(int scene) {
        if (!valid(scene)) return null;
        return "mr_scenes/" + SLUGS[category(scene)] + "_" + (number(scene) + 1) + ".webp";
    }

    /**
     * The picture of landscape {@code scene}, or null when it cannot be read (no such landscape, a file that is gone, not enough memory). {@code sample}
     * is the power of two that the picture is made smaller by (1 = as it is, 2 = half of the width and of the height), for the small tiles. The
     * caller owns the bitmap. Reads a file: not for the main thread when many are asked for.
     */
    static Bitmap load(Context c, int scene, int sample) {
        String path = path(scene);
        if (c == null || path == null) return null;
        InputStream in = null;
        try {
            AssetManager am = c.getAssets();
            in = am.open(path);
            BitmapFactory.Options o = new BitmapFactory.Options();
            o.inSampleSize = Math.max(1, sample);
            o.inPreferredConfig = Bitmap.Config.ARGB_8888;
            return BitmapFactory.decodeStream(in, null, o);
        } catch (IOException e) {
            return null;
        } catch (RuntimeException e) {
            return null;
        } catch (OutOfMemoryError e) {
            return null;
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    // nothing to do
                }
            }
        }
    }

    static Bitmap load(Context c, int scene) {
        return load(c, scene, 1);
    }
}
