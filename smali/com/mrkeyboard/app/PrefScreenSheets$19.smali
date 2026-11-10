.class Lcom/mrkeyboard/app/PrefScreenSheets$19;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 475
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 477
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->resetAllToDefaults(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 478
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 479
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v2, "mr_sheets_toast_restored_all"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    .line 481
    :cond_0
    return-void
.end method
