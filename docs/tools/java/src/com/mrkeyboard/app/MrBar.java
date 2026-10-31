package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.view.View;
import android.view.ViewGroup;

import java.lang.ref.WeakReference;

/**
 * Altura da barra de ferramentas e sugestões (v1.69): a linha "bar_main" do mr_toolbar, onde as
 * ferramentas e as sugestões de palavras se alternam (MrSugg). O layout fixa 48 dp; aqui a altura
 * vira 48 dp vezes "pref_bar_scale" (60% a 150%, padrão 100%) e acompanha a configuração na hora.
 */
public final class MrBar {
    private MrBar() { }

    static final String KEY = "pref_bar_scale";
    static final float BASE_DP = 48f;
    static final float MIN = 0.6f;
    static final float MAX = 1.5f;

    private static WeakReference<View> sBar;
    private static SharedPreferences sRegistered;
    private static final SharedPreferences.OnSharedPreferenceChangeListener sListener =
            new SharedPreferences.OnSharedPreferenceChangeListener() {
                public void onSharedPreferenceChanged(SharedPreferences prefs, String key) {
                    if (!KEY.equals(key)) return;
                    View bar = sBar != null ? sBar.get() : null;
                    if (bar != null) apply(bar);
                }
            };

    /** Chamado quando a barra é montada: aplica a altura e passa a seguir a configuração. */
    public static void attach(View bar) {
        if (bar == null) return;
        sBar = new WeakReference<View>(bar);
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(bar.getContext());
        if (sRegistered != sp) {
            if (sRegistered != null) sRegistered.unregisterOnSharedPreferenceChangeListener(sListener);
            sp.registerOnSharedPreferenceChangeListener(sListener);
            sRegistered = sp;
        }
        apply(bar);
    }

    /** Escala guardada, dentro de 60% a 150%; valor ausente ou inválido vale 100%. */
    static float scale(String stored) {
        float v = 1f;
        if (stored != null) {
            try {
                v = Float.parseFloat(stored.trim());
            } catch (NumberFormatException e) {
                v = 1f;
            }
        }
        if (!(v == v)) v = 1f;
        return Math.max(MIN, Math.min(MAX, v));
    }

    /** Altura em pixels para a densidade e a escala dadas. */
    static int heightPx(float density, float scale) {
        return Math.round(BASE_DP * density * scale);
    }

    static void apply(View bar) {
        ViewGroup.LayoutParams lp = bar.getLayoutParams();
        if (lp == null) return;
        Context c = bar.getContext();
        String stored = PreferenceManager.getDefaultSharedPreferences(c).getString(KEY, null);
        int h = heightPx(c.getResources().getDisplayMetrics().density, scale(stored));
        if (lp.height != h) {
            lp.height = h;
            bar.setLayoutParams(lp);
        }
    }
}
