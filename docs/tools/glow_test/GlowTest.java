package com.mrkeyboard.app;

import android.content.ContextWrapper;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.LayerDrawable;
import android.preference.PreferenceManager;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.TextView;

/**
 * The neon look of the keyboard themes (MrGlow): a theme without the flag is drawn as before, a neon theme gets the
 * light of the labels (dead keys included), icons, dash and preview letter, and a spectrum theme gets the hue of each key from its
 * position (face, label, icon, hint letters and dash), except in the popup of variants.
 */
public class GlowTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final int GREEN = 0xff00e676, PINK = 0xffff2bd6, DASH_OFF = 0xff044d29, DASH_ON = 0xff4dee9f, DASH_LOCK = 0xffff6a5c;
    static final int TEXT = 0xffb8f8d9;     // GREEN with 72% of white
    static final int HINT = 0x9e8cf4c1;

    /** A keyboard view of 1000 x 400 on a screen of the given density. */
    static class Kbd extends View {
        final float density;
        Kbd(float density, boolean tagged) {
            this.density = density;
            stubSize(1000, 400);
            if (tagged) setTag("mr_test");
        }
        public Resources getResources() {
            return new Resources() {
                public DisplayMetrics getDisplayMetrics() {
                    DisplayMetrics m = new DisplayMetrics();
                    m.density = density;
                    return m;
                }
            };
        }
    }

    static class Bubble extends TextView {
        Bubble() { super(null); }
        public Resources getResources() {
            return new Resources() {
                public DisplayMetrics getDisplayMetrics() {
                    DisplayMetrics m = new DisplayMetrics();
                    m.density = 2f;
                    return m;
                }
            };
        }
    }

    static void theme(String tag, boolean glow, boolean spectrum) {
        MrTheme.stubTag = tag;
        MrTheme.stubGlow = glow;
        MrTheme.stubSpectrum = spectrum;
        MrTheme.stubColors.clear();
        MrTheme.stubColors.put("glow", GREEN);
        MrTheme.stubColors.put("accent_glow", PINK);
        MrTheme.stubColors.put("modifier_indicator_off", DASH_OFF);
        MrTheme.stubColors.put("modifier_indicator_lock", DASH_LOCK);
        MrTheme.stubColors.put("spectrum_start", 0xffff0000);
        MrTheme.stubColors.put("spectrum_mid", 0xff00ff00);
        MrTheme.stubColors.put("spectrum_end", 0xff0000ff);
    }

    static Paint paint(int color, float size) {
        Paint p = new Paint(0);
        p.setColor(color);
        p.setTextSize(size);
        return p;
    }

    static Keyboard.Key keyAt(int x, int y) { return new Keyboard.Key('a', x, y, 100, 100); }

    static boolean near(int a, int b, int tol) {
        for (int shift = 0; shift <= 24; shift += 8) {
            if (Math.abs(((a >> shift) & 0xff) - ((b >> shift) & 0xff)) > tol) return false;
        }
        return true;
    }

    static int mix(int a, int b, float t) {
        int out = 0xff000000;
        for (int shift = 0; shift <= 16; shift += 8) {
            int x = (a >> shift) & 0xff, y = (b >> shift) & 0xff;
            out |= Math.round(x + (y - x) * t) << shift;
        }
        return out;
    }

    static String hex(int c) { return Integer.toHexString(c); }


    /** A preferences file that is only a map (what the PC tests need of it). */
    static class Map2 implements SharedPreferences {
        final java.util.Map<String, Object> m = new java.util.HashMap<String, Object>();
        public java.util.Map<String, ?> getAll() { return m; }
        public String getString(String key, String def) { Object o = m.get(key); return o == null ? def : (String) o; }
        public int getInt(String key, int def) { Object o = m.get(key); return o == null ? def : ((Integer) o).intValue(); }
        public long getLong(String key, long def) { Object o = m.get(key); return o == null ? def : ((Long) o).longValue(); }
        public boolean getBoolean(String key, boolean def) { Object o = m.get(key); return o == null ? def : ((Boolean) o).booleanValue(); }
        public Editor edit() {
            return new Editor() {
                public Editor putString(String k, String v) { m.put(k, v); return this; }
                public Editor putInt(String k, int v) { m.put(k, Integer.valueOf(v)); return this; }
                public Editor putLong(String k, long v) { m.put(k, Long.valueOf(v)); return this; }
                public Editor putBoolean(String k, boolean v) { m.put(k, Boolean.valueOf(v)); return this; }
                public Editor remove(String k) { m.remove(k); return this; }
                public boolean commit() { return true; }
                public void apply() { }
            };
        }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
    }

    /** A layer of a face that remembers every colour filter it was given. */
    static class Layer extends Drawable {
        final java.util.List<ColorFilter> seen = new java.util.ArrayList<ColorFilter>();
        @Override
        public void setColorFilter(ColorFilter f) { super.setColorFilter(f); seen.add(f); }
    }

    static float alphaOf(ColorFilter f) { return ((ColorMatrixColorFilter) f).stubMatrix[18]; }

    static void keyLook(Kbd kbd, Drawable face) {
        Map2 prefs = new Map2();
        PreferenceManager.stubDefault = prefs;
        MrTools.sApp = new ContextWrapper(null);
        Keyboard.Key key = keyAt(500, 200);

        // nothing tuned: what the theme gives
        theme("mr_overice", false, false);
        MrKeyLook.invalidate();
        MrGlow.reset();
        Paint label = paint(TEXT, 60f);
        MrGlow.key(kbd, key, false, label);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("a theme of the backgrounds with nothing tuned: the letters and the face are the theme's", label.getColor() == TEXT && KeyStyle.stubDrawn.size() == 1 && KeyStyle.stubDrawn.get(0) == null
                && MrGlow.iconFilter(null) == null);

        // the colour of the letters
        prefs.edit().putInt(MrKeyLook.PREF_TEXT, 0xffff8800).apply();
        MrKeyLook.changed(MrKeyLook.PREF_TEXT);
        label = paint(TEXT, 60f);
        MrGlow.key(kbd, key, false, label);
        Paint hint = paint(HINT, 20f);
        MrGlow.hint(hint, HINT);
        check("the colour of the letters that the person chose is the one of the labels", label.getColor() == 0xffff8800);
        check("the small letters take it too, fainter than the labels", (hint.getColor() & 0xffffff) == 0xff8800 && (hint.getColor() >>> 24) < 0xff && (hint.getColor() >>> 24) > 0x40);
        check("and the icons are drawn in it", MrGlow.iconFilter(null) instanceof PorterDuffColorFilter && ((PorterDuffColorFilter) MrGlow.iconFilter(null)).stubColor == 0xffff8800);
        Paint accentLabel = paint(0xff112233, 60f);
        MrGlow.key(kbd, keyAt(10, 10), true, accentLabel);
        check("a highlight key has it as well", accentLabel.getColor() == 0xffff8800);
        check("the toolbar takes it for its text and its icons (MrTools.wrap asks), and a fainter one of it for its secondary text", MrGlow.toolInk() == 0xffff8800
                && (MrGlow.toolHint(0xffff8800) & 0xffffff) == 0xff8800 && (MrGlow.toolHint(0xffff8800) >>> 24) < 0xff && (MrGlow.toolHint(0xffff8800) >>> 24) > 0x40);
        theme("mr_plain", false, false);
        MrGlow.reset();
        Paint plain = paint(TEXT, 60f);
        MrGlow.key(kbd, key, false, plain);
        check("a theme of the list does not read it (the preference may be left from a background)", plain.getColor() == TEXT && MrGlow.iconFilter(null) == null && MrGlow.toolInk() == 0);
        theme("mr_overice", false, false);
        MrGlow.reset();

        // opacity of the face and of the line
        prefs.edit().putInt(MrKeyLook.PREF_TEXT, 0).putInt(MrKeyLook.PREF_KEY, 50).putInt(MrKeyLook.PREF_EDGE, 200).apply();
        MrKeyLook.changed(MrKeyLook.PREF_KEY);
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Layer fill = new Layer(), line = new Layer();
        LayerDrawable two = new LayerDrawable(new Drawable[] {fill, line});
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(two, new Canvas(), 100, 100);
        check("the face of two layers is drawn with the fill at half of its opacity and the line at twice (each layer has its own filter)",
                fill.seen.size() == 2 && line.seen.size() == 2 && alphaOf(fill.seen.get(0)) == 0.5f && alphaOf(line.seen.get(0)) == 2f);
        check("both filters are taken off afterwards (a face is shared by the keys)", fill.seen.get(1) == null && line.seen.get(1) == null && two.stubFilter == null);
        Layer under = new Layer(), fill2 = new Layer(), line2 = new Layer();
        MrGlow.drawKey(new LayerDrawable(new Drawable[] {under, fill2, line2}), new Canvas(), 100, 100);
        check("of a face of more layers only the last two are the fill and the line", under.seen.size() == 1 && under.seen.get(0) == null && alphaOf(fill2.seen.get(0)) == 0.5f && alphaOf(line2.seen.get(0)) == 2f);
        Layer one = new Layer();
        MrGlow.drawKey(one, new Canvas(), 100, 100);
        check("a face of one layer (the clear glass) goes through the opacity of the fill", alphaOf(one.seen.get(0)) == 0.5f && one.seen.get(1) == null);
        prefs.edit().putInt(MrKeyLook.PREF_KEY, 100).putInt(MrKeyLook.PREF_EDGE, 100).apply();
        MrKeyLook.changed(MrKeyLook.PREF_EDGE);
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        KeyStyle.stubDrawn.clear();
        Layer a = new Layer(), b = new Layer();
        MrGlow.drawKey(new LayerDrawable(new Drawable[] {a, b}), new Canvas(), 100, 100);
        check("back to the opacity of the theme: the face is drawn as before (no filter on any layer)", a.seen.isEmpty() && b.seen.isEmpty() && KeyStyle.stubDrawn.size() == 1);

        // the colour of the line: the line of the style is hidden (the keyboard draws the colour that was chosen itself) and the fill keeps its own filter
        prefs.edit().putInt(MrKeyLook.PREF_LINE, 0xff3366ff).apply();
        MrKeyLook.changed(MrKeyLook.PREF_LINE);
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Layer lf = new Layer(), ll = new Layer();
        MrGlow.drawKey(new LayerDrawable(new Drawable[] {lf, ll}), new Canvas(), 100, 100);
        check("with a colour of the line chosen the face is drawn tuned (the line only is hidden: alpha 0) even at the opacities of the style",
                lf.seen.size() == 2 && ll.seen.size() == 2 && alphaOf(lf.seen.get(0)) == 1f && alphaOf(ll.seen.get(0)) == 0f && lf.seen.get(1) == null && ll.seen.get(1) == null);
        Layer glass = new Layer();
        MrGlow.drawKey(glass, new Canvas(), 100, 100);
        check("a face of one layer (the clear glass) is drawn through the fill's filter, and the line over it", glass.seen.size() == 2 && alphaOf(glass.seen.get(0)) == 1f);
        prefs.edit().putInt(MrKeyLook.PREF_LINE, 0).apply();
        MrKeyLook.changed(MrKeyLook.PREF_LINE);
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Layer na = new Layer(), nb = new Layer();
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(new LayerDrawable(new Drawable[] {na, nb}), new Canvas(), 100, 100);
        check("automatic again: the face is drawn as the style has it", na.seen.isEmpty() && nb.seen.isEmpty() && KeyStyle.stubDrawn.size() == 1);
        prefs.edit().putInt(MrKeyLook.PREF_KEY, 999).apply();
        MrKeyLook.changed(MrKeyLook.PREF_KEY);
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Layer c1 = new Layer();
        MrGlow.drawKey(c1, new Canvas(), 100, 100);
        check("the opacity is at most 250% of the theme's", alphaOf(c1.seen.get(0)) == 2.5f);

        // the dash that is off is faint on a theme of the backgrounds and as it is on any other
        prefs.edit().putInt(MrKeyLook.PREF_KEY, 100).apply();
        MrKeyLook.changed(MrKeyLook.PREF_KEY);
        MrGlow.reset();
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Paint off = paint(DASH_OFF, 0f);
        MrGlow.dash(off);
        check("the dash that is off is its colour at 45% of the opacity on a theme of the backgrounds", (off.getColor() & 0xffffff) == (DASH_OFF & 0xffffff)
                && Math.abs((off.getColor() >>> 24) - Math.round(255 * MrKeyLook.DASH_OFF_SHARE)) <= 1);
        Paint on = paint(DASH_ON, 0f);
        MrGlow.dash(on);
        Paint lock = paint(DASH_LOCK, 0f);
        MrGlow.dash(lock);
        check("the dash that is on and the one that is locked are as they were", on.getColor() == DASH_ON && lock.getColor() == DASH_LOCK);
        theme("mr_plain", false, false);
        MrGlow.reset();
        MrGlow.key(kbd, key, false, paint(TEXT, 60f));
        Paint offPlain = paint(DASH_OFF, 0f);
        MrGlow.dash(offPlain);
        check("on a theme of the list the dash that is off is as it was", offPlain.getColor() == DASH_OFF);

        // the styles of the person's own colour: the hues come from the look
        theme("mr_overownglass", true, true);
        MrTheme.stubColors.put("glow", 0x006f7bff);
        MrTheme.stubColors.put("accent_glow", 0x006f7bff);
        MrTheme.stubColors.put("spectrum_start", MrBackdrop.OWN_DEFAULT);
        MrTheme.stubColors.put("spectrum_mid", MrBackdrop.OWN_DEFAULT);
        MrTheme.stubColors.put("spectrum_end", MrBackdrop.OWN_DEFAULT);
        prefs.edit().putInt(MrKeyLook.PREF_HUE, 0x00cc3322).putInt(MrKeyLook.PREF_TEXT, 0).apply();
        MrKeyLook.changed(MrKeyLook.PREF_HUE);
        MrGlow.reset();
        Paint inkOwn = paint(0xff808080, 60f);
        MrGlow.key(kbd, key, false, inkOwn);
        KeyStyle.stubDrawn.clear();
        Layer own1 = new Layer();
        MrGlow.drawKey(own1, new Canvas(), 100, 100);
        check("a style of the person's own colour draws the face through the filter that moves its hue (and nothing is lit: its glow is clear)", own1.stubFilter == null && KeyStyle.stubDrawn.size() == 1
                && KeyStyle.stubDrawn.get(0) instanceof ColorMatrixColorFilter);
        Canvas cv = new Canvas();
        MrGlow.bloom(cv, "a", 0f, 0f, inkOwn);
        check("it has no light under the letters", cv.stubTexts.isEmpty());
        int[] glassSpectrum = MrKeyLook.spectrum("mr_overownglass", MrKeyLook.current(MrTools.sApp));
        check("its three hues are the colour that was picked", glassSpectrum != null && glassSpectrum[0] == 0xffcc3322 && glassSpectrum[1] == 0xffcc3322 && glassSpectrum[2] == 0xffcc3322);
        int[] noRoles = MrKeyLook.spectrum("mr_overice", MrKeyLook.current(MrTools.sApp));
        check("a style that is not of the own colour has no hues from the look", noRoles == null && MrKeyLook.spectrum("mr_overlight", MrKeyLook.current(MrTools.sApp)) == null && MrKeyLook.spectrum(null, null) == null);
        prefs.edit().putInt(MrKeyLook.PREF_HUE, 0x0000aa44).putInt(MrKeyLook.PREF_HUE2, 0x00aa00cc).apply();
        MrKeyLook.changed(MrKeyLook.PREF_HUE2);
        int[] grad = MrKeyLook.spectrum("mr_overowngrad", MrKeyLook.current(MrTools.sApp));
        check("a gradient of the own colour goes from the first colour to the second", grad != null && grad[0] == 0xff00aa44 && grad[2] == 0xffaa00cc && grad[1] != grad[0] && grad[1] != grad[2]);
        prefs.edit().putInt(MrKeyLook.PREF_HUE2, 0).apply();
        MrKeyLook.changed(MrKeyLook.PREF_HUE2);
        int[] auto = MrKeyLook.spectrum("mr_overowngrad", MrKeyLook.current(MrTools.sApp));
        check("without a second colour the keyboard makes one up, a turn of the hue away from the first", auto != null && auto[0] == 0xff00aa44 && auto[2] != auto[0] && (auto[2] >>> 24) == 0xff);
        // the face of such a theme at two places of the keyboard has two hues only in the gradient
        MrGlow.reset();
        theme("mr_overowngrad", true, true);
        MrTheme.stubColors.put("glow", 0x666f7bff);
        MrTheme.stubColors.put("accent_glow", 0x666f7bff);
        MrTheme.stubColors.put("spectrum_start", MrBackdrop.OWN_DEFAULT);
        MrTheme.stubColors.put("spectrum_mid", MrBackdrop.OWN_DEFAULT);
        MrTheme.stubColors.put("spectrum_end", MrBackdrop.OWN_DEFAULT);
        MrKeyLook.invalidate();
        MrGlow.reset();
        Paint lp = paint(0xff808080, 60f);
        MrGlow.key(kbd, keyAt(0, 0), false, lp);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(new Layer(), new Canvas(), 100, 100);
        ColorFilter left = KeyStyle.stubDrawn.get(0);
        MrGlow.key(kbd, keyAt(900, 300), false, paint(0xff808080, 60f));
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(new Layer(), new Canvas(), 100, 100);
        ColorFilter right = KeyStyle.stubDrawn.get(0);
        check("the gradient of the own colour has another hue at each end of the keyboard", left != null && right != null
                && !java.util.Arrays.equals(((ColorMatrixColorFilter) left).stubMatrix, ((ColorMatrixColorFilter) right).stubMatrix));
        // when the colour moves the keyboard makes its hues again
        int before = MrKeyLook.version();
        prefs.edit().putInt(MrKeyLook.PREF_HUE, 0x00ff0000).apply();
        MrKeyLook.changed(MrKeyLook.PREF_HUE);
        check("a change of a preference of the look is told to the keyboard (and any other key is not)", MrKeyLook.version() == before + 1 && !MrKeyLook.changed("pref_kbd_bg") && !MrKeyLook.changed(null)
                && MrKeyLook.version() == before + 1);
        MrGlow.reset();
        MrKeyLook.invalidate();
    }

    public static void main(String[] a) {
        Drawable face = new Drawable() { };
        ColorFilter own = new ColorFilter();

        // ================= a theme without the flag: everything as before
        theme("mr_plain", false, false);
        MrGlow.reset();
        Kbd kbd = new Kbd(3f, true);
        Paint label = paint(TEXT, 60f);
        label.setShadowLayer(2f, 0f, 0f, 0x55000000);          // the theme's own shadow, set by the keyboard
        Paint hint = paint(HINT, 20f);
        MrGlow.key(kbd, keyAt(0, 0), false, label);
        MrGlow.hint(hint, HINT);
        check("plain theme: the colour of the label is left alone", label.getColor() == TEXT);
        check("plain theme: the colour of the hint letters is left alone", hint.getColor() == HINT);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("plain theme: the face is drawn by KeyStyle with no colour filter",
                KeyStyle.stubDrawn.size() == 1 && KeyStyle.stubDrawn.get(0) == null && face.stubFilter == null);
        Canvas c = new Canvas();
        MrGlow.bloom(c, "a", 10f, 20f, label);
        check("plain theme: no extra drawing under the label", c.stubTexts.isEmpty());
        check("plain theme: the shadow of the label is the theme's own",
                label.stubShadowRadius == 2f && label.stubShadowColor == 0x55000000);
        MrGlow.edge(label);
        check("plain theme: the label of a dead key keeps the theme's own shadow too",
                label.stubShadowRadius == 2f && label.stubShadowColor == 0x55000000);
        ShadowDrawHelper.stubRadius = -1f;
        ShadowDrawHelper.stubFilter = null;
        MrGlow.icon(c, face, keyAt(0, 0), 4.5f, own);
        check("plain theme: the icon has no outline or shadow of any kind (the helper is not called)",
                ShadowDrawHelper.stubRadius == -1f && ShadowDrawHelper.stubFilter == null);
        check("plain theme: the icon keeps its colour filter", MrGlow.iconFilter(own) == own && MrGlow.iconFilter(null) == null);
        Paint dash = paint(DASH_ON, 0f);
        dash.setShadowLayer(9f, 0f, 0f, GREEN);                // left over from a neon theme
        MrGlow.dash(dash);
        check("plain theme: the dash has no light, even after a neon theme", dash.stubShadowRadius == 0f && dash.getColor() == DASH_ON);
        Bubble bubble = new Bubble();
        MrGlow.preview(bubble);
        check("plain theme: the letter of the preview bubble has no light", bubble.stubShadowRadius == 0f);

        // ================= a neon theme
        theme("mr_neon", true, false);
        label = paint(TEXT, 60f);
        MrGlow.key(kbd, keyAt(0, 0), false, label);
        MrGlow.hint(hint, HINT);
        check("neon: the colour of the label and of the hint letters is the theme's", label.getColor() == TEXT && hint.getColor() == HINT);
        c = new Canvas();
        MrGlow.bloom(c, "a", 10f, 20f, label);
        // density 3: wide = 60 * 0.30 = 18 px (between 9 and 21); tight = 60 * 0.085 = 5.1 px (between 3.75 and 7.5)
        check("neon: the wide light is drawn once, under the label (" + c.stubTexts + ")",
                c.stubTexts.size() == 1 && c.stubTexts.get(0).equals("a|18.0|" + hex(0xbf00e676)));
        check("neon: the tight light stays in the paint for the label itself",
                Math.abs(label.stubShadowRadius - 5.1f) < 0.001f && label.stubShadowColor == GREEN);
        Paint small = paint(TEXT, 12f), big = paint(TEXT, 200f);
        c = new Canvas();
        MrGlow.bloom(c, "x", 0f, 0f, small);
        MrGlow.bloom(c, "y", 0f, 0f, big);
        check("neon: the light of a tiny label is not below 3 dp / 1.25 dp (" + c.stubTexts.get(0) + ")",
                c.stubTexts.get(0).startsWith("x|9.0|") && small.stubShadowRadius == 3.75f);
        check("neon: the light of a huge label is not above 7 dp / 2.5 dp (" + c.stubTexts.get(1) + ")",
                c.stubTexts.get(1).startsWith("y|21.0|") && big.stubShadowRadius == 7.5f);
        // dead key: one light, 60 * 0.16 = 9.6 px (between 6 and 12 at density 3), and nothing drawn by MrGlow itself
        Paint dead = paint(TEXT, 60f);
        c = new Canvas();
        MrGlow.edge(dead);
        check("neon: the label of a dead key gets one light of middle width, left in the paint",
                Math.abs(dead.stubShadowRadius - 9.6f) < 0.001f && dead.stubShadowColor == GREEN && c.stubTexts.isEmpty());
        MrGlow.edge(small);
        MrGlow.edge(big);
        check("neon: that light is not below 2 dp nor above 4 dp", small.stubShadowRadius == 6f && big.stubShadowRadius == 12f);
        MrGlow.edge(null);
        MrGlow.icon(c, face, keyAt(0, 0), 4.5f, own);
        check("neon: the icon gets a light of 3.25 dp in the glow colour instead of the dark outline",
                ShadowDrawHelper.stubRadius == 9.75f && ShadowDrawHelper.stubFilter instanceof PorterDuffColorFilter
                && ((PorterDuffColorFilter) ShadowDrawHelper.stubFilter).stubColor == GREEN
                && ((PorterDuffColorFilter) ShadowDrawHelper.stubFilter).stubMode == PorterDuff.Mode.SRC_IN);
        ColorFilter first = ShadowDrawHelper.stubFilter;
        MrGlow.icon(c, face, keyAt(0, 0), 4.5f, own);
        check("neon: the filter of the light is made once per colour", ShadowDrawHelper.stubFilter == first);
        check("neon: the icon keeps its colour filter", MrGlow.iconFilter(own) == own);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("neon: the face is drawn with no colour filter", KeyStyle.stubDrawn.size() == 1 && KeyStyle.stubDrawn.get(0) == null);
        dash = paint(DASH_ON, 0f);
        MrGlow.dash(dash);
        check("neon: a lit dash shines in its own colour (3 dp)", dash.stubShadowRadius == 9f && dash.stubShadowColor == DASH_ON);
        dash.setColor(DASH_OFF);
        MrGlow.dash(dash);
        check("neon: an off dash does not shine", dash.stubShadowRadius == 0f && dash.getColor() == DASH_OFF);
        MrGlow.key(kbd, keyAt(0, 0), true, label);
        c = new Canvas();
        MrGlow.bloom(c, "a", 0f, 0f, label);
        check("neon: a highlight key shines in the accent colour", label.stubShadowColor == PINK && c.stubTexts.get(0).endsWith("|" + hex(0xbfff2bd6)));
        MrGlow.icon(c, face, keyAt(0, 0), 4.5f, own);
        check("neon: and so does its icon", ((PorterDuffColorFilter) ShadowDrawHelper.stubFilter).stubColor == PINK);
        dash = paint(DASH_ON, 0f);
        MrGlow.dash(dash);
        check("neon: on a highlight key (Ctrl, Alt, Shift) the lit dash shines in its own colour, not in the accent one",
                dash.stubShadowRadius == 9f && dash.stubShadowColor == DASH_ON && dash.getColor() == DASH_ON);
        MrGlow.preview(bubble);
        check("neon: the letter of the preview bubble shines (6 dp, density of the bubble)",
                bubble.stubShadowRadius == 12f && bubble.stubShadowColor == GREEN);
        MrGlow.bloom(null, "a", 0f, 0f, label);
        MrGlow.bloom(c, null, 0f, 0f, label);
        MrGlow.bloom(c, "a", 0f, 0f, null);
        MrGlow.dash(null);
        MrGlow.preview(null);
        MrGlow.hint(null, HINT);
        MrGlow.key(null, null, false, null);
        check("neon: missing arguments do not fail", true);

        // a weaker glow colour gives a weaker light
        MrTheme.stubColors.put("glow", 0x8000e676);
        MrTheme.stubTag = "mr_dim";
        MrGlow.key(kbd, keyAt(0, 0), false, label);
        c = new Canvas();
        MrGlow.bloom(c, "a", 0f, 0f, label);
        check("the opacity of the glow colour is the strength of the light (" + c.stubTexts.get(0) + ")",
                label.stubShadowColor == 0x8000e676 && c.stubTexts.get(0).endsWith("|" + hex(0x6000e676)));
        check("the colours are read again when the theme changes", true);

        // ================= the maths of the spectrum
        check("step: left edge = 0, right edge = STEPS", MrGlow.step(0f, 0f, 1000, 400) == 0
                && MrGlow.step(1000f, 400f, 1000, 400) == MrGlow.STEPS);
        boolean rising = true;
        for (int x = 0; x < 1000; x += 10) if (MrGlow.step(x + 10, 200f, 1000, 400) < MrGlow.step(x, 200f, 1000, 400)) rising = false;
        check("step: never goes back from left to right", rising);
        int tilt = MrGlow.step(500f, 400f, 1000, 400) - MrGlow.step(500f, 0f, 1000, 400);
        check("step: the rows are slightly tilted (the bottom row is " + tilt + " steps ahead of the top one, of " + MrGlow.STEPS + ")",
                tilt > 0 && tilt < MrGlow.STEPS / 2);
        check("step: a keyboard with no size and a key outside it do not fail", MrGlow.step(5f, 5f, 0, 0) == 0
                && MrGlow.step(-50f, -50f, 1000, 400) == 0 && MrGlow.step(5000f, 5000f, 1000, 400) == MrGlow.STEPS);

        int red = 0xffff0000, lime = 0xff00ff00, blue = 0xff0000ff;
        check("ramp: the three colours at 0, 0.5 and 1", MrGlow.ramp(red, lime, blue, 0f) == red
                && MrGlow.ramp(red, lime, blue, 0.5f) == lime && MrGlow.ramp(red, lime, blue, 1f) == blue);
        check("ramp: between red and green it goes through yellow, vivid (" + hex(MrGlow.ramp(red, lime, blue, 0.25f)) + ")",
                MrGlow.ramp(red, lime, blue, 0.25f) == 0xffffff00);
        check("ramp: between red and blue it goes the short way, through magenta (" + hex(MrGlow.ramp(red, blue, blue, 0.25f)) + ")",
                MrGlow.ramp(red, blue, blue, 0.25f) == 0xffff00ff);
        check("ramp: and back the same way", MrGlow.ramp(blue, red, red, 0.25f) == 0xffff00ff);
        check("ramp: outside 0..1 it stops at the ends", MrGlow.ramp(red, lime, blue, -3f) == red && MrGlow.ramp(red, lime, blue, 7f) == blue);
        float[] hsv = new float[3];
        boolean round = true;
        for (int col : new int[] {GREEN, PINK, 0xff3d8bff, 0xffffab00, 0xff6f7bff, 0xff000000, 0xffffffff, 0xff808080}) {
            MrGlow.hsv(col, hsv);
            if (!near(MrGlow.rgb(hsv[0], hsv[1], hsv[2]), col, 1)) round = false;
        }
        check("hsv and rgb undo each other", round);

        float[] m = MrGlow.remap(GREEN, PINK);
        check("remap: the hue of the drawables lands on the hue of the key", m != null && near(MrGlow.map(m, GREEN), PINK, 1));
        check("remap: white stays white and black stays black", MrGlow.map(m, 0xffffffff) == 0xffffffff && MrGlow.map(m, 0xff000000) == 0xff000000);
        check("remap: a tube (hue with white) lands on the same tube of the other hue",
                near(MrGlow.map(m, mix(GREEN, 0xffffffff, 0.28f)), mix(PINK, 0xffffffff, 0.28f), 2));
        check("remap: a face (hue with black) lands on the same face of the other hue",
                near(MrGlow.map(m, mix(0xff000000, GREEN, 0.11f)), mix(0xff000000, PINK, 0.11f), 2));
        check("remap: the opacity of a colour is kept (light of a key)", (MrGlow.map(m, 0x4d00e676) >>> 24) == 0x4d
                && near(MrGlow.map(m, 0x4d00e676) | 0xff000000, PINK, 1));
        check("remap: a grey has no hue to move", MrGlow.remap(0xff808080, PINK) == null && MrGlow.remap(0xffffffff, PINK) == null);
        float[] same = MrGlow.remap(GREEN, GREEN);
        check("remap: to the same hue nothing changes", near(MrGlow.map(same, TEXT), TEXT, 1) && near(MrGlow.map(same, 0xff123456), 0xff123456, 1));
        check("map: no matrix, no change", MrGlow.map(null, 0x12345678) == 0x12345678);
        check("fade and clamp", MrGlow.fade(0xff00e676, 0.75f) == 0xbf00e676 && MrGlow.fade(0x8000e676, 2f) == 0x8000e676
                && MrGlow.clamp(5f, 1f, 3f) == 3f && MrGlow.clamp(-5f, 1f, 3f) == 1f && MrGlow.clamp(2f, 1f, 3f) == 2f);

        // ================= a spectrum theme: red on the left, green in the middle, blue on the right
        theme("mr_rgb", true, true);
        kbd = new Kbd(1f, true);
        label = paint(TEXT, 60f);
        hint = paint(HINT, 20f);
        Keyboard.Key left = new Keyboard.Key('q', -50, -50, 100, 100);       // centre at (0, 0): step 0
        MrGlow.key(kbd, left, false, label);
        MrGlow.hint(hint, HINT);
        int textRed = mix(red, 0xffffffff, 0.72f);
        check("spectrum: the label of the leftmost key is the theme's label moved to red (" + hex(label.getColor()) + ")",
                near(label.getColor(), textRed, 2));
        check("spectrum: its hint letters too, with their opacity (" + hex(hint.getColor()) + ")",
                (hint.getColor() >>> 24) == 0x9e && near(hint.getColor() | 0xff000000, mix(red, 0xffffffff, 0.55f), 2));
        c = new Canvas();
        MrGlow.bloom(c, "q", 0f, 0f, label);
        check("spectrum: its light is red (" + hex(label.stubShadowColor) + ")", label.stubShadowColor == red);
        Paint deadRed = paint(TEXT, 60f);
        MrGlow.edge(deadRed);
        check("spectrum: the light of a dead-key label there is red too", deadRed.stubShadowColor == red && deadRed.stubShadowRadius > 0f);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        ColorFilter drawn = KeyStyle.stubDrawn.get(0);
        check("spectrum: its face is drawn through a colour matrix", drawn instanceof ColorMatrixColorFilter);
        check("spectrum: the filter is taken off the shared drawable afterwards", face.stubFilter == null);
        float[] cm = ((ColorMatrixColorFilter) drawn).stubMatrix;
        // the 4x5 matrix applied to the hue of the drawables must give red, with the opacity untouched
        float r = cm[0] * 0x00 + cm[1] * 0xe6 + cm[2] * 0x76, g = cm[5] * 0x00 + cm[6] * 0xe6 + cm[7] * 0x76,
                b = cm[10] * 0x00 + cm[11] * 0xe6 + cm[12] * 0x76;
        check("spectrum: that matrix takes the hue of the drawables to red (" + r + ", " + g + ", " + b + ")",
                cm.length == 20 && Math.abs(r - 255f) < 1.5f && Math.abs(g) < 1.5f && Math.abs(b) < 1.5f);
        check("spectrum: and leaves the opacity as it is", cm[15] == 0f && cm[16] == 0f && cm[17] == 0f && cm[18] == 1f && cm[19] == 0f
                && cm[3] == 0f && cm[4] == 0f && cm[8] == 0f && cm[9] == 0f && cm[13] == 0f && cm[14] == 0f);
        ColorFilter ink = MrGlow.iconFilter(own);
        check("spectrum: the icon is painted in the colour of the label", ink instanceof PorterDuffColorFilter
                && ((PorterDuffColorFilter) ink).stubColor == label.getColor()
                && ((PorterDuffColorFilter) ink).stubMode == PorterDuff.Mode.SRC_ATOP);
        MrGlow.icon(c, face, left, 4.5f, own);
        check("spectrum: and its light is red", ((PorterDuffColorFilter) ShadowDrawHelper.stubFilter).stubColor == red);
        dash = paint(DASH_ON, 0f);
        MrGlow.dash(dash);
        check("spectrum: a lit dash takes the hue of its key and shines in it (" + hex(dash.getColor()) + ")",
                near(dash.getColor(), mix(red, 0xffffffff, 0.30f), 3) && dash.stubShadowRadius == 3f && dash.stubShadowColor == dash.getColor());
        dash.setColor(DASH_OFF);
        MrGlow.dash(dash);
        check("spectrum: an off dash takes the hue too, without light (" + hex(dash.getColor()) + ")",
                dash.stubShadowRadius == 0f && (dash.getColor() & 0xff) < 0x20 && ((dash.getColor() >> 16) & 0xff) > ((dash.getColor() >> 8) & 0xff));
        dash.setColor(DASH_LOCK);
        MrGlow.dash(dash);
        check("spectrum: the locked dash keeps its own reddish colour and shines in it",
                dash.getColor() == DASH_LOCK && dash.stubShadowRadius == 3f && dash.stubShadowColor == DASH_LOCK);

        // same position, same filter object; the middle is green, the right edge blue
        KeyStyle.stubDrawn.clear();
        MrGlow.key(kbd, left, false, paint(TEXT, 60f));
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("spectrum: the filter of a hue is made once", KeyStyle.stubDrawn.get(0) == drawn);
        Paint mid = paint(TEXT, 60f), end = paint(TEXT, 60f);
        MrGlow.key(kbd, new Keyboard.Key('g', 450, 150, 100, 100), false, mid);
        MrGlow.bloom(new Canvas(), "g", 0f, 0f, mid);
        check("spectrum: the key in the middle is green (" + hex(mid.stubShadowColor) + ")", mid.stubShadowColor == lime
                && near(mid.getColor(), mix(lime, 0xffffffff, 0.72f), 2));
        MrGlow.key(kbd, new Keyboard.Key('p', 950, 350, 100, 100), false, end);
        MrGlow.bloom(new Canvas(), "p", 0f, 0f, end);
        check("spectrum: the key at the right edge is blue (" + hex(end.stubShadowColor) + ")", end.stubShadowColor == blue
                && near(end.getColor(), mix(blue, 0xffffffff, 0.72f), 2));
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("spectrum: each hue has its own filter", KeyStyle.stubDrawn.get(0) != drawn && KeyStyle.stubDrawn.get(0) instanceof ColorMatrixColorFilter);
        Paint acc = paint(TEXT, 60f);
        MrGlow.key(kbd, new Keyboard.Key('\n', 950, 350, 100, 100), true, acc);
        MrGlow.bloom(new Canvas(), "p", 0f, 0f, acc);
        check("spectrum: a highlight key takes the hue of its place, not the accent colour", acc.stubShadowColor == blue);

        // the popup of variants (a keyboard view with no tag) keeps the hue of the drawables
        Kbd popup = new Kbd(1f, false);
        Paint pl = paint(TEXT, 60f), ph = paint(HINT, 20f);
        MrGlow.key(popup, keyAt(900, 300), false, pl);
        MrGlow.hint(ph, HINT);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        MrGlow.bloom(new Canvas(), "p", 0f, 0f, pl);
        check("spectrum: the popup of variants keeps the hue of the drawables (face, label, hint letters)",
                KeyStyle.stubDrawn.get(0) == null && pl.getColor() == TEXT && ph.getColor() == HINT);
        check("spectrum: and still shines, in the glow colour of the theme", pl.stubShadowColor == GREEN && MrGlow.iconFilter(own) == own);
        bubble = new Bubble();
        MrGlow.preview(bubble);
        check("spectrum: the preview bubble too", bubble.stubShadowColor == GREEN && bubble.stubShadowRadius == 12f);

        // drawables written in grey (a white neon): there is no hue to move, the theme just shines
        theme("mr_grey", true, true);
        MrTheme.stubColors.put("glow", 0xffc0c0c0);
        Paint gl = paint(0xfff0f0f0, 60f);
        MrGlow.key(kbd, keyAt(900, 300), false, gl);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        MrGlow.bloom(new Canvas(), "p", 0f, 0f, gl);
        check("spectrum on grey drawables: nothing is moved and nothing fails",
                KeyStyle.stubDrawn.get(0) == null && gl.getColor() == 0xfff0f0f0 && gl.stubShadowColor == 0xffc0c0c0);

        // back to a plain theme: nothing of the neon one is left
        theme("mr_plain", false, false);
        Paint back = paint(TEXT, 60f);
        MrGlow.key(kbd, left, false, back);
        c = new Canvas();
        MrGlow.bloom(c, "q", 0f, 0f, back);
        KeyStyle.stubDrawn.clear();
        MrGlow.drawKey(face, new Canvas(), 100, 100);
        check("after a neon theme, a plain theme is plain again", c.stubTexts.isEmpty() && back.getColor() == TEXT
                && back.stubShadowRadius == 0f && KeyStyle.stubDrawn.get(0) == null && MrGlow.iconFilter(own) == own);

        // ================= the keys that the person tuned (MrKeyLook) on a theme of the backgrounds
        keyLook(kbd, face);
        MrTools.sApp = null;
        PreferenceManager.stubDefault = null;
        MrKeyLook.invalidate();

        System.out.println(fail == 0 ? ok + " ok, 0 failures" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
