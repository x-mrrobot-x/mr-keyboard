.class final Lcom/mrkeyboard/app/MrUpdateDialog$Box;
.super Landroid/app/Dialog;
.source "MrUpdateDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mrkeyboard/app/MrUpdateDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Box"
.end annotation


# direct methods
.method constructor <init>(Landroid/app/Activity;I)V
    .locals 0

    .prologue
    .line 236
    invoke-direct {p0, p1, p2}, Landroid/app/Dialog;-><init>(Landroid/content/Context;I)V

    .line 237
    return-void
.end method


# virtual methods
.method public onWindowFocusChanged(Z)V
    .locals 0

    .prologue
    .line 240
    invoke-super {p0, p1}, Landroid/app/Dialog;->onWindowFocusChanged(Z)V

    .line 241
    if-eqz p1, :cond_0

    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateDialog;->access$000()V

    .line 242
    :cond_0
    return-void
.end method
