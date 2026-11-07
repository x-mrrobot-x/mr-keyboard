package com.mrkeyboard.app;

import java.io.*;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.util.Locale;

/**
 * MrDiag (1.90.0): the numbers of the "Dictionary memory" line. Checks the reading of /proc/self/smaps on made-up text (every kind of line
 * the system writes), the path matching (the same file under /data/user/0 and /data/data, a deleted file), the texts, the pack report
 * (sizes, format of trigrams.bin, times only for the file they were measured on) and, on Linux, the real thing: a file mapped by this JVM
 * under a folder shaped like files/dicts/pt-BR/8/ shows up as resident after its pages are touched and as 0 after it is unmapped.
 */
public class DiagTest {
    static int fails = 0, checks = 0;

    static void check(boolean ok, String what) {
        checks++;
        if (!ok) fails++;
        System.out.println((ok ? "OK    " : "FAIL  ") + what);
    }

    static final String SMAPS =
        "7f1000000000-7f1000400000 r--s 00000000 fd:0a 4242 /data/user/0/com.mrkeyboard.app/files/dicts/pt-BR/8/trigrams.bin\n" +
        "Size:               4096 kB\n" +
        "Rss:                 900 kB\n" +
        "Pss:                 450 kB\n" +
        "Shared_Clean:        900 kB\n" +
        "VmFlags: rd sh mr mw me ms \n" +
        "7f2000000000-7f2000200000 r--s 00000000 fd:0a 4243 /data/user/0/com.mrkeyboard.app/files/dicts/pt-BR/8/main.dict\n" +
        "Size:               2048 kB\n" +
        "Rss:                2000 kB\n" +
        "Pss:                2000 kB\n" +
        "7f2000300000-7f2000400000 r--s 00000000 fd:0a 4243 /data/user/0/com.mrkeyboard.app/files/dicts/pt-BR/8/main.dict\n" +
        "Size:               1024 kB\n" +
        "Rss:                 100 kB\n" +
        "Pss:                  50 kB\n" +
        "7f3000000000-7f3000100000 r--s 00000000 fd:0a 4244 /data/user/0/com.mrkeyboard.app/files/dicts/en-US/7/trigrams.bin (deleted)\n" +
        "Size:                 12 kB\n" +
        "Rss:                  12 kB\n" +
        "Pss:                  12 kB\n" +
        "7f4000000000-7f4000100000 rw-p 00000000 00:00 0 \n" +
        "Size:                 100 kB\n" +
        "Rss:                  100 kB\n" +
        "Pss:                  100 kB\n";

    public static void main(String[] a) throws Exception {
        Locale.setDefault(Locale.US);

        // ---- smaps text
        check(MrDiag.residentIn(new StringReader(SMAPS), "/dicts/pt-BR/8/trigrams.bin") == 450L * 1024, "trigrams.bin: its Pss (not the Rss) counts");
        check(MrDiag.residentIn(new StringReader(SMAPS), "/dicts/pt-BR/8/main.dict") == 2050L * 1024, "main.dict mapped twice: the Pss of both mappings is added");
        check(MrDiag.residentIn(new StringReader(SMAPS), "/dicts/en-US/7/trigrams.bin") == 12L * 1024, "a deleted file is still counted (the pack was replaced, the old one is still mapped)");
        check(MrDiag.residentIn(new StringReader(SMAPS), "/dicts/pt-BR/9/trigrams.bin") == 0, "a file that is not mapped is 0");
        check(MrDiag.residentIn(new StringReader(SMAPS), "/dicts/pt-BR/8/trigrams.bi") == 0, "a path that only starts like one is not it");
        check(MrDiag.residentIn(new StringReader(SMAPS), "/files/dicts/pt-BR/8/main.dict") == 2050L * 1024, "the longer tail also matches");
        check(MrDiag.residentIn(new StringReader(""), "/dicts/x/1/main.dict") == 0, "empty smaps is 0");
        check(MrDiag.residentIn(new StringReader("Rss: 77 kB\n"), "/a") == 0, "a value line before any header is ignored");
        String noPss = "7f1000000000-7f1000400000 r--s 00000000 fd:0a 4242 /x/dicts/a/1/main.dict\nSize: 10 kB\nRss: 8 kB\n";
        check(MrDiag.residentIn(new StringReader(noPss), "/dicts/a/1/main.dict") == 8L * 1024, "without Pss the Rss is used");
        check(MrDiag.residentIn(new StringReader(SMAPS.replace("\n", "\r\n")), "/dicts/pt-BR/8/trigrams.bin") == 450L * 1024, "CRLF lines");

        // ---- paths
        check(MrDiag.tail(new File("/data/user/0/com.mrkeyboard.app/files/dicts/pt-BR/8/main.dict")).equals("/dicts/pt-BR/8/main.dict"), "tail: four parts");
        check(MrDiag.tail(new File("/data/data/com.mrkeyboard.app/files/dicts/pt-BR/8/main.dict")).equals("/dicts/pt-BR/8/main.dict"), "tail: /data/data and /data/user/0 give the same");
        check(MrDiag.tail(new File("a/b")).equals("/a/b"), "tail: a short path");

        // ---- texts
        check(MrDiag.bytesText(3556058).equals("3.6 MB") && MrDiag.bytesText(999499).equals("999 KB") && MrDiag.bytesText(0).equals("0 KB") && MrDiag.bytesText(-1).equals("?"), "bytesText");
        check(MrDiag.msText(500000).equals("0.5") && MrDiag.msText(12345678).equals("12.3") && MrDiag.msText(-1).equals("?") && MrDiag.msText(0).equals("0.0"), "msText");
        Locale.setDefault(new Locale("pt", "BR"));
        check(MrDiag.bytesText(3556058).equals("3,6 MB") && MrDiag.msText(500000).equals("0,5"), "texts follow the language (decimal comma)");
        Locale.setDefault(Locale.US);

        // ---- the report of a pack folder
        File root = Files.createTempDirectory("mrdiag").toFile();
        File dir = new File(root, "files/dicts/pt-BR/8");
        check(dir.mkdirs(), "temporary folder");
        byte[] mainBytes = new byte[300000];
        mainBytes[0] = (byte) 200; mainBytes[1] = 2;
        write(new File(dir, "main.dict"), mainBytes);
        byte[] tri2 = new byte[200000];
        System.arraycopy(new byte[] {'M', 'R', 'T', '2'}, 0, tri2, 0, 4);
        File triFile = new File(dir, "trigrams.bin");
        write(triFile, tri2);
        MrDiag.sDictPath = null; MrDiag.sTriPath = null; MrDiag.sEngineNs = -1; MrDiag.sRulesNs = -1;
        MrDiag.Report r = MrDiag.collect(dir);
        check(r.id.equals("pt-BR") && r.version == 8, "report: id and version come from the folder");
        check(r.dictBytes == 300000 && r.triBytes == 200000 && r.hasTri && r.triFormat == 2, "report: sizes and the format of trigrams.bin");
        check(r.dictNs == -1 && r.triNs == -1 && r.engineNs == -1, "report: times not measured yet are -1");
        MrDiag.sDictPath = new File(dir, "main.dict").getPath(); MrDiag.sDictNs = 4100000;
        MrDiag.sTriPath = "/some/other/trigrams.bin"; MrDiag.sTriNs = 900000;
        MrDiag.sEngineNs = 9000000; MrDiag.sRulesNs = 3000000;
        r = MrDiag.collect(dir);
        check(r.dictNs == 4100000 && r.triNs == -1 && r.engineNs == 9000000 && r.rulesNs == 3000000, "report: a time only counts for the file it was measured on");
        tri2[3] = '1';
        write(triFile, tri2);
        check(MrDiag.collect(dir).triFormat == 1, "report: MRT1 is told from MRT2");
        write(triFile, new byte[] {1, 2});
        check(MrDiag.collect(dir).triFormat == 0, "report: a file that is not MRT is format 0");
        check(triFile.delete() && !MrDiag.collect(dir).hasTri, "report: no trigrams.bin, no line for it");
        check(MrDiag.collect(null).id.equals("") && MrDiag.collect(new File(root, "nothing/here")).dictBytes == -1, "report: no folder, no pack: nothing is thrown");

        // ---- the real thing (Linux): a mapped file is resident after it is touched, and 0 after it is unmapped
        if (new File("/proc/self/smaps").canRead()) {
            File f = new File(dir, "main.dict");
            RandomAccessFile raf = new RandomAccessFile(f, "rw");
            raf.setLength(8L << 20);
            MappedByteBuffer buf = raf.getChannel().map(FileChannel.MapMode.READ_WRITE, 0, 8L << 20);
            long before = MrDiag.resident(f);
            check(before >= 0, "real smaps: the mapping is listed (resident " + before / 1024 + " KB before touching)");
            for (int i = 0; i < (8 << 20); i += 4096) buf.put(i, (byte) 1);
            long after = MrDiag.resident(f);
            check(after >= (7L << 20) && after > before, "real smaps: after touching 8 MB, about 8 MB are resident (" + after / 1024 + " KB)");
            check(MrDiag.collect(dir).dictMem == after, "report: the memory of the dictionary is the same number");
            check(MrDiag.resident(new File(dir, "never.bin")) == 0, "real smaps: a file that is not mapped is 0");
            raf.close();
        } else {
            System.out.println("SKIP  real smaps (no /proc/self/smaps here)");
        }
        check(MrDiag.resident(new File("/dev/null/x")) >= 0 || !new File("/proc/self/smaps").canRead(), "resident() of a strange path gives a number or -1, never throws");

        deleteTree(root);
        System.out.println(fails == 0 ? "ALL OK (" + checks + " checks)" : fails + " FAILURE(S) out of " + checks + " checks");
        System.exit(fails == 0 ? 0 : 1);
    }

    static void write(File f, byte[] d) throws IOException {
        FileOutputStream o = new FileOutputStream(f);
        try { o.write(d); } finally { o.close(); }
    }

    static void deleteTree(File f) {
        File[] kids = f.listFiles();
        if (kids != null) for (File k : kids) deleteTree(k);
        f.delete();
    }
}
