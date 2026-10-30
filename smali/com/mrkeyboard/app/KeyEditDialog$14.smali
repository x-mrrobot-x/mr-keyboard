.class Lcom/mrkeyboard/app/KeyEditDialog$14;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$autoSyncLabel:[Z

.field final synthetic val$labelInput:Landroid/widget/EditText;


# direct methods
.method constructor <init>([ZLandroid/widget/EditText;)V
    .registers 3

    .line 484
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$14;->val$autoSyncLabel:[Z

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$14;->val$labelInput:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .registers 5

    .line 489
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$14;->val$autoSyncLabel:[Z

    const/4 v1, 0x0

    aget-boolean v0, v0, v1

    if-eqz v0, :cond_28

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v0

    const/4 v2, 0x6

    if-gt v0, v2, :cond_28

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v2, "\n"

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_28

    .line 490
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$14;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 491
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$14;->val$autoSyncLabel:[Z

    const/4 v0, 0x1

    aput-boolean v0, p1, v1

    .line 493
    :cond_28
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .registers 5

    .line 485
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .registers 5

    .line 486
    return-void
.end method
