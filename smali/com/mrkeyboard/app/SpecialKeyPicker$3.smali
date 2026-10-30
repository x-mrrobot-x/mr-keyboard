.class Lcom/mrkeyboard/app/SpecialKeyPicker$3;
.super Ljava/lang/Object;
.source "SpecialKeyPicker.java"

# interfaces
.implements Landroid/content/DialogInterface$OnShowListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/SpecialKeyPicker;->show(Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$currentCode:I

.field final synthetic val$dialog:Landroid/app/AlertDialog;

.field final synthetic val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;


# direct methods
.method constructor <init>(Landroid/app/AlertDialog;Landroid/content/Context;ILcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;)V
    .registers 5

    .line 254
    iput-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$dialog:Landroid/app/AlertDialog;

    iput-object p2, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$ctx:Landroid/content/Context;

    iput p3, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$currentCode:I

    iput-object p4, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$listener:Lcom/mrkeyboard/app/SpecialKeyPicker$OnSpecialKeySelectedListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShow(Landroid/content/DialogInterface;)V
    .registers 3

    .line 257
    iget-object p1, p0, Lcom/mrkeyboard/app/SpecialKeyPicker$3;->val$dialog:Landroid/app/AlertDialog;

    const/4 v0, -0x3

    invoke-virtual {p1, v0}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p1

    new-instance v0, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/SpecialKeyPicker$3$1;-><init>(Lcom/mrkeyboard/app/SpecialKeyPicker$3;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 264
    return-void
.end method
