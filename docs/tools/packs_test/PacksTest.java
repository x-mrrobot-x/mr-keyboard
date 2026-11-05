package com.mrkeyboard.app;

import android.content.*;
import android.content.pm.*;
import android.content.res.*;
import android.view.inputmethod.InputConnection;

import java.io.*;
import java.nio.MappedByteBuffer;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/** PC test of the pack flow (MrPacks) with the classes of the 1.63 APK and the PC native lib. */
public class PacksTest {
    static int fails = 0, oks = 0;
    // Folders of the test (run_packs_tests.sh sets them; the defaults are the ones of the old manual run, see README.md)
    static final String FX = System.getProperty("mr.fx", "/tmp/pt/fx") + "/";        // fixtures made by make_fixtures.py (signed)
    static final String FA = System.getProperty("mr.fa", "/tmp/fa");                 // test key: cert.pem (and the EC pair)
    static final String DICTS = System.getProperty("mr.dicts", "dicts");             // the repository's dictionaries

    /** Corrections of dicts/<id>/rules.txt: what the keyboard must have loaded once that pack is the active one. */
    static int rulesOf(String id) throws IOException {
        InputStream in = new FileInputStream(DICTS + "/" + id + "/rules.txt");
        try { return MrRules.parse(in).corrections.size(); } finally { in.close(); }
    }

    // versionCode of the app that the fake PackageManager reports: the packs need minApp <= this (run_packs_tests.sh passes the real one)
    static long dictSize(String id) { return new File(DICTS + "/" + id + "/main.dict").length(); }

    static void check(String label, boolean ok, Object detail) {
        if (ok) oks++; else fails++;
        System.out.printf("%s %-58s %s%n", ok ? "OK   " : "FAIL ", label, detail == null ? "" : detail);
    }

    // ---------------------------------------------------------------- fake Android
    static class Prefs implements SharedPreferences {
        final HashMap<String, Object> m = new HashMap<String, Object>();
        public Map<String, ?> getAll() { return new HashMap<String, Object>(m); }
        public String getString(String k, String d) { Object o = m.get(k); return o instanceof String ? (String) o : d; }
        public int getInt(String k, int d) { Object o = m.get(k); return o instanceof Integer ? (Integer) o : d; }
        public long getLong(String k, long d) { Object o = m.get(k); return o instanceof Long ? (Long) o : d; }
        public boolean getBoolean(String k, boolean d) { Object o = m.get(k); return o instanceof Boolean ? (Boolean) o : d; }
        public void registerOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public void unregisterOnSharedPreferenceChangeListener(OnSharedPreferenceChangeListener l) { }
        public Editor edit() {
            final HashMap<String, Object> pend = new HashMap<String, Object>();
            final HashSet<String> rem = new HashSet<String>();
            return new Editor() {
                public Editor putString(String k, String v) { pend.put(k, v); return this; }
                public Editor putInt(String k, int v) { pend.put(k, v); return this; }
                public Editor putLong(String k, long v) { pend.put(k, v); return this; }
                public Editor putBoolean(String k, boolean v) { pend.put(k, v); return this; }
                public Editor remove(String k) { rem.add(k); return this; }
                public boolean commit() { for (String k : rem) m.remove(k); m.putAll(pend); return true; }
                public void apply() { commit(); }
            };
        }
    }

    static class Res extends Resources {
        final Configuration conf = new Configuration();
        Res() { conf.locale = new Locale("pt_BR"); }
        public Configuration getConfiguration() { return conf; }
        public int getIdentifier(String name, String type, String pkg) { return name.equals("mr_dicts_offer") ? 1 : name.equals("mr_tr_notice") ? 2 : 0; }
        public String getString(int id) { return id == 1 ? "Baixar dicionário" : id == 2 ? "warning" : null; }
        public String getString(int id, Object... a) { return getString(id); }
    }

    static class Ctx extends Context {
        final File dir;
        final HashMap<String, Prefs> prefs = new HashMap<String, Prefs>();
        final Res res = new Res();
        Intent started;
        Ctx(File dir) { this.dir = dir; new File(dir, "files").mkdirs(); new File(dir, "cache").mkdirs(); }
        public AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public PackageManager getPackageManager() {
            return new PackageManager() {
                public PackageInfo getPackageInfo(String p, int f) { PackageInfo i = new PackageInfo(); i.versionCode = Integer.getInteger("mr.appcode", 1063000); return i; }
            };
        }
        public SharedPreferences getSharedPreferences(String n, int mode) {
            Prefs p = prefs.get(n);
            if (p == null) { p = new Prefs(); prefs.put(n, p); }
            return p;
        }
        public File getFilesDir() { return new File(dir, "files"); }
        public File getCacheDir() { return new File(dir, "cache"); }
        public void startActivity(Intent i) { started = i; }
    }

    // ---------------------------------------------------------------- fake network
    static String catalogFile = FX + "ok/catalog.json";
    static String zipDir = FX + "ok/";
    static int corruptAt = -1, truncateAt = -1, httpCode = 200, cancelAfter = -1;
    static int requests = 0;
    static String lastZipUrl = null;

    static void net() {
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] len) throws IOException {
                requests++;
                if (httpCode != 200) throw new MrPacks.HttpError(httpCode);
                byte[] b;
                if (url.equals(MrPacks.sCatalogUrl)) b = Files.readAllBytes(Paths.get(catalogFile));
                else {
                    // .../releases/download/<tag>/<zip>: any release is served; the test looks at which one was asked
                    String base = MrPacks.RELEASES_URL;
                    if (!url.startsWith(base) || url.indexOf('/', base.length()) < 0) throw new IOException("unexpected url " + url);
                    lastZipUrl = url;
                    b = Files.readAllBytes(Paths.get(zipDir + url.substring(url.indexOf('/', base.length()) + 1)));
                    if (corruptAt >= 0) b[corruptAt] ^= 0x55;
                    if (truncateAt >= 0) b = Arrays.copyOf(b, truncateAt);
                }
                len[0] = truncateAt >= 0 ? -1 : b.length;
                final byte[] data = b;
                return new InputStream() {
                    int p = 0, reads = 0;
                    public int read() { return p < data.length ? data[p++] & 0xff : -1; }
                    public int read(byte[] o, int off, int n) {
                        if (cancelAfter >= 0 && ++reads > cancelAfter) MrPacks.sCancel = true;
                        if (p >= data.length) return -1;
                        int k = Math.min(n, Math.min(65536, data.length - p));
                        System.arraycopy(data, p, o, off, k); p += k; return k;
                    }
                };
            }
        };
    }

    static String err(Runnable r) {
        try { r.run(); return null; } catch (RuntimeException e) {
            if (e.getCause() instanceof MrPacks.PackException) return ((MrPacks.PackException) e.getCause()).key;
            throw e;
        }
    }

    interface Job { void run() throws Exception; }
    static String errOf(Job j) {
        try { j.run(); return "ok"; } catch (MrPacks.PackException e) { return e.key + (e.args.length > 0 ? " " + Arrays.toString(e.args) : ""); }
        catch (Exception e) { return "exception " + e; }
    }

    static List<String> list(File dir) {
        String[] n = dir.list();
        if (n == null) return Collections.emptyList();
        Arrays.sort(n);
        return Arrays.asList(n);
    }

    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mrpacks").toFile();
        final Ctx ctx = new Ctx(tmp);
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        X509Certificate cert = (X509Certificate) cf.generateCertificate(new FileInputStream(FA + "/cert.pem"));
        MrPacks.sTestCerts = new X509Certificate[] {cert};
        net();

        // ---- texts and names
        check("splitLocale pt_BR", Arrays.equals(MrPacks.splitLocale("pt_BR"), new String[] {"pt", "BR"}), null);
        check("splitLocale pt-br / pt / en_US_POSIX", Arrays.equals(MrPacks.splitLocale("pt-br"), new String[] {"pt", "BR"})
                && Arrays.equals(MrPacks.splitLocale("pt"), new String[] {"pt", ""})
                && Arrays.equals(MrPacks.splitLocale("en_US_POSIX"), new String[] {"en", "US"}), null);
        check("validId accepts pt-BR, en, fil; rejects PT-br, pt_BR, ../x",
                MrPacks.validId("pt-BR") && MrPacks.validId("en") && MrPacks.validId("fil") && !MrPacks.validId("PT-br")
                && !MrPacks.validId("pt_BR") && !MrPacks.validId("../x") && !MrPacks.validId("pt-BRA"), null);
        check("the catalog is read from the latest release (the same as the APK)",
                MrPacks.CATALOG_URL.equals("https://github.com/x-mrrobot-x/mr-keyboard/releases/latest/download/catalog.json"),
                MrPacks.CATALOG_URL);
        check("zips are read from the releases of the repository (release + name)",
                MrPacks.RELEASES_URL.equals("https://github.com/x-mrrobot-x/mr-keyboard/releases/download/"), MrPacks.RELEASES_URL);
        check("validTag accepts v1.82.0 and v10.0.12; rejects the rest",
                MrPacks.validTag("v1.82.0") && MrPacks.validTag("v10.0.12") && !MrPacks.validTag("1.82.0") && !MrPacks.validTag("v1.82")
                && !MrPacks.validTag("v1.82.0.1") && !MrPacks.validTag("v1..2") && !MrPacks.validTag("v1.2.") && !MrPacks.validTag("v.1.2")
                && !MrPacks.validTag("main") && !MrPacks.validTag("v1.82.0/../x") && !MrPacks.validTag("v1.82.0-rc1") && !MrPacks.validTag("")
                && !MrPacks.validTag(null) && !MrPacks.validTag("V1.82.0"), null);
        check("safeName rejects ../x, a/b, .x, empty", MrPacks.safeName("mr-keyboard-dict-pt-BR-2.zip") && !MrPacks.safeName("../x")
                && !MrPacks.safeName("a/b") && !MrPacks.safeName(".x") && !MrPacks.safeName(""), null);
        boolean bad = false;
        for (String j : new String[] {"{", "[1,]", "{\"a\":}", "\"\\x\"", "nul", "{}x"}) {
            try { MrJson.parse(j); bad = true; } catch (IllegalArgumentException e) { /* certo */ }
        }
        StringBuilder deep = new StringBuilder();
        for (int i = 0; i < 100; i++) deep.append('[');
        try { MrJson.parse(deep.toString()); bad = true; } catch (IllegalArgumentException e) { /* certo */ }
        check("MrJson rejects invalid JSON and nesting that is too deep", !bad, null);

        // ---- no pack
        Suggest s0 = new Suggest(ctx, new int[] {0});
        check("no pack: Suggest without a main dictionary", !s0.hasMainDictionary(), null);
        check("no pack: empty rules", MrRules.get().corrections.isEmpty() && MrRules.get().starters.length == 0, null);
        InputConnection ic = new InputConnection() {
            public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
        };
        List<CharSequence> offer = MrPredict.list(ctx, s0, ic);
        check("no pack and no catalog: strip shows Baixar dicionário", offer != null && offer.size() == 1
                && offer.get(0).toString().equals("Baixar dicionário"), offer);
        check("tapping the item opens the screen and does not type", offer != null && MrPacks.onPick(ctx, offer.get(0)) && ctx.started != null, null);
        check("tapping an equal word (another object) types normally", !MrPacks.onPick(ctx, new String("Baixar dicionário")), null);

        // ---- catalog
        String r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catalog signed with the app's key", r.equals("ok"), r);
        MrPacks.Catalog cat = MrPacks.cachedCatalog(ctx);
        check("stored catalog: serial 1, pt-BR v2", cat != null && cat.serial == 1 && cat.packs.size() == 1
                && cat.packs.get(0).version == 2, cat == null ? null : cat.packs.get(0).id + " v" + cat.packs.get(0).version);
        catalogFile = FX + "old/catalog.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catalog with a lower serial is rejected", r.equals("mr_dicts_err_old_catalog"), r);
        catalogFile = FX + "ok/catalog_tamper.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catalog altered after signing is rejected", r.equals("mr_dicts_err_signature"), r);
        catalogFile = FX + "ok/catalog_ec.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catalog signed with another key is rejected", r.equals("mr_dicts_err_other_key"), r);
        httpCode = 404;
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("HTTP 404 becomes a message with the code", r.equals("mr_dicts_err_http [404]"), r);
        httpCode = 200;
        check("stored serial stays 1", MrPacks.prefs(ctx).getLong(MrPacks.KEY_SERIAL, -1) == 1, null);
        catalogFile = FX + "ok/catalog.json";

        // ---- keyboard languages (cards and selected_languages)
        check("cards without a catalog: the 3 defaults (app language first)",
                MrPacks.cardIds(null, new ArrayList<String>(), "pt").toString().equals("[pt-BR, en-US, es]")
                && MrPacks.cardIds(null, new ArrayList<String>(), "en").toString().equals("[en-US, pt-BR, es]")
                && MrPacks.cardIds(null, new ArrayList<String>(), "es").toString().equals("[es, pt-BR, en-US]")
                && MrPacks.cardIds(null, new ArrayList<String>(), "de").toString().equals("[pt-BR, en-US, es]"),
                MrPacks.cardIds(null, new ArrayList<String>(), "en"));
        check("cards: catalog and installed ones come in without repeating",
                MrPacks.cardIds(Arrays.asList("fr-FR", "pt-BR", "es"), Arrays.asList("de-DE", "es"), "fr").toString()
                        .equals("[fr-FR, pt-BR, en-US, es, de-DE]"),
                MrPacks.cardIds(Arrays.asList("fr-FR", "pt-BR", "es"), Arrays.asList("de-DE", "es"), "fr"));
        List<String> order3 = MrPacks.cardIds(null, new ArrayList<String>(), "pt");
        check("selected_languages: only the installed ones, in card order",
                "pt_BR,es,".equals(MrPacks.languageKeys(order3, Arrays.asList("es", "pt-BR")))
                && "en_US,".equals(MrPacks.languageKeys(order3, Arrays.asList("en-US")))
                && MrPacks.languageKeys(order3, new ArrayList<String>()) == null,
                MrPacks.languageKeys(order3, Arrays.asList("es", "pt-BR")));
        check("no pack: selected_languages does not exist (keyboard uses the device language)",
                ctx.getSharedPreferences("default", 0).getString("selected_languages", "-").equals("-"), null);

        // ---- toolbar and suggestions height
        check("bar: empty, invalid or out-of-range scale ends up between 60% and 150% (default 100%)",
                MrBar.scale(null, 0.6f, 1.5f) == 1f && MrBar.scale("abc", 0.6f, 1.5f) == 1f && MrBar.scale("1.0", 0.6f, 1.5f) == 1f && MrBar.scale("0.3", 0.6f, 1.5f) == 0.6f
                && MrBar.scale("2", 0.6f, 1.5f) == 1.5f && MrBar.scale("0.8", 0.6f, 1.5f) == 0.8f && MrBar.scale("NaN", 0.6f, 1.5f) == 1f,
                MrBar.scale("0.3", 0.6f, 1.5f) + " " + MrBar.scale("2", 0.6f, 1.5f));
        check("bar: height = 48 dp x density x scale (rounded)",
                MrBar.heightPx(96f, 1f) == 96 && MrBar.heightPx(120f, 0.6f) == 72 && MrBar.heightPx(144f, 1.5f) == 216,
                MrBar.heightPx(96f, 1f) + " " + MrBar.heightPx(120f, 0.6f));

        // ---- installation
        final MrPacks.Catalog c1 = MrPacks.cachedCatalog(ctx);
        final MrPacks.Pack p1 = c1.packs.get(0);
        cancelAfter = 3;
        r = errOf(() -> MrPacks.install(ctx, c1, p1));
        check("cancel in the middle of the download", r.equals("mr_dicts_err_cancel") && MrPacks.installedVersion(ctx, "pt-BR") == 0, r);
        cancelAfter = -1;
        long t0 = System.nanoTime();
        r = errOf(() -> MrPacks.install(ctx, c1, p1));
        File d2 = MrPacks.packDir(ctx, "pt-BR", 2);
        final String firstUrl = lastZipUrl;
        // a pack whose zip stayed in an earlier release: same catalog, "release" changed
        MrPacks.Catalog cOld = MrPacks.readData(c1.data.replace("\"v1.73.0\"", "\"v1.71.0\""));
        r = errOf(() -> MrPacks.install(ctx, cOld, cOld.packs.get(0)));
        check("pack in an earlier release (v1.71.0): the download goes to that release and works",
                r.equals("ok") && "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.71.0/mr-keyboard-dict-pt-BR-2.zip".equals(lastZipUrl), r + " " + lastZipUrl);
        for (String badRel : new String[] {"main", "v1.73", "../x", "v1.73.0/../../x", "", "v1.73.0-rc"}) {
            String rr = errOf(() -> MrPacks.readData(c1.data.replace("\"v1.73.0\"", "\"" + badRel + "\"")));
            check("catalog with release \"" + badRel + "\" is rejected", rr.startsWith("mr_dicts_err_corrupt"), rr);
        }
        String noRel = errOf(() -> MrPacks.readData(c1.data.replace("\"release\"", "\"x_release\"")));
        check("catalog without \"release\" is rejected (no global address anymore)", noRel.startsWith("mr_dicts_err_corrupt"), noRel);
        String oldFmt = errOf(() -> MrPacks.readData(c1.data.replace("\"packs\": [", "\"baseUrl\": \"https://x/\", \"packs\": [")));
        check("a leftover baseUrl in the catalog does no harm (it is ignored)", oldFmt.equals("ok"), oldFmt);
        check("installs", r.equals("ok"), r + String.format(" (%.0f ms)", (System.nanoTime() - t0) / 1e6));
        check("the zip was asked from the release in the catalog, with the dictionary name",
                "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/v1.73.0/mr-keyboard-dict-pt-BR-2.zip".equals(firstUrl)
                && "v1.73.0".equals(p1.release) && "mr-keyboard-dict-pt-BR-2.zip".equals(p1.url), firstUrl);
        check("files in files/dicts/pt-BR/2", list(d2).equals(Arrays.asList("NOTICE.txt", "main.dict", "pack.json", "rules.txt", "trigrams.bin")), list(d2));
        check("nothing is left in cache/ or .tmp", list(ctx.getCacheDir()).isEmpty() && list(d2.getParentFile()).equals(Arrays.asList("2")), list(ctx.getCacheDir()));
        MrPacks.syncLanguages(ctx, MrPacks.cardIds(null, MrPacks.installedIds(ctx), "pt"));
        check("installed pack becomes a keyboard language (pt_BR,)",
                "pt_BR,".equals(ctx.getSharedPreferences("default", 0).getString("selected_languages", "-")),
                ctx.getSharedPreferences("default", 0).getString("selected_languages", "-"));
        SharedPreferences dp = ctx.getSharedPreferences("default", 0);
        dp.edit().putString("pref_keyboard_layout", "9").putBoolean("show_suggestions", true).putString("pref_key_spacing", "10")
                .putString("pref_render_mode", "2").putString("emote_recent", "a,b").putString("selected_languages", "xx,").commit();
        MrReset.apply(ctx);
        check("restore defaults: the settings keys go away (theme, suggestions, spacing, old keys)",
                dp.getString("pref_keyboard_layout", "-").equals("-") && !dp.getBoolean("show_suggestions", false)
                && dp.getString("pref_key_spacing", "-").equals("-") && dp.getString("pref_render_mode", "-").equals("-"), null);
        check("restore defaults: does not delete what is not a setting and fixes the languages (emotes, pt_BR,, pack)",
                "a,b".equals(dp.getString("emote_recent", "-")) && "pt_BR,".equals(dp.getString("selected_languages", "-"))
                && MrPacks.installedVersion(ctx, "pt-BR") == 2, dp.getString("selected_languages", "-"));
        check("notice to the keyboard (mr_dicts_updated_at)", ctx.getSharedPreferences("default", 0).getLong("mr_dicts_updated_at", 0) > 0, null);

        // ---- use by the keyboard: the same path as the device (Suggest(Context,int[]) -> MrPacks.mainDictionary)
        Suggest s = new Suggest(ctx, new int[] {0});
        check("Suggest takes the pack's dictionary", s.hasMainDictionary() && s.mrMainDict().getSize() == dictSize("pt-BR"), s.mrMainDict().getSize());
        check("dictionary mapped from the file (MappedByteBuffer)", s.mrMainDict().mrBuffer() instanceof MappedByteBuffer, s.mrMainDict().mrBuffer().getClass().getSimpleName());
        check("pack rules active (the corrections of rules.txt, 3 starters)", MrRules.get().corrections.size() == rulesOf("pt-BR") && MrRules.get().starters.length == 3, MrRules.get().corrections.size());
        for (int i = 0; i < 100 && !MrTrigram.ready(); i++) Thread.sleep(50);
        check("the pack's two words loaded", MrTrigram.ready(), null);
        E2ETest.suggest = s;
        s.setCorrectionMode(1);
        String[][] cases = {{"vc", "você"}, {"omem", "homem"}, {"obrogado", "obrigado"}, {"enchergar", "enxergar"}, {"concerteza", "com certeza"}};
        for (String[] c : cases) {
            List<String> l = E2ETest.strs(E2ETest.sugg(c[0], null));
            int at = l.indexOf(c[1]);
            check("suggestion " + c[0] + " -> " + c[1], at >= 0 && at <= 2, l.subList(0, Math.min(4, l.size())));
        }
        List<CharSequence> start = MrPredict.list(ctx, s, ic);
        check("sentence start: Você, Eu, Não (Eu in the center)", start != null && start.toString().equals("[Você, Eu, Não]"), start);
        List<CharSequence> tri = MrPredict.forWords(s, "muito", "obrigado");
        check("prediction with two words", tri != null && !tri.isEmpty(), tri);
        check("with a pack: strip does not offer download", !"Baixar dicionário".equals(String.valueOf(MrPredict.list(ctx, s, ic))), null);
        check("PluginManager.getDictionary finds the pack (languages screen)", PluginManager.getDictionary(ctx, "pt") != null, null);
        check("language without a pack (en) does not find it", PluginManager.getDictionary(ctx, "en") == null, null);

        // ---- updates with a problem: version 2 stays
        catalogFile = FX + "v3/catalog.json"; zipDir = FX + "v3/";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog c3 = MrPacks.cachedCatalog(ctx);
        check("updates: catalog v3 with v2 installed = 1 (no catalog = 0)",
                MrPacks.updatesAvailable(ctx, c3) == 1 && MrPacks.updatesAvailable(ctx, null) == 0, MrPacks.updatesAvailable(ctx, c3));
        corruptAt = 2000000;
        r = errOf(() -> MrPacks.install(ctx, c3, c3.packs.get(0)));
        check("zip with one byte changed is rejected (sha256)", r.equals("mr_dicts_err_corrupt [sha256]"), r);
        corruptAt = -1; truncateAt = 1000000;
        r = errOf(() -> MrPacks.install(ctx, c3, c3.packs.get(0)));
        check("truncated zip is rejected", r.equals("mr_dicts_err_corrupt [size]"), r);
        truncateAt = -1;
        check("after the failures: v2 installed and intact", MrPacks.installedVersion(ctx, "pt-BR") == 2
                && list(d2).size() == 5 && list(d2.getParentFile()).equals(Arrays.asList("2")) && list(ctx.getCacheDir()).isEmpty(),
                list(d2.getParentFile()));
        for (String fx : new String[] {"extra", "slip"}) {
            catalogFile = FX + fx + "/catalog.json"; zipDir = FX + fx + "/";
            MrPacks.prefs(ctx).edit().putLong(MrPacks.KEY_SERIAL, 2).commit();
            r = errOf(() -> MrPacks.fetchCatalog(ctx));
            final MrPacks.Catalog cx = MrPacks.cachedCatalog(ctx);
            r = errOf(() -> MrPacks.install(ctx, cx, cx.packs.get(0)));
            check("signed zip with an extra file (" + fx + ") is rejected", r.startsWith("mr_dicts_err_corrupt"), r);
        }
        check("no file outside the pack folder", !new File(ctx.getFilesDir(), "evil.txt").exists()
                && !new File(new File(ctx.getFilesDir(), "dicts"), "evil.txt").exists()
                && !new File(new File(new File(ctx.getFilesDir(), "dicts"), "pt-BR"), "evil.txt").exists(), null);
        catalogFile = FX + "badfile/catalog.json"; zipDir = FX + "badfile/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog cb = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, cb, cb.packs.get(0)));
        check("file inside the zip with a wrong sha256 is rejected", r.equals("mr_dicts_err_corrupt [rules.txt]"), r);
        catalogFile = FX + "minapp/catalog.json"; zipDir = FX + "minapp/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog cm = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, cm, cm.packs.get(0)));
        check("pack for a newer app does not install", r.equals("mr_dicts_err_app_old") && MrPacks.appTooOld(ctx, cm.packs.get(0)), r);
        check("updates: pack that requires a newer app does not count", MrPacks.updatesAvailable(ctx, cm) == 0, MrPacks.updatesAvailable(ctx, cm));
        check("after everything: v2 installed and intact", MrPacks.installedVersion(ctx, "pt-BR") == 2
                && list(d2).size() == 5 && list(d2.getParentFile()).equals(Arrays.asList("2")), list(d2.getParentFile()));

        // ---- a good update swaps the folder
        catalogFile = FX + "v7/catalog.json"; zipDir = FX + "v7/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog c7 = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, c7, c7.packs.get(0)));
        check("updates to v7 and deletes v2", r.equals("ok") && MrPacks.installedVersion(ctx, "pt-BR") == 7
                && list(d2.getParentFile()).equals(Arrays.asList("7")), list(d2.getParentFile()));
        Suggest s7 = new Suggest(ctx, new int[] {0});
        check("keyboard uses v7", s7.hasMainDictionary() && MrRules.get().corrections.size() == rulesOf("pt-BR"), null);
        check("updates: with v7 installed there is nothing left to update", MrPacks.updatesAvailable(ctx, c7) == 0, MrPacks.updatesAvailable(ctx, c7));

        // ---- remove
        MrPacks.remove(ctx, "pt-BR");
        Suggest s8 = new Suggest(ctx, new int[] {0});
        check("remove: no dictionary, no rules, no folder", !s8.hasMainDictionary() && MrRules.get().corrections.isEmpty()
                && !new File(new File(ctx.getFilesDir(), "dicts"), "pt-BR").exists() && MrPacks.installedIds(ctx).isEmpty(), null);
        MrPacks.syncLanguages(ctx, MrPacks.cardIds(null, MrPacks.installedIds(ctx), "pt"));
        check("remove: the language leaves the keyboard (selected_languages goes away)",
                ctx.getSharedPreferences("default", 0).getString("selected_languages", "-").equals("-"), null);
        List<CharSequence> again = MrPredict.list(ctx, s8, ic);
        check("removed: strip offers the download again", again != null && again.size() == 1, again);

        System.out.println(fails == 0 ? "ALL OK (" + oks + " checks)" : fails + " FAILURE(S) out of " + (oks + fails) + " checks");
        MrPacks.deleteTree(tmp);
        System.exit(fails == 0 ? 0 : 1);
    }
}
