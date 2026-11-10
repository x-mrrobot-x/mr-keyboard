.class Lcom/mrkeyboard/app/SheetEditorActivity$10;
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
    .line 277
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    iput p4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$row:I

    iput-object p5, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$key:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .locals 2

    .prologue
    .line 279
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 280
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 281
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 282
    return-void
.end method

.method public onDuplicate()V
    .locals 3

    .prologue
    .line 285
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$row:I

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;I)I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 286
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 287
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    add-int/lit8 v1, v1, 0x1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$key:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->deepCopy()Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 288
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 290
    :cond_0
    return-void
.end method

.method public onMoveLeft()V
    .locals 4

    .prologue
    .line 293
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    if-lez v0, :cond_0

    .line 294
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 295
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    add-int/lit8 v2, v0, -0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 296
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 298
    :cond_0
    return-void
.end method

.method public onMoveRight()V
    .locals 4

    .prologue
    .line 301
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge v0, v1, :cond_0

    .line 302
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 303
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    add-int/lit8 v2, v0, 0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 304
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 306
    :cond_0
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 2

    .prologue
    .line 309
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 310
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 311
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 312
    return-void
.end method
