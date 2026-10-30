package com.mrkeyboard.app;

import java.io.*;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/** Dois pacotes instalados (pt-BR e en-US): o teclado troca dicionário e regras com o idioma. */
public class TwoLangTest {
    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mr2").toFile();
        final PacksTest.Ctx ctx = new PacksTest.Ctx(tmp);
        ctx.conn.metered = false;
        MrPacks.sTestCerts = new X509Certificate[] {(X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new FileInputStream("/tmp/fa/cert.pem"))};
        PacksTest.catalogFile = "/tmp/v164out/catalogo.json";
        PacksTest.zipDir = "/tmp/v164out/";
        PacksTest.net();
        MrPacks.Catalog cat = MrPacks.fetchCatalog(ctx);
        PacksTest.check("catálogo com 2 pacotes", cat.packs.size() == 2, cat.packs.get(0).id + ", " + cat.packs.get(1).id);
        for (MrPacks.Pack p : cat.packs) MrPacks.install(ctx, cat, p);
        PacksTest.check("os dois instalados", MrPacks.installedIds(ctx).equals(Arrays.asList("en-US", "pt-BR")), MrPacks.installedIds(ctx));
        String[][] cases = {{"en_US", "en-US"}, {"en", "en-US"}, {"en_GB", "en-US"}, {"pt_BR", "pt-BR"}, {"pt", "pt-BR"}};
        for (String[] c : cases) {
            ctx.res.conf.locale = new Locale(c[0]);
            Suggest s = new Suggest(ctx, new int[] {0});
            int corr = MrRules.get().corrections.size();
            String want = c[1].equals("en-US") ? "I" : "Eu";
            String start = String.valueOf(MrPredict.list(ctx, s, new android.view.inputmethod.InputConnection() {
                public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
            }));
            boolean ok = s.hasMainDictionary() && start.contains(want) && corr == (c[1].equals("en-US") ? 346 : 217);
            PacksTest.check("idioma " + c[0] + " usa " + c[1], ok, corr + " correções, começo " + start);
            E2ETest.suggest = s;
            s.setCorrectionMode(1);
            String typed = c[1].equals("en-US") ? "teh" : "vc";
            String fix = c[1].equals("en-US") ? "the" : "você";
            List<String> l = E2ETest.strs(E2ETest.sugg(typed, null));
            PacksTest.check("  " + typed + " -> " + fix, l.indexOf(fix) >= 1 && l.indexOf(fix) <= 2, l.subList(0, Math.min(4, l.size())));
        }
        ctx.res.conf.locale = new Locale("de_DE");
        Suggest sd = new Suggest(ctx, new int[] {0});
        List<CharSequence> offer = MrPredict.list(ctx, sd, new android.view.inputmethod.InputConnection() {
            public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
        });
        PacksTest.check("alemão (sem pacote no catálogo): sem dicionário e sem oferecer download", !sd.hasMainDictionary() && offer == null, offer);
        // aviso do Traduzir: só na primeira vez
        MrNotice.translate(ctx);
        boolean first = ctx.getSharedPreferences(MrNotice.PREFS, 0).getBoolean(MrNotice.KEY_TRANSLATE, false);
        PacksTest.check("aviso do Traduzir marcado como visto", first, null);
        System.out.println(PacksTest.fails == 0 ? "TUDO OK (" + PacksTest.oks + " verificações)" : PacksTest.fails + " FALHA(S)");
        MrPacks.deleteTree(tmp);
        System.exit(PacksTest.fails == 0 ? 0 : 1);
    }
}
