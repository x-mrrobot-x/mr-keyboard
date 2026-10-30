.class Lcom/mrkeyboard/app/SheetEditorActivity$15;
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

.field final synthetic val$list:Ljava/util/ArrayList;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/util/ArrayList;Z)V
    .registers 4

    .line 565
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$list:Ljava/util/ArrayList;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 5

    .line 568
    const/4 p1, 0x0

    move p2, p1

    :goto_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$list:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p2, v0, :cond_2b

    .line 569
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$list:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    # getter for: Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    invoke-static {v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_28

    .line 570
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$list:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 571
    goto :goto_2b

    .line 568
    :cond_28
    add-int/lit8 p2, p2, 0x1

    goto :goto_2

    .line 574
    :cond_2b
    :goto_2b
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$list:Ljava/util/ArrayList;

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 575
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->val$pt:Z

    if-eqz v0, :cond_3b

    const-string v0, "Folha exclu\u00edda."

    goto :goto_3d

    :cond_3b
    const-string v0, "Sheet deleted."

    :goto_3d
    invoke-static {p2, v0, p1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 576
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity$15;->this$0:Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-virtual {p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 577
    return-void
.end method
