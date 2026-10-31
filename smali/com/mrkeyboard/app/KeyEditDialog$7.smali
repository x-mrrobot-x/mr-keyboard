.class Lcom/mrkeyboard/app/KeyEditDialog$7;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog;->showInternal(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$popupBtn:Landroid/widget/TextView;

.field final synthetic val$pt:Z


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Landroid/widget/TextView;Z)V
    .registers 4

    .line 384
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$popupBtn:Landroid/widget/TextView;

    iput-boolean p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$pt:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 4

    .line 387
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupKeys()Z

    move-result v0

    if-eqz v0, :cond_36

    .line 388
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$popupBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$pt:Z

    if-eqz v2, :cond_16

    const-string v2, "Lista de teclas ("

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_18

    :cond_16
    const-string v2, "Action keys ("

    :goto_18
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ")  \u25b8"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_76

    .line 389
    :cond_36
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasPopupChars()Z

    move-result v0

    if-eqz v0, :cond_68

    .line 390
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$popupBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$pt:Z

    if-eqz v2, :cond_4c

    const-string v2, "Caracteres: "

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_4e

    :cond_4c
    const-string v2, "Chars: "

    :goto_4e
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "  \u25b8"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_76

    .line 392
    :cond_68
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$popupBtn:Landroid/widget/TextView;

    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$7;->val$pt:Z

    if-eqz v1, :cond_71

    const-string v1, "Nenhum (toque para configurar)  \u25b8"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_73

    :cond_71
    const-string v1, "None (tap to configure)  \u25b8"

    :goto_73
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 394
    :goto_76
    return-void
.end method
