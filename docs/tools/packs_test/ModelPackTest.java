package com.mrkeyboard.app;

import android.content.SharedPreferences;

import java.io.*;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/**
 * PC test of the gesture recognition pack (1.96.0): the "models" list of the signed catalog, and the download, the checks, the
 * install, the update and the removal of the weights by MrPacks, with the classes of the APK, the PC native lib and the fake
 * Android of PacksTest. The fixtures are made by make_model_fixtures.py from the real gesture/ folder, so the file the lib opens
 * at the end is the one that ships. It also covers the weights installed from a file the user picked (MrPacks.installModelFile):
 * only the known file is taken, and the table of known files agrees with gesture/. run_packs_tests.sh runs it after PacksTest.
 */
public class ModelPackTest {
    static final String FX = PacksTest.FX;
    static final String G = "gesture";
    static final String ZIP1 = "mr-keyboard-model-gesture-1.zip", ZIP2 = "mr-keyboard-model-gesture-2.zip";

    static void check(String label, boolean ok, Object detail) {
        PacksTest.check(label, ok, detail);
    }

    static String errOf(PacksTest.Job j) {
        return PacksTest.errOf(j);
    }

    static List<String> list(File dir) {
        return PacksTest.list(dir);
    }

    static MrPacks.Catalog fetch(PacksTest.Ctx ctx, String fx) {
        PacksTest.catalogFile = FX + fx + "/catalog.json";
        PacksTest.zipDir = FX + fx + "/";
        String r = errOf(() -> MrPacks.fetchCatalog(ctx));
        if (!r.equals("ok")) check("catalog " + fx + " is accepted", false, r);
        return MrPacks.cachedCatalog(ctx);
    }

    /** MrGesture opens the weights in a thread of its own: waits for it (or for the close) up to 5 s. */
    static boolean waitReady(boolean want) throws InterruptedException {
        for (int i = 0; i < 100 && MrGesture.ready() != want; i++) Thread.sleep(50);
        return MrGesture.ready() == want;
    }

    /** The fake resources of PacksTest plus the one raw resource the app reads: the text of the licence kept in the APK. */
    static class MRes extends PacksTest.Res {
        boolean noLicence;
        public int getIdentifier(String name, String type, String pkg) {
            if (name.equals("mr_futo_license") && type.equals("raw")) return noLicence ? 0 : 77;
            return super.getIdentifier(name, type, pkg);
        }
        public InputStream openRawResource(int id) {
            try {
                return id == 77 ? new FileInputStream("res/raw/mr_futo_license.md") : null;
            } catch (IOException e) {
                return null;
            }
        }
    }

    static class MCtx extends PacksTest.Ctx {
        final MRes mres = new MRes();
        MCtx(File dir) { super(dir); }
        public android.content.res.Resources getResources() { return mres; }
    }

    /** A stream of n bytes of the same value that counts what was asked of it (a file far too large to be weights). */
    static class Endless extends InputStream {
        long left, given;
        Endless(long n) { left = n; }
        public int read() { if (left <= 0) return -1; left--; given++; return 7; }
        public int read(byte[] b, int off, int len) {
            if (left <= 0) return -1;
            int k = (int) Math.min(len, left);
            Arrays.fill(b, off, off + k, (byte) 7);
            left -= k; given += k;
            return k;
        }
    }

    static String text(String file, String name) throws IOException {
        String s = new String(Files.readAllBytes(Paths.get(file)), "UTF-8");
        int at = s.indexOf("<string name=\"" + name + "\">");
        if (at < 0) return "";
        return s.substring(s.indexOf('>', at) + 1, s.indexOf("</string>", at));
    }

    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mrmodel").toFile();
        final MCtx ctx = new MCtx(tmp);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        MrPacks.sTestCerts = new X509Certificate[] {(X509Certificate) cf.generateCertificate(new FileInputStream(PacksTest.FA + "/cert.pem"))};
        PacksTest.net();
        final SharedPreferences dp = ctx.getSharedPreferences("default", 0);
        final File models = new File(ctx.getFilesDir(), "models");

        // ---- the catalog
        final MrPacks.Catalog c1 = fetch(ctx, "m_ok");
        final MrPacks.Pack g1 = c1 != null ? c1.model(G) : null;
        check("catalog with models: the language list is what it was (pt-BR v2) and the model is not in it",
                c1 != null && c1.serial == 1 && c1.packs.size() == 1 && c1.packs.get(0).id.equals("pt-BR") && c1.find(G) == null, null);
        check("catalog with models: one model, gesture v1, format 1, minApp 1096000, in v1.96.0",
                c1 != null && c1.models.size() == 1 && g1 != null && g1.model && g1.version == 1 && g1.format == 1 && g1.minApp == 1096000
                && "v1.96.0".equals(g1.release) && ZIP1.equals(g1.url), g1 == null ? null : g1.version + " " + g1.minApp + " " + g1.url);
        check("the model has a name in the 3 languages, a description, the licence and the credits",
                g1 != null && g1.name(new Locale("pt", "BR")).equals("Reconhecimento de gestos") && g1.name(Locale.US).equals("Gesture recognition")
                && g1.name(new Locale("es")).equals("Reconocimiento de gestos") && g1.name(Locale.GERMANY).equals("Gesture recognition")
                && g1.description(new Locale("pt", "BR")).contains("FUTO Swipe") && g1.licenses.contains("FUTO Model Weights License 1.0")
                && g1.credits.contains("FUTO Holdings"), g1 == null ? null : g1.name(new Locale("pt", "BR")) + " | " + g1.licenses);
        check("this app can use it (and the app of the versionCode before 1096000 could not)", g1 != null && !MrPacks.appTooOld(ctx, g1)
                && MrPacks.appVersion(ctx) >= 1096000, MrPacks.appVersion(ctx));
        check("nothing installed: no model version, no file, no update counted", MrPacks.modelVersion(ctx, G) == 0
                && MrPacks.modelFile(ctx, G, MrPacks.ENCODER) == null && MrPacks.updatesAvailable(ctx, c1) == 0 && !models.exists(), null);

        // ---- the option without the file
        MrGestureInput.init(ctx);
        check("default: gesture typing is off", !MrGestureInput.sOn && !MrGesture.ready(), null);
        dp.edit().putBoolean("pref_gesture_typing", true).commit();
        MrGestureInput.reload(ctx);
        check("option on, file not downloaded: still off, nothing open in the lib", !MrGestureInput.sOn && waitReady(false), null);
        dp.edit().remove("pref_gesture_typing").commit();
        MrGestureInput.reload(ctx);

        // ---- downloads that must not install
        PacksTest.cancelAfter = 3;
        String r = errOf(() -> MrPacks.install(ctx, c1, g1));
        check("cancel in the middle of the download", r.equals("mr_dicts_err_cancel") && MrPacks.modelVersion(ctx, G) == 0, r);
        PacksTest.cancelAfter = -1;
        PacksTest.corruptAt = 1000000;
        r = errOf(() -> MrPacks.install(ctx, c1, g1));
        check("zip with one byte changed is rejected (sha256)", r.equals("mr_dicts_err_corrupt [sha256]"), r);
        PacksTest.corruptAt = -1;
        PacksTest.truncateAt = 500000;
        r = errOf(() -> MrPacks.install(ctx, c1, g1));
        check("truncated zip is rejected", r.equals("mr_dicts_err_corrupt [size]"), r);
        PacksTest.truncateAt = -1;
        PacksTest.httpCode = 404;
        r = errOf(() -> MrPacks.install(ctx, c1, g1));
        check("HTTP 404 on the zip becomes a message with the code", r.equals("mr_dicts_err_http [404]"), r);
        PacksTest.httpCode = 200;
        check("after the failures: nothing installed, nothing left in cache/ or in models/",
                MrPacks.modelVersion(ctx, G) == 0 && list(ctx.getCacheDir()).isEmpty() && list(new File(models, G)).isEmpty(), list(new File(models, G)));

        // ---- installation
        dp.edit().putBoolean("show_suggestions", false).commit();
        long before = dp.getLong("mr_dicts_updated_at", 0);
        r = errOf(() -> MrPacks.install(ctx, c1, g1));
        File d1 = MrPacks.modelDir(ctx, G, 1);
        check("installs", r.equals("ok") && MrPacks.modelVersion(ctx, G) == 1, r);
        check("the zip was asked from the release in the catalog, with the model name",
                ("https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.96.0/" + ZIP1).equals(PacksTest.lastZipUrl), PacksTest.lastZipUrl);
        check("files in files/models/gesture/1: the weights, the licence, the notice and pack.json",
                d1.equals(new File(new File(models, G), "1")) && list(d1).equals(Arrays.asList("LICENSE-FUTO-Model-Weights.md", "NOTICE.txt", "encoder.bin", "pack.json")), list(d1));
        check("nothing is left in cache/ or .tmp", list(ctx.getCacheDir()).isEmpty() && list(d1.getParentFile()).equals(Arrays.asList("1")), list(d1.getParentFile()));
        File enc = MrPacks.modelFile(ctx, G, MrPacks.ENCODER);
        byte[] shipped = Files.readAllBytes(Paths.get("gesture/encoder.bin"));
        check("the installed weights are, byte for byte, gesture/encoder.bin of the repository",
                enc != null && Arrays.equals(Files.readAllBytes(enc.toPath()), shipped), enc == null ? null : enc.length());
        File lic = MrPacks.modelFile(ctx, G, MrPacks.MODEL_LICENSE);
        check("the licence of the weights came with them, whole", lic != null
                && Arrays.equals(Files.readAllBytes(lic.toPath()), Files.readAllBytes(Paths.get("gesture/LICENSE-FUTO-Model-Weights.md")))
                && new String(Files.readAllBytes(lic.toPath()), "UTF-8").contains("FUTO Model Weights License 1.0"), lic == null ? null : lic.length());
        check("a file that is not in the pack is not found", MrPacks.modelFile(ctx, G, "main.dict") == null && MrPacks.modelFile(ctx, "voice", MrPacks.ENCODER) == null, null);
        check("the model is not a language: no installed dictionary, no keyboard language, no dictionary folder",
                MrPacks.installedIds(ctx).isEmpty() && MrPacks.installedVersion(ctx, G) == 0 && dp.getString("selected_languages", "-").equals("-")
                && !new File(ctx.getFilesDir(), "dicts").exists(), MrPacks.installedIds(ctx));
        check("installing the model does not turn the suggestions on nor tell the keyboard to reload its dictionaries",
                !dp.getBoolean("show_suggestions", true) && dp.getLong("mr_dicts_updated_at", 0) == before, null);
        check("installed, option off: gesture typing stays off and the lib holds nothing", !MrGestureInput.sOn && waitReady(false), null);
        check("updates: the same version installed counts nothing", MrPacks.updatesAvailable(ctx, c1) == 0, null);

        // ---- the option with the file: the lib of the PC opens the weights that were downloaded
        dp.edit().putBoolean("pref_gesture_typing", true).commit();
        MrGestureInput.reload(ctx);
        check("option on with the file: gesture typing on, and the native lib opens the installed weights",
                MrGestureInput.sOn && waitReady(true), MrGestureInput.sOn + " " + MrGesture.ready());
        check("the trail is on by default and follows its option", MrGestureInput.sTrail, null);
        dp.edit().putBoolean("pref_gesture_trail", false).commit();
        MrGestureInput.reload(ctx);
        check("trail option off: no trail, gesture typing still on", !MrGestureInput.sTrail && MrGestureInput.sOn && MrGesture.ready(), null);
        dp.edit().remove("pref_gesture_trail").commit();

        // ---- the dictionary of the same catalog installs next to it, each in its own place
        r = errOf(() -> MrPacks.install(ctx, c1, c1.packs.get(0)));
        check("the pt-BR dictionary of the same catalog installs; the model stays", r.equals("ok") && MrPacks.installedVersion(ctx, "pt-BR") == 2
                && MrPacks.installedIds(ctx).toString().equals("[pt-BR]") && MrPacks.modelVersion(ctx, G) == 1 && list(d1).size() == 4, r + " " + MrPacks.installedIds(ctx));

        // ---- updates with a problem: version 1 stays, and stays open
        String[][] bad = {
                {"m_badmagic", "weights that do not start with MRSWENC1", "mr_dicts_err_corrupt [encoder.bin]"},
                {"m_nolicense", "a licence file of a few bytes", "mr_dicts_err_corrupt [LICENSE-FUTO-Model-Weights.md]"},
                {"m_extra", "one more file inside the zip", "mr_dicts_err_corrupt [evil.txt]"},
        };
        for (String[] b : bad) {
            final MrPacks.Catalog cb = fetch(ctx, b[0]);
            final MrPacks.Pack pb = cb.model(G);
            r = errOf(() -> MrPacks.install(ctx, cb, pb));
            check("signed model v2 with " + b[1] + " is rejected", r.equals(b[2]), r);
        }
        final MrPacks.Catalog cm = fetch(ctx, "m_minapp");
        r = errOf(() -> MrPacks.install(ctx, cm, cm.model(G)));
        check("model for a newer app does not install, with its own message", r.equals("mr_gesture_err_app_old") && MrPacks.appTooOld(ctx, cm.model(G)), r);
        check("updates: a model that requires a newer app does not count", MrPacks.updatesAvailable(ctx, cm) == 0, MrPacks.updatesAvailable(ctx, cm));
        final MrPacks.Catalog cfm = fetch(ctx, "m_format");
        r = errOf(() -> MrPacks.install(ctx, cfm, cfm.model(G)));
        check("model in a format this app does not know does not install", r.equals("mr_gesture_err_app_old") && cfm.model(G).format == 2, r);
        check("after everything: v1 installed, intact and still open in the lib; no file outside its folder",
                MrPacks.modelVersion(ctx, G) == 1 && list(d1).size() == 4 && list(d1.getParentFile()).equals(Arrays.asList("1")) && MrGesture.ready()
                && list(ctx.getCacheDir()).isEmpty() && !new File(ctx.getFilesDir(), "evil.txt").exists() && !new File(models, "evil.txt").exists()
                && !new File(new File(models, G), "evil.txt").exists(), list(d1.getParentFile()));

        // ---- a good update swaps the folder and the open file
        final MrPacks.Catalog c7 = fetch(ctx, "m_v2");
        check("updates: catalog v2 with v1 installed = 1", MrPacks.updatesAvailable(ctx, c7) == 1, MrPacks.updatesAvailable(ctx, c7));
        r = errOf(() -> MrPacks.install(ctx, c7, c7.model(G)));
        File d2 = MrPacks.modelDir(ctx, G, 2);
        check("updates to v2 and deletes v1", r.equals("ok") && MrPacks.modelVersion(ctx, G) == 2 && list(d2.getParentFile()).equals(Arrays.asList("2"))
                && ("https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.96.0/" + ZIP2).equals(PacksTest.lastZipUrl), list(d2.getParentFile()));
        File enc2 = MrPacks.modelFile(ctx, G, MrPacks.ENCODER);
        check("after the update gesture typing is on with the new file (the lib opened it)",
                enc2 != null && enc2.getParentFile().equals(d2) && MrGestureInput.sOn && waitReady(true), enc2);
        check("updates: nothing left to update; the dictionary was not touched", MrPacks.updatesAvailable(ctx, c7) == 0
                && MrPacks.installedVersion(ctx, "pt-BR") == 2, null);

        // ---- catalogs that this version reads only in part, or that have no model
        MrPacks.Catalog cx = fetch(ctx, "m_mixed");
        check("models with an unknown id, a broken entry, a non-object and a repeat: only the good gesture v2 is kept, the languages stand",
                cx != null && cx.serial == 8 && cx.models.size() == 1 && cx.model(G).version == 2 && cx.model("voice") == null && cx.packs.size() == 1,
                cx == null ? null : cx.models.size());
        MrPacks.Catalog cn = fetch(ctx, "m_notlist");
        check("\"models\" that is not a list: no model, the languages stand", cn != null && cn.serial == 9 && cn.models.isEmpty() && cn.packs.size() == 1, null);
        MrPacks.Catalog c0 = fetch(ctx, "m_none");
        check("a catalog without \"models\" (made without --model): no model, and the installed one stays in use",
                c0 != null && c0.serial == 10 && c0.models.isEmpty() && c0.model(G) == null && MrPacks.modelVersion(ctx, G) == 2
                && MrPacks.updatesAvailable(ctx, c0) == 0 && MrGestureInput.sOn && MrGesture.ready(), null);

        // ---- restore defaults: the option goes back to off, the file stays
        dp.edit().putBoolean("pref_gesture_trail", false).commit();
        MrReset.apply(ctx);
        MrGestureInput.reload(ctx);
        check("restore defaults: both gesture options go away (off, trail on), and the lib lets go of the weights",
                !dp.getBoolean("pref_gesture_typing", false) && dp.getBoolean("pref_gesture_trail", true) && !MrGestureInput.sOn && MrGestureInput.sTrail
                && waitReady(false), MrGestureInput.sOn + " " + MrGesture.ready());
        check("restore defaults: the downloaded file is not a setting (still v2, 4 files)", MrPacks.modelVersion(ctx, G) == 2 && list(d2).size() == 4, list(d2));
        dp.edit().putBoolean("pref_gesture_typing", true).commit();
        MrGestureInput.reload(ctx);
        check("turned on again: works without downloading again", MrGestureInput.sOn && waitReady(true), null);

        // ---- remove
        MrPacks.remove(ctx, "pt-BR");
        check("removing the dictionary does not remove the model", MrPacks.modelVersion(ctx, G) == 2 && list(d2).size() == 4 && MrPacks.installedIds(ctx).isEmpty(), null);
        MrPacks.removeModel(ctx, G);
        check("remove: no version, no file, no folder", MrPacks.modelVersion(ctx, G) == 0 && MrPacks.modelFile(ctx, G, MrPacks.ENCODER) == null
                && !new File(models, G).exists(), list(models));
        check("remove: gesture typing goes off by itself (the option is still on) and the lib lets go of the weights",
                dp.getBoolean("pref_gesture_typing", false) && !MrGestureInput.sOn && waitReady(false), MrGestureInput.sOn + " " + MrGesture.ready());
        final MrPacks.Catalog cAgain = MrPacks.readData(c7.data);
        PacksTest.zipDir = FX + "m_v2/";
        r = errOf(() -> MrPacks.install(ctx, cAgain, cAgain.model(G)));
        check("downloaded again: on again, with no other step", r.equals("ok") && MrPacks.modelVersion(ctx, G) == 2 && MrGestureInput.sOn && waitReady(true), r);
        MrPacks.removeModel(ctx, G);
        waitReady(false);

        // ---- from a file the user picked (no connection): only the weights this version knows
        final byte[] real = Files.readAllBytes(Paths.get("gesture/encoder.bin"));
        final File home = new File(models, G);
        int packVersion = Integer.parseInt(new String(Files.readAllBytes(Paths.get("gesture/pack.json")), "UTF-8").replaceAll("(?s).*\"version\"\\s*:\\s*(\\d+).*", "$1"));
        String recorded = new String(Files.readAllBytes(Paths.get("gesture/encoder.bin.sha256")), "UTF-8").trim().split("\\s+")[0];
        check("the table of files the app takes has gesture/encoder.bin with the version of gesture/pack.json",
                MrPacks.knownModelFile(recorded) == packVersion && packVersion >= 1 && MrPacks.knownModelFile("0000") == 0
                && MrPacks.knownModelFile(recorded.toUpperCase(Locale.ROOT)) == 0, recorded + " -> " + MrPacks.knownModelFile(recorded) + ", pack.json " + packVersion);
        check("the licence text kept in the APK (res/raw) is, byte for byte, the one of gesture/",
                Arrays.equals(MrPacks.modelLicense(ctx), Files.readAllBytes(Paths.get("gesture/LICENSE-FUTO-Model-Weights.md"))), null);
        PacksTest.requests = 0;
        byte[] changed = real.clone();
        changed[changed.length / 2] ^= 1;
        r = errOf(() -> MrPacks.installModelFile(ctx, new ByteArrayInputStream(changed)));
        check("from a file: the weights with one bit changed are refused", r.equals("mr_gesture_err_file") && MrPacks.modelVersion(ctx, G) == 0, r);
        r = errOf(() -> MrPacks.installModelFile(ctx, new FileInputStream("gesture/pack.json")));
        check("from a file: another file is refused", r.equals("mr_gesture_err_file"), r);
        r = errOf(() -> MrPacks.installModelFile(ctx, new ByteArrayInputStream(new byte[0])));
        check("from a file: an empty file is refused", r.equals("mr_gesture_err_file"), r);
        final Endless big = new Endless(200L << 20);
        r = errOf(() -> MrPacks.installModelFile(ctx, big));
        check("from a file: a 200 MB file is refused, and the reading stops soon after the limit of 16 MB",
                r.equals("mr_gesture_err_file") && big.given > (16L << 20) && big.given <= (16L << 20) + 65536, r + " read " + big.given);
        ctx.mres.noLicence = true;
        r = errOf(() -> MrPacks.installModelFile(ctx, new ByteArrayInputStream(real)));
        check("from a file: without the licence text in the APK the weights are not installed", r.equals("mr_gesture_err_io [LICENSE-FUTO-Model-Weights.md]"), r);
        ctx.mres.noLicence = false;
        check("after the refusals: nothing installed, nothing left behind (no file.tmp), gesture typing off",
                MrPacks.modelVersion(ctx, G) == 0 && list(home).isEmpty() && list(ctx.getCacheDir()).isEmpty() && !MrGestureInput.sOn, list(home));
        r = errOf(() -> MrPacks.installModelFile(ctx, new ByteArrayInputStream(real)));
        File df = MrPacks.modelDir(ctx, G, packVersion);
        check("from a file: gesture/encoder.bin installs as the version it has in the catalog", r.equals("ok") && MrPacks.modelVersion(ctx, G) == packVersion
                && list(home).equals(Arrays.asList(String.valueOf(packVersion))), r + " " + list(home));
        check("from a file: the folder has the weights and the licence text, both whole",
                list(df).equals(Arrays.asList("LICENSE-FUTO-Model-Weights.md", "encoder.bin")) && Arrays.equals(Files.readAllBytes(new File(df, "encoder.bin").toPath()), real)
                && Arrays.equals(Files.readAllBytes(new File(df, "LICENSE-FUTO-Model-Weights.md").toPath()), Files.readAllBytes(Paths.get("gesture/LICENSE-FUTO-Model-Weights.md"))), list(df));
        check("from a file: no request was made to the network", PacksTest.requests == 0, PacksTest.requests);
        check("from a file: with the option on, gesture typing is on and the lib opens the file", MrGestureInput.sOn && waitReady(true), MrGestureInput.sOn + " " + MrGesture.ready());
        check("from a file: the catalog with the same version has nothing to update, and the one with v2 has", MrPacks.updatesAvailable(ctx, c1) == 0
                && MrPacks.updatesAvailable(ctx, c7) == (packVersion < 2 ? 1 : 0), MrPacks.updatesAvailable(ctx, c7));
        r = errOf(() -> MrPacks.install(ctx, cAgain, cAgain.model(G)));
        check("from a file, then the download of v2: the pack takes its place (4 files) and stays in use", r.equals("ok") && MrPacks.modelVersion(ctx, G) == 2
                && list(home).equals(Arrays.asList("2")) && list(MrPacks.modelDir(ctx, G, 2)).size() == 4 && MrGestureInput.sOn && waitReady(true), list(home));
        r = errOf(() -> MrPacks.installModelFile(ctx, new ByteArrayInputStream(real)));
        check("the picked file is what the user asked for: it replaces the downloaded one", r.equals("ok") && MrPacks.modelVersion(ctx, G) == packVersion
                && list(home).equals(Arrays.asList(String.valueOf(packVersion))) && MrGestureInput.sOn && waitReady(true), list(home));
        MrPacks.removeModel(ctx, G);
        check("remove after a file install: nothing left, gesture typing off", MrPacks.modelVersion(ctx, G) == 0 && !home.exists() && !MrGestureInput.sOn && waitReady(false), null);

        // ---- the size said in the dialog that offers the download is the one of the real zip
        long size = new File(FX + "m_ok/" + ZIP1).length();
        String mb = String.format(Locale.US, "%.1f", size / 1000000.0);
        String en = text("res/values/mr_strings.xml", "mr_gesture_need_pack");
        String pt = text("res/values-pt-rBR/mr_strings.xml", "mr_gesture_need_pack");
        String es = text("res/values-es/mr_strings.xml", "mr_gesture_need_pack");
        check("the download dialog says the size of the real zip (" + mb + " MB) in the 3 languages",
                en.contains(mb + " MB") && pt.contains(mb.replace('.', ',') + " MB") && es.contains(mb.replace('.', ',') + " MB"), en);
        check("the texts of the screen carry the notice the licence asks for (powered by \"FUTO Swipe\" technology)",
                text("res/values/mr_strings.xml", "mr_gesture_notice_title").equals("Powered by “FUTO Swipe” technology")
                && text("res/values-pt-rBR/mr_strings.xml", "mr_gesture_notice_title").contains("“FUTO Swipe”")
                && text("res/values-es/mr_strings.xml", "mr_gesture_notice_title").contains("“FUTO Swipe”"), null);

        System.out.println(PacksTest.fails == 0 ? "ALL OK (" + PacksTest.oks + " checks)" : PacksTest.fails + " FAILURE(S) out of " + (PacksTest.oks + PacksTest.fails) + " checks");
        MrPacks.deleteTree(tmp);
        System.exit(PacksTest.fails == 0 ? 0 : 1);
    }
}
