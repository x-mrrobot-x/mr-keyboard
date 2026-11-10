package com.mrkeyboard.app;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.pm.PackageManager;
import android.content.Intent;
import java.io.File;
import java.util.Locale;

/** Tests SheetStrings.isPt/p/a and MrEs with contexts of different languages. */
public class EsTest {
    static int ok = 0, fail = 0;
    static void check(String what, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + what); } else { fail++; System.out.println("FAIL  " + what); }
    }
    static Context ctx(final Locale l) {
        final Configuration conf = new Configuration();
        conf.locale = l;
        final Resources res = new Resources() { public Configuration getConfiguration() { return conf; } };
        return new Context() {
            public AssetManager getAssets() { return null; }
            public Context getApplicationContext() { return this; }
            public Resources getResources() { return res; }
            public String getPackageName() { return "x"; }
            public PackageManager getPackageManager() { return null; }
            public SharedPreferences getSharedPreferences(String n, int m) { return null; }
            public File getFilesDir() { return null; }
            public File getCacheDir() { return null; }
            public void startActivity(Intent i) { }
        };
    }
    public static void main(String[] a) throws Exception {
        Context es = ctx(new Locale("es")), pt = ctx(new Locale("pt", "BR")), en = ctx(Locale.US), fr = ctx(Locale.FRANCE);
        // the classes must come from the APK: docs/tools/java/stubs has the same names with empty bodies (SheetStrings.p returns
        // the text unchanged), and that is what this check catches if the stub folder ever comes first on the classpath again
        java.security.CodeSource cs = SheetStrings.class.getProtectionDomain().getCodeSource();
        String from = cs == null || cs.getLocation() == null ? "?" : cs.getLocation().toString();
        check("SheetStrings comes from the APK jar (" + from.replaceAll(".*/", "") + ")", from.endsWith(".jar"));
        check("Spanish: isPt (uses the Portuguese text)", SheetStrings.isPt(es));
        check("Spanish: sEs on", SheetStrings.sEs);
        check("Spanish: p swaps a name of the picker catalog", "Retroceso (borrar)".equals(SheetStrings.p("Backspace (apagar)")));
        check("Spanish: p swaps a sentence with accents", "Navegaci\u00f3n".equals(SheetStrings.p("Navega\u00e7\u00e3o")));
        // the texts of the sheet editor left the table (they are mr_sheet_ed_* in mr_strings.xml now): p no longer knows them
        check("Spanish: text of the sheet editor (now in mr_strings.xml) stays as it is", "Excluir folha?".equals(SheetStrings.p("Excluir folha?")));
        check("Spanish: p swaps the multi-line text of the table", SheetStrings.p("\nToque numa categoria ou em Atualizar.").startsWith("\nToca una categor"));
        // the multi-line text of the empty sheets list left the table as well (it is mr_sheets_empty in res/values*/mr_strings.xml): p keeps it
        check("Spanish: multi-line text of the empty sheets list (now mr_sheets_empty) stays as it is", SheetStrings.p("Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em \u22ee \u2192 \"Restaurar todas para o padr\u00e3o\".").startsWith("Nenhuma folha ativa"));
        check("Spanish: text without translation stays the same", "Qualquer coisa".equals(SheetStrings.p("Qualquer coisa")));
        check("Spanish: tr picks the Portuguese (which p translates)", "Navega\u00e7\u00e3o".equals(SheetStrings.tr(es, "Navega\u00e7\u00e3o", "Navigation")));
        check("Portuguese: isPt", SheetStrings.isPt(pt));
        check("Portuguese: sEs off", !SheetStrings.sEs);
        check("Portuguese: p changes nothing", "Sistema".equals(SheetStrings.p("Sistema")));
        check("English: isPt false", !SheetStrings.isPt(en));
        check("English: sEs off", !SheetStrings.sEs);
        check("English: p changes nothing", "Sistema".equals(SheetStrings.p("Sistema")));
        check("French: isPt false (falls back to English)", !SheetStrings.isPt(fr));
        check("no context: isPt true and sEs off", SheetStrings.isPt(null) && !SheetStrings.sEs);
        // after Spanish, going back to Portuguese turns the swap off
        SheetStrings.isPt(es); SheetStrings.isPt(pt);
        check("flag turns off again in Portuguese", "Sistema".equals(SheetStrings.p("Sistema")));
        // Portuguese-only text of the attachment/cache
        String c = "Limpando caches…";
        check("MrEs.app Portuguese", c.equals(MrEs.app(pt, c)));
        check("MrEs.app Spanish", "Borrando cachés…".equals(MrEs.app(es, c)));
        check("MrEs.app English", "Clearing caches…".equals(MrEs.app(en, c)));
        check("MrEs.app French falls back to English", "Clearing caches…".equals(MrEs.app(fr, c)));
        check("MrEs.app unknown text stays the same", "Zzz".equals(MrEs.app(en, "Zzz")));
        // table (private ES field of MrEs, read by reflection): no translation empty or equal to the key without a reason
        java.lang.reflect.Field fe = MrEs.class.getDeclaredField("ES");
        fe.setAccessible(true);
        java.util.Map<?, ?> es_map = (java.util.Map<?, ?>) fe.get(null);
        int empties = 0, sameAsKey = 0;
        for (java.util.Map.Entry<?, ?> e : es_map.entrySet()) {
            String k = (String) e.getKey(), v = (String) e.getValue();
            if (v == null || v.length() == 0) empties++;
            // really the same in Spanish: they do not count
            boolean legitimate = k.equals("Enter / Retorno") || k.equals("Teclado numérico (Numpad)");
            if (v != null && v.equals(k) && k.length() > 14 && !legitimate) sameAsKey++;
        }
        check("table: " + es_map.size() + " keys, none translated as empty", empties == 0);
        check("table: no long sentence stayed equal to the Portuguese", sameAsKey == 0);
        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
