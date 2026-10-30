.class Lcom/mrkeyboard/app/PrefScreenSheets$19;
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

.field final synthetic val$badgeEt:Landroid/widget/EditText;

.field final synthetic val$nameEt:Landroid/widget/EditText;

.field final synthetic val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .registers 5

    .line 730
    iput-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iput-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$nameEt:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$badgeEt:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 733
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$nameEt:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 734
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$badgeEt:Landroid/widget/EditText;

    invoke-virtual {p2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->val$sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 735
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # getter for: Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;
    invoke-static {p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;

    move-result-object p2

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 736
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets$19;->this$0:Lcom/mrkeyboard/app/PrefScreenSheets;

    # invokes: Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V
    invoke-static {p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 737
    return-void
.end method
