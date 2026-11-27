.class Lcom/mrkeyboard/app/SheetEditorActivity$7;
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
    .line 270
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAddKeyTapped(I)V
    .locals 1

    .prologue
    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;I)V

    .line 273
    return-void
.end method

.method public onDropRefused(I)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 296
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v2, "mr_sheet_ed_row_limit"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v4, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;I)I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    .line 297
    return-void
.end method

.method public onKeyDragged(IIII)V
    .locals 1

    .prologue
    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$600(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V

    .line 277
    return-void
.end method

.method public onKeyTapped(II)V
    .locals 1

    .prologue
    .line 280
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/MrAbcKeys$Model;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 281
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$800(Lcom/mrkeyboard/app/SheetEditorActivity;II)V

    .line 285
    :goto_0
    return-void

    .line 283
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$900(Lcom/mrkeyboard/app/SheetEditorActivity;II)V

    goto :goto_0
.end method

.method public onLockedKeyTapped(Z)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 288
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/MrAbcKeys$Model;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 289
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v2, "mr_abc_fixed_key"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    .line 293
    :goto_0
    return-void

    .line 292
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$7;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    if-eqz p1, :cond_1

    const-string v0, "mr_sheet_ed_locked_delete"

    :goto_1
    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    goto :goto_0

    :cond_1
    const-string v0, "mr_sheet_ed_locked_row"

    goto :goto_1
.end method
