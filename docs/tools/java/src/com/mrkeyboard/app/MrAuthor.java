package com.mrkeyboard.app;

import android.content.Context;
import android.preference.Preference;

/**
 * Cartão "by x-mrrobot-x" de Sobre: abre o perfil no GitHub. Antes era um intent no XML, que fecha o app
 * (ActivityNotFoundException) em aparelho sem navegador; aqui o erro vira um aviso (ver MrLink).
 */
public final class MrAuthor implements Preference.OnPreferenceClickListener {
    static final String URL = "https://github.com/x-mrrobot-x";

    private final Context mContext;

    public MrAuthor(Context context) {
        mContext = context;
    }

    public boolean onPreferenceClick(Preference preference) {
        open(mContext);
        return true;
    }

    /** Abre o link; sem app para abrir, mostra o aviso e devolve false. */
    static boolean open(Context c) {
        return MrLink.open(c, URL);
    }
}
