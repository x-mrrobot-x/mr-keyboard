package com.mrkeyboard.app;

/** Substitui a classe do APK no teste (a real usa APIs que o PC não tem). */
public final class UiLocale {
    public static android.content.Context wrap(android.content.Context c) { return c; }
}
