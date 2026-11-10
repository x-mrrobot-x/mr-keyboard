.class Lcom/mrkeyboard/app/PrefScreenSheets$18;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 459
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 461
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->resetBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 462
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 463
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$18;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    const-string v2, "mr_sheets_toast_restored"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    .line 465
    :cond_0
    return-void
.end method
