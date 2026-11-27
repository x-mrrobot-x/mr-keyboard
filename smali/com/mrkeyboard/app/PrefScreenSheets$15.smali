.class Lcom/mrkeyboard/app/PrefScreenSheets$15;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
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
    .line 428
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onNamed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 430
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p1, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 431
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p2, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$15;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 434
    return-void
.end method
