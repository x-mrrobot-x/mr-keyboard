.class Lcom/mrkeyboard/app/KeyEditDialog$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$labelInput:Landroid/widget/EditText;

.field final synthetic val$preset:Ljava/lang/String;

.field final synthetic val$taskerInput:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Landroid/widget/EditText;Ljava/lang/String;Landroid/widget/EditText;)V
    .registers 4

    .line 249
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$taskerInput:Landroid/widget/EditText;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$preset:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$labelInput:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 3

    .line 252
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$taskerInput:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$preset:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 253
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_22

    .line 254
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$labelInput:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$1;->val$preset:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 256
    :cond_22
    return-void
.end method
