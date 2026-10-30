.class Lcom/mrkeyboard/app/PopupEditDialog$9;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$pt:Z

.field final synthetic val$refreshRef:[Ljava/lang/Runnable;

.field final synthetic val$workingKeys:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Ljava/util/ArrayList;Landroid/content/Context;ZLjava/util/List;[Ljava/lang/Runnable;)V
    .registers 6

    .line 355
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$workingKeys:Ljava/util/ArrayList;

    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$ctx:Landroid/content/Context;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$pt:Z

    iput-object p4, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$allSheets:Ljava/util/List;

    iput-object p5, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$refreshRef:[Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 7

    .line 358
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    const/16 v0, 0xa

    if-lt p1, v0, :cond_1e

    .line 359
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$ctx:Landroid/content/Context;

    iget-boolean v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$pt:Z

    if-eqz v0, :cond_13

    const-string v0, "Limite m\u00e1ximo de 10 itens no popup."

    goto :goto_15

    :cond_13
    const-string v0, "Maximum of 10 popup items."

    :goto_15
    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 360
    return-void

    .line 362
    :cond_1e
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$9;->val$allSheets:Ljava/util/List;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v2, "text"

    const/high16 v3, 0x3f800000    # 1.0f

    const-string v4, ""

    invoke-direct {v1, v4, v2, v4, v3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    new-instance v2, Lcom/mrkeyboard/app/PopupEditDialog$9$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PopupEditDialog$9$1;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$9;)V

    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->showSinglePopupItemEditor(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
    invoke-static {p1, v0, v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->access$100(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V

    .line 369
    return-void
.end method
