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
        check("Spanish: isPt (uses the Portuguese text)", SheetStrings.isPt(es));
        check("Spanish: sEs on", SheetStrings.sEs);
        check("Spanish: p swaps 'Excluir' for 'Eliminar'", "Eliminar".equals(SheetStrings.p("Excluir")));
        check("Spanish: p swaps the sentence with accents", "¿Eliminar la hoja?".equals(SheetStrings.p("Excluir folha?")));
        check("Spanish: p swaps the multi-line text", SheetStrings.p("Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em ⋮ → \"Restaurar todas para o padrão\".").startsWith("Ninguna hoja activa"));
        check("Spanish: text without translation stays the same", "Qualquer coisa".equals(SheetStrings.p("Qualquer coisa")));
        check("Spanish: tr picks the Portuguese (which p translates)", "Excluir".equals(SheetStrings.tr(es, "Excluir", "Delete")));
        check("Portuguese: isPt", SheetStrings.isPt(pt));
        check("Portuguese: sEs off", !SheetStrings.sEs);
        check("Portuguese: p changes nothing", "Excluir".equals(SheetStrings.p("Excluir")));
        check("English: isPt false", !SheetStrings.isPt(en));
        check("English: sEs off", !SheetStrings.sEs);
        check("English: p changes nothing", "Excluir".equals(SheetStrings.p("Excluir")));
        check("French: isPt false (falls back to English)", !SheetStrings.isPt(fr));
        check("no context: isPt true and sEs off", SheetStrings.isPt(null) && !SheetStrings.sEs);
        // after Spanish, going back to Portuguese turns the swap off
        SheetStrings.isPt(es); SheetStrings.isPt(pt);
        check("flag turns off again in Portuguese", "Excluir".equals(SheetStrings.p("Excluir")));
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
            boolean legitimate = k.equals("Código personalizado (") || k.equals("Enter / Retorno") || k.equals("Lista de teclas (")
                    || k.equals("Teclado numérico (Numpad)") || k.equals("ABC \u2014 Teclado principal");
            if (v != null && v.equals(k) && k.length() > 14 && !legitimate) sameAsKey++;
        }
        check("table: " + es_map.size() + " keys, none translated as empty", empties == 0);
        check("table: no long sentence stayed equal to the Portuguese", sameAsKey == 0);
        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }
}
