package com.mrkeyboard.app;

import android.content.Context;
import android.preference.Preference;

/**
 * "by x-mrrobot-x" card in About: opens the profile on GitHub. It used to be an intent in the XML, which closes the app
 * (ActivityNotFoundException) on a device without a browser; here the error becomes a notice (see MrLink).
 */
public final class MrAuthor implements Preference.OnPreferenceClickListener {
    static final String URL = "https://github.com/x-mrrobot-x";

    private final Context mContext;

    public MrAuthor(Context context) {
        mContext = context;
    }

    public boolean onPreferenceClick(Preference preference) {
        open(mContext);
        return true;
    }

    /** Opens the link; with no app to open it, shows the notice and returns false. */
    static boolean open(Context c) {
        return MrLink.open(c, URL);
    }
}
