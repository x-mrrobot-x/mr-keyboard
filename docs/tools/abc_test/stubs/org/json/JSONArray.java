package org.json;

import java.util.ArrayList;

/** Test only (AbcKeysTest): the array of the working org.json of this folder. */
public class JSONArray {
    final ArrayList<Object> list = new ArrayList<Object>();

    public JSONArray() { }

    public JSONArray(String json) throws JSONException {
        JSONObject.Parser p = new JSONObject.Parser(json);
        Object v = p.value();
        p.end();
        if (!(v instanceof JSONArray)) throw new JSONException("not an array");
        list.addAll(((JSONArray) v).list);
    }

    public JSONArray put(Object value) { list.add(value); return this; }
    public int length() { return list.size(); }
    public JSONObject getJSONObject(int index) throws JSONException {
        Object o = index >= 0 && index < list.size() ? list.get(index) : null;
        if (o instanceof JSONObject) return (JSONObject) o;
        throw new JSONException("no object at " + index);
    }
    public JSONObject optJSONObject(int index) {
        Object o = index >= 0 && index < list.size() ? list.get(index) : null;
        return o instanceof JSONObject ? (JSONObject) o : null;
    }
    public JSONArray optJSONArray(int index) {
        Object o = index >= 0 && index < list.size() ? list.get(index) : null;
        return o instanceof JSONArray ? (JSONArray) o : null;
    }
    public String optString(int index) {
        Object o = index >= 0 && index < list.size() ? list.get(index) : null;
        return o == null || o == JSONObject.NULL ? "" : String.valueOf(o);
    }
    public String getString(int index) throws JSONException {
        Object o = index >= 0 && index < list.size() ? list.get(index) : null;
        if (o == null) throw new JSONException("no value at " + index);
        return String.valueOf(o);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0) sb.append(',');
            JSONObject.write(sb, list.get(i));
        }
        return sb.append(']').toString();
    }
}
