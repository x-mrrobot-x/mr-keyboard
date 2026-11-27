package org.json;

public class JSONObject {
    public JSONObject() { }
    public JSONObject(String json) throws JSONException { }
    public JSONObject put(String name, Object value) throws JSONException { return this; }
    public JSONObject put(String name, double value) throws JSONException { return this; }
    public JSONObject put(String name, int value) throws JSONException { return this; }
    public JSONObject getJSONObject(String name) throws JSONException { return null; }
    public JSONObject optJSONObject(String name) { return null; }
    public JSONArray getJSONArray(String name) throws JSONException { return null; }
    public JSONArray optJSONArray(String name) { return null; }
    public String getString(String name) throws JSONException { return null; }
    public String optString(String name) { return ""; }
    public String optString(String name, String fallback) { return fallback; }
    public Object opt(String name) { return null; }
    public JSONObject put(String name, boolean value) throws JSONException { return this; }
    public boolean optBoolean(String name, boolean fallback) { return fallback; }
    public double optDouble(String name, double fallback) { return fallback; }
    public java.util.Iterator<String> keys() { return new java.util.ArrayList<String>().iterator(); }
    public String toString(int indentSpaces) throws JSONException { return "{}"; }
}
