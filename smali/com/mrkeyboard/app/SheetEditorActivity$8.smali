.class Lcom/mrkeyboard/app/SheetEditorActivity$8;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->addNewKeyToRow(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$target:Lcom/mrkeyboard/app/SheetModel$Row;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 319
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .locals 0

    .prologue
    .line 320
    return-void
.end method

.method public onDuplicate()V
    .locals 0

    .prologue
    .line 322
    return-void
.end method

.method public onMoveLeft()V
    .locals 0

    .prologue
    .line 324
    return-void
.end method

.method public onMoveRight()V
    .locals 0

    .prologue
    .line 326
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 1

    .prologue
    .line 329
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 330
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->val$target:Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 331
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 332
    return-void
.end method
