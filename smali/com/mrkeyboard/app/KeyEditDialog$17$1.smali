.class Lcom/mrkeyboard/app/KeyEditDialog$17$1;
.super Ljava/lang/Object;
.source "KeyEditDialog.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/KeyEditDialog$17;->onShow(Landroid/content/DialogInterface;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;


# direct methods
.method constructor <init>(Lcom/mrkeyboard/app/KeyEditDialog$17;)V
    .registers 2

    .line 544
    iput-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 7

    .line 547
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$labelInput:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 548
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$isPopupItem:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_16

    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_27

    :cond_16
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$widthStepIdx:[I

    aget v0, v0, v1

    int-to-float v0, v0

    const/high16 v2, 0x3e800000    # 0.25f

    mul-float/2addr v0, v2

    const/high16 v2, 0x3f000000    # 0.5f

    add-float/2addr v0, v2

    invoke-static {v0}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v0

    .line 550
    :goto_27
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v3, "spacer"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_52

    .line 551
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v1, ""

    iput-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 552
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 553
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const/4 v1, 0x0

    iput-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupChars:Ljava/lang/String;

    .line 554
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v1, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->popupKeys:Ljava/util/ArrayList;

    goto/16 :goto_184

    .line 555
    :cond_52
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v3, "text"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_c2

    .line 556
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$textValueInput:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    .line 557
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_8f

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_8f

    .line 558
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$pt:Z

    if-eqz v0, :cond_85

    const-string v0, "Informe o texto ou r\u00f3tulo da tecla."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_87

    :cond_85
    const-string v0, "Enter key text or label."

    :goto_87
    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 559
    return-void

    .line 561
    :cond_8f
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_96

    move-object v2, p1

    .line 562
    :cond_96
    nop

    .line 563
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_b4

    .line 564
    const-string p1, "\n"

    const-string v3, "\u21b5"

    invoke-virtual {v2, p1, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 565
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x6

    if-le v3, v4, :cond_b4

    invoke-virtual {p1, v1, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 567
    :cond_b4
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object p1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 568
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 569
    goto/16 :goto_184

    :cond_c2
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v3, "tasker"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_115

    .line 570
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$taskerInput:Landroid/widget/EditText;

    invoke-virtual {v2}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->stripTaskerPrefix(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 571
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_fd

    .line 572
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$ctx:Landroid/content/Context;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$pt:Z

    if-eqz v0, :cond_f3

    const-string v0, "Informe o nome do comando Tasker."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_f5

    :cond_f3
    const-string v0, "Enter the Tasker command name."

    :goto_f5
    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 573
    return-void

    .line 575
    :cond_fd
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 576
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_112

    move-object p1, v2

    :cond_112
    iput-object p1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 577
    goto :goto_184

    :cond_115
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v3, "special"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_14e

    .line 578
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v3, v3, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$selectedSpecialCode:[I

    aget v3, v3, v1

    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 579
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_14b

    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$selectedSpecialCode:[I

    aget p1, p1, v1

    invoke-static {p1}, Lcom/mrkeyboard/app/SpecialKeyPicker;->defaultLabelForCode(I)Ljava/lang/String;

    move-result-object p1

    :cond_14b
    iput-object p1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    goto :goto_184

    .line 580
    :cond_14e
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v3, "sheet"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_184

    .line 581
    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v3, v3, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$selectedSheetTarget:[Ljava/lang/String;

    aget-object v1, v3, v1

    iput-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->value:Ljava/lang/String;

    .line 582
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v1, v1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_182

    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v2, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v2, v2, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$allSheets:Ljava/util/List;

    invoke-static {p1, v2}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object p1

    :cond_182
    iput-object p1, v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->label:Ljava/lang/String;

    .line 585
    :cond_184
    :goto_184
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iput v0, p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    .line 586
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$dialog:Landroid/app/AlertDialog;

    invoke-virtual {p1}, Landroid/app/AlertDialog;->dismiss()V

    .line 587
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    if-eqz p1, :cond_1a2

    .line 588
    iget-object p1, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object p1, p1, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$listener:Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;

    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$17$1;->this$0:Lcom/mrkeyboard/app/KeyEditDialog$17;

    iget-object v0, v0, Lcom/mrkeyboard/app/KeyEditDialog$17;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-interface {p1, v0}, Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;->onSave(Lcom/mrkeyboard/app/SheetModel$KeySpec;)V

    .line 590
    :cond_1a2
    return-void
.end method
