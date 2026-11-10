.class Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;)V
    .locals 0

    .prologue
    .line 311
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSpecialKeySelected(ILjava/lang/String;)V
    .locals 4

    .prologue
    .line 314
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1200(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)I

    move-result v0

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    .line 315
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1, p1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1202(Lcom/mrkeyboard/app/KeyEditDialog$Editor;I)I

    .line 316
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1300(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/TextView;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v3, v3, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v3}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$1100(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "  \u25be"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 317
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v1}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 318
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_0

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6$1;->this$1:Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$Editor$6;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$Editor;

    invoke-static {v0}, Lcom/mrkeyboard/app/KeyEditDialog$Editor;->access$500(Lcom/mrkeyboard/app/KeyEditDialog$Editor;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 319
    :cond_1
    return-void
.end method
