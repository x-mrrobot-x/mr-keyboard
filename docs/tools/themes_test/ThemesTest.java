package com.mrkeyboard.app;

import android.app.Activity;
import android.content.ContentResolver;
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
 * (MrBackdrop.Spec), the part of a picture that fills the keyboard and how a finger moves it (crop, pan), the veil that keeps the toolbar readable
 * over every landscape and gradient for the dark and the light themes (veil, look), the picture of the gallery (importImage: the size, the
 * photo turned, a failure that keeps the old one), the background put on the keyboard (apply, MrBackdropDrawable, bottomColor), the colours of the
 * thirteen themes read from the real res/ files (MrThemeColors), the small keyboards (MrThemePreview: every key and label, the faces made once, the
 * neon light, the ring), the screen (MrThemesActivity: the tiles, the theme and the background chosen apart, the zoom, the drag, the softening, the
 * gallery, remove), the row of the settings (MrThemeRow) and the files (strings in three languages, the manifest, prefs.xml, the smali hooks).
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
        public android.content.res.AssetManager getAssets() { return null; }
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
        public android.content.res.AssetManager getAssets() { return null; }
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
        public void runOnUiThread(Runnable r) { r.run(); }
        public void startActivityForResult(Intent i, int code) {
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

    static boolean waitFor(BooleanSupplier s) throws InterruptedException {
        for (int i = 0; i < 250; i++) {
            if (s.getAsBoolean()) return true;
            Thread.sleep(20);
        }
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

    // ---------------------------------------------------------------- the spec

    static void spec() {
        MrBackdrop.Spec no = MrBackdrop.Spec.parse("");
        check("an empty text is no background", no.kind == MrBackdrop.NONE && no.format().equals(""));
        check("null and one letter are no background", MrBackdrop.Spec.parse(null).kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("g").kind == MrBackdrop.NONE);
        boolean round = true;
        for (int i = 0; i < MrBackdrop.GRADIENTS.length; i++) {
            MrBackdrop.Spec s = MrBackdrop.Spec.parse("g" + i);
            if (s.kind != MrBackdrop.GRADIENT || s.index != i || !s.format().equals("g" + i)) round = false;
        }
        check("each of the " + MrBackdrop.GRADIENTS.length + " gradients is read back as it was written", round && MrBackdrop.GRADIENTS.length == 12);
        round = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            MrBackdrop.Spec s = MrBackdrop.Spec.parse("s" + i);
            if (s.kind != MrBackdrop.SCENE || s.index != i || !s.format().equals("s" + i)) round = false;
        }
        check("each of the " + MrScenes.COUNT + " landscapes is read back as it was written", round);
        check("a gradient or a landscape that is not there is no background",
                MrBackdrop.Spec.parse("g12").kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("g-1").kind == MrBackdrop.NONE
                        && MrBackdrop.Spec.parse("s" + MrScenes.COUNT).kind == MrBackdrop.NONE && MrBackdrop.Spec.parse("s-3").kind == MrBackdrop.NONE);
        MrBackdrop.Spec img = MrBackdrop.Spec.parse("i150,-20,35,1700000000123");
        check("a picture: zoom, position and the time it was chosen", img.kind == MrBackdrop.IMAGE && img.zoom == 150 && img.dx == -20 && img.dy == 35 && img.stamp == 1700000000123L);
        check("a picture is written back the same", img.format().equals("i150,-20,35,1700000000123"));
        MrBackdrop.Spec wild = MrBackdrop.Spec.parse("i999,500,-500,7");
        check("zoom and position are kept inside their limits", wild.zoom == MrBackdrop.ZOOM_MAX && wild.dx == 100 && wild.dy == -100);
        check("a zoom below 100 is 100", MrBackdrop.Spec.parse("i10,0,0,1").zoom == MrBackdrop.ZOOM_MIN);
        String[] bad = {"x1", "gx", "sx", "i1,2,3", "i1,2,3,4,5", "i1,2,3,x", "i,,,", "g1.5", "g 1", "iabc", "G1", "g1 ", "s99999999999999999999"};
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
        check("moved on a gradient changes nothing", MrBackdrop.Spec.gradient(3).moved(300, 1, 1).format().equals("g3"));
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

    // ---------------------------------------------------------------- the pixels of a background

    /** The colour of a CSS linear gradient (angle: 0 up, 90 to the right) at a point of a shape of w x h. */
    static int css(int[] g, double x, double y, int w, int h) {
        double a = Math.toRadians(g[0]);
        double dx = Math.sin(a), dy = -Math.cos(a);
        double len = Math.abs(w * dx) + Math.abs(h * dy);
        double t = 0.5 + ((x - w / 2.0) * dx + (y - h / 2.0) * dy) / len;
        t = Math.max(0, Math.min(1, t));
        int n = g.length - 2;
        double pos = t * n;
        int i = Math.min(n - 1, (int) Math.floor(pos));
        return MrBackdrop.mix(g[1 + i], g[2 + i], (float) (pos - i));
    }

    static void pixels() {
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
        for (int n = 0; n < MrBackdrop.GRADIENTS.length; n++) {
            out = bitmap(240, 100);
            MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(n), 240, 100, null);
            for (int[] pt : new int[][] {{1, 1}, {238, 1}, {1, 98}, {238, 98}, {120, 50}, {60, 25}, {180, 75}, {120, 1}, {120, 98}}) {
                int want = css(MrBackdrop.GRADIENTS[n], pt[0] + 0.5, pt[1] + 0.5, 240, 100);
                if (maxDiff(out.getPixel(pt[0], pt[1]), want) > 4) {
                    formula = false;
                    System.out.println("      gradient " + n + " at " + pt[0] + "," + pt[1] + ": " + Integer.toHexString(out.getPixel(pt[0], pt[1])) + " expected " + Integer.toHexString(want));
                }
            }
        }
        check("the twelve gradients follow their angle and colours as CSS does (nine points of each)", formula);
        out = bitmap(240, 100);
        MrBackdrop.draw(new Canvas(out), MrBackdrop.Spec.gradient(3), 240, 100, null);
        int[] g = MrBackdrop.GRADIENTS[3];
        check("135 degrees starts with the first colour in the top left corner and ends with the last in the bottom right one",
                maxDiff(out.getPixel(0, 0), g[1]) <= 6 && maxDiff(out.getPixel(239, 99), g[2]) <= 6);
        boolean every = true;
        for (int i = 0; i < MrScenes.COUNT; i++) {
            out = bitmap(240, 100);
            MrScenes.draw(new Canvas(out), i, 240, 100);
            int opaque = 0;
            for (int px : out.stubPixels) if ((px >>> 24) == 255) opaque++;
            if (opaque < out.stubPixels.length * 0.98) {
                every = false;
                System.out.println("      scene " + i + ": " + opaque + " of " + out.stubPixels.length + " pixels covered");
            }
        }
        check("each landscape covers the whole of its shape", every);
        Bitmap a = bitmap(240, 100), b = bitmap(240, 100);
        MrScenes.draw(new Canvas(a), 3, 240, 100);
        MrScenes.draw(new Canvas(b), 3, 240, 100);
        check("a landscape looks the same every time it is drawn", java.util.Arrays.equals(a.stubPixels, b.stubPixels));
        out = bitmap(240, 100);
        MrScenes.draw(new Canvas(out), 99, 240, 100);
        MrScenes.draw(new Canvas(out), -1, 240, 100);
        MrScenes.draw(null, 1, 240, 100);
        MrScenes.draw(new Canvas(out), 1, 0, 0);
        check("an unknown landscape, no canvas and no size draw nothing", out.getPixel(5, 5) == 0);
        boolean differ = true;
        for (int i = 0; i < MrScenes.COUNT && differ; i++) {
            for (int j = i + 1; j < MrScenes.COUNT; j++) {
                Bitmap x = bitmap(120, 50), y = bitmap(120, 50);
                MrScenes.draw(new Canvas(x), i, 120, 50);
                MrScenes.draw(new Canvas(y), j, 120, 50);
                if (java.util.Arrays.equals(x.stubPixels, y.stubPixels)) differ = false;
            }
        }
        check("no two landscapes are the same picture", differ);
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
        for (int i = 0; i < MrBackdrop.GRADIENTS.length; i++) specs.add(MrBackdrop.Spec.gradient(i));
        for (MrBackdrop.Spec s : specs) {
            for (int soft : new int[] {0, 25, 70}) {
                for (boolean dark : new boolean[] {true, false}) {
                    MrBackdrop.Look look = MrBackdrop.look(s, null, dark, soft);
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
                    if (look.veilColor != (dark ? 0xff000000 : 0xffffffff) || look.veilAlpha < Math.round(soft * 2.55f) - 1) covered = false;
                    if ((look.bottom >>> 24) != 255) bottomOpaque = false;
                    if (soft == 0 && dark) worstDark = Math.max(worstDark, look.veilAlpha);
                    if (soft == 0 && !dark) worstLight = Math.max(worstLight, look.veilAlpha);
                }
            }
        }
        check("every landscape and gradient is brought to the target brightness, over all of it and over the toolbar at the top, under a dark and a light theme (or to the limit of the veil)", covered);
        check("the colour of the lower edge, for the navigation bar, is opaque", bottomOpaque);
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
        check("no picture kept: none to load, no time", !MrBackdrop.hasImage(c) && MrBackdrop.load(c) == null && MrBackdrop.imageStamp(c) == 0L);

        BitmapFactory.stubWidth = 4000;
        BitmapFactory.stubHeight = 3000;
        int[] size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9, 9, 9}));
        check("a 4000 x 3000 photo is kept at 1280 on its longest side, with its shape", size != null && size[0] == 1280 && size[1] == 960);
        check("the photo was decoded smaller (a power of two) and not at full size", BitmapFactory.stubSamples.size() == 1 && BitmapFactory.stubSamples.get(0) == 2);
        check("it is in the files of the app, and nothing else was left there or in the cache",
                MrBackdrop.hasImage(c) && new File(FILES, MrBackdrop.FILE).length() == 5 && FILES.list().length == 1 && CACHE.list().length == 0);
        check("the kept picture can be loaded and has a time", MrBackdrop.load(c) != null && MrBackdrop.imageStamp(c) > 0L);

        BitmapFactory.stubWidth = 800;
        BitmapFactory.stubHeight = 600;
        BitmapFactory.stubSamples.clear();
        size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9}));
        check("a small picture is kept as it is", size != null && size[0] == 800 && size[1] == 600 && BitmapFactory.stubSamples.get(0) == 1);

        BitmapFactory.stubWidth = 1200;
        BitmapFactory.stubHeight = 4000;
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_90;
        size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9}));
        check("a portrait photo is scaled and then turned the quarter turn it asks for: the sides swap", size != null && size[0] == 1280 && size[1] == 384);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_180;
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 1000;
        size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9}));
        check("a half turn keeps the sides", size != null && size[0] == 1280 && size[1] == 427);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_ROTATE_270;
        size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9}));
        check("three quarters swap them too", size != null && size[0] == 427 && size[1] == 1280);
        ExifInterface.stubOrientation = ExifInterface.ORIENTATION_NORMAL;
        ExifInterface.stubFail = true;
        size = MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {9}));
        check("a photo whose orientation cannot be read is kept as it is", size != null && size[0] == 1280 && size[1] == 427);
        ExifInterface.stubFail = false;

        // a failure leaves what was there
        long stamp = MrBackdrop.imageStamp(c);
        byte[] before = Files.readAllBytes(new File(FILES, MrBackdrop.FILE).toPath());
        BitmapFactory.stubFail = true;
        check("something that is not a picture gives null", MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {1, 2})) == null);
        BitmapFactory.stubFail = false;
        BitmapFactory.stubWidth = 0;
        BitmapFactory.stubHeight = 0;
        check("a picture without size gives null", MrBackdrop.importImage(c, new ByteArrayInputStream(new byte[] {1, 2})) == null);
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 2000;
        check("a stream that breaks gives null", MrBackdrop.importImage(c, new InputStream() {
            public int read() throws IOException { throw new IOException("lost"); }
        }) == null);
        check("what was kept before stays, and no half-written file or copy is left",
                java.util.Arrays.equals(before, Files.readAllBytes(new File(FILES, MrBackdrop.FILE).toPath())) && MrBackdrop.imageStamp(c) == stamp
                        && FILES.list().length == 1 && CACHE.list().length == 0);

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
        check("thirteen themes with a tag, a name and a value each", tags.length == 13 && names.length == 13 && values.length == 13);
        boolean named = true, valued = true;
        for (int i = 0; i < 13; i++) {
            if (names[i] == null || names[i].length() == 0) named = false;
            if (!values[i].equals(String.valueOf(i))) valued = false;
        }
        check("the names are the ones of the list (no empty one) and the values are 0 .. 12", named && valued);
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
        boolean[] dark = new boolean[13];
        for (int i = 0; i < 13; i++) {
            dark[i] = MrThemeColors.dark(c, tags[i]);
            row.append(tags[i].substring(3)).append(dark[i] ? "=dark " : "=light ");
        }
        System.out.println("      " + row);
        boolean[] want = {true, true, true, true, true, true, false, false, false, true, false, true, true};
        check("a theme is dark when its background is: the nine of dark background (Chrome, with dark letters on its keys, and Glass and Denim, which are see-through, among them), not Aqua, Sky, Snow and Rose",
                java.util.Arrays.equals(dark, want));
        int toolInk = MrThemeColors.declared(c, "mr_chrome", "tool_ink");
        check("Chrome, whose keys and background are of opposite brightness, has the ink of its toolbar from tool_ink (light), though its key letters are dark", toolInk != 0
                && MrThemeColors.luminance(toolInk) > 0.5f && MrThemeColors.ink(c, "mr_chrome") == (0xff000000 | toolInk) && MrThemeColors.luminance(MrThemeColors.color(c, "mr_chrome", "text")) < 0.2f);
        check("Sky has pale letters on a light background: it is a light theme, whatever its ink", !dark[7] && MrThemeColors.luminance(MrThemeColors.ink(c, "mr_sky")) > 0.5f);
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
        p.show(tags[1], MrBackdrop.Spec.scene(1), null, 20);
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
        int[] means = new int[13];
        for (int i = 0; i < tags.length; i++) {
            MrThemePreview p = preview(c, 420);
            p.show(tags[i], MrBackdrop.Spec.NO, null, 0);
            sheet.add(draw(p));
            if (i == 4) p.setChecked(true, 0xff1b97fc, 0xffffffff);
        }
        sheet(sheet, 3, "themes");
        // the colour of the theme is the background that every one shows
        boolean bg = true;
        for (int i = 0; i < tags.length; i++) {
            int expect = MrThemeColors.color(c, tags[i], "kbd_bg");
            Bitmap b = sheet.get(i);
            if (maxDiff(b.getPixel(3, 74), expect) > 12 && maxDiff(b.getPixel(210, 4), expect) > 12) {
                bg = false;
                System.out.println("      " + tags[i] + ": " + Integer.toHexString(b.getPixel(210, 4)) + " expected about " + Integer.toHexString(expect));
            }
        }
        check("with no background every preview shows the colour of its theme behind the keys", bg);

        // the backgrounds, under a dark and a light theme
        for (String tag : new String[] {"mr_midnight", "mr_snow", "mr_cyan"}) {
            List<Bitmap> t = new ArrayList<Bitmap>();
            for (int i = 0; i < MrScenes.COUNT; i++) {
                MrThemePreview p = preview(c, 330);
                p.show(tag, MrBackdrop.Spec.scene(i), null, 0);
                t.add(draw(p));
            }
            for (int i = 0; i < MrBackdrop.GRADIENTS.length; i++) {
                MrThemePreview p = preview(c, 330);
                p.show(tag, MrBackdrop.Spec.gradient(i), null, 0);
                t.add(draw(p));
            }
            sheet(t, 3, "backgrounds_" + tag.substring(3));
        }

        // the veil keeps the bar readable: the ink of the toolbar against the background behind it
        boolean contrast = true;
        double worstRatio = 99;
        for (String tag : new String[] {"mr_midnight", "mr_snow", "mr_cyan", "mr_chrome"}) {
            boolean dark = MrThemeColors.dark(c, tag);
            int ink = MrThemeColors.ink(c, tag);
            List<MrBackdrop.Spec> specs = new ArrayList<MrBackdrop.Spec>();
            for (int i = 0; i < MrScenes.COUNT; i++) specs.add(MrBackdrop.Spec.scene(i));
            for (int i = 0; i < MrBackdrop.GRADIENTS.length; i++) specs.add(MrBackdrop.Spec.gradient(i));
            for (MrBackdrop.Spec s : specs) {
                MrThemePreview p = preview(c, 600);
                p.show(tag, s, null, 0);
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
            }
        }
        System.out.println("      the worst contrast of the ink of the toolbar with the bar: " + String.format("%.2f", worstRatio));
        check("over every landscape and gradient the ink of the toolbar keeps a contrast of 3 or more with the bar, for dark and light themes", contrast);

        // a picture of the gallery
        Bitmap ph = photo(800, 500);
        List<Bitmap> t = new ArrayList<Bitmap>();
        int[][] views = {{100, 0, 0}, {200, 0, 0}, {200, -100, -100}, {300, 100, 100}, {100, 0, 0}, {400, 40, -30}};
        for (int i = 0; i < views.length; i++) {
            MrThemePreview p = preview(c, 360);
            p.show(i < 4 ? "mr_midnight" : "mr_snow", MrBackdrop.Spec.image(views[i][0], views[i][1], views[i][2], 1), ph, i == 4 ? 0 : 20);
            t.add(draw(p));
        }
        sheet(t, 3, "picture");
        Bitmap hit = t.get(2);
        check("the picture is under the keys (the frame of its upper left corner shows in the corner of the preview, softened by the veil)",
                MrThemeColors.luminance(hit.getPixel(30, 2)) > 0.2f);
        // the same picture of the same theme and background is drawn from the copy that it kept
        MrThemePreview q = preview(c, 360);
        q.show("mr_midnight", MrBackdrop.Spec.image(100, 0, 0, 1), ph, 0);
        Bitmap one = draw(q), two = draw(q);
        check("drawn again it is the same", java.util.Arrays.equals(one.stubPixels, two.stubPixels));
        q.show("mr_midnight", MrBackdrop.Spec.image(100, 0, 0, 1), null, 0);
        Bitmap without = draw(q);
        check("a picture spec whose picture is not loaded yet shows the colour of the theme", maxDiff(without.getPixel(210, 4), MrThemeColors.color(c, "mr_midnight", "kbd_bg")) <= 12);
        RES.flatFaces = false;
    }

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

        // the lower edge for the navigation bar
        prefs.edit().putString(MrBackdrop.PREF, "g3").apply();
        MrBackdrop.Look dark = MrBackdrop.lookNow(c);
        check("a gradient chosen: its look is measured for the dark theme in use", dark != null && dark.veilColor == 0xff000000);
        check("the navigation bar of Android 15 and earlier takes the colour of the lower edge", MrBackdrop.bottomColor(c) == dark.bottom && (dark.bottom >>> 24) == 255);
        check("the same background is measured once", MrBackdrop.lookNow(c) == dark);
        Build.VERSION.SDK_INT = 36;
        check("from Android 16 the bar is transparent and the keyboard is under it: no colour is asked", MrBackdrop.bottomColor(c) == 0);
        Build.VERSION.SDK_INT = 35;
        check("Android 15 still asks", MrBackdrop.bottomColor(c) == dark.bottom);
        Build.VERSION.SDK_INT = 33;
        MrTheme.stubTag = "mr_snow";
        MrBackdrop.Look lightLook = MrBackdrop.lookNow(c);
        check("a light theme has a white veil, so another look and another edge", lightLook != dark && lightLook.veilColor == 0xffffffff && lightLook.bottom != dark.bottom);
        MrTheme.stubTag = "mr_midnight";
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 40).apply();
        MrBackdrop.Look soft = MrBackdrop.lookNow(c);
        check("a new softening is a new look, never less veil than it", soft != dark && soft.veilAlpha >= Math.round(0.40f * 255f) - 1);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 0).apply();
        prefs.edit().putString(MrBackdrop.PREF, "i100,0,0,11").apply();
        check("a picture that is not there: no look, no colour", MrBackdrop.lookNow(c) == null && MrBackdrop.bottomColor(c) == 0);
        File f = new File(FILES, MrBackdrop.FILE);
        Files.write(f.toPath(), new byte[] {1});
        BitmapFactory.stubWidth = 640;
        BitmapFactory.stubHeight = 480;
        check("the picture arrives: the look is there", MrBackdrop.lookNow(c) != null);
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
        check("a landscape chosen: the drawable is the background of the root of the toolbar and the keyboard view is left clear",
                root.stubBackground instanceof MrBackdropDrawable && kbd.stubBackgroundColor == 0);
        Drawable first = root.stubBackground;
        MrBackdrop.apply();
        check("shown again it is the same drawable (it keeps what it drew)", root.stubBackground == first);
        prefs.edit().putInt(MrBackdrop.PREF_SOFT, 30).apply();
        MrBackdrop.apply();
        check("a new softening makes a new one", root.stubBackground != first && root.stubBackground instanceof MrBackdropDrawable);
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

    static Screen open() {
        Screen s = new Screen();
        s.onCreate((Bundle) null);
        s.mBig.stubSize(1000, 417);
        return s;
    }

    static int checkedTheme(Screen s) {
        int n = -1;
        for (int i = 0; i < s.mThemeTiles.size(); i++) if (s.mThemeTiles.get(i).checked()) n = n == -1 ? i : -2;
        return n;
    }

    static int checkedBackground(Screen s) {
        int n = -1;
        for (int i = 0; i < s.mBgTiles.size(); i++) if (s.mBgTiles.get(i).checked()) n = n == -1 ? i : -2;
        return n;
    }

    static void screen() throws Exception {
        reset();
        Screen s = open();
        String[] names = MrThemeColors.names(s);
        check("the screen has the tiles of the thirteen themes", s.mThemeTiles.size() == 13 && s.mTags.length == 13);
        check("and 20 backgrounds: none, my image, six landscapes and twelve gradients", s.mBgTiles.size() == 20 && s.mBgSpecs.size() == 20);
        check("in that order: none, my image, then the landscapes, then the gradients", s.mBgSpecs.get(0).kind == MrBackdrop.NONE && s.mBgSpecs.get(1).kind == MrBackdrop.IMAGE
                && s.mBgSpecs.get(2).format().equals("s0") && s.mBgSpecs.get(7).format().equals("s5") && s.mBgSpecs.get(8).format().equals("g0") && s.mBgSpecs.get(19).format().equals("g11"));
        check("the theme of the preference is the one chosen, and no background", checkedTheme(s) == 0 && checkedBackground(s) == 0 && s.mSpec.kind == MrBackdrop.NONE);
        check("the caption says the theme", s.mCaption.getText().toString().equals(names[0]));
        check("the controls that do not apply are hidden: no zoom without a picture, no softening without a background, no remove without a picture",
                s.mEditor.getVisibility() == View.GONE && s.mSoftBox.getVisibility() == View.GONE && s.mRemove.getVisibility() == View.GONE);
        check("the tile of my image is hidden until there is a picture", boxOf(s.mMineTile).getVisibility() == View.INVISIBLE);

        s.chooseTheme(5);
        check("a theme chosen is written in the preference the keyboard reads, as it always was", "5".equals(prefs.getString("pref_keyboard_layout", null)) && s.mTheme == 5);
        check("only that tile is chosen", checkedTheme(s) == 5 && s.mCaption.getText().toString().equals(names[5]));
        s.chooseTheme(12);
        check("the last theme", "12".equals(prefs.getString("pref_keyboard_layout", null)) && checkedTheme(s) == 12);
        s.chooseBackground(MrBackdrop.Spec.scene(2));
        check("a landscape chosen is written as s2, and its tile is the one chosen (and no other)", "s2".equals(prefs.getString(MrBackdrop.PREF, null)) && checkedBackground(s) == 4);
        check("the caption says the theme and the background", s.mCaption.getText().toString().equals(names[12] + " · Sea"));
        check("a background shows the softening, and not the zoom of a picture", s.mSoftBox.getVisibility() == View.VISIBLE && s.mEditor.getVisibility() == View.GONE);
        s.chooseBackground(MrBackdrop.Spec.gradient(11));
        check("a gradient: g11", "g11".equals(prefs.getString(MrBackdrop.PREF, null)) && checkedBackground(s) == 19);
        check("the theme did not change with the background", "12".equals(prefs.getString("pref_keyboard_layout", null)) && checkedTheme(s) == 12);
        s.chooseTheme(3);
        check("and the background did not change with the theme", "g11".equals(prefs.getString(MrBackdrop.PREF, null)) && checkedBackground(s) == 19);
        s.chooseBackground(MrBackdrop.Spec.NO);
        check("none is an empty preference and hides the softening", prefs.getString(MrBackdrop.PREF, "x").equals("") && checkedBackground(s) == 0 && s.mSoftBox.getVisibility() == View.GONE);
        check("the caption is the name of the theme again", s.mCaption.getText().toString().equals(names[3]));

        // the softening
        s.chooseBackground(MrBackdrop.Spec.scene(0));
        s.softChanged(35);
        check("moving the slider changes the big keyboard and the text, and writes nothing yet", s.mSoft == 35 && s.mSoftText.getText().toString().equals("35%") && prefs.getInt(MrBackdrop.PREF_SOFT, 0) == 0);
        s.saveSoft();
        check("letting go writes it", prefs.getInt(MrBackdrop.PREF_SOFT, -1) == 35 && s.mSoftBar.getProgress() == 35);
        s.softChanged(999);
        check("the slider cannot go past 70", s.mSoft == 70);
        s.softChanged(-4);
        check("nor below 0", s.mSoft == 0);
        check("the slider has its limits", s.mSoftBar.getMax() == 70 && s.mZoom.getMax() == 300);

        // the strings of the screen
        check("the texts of the screen are the ones of the strings", s.sceneName(s, 0).equals("Dusk") && MrThemesActivity.sceneName(s, 4).equals("Northern lights")
                && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.gradient(4)).equals("Gradient 5") && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.image(100, 0, 0, 1)).equals("My image")
                && MrThemesActivity.backgroundName(s, MrBackdrop.Spec.NO).equals("None"));
        check("a scene that has no name is empty and no exception", MrThemesActivity.sceneName(s, 99).equals(""));

        // the touch on a tile
        reset();
        s = open();
        click(s.mThemeTiles.get(7));
        check("touching the tile of a theme chooses it", "7".equals(prefs.getString("pref_keyboard_layout", null)) && checkedTheme(s) == 7);
        click(s.mBgTiles.get(9));
        check("touching the tile of a background chooses it (the third of the gradients: g1)", "g1".equals(prefs.getString(MrBackdrop.PREF, null)) && checkedBackground(s) == 9);
        click(s.mBgTiles.get(0));
        check("touching none takes the background off", prefs.getString(MrBackdrop.PREF, "x").equals("") && checkedBackground(s) == 0);
        check("each tile has its name for the screen readers", boxOf(s.mThemeTiles.get(2)).getContentDescription().toString().equals(names[2])
                && boxOf(s.mBgTiles.get(3)).getContentDescription().toString().equals("Dunes") && boxOf(s.mBgTiles.get(12)).getContentDescription().toString().equals("Gradient 5"));
        View gal = find(s.content, "Gallery");
        check("the tile of the gallery is there and opens it", gal != null && gal.performClick() && s.started != null && s.startedCode == 71);
        check("the screen is one scroll of everything", s.content != null);
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

    static void gallery2() throws Exception {
        reset();
        Screen s = open();
        s.pick();
        check("the gallery is opened to pick a picture (a document of any image type)", s.started != null && Intent.ACTION_OPEN_DOCUMENT.equals(s.started.getAction()) && s.startedCode == 71);

        // not chosen: nothing changes
        s.onActivityResult(71, 0, new Chosen(new android.net.Uri()));
        s.onActivityResult(70, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        s.onActivityResult(71, Activity.RESULT_OK, null);
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(null));
        Thread.sleep(100);
        check("a cancelled pick, another request, no answer and no picture change nothing", prefs.getString(MrBackdrop.PREF, "").equals("") && !MrBackdrop.hasImage(s));

        // an image
        BitmapFactory.stubWidth = 3000;
        BitmapFactory.stubHeight = 2000;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        check("the picture is read, kept, and becomes the background (centred, not zoomed)",
                waitFor(() -> prefs.getString(MrBackdrop.PREF, "").startsWith("i100,0,0,")) && MrBackdrop.hasImage(s));
        check("and it is loaded for the big keyboard and the tiles (the small copy is at most 320)",
                waitFor(() -> s.mImage != null && s.mThumb != null) && s.mThumb.getWidth() <= 320 && s.mThumb.getHeight() <= 320);
        check("the zoom and the remove button appear, and so does the tile of my image", waitFor(() -> s.mEditor.getVisibility() == View.VISIBLE)
                && s.mRemove.getVisibility() == View.VISIBLE && boxOf(s.mMineTile).getVisibility() == View.VISIBLE);
        check("my image is the tile that is chosen", checkedBackground(s) == 1 && s.mCaption.getText().toString().endsWith(" · My image"));
        check("a thread that is not the screen's changed nothing else", s.mSpec.kind == MrBackdrop.IMAGE && s.mSpec.stamp > 0L);

        // the zoom
        s.zoomChanged(250);
        check("zooming shows at once on the big keyboard and in the text, and writes nothing", s.mSpec.zoom == 250 && s.mZoomText.getText().toString().equals("250%") && prefs.getString(MrBackdrop.PREF, "").startsWith("i100,"));
        s.saveSpec();
        check("letting go writes zoom 250 with the same position and time", prefs.getString(MrBackdrop.PREF, "").startsWith("i250,0,0,") && s.mZoom.getProgress() == 150);
        s.zoomChanged(5000);
        check("the zoom stops at 400", s.mSpec.zoom == 400);
        s.zoomChanged(250);

        // the drag
        MotionEvent down = MotionEvent.obtain(MotionEvent.ACTION_DOWN, 500f, 200f);
        check("a finger on the big keyboard takes the touch while there is a picture", s.drag(s.mBig, down));
        s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_MOVE, 600f, 200f));
        check("moving it to the right moves the picture (the position goes to the left)", s.mSpec.dx < 0 && s.mSpec.zoom == 250);
        int dx = s.mSpec.dx;
        String written = prefs.getString(MrBackdrop.PREF, "");
        s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_MOVE, 650f, 260f));
        check("the preference is written when the finger lets go, not on every step", prefs.getString(MrBackdrop.PREF, "").equals(written) && s.mSpec.dx < dx);
        s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_UP, 650f, 260f));
        check("lifted: it is written with the new position, and the same time", prefs.getString(MrBackdrop.PREF, "").equals(s.mSpec.format()) && s.mSpec.stamp == MrBackdrop.Spec.parse(written).stamp);
        check("a move without a finger down is ignored", !s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_MOVE, 10f, 10f)) && !s.mDragging);
        s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_DOWN, 100f, 100f));
        String before = prefs.getString(MrBackdrop.PREF, "");
        s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_CANCEL, 100f, 100f));
        check("a touch that is cancelled ends the drag and keeps where it got to", !s.mDragging && prefs.getString(MrBackdrop.PREF, "").equals(before));
        s.chooseBackground(MrBackdrop.Spec.gradient(2));
        check("with a gradient chosen the big keyboard does not take the touch (the page scrolls)", !s.drag(s.mBig, MotionEvent.obtain(MotionEvent.ACTION_DOWN, 100f, 100f)));

        // the tile of my image keeps its zoom and position
        s.chooseBackground(MrBackdrop.Spec.image(100, 0, 0, 0L));
        check("choosing my image takes the picture that is kept, centred, with the time of the file", s.mSpec.kind == MrBackdrop.IMAGE && s.mSpec.stamp == MrBackdrop.imageStamp(s)
                && prefs.getString(MrBackdrop.PREF, "").equals(s.mSpec.format()));
        s.zoomChanged(300);
        s.chooseBackground(MrBackdrop.Spec.image(100, 0, 0, 0L));
        check("choosing it again keeps the zoom and the position it has", s.mSpec.zoom == 300);

        // a failure
        String kept = prefs.getString(MrBackdrop.PREF, "");
        s.imported(false);
        check("a picture that could not be read: the choice stays as it was", prefs.getString(MrBackdrop.PREF, "").equals(kept));
        s.unreadable = true;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        Thread.sleep(150);
        check("a document that cannot be opened: the choice stays as it was", prefs.getString(MrBackdrop.PREF, "").equals(kept) && MrBackdrop.hasImage(s));
        s.unreadable = false;
        BitmapFactory.stubFail = true;
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        Thread.sleep(150);
        BitmapFactory.stubFail = false;
        check("a file that is not a picture: the choice and the old picture stay", prefs.getString(MrBackdrop.PREF, "").equals(kept) && MrBackdrop.hasImage(s));
        s.finishing = true;
        s.imported(true);
        s.finishing = false;
        check("a screen that is closing ignores the answer", prefs.getString(MrBackdrop.PREF, "").equals(kept));

        // a screen opened again with the picture kept
        Screen again = open();
        check("opened again: the choice is the one kept, and the picture loads", again.mSpec.kind == MrBackdrop.IMAGE && waitFor(() -> again.mImage != null && again.mThumb != null)
                && again.mEditor.getVisibility() == View.VISIBLE);
        again.onDestroy();
        check("closed: the pictures are let go", again.mImage == null && again.mThumb == null);

        // remove
        s.softChanged(20);
        s.removeImage();
        check("remove: the file is gone, the background is none, the preference is empty", !MrBackdrop.hasImage(s) && s.mSpec.kind == MrBackdrop.NONE
                && prefs.getString(MrBackdrop.PREF, "x").equals("") && s.mImage == null && s.mThumb == null);
        check("the zoom and the remove button are hidden again", s.mEditor.getVisibility() == View.GONE && s.mRemove.getVisibility() == View.GONE
                && boxOf(s.mMineTile).getVisibility() == View.INVISIBLE);
        // remove while another background is chosen: it stays
        s.picture = new byte[] {5};
        s.onActivityResult(71, Activity.RESULT_OK, new Chosen(new android.net.Uri()));
        check("a picture again", waitFor(() -> s.mImage != null && MrBackdrop.hasImage(s)));
        s.chooseBackground(MrBackdrop.Spec.scene(1));
        s.removeImage();
        check("removing the picture while a landscape is chosen keeps the landscape", "s1".equals(prefs.getString(MrBackdrop.PREF, "")) && s.mSpec.kind == MrBackdrop.SCENE && !MrBackdrop.hasImage(s));

        // a screen opened with a saved picture that is gone
        reset();
        prefs.edit().putString(MrBackdrop.PREF, "i150,3,4,99").apply();
        Screen gone = open();
        check("a choice of a picture that is gone: the big keyboard shows the colour of the theme and the controls of a picture are there to be used",
                gone.mImage == null && gone.mThumb == null);
        // a saved theme that is not any theme
        reset();
        prefs.edit().putString("pref_keyboard_layout", "99").apply();
        Screen odd = open();
        check("a theme value that is not any theme is the first one", odd.mTheme == 0 && checkedTheme(odd) == 0);
        reset();
        prefs.edit().putString(MrBackdrop.PREF, "nonsense").apply();
        check("a background that does not parse is none", open().mSpec.kind == MrBackdrop.NONE);

        // the small copy
        check("the thumbnail of a small picture is the picture", MrThemesActivity.thumb(bitmap(100, 50)).getWidth() == 100);
        Bitmap th = MrThemesActivity.thumb(bitmap(1280, 640));
        check("the small copy keeps the shape and is at most 320", th.getWidth() == 320 && th.getHeight() == 160);
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
        check("with a background, after a dot", MrThemeRow.summary(c).equals(names[5] + " · Forest"));
        prefs.edit().putString(MrBackdrop.PREF, "g0").apply();
        check("a gradient has its number", MrThemeRow.summary(c).equals(names[5] + " · Gradient 1"));
        prefs.edit().putString(MrBackdrop.PREF, "i100,0,0,5").apply();
        check("a picture is my image", MrThemeRow.summary(c).equals(names[5] + " · My image"));
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
        String strings = read("res/values/mr_strings.xml");
        String[] names = {"mr_themes_title", "mr_themes_themes", "mr_themes_backgrounds", "mr_themes_landscapes", "mr_themes_gradients", "mr_themes_none", "mr_themes_gallery",
                "mr_themes_mine", "mr_themes_soften", "mr_themes_soften_hint", "mr_themes_zoom", "mr_themes_drag", "mr_themes_remove", "mr_themes_image_failed", "mr_themes_gradient",
                "mr_themes_scene_0", "mr_themes_scene_1", "mr_themes_scene_2", "mr_themes_scene_3", "mr_themes_scene_4", "mr_themes_scene_5"};
        check("the screen has 21 texts", names.length == 21);
        boolean all = true;
        for (String lang : new String[] {"en", "es", "pt-rBR"}) {
            Map<String, String> m = lang.equals("en") ? STRINGS : LANG.get(lang);
            for (String n : names) {
                String v = m.get(n);
                if (v == null || v.length() == 0) {
                    all = false;
                    System.out.println("      " + lang + " lacks " + n);
                } else if (n.equals("mr_themes_gradient") && !v.contains("%1$d")) {
                    all = false;
                    System.out.println("      " + lang + " " + n + " has no number");
                }
            }
        }
        check("every text is there in English, Spanish and Portuguese, and the gradient has its number in each", all);
        boolean distinct = true;
        for (String n : names) {
            if (n.equals("mr_themes_gradient")) continue;
            if (LANG.get("pt-rBR").get(n).equals(STRINGS.get(n)) && n.startsWith("mr_themes_s") && !n.startsWith("mr_themes_scene")) distinct = false;
        }
        check("the texts are translated, not copied", distinct && !LANG.get("es").get("mr_themes_backgrounds").equals(STRINGS.get("mr_themes_backgrounds"))
                && !LANG.get("pt-rBR").get("mr_themes_backgrounds").equals(STRINGS.get("mr_themes_backgrounds")));

        String manifest = read("AndroidManifest.xml");
        check("the screen is in the manifest", manifest.contains("com.mrkeyboard.app.MrThemesActivity") || manifest.contains(".MrThemesActivity"));
        String prefsXml = read("res/xml/prefs.xml");
        check("the row of the settings is the one of the themes screen, and the list of names is gone", prefsXml.contains("com.mrkeyboard.app.MrThemeRow") && prefsXml.contains("MrThemesActivity")
                && !prefsXml.matches("(?s).*<ListPreference[^>]*pref_keyboard_layout.*"));
        String sw = read("smali/com/mrkeyboard/app/KeyboardSwitcher.smali");
        check("the keyboard is made again when the background or the softening change (KeyboardSwitcher)", sw.contains("pref_kbd_bg") && sw.contains("pref_kbd_bg_soft"));
        String tools = read("smali/com/mrkeyboard/app/MrTools.smali");
        check("the background is put on the keyboard when it is made and shown (MrTools)", tools.contains("Lcom/mrkeyboard/app/MrBackdrop;->apply()V"));
        String reset = read("docs/tools/java/src/com/mrkeyboard/app/MrReset.java");
        check("the settings that reset puts back include the background and the softening", reset.contains("\"pref_kbd_bg\"") && reset.contains("\"pref_kbd_bg_soft\""));
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
        Canvas.stubBackend = new AwtBackend();
        System.setProperty("java.awt.headless", "true");

        spec();
        cropAndPan();
        pixels();
        veil();
        gallery();
        colours();
        previews();
        previewPictures();
        onKeyboard();
        screen();
        gallery2();
        row();
        files();

        System.out.println();
        System.out.println(ok + " ok, " + fail + " failed");
        if (fail > 0) System.exit(1);
    }
}
