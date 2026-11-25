.class Lcom/mrkeyboard/app/SheetNameDialog$1;
.super Ljava/lang/Object;
.source "SheetNameDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$badgeField:Landroid/widget/EditText;

.field final synthetic val$done:Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;

.field final synthetic val$nameField:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 57
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$done:Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;

    iput-object p2, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$nameField:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$badgeField:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3

    .prologue
    .line 59
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$done:Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$done:Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$nameField:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetNameDialog$1;->val$badgeField:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;->onNamed(Ljava/lang/String;Ljava/lang/String;)V

    .line 60
    :cond_0
    return-void
.end method
