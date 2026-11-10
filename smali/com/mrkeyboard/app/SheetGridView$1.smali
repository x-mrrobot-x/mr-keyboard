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
    .locals 0

    .prologue
    .line 201
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 203
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v0

    iget v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetGridView;->access$100(Lcom/mrkeyboard/app/SheetGridView;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 210
    :cond_0
    :goto_0
    return-void

    .line 204
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->access$102(Lcom/mrkeyboard/app/SheetGridView;Z)Z

    .line 205
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->performHapticFeedback(I)Z

    .line 206
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetGridView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    .line 207
    if-eqz v0, :cond_2

    invoke-interface {v0, v2}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 208
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v1}, Lcom/mrkeyboard/app/SheetGridView;->access$200(Lcom/mrkeyboard/app/SheetGridView;)F

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetGridView;->access$300(Lcom/mrkeyboard/app/SheetGridView;)F

    move-result v2

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->access$400(Lcom/mrkeyboard/app/SheetGridView;FF)V

    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView$1;->this$0:Lcom/mrkeyboard/app/SheetGridView;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    goto :goto_0
.end method
