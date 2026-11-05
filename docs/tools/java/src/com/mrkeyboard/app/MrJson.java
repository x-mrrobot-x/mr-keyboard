package com.mrkeyboard.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Small JSON reader for the dictionary catalog (v1.63). Returns Map (object), List
 * (list), String, Long or Double (number), Boolean and null. Limits depth and size, and throws
 * IllegalArgumentException on invalid JSON.
 */
final class MrJson {
    private static final int MAX_DEPTH = 32;
    private final String s;
    private int p;

    private MrJson(String s) {
        this.s = s;
    }

    static Object parse(String text) {
        if (text == null) throw new IllegalArgumentException("empty");
        MrJson j = new MrJson(text);
        j.ws();
        Object v = j.value(0);
        j.ws();
        if (j.p != text.length()) throw new IllegalArgumentException("extra data after the JSON");
        return v;
    }

    // ---------------------------------------------------------------- typed access

    @SuppressWarnings("unchecked")
    static Map<String, Object> obj(Object o) {
        if (!(o instanceof Map)) throw new IllegalArgumentException("expected an object");
        return (Map<String, Object>) o;
    }

    @SuppressWarnings("unchecked")
    static List<Object> list(Object o) {
        if (!(o instanceof List)) throw new IllegalArgumentException("expected a list");
        return (List<Object>) o;
    }

    static String str(Map<String, Object> m, String k) {
        Object o = m.get(k);
        if (!(o instanceof String)) throw new IllegalArgumentException("field " + k + " missing or not text");
        return (String) o;
    }

    static String optStr(Map<String, Object> m, String k, String def) {
        Object o = m.get(k);
        return o instanceof String ? (String) o : def;
    }

    static long num(Map<String, Object> m, String k) {
        Object o = m.get(k);
        if (!(o instanceof Long)) throw new IllegalArgumentException("field " + k + " missing or not an integer");
        return (Long) o;
    }

    // ---------------------------------------------------------------- reading

    private Object value(int depth) {
        if (depth > MAX_DEPTH) throw new IllegalArgumentException("JSON nested too deep");
        if (p >= s.length()) throw new IllegalArgumentException("unexpected end");
        char c = s.charAt(p);
        if (c == '{') return object(depth);
        if (c == '[') return array(depth);
        if (c == '"') return string();
        if (c == 't' && s.startsWith("true", p)) { p += 4; return Boolean.TRUE; }
        if (c == 'f' && s.startsWith("false", p)) { p += 5; return Boolean.FALSE; }
        if (c == 'n' && s.startsWith("null", p)) { p += 4; return null; }
        if (c == '-' || (c >= '0' && c <= '9')) return number();
        throw new IllegalArgumentException("unexpected character at position " + p);
    }

    private Map<String, Object> object(int depth) {
        HashMap<String, Object> m = new HashMap<String, Object>();
        p++;
        ws();
        if (peek() == '}') { p++; return m; }
        while (true) {
            ws();
            if (peek() != '"') throw new IllegalArgumentException("expected a field name");
            String k = string();
            ws();
            if (peek() != ':') throw new IllegalArgumentException("expected ':'");
            p++;
            ws();
            m.put(k, value(depth + 1));
            ws();
            char c = peek();
            p++;
            if (c == ',') continue;
            if (c == '}') return m;
            throw new IllegalArgumentException("expected ',' or '}'");
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
            throw new IllegalArgumentException("expected ',' or ']'");
        }
    }

    private String string() {
        p++;
        StringBuilder b = new StringBuilder();
        while (true) {
            if (p >= s.length()) throw new IllegalArgumentException("unterminated string");
            char c = s.charAt(p++);
            if (c == '"') return b.toString();
            if (c == '\\') {
                if (p >= s.length()) throw new IllegalArgumentException("unterminated escape");
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
                        if (p + 4 > s.length()) throw new IllegalArgumentException("incomplete \\u");
                        try {
                            b.append((char) Integer.parseInt(s.substring(p, p + 4), 16));
                        } catch (NumberFormatException ex) {
                            throw new IllegalArgumentException("invalid \\u");
                        }
                        p += 4;
                        break;
                    default:
                        throw new IllegalArgumentException("invalid escape");
                }
            } else {
                if (c < 0x20) throw new IllegalArgumentException("control character inside string");
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
            throw new IllegalArgumentException("invalid number: " + t);
        }
    }

    private char peek() {
        if (p >= s.length()) throw new IllegalArgumentException("unexpected end");
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
