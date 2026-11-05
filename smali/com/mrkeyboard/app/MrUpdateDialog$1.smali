.class Lcom/mrkeyboard/app/MrUpdateDialog$1;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnCancelListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateDialog;->show(Landroid/app/Activity;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$app:Landroid/content/Context;

.field final synthetic val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 103
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$1;->val$app:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$1;->val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 2

    .prologue
    .line 106
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$1;->val$app:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$1;->val$notice:Lcom/mrkeyboard/app/MrUpdate$Notice;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrUpdate;->snooze(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdate$Notice;)V

    .line 107
    invoke-static {}, Lcom/mrkeyboard/app/MrUpdateInstall;->cancel()V

    .line 108
    return-void
.end method
