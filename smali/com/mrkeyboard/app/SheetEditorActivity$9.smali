.class Lcom/mrkeyboard/app/SheetEditorActivity$9;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetGridView$GridListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Z)V
    .registers 3

    .line 257
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-boolean p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAddKeyTapped(I)V
    .registers 3

    .line 260
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->addNewKeyToRow(I)V
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$900(Lcom/mrkeyboard/app/SheetEditorActivity;I)V

    .line 261
    return-void
.end method

.method public onKeyDragged(IIII)V
    .registers 6

    .line 264
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->handleKeyDragMove(IIII)V
    invoke-static {v0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V

    .line 265
    return-void
.end method

.method public onKeyTapped(II)V
    .registers 4

    .line 268
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # invokes: Lcom/mrkeyboard/app/SheetEditorActivity;->openKeyEditor(II)V
    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;II)V

    .line 269
    return-void
.end method

.method public onLockedKeyTapped(Z)V
    .registers 4

    .line 272
    if-eqz p1, :cond_c

    .line 273
    iget-boolean p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$pt:Z

    if-eqz p1, :cond_9

    const-string p1, "A tecla Apagar (\u232b) no canto inferior direito \u00e9 fixa por seguran\u00e7a."

    goto :goto_15

    :cond_9
    const-string p1, "The trailing Delete key is locked for safety."

    goto :goto_15

    .line 274
    :cond_c
    iget-boolean p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->val$pt:Z

    if-eqz p1, :cond_13

    const-string p1, "A fileira inferior do sistema \u00e9 fixa em todas as folhas."

    goto :goto_15

    :cond_13
    const-string p1, "The bottom system row is fixed across all sheets."

    .line 275
    :goto_15
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$9;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 276
    return-void
.end method
