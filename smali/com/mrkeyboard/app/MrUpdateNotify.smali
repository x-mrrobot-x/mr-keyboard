.class final Lcom/mrkeyboard/app/MrUpdateNotify;
.super Ljava/lang/Object;
.source "MrUpdateNotify.java"


# static fields
.field static final ACTION_NOTIFICATION_SETTINGS:Ljava/lang/String; = "android.settings.APP_NOTIFICATION_SETTINGS"

.field static final CHANNEL:Ljava/lang/String; = "mr_update"

.field static final EXTRA_APP_PACKAGE:Ljava/lang/String; = "android.provider.extra.APP_PACKAGE"

.field static final ICON:Ljava/lang/String; = "icon_hk_notification"

.field static final ID:I = 0x71c

.field static final TARGET:Ljava/lang/String; = "com.mrkeyboard.app.LatinIMESettings"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static dismiss(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 95
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->manager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object v0

    .line 96
    if-eqz v0, :cond_0

    const/16 v1, 0x71c

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 100
    :cond_0
    :goto_0
    return-void

    .line 97
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method static dropIfInstalled(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 104
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdate;->pending(Landroid/content/Context;)Lcom/mrkeyboard/app/MrUpdate$Notice;

    move-result-object v0

    if-nez v0, :cond_0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->dismiss(Landroid/content/Context;)V

    .line 105
    :cond_0
    return-void
.end method

.method static enabled(Landroid/content/Context;)Z
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 42
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->manager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object v1

    .line 43
    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/app/NotificationManager;->areNotificationsEnabled()Z

    move-result v2

    if-nez v2, :cond_1

    .line 47
    :cond_0
    :goto_0
    return v0

    .line 44
    :cond_1
    const-string v2, "mr_update"

    invoke-virtual {v1, v2}, Landroid/app/NotificationManager;->getNotificationChannel(Ljava/lang/String;)Landroid/app/NotificationChannel;

    move-result-object v1

    .line 45
    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/app/NotificationChannel;->getImportance()I
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    if-eqz v1, :cond_0

    :cond_2
    const/4 v0, 0x1

    goto :goto_0

    .line 46
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static ensureChannel(Landroid/content/Context;)V
    .locals 5

    .prologue
    .line 54
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->manager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object v0

    .line 55
    if-nez v0, :cond_0

    .line 61
    :goto_0
    return-void

    .line 56
    :cond_0
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "mr_update"

    const-string v3, "mr_update_notif_channel"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    .line 57
    invoke-static {p0, v3, v4}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    invoke-direct {v1, v2, v3, v4}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 56
    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 58
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private static manager(Landroid/content/Context;)Landroid/app/NotificationManager;
    .locals 2

    .prologue
    .line 31
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    .line 32
    instance-of v1, v0, Landroid/app/NotificationManager;

    if-eqz v1, :cond_0

    check-cast v0, Landroid/app/NotificationManager;

    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method static settingsIntent(Landroid/content/Context;)Landroid/content/Intent;
    .locals 3

    .prologue
    .line 109
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.APP_NOTIFICATION_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "android.provider.extra.APP_PACKAGE"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const/high16 v1, 0x10000000

    .line 110
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    .line 109
    return-object v0
.end method

.method static show(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)Z
    .locals 9

    .prologue
    const/4 v1, 0x1

    const/4 v0, 0x0

    .line 73
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->manager(Landroid/content/Context;)Landroid/app/NotificationManager;

    move-result-object v2

    .line 74
    if-nez v2, :cond_0

    .line 89
    :goto_0
    return v0

    .line 75
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->ensureChannel(Landroid/content/Context;)V

    .line 76
    const/4 v3, 0x0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrUpdateNotify;->tapIntent(Landroid/content/Context;)Landroid/content/Intent;

    move-result-object v4

    const/high16 v5, 0xc000000

    invoke-static {p0, v3, v4, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v3

    .line 78
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    const-string v5, "icon_hk_notification"

    const-string v6, "drawable"

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v4, v5, v6, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 79
    new-instance v5, Landroid/app/Notification$Builder;

    const-string v6, "mr_update"

    invoke-direct {v5, p0, v6}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 80
    invoke-virtual {v5, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v4

    const-string v5, "mr_update_notif_title"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    iget-object v8, p1, Lcom/mrkeyboard/app/MrUpdate$Notice;->versionName:Ljava/lang/String;

    aput-object v8, v6, v7

    .line 81
    invoke-static {p0, v5, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v4

    const-string v5, "mr_update_notif_text"

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    .line 82
    invoke-static {p0, v5, v6}, Lcom/mrkeyboard/app/MrPacks;->text(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v4

    .line 83
    invoke-virtual {v4, v3}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v3

    const/4 v4, 0x1

    .line 84
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v3

    .line 85
    invoke-virtual {v3}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v3

    .line 86
    const/16 v4, 0x71c

    invoke-virtual {v2, v4, v3}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move v0, v1

    .line 87
    goto :goto_0

    .line 88
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method static tapIntent(Landroid/content/Context;)Landroid/content/Intent;
    .locals 3

    .prologue
    .line 65
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "com.mrkeyboard.app.LatinIMESettings"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const-string v1, "mr_update_show"

    const/4 v2, 0x1

    .line 66
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    move-result-object v0

    const v1, 0x10008000

    .line 67
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    .line 65
    return-object v0
.end method
