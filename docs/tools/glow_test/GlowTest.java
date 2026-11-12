package com.mrkeyboard.app;

import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Paint;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffColorFilter;
import android.graphics.drawable.Drawable;
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
        MrGlow.icon(c, face, keyAt(0, 0), 4.5f, own);
        check("plain theme: the icon keeps its dark outline (radius and filter of the keyboard)",
                ShadowDrawHelper.stubRadius == 4.5f && ShadowDrawHelper.stubFilter == own);
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

        System.out.println(fail == 0 ? ok + " ok, 0 failures" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
