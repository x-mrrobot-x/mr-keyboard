.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/text/TextWatcher;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindLabelSync()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)V
    .locals 0

    .prologue
    .line 376
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 3

    .prologue
    .line 382
    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    .line 383
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$10;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v2}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$2200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    invoke-static {v1, v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$2102(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Z)Z

    .line 384
    return-void

    .line 383
    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 377
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 379
    return-void
.end method
