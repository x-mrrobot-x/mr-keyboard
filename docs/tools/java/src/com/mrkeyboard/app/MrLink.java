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
 * Open a link without bringing the app down, as the Android documentation recommends (guide "Fulfill common use cases while
 * having limited package visibility", section "Open URLs"): ACTION_VIEW intent with startActivity() and handling of
 * ActivityNotFoundException, with no need for <queries> in the manifest. On a device without a browser Android throws
 * that exception (and, depending on the version, the default URLSpan only logs it, without telling anyone). Here it becomes a notice.
 *  - open(): used by the author card (MrAuthor);
 *  - protect(): replaces the links (URLSpan) in the main screen text with a span that uses open().
 */
public final class MrLink {
    private MrLink() { }

    /** Opens the link; with no app to open it, shows the notice and returns false. */
    static boolean open(Context c, String url) {
        try {
            c.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
            return true;
        } catch (ActivityNotFoundException e) {
            // no installed app opens the link (the case the Android documentation says to handle)
            String t = MrPacks.text(c, "mr_ui_link_no_browser");
            Toast.makeText(c.getApplicationContext(), t != null ? t : url, Toast.LENGTH_LONG).show();
            return false;
        }
    }

    /** Replaces each URLSpan in the view text with a span that opens the link with open(). */
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
