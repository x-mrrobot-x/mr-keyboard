package com.mrkeyboard.app;

/**
 * Mapa de erros comuns e abreviações do idioma (v1.60). Desde a 1.63 a lista vem do pacote de
 * dicionário (seção [corrections] do rules.txt, lida por MrRules); sem pacote, não há correções.
 * A chave é a forma digitada em minúscula e sem acento (MrText.base); o valor é a sugestão. A
 * sugestão entra como a melhor da lista; com a autocorreção ligada ela só substitui a palavra se
 * a digitada não for válida.
 */
public final class MrFix {
    private MrFix() { }

    /** Chave de busca: minúscula e sem acento. */
    static String key(CharSequence typed) {
        if (typed == null) return null;
        int n = typed.length();
        if (n == 0 || n > 24) return null;
        char[] k = new char[n];
        for (int i = 0; i < n; i++) k[i] = MrText.base(typed.charAt(i));
        return new String(k);
    }

    /** Sugestão para a palavra digitada, ou null. */
    public static String lookup(CharSequence typed) {
        MrRules r = MrRules.get();
        if (r.corrections.isEmpty()) return null;
        String k = key(typed);
        if (k == null) return null;
        return r.corrections.get(k);
    }

    /** Quantidade de entradas (para testes). */
    static int size() {
        return MrRules.get().corrections.size();
    }
}
