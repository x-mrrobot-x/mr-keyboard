.class Lcom/mrkeyboard/app/PopupEditDialog$11;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->showSinglePopupItemEditor(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$cb:Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;)V
    .registers 2

    .line 394
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$11;->val$cb:Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDelete()V
    .registers 1

    .line 395
    return-void
.end method

.method public onDuplicate()V
    .registers 1

    .line 396
    return-void
.end method

.method public onMoveLeft()V
    .registers 1

    .line 397
    return-void
.end method

.method public onMoveRight()V
    .registers 1

    .line 398
    return-void
.end method

.method public onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V
    .registers 3

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$11;->val$cb:Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;

    invoke-interface {v0, p1}, Lcom/mrkeyboard/app/PopupEditDialog$OnItemEdited;->onSaved(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 402
    return-void
.end method
