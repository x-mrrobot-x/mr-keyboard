package com.mrkeyboard.app;

import android.content.Context;
import android.view.ContextThemeWrapper;

/**
 * Contexto do teclado com os recursos no idioma escolhido em "Idioma do app". A barra de ferramentas
 * (mr_toolbar.xml) é inflada com ele para que os textos do layout sigam o idioma do app e não só o do
 * sistema (o texto de um atributo de layout sai dos recursos do tema do contexto, por isso não basta
 * trocar getResources()). Mantém o tema do teclado. Sem idioma escolhido ("Padrão do sistema"), devolve
 * o próprio contexto e nada muda.
 */
public final class MrLocaleCtx {
    private MrLocaleCtx() { }

    public static Context of(Context base) {
        Context w = UiLocale.wrap(base);
        if (w == null || w == base) return base;
        ContextThemeWrapper t = new ContextThemeWrapper(w, 0);
        t.getTheme().setTo(base.getTheme());
        return t;
    }
}
