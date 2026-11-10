.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor;->bindTaskerPresets(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

.field final synthetic val$pill:Landroid/widget/TextView;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor;Landroid/widget/TextView;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 271
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->val$pill:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->val$pill:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 274
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$400(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 275
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$3;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 276
    :cond_0
    return-void
.end method
