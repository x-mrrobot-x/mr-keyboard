package com.mrkeyboard.app;

import android.content.*;
import android.content.pm.*;
import android.content.res.*;
import android.net.ConnectivityManager;
import android.view.inputmethod.InputConnection;

import java.io.*;
import java.nio.MappedByteBuffer;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/** Teste no PC do fluxo de pacotes (MrPacks) com as classes do APK 1.63 e a lib nativa do PC. */
public class PacksTest {
    static int fails = 0, oks = 0;
    static final String FX = "/tmp/pt/fx/";

    static void check(String label, boolean ok, Object detail) {
        if (ok) oks++; else fails++;
        System.out.printf("%s %-58s %s%n", ok ? "OK   " : "FALHA", label, detail == null ? "" : detail);
    }

    // ---------------------------------------------------------------- Android de mentira
    static class Prefs implements SharedPreferences {
        final HashMap<String, Object> m = new HashMap<String, Object>();
        public Map<String, ?> getAll() { return new HashMap<String, Object>(m); }
        public String getString(String k, String d) { Object o = m.get(k); return o instanceof String ? (String) o : d; }
        public int getInt(String k, int d) { Object o = m.get(k); return o instanceof Integer ? (Integer) o : d; }
        public long getLong(String k, long d) { Object o = m.get(k); return o instanceof Long ? (Long) o : d; }
        public boolean getBoolean(String k, boolean d) { Object o = m.get(k); return o instanceof Boolean ? (Boolean) o : d; }
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

    static class Conn extends ConnectivityManager {
        boolean metered = true;
        public android.net.Network getActiveNetwork() { return new android.net.Network(); }
        public boolean isActiveNetworkMetered() { return metered; }
    }

    static class Res extends Resources {
        final Configuration conf = new Configuration();
        Res() { conf.locale = new Locale("pt_BR"); }
        public Configuration getConfiguration() { return conf; }
        public int getIdentifier(String name, String type, String pkg) { return name.equals("mr_dicts_offer") ? 1 : 0; }
        public String getString(int id) { return id == 1 ? "Baixar dicionário" : null; }
        public String getString(int id, Object... a) { return getString(id); }
    }

    static class Ctx extends Context {
        final File dir;
        final HashMap<String, Prefs> prefs = new HashMap<String, Prefs>();
        final Conn conn = new Conn();
        final Res res = new Res();
        Intent started;
        Ctx(File dir) { this.dir = dir; new File(dir, "files").mkdirs(); new File(dir, "cache").mkdirs(); }
        public AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "com.mrkeyboard.app"; }
        public PackageManager getPackageManager() {
            return new PackageManager() {
                public PackageInfo getPackageInfo(String p, int f) { PackageInfo i = new PackageInfo(); i.versionCode = 1063000; return i; }
            };
        }
        public SharedPreferences getSharedPreferences(String n, int mode) {
            Prefs p = prefs.get(n);
            if (p == null) { p = new Prefs(); prefs.put(n, p); }
            return p;
        }
        public File getFilesDir() { return new File(dir, "files"); }
        public File getCacheDir() { return new File(dir, "cache"); }
        public Object getSystemService(String n) { return Context.CONNECTIVITY_SERVICE.equals(n) ? conn : null; }
        public void startActivity(Intent i) { started = i; }
    }

    // ---------------------------------------------------------------- rede de mentira
    static String catalogFile = FX + "ok/catalogo.json";
    static String zipDir = FX + "ok/";
    static int corruptAt = -1, truncateAt = -1, httpCode = 200, cancelAfter = -1;
    static int requests = 0;

    static void net() {
        MrPacks.sNet = new MrPacks.Net() {
            public InputStream open(String url, long[] len) throws IOException {
                requests++;
                if (httpCode != 200) throw new MrPacks.HttpError(httpCode);
                byte[] b;
                if (url.equals(MrPacks.sCatalogUrl)) b = Files.readAllBytes(Paths.get(catalogFile));
                else {
                    String base = "https://github.com/x-mrrobot-x/mr-keyboard/releases/download/dicionarios/";
                    if (!url.startsWith(base)) throw new IOException("url inesperada " + url);
                    b = Files.readAllBytes(Paths.get(zipDir + url.substring(base.length())));
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
        catch (Exception e) { return "exceção " + e; }
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
        X509Certificate cert = (X509Certificate) cf.generateCertificate(new FileInputStream("/tmp/fa/cert.pem"));
        MrPacks.sTestCerts = new X509Certificate[] {cert};
        net();

        // ---- textos e nomes
        check("splitLocale pt_BR", Arrays.equals(MrPacks.splitLocale("pt_BR"), new String[] {"pt", "BR"}), null);
        check("splitLocale pt-br / pt / en_US_POSIX", Arrays.equals(MrPacks.splitLocale("pt-br"), new String[] {"pt", "BR"})
                && Arrays.equals(MrPacks.splitLocale("pt"), new String[] {"pt", ""})
                && Arrays.equals(MrPacks.splitLocale("en_US_POSIX"), new String[] {"en", "US"}), null);
        check("validId aceita pt-BR, en, fil; recusa PT-br, pt_BR, ../x",
                MrPacks.validId("pt-BR") && MrPacks.validId("en") && MrPacks.validId("fil") && !MrPacks.validId("PT-br")
                && !MrPacks.validId("pt_BR") && !MrPacks.validId("../x") && !MrPacks.validId("pt-BRA"), null);
        check("safeName recusa ../x, a/b, .x, vazio", MrPacks.safeName("pt-BR-2.zip") && !MrPacks.safeName("../x")
                && !MrPacks.safeName("a/b") && !MrPacks.safeName(".x") && !MrPacks.safeName(""), null);
        boolean bad = false;
        for (String j : new String[] {"{", "[1,]", "{\"a\":}", "\"\\x\"", "nul", "{}x"}) {
            try { MrJson.parse(j); bad = true; } catch (IllegalArgumentException e) { /* certo */ }
        }
        StringBuilder deep = new StringBuilder();
        for (int i = 0; i < 100; i++) deep.append('[');
        try { MrJson.parse(deep.toString()); bad = true; } catch (IllegalArgumentException e) { /* certo */ }
        check("MrJson recusa JSON inválido e fundo demais", !bad, null);

        // ---- sem pacote
        Suggest s0 = new Suggest(ctx, new int[] {0});
        check("sem pacote: Suggest sem dicionário principal", !s0.hasMainDictionary(), null);
        check("sem pacote: regras vazias", MrRules.get().corrections.isEmpty() && MrRules.get().starters.length == 0, null);
        InputConnection ic = new InputConnection() {
            public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
        };
        List<CharSequence> offer = MrPredict.list(ctx, s0, ic);
        check("sem pacote e sem catálogo: faixa mostra Baixar dicionário", offer != null && offer.size() == 1
                && offer.get(0).toString().equals("Baixar dicionário"), offer);
        check("tocar no item abre a tela e não digita", offer != null && MrPacks.onPick(ctx, offer.get(0)) && ctx.started != null, null);
        check("tocar em palavra igual (outro objeto) digita normal", !MrPacks.onPick(ctx, new String("Baixar dicionário")), null);

        // ---- catálogo
        String r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catálogo assinado com a chave do app", r.equals("ok"), r);
        MrPacks.Catalog cat = MrPacks.cachedCatalog(ctx);
        check("catálogo guardado: série 1, pt-BR v2", cat != null && cat.serial == 1 && cat.packs.size() == 1
                && cat.packs.get(0).version == 2, cat == null ? null : cat.packs.get(0).id + " v" + cat.packs.get(0).version);
        catalogFile = FX + "old/catalogo.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catálogo com série menor é recusado", r.equals("mr_dicts_err_old_catalog"), r);
        catalogFile = FX + "ok/catalogo_tamper.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catálogo alterado depois de assinado é recusado", r.equals("mr_dicts_err_signature"), r);
        catalogFile = FX + "ok/catalogo_ec.json";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("catálogo assinado com outra chave é recusado", r.equals("mr_dicts_err_other_key"), r);
        httpCode = 404;
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        check("HTTP 404 vira mensagem com o código", r.equals("mr_dicts_err_http [404]"), r);
        httpCode = 200;
        check("série guardada continua 1", MrPacks.prefs(ctx).getLong(MrPacks.KEY_SERIAL, -1) == 1, null);
        catalogFile = FX + "ok/catalogo.json";

        // ---- instalação
        final MrPacks.Catalog c1 = MrPacks.cachedCatalog(ctx);
        final MrPacks.Pack p1 = c1.packs.get(0);
        ctx.conn.metered = true;
        int before = requests;
        r = errOf(() -> MrPacks.install(ctx, c1, p1));
        check("só Wi-Fi + rede cobrada: nem chega a conectar", r.equals("mr_dicts_err_wifi") && requests == before, r);
        MrPacks.prefs(ctx).edit().putBoolean(MrPacks.KEY_WIFI, false).commit();
        cancelAfter = 3;
        r = errOf(() -> MrPacks.install(ctx, c1, p1));
        check("cancelar no meio do download", r.equals("mr_dicts_err_cancel") && MrPacks.installedVersion(ctx, "pt-BR") == 0, r);
        cancelAfter = -1;
        ctx.conn.metered = false;
        MrPacks.prefs(ctx).edit().putBoolean(MrPacks.KEY_WIFI, true).commit();
        long t0 = System.nanoTime();
        r = errOf(() -> MrPacks.install(ctx, c1, p1));
        File d2 = MrPacks.packDir(ctx, "pt-BR", 2);
        check("instala no Wi-Fi", r.equals("ok"), r + String.format(" (%.0f ms)", (System.nanoTime() - t0) / 1e6));
        check("arquivos em files/dicts/pt-BR/2", list(d2).equals(Arrays.asList("NOTICE.txt", "main.dict", "pack.json", "rules.txt", "trigrams.bin")), list(d2));
        check("nada sobra em cache/ nem .tmp", list(ctx.getCacheDir()).isEmpty() && list(d2.getParentFile()).equals(Arrays.asList("2")), list(ctx.getCacheDir()));
        check("aviso ao teclado (mr_dicts_updated_at)", ctx.getSharedPreferences("default", 0).getLong("mr_dicts_updated_at", 0) > 0, null);

        // ---- uso pelo teclado: o mesmo caminho do aparelho (Suggest(Context,int[]) -> MrPacks.mainDictionary)
        Suggest s = new Suggest(ctx, new int[] {0});
        check("Suggest pega o dicionário do pacote", s.hasMainDictionary() && s.mrMainDict().getSize() == 3708011, s.mrMainDict().getSize());
        check("dicionário mapeado do arquivo (MappedByteBuffer)", s.mrMainDict().mrBuffer() instanceof MappedByteBuffer, s.mrMainDict().mrBuffer().getClass().getSimpleName());
        check("regras do pacote ativas (217 correções, 3 começos)", MrRules.get().corrections.size() == 217 && MrRules.get().starters.length == 3, MrRules.get().corrections.size());
        for (int i = 0; i < 100 && !MrTrigram.ready(); i++) Thread.sleep(50);
        check("duas palavras do pacote carregadas", MrTrigram.ready(), null);
        E2ETest.suggest = s;
        s.setCorrectionMode(1);
        String[][] cases = {{"vc", "você"}, {"omem", "homem"}, {"obrogado", "obrigado"}, {"enchergar", "enxergar"}, {"concerteza", "com certeza"}};
        for (String[] c : cases) {
            List<String> l = E2ETest.strs(E2ETest.sugg(c[0], null));
            int at = l.indexOf(c[1]);
            check("sugestão " + c[0] + " -> " + c[1], at >= 0 && at <= 2, l.subList(0, Math.min(4, l.size())));
        }
        List<CharSequence> start = MrPredict.list(ctx, s, ic);
        check("começo de frase: Você, Eu, Não (Eu no centro)", start != null && start.toString().equals("[Você, Eu, Não]"), start);
        List<CharSequence> tri = MrPredict.forWords(s, "muito", "obrigado");
        check("previsão com duas palavras", tri != null && !tri.isEmpty(), tri);
        check("com pacote: faixa não oferece download", !"Baixar dicionário".equals(String.valueOf(MrPredict.list(ctx, s, ic))), null);
        check("PluginManager.getDictionary acha o pacote (tela de idiomas)", PluginManager.getDictionary(ctx, "pt") != null, null);
        check("idioma sem pacote (en) não acha", PluginManager.getDictionary(ctx, "en") == null, null);

        // ---- atualizações com problema: a versão 2 continua
        catalogFile = FX + "v3/catalogo.json"; zipDir = FX + "v3/";
        r = errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog c3 = MrPacks.cachedCatalog(ctx);
        corruptAt = 2000000;
        r = errOf(() -> MrPacks.install(ctx, c3, c3.packs.get(0)));
        check("zip com um byte trocado é recusado (sha256)", r.equals("mr_dicts_err_corrupt [sha256]"), r);
        corruptAt = -1; truncateAt = 1000000;
        r = errOf(() -> MrPacks.install(ctx, c3, c3.packs.get(0)));
        check("zip cortado é recusado", r.equals("mr_dicts_err_corrupt [size]"), r);
        truncateAt = -1;
        check("depois das falhas: v2 instalada e intacta", MrPacks.installedVersion(ctx, "pt-BR") == 2
                && list(d2).size() == 5 && list(d2.getParentFile()).equals(Arrays.asList("2")) && list(ctx.getCacheDir()).isEmpty(),
                list(d2.getParentFile()));
        for (String fx : new String[] {"extra", "slip"}) {
            catalogFile = FX + fx + "/catalogo.json"; zipDir = FX + fx + "/";
            MrPacks.prefs(ctx).edit().putLong(MrPacks.KEY_SERIAL, 2).commit();
            r = errOf(() -> MrPacks.fetchCatalog(ctx));
            final MrPacks.Catalog cx = MrPacks.cachedCatalog(ctx);
            r = errOf(() -> MrPacks.install(ctx, cx, cx.packs.get(0)));
            check("zip assinado com arquivo a mais (" + fx + ") é recusado", r.startsWith("mr_dicts_err_corrupt"), r);
        }
        check("nenhum arquivo fora da pasta do pacote", !new File(ctx.getFilesDir(), "evil.txt").exists()
                && !new File(new File(ctx.getFilesDir(), "dicts"), "evil.txt").exists()
                && !new File(new File(new File(ctx.getFilesDir(), "dicts"), "pt-BR"), "evil.txt").exists(), null);
        catalogFile = FX + "badfile/catalogo.json"; zipDir = FX + "badfile/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog cb = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, cb, cb.packs.get(0)));
        check("arquivo dentro do zip com sha256 errado é recusado", r.equals("mr_dicts_err_corrupt [rules.txt]"), r);
        catalogFile = FX + "minapp/catalogo.json"; zipDir = FX + "minapp/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog cm = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, cm, cm.packs.get(0)));
        check("pacote para app mais novo não instala", r.equals("mr_dicts_err_app_old") && MrPacks.appTooOld(ctx, cm.packs.get(0)), r);
        check("depois de tudo: v2 instalada e intacta", MrPacks.installedVersion(ctx, "pt-BR") == 2
                && list(d2).size() == 5 && list(d2.getParentFile()).equals(Arrays.asList("2")), list(d2.getParentFile()));

        // ---- atualização boa troca a pasta
        catalogFile = FX + "v7/catalogo.json"; zipDir = FX + "v7/";
        errOf(() -> MrPacks.fetchCatalog(ctx));
        final MrPacks.Catalog c7 = MrPacks.cachedCatalog(ctx);
        r = errOf(() -> MrPacks.install(ctx, c7, c7.packs.get(0)));
        check("atualiza para a v7 e apaga a v2", r.equals("ok") && MrPacks.installedVersion(ctx, "pt-BR") == 7
                && list(d2.getParentFile()).equals(Arrays.asList("7")), list(d2.getParentFile()));
        Suggest s7 = new Suggest(ctx, new int[] {0});
        check("teclado usa a v7", s7.hasMainDictionary() && MrRules.get().corrections.size() == 217, null);

        // ---- remover
        MrPacks.remove(ctx, "pt-BR");
        Suggest s8 = new Suggest(ctx, new int[] {0});
        check("remover: sem dicionário, sem regras, sem pasta", !s8.hasMainDictionary() && MrRules.get().corrections.isEmpty()
                && !new File(new File(ctx.getFilesDir(), "dicts"), "pt-BR").exists() && MrPacks.installedIds(ctx).isEmpty(), null);
        List<CharSequence> again = MrPredict.list(ctx, s8, ic);
        check("removido: faixa volta a oferecer o download", again != null && again.size() == 1, again);

        System.out.println(fails == 0 ? "TUDO OK (" + oks + " verificações)" : fails + " FALHA(S) de " + (oks + fails));
        MrPacks.deleteTree(tmp);
        System.exit(fails == 0 ? 0 : 1);
    }
}
