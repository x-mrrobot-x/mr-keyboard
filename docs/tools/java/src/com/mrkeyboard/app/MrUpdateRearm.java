package com.mrkeyboard.app;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

/**
 * After the app is updated (MY_PACKAGE_REPLACED; declared in the manifest with exported=false, only the system sends
 * it) makes sure the morning job exists again and removes the notification of the version that has just been installed
 * (MrUpdateSchedule.sync). No network.
 */
public final class MrUpdateRearm extends BroadcastReceiver {
    public void onReceive(Context context, Intent intent) {
        if (intent == null || !Intent.ACTION_MY_PACKAGE_REPLACED.equals(intent.getAction())) return;
        try {
            Context app = context.getApplicationContext();
            MrUpdateSchedule.sync(app != null ? app : context);
        } catch (RuntimeException e) {
            // the next opening of the app tries again
        }
    }
}
