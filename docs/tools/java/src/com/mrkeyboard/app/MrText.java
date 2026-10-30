package com.mrkeyboard.app;

/**
 * Utilidades de texto para sugestões em pt-BR (v1.60).
 * - base(): minúscula sem acento (á -> a, ç -> c), a mesma ideia do BASE_CHARS da lib nativa.
 * - fillInitials()/allInitials(): alternativas de 1ª letra para a consulta de bigramas, porque a lib
 *   compara a inicial da palavra seguinte de forma exata (é != e).
 * - lastWord(): última palavra antes do cursor, para a previsão depois do espaço.
 */
public final class MrText {
    private MrText() { }

    /** Minúscula sem acento para letras latinas; outros caracteres só em minúscula. */
    public static char base(int code) {
        char c = (char) code;
        switch (c) {
            case 'à': case 'á': case 'â': case 'ã': case 'ä': case 'å':
            case 'À': case 'Á': case 'Â': case 'Ã': case 'Ä': case 'Å':
                return 'a';
            case 'ç': case 'Ç':
                return 'c';
            case 'è': case 'é': case 'ê': case 'ë':
            case 'È': case 'É': case 'Ê': case 'Ë':
                return 'e';
            case 'ì': case 'í': case 'î': case 'ï':
            case 'Ì': case 'Í': case 'Î': case 'Ï':
                return 'i';
            case 'ñ': case 'Ñ':
                return 'n';
            case 'ò': case 'ó': case 'ô': case 'õ': case 'ö':
            case 'Ò': case 'Ó': case 'Ô': case 'Õ': case 'Ö':
                return 'o';
            case 'ù': case 'ú': case 'û': case 'ü':
            case 'Ù': case 'Ú': case 'Û': case 'Ü':
                return 'u';
            case 'ý': case 'ÿ': case 'Ý':
                return 'y';
            default:
                return Character.toLowerCase(c);
        }
    }

    /** true se a 1ª letra de word e typed são a mesma letra, ignorando caixa e acento. */
    public static boolean sameInitial(CharSequence word, int typed) {
        if (word == null || word.length() == 0) return false;
        return base(word.charAt(0)) == base(typed);
    }

    private static final String VARIANTS_A = "àáâã";
    private static final String VARIANTS_E = "éê";
    private static final String VARIANTS_I = "í";
    private static final String VARIANTS_O = "óôõ";
    private static final String VARIANTS_U = "úü";
    private static final String VARIANTS_C = "ç";

    private static String variantsOf(char b) {
        switch (b) {
            case 'a': return VARIANTS_A;
            case 'e': return VARIANTS_E;
            case 'i': return VARIANTS_I;
            case 'o': return VARIANTS_O;
            case 'u': return VARIANTS_U;
            case 'c': return VARIANTS_C;
            default: return "";
        }
    }

    private static int put(int[] dst, int count, int max, int code) {
        if (code <= 0 || count >= max) return count;
        for (int i = 0; i < count; i++) {
            if (dst[i] == code) return count;
        }
        dst[count] = code;
        return count + 1;
    }

    /**
     * Copia os códigos da 1ª posição (tecla tocada e vizinhas) para dst e acrescenta as variantes
     * acentuadas e maiúsculas de cada um. Devolve quantos códigos foram escritos; o resto de dst
     * (até max) recebe -1.
     */
    public static int fillInitials(int[] src, int[] dst, int max) {
        if (max > dst.length) max = dst.length;
        int count = 0;
        if (src != null) {
            for (int k = 0; k < src.length; k++) {
                int code = src[k];
                if (code <= 0) {
                    if (k == 0) continue;
                    break;
                }
                char b = base(code);
                count = put(dst, count, max, code);
                count = put(dst, count, max, Character.toUpperCase((char) code));
                if (Character.isLetter((char) code)) {
                    count = put(dst, count, max, b);
                    count = put(dst, count, max, Character.toUpperCase(b));
                    String v = variantsOf(b);
                    for (int i = 0; i < v.length(); i++) {
                        count = put(dst, count, max, v.charAt(i));
                        count = put(dst, count, max, Character.toUpperCase(v.charAt(i)));
                    }
                }
            }
        }
        for (int i = count; i < max; i++) dst[i] = -1;
        return count;
    }

    private static final String ALL_LOWER = "abcdefghijklmnopqrstuvwxyzàáâãéêíóôõúüç";

    /** Todas as iniciais (a-z, acentuadas, minúsculas e maiúsculas), para prever sem letra digitada. */
    public static int allInitials(int[] dst) {
        int count = 0;
        int max = dst.length;
        for (int i = 0; i < ALL_LOWER.length(); i++) {
            char c = ALL_LOWER.charAt(i);
            count = put(dst, count, max, c);
            count = put(dst, count, max, Character.toUpperCase(c));
        }
        for (int i = count; i < max; i++) dst[i] = -1;
        return count;
    }

    /**
     * Conserta as palavras que a lib nativa devolve dos bigramas. No x86 o char da lib tem sinal e
     * as letras de 0x80 a 0xFF chegam como 0xFF80..0xFFFF (é vira U+FFE9); no ARM não acontece.
     * O dicionário só tem caracteres abaixo de U+00FF, então nada legítimo cai nessa faixa.
     */
    public static void fixNative(char[] buf) {
        if (buf == null) return;
        for (int i = 0; i < buf.length; i++) {
            char c = buf[i];
            if (c >= 0xFF80) buf[i] = (char) (c & 0xFF);
        }
    }

    /**
     * Pode entrar no aprendizado (AutoDictionary e bigramas do usuário)? Não para sugestões com
     * espaço (correções do MrFix como "com certeza" e "por isso", ou espaço faltando): elas viram
     * duas palavras no texto e cada uma já é aprendida como bigrama quando for escolhida.
     */
    public static boolean learnable(CharSequence word) {
        if (word == null) return false;
        int n = word.length();
        if (n == 0) return false;
        for (int i = 0; i < n; i++) {
            if (Character.isWhitespace(word.charAt(i))) return false;
        }
        return true;
    }

    /**
     * Última palavra antes do cursor (ignorando espaços no fim). Devolve null se o texto terminar em
     * pontuação ou número, ou se não houver palavra: nesses casos a faixa mostra a pontuação.
     */
    public static String lastWord(CharSequence before) {
        if (before == null) return null;
        int end = before.length();
        while (end > 0 && Character.isWhitespace(before.charAt(end - 1))) end--;
        if (end == 0) return null;
        int start = end;
        while (start > 0) {
            char c = before.charAt(start - 1);
            if (Character.isLetter(c) || c == '\'' || c == '-') start--;
            else break;
        }
        while (start < end && !Character.isLetter(before.charAt(start))) start++;
        while (end > start && !Character.isLetter(before.charAt(end - 1))) end--;
        if (start >= end) return null;
        if (end - start > 47) return null;
        return before.subSequence(start, end).toString();
    }
}
