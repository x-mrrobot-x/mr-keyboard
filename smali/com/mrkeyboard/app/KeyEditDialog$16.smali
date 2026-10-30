.class Lcom/mrkeyboard/app/KeyEditDialog$16;
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
.field final synthetic val$code:Ljava/lang/String;

.field final synthetic val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$labelInput:Landroid/widget/EditText;

.field final synthetic val$refreshTypeUi:Ljava/lang/Runnable;

.field final synthetic val$selectedSpecialCode:[I


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;Landroid/widget/EditText;[ILjava/lang/Runnable;)V
    .registers 6

    .line 528
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p2, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$code:Ljava/lang/String;

    iput-object p3, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$labelInput:Landroid/widget/EditText;

    iput-object p4, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$selectedSpecialCode:[I

    iput-object p5, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$refreshTypeUi:Ljava/lang/Runnable;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    .line 531
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$code:Ljava/lang/String;

    iput-object v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    .line 532
    const-string p1, "special"

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$code:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_32

    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_32

    .line 533
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$labelInput:Landroid/widget/EditText;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$selectedSpecialCode:[I

    const/4 v1, 0x0

    aget v0, v0, v1

    invoke-static {v0}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 535
    :cond_32
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$16;->val$refreshTypeUi:Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 536
    return-void
.end method
