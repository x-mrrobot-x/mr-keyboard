package com.mrkeyboard.app;

import java.io.*;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/** Três pacotes instalados (pt-BR, en-US e es): o teclado troca dicionário e regras com o idioma. */
public class ThreeLangTest {
    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mr2").toFile();
        final PacksTest.Ctx ctx = new PacksTest.Ctx(tmp);
        MrPacks.sTestCerts = new X509Certificate[] {(X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new FileInputStream("/tmp/fa/cert.pem"))};
        PacksTest.catalogFile = "/tmp/v165out/catalog.json";
        PacksTest.zipDir = "/tmp/v165out/";
        PacksTest.net();
        MrPacks.Catalog cat = MrPacks.fetchCatalog(ctx);
        PacksTest.check("catálogo com 3 pacotes", cat.packs.size() == 3, cat.packs.get(0).id + ", " + cat.packs.get(1).id + ", " + cat.packs.get(2).id);
        for (MrPacks.Pack p : cat.packs) MrPacks.install(ctx, cat, p);
        PacksTest.check("os três instalados", MrPacks.installedIds(ctx).equals(Arrays.asList("en-US", "es", "pt-BR")), MrPacks.installedIds(ctx));
        for (String[] c : new String[][] {{"pt", "pt_BR,en_US,es,"}, {"en", "en_US,pt_BR,es,"}, {"es", "es,pt_BR,en_US,"}}) {
            MrPacks.syncLanguages(ctx, MrPacks.cardIds(null, MrPacks.installedIds(ctx), c[0]));
            String got = ctx.getSharedPreferences("default", 0).getString("selected_languages", "-");
            PacksTest.check("três instalados, app em " + c[0] + " -> " + c[1], got.equals(c[1]), got);
        }
        String[][] cases = {{"en_US", "en-US"}, {"es_ES", "es"}, {"pt_BR", "pt-BR"}, {"es_MX", "es"}, {"en", "en-US"}, {"es", "es"}, {"pt", "pt-BR"}, {"es_US", "es"}};
        for (String[] c : cases) {
            ctx.res.conf.locale = new Locale(c[0]);
            Suggest s = new Suggest(ctx, new int[] {0});
            int corr = MrRules.get().corrections.size();
            String want = c[1].equals("en-US") ? "I" : c[1].equals("es") ? "No" : "Eu";
            String start = String.valueOf(MrPredict.list(ctx, s, new android.view.inputmethod.InputConnection() {
                public CharSequence getTextBeforeCursor(int n, int f) { return ""; }
            }));
            boolean ok = s.hasMainDictionary() && start.contains(want) && corr == (c[1].equals("en-US") ? 346 : c[1].equals("es") ? 137 : 217);
            PacksTest.check("idioma " + c[0] + " usa " + c[1], ok, corr + " correções, começo " + start);
            E2ETest.suggest = s;
            s.setCorrectionMode(1);
            String typed = c[1].equals("en-US") ? "teh" : c[1].equals("es") ? "xq" : "vc";
            String fix = c[1].equals("en-US") ? "the" : c[1].equals("es") ? "porque" : "você";
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
