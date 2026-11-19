package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.preference.PreferenceManager;

import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * MrEngineStats: the two lines that moved from "Suggestions and dictionaries" to the card "Keyboard statistics" of Advanced (2.0.0): the suggestion
 * engine in use and the recognition time of the gesture typing. Run on the PC the native lib is not there, so the engine line says it is missing
 * and the recognition time says why there is none (typing by gestures off, the file not downloaded); the time itself needs the lib and the weights
 * (read on the phone). Also: the screen of the suggestions no longer has the two rows, and MrPerf writes the block once.
 */
public class EngineStatsTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }

    static final Map<String, String> TEXTS = new HashMap<String, String>();
    static {
        TEXTS.put("mr_engine_title", "Suggestion engine");
        TEXTS.put("mr_engine_native", "Native (C++)");
        TEXTS.put("mr_engine_missing", "Unavailable (native library not found)");
        TEXTS.put("mr_gesture_time_title", "Recognition time");
        TEXTS.put("mr_gesture_time_off", "Typing by gestures is off.");
        TEXTS.put("mr_gesture_time_nopack", "The gesture recognition has not been downloaded yet.");
    }

    static class Mem implements SharedPreferences {
        final Map<String, Object> m = new HashMap<String, Object>();
        public Map<String, ?> getAll() { return m; }
        public String getString(String k, String d) { return d; }
        public int getInt(String k, int d) { return d; }
        public long getLong(String k, long d) { return d; }
        public boolean getBoolean(String k, boolean d) { return m.containsKey(k) ? (Boolean) m.get(k) : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public Editor edit() { return null; }
    }

    static class Ctx extends Context {
        boolean broken;
        final Mem store = new Mem();
        public Resources getResources() {
            if (broken) throw new IllegalStateException("no resources");
            return new Resources() {
                public int getIdentifier(String name, String type, String pkg) { return "string".equals(type) && TEXTS.containsKey(name) ? name.hashCode() : 0; }
                public String getString(int id) { for (Map.Entry<String, String> e : TEXTS.entrySet()) if (e.getKey().hashCode() == id) return e.getValue(); return null; }
                public String getString(int id, Object... a) { return String.format(Locale.US, getString(id), a); }
            };
        }
        public String getPackageName() { return "app"; }
        public Context getApplicationContext() { return this; }
        public SharedPreferences getSharedPreferences(String n, int m) { return store; }
        public void startActivity(android.content.Intent i) { }
        public android.content.res.AssetManager getAssets() { return null; }
        public android.content.pm.PackageManager getPackageManager() { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
    }

    static String read(String path) throws Exception {
        File f = new File(path);
        return f.exists() ? new String(Files.readAllBytes(f.toPath()), "UTF-8") : null;
    }

    public static void main(String[] a) throws Exception {
        Ctx c = new Ctx();
        Mem def = new Mem();
        PreferenceManager.stubDefault = def;

        def.m.put(MrGestureInput.PREF_ON, Boolean.FALSE);
        check("no native lib, typing by gestures off: the engine line and why there is no time (one under the other)",
                "Suggestion engine: Unavailable (native library not found)\nRecognition time: Typing by gestures is off.".equals(MrEngineStats.block(c)));
        def.m.put(MrGestureInput.PREF_ON, Boolean.TRUE);
        check("typing by gestures on, the file not downloaded: says so",
                "Suggestion engine: Unavailable (native library not found)\nRecognition time: The gesture recognition has not been downloaded yet.".equals(MrEngineStats.block(c)));
        check("the engine line alone", "Suggestion engine: Unavailable (native library not found)".equals(MrEngineStats.engineLine(c)));
        String t = TEXTS.remove("mr_gesture_time_title");
        check("the title of the recognition missing: only the engine line", "Suggestion engine: Unavailable (native library not found)".equals(MrEngineStats.block(c)));
        TEXTS.put("mr_gesture_time_title", t);
        String e = TEXTS.remove("mr_engine_title");
        check("the title of the engine missing: only the recognition line", MrEngineStats.block(c).startsWith("Recognition time: "));
        String g = TEXTS.remove("mr_gesture_time_title");
        check("no text at all: nothing (the card is as it was)", MrEngineStats.block(c) == null);
        TEXTS.put("mr_engine_title", e);
        TEXTS.put("mr_gesture_time_title", g);
        c.broken = true;
        check("a phone that cannot give its resources: no exception, no lines", MrEngineStats.block(c) == null);
        c.broken = false;

        // the screen of the suggestions no longer has the rows; the card of the statistics has the block, once
        String packs = read("docs/tools/java/src/com/mrkeyboard/app/MrPacksActivity.java");
        if (packs != null) {
            check("MrPacksActivity no longer has the engine row", !packs.contains("mr_engine_title") && !packs.contains("mr_engine_native"));
            check("MrPacksActivity no longer has the recognition time row", !packs.contains("mr_gesture_time") && !packs.contains("mGTime") && !packs.contains("timeText"));
            check("the other rows of the gesture group stay (the file and the notice)", packs.contains("mGPack") && packs.contains("mGNotice"));
        } else {
            System.out.println("SKIP  MrPacksActivity.java (run at the project root)");
        }
        String perf = read("docs/tools/java/src/com/mrkeyboard/app/MrPerf.java");
        if (perf != null) {
            int n = perf.split("MrEngineStats\\.block\\(", -1).length - 1;
            check("MrPerf.summary writes the block once", n == 1);
            check("and after the memory of the dictionaries", perf.indexOf("MrDictMem.block(c)") > 0 && perf.indexOf("MrDictMem.block(c)") < perf.indexOf("MrEngineStats.block(c)"));
        }
        System.out.println(ok + " ok, " + fail + " fail");
        if (fail > 0) System.exit(1);
    }
}
