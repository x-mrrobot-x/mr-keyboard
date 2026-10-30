.class Lcom/mrkeyboard/app/SheetEditorActivity$18;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Z)V
    .registers 3

    .line 688
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 691
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p2

    iget-object p2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {p1, p2}, Lcom/mrkeyboard/app/SheetStore;->loadDefaultBuiltinSheet(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    .line 692
    if-eqz p1, :cond_32

    .line 693
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 694
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # setter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {p2, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$502(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 695
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 696
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-boolean p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$18;->val$pt:Z

    if-eqz p2, :cond_28

    const-string p2, "Folha restaurada para o padr\u00e3o."

    goto :goto_2a

    :cond_28
    const-string p2, "Sheet restored to default."

    :goto_2a
    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 698
    :cond_32
    return-void
.end method
