.class Lcom/mrkeyboard/app/SheetEditorActivity$22;
.super Ljava/lang/Object;
.source "SheetEditorActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetEditorActivity;->confirmDeleteCurrentSheet()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

.field final synthetic val$all:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 600
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->val$all:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v2, 0x0

    .line 602
    move v1, v2

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->val$all:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    .line 603
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->val$all:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-static {v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v3

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 604
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->val$all:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 608
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->val$all:Ljava/util/ArrayList;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 609
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    const-string v3, "mr_sheet_ed_deleted"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-static {v1, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$800(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$900(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V

    .line 610
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$22;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 611
    return-void

    .line 602
    :cond_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0
.end method
