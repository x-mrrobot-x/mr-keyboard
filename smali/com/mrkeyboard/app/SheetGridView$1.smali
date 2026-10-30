.class Lcom/mrkeyboard/app/SheetGridView$1;
.super Ljava/lang/Object;
.source "SheetGridView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetGridView;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetGridView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetGridView;)V
    .registers 2

    .line 94
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 4

    .line 97
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    # getter for: Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v0

    if-eqz v0, :cond_47

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    # getter for: Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v0

    iget v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v0, :cond_47

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    # getter for: Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$100(Lcom/mrkeyboard/app/SheetGridView;)Z

    move-result v0

    if-nez v0, :cond_47

    .line 98
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    const/4 v1, 0x1

    # setter for: Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z
    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->access$102(Lcom/mrkeyboard/app/SheetGridView;Z)Z

    .line 99
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->performHapticFeedback(I)Z

    .line 100
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetGridView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    .line 101
    if-eqz v0, :cond_31

    .line 102
    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 104
    :cond_31
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    # getter for: Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F
    invoke-static {v1}, Lcom/mrkeyboard/app/SheetGridView;->access$200(Lcom/mrkeyboard/app/SheetGridView;)F

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    # getter for: Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetGridView;->access$300(Lcom/mrkeyboard/app/SheetGridView;)F

    move-result v2

    # invokes: Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->access$400(Lcom/mrkeyboard/app/SheetGridView;FF)V

    .line 105
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 107
    :cond_47
    return-void
.end method
