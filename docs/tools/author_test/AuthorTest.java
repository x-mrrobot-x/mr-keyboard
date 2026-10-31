package com.mrkeyboard.app;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.content.pm.PackageManager;
import java.io.File;
public class AuthorTest {
    static int ok, fail;
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FALHA " + w); } }
    static class Ctx extends Context {
        boolean throwIt, throwOther; int starts;
        final Resources res = new Resources();
        public AssetManager getAssets() { return null; }
        public Context getApplicationContext() { return this; }
        public Resources getResources() { return res; }
        public String getPackageName() { return "x"; }
        public PackageManager getPackageManager() { return null; }
        public SharedPreferences getSharedPreferences(String n, int m) { return null; }
        public File getFilesDir() { return null; }
        public File getCacheDir() { return null; }
        public void startActivity(Intent i) { starts++; if (throwOther) throw new IllegalStateException("outro erro"); if (throwIt) throw new android.content.ActivityNotFoundException("No Activity found to handle Intent"); }
    }
    public static void main(String[] a) {
        Ctx c = new Ctx();
        check("com navegador: abre e devolve true, sem aviso", MrAuthor.open(c) && c.starts == 1 && android.widget.Toast.shown == 0);
        c.throwIt = true;
        check("sem navegador: não propaga o erro e devolve false", !MrAuthor.open(c));
        c.throwOther = true;
        boolean passou = false;
        try { MrAuthor.open(c); } catch (IllegalStateException e) { passou = true; }
        check("outro erro (não é falta de app) não é engolido", passou);
        c.throwOther = false;
        check("sem navegador: mostra o aviso do idioma", "No hay ninguna app para abrir el enlace".equals(android.widget.Toast.last));
        android.content.res.Resources.hasText = false;
        android.widget.Toast.last = null;
        check("sem texto no idioma: mostra o link em vez de falhar", !MrAuthor.open(c) && MrAuthor.URL.equals(android.widget.Toast.last));
        check("o clique do cartão devolve true (consome o toque)", new MrAuthor(c).onPreferenceClick(null));
        check("o link é o perfil no GitHub", "https://github.com/x-mrrobot-x".equals(MrAuthor.URL));
        linkTests();
        System.out.println(fail == 0 ? "TUDO OK (" + ok + " verificações)" : fail + " FALHAS");
        System.exit(fail == 0 ? 0 : 1);
    }

    // ---- links da tela principal (MrLink.protect)
    static class Fake implements android.text.Spannable {
        final String text;
        final java.util.ArrayList<Object[]> spans = new java.util.ArrayList<Object[]>();   // {obj, start, end, flags}
        Fake(String t) { text = t; }
        public int length() { return text.length(); }
        public char charAt(int i) { return text.charAt(i); }
        public CharSequence subSequence(int a, int b) { return text.subSequence(a, b); }
        public String toString() { return text; }
        public void setSpan(Object w, int s, int e, int f) { spans.add(new Object[] {w, s, e, f}); }
        public void removeSpan(Object w) { for (int i = 0; i < spans.size(); i++) if (spans.get(i)[0] == w) { spans.remove(i); return; } }
        Object[] find(Object tag) { for (Object[] r : spans) if (r[0] == tag) return r; return null; }
        public int getSpanStart(Object t) { return (Integer) find(t)[1]; }
        public int getSpanEnd(Object t) { return (Integer) find(t)[2]; }
        public int getSpanFlags(Object t) { return (Integer) find(t)[3]; }
        @SuppressWarnings("unchecked")
        public <T> T[] getSpans(int s, int e, Class<T> type) {
            java.util.ArrayList<T> out = new java.util.ArrayList<T>();
            for (Object[] r : new java.util.ArrayList<Object[]>(spans)) if (type.isInstance(r[0])) out.add((T) r[0]);
            return out.toArray((T[]) java.lang.reflect.Array.newInstance(type, out.size()));
        }
    }

    static void linkTests() {
        final Ctx c = new Ctx();
        final Fake text = new Fake("Veja a pagina do projeto para mais informacoes");
        android.text.style.URLSpan u = new android.text.style.URLSpan("https://github.com/x-mrrobot-x/mr-keyboard");
        text.setSpan(u, 7, 24, 33);
        android.widget.TextView tv = new android.widget.TextView(c) { public CharSequence getText() { return text; } };
        MrLink.protect(tv);
        check("protect: o URLSpan padrão sai do texto", text.getSpans(0, 10, android.text.style.URLSpan.class).length == 0);
        android.text.style.ClickableSpan[] cs = text.getSpans(0, 10, android.text.style.ClickableSpan.class);
        check("protect: entra um span seguro no mesmo trecho", cs.length == 1 && text.getSpanStart(cs[0]) == 7 && text.getSpanEnd(cs[0]) == 24 && text.getSpanFlags(cs[0]) == 33);
        android.view.View w = new android.view.View() { public android.content.Context getContext() { return c; } };
        android.widget.Toast.shown = 0;
        c.throwIt = false; c.starts = 0;
        cs[0].onClick(w);
        check("toque no link com navegador abre uma vez", c.starts == 1 && android.widget.Toast.shown == 0);
        c.throwIt = true;
        boolean propagou = false;
        try { cs[0].onClick(w); } catch (RuntimeException e) { propagou = true; }
        check("toque no link sem navegador não derruba o app e avisa", !propagou && android.widget.Toast.shown == 1);
        android.widget.TextView plain = new android.widget.TextView(c) { public CharSequence getText() { return "texto simples"; } };
        boolean ok2 = true;
        try { MrLink.protect(plain); } catch (RuntimeException e) { ok2 = false; }
        check("protect: texto que não é Spannable passa sem erro", ok2);
    }
}
