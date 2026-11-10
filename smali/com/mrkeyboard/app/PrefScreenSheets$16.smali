.class Lcom/mrkeyboard/app/PrefScreenSheets$16;
.super Ljava/lang/Object;
.source "PrefScreenSheets.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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

.field final synthetic val$fields:[Landroid/widget/EditText;

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;[Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 427
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$fields:[Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 429
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$fields:[Landroid/widget/EditText;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 430
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$fields:[Landroid/widget/EditText;

    const/4 v2, 0x1

    aget-object v1, v1, v2

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 431
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$16;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    invoke-static {v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 433
    return-void
.end method
