package org.json;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Test only (AbcKeysTest): a small org.json that works (the one of docs/tools/java/stubs only compiles), with the methods the stub has and
 * the same behaviour as Android for what MrAbcKeys and the stub of SheetModel.KeySpec use: parse, put, opt*, keys, toString.
 */
public class JSONObject {
    final LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
    static final Object NULL = new Object();

    public JSONObject() { }

    public JSONObject(String json) throws JSONException {
        Parser p = new Parser(json);
        Object v = p.value();
        p.end();
        if (!(v instanceof JSONObject)) throw new JSONException("not an object");
        map.putAll(((JSONObject) v).map);
    }

    public JSONObject put(String name, Object value) throws JSONException {
        if (name == null) throw new JSONException("null name");
        if (value == null) map.remove(name);
        else map.put(name, value);
        return this;
    }
    public JSONObject put(String name, double value) throws JSONException { return put(name, Double.valueOf(value)); }
    public JSONObject put(String name, int value) throws JSONException { return put(name, Integer.valueOf(value)); }
    public JSONObject put(String name, boolean value) throws JSONException { return put(name, Boolean.valueOf(value)); }
    public Object opt(String name) { return map.get(name); }
    public JSONObject getJSONObject(String name) throws JSONException {
        Object o = map.get(name);
        if (o instanceof JSONObject) return (JSONObject) o;
        throw new JSONException("no object " + name);
    }
    public JSONObject optJSONObject(String name) { Object o = map.get(name); return o instanceof JSONObject ? (JSONObject) o : null; }
    public JSONArray getJSONArray(String name) throws JSONException {
        Object o = map.get(name);
        if (o instanceof JSONArray) return (JSONArray) o;
        throw new JSONException("no array " + name);
    }
    public JSONArray optJSONArray(String name) { Object o = map.get(name); return o instanceof JSONArray ? (JSONArray) o : null; }
    public String getString(String name) throws JSONException {
        Object o = map.get(name);
        if (o == null) throw new JSONException("no " + name);
        return String.valueOf(o);
    }
    public String optString(String name) { return optString(name, ""); }
    public String optString(String name, String fallback) {
        Object o = map.get(name);
        return o == null || o == NULL ? fallback : String.valueOf(o);
    }
    public boolean optBoolean(String name, boolean fallback) {
        Object o = map.get(name);
        if (o instanceof Boolean) return ((Boolean) o).booleanValue();
        if (o instanceof String) return Boolean.parseBoolean((String) o);
        return fallback;
    }
    public double optDouble(String name, double fallback) {
        Object o = map.get(name);
        if (o instanceof Number) return ((Number) o).doubleValue();
        try {
            return o instanceof String ? Double.parseDouble((String) o) : fallback;
        } catch (NumberFormatException e) {
            return fallback;
        }
    }
    public Iterator<String> keys() { return new java.util.ArrayList<String>(map.keySet()).iterator(); }
    public int length() { return map.size(); }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("{");
        boolean first = true;
        for (Map.Entry<String, Object> e : map.entrySet()) {
            if (!first) sb.append(',');
            first = false;
            quote(sb, e.getKey());
            sb.append(':');
            write(sb, e.getValue());
        }
        return sb.append('}').toString();
    }

    public String toString(int indentSpaces) throws JSONException { return toString(); }

    static void write(StringBuilder sb, Object v) {
        if (v == null || v == NULL) sb.append("null");
        else if (v instanceof String) quote(sb, (String) v);
        else if (v instanceof Double) {
            double d = ((Double) v).doubleValue();
            if (d == Math.rint(d) && Math.abs(d) < 1e15) sb.append((long) d);
            else sb.append(d);
        } else sb.append(v.toString());
    }

    static void quote(StringBuilder sb, String s) {
        sb.append('"');
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '"': sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (c < 0x20) sb.append(String.format("\\u%04x", Integer.valueOf(c)));
                    else sb.append(c);
            }
        }
        sb.append('"');
    }

    /** The reader of the JSON text. */
    static final class Parser {
        final String s;
        int i;

        Parser(String s) throws JSONException {
            if (s == null) throw new JSONException("null");
            this.s = s;
        }

        void ws() { while (i < s.length() && Character.isWhitespace(s.charAt(i))) i++; }

        void end() throws JSONException {
            ws();
            if (i != s.length()) throw new JSONException("text after the value");
        }

        Object value() throws JSONException {
            ws();
            if (i >= s.length()) throw new JSONException("end of text");
            char c = s.charAt(i);
            if (c == '{') {
                i++;
                JSONObject o = new JSONObject();
                ws();
                if (i < s.length() && s.charAt(i) == '}') { i++; return o; }
                while (true) {
                    ws();
                    String key = string();
                    ws();
                    expect(':');
                    o.map.put(key, value());
                    ws();
                    if (i < s.length() && s.charAt(i) == ',') { i++; continue; }
                    expect('}');
                    return o;
                }
            }
            if (c == '[') {
                i++;
                JSONArray a = new JSONArray();
                ws();
                if (i < s.length() && s.charAt(i) == ']') { i++; return a; }
                while (true) {
                    a.list.add(value());
                    ws();
                    if (i < s.length() && s.charAt(i) == ',') { i++; continue; }
                    expect(']');
                    return a;
                }
            }
            if (c == '"') return string();
            if (s.startsWith("true", i)) { i += 4; return Boolean.TRUE; }
            if (s.startsWith("false", i)) { i += 5; return Boolean.FALSE; }
            if (s.startsWith("null", i)) { i += 4; return NULL; }
            int start = i;
            while (i < s.length() && "+-0123456789.eE".indexOf(s.charAt(i)) >= 0) i++;
            if (start == i) throw new JSONException("bad value at " + i);
            String n = s.substring(start, i);
            try {
                if (n.indexOf('.') < 0 && n.indexOf('e') < 0 && n.indexOf('E') < 0) {
                    long l = Long.parseLong(n);
                    if (l >= Integer.MIN_VALUE && l <= Integer.MAX_VALUE) return Integer.valueOf((int) l);
                    return Long.valueOf(l);
                }
                return Double.valueOf(n);
            } catch (NumberFormatException e) {
                throw new JSONException("bad number " + n);
            }
        }

        void expect(char c) throws JSONException {
            if (i >= s.length() || s.charAt(i) != c) throw new JSONException("expected " + c + " at " + i);
            i++;
        }

        String string() throws JSONException {
            expect('"');
            StringBuilder sb = new StringBuilder();
            while (true) {
                if (i >= s.length()) throw new JSONException("open string");
                char c = s.charAt(i++);
                if (c == '"') return sb.toString();
                if (c != '\\') { sb.append(c); continue; }
                if (i >= s.length()) throw new JSONException("bad escape");
                char e = s.charAt(i++);
                switch (e) {
                    case 'n': sb.append('\n'); break;
                    case 'r': sb.append('\r'); break;
                    case 't': sb.append('\t'); break;
                    case 'b': sb.append('\b'); break;
                    case 'f': sb.append('\f'); break;
                    case 'u':
                        if (i + 4 > s.length()) throw new JSONException("bad escape");
                        sb.append((char) Integer.parseInt(s.substring(i, i + 4), 16));
                        i += 4;
                        break;
                    default: sb.append(e);
                }
            }
        }
    }
}
