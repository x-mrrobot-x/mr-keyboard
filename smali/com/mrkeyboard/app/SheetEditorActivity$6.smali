.class Lcom/mrkeyboard/app/SheetEditorActivity$6;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->onCreate(Landroid/os/Bundle;)V
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

    .line 215
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 218
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    const/4 v0, 0x6

    if-lt p1, v0, :cond_23

    .line 219
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    .line 221
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->val$pt:Z

    if-eqz v0, :cond_18

    const-string v0, "Limite m\u00e1ximo de 6 fileiras edit\u00e1veis atingido."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1a

    :cond_18
    const-string v0, "Maximum of 6 editable rows reached."

    .line 219
    :goto_1a
    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    .line 223
    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 224
    return-void

    .line 226
    :cond_23
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 227
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance v0, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v0}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 228
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$6;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 229
    return-void
.end method
