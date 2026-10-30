.class Lcom/mrkeyboard/app/KeyEditDialog$2$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$2;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$2;)V
    .registers 2

    .line 274
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSpecialKeySelected(ILjava/lang/String;)V
    .registers 7

    .line 277
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$selectedSpecialCode:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    .line 278
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$selectedSpecialCode:[I

    aput p1, v2, v1

    .line 279
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$specialPickBtn:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object v3, v3, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$ctx:Landroid/content/Context;

    invoke-static {v3, p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, "  \u25be"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 280
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    .line 281
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_4f

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_56

    .line 282
    :cond_4f
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$2$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$2;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$2;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 284
    :cond_56
    return-void
.end method
