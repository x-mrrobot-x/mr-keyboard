package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

/**
 * Avisos que aparecem uma vez só (v1.64). Hoje: na primeira vez que o painel Traduzir abre, avisa
 * que o texto daquele campo vai para o Google Tradutor. Desde a v1.78 também avisa, na primeira
 * vez que o Editor de IA abre, que o texto reescrito vai para o serviço que o usuário configurou.
 */
public final class MrNotice {
    private MrNotice() { }

    static final String PREFS = "mr_notices";
    static final String KEY_TRANSLATE = "translate_seen";
    static final String KEY_AI = "ai_seen";

    /** Chamado por MrTools.enterTranslate. Nunca lança exceção. */
    public static void translate(Context c) {
        once(c, KEY_TRANSLATE, "mr_tr_notice");
    }

    /** Chamado por MrAi.onOpen (primeira abertura do Editor de IA). Nunca lança exceção. */
    public static void aiEditor(Context c) {
        once(c, KEY_AI, "mr_ai_notice");
    }

    private static void once(Context c, String key, String stringName) {
        try {
            if (c == null) return;
            SharedPreferences p = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE);
            if (p.getBoolean(key, false)) return;
            String msg = MrPacks.text(c, stringName);
            if (msg == null) return;
            p.edit().putBoolean(key, true).apply();
            Toast.makeText(c, msg, Toast.LENGTH_LONG).show();
        } catch (RuntimeException e) {
            // sem o aviso, o painel abre normalmente
        }
    }
}
