package com.mrkeyboard.app;

import java.io.File;
import java.nio.file.Files;
import java.util.Map;

/** Downloads the real catalog and pack from GitHub with the HttpURLConnection of MrPacks. */
public class LiveTest {
    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mrlive").toFile();
        PacksTest.Ctx ctx = new PacksTest.Ctx(tmp);
        long t0 = System.nanoTime();
        byte[] env = MrPacks.fetchBytes(MrPacks.CATALOG_URL, MrPacks.MAX_CATALOG);
        Map<String, Object> e = MrJson.obj(MrJson.parse(new String(env, "UTF-8")));
        MrPacks.Catalog cat = MrPacks.readData(MrJson.str(e, "data"));
        MrPacks.Pack p = cat.packs.get(0);
        System.out.printf("catalog: %d bytes, serial %d, %s v%d (%d bytes), signed by %s%n", env.length, cat.serial, p.id,
                p.version, p.size, MrJson.str(e, "signer").substring(0, 16));
        MrPacks.install(ctx, cat, p);
        File d = MrPacks.packDir(ctx, p.id, p.version);
        System.out.printf("installed in %.1f s: %s%n", (System.nanoTime() - t0) / 1e9, java.util.Arrays.toString(d.list()));
        Suggest s = new Suggest(ctx, new int[] {0});
        System.out.println("Suggest with the pack dictionary: " + s.hasMainDictionary() + ", corrections " + MrRules.get().corrections.size());
        MrPacks.deleteTree(tmp);
    }
}
