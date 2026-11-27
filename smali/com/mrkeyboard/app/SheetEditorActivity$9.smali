.class Lcom/mrkeyboard/app/SheetEditorActivity$9;
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

.field final synthetic val$index:I

.field final synthetic val$key:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$row:I

.field final synthetic val$target:Lcom/mrkeyboard/app/SheetModel$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;IILcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 343
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$row:I

    iput-object p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$key:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .locals 2

    .prologue
    .line 345
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 346
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 347
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 348
    return-void
.end method

.method public onDuplicate()V
    .locals 3

    .prologue
    .line 351
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$row:I

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;I)I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 352
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 353
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$key:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 354
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 356
    :cond_0
    return-void
.end method

.method public onMoveLeft()V
    .locals 4

    .prologue
    .line 359
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    if-lez v0, :cond_0

    .line 360
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 361
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    add-int/lit8 v2, v0, -0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 362
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 364
    :cond_0
    return-void
.end method

.method public onMoveRight()V
    .locals 4

    .prologue
    .line 367
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_0

    .line 368
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 369
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    add-int/lit8 v2, v0, 0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 370
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 372
    :cond_0
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 2

    .prologue
    .line 375
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$index:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 377
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 378
    return-void
.end method
