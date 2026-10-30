.class Lcom/mrkeyboard/app/KeyEditDialog$13;
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

.field final synthetic val$textValueInput:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Landroid/widget/EditText;[Z)V
    .registers 3

    .line 474
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$13;->val$textValueInput:Landroid/widget/EditText;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$13;->val$autoSyncLabel:[Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .registers 6

    .line 479
    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 480
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$13;->val$textValueInput:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 481
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$13;->val$autoSyncLabel:[Z

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-nez v2, :cond_20

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1e

    goto :goto_20

    :cond_1e
    move p1, v3

    goto :goto_21

    :cond_20
    :goto_20
    const/4 p1, 0x1

    :goto_21
    aput-boolean p1, v1, v3

    .line 482
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .registers 5

    .line 475
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .registers 5

    .line 476
    return-void
.end method
