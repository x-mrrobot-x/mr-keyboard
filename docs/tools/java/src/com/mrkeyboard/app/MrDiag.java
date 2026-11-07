package com.mrkeyboard.app;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Locale;

/**
 * Numbers for the "Dictionary memory" line of the dictionaries screen (v1.90.0): how long each part took to load and how much of each
 * file is in memory now. They exist to be read on a real phone: the PC figures (docs/native-engine.md) say how the code behaves, not how
 * long a cheap phone takes to open a file or how much of it the system keeps.
 *
 * Times are taken by the code that does the work (MrNative.load, MrPacks.open, MrTrigram.open) and left here; the memory is read from
 * /proc/self/smaps, the list of the memory mappings of this process: the dictionary (main.dict) and, since 1.90.0, trigrams.bin are
 * mapped from the file, so what counts is how many of their pages the system has resident (Pss: the pages of a file mapped twice are not
 * counted twice). These are pages of the file, clean and shared: the system can drop them when it needs the memory and read them
 * again later, they are not heap of the app. Nothing here changes how the keyboard works; if smaps cannot be read the memory is
 * simply not shown.
 */
final class MrDiag {
    private MrDiag() { }

    // Load times in nanoseconds and the file each one was measured on; -1 = not measured yet. Written by the thread that loads, read by the screen.
    static volatile long sEngineNs = -1;    // System.loadLibrary + tables handed over (MrNative.load)
    static volatile long sRulesNs = -1;     // the rules of the language handed over (the last time)
    static volatile long sDictNs = -1;      // mapping main.dict and creating the reader (MrPacks.open)
    static volatile String sDictPath;
    static volatile long sTriNs = -1;       // opening trigrams.bin in the lib (MrTrigram.open)
    static volatile String sTriPath;

    /** What the screen shows for one pack in use. -1 = not known. */
    static final class Report {
        String id = "";
        int version;
        long dictBytes = -1, dictMem = -1, dictNs = -1;
        long triBytes = -1, triMem = -1, triNs = -1;
        int triFormat;                      // 1 = MRT1, 2 = MRT2, 0 = unknown / no file
        long engineNs = -1, rulesNs = -1;
        boolean hasTri;
    }

    /** Reads everything for the pack folder files/dicts/&lt;id&gt;/&lt;version&gt;. Reads smaps: call it off the main thread. */
    static Report collect(File dir) {
        Report r = new Report();
        if (dir == null) return r;
        r.id = dir.getParentFile() != null ? dir.getParentFile().getName() : "";
        try {
            r.version = Integer.parseInt(dir.getName());
        } catch (NumberFormatException e) {
            r.version = 0;
        }
        File main = new File(dir, MrPacks.MAIN);
        File tri = new File(dir, MrPacks.TRIGRAMS);
        r.engineNs = sEngineNs;
        r.rulesNs = sRulesNs;
        if (main.isFile()) {
            r.dictBytes = main.length();
            r.dictMem = resident(main);
            r.dictNs = main.getPath().equals(sDictPath) ? sDictNs : -1;
        }
        if (tri.isFile()) {
            r.hasTri = true;
            r.triBytes = tri.length();
            r.triMem = resident(tri);
            r.triNs = tri.getPath().equals(sTriPath) ? sTriNs : -1;
            r.triFormat = formatOf(tri);
        }
        return r;
    }

    /** 1 for MRT1, 2 for MRT2, 0 for anything else or if it cannot be read (the first four bytes). */
    static int formatOf(File f) {
        FileInputStream in = null;
        try {
            in = new FileInputStream(f);
            byte[] m = new byte[4];
            int n = 0;
            while (n < 4) {
                int k = in.read(m, n, 4 - n);
                if (k <= 0) break;
                n += k;
            }
            if (n == 4 && m[0] == 'M' && m[1] == 'R' && m[2] == 'T') {
                if (m[3] == '1') return 1;
                if (m[3] == '2') return 2;
            }
        } catch (IOException e) {
            // 0
        } finally {
            if (in != null) {
                try { in.close(); } catch (IOException e) { /* nothing to do */ }
            }
        }
        return 0;
    }

    /** The last four parts of the path (dicts/&lt;id&gt;/&lt;version&gt;/&lt;name&gt;), with a slash in front: the same file has different prefixes in Android (/data/user/0, /data/data). */
    static String tail(File f) {
        StringBuilder sb = new StringBuilder();
        File p = f;
        for (int i = 0; i < 4 && p != null && p.getName().length() > 0; i++) {
            sb.insert(0, "/" + p.getName());
            p = p.getParentFile();
        }
        return sb.toString();
    }

    /** Bytes of the file that are in memory now (smaps), 0 if the file is not mapped, -1 if smaps cannot be read. */
    static long resident(File f) {
        Reader r = null;
        try {
            r = new FileReader("/proc/self/smaps");
            return residentIn(r, tail(f));
        } catch (Throwable e) {
            return -1;
        } finally {
            if (r != null) {
                try { r.close(); } catch (IOException e) { /* nothing to do */ }
            }
        }
    }

    /**
     * Adds the Pss (or, if the system does not give it, the Rss) of every mapping whose line ends with the tail of the path
     * (or with it followed by " (deleted)"). In smaps a mapping is one header line (address range, permissions, ..., path) followed by lines
     * "Name: value kB"; the headers start with a hex digit, the others with a capital letter.
     */
    static long residentIn(Reader in, String tail) throws IOException {
        BufferedReader br = new BufferedReader(in, 16384);
        long pss = 0, rss = 0;
        boolean mine = false;
        String line;
        while ((line = br.readLine()) != null) {
            if (line.length() == 0) continue;
            char c = line.charAt(0);
            if ((c >= '0' && c <= '9') || (c >= 'a' && c <= 'f')) {
                mine = line.endsWith(tail) || line.endsWith(tail + " (deleted)");
                continue;
            }
            if (!mine) continue;
            if (line.startsWith("Pss:")) pss += kb(line);
            else if (line.startsWith("Rss:")) rss += kb(line);
        }
        return (pss > 0 ? pss : rss) * 1024L;
    }

    private static long kb(String line) {
        long v = 0;
        boolean any = false;
        for (int i = line.indexOf(':') + 1; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c >= '0' && c <= '9') {
                v = v * 10 + (c - '0');
                any = true;
            } else if (any) {
                break;
            }
        }
        return v;
    }

    /** "3.4 MB" from one megabyte (decimal, like the sizes of the packs), "820 KB" below it. */
    static String bytesText(long bytes) {
        if (bytes < 0) return "?";
        if (bytes >= 1000000L) return String.format(Locale.getDefault(), "%.1f MB", bytes / 1000000.0);
        return String.format(Locale.getDefault(), "%d KB", (bytes + 500) / 1000);
    }

    /** Milliseconds with one decimal ("0.5", "12.3"); "?" if it was not measured. */
    static String msText(long ns) {
        if (ns < 0) return "?";
        return String.format(Locale.getDefault(), "%.1f", ns / 1000000.0);
    }
}
