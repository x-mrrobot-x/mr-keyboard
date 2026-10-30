.class Lcom/mrkeyboard/app/KeyEditDialog$3$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Lcom/mrkeyboard/app/KeyEditDialog$OnTargetPicked;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$3;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$3;)V
    .registers 2

    .line 303
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPicked(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .registers 6

    .line 306
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$3$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$selectedSheetTarget:[Ljava/lang/String;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    .line 307
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$sheetPickBtn:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    const-string v0, "  \u25be"

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 308
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_3e

    .line 309
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$3$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$3;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$3;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 311
    :cond_3e
    return-void
.end method
