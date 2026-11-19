package com.mrkeyboard.app;

import android.app.Activity;
import android.content.ContentResolver;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.media.ExifInterface;
import android.os.Build;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import android.view.View;

import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.font.GlyphVector;
import java.awt.geom.AffineTransform;
import java.awt.geom.Area;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Path2D;
import java.awt.geom.Point2D;
import java.awt.geom.Rectangle2D;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.DataBufferInt;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.WeakHashMap;
import java.util.function.BooleanSupplier;
import javax.imageio.ImageIO;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * The themes screen (v2.0.0, "Keyboard theme"), run on the PC against the stubs of Android: the spec of the background that the preference holds
 * (MrBackdrop.Spec: colours, gradients, landscapes, a picture with zoom and position), the part of a picture that fills the keyboard and how a finger
 * moves and pinches its frame (crop, pan, shift, rezoom), the gradients drawn as CSS does and the 36 landscapes (the pictures of the app, in six categories, drawn as a picture of the gallery is), the veil that keeps the toolbar readable
 * over every colour, gradient and landscape (veil, look; the softening is for gradients, landscapes and pictures), the picture of the gallery (importPending: the size, the
 * photo turned, a failure that keeps the one that waits; commitPending, discardPending), the background put on the keyboard only in the themes of the
 * backgrounds (apply, MrBackdropDrawable, bottomColor), the colours of the thirty-two themes read from the real res/ files (MrThemeColors: thirteen on the
 * list, nineteen hidden: the see-through keys and the ink, the fourteen styles of keys and the three of the colour the person picks: glass, outline and gradient, audited over every background), the small keyboards (MrThemePreview: every key and label, the faces made once, the neon light, the
 * ring), the screen (MrThemesActivity: the tabs (the themes, the colours, the gradients, one for each category of landscapes, the gallery) with their cards made a
 * few at a time and the pictures read apart, a theme or a background chosen only after its dialog, the styles of the keys and the softening in the dialog of a
 * background, the themes never changed by a background, the photo picker and its fallbacks, the crop dialog with its pinch and drag (the softening is in the preview after it), the picture that waits and is applied, cancelled or let go, remove),
 * the crop view (MrCropView), the row of the settings (MrThemeRow) and the files (strings in three languages, the manifest, prefs.xml, the smali hooks).
 *
 * <p>What is drawn is rasterized with Java2D behind the Canvas stub (AwtBackend), so that the pixels can be read and the pictures are dumped as PNG
 * (the folder is the first argument): a person can look at them. The key faces of the real keyboard are drawn by KeyStyle (smali) and are
 * not in these pictures: a theme without face drawables shows the flat faces of its colours, which is what is looked at here. How it looks on
 * the phone is for the person to try.
 */
public class ThemesTest {
    static int ok, fail;

    static void check(String what, boolean cond) {
        if (cond) {
            ok++;
            System.out.println("OK    " + what);
        } else {
            fail++;
            System.out.println("FAIL  " + what);
        }
    }

    static boolean near(float a, float b, float eps) {
        return Math.abs(a - b) <= eps;
    }

    // ---------------------------------------------------------------- the real resources

    static final Map<String, Integer> COLORS = new HashMap<String, Integer>();
    static final Map<String, String> STRINGS = new HashMap<String, String>();
    static final Map<String, String[]> ARRAYS = new HashMap<String, String[]>();
    static final Map<String, Map<String, String>> LANG = new HashMap<String, Map<String, String>>();
    static final Map<String, String> RAW_COLORS = new HashMap<String, String>();
    static final Map<String, List<String>> RAW_ARRAYS = new HashMap<String, List<String>>();

    static void readValues(File dir, Map<String, String> strings, boolean all) throws Exception {
        File[] files = dir.listFiles();
        if (files == null) return;
        java.util.Arrays.sort(files);
        for (File f : files) {
            if (!f.getName().endsWith(".xml")) continue;
            org.w3c.dom.Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(f);
            NodeList list = doc.getDocumentElement().getChildNodes();
            for (int i = 0; i < list.getLength(); i++) {
                if (!(list.item(i) instanceof Element)) continue;
                Element e = (Element) list.item(i);
                String name = e.getAttribute("name");
                if (e.getTagName().equals("string")) {
                    strings.put(name, unescape(e.getTextContent().trim()));
                } else if (all && e.getTagName().equals("color")) {
                    RAW_COLORS.put(name, e.getTextContent().trim());
                } else if (all && e.getTagName().equals("string-array")) {
                    List<String> items = new ArrayList<String>();
                    NodeList its = e.getElementsByTagName("item");
                    for (int j = 0; j < its.getLength(); j++) items.add(its.item(j).getTextContent().trim());
                    RAW_ARRAYS.put(name, items);
                }
            }
        }
    }

    static String unescape(String s) {
        return s.replace("\\'", "'").replace("\\\"", "\"").replace("\\n", "\n").replace("\\@", "@");
    }

    static int parseColor(String v) {
        if (v.startsWith("@color/")) return parseColor(RAW_COLORS.get(v.substring(7)));
        String h = v.substring(1);
        if (h.length() == 3) h = "" + h.charAt(0) + h.charAt(0) + h.charAt(1) + h.charAt(1) + h.charAt(2) + h.charAt(2);
        if (h.length() == 4) h = "" + h.charAt(0) + h.charAt(0) + h.charAt(1) + h.charAt(1) + h.charAt(2) + h.charAt(2) + h.charAt(3) + h.charAt(3);
        if (h.length() == 6) h = "ff" + h;
        return (int) Long.parseLong(h, 16);
    }

    static void loadResources() throws Exception {
        readValues(new File("res/values"), STRINGS, true);
        for (String name : RAW_COLORS.keySet()) COLORS.put(name, parseColor(RAW_COLORS.get(name)));
        for (Map.Entry<String, List<String>> e : RAW_ARRAYS.entrySet()) {
            String[] a = new String[e.getValue().size()];
            for (int i = 0; i < a.length; i++) {
                String v = e.getValue().get(i);
                a[i] = v.startsWith("@string/") ? STRINGS.get(v.substring(8)) : v;
            }
            ARRAYS.put(e.getKey(), a);
        }
        for (String lang : new String[] {"es", "pt-rBR"}) {
            Map<String, String> m = new HashMap<String, String>();
            readValues(new File("res/values-" + lang), m, false);
            LANG.put(lang, m);
        }
    }

    // ---------------------------------------------------------------- the world of the stubs

    static class Prefs implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();
        final List<OnSharedPreferenceChangeListener> listeners = new ArrayList<OnSharedPreferenceChangeListener>();
        public Map<String, ?> getAll() { return m; }
        public String getString(String k, String d) { Object o = m.get(k); return o instanceof String ? (String) o : d; }
        public int getInt(String k, int d) {
            Object o = m.get(k);
            if (o instanceof String) throw new ClassCastException("a String is not an int");
            return o instanceof Integer ? (Integer) o : d;
        }
        public long getLong(String k, long d) { Object o = m.get(k); return o instanceof Long ? (Long) o : d; }
        public boolean getBoolean(String k, boolean d) { Object o = m.get(k); return o instanceof Boolean ? (Boolean) o : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { listeners.add(l); }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { listeners.remove(l); }
        public Editor edit() {
            final Map<String, Object> pending = new HashMap<String, Object>();
            final List<String> removed = new ArrayList<String>();
            return new Editor() {
                public Editor putString(String k, String v) { pending.put(k, v); return this; }
                public Editor putInt(String k, int v) { pending.put(k, v); return this; }
                public Editor putLong(String k, long v) { pending.put(k, v); return this; }
                public Editor putBoolean(String k, boolean v) { pending.put(k, v); return this; }
                public Editor remove(String k) { removed.add(k); return this; }
                public boolean commit() { apply(); return true; }
                public void apply() {
                    List<String> keys = new ArrayList<String>(pending.keySet());
                    for (String r : removed) {
                        m.remove(r);
                        keys.add(r);
                    }
                    m.putAll(pending);
                    for (String k : keys) {
                        for (OnSharedPreferenceChangeListener l : new ArrayList<OnSharedPreferenceChangeListener>(listeners)) l.onSharedPreferenceChanged(Prefs.this, k);
                    }
                }
            };
        }
    }

    /** A key face of the theme: the shared one and the copies that the constant state makes (the preview must draw copies). */
    static class Face extends Drawable {
        static int originals, copies;
        final boolean copy;

        Face(boolean copy) {
            this.copy = copy;
            if (copy) copies++;
            else originals++;
        }

        @Override
        public ConstantState getConstantState() {
            return new ConstantState() {
                public Drawable newDrawable() { return new Face(true); }
            };
        }
    }

    static class Res extends Resources {
        final Map<String, Integer> ids = new HashMap<String, Integer>();
        final Map<Integer, String> names = new HashMap<Integer, String>();
        final DisplayMetrics dm = new DisplayMetrics();
        /** No key face drawables: the previews draw the flat faces of the colours (what the PNG shows). */
        boolean flatFaces;

        Res() {
            dm.density = 2f;
            dm.widthPixels = 1080;
            dm.heightPixels = 2400;
        }

        public int getIdentifier(String name, String type, String pkg) {
            boolean there;
            if (type.equals("color")) there = COLORS.containsKey(name);
            else if (type.equals("array")) there = ARRAYS.containsKey(name);
            else if (type.equals("string")) there = STRINGS.containsKey(name);
            else if (type.equals("drawable")) there = !flatFaces && new File("res/drawable/" + name + ".xml").exists();
            else there = false;
            if (!there) return 0;
            String key = type + ":" + name;
            Integer id = ids.get(key);
            if (id == null) {
                id = 1000 + ids.size();
                ids.put(key, id);
                names.put(id, key);
            }
            return id;
        }

        String name(int id) {
            String k = names.get(id);
            return k == null ? null : k.substring(k.indexOf(':') + 1);
        }

        public String getString(int id) { return STRINGS.get(name(id)); }
        public String getString(int id, Object... args) { return String.format(STRINGS.get(name(id)), args); }
        public String[] getStringArray(int id) { return ARRAYS.get(name(id)); }
        public int getColor(int id) { return COLORS.get(name(id)); }
        public Drawable getDrawable(int id) { return new Face(false); }
        public DisplayMetrics getDisplayMetrics() { return dm; }
    }

    static File FILES, CACHE;
    static Prefs prefs;
    static final Res RES = new Res();

    /** A context for the engine: the real colours and texts, the folders of the app, the preferences. */
    static class Ctx extends Activity {
        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return new android.content.res.AssetManager(); }
        public Resources getResources() { return RES; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return prefs; }
        public File getFilesDir() { return FILES; }
        public File getCacheDir() { return CACHE; }
        public void startActivity(Intent i) { }
    }

    static class Chosen extends Intent {
        final android.net.Uri uri;

        Chosen(android.net.Uri uri) {
            super();
            this.uri = uri;
        }

        @Override
        public android.net.Uri getData() { return uri; }
    }

    static class Screen extends MrThemesActivity {
        View content;
        int finishes;
        boolean finishing;
        Intent started;
        int startedCode;
        byte[] picture = new byte[] {1, 2, 3};
        boolean unreadable;

        public Context getApplicationContext() { return this; }
        public android.content.res.AssetManager getAssets() { return new android.content.res.AssetManager(); }
        public Resources getResources() { return RES; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String name, int mode) { return prefs; }
        public File getFilesDir() { return FILES; }
        public File getCacheDir() { return CACHE; }
        public void startActivity(Intent i) { }
        public void setContentView(View v) { content = v; }
        public void finish() { finishes++; }
        public boolean isFinishing() { return finishing; }
        public void runOnUiThread(Runnable r) { UI.add(r); }
        /** How many pickers refuse to start before one does (ActivityNotFoundException), how many were tried, and a picker that fails with another exception once. */
        int refuse, tried;
        boolean crash;

        public void startActivityForResult(Intent i, int code) {
            tried++;
            if (crash) {
                crash = false;
                throw new IllegalStateException("cannot start");
            }
            if (refuse > 0) {
                refuse--;
                throw new android.content.ActivityNotFoundException();
            }
            started = i;
            startedCode = code;
        }

        public ContentResolver getContentResolver() {
            return new ContentResolver() {
                public InputStream openInputStream(android.net.Uri uri) throws java.io.FileNotFoundException {
                    if (unreadable) throw new java.io.FileNotFoundException("gone");
                    return new ByteArrayInputStream(picture);
                }
            };
        }
    }

    static void reset() throws IOException {
        prefs = new Prefs();
        PreferenceManager.stubDefault = prefs;
        Build.VERSION.SDK_INT = 33;
        MrTheme.stubTag = "mr_midnight";
        MrTheme.stubColors.clear();
        MrTheme.stubColors.put("kbd_bg", 0xff171e27);
        MrTools.sBarRoot = null;
        MrTools.sKbd = null;
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 2000;
        BitmapFactory.stubFail = false;
        BitmapFactory.stubSamples.clear();
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_NORMAL;
        ExifInterface.stubFail = false;
        RES.flatFaces = false;
        for (File d : new File[] {FILES, CACHE}) {
            File[] fs = d.listFiles();
            if (fs != null) for (File f : fs) f.delete();
        }
    }

    // ---------------------------------------------------------------- Java2D behind the Canvas stub

    /** Draws what the code asks of a Canvas on the pixels of the Bitmap it was made for. */
    static class AwtBackend implements Canvas.StubBackend {
        static final class State {
            AffineTransform tx = new AffineTransform();
            Area clip;
            State copy() {
                State s = new State();
                s.tx = new AffineTransform(tx);
                s.clip = clip;
                return s;
            }
        }

        static final class Pen {
            Graphics2D g;
            final Deque<State> stack = new ArrayDeque<State>();
        }

        final Map<Canvas, Pen> pens = new WeakHashMap<Canvas, Pen>();
        final Map<Bitmap, BufferedImage> images = new WeakHashMap<Bitmap, BufferedImage>();

        BufferedImage image(Bitmap b) {
            BufferedImage i = images.get(b);
            if (i == null) {
                DataBufferInt db = new DataBufferInt(b.stubPixels, b.stubPixels.length);
                WritableRaster r = Raster.createPackedRaster(db, b.stubW, b.stubH, b.stubW, new int[] {0xff0000, 0xff00, 0xff, 0xff000000}, null);
                i = new BufferedImage(ColorModel.getRGBdefault(), r, false, null);
                images.put(b, i);
            }
            return i;
        }

        Pen pen(Canvas c) {
            if (c.stubBitmap == null) return null;
            Pen p = pens.get(c);
            if (p == null) {
                p = new Pen();
                p.g = image(c.stubBitmap).createGraphics();
                p.g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                p.g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
                p.g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
                p.g.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
                p.stack.push(new State());
                pens.put(c, p);
            }
            State s = p.stack.peek();
            // the clip is kept in device space; the transform is the one of the canvas
            p.g.setTransform(new AffineTransform());
            p.g.setClip(s.clip);
            p.g.setTransform(s.tx);
            return p;
        }

        static Path2D.Float shape(Path path) {
            Path2D.Float p = new Path2D.Float();
            for (float[] op : path.stubOps) {
                switch ((int) op[0]) {
                    case 0: p.moveTo(op[1], op[2]); break;
                    case 1: p.lineTo(op[1], op[2]); break;
                    case 2: p.quadTo(op[1], op[2], op[3], op[4]); break;
                    default: p.closePath(); break;
                }
            }
            return p;
        }

        static Color colour(int argb, Paint p) {
            int a = (argb >>> 24) * p.stubAlpha / 255;
            return new Color((a << 24) | (argb & 0xffffff), true);
        }

        static java.awt.Paint paint(Paint p) {
            if (p.stubShader instanceof LinearGradient) {
                LinearGradient l = (LinearGradient) p.stubShader;
                if (l.x0 == l.x1 && l.y0 == l.y1) return colour(l.colors[0], p);
                return new java.awt.LinearGradientPaint(new Point2D.Float(l.x0, l.y0), new Point2D.Float(l.x1, l.y1), fractions(l.colors.length, l.positions),
                        colours(l.colors, p), java.awt.MultipleGradientPaint.CycleMethod.NO_CYCLE);
            }
            if (p.stubShader instanceof RadialGradient) {
                RadialGradient r = (RadialGradient) p.stubShader;
                if (r.radius <= 0f) return colour(r.colors[0], p);
                return new java.awt.RadialGradientPaint(new Point2D.Float(r.cx, r.cy), r.radius, fractions(r.colors.length, r.stops), colours(r.colors, p),
                        java.awt.MultipleGradientPaint.CycleMethod.NO_CYCLE);
            }
            return colour(p.getColor(), p);
        }

        static float[] fractions(int n, float[] given) {
            if (given != null) return given;
            float[] f = new float[n];
            for (int i = 0; i < n; i++) f[i] = n == 1 ? 0f : i / (float) (n - 1);
            return f;
        }

        static Color[] colours(int[] argb, Paint p) {
            Color[] c = new Color[argb.length];
            for (int i = 0; i < c.length; i++) c[i] = colour(argb[i], p);
            return c;
        }

        void put(Pen pen, Shape s, Paint p) {
            Graphics2D g = pen.g;
            g.setComposite(AlphaComposite.SrcOver);
            g.setPaint(paint(p));
            if (p.stubStyle == Paint.Style.FILL) {
                g.fill(s);
            } else {
                g.setStroke(new BasicStroke(Math.max(0.01f, p.stubStroke), BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND));
                g.draw(s);
            }
        }

        public void drawRect(Canvas c, float l, float t, float r, float b, Paint p) {
            Pen pen = pen(c);
            if (pen != null) put(pen, new Rectangle2D.Float(l, t, r - l, b - t), p);
        }

        public void drawCircle(Canvas c, float cx, float cy, float r, Paint p) {
            Pen pen = pen(c);
            if (pen != null) put(pen, new Ellipse2D.Float(cx - r, cy - r, 2 * r, 2 * r), p);
        }

        public void drawPath(Canvas c, Path path, Paint p) {
            Pen pen = pen(c);
            if (pen != null) put(pen, shape(path), p);
        }

        public void drawRoundRect(Canvas c, float l, float t, float r, float b, float rx, float ry, Paint p) {
            Pen pen = pen(c);
            if (pen != null) put(pen, new RoundRectangle2D.Float(l, t, r - l, b - t, 2 * rx, 2 * ry), p);
        }

        public void drawColor(Canvas c, int color) {
            Pen pen = pen(c);
            if (pen == null) return;
            pen.g.setTransform(new AffineTransform());
            pen.g.setComposite(AlphaComposite.SrcOver);
            pen.g.setColor(new Color(color, true));
            pen.g.fillRect(0, 0, c.stubBitmap.stubW, c.stubBitmap.stubH);
        }

        public void drawBitmap(Canvas c, Bitmap bm, Rect src, Rect dst, Paint p) {
            Pen pen = pen(c);
            if (pen == null) return;
            pen.g.setComposite(p.stubAlpha < 255 ? AlphaComposite.getInstance(AlphaComposite.SRC_OVER, p.stubAlpha / 255f) : AlphaComposite.SrcOver);
            pen.g.drawImage(image(bm), dst.left, dst.top, dst.right, dst.bottom, src.left, src.top, src.right, src.bottom, null);
        }

        public void save(Canvas c) {
            Pen pen = pen(c);
            if (pen != null) pen.stack.push(pen.stack.peek().copy());
        }

        public void restore(Canvas c) {
            Pen pen = pen(c);
            if (pen != null && pen.stack.size() > 1) pen.stack.pop();
        }

        public void translate(Canvas c, float dx, float dy) {
            Pen pen = pen(c);
            if (pen != null) pen.stack.peek().tx.translate(dx, dy);
        }

        public void scale(Canvas c, float sx, float sy) {
            Pen pen = pen(c);
            if (pen != null) pen.stack.peek().tx.scale(sx, sy);
        }

        public void clipPath(Canvas c, Path path) {
            Pen pen = pen(c);
            if (pen == null) return;
            State s = pen.stack.peek();
            Area a = new Area(s.tx.createTransformedShape(shape(path)));
            if (s.clip != null) a.intersect(s.clip);
            s.clip = a;
        }

        public void drawText(Canvas c, String text, float x, float y, Paint p) {
            Pen pen = pen(c);
            if (pen == null) return;
            Font font = new Font(Font.SANS_SERIF, Font.PLAIN, Math.max(1, Math.round(p.getTextSize())));
            pen.g.setFont(font);
            FontMetrics fm = pen.g.getFontMetrics();
            float w = fm.stringWidth(text);
            float left = p.stubAlign == Paint.Align.CENTER ? x - w / 2f : p.stubAlign == Paint.Align.RIGHT ? x - w : x;
            pen.g.setComposite(AlphaComposite.SrcOver);
            GlyphVector gv = font.createGlyphVector(pen.g.getFontRenderContext(), text);
            Shape outline = gv.getOutline(left, y);
            if (p.stubShadowRadius > 0f) {
                // the light round the glyphs of the neon themes, as a wide faint stroke
                for (int i = 3; i >= 1; i--) {
                    pen.g.setColor(colour((p.stubShadowColor & 0xffffff) | (0x30 << 24), p));
                    pen.g.setStroke(new BasicStroke(p.stubShadowRadius * i / 3f, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND));
                    pen.g.draw(outline);
                }
            }
            pen.g.setColor(colour(p.getColor(), p));
            pen.g.fill(outline);
        }

        public void drawLine(Canvas c, float x0, float y0, float x1, float y1, Paint p) {
            Pen pen = pen(c);
            if (pen == null) return;
            pen.g.setComposite(AlphaComposite.SrcOver);
            pen.g.setColor(colour(p.getColor(), p));
            pen.g.setStroke(new BasicStroke(Math.max(0.01f, p.stubStroke), BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND));
            pen.g.draw(new Line2D.Float(x0, y0, x1, y1));
        }
    }

    // ---------------------------------------------------------------- helpers

    static Bitmap bitmap(int w, int h) {
        return Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
    }

    /** A picture of the gallery that is easy to tell apart: hue along the width, brightness down the height, and a frame. */
    static Bitmap photo(int w, int h) {
        Bitmap b = bitmap(w, h);
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                float hue = x / (float) w;
                float br = 1f - 0.7f * y / h;
                int rgb = Color.HSBtoRGB(hue * 0.8f, 0.85f, br);
                boolean frame = x < 6 || y < 6 || x >= w - 6 || y >= h - 6;
                boolean cross = Math.abs(x - w / 2) < 3 || Math.abs(y - h / 2) < 3;
                b.setPixel(x, y, frame || cross ? 0xffffffff : rgb);
            }
        }
        return b;
    }

    static int channel(int argb, int shift) {
        return (argb >> shift) & 0xff;
    }

    static int maxDiff(int a, int b) {
        return Math.max(Math.abs(channel(a, 16) - channel(b, 16)), Math.max(Math.abs(channel(a, 8) - channel(b, 8)), Math.abs(channel(a, 0) - channel(b, 0))));
    }

    static MrThemePreview preview(Context c, int w) {
        MrThemePreview p = new MrThemePreview(c);
        p.onMeasure(View.MeasureSpec.makeMeasureSpec(w, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
        p.stubSize(w, p.stubMeasuredHeight());
        return p;
    }

    static Bitmap draw(MrThemePreview p) {
        Bitmap b = bitmap(p.getWidth(), p.getHeight());
        p.onDraw(new Canvas(b));
        return b;
    }

    /** What the threads of the screens post to the main thread: it runs here, on the thread of the test (the one that owns the views). */
    static final java.util.concurrent.ConcurrentLinkedQueue<Runnable> UI = new java.util.concurrent.ConcurrentLinkedQueue<Runnable>();

    static void pump() {
        Runnable r;
        while ((r = UI.poll()) != null) r.run();
    }

    static boolean waitFor(BooleanSupplier s) throws InterruptedException {
        for (int i = 0; i < 250; i++) {
            pump();
            if (s.getAsBoolean()) return true;
            Thread.sleep(20);
        }
        pump();
        return s.getAsBoolean();
    }

    static String PNG;

    static void save(Bitmap b, String name) throws IOException {
        if (PNG == null) return;
        BufferedImage i = new BufferedImage(b.stubW, b.stubH, BufferedImage.TYPE_INT_ARGB);
        i.setRGB(0, 0, b.stubW, b.stubH, b.stubPixels, 0, b.stubW);
        ImageIO.write(i, "png", new File(PNG, name + ".png"));
    }

    /** The pictures side by side, three to a row, on a grey ground. */
    static void sheet(List<Bitmap> tiles, int cols, String name) throws IOException {
        if (PNG == null || tiles.isEmpty()) return;
        int gap = 12;
        int tw = tiles.get(0).stubW, th = tiles.get(0).stubH;
        int rows = (tiles.size() + cols - 1) / cols;
        Bitmap out = bitmap(gap + cols * (tw + gap), gap + rows * (th + gap));
        java.util.Arrays.fill(out.stubPixels, 0xff6b6f76);
        for (int i = 0; i < tiles.size(); i++) {
            int ox = gap + (i % cols) * (tw + gap), oy = gap + (i / cols) * (th + gap);
            Bitmap t = tiles.get(i);
            for (int y = 0; y < t.stubH; y++) {
                for (int x = 0; x < t.stubW; x++) {
                    int p = t.getPixel(x, y);
                    int a = p >>> 24;
                    int under = out.getPixel(ox + x, oy + y);
                    out.setPixel(ox + x, oy + y, a == 255 ? p : MrBackdrop.mix(under, p | 0xff000000, a / 255f));
                }
            }
        }
        save(out, name);
    }

    // ---------------------------------------------------------------- the card of the choice in use takes the list to its own card

    static void heroClick() throws Exception {
        reset();
        prefs.edit().putString("pref_keyboard_layout", "15").putString(MrBackdrop.PREF, "s20").apply();
        Screen s = open();
        View hero = (View) s.mBig.getParent();
        check("the card of the choice in use is touchable and has a name for the screen readers", hero.isClickable() && hero.getContentDescription() != null && hero.getContentDescription().toString().equals("In use"));
        check("the screen opens on the tab of the choice (the nature landscapes)", s.mTab == MrThemesActivity.TAB_SCENES + MrScenes.NATURE && checkedBackground(s) == FIRST_SCENE + 20);
        tab(s, MrThemesActivity.TAB_THEMES);
        int smooths = s.mScroll.stubSmooths;
        hero.performClick();
        s.mScroll.stubRunPosted();
        check("touching it opens the tab of the choice in use (the landscape: its category) and rolls the list, softly, once", s.mTab == MrThemesActivity.TAB_SCENES + MrScenes.NATURE
                && s.mScroll.stubSmooths == smooths + 1 && s.mScroll.stubSmoothY >= 0 && checkedBackground(s) == FIRST_SCENE + 20);
        int before = s.mScroll.stubSmooths;
        hero.performClick();
        s.mScroll.stubRunPosted();
        check("touching it with the tab already open rolls again to the card and does not make the tab again", s.mTab == MrThemesActivity.TAB_SCENES + MrScenes.NATURE
                && s.mScroll.stubSmooths == before + 1);
        s.chooseTheme(11);
        tab(s, MrThemesActivity.TAB_GRADIENTS);
        smooths = s.mScroll.stubSmooths;
        hero.performClick();
        s.mScroll.stubRunPosted();
        check("a theme of the list is shown in the tab of the themes, with the cards up to it made and the list rolled to it", s.mTab == MrThemesActivity.TAB_THEMES && s.mBuilt > 11
                && checkedTheme(s) == 11 && s.mScroll.stubSmooths == smooths + 1);
    }

    // ---------------------------------------------------------------- the dialog: opacity, colour of the letters, colour of the person's own

    static void collect(View v, Class<?> type, List<View> into) {
        if (v == null) return;
        if (type.isInstance(v)) into.add(v);
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) collect(g.getChildAt(i), type, into);
        }
    }

    static List<View> all(View v, Class<?> type) {
        List<View> l = new ArrayList<View>();
        collect(v, type, l);
        return l;
    }

    /** The colour dots (the round buttons of the picker of the letters and of the end of the gradient) in the dialog of the background. */
    static List<View> colourDots(Screen s) {
        return all(s.mDialog.stubContent, MrColorDot.class);
    }

    /** A press on a button of the dialog of the background (the picker, if it is open, is the last dialog, so this is not {@link #press}). */
    static boolean pressMain(Screen s, String text) {
        View b = s.mDialog == null ? null : byText(s.mDialog.stubContent, text);
        return b != null && b.performClick();
    }

    static boolean pressPicker(Screen s, String text) {
        View b = s.mPicker == null ? null : byText(s.mPicker.stubContent, text);
        return b != null && b.performClick();
    }

    static void finger(Screen s, android.widget.SeekBar bar, int progress) {
        bar.stubListener.onProgressChanged(bar, progress, true);
    }

    static void dialogLook() throws Exception {
        reset();
        Screen s = open();
        int scene = FIRST_SCENE + 1;
        click(bg(s, scene));
        Dialog d = Dialog.stubLast;
        check("the dialog of a landscape has the slider of the opacity of the keys and the one of their border (up to 250%, at the 100% of the style), and the colour of the letters in automatic",
                s.mDialogKey != null && s.mDialogEdge != null && s.mDialogKey.getMax() == 250 && s.mDialogEdge.getMax() == 250 && s.mDialogKey.getProgress() == 100 && s.mDialogEdge.getProgress() == 100
                        && byText(d.stubContent, "Background opacity") != null && byText(d.stubContent, "Border opacity") != null && byText(d.stubContent, "Text colour") != null
                        && byText(d.stubContent, "Automatic") != null && colourDots(s).size() == 1 && ((MrColorDot) colourDots(s).get(0)).color() == 0);
        check("the controls scroll between the keyboard and the buttons, in a view that the sheet limits (the sheet grows up to 90% of the screen height, the controls take what is left)",
                all(d.stubContent, MrCappedScroll.class).size() == 1 && d.stubContent instanceof MrSheetBox && ((MrSheetBox) d.stubContent).maxPx() == Math.round(2400 * MrThemesActivity.SHEET_SHARE)
                        && MrThemesActivity.SHEET_SHARE == 0.90f && ((MrSheetBox) d.stubContent).scroll() == all(d.stubContent, MrCappedScroll.class).get(0)
                        && byText(d.stubContent, "Cancel") != null && byText(d.stubContent, "Apply") != null);
        MrSheetBox sheet = (MrSheetBox) d.stubContent;
        check("what the controls may take is the limit less what the others need (and never less than the least they keep)", MrSheetBox.room(2160, 1000, 288) == 1160 && MrSheetBox.room(2160, 2000, 288) == 288
                && MrSheetBox.room(2160, 0, 288) == 2160 && MrThemesActivity.MIN_CONTROLS_DP == 96);
        sheet.measure(android.view.View.MeasureSpec.makeMeasureSpec(1080, android.view.View.MeasureSpec.EXACTLY), android.view.View.MeasureSpec.makeMeasureSpec(2400, android.view.View.MeasureSpec.AT_MOST));
        check("the sheet can be measured, and the scroll view has a limit that it did not have before (it is free until the sheet is measured)", sheet.scroll().maxPx() > 0 && sheet.scroll().maxPx() < MrCappedScroll.FREE);
        check("the keyboard of the dialog starts with nothing tuned", s.mDialogPreview.look().isNone() && s.mDialogLook[0].isNone() && s.mDialogStyle[0] == 0);
        finger(s, s.mDialogKey, 40);
        check("the slider of the keys tunes the keyboard of the dialog while the finger moves it, and says the value", s.mDialogPreview.look().key == 40 && s.mDialogPreview.look().edge == 100 && byText(d.stubContent, "40%") != null);
        finger(s, s.mDialogEdge, 170);
        check("the one of the border is another value", s.mDialogPreview.look().key == 40 && s.mDialogPreview.look().edge == 170 && byText(d.stubContent, "170%") != null);
        finger(s, s.mDialogKey, 999);
        check("a slider stops at 250%", s.mDialogPreview.look().key == 250 && byText(d.stubContent, "250%") != null);
        s.mDialogEdge.stubListener.onProgressChanged(s.mDialogEdge, 5, false);
        check("a change that is not the finger's is not a choice", s.mDialogPreview.look().edge == 170);
        check("nothing is written while the dialog is open", prefs.getInt("pref_kbd_look_key", -1) == -1 && prefs.getInt("pref_kbd_look_edge", -1) == -1 && s.mLook.isNone());
        finger(s, s.mDialogKey, 100);
        finger(s, s.mDialogEdge, 100);

        // the colour of the letters
        check("a style of keys does not take the opacity of another: moving the kind keeps the sliders", byText(d.stubContent, "Outline").performClick() && s.mDialogKey.getProgress() == 100 && s.mDialogPreview.tag().equals("mr_overline"));
        byText(d.stubContent, "Glass").performClick();
        View textDot = colourDots(s).get(0);
        textDot.performClick();
        check("the round button of the colour of the letters opens the picker over the dialog, which stays open", s.mPicker != null && s.mPicker.stubShowing && d.stubShowing && s.mPickerView != null
                && byText(s.mPicker.stubContent, "Pick a colour") != null && byText(s.mPicker.stubContent, "Done") != null && byText(s.mPicker.stubContent, "Cancel") != null);
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 300, 10);
        s.mPickerView.drag(1, 600, 0);
        int cyan = s.mPickerView.color();
        check("a finger on the bar of the hues and then on the square picks a colour: the keyboard of the dialog has it in its letters at once", Math.abs(s.mPickerView.hue() - 180f) < 1f && (cyan & 0xffffff) == 0x00ffff
                && s.mDialogPreview.look().text == (0xff000000 | cyan) && s.mDialogLook[0].text == s.mDialogPreview.look().text);
        check("Cancel in the picker closes it and gives back the colour there was (none); the dialog stays", pressPicker(s, "Cancel") && s.mPicker == null && d.stubShowing && s.mDialogPreview.look().text == 0);
        colourDots(s).get(0).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 100, 10);
        Dialog.stubLast.stubBack();
        check("so does the back button, and the dialog under it stays", s.mPicker == null && d.stubShowing && s.mDialogPreview.look().text == 0 && s.mDialog == d);
        colourDots(s).get(0).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 450, 10);
        s.mPickerView.drag(1, 300, 120);
        int picked = s.mPickerView.color();
        check("Done keeps the colour: it is the colour of the letters and the round button shows it", pressPicker(s, "Done") && s.mPicker == null && s.mDialogPreview.look().text == (0xff000000 | picked)
                && ((MrColorDot) colourDots(s).get(0)).color() == (0xff000000 | picked) && byText(d.stubContent, "Automatic") != null);
        check("Automatic lets the colour go (the one of the theme)", pressMain(s, "Automatic") && s.mDialogPreview.look().text == 0 && ((MrColorDot) colourDots(s).get(0)).color() == 0);
        colourDots(s).get(0).performClick();
        check("the picker opens on white when there was no colour, and Done without touching it picks white", pressPicker(s, "Done") && s.mDialogPreview.look().text == 0xffffffff);
        pressMain(s, "Automatic");

        // the colour of the person's own, in each kind
        check("each kind ends with a round button that picks a colour, which is not a style until it is touched", dots(d.stubContent) == 6 && byDescription(d.stubContent, "Pick a colour") != null
                && ((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).own() == 0 && !((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).chosen());
        byDescription(d.stubContent, "Pick a colour").performClick();
        check("touching it chooses the style of the own colour of the kind (glass) in the colour the theme is written in, and opens the picker", s.mDialogStyle[0] == MrBackdrop.ownStyle(MrBackdrop.KIND_GLASS)
                && s.mDialogPreview.tag().equals("mr_overownglass") && s.mDialogLook[0].hue == MrBackdrop.OWN_DEFAULT && s.mPicker != null && chosenDots(d.stubContent) == 1);
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 0, 10);
        s.mPickerView.drag(1, 600, 0);
        int red = s.mPickerView.color();
        check("the colour that the finger picks is the colour of the keys of the dialog at once", (red & 0xffffff) == 0xff0000 && s.mDialogPreview.look().hue == (0xff000000 | red));
        check("Done keeps it, and the round button of the kind shows it", pressPicker(s, "Done") && ((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).own() == (0xff000000 | red)
                && ((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).chosen() && byText(d.stubContent, "Own colour") != null);
        byText(d.stubContent, "Outline").performClick();
        check("the other kinds have their round button with the same colour; the style is the first of the kind until it is touched", s.mDialogStyle[0] == MrBackdrop.KIND_FIRST[MrBackdrop.KIND_OUTLINE]
                && ((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).own() == (0xff000000 | red) && !((MrStyleDot) byDescription(d.stubContent, "Pick a colour")).chosen() && dots(d.stubContent) == 7);
        byDescription(d.stubContent, "Pick a colour").performClick();
        pressPicker(s, "Done");
        check("the outline of the own colour is the style chosen, with the colour that was picked", s.mDialogPreview.tag().equals("mr_overownline") && s.mDialogLook[0].hue == (0xff000000 | red) && s.mPicker == null);
        check("a gradient has no end to pick until it is the gradient of the own colour", byText(d.stubContent, "End of the gradient") == null);
        byText(d.stubContent, "Gradient").performClick();
        byDescription(d.stubContent, "Pick a colour").performClick();
        pressPicker(s, "Done");
        check("the gradient of the own colour has the line of its end: automatic, with a round button", s.mDialogPreview.tag().equals("mr_overowngrad") && byText(d.stubContent, "End of the gradient") != null && colourDots(s).size() == 2
                && s.mDialogLook[0].hue2 == 0 && ((MrColorDot) colourDots(s).get(0)).color() == 0);
        // the end of the gradient is in the keys, above the sliders; the colour of the letters is the last line of the dialog
        colourDots(s).get(0).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 400, 10);
        s.mPickerView.drag(1, 600, 0);
        int end = s.mPickerView.color();
        pressPicker(s, "Done");
        check("the end of the gradient is the second colour of the keyboard of the dialog", s.mDialogPreview.look().hue2 == (0xff000000 | end) && ((MrColorDot) colourDots(s).get(0)).color() == (0xff000000 | end)
                && s.mDialogLook[0].hue == (0xff000000 | red));
        check("Automatic lets the end go (the keyboard makes one up)", pressMain(s, "Automatic") && s.mDialogLook[0].hue2 == 0 && ((MrColorDot) colourDots(s).get(0)).color() == 0);
        colourDots(s).get(0).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 500, 10);
        pressPicker(s, "Done");
        // a picker over the dialog goes with it
        colourDots(s).get(1).performClick();
        check("a picker that is open is closed with the dialog (Cancel)", s.mPicker != null && pressMain(s, "Cancel") && s.mPicker == null && !Dialog.stubLast.stubShowing && s.mDialog == null && s.mDialogLook == null);
        check("Cancel after all that writes nothing", prefs.getInt("pref_kbd_look_hue", -1) == -1 && prefs.getInt("pref_kbd_look_key", -1) == -1 && "".equals(bgKey()) || bgKey() == null);

        // Apply writes it
        click(bg(s, scene));
        d = Dialog.stubLast;
        finger(s, s.mDialogKey, 30);
        finger(s, s.mDialogEdge, 210);
        byText(d.stubContent, "Gradient").performClick();
        byDescription(d.stubContent, "Pick a colour").performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 300, 10);
        s.mPickerView.drag(1, 600, 0);
        int first = s.mPickerView.color();
        pressPicker(s, "Done");
        colourDots(s).get(0).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 500, 10);
        s.mPickerView.drag(1, 600, 0);
        int second = s.mPickerView.color();
        pressPicker(s, "Done");
        colourDots(s).get(1).performClick();
        s.mPickerView.stubSize(600, 400);
        s.mPickerView.drag(2, 20, 10);
        s.mPickerView.drag(1, 600, 0);
        int letters = s.mPickerView.color();
        pressPicker(s, "Done");
        check("Apply writes the style, the opacities and the colours in one edit, and the screen has them", pressMain(s, "Apply") && s.mDialog == null && "31".equals(themeKey()) && s.mStyle == 17
                && prefs.getInt("pref_kbd_look_key", -1) == 30 && prefs.getInt("pref_kbd_look_edge", -1) == 210 && prefs.getInt("pref_kbd_look_text", -1) == (0xff000000 | letters)
                && prefs.getInt("pref_kbd_look_hue", -1) == (0xff000000 | first) && prefs.getInt("pref_kbd_look_hue2", -1) == (0xff000000 | second)
                && s.mLook.key == 30 && s.mLook.edge == 210 && s.mLook.text == (0xff000000 | letters));
        check("the keyboard at the top shows it, with its tuning, and says the style", s.mBig.tag().equals("mr_overowngrad") && s.mBig.look().same(s.mLook) && s.mDetail.getText().toString().contains("Own colour"));
        click(bg(s, scene));
        d = Dialog.stubLast;
        check("the dialog of the background in use starts with its style and its tuning (the sliders, the colours)", s.mDialogStyle[0] == 17 && s.mDialogKey.getProgress() == 30 && s.mDialogEdge.getProgress() == 210
                && s.mDialogLook[0].same(s.mLook) && byText(d.stubContent, "30%") != null && ((MrColorDot) colourDots(s).get(1)).color() == (0xff000000 | letters) && ((MrColorDot) colourDots(s).get(0)).color() == (0xff000000 | second)
                && s.mDialogPreview.look().same(s.mLook));
        press("Cancel");
        click(bg(s, scene + 1));
        check("another landscape starts clean: the see-through glass and nothing tuned, so that what was chosen for the one in use is not carried to it", s.mDialogStyle[0] == 0 && s.mDialogPreview.tag().equals("mr_overlight")
                && s.mDialogLook[0].isNone() && s.mDialogKey.getProgress() == 100 && s.mDialogEdge.getProgress() == 100 && ((MrColorDot) colourDots(s).get(0)).color() == 0 && chosenDots(Dialog.stubLast.stubContent) == 1);
        check("and the first one marked is the see-through glass", ((MrStyleDot) byDescription(Dialog.stubLast.stubContent, "See-through")).chosen());
        press("Apply");
        check("applied like that it writes the see-through glass and no tuning: the opacities at 100%, no colours", "13".equals(themeKey()) && prefs.getInt("pref_kbd_look_key", -1) == 100 && prefs.getInt("pref_kbd_look_edge", -1) == 100
                && prefs.getInt("pref_kbd_look_text", -1) == 0 && prefs.getInt("pref_kbd_look_hue", -1) == 0 && prefs.getInt("pref_kbd_look_hue2", -1) == 0 && s.mLook.isNone());
        // a colour and a gradient start clean too
        apply(s, FIRST_GRADIENT + 2);
        click(bg(s, 5));
        check("a colour starts clean as well, though the background in use is another kind", s.mDialogStyle[0] == 0 && s.mDialogLook[0].isNone());
        finger(s, s.mDialogKey, 60);
        press("Apply");
        click(bg(s, 5));
        check("and a colour that has been tuned keeps it when it is opened again", s.mDialogKey.getProgress() == 60 && s.mDialogPreview.look().key == 60);
        press("Cancel");
        click(bg(s, 1));
        check("a light colour (dark ink, no styles) has the colour of the letters but no opacity sliders", s.mDialogKey == null && s.mDialogEdge == null && byText(Dialog.stubLast.stubContent, "Background opacity") == null
                && byText(Dialog.stubLast.stubContent, "Text colour") != null && colourDots(s).size() == 1 && dots(Dialog.stubLast.stubContent) == 0);
        pressMain(s, "Cancel");
        // a theme of the list: the tuning is of the backgrounds
        s.chooseTheme(7);
        check("choosing a theme of the list takes the tuning away from the screen (the preferences keep it for the next background)", s.mLook.isNone() && s.mBig.look().isNone());
        click(th(s, 5));
        check("the dialog of a theme of the list has no controls", s.mDialogKey == null && s.mDialogEdge == null && byText(Dialog.stubLast.stubContent, "Text colour") == null && s.mDialogLook == null);
        press("Cancel");
    }

    /** The picker of a colour on its own: where a finger counts, what it picks and what it tells. */
    static void colourPicker() throws Exception {
        reset();
        Context c = new Ctx();
        MrColorPicker p = new MrColorPicker(c);
        p.onMeasure(View.MeasureSpec.makeMeasureSpec(600, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
        check("the picker is as wide as it is given and as tall as the square, the gap and the bar (in dp, by the density)", p.stubMeasuredWidth() == 600
                && p.stubMeasuredHeight() == 2 * (MrColorPicker.SQUARE_DP + MrColorPicker.GAP_DP + MrColorPicker.BAR_DP));
        p.stubSize(600, p.stubMeasuredHeight());
        final List<Integer> told = new ArrayList<Integer>();
        p.setListener(new MrColorPicker.Listener() {
            public void onColor(int rgb) {
                told.add(rgb);
            }
        });
        p.setColor(0xff3366cc);
        check("a colour that is set is the one it holds (and it does not tell)", (p.color() & 0xffffff) == 0x3366cc && told.isEmpty() && (p.color() >>> 24) == 0xff);
        p.setColor(0xffff0000);
        check("red is hue 0", p.hue() == 0f);
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, 300f, p.stubMeasuredHeight() - 20f));
        check("a finger on the bar sets the hue by its place (the middle: cyan) and tells it", told.size() == 1 && Math.abs(p.hue() - 180f) < 1f && told.get(0) == p.color());
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, 450f, 10f));
        check("and keeps it while it moves, wherever it goes (it is still the bar's finger)", told.size() == 2 && Math.abs(p.hue() - 270f) < 1f);
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, 450f, 10f));
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_DOWN, 600f, 0f));
        check("a finger on the square sets the saturation to the right and the brightness to the top: the pure hue", told.size() == 3 && (p.color() & 0xffffff) == (MrGlow.rgb(p.hue(), 1f, 1f) & 0xffffff));
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, 0f, p.stubMeasuredHeight() / 2f - 40f));
        check("to the left it is a grey and at the bottom it is black", maxDiff(p.color(), p.color() & 0xffffff | 0xff000000) == 0 && channel(p.color(), 16) == channel(p.color(), 8) && channel(p.color(), 8) == channel(p.color(), 0));
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, -50f, 5000f));
        check("outside the square the finger is held at its edge (black in the corner) and nothing fails", (p.color() & 0xffffff) == 0);
        int n = told.size();
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_UP, 0f, 0f));
        p.onTouchEvent(MotionEvent.obtain(MotionEvent.ACTION_MOVE, 100f, 100f));
        check("a move without a finger down is not told as a colour that moved from the last part", told.size() >= n);
        Bitmap b = bitmap(600, p.stubMeasuredHeight());
        p.setColor(0xff22aa66);
        p.onDraw(new Canvas(b));
        int sqH = 2 * MrColorPicker.SQUARE_DP;
        check("it is drawn: white at the top left of the square, black at its bottom, the hues in the bar", maxDiff(b.getPixel(12, 12), 0xffffffff) < 40 && channel(b.getPixel(300, sqH - 4), 16) < 40
                && maxDiff(b.getPixel(150, sqH + 2 * MrColorPicker.GAP_DP + MrColorPicker.BAR_DP), b.getPixel(450, sqH + 2 * MrColorPicker.GAP_DP + MrColorPicker.BAR_DP)) > 60);
        save(b, "colour_picker");
        // the dots
        MrColorDot none = new MrColorDot(c, 0), some = new MrColorDot(c, 0x00ff8800);
        none.onMeasure(0, 0);
        check("the round buttons are 40 dp, the colour is made opaque, and none stays none", none.stubMeasuredWidth() == 2 * MrColorDot.SIZE_DP && none.color() == 0 && some.color() == 0xffff8800);
        Bitmap db = bitmap(80, 80);
        none.stubSize(80, 80);
        some.stubSize(80, 80);
        none.onDraw(new Canvas(db));
        Bitmap db2 = bitmap(80, 80);
        some.onDraw(new Canvas(db2));
        check("the one with no colour is drawn with a plus on a dark disc, the other as a disc of its colour, both with the ring of all the hues", differing(db, db2, 8) > 500 && maxDiff(db2.getPixel(40, 40), 0xffff8800) <= 2
                && maxDiff(db.getPixel(40, 40), 0xffffffff) <= 12);
        MrStyleDot own = new MrStyleDot(c, MrBackdrop.ownStyle(MrBackdrop.KIND_OUTLINE), true, 0xff00ffff, 0xff3355ff, 0);
        MrStyleDot waiting = new MrStyleDot(c, MrBackdrop.ownStyle(MrBackdrop.KIND_GLASS), false, 0xff00ffff, 0, 0);
        own.stubSize(80, 80);
        waiting.stubSize(80, 80);
        Bitmap ob = bitmap(80, 80), wb = bitmap(80, 80);
        own.onDraw(new Canvas(ob));
        waiting.onDraw(new Canvas(wb));
        check("the dot of the own colour is the style in that colour (the outline: a ring of it) and, when none was picked, a plus; the one chosen has its ring", own.own() == 0xff3355ff && own.chosen() && waiting.own() == 0 && !waiting.chosen()
                && near(ob, 0x3355ff, 40) > 100 && near(ob, 0x00ffff, 20) > 100 && maxDiff(wb.getPixel(40, 40), 0xffffffff) <= 12 && near(wb, 0x00ffff, 20) == 0);
        save(ob, "own_dot_outline");
        MrStyleDot gradDot = new MrStyleDot(c, MrBackdrop.ownStyle(MrBackdrop.KIND_GRADIENT), false, 0xff00ffff, 0xffff3030, 0xff3050ff);
        gradDot.stubSize(80, 80);
        Bitmap gb = bitmap(80, 80);
        gradDot.onDraw(new Canvas(gb));
        check("the gradient of the own colour is drawn from the first colour to the second", near(gb, 0xff3030, 90) > 30 && near(gb, 0x3050ff, 90) > 30);
        MrStyleDot preset = new MrStyleDot(c, 7, false, 0xff00ffff);
        check("a preset has no colour of its own", preset.own() == 0);
    }

    // ---------------------------------------------------------------- the line of suggestions of the previews

    /** The bounding box {x0, y0, x1, y1} of what differs from {@code bg} by more than 10 in the rows 0..{@code h} of {@code b}, away from the corners (null: nothing). */
    static int[] drawnBox(Bitmap b, int h, int bg) {
        int x0 = Integer.MAX_VALUE, y0 = Integer.MAX_VALUE, x1 = -1, y1 = -1;
        int margin = Math.max(6, b.stubW / 40);
        for (int y = 3; y < h; y++) {       // not the first rows: the rim of the preview
            for (int x = margin; x < b.stubW - margin; x++) {
                if (maxDiff(b.getPixel(x, y), bg) > 10) {
                    x0 = Math.min(x0, x);
                    x1 = Math.max(x1, x);
                    y0 = Math.min(y0, y);
                    y1 = Math.max(y1, y);
                }
            }
        }
        return x1 < 0 ? null : new int[] {x0, y0, x1, y1};
    }

    static void suggestionBar() throws Exception {
        reset();
        RES.flatFaces = true;
        Context c = new Ctx();
        String[] tags = MrThemeColors.tags(c);
        StringBuilder off = new StringBuilder();
        List<Bitmap> bars = new ArrayList<Bitmap>();
        int checked = 0;
        for (int i = 0; i < tags.length; i++) {
            for (int full = 0; full < 2; full++) {
                MrThemePreview p = full == 1 ? fullPreview(c, 720) : preview(c, 720);
                boolean hidden = MrThemeColors.hidden(tags[i]);
                p.show(tags[i], hidden ? MrBackdrop.Spec.color(tags[i].equals("mr_overdark") ? 1 : 5) : MrBackdrop.Spec.NO, null, 0);
                Bitmap b = draw(p);
                float k = 720 / 1080f;
                float vh = 1080f / (full == 1 ? MrThemePreview.FULL_ASPECT : MrBackdrop.ASPECT);
                float bottom = vh * (full == 1 ? MrThemePreview.FULL_BAR_SHARE : MrThemePreview.BAR_SHARE);
                int h = Math.round(bottom * k);
                int bg = b.getPixel(Math.round(b.stubW * 0.04f), Math.round((bottom + MrThemePreview.FACE_GAP_DP * 2f) / 2f * k));
                int[] box = drawnBox(b, h, bg);
                checked++;
                if (box == null) {
                    off.append(tags[i]).append(full == 1 ? " (full: nothing drawn) " : " (small: nothing drawn) ");
                    continue;
                }
                int left = box[0], right = b.stubW - 1 - box[2];
                float wantY = (bottom + MrThemePreview.FACE_GAP_DP * 2f) / 2f * k, gotY = (box[1] + box[3] + 1) / 2f;
                if (Math.abs(left - right) > 2 || Math.abs(wantY - gotY) > 1.5f) off.append(tags[i]).append(full == 1 ? " full " : " small ").append(left).append("/").append(right).append(" y ").append(gotY).append("~").append(wantY).append("; ");
                if (full == 1 && i % 4 == 0 && bars.size() < 12) {
                    Bitmap crop = bitmap(b.stubW, h);
                    for (int y = 0; y < h; y++) for (int x = 0; x < b.stubW; x++) crop.setPixel(x, y, b.getPixel(x, y));
                    bars.add(crop);
                }
            }
        }
        check("the three bars of the line of suggestions have the same margin on the left and on the right and are in the middle of the height of the line, in every theme (" + checked + " previews, the small and the complete keyboard)" + (off.length() > 0 ? ": " + off : ""),
                off.length() == 0 && checked == tags.length * 2);
        sheet(bars, 3, "suggestion_bars");
        RES.flatFaces = false;
    }

    // ---------------------------------------------------------------- the keys that the person tuned

    /** How many pixels of {@code b} differ from the ones of {@code o} by more than {@code tol} in some channel. */
    static int differing(Bitmap b, Bitmap o, int tol) {
        int n = 0;
        for (int i = 0; i < b.stubPixels.length; i++) if (maxDiff(b.stubPixels[i], o.stubPixels[i]) > tol) n++;
        return n;
    }

    /** How many pixels of {@code b} are within {@code tol} of the colour {@code rgb}. */
    static int near(Bitmap b, int rgb, int tol) {
        int n = 0;
        for (int i = 0; i < b.stubPixels.length; i++) if (maxDiff(b.stubPixels[i], rgb) <= tol) n++;
        return n;
    }

    static float hueOf(int rgb) {
        float[] hsv = new float[3];
        MrGlow.hsv(rgb, hsv);
        return hsv[0];
    }

    /** A complete keyboard of the theme {@code tag} over the dark colour 5, tuned with {@code look}. */
    static Bitmap tuned(Context c, String tag, MrKeyLook look) {
        return tuned(c, tag, look, 5);
    }

    static Bitmap tuned(Context c, String tag, MrKeyLook look, int colour) {
        MrThemePreview p = fullPreview(c, 720);
        p.show(tag, MrBackdrop.Spec.color(colour), null, 0);
        p.setLook(look);
        return draw(p);
    }

    static void keyLook() throws Exception {
        reset();
        RES.flatFaces = true;
        Context c = new Ctx();
        float vw = 1080f, vh = vw / MrThemePreview.FULL_ASPECT, k = 720 / vw, top = vh * MrThemePreview.FULL_BAR_SHARE, rowH = (vh - top) / 6f;
        int fx = Math.round(30 * k), fy = Math.round((top + rowH * 0.25f) * k);       // inside the face of Ctrl, clear of its letters
        int gx = Math.round(1050f * k), gy = Math.round((top + 2 * rowH + rowH * 0.25f) * k);    // inside the face of P, at the right end of the row of letters

        // the values: what is kept, what is limited
        MrKeyLook none = MrKeyLook.NONE;
        MrKeyLook odd = new MrKeyLook(-5, 999, 0x123456, 0x654321, 0);
        check("the tuning has none of itself by default: the opacity of the style (100%), no colour of letters, no colour of its own", none.key == 100 && none.edge == 100 && none.text == 0 && none.hue == 0 && none.hue2 == 0
                && none.isNone() && !none.faceTuned());
        check("an opacity is kept between 0 and 250%, a colour is made opaque and 0 stays none", odd.key == 0 && odd.edge == 250 && odd.text == 0xff123456 && odd.hue == 0xff654321 && odd.hue2 == 0 && !odd.isNone() && odd.faceTuned());
        check("a change makes another look and leaves the first as it was", none.withKey(30).key == 30 && none.key == 100 && none.withEdge(40).edge == 40 && none.withText(0xff00ff00).text == 0xff00ff00
                && none.withHue(0xff112233).hue == 0xff112233 && none.withHue2(0xff223344).hue2 == 0xff223344 && none.withKey(100).same(none) && !none.withKey(99).same(none) && !none.same(null));
        // kept in the preferences
        Prefs store = new Prefs();
        MrKeyLook tuned = new MrKeyLook(40, 160, 0xffee8800, 0xff3366ff, 0xffff3399);
        SharedPreferences.Editor e = store.edit();
        tuned.write(e);
        e.apply();
        check("it is written whole in the preferences pref_kbd_look_* and read back as it was", MrKeyLook.read(store).same(tuned) && store.getInt("pref_kbd_look_key", -1) == 40 && store.getInt("pref_kbd_look_edge", -1) == 160
                && MrKeyLook.PREFS.length == 5 && MrKeyLook.PREFIX.equals("pref_kbd_look_"));
        store.edit().putString("pref_kbd_look_key", "oops").apply();
        check("a preference that is not a number is no tuning (and no exception)", MrKeyLook.read(store).same(MrKeyLook.NONE) && MrKeyLook.read((SharedPreferences) null).same(MrKeyLook.NONE) && MrKeyLook.read((Context) null).same(MrKeyLook.NONE));
        none.write(e = store.edit());
        e.apply();
        check("writing the default ones puts them back (the ones that were there are not left behind)", MrKeyLook.read(store).same(none) && store.getInt("pref_kbd_look_hue", -1) == 0);

        // what the keys of a theme of the backgrounds do with it
        Bitmap base = tuned(c, "mr_overice", none);
        Bitmap faint = tuned(c, "mr_overice", none.withKey(0)), dense = tuned(c, "mr_overice", none.withKey(250));
        int bgPixel = faint.getPixel(1, fy);        // the margin at the left of the keys: the background itself
        System.out.println("      key opacity: background " + Integer.toHexString(bgPixel) + ", at 0 " + Integer.toHexString(faint.getPixel(fx, fy)) + ", at 100 " + Integer.toHexString(base.getPixel(fx, fy))
                + ", at 250 " + Integer.toHexString(dense.getPixel(fx, fy)));
        check("key opacity 0: the face is gone (the background shows where the key is)", maxDiff(bgPixel, faint.getPixel(fx, fy)) <= 2 && maxDiff(bgPixel, faint.getPixel(gx, gy)) <= 2 && differing(base, faint, 2) > 1000);
        check("more opacity is a key that covers more of the background: 0, then the style's own, then 250%", maxDiff(base.getPixel(fx, fy), bgPixel) > 8 && maxDiff(dense.getPixel(fx, fy), bgPixel) > maxDiff(base.getPixel(fx, fy), bgPixel) + 8
                && maxDiff(dense.getPixel(gx, gy), bgPixel) > maxDiff(base.getPixel(gx, gy), bgPixel));
        Bitmap lineNone = tuned(c, "mr_overline", none), lineOff = tuned(c, "mr_overline", none.withEdge(0)), lineStrong = tuned(c, "mr_overline", none.withEdge(250));
        check("border opacity 0 takes the line away and leaves the face where it is", differing(lineNone, lineOff, 2) > 300 && maxDiff(lineNone.getPixel(fx, fy), lineOff.getPixel(fx, fy)) <= 1);
        check("a line at 250% is stronger than the style's own", differing(lineNone, lineStrong, 2) > 100 && near(lineStrong, MrBackdrop.STYLE_COLORS[5][0] & 0xffffff, 40) > near(lineNone, MrBackdrop.STYLE_COLORS[5][0] & 0xffffff, 40));
        Bitmap lineFill = tuned(c, "mr_overline", none.withKey(250));
        check("and the face is not touched by the line, nor the line by the face", differing(lineNone, lineFill, 2) > 100 && maxDiff(lineNone.getPixel(fx, fy), lineFill.getPixel(fx, fy)) > 4);
        // the colour of the letters
        Bitmap orange = tuned(c, "mr_overice", none.withText(0xffff8800));
        check("the letters have the colour that was picked", near(orange, 0xff8800, 36) > 150 && near(base, 0xff8800, 36) < 20);
        // the tuning is for the backgrounds only
        MrThemePreview list = fullPreview(c, 720);
        list.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        Bitmap plainList = draw(list);
        list.setLook(new MrKeyLook(0, 0, 0xffff8800, 0, 0));
        check("a theme of the list ignores it", differing(plainList, draw(list), 0) == 0);
        // the styles of the person's own colour
        MrKeyLook red = none.withHue(0xffd8281c), blue = none.withHue(0xff2848d8);
        // over black the face shows the colour itself (over a coloured background it is mixed with it)
        Bitmap redGlass = tuned(c, "mr_overownglass", red, 14), blueGlass = tuned(c, "mr_overownglass", blue, 14), defaultGlass = tuned(c, "mr_overownglass", none, 14);
        int pr = redGlass.getPixel(fx, fy), pb = blueGlass.getPixel(fx, fy);
        check("a glass of the own colour has the face tinted with it: red is red, blue is blue", channel(pr, 16) > channel(pr, 0) + 6 && channel(pb, 0) > channel(pb, 16) + 6);
        check("with no colour picked it is the one of the theme", differing(defaultGlass, tuned(c, "mr_overownglass", none.withHue(MrBackdrop.OWN_DEFAULT), 14), 1) < 50);
        Bitmap redLine = tuned(c, "mr_overownline", red, 14);
        check("an outline of the own colour has the line in it", near(redLine, 0xd8281c, 60) > 200 && near(tuned(c, "mr_overownline", blue, 14), 0xd8281c, 60) < 30);
        Bitmap grad = tuned(c, "mr_overowngrad", none.withHue(0xffff3030).withHue2(0xff3050ff), 14);
        float hl = hueOf(grad.getPixel(fx, fy) | 0xff000000), hr = hueOf(grad.getPixel(gx, gy) | 0xff000000);
        float turn = Math.abs(hl - hr);
        check("a gradient of the own colour turns from its first colour to its second along the keyboard", Math.min(turn, 360 - turn) > 60);
        Bitmap oneColour = redGlass;
        float ol = hueOf(oneColour.getPixel(fx, fy) | 0xff000000), or = hueOf(oneColour.getPixel(gx, gy) | 0xff000000);
        check("the glass and the outline have one colour all over the keyboard", Math.min(Math.abs(ol - or), 360 - Math.abs(ol - or)) < 12);
        List<Bitmap> sheetA = new ArrayList<Bitmap>(java.util.Arrays.asList(base, faint, dense, lineNone, lineOff, lineStrong));
        sheet(sheetA, 3, "look_opacity");
        List<Bitmap> sheetB = new ArrayList<Bitmap>(java.util.Arrays.asList(orange, redGlass, blueGlass, redLine, grad, tuned(c, "mr_overshade", none)));
        sheet(sheetB, 3, "look_colours");
        RES.flatFaces = false;
    }

    // ---------------------------------------------------------------- the spec

    static void spec() {
        MrBackdrop.Spec no = MrBackdrop.Spec.parse("");
        check("an empty text is no background", no.kind == MrBackdrop.NONE && no.format().equals(""));
        check("null and one letter are no background", MrBackdrop.Spec.parse(null).kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("g").kind == MrBackdrop.NONE);
        boolean round = true;
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) {
            MrBackdrop.Spec s = MrBackdrop.Spec.parse("g" + i);
            if (s.kind != MrBackdrop.GRADIENT || s.index != i || !s.format().equals("g" + i)) round = false;
        }
        check("each of the " + MrBackdrop.GRADIENT_COUNT + " gradients is read back as it was written", round && MrBackdrop.GRADIENT_COUNT == 20);
        round = true;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            MrBackdrop.Spec s = MrBackdrop.Spec.parse("c" + i);
            if (s.kind != MrBackdrop.COLOR || s.index != i || !s.format().equals("c" + i) || !s.same(MrBackdrop.Spec.color(i))) round = false;
        }
        check("each of the " + MrBackdrop.COLORS.length + " plain colours is read back as it was written", round && MrBackdrop.COLORS.length == 16);
        boolean opaque = true;
        for (int col : MrBackdrop.COLORS) if ((col >>> 24) != 255) opaque = false;
        check("the plain colours are opaque", opaque);
        round = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            MrBackdrop.Spec s = MrBackdrop.Spec.parse("s" + i);
            if (s.kind != MrBackdrop.SCENE || s.index != i || !s.format().equals("s" + i)) round = false;
        }
        check("each of the " + MrScenes.COUNT + " landscapes is read back as it was written", round);
        check("a gradient or a landscape that is not there is no background",
                MrBackdrop.Spec.parse("g20").kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("g-1").kind == MrBackdrop.NONE
                        && MrBackdrop.Spec.parse("c16").kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("c-1").kind == MrBackdrop.NONE
                        && MrBackdrop.Spec.parse("s" + MrScenes.COUNT).kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("s-3").kind == MrBackdrop.NONE);
        MrBackdrop.Spec img = MrBackdrop.Spec.parse("i150,-20,35,1700000000123");
        check("a picture: zoom, position and the time it was chosen", img.kind == MrBackdrop.IMAGE && img.zoom == 150 && img.dx == -20 && img.dy == 35 && img.stamp == 1700000000123L);
        check("a picture is written back the same", img.format().equals("i150,-20,35,1700000000123"));
        MrBackdrop.Spec wild = MrBackdrop.Spec.parse("i999,500,-500,7");
        check("zoom and position are kept inside their limits", wild.zoom == MrBackdrop.ZOOM_MAX && wild.dx == 100 && wild.dy == -100);
        check("a zoom below 100 is 100", MrBackdrop.Spec.parse("i10,0,0,1").zoom == MrBackdrop.ZOOM_MIN);
        String[] bad = {"x1", "gx", "sx", "i1,2,3", "i1,2,3,4,5", "i1,2,3,x", "i,,,", "g1.5", "g 1", "iabc", "G1", "g1 ", "s99999999999999999999", "cx", "c1.5", "C1", "c"};
        boolean allNo = true;
        for (String b : bad) {
            if (MrBackdrop.Spec.parse(b).kind != MrBackdrop.NONE) {
                allNo = false;
                System.out.println("      parsed: " + b);
            }
        }
        check("anything that is not a spec is no background", allNo);
        MrBackdrop.Spec moved = img.moved(300, 10, 20);
        check("moved keeps the picture (and its time) and changes the zoom and the position",
                moved.kind == MrBackdrop.IMAGE && moved.zoom == 300 && moved.dx == 10 && moved.dy == 20 && moved.stamp == img.stamp);
        check("moved on a gradient or a colour changes nothing", MrBackdrop.Spec.gradient(3).moved(300, 1, 1).format().equals("g3") && MrBackdrop.Spec.color(4).moved(300, 1, 1).format().equals("c4"));
        check("same compares the text", img.same(MrBackdrop.Spec.parse("i150,-20,35,1700000000123")) && !img.same(moved) && !img.same(null));
        check("clamp", MrBackdrop.clamp(5, 0, 3) == 3 && MrBackdrop.clamp(-5, 0, 3) == 0 && MrBackdrop.clamp(2, 0, 3) == 2);
    }

    // ---------------------------------------------------------------- the part of the picture, and the finger

    static void cropAndPan() {
        Rect r = MrBackdrop.crop(4000, 3000, 240, 100, 100, 0, 0);
        check("a wide shape takes the full width of the picture and the part of the height that fits, in the middle",
                r.left == 0 && r.right == 4000 && r.height() == Math.round(4000 / 2.4f) && r.top == Math.round((3000 - r.height()) / 2.0));
        r = MrBackdrop.crop(4000, 3000, 240, 100, 200, 0, 0);
        check("a zoom of 200 shows half of the width and half of the height", r.width() == 2000 && r.height() == Math.round(4000 / 2.4f / 2f) && r.left == 1000);
        r = MrBackdrop.crop(4000, 3000, 240, 100, 200, -100, -100);
        check("position -100 is against the left and the top edge", r.left == 0 && r.top == 0);
        r = MrBackdrop.crop(4000, 3000, 240, 100, 200, 100, 100);
        check("position 100 is against the right and the bottom edge", r.right == 4000 && r.bottom == 3000);
        r = MrBackdrop.crop(1000, 1000, 240, 100, 100, 0, 0);
        check("a picture that is narrower than the shape fills the width and shows a band of it", r.width() == 1000 && r.height() == Math.round(1000 / 2.4f));
        r = MrBackdrop.crop(2400, 1000, 240, 100, 100, 50, 50);
        check("a picture of the very shape is shown whole", r.left == 0 && r.top == 0 && r.right == 2400 && r.bottom == 1000);
        r = MrBackdrop.crop(0, 0, 240, 100, 100, 0, 0);
        check("an empty picture gives an empty part and no exception", r.width() == 0 && r.height() == 0);
        r = MrBackdrop.crop(500, 400, 0, 100, 100, 0, 0);
        check("an empty shape gives the whole picture", r.width() == 500 && r.height() == 400);

        Random rnd = new Random(7);
        boolean inside = true, shape = true, shrink = true;
        for (int n = 0; n < 4000; n++) {
            int iw = 1 + rnd.nextInt(5000), ih = 1 + rnd.nextInt(5000);
            int w = 1 + rnd.nextInt(2000), h = 1 + rnd.nextInt(2000);
            int dx = rnd.nextInt(401) - 200, dy = rnd.nextInt(401) - 200, zoom = rnd.nextInt(600);
            Rect c = MrBackdrop.crop(iw, ih, w, h, zoom, dx, dy);
            if (c.left < 0 || c.top < 0 || c.right > iw || c.bottom > ih || c.width() < 1 || c.height() < 1) inside = false;
            Rect bigger = MrBackdrop.crop(iw, ih, w, h, 100, dx, dy);
            if (c.width() > bigger.width() + 1 || c.height() > bigger.height() + 1) shrink = false;
            // the shape is the one of the view, when the part is big enough for the rounding not to matter
            if (c.width() > 200 && c.height() > 200 && Math.abs(c.width() / (double) c.height() - w / (double) h) > 0.02 * (w / (double) h)) shape = false;
        }
        check("for any picture, shape, zoom and position the part is inside the picture and never empty (4000 cases)", inside);
        check("the part has the shape of the view (nothing is stretched) and a zoom never makes it bigger", shape && shrink);

        // the finger
        int[] p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, 0f, 0f);
        check("no move leaves the position as it was", p[0] == 0 && p[1] == 0);
        p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, 60f, 0f);
        check("the picture follows the finger: a finger to the right shows more of the left side", p[0] < 0 && p[1] == 0);
        p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, -60f, 0f);
        check("a finger to the left shows more of the right side", p[0] > 0);
        p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, 0f, 25f);
        check("a finger down shows more of the top", p[1] < 0 && p[0] == 0);
        int[] a = MrBackdrop.pan(4000, 3000, 240, 100, 300, 0, 0, 30f, 0f);
        int[] b = MrBackdrop.pan(4000, 3000, 240, 100, 300, a[0], 0, -30f, 0f);
        check("the same move there and back brings it home", Math.abs(b[0]) <= 1);
        p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, 100000f, -100000f);
        check("a very long move stops at the edge", p[0] == -100 && p[1] == 100);
        p = MrBackdrop.pan(2400, 1000, 240, 100, 100, 17, -9, 80f, 80f);
        check("a direction without room to move is left as it was", p[0] == 17 && p[1] == -9);
        p = MrBackdrop.pan(4000, 3000, 0, 0, 200, 5, 6, 10f, 10f);
        check("a view without size changes nothing", p[0] == 5 && p[1] == 6);
        // dragging the whole width of the view at zoom 200 moves the shown part by its own width
        Rect before = MrBackdrop.crop(4000, 3000, 240, 100, 200, 0, 0);
        p = MrBackdrop.pan(4000, 3000, 240, 100, 200, 0, 0, 120f, 0f);
        Rect after = MrBackdrop.crop(4000, 3000, 240, 100, 200, p[0], p[1]);
        check("the picture moves with the finger by the same share of the view (half the width of the view: half the part)",
                Math.abs((before.left - after.left) - before.width() / 2) <= 8);
    }

    /** The frame of the crop dialog: where it goes when moved, and where it stays when the zoom changes. */
    static void frame() {
        int[] p = MrBackdrop.shift(4000, 3000, 240, 100, 200, 0, 0, 0f, 0f);
        check("the frame moved by nothing stays", p[0] == 0 && p[1] == 0);
        p = MrBackdrop.shift(4000, 3000, 240, 100, 200, 0, 0, 500f, 0f);
        check("the frame goes where the finger goes (500 of the 2000 free pixels to the right: position 50)", p[0] == 50 && p[1] == 0);
        p = MrBackdrop.shift(4000, 3000, 240, 100, 200, 0, 0, -500f, 0f);
        check("and to the left", p[0] == -50);
        p = MrBackdrop.shift(4000, 3000, 240, 100, 200, 0, 0, 0f, 100f);
        Rect r = MrBackdrop.crop(4000, 3000, 240, 100, 200, 0, 0);
        check("down: a position below the middle", p[1] > 0 && p[0] == 0 && r.height() < 3000);
        p = MrBackdrop.shift(4000, 3000, 240, 100, 200, 0, 0, 100000f, -100000f);
        check("a very long move stops at the edge", p[0] == 100 && p[1] == -100);
        p = MrBackdrop.shift(2400, 1000, 240, 100, 100, 17, -9, 80f, 80f);
        check("a direction without room is left as it was", p[0] == 17 && p[1] == -9);
        int[] a = MrBackdrop.shift(4000, 3000, 240, 100, 300, 10, 20, 120f, 40f);
        Rect ra = MrBackdrop.crop(4000, 3000, 240, 100, 300, a[0], a[1]);
        Rect r0 = MrBackdrop.crop(4000, 3000, 240, 100, 300, 10, 20);
        check("the frame moves by the pixels asked (within the rounding of the position)", Math.abs((ra.left - r0.left) - 120) <= 14 && Math.abs((ra.top - r0.top) - 40) <= 14);

        // the pinch keeps the middle of the frame where it is
        Random rnd = new Random(11);
        boolean kept = true;
        for (int n = 0; n < 2000; n++) {
            int iw = 800 + rnd.nextInt(4000), ih = 600 + rnd.nextInt(3000);
            int zoom = 100 + rnd.nextInt(301), nz = 100 + rnd.nextInt(301);
            int dx = rnd.nextInt(201) - 100, dy = rnd.nextInt(201) - 100;
            Rect before = MrBackdrop.crop(iw, ih, 240, 100, zoom, dx, dy);
            int[] q = MrBackdrop.rezoom(iw, ih, 240, 100, zoom, dx, dy, nz);
            Rect after = MrBackdrop.crop(iw, ih, 240, 100, nz, q[0], q[1]);
            double cx0 = before.left + before.width() / 2.0, cx1 = after.left + after.width() / 2.0;
            double cy0 = before.top + before.height() / 2.0, cy1 = after.top + after.height() / 2.0;
            // a frame that would go out of the picture is pushed back in: the middle moves only then
            boolean fitsX = cx0 - after.width() / 2.0 >= 0 && cx0 + after.width() / 2.0 <= iw;
            boolean fitsY = cy0 - after.height() / 2.0 >= 0 && cy0 + after.height() / 2.0 <= ih;
            double tolX = 2.0 + iw / 200.0, tolY = 2.0 + ih / 200.0;
            if (fitsX && Math.abs(cx0 - cx1) > tolX) kept = false;
            if (fitsY && Math.abs(cy0 - cy1) > tolY) kept = false;
            if (q[0] < -100 || q[0] > 100 || q[1] < -100 || q[1] > 100) kept = false;
        }
        check("a pinch keeps the middle of the frame where it was, whenever the new frame fits in the picture (2000 cases)", kept);
        p = MrBackdrop.rezoom(4000, 3000, 240, 100, 200, -100, 0, 400);
        check("a frame against the left edge that shrinks stays against the left edge's side: the middle is kept, so it moves right of the edge", p[0] > -100);
        p = MrBackdrop.rezoom(2400, 1000, 240, 100, 100, 17, -9, 100);
        check("a picture of the very shape has nothing to move", p[0] == 17 && p[1] == -9);
    }

    // ---------------------------------------------------------------- the pixels of a background

    /** The colour of a CSS linear gradient (angle: 0 up, 90 to the right) at a point of a shape of w x h. */
    static int css(MrBackdrop.Grad g, double x, double y, int w, int h) {
        double a = Math.toRadians(g.angle);
        double dx = Math.sin(a), dy = -Math.cos(a);
        double len = Math.abs(w * dx) + Math.abs(h * dy);
        double t = 0.5 + ((x - w / 2.0) * dx + (y - h / 2.0) * dy) / len;
        t = Math.max(0, Math.min(1, t));
        int n = g.colours.length - 1;
        for (int i = 0; i < n; i++) {
            double from = g.stops == null ? i / (double) n : g.stops[i], to = g.stops == null ? (i + 1) / (double) n : g.stops[i + 1];
            if (t <= to || i == n - 1) {
                double f = to > from ? Math.max(0, Math.min(1, (t - from) / (to - from))) : 1;
                return MrBackdrop.mix(g.colours[i], g.colours[i + 1], (float) f);
            }
        }
        return g.colours[n];
    }

    static void pixels() throws Exception {
        // a picture of two halves: red on the left, blue on the right
        Bitmap two = bitmap(1000, 500);
        for (int y = 0; y < 500; y++) for (int x = 0; x < 1000; x++) two.setPixel(x, y, x < 500 ? 0xffff0000 : 0xff0000ff);
        Bitmap out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.image(100, 0, 0, 1), 240, 100, two);
        check("a picture is drawn from its left side to its right", maxDiff(out.getPixel(10, 50), 0xffff0000) <= 2 && maxDiff(out.getPixel(230, 50), 0xff0000ff) <= 2);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.image(400, -100, 0, 1), 240, 100, two);
        check("zoomed to 400 and against the left edge only the left side shows", maxDiff(out.getPixel(10, 50), 0xffff0000) <= 2 && maxDiff(out.getPixel(230, 50), 0xffff0000) <= 2);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.image(400, 100, 0, 1), 240, 100, two);
        check("against the right edge only the right side shows", maxDiff(out.getPixel(10, 50), 0xff0000ff) <= 2 && maxDiff(out.getPixel(230, 50), 0xff0000ff) <= 2);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.image(100, 0, 0, 1), 240, 100, null);
        check("a picture that is not there draws nothing", out.getPixel(10, 10) == 0 && out.getPixel(200, 90) == 0);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.NO, 240, 100, two);
        check("no background draws nothing", out.getPixel(10, 10) == 0);
        MrBackdrop.draw(null, MrBackdrop.Spec.gradient(0), 10, 10, null);
        MrBackdrop.draw(new Canvas(out), null, 10, 10, null);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(0), 0, 10, null);
        check("no canvas, no spec or no size are left alone", true);

        // every gradient is drawn the way CSS draws it: along its angle, through the middle, as long as the shape is deep in that direction
        boolean formula = true;
        int lit = 0;
        for (int n = 0; n < MrBackdrop.GRADIENT_COUNT; n++) {
            if (MrBackdrop.GRADS[n].glow != null) {
                lit++;
                continue; // the ones with a light in a corner are checked below
            }
            out = bitmap(240, 100);
            MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(n), 240, 100, null);
            for (int[] pt : new int[][] {{1, 1}, {238, 1}, {1, 98}, {238, 98}, {120, 50}, {60, 25}, {180, 75}, {120, 1}, {120, 98}, {120, 55}, {120, 88}}) {
                int want = css(MrBackdrop.GRADS[n], pt[0] + 0.5, pt[1] + 0.5, 240, 100);
                if (maxDiff(out.getPixel(pt[0], pt[1]), want) > 4) {
                    formula = false;
                    System.out.println("      gradient " + n + " at " + pt[0] + "," + pt[1] + ": " + Integer.toHexString(out.getPixel(pt[0], pt[1])) + " expected " + Integer.toHexString(want));
                }
            }
        }
        check("the gradients without a light follow their angle, colours and stops as CSS does (eleven points of each)", formula && lit == 2);
        boolean topDown = true;
        for (int n = 0; n < MrBackdrop.GRADIENT_COUNT; n++) if (MrBackdrop.GRADS[n].angle != 180) topDown = false;
        check("every gradient goes from the top down, like the ones of the GB example", topDown);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(0), 240, 100, null);
        MrBackdrop.Grad g0 = MrBackdrop.GRADS[0];
        check("from the top down: the first colour at the top, the last at the bottom",
                maxDiff(out.getPixel(120, 0), g0.colours[0]) <= 6 && maxDiff(out.getPixel(120, 99), g0.colours[2]) <= 6 && maxDiff(out.getPixel(3, 0), out.getPixel(236, 0)) <= 2);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(5), 240, 100, null);
        MrBackdrop.Grad g5 = MrBackdrop.GRADS[5];
        check("a gradient with stops has its second colour where the stop says (55% of the height)", g5.stops != null && maxDiff(out.getPixel(120, 55), g5.colours[1]) <= 8 && maxDiff(out.getPixel(120, 88), g5.colours[2]) <= 8);
        // the light in a corner
        Bitmap lit1 = bitmap(240, 100), lit2 = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(lit1), MrBackdrop.Spec.gradient(17), 240, 100, null);
        MrBackdrop.draw(new Canvas(lit2), MrBackdrop.Spec.gradient(19), 240, 100, null);
        MrBackdrop.Grad g18 = MrBackdrop.GRADS[17], g20 = MrBackdrop.GRADS[19];
        int base18 = css(new MrBackdrop.Grad(180, g18.colours, g18.stops, null), 120.5, 92.5, 240, 100);
        int base20 = css(new MrBackdrop.Grad(180, g20.colours, g20.stops, null), 239.5, 99.5, 240, 100);
        check("the light of the green gradient is brightest low in the middle, and its corner is as the gradient says",
                channel(lit1.getPixel(120, 92), 8) > channel(base18, 8) + 40 && maxDiff(lit1.getPixel(0, 0), g18.colours[0]) <= 6);
        check("the light of the pink gradient is in the bottom right corner", maxDiff(lit2.getPixel(239, 99), base20) > 40 && maxDiff(lit2.getPixel(0, 0), g20.colours[0]) <= 6);
        // a plain colour fills the shape
        boolean plain = true;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            out = bitmap(240, 100);
            MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.color(i), 240, 100, null);
            if (out.getPixel(0, 0) != MrBackdrop.COLORS[i] || out.getPixel(239, 99) != MrBackdrop.COLORS[i] || out.getPixel(120, 50) != MrBackdrop.COLORS[i]) plain = false;
        }
        check("a plain colour is the whole of its shape, as it is", plain);
        scenes();
    }

    // ---------------------------------------------------------------- the landscapes

    static Bitmap[] SCENE_BITMAPS;

    /** The bitmap of landscape {@code i}, read once (the PC has no WebP decoder: with PNG files named like the assets in the folder of AssetManager.stubRoot they are the real pictures). */
    static Bitmap scene(int i) {
        if (SCENE_BITMAPS == null) {
            SCENE_BITMAPS = new Bitmap[MrScenes.COUNT];
            Ctx c = new Ctx();
            for (int n = 0; n < MrScenes.COUNT; n++) SCENE_BITMAPS[n] = MrScenes.load(c, n);
        }
        return SCENE_BITMAPS[i];
    }

    /** The bitmap that a background is drawn from in these tests: the landscape for a landscape, none for the others. */
    static Bitmap imageFor(MrBackdrop.Spec s) {
        return s != null && s.kind == MrBackdrop.SCENE ? scene(s.index) : null;
    }

    /** The size of a lossy WebP from its header (what the PC can read of it): {width, height}, or null when it is not one. */
    static int[] webpSize(byte[] d) {
        if (d.length < 30 || d[0] != 'R' || d[1] != 'I' || d[2] != 'F' || d[3] != 'F' || d[8] != 'W' || d[9] != 'E' || d[10] != 'B' || d[11] != 'P') return null;
        if (d[12] != 'V' || d[13] != 'P' || d[14] != '8' || d[15] != ' ') return null;
        if ((d[23] & 0xff) != 0x9d || (d[24] & 0xff) != 0x01 || (d[25] & 0xff) != 0x2a) return null;
        return new int[] {(d[26] & 0xff) | ((d[27] & 0x3f) << 8), (d[28] & 0xff) | ((d[29] & 0x3f) << 8)};
    }

    static void scenes() throws Exception {
        reset();
        // the landscapes are 36 pictures of the app: six categories of six
        check("36 landscapes: six categories of six", MrScenes.COUNT == 36 && MrScenes.CATEGORIES == 6 && MrScenes.PER_CATEGORY == 6);
        boolean map = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            if (MrScenes.category(i) != i / 6 || MrScenes.number(i) != i % 6 || MrScenes.scene(MrScenes.category(i), MrScenes.number(i)) != i || !MrScenes.valid(i)) map = false;
        }
        check("a landscape is told by its category and its place in it", map && MrScenes.category(-1) == -1 && MrScenes.category(36) == -1 && MrScenes.number(99) == -1
                && !MrScenes.valid(-1) && !MrScenes.valid(36));
        check("the categories are sports, animals, snow, nature, anime and AI, in this order", MrScenes.SPORTS == 0 && MrScenes.ANIMALS == 1 && MrScenes.SNOW == 2 && MrScenes.NATURE == 3
                && MrScenes.ANIME == 4 && MrScenes.AI == 5 && "mr_scenes/sports_1.webp".equals(MrScenes.path(0)) && "mr_scenes/animals_3.webp".equals(MrScenes.path(8))
                && "mr_scenes/snow_6.webp".equals(MrScenes.path(17)) && "mr_scenes/nature_2.webp".equals(MrScenes.path(19)) && "mr_scenes/anime_4.webp".equals(MrScenes.path(27))
                && "mr_scenes/ai_6.webp".equals(MrScenes.path(35)) && MrScenes.path(36) == null && MrScenes.path(-1) == null);
        // the files: one small WebP for each, a picture of its own (the crop of the sheet, without the frame)
        boolean files = true, sizes = true;
        long total = 0;
        java.util.Set<String> seen = new java.util.HashSet<String>();
        for (int i = 0; i < MrScenes.COUNT; i++) {
            File f = new File("assets/" + MrScenes.path(i));
            if (!f.isFile()) {
                files = false;
                System.out.println("      missing: " + f);
                continue;
            }
            byte[] d = java.nio.file.Files.readAllBytes(f.toPath());
            total += d.length;
            int[] size = webpSize(d);
            if (size == null || size[0] < 330 || size[1] < 330 || size[0] > 560 || size[1] > 560 || d.length > 110 * 1024 || d.length < 8 * 1024) {
                sizes = false;
                System.out.println("      " + f + ": " + d.length + " bytes, " + (size == null ? "not a WebP" : size[0] + "x" + size[1]));
            }
            if (!seen.add(java.util.Arrays.toString(java.util.Arrays.copyOf(d, Math.min(d.length, 4096))))) files = false;
        }
        check("every landscape has its file in the assets, and no two are the same file", files);
        check("each is a WebP of 330 to 560 pixels a side and 8 to 110 KB", sizes);
        System.out.println("      the 36 landscapes take " + total / 1024 + " KB in the app");
        check("together they are under 2 MB", total < 2 * 1024 * 1024);
        check("the apk stores the WebP as it is (doNotCompress), as it is compressed already", new String(java.nio.file.Files.readAllBytes(new File("apktool.yml").toPath()), "UTF-8").contains("- webp"));
        // reading one
        Ctx c = new Ctx();
        Bitmap whole = MrScenes.load(c, 0), half = MrScenes.load(c, 0, 2);
        check("a landscape is read whole, and at half the size for the small tiles", whole != null && half != null && half.getWidth() == whole.getWidth() / 2 && half.getHeight() == whole.getHeight() / 2
                && whole.getWidth() >= 330 && whole.getHeight() >= 330);
        check("an unknown landscape and no context give no picture and no exception", MrScenes.load(c, 36) == null && MrScenes.load(c, -1) == null && MrScenes.load(null, 0) == null);
        File root = android.content.res.AssetManager.stubRoot;
        android.content.res.AssetManager.stubRoot = new File("no_such_folder");
        check("a file that is gone gives no picture", MrScenes.load(c, 3) == null);
        android.content.res.AssetManager.stubRoot = root;
        BitmapFactory.stubFail = true;
        check("a picture that cannot be decoded gives none", MrScenes.load(c, 3) == null);
        BitmapFactory.stubFail = false;

        // where the strip goes: inside the picture, and the spec carries it
        boolean focus = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            int f = MrScenes.focus(i);
            MrBackdrop.Spec sp = MrBackdrop.Spec.scene(i);
            if (f < -100 || f > 100 || sp.dy != f || sp.dx != 0 || sp.zoom != 100 || sp.kind != MrBackdrop.SCENE || !sp.format().equals("s" + i)) focus = false;
        }
        check("every landscape says where its strip goes (-100 .. 100) and the spec carries it, with no zoom and no sideways move", focus && MrScenes.focus(99) == 0 && MrScenes.focus(-1) == 0);
        check("a landscape is drawn from a bitmap, as the picture of the gallery is; a colour or a gradient or none is not",
                MrBackdrop.needsBitmap(MrBackdrop.Spec.scene(3)) && MrBackdrop.needsBitmap(MrBackdrop.Spec.image(100, 0, 0, 1)) && !MrBackdrop.needsBitmap(MrBackdrop.Spec.color(2))
                        && !MrBackdrop.needsBitmap(MrBackdrop.Spec.gradient(2)) && !MrBackdrop.needsBitmap(MrBackdrop.Spec.NO) && !MrBackdrop.needsBitmap(null));
        check("the bitmap of a background: the landscape for a landscape, none for a colour or a gradient or none",
                MrBackdrop.bitmap(c, MrBackdrop.Spec.scene(5)) != null && MrBackdrop.bitmap(c, MrBackdrop.Spec.color(1)) == null && MrBackdrop.bitmap(c, MrBackdrop.Spec.gradient(1)) == null
                        && MrBackdrop.bitmap(c, MrBackdrop.Spec.NO) == null && MrBackdrop.bitmap(c, null) == null && MrBackdrop.bitmap(null, MrBackdrop.Spec.scene(5)) == null);

        // drawing: the strip of the picture fills the shape, as the picture of the gallery does
        boolean every = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            Bitmap out = bitmap(240, 100);
            MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.scene(i), 240, 100, scene(i));
            int opaque = 0;
            for (int px : out.stubPixels) if ((px >>> 24) == 255) opaque++;
            if (opaque < out.stubPixels.length * 0.98) {
                every = false;
                System.out.println("      scene " + i + ": " + opaque + " of " + out.stubPixels.length + " pixels covered");
            }
        }
        check("each landscape covers the whole of its shape", every);
        boolean repeatable = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            Bitmap a = bitmap(240, 100), b = bitmap(240, 100);
            MrBackdrop.draw(new Canvas(a), MrBackdrop.Spec.scene(i), 240, 100, scene(i));
            MrBackdrop.draw(new Canvas(b), MrBackdrop.Spec.scene(i), 240, 100, scene(i));
            if (!java.util.Arrays.equals(a.stubPixels, b.stubPixels)) repeatable = false;
        }
        check("a landscape looks the same every time it is drawn", repeatable);
        Bitmap out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.scene(1), 240, 100, null);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.NO, 240, 100, scene(1));
        check("a landscape without its picture, and a picture without a background, draw nothing", out.getPixel(5, 5) == 0 && out.getPixel(200, 90) == 0);
        boolean differ = true;
        for (int i = 0; i < MrScenes.COUNT && differ; i++) {
            for (int j = i + 1; j < MrScenes.COUNT; j++) {
                Bitmap x = bitmap(120, 50), y = bitmap(120, 50);
                MrBackdrop.draw(new Canvas(x), MrBackdrop.Spec.scene(i), 120, 50, scene(i));
                MrBackdrop.draw(new Canvas(y), MrBackdrop.Spec.scene(j), 120, 50, scene(j));
                if (java.util.Arrays.equals(x.stubPixels, y.stubPixels)) differ = false;
            }
        }
        check("no two landscapes are the same picture", differ);
        // the strip follows the focus: the same picture drawn at the top and at the bottom shows different parts
        Bitmap top = bitmap(240, 100), bottom = bitmap(240, 100), mine = bitmap(240, 100), same = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(top), MrBackdrop.Spec.image(100, 0, -100, 1), 240, 100, scene(2));
        MrBackdrop.draw(new Canvas(bottom), MrBackdrop.Spec.image(100, 0, 100, 1), 240, 100, scene(2));
        MrBackdrop.draw(new Canvas(mine), MrBackdrop.Spec.scene(2), 240, 100, scene(2));
        MrBackdrop.draw(new Canvas(same), MrBackdrop.Spec.image(100, 0, MrScenes.focus(2), 1), 240, 100, scene(2));
        check("the strip of a landscape is the part of the picture that its focus says (neither the top nor the bottom of it)",
                java.util.Arrays.equals(mine.stubPixels, same.stubPixels) && !java.util.Arrays.equals(top.stubPixels, bottom.stubPixels) && !java.util.Arrays.equals(mine.stubPixels, top.stubPixels));
    }

    // ---------------------------------------------------------------- the veil

    static void veil() {
        check("a dark theme over a dark background needs no veil", MrBackdrop.veil(true, 0.2f, 0) == 0f);
        check("a light theme over a light background needs no veil", MrBackdrop.veil(false, 0.8f, 0) == 0f);
        check("a dark theme over a bright background: black, just enough for 0.40", near(MrBackdrop.veil(true, 0.8f, 0), 0.5f, 0.0001f));
        check("a light theme over a dark background: white, just enough for 0.62", near(MrBackdrop.veil(false, 0.2f, 0), (0.62f - 0.2f) / 0.8f, 0.0001f));
        check("the softening is a floor: a dark background that needs nothing still gets it", near(MrBackdrop.veil(true, 0.1f, 30), 0.30f, 0.0001f));
        check("a veil that is needed is not made smaller by a smaller softening", near(MrBackdrop.veil(true, 0.8f, 10), 0.5f, 0.0001f));
        check("the softening is kept inside its limit", near(MrBackdrop.veil(true, 0.1f, 500), 0.70f, 0.0001f) && MrBackdrop.veil(true, 0.1f, -5) == 0f);
        boolean never = true, reaches = true;
        for (int soft = 0; soft <= 70; soft += 10) {
            for (float lum = 0f; lum <= 1.0001f; lum += 0.01f) {
                float d = MrBackdrop.veil(true, lum, soft), l = MrBackdrop.veil(false, lum, soft);
                if (d > MrBackdrop.MAX_VEIL + 1e-6f || l > MrBackdrop.MAX_VEIL + 1e-6f || d < soft / 100f - 1e-6f || l < soft / 100f - 1e-6f) never = false;
                if (lum * (1f - d) > MrBackdrop.DARK_TARGET + 1e-4f) reaches = false;
                if (lum + (1f - lum) * l < MrBackdrop.LIGHT_TARGET - 1e-4f) reaches = false;
            }
        }
        check("the veil is never denser than 75% and never less than the softening, and the targets are reached for every brightness", never && reaches);
        check("mix: half of white on black is grey, alpha 0 is the colour under, alpha 1 the colour over",
                MrBackdrop.mix(0xff000000, 0xffffffff, 0.5f) == 0xff808080 && MrBackdrop.mix(0xff102030, 0xffffffff, 0f) == 0xff102030
                        && MrBackdrop.mix(0xff102030, 0xffabcdef, 1f) == 0xffabcdef);
        check("a veil with no look or no alpha is clear, the other one is its colour at its alpha",
                MrBackdropDrawable.veilOver(null) == 0 && MrBackdropDrawable.veilOver(new MrBackdrop.Look(0.5f, 0.5f, 0, 0xff000000, 0)) == 0
                        && MrBackdropDrawable.veilOver(new MrBackdrop.Look(0.9f, 0.9f, 128, 0xff000000, 0)) == 0x80000000
                        && MrBackdropDrawable.veilOver(new MrBackdrop.Look(0.1f, 0.1f, 77, 0xffffffff, 0)) == 0x4dffffff);

        // every landscape and gradient, under a dark and a light theme, for several softenings
        boolean covered = true, bottomOpaque = true;
        int worstDark = 0, worstLight = 0;
        List<MrBackdrop.Spec> specs = new ArrayList<MrBackdrop.Spec>();
        for (int i = 0; i < MrScenes.COUNT; i++) specs.add(MrBackdrop.Spec.scene(i));
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) specs.add(MrBackdrop.Spec.gradient(i));
        boolean softApplied = true, softMoves = false;
        for (MrBackdrop.Spec s : specs) {
            for (int soft : new int[] {0, 25, 70}) {
                for (boolean dark : new boolean[] {true, false}) {
                    MrBackdrop.Look look = MrBackdrop.look(s, imageFor(s), dark, soft);
                    if (look == null) {
                        covered = false;
                        continue;
                    }
                    float a = look.veilAlpha / 255f;
                    boolean capped = a >= MrBackdrop.MAX_VEIL - 0.01f;
                    for (float lum : new float[] {look.luminance, look.barLuminance}) {
                        float after = dark ? lum * (1f - a) : lum + (1f - lum) * a;
                        if (dark && after > MrBackdrop.DARK_TARGET + 0.01f && !capped) covered = false;
                        if (!dark && after < MrBackdrop.LIGHT_TARGET - 0.01f && !capped) covered = false;
                    }
                    if (look.veilColor != (dark ? 0xff000000 : 0xffffffff)) covered = false;
                    // the softening is for the gradients, the landscapes and the pictures: the veil is the one the picture needs, or the softening when that is more
                    int needed = MrBackdrop.look(s, imageFor(s), dark, 0).veilAlpha;
                    if (look.veilAlpha < needed || look.veilAlpha < Math.min(Math.round(soft * 255 / 100f), Math.round(MrBackdrop.MAX_VEIL * 255)) - 2) softApplied = false;
                    if (soft == 70 && look.veilAlpha > needed) softMoves = true;
                    if ((look.bottom >>> 24) != 255) bottomOpaque = false;
                    if (soft == 0 && dark) worstDark = Math.max(worstDark, look.veilAlpha);
                    if (soft == 0 && !dark) worstLight = Math.max(worstLight, look.veilAlpha);
                }
            }
        }
        check("every landscape and gradient is brought to the target brightness, over all of it and over the toolbar at the top, under a dark and a light theme (or to the limit of the veil)", covered);
        check("the colour of the lower edge, for the navigation bar, is opaque", bottomOpaque);
        check("the softening gives a landscape or a gradient a veil at least as dense as the softening (and the one the picture needs, when that is more)", softApplied && softMoves);
        // the plain colours: no veil, the colour is the lower edge, whatever the softening and the theme
        boolean colourLook = true;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            for (boolean dark : new boolean[] {true, false}) {
                MrBackdrop.Look l = MrBackdrop.look(MrBackdrop.Spec.color(i), null, dark, 60);
                if (l == null || l.veilAlpha != 0 || l.bottom != MrBackdrop.COLORS[i] || !near(l.luminance, MrThemeColors.luminance(MrBackdrop.COLORS[i]), 0.001f)) colourLook = false;
            }
        }
        check("a plain colour is shown as it is: no veil, whatever the theme or the softening, and its own colour is the lower edge", colourLook);
        boolean[] darkInk = {false, true, false, false, false, false, true, false, false, false, true, true, false, false, false, false};
        boolean inkRight = true;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            if (MrBackdrop.darkInk(MrBackdrop.Spec.color(i)) != darkInk[i]) inkRight = false;
            if (MrBackdrop.themeTag(MrBackdrop.Spec.color(i)).equals(MrBackdrop.TAG_DARK_INK) != darkInk[i]) inkRight = false;
        }
        check("white is the ink of a colour unless white would not read on it (under 4.5 to 1): the four light ones have dark ink, the other twelve white", inkRight);
        boolean whiteInk = !MrBackdrop.darkInk(null) && !MrBackdrop.darkInk(MrBackdrop.Spec.NO) && !MrBackdrop.darkInk(MrBackdrop.Spec.image(100, 0, 0, 1));
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) if (MrBackdrop.darkInk(MrBackdrop.Spec.gradient(i))) whiteInk = false;
        for (int i = 0; i < MrScenes.COUNT; i++) if (MrBackdrop.darkInk(MrBackdrop.Spec.scene(i))) whiteInk = false;
        check("gradients, landscapes and pictures always have white ink (they are dark, or veiled)", whiteInk);
        check("the contrast of black and white is 21 and of a colour with itself 1", near(MrBackdrop.contrast(0xff000000, 0xffffffff), 21f, 0.01f) && near(MrBackdrop.contrast(0xff336699, 0xff336699), 1f, 0.001f));
        Bitmap bright = bitmap(100, 100);
        java.util.Arrays.fill(bright.stubPixels, 0xffffffff);
        check("the softening is a floor of the veil for a picture of the gallery: 40% on a white picture under a dark ink gives at least 60% (needed) and a dark one gets 40%",
                MrBackdrop.look(MrBackdrop.Spec.image(100, 0, 0, 1), bright, true, 40).veilAlpha >= 152);
        Bitmap darkPic = bitmap(100, 100);
        java.util.Arrays.fill(darkPic.stubPixels, 0xff101010);
        MrBackdrop.Look softPic = MrBackdrop.look(MrBackdrop.Spec.image(100, 0, 0, 1), darkPic, true, 40);
        check("a dark picture needs no veil of its own and gets the softening asked: 40%", Math.abs(softPic.veilAlpha - Math.round(0.40f * 255f)) <= 1);
        System.out.println("      densest veil without softening: dark theme " + worstDark + "/255, light theme " + worstLight + "/255");
        check("no background and a picture that is not there give no look", MrBackdrop.look(MrBackdrop.Spec.NO, null, true, 0) == null
                && MrBackdrop.look(MrBackdrop.Spec.image(100, 0, 0, 1), null, true, 0) == null && MrBackdrop.look(null, null, true, 0) == null);
        // the lower edge is the colour of the lower row of the background with the veil on it
        Bitmap white = bitmap(100, 100);
        java.util.Arrays.fill(white.stubPixels, 0xffffffff);
        MrBackdrop.Look lw = MrBackdrop.look(MrBackdrop.Spec.image(100, 0, 0, 1), white, true, 0);
        check("a white picture under a dark theme: brightness 1, a veil of 60%, an edge of 40% grey",
                near(lw.luminance, 1f, 0.001f) && Math.abs(lw.veilAlpha - 153) <= 1 && maxDiff(lw.bottom, 0xff666666) <= 2);
        Bitmap black = bitmap(100, 100);
        java.util.Arrays.fill(black.stubPixels, 0xff000000);
        MrBackdrop.Look lb = MrBackdrop.look(MrBackdrop.Spec.image(100, 0, 0, 1), black, false, 0);
        check("a black picture under a light theme: a white veil of 62%, an edge of 62% grey", lb.luminance < 0.001f && Math.abs(lb.veilAlpha - 158) <= 1 && maxDiff(lb.bottom, 0xff9e9e9e) <= 2);
    }

    // ---------------------------------------------------------------- the picture of the gallery

    static void gallery() throws Exception {
        reset();
        Context c = new Ctx();
        check("no picture kept: none to load, no time, nothing waiting", !MrBackdrop.hasImage(c) && MrBackdrop.load(c) == null && MrBackdrop.imageStamp(c) == 0L
                && !MrBackdrop.hasPending(c) && MrBackdrop.loadPending(c) == null && MrBackdrop.pendingStamp(c) == 0L);

        BitmapFactory.stubWidth = 4000;
        BitmapFactory.stubHeight = 3000;
        int[] size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9, 9, 9}));
        check("a 4000 x 3000 photo is kept at 1280 on its longest side, with its shape", size != null && size[0] == 1280 && size[1] == 960);
        check("the photo was decoded smaller (a power of two) and not at full size", BitmapFactory.stubSamples.size() == 1 && BitmapFactory.stubSamples.get(0) == 2);
        check("it waits in the files of the app, apart from the background, and nothing else was left there or in the cache",
                MrBackdrop.hasPending(c) && !MrBackdrop.hasImage(c) && new File(FILES, MrBackdrop.PENDING).length() == 5 && FILES.list().length == 1 && CACHE.list().length == 0);
        check("the waiting picture can be loaded and has a time, and the background has none yet", MrBackdrop.loadPending(c) != null && MrBackdrop.pendingStamp(c) > 0L && MrBackdrop.load(c) == null
                && MrBackdrop.imageStamp(c) == 0L);

        BitmapFactory.stubWidth = 800;
        BitmapFactory.stubHeight = 600;
        BitmapFactory.stubSamples.clear();
        size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("a small picture is kept as it is", size != null && size[0] == 800 && size[1] == 600 && BitmapFactory.stubSamples.get(0) == 1);

        BitmapFactory.stubWidth = 1200;
        BitmapFactory.stubHeight = 4000;
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_90;
        size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("a portrait photo is scaled and then turned the quarter turn it asks for: the sides swap", size != null && size[0] == 1280 && size[1] == 384);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_180;
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 1000;
        size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("a half turn keeps the sides", size != null && size[0] == 1280 && size[1] == 427);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_270;
        size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("three quarters swap them too", size != null && size[0] == 427 && size[1] == 1280);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_NORMAL;
        ExifInterface.stubFail = true;
        size = MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("a photo whose orientation cannot be read is kept as it is", size != null && size[0] == 1280 && size[1] == 427);
        ExifInterface.stubFail = false;

        // a failure leaves what was there
        long stamp = MrBackdrop.pendingStamp(c);
        byte[] before = Files.readAllBytes(new File(FILES, MrBackdrop.PENDING).toPath());
        BitmapFactory.stubFail = true;
        check("something that is not a picture gives null", MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {1, 2})) == null);
        BitmapFactory.stubFail = false;
        BitmapFactory.stubWidth = 0;
        BitmapFactory.stubHeight = 0;
        check("a picture without size gives null", MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {1, 2})) == null);
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 2000;
        check("a stream that breaks gives null", MrBackdrop.importPending(c, new InputStream() {
            public int read() throws IOException { throw new IOException("lost"); }
        }) == null);
        check("what was waiting before stays, and no half-written file or copy is left",
                java.util.Arrays.equals(before, Files.readAllBytes(new File(FILES, MrBackdrop.PENDING).toPath())) && MrBackdrop.pendingStamp(c) == stamp
                        && FILES.list().length == 1 && CACHE.list().length == 0);

        // applying: the waiting picture becomes the background, in one step
        Files.write(new File(FILES, MrBackdrop.FILE).toPath(), new byte[] {7, 7});
        byte[] waiting = Files.readAllBytes(new File(FILES, MrBackdrop.PENDING).toPath());
        check("a background that is already there is not touched by a picture that waits", MrBackdrop.hasImage(c) && new File(FILES, MrBackdrop.FILE).length() == 2 && MrBackdrop.hasPending(c));
        check("committing makes the waiting picture the background, and nothing waits any more", MrBackdrop.commitPending(c) && !MrBackdrop.hasPending(c) && MrBackdrop.hasImage(c)
                && java.util.Arrays.equals(waiting, Files.readAllBytes(new File(FILES, MrBackdrop.FILE).toPath())) && FILES.list().length == 1);
        check("committing with nothing waiting says no and changes nothing", !MrBackdrop.commitPending(c) && MrBackdrop.hasImage(c));
        // discarding: the picture is let go and the background stays
        MrBackdrop.importPending(c, new ByteArrayInputStream(new byte[] {9}));
        check("another picture waits beside the background", MrBackdrop.hasPending(c) && MrBackdrop.hasImage(c) && FILES.list().length == 2);
        MrBackdrop.discardPending(c);
        check("discarding it takes only the waiting one; discarding again is no error", !MrBackdrop.hasPending(c) && MrBackdrop.hasImage(c));
        MrBackdrop.discardPending(c);

        MrBackdrop.removeImage(c);
        check("removing deletes the file and removing again is no error", !MrBackdrop.hasImage(c) && MrBackdrop.load(c) == null);
        MrBackdrop.removeImage(c);

        check("sample sizes keep the longest side at 1280 or more", MrBackdrop.sampleSize(1000, 800) == 1 && MrBackdrop.sampleSize(2559, 100) == 1
                && MrBackdrop.sampleSize(2560, 100) == 2 && MrBackdrop.sampleSize(5000, 4000) == 2 && MrBackdrop.sampleSize(6000, 100) == 4
                && MrBackdrop.sampleSize(12000, 9000) == 8 && MrBackdrop.sampleSize(0, 0) == 1);
        check("the quarter turns of the orientation tag", MrBackdrop.degrees(ExifInterface.ORIENTATION_NORMAL) == 0 && MrBackdrop.degrees(ExifInterface.ORIENTATION_ROTATE_90) == 90
                && MrBackdrop.degrees(ExifInterface.ORIENTATION_ROTATE_180) == 180 && MrBackdrop.degrees(ExifInterface.ORIENTATION_ROTATE_270) == 270 && MrBackdrop.degrees(77) == 0);
    }

    // ---------------------------------------------------------------- the colours of the themes

    static final String[] ROLES = {"kbd_bg", "text", "accent_text"};

    static void colours() {
        Context c = new Ctx();
        String[] tags = MrThemeColors.tags(c), names = MrThemeColors.names(c), values = MrThemeColors.values(c);
        check("thirty-two themes with a tag, a name and a value each: thirteen on the list and the nineteen of the backgrounds", tags.length == 32 && names.length == 32 && values.length == 32);
        boolean named = true, valued = true;
        for (int i = 0; i < 32; i++) {
            if (names[i] == null || names[i].length() == 0) named = false;
            if (!values[i].equals(String.valueOf(i))) valued = false;
        }
        check("the names are the ones of the list (no empty one) and the values are 0 .. 28", named && valued);
        boolean allHidden = true;
        for (int i = 13; i < 32; i++) if (!MrThemeColors.hidden(tags[i])) allHidden = false;
        check("the list shows the first thirteen: the nineteen themes of the backgrounds come after them and are hidden", MrThemeColors.listed(tags) == 13 && !MrThemeColors.hidden(tags[12])
                && allHidden && tags[13].equals(MrBackdrop.TAG_LIGHT_INK) && tags[14].equals(MrBackdrop.TAG_DARK_INK));
        String[] order = {"mr_overlight", "mr_overice", "mr_overlilac", "mr_overmint", "mr_overshade", "mr_overline", "mr_overteal", "mr_overviolet", "mr_overfuchsia", "mr_overlime", "mr_overgold",
                "mr_overdawn", "mr_overtide", "mr_overprism", "mr_overlagoon", "mr_overownglass", "mr_overownline", "mr_overowngrad"};
        boolean sameOrder = MrBackdrop.STYLES == order.length;
        for (int i = 0; sameOrder && i < order.length; i++) sameOrder = MrBackdrop.STYLE_TAGS[i].equals(order[i]) && tags[i == 0 ? 13 : 14 + i].equals(order[i]);
        check("the styles of the keys are themes of the backgrounds too, in this order: the clear glass, four tinted glasses, six outlines, four gradients and the three of the colour the person picks (the first one is the theme with light ink)", sameOrder);
        check("the styles come in three kinds: glass (the first five), outline (six) and gradient (four), each with the colours that show it in the dialog (three hues for a gradient)",
                MrBackdrop.KINDS == 3 && MrBackdrop.KIND_FIRST.length == 4 && MrBackdrop.KIND_FIRST[0] == 0 && MrBackdrop.KIND_FIRST[1] == 5 && MrBackdrop.KIND_FIRST[2] == 11 && MrBackdrop.KIND_FIRST[3] == MrBackdrop.PRESETS && MrBackdrop.PRESETS == 15 && MrBackdrop.STYLES == 18
                        && MrBackdrop.kindOf(0) == MrBackdrop.KIND_GLASS && MrBackdrop.kindOf(4) == MrBackdrop.KIND_GLASS && MrBackdrop.kindOf(5) == MrBackdrop.KIND_OUTLINE
                        && MrBackdrop.kindOf(10) == MrBackdrop.KIND_OUTLINE && MrBackdrop.kindOf(11) == MrBackdrop.KIND_GRADIENT && MrBackdrop.kindOf(14) == MrBackdrop.KIND_GRADIENT
                        && MrBackdrop.kindOf(15) == MrBackdrop.KIND_GLASS && MrBackdrop.kindOf(16) == MrBackdrop.KIND_OUTLINE && MrBackdrop.kindOf(17) == MrBackdrop.KIND_GRADIENT
                        && MrBackdrop.ownStyle(MrBackdrop.KIND_GLASS) == 15 && MrBackdrop.ownStyle(MrBackdrop.KIND_GRADIENT) == 17 && MrBackdrop.isOwnStyle(15) && !MrBackdrop.isOwnStyle(14) && !MrBackdrop.isOwnStyle(18)
                        && MrBackdrop.kindOf(-4) == MrBackdrop.KIND_GLASS && MrBackdrop.kindOf(99) == MrBackdrop.KIND_GRADIENT && MrBackdrop.STYLE_COLORS.length == MrBackdrop.PRESETS
                        && MrBackdrop.STYLE_COLORS[12].length == 3 && MrBackdrop.STYLE_COLORS[7].length == 1);
        boolean spectra = true;
        for (int i = 0; i < MrBackdrop.STYLES; i++) {
            boolean own = MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_start") != 0;
            boolean ownColour = MrBackdrop.isOwnStyle(i);
            if (own != (ownColour || MrBackdrop.kindOf(i) == MrBackdrop.KIND_GRADIENT)) spectra = false;
            if (own && !ownColour) {
                int[] hues = MrBackdrop.STYLE_COLORS[i];
                spectra &= MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_start") == hues[0] && MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_mid") == hues[1]
                        && MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_end") == hues[2] && MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "glow") != 0;
            }
            if (ownColour) {
                // the colour of the person's own styles is moved at run time: the theme says only the one its drawables are written in, and the light of the labels is the gradient's alone
                boolean light = MrBackdrop.kindOf(i) == MrBackdrop.KIND_GRADIENT;
                spectra &= MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_start") == MrBackdrop.OWN_DEFAULT && MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_mid") == MrBackdrop.OWN_DEFAULT
                        && MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "spectrum_end") == MrBackdrop.OWN_DEFAULT && (MrThemeColors.own(c, MrBackdrop.STYLE_TAGS[i], "glow") >>> 24 != 0) == light;
            }
        }
        check("only the gradient styles and the three of the colour the person picks have the roles of a spectrum (the hues of the dialog are the ones of the theme; the own ones say the hue their drawables are written in); no other theme says them itself, and an unknown one nothing",
                spectra && MrThemeColors.own(c, "mr_midnight", "spectrum_start") == 0 && MrThemeColors.own(c, null, "spectrum_start") == 0 && MrThemeColors.own(c, "mr_aurora", "spectrum_start") != 0);
        boolean exist = true;
        for (int i = 0; i < MrBackdrop.STYLES; i++) if (MrThemeColors.indexOfTag(tags, MrBackdrop.STYLE_TAGS[i]) < 13) exist = false;
        check("every style is a theme that exists, hidden", exist);
        MrBackdrop.Spec lightColour = MrBackdrop.Spec.color(1), darkColour = MrBackdrop.Spec.color(4), landscape = MrBackdrop.Spec.scene(0);
        check("a background has the theme of the style asked: a gradient, a landscape, a picture and a dark colour take it, and the style is kept inside the eighteen",
                MrBackdrop.themeTag(landscape, 3).equals("mr_overmint") && MrBackdrop.themeTag(MrBackdrop.Spec.gradient(2), 4).equals("mr_overshade") && MrBackdrop.themeTag(darkColour, 5).equals("mr_overline")
                        && MrBackdrop.themeTag(MrBackdrop.Spec.image(100, 0, 0, 1), 1).equals("mr_overice") && MrBackdrop.themeTag(landscape, 99).equals("mr_overowngrad")
                        && MrBackdrop.themeTag(landscape, -3).equals(MrBackdrop.TAG_LIGHT_INK) && MrBackdrop.themeTag(landscape).equals(MrBackdrop.TAG_LIGHT_INK));
        check("a light colour has the theme with dark ink whatever the style (its keys have no styles)", MrBackdrop.themeTag(lightColour, 4).equals(MrBackdrop.TAG_DARK_INK) && MrBackdrop.themeTag(lightColour).equals(MrBackdrop.TAG_DARK_INK));
        check("the styles are offered for every background but a light colour, and for no background", MrBackdrop.hasStyles(darkColour) && MrBackdrop.hasStyles(landscape) && MrBackdrop.hasStyles(MrBackdrop.Spec.gradient(0))
                && MrBackdrop.hasStyles(MrBackdrop.Spec.image(100, 0, 0, 1)) && !MrBackdrop.hasStyles(lightColour) && !MrBackdrop.hasStyles(MrBackdrop.Spec.NO) && !MrBackdrop.hasStyles(null));
        check("the style of a theme is read back from its tag, and 0 for any other theme", MrBackdrop.styleOf("mr_overice") == 1 && MrBackdrop.styleOf("mr_overline") == 5 && MrBackdrop.styleOf("mr_overlagoon") == 14 && MrBackdrop.styleOf(MrBackdrop.TAG_LIGHT_INK) == 0
                && MrBackdrop.styleOf("mr_midnight") == 0 && MrBackdrop.styleOf(MrBackdrop.TAG_DARK_INK) == 0 && MrBackdrop.styleOf(null) == 0);
        check("hidden is by the tag, and no theme of the list is hidden", MrThemeColors.hidden("mr_overlight") && !MrThemeColors.hidden("mr_midnight") && !MrThemeColors.hidden(null) && !MrThemeColors.hidden(""));
        check("indexOfTag finds a theme by its tag, and -1 for any other", MrThemeColors.indexOfTag(tags, "mr_midnight") == 0 && MrThemeColors.indexOfTag(tags, "mr_overdark") == 14
                && MrThemeColors.indexOfTag(tags, "mr_nothing") == -1 && MrThemeColors.indexOfTag(tags, null) == -1);
        check("listed counts all of them when none is hidden", MrThemeColors.listed(new String[] {"mr_a", "mr_b"}) == 2 && MrThemeColors.listed(new String[0]) == 0);
        check("the first theme is Midnight Steel and the second Aurora", names[0].equals("Midnight Steel") && names[1].equals("Aurora") && tags[0].equals("mr_midnight"));
        check("indexOf finds a value, and anything else is the first theme", MrThemeColors.indexOf(values, "7") == 7 && MrThemeColors.indexOf(values, "12") == 12
                && MrThemeColors.indexOf(values, "x") == 0 && MrThemeColors.indexOf(values, "") == 0);
        check("the values are the position of the theme when the list is not as long as the themes", MrThemeColors.values(new Ctx() {
            public Resources getResources() {
                return new Res() {
                    public String[] getStringArray(int id) {
                        return "keyboard_layout_modes_values".equals(name(id)) ? new String[] {"a"} : super.getStringArray(id);
                    }
                };
            }
        })[12].equals("12"));
        check("a phone that gives no array gives empty lists", MrThemeColors.tags(new Ctx() {
            public Resources getResources() { return new Resources() { }; }
        }).length == 0);

        boolean all = true;
        for (String tag : tags) {
            for (String role : ROLES) {
                if (MrThemeColors.color(c, tag, role) == MrThemeColors.NONE) {
                    all = false;
                    System.out.println("      " + tag + " has no " + role);
                }
            }
        }
        boolean faceColours = true;
        for (String tag : tags) {
            for (String pre : new String[] {"key_normal_", "key_acc_normal_"}) {
                if (MrThemeColors.color(c, tag, pre + "fill") == MrThemeColors.NONE && MrThemeColors.color(c, tag, pre + "top") == MrThemeColors.NONE) {
                    faceColours = false;
                    System.out.println("      " + tag + " has neither " + pre + "fill nor " + pre + "top");
                }
            }
        }
        check("every theme has the colours that the small keyboard uses (background, text, accent text)", all);
        check("and the colours of its key faces, as a fill or as the top of a gradient (what the flat faces are drawn with)", faceColours);
        check("a colour of a theme is the one of its own entry", MrThemeColors.color(c, "mr_midnight", "kbd_bg") == 0xff171e27 && MrThemeColors.color(c, "mr_midnight", "text") == 0xffe7eef7);
        check("a role that the theme does not say is the shared one, and null asks for the shared ones",
                MrThemeColors.color(c, "mr_midnight", "accent") == 0xff1b97fc && MrThemeColors.color(c, null, "accent") == 0xff1b97fc);
        check("a role that nothing has is NONE, colorOr gives the fallback", MrThemeColors.color(c, "mr_midnight", "no_such_role") == MrThemeColors.NONE
                && MrThemeColors.colorOr(c, "mr_midnight", "no_such_role", 0xff123456) == 0xff123456 && MrThemeColors.colorOr(c, "mr_midnight", "text", 0) == 0xffe7eef7);
        check("a theme that does not exist has the shared colours", MrThemeColors.color(c, "mr_nothing", "accent") == 0xff1b97fc);
        check("a phone that fails answers NONE", MrThemeColors.color(new Ctx() {
            public Resources getResources() { throw new RuntimeException("no resources"); }
        }, "mr_midnight", "text") == MrThemeColors.NONE);
        check("declared: a role that every theme leaves clear (the glow) is 0, the one of a neon theme is its colour",
                MrThemeColors.declared(c, "mr_midnight", "glow") == 0 && MrThemeColors.declared(c, "mr_cyan", "glow") != 0 && MrThemeColors.declared(c, "mr_midnight", "no_such_role") == 0);

        StringBuilder row = new StringBuilder();
        boolean[] dark = new boolean[32];
        for (int i = 0; i < 32; i++) {
            dark[i] = MrThemeColors.dark(c, tags[i]);
            row.append(tags[i].substring(3)).append(dark[i] ? "=dark " : "=light ");
        }
        System.out.println("      " + row);
        boolean[] want = new boolean[32];
        java.util.Arrays.fill(want, true);
        want[6] = want[7] = want[8] = want[10] = want[14] = false;
        check("a theme is dark when its background is: the nine of dark background (Chrome, with dark letters on its keys, and Glass and Denim, which are see-through, among them), not Aqua, Sky, Snow and Rose; of the nineteen of the backgrounds the one with dark ink is light and the eighteen with light ink (the styles of the keys) are dark",
                java.util.Arrays.equals(dark, want));
        int toolInk = MrThemeColors.declared(c, "mr_chrome", "tool_ink");
        check("Chrome, whose keys and background are of opposite brightness, has the ink of its toolbar from tool_ink (light), though its key letters are dark", toolInk != 0
                && MrThemeColors.luminance(toolInk) > 0.5f && MrThemeColors.ink(c, "mr_chrome") == (0xff000000 | toolInk) && MrThemeColors.luminance(MrThemeColors.color(c, "mr_chrome", "text")) < 0.2f);
        check("Sky has pale letters on a light background: it is a light theme, whatever its ink", !dark[7] && MrThemeColors.luminance(MrThemeColors.ink(c, "mr_sky")) > 0.5f);
        int lightText = MrThemeColors.color(c, "mr_overlight", "text"), darkText = MrThemeColors.color(c, "mr_overdark", "text");
        check("the theme of the backgrounds with light ink has white letters and the one with dark ink has dark letters", MrThemeColors.luminance(lightText) > 0.9f && MrThemeColors.luminance(darkText) < 0.2f
                && MrThemeColors.ink(c, "mr_overlight") == lightText && MrThemeColors.ink(c, "mr_overdark") == darkText);
        boolean glassKeys = true;
        for (String tag : new String[] {"mr_overlight", "mr_overdark"}) {
            for (String role : new String[] {"key_normal_fill", "key_pressed_fill", "key_on_fill", "key_lock_fill", "key_acc_normal_fill", "key_acc_pressed_fill", "key_acc_on_fill", "key_acc_lock_fill"}) {
                int col = MrThemeColors.color(c, tag, role);
                // the accent keys (shift, delete, enter...) are the same as the letters in every state
                if (role.startsWith("key_acc_") && col != MrThemeColors.color(c, tag, "key_" + role.substring(8))) glassKeys = false;
                if (role.endsWith("lock_fill")) continue; // a locked key (caps lock) is tinted red, not white
                int alpha = col >>> 24;
                // see-through: the keys are a veil of white (or of black, on a light colour), never a solid face
                if (col == MrThemeColors.NONE || alpha == 0 || alpha > 0x80) glassKeys = false;
                int rgb = col & 0xffffff;
                if (rgb != (tag.equals("mr_overlight") ? 0xffffff : 0x000000)) glassKeys = false;
            }
        }
        check("on a colour, a gradient, a landscape or a picture the keys are all the same: a translucent white (translucent black on a light colour), none of them solid",
                glassKeys && MrThemeColors.color(c, "mr_overlight", "key_normal_fill") == 0x38ffffff);
        check("the key letters are not the colour of the key: the ink is what changes between the two themes of the backgrounds",
                MrThemeColors.color(c, "mr_overlight", "key_normal_fill") != MrThemeColors.color(c, "mr_overdark", "key_normal_fill") && lightText != darkText);
        check("a theme without tool ink uses the text of its keys", MrThemeColors.ink(c, "mr_midnight") == MrThemeColors.color(c, "mr_midnight", "text"));
        check("the brightness: black 0, white 1, green more than red more than blue", MrThemeColors.luminance(0xff000000) == 0f && near(MrThemeColors.luminance(0xffffffff), 1f, 0.001f)
                && MrThemeColors.luminance(0xff00ff00) > MrThemeColors.luminance(0xffff0000) && MrThemeColors.luminance(0xffff0000) > MrThemeColors.luminance(0xff0000ff));

        boolean faces = true;
        for (String tag : tags) if (MrThemeColors.keyDrawable(c, tag, false) == 0 || MrThemeColors.keyDrawable(c, tag, true) == 0) faces = false;
        check("every theme has its key face and its accent key face", faces);
        check("no tag, or a theme that has no face, gives 0", MrThemeColors.keyDrawable(c, null, false) == 0 && MrThemeColors.keyDrawable(c, "mr_nothing", false) == 0);
    }

    // ---------------------------------------------------------------- one small keyboard

    static void previews() throws Exception {
        reset();
        Context c = new Ctx();
        MrThemePreview p = preview(c, 360);
        check("a preview is as tall as the keyboard is for its width (shape 2.4)", p.getWidth() == 360 && p.getHeight() == 150);
        String[] tags = MrThemeColors.tags(c);

        Face.originals = 0;
        Face.copies = 0;
        KeyStyle.stubPrepared.clear();
        KeyStyle.stubDrawn.clear();
        p.show(tags[0], MrBackdrop.Spec.NO, null, 0);
        Canvas cv = new Canvas(bitmap(360, 150));
        p.onDraw(cv);
        int letters = 0;
        for (String t : cv.stubTexts) if (t.length() > 0 && t.indexOf('|') == 1 && Character.isLetter(t.charAt(0))) letters++;
        check("it draws the 26 letters, shift, delete, ?123, the comma, the point and enter (and the space has no label)", cv.stubTexts.size() == 32 && letters == 26);
        check("33 key faces are made ready and drawn: 26 letters, shift, delete, ?123, comma, space, point and enter", KeyStyle.stubPrepared.size() == 33 && KeyStyle.stubDrawn.size() == 33);
        check("the faces are copies of the drawables of the theme (the ones that the keyboard uses are not touched): two copies, one for the keys and one for the accent key",
                Face.copies == 2 && Face.originals == 2);
        p.onDraw(new Canvas(bitmap(360, 150)));
        check("drawn again it makes no new copies", Face.copies == 2 && p.drawn() == 2);
        p.show(tags[1], MrBackdrop.Spec.NO, null, 0);
        p.onDraw(new Canvas(bitmap(360, 150)));
        check("another theme makes its own", Face.copies == 4);
        p.show(tags[1], MrBackdrop.Spec.scene(1), scene(1), 20);
        p.onDraw(new Canvas(bitmap(360, 150)));
        check("another background of the same theme does not", Face.copies == 4);

        // the neon light and the labels
        p.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        cv = new Canvas(bitmap(360, 150));
        p.onDraw(cv);
        boolean none = true;
        for (String t : cv.stubTexts) if (!t.endsWith("|0.0|0")) none = false;
        p.show("mr_cyan", MrBackdrop.Spec.NO, null, 0);
        cv = new Canvas(bitmap(360, 150));
        p.onDraw(cv);
        boolean light = true;
        for (String t : cv.stubTexts) if (t.endsWith("|0.0|0") || !t.contains("|10.0|")) light = false;
        check("a theme without the neon flag has no light round its labels, a neon theme has it on every one", none && light);
        check("the labels are drawn in the text colour of the theme", cv.stubGlyphs.get(0).endsWith("#" + Integer.toHexString(MrThemeColors.color(c, "mr_cyan", "text"))));

        // the ring and the check mark
        RES.flatFaces = true;
        p = preview(c, 360);
        p.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        check("not chosen by default", !p.checked());
        Bitmap plain = draw(p);
        p.setChecked(true, 0xff00cc66, 0xffffffff);
        Bitmap ringed = draw(p);
        check("the ring is drawn round the chosen one, with the round badge in the corner",
                p.checked() && maxDiff(ringed.getPixel(180, 1), 0xff00cc66) <= 2 && maxDiff(ringed.getPixel(180, 148), 0xff00cc66) <= 2
                        && maxDiff(ringed.getPixel(330 - 14, 30), 0xff00cc66) <= 2 && ringed.getPixel(180, 1) != plain.getPixel(180, 1));
        check("the check mark inside the badge is in the check colour", containsColour(ringed, 316, 16, 344, 44, 0xffffffff));
        p.setChecked(false, 0xff00cc66, 0xffffffff);
        check("not chosen again: the ring is gone", java.util.Arrays.equals(draw(p).stubPixels, plain.stubPixels));
        // the corners are rounded
        check("the corners of the view are rounded (the very corner is clear), the middle of the edge is not", plain.getPixel(0, 0) >>> 24 == 0 && plain.getPixel(180, 0) >>> 24 == 255);

        // the tile that adds a picture
        MrThemePreview plus = preview(c, 360);
        plus.showPlus(0xff202830, 0xff405060, 0xff80c0ff);
        Bitmap pb = draw(plus);
        check("the tile of the gallery is a plain face with a plus in the middle", maxDiff(pb.getPixel(10, 75), 0xff202830) <= 2 && maxDiff(pb.getPixel(180, 75), 0xff80c0ff) <= 2
                && maxDiff(pb.getPixel(180, 55), 0xff80c0ff) <= 2 && maxDiff(pb.getPixel(120, 30), 0xff202830) <= 2);
        plus.setChecked(true, 0xff00cc66, 0xffffffff);
        check("and gets the ring when it is the choice", maxDiff(draw(plus).getPixel(180, 1), 0xff00cc66) <= 2);

        // the keyboard that is as wide as the narrow side of the phone, not of the screen turned
        RES.dm.widthPixels = 2400;
        RES.dm.heightPixels = 1080;
        MrThemePreview turned = preview(c, 360);
        turned.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        Bitmap tb = draw(turned);
        RES.dm.widthPixels = 1080;
        RES.dm.heightPixels = 2400;
        MrThemePreview upright = preview(c, 360);
        upright.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        check("a screen that is turned (2400 x 1080) gives the same preview as the one upright", java.util.Arrays.equals(tb.stubPixels, draw(upright).stubPixels));

        // measure with no width
        MrThemePreview none0 = new MrThemePreview(c);
        none0.onMeasure(View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED), 0);
        none0.onDraw(new Canvas(bitmap(10, 10)));
        check("a view that was not laid out draws nothing and does not fail", none0.stubMeasuredHeight() == 0 && none0.drawn() == 0);
        RES.flatFaces = false;
    }

    /** WCAG relative luminance of a colour (linear light). */
    static double linear(int argb) {
        double[] v = new double[3];
        for (int i = 0; i < 3; i++) {
            double x = channel(argb, 16 - 8 * i) / 255.0;
            v[i] = x <= 0.03928 ? x / 12.92 : Math.pow((x + 0.055) / 1.055, 2.4);
        }
        return 0.2126 * v[0] + 0.7152 * v[1] + 0.0722 * v[2];
    }

    /** The colour of a letter key of the preview (the middle of the "q" key, in the first row of keys). */
    static int keyPixel(Bitmap b, int w) {
        return b.getPixel(Math.round(w * 0.054f), Math.round(b.stubH * 0.274f));
    }

    static boolean containsColour(Bitmap b, int x0, int y0, int x1, int y1, int argb) {
        for (int y = y0; y < y1; y++) for (int x = x0; x < x1; x++) if (maxDiff(b.getPixel(x, y), argb) <= 4 && (b.getPixel(x, y) >>> 24) == 255) return true;
        return false;
    }

    static void previewPictures() throws Exception {
        reset();
        RES.flatFaces = true;
        Context c = new Ctx();
        String[] tags = MrThemeColors.tags(c);
        List<Bitmap> sheet = new ArrayList<Bitmap>();
        List<Bitmap> small = new ArrayList<Bitmap>();
        int listed = MrThemeColors.listed(tags);
        for (int i = 0; i < listed; i++) {
            MrThemePreview p = preview(c, 420);
            p.show(tags[i], MrBackdrop.Spec.NO, null, 0);
            sheet.add(draw(p));
            if (i == 4) p.setChecked(true, 0xff1b97fc, 0xffffffff);
        }
        sheet(sheet, 3, "themes");
        // the colour of the theme is the background that every one shows
        boolean bg = true;
        for (int i = 0; i < listed; i++) {
            int expect = MrThemeColors.color(c, tags[i], "kbd_bg");
            Bitmap b = sheet.get(i);
            if (maxDiff(b.getPixel(3, 74), expect) > 12 && maxDiff(b.getPixel(210, 4), expect) > 12) {
                bg = false;
                System.out.println("      " + tags[i] + ": " + Integer.toHexString(b.getPixel(210, 4)) + " expected about " + Integer.toHexString(expect));
            }
        }
        check("with no background every preview shows the colour of its theme behind the keys", bg);

        // the backgrounds, each in the theme that suits it (light ink, or dark ink on the light colours)
        List<MrBackdrop.Spec> all = new ArrayList<MrBackdrop.Spec>();
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) all.add(MrBackdrop.Spec.color(i));
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) all.add(MrBackdrop.Spec.gradient(i));
        for (int i = 0; i < MrScenes.COUNT; i++) all.add(MrBackdrop.Spec.scene(i));
        String[] groups = {"colors", "gradients", "scenes"};
        int[][] ranges = {{0, MrBackdrop.COLORS.length}, {MrBackdrop.COLORS.length, MrBackdrop.COLORS.length + MrBackdrop.GRADIENT_COUNT},
                {MrBackdrop.COLORS.length + MrBackdrop.GRADIENT_COUNT, all.size()}};
        for (int g = 0; g < groups.length; g++) {
            List<Bitmap> t = new ArrayList<Bitmap>();
            for (int i = ranges[g][0]; i < ranges[g][1]; i++) {
                MrThemePreview p = preview(c, 330);
                p.show(MrBackdrop.themeTag(all.get(i)), all.get(i), imageFor(all.get(i)), 0);
                t.add(draw(p));
            }
            sheet(t, 3, "backgrounds_" + groups[g]);
        }
        // the same keyboard of a named theme is never changed by a background: the preview of a theme has no background, whatever the preferences hold
        prefs.edit().putString(MrBackdrop.PREF, "g3").apply();
        MrThemePreview iso = preview(c, 330), isoClean = preview(c, 330);
        iso.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        isoClean.show("mr_midnight", MrBackdrop.Spec.NO, null, 0);
        check("a theme of the list drawn as itself is the same whatever background is chosen", java.util.Arrays.equals(draw(iso).stubPixels, draw(isoClean).stubPixels));
        prefs.edit().putString(MrBackdrop.PREF, "").apply();

        // on a colour the keys are one translucent white (or black) that lets the colour through, and only the ink is told apart
        boolean glass = true;
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) {
            MrBackdrop.Spec sp = MrBackdrop.Spec.color(i);
            MrThemePreview p = preview(c, 600);
            p.show(MrBackdrop.themeTag(sp), sp, null, 0);
            Bitmap b = draw(p);
            // the middle of the gap between keys is the colour itself; the middle of a letter key is that colour with the veil of the key over it
            int gap = b.getPixel(3, 74), key = keyPixel(b, 600);
            if (gap != MrBackdrop.COLORS[i]) {
                glass = false;
                System.out.println("      colour " + i + ": the gap is " + Integer.toHexString(gap));
            }
            int veil = MrThemeColors.color(c, MrBackdrop.themeTag(sp), "key_normal_fill");
            int expect = MrBackdrop.mix(MrBackdrop.COLORS[i], veil | 0xff000000, (veil >>> 24) / 255f);
            if (maxDiff(key, expect) > 6) {
                glass = false;
                System.out.println("      colour " + i + ": a key is " + Integer.toHexString(key) + ", expected about " + Integer.toHexString(expect));
            }
        }
        check("on every colour the gap is the colour as it is and a key is that colour with a translucent white (or black) over it", glass);

        // the veil keeps the bar readable: the ink of the toolbar against the background behind it
        boolean contrast = true;
        double worstRatio = 99, worstKey = 99;
        {
            List<MrBackdrop.Spec> specs = all;
            for (MrBackdrop.Spec s : specs) {
              for (int style = 0; style < (MrBackdrop.hasStyles(s) ? MrBackdrop.STYLES : 1); style++) {
                String tag = MrBackdrop.themeTag(s, style);
                int ink = MrThemeColors.ink(c, tag);
                MrThemePreview p = preview(c, 600);
                p.show(tag, s, imageFor(s), 0);
                Bitmap b = draw(p);
                // the bar is the top 17% of the keyboard: the background there, without the bars of the suggestions (WCAG contrast, on linear light)
                double sum = 0;
                int n = 0;
                for (int y = 4; y < 20; y += 2) {
                    for (int x = 6; x < 594; x += 4) {
                        sum += linear(b.getPixel(x, y));
                        n++;
                    }
                }
                double bgLum = sum / n;
                double inkLum = linear(ink);
                double ratio = (Math.max(bgLum, inkLum) + 0.05) / (Math.min(bgLum, inkLum) + 0.05);
                worstRatio = Math.min(worstRatio, ratio);
                if (ratio < 3.0) {
                    contrast = false;
                    System.out.println("      " + tag + " " + s.format() + ": contrast " + String.format("%.2f", ratio));
                }
                // the letters of the keys: the ink against the key (the background with the glass over it) must be readable too
                int keyCol = MrThemeColors.color(c, tag, "key_normal_fill");
                int under = MrBackdrop.mix(0xff000000 | (int) Math.round(255 * Math.pow(bgLum, 1 / 2.2)) * 0x010101, keyCol | 0xff000000, (keyCol >>> 24) / 255f);
                double keyLum = linear(under), letter = linear(MrThemeColors.color(c, tag, "text"));
                double keyRatio = (Math.max(keyLum, letter) + 0.05) / (Math.min(keyLum, letter) + 0.05);
                worstKey = Math.min(worstKey, keyRatio);
                if (keyRatio < 2.5) {
                    contrast = false;
                    System.out.println("      " + tag + " " + s.format() + ": the letters on the keys have a contrast of " + String.format("%.2f", keyRatio));
                }
              }
            }
        }
        System.out.println("      the worst contrast of the ink of the toolbar with the bar: " + String.format("%.2f", worstRatio) + ", of the letters with their keys: " + String.format("%.2f", worstKey));
        check("over every colour, gradient and landscape the ink of the toolbar keeps a contrast of 3 or more with the bar, and the letters of the keys one of 2.5 or more with their glass keys", contrast);

        // a picture of the gallery
        Bitmap ph = photo(800, 500);
        List<Bitmap> t = new ArrayList<Bitmap>();
        int[][] views = {{100, 0, 0}, {200, 0, 0}, {200, -100, -100}, {300, 100, 100}, {100, 0, 0}, {400, 40, -30}};
        for (int i = 0; i < views.length; i++) {
            MrThemePreview p = preview(c, 360);
            p.show(MrBackdrop.TAG_LIGHT_INK, MrBackdrop.Spec.image(views[i][0], views[i][1], views[i][2], 1), ph, i == 4 ? 0 : 20);
            t.add(draw(p));
        }
        sheet(t, 3, "picture");
        Bitmap hit = t.get(2);
        check("the picture is under the keys (the frame of its upper left corner shows in the corner of the preview, softened by the veil)",
                MrThemeColors.luminance(hit.getPixel(30, 2)) > 0.2f);
        // the same picture of the same theme and background is drawn from the copy that it kept
        MrThemePreview q = preview(c, 360);
        q.show(MrBackdrop.TAG_LIGHT_INK, MrBackdrop.Spec.image(100, 0, 0, 1), ph, 0);
        Bitmap one = draw(q), two = draw(q);
        check("drawn again it is the same", java.util.Arrays.equals(one.stubPixels, two.stubPixels));
        q.show(MrBackdrop.TAG_LIGHT_INK, MrBackdrop.Spec.image(100, 0, 0, 1), null, 0);
        Bitmap without = draw(q);
        check("a picture spec whose picture is not loaded yet shows the colour of the theme", maxDiff(without.getPixel(210, 4), MrThemeColors.color(c, MrBackdrop.TAG_LIGHT_INK, "kbd_bg")) <= 12);
        RES.flatFaces = false;
    }

    // ---------------------------------------------------------------- the complete keyboard and the dash

    static MrThemePreview fullPreview(Context c, int w) {
        MrThemePreview p = new MrThemePreview(c);
        p.setFull(true);
        p.onMeasure(View.MeasureSpec.makeMeasureSpec(w, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
        p.stubSize(w, p.stubMeasuredHeight());
        return p;
    }

    /** The colour {@code top} at the opacity {@code a} over the opaque {@code under}. */
    static int blend(int top, float a, int under) {
        int r = Math.round(((top >> 16) & 0xff) * a + ((under >> 16) & 0xff) * (1f - a)), g = Math.round(((top >> 8) & 0xff) * a + ((under >> 8) & 0xff) * (1f - a));
        int bl = Math.round((top & 0xff) * a + (under & 0xff) * (1f - a));
        return 0xff000000 | (r << 16) | (g << 8) | bl;
    }

    /** Whether the pixel at {@code at} is the dash 'off' of a theme of the backgrounds: its colour at the share of opacity that the faint dash has, over the face just above it. */
    static boolean faintDash(Bitmap b, int[] at, int off) {
        int face = b.getPixel(at[0], at[1] - 9);
        return maxDiff(b.getPixel(at[0], at[1]), blend(off, MrKeyLook.DASH_OFF_SHARE, face)) <= 4;
    }

    /** The middle of the dash of a key of the complete keyboard (row 0 .. 5, the left edge and the width of the key as a share of the width of the keys) on a view {@code w} wide. */
    static int[] dashAt(int w, int row, float leftShare, float widthShare) {
        float vw = 1080f, vh = vw / MrThemePreview.FULL_ASPECT, k = w / vw;
        float top = vh * MrThemePreview.FULL_BAR_SHARE, rowH = (vh - top) / 6f, side = vw * 0.008f, width = vw - 2f * side;
        float kx = side + width * leftShare, kw = width * widthShare;
        float density = 2f;
        float y = top + row * rowH + Math.round(rowH) - 8f * density - 1.5f * density;
        return new int[] {Math.round((kx + kw / 2f) * k), Math.round(y * k)};
    }

    static void fullKeyboard() throws Exception {
        reset();
        RES.flatFaces = true;
        Context c = new Ctx();
        MrThemePreview small = preview(c, 600);
        check("a keyboard preview is the small one until it is told otherwise: 2.4 to 1, and it is not full", !small.full() && small.getHeight() == Math.round(600 / MrBackdrop.ASPECT));
        MrThemePreview p = fullPreview(c, 600);
        check("the complete keyboard is taller: 1.7 to 1", p.full() && p.getHeight() == Math.round(600 / MrThemePreview.FULL_ASPECT) && p.getHeight() > small.getHeight() * 1.3);
        p.setFull(false);
        check("and goes back to the small one", !p.full());
        p.setFull(true);

        // the dash of the modifier keys at rest, in the colour of the theme: under Ctrl, Alt and Shift only (Tab, the arrows and F1 have none)
        for (String tag : new String[] {MrBackdrop.TAG_LIGHT_INK, MrBackdrop.TAG_DARK_INK}) {
            MrBackdrop.Spec sp = tag.equals(MrBackdrop.TAG_LIGHT_INK) ? MrBackdrop.Spec.color(5) : MrBackdrop.Spec.color(1);
            p = fullPreview(c, 720);
            p.show(tag, sp, null, 0);
            Bitmap b = draw(p);
            int off = MrThemeColors.color(c, tag, "modifier_indicator_off"), on = MrThemeColors.color(c, tag, "modifier_indicator_on"), lock = MrThemeColors.color(c, tag, "modifier_indicator_lock");
            int[] ctrl = dashAt(720, 0, 0f, 14.2f / 100.4f), alt = dashAt(720, 0, 14.2f / 100.4f, 13.2f / 100.4f), shift = dashAt(720, 4, 0f, 0.15f), f1 = dashAt(720, 5, 0.20f, 0.10f);
            int[] tab = dashAt(720, 0, (14.2f + 13.2f) / 100.4f, 13.3f / 100.4f), arrow = dashAt(720, 0, (14.2f + 13.2f + 13.3f + 10.2f) / 100.4f, 13.1f / 100.4f), arrowR = dashAt(720, 0, (14.2f + 13.2f + 13.3f + 10.2f + 13.1f + 13.1f) / 100.4f, 13.1f / 100.4f);
            int[] plain = dashAt(720, 1, 0f, 0.10f), angle = dashAt(720, 0, (14.2f + 13.2f + 13.3f) / 100.4f, 10.2f / 100.4f), letter = dashAt(720, 2, 0f, 0.10f);
            check(tag + ": Ctrl, Alt and Shift have the dash 'off', faint (the keyboard at rest: nothing lit, nothing locked; a hint that does not draw the eye)",
                    faintDash(b, ctrl, off) && faintDash(b, alt, off) && faintDash(b, shift, off));
            check(tag + ": Tab, the arrows and F1 have no dash", !faintDash(b, tab, off) && !faintDash(b, arrow, off) && !faintDash(b, arrowR, off) && !faintDash(b, f1, off));
            check(tag + ": the keys that are not modifier keys have no dash (a number, a letter and the key of the angles)", !faintDash(b, plain, off) && b.getPixel(plain[0], plain[1]) != on
                    && !faintDash(b, letter, off) && !faintDash(b, angle, off) && b.getPixel(angle[0], angle[1]) != on);
            check(tag + ": the three dashes are three different colours", on != off && on != lock && off != lock);
            Bitmap compact = draw(preview(c, 720));
            check(tag + ": the small keyboard has no dash (it has no modifier keys)", compact.getPixel(ctrl[0], Math.round(compact.stubH * 0.9f)) != on);
        }

        // the keys are drawn at rest: Ctrl is the same face as Alt, and Shift is the same face as delete (no lit key, no red lock)
        MrThemePreview q = fullPreview(c, 720);
        q.show(MrBackdrop.TAG_LIGHT_INK, MrBackdrop.Spec.color(5), null, 0);
        Bitmap qb = draw(q);
        float vw = 1080f, vh = vw / MrThemePreview.FULL_ASPECT, k = 720 / vw, top = vh * MrThemePreview.FULL_BAR_SHARE, rowH = (vh - top) / 6f;
        int ctrlFace = qb.getPixel(Math.round(30 * k), Math.round((top + rowH * 0.25f) * k));
        int altFace = qb.getPixel(Math.round((8.64f + 1062.7f * 0.142f / 1.004f + 30) * k), Math.round((top + rowH * 0.25f) * k));
        int shiftFace = qb.getPixel(Math.round(30 * k), Math.round((top + 4 * rowH + rowH * 0.25f) * k));
        int deleteFace = qb.getPixel(Math.round((8.64f + 1062.7f * 0.85f + 30) * k), Math.round((top + 4 * rowH + rowH * 0.25f) * k));
        check("Ctrl is not lit (it is the face of Alt) and Shift is not red (it is the face of delete)",
                maxDiff(ctrlFace, altFace) <= 6 && maxDiff(shiftFace, deleteFace) <= 6);
        // every key of the complete keyboard is there: the row of Ctrl, Alt and the arrows, the numbers, three rows of letters and the bottom row
        boolean rows = true;
        for (int r = 0; r < 6; r++) {
            int yy = Math.round((top + r * rowH + rowH * 0.2f) * k);
            // along the row, most of the width is key faces (lighter than the colour behind them) and the rest the gaps between them
            int faces = 0;
            for (int x = 6; x < 714; x += 6) if (maxDiff(qb.getPixel(x, yy), MrBackdrop.COLORS[5]) > 8) faces++;
            if (faces < 60) {
                rows = false;
                System.out.println("      row " + r + ": " + faces + " of 118 samples are key faces");
            }
        }
        check("the six rows of keys are all drawn", rows);
        // the line of suggestions is above them, in the ink of the toolbar
        int ink = MrThemeColors.ink(c, MrBackdrop.TAG_LIGHT_INK);
        boolean words = false;
        for (int y = 0; y < Math.round(top * k) && !words; y++) for (int x = 0; x < 720 && !words; x++) if (maxDiff(qb.getPixel(x, y), MrBackdrop.mix(MrBackdrop.COLORS[5], ink | 0xff000000, 0.70f)) <= 6) words = true;
        check("the line of suggestions is on top, in the ink of the toolbar", words);

        // on every background of the backgrounds the dash reads over the faces
        boolean reads = true;
        double worstOn = 99, worstLock = 99, worstOff = 99;
        for (int t = 0; t < 1 + MrBackdrop.STYLES; t++) {
            String tag = t == 0 ? MrBackdrop.TAG_DARK_INK : MrBackdrop.STYLE_TAGS[t - 1];
            int off = MrThemeColors.color(c, tag, "modifier_indicator_off") | 0xff000000, on = MrThemeColors.color(c, tag, "modifier_indicator_on") | 0xff000000;
            int lock = MrThemeColors.color(c, tag, "modifier_indicator_lock") | 0xff000000;
            int fNormal = MrThemeColors.color(c, tag, "key_normal_fill"), fOn = MrThemeColors.color(c, tag, "key_on_fill"), fLock = MrThemeColors.color(c, tag, "key_lock_fill");
            List<Integer> backs = new ArrayList<Integer>();
            for (int i = 0; i < MrBackdrop.COLORS.length; i++) if (MrBackdrop.themeTag(MrBackdrop.Spec.color(i), t - 1).equals(tag)) backs.add(MrBackdrop.COLORS[i]);
            if (t > 0) for (MrBackdrop.Grad g : MrBackdrop.GRADS) for (int col : g.colours) backs.add(col);
            for (int bgc : backs) {
                int a = MrBackdrop.mix(bgc, fNormal | 0xff000000, (fNormal >>> 24) / 255f), bOn = MrBackdrop.mix(bgc, fOn | 0xff000000, (fOn >>> 24) / 255f);
                int bLock = MrBackdrop.mix(bgc, fLock | 0xff000000, (fLock >>> 24) / 255f);
                double cOn = MrBackdrop.contrast(on, bOn), cLock = MrBackdrop.contrast(lock, bLock), cOff = MrBackdrop.contrast(off, a);
                worstOn = Math.min(worstOn, cOn);
                worstLock = Math.min(worstLock, cLock);
                worstOff = Math.min(worstOff, cOff);
                if (cOn < 2.2 || cLock < 2.2 || cOff < 1.15) {
                    reads = false;
                    System.out.println("      " + tag + " on " + Integer.toHexString(bgc) + ": on " + String.format("%.2f", cOn) + ", lock " + String.format("%.2f", cLock) + ", off " + String.format("%.2f", cOff));
                }
            }
        }
        System.out.println("      the dash over the faces, worst case: on " + String.format("%.2f", worstOn) + ", locked " + String.format("%.2f", worstLock) + ", off " + String.format("%.2f", worstOff));
        check("over every colour and gradient, in each of the themes of the backgrounds (the fifteen styles of keys and the dark ink), the dash 'on' and the dash 'locked' have a contrast of 2.2 or more with the face they are on, and 'off' one of 1.15 or more", reads);

        // the bubble and the popup of variants: the letters read on them, and the popup key is told apart from the bubble
        boolean popups = true;
        for (String tag : new String[] {MrBackdrop.TAG_LIGHT_INK, MrBackdrop.TAG_DARK_INK}) {
            int fill = MrThemeColors.color(c, tag, "bubble_fill"), text = MrThemeColors.color(c, tag, "popup_text"), keyFill = MrThemeColors.color(c, tag, "popup_key_fill"), stroke = MrThemeColors.color(c, tag, "bubble_stroke");
            if ((fill >>> 24) != 255 || (keyFill >>> 24) != 255 || MrBackdrop.contrast(text | 0xff000000, fill) < 7f || MrBackdrop.contrast(text | 0xff000000, keyFill) < 4.5f
                    || MrBackdrop.contrast(keyFill, fill) < 1.3f || MrBackdrop.contrast(stroke, fill) < 1.15f) {
                popups = false;
                System.out.println("      " + tag + ": bubble " + Integer.toHexString(fill) + ", key " + Integer.toHexString(keyFill) + ", text " + Integer.toHexString(text) + ", edge " + Integer.toHexString(stroke));
            }
        }
        check("the popup: opaque, its letters read on the bubble (7 to 1) and on the key that is held (4.5), the key and the edge show against the bubble", popups);
        int dFill = MrThemeColors.color(c, MrBackdrop.TAG_LIGHT_INK, "bubble_fill"), lFill = MrThemeColors.color(c, MrBackdrop.TAG_DARK_INK, "bubble_fill");
        check("light ink has a dark bubble and dark ink a light one (not the grey of before)", MrThemeColors.luminance(dFill) < 0.2f && MrThemeColors.luminance(lFill) > 0.9f);

        // the complete keyboard on a colour, a gradient, a landscape and a light colour (for the eye)
        List<Bitmap> sheet = new ArrayList<Bitmap>();
        MrBackdrop.Spec[] some = {MrBackdrop.Spec.color(5), MrBackdrop.Spec.color(1), MrBackdrop.Spec.color(10), MrBackdrop.Spec.color(14), MrBackdrop.Spec.gradient(3), MrBackdrop.Spec.gradient(17),
                MrBackdrop.Spec.scene(2), MrBackdrop.Spec.scene(20), MrBackdrop.Spec.scene(30)};
        for (MrBackdrop.Spec sp : some) {
            MrThemePreview v = fullPreview(c, 360);
            v.show(MrBackdrop.themeTag(sp), sp, imageFor(sp), 0);
            sheet.add(draw(v));
        }
        sheet(sheet, 3, "full_keyboard");
        // the fifteen styles of the keys, over a landscape that is busy, a gradient and a dark colour (for the eye), and the softening over the landscape
        MrBackdrop.Spec[] over = {MrBackdrop.Spec.scene(2), MrBackdrop.Spec.scene(26), MrBackdrop.Spec.gradient(8), MrBackdrop.Spec.color(5)};
        boolean different = true;
        for (MrBackdrop.Spec sp : over) {
            List<Bitmap> styles = new ArrayList<Bitmap>();
            List<int[]> seen = new ArrayList<int[]>();
            for (int style = 0; style < MrBackdrop.STYLES; style++) {
                MrThemePreview v = fullPreview(c, 360);
                v.show(MrBackdrop.themeTag(sp, style), sp, imageFor(sp), 0);
                Bitmap shown = draw(v);
                styles.add(shown);
                for (int[] before : seen) if (java.util.Arrays.equals(before, shown.stubPixels)) different = false;
                seen.add(shown.stubPixels.clone());
            }
            for (int soft : new int[] {30, 70}) {
                MrThemePreview v = fullPreview(c, 360);
                v.show(MrBackdrop.themeTag(sp, 0), sp, imageFor(sp), soft);
                styles.add(draw(v));
            }
            sheet(styles, 4, "styles_" + sp.format());
            if (sp.kind == MrBackdrop.SCENE || sp.kind == MrBackdrop.GRADIENT) {
                // the same, larger (as the dialog of a phone draws them), for looking at the lines and the letters
                List<Bitmap> big = new ArrayList<Bitmap>();
                for (int style = 0; style < MrBackdrop.STYLES; style++) {
                    MrThemePreview v = fullPreview(c, 600);
                    v.show(MrBackdrop.themeTag(sp, style), sp, imageFor(sp), 0);
                    big.add(draw(v));
                }
                sheet(big, 3, "styles_big_" + sp.format());
            }
        }
        check("the fifteen styles of the keys draw fifteen different keyboards over a landscape, a gradient and a colour", different);
        RES.flatFaces = false;
    }

    // ---------------------------------------------------------------- the colours of the styles of keys, one place at a time

    /** The colour of {@code role} as the keyboard draws it for the key at step {@code step} of a gradient theme (the one of the theme when it has no gradient). */
    static int hueOf(Context c, String tag, String role, int step) {
        int v = MrThemeColors.color(c, tag, role);
        int glow = MrThemeColors.own(c, tag, "glow");
        if (MrThemeColors.own(c, tag, "spectrum_start") == 0 || glow == 0 || step < 0) return v;
        float[] m = MrGlow.remap(glow, MrGlow.ramp(MrThemeColors.own(c, tag, "spectrum_start"), MrThemeColors.own(c, tag, "spectrum_mid"), MrThemeColors.own(c, tag, "spectrum_end"), step / (float) MrGlow.STEPS));
        return MrGlow.map(m, v);
    }

    /** CIE 1976 colour difference (Lab, D65) between two opaque colours: about 2.3 is the least that an eye sees, 10 or more is a clear difference of colour. */
    static double deltaE(int a, int b) {
        double[] x = lab(a), y = lab(b);
        return Math.sqrt((x[0] - y[0]) * (x[0] - y[0]) + (x[1] - y[1]) * (x[1] - y[1]) + (x[2] - y[2]) * (x[2] - y[2]));
    }

    static double[] lab(int argb) {
        double r = linearChannel(channel(argb, 16)), g = linearChannel(channel(argb, 8)), b = linearChannel(channel(argb, 0));
        double x = (0.4124 * r + 0.3576 * g + 0.1805 * b) / 0.95047, y = 0.2126 * r + 0.7152 * g + 0.0722 * b, z = (0.0193 * r + 0.1192 * g + 0.9505 * b) / 1.08883;
        double fx = labF(x), fy = labF(y), fz = labF(z);
        return new double[] {116 * fy - 16, 500 * (fx - fy), 200 * (fy - fz)};
    }

    static double linearChannel(int v) {
        double x = v / 255.0;
        return x <= 0.04045 ? x / 12.92 : Math.pow((x + 0.055) / 1.055, 2.4);
    }

    static double labF(double t) {
        return t > 0.008856 ? Math.cbrt(t) : 7.787 * t + 16.0 / 116;
    }

    /**
     * Every style of keys over every colour, gradient and landscape that can have one, looked at in 120 places of the keyboard (20 along, 6 rows;
     * what is behind a key is the mean of its cell), with the veil of the background as it is without softening: the letters against the key they
     * are on (the key is the background with the face of the style over it, so a see-through key is only as dark as what is behind it: the clear
     * glass, the style that is the reference, has the worst of them in a bright landscape, where the dark outline of the labels does the rest), and
     * the line of an outlined key against what is behind it, as a difference of colour (a line of one hue can be as light as what is behind it and
     * still be seen). A gradient style is looked at with the hue of every place (the letters, the face and the line move together). The worst of each
     * style is printed, and no style may read worse than the reference or draw a line that is lost.
     */
    static void styleAudit() throws Exception {
        reset();
        Context c = new Ctx();
        final int W = 360;
        final int H = Math.round(W / MrThemePreview.FULL_ASPECT);
        float top = H * MrThemePreview.FULL_BAR_SHARE, rowH = (H - top) / 6f;
        List<MrBackdrop.Spec> specs = new ArrayList<MrBackdrop.Spec>();
        for (int i = 0; i < MrBackdrop.COLORS.length; i++) if (MrBackdrop.hasStyles(MrBackdrop.Spec.color(i))) specs.add(MrBackdrop.Spec.color(i));
        for (int i = 0; i < MrBackdrop.GRADIENT_COUNT; i++) specs.add(MrBackdrop.Spec.gradient(i));
        for (int i = 0; i < MrScenes.COUNT; i++) specs.add(MrBackdrop.Spec.scene(i));
        int n = MrBackdrop.STYLES;
        double[] letter = new double[n], accent = new double[n], pressed = new double[n], line = new double[n];
        java.util.Arrays.fill(letter, 99);
        java.util.Arrays.fill(accent, 99);
        java.util.Arrays.fill(pressed, 99);
        java.util.Arrays.fill(line, 99);
        List<List<Double>> lines = new ArrayList<List<Double>>();
        for (int i = 0; i < n; i++) lines.add(new ArrayList<Double>());
        String[] where = new String[n];
        for (MrBackdrop.Spec sp : specs) {
            Bitmap image = imageFor(sp);
            Bitmap bg = bitmap(W, H);
            Canvas oc = new Canvas(bg);
            MrBackdrop.draw(oc, sp, W, H, image);
            oc.drawColor(MrBackdropDrawable.veilOver(MrBackdrop.look(sp, image, true, 0)));
            for (int style = 0; style < n; style++) {
                String tag = MrBackdrop.STYLE_TAGS[style];
                boolean hasEdge = MrThemeColors.own(c, tag, "key_normal_edge") != 0;
                for (int r = 0; r < 6; r++) {
                    for (int i = 0; i < 20; i++) {
                        int x = Math.round((i + 0.5f) * W / 20f), y = Math.round(top + (r + 0.5f) * rowH);
                        int step = MrGlow.step(x, y - top, W, Math.round(H - top));
                        int under = mean(bg, x - W / 40, y - Math.round(rowH / 2f), W / 20, Math.round(rowH));
                        int ink = hueOf(c, tag, "text", step) | 0xff000000;
                        int fill = hueOf(c, tag, "key_normal_fill", step), accFill = hueOf(c, tag, "key_acc_normal_fill", step), press = hueOf(c, tag, "key_pressed_fill", step);
                        int onKey = MrBackdrop.mix(under, fill | 0xff000000, (fill >>> 24) / 255f), onAccent = MrBackdrop.mix(under, accFill | 0xff000000, (accFill >>> 24) / 255f);
                        int onPressed = MrBackdrop.mix(under, press | 0xff000000, (press >>> 24) / 255f);
                        double a = MrBackdrop.contrast(ink, onKey);
                        if (a < letter[style]) {
                            letter[style] = a;
                            where[style] = sp.format() + " row " + r + " col " + i;
                        }
                        accent[style] = Math.min(accent[style], MrBackdrop.contrast(ink, onAccent));
                        pressed[style] = Math.min(pressed[style], MrBackdrop.contrast(ink, onPressed));
                        if (hasEdge) {
                            int edge = hueOf(c, tag, "key_normal_edge", step);
                            double e = deltaE(MrBackdrop.mix(onKey, edge | 0xff000000, (edge >>> 24) / 255f), under);
                            line[style] = Math.min(line[style], e);
                            lines.get(style).add(e);
                        }
                    }
                }
            }
        }
        boolean letters = true, seen = true;
        double base = letter[0], baseAccent = accent[0], basePressed = pressed[0];
        for (int style = 0; style < n; style++) {
            String edge = "-";
            if (!lines.get(style).isEmpty()) {
                List<Double> l = lines.get(style);
                java.util.Collections.sort(l);
                edge = String.format("worst %.0f, one in ten below %.0f", l.get(0), l.get(l.size() / 10));
                if (l.get(l.size() / 10) < LINE_TENTH) seen = false;
            }
            System.out.println(String.format("      %-12s letters %.2f (worst at %s), highlight keys %.2f, pressed %.2f; line: %s", MrBackdrop.STYLE_TAGS[style].substring(3), letter[style], where[style],
                    accent[style], pressed[style], edge));
            if (letter[style] < base - LETTER_SLACK || accent[style] < baseAccent - LETTER_SLACK || pressed[style] < basePressed - LETTER_SLACK) letters = false;
        }
        check("over every colour, gradient and landscape, in 120 places of the keyboard, the letters of no style have a contrast with their key (at rest, a highlight key, under the finger) that is more than 0.15 worse than the clear glass has in its worst place", letters);
        check("and the line of an outlined or gradient key is a difference of colour of " + LINE_TENTH + " or more from what is behind it in nine places out of ten, so the key is seen as a key", seen);
        RES.flatFaces = false;
    }

    /** The mean colour (opaque) of the block of {@code w} x {@code h} pixels whose upper left corner is ({@code x}, {@code y}): what is behind a key, as the eye sees it. */
    static int mean(Bitmap b, int x, int y, int w, int h) {
        long r = 0, g = 0, bl = 0;
        int n = 0;
        for (int j = Math.max(0, y); j < Math.min(b.stubH, y + h); j++) {
            for (int i = Math.max(0, x); i < Math.min(b.stubW, x + w); i++) {
                int p = b.getPixel(i, j);
                r += (p >> 16) & 0xff;
                g += (p >> 8) & 0xff;
                bl += p & 0xff;
                n++;
            }
        }
        if (n == 0) return 0xff000000;
        return 0xff000000 | ((int) (r / n) << 16) | ((int) (g / n) << 8) | (int) (bl / n);
    }

    static final double LINE_TENTH = 14, LETTER_SLACK = 0.15;

    // ---------------------------------------------------------------- on the keyboard

    static void onKeyboard() throws Exception {
        reset();
        Ctx c = new Ctx();
        check("no background chosen: no look and no colour for the bar", MrBackdrop.lookNow(c) == null && MrBackdrop.bottomColor(c) == 0);
        check("the spec and the softening of an empty preference", MrBackdrop.current(c).kind == MrBackdrop.NONE && MrBackdrop.soft(c) == 0);
        PreferenceManager.stubDefault = null;
        check("without preferences it is the same", MrBackdrop.current(c).kind == MrBackdrop.NONE && MrBackdrop.soft(c) == 0 && MrBackdrop.lookNow(c) == null);
        PreferenceManager.stubDefault = prefs;
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 500).apply();
        check("the softening is kept inside 0 .. 70", MrBackdrop.soft(c) == 70);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, -9).apply();
        check("and not below 0", MrBackdrop.soft(c) == 0);
        prefs.edit().putString(MrBackdrop.PREF_SOFT, "40").apply();
        check("a softening of another type is 0 and no exception", MrBackdrop.soft(c) == 0);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 0).apply();

        // a background belongs to the themes of the backgrounds: a theme of the list has none, whatever the preference holds
        prefs.edit().putString(MrBackdrop.PREF, "g3").apply();
        check("in a theme of the list (Midnight) a background that is chosen is not looked at: no look, no colour for the bar", MrBackdrop.lookNow(c) == null && MrBackdrop.bottomColor(c) == 0);
        MrTheme.stubTag = "mr_snow";
        check("nor in a light one of the list", MrBackdrop.lookNow(c) == null && MrBackdrop.bottomColor(c) == 0);

        // the lower edge for the navigation bar
        MrTheme.stubTag = MrBackdrop.TAG_LIGHT_INK;
        MrBackdrop.Look dark = MrBackdrop.lookNow(c);
        check("a gradient chosen: its look is measured for the theme in use (light ink: a black veil)", dark != null && dark.veilColor == 0xff000000);
        check("the navigation bar of Android 15 and earlier takes the colour of the lower edge", MrBackdrop.bottomColor(c) == dark.bottom && (dark.bottom >>> 24) == 255);
        check("the same background is measured once", MrBackdrop.lookNow(c) == dark);
        Build.VERSION.SDK_INT = 36;
        check("from Android 16 the bar is transparent and the keyboard is under it: no colour is asked", MrBackdrop.bottomColor(c) == 0);
        Build.VERSION.SDK_INT = 35;
        check("Android 15 still asks", MrBackdrop.bottomColor(c) == dark.bottom);
        Build.VERSION.SDK_INT = 33;
        MrTheme.stubTag = MrBackdrop.TAG_DARK_INK;
        MrBackdrop.Look lightLook = MrBackdrop.lookNow(c);
        check("the theme with dark ink has a white veil, so another look and another edge", lightLook != dark && lightLook.veilColor == 0xffffffff && lightLook.bottom != dark.bottom);
        MrTheme.stubTag = MrBackdrop.TAG_LIGHT_INK;
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 40).apply();
        MrBackdrop.Look soft = MrBackdrop.lookNow(c);
        check("the softening that was left from a picture or a dialog gives a gradient the veil of the softening (at least), and keeps the edge of the bar opaque",
                soft.veilAlpha >= dark.veilAlpha && soft.veilAlpha >= Math.round(0.4f * 255) - 2 && (soft.bottom >>> 24) == 255);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 0).apply();
        prefs.edit().putString(MrBackdrop.PREF, "c7").apply();
        MrBackdrop.Look colour = MrBackdrop.lookNow(c);
        check("a colour chosen: no veil, and the colour itself is the edge of the navigation bar", colour != null && colour.veilAlpha == 0 && colour.bottom == MrBackdrop.COLORS[7]
                && MrBackdrop.bottomColor(c) == MrBackdrop.COLORS[7]);
        prefs.edit().putString(MrBackdrop.PREF, "c0").apply();
        MrTheme.stubTag = MrBackdrop.TAG_DARK_INK;
        check("a light colour in the theme with dark ink: the same, its own colour", MrBackdrop.lookNow(c).veilAlpha == 0 && MrBackdrop.bottomColor(c) == MrBackdrop.COLORS[0]);
        MrTheme.stubTag = MrBackdrop.TAG_LIGHT_INK;
        prefs.edit().putString(MrBackdrop.PREF, "i100,0,0,11").apply();
        check("a picture that is not there: no look, no colour", MrBackdrop.lookNow(c) == null && MrBackdrop.bottomColor(c) == 0);
        File f = new File(FILES, MrBackdrop.FILE);
        Files.write(f.toPath(), new byte[] {1});
        BitmapFactory.stubWidth = 640;
        BitmapFactory.stubHeight = 480;
        check("the picture arrives: the look is there", MrBackdrop.lookNow(c) != null);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 40).apply();
        MrBackdrop.Look pic = MrBackdrop.lookNow(c);
        check("the softening is the floor of the veil of a picture", pic != null && pic.veilAlpha >= Math.round(0.40f * 255f) - 1);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 0).apply();
        Files.delete(f.toPath());
        check("a context that fails gives 0 and no exception", MrBackdrop.bottomColor(null) == 0);

        // apply: the keyboard
        reset();
        c = new Ctx();
        View root = new View(c), kbd = new View(c);
        kbd.setBackgroundColor(0xff123456);
        MrTools.sBarRoot = root;
        MrTools.sKbd = kbd;
        MrBackdrop.apply();
        check("no background chosen: the keyboard keeps the colour of its theme", root.stubBackground == null && kbd.stubBackgroundColor == 0xff123456);
        prefs.edit().putString(MrBackdrop.PREF, "s4").apply();
        MrBackdrop.apply();
        check("a theme of the list (Midnight) with a background in the preference: the keyboard is not touched", root.stubBackground == null && kbd.stubBackgroundColor == 0xff123456);
        MrTheme.stubTag = MrBackdrop.TAG_LIGHT_INK;
        MrBackdrop.apply();
        check("a landscape chosen: the drawable is the background of the root of the toolbar and the keyboard view is left clear",
                root.stubBackground instanceof MrBackdropDrawable && kbd.stubBackgroundColor == 0);
        Drawable first = root.stubBackground;
        MrBackdrop.apply();
        check("shown again it is the same drawable (it keeps what it drew)", root.stubBackground == first);
        prefs.edit().putString(MrBackdrop.PREF, "c5").apply();
        MrBackdrop.apply();
        check("a colour chosen: the drawable is a new one, with the colour", root.stubBackground != first && root.stubBackground instanceof MrBackdropDrawable);
        MrBackdropDrawable colourDrawable = (MrBackdropDrawable) root.stubBackground;
        colourDrawable.setBounds(0, 0, 100, 40);
        Bitmap colourOut = bitmap(100, 40);
        colourDrawable.draw(new Canvas(colourOut));
        check("it paints the colour as it is, with no veil on it", colourOut.getPixel(50, 20) == MrBackdrop.COLORS[5] && colourOut.getPixel(1, 1) == MrBackdrop.COLORS[5]);
        prefs.edit().putString(MrBackdrop.PREF, "s4").apply();
        MrBackdrop.apply();
        first = root.stubBackground;
        prefs.edit().putString(MrBackdrop.PREF, "i100,0,0,12").apply();
        Drawable before = root.stubBackground;
        MrBackdrop.apply();
        check("a picture chosen that is gone: nothing is changed", root.stubBackground == before);
        MrTools.sBarRoot = null;
        MrBackdrop.apply();
        check("a keyboard that is not made yet is no error", true);
        MrTools.sBarRoot = root;
        MrTools.sKbd = null;
        prefs.edit().putString(MrBackdrop.PREF, "g1").apply();
        MrBackdrop.apply();
        check("without a keyboard view the background is still set", root.stubBackground instanceof MrBackdropDrawable);

        // the drawable: what it draws is the background with the veil
        c = new Ctx();
        MrBackdropDrawable d = MrBackdropDrawable.create(c, MrBackdrop.Spec.gradient(2), true, 0, 0xff102030);
        d.setBounds(0, 0, 300, 125);
        Bitmap out = bitmap(300, 125);
        d.draw(new Canvas(out));
        Bitmap ref = bitmap(300, 125);
        MrBackdrop.draw(new Canvas(ref), MrBackdrop.Spec.gradient(2), 300, 125, null);
        MrBackdrop.Look look = MrBackdrop.look(MrBackdrop.Spec.gradient(2), null, true, 0);
        int worst = 0;
        for (int y = 0; y < 125; y += 5) {
            for (int x = 0; x < 300; x += 5) worst = Math.max(worst, maxDiff(out.getPixel(x, y), MrBackdrop.mix(ref.getPixel(x, y), look.veilColor, look.veilAlpha / 255f)));
        }
        check("the drawable draws the background with its veil laid over it", worst <= 3 && d.getOpacity() == -1);
        d.setBounds(0, 0, 80, 40);
        Bitmap small = bitmap(80, 40);
        d.draw(new Canvas(small));
        check("a new size draws it again for that size", (small.getPixel(40, 20) >>> 24) == 255);
        d.setBounds(0, 0, 0, 0);
        Canvas none = new Canvas(bitmap(10, 10));
        d.draw(none);
        check("a drawable without bounds draws nothing", none.stubFill == 0);
        check("no background, a picture that is not there and no context give no drawable", MrBackdropDrawable.create(c, MrBackdrop.Spec.NO, true, 0, 0) == null
                && MrBackdropDrawable.create(c, MrBackdrop.Spec.image(100, 0, 0, 1), true, 0, 0) == null && MrBackdropDrawable.create(null, MrBackdrop.Spec.gradient(0), true, 0, 0) == null);
        // a picture that goes away after the drawable was made: the colour of the theme, never see-through
        Files.write(new File(FILES, MrBackdrop.FILE).toPath(), new byte[] {1});
        MrBackdropDrawable gone = MrBackdropDrawable.create(c, MrBackdrop.Spec.image(100, 0, 0, 13), true, 0, 0xff102030);
        new File(FILES, MrBackdrop.FILE).delete();
        gone.setBounds(0, 0, 50, 20);
        Canvas cg = new Canvas(bitmap(50, 20));
        gone.draw(cg);
        check("a picture that went away: the drawable paints the colour of the theme", cg.stubFill == 0xff102030);
        MrBackdropDrawable alpha = MrBackdropDrawable.create(c, MrBackdrop.Spec.gradient(0), true, 0, 0);
        alpha.setAlpha(100);
        alpha.setBounds(0, 0, 50, 20);
        Bitmap faint = bitmap(50, 20);
        alpha.draw(new Canvas(faint));
        check("setAlpha is honoured", (faint.getPixel(25, 10) >>> 24) < 200);
    }

    // ---------------------------------------------------------------- the screen

    /** The screen as onCreate leaves it: the first cards of the tab are made and the rest is posted. */
    static Screen openRaw() {
        Screen s = new Screen();
        s.onCreate((Bundle) null);
        s.mBig.stubSize(1000, 417);
        return s;
    }

    /** The screen with its tab made (the posted steps run, as the main thread does after onCreate). */
    static Screen open() {
        Screen s = openRaw();
        s.mGrid.stubRunPosted();
        return s;
    }

    static final int COLOURS = 16, GRADIENTS = 20, SCENES = 36;
    static final int FIRST_GRADIENT = COLOURS, FIRST_SCENE = COLOURS + GRADIENTS, MINE = COLOURS + GRADIENTS + SCENES;

    /** The tab that holds tile {@code i} of the backgrounds (numbered as they were when they were all on one page: colours, gradients, landscapes, my image). */
    static int tabOfTile(int i) {
        if (i < FIRST_GRADIENT) return MrThemesActivity.TAB_COLORS;
        if (i < FIRST_SCENE) return MrThemesActivity.TAB_GRADIENTS;
        if (i < MINE) return MrThemesActivity.TAB_SCENES + MrScenes.category(i - FIRST_SCENE);
        return MrThemesActivity.TAB_GALLERY;
    }

    /** The number of the first tile of the backgrounds of tab {@code tab}. */
    static int firstOfTab(int tab) {
        if (tab == MrThemesActivity.TAB_COLORS) return 0;
        if (tab == MrThemesActivity.TAB_GRADIENTS) return FIRST_GRADIENT;
        if (tab == MrThemesActivity.TAB_GALLERY) return MINE;
        return FIRST_SCENE + (tab - MrThemesActivity.TAB_SCENES) * MrScenes.PER_CATEGORY;
    }

    static MrBackdrop.Spec specOf(int i) {
        if (i < FIRST_GRADIENT) return MrBackdrop.Spec.color(i);
        if (i < FIRST_SCENE) return MrBackdrop.Spec.gradient(i - FIRST_GRADIENT);
        return MrBackdrop.Spec.scene(i - FIRST_SCENE);
    }

    /** Opens tab {@code t} (if another is open) and makes all its cards, as the posted steps do. */
    static void tab(Screen s, int t) {
        if (s.mTab != t) s.showTab(t);
        s.mGrid.stubRunPosted();
    }

    /** Card {@code i} of the themes (the tab of the themes is opened if it is not). */
    static MrThemePreview th(Screen s, int i) {
        tab(s, MrThemesActivity.TAB_THEMES);
        return s.mThemeTiles.get(i);
    }

    /** Tile {@code i} of the backgrounds, as numbered when they were on one page (the tab that holds it is opened if it is not). */
    static MrThemePreview bg(Screen s, int i) {
        int t = tabOfTile(i);
        tab(s, t);
        return s.mBgTiles.get(i - firstOfTab(t));
    }

    /** The whole card of theme {@code i}: its frame with the keyboard, the name and the pill. */
    static View cardOf(Screen s, int i) {
        return (View) th(s, i).getParent();
    }

    /** The theme whose card is the one in use on the open tab (-1: none, -2: more than one). */
    static int checkedTheme(Screen s) {
        int n = -1;
        for (int i = 0; i < s.mThemeTiles.size(); i++) if (s.mThemeTiles.get(i).checked()) n = n == -1 ? i : -2;
        return n;
    }

    /** The tile of the backgrounds that is the one in use on the open tab, numbered as {@link #bg} does (-1: none, -2: more than one). */
    static int checkedBackground(Screen s) {
        int n = -1;
        for (int i = 0; i < s.mBgTiles.size(); i++) if (s.mBgTiles.get(i).checked()) n = n == -1 ? i : -2;
        return n < 0 ? n : n + firstOfTab(s.mTab);
    }

    static String themeKey() {
        return prefs.getString("pref_keyboard_layout", null);
    }

    static String bgKey() {
        return prefs.getString(MrBackdrop.PREF, null);
    }

    /** The view with this text (a button of a dialog), or null. */
    static View byText(View v, String text) {
        if (v == null) return null;
        if (v instanceof android.widget.TextView && text.equals(String.valueOf(((android.widget.TextView) v).getText()))) return v;
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) {
                View f = byText(g.getChildAt(i), text);
                if (f != null) return f;
            }
        }
        return null;
    }

    /** The view under {@code v} whose description (what a screen reader says) is {@code text}. */
    static View byDescription(View v, String text) {
        if (v == null) return null;
        if (v.getContentDescription() != null && text.equals(v.getContentDescription().toString()) && v instanceof MrStyleDot) return v;
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) {
                View f = byDescription(g.getChildAt(i), text);
                if (f != null) return f;
            }
        }
        return null;
    }

    /** How many dots of styles of keys there are under {@code v}. */
    static int dots(View v) {
        if (v == null) return 0;
        int n = v instanceof MrStyleDot ? 1 : 0;
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) n += dots(g.getChildAt(i));
        }
        return n;
    }

    /** How many of the dots under {@code v} are the chosen one. */
    static int chosenDots(View v) {
        if (v == null) return 0;
        int n = v instanceof MrStyleDot && ((MrStyleDot) v).chosen() ? 1 : 0;
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) n += chosenDots(g.getChildAt(i));
        }
        return n;
    }

    /** Touches the dot of the style called {@code name} in the dialog that is open (false when there is none). */
    static boolean dot(String name) {
        Dialog d = Dialog.stubLast;
        View b = d == null ? null : byDescription(d.stubContent, name);
        return b != null && b.performClick();
    }

    /** Presses the button of the dialog that is open. */
    static boolean press(String text) {
        Dialog d = Dialog.stubLast;
        if (d == null || !d.stubShowing) return false;
        View b = byText(d.stubContent, text);
        return b != null && b.performClick();
    }

    static boolean showing() {
        return Dialog.stubLast != null && Dialog.stubLast.stubShowing;
    }

    /** A tile as it is drawn on a screen 360 wide. */
    static int[] tileImage(MrThemePreview t) {
        t.onMeasure(View.MeasureSpec.makeMeasureSpec(360, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
        t.stubSize(360, t.stubMeasuredHeight());
        return draw(t).stubPixels.clone();
    }

    static List<int[]> themeTiles(Screen s) {
        List<int[]> l = new ArrayList<int[]>();
        for (MrThemePreview t : s.mThemeTiles) l.add(tileImage(t));
        return l;
    }

    /** Every tile of a theme is the same picture as that theme drawn alone, with no background. */
    static boolean themeTilesAreThemes(Screen s) {
        for (int i = 0; i < s.mThemeTiles.size(); i++) {
            MrThemePreview alone = new MrThemePreview(s);
            alone.show(s.mTags[i], MrBackdrop.Spec.NO, null, 0);
            if (!java.util.Arrays.equals(tileImage(s.mThemeTiles.get(i)), tileImage(alone))) return false;
        }
        return true;
    }

    static boolean sameImages(List<int[]> a, List<int[]> b) {
        if (a.size() != b.size()) return false;
        for (int i = 0; i < a.size(); i++) if (!java.util.Arrays.equals(a.get(i), b.get(i))) return false;
        return true;
    }

    /** Touches a tile of the backgrounds and applies what the dialog shows. */
    static void apply(Screen s, int tile) {
        click(bg(s, tile));
        press("Apply");
    }

    /** The card of the choice in use (the keyboard at the top with its name and what it is) and the list under it (one card in each row, the bar of rolling at the margin on the right). */
    static void heroAndScroll() throws Exception {
        reset();
        Screen s = open();
        check("the list rolls with a thin bar of a faint tone, drawn outside of the cards: the margin on the right is the padding of the list, that is not clipped",
                s.mScroll.getPaddingRight() == s.k.dp(MrThemesActivity.SCROLL_MARGIN_DP) && !s.mScroll.stubClipToPadding && s.mScroll.stubScrollBarStyle == android.view.View.SCROLLBARS_OUTSIDE_OVERLAY
                        && s.mScroll.stubScrollBarSize == s.k.dp(3) && s.mScroll.stubScrollBarFades && MrThemesActivity.SCROLL_THUMB_ALPHA < 0x80 && MrThemesActivity.SCROLL_MARGIN_DP >= 12);
        check("from Android 10 on the thumb of the bar is the faint one of the screen; before it the bar of the system stays as it is", s.mScroll.stubScrollBarThumb != null);
        Build.VERSION.SDK_INT = 26;
        Screen old = open();
        check("on Android 8 the thumb is not set (the call does not exist there)", old.mScroll.stubScrollBarThumb == null && old.mScroll.stubScrollBarSize == old.k.dp(3));
        Build.VERSION.SDK_INT = 33;
        check("one card in each row: no row has an empty place, and every row is as wide as the list less the margin", MrThemesActivity.COLUMNS == 1 && s.mGrid.getChildCount() == s.mThemeTiles.size());
        check("under the name of the keyboard in use the screen says what it is: a theme of the list", s.mDetail.getText().toString().equals("Theme") && s.detail().equals("Theme")
                && s.mDetail.stubMaxLines == 3);

        // a background with the keys of a kind: the tab it is in, and the kind and the name of the style
        int outline = MrBackdrop.KIND_FIRST[MrBackdrop.KIND_OUTLINE];
        s.applyBackdrop(MrBackdrop.Spec.color(4), 0, outline, MrKeyLook.NONE, false);
        check("a colour with an outline style says the tab, the kind and the style (Colors, then Keys: Outline, White)", s.mDetail.getText().toString().equals("Colors\nKeys: Outline \u00b7 White")
                && s.mStyle == outline && s.mCaption.getText().toString().equals("Color 5"));
        s.applyBackdrop(MrBackdrop.Spec.gradient(2), 0, MrBackdrop.KIND_FIRST[MrBackdrop.KIND_GRADIENT] + 2, MrKeyLook.NONE, false);
        check("a gradient with a gradient style: the tab and the kind", s.mDetail.getText().toString().equals("Gradients\nKeys: Gradient \u00b7 " + MrThemesActivity.styleName(s, MrBackdrop.KIND_FIRST[MrBackdrop.KIND_GRADIENT] + 2)));
        s.applyBackdrop(MrBackdrop.Spec.scene(13), 0, 0, MrKeyLook.NONE, false);
        check("a landscape says its category and the clear glass", s.mDetail.getText().toString().equals(MrThemesActivity.categoryName(s, MrScenes.category(13)) + "\nKeys: Glass \u00b7 See-through"));
        int light = -1;
        for (int i = 0; i < MrBackdrop.COLORS.length && light < 0; i++) if (!MrBackdrop.hasStyles(MrBackdrop.Spec.color(i))) light = i;
        if (light >= 0) {
            s.applyBackdrop(MrBackdrop.Spec.color(light), 0, 0, MrKeyLook.NONE, false);
            check("a light colour has no styles of keys, so the screen says only the tab", s.mDetail.getText().toString().equals("Colors"));
        }
        s.chooseTheme(3);
        check("and back to a theme of the list", s.mDetail.getText().toString().equals("Theme"));
    }

    static void screen() throws Exception {
        reset();
        // the screen opens on the tab of the choice and makes only that tab, a few cards at a time
        Screen s = openRaw();
        String[] names = MrThemeColors.names(s);
        check("the screen knows all thirty-two themes and lists the thirteen (the nineteen of the backgrounds are not on it)", s.mListed == 13 && s.mTags.length == 32);
        check("it opens on the themes (no background is chosen) and has made only the first few cards, the rest are posted",
                s.mTab == MrThemesActivity.TAB_THEMES && s.mThemeTiles.size() == MrThemesActivity.CHUNK && s.mBgTiles.isEmpty() && s.mGrid.stubPostedCount() == 1);
        s.mGrid.stubRunPosted();
        check("then the thirteen themes are all there, one card in each row", MrThemesActivity.COLUMNS == 1 && s.mThemeTiles.size() == 13 && s.mGrid.getChildCount() == 13 && s.mBgTiles.isEmpty());
        check("the tabs are the themes, the colours, the gradients, the six categories of landscapes (each one a tab, there is no tab of landscapes) and the gallery",
                s.mTabViews.size() == 10 && byText(s.content, "Themes") != null && byText(s.content, "Colors") != null && byText(s.content, "Gradients") != null
                        && byText(s.content, "Sports") != null && byText(s.content, "Animals") != null && byText(s.content, "Snow") != null && byText(s.content, "Nature") != null
                        && byText(s.content, "Anime") != null && byText(s.content, "AI") != null && byText(s.content, "Gallery") != null && byText(s.content, "Landscapes") == null);
        check("the keyboard at the top says it is the one in use, with its name", byText(s.content, "In use") != null && s.mCaption.getText().toString().equals(names[0])
                && s.mBig.tag().equals("mr_midnight") && s.mBig.spec().kind == MrBackdrop.NONE);
        check("a card is the small keyboard with its name under it and a View on the right; the one in use says so", cardOf(s, 1) != null && byText(cardOf(s, 1), names[1]) != null && byText(cardOf(s, 1), "View") != null
                && byText(cardOf(s, 0), "In use") != null && byText(cardOf(s, 0), "View") == null);
        boolean own = true;
        for (int i = 0; i < s.mThemeTiles.size(); i++) if (!s.mThemeTiles.get(i).tag().equals(s.mTags[i]) || s.mThemeTiles.get(i).spec().kind != MrBackdrop.NONE) own = false;
        check("every card of a theme shows that theme and no background", own && checkedTheme(s) == 0 && s.mSpec.kind == MrBackdrop.NONE);

        // the other tabs are made when they are opened, and let go when they are left
        s.mTabViews.get(MrThemesActivity.TAB_COLORS).performClick();
        s.mGrid.stubRunPosted();
        check("a tab is opened by touching it: the cards of the themes are let go and the sixteen colours are made, c0 to c15",
                s.mTab == MrThemesActivity.TAB_COLORS && s.mThemeTiles.isEmpty() && s.mBgTiles.size() == COLOURS && s.mBgSpecs.get(0).format().equals("c0") && s.mBgSpecs.get(15).format().equals("c15"));
        s.mTabViews.get(MrThemesActivity.TAB_GRADIENTS).performClick();
        s.mGrid.stubRunPosted();
        check("the twenty gradients, g0 to g19", s.mBgTiles.size() == GRADIENTS && s.mBgSpecs.get(0).format().equals("g0") && s.mBgSpecs.get(19).format().equals("g19"));
        boolean sixEach = true;
        for (int cat = 0; cat < MrScenes.CATEGORIES; cat++) {
            s.mTabViews.get(MrThemesActivity.TAB_SCENES + cat).performClick();
            s.mGrid.stubRunPosted();
            if (s.mBgTiles.size() != 6) sixEach = false;
            for (int n = 0; n < 6; n++) if (!s.mBgSpecs.get(n).format().equals("s" + (cat * 6 + n))) sixEach = false;
        }
        check("each category of landscapes is a tab of its own with its six, in order: s0 to s5 the sports, then the animals, the snow, the nature, the anime and the AI", sixEach
                && MrScenes.category(5) == MrScenes.SPORTS && MrScenes.category(6) == MrScenes.ANIMALS);
        final Screen live = s;
        boolean loaded = waitFor(() -> {
            for (int i = 0; i < MrScenes.COUNT; i++) if (live.mScenes[i] == null) return false;
            return true;
        });
        check("the small copies are read apart from the main thread, at half the size, as the tab of their category is opened",
                loaded && s.mScenes[35].getHeight() * 2 <= scene(35).getHeight() + 1 && s.mScenes[0] != null && s.mScenes[30].getWidth() * 2 <= scene(30).getWidth() + 1);
        final Screen fresh = open();
        tab(fresh, MrThemesActivity.TAB_SCENES + MrScenes.NATURE);
        check("a screen that opens only one category reads only its six landscapes", waitFor(() -> {
            for (int i = 18; i < 24; i++) if (fresh.mScenes[i] == null) return false;
            return true;
        }) && fresh.mScenes[0] == null && fresh.mScenes[35] == null);
        tab(s, MrThemesActivity.TAB_SCENES + MrScenes.AI);
        MrThemePreview withPicture = s.mBgTiles.get(5), without = new MrThemePreview(s);
        without.show(MrBackdrop.TAG_LIGHT_INK, MrBackdrop.Spec.scene(35), null, 0);
        check("a card of a landscape shows its picture as soon as it is read (until then, the colour of the theme)", !java.util.Arrays.equals(tileImage(withPicture), tileImage(without)));
        tab(s, MrThemesActivity.TAB_GALLERY);
        check("the gallery has the card that picks a photo (no card of my image and no remove button until there is a picture)",
                byText(s.content, "Choose a photo") != null && byText(s.content, "Choose") != null && s.mMineTile == null && s.mRemove == null && s.mBgTiles.isEmpty());
        boolean suited = true;
        for (int i = 0; i < MINE; i++) {
            MrBackdrop.Spec sp = specOf(i);
            MrThemePreview t = bg(s, i);
            if (!t.spec().same(sp) || !t.tag().equals(MrBackdrop.themeTag(sp))) suited = false;
        }
        check("every card of a background shows that background in the theme that suits it (light ink, or dark ink on the light colours)", suited
                && bg(s, 0).tag().equals("mr_overlight") && bg(s, 1).tag().equals("mr_overdark") && bg(s, FIRST_SCENE).tag().equals("mr_overlight"));

        // a theme: a dialog with the complete keyboard, and nothing is chosen until Apply
        tab(s, MrThemesActivity.TAB_THEMES);
        click(th(s, 5));
        Dialog d = Dialog.stubLast;
        check("touching a theme opens a dialog with the complete keyboard of that theme, its name, Cancel and Apply (and no softening or styles: they are for the backgrounds)",
                d.stubShowing && s.mDialogPreview.full() && s.mDialogPreview.tag().equals(s.mTags[5]) && s.mDialogPreview.spec().kind == MrBackdrop.NONE && byText(d.stubContent, names[5]) != null
                        && byText(d.stubContent, "Cancel") != null && byText(d.stubContent, "Apply") != null && s.mDialogSoft == null && byText(d.stubContent, "Keys") == null);
        check("nothing is chosen yet", "0".equals(themeKey()) || themeKey() == null);
        check("Cancel closes it and writes nothing", press("Cancel") && !d.stubShowing && !"5".equals(themeKey()) && s.mTheme == 0);
        click(th(s, 5));
        check("Apply chooses it, writes it with no background, and the card and the keyboard at the top show it",
                press("Apply") && "5".equals(themeKey()) && s.mTheme == 5 && "".equals(bgKey()) && checkedTheme(s) == 5 && s.mCaption.getText().toString().equals(names[5])
                        && s.mBig.tag().equals(s.mTags[5]) && byText(cardOf(s, 5), "In use") != null && byText(cardOf(s, 0), "View") != null);
        s.chooseTheme(12);
        check("the last theme of the list", "12".equals(themeKey()) && checkedTheme(s) == 12);

        // a colour: a dialog, and nothing is applied until Apply
        click(bg(s, 4));
        d = Dialog.stubLast;
        check("touching a colour opens a dialog with the keyboard as it will look, in the theme of the colour", d.stubShowing && s.mDialogPreview != null
                && s.mDialogPreview.spec().format().equals("c4") && s.mDialogPreview.tag().equals(MrBackdrop.themeTag(MrBackdrop.Spec.color(4))));
        check("the dialog has Cancel and Apply, and is a sheet at the bottom as wide as the screen", byText(d.stubContent, "Cancel") != null && byText(d.stubContent, "Apply") != null
                && d.getWindow().stubGravity == android.view.Gravity.BOTTOM && d.getWindow().stubWidth == android.view.ViewGroup.LayoutParams.MATCH_PARENT);
        check("a colour has the styles of the keys in two levels (the three kinds as chips, the colours of the kind in use as dots and the round one that picks a colour, the name of the one chosen under them) and no softening",
                byText(d.stubContent, "Keys") != null && byText(d.stubContent, "Glass") != null && byText(d.stubContent, "Outline") != null && byText(d.stubContent, "Gradient") != null
                        && dots(d.stubContent) == 6 && byDescription(d.stubContent, "See-through") != null && byDescription(d.stubContent, "Pick a colour") != null && byDescription(d.stubContent, "Ice") != null && byDescription(d.stubContent, "Dark") != null
                        && byDescription(d.stubContent, "Violet") == null && byText(d.stubContent, "See-through") != null && s.mDialogSoft == null && byText(d.stubContent, "Soften background") == null);
        check("nothing is applied yet: the preferences, the keyboard at the top and the cards are as they were", "12".equals(themeKey()) && "".equals(bgKey()) && s.mSpec.kind == MrBackdrop.NONE
                && s.mBig.spec().kind == MrBackdrop.NONE);
        check("the dialog shows the complete keyboard (the row of Ctrl and Alt, the numbers, the letters, the bottom row, the dash of the modifier keys), the big keyboard of the screen stays the small one",
                s.mDialogPreview.full() && !s.mBig.full() && !bg(s, 4).full() && !th(s, 0).full());
        tab(s, MrThemesActivity.TAB_COLORS);
        {
            MrThemePreview shown = s.mDialogPreview;
            shown.onMeasure(View.MeasureSpec.makeMeasureSpec(600, View.MeasureSpec.EXACTLY), View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
            check("it is as tall as the complete keyboard is (1.7 to 1)", shown.stubMeasuredHeight() == Math.round(600 / MrThemePreview.FULL_ASPECT));
        }
        check("Cancel closes it and writes nothing", press("Cancel") && !d.stubShowing && "12".equals(themeKey()) && "".equals(bgKey()) && s.mDialog == null);
        click(bg(s, 4));
        Dialog.stubLast.stubBack();
        check("so does the back button", !Dialog.stubLast.stubShowing && "12".equals(themeKey()) && "".equals(bgKey()));
        click(bg(s, 4));
        check("Apply closes it", press("Apply") && !Dialog.stubLast.stubShowing);
        check("a dark colour is written with the theme of the backgrounds with light ink (13), and as c4", "13".equals(themeKey()) && "c4".equals(bgKey()) && s.mSpec.format().equals("c4"));
        check("only the keyboard at the top shows it: the card of the colour is the one in use and no theme is", checkedBackground(s) == 4 && s.mBig.spec().format().equals("c4")
                && s.mBig.tag().equals("mr_overlight") && s.mCaption.getText().toString().equals("Color 5") && byText(boxOf(bg(s, 4)), "In use") != null);
        check("the softening is for gradients, landscapes and pictures: a colour does not write it", prefs.getInt(MrBackdrop.PREF_SOFT, -1) == -1);
        tab(s, MrThemesActivity.TAB_THEMES);
        check("the cards of the themes show the themes as they are (a card is its theme with no background, whatever is chosen), and no theme is the one in use", themeTilesAreThemes(s) && checkedTheme(s) == -1
                && s.mThemeTiles.size() == 13);
        apply(s, 1);
        check("a light colour is written with the theme with dark ink (14), and it has no styles of keys to choose (they all have white ink)",
                "14".equals(themeKey()) && "c1".equals(bgKey()) && s.mBig.tag().equals("mr_overdark") && checkedBackground(s) == 1);
        click(bg(s, 1));
        check("its dialog has no styles", byText(Dialog.stubLast.stubContent, "Keys") == null && dots(Dialog.stubLast.stubContent) == 0 && byText(Dialog.stubLast.stubContent, "Glass") == null && s.mDialogPreview.tag().equals("mr_overdark"));
        press("Cancel");

        // a gradient: the softening and the styles
        apply(s, FIRST_GRADIENT + 3);
        check("a gradient: g3, in the theme with light ink, and its card is the one in use", "13".equals(themeKey()) && "g3".equals(bgKey()) && checkedBackground(s) == FIRST_GRADIENT + 3
                && s.mCaption.getText().toString().equals("Gradient 4"));
        check("it wrote the softening it had in the dialog: none", prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 0);

        // a landscape: the softening and the style of the keys, both in the dialog
        apply(s, FIRST_SCENE + 4);
        check("a landscape: s4", "13".equals(themeKey()) && "s4".equals(bgKey()) && checkedBackground(s) == FIRST_SCENE + 4 && s.mCaption.getText().toString().equals("Sports \u00b7 Esports"));
        click(bg(s, FIRST_SCENE + 1));
        d = Dialog.stubLast;
        check("the dialog of a landscape shows that landscape, with its picture, on the complete keyboard, with the title, the softening and the styles of the keys",
                s.mDialogPreview.spec().format().equals("s1") && "s4".equals(bgKey()) && s.mDialogPreview.full() && byText(d.stubContent, "Sports \u00b7 Basketball") != null
                        && s.mDialogSoft != null && s.mDialogSoft.getMax() == 70 && byText(d.stubContent, "Soften background") != null && byText(d.stubContent, "Keys") != null);
        check("another landscape starts with no softening (the one in use is another), and with the see-through glass", s.mDialogSoft.getProgress() == 0 && s.mDialogPreview.tag().equals("mr_overlight"));
        int[] plain = tileImage(s.mDialogPreview);
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 60, true);
        int[] softened = tileImage(s.mDialogPreview);
        check("moving the softening draws the keyboard of the dialog again with the veil it gives (nothing is written)", !java.util.Arrays.equals(plain, softened) && byText(d.stubContent, "60%") != null
                && prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 0);
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 999, true);
        check("it stops at 70", byText(d.stubContent, "70%") != null);
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 5, false);
        check("a change that is not the finger's (the code setting the bar) is not a choice", byText(d.stubContent, "70%") != null);
        check("a style of keys is chosen by touching its dot: the keyboard of the dialog is drawn with its keys, and the name under the dots says it", dot("Ice") && s.mDialogPreview.tag().equals("mr_overice")
                && byText(Dialog.stubLast.stubContent, "Ice") != null && byText(Dialog.stubLast.stubContent, "See-through") == null && s.mStyle == 0);
        check("another one replaces it", dot("Mint") && s.mDialogPreview.tag().equals("mr_overmint") && byText(Dialog.stubLast.stubContent, "Mint") != null);
        check("a kind is chosen by touching its chip: its first colour is in the keyboard, and the dots are the ones of that kind (six outlines, four gradients, each with the round one that picks a colour)",
                byText(Dialog.stubLast.stubContent, "Outline").performClick() && s.mDialogPreview.tag().equals("mr_overline") && dots(Dialog.stubLast.stubContent) == 7
                        && byDescription(Dialog.stubLast.stubContent, "Gold") != null && byDescription(Dialog.stubLast.stubContent, "Ice") == null
                        && byText(Dialog.stubLast.stubContent, "Gradient").performClick() && s.mDialogPreview.tag().equals("mr_overdawn") && dots(Dialog.stubLast.stubContent) == 5
                        && dot("Prism") && s.mDialogPreview.tag().equals("mr_overprism") && byText(Dialog.stubLast.stubContent, "Prism") != null);
        check("touching the kind that is chosen keeps the colour", byText(Dialog.stubLast.stubContent, "Gradient").performClick() && s.mDialogPreview.tag().equals("mr_overprism"));
        check("and the chosen dot is the only one with a second ring", chosenDots(Dialog.stubLast.stubContent) == 1);
        check("Cancel after all that writes nothing: the landscape, the theme and the softening are as they were", press("Cancel") && "s4".equals(bgKey()) && "13".equals(themeKey()) && prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 0);
        click(bg(s, FIRST_SCENE + 1));
        Dialog.stubLast.stubBack();
        click(bg(s, FIRST_SCENE + 1));
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 45, true);
        dot("Ice");
        check("Apply writes the landscape, the softening and the theme of the style chosen (ice: 15), in one edit", press("Apply") && "s1".equals(bgKey()) && prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 45
                && "15".equals(themeKey()) && s.mTheme == 15 && s.mStyle == 1);
        check("the keyboard at the top shows it, with the style, the softening and its name", s.mBig.tag().equals("mr_overice") && s.mBig.spec().format().equals("s1")
                && s.mCaption.getText().toString().equals("Sports \u00b7 Basketball") && checkedBackground(s) == FIRST_SCENE + 1);
        click(bg(s, FIRST_SCENE + 1));
        check("the dialog of the landscape in use starts with its softening and its style", s.mDialogSoft.getProgress() == 45 && s.mDialogPreview.tag().equals("mr_overice")
                && byText(Dialog.stubLast.stubContent, "45%") != null);
        press("Cancel");
        click(bg(s, FIRST_SCENE + 2));
        check("another landscape starts with no softening and with the see-through glass: what was chosen for the one in use (ice) is not carried to it", s.mDialogSoft.getProgress() == 0 && s.mDialogPreview.tag().equals("mr_overlight"));
        press("Cancel");
        tab(s, MrThemesActivity.TAB_COLORS);
        click(bg(s, 5));
        check("a colour opens in the see-through glass too, not in the style in use (ice)", s.mDialogPreview.tag().equals("mr_overlight") && s.mDialogLook[0].isNone());
        dot("Ice");
        press("Apply");
        check("a dark colour with the style chosen is written with that theme (15), and no softening is written for it", "15".equals(themeKey()) && "c5".equals(bgKey()) && prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 45);
        click(bg(s, 1));
        check("and a light colour keeps its dark ink whatever the style in use", s.mDialogPreview.tag().equals("mr_overdark"));
        press("Apply");
        check("it is written with the theme with dark ink (14)", "14".equals(themeKey()) && "c1".equals(bgKey()) && s.mStyle == 0);

        // a theme after a background takes the background away
        click(th(s, 7));
        press("Apply");
        check("applying a theme chooses it and takes the background off", "7".equals(themeKey()) && "".equals(bgKey()) && checkedTheme(s) == 7 && s.mSpec.kind == MrBackdrop.NONE
                && s.mBig.tag().equals(s.mTags[7]) && s.mBig.spec().kind == MrBackdrop.NONE && s.mCaption.getText().toString().equals(names[7]) && s.mStyle == 0);
        check("each card has its name for the screen readers", boxOf(th(s, 2)).getContentDescription().toString().equals(names[2])
                && boxOf(bg(s, 4)).getContentDescription().toString().equals("Color 5") && boxOf(bg(s, FIRST_GRADIENT + 4)).getContentDescription().toString().equals("Gradient 5")
                && boxOf(bg(s, FIRST_SCENE)).getContentDescription().toString().equals("Soccer ball"));

        // the texts
        check("the texts of the screen are the ones of the strings", MrThemesActivity.sceneName(s, 0).equals("Soccer ball") && MrThemesActivity.sceneName(s, 8).equals("Panther") && MrThemesActivity.sceneName(s, 35).equals("Network")
                && MrThemesActivity.categoryName(s, 0).equals("Sports") && MrThemesActivity.categoryName(s, 5).equals("AI") && MrThemesActivity.categoryName(s, 6).equals("")
                && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.scene(13)).equals("Snow \u00b7 Katana")
                && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.gradient(4)).equals("Gradient 5") && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.color(0)).equals("Color 1")
                && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.image(100, 0, 0, 1)).equals("My image") && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.NO).equals("")
                && MrThemesActivity.styleName(s, 0).equals("See-through") && MrThemesActivity.styleName(s, 5).equals("White") && MrThemesActivity.styleName(s, 14).equals("Lagoon") && MrThemesActivity.styleName(s, 15).equals("Own colour") && MrThemesActivity.styleName(s, 17).equals("Own colour") && MrThemesActivity.styleName(s, 18).equals("")
                && MrThemesActivity.kindName(s, 0).equals("Glass") && MrThemesActivity.kindName(s, 1).equals("Outline") && MrThemesActivity.kindName(s, 2).equals("Gradient") && MrThemesActivity.kindName(s, 3).equals(""));
        check("a scene that has no name is empty and no exception", MrThemesActivity.sceneName(s, 99).equals(""));

        // what the preferences say when the screen is made
        reset();
        prefs.edit().putString("pref_keyboard_layout", "5").putString(MrBackdrop.PREF, "c3").apply();
        s = open();
        check("a background that is left in the preference of a theme of the list is let be: the screen shows the theme", s.mSpec.kind == MrBackdrop.NONE && checkedTheme(s) == 5
                && s.mBig.tag().equals(s.mTags[5]) && s.mBig.spec().kind == MrBackdrop.NONE && s.mTab == MrThemesActivity.TAB_THEMES);
        reset();
        prefs.edit().putString("pref_keyboard_layout", "13").putString(MrBackdrop.PREF, "c3").apply();
        s = open();
        check("in the theme of the backgrounds the background in the preference is the choice: it opens on the tab of the colours, its card is the one in use and no theme is",
                s.mSpec.format().equals("c3") && s.mTab == MrThemesActivity.TAB_COLORS && checkedBackground(s) == 3 && checkedTheme(s) == -1 && s.mCaption.getText().toString().equals("Color 4"));
        reset();
        prefs.edit().putString("pref_keyboard_layout", "13").putString(MrBackdrop.PREF, "g7").apply();
        check("a gradient opens on the tab of the gradients", open().mTab == MrThemesActivity.TAB_GRADIENTS);
        reset();
        prefs.edit().putString("pref_keyboard_layout", "15").putString(MrBackdrop.PREF, "s20").apply();
        s = open();
        check("a landscape opens on the tab of its category (s20 is nature) and the style comes from the theme (outlined: 1)", s.mTab == MrThemesActivity.TAB_SCENES + MrScenes.NATURE && s.mStyle == 1
                && s.mSpec.format().equals("s20") && checkedBackground(s) == FIRST_SCENE + 20);
        reset();
        prefs.edit().putString("pref_keyboard_layout", "13").apply();
        s = open();
        check("the theme of the backgrounds with no background chooses nothing and says nothing", checkedBackground(s) == -1 && checkedTheme(s) == -1 && s.mCaption.getText().toString().equals(""));
        reset();
        prefs.edit().putString("pref_keyboard_layout", "99").apply();
        Screen odd = open();
        check("a theme value that is not any theme is the first one", odd.mTheme == 0 && checkedTheme(odd) == 0);
        reset();
        prefs.edit().putString("pref_keyboard_layout", "14").putString(MrBackdrop.PREF, "nonsense").apply();
        check("a background that does not parse is none", open().mSpec.kind == MrBackdrop.NONE);

        // a tab opened while the cards of another are still being made: the old ones stop
        reset();
        s = new Screen();
        s.onCreate((Bundle) null);
        s.showTab(MrThemesActivity.TAB_GRADIENTS);
        s.mGrid.stubRunPosted();
        check("a step posted by a tab that was left does nothing to the one that was opened after it (20 gradients, no card of the themes)", s.mBgTiles.size() == GRADIENTS && s.mThemeTiles.isEmpty()
                && s.mGrid.getChildCount() == GRADIENTS);
    }

    static View boxOf(View tile) {
        return (View) tile.getParent();
    }

    static void click(View tile) {
        boxOf(tile).performClick();
    }

    /** The first view under {@code v} whose description is {@code desc} (null: any clickable). */
    static View find(View v, String desc) {
        if (v == null) return null;
        if (desc != null && v.getContentDescription() != null && desc.equals(v.getContentDescription().toString())) return v;
        if (v instanceof android.view.ViewGroup) {
            android.view.ViewGroup g = (android.view.ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) {
                View f = find(g.getChildAt(i), desc);
                if (f != null) return f;
            }
        }
        return null;
    }

    static void pickerChain() throws Exception {
        reset();
        Screen s = open();
        List<Intent> tries = MrThemesActivity.pickers(33);
        check("on Android 13 there are three ways to ask for a picture: the photo picker, the gallery, the documents", tries.size() == 3
                && "android.provider.action.PICK_IMAGES".equals(tries.get(0).getAction()) && Intent.ACTION_PICK.equals(tries.get(1).getAction()) && Intent.ACTION_OPEN_DOCUMENT.equals(tries.get(2).getAction()));
        check("each one asks for images", "image/*".equals(tries.get(0).stubType) && "image/*".equals(tries.get(1).stubType) && "image/*".equals(tries.get(2).stubType)
                && String.valueOf(tries.get(1).getData()).equals("content://media/external/images/media") && tries.get(2).stubCategories.contains(Intent.CATEGORY_OPENABLE));
        check("before Android 11 there is no photo picker to ask: the gallery first", MrThemesActivity.pickers(29).size() == 2 && Intent.ACTION_PICK.equals(MrThemesActivity.pickers(29).get(0).getAction())
                && Intent.ACTION_OPEN_DOCUMENT.equals(MrThemesActivity.pickers(29).get(1).getAction()) && MrThemesActivity.pickers(30).size() == 3);

        tab(s, MrThemesActivity.TAB_GALLERY);
        View gal = find(s.content, "Choose a photo");
        check("the card that picks a photo, in the gallery, opens the photo picker of Android, not the file manager", gal != null && gal.performClick() && s.started != null
                && "android.provider.action.PICK_IMAGES".equals(s.started.getAction()) && "image/*".equals(s.started.stubType) && s.startedCode == 71);
        s.started = null;
        s.refuse = 1;
        s.tried = 0;
        s.pick();
        check("a phone without the photo picker is asked for the gallery", s.started != null && Intent.ACTION_PICK.equals(s.started.getAction()) && s.tried == 2);
        s.started = null;
        s.refuse = 2;
        s.tried = 0;
        s.pick();
        check("and one without that, for the documents (the file manager)", s.started != null && Intent.ACTION_OPEN_DOCUMENT.equals(s.started.getAction()) && s.tried == 3);
        s.started = null;
        s.refuse = 3;
        s.tried = 0;
        s.pick();
        check("a phone that answers none starts nothing, says so, and does not fail", s.started == null && s.tried == 3);
        s.started = null;
        s.refuse = 0;
        s.crash = true;
        s.pick();
        check("a picker that cannot be started (an exception) is not the end: the next one is tried", s.started != null && Intent.ACTION_PICK.equals(s.started.getAction()));
        s.crash = false;
        Build.VERSION.SDK_INT = 29;
        s.started = null;
        s.pick();
        check("on Android 10 the first one asked is the gallery", s.started != null && Intent.ACTION_PICK.equals(s.started.getAction()));
        Build.VERSION.SDK_INT = 33;
    }

    /** Makes the screen choose a picture and waits until the crop dialog is open. */
    static boolean choose(Screen s) throws Exception {
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        return waitFor(() -> s.mDialogCrop != null && Dialog.stubLast.stubShowing);
    }

    static MotionEvent finger(int action, int index, float... xy) {
        int n = xy.length / 2;
        int[] ids = new int[n];
        float[] xs = new float[n], ys = new float[n];
        for (int i = 0; i < n; i++) {
            ids[i] = i;
            xs[i] = xy[2 * i];
            ys[i] = xy[2 * i + 1];
        }
        return MotionEvent.stub(action, index, 0L, 0L, ids, xs, ys);
    }

    static void crop() throws Exception {
        reset();
        Screen s = open();
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 2000;
        apply(s, FIRST_SCENE + 1);
        tab(s, MrThemesActivity.TAB_GALLERY);
        String theme0 = themeKey(), bg0 = bgKey();
        check("a landscape is the background", "13".equals(theme0) && "s1".equals(bg0));

        // not chosen: nothing changes
        s.onActivityResult(71, 0, new Chosen(new android.net.Uri()));
        s.onActivityResult(70, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        s.onActivityResult(71, Activity.RESULT_OK, null);
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(null));
        Thread.sleep(100);
        pump();
        check("a cancelled pick, another request, no answer and no picture change nothing and open nothing", bgKey().equals(bg0) && !MrBackdrop.hasPending(s) && !MrBackdrop.hasImage(s) && !showing());

        // a picture: the dialog of the crop, and nothing is applied
        check("the picture is read into a waiting file and a dialog opens to place it", choose(s) && MrBackdrop.hasPending(s));
        check("nothing is the background yet: the preferences, the screen and the picture kept are as they were", themeKey().equals(theme0) && bgKey().equals(bg0) && !MrBackdrop.hasImage(s)
                && s.mSpec.format().equals("s1") && s.mBig.spec().format().equals("s1"));
        MrCropView crop = s.mDialogCrop;
        crop.stubSize(900, 500);
        check("the dialog is a full page with the hint, the picture with its frame and two buttons (the softening is not here: it is in the preview that follows)", Dialog.stubLast.getWindow().stubHeight == android.view.ViewGroup.LayoutParams.MATCH_PARENT
                && byText(Dialog.stubLast.stubContent, "Drag to move and pinch to zoom the part the keyboard will show.") != null && byText(Dialog.stubLast.stubContent, "Soften background") == null
                && byText(Dialog.stubLast.stubContent, "Cancel") != null && byText(Dialog.stubLast.stubContent, "Next") != null && s.mDialogSoft == null);
        check("it starts centred and not zoomed", crop.zoom() == 100 && crop.dx() == 0 && crop.dy() == 0);
        Rect f = crop.frame();
        check("the frame has the shape of the complete keyboard (1.7 to 1, as tall as the one of the preview that follows) and is inside the view", f.width() > 0 && near((float) (f.width() / (double) f.height()), MrThemePreview.FULL_ASPECT, 0.15f)
                && MrThemePreview.FULL_ASPECT < MrBackdrop.ASPECT
                && f.left >= 0 && f.top >= 0 && f.right <= 900 && f.bottom <= 500);
        Bitmap shot = bitmap(900, 500);
        crop.onDraw(new Canvas(shot));
        save(shot, "crop_start");

        // the pinch: fingers together make the frame smaller (a bigger zoom), spread make it bigger
        crop.onTouchEvent(finger(MotionEvent.ACTION_DOWN, 0, 350f, 250f));
        crop.onTouchEvent(finger(MotionEvent.ACTION_POINTER_DOWN, 1, 350f, 250f, 550f, 250f));
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 400f, 250f, 500f, 250f));
        check("fingers brought together to half the distance double the zoom", crop.zoom() == 200);
        Rect small = crop.frame();
        check("the frame is smaller and keeps the shape", small.width() < f.width() * 0.6 && near((float) (small.width() / (double) small.height()), MrThemePreview.FULL_ASPECT, 0.2f));
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 450f, 250f, 450f, 250f));
        check("fingers on the same point change nothing (no division by zero)", crop.zoom() == 200);
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 300f, 250f, 600f, 250f));
        check("spread wider than they started the zoom goes back to 100, and not under it", crop.zoom() == 100);
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 390f, 250f, 410f, 250f));
        check("fingers almost together stop at a zoom of 400", crop.zoom() == 400);
        crop.onTouchEvent(finger(MotionEvent.ACTION_POINTER_UP, 1, 390f, 250f, 410f, 250f));
        Rect before = crop.frame();
        int dx = crop.dx();
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 390f, 250f));
        check("when one finger is lifted the other carries on from where it is, with no jump", crop.dx() == dx && crop.frame().left == before.left && crop.frame().top == before.top);
        crop.onTouchEvent(finger(MotionEvent.ACTION_UP, 0, 390f, 250f));

        // the drag: the frame goes where the finger goes
        crop.onTouchEvent(finger(MotionEvent.ACTION_DOWN, 0, 450f, 250f));
        Rect from = crop.frame();
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 470f, 250f));
        Rect to = crop.frame();
        check("one finger moved 20 pixels to the right moves the frame about 20 pixels to the right", Math.abs((to.left - from.left) - 20) <= 6 && to.width() == from.width() && crop.dx() > dx);
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 450f, 270f));
        check("and down moves it down", crop.frame().top > to.top);
        crop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 100000f, -100000f));
        check("a very long move stops at the edge of the picture", crop.dx() == 100 && crop.dy() == -100 && crop.frame().right <= 900 && crop.frame().top >= 0);
        crop.onTouchEvent(finger(MotionEvent.ACTION_UP, 0, 450f, 250f));
        check("nothing was written by touching the frame", bgKey().equals(bg0) && themeKey().equals(theme0));
        crop.stubSize(0, 0);
        check("a view without size takes no touch", !crop.onTouchEvent(finger(MotionEvent.ACTION_DOWN, 0, 1f, 1f)) && crop.frame().width() == 0);
        crop.stubSize(900, 500);

        Bitmap bright = photo(1500, 1000);
        crop.set(bright, 250, 20, -30);
        check("set puts the frame where it is told, inside the limits", crop.zoom() == 250 && crop.dx() == 20 && crop.dy() == -30);
        crop.set(bright, 9999, 999, -999);
        check("and never outside them", crop.zoom() == 400 && crop.dx() == 100 && crop.dy() == -100);
        crop.set(bright, 200, 10, 20);

        // Next: the preview, and still nothing is applied
        check("Next opens the preview with the picture in the frame", press("Next") && s.mDialogPreview != null && s.mDialogCrop == null && s.mDialogPreview.spec().kind == MrBackdrop.IMAGE
                && s.mDialogPreview.spec().zoom == 200 && s.mDialogPreview.spec().dx == 10 && s.mDialogPreview.spec().dy == 20 && s.mDialogPreview.tag().equals("mr_overlight"));
        check("it is still not applied: the picture waits, the background is the landscape", MrBackdrop.hasPending(s) && !MrBackdrop.hasImage(s) && bgKey().equals(bg0) && themeKey().equals(theme0));
        check("the preview of the picture has the softening of the background (the slider is here, after the part of the picture was chosen), at the one in use, and the hint under it",
                s.mDialogSoft != null && s.mDialogSoft.getMax() == 70 && s.mDialogSoft.getProgress() == s.mSoft && byText(Dialog.stubLast.stubContent, "Soften background") != null
                        && byText(Dialog.stubLast.stubContent, "A veil keeps the suggestions readable over any background.") != null);
        int plainPic[] = tileImage(s.mDialogPreview);
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 60, true);
        check("moving it draws the keyboard of the preview again with the veil it gives, and writes nothing", !java.util.Arrays.equals(plainPic, tileImage(s.mDialogPreview)) && prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 0);
        check("Cancel there lets the picture go", press("Cancel") && !MrBackdrop.hasPending(s) && !showing() && bgKey().equals(bg0));

        // Cancel and back in the crop let it go too
        check("another picture", choose(s));
        check("Cancel in the crop deletes the waiting picture and closes the dialog", press("Cancel") && !MrBackdrop.hasPending(s) && !showing() && bgKey().equals(bg0));
        check("again", choose(s));
        Dialog.stubLast.stubBack();
        check("the back button in the crop too", !MrBackdrop.hasPending(s) && !showing() && bgKey().equals(bg0));
        check("again, to the preview", choose(s) && press("Next"));
        Dialog.stubLast.stubBack();
        check("the back button in the preview too", !MrBackdrop.hasPending(s) && !showing() && bgKey().equals(bg0));

        // Apply
        check("a picture, softened to 40, with the frame at zoom 200", choose(s));
        s.mDialogCrop.stubSize(900, 500);
        s.mDialogCrop.set(MrBackdrop.loadPending(s), 200, 10, 20);
        check("Next, the softening in the preview, and Apply", press("Next") && s.mDialogSoft != null && s.mDialogSoft.stubListener != null);
        s.mDialogSoft.stubListener.onProgressChanged(s.mDialogSoft, 40, true);
        check("Apply", press("Apply") && !showing());
        check("the picture is the background now, and nothing waits", MrBackdrop.hasImage(s) && !MrBackdrop.hasPending(s));
        check("the keyboard goes to the theme of the backgrounds and the preference holds the zoom, the position and the time of the file",
                "13".equals(themeKey()) && bgKey().equals("i200,10,20," + MrBackdrop.imageStamp(s)) && s.mSpec.kind == MrBackdrop.IMAGE);
        check("and the softening is written, because it is a picture", prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 40 && s.mSoft == 40);
        check("it is loaded for the keyboard at the top and for the tiles (the small copy is at most 320)", waitFor(() -> s.mImage != null && s.mThumb != null) && s.mThumb.getWidth() <= 320 && s.mThumb.getHeight() <= 320);
        check("my image is the card that is in use, the caption says so, and its card and the remove button appear in the gallery", waitFor(() -> mineThere(s))
                && checkedBackground(s) == MINE && s.mCaption.getText().toString().equals("My image") && byText(boxOf(s.mMineTile), "In use") != null);
        check("the card of my image shows the picture as it is placed", s.mMineTile.spec().zoom == 200 && s.mMineTile.spec().dx == 10);

        // a failure to apply
        String kept = bgKey();
        s.applyBackdrop(MrBackdrop.Spec.image(100, 0, 0, 1), 0, 0, MrKeyLook.NONE, true);
        check("applying a waiting picture that is not there changes nothing", bgKey().equals(kept) && themeKey().equals("13") && MrBackdrop.hasImage(s));

        // my image again: the crop with the picture that is kept
        click(mine(s));
        check("touching my image opens the crop with the picture that is kept, where the frame is now", s.mDialogCrop != null && showing() && s.mDialogCrop.zoom() == 200 && s.mDialogCrop.dx() == 10 && s.mDialogCrop.dy() == 20
                && s.mDialogSoft == null);
        s.mDialogCrop.stubSize(900, 500);
        s.mDialogCrop.onTouchEvent(finger(MotionEvent.ACTION_DOWN, 0, 450f, 250f));
        s.mDialogCrop.onTouchEvent(finger(MotionEvent.ACTION_MOVE, 0, 470f, 250f));
        s.mDialogCrop.onTouchEvent(finger(MotionEvent.ACTION_UP, 0, 470f, 250f));
        long stamp = MrBackdrop.imageStamp(s);
        check("Next shows the preview with the softening that is in use (40)", press("Next") && s.mDialogSoft != null && s.mDialogSoft.getProgress() == 40);
        check("and Apply puts the picture where it was moved to; the file is the same one (the time does not change) and is not copied", press("Apply")
                && bgKey().startsWith("i200,") && !bgKey().startsWith("i200,10,20,") && bgKey().endsWith("," + stamp) && MrBackdrop.imageStamp(s) == stamp && !MrBackdrop.hasPending(s));
        String placed = bgKey();
        click(mine(s));
        press("Cancel");
        check("Cancel there changes nothing, and the picture that is kept stays", bgKey().equals(placed) && MrBackdrop.hasImage(s));

        // a theme after the picture: the picture is kept for later
        click(th(s, 2));
        press("Apply");
        boolean themeIn = "2".equals(themeKey()) && "".equals(bgKey()) && MrBackdrop.hasImage(s) && checkedTheme(s) == 2;
        tab(s, MrThemesActivity.TAB_GALLERY);
        check("a theme chosen takes the picture off the keyboard but the picture is kept: in the gallery its card and the remove button stay, and the card is not the one in use", themeIn
                && s.mMineTile != null && s.mRemove != null && checkedBackground(s) == -1 && byText(boxOf(s.mMineTile), "View") != null);
        click(s.mMineTile);
        check("touching my image then opens the crop centred and not zoomed", s.mDialogCrop != null && s.mDialogCrop.zoom() == 100 && s.mDialogCrop.dx() == 0 && s.mDialogCrop.dy() == 0);
        press("Next");
        press("Apply");
        check("and Apply makes it the background again, in its theme", bgKey().startsWith("i100,0,0,") && "13".equals(themeKey()) && checkedBackground(s) == MINE);

        // failures: nothing is opened, nothing is left behind
        String now = bgKey();
        s.unreadable = true;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        Thread.sleep(150);
        pump();
        s.unreadable = false;
        check("a document that cannot be opened: no dialog, nothing waiting, the choice stays", s.mDialog == null && !MrBackdrop.hasPending(s) && bgKey().equals(now) && MrBackdrop.hasImage(s));
        BitmapFactory.stubFail = true;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        Thread.sleep(150);
        pump();
        BitmapFactory.stubFail = false;
        check("a file that is not a picture: the same, and the picture that is kept stays", s.mDialog == null && !MrBackdrop.hasPending(s) && bgKey().equals(now) && MrBackdrop.hasImage(s));
        check("a picture, and the screen is closing when it is read: it is let go and no dialog opens",
                chooseWhileClosing(s) && !MrBackdrop.hasPending(s) && s.mDialog == null);
        check("a picture and the screen is closed with the crop open: the dialog closes and the picture is let go", choose(s));
        Dialog open = Dialog.stubLast;
        s.onDestroy();
        check("closed: the dialog is gone, nothing waits, the pictures are let go", !open.stubShowing && !MrBackdrop.hasPending(s) && s.mImage == null && s.mThumb == null && MrBackdrop.hasImage(s));

        // a screen opened again with the picture kept
        Screen again = open();
        check("opened again: the choice is the one kept, and the picture loads", again.mSpec.kind == MrBackdrop.IMAGE && waitFor(() -> again.mImage != null && again.mThumb != null)
                && again.mTab == MrThemesActivity.TAB_GALLERY && again.mRemove != null && again.mMineTile != null);
        again.onDestroy();

        // remove
        final Screen r = open();
        waitFor(() -> r.mMineTile != null);
        r.removeImage();
        tab(r, MrThemesActivity.TAB_GALLERY);
        check("remove while the picture is the background: the file is gone, the keyboard goes to the first theme with no background", !MrBackdrop.hasImage(r) && "0".equals(themeKey()) && "".equals(bgKey())
                && r.mSpec.kind == MrBackdrop.NONE && r.mImage == null && r.mThumb == null && r.mTheme == 0);
        check("the remove button and the card of my image are gone, and the card that picks a photo stays", r.mRemove == null && r.mMineTile == null && byText(r.content, "Choose a photo") != null
                && byText(r.content, "My image") == null);
        check("a picture again", choose(r) && press("Next") && press("Apply") && waitFor(() -> r.mImage != null && MrBackdrop.hasImage(r)));
        apply(r, FIRST_SCENE + 2);
        r.removeImage();
        check("removing the picture while a landscape is the background keeps the landscape and its theme", "s2".equals(bgKey()) && "13".equals(themeKey()) && r.mSpec.kind == MrBackdrop.SCENE && !MrBackdrop.hasImage(r));

        // the small copy
        check("the thumbnail of a small picture is the picture", MrThemesActivity.thumb(bitmap(100, 50)).getWidth() == 100);
        Bitmap th = MrThemesActivity.thumb(bitmap(1280, 640));
        check("the small copy keeps the shape and is at most 320", th.getWidth() == 320 && th.getHeight() == 160);
    }

    static boolean chooseWhileClosing(Screen s) throws Exception {
        s.finishing = true;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        Thread.sleep(200);
        pump();
        s.finishing = false;
        return true;
    }

    /** The card of my image and the remove button are there on the gallery tab (its posted steps run first). */
    static boolean mineThere(Screen s) {
        tab(s, MrThemesActivity.TAB_GALLERY);
        return s.mMineTile != null && s.mRemove != null;
    }

    static MrThemePreview mine(Screen s) {
        tab(s, MrThemesActivity.TAB_GALLERY);
        return s.mMineTile;
    }

    // ---------------------------------------------------------------- the row of the settings

    static void row() throws Exception {
        reset();
        Ctx c = new Ctx();
        String[] names = MrThemeColors.names(c);
        MrThemeRow row = new MrThemeRow(c, null);
        check("the row says the name of the theme", row.getSummary().toString().equals(names[0]) && MrThemeRow.summary(c).equals(names[0]));
        prefs.edit().putString("pref_keyboard_layout", "5").apply();
        check("another theme", MrThemeRow.summary(c).equals(names[5]));
        prefs.edit().putString(MrBackdrop.PREF, "s3").apply();
        check("a background that is left in the preference of a theme of the list is not part of the choice: the row says the theme", MrThemeRow.summary(c).equals(names[5]));
        prefs.edit().putString("pref_keyboard_layout", "13").apply();
        check("in the theme of the backgrounds the row says the background (the themes of the backgrounds are not on the list)", MrThemeRow.summary(c).equals("Sports \u00b7 Tennis"));
        prefs.edit().putString(MrBackdrop.PREF, "g0").apply();
        check("a gradient has its number", MrThemeRow.summary(c).equals("Gradient 1"));
        prefs.edit().putString(MrBackdrop.PREF, "c4").apply();
        check("a colour has its number", MrThemeRow.summary(c).equals("Color 5"));
        prefs.edit().putString("pref_keyboard_layout", "14").putString(MrBackdrop.PREF, "c0").apply();
        check("in the theme with dark ink too", MrThemeRow.summary(c).equals("Color 1"));
        prefs.edit().putString(MrBackdrop.PREF, "i100,0,0,5").apply();
        check("a picture is my image", MrThemeRow.summary(c).equals("My image"));
        prefs.edit().putString(MrBackdrop.PREF, "").apply();
        check("a theme of the backgrounds with no background says nothing", MrThemeRow.summary(c).equals(""));
        prefs.edit().putString("pref_keyboard_layout", "oops").apply();
        prefs.edit().putString(MrBackdrop.PREF, "").apply();
        check("a theme that is not any is the first", MrThemeRow.summary(c).equals(names[0]));
        PreferenceManager.stubDefault = null;
        check("without preferences it says the first theme", MrThemeRow.summary(c).equals(names[0]));
        PreferenceManager.stubDefault = prefs;

        // it draws itself again when the screen changes the settings
        row.stubAttach(new PreferenceManager());
        check("on the screen it watches the preferences", prefs.listeners.size() == 1);
        int n = row.stubNotified;
        prefs.edit().putString("pref_keyboard_layout", "2").apply();
        check("a theme chosen on the screen redraws the row", row.stubNotified == n + 1);
        prefs.edit().putString(MrBackdrop.PREF, "g1").apply();
        check("a background too", row.stubNotified == n + 2);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 20).apply();
        prefs.edit().putBoolean("something_else", true).apply();
        check("another setting does not", row.stubNotified == n + 2);
        row.stubAttach(new PreferenceManager());
        check("it watches once", prefs.listeners.size() == 1);
        row.stubRemove();
        check("when the row goes away it stops watching", prefs.listeners.isEmpty());
        prefs.edit().putString("pref_keyboard_layout", "3").apply();
        check("and is not told any more", row.stubNotified == n + 2);
        row.stubRemove();
        check("leaving twice is no error", true);
    }

    // ---------------------------------------------------------------- the files

    static String read(String path) throws IOException {
        return new String(Files.readAllBytes(Paths.get(path)), "UTF-8");
    }

    static void files() throws Exception {
        List<String> list = new ArrayList<String>(java.util.Arrays.asList("mr_themes_title", "mr_themes_themes", "mr_themes_colors", "mr_themes_color", "mr_themes_gradients",
                "mr_themes_gallery", "mr_themes_mine", "mr_themes_soften", "mr_themes_soften_hint", "mr_themes_remove", "mr_themes_image_failed", "mr_themes_gradient", "mr_themes_cancel",
                "mr_themes_apply", "mr_themes_next", "mr_themes_crop_hint", "mr_themes_current", "mr_themes_view", "mr_themes_in_use", "mr_themes_choose", "mr_themes_photo", "mr_themes_keys", "mr_themes_theme_one",
                "mr_themes_key_opacity", "mr_themes_edge_opacity", "mr_themes_text_color", "mr_themes_grad_end", "mr_themes_auto", "mr_themes_pick_color", "mr_themes_done"));
        for (int i = 0; i < MrBackdrop.STYLES; i++) list.add("mr_themes_style_" + i);
        for (int i = 0; i < MrBackdrop.KINDS; i++) list.add("mr_themes_kind_" + i);
        for (int i = 0; i < MrScenes.CATEGORIES; i++) list.add("mr_themes_scene_cat_" + i);
        for (int i = 0; i < MrScenes.COUNT; i++) list.add("mr_themes_scene_" + i);
        String[] names = list.toArray(new String[0]);
        check("the screen has 93 texts: the 30 of the screen, the 18 styles of the keys, the 3 kinds of them, the 6 categories and the 36 landscapes", names.length == 93 && MrScenes.COUNT == 36 && MrScenes.CATEGORIES == 6);
        boolean all = true;
        for (String lang : new String[] {"en", "es", "pt-rBR"}) {
            Map<String, String> m = lang.equals("en") ? STRINGS : LANG.get(lang);
            for (String n : names) {
                String v = m.get(n);
                if (v == null || v.length() == 0) {
                    all = false;
                    System.out.println("      " + lang + " lacks " + n);
                } else if ((n.equals("mr_themes_gradient") || n.equals("mr_themes_color")) && !v.contains("%1$d")) {
                    all = false;
                    System.out.println("      " + lang + " " + n + " has no number");
                }
            }
            for (String gone : new String[] {"mr_themes_backgrounds", "mr_themes_none", "mr_themes_zoom", "mr_themes_drag", "mr_themes_landscapes"}) {
                if (m.get(gone) != null) {
                    all = false;
                    System.out.println("      " + lang + " still has " + gone);
                }
            }
        }
        check("every text is there in English, Spanish and Portuguese, the gradient and the colour have their number in each, and the texts of the old screen are gone", all);
        boolean distinct = true;
        for (String n : new String[] {"mr_themes_colors", "mr_themes_cancel", "mr_themes_apply", "mr_themes_next", "mr_themes_crop_hint", "mr_themes_soften_hint", "mr_themes_current", "mr_themes_in_use",
                "mr_themes_choose", "mr_themes_photo", "mr_themes_keys", "mr_themes_theme_one", "mr_themes_style_0", "mr_themes_style_1", "mr_themes_style_5", "mr_themes_style_11", "mr_themes_kind_0",
                "mr_themes_kind_1", "mr_themes_kind_2"}) {
            if (LANG.get("es").get(n).equals(STRINGS.get(n)) || LANG.get("pt-rBR").get(n).equals(STRINGS.get(n))) {
                distinct = false;
                System.out.println("      " + n + " is not translated");
            }
        }
        check("the new texts are translated, not copied", distinct);

        // the nineteen themes of the backgrounds: layouts, key faces, the entries of the lists
        boolean themeFiles = true;
        List<String> hidden = new ArrayList<String>();
        hidden.add("overlight");
        hidden.add("overdark");
        for (int i = 1; i < MrBackdrop.STYLES; i++) hidden.add(MrBackdrop.STYLE_TAGS[i].substring(3));
        for (String t : hidden) {
            for (String f : new String[] {"res/layout/input_mr_" + t + ".xml", "res/layout/input_popup_" + t + ".xml", "res/layout/key_preview_" + t + ".xml",
                    "res/drawable/btn_keyboard_key_" + t + ".xml", "res/drawable/btn_keyboard_key_" + t + "_accent.xml"}) {
                if (!new File(f).isFile()) {
                    themeFiles = false;
                    System.out.println("      missing " + f);
                }
            }
        }
        check("the nineteen themes of the backgrounds are complete (layouts, popup, key preview and key faces)", themeFiles && hidden.size() == 19);
        // the scroll bar of every screen and dialog (not only the themes screen) is the thin faint one at the right edge: the themes of the two give it
        String themeXml = read("res/values/mr_theme.xml");
        boolean bars = true;
        for (String style : new String[] {"Theme.MrKeyboard.Settings", "Theme.MrKeyboard.Dialog"}) {
            int at = themeXml.indexOf("<style name=\"" + style + "\"");
            int end = themeXml.indexOf("</style>", at);
            String body = at < 0 ? "" : themeXml.substring(at, end);
            if (!body.contains("<item name=\"android:scrollbarThumbVertical\">@drawable/mr_scrollbar_thumb</item>") || !body.contains("<item name=\"android:scrollbarSize\">3.0dip</item>")
                    || !body.contains("<item name=\"android:scrollbarStyle\">outsideOverlay</item>")) {
                bars = false;
                System.out.println("      the theme " + style + " lacks the scroll bar");
            }
        }
        String colours = read("res/values/mr_colors.xml");
        java.util.regex.Matcher thumb = java.util.regex.Pattern.compile("name=\"mr_scrollbar_thumb\">#([0-9a-f]{8})<").matcher(colours);
        java.util.regex.Matcher text2 = java.util.regex.Pattern.compile("name=\"mr_ui_text2\">#([0-9a-f]{8})<").matcher(colours);
        boolean tone = thumb.find() && text2.find() && Integer.parseInt(thumb.group(1).substring(0, 2), 16) == MrThemesActivity.SCROLL_THUMB_ALPHA && thumb.group(1).substring(2).equals(text2.group(1).substring(2));
        check("every screen and every dialog has the scroll bar of the themes screen from its theme: a 3 dp thumb in the secondary text at 35%, at the edge of the view (outside the padding)",
                bars && tone && new File("res/drawable/mr_scrollbar_thumb.xml").isFile() && read("res/drawable/mr_scrollbar_thumb.xml").contains("@color/mr_scrollbar_thumb"));
        // a layer that has only a stroke is filled with opaque black by GradientDrawable when it is drawn through a colour filter (the keyboard draws the line of the
        // keys through one, to give it its opacity and its hue), so every layer of every key face that has a stroke has a (transparent) solid too
        int faceFiles = 0;
        List<String> bare = new ArrayList<String>();
        File[] drawables = new File("res/drawable").listFiles();
        for (File f : drawables) {
            if (!f.getName().startsWith("key_") || !f.getName().endsWith(".xml")) continue;
            faceFiles++;
            for (String layer : read("res/drawable/" + f.getName()).split("<item")) {
                if (layer.contains("<stroke") && !layer.contains("<solid")) bare.add(f.getName());
            }
        }
        check("every layer of a key face that has a stroke has a solid too (transparent), so that a colour filter cannot fill it with black", faceFiles > 150 && bare.isEmpty());
        if (!bare.isEmpty()) System.out.println("      without a solid: " + bare.subList(0, Math.min(5, bare.size())));
        String arrays = read("res/values/arrays.xml");
        boolean ordered = arrays.indexOf("mr_overlight") > arrays.indexOf("mr_denim") && arrays.indexOf("mr_overdark") > arrays.indexOf("mr_overlight");
        String before = "mr_overdark";
        for (int i = 1; i < MrBackdrop.STYLES; i++) {
            String t = MrBackdrop.STYLE_TAGS[i];
            if (arrays.indexOf(t) <= arrays.indexOf(before)) ordered = false;
            before = t;
        }
        check("they are in the lists of themes after the thirteen of the list, in the order of the values (13 to 31)", arrays.contains("mr_overlight") && ordered);
        check("the class of the crop (MrCropView) is in the build list and its smali is there", read("docs/tools/build_java.sh").contains("MrCropView") && new File("smali/com/mrkeyboard/app/MrCropView.smali").isFile());

        String build = read("docs/tools/build_java.sh");
        boolean listed = true;
        for (String cls : new String[] {"MrKeyLook", "MrColorPicker", "MrColorDot", "MrCappedScroll"}) {
            listed &= build.contains(cls + ",") && new File("smali/com/mrkeyboard/app/" + cls + ".smali").exists();
        }
        check("the classes of the tuning of the keys (MrKeyLook, the picker, its round button and the scroll of the controls) are in the build list and their smali is there", listed);
        String manifest = read("AndroidManifest.xml");
        check("the screen is in the manifest", manifest.contains("com.mrkeyboard.app.MrThemesActivity") || manifest.contains(".MrThemesActivity"));
        String prefsXml = read("res/xml/prefs.xml");
        check("the row of the settings is the one of the themes screen, and the list of names is gone", prefsXml.contains("com.mrkeyboard.app.MrThemeRow") && prefsXml.contains("MrThemesActivity")
                && !prefsXml.matches("(?s).*<ListPreference[^>]*pref_keyboard_layout.*"));
        String sw = read("smali/com/mrkeyboard/app/KeyboardSwitcher.smali");
        check("the keyboard is made again when the background, the softening or the tuning of the keys change (KeyboardSwitcher asks MrKeyLook)", sw.contains("pref_kbd_bg") && sw.contains("pref_kbd_bg_soft")
                && sw.contains("Lcom/mrkeyboard/app/MrKeyLook;->changed(Ljava/lang/String;)Z"));
        String tools = read("smali/com/mrkeyboard/app/MrTools.smali");
        check("the background is put on the keyboard when it is made and shown (MrTools)", tools.contains("Lcom/mrkeyboard/app/MrBackdrop;->apply()V"));
        String reset = read("docs/tools/java/src/com/mrkeyboard/app/MrReset.java");
        check("the settings that reset puts back include the background, the softening and the tuning of the keys", reset.contains("\"pref_kbd_bg\"") && reset.contains("\"pref_kbd_bg_soft\"")
                && reset.contains("\"pref_kbd_look_key\"") && reset.contains("\"pref_kbd_look_edge\"") && reset.contains("\"pref_kbd_look_text\"") && reset.contains("\"pref_kbd_look_hue\"") && reset.contains("\"pref_kbd_look_hue2\""));
        String bottom = read("docs/tools/java/src/com/mrkeyboard/app/MrBottom.java");
        check("the navigation bar asks for the colour of the background (MrBottom)", bottom.contains("MrBackdrop.bottomColor"));
    }

    // ---------------------------------------------------------------- run

    public static void main(String[] args) throws Exception {
        PNG = args.length > 0 ? args[0] : null;
        if (PNG != null) new File(PNG).mkdirs();
        FILES = Files.createTempDirectory("mr_files").toFile();
        CACHE = Files.createTempDirectory("mr_cache").toFile();
        loadResources();
        // the assets of the app: the folder of the project (the WebP files, which the PC cannot decode: they give a pattern of their size); with
        // -Dmr.assets=<folder> the real pictures, as PNG files that have the names of the WebP ones
        android.content.res.AssetManager.stubRoot = new File(System.getProperty("mr.assets", "assets"));
        Canvas.stubBackend = new AwtBackend();
        System.setProperty("java.awt.headless", "true");

        spec();
        cropAndPan();
        frame();
        pixels();
        veil();
        gallery();
        colours();
        previews();
        previewPictures();
        fullKeyboard();
        keyLook();
        suggestionBar();
        styleAudit();
        onKeyboard();
        screen();
        heroAndScroll();
        heroClick();
        dialogLook();
        colourPicker();
        pickerChain();
        crop();
        row();
        files();

        System.out.println();
        System.out.println(ok + " ok, " + fail + " failed");
        if (fail > 0) System.exit(1);
    }
}
