.class Lcom/mrkeyboard/app/KeyEditDialog$8;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$updatePopupSummary:Ljava/lang/Runnable;


# direct methods
.method constructor <init>(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/Runnable;)V
    .registers 5

    .line 396
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$ctx:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$allSheets:Ljava/util/List;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$updatePopupSummary:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 6

    .line 399
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$allSheets:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$8;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    new-instance v3, Lcom/mrkeyboard/app/KeyEditDialog$8$1;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/KeyEditDialog$8$1;-><init>(Lcom/mrkeyboard/app/KeyEditDialog$8;)V

    invoke-static {p1, v0, v1, v2, v3}, Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V

    .line 407
    return-void
.end method
