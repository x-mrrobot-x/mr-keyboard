package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

/**
 * Avisos que aparecem uma vez só (v1.64). Hoje: na primeira vez que o painel Traduzir abre, avisa
 * que o texto daquele campo vai para o Google Tradutor (é o único recurso que manda texto para fora
 * do aparelho). A dica do campo também diz isso o tempo todo.
 */
public final class MrNotice {
    private MrNotice() { }

    static final String PREFS = "mr_notices";
    static final String KEY_TRANSLATE = "translate_seen";

    /** Chamado por MrTools.enterTranslate. Nunca lança exceção. */
    public static void translate(Context c) {
        try {
            if (c == null) return;
            SharedPreferences p = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
            if (p.getBoolean(KEY_TRANSLATE, false)) return;
            String msg = MrPacks.text(c, "mr_tr_notice");
            if (msg == null) return;
            p.edit().putBoolean(KEY_TRANSLATE, true).apply();
            Toast.makeText(c, msg, Toast.LENGTH_LONG).show();
        } catch (RuntimeException e) {
            // sem o aviso, o painel abre normalmente
        }
    }
}
