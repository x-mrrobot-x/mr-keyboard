package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.ViewGroup;

import java.lang.ref.WeakReference;
import java.util.ArrayList;

/**
 * Height of the toolbar and suggestions bar (v1.69): the "bar_main" row of mr_toolbar, where the
 * tools and the word suggestions alternate (MrSugg). The layout fixes the height at
 * mr_bar_height; here it becomes that height times "pref_bar_scale" (from mr_bar_scale_min to
 * mr_bar_scale_max, default 100%) and follows the setting immediately.
 *
 * The panel headers (bar_t, bar_c, bar_s, bar_e, bar_tune) enter the same list through
 * attachExtra, so that opening a panel does not change the bar height (step 5.1 of the plan).
 */
public final class MrBar {
    private MrBar() { }

    static final String KEY = "pref_bar_scale";

    private static final ArrayList<WeakReference<View>> sBars = new ArrayList<WeakReference<View>>();
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

    static void apply(View bar) {
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
