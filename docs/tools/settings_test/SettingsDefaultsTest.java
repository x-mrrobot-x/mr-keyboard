package com.mrkeyboard.app;

import android.content.SharedPreferences;
import android.content.res.Resources;
import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.lang.reflect.Proxy;
import java.nio.file.Files;
import java.util.*;
import java.util.regex.*;

/**
* Compares the fields of GlobalKeyboardSettings after initPrefs with empty preferences (defaults)
* or with old stored values. Usage: SettingsDefaultsTest <project folder> [key=value ...]
* Values "true"/"false" become booleans; the rest becomes text.
 */
public class SettingsDefaultsTest {
    static String read(File f) throws Exception { return new String(Files.readAllBytes(f.toPath()), "UTF-8"); }

    public static void main(String[] a) throws Exception {
        File root = new File(a[0]);
        final Map<Integer, String> names = new HashMap<Integer, String>();
        Matcher m = Pattern.compile("<public type=\"(\\w+)\" name=\"([^\"]+)\" id=\"0x([0-9a-f]+)\"").matcher(read(new File(root, "res/values/public.xml")));
        while (m.find()) names.put((int) Long.parseLong(m.group(3), 16), m.group(1) + "/" + m.group(2));
        final Map<String, String> vals = new HashMap<String, String>();
        for (String f : new String[] {"strings", "bools", "integers"}) {
            Matcher v = Pattern.compile("<(string|bool|integer) name=\"([^\"]+)\"[^>]*>([^<]*)</\\1>").matcher(read(new File(root, "res/values/" + f + ".xml")));
            while (v.find()) vals.put(v.group(1) + "/" + v.group(2), v.group(3));
        }
        Resources res = new Resources() {
            String val(int id) { String n = names.get(id); String v = n == null ? null : vals.get(n); if (v == null) throw new IllegalStateException("resource without a value: 0x" + Integer.toHexString(id) + " " + n); return v; }
            public String getString(int id) { return val(id); }
            public boolean getBoolean(int id) { return Boolean.parseBoolean(val(id)); }
            public int getInteger(int id) { return Integer.parseInt(val(id)); }
        };
        final Map<String, Object> store = new HashMap<String, Object>();
        for (int i = 1; i < a.length; i++) {
            String[] kv = a[i].split("=", 2);
            store.put(kv[0], kv[1].equals("true") ? (Object) Boolean.TRUE : kv[1].equals("false") ? (Object) Boolean.FALSE : kv[1]);
        }
        SharedPreferences sp = (SharedPreferences) Proxy.newProxyInstance(SettingsDefaultsTest.class.getClassLoader(),
            new Class<?>[] {SharedPreferences.class}, new InvocationHandler() {
                public Object invoke(Object p, Method me, Object[] args) {
                    String n = me.getName();
                    if (n.startsWith("get") && args != null && args.length == 2) { Object o = store.get((String) args[0]); return o != null ? o : args[1]; }
                    return null;
                }
            });
        GlobalKeyboardSettings g = new GlobalKeyboardSettings();
        g.initPrefs(sp, res);
        TreeMap<String, String> out = new TreeMap<String, String>();
        for (Field f : GlobalKeyboardSettings.class.getFields()) {
            if (Modifier.isStatic(f.getModifiers())) continue;
            Object v = f.get(g);
            out.put(f.getName(), String.valueOf(v));
        }
        for (Map.Entry<String, String> e : out.entrySet()) System.out.println(e.getKey() + "=" + e.getValue());
    }
}
