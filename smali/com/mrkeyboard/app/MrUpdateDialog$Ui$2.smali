.class Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;
.super Ljava/lang/Object;
.source "MrUpdateDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->failed(Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

.field final synthetic val$f:Lcom/mrkeyboard/app/MrUpdateInstall$Failure;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 272
    iput-object p1, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    iput-object p2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;->val$f:Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 274
    iget-object v0, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->access$400(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0xc

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;->this$0:Lcom/mrkeyboard/app/MrUpdateDialog$Ui;

    invoke-static {v2}, Lcom/mrkeyboard/app/MrUpdateDialog$Ui;->access$500(Lcom/mrkeyboard/app/MrUpdateDialog$Ui;)Landroid/app/Activity;

    move-result-object v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrUpdateDialog$Ui$2;->val$f:Lcom/mrkeyboard/app/MrUpdateInstall$Failure;

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrUpdateDialog;->errorText(Landroid/content/Context;Lcom/mrkeyboard/app/MrUpdateInstall$Failure;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrUpdateDialog;->setState(IILjava/lang/String;)V

    .line 275
    :cond_0
    return-void
.end method
