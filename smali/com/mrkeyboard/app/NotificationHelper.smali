.class final Lcom/mrkeyboard/app/NotificationHelper;
.super Ljava/lang/Object;
.source "NotificationHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/NotificationHelper$Api26;
    }
.end annotation


# static fields
.field private static final CHANNEL_ID:Ljava/lang/String; = "PCKeyboard"

.field private static final NOTIFICATION_ID:I = 0x3e9

.field private static final RES_ICON_NOTIFY:I = 0x7f070097

.field private static final RES_STR_CHAN_DESC:I = 0x7f0c011d

.field private static final RES_STR_CHAN_NAME:I = 0x7f0c011e

.field private static final RES_STR_SETTINGS:I = 0x7f0c011c


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static cancelAndUnregister(Lcom/mrkeyboard/app/LatinIME;Landroid/app/NotificationManager;Lcom/mrkeyboard/app/NotificationReceiver;)V
    .registers 4

    .line 80
    if-eqz p1, :cond_7

    .line 81
    const/16 v0, 0x3e9

    invoke-virtual {p1, v0}, Landroid/app/NotificationManager;->cancel(I)V

    .line 83
    :cond_7
    if-eqz p2, :cond_e

    .line 85
    :try_start_9
    invoke-virtual {p0, p2}, Lcom/mrkeyboard/app/LatinIME;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_c
    .catch Ljava/lang/IllegalArgumentException; {:try_start_9 .. :try_end_c} :catch_d

    .line 87
    goto :goto_e

    .line 86
    :catch_d
    move-exception p0

    .line 89
    :cond_e
    :goto_e
    return-void
.end method

.method static registerAndPost(Lcom/mrkeyboard/app/LatinIME;Landroid/app/NotificationManager;)Lcom/mrkeyboard/app/NotificationReceiver;
    .registers 12

    .line 26
    if-eqz p1, :cond_b

    .line 27
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/NotificationHelper$Api26;->ensureChannel(Landroid/content/Context;Landroid/app/NotificationManager;)V

    .line 30
    :cond_b
    new-instance v1, Lcom/mrkeyboard/app/NotificationReceiver;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/NotificationReceiver;-><init>(Lcom/mrkeyboard/app/LatinIME;)V

    .line 31
    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "com.mrkeyboard.app.SHOW"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 32
    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/ReceiverCompat;->registerNotExported(Landroid/content/Context;Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 34
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 36
    new-instance v4, Landroid/content/Intent;

    invoke-direct {v4, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 37
    invoke-virtual {p0}, Lcom/mrkeyboard/app/LatinIME;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 38
    const/4 v3, 0x1

    const/high16 v5, 0x4000000

    invoke-static {v2, v3, v4, v5}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v4

    .line 41
    new-instance v6, Landroid/content/Intent;

    const-class v7, Lcom/mrkeyboard/app/LatinIMESettings;

    invoke-direct {v6, p0, v7}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 42
    const/high16 v7, 0x10000000

    invoke-virtual {v6, v7}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 43
    const/4 v7, 0x2

    invoke-static {v2, v7, v6, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v2

    .line 47
    const/4 v6, 0x0

    .line 48
    const-string v0, "PCKeyboard"

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/NotificationHelper$Api26;->newBuilder(Landroid/content/Context;Ljava/lang/String;)Landroid/app/Notification$Builder;

    move-result-object v0

    .line 54
    :goto_57
    invoke-static {p0}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v9

    new-instance v5, Landroid/app/Notification$Action$Builder;

    .line 55
    const v7, 0x7f070097

    invoke-static {p0, v7}, Landroid/graphics/drawable/Icon;->createWithResource(Landroid/content/Context;I)Landroid/graphics/drawable/Icon;

    move-result-object v8

    .line 56
    const v6, 0x7f0c011c

    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/LatinIME;->getString(I)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v5, v8, p0, v2}, Landroid/app/Notification$Action$Builder;-><init>(Landroid/graphics/drawable/Icon;Ljava/lang/CharSequence;Landroid/app/PendingIntent;)V

    .line 58
    invoke-virtual {v5}, Landroid/app/Notification$Action$Builder;->build()Landroid/app/Notification$Action;

    move-result-object p0

    .line 60
    invoke-virtual {v0, v7}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 61
    const v5, -0xddffbc

    invoke-virtual {v2, v5}, Landroid/app/Notification$Builder;->setColor(I)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 62
    const/4 v6, 0x0

    invoke-virtual {v2, v6}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 63
    const v5, 0x7f0c01c9

    invoke-virtual {v9, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/app/Notification$Builder;->setTicker(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 64
    const v5, 0x7f0c01c7

    invoke-virtual {v9, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 65
    const v5, 0x7f0c01c8

    invoke-virtual {v9, v5}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 66
    invoke-virtual {v2, v4}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 67
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 68
    invoke-virtual {v2, p0}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    .line 70
    if-eqz p1, :cond_a7

    .line 72
    :try_start_9c
    invoke-virtual {v0}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p0

    const/16 v0, 0x3e9

    invoke-virtual {p1, v0, p0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_a5
    .catch Ljava/lang/SecurityException; {:try_start_9c .. :try_end_a5} :catch_a6

    .line 74
    goto :goto_a7

    .line 73
    :catch_a6
    move-exception p0

    .line 76
    :cond_a7
    :goto_a7
    return-object v1
.end method
