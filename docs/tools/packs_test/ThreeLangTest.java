package com.mrkeyboard.app;

import java.io.*;
import java.nio.file.*;
import java.security.cert.*;
import java.util.*;

/** Three installed packs (pt-BR, en-US and es): the keyboard swaps dictionary and rules with the language. */
public class ThreeLangTest {
    public static void main(String[] a) throws Exception {
        File tmp = Files.createTempDirectory("mr2").toFile();
        final PacksTest.Ctx ctx = new PacksTest.Ctx(tmp);
        MrPacks.sTestCerts = new X509Certificate[] {(X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new FileInputStream(PacksTest.FA + "/cert.pem"))};
        String three = System.getProperty("mr.three", "/tmp/v165out");   // the signed catalog of the 3 packs (make_catalog.py + SignCatalog)
        PacksTest.catalogFile = three + "/catalog.json";
        PacksTest.zipDir = three + "/";
        PacksTest.net();
        MrPacks.Catalog cat = MrPacks.fetchCatalog(ctx);
        PacksTest.check("catalog with 3 packs", cat.packs.size() == 3, cat.packs.get(0).id + ", " + cat.packs.get(1).id + ", " + cat.packs.get(2).id);
        for (MrPacks.Pack p : cat.packs) MrPacks.install(ctx, cat, p);
        PacksTest.check("all three installed", MrPacks.installedIds(ctx).equals(Arrays.asList("en-US", "es", "pt-BR")), MrPacks.installedIds(ctx));
        for (String[] c : new String[][] {{"pt", "pt_BR,en_US,es,"}, {"en", "en_US,pt_BR,es,"}, {"es", "es,pt_BR,en_US,"}}) {
            MrPacks.syncLanguages(ctx, MrPacks.cardIds(null, MrPacks.installedIds(ctx), c[0]));
            String got = ctx.getSharedPreferences("default", 0).getString("selected_languages", "-");
            PacksTest.check("three installed, app in " + c[0] + " -> " + c[1], got.equals(c[1]), got);
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
            boolean ok = s.hasMainDictionary() && start.contains(want) && corr == PacksTest.rulesOf(c[1]);
            PacksTest.check("language " + c[0] + " uses " + c[1], ok, corr + " corrections, start " + start);
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
        PacksTest.check("German (no pack in the catalog): no dictionary and no download offer", !sd.hasMainDictionary() && offer == null, offer);
        // the first steps (MrTour.work): the dictionary of the system language; a language with no dictionary gets English
        String[][] steps = {{"pt", "BR", "pt-BR", "pt_BR,"}, {"es", "MX", "es", "es,"}, {"en", "GB", "en-US", "en_US,"}, {"fr", "FR", "en-US", "en_US,"}, {"ja", "JP", "en-US", "en_US,"}};
        for (String[] t : steps) {
            File dir2 = Files.createTempDirectory("mr3").toFile();
            PacksTest.Ctx c2 = new PacksTest.Ctx(dir2);
            String err = MrTour.work(c2, "dict", new Locale(t[0], t[1]));
            android.content.SharedPreferences dp = c2.getSharedPreferences("default", 0);
            PacksTest.check("first steps, system language " + t[0] + "_" + t[1] + ": downloads " + t[2] + " and nothing else", err == null && MrPacks.installedIds(c2).equals(Arrays.asList(t[2])), err + " " + MrPacks.installedIds(c2));
            PacksTest.check("  suggestions on and the keyboard language is " + t[3], dp.getBoolean("show_suggestions", false) && t[3].equals(dp.getString("selected_languages", "-")), dp.getString("selected_languages", "-"));
            MrPacks.deleteTree(dir2);
        }
        PacksTest.httpCode = 404;
        File dir3 = Files.createTempDirectory("mr3").toFile();
        PacksTest.Ctx c3 = new PacksTest.Ctx(dir3);
        String err3 = MrTour.work(c3, "dict", new Locale("pt", "BR"));
        PacksTest.httpCode = 200;
        PacksTest.check("first steps, no connection to the catalog (HTTP 404): a failure to show on the card, nothing installed and suggestions not touched",
                err3 != null && err3.length() > 0 && MrPacks.installedIds(c3).isEmpty() && !c3.getSharedPreferences("default", 0).getBoolean("show_suggestions", false), err3);
        MrPacks.deleteTree(dir3);
        System.out.println(PacksTest.fails == 0 ? "ALL OK (" + PacksTest.oks + " checks)" : PacksTest.fails + " FAILURE(S)");
        MrPacks.deleteTree(tmp);
        System.exit(PacksTest.fails == 0 ? 0 : 1);
    }
}
