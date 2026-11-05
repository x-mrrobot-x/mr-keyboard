package com.mrkeyboard.app;

import android.content.Context;
import android.view.ContextThemeWrapper;

/**
 * Keyboard context with the resources in the language chosen in "Idioma do app" (App language). The toolbar
 * (mr_toolbar.xml) is inflated with it so that the layout texts follow the app language and not just the
 * system one (the text of a layout attribute comes from the resources of the context theme, so it is not enough to
 * swap getResources()). Keeps the keyboard theme. With no language chosen ("Padrão do sistema", system default), it returns
 * the context itself and nothing changes.
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
