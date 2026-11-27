.class Lcom/mrkeyboard/app/SheetEditorActivity$10;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->openAbcKeyEditor(II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$index:I

.field final synthetic val$target:Lcom/mrkeyboard/app/SheetModel$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 387
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iput p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .locals 0

    .prologue
    .line 388
    return-void
.end method

.method public onDuplicate()V
    .locals 0

    .prologue
    .line 390
    return-void
.end method

.method public onMoveLeft()V
    .locals 0

    .prologue
    .line 392
    return-void
.end method

.method public onMoveRight()V
    .locals 0

    .prologue
    .line 394
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 2

    .prologue
    .line 397
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 398
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->val$index:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 399
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$10;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 400
    return-void
.end method
