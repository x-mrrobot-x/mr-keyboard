package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Leitor de JSON pequeno para o catálogo de dicionários (v1.63). Devolve Map (objeto), List
 * (lista), String, Long ou Double (número), Boolean e null. Limita profundidade e tamanho, e lança
 * IllegalArgumentException em JSON inválido.
 */
final class MrJson {
    private static final int MAX_DEPTH = 32;
    private final String s;
    private int p;

    private MrJson(String s) {
        this.s = s;
    }

    static Object parse(String text) {
        if (text == null) throw new IllegalArgumentException("vazio");
        MrJson j = new MrJson(text);
        j.ws();
        Object v = j.value(0);
        j.ws();
        if (j.p != text.length()) throw new IllegalArgumentException("sobra depois do JSON");
        return v;
    }

    // ---------------------------------------------------------------- acesso com tipo

    @SuppressWarnings("unchecked")
    static Map<String, Object> obj(Object o) {
        if (!(o instanceof Map)) throw new IllegalArgumentException("esperava objeto");
        return (Map<String, Object>) o;
    }

    @SuppressWarnings("unchecked")
    static List<Object> list(Object o) {
        if (!(o instanceof List)) throw new IllegalArgumentException("esperava lista");
        return (List<Object>) o;
    }

    static String str(Map<String, Object> m, String k) {
        Object o = m.get(k);
        if (!(o instanceof String)) throw new IllegalArgumentException("campo " + k + " ausente ou não é texto");
        return (String) o;
    }

    static String optStr(Map<String, Object> m, String k, String def) {
        Object o = m.get(k);
        return o instanceof String ? (String) o : def;
    }

    static long num(Map<String, Object> m, String k) {
        Object o = m.get(k);
        if (!(o instanceof Long)) throw new IllegalArgumentException("campo " + k + " ausente ou não é inteiro");
        return (Long) o;
    }

    // ---------------------------------------------------------------- leitura

    private Object value(int depth) {
        if (depth > MAX_DEPTH) throw new IllegalArgumentException("JSON fundo demais");
        if (p >= s.length()) throw new IllegalArgumentException("fim inesperado");
        char c = s.charAt(p);
        if (c == '{') return object(depth);
        if (c == '[') return array(depth);
        if (c == '"') return string();
        if (c == 't' && s.startsWith("true", p)) { p += 4; return Boolean.TRUE; }
        if (c == 'f' && s.startsWith("false", p)) { p += 5; return Boolean.FALSE; }
        if (c == 'n' && s.startsWith("null", p)) { p += 4; return null; }
        if (c == '-' || (c >= '0' && c <= '9')) return number();
        throw new IllegalArgumentException("caractere inesperado na posição " + p);
    }

    private Map<String, Object> object(int depth) {
        HashMap<String, Object> m = new HashMap<String, Object>();
        p++;
        ws();
        if (peek() == '}') { p++; return m; }
        while (true) {
            ws();
            if (peek() != '"') throw new IllegalArgumentException("esperava nome de campo");
            String k = string();
            ws();
            if (peek() != ':') throw new IllegalArgumentException("esperava ':'");
            p++;
            ws();
            m.put(k, value(depth + 1));
            ws();
            char c = peek();
            p++;
            if (c == ',') continue;
            if (c == '}') return m;
            throw new IllegalArgumentException("esperava ',' ou '}'");
        }
    }

    private List<Object> array(int depth) {
        ArrayList<Object> l = new ArrayList<Object>();
        p++;
        ws();
        if (peek() == ']') { p++; return l; }
        while (true) {
            ws();
            l.add(value(depth + 1));
            ws();
            char c = peek();
            p++;
            if (c == ',') continue;
            if (c == ']') return l;
            throw new IllegalArgumentException("esperava ',' ou ']'");
        }
    }

    private String string() {
        p++;
        StringBuilder b = new StringBuilder();
        while (true) {
            if (p >= s.length()) throw new IllegalArgumentException("texto sem fim");
            char c = s.charAt(p++);
            if (c == '"') return b.toString();
            if (c == '\\') {
                if (p >= s.length()) throw new IllegalArgumentException("escape sem fim");
                char e = s.charAt(p++);
                switch (e) {
                    case '"': b.append('"'); break;
                    case '\\': b.append('\\'); break;
                    case '/': b.append('/'); break;
                    case 'b': b.append('\b'); break;
                    case 'f': b.append('\f'); break;
                    case 'n': b.append('\n'); break;
                    case 'r': b.append('\r'); break;
                    case 't': b.append('\t'); break;
                    case 'u':
                        if (p + 4 > s.length()) throw new IllegalArgumentException("\\u incompleto");
                        try {
                            b.append((char) Integer.parseInt(s.substring(p, p + 4), 16));
                        } catch (NumberFormatException ex) {
                            throw new IllegalArgumentException("\\u inválido");
                        }
                        p += 4;
                        break;
                    default:
                        throw new IllegalArgumentException("escape inválido");
                }
            } else {
                if (c < 0x20) throw new IllegalArgumentException("controle dentro de texto");
                b.append(c);
            }
        }
    }

    private Object number() {
        int start = p;
        if (peek() == '-') p++;
        boolean real = false;
        while (p < s.length()) {
            char c = s.charAt(p);
            if (c >= '0' && c <= '9') { p++; continue; }
            if (c == '.' || c == 'e' || c == 'E' || c == '+' || c == '-') { real = true; p++; continue; }
            break;
        }
        String t = s.substring(start, p);
        try {
            if (!real) return Long.parseLong(t);
            return Double.parseDouble(t);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("número inválido: " + t);
        }
    }

    private char peek() {
        if (p >= s.length()) throw new IllegalArgumentException("fim inesperado");
        return s.charAt(p);
    }

    private void ws() {
        while (p < s.length()) {
            char c = s.charAt(p);
            if (c == ' ' || c == '\n' || c == '\r' || c == '\t') p++;
            else break;
        }
    }
}
