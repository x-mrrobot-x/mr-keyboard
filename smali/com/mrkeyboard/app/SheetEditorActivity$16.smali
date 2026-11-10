.class Lcom/mrkeyboard/app/SheetEditorActivity$16;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$badgeField:Landroid/widget/EditText;

.field final synthetic val$nameField:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 429
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->val$nameField:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->val$badgeField:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 431
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 432
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->val$nameField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->val$badgeField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    .line 434
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$16;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 435
    return-void
.end method
