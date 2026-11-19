package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.RadialGradient;
import android.graphics.Rect;
import android.graphics.Shader;
import android.media.ExifInterface;
import android.os.Build;
import android.preference.PreferenceManager;
import android.view.View;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * The background of the keyboard: what is drawn behind the toolbar and the keys instead of the flat colour of a theme (the colours, gradients, landscapes
 * and the picture of the gallery of the themes screen). A background is a theme of its own: choosing one puts the keyboard in one of the themes of
 * the backgrounds ({@link #themeTag}: flat keys, see-through with light ink or dark ink, or one of the styles of dense keys, {@link #STYLE_TAGS}) and
 * choosing any other theme puts the background away, so the two are never mixed and the themes of the list always look the way they do.
 *
 * <h3>The preference</h3>
 * {@link #PREF} holds one text, the spec: empty = no background; {@code c<N>} = colour N; {@code g<N>} = gradient N; {@code s<N>} = landscape N
 * ({@link MrScenes}: a picture of the app, drawn as the one of the gallery is); {@code i<zoom>,<dx>,<dy>,<stamp>} = the picture of the gallery the person chose ({@link #FILE}, in the files of the app),
 * with the zoom in per cent (100 .. 400), the position (dx and dy, -100 .. 100: how far the shown part is moved between the two edges) and the
 * time the picture was chosen (so that a new picture of the same settings is a new value, and the caches know it). A text that does not parse
 * is "no background". {@link #PREF_SOFT} is how much a gradient, a landscape or a picture is softened (0 .. {@link #MAX_SOFT} per cent): a plain colour is not.
 *
 * <h3>Legibility</h3>
 * Whatever the background, the ink of the toolbar (the suggestions, the icons) must stay readable: the theme of the background has light ink or
 * dark ink. A veil of the opposite colour (black under light ink, white under dark ink) is laid over the background; how strong it is comes
 * from the brightness of the background itself ({@link #look}): the average of a small copy of it, and the average of its upper part where the
 * toolbar is, must end up no brighter than {@link #DARK_TARGET} under light ink, no darker than {@link #LIGHT_TARGET} under dark ink, and never
 * less than the softening that the person set. A plain colour has no veil (it is shown as it is: its ink is the one that reads on it,
 * {@link #darkInk}).
 *
 * <h3>On the keyboard</h3>
 * {@link #apply} (MrTools.applyTranslucentBlur calls it when the keyboard is made and when it is shown) puts a {@link MrBackdropDrawable} as the
 * background of the root of the toolbar (the bar, the panels and the keys on the same sheet) and leaves the keyboard view clear.
 * {@link #bottomColor} is the colour of its lower edge: the navigation bar is asked for it up to Android 15 (MrBottom.bar), as it is asked for
 * the colour of the theme without a background.
 */
final class MrBackdrop {
    static final String PREF = "pref_kbd_bg";
    static final String PREF_SOFT = "pref_kbd_bg_soft";
    /** The picture, in the files of the app (JPEG). */
    static final String FILE = "kbd_bg.jpg";
    /** The picture that was just chosen and is not the background yet (it becomes {@link #FILE} when the person applies it). */
    static final String PENDING = "kbd_bg_new.jpg";

    static final int NONE = 0, GRADIENT = 1, SCENE = 2, IMAGE = 3, COLOR = 4;

    /** The longest side of the stored picture, in pixels (a keyboard shows a part of it: more would only cost memory). */
    static final int MAX_SIDE = 1280;
    static final int JPEG_QUALITY = 90;
    static final int ZOOM_MIN = 100, ZOOM_MAX = 400;
    static final int MAX_SOFT = 70;

    /** The average brightness that a dark theme's background may not exceed, and that a light theme's may not fall below. */
    static final float DARK_TARGET = 0.40f;
    static final float LIGHT_TARGET = 0.62f;
    /** The veil is never denser than this (the background must still be seen). */
    static final float MAX_VEIL = 0.75f;

    /** Shape of the keyboard that a preview and the small copy stand for (width / height). */
    static final float ASPECT = 2.4f;
    /** Size of the small copy that the brightness is measured on. */
    static final int PROBE_W = 48;
    /** The share of the height of the keyboard that the toolbar (the line of suggestions, the ink that must stay readable) takes at the top. */
    static final float BAR_SHARE = 0.17f;

    /** The plain colours (opaque), in the order of the tiles. */
    static final int[] COLORS = {
            0xff263238, 0xfff8f9fa, 0xff37393d, 0xffc62828,
            0xff00695c, 0xff1565c0, 0xff80deea, 0xff4527a0,
            0xff6a1b9a, 0xffad1457, 0xfff8bbd0, 0xffd7ccc8,
            0xff4e342e, 0xff37474f, 0xff000000, 0xff161616};

    /** The contrast with white that a colour needs to carry white ink; under it the ink is dark. */
    static final float WHITE_INK_CONTRAST = 4.5f;

    /** A gradient: the angle, its colours from the start to the end (and where each one sits, or null for even steps) and a soft light (or null). */
    static final class Grad {
        /** Degrees as in CSS: 0 = from the bottom up, 90 = from the left to the right, 180 = from the top down. */
        final int angle;
        final int[] colours;
        final float[] stops;
        /** {x, y, radius}, each in per cent of the width (the radius too), and the colour that fades out to nothing at the radius; or null. */
        final int[] glow;

        Grad(int angle, int[] colours, float[] stops, int[] glow) {
            this.angle = angle;
            this.colours = colours;
            this.stops = stops;
            this.glow = glow;
        }
    }

    private static Grad down(int... colours) {
        return new Grad(180, colours, null, null);
    }

    /** The gradients: dark ones, from the top down; two of them have a light in a corner. */
    static final Grad[] GRADS = {
            down(0xff1b1464, 0xff5b2a86, 0xffb24fa4),
            down(0xff62656a, 0xff38393d, 0xff060607),
            down(0xff5c6b73, 0xff2b363c),
            down(0xff00836f, 0xff00594f),
            down(0xff1a75e3, 0xff0d4fb3),
            new Grad(180, new int[] {0xff376896, 0xff2f587d, 0xff1c3249, 0xff0e1826}, new float[] {0f, 0.55f, 0.88f, 1f}, null),
            down(0xff595b60, 0xff2f3338),
            down(0xff0b564c, 0xff011f1e),
            down(0xff00858a, 0xff115761),
            down(0xff8479a5, 0xff4a4258),
            down(0xff514b9c, 0xff1f5f75),
            down(0xff00708f, 0xff1c4560),
            down(0xff4e2cc0, 0xff2c1a82),
            down(0xffb0175a, 0xff8c0d48),
            down(0xff0594e0, 0xff0235ae),
            new Grad(180, new int[] {0xff2f2745, 0xff6a58a6, 0xffa77c88}, new float[] {0f, 0.7f, 1f}, null),
            down(0xff0a4fa0, 0xff53309f),
            new Grad(180, new int[] {0xff1040c4, 0xff0c68a8}, null, new int[] {50, 92, 62, 0xd90eb060}),
            down(0xff5c3a62, 0xff8c5068),
            new Grad(180, new int[] {0xff3a5f92, 0xff3b4f82}, null, new int[] {100, 100, 78, 0xe6e8707c})};

    static final int GRADIENT_COUNT = GRADS.length;

    private MrBackdrop() { }

    // ---- the spec

    /** What the preference says, parsed. Immutable. */
    static final class Spec {
        final int kind;
        /** Colour, gradient or landscape number. */
        final int index;
        /** Picture: zoom in per cent, position, and the time it was chosen. */
        final int zoom, dx, dy;
        final long stamp;

        private Spec(int kind, int index, int zoom, int dx, int dy, long stamp) {
            this.kind = kind;
            this.index = index;
            this.zoom = zoom;
            this.dx = dx;
            this.dy = dy;
            this.stamp = stamp;
        }

        static final Spec NO = new Spec(NONE, 0, 100, 0, 0, 0L);

        static Spec color(int n) {
            return n >= 0 && n < COLORS.length ? new Spec(COLOR, n, 100, 0, 0, 0L) : NO;
        }

        static Spec gradient(int n) {
            return n >= 0 && n < GRADS.length ? new Spec(GRADIENT, n, 100, 0, 0, 0L) : NO;
        }

        static Spec scene(int n) {
            // the strip of the picture that suits it (MrScenes.focus): it is drawn as a picture, from the bitmap that MrScenes.load gives
            return MrScenes.valid(n) ? new Spec(SCENE, n, 100, 0, MrScenes.focus(n), 0L) : NO;
        }

        static Spec image(int zoom, int dx, int dy, long stamp) {
            return new Spec(IMAGE, 0, clamp(zoom, ZOOM_MIN, ZOOM_MAX), clamp(dx, -100, 100), clamp(dy, -100, 100), stamp);
        }

        /** The same picture with another zoom and position. */
        Spec moved(int zoom, int dx, int dy) {
            return kind == IMAGE ? image(zoom, dx, dy, stamp) : this;
        }

        /** Reads the text of the preference; anything that is not a spec is "no background". */
        static Spec parse(String s) {
            if (s == null || s.length() < 2) return NO;
            try {
                String body = s.substring(1);
                switch (s.charAt(0)) {
                    case 'c': return color(Integer.parseInt(body));
                    case 'g': return gradient(Integer.parseInt(body));
                    case 's': return scene(Integer.parseInt(body));
                    case 'i': {
                        String[] p = body.split(",", -1);
                        if (p.length != 4) return NO;
                        return image(Integer.parseInt(p[0]), Integer.parseInt(p[1]), Integer.parseInt(p[2]), Long.parseLong(p[3]));
                    }
                    default: return NO;
                }
            } catch (NumberFormatException e) {
                return NO;
            }
        }

        /** The text for the preference (empty for no background). */
        String format() {
            switch (kind) {
                case COLOR: return "c" + index;
                case GRADIENT: return "g" + index;
                case SCENE: return "s" + index;
                case IMAGE: return "i" + zoom + "," + dx + "," + dy + "," + stamp;
                default: return "";
            }
        }

        boolean same(Spec o) {
            return o != null && format().equals(o.format());
        }
    }

    static int clamp(int v, int lo, int hi) {
        return v < lo ? lo : v > hi ? hi : v;
    }

    /** The background that the preferences ask for now. */
    static Spec current(Context c) {
        SharedPreferences sp = prefs(c);
        return sp == null ? Spec.NO : Spec.parse(sp.getString(PREF, ""));
    }

    /** How much it is softened now, 0 .. MAX_SOFT. */
    static int soft(Context c) {
        SharedPreferences sp = prefs(c);
        if (sp == null) return 0;
        try {
            return clamp(sp.getInt(PREF_SOFT, 0), 0, MAX_SOFT);
        } catch (ClassCastException e) {
            return 0;
        }
    }

    private static SharedPreferences prefs(Context c) {
        return c == null ? null : PreferenceManager.getDefaultSharedPreferences(c);
    }

    // ---- drawing

    /**
     * Draws the background (no veil) over {@code w} x {@code h}; {@code image} is the picture for an IMAGE spec and for a SCENE one (the bitmap of
     * the landscape, {@link #bitmap}); null: nothing is drawn.
     */
    static void draw(Canvas canvas, Spec spec, int w, int h, Bitmap image) {
        if (canvas == null || spec == null || w <= 0 || h <= 0) return;
        switch (spec.kind) {
            case COLOR:
                canvas.drawColor(COLORS[spec.index]);
                break;
            case GRADIENT:
                gradient(canvas, spec.index, w, h);
                break;
            case SCENE:
            case IMAGE:
                if (image != null) picture(canvas, spec, image, w, h);
                break;
            default:
                break;
        }
    }

    private static void gradient(Canvas canvas, int n, int w, int h) {
        Grad g = GRADS[n];
        double a = Math.toRadians(g.angle);
        float dx = (float) Math.sin(a), dy = (float) -Math.cos(a);
        // the gradient runs along the angle through the centre, as long as the shape is deep in that direction
        float half = (Math.abs(dx) * w + Math.abs(dy) * h) / 2f;
        float cx = w / 2f, cy = h / 2f;
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        p.setDither(true);
        p.setShader(new LinearGradient(cx - dx * half, cy - dy * half, cx + dx * half, cy + dy * half, g.colours, g.stops, Shader.TileMode.CLAMP));
        canvas.drawRect(0, 0, w, h, p);
        if (g.glow != null) {
            // a soft light that fades out to nothing at its radius
            float gx = w * g.glow[0] / 100f, gy = h * g.glow[1] / 100f, gr = Math.max(1f, w * g.glow[2] / 100f);
            int c = g.glow[3];
            p.setShader(new RadialGradient(gx, gy, gr, new int[] {c, c & 0x00ffffff}, new float[] {0f, 1f}, Shader.TileMode.CLAMP));
            canvas.drawRect(0, 0, w, h, p);
        }
    }

    private static void picture(Canvas canvas, Spec spec, Bitmap image, int w, int h) {
        Rect src = crop(image.getWidth(), image.getHeight(), w, h, spec.zoom, spec.dx, spec.dy);
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        p.setFilterBitmap(true);
        canvas.drawBitmap(image, src, new Rect(0, 0, w, h), p);
    }

    /**
     * The part of a picture of {@code iw} x {@code ih} that fills a shape of {@code w} x {@code h}: the biggest part of that shape that fits
     * (nothing is stretched), made smaller by the zoom (100 = as it is, 200 = half of the width and of the height), and moved: dx and dy go from
     * -100 (against the left / top edge of the picture) to 100 (against the right / bottom one), 0 is the middle.
     */
    static Rect crop(int iw, int ih, int w, int h, int zoom, int dx, int dy) {
        if (iw <= 0 || ih <= 0 || w <= 0 || h <= 0) return new Rect(0, 0, Math.max(0, iw), Math.max(0, ih));
        double shape = w / (double) h;
        double cw, ch;
        if (iw / (double) ih > shape) {
            ch = ih;
            cw = ih * shape;
        } else {
            cw = iw;
            ch = iw / shape;
        }
        double z = clamp(zoom, ZOOM_MIN, ZOOM_MAX) / 100.0;
        cw /= z;
        ch /= z;
        double left = (iw - cw) * (clamp(dx, -100, 100) + 100) / 200.0;
        double top = (ih - ch) * (clamp(dy, -100, 100) + 100) / 200.0;
        // at least one pixel, and inside the picture even for a shape so thin that the part is less than a pixel
        int l = clamp((int) Math.round(left), 0, iw - 1), t = clamp((int) Math.round(top), 0, ih - 1);
        int r = Math.min(iw, l + (int) Math.round(cw)), b = Math.min(ih, t + (int) Math.round(ch));
        return new Rect(l, t, Math.max(l + 1, r), Math.max(t + 1, b));
    }

    /**
     * The new position after the finger moved the picture by {@code moveX} and {@code moveY} pixels of a view of {@code w} x {@code h} that shows
     * it: the picture follows the finger. Returns {dx, dy}. A direction in which the picture has no room to move (the shown part is as wide as the
     * picture) is left as it was.
     */
    static int[] pan(int iw, int ih, int w, int h, int zoom, int dx, int dy, float moveX, float moveY) {
        Rect r = crop(iw, ih, w, h, zoom, dx, dy);
        double freeX = iw - r.width(), freeY = ih - r.height();
        int nx = dx, ny = dy;
        if (freeX > 0.5 && w > 0) {
            // the part shown spans r.width() picture pixels over w view pixels; the left edge moves the other way from the finger
            double leftPx = r.left - moveX * r.width() / w;
            nx = clamp((int) Math.round(leftPx / freeX * 200.0 - 100.0), -100, 100);
        }
        if (freeY > 0.5 && h > 0) {
            double topPx = r.top - moveY * r.height() / h;
            ny = clamp((int) Math.round(topPx / freeY * 200.0 - 100.0), -100, 100);
        }
        return new int[] {nx, ny};
    }

    /**
     * The new position after the frame that shows a part of a picture of {@code iw} x {@code ih} (the shape {@code w} x {@code h}, at this zoom) is
     * moved by {@code moveX} and {@code moveY} pixels of the picture: the frame goes where the finger goes. Returns {dx, dy}; a direction in which
     * the frame has no room is left as it was.
     */
    static int[] shift(int iw, int ih, int w, int h, int zoom, int dx, int dy, float moveX, float moveY) {
        Rect r = crop(iw, ih, w, h, zoom, dx, dy);
        double freeX = iw - r.width(), freeY = ih - r.height();
        int nx = dx, ny = dy;
        if (freeX > 0.5) nx = clamp((int) Math.round((r.left + moveX) / freeX * 200.0 - 100.0), -100, 100);
        if (freeY > 0.5) ny = clamp((int) Math.round((r.top + moveY) / freeY * 200.0 - 100.0), -100, 100);
        return new int[] {nx, ny};
    }

    /**
     * The position that keeps the middle of the frame where it is when the zoom goes from {@code zoom} to {@code newZoom} (the frame grows or
     * shrinks around its middle). Returns {dx, dy}.
     */
    static int[] rezoom(int iw, int ih, int w, int h, int zoom, int dx, int dy, int newZoom) {
        Rect r = crop(iw, ih, w, h, zoom, dx, dy);
        double cx = r.left + r.width() / 2.0, cy = r.top + r.height() / 2.0;
        Rect n = crop(iw, ih, w, h, newZoom, 0, 0);
        double freeX = iw - n.width(), freeY = ih - n.height();
        int nx = dx, ny = dy;
        if (freeX > 0.5) nx = clamp((int) Math.round((cx - n.width() / 2.0) / freeX * 200.0 - 100.0), -100, 100);
        if (freeY > 0.5) ny = clamp((int) Math.round((cy - n.height() / 2.0) / freeY * 200.0 - 100.0), -100, 100);
        return new int[] {nx, ny};
    }

    /** Whether the background is drawn from a bitmap: the picture of the gallery and the landscapes. */
    static boolean needsBitmap(Spec spec) {
        return spec != null && (spec.kind == IMAGE || spec.kind == SCENE);
    }

    /**
     * The bitmap that a background is drawn from: the picture of the gallery (the one that is kept) or the landscape of the app; null for the
     * others and when it cannot be read. The caller owns it. Reads a file.
     */
    static Bitmap bitmap(Context c, Spec spec) {
        if (spec == null || c == null) return null;
        if (spec.kind == IMAGE) return load(c);
        if (spec.kind == SCENE) return MrScenes.load(c, spec.index);
        return null;
    }

    // ---- brightness and veil

    /** What the veil is and what the background looks like under it. */
    static final class Look {
        /** Average brightness of the background alone, 0 .. 1, over all of it and over the part where the toolbar is. */
        final float luminance, barLuminance;
        /** The veil: its alpha (0 .. 255) and its colour (black or white, opaque). */
        final int veilAlpha, veilColor;
        /** The colour of the lower edge of the background with the veil on it (opaque). */
        final int bottom;

        Look(float luminance, float barLuminance, int veilAlpha, int veilColor, int bottom) {
            this.luminance = luminance;
            this.barLuminance = barLuminance;
            this.veilAlpha = veilAlpha;
            this.veilColor = veilColor;
            this.bottom = bottom;
        }
    }

    /**
     * The alpha of the veil (0 .. 1) for a background of average brightness {@code lum} under a theme: the least that brings it to the target,
     * and never less than the softening {@code soft} (per cent). Dark theme: black, until the brightness is {@link #DARK_TARGET} at most; light
     * theme: white, until it is {@link #LIGHT_TARGET} at least.
     */
    static float veil(boolean dark, float lum, int soft) {
        float need = 0f;
        if (dark) {
            if (lum > DARK_TARGET) need = 1f - DARK_TARGET / lum;
        } else if (lum < LIGHT_TARGET) {
            need = (LIGHT_TARGET - lum) / (1f - lum);
        }
        need = Math.min(need, MAX_VEIL);
        return Math.max(need, clamp(soft, 0, MAX_SOFT) / 100f);
    }

    /** The colour {@code over} drawn at {@code alpha} (0 .. 1) on the opaque {@code under}. */
    static int mix(int under, int over, float alpha) {
        int r = Math.round(((under >> 16) & 0xff) * (1f - alpha) + ((over >> 16) & 0xff) * alpha);
        int g = Math.round(((under >> 8) & 0xff) * (1f - alpha) + ((over >> 8) & 0xff) * alpha);
        int b = Math.round((under & 0xff) * (1f - alpha) + (over & 0xff) * alpha);
        return 0xff000000 | (r << 16) | (g << 8) | b;
    }

    /** Measures a small copy of the background: the veil it needs and the colour of its lower edge. A picture that is not there gives null. */
    static Look look(Spec spec, Bitmap image, boolean dark, int soft) {
        if (spec == null || spec.kind == NONE) return null;
        if (needsBitmap(spec) && image == null) return null;
        int veilColor = dark ? 0xff000000 : 0xffffffff;
        if (spec.kind == COLOR) {
            // a plain colour is shown as it is: no veil, and the colour itself is the lower edge for the navigation bar
            float l = MrThemeColors.luminance(COLORS[spec.index]);
            return new Look(l, l, 0, veilColor, COLORS[spec.index]);
        }
        int h = Math.max(1, Math.round(PROBE_W / ASPECT));
        Bitmap small = Bitmap.createBitmap(PROBE_W, h, Bitmap.Config.ARGB_8888);
        draw(new Canvas(small), spec, PROBE_W, h, image);
        // the ink sits on the toolbar at the top: that part must be readable too, not only the average of the whole (a bright sky over dark hills)
        int barRows = Math.max(1, Math.min(h, Math.round(h * BAR_SHARE)));
        double sum = 0, barSum = 0;
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < PROBE_W; x++) {
                float l = MrThemeColors.luminance(small.getPixel(x, y));
                sum += l;
                if (y < barRows) barSum += l;
            }
        }
        float lum = (float) (sum / (PROBE_W * h));
        float barLum = (float) (barSum / (PROBE_W * barRows));
        float a = Math.max(veil(dark, lum, soft), veil(dark, barLum, soft));
        int r = 0, g = 0, b = 0;
        for (int x = 0; x < PROBE_W; x++) {
            int p = small.getPixel(x, h - 1);
            r += (p >> 16) & 0xff;
            g += (p >> 8) & 0xff;
            b += p & 0xff;
        }
        int bottom = mix(0xff000000 | ((r / PROBE_W) << 16) | ((g / PROBE_W) << 8) | (b / PROBE_W), veilColor, a);
        return new Look(lum, barLum, Math.round(a * 255f), veilColor, bottom);
    }

    // ---- the theme of a background

    /** The contrast ratio of two opaque colours as WCAG gives it (1 .. 21), on the linear brightness. */
    static float contrast(int a, int b) {
        float la = linear(a), lb = linear(b);
        float hi = Math.max(la, lb), lo = Math.min(la, lb);
        return (hi + 0.05f) / (lo + 0.05f);
    }

    private static float linear(int argb) {
        double r = channel((argb >> 16) & 0xff), g = channel((argb >> 8) & 0xff), b = channel(argb & 0xff);
        return (float) (0.2126 * r + 0.7152 * g + 0.0722 * b);
    }

    private static double channel(int v) {
        double c = v / 255.0;
        return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
    }

    /**
     * Whether the ink on this background is dark. White is the ink of every background by default; only a plain colour that is too light to carry
     * it (less than {@link #WHITE_INK_CONTRAST} to 1 against white, the AA level for text: the glass of the keys lightens it a little more) has a dark ink. The gradients are dark, and a landscape or a picture has its
     * veil, so none of them needs it.
     */
    static boolean darkInk(Spec spec) {
        return spec != null && spec.kind == COLOR && contrast(0xffffffff, COLORS[spec.index]) < WHITE_INK_CONTRAST;
    }

    /** The tag of the theme that a background puts the keyboard in: the one with the light ink or the one with the dark ink. */
    static String themeTag(Spec spec) {
        return themeTag(spec, 0);
    }

    /**
     * The tag of the theme that a background puts the keyboard in, with the style of keys chosen ({@link #STYLE_TAGS}). A background that needs
     * dark ink has only the see-through keys with dark ink (the dense styles all have white ink and would not read on the toolbar).
     */
    static String themeTag(Spec spec, int style) {
        if (darkInk(spec)) return TAG_DARK_INK;
        return STYLE_TAGS[clamp(style, 0, STYLES - 1)];
    }

    /** Whether the styles of keys can be chosen for this background (all but the plain colours that need dark ink). */
    static boolean hasStyles(Spec spec) {
        return spec != null && spec.kind != NONE && !darkInk(spec);
    }

    /** The style of keys that a theme tag stands for: its position in {@link #STYLE_TAGS}, 0 for any other theme (the see-through keys). */
    static int styleOf(String tag) {
        for (int i = 0; i < STYLES; i++) {
            if (STYLE_TAGS[i].equals(tag)) return i;
        }
        return 0;
    }

    static final String TAG_LIGHT_INK = "mr_overlight", TAG_DARK_INK = "mr_overdark";
    /**
     * The styles of the keys of a background, each one a theme of the backgrounds with light ink, all of them see-through (what shows through the
     * key is the background): the clear glass, four tinted glasses, six outlines (a line of one hue around an almost empty face) and four gradients
     * (the line, the labels and the light of the labels change hue along the keyboard). The dialog of a background lets the person pick one by kind
     * ({@link #KIND_FIRST}) and then by colour.
     */
    static final String[] STYLE_TAGS = {TAG_LIGHT_INK, "mr_overice", "mr_overlilac", "mr_overmint", "mr_overember",
            "mr_overline", "mr_overteal", "mr_overviolet", "mr_overfuchsia", "mr_overlime", "mr_overgold",
            "mr_overdawn", "mr_overtide", "mr_overprism", "mr_overlagoon"};
    static final int STYLES = STYLE_TAGS.length;
    /** The kinds of style: glass, outline and gradient. */
    static final int KIND_GLASS = 0, KIND_OUTLINE = 1, KIND_GRADIENT = 2, KINDS = 3;
    /** The first style of each kind (and, last, the number of styles): the styles of a kind are the ones from {@code KIND_FIRST[k]} up to the next. */
    static final int[] KIND_FIRST = {0, 5, 11, STYLES};
    /**
     * The colours that show a style in the dialog (the hue of the glass or of the line; the three hues a gradient turns through), opaque; the
     * see-through glass is white. Same order as {@link #STYLE_TAGS}.
     */
    static final int[][] STYLE_COLORS = {
            {0xffffffff}, {0xff4da3ff}, {0xffa77bff}, {0xff3ddc97}, {0xffff8a4c},
            {0xffffffff}, {0xff2de2e6}, {0xffa78bfa}, {0xffff5fd2}, {0xffa6e22e}, {0xffffc83d},
            {0xffffb347, 0xffff5fa2, 0xff9b6bff}, {0xff22e1ff, 0xff4d7cff, 0xffb06bff}, {0xffff4d6d, 0xff4dff9a, 0xff4d8dff}, {0xffa3ff5c, 0xff19e6b0, 0xff3d8bff}};

    /** The kind of a style: glass, outline or gradient. */
    static int kindOf(int style) {
        int s = clamp(style, 0, STYLES - 1);
        for (int k = KINDS - 1; k > 0; k--) {
            if (s >= KIND_FIRST[k]) return k;
        }
        return KIND_GLASS;
    }

    // ---- the picture of the gallery

    /** The stored picture, or null when there is none (or it cannot be read). The caller owns the bitmap. */
    static Bitmap load(Context c) {
        return decode(c, FILE);
    }

    /** The picture that was just chosen and is not the background yet, or null. The caller owns the bitmap. */
    static Bitmap loadPending(Context c) {
        return decode(c, PENDING);
    }

    private static Bitmap decode(Context c, String name) {
        try {
            File f = new File(c.getFilesDir(), name);
            if (!f.isFile()) return null;
            return BitmapFactory.decodeFile(f.getPath());
        } catch (RuntimeException e) {
            return null;
        } catch (OutOfMemoryError e) {
            return null;
        }
    }

    static boolean hasImage(Context c) {
        return has(c, FILE);
    }

    static boolean hasPending(Context c) {
        return has(c, PENDING);
    }

    private static boolean has(Context c, String name) {
        try {
            return new File(c.getFilesDir(), name).isFile();
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** The time the stored picture was written (0 when there is none): what a picture that was chosen before is told apart by. */
    static long imageStamp(Context c) {
        return stamp(c, FILE);
    }

    /** The same for the picture that is waiting to be applied. */
    static long pendingStamp(Context c) {
        return stamp(c, PENDING);
    }

    private static long stamp(Context c, String name) {
        try {
            File f = new File(c.getFilesDir(), name);
            return f.isFile() ? f.lastModified() : 0L;
        } catch (RuntimeException e) {
            return 0L;
        }
    }

    static void removeImage(Context c) {
        delete(c, FILE);
    }

    /** The picture that was chosen is let go of (the person cancelled). */
    static void discardPending(Context c) {
        delete(c, PENDING);
    }

    private static void delete(Context c, String name) {
        try {
            File f = new File(c.getFilesDir(), name);
            if (f.exists() && !f.delete()) f.deleteOnExit();
        } catch (RuntimeException e) {
            // the file stays; the next picture replaces it
        }
    }

    /** The picture that was chosen becomes the one of the background (in one step: a failure leaves the one that was there). */
    static boolean commitPending(Context c) {
        try {
            File from = new File(c.getFilesDir(), PENDING);
            return from.isFile() && from.renameTo(new File(c.getFilesDir(), FILE));
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** The power of two to decode a picture with, so that its longest side is still at least {@link #MAX_SIDE} (or the picture as it is, if smaller). */
    static int sampleSize(int w, int h) {
        int longest = Math.max(w, h);
        int s = 1;
        while (longest / (s * 2) >= MAX_SIDE) s *= 2;
        return s;
    }

    /** The quarter turns (in degrees) that the orientation tag of a photo asks for. */
    static int degrees(int orientation) {
        switch (orientation) {
            case ExifInterface.ORIENTATION_ROTATE_90: return 90;
            case ExifInterface.ORIENTATION_ROTATE_180: return 180;
            case ExifInterface.ORIENTATION_ROTATE_270: return 270;
            default: return 0;
        }
    }

    /**
     * Reads the picture that the person chose (the stream of the document that the gallery gave), makes it at most {@link #MAX_SIDE} on its longest
     * side, turned the way the photo says it was taken, and keeps it as {@link #PENDING}: it becomes the background only when {@link #commitPending} says so, so a picture that is not applied costs
     * nothing to the one that was there. Returns {width, height} of what was kept, or null when it was
     * not a picture the phone can read (what was there before stays). Slow (it decodes a photo): not for the main thread.
     */
    static int[] importPending(Context c, InputStream in) {
        File tmp = null, out = null;
        try {
            tmp = new File(c.getCacheDir(), "kbd_bg_in");
            copy(in, tmp);
            BitmapFactory.Options o = new BitmapFactory.Options();
            o.inJustDecodeBounds = true;
            BitmapFactory.decodeFile(tmp.getPath(), o);
            if (o.outWidth <= 0 || o.outHeight <= 0) return null;
            BitmapFactory.Options d = new BitmapFactory.Options();
            d.inSampleSize = sampleSize(o.outWidth, o.outHeight);
            d.inPreferredConfig = Bitmap.Config.ARGB_8888;
            Bitmap bm = BitmapFactory.decodeFile(tmp.getPath(), d);
            if (bm == null) return null;
            bm = fit(bm);
            bm = turn(bm, orientation(tmp));
            out = new File(c.getFilesDir(), PENDING + ".tmp");
            OutputStream os = new FileOutputStream(out);
            boolean ok;
            try {
                ok = bm.compress(Bitmap.CompressFormat.JPEG, JPEG_QUALITY, os);
            } finally {
                os.close();
            }
            // renameTo replaces the old pending picture in one step (Android is Linux): a failure leaves what was there
            if (!ok || !out.renameTo(new File(c.getFilesDir(), PENDING))) return null;
            return new int[] {bm.getWidth(), bm.getHeight()};
        } catch (IOException e) {
            return null;
        } catch (RuntimeException e) {
            return null;
        } catch (OutOfMemoryError e) {
            return null;
        } finally {
            if (tmp != null && tmp.exists()) tmp.delete();
            if (out != null && out.exists()) out.delete();
        }
    }

    private static void copy(InputStream in, File to) throws IOException {
        OutputStream os = new FileOutputStream(to);
        try {
            byte[] buf = new byte[16384];
            int n;
            while ((n = in.read(buf)) > 0) os.write(buf, 0, n);
        } finally {
            os.close();
        }
    }

    /** The picture scaled down to {@link #MAX_SIDE} on its longest side (as it is when it already is). */
    private static Bitmap fit(Bitmap bm) {
        int longest = Math.max(bm.getWidth(), bm.getHeight());
        if (longest <= MAX_SIDE) return bm;
        float k = MAX_SIDE / (float) longest;
        return Bitmap.createScaledBitmap(bm, Math.max(1, Math.round(bm.getWidth() * k)), Math.max(1, Math.round(bm.getHeight() * k)), true);
    }

    private static int orientation(File f) {
        try {
            return new ExifInterface(f.getPath()).getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);
        } catch (IOException e) {
            return ExifInterface.ORIENTATION_NORMAL;
        }
    }

    private static Bitmap turn(Bitmap bm, int orientation) {
        int deg = degrees(orientation);
        if (deg == 0) return bm;
        Matrix m = new Matrix();
        m.postRotate(deg);
        return Bitmap.createBitmap(bm, 0, 0, bm.getWidth(), bm.getHeight(), m, true);
    }

    // ---- on the keyboard

    /** The last measurement ({@link #bottomColor} asks every time the keyboard is shown, and the same background does not change). */
    private static String sLookKey;
    private static Look sLook;

    /** Whether the theme of the keyboard on the screen is a dark one. */
    static boolean darkNow(Context c) {
        return MrThemeColors.dark(c, MrTheme.tag());
    }

    /** The veil and the lower edge of the background in use, measured once for the same spec, theme and softening. Null: no background. */
    static synchronized Look lookNow(Context c) {
        // a background belongs to the themes of the backgrounds: in any other theme there is none (an old value of the preference is let be)
        if (!MrThemeColors.hidden(MrTheme.tag())) return null;
        Spec spec = current(c);
        if (spec.kind == NONE) return null;
        boolean dark = darkNow(c);
        int soft = soft(c);
        String key = spec.format() + "|" + dark + "|" + soft;
        if (key.equals(sLookKey)) return sLook;
        Bitmap image = bitmap(c, spec);
        if (needsBitmap(spec) && image == null) return null;
        Look look = look(spec, image, dark, soft);
        if (image != null) image.recycle();
        sLookKey = key;
        sLook = look;
        return look;
    }

    /**
     * The colour of the lower edge of the background for the navigation bar (opaque), or 0 when there is no background to match (the bar then
     * has the colour of the theme). The keyboard of Android 16 and later is drawn under a transparent bar, so it is not asked there.
     */
    static int bottomColor(Context c) {
        try {
            if (c == null || Build.VERSION.SDK_INT >= MrBottom.TRANSPARENT_BAR_SDK) return 0;
            Look look = lookNow(c);
            return look == null ? 0 : look.bottom;
        } catch (Throwable t) {
            return 0;
        }
    }

    /**
     * Puts the background chosen on the keyboard: the {@link MrBackdropDrawable} becomes the background of the root of the toolbar, and the
     * keyboard view (which would paint the colour of the theme over it) is left clear. No background chosen, or a picture that is gone: nothing
     * is changed, the keyboard keeps the colour of the theme. Asked again for the same view it sets the same thing again.
     */
    static synchronized void apply() {
        try {
            View root = MrTools.sBarRoot;
            if (root == null) return;
            Context c = root.getContext();
            if (!MrThemeColors.hidden(MrTheme.tag())) return;
            Spec spec = current(c);
            if (spec.kind == NONE) return;
            boolean dark = darkNow(c);
            int soft = soft(c);
            int fallback = MrTheme.color("kbd_bg");
            // the keyboard is shown again and again: the same background is not made again (the drawable keeps what it drew)
            String key = spec.format() + "|" + dark + "|" + soft + "|" + fallback;
            if (sDrawable == null || !key.equals(sDrawableKey)) {
                MrBackdropDrawable d = MrBackdropDrawable.create(c, spec, dark, soft, fallback);
                if (d == null) return;
                sDrawable = d;
                sDrawableKey = key;
            }
            root.setBackground(sDrawable);
            View kbd = MrTools.sKbd;
            if (kbd != null) kbd.setBackgroundColor(0);
        } catch (Throwable t) {
            // the keyboard stays with the colour of the theme
        }
    }

    /** The drawable that was last put on the keyboard, and what it was made for. */
    private static MrBackdropDrawable sDrawable;
    private static String sDrawableKey;
}
