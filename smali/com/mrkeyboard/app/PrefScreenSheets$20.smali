.class Lcom/mrkeyboard/app/PrefScreenSheets$20;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->onActivityResult(IILandroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$raw:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 548
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$raw:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 551
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->val$raw:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->importJsonString(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 552
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 553
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v3, "mr_sheets_imported"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 557
    :goto_0
    return-void

    .line 554
    :catch_0
    move-exception v0

    .line 555
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$20;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v3, "mr_sheets_import_bad"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v6

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    goto :goto_0
.end method
