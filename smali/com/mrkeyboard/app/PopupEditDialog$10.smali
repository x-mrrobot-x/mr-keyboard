.class Lcom/mrkeyboard/app/PopupEditDialog$10;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$charsInput:Landroid/widget/EditText;

.field final synthetic val$currentMode:[I

.field final synthetic val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

.field final synthetic val$workingKeys:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;[ILandroid/widget/EditText;Ljava/util/ArrayList;)V
    .registers 5

    .line 375
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$currentMode:[I

    iput-object p3, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$charsInput:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$workingKeys:Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 5

    .line 378
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    if-nez p1, :cond_5

    return-void

    .line 379
    :cond_5
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$currentMode:[I

    const/4 p2, 0x0

    aget p1, p1, p2

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-ne p1, v0, :cond_25

    .line 380
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$charsInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 381
    iget-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_21

    move-object p1, v1

    :cond_21
    invoke-interface {p2, p1, v1}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    .line 382
    goto :goto_43

    :cond_25
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$currentMode:[I

    aget p1, p1, p2

    const/4 p2, 0x2

    if-ne p1, p2, :cond_3e

    .line 383
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    iget-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_38

    move-object p2, v1

    goto :goto_3a

    :cond_38
    iget-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$workingKeys:Ljava/util/ArrayList;

    :goto_3a
    invoke-interface {p1, v1, p2}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    goto :goto_43

    .line 385
    :cond_3e
    iget-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$10;->val$listener:Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;

    invoke-interface {p1, v1, v1}, Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;->onPopupSaved(Ljava/lang/String;Ljava/util/ArrayList;)V

    .line 387
    :goto_43
    return-void
.end method
