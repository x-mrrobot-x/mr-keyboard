.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;)V
    .locals 0

    .prologue
    .line 330
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPicked(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    .prologue
    .line 332
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1402(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Ljava/lang/String;)Ljava/lang/String;

    .line 333
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  \u25be"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 334
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$7;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 335
    :cond_0
    return-void
.end method
