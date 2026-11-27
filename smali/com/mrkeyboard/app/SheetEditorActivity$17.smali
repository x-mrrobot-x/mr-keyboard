.class Lcom/mrkeyboard/app/SheetEditorActivity$17;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->renderRows(Landroid/widget/LinearLayout;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$idx:I

.field final synthetic val$list:Landroid/widget/LinearLayout;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 611
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$idx:I

    iput-object p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$list:Landroid/widget/LinearLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    .prologue
    .line 613
    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$idx:I

    if-lez v0, :cond_0

    .line 614
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 615
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$idx:I

    add-int/lit8 v2, v0, -0x1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    iget v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$idx:I

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 616
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    .line 617
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$17;->val$list:Landroid/widget/LinearLayout;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2500(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;)V

    .line 619
    :cond_0
    return-void
.end method
