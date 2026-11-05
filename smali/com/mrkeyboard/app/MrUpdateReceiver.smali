.class public final Lcom/mrkeyboard/app/MrUpdateReceiver;
.super Landroid/content/BroadcastReceiver;
.source "MrUpdateReceiver.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 13
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 15
    if-nez p2, :cond_0

    .line 33
    :goto_0
    return-void

    .line 17
    :cond_0
    :try_start_0
    const-string v0, "android.content.pm.extra.STATUS"

    const/4 v1, 0x1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 18
    const/4 v1, -0x1

    if-ne v0, v1, :cond_2

    .line 19
    const-string v0, "android.intent.extra.INTENT"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/content/Intent;

    .line 20
    if-nez v0, :cond_1

    .line 21
    const/4 v0, 0x1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->onResult(I)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 29
    :catch_0
    move-exception v0

    .line 31
    invoke-static {v2}, Lcom/mrkeyboard/app/MrUpdateInstall;->onResult(I)V

    goto :goto_0

    .line 24
    :cond_1
    const/high16 v1, 0x10000000

    :try_start_1
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 25
    invoke-virtual {p1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 28
    :cond_2
    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateInstall;->onResult(I)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method
