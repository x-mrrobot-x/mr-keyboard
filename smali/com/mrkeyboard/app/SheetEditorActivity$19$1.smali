.class Lcom/mrkeyboard/app/SheetEditorActivity$19$1;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity$19;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

.field final synthetic val$rIdx:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity$19;I)V
    .registers 3

    .line 744
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iput p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->val$rIdx:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 747
    iget p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->val$rIdx:I

    if-lez p1, :cond_3f

    .line 748
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 749
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object p1

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->val$rIdx:I

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 750
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->val$rIdx:I

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 751
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetEditorActivity$19;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 752
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$19$1;->this$1:Lcom/mrkeyboard/app/SheetEditorActivity$19;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetEditorActivity$19;->val$rebuild:[Ljava/lang/Runnable;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 754
    :cond_3f
    return-void
.end method
