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

/** Testa SheetStrings.isPt/p/a e MrEs com contextos de idiomas diferentes. */
public class EsTest {
    static int ok = 0, fail = 0;
    static void check(String what, boolean cond) {
        if (cond) { ok++; System.out.println("OK    " + what); } else { fail++; System.out.println("FALHA " + what); }
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
        check("espanhol: isPt (usa o texto em português)", SheetStrings.isPt(es));
        check("espanhol: sEs ligado", SheetStrings.sEs);
        check("espanhol: p troca 'Excluir' por 'Eliminar'", "Eliminar".equals(SheetStrings.p("Excluir")));
        check("espanhol: p troca a frase com acento", "¿Eliminar la hoja?".equals(SheetStrings.p("Excluir folha?")));
        check("espanhol: p troca o texto de várias linhas", SheetStrings.p("Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em ⋮ → \"Restaurar todas para o padrão\".").startsWith("Ninguna hoja activa"));
        check("espanhol: texto sem tradução fica igual", "Qualquer coisa".equals(SheetStrings.p("Qualquer coisa")));
        check("espanhol: tr escolhe o português (que p traduz)", "Excluir".equals(SheetStrings.tr(es, "Excluir", "Delete")));
        check("português: isPt", SheetStrings.isPt(pt));
        check("português: sEs desligado", !SheetStrings.sEs);
        check("português: p não muda nada", "Excluir".equals(SheetStrings.p("Excluir")));
        check("inglês: isPt falso", !SheetStrings.isPt(en));
        check("inglês: sEs desligado", !SheetStrings.sEs);
        check("inglês: p não muda nada", "Excluir".equals(SheetStrings.p("Excluir")));
        check("francês: isPt falso (cai no inglês)", !SheetStrings.isPt(fr));
        check("sem contexto: isPt verdadeiro e sEs desligado", SheetStrings.isPt(null) && !SheetStrings.sEs);
        // depois do espanhol, voltar ao português desliga o troca
        SheetStrings.isPt(es); SheetStrings.isPt(pt);
        check("bandeira volta a desligar no português", "Excluir".equals(SheetStrings.p("Excluir")));
        // texto só em português do anexo/cache
        String c = "Limpando caches…";
        check("MrEs.app português", c.equals(MrEs.app(pt, c)));
        check("MrEs.app espanhol", "Borrando cachés…".equals(MrEs.app(es, c)));
        check("MrEs.app inglês", "Clearing caches…".equals(MrEs.app(en, c)));
        check("MrEs.app francês cai no inglês", "Clearing caches…".equals(MrEs.app(fr, c)));
        check("MrEs.app texto desconhecido fica igual", "Zzz".equals(MrEs.app(en, "Zzz")));
        // tabela (campo privado ES do MrEs, lido por reflexão): nenhuma tradução vazia ou igual à chave sem motivo
        java.lang.reflect.Field fe = MrEs.class.getDeclaredField("ES");
        fe.setAccessible(true);
        java.util.Map<?, ?> es_map = (java.util.Map<?, ?>) fe.get(null);
        int vazios = 0, saoIguais = 0;
        for (java.util.Map.Entry<?, ?> e : es_map.entrySet()) {
            String k = (String) e.getKey(), v = (String) e.getValue();
            if (v == null || v.length() == 0) vazios++;
            // iguais de verdade em espanhol: não contam
            boolean legitimo = k.equals("Código personalizado (") || k.equals("Enter / Retorno") || k.equals("Lista de teclas (")
                    || k.equals("Teclado numérico (Numpad)") || k.equals("ABC \u2014 Teclado principal");
            if (v != null && v.equals(k) && k.length() > 14 && !legitimo) saoIguais++;
        }
        check("tabela: " + es_map.size() + " chaves, nenhuma traduzida como vazio", vazios == 0);
        check("tabela: nenhuma frase longa ficou igual ao português", saoIguais == 0);
        System.out.println(fail == 0 ? "TUDO OK (" + ok + " verificações)" : fail + " FALHAS");
        System.exit(fail == 0 ? 0 : 1);
    }
}
