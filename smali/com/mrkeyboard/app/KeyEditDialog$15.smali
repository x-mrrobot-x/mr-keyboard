.class Lcom/mrkeyboard/app/KeyEditDialog$15;
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
.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

.field final synthetic val$isPopupItem:Z

.field final synthetic val$labelBox:Landroid/widget/LinearLayout;

.field final synthetic val$popupSection:Landroid/widget/LinearLayout;

.field final synthetic val$selectedSheetTarget:[Ljava/lang/String;

.field final synthetic val$selectedSpecialCode:[I

.field final synthetic val$sheetBox:Landroid/widget/LinearLayout;

.field final synthetic val$sheetPickBtn:Landroid/widget/TextView;

.field final synthetic val$spacerInfo:Landroid/widget/TextView;

.field final synthetic val$specialBox:Landroid/widget/LinearLayout;

.field final synthetic val$specialPickBtn:Landroid/widget/TextView;

.field final synthetic val$taskerBox:Landroid/widget/LinearLayout;

.field final synthetic val$textActionBox:Landroid/widget/LinearLayout;

.field final synthetic val$typeChips:[Landroid/widget/TextView;

.field final synthetic val$typeCodes:[Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/content/Context;[Ljava/lang/String;Lcom/mrkeyboard/app/SheetModel$KeySpec;[Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/TextView;ZLandroid/widget/LinearLayout;Landroid/widget/TextView;[ILandroid/widget/TextView;Ljava/util/List;[Ljava/lang/String;)V
    .registers 20

    .line 496
    move-object v0, p0

    move-object v1, p1

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$ctx:Landroid/content/Context;

    move-object v1, p2

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeCodes:[Ljava/lang/String;

    move-object v1, p3

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    move-object v1, p4

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeChips:[Landroid/widget/TextView;

    move-object v1, p5

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$labelBox:Landroid/widget/LinearLayout;

    move-object v1, p6

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$textActionBox:Landroid/widget/LinearLayout;

    move-object v1, p7

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$taskerBox:Landroid/widget/LinearLayout;

    move-object v1, p8

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$specialBox:Landroid/widget/LinearLayout;

    move-object v1, p9

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$sheetBox:Landroid/widget/LinearLayout;

    move-object v1, p10

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$spacerInfo:Landroid/widget/TextView;

    move v1, p11

    iput-boolean v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$isPopupItem:Z

    move-object v1, p12

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$popupSection:Landroid/widget/LinearLayout;

    move-object v1, p13

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$specialPickBtn:Landroid/widget/TextView;

    move-object/from16 v1, p14

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$selectedSpecialCode:[I

    move-object/from16 v1, p15

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$sheetPickBtn:Landroid/widget/TextView;

    move-object/from16 v1, p16

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$allSheets:Ljava/util/List;

    move-object/from16 v1, p17

    iput-object v1, v0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$selectedSheetTarget:[Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 9

    .line 499
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$ctx:Landroid/content/Context;

    const/high16 v1, 0x41200000    # 10.0f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v0

    .line 500
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$ctx:Landroid/content/Context;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v1

    const/4 v2, 0x1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 501
    const/4 v2, 0x0

    move v3, v2

    :goto_17
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeCodes:[Ljava/lang/String;

    array-length v4, v4

    if-ge v3, v4, :cond_67

    .line 502
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeCodes:[Ljava/lang/String;

    aget-object v4, v4, v3

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 503
    if-eqz v4, :cond_46

    .line 504
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeChips:[Landroid/widget/TextView;

    aget-object v4, v4, v3

    const v5, -0xd63a0a

    const v6, 0x3304141c

    invoke-static {v5, v0, v2, v2, v6}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 505
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeChips:[Landroid/widget/TextView;

    aget-object v4, v4, v3

    const v5, -0xfbebe4

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_64

    .line 507
    :cond_46
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeChips:[Landroid/widget/TextView;

    aget-object v4, v4, v3

    const v5, -0xd5c4ac

    const v6, 0x3329c5f6

    const v7, -0xf5efe8

    invoke-static {v7, v0, v1, v5, v6}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 508
    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$typeChips:[Landroid/widget/TextView;

    aget-object v4, v4, v3

    const v5, -0x6c5c46

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 501
    :goto_64
    add-int/lit8 v3, v3, 0x1

    goto :goto_17

    .line 511
    :cond_67
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v1, "spacer"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 512
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$labelBox:Landroid/widget/LinearLayout;

    const/16 v3, 0x8

    if-eqz v0, :cond_79

    move v4, v3

    goto :goto_7a

    :cond_79
    move v4, v2

    :goto_7a
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 513
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$textActionBox:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v5, "text"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_8d

    move v4, v2

    goto :goto_8e

    :cond_8d
    move v4, v3

    :goto_8e
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 514
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$taskerBox:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v5, "tasker"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_a1

    move v4, v2

    goto :goto_a2

    :cond_a1
    move v4, v3

    :goto_a2
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 515
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$specialBox:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v5, "special"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_b5

    move v4, v2

    goto :goto_b6

    :cond_b5
    move v4, v3

    :goto_b6
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 516
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$sheetBox:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$draft:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    const-string v5, "sheet"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_c9

    move v4, v2

    goto :goto_ca

    :cond_c9
    move v4, v3

    :goto_ca
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 517
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$spacerInfo:Landroid/widget/TextView;

    if-eqz v0, :cond_d3

    move v4, v2

    goto :goto_d4

    :cond_d3
    move v4, v3

    :goto_d4
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 518
    iget-boolean v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$isPopupItem:Z

    if-nez v1, :cond_e4

    .line 519
    iget-object v1, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$popupSection:Landroid/widget/LinearLayout;

    if-eqz v0, :cond_e0

    goto :goto_e1

    :cond_e0
    move v3, v2

    :goto_e1
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 521
    :cond_e4
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$specialPickBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$ctx:Landroid/content/Context;

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$selectedSpecialCode:[I

    aget v4, v4, v2

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/SpecialKeyPicker;->describeCode(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "  \u25be"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 522
    iget-object v0, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$sheetPickBtn:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$ctx:Landroid/content/Context;

    iget-object v5, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$allSheets:Ljava/util/List;

    iget-object v6, p0, Lcom/mrkeyboard/app/KeyEditDialog$15;->val$selectedSheetTarget:[Ljava/lang/String;

    aget-object v2, v6, v2

    # invokes: Lcom/mrkeyboard/app/KeyEditDialog;->describeSheetTarget(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;
    invoke-static {v4, v5, v2}, Lcom/mrkeyboard/app/KeyEditDialog;->access$200(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 523
    return-void
.end method
