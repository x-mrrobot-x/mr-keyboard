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
    static void check(String w, boolean c) { if (c) { ok++; System.out.println("OK    " + w); } else { fail++; System.out.println("FAIL  " + w); } }
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
        public void startActivity(Intent i) { starts++; if (throwOther) throw new IllegalStateException("other error"); if (throwIt) throw new android.content.ActivityNotFoundException("No Activity found to handle Intent"); }
    }
    public static void main(String[] a) {
        Ctx c = new Ctx();
        check("with a browser: opens and returns true, no warning", MrAuthor.open(c) && c.starts == 1 && android.widget.Toast.shown == 0);
        c.throwIt = true;
        check("without a browser: does not propagate the error and returns false", !MrAuthor.open(c));
        c.throwOther = true;
        boolean passed = false;
        try { MrAuthor.open(c); } catch (IllegalStateException e) { passed = true; }
        check("other error (not a missing app) is not swallowed", passed);
        c.throwOther = false;
        check("without a browser: shows the warning in the language", "No hay ninguna app para abrir el enlace".equals(android.widget.Toast.last));
        android.content.res.Resources.hasText = false;
        android.widget.Toast.last = null;
        check("without text in the language: shows the link instead of failing", !MrAuthor.open(c) && MrAuthor.URL.equals(android.widget.Toast.last));
        check("the card click returns true (consumes the touch)", new MrAuthor(c).onPreferenceClick(null));
        check("the link is the GitHub profile", "https://github.com/x-mrrobot-x".equals(MrAuthor.URL));
        linkTests();
        System.out.println(fail == 0 ? "ALL OK (" + ok + " checks)" : fail + " FAILURE(S)");
        System.exit(fail == 0 ? 0 : 1);
    }

    // ---- links on the main screen (MrLink.protect)
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
        check("protect: the default URLSpan leaves the text", text.getSpans(0, 10, android.text.style.URLSpan.class).length == 0);
        android.text.style.ClickableSpan[] cs = text.getSpans(0, 10, android.text.style.ClickableSpan.class);
        check("protect: a safe span takes its place in the same range", cs.length == 1 && text.getSpanStart(cs[0]) == 7 && text.getSpanEnd(cs[0]) == 24 && text.getSpanFlags(cs[0]) == 33);
        android.view.View w = new android.view.View() { public android.content.Context getContext() { return c; } };
        android.widget.Toast.shown = 0;
        c.throwIt = false; c.starts = 0;
        cs[0].onClick(w);
        check("tap on the link with a browser opens once", c.starts == 1 && android.widget.Toast.shown == 0);
        c.throwIt = true;
        boolean propagated = false;
        try { cs[0].onClick(w); } catch (RuntimeException e) { propagated = true; }
        check("tap on the link without a browser does not crash the app and warns", !propagated && android.widget.Toast.shown == 1);
        android.widget.TextView plain = new android.widget.TextView(c) { public CharSequence getText() { return "plain text"; } };
        boolean ok2 = true;
        try { MrLink.protect(plain); } catch (RuntimeException e) { ok2 = false; }
        check("protect: text that is not Spannable passes without error", ok2);
    }
}
