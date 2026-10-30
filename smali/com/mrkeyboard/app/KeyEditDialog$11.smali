.class Lcom/mrkeyboard/app/KeyEditDialog$11;
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
.field final synthetic val$dialog:Landroid/app/AlertDialog;

.field final synthetic val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;


# direct methods
.method constructor <init>(Landroid/app/AlertDialog;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V
    .registers 3

    .line 448
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$11;->val$dialog:Landroid/app/AlertDialog;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$11;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 2

    .line 451
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$11;->val$dialog:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 452
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$11;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-eqz p1, :cond_e

    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$11;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    invoke-interface {p1}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onDuplicate()V

    .line 453
    :cond_e
    return-void
.end method
