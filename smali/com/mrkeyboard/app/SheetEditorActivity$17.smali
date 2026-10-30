.class Lcom/mrkeyboard/app/SheetEditorActivity$17;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->openKeyEditor(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$current:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$keyIdx:I

.field final synthetic val$row:Lcom/mrkeyboard/app/SheetModel$Row;

.field final synthetic val$rowIdx:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;IILcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 6

    .line 613
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$rowIdx:I

    iput-object p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$current:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .registers 3

    .line 616
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 617
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 618
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 619
    return-void
.end method

.method public onDuplicate()V
    .registers 4

    .line 622
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$rowIdx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_15

    const/16 v0, 0x9

    goto :goto_17

    :cond_15
    const/16 v0, 0xa

    .line 623
    :goto_17
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v1, v0, :cond_3c

    .line 624
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 625
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$current:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 626
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 628
    :cond_3c
    return-void
.end method

.method public onMoveLeft()V
    .registers 4

    .line 631
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    if-lez v0, :cond_25

    .line 632
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 633
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 634
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 635
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 637
    :cond_25
    return-void
.end method

.method public onMoveRight()V
    .registers 4

    .line 640
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_2f

    .line 641
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 642
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 643
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 644
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 646
    :cond_2f
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 4

    .line 649
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 650
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$row:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$keyIdx:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 651
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 652
    return-void
.end method
