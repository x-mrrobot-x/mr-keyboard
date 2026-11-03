package org.json;

public class JSONArray {
    public JSONArray() { }
    public JSONArray(String json) throws JSONException { }
    public JSONArray put(Object value) { return this; }
    public int length() { return 0; }
    public JSONObject getJSONObject(int index) throws JSONException { return null; }
    public JSONObject optJSONObject(int index) { return null; }
    public String optString(int index) { return ""; }
    public String getString(int index) throws JSONException { return null; }
}
