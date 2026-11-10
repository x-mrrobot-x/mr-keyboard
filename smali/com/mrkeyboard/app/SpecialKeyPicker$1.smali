.class Lcom/mrkeyboard/app/SpecialKeyPicker$1;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker;->showCustomCodeDialog(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$context:Landroid/content/Context;

.field final synthetic val$field:Landroid/widget/EditText;

.field final synthetic val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;


# direct methods
.method constructor <init>(Landroid/widget/EditText;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;Landroid/content/Context;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 270
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$field:Landroid/widget/EditText;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    iput-object p3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$context:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 273
    :try_start_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$field:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 274
    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v0, v2}, Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;->onSpecialKeySelected(ILjava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 278
    :cond_0
    :goto_0
    return-void

    .line 275
    :catch_0
    move-exception v0

    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$context:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$1;->val$context:Landroid/content/Context;

    const-string v2, "mr_pick_invalid"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-static {v1, v2, v3}, Lcom/mrkeyboard/app/SpecialKeyPicker;->access$200(Landroid/content/Context;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method
