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
 * Altura da barra de ferramentas e sugestões (v1.69): a linha "bar_main" do mr_toolbar, onde as
 * ferramentas e as sugestões de palavras se alternam (MrSugg). O layout fixa a altura em
 * mr_bar_height; aqui ela vira essa altura vezes "pref_bar_scale" (de mr_bar_scale_min a
 * mr_bar_scale_max, padrão 100%) e acompanha a configuração na hora.
 *
 * Os cabeçalhos dos painéis (bar_t, bar_c, bar_s, bar_e, bar_tune) entram na mesma lista por
 * attachExtra, para que abrir um painel não mude a altura da barra (etapa 5.1 do plano).
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

    /** Chamado quando a barra é montada: começa uma lista nova, aplica a altura e segue a configuração. */
    public static void attach(View bar) {
        if (bar == null) return;
        sBars.clear();
        attachExtra(bar);
    }

    /** Cabeçalho de painel que segue a mesma escala da barra (chamado depois do attach da barra). */
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

    /** Escala guardada, dentro de min a max; valor ausente ou inválido vale 100%. */
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

    /** Altura em pixels para a altura base em pixels e a escala dadas. */
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
