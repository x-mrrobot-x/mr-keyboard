package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.ViewGroup;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.WeakHashMap;

/**
 * Height of the toolbar and suggestions bar (v1.69): the "bar_main" row of mr_toolbar, where the
 * tools and the word suggestions alternate (MrSugg). The layout fixes the height at
 * mr_bar_height; here it becomes that height times "pref_bar_scale" (from mr_bar_scale_min to
 * mr_bar_scale_max, default 100%) and follows the setting immediately.
 *
 * The panel headers (bar_t, bar_c, bar_s, bar_e, bar_tune) enter the same list through
 * attachExtra, so that opening a panel does not change the bar height (step 5.1 of the plan).
 *
 * A panel that needs more room than one row (the emoji search, 1.97.0) makes its header taller with expand and gives
 * the height back with restore when it closes (its back button). Any tool bar can do the same: expand(bar, px) keeps
 * the height the bar had, and restore(bar) puts it back (the scaled height, for the bars of the list).
 */
public final class MrBar {
    private MrBar() { }

    static final String KEY = "pref_bar_scale";

    private static final ArrayList<WeakReference<View>> sBars = new ArrayList<WeakReference<View>>();
    /** The bars made taller by expand, with the height they had (restore gives it back). Weak: a bar that goes away leaves. */
    private static final WeakHashMap<View, Integer> sExpanded = new WeakHashMap<View, Integer>();
    private static SharedPreferences sRegistered;
    private static final SharedPreferences.OnSharedPreferenceChangeListener sListener =
            new SharedPreferences.OnSharedPreferenceChangeListener() {
                public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
                    if (!KEY.equals(key)) return;
                    for (WeakReference<View> ref : sBars) {
                        View bar = ref.get();
                        if (bar != null) apply(bar);
                    }
                }
            };

    /** Called when the bar is assembled: starts a new list, applies the height and follows the setting. */
    public static void attach(View bar) {
        if (bar == null) return;
        sBars.clear();
        attachExtra(bar);
    }

    /** Panel header that follows the same scale as the bar (called after the bar attach). */
    public static void attachExtra(View bar) {
        if (bar == null) return;
        sBars.add(new WeakReference<View>(bar));
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(bar.getContext());
        if (sRegistered != sp) {
            if (sRegistered != null) sRegistered.unregisterOnSharedPreferenceChangeListener(sListener);
            sp.registerOnSharedPreferenceChangeListener(sListener);
            sRegistered = sp;
        }
        apply(bar);
    }

    /** Stored scale, within min to max; a missing or invalid value counts as 100%. */
    static float scale(String stored, float min, float max) {
        float v = 1f;
        if (stored != null) {
            try {
                v = Float.parseFloat(stored.trim());
            } catch (NumberFormatException e) {
                v = 1f;
            }
        }
        if (!(v == v)) v = 1f;
        return Math.max(min, Math.min(max, v));
    }

    /** Height in pixels for the given base height in pixels and scale. */
    static int heightPx(float basePx, float scale) {
        return Math.round(basePx * scale);
    }

    private static float number(Resources r, String pkg, String name) {
        return Float.parseFloat(r.getString(r.getIdentifier(name, "string", pkg)).trim());
    }

    /**
     * Makes this bar px pixels tall until restore: for a panel that needs more than one row. The setting of the bar height
     * does not touch it meanwhile. Called again with another height, it only changes the height (the first one is kept).
     */
    public static void expand(View bar, int px) {
        if (bar == null || px <= 0) return;
        ViewGroup.LayoutParams lp = bar.getLayoutParams();
        if (lp == null) return;
        if (!sExpanded.containsKey(bar)) sExpanded.put(bar, Integer.valueOf(lp.height));
        if (lp.height != px) {
            lp.height = px;
            bar.setLayoutParams(lp);
        }
    }

    /** Back to the height the bar had before expand (for a bar of the list: the height of the setting). No-op if not expanded. */
    public static void restore(View bar) {
        if (bar == null) return;
        Integer was = sExpanded.remove(bar);
        if (was == null) return;
        if (isListed(bar)) {
            apply(bar);
            return;
        }
        ViewGroup.LayoutParams lp = bar.getLayoutParams();
        if (lp != null && lp.height != was.intValue()) {
            lp.height = was.intValue();
            bar.setLayoutParams(lp);
        }
    }

    /** True while the bar is taller (or shorter) than usual because of expand. */
    public static boolean expanded(View bar) {
        return bar != null && sExpanded.containsKey(bar);
    }

    private static boolean isListed(View bar) {
        for (WeakReference<View> ref : sBars) {
            if (ref.get() == bar) return true;
        }
        return false;
    }

    static void apply(View bar) {
        if (sExpanded.containsKey(bar)) return;   // a panel asked for another height: restore brings the setting back
        ViewGroup.LayoutParams lp = bar.getLayoutParams();
        if (lp == null) return;
        Context c = bar.getContext();
        Resources r = c.getResources();
        String pkg = c.getPackageName();
        String stored = PreferenceManager.getDefaultSharedPreferences(c).getString(KEY, null);
        float s = scale(stored, number(r, pkg, "mr_bar_scale_min"), number(r, pkg, "mr_bar_scale_max"));
        int h = heightPx(r.getDimension(r.getIdentifier("mr_bar_height", "dimen", pkg)), s);
        if (lp.height != h) {
            lp.height = h;
            bar.setLayoutParams(lp);
        }
    }
}
