.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;
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
    .line 386
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2

    .prologue
    .line 393
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$2100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Landroid/text/Editable;->length()I

    move-result v0

    const/4 v1, 0x6

    if-gt v0, v1, :cond_0

    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xa

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(I)I

    move-result v0

    if-gez v0, :cond_0

    .line 394
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v0

    invoke-interface {p1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 395
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$11;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$2102(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Z)Z

    .line 397
    :cond_0
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 387
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 0

    .prologue
    .line 389
    return-void
.end method
