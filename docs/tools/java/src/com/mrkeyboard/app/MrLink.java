package com.mrkeyboard.app;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.Spannable;
import android.text.style.ClickableSpan;
import android.text.style.URLSpan;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Abrir link sem derrubar o app, como a documentação do Android recomenda (guia "Fulfill common use cases while
 * having limited package visibility", seção "Open URLs"): intent ACTION_VIEW com startActivity() e tratamento do
 * ActivityNotFoundException, sem precisar de <queries> no manifest. Em aparelho sem navegador o Android lança
 * essa exceção (e, conforme a versão, o URLSpan padrão só registra no log, sem avisar ninguém). Aqui vira um aviso.
 *  - open(): usado pelo cartão do autor (MrAuthor);
 *  - protect(): troca os links (URLSpan) do texto da tela principal por um span que usa open().
 */
public final class MrLink {
    private MrLink() { }

    /** Abre o link; sem app para abrir, mostra o aviso e devolve false. */
    static boolean open(Context c, String url) {
        try {
            c.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
            return true;
        } catch (ActivityNotFoundException e) {
            // nenhum app instalado abre o link (o caso que a documentação do Android manda tratar)
            String t = MrPacks.text(c, "mr_ui_link_no_browser");
            Toast.makeText(c.getApplicationContext(), t != null ? t : url, Toast.LENGTH_LONG).show();
            return false;
        }
    }

    /** Troca cada URLSpan do texto da vista por um span que abre o link com open(). */
    public static void protect(TextView tv) {
        CharSequence cs = tv.getText();
        if (!(cs instanceof Spannable)) return;
        Spannable sp = (Spannable) cs;
        URLSpan[] spans = sp.getSpans(0, sp.length(), URLSpan.class);
        for (URLSpan u : spans) {
            int start = sp.getSpanStart(u);
            int end = sp.getSpanEnd(u);
            int flags = sp.getSpanFlags(u);
            sp.removeSpan(u);
            sp.setSpan(new SafeSpan(u.getURL()), start, end, flags);
        }
    }

    static final class SafeSpan extends ClickableSpan {
        private final String mUrl;

        SafeSpan(String url) {
            mUrl = url;
        }

        @Override
        public void onClick(View widget) {
            open(widget.getContext(), mUrl);
        }
    }
}
