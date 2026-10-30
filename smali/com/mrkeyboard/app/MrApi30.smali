.class final Lcom/mrkeyboard/app/MrApi30;

.super Ljava/lang/Object;

.source "MrApi30.java"

.method static isManager()Z

    .locals 1

    invoke-static {}, Landroid/os/Environment;->isExternalStorageManager()Z

    move-result v0

    return v0

.end method
