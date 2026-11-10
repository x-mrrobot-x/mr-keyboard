.class Lcom/mrkeyboard/app/SheetEditorActivity$8;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Lcom/mrkeyboard/app/SheetGridView$GridListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->bindGrid(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 217
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAddKeyTapped(I)V
    .locals 1

    .prologue
    .line 219
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;I)V

    .line 220
    return-void
.end method

.method public onKeyDragged(IIII)V
    .locals 1

    .prologue
    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V

    .line 224
    return-void
.end method

.method public onKeyTapped(II)V
    .locals 1

    .prologue
    .line 227
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;II)V

    .line 228
    return-void
.end method

.method public onLockedKeyTapped(Z)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 231
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$8;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    if-eqz p1, :cond_0

    const-string v0, "mr_sheet_ed_locked_delete"

    :goto_0
    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$800(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$900(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    .line 232
    return-void

    .line 231
    :cond_0
    const-string v0, "mr_sheet_ed_locked_row"

    goto :goto_0
.end method
