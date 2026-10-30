.class Lcom/mrkeyboard/app/PopupEditDialog$5;
.super Ljava/lang/Object;
.source "PopupEditDialog.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mrkeyboard/app/PopupEditDialog;->show(Landroid/content/Context;Ljava/util/List;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/PopupEditDialog$OnPopupSavedListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$addItemBtn:Landroid/widget/TextView;

.field final synthetic val$allSheets:Ljava/util/List;

.field final synthetic val$charsBox:Landroid/widget/LinearLayout;

.field final synthetic val$ctx:Landroid/content/Context;

.field final synthetic val$currentMode:[I

.field final synthetic val$keysBox:Landroid/widget/LinearLayout;

.field final synthetic val$keysHeader:Landroid/widget/TextView;

.field final synthetic val$keysList:Landroid/widget/LinearLayout;

.field final synthetic val$noneInfo:Landroid/widget/TextView;

.field final synthetic val$pt:Z

.field final synthetic val$refreshRef:[Ljava/lang/Runnable;

.field final synthetic val$tabChars:Landroid/widget/TextView;

.field final synthetic val$tabKeys:Landroid/widget/TextView;

.field final synthetic val$tabNone:Landroid/widget/TextView;

.field final synthetic val$workingKeys:Ljava/util/ArrayList;


# direct methods
.method constructor <init>(Landroid/content/Context;Landroid/widget/TextView;[ILandroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/LinearLayout;Landroid/widget/LinearLayout;Landroid/widget/TextView;ZLjava/util/ArrayList;Landroid/widget/LinearLayout;Ljava/util/List;[Ljava/lang/Runnable;Landroid/widget/TextView;)V
    .registers 16

    .line 266
    iput-object p1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iput-object p2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabNone:Landroid/widget/TextView;

    iput-object p3, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    iput-object p4, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabChars:Landroid/widget/TextView;

    iput-object p5, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabKeys:Landroid/widget/TextView;

    iput-object p6, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$noneInfo:Landroid/widget/TextView;

    iput-object p7, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$charsBox:Landroid/widget/LinearLayout;

    iput-object p8, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysBox:Landroid/widget/LinearLayout;

    iput-object p9, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysHeader:Landroid/widget/TextView;

    iput-boolean p10, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$pt:Z

    iput-object p11, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    iput-object p12, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysList:Landroid/widget/LinearLayout;

    iput-object p13, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$allSheets:Ljava/util/List;

    iput-object p14, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$refreshRef:[Ljava/lang/Runnable;

    iput-object p15, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$addItemBtn:Landroid/widget/TextView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 14

    .line 269
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabNone:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    const/4 v3, 0x0

    aget v2, v2, v3

    const/4 v4, 0x1

    if-nez v2, :cond_e

    move v2, v4

    goto :goto_f

    :cond_e
    move v2, v3

    :goto_f
    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->styleModeChip(Landroid/content/Context;Landroid/widget/TextView;Z)V
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->access$000(Landroid/content/Context;Landroid/widget/TextView;Z)V

    .line 270
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabChars:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v2, v2, v3

    if-ne v2, v4, :cond_1e

    move v2, v4

    goto :goto_1f

    :cond_1e
    move v2, v3

    :goto_1f
    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->styleModeChip(Landroid/content/Context;Landroid/widget/TextView;Z)V
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->access$000(Landroid/content/Context;Landroid/widget/TextView;Z)V

    .line 271
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$tabKeys:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v2, v2, v3

    const/4 v5, 0x2

    if-ne v2, v5, :cond_2f

    move v2, v4

    goto :goto_30

    :cond_2f
    move v2, v3

    :goto_30
    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->styleModeChip(Landroid/content/Context;Landroid/widget/TextView;Z)V
    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/PopupEditDialog;->access$000(Landroid/content/Context;Landroid/widget/TextView;Z)V

    .line 272
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$noneInfo:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v1, v1, v3

    const/16 v2, 0x8

    if-nez v1, :cond_3f

    move v1, v3

    goto :goto_40

    :cond_3f
    move v1, v2

    :goto_40
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 273
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$charsBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v1, v1, v3

    if-ne v1, v4, :cond_4d

    move v1, v3

    goto :goto_4e

    :cond_4d
    move v1, v2

    :goto_4e
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 274
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysBox:Landroid/widget/LinearLayout;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v1, v1, v3

    if-ne v1, v5, :cond_5a

    move v2, v3

    :cond_5a
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 276
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$currentMode:[I

    aget v0, v0, v3

    if-ne v0, v5, :cond_f0

    .line 277
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysHeader:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$pt:Z

    if-eqz v2, :cond_71

    const-string v2, "Itens do popup ("

    goto :goto_73

    :cond_71
    const-string v2, "Popup items ("

    :goto_73
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0xa

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "):"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 278
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysList:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 279
    nop

    :goto_a0
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v3, v0, :cond_dd

    .line 280
    nop

    .line 281
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 282
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$keysList:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$ctx:Landroid/content/Context;

    iget-object v5, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$allSheets:Ljava/util/List;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    .line 287
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v8

    new-instance v9, Lcom/mrkeyboard/app/PopupEditDialog$5$1;

    invoke-direct {v9, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$5$1;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$5;I)V

    new-instance v10, Lcom/mrkeyboard/app/PopupEditDialog$5$2;

    invoke-direct {v10, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$5$2;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$5;I)V

    new-instance v11, Lcom/mrkeyboard/app/PopupEditDialog$5$3;

    invoke-direct {v11, p0, v6, v3}, Lcom/mrkeyboard/app/PopupEditDialog$5$3;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$5;Lcom/mrkeyboard/app/SheetModel$KeySpec;I)V

    new-instance v12, Lcom/mrkeyboard/app/PopupEditDialog$5$4;

    invoke-direct {v12, p0, v3}, Lcom/mrkeyboard/app/PopupEditDialog$5$4;-><init>(Lcom/mrkeyboard/app/PopupEditDialog$5;I)V

    .line 282
    move v7, v3

    # invokes: Lcom/mrkeyboard/app/PopupEditDialog;->buildPopupItemRow(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;
    invoke-static/range {v4 .. v12}, Lcom/mrkeyboard/app/PopupEditDialog;->access$200(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;IILjava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;Ljava/lang/Runnable;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 279
    add-int/lit8 v3, v3, 0x1

    goto :goto_a0

    .line 329
    :cond_dd
    iget-object v0, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$addItemBtn:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/mrkeyboard/app/PopupEditDialog$5;->val$workingKeys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v1, v2, :cond_ea

    const/high16 v1, 0x3f800000    # 1.0f

    goto :goto_ed

    :cond_ea
    const v1, 0x3ee66666    # 0.45f

    :goto_ed
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setAlpha(F)V

    .line 331
    :cond_f0
    return-void
.end method
