package com.mrkeyboard.app;

import android.content.res.Resources;
import android.preference.Preference;
import android.preference.PreferenceActivity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.file.Files;
import java.util.Locale;

/**
 * MrDictMem: the "Dictionary memory" row of Settings → Advanced → Performance, run against the stubs of Android. Checks what the row says
 * with no dictionary yet (no thread started), the text that is put at once ("Reading…") and the one that arrives from the thread (the pack, the
 * triples, the engine), a pack without triples, an answer that arrives after a newer read started (dropped), a screen that is gone when the
 * answer arrives (nothing written), a screen without the row, a screen that fails, and texts that are missing (the name is shown, nothing is thrown).
 */
public class DictMemTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) fails++;
        System.out.println((ok ? "OK    " : "FAIL  ") + what);
    }

    static final String[][] TEXTS = {
        {"mr_mem_title", "Dictionary memory"}, {"mr_mem_wait", "Reading…"}, {"mr_mem_none", "No dictionary loaded yet."},
        {"mr_mem_dict", "%1$s v%2$d · words %3$s, %4$s in memory, opened in %5$s ms"},
        {"mr_mem_tri", "Word triples (MRT%1$d) %2$s, %3$s in memory, opened in %4$s ms"},
        {"mr_mem_tri_none", "Word triples: none in this pack"}, {"mr_mem_engine", "Engine started in %1$s ms, rules in %2$s ms"},
        {"mr_mem_nomem", "Memory use is not available on this device."}};

    static class Row extends Preference {
        CharSequence summary;
        int sets;
        Row() { super(null); }
        public void setSummary(CharSequence s) { summary = s; sets++; }
    }

    static class Screen extends PreferenceActivity {
        final Row row = new Row();
        boolean hasRow = true, broken, gone, noTexts;
        public Preference findPreference(CharSequence key) {
            if (broken) throw new IllegalStateException("no screen");
            return hasRow && "mr_dict_mem".equals(String.valueOf(key)) ? row : null;
        }
        public boolean isFinishing() { return gone; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public Resources getResources() {
            return new Resources() {
                public int getIdentifier(String name, String defType, String defPackage) {
                    if (noTexts || !"string".equals(defType)) return 0;
                    for (String[] t : TEXTS) if (t[0].equals(name)) return name.hashCode();
                    return 0;
                }
                String byId(int id) {
                    for (String[] t : TEXTS) if (t[0].hashCode() == id) return t[1];
                    return null;
                }
                public String getString(int id) { return byId(id); }
                public String getString(int id, Object... args) { return String.format(Locale.US, byId(id), args); }
            };
        }
    }

    static void setActive(File dir) throws Exception {
        Field f = MrPacks.class.getDeclaredField("sActiveDir");
        f.setAccessible(true);
        f.set(null, dir == null ? null : dir.getPath());
    }

    static File pack(File root, String id, int version, boolean tri) throws IOException {
        File dir = new File(root, "files/dicts/" + id + "/" + version);
        dir.mkdirs();
        write(new File(dir, "main.dict"), new byte[300000]);
        if (tri) {
            byte[] t = new byte[200000];
            t[0] = 'M'; t[1] = 'R'; t[2] = 'T'; t[3] = '2';
            write(new File(dir, "trigrams.bin"), t);
        }
        return dir;
    }

    static void write(File f, byte[] d) throws IOException {
        FileOutputStream o = new FileOutputStream(f);
        try { o.write(d); } finally { o.close(); }
    }

    /** Waits until the threads of the reads have posted their answers, then runs them on "the main thread". */
    static void arrive(int expected) throws Exception {
        long end = System.currentTimeMillis() + 10000;
        while (MrDictMem.main().stubPending() < expected && System.currentTimeMillis() < end) Thread.sleep(5);
        check(MrDictMem.main().stubPending() == expected, "the threads posted " + expected + " answer(s) (" + MrDictMem.main().stubPending() + ")");
        MrDictMem.main().stubRunPending();
    }

    public static void main(String[] a) throws Exception {
        Locale.setDefault(Locale.US);
        File root = Files.createTempDirectory("mrdictmem").toFile();

        // ---- no dictionary yet: the text says so at once, no thread, no memory map read
        setActive(null);
        int reads = MrDictMem.sReads;
        Screen s = new Screen();
        MrDictMem.fill(s);
        check("No dictionary loaded yet.".equals(String.valueOf(s.row.summary)), "no pack in use: the row says there is none");
        check(MrDictMem.sReads == reads && MrDictMem.main().stubPending() == 0, "... and no thread was started");

        // ---- a pack in use: "Reading…" at once, the lines when the thread is done
        File pt = pack(root, "pt-BR", 8, true);
        setActive(pt);
        MrDiag.sDictPath = null; MrDiag.sTriPath = null; MrDiag.sEngineNs = -1; MrDiag.sRulesNs = -1;
        MrDiag.sDictPath = new File(pt, "main.dict").getPath(); MrDiag.sDictNs = 4100000;
        MrDiag.sTriPath = new File(pt, "trigrams.bin").getPath(); MrDiag.sTriNs = 900000;
        MrDiag.sEngineNs = 9000000; MrDiag.sRulesNs = 3000000;
        s = new Screen();
        MrDictMem.fill(s);
        check("Reading…".equals(String.valueOf(s.row.summary)), "a pack in use: the row says it is reading until the thread is done");
        check(MrDictMem.sReads == reads + 1, "... one read started");
        arrive(1);
        String text = String.valueOf(s.row.summary);
        String[] lines = text.split("\n");
        check(lines[0].startsWith("pt-BR v8 · words 300 KB, ") && lines[0].endsWith(" in memory, opened in 4.1 ms"),
                "line 1: the pack, its size and the time it took to open (" + lines[0] + ")");
        check(lines[1].startsWith("Word triples (MRT2) 200 KB, ") && lines[1].endsWith(" in memory, opened in 0.9 ms"), "line 2: the triples, their format, size and time (" + lines[1] + ")");
        check(lines[2].equals("Engine started in 9.0 ms, rules in 3.0 ms"), "line 3: the engine and the rules (" + lines[2] + ")");
        check(s.row.sets == 2, "the row was written twice only: Reading… and the text");

        // ---- the same text is made by text() from a report (a pack without triples, nothing measured, no memory read)
        File en = pack(root, "en-US", 7, false);
        MrDiag.Report r = MrDiag.collect(en);
        r.dictMem = -1; r.triMem = -1;
        String t2 = MrDictMem.text(s, r);
        check(t2.contains("en-US v7 · words 300 KB, ? in memory, opened in ?") && t2.contains("Word triples: none in this pack"), "a pack without triples says so, '?' for what is not known");
        check(t2.endsWith("Memory use is not available on this device."), "no memory reading at all: the last line says so");
        r.dictMem = 0;
        check(!MrDictMem.text(s, r).contains("Memory use is not available"), "one memory number known (even 0): no such line");
        check("No dictionary loaded yet.".equals(MrDictMem.text(s, null)), "no report: no dictionary yet");

        // ---- an answer that arrives after a newer read started is dropped
        setActive(pt);
        Screen s2 = new Screen();
        MrDictMem.fill(s2);          // read of pt-BR
        setActive(en);
        MrDictMem.fill(s2);          // newer read of en-US on the same row
        arrive(2);
        check(String.valueOf(s2.row.summary).startsWith("en-US v7"), "two reads one after the other: the row shows the newer one (" + String.valueOf(s2.row.summary).split("\n")[0] + ")");
        check(s2.row.sets == 3, "... and the older answer wrote nothing (Reading…, Reading…, the newer text)");

        // ---- the pack goes away while a read is running: the late answer is dropped
        setActive(pt);
        Screen s3 = new Screen();
        MrDictMem.fill(s3);
        setActive(null);
        MrDictMem.fill(s3);          // no pack now: "none" at once
        arrive(1);
        check("No dictionary loaded yet.".equals(String.valueOf(s3.row.summary)), "a late answer does not replace 'no dictionary yet' (" + s3.row.summary + ")");

        // ---- the screen is gone when the answer arrives
        setActive(pt);
        Screen gone = new Screen();
        MrDictMem.fill(gone);
        gone.gone = true;
        arrive(1);
        check("Reading…".equals(String.valueOf(gone.row.summary)) && gone.row.sets == 1, "a finished screen is not written to");

        // ---- no row on the screen, a broken screen, texts that are missing
        Screen none = new Screen();
        none.hasRow = false;
        reads = MrDictMem.sReads;
        MrDictMem.fill(none);
        check(MrDictMem.sReads == reads && none.row.summary == null && MrDictMem.main().stubPending() == 0, "no row: nothing set, no thread");
        Screen broken = new Screen();
        broken.broken = true;
        boolean thrown = false;
        try { MrDictMem.fill(broken); } catch (RuntimeException e) { thrown = true; }
        check(!thrown, "a broken screen: no exception");
        Screen bare = new Screen();
        bare.noTexts = true;
        setActive(null);
        MrDictMem.fill(bare);
        check("mr_mem_none".equals(String.valueOf(bare.row.summary)), "texts missing: the name is shown, nothing is thrown");

        setActive(null);
        deleteTree(root);
        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }

    static void deleteTree(File f) {
        File[] kids = f.listFiles();
        if (kids != null) for (File k : kids) deleteTree(k);
        f.delete();
    }
}
