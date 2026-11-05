package com.mrkeyboard.app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

/**
 * The notification of a new version (v1.82.0), posted by the morning job.
 *
 * Channel "mr_update" with low importance (no sound and no vibration; the user can change it in the system
 * settings). The text is the same on the three languages of the app (strings mr_update_notif_*). A tap opens the
 * Settings of the app with the dialog of the new version (MrUpdateUi.EXTRA_SHOW); it goes away on the tap and when the
 * installed app is already that version. One notification per version is decided by the job (MrUpdateSchedule.notified).
 */
final class MrUpdateNotify {
    private MrUpdateNotify() { }

    static final String CHANNEL = "mr_update";
    static final int ID = 1820;
    /** The screen that the tap opens (the Settings of the app, which shows the dialog). */
    static final String TARGET = "com.mrkeyboard.app.LatinIMESettings";
    /** Small icon: the one of the keyboard's own notification. */
    static final String ICON = "icon_hk_notification";
    static final String ACTION_NOTIFICATION_SETTINGS = "android.settings.APP_NOTIFICATION_SETTINGS";
    static final String EXTRA_APP_PACKAGE = "android.provider.extra.APP_PACKAGE";

    private static NotificationManager manager(Context c) {
        Object s = c.getSystemService(Context.NOTIFICATION_SERVICE);
        return s instanceof NotificationManager ? (NotificationManager) s : null;
    }

    /**
     * True when a notification can be seen: the app's notifications are not blocked (Android 13+ permission or the
     * switch of the system settings) and the user did not turn the channel off. Without it the job does not ask for
     * the network.
     */
    static boolean enabled(Context c) {
        try {
            NotificationManager nm = manager(c);
            if (nm == null || !nm.areNotificationsEnabled()) return false;
            NotificationChannel ch = nm.getNotificationChannel(CHANNEL);
            return ch == null || ch.getImportance() != NotificationManager.IMPORTANCE_NONE;
        } catch (RuntimeException e) {
            return false;
        }
    }

    /** Creates the channel (it only changes the name, the first time it is created the importance is kept by the user). */
    static void ensureChannel(Context c) {
        try {
            NotificationManager nm = manager(c);
            if (nm == null) return;
            nm.createNotificationChannel(new NotificationChannel(CHANNEL,
                    MrPacks.text(c, "mr_update_notif_channel"), NotificationManager.IMPORTANCE_LOW));
        } catch (RuntimeException e) {
            // without a channel the notification is not posted: the job notices it in show()
        }
    }

    /** The intent of the tap: Settings, in a new task, with the extra that asks for the dialog. */
    static Intent tapIntent(Context c) {
        return new Intent().setClassName(c.getPackageName(), TARGET)
                .putExtra(MrUpdateUi.EXTRA_SHOW, true)
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
    }

    /** Posts the notification of that version. False if it could not be posted (the job then does not mark it as notified). */
    static boolean show(Context c, MrUpdate.Notice n) {
        try {
            NotificationManager nm = manager(c);
            if (nm == null) return false;
            ensureChannel(c);
            PendingIntent tap = PendingIntent.getActivity(c, 0, tapIntent(c),
                    PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT);
            int icon = c.getResources().getIdentifier(ICON, "drawable", c.getPackageName());
            Notification built = new Notification.Builder(c, CHANNEL)
                    .setSmallIcon(icon)
                    .setContentTitle(MrPacks.text(c, "mr_update_notif_title", n.versionName))
                    .setContentText(MrPacks.text(c, "mr_update_notif_text"))
                    .setContentIntent(tap)
                    .setAutoCancel(true)
                    .build();
            nm.notify(ID, built);
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }

    static void dismiss(Context c) {
        try {
            NotificationManager nm = manager(c);
            if (nm != null) nm.cancel(ID);
        } catch (RuntimeException e) {
            // nothing to remove
        }
    }

    /** Removes the notification when there is no newer version than the installed one (the update was made). */
    static void dropIfInstalled(Context c) {
        if (MrUpdate.pending(c) == null) dismiss(c);
    }

    /** The system screen of the notifications of this app (the user turns them on there). */
    static Intent settingsIntent(Context c) {
        return new Intent(ACTION_NOTIFICATION_SETTINGS).putExtra(EXTRA_APP_PACKAGE, c.getPackageName())
                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    }
}
