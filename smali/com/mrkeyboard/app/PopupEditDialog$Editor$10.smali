.class Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog$Editor;->editItem(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

.field final synthetic val$position:I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$Editor;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 279
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    iput p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->val$position:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .locals 0

    .prologue
    .line 280
    return-void
.end method

.method public onDuplicate()V
    .locals 0

    .prologue
    .line 282
    return-void
.end method

.method public onMoveLeft()V
    .locals 0

    .prologue
    .line 284
    return-void
.end method

.method public onMoveRight()V
    .locals 0

    .prologue
    .line 286
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .locals 2

    .prologue
    .line 289
    iget v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->val$position:I

    if-gez v0, :cond_0

    .line 290
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 294
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$700(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)V

    .line 295
    return-void

    .line 292
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/PopupEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/PopupEditDialog$Editor;->access$600(Lcom/mrkeyboard/app/PopupEditDialog$Editor;)Ljava/util/ArrayList;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$Editor$10;->val$position:I

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->set(ILjava/lang/Object;)Ljava/lang/Object;

    goto :goto_0
.end method
