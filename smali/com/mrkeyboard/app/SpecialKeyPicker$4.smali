.class Lcom/mrkeyboard/app/SpecialKeyPicker$4;
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
.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$input:Landroid/widget/EditText;

.field final synthetic val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Landroid/widget/EditText;Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;Landroid/content/Context;Z)V
    .registers 5

    .line 295
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$input:Landroid/widget/EditText;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    iput-object p3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$ctx:Landroid/content/Context;

    iput-boolean p4, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    .line 299
    :try_start_0
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$input:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p1

    .line 300
    iget-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    if-eqz p2, :cond_1f

    .line 301
    iget-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    invoke-static {p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, p1, v0}, Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;->onSpecialKeySelected(ILjava/lang/String;)V
    :try_end_1f
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_1f} :catch_20

    .line 305
    :cond_1f
    goto :goto_34

    .line 303
    :catch_20
    move-exception p1

    .line 304
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$ctx:Landroid/content/Context;

    iget-boolean p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$4;->val$pt:Z

    if-eqz p2, :cond_2a

    const-string p2, "C\u00f3digo inteiro inv\u00e1lido."

    goto :goto_2c

    :cond_2a
    const-string p2, "Invalid integer code."

    :goto_2c
    const/4 v0, 0x0

    invoke-static {p1, p2, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 306
    :goto_34
    return-void
.end method
