package com.mrkeyboard.app;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInstaller;

/**
 * Receives the answer of the install session of the update (v1.82.0; declared in the manifest with exported=false, so
 * only the system, through the PendingIntent that MrUpdateInstall gives to the session, reaches it). On
 * STATUS_PENDING_USER_ACTION it opens the confirm screen of Android; any other status goes to MrUpdateInstall.onResult.
 */
public final class MrUpdateReceiver extends BroadcastReceiver {
    public void onReceive(Context context, Intent intent) {
        if (intent == null) return;
        try {
            int status = intent.getIntExtra(PackageInstaller.EXTRA_STATUS, PackageInstaller.STATUS_FAILURE);
            if (status == PackageInstaller.STATUS_PENDING_USER_ACTION) {
                Intent confirm = intent.getParcelableExtra(Intent.EXTRA_INTENT);
                if (confirm == null) {
                    MrUpdateInstall.onResult(PackageInstaller.STATUS_FAILURE);
                    return;
                }
                confirm.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(confirm);
                return;
            }
            MrUpdateInstall.onResult(status);
        } catch (RuntimeException e) {
            // the confirm screen could not be opened: the dialog says that Android refused
            MrUpdateInstall.onResult(PackageInstaller.STATUS_FAILURE);
        }
    }
}
