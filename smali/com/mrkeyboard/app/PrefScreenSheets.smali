.class public Lcom/mrkeyboard/app/PrefScreenSheets;
.super Landroid/app/Activity;
.source "PrefScreenSheets.java"


# static fields
.field private static final REQ_EXPORT_JSON:I = 0x1005

.field private static final REQ_IMPORT_JSON:I = 0x1006


# instance fields
.field private mListContainer:Landroid/widget/LinearLayout;

.field private mNewSheetBtn:Landroid/widget/TextView;

.field private mSheets:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private mSubtitleView:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showHeaderMenu(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->showNewSheetTemplatePicker()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 35
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    return-void
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startImportJson()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method private actionIcon(Landroid/view/View;Ljava/lang/String;IZ)Landroid/widget/ImageView;
    .locals 4

    .prologue
    .line 227
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 228
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 229
    if-eqz p4, :cond_1

    const-string v1, "mr_ui_text2"

    :goto_0
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v1

    const/high16 v3, 0x41900000    # 18.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {v2, p0, p3, v1, v3}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 228
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 230
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 231
    if-nez p4, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 232
    :cond_0
    return-object v0

    .line 229
    :cond_1
    const-string v1, "mr_ui_text_dis"

    goto :goto_0
.end method

.method private buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;
    .locals 8

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x1

    .line 187
    const-string v0, "mr_sheet_card"

    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v3

    .line 188
    const-string v0, "badge"

    invoke-virtual {v3, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v4, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v5, "123"

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 189
    const-string v0, "name"

    invoke-virtual {v3, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v4, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 190
    iget-boolean v0, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_3

    const-string v0, "mr_sheets_builtin"

    :goto_0
    new-array v4, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 191
    const-string v0, "info"

    invoke-virtual {v3, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const-string v5, "mr_sheets_card_info"

    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/Object;

    iget-object v7, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 192
    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v2

    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v1

    const/4 v7, 0x2

    aput-object v4, v6, v7

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    .line 191
    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 193
    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$7;

    invoke-direct {v0, p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$7;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v3, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 199
    const-string v4, "up"

    const/4 v5, 0x6

    if-lez p1, :cond_4

    move v0, v1

    :goto_1
    invoke-direct {p0, v3, v4, v5, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZ)Landroid/widget/ImageView;

    move-result-object v0

    .line 200
    if-lez p1, :cond_0

    .line 201
    new-instance v4, Lcom/mrkeyboard/app/PrefScreenSheets$8;

    invoke-direct {v4, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$8;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 207
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge p1, v0, :cond_1

    move v2, v1

    .line 208
    :cond_1
    const-string v0, "down"

    const/4 v4, 0x7

    invoke-direct {p0, v3, v0, v4, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZ)Landroid/widget/ImageView;

    move-result-object v0

    .line 209
    if-eqz v2, :cond_2

    .line 210
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$9;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$9;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 216
    :cond_2
    const-string v0, "more"

    invoke-direct {p0, v3, v0, v1, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZ)Landroid/widget/ImageView;

    move-result-object v0

    .line 217
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$10;

    invoke-direct {v1, p0, v0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$10;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 222
    return-object v3

    .line 190
    :cond_3
    const-string v0, "mr_sheets_custom"

    goto :goto_0

    :cond_4
    move v0, v2

    .line 199
    goto :goto_1
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 54
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 440
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 453
    :cond_0
    :goto_0
    return-void

    .line 441
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_delete_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 442
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 443
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete"

    new-array v2, v4, [Ljava/lang/Object;

    .line 444
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$17;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$17;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 451
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 452
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmResetAll()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 472
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_reset_all_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 473
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_all_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 474
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_all_ok"

    new-array v2, v3, [Ljava/lang/Object;

    .line 475
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$19;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$19;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 483
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 484
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 485
    return-void
.end method

.method private confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 456
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_reset_one_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 457
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 458
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_ok"

    new-array v2, v4, [Ljava/lang/Object;

    .line 459
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$18;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$18;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 467
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 468
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 469
    return-void
.end method

.method private dialogFields(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Landroid/widget/EditText;)Landroid/view/View;
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 355
    const-string v0, "mr_sheet_dialog_fields"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 356
    const-string v0, "badge_label"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 357
    invoke-static {p0, p2, v6}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v0

    .line 358
    invoke-virtual {v0, p2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 359
    const-string v2, "name_slot"

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 360
    invoke-static {p0, p3, v6}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v2

    .line 361
    new-array v3, v6, [Landroid/text/InputFilter;

    new-instance v4, Landroid/text/InputFilter$LengthFilter;

    const/4 v5, 0x5

    invoke-direct {v4, v5}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v4, v3, v7

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    .line 362
    invoke-virtual {v2, p3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 363
    const-string v3, "badge_slot"

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 364
    aput-object v0, p4, v7

    .line 365
    aput-object v2, p4, v6

    .line 366
    return-object v1
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 63
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    return v0
.end method

.method private duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 304
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 312
    :goto_0
    return-void

    .line 305
    :cond_0
    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 306
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    const-string v2, "copy"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 307
    iput-boolean v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 308
    const-string v1, "mr_sheets_copy_name"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 309
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    add-int/lit8 v2, p1, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 310
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 311
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    .prologue
    .line 58
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 59
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, p2, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method private limitReached()Z
    .locals 5

    .prologue
    const/16 v4, 0xc

    const/4 v0, 0x1

    const/4 v1, 0x0

    .line 296
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt v2, v4, :cond_0

    .line 297
    const-string v2, "mr_sheets_limit"

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v1

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 300
    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private moveSheet(II)V
    .locals 2

    .prologue
    .line 282
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    if-ltz p2, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p2, v0, :cond_1

    .line 287
    :cond_0
    :goto_0
    return-void

    .line 283
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 284
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1, p2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 285
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 286
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private openEditor(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 290
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 291
    const-string v1, "sheet_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 292
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivity(Landroid/content/Intent;)V

    .line 293
    return-void
.end method

.method private pickExistingSheetToCopy()V
    .locals 7

    .prologue
    const/4 v2, 0x0

    .line 335
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 336
    if-gtz v3, :cond_0

    .line 351
    :goto_0
    return-void

    .line 337
    :cond_0
    new-array v4, v3, [Ljava/lang/CharSequence;

    move v1, v2

    .line 338
    :goto_1
    if-ge v1, v3, :cond_1

    .line 339
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 340
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "["

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "] "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v1

    .line 338
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 342
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_copy_title"

    new-array v3, v2, [Ljava/lang/Object;

    .line 343
    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$14;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$14;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 344
    invoke-virtual {v0, v4, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v2, [Ljava/lang/Object;

    .line 349
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 350
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 10

    .prologue
    const/4 v5, 0x2

    const/4 v2, 0x1

    const/4 v9, 0x0

    .line 373
    if-ne p1, v2, :cond_0

    .line 374
    const-string v0, "mr_sheets_default_numpad"

    new-array v1, v9, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 375
    const-string v4, "NUM"

    .line 387
    :goto_0
    new-array v2, v5, [Landroid/widget/EditText;

    .line 388
    const-string v0, "mr_sheets_badge_label_new"

    new-array v1, v9, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v3, v4, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dialogFields(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Landroid/widget/EditText;)Landroid/view/View;

    move-result-object v0

    .line 389
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v5, "mr_sheets_new_title"

    new-array v6, v9, [Ljava/lang/Object;

    .line 390
    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 391
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v7

    const-string v0, "mr_sheets_create_edit"

    new-array v1, v9, [Ljava/lang/Object;

    .line 392
    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$15;

    move-object v1, p0

    move v5, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/PrefScreenSheets$15;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;[Landroid/widget/EditText;Ljava/lang/String;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v7, v8, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v9, [Ljava/lang/Object;

    .line 417
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 418
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 419
    return-void

    .line 376
    :cond_0
    if-ne p1, v5, :cond_1

    .line 377
    const-string v0, "mr_sheets_default_nav"

    new-array v1, v9, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 378
    const-string v4, "NAV"

    goto :goto_0

    .line 379
    :cond_1
    if-eqz p2, :cond_2

    .line 380
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " 2"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 381
    iget-object v4, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    goto :goto_0

    .line 383
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 384
    const-string v1, "mr_sheets_default_name"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v9

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 385
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "F"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    goto/16 :goto_0
.end method

.method private reloadAndRender()V
    .locals 7

    .prologue
    const/16 v6, 0xc

    const/4 v1, 0x0

    .line 172
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 173
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    const-string v2, "mr_sheets_subtitle"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v1

    const/4 v4, 0x1

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 174
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v0, v6, :cond_1

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_0
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setAlpha(F)V

    .line 175
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 176
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 177
    if-nez v2, :cond_2

    .line 178
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    const-string v1, "mr_sheet_empty"

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 184
    :cond_0
    return-void

    .line 174
    :cond_1
    const v0, 0x3ee66666    # 0.45f

    goto :goto_0

    .line 181
    :cond_2
    :goto_1
    if-ge v1, v2, :cond_0

    .line 182
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0, v1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 181
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1
.end method

.method private secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;
    .locals 5

    .prologue
    .line 162
    if-eqz p2, :cond_0

    const-string v0, "mr_sheet_button_danger"

    :goto_0
    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 163
    const-string v0, "icon"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 164
    invoke-direct {p0, p4}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {v2, p0, p3, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 163
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 165
    const-string v0, "label"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {p0, p5, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    return-object v1

    .line 162
    :cond_0
    const-string v0, "mr_sheet_button"

    goto :goto_0
.end method

.method private showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 10

    .prologue
    const/4 v8, 0x4

    const/4 v9, 0x2

    const/4 v1, 0x6

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 252
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 253
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v2, "mr_sheets_menu_edit"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v4, v8, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 254
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const-string v3, "mr_sheets_menu_rename"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v9, v2, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 255
    if-lez p2, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x3

    const-string v3, "mr_sheets_menu_up"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 256
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge p2, v0, :cond_1

    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x7

    const-string v3, "mr_sheets_menu_down"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v8, v2, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 257
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const/16 v3, 0x8

    const-string v5, "mr_sheets_menu_duplicate"

    new-array v8, v6, [Ljava/lang/Object;

    invoke-direct {p0, v5, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v2, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 258
    iget-boolean v0, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_2

    .line 259
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xc

    const-string v3, "mr_sheets_menu_restore"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 261
    :cond_2
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x7

    const/16 v2, 0xd

    const-string v3, "mr_sheets_menu_delete"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-boolean v5, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-nez v5, :cond_3

    move v5, v4

    :goto_0
    move v4, v9

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 262
    iget-object v0, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "123"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$12;

    invoke-direct {v5, p0, p3, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$12;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;I)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v7

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 277
    return-void

    :cond_3
    move v5, v6

    .line 261
    goto :goto_0
.end method

.method private showHeaderMenu(Landroid/view/View;)V
    .locals 9

    .prologue
    const/4 v1, 0x3

    const/4 v4, 0x1

    const/4 v8, 0x0

    .line 238
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 239
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xa

    const-string v3, "mr_sheets_menu_export"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v4, v2, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 240
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x2

    const/16 v3, 0xb

    const-string v5, "mr_sheets_menu_import"

    new-array v7, v8, [Ljava/lang/Object;

    invoke-direct {p0, v5, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v2, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 241
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xc

    const-string v3, "mr_sheets_restore_all"

    new-array v5, v8, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 242
    const-string v2, "JSON"

    const-string v0, "mr_sheets_menu_subtitle"

    new-array v1, v8, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$11;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$11;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v6

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 249
    return-void
.end method

.method private showNewSheetTemplatePicker()V
    .locals 7

    .prologue
    const/4 v1, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 315
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 332
    :goto_0
    return-void

    .line 316
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    move v2, v3

    .line 317
    :goto_1
    if-eqz v2, :cond_3

    const/4 v0, 0x4

    :goto_2
    new-array v0, v0, [Ljava/lang/CharSequence;

    .line 318
    const-string v5, "mr_sheets_tpl_blank"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v4

    .line 319
    const-string v5, "mr_sheets_tpl_numpad"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 320
    const/4 v3, 0x2

    const-string v5, "mr_sheets_tpl_nav"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 321
    if-eqz v2, :cond_1

    const-string v2, "mr_sheets_tpl_copy"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    .line 322
    :cond_1
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheets_tpl_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 323
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$13;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$13;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 324
    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 330
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 331
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    :cond_2
    move v2, v4

    .line 316
    goto :goto_1

    :cond_3
    move v0, v1

    .line 317
    goto :goto_2
.end method

.method private showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 422
    const/4 v0, 0x2

    new-array v0, v0, [Landroid/widget/EditText;

    .line 423
    const-string v1, "mr_sheets_badge_label_edit"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-direct {p0, v1, v2, v3, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->dialogFields(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Landroid/widget/EditText;)Landroid/view/View;

    move-result-object v1

    .line 424
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v3, "mr_sheets_rename_title"

    new-array v4, v5, [Ljava/lang/Object;

    .line 425
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 426
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_sheets_save"

    new-array v3, v5, [Ljava/lang/Object;

    .line 427
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$16;

    invoke-direct {v3, p0, p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$16;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;[Landroid/widget/EditText;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v5, [Ljava/lang/Object;

    .line 435
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 436
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 437
    return-void
.end method

.method private slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 157
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private startExportJson()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 491
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 492
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 493
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 494
    const-string v1, "android.intent.extra.TITLE"

    const-string v2, "mr-keyboard-sheets.json"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 495
    const/16 v1, 0x1005

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 499
    :goto_0
    return-void

    .line 496
    :catch_0
    move-exception v0

    .line 497
    const-string v0, "mr_sheets_picker_error"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private startImportJson()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 503
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 504
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 505
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 506
    const-string v1, "android.intent.extra.MIME_TYPES"

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/String;

    const/4 v3, 0x0

    const-string v4, "application/json"

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-string v4, "text/plain"

    aput-object v4, v2, v3

    const/4 v3, 0x2

    const-string v4, "application/octet-stream"

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    .line 507
    const/16 v1, 0x1006

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 511
    :goto_0
    return-void

    .line 508
    :catch_0
    move-exception v0

    .line 509
    const-string v0, "mr_sheets_picker_error"

    new-array v1, v5, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 48
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 49
    if-nez v0, :cond_0

    .line 50
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private toast(Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 67
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 68
    return-void

    .line 67
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 74
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 75
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 515
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 516
    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 565
    :cond_0
    :goto_0
    return-void

    .line 517
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 518
    if-eqz v0, :cond_0

    .line 519
    const/16 v1, 0x1005

    if-ne p1, v1, :cond_2

    .line 521
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->exportJsonString(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 522
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 523
    if-eqz v2, :cond_0

    .line 525
    :try_start_1
    const-string v0, "UTF-8"

    invoke-virtual {v1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/io/OutputStream;->write([B)V

    .line 526
    invoke-virtual {v2}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 528
    :try_start_2
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    .line 530
    const-string v0, "mr_sheets_exported"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 531
    :catch_0
    move-exception v0

    .line 532
    const-string v1, "mr_sheets_export_failed"

    new-array v2, v7, [Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v6

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 528
    :catchall_0
    move-exception v0

    :try_start_3
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V

    .line 529
    throw v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 534
    :cond_2
    const/16 v1, 0x1006

    if-ne p1, v1, :cond_0

    .line 536
    :try_start_4
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v0

    .line 537
    if-eqz v0, :cond_0

    .line 540
    :try_start_5
    invoke-static {v0}, Lcom/mrkeyboard/app/SheetStore;->readStreamUtf8(Ljava/io/InputStream;)Ljava/lang/String;
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    move-result-object v1

    .line 542
    :try_start_6
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 544
    invoke-static {v1}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v0

    .line 545
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v3, "mr_sheets_import_title"

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    .line 546
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    const-string v3, "mr_sheets_import_msg"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    .line 547
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v4, v5

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "mr_sheets_import"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    .line 548
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$20;

    invoke-direct {v3, p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets$20;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 559
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 560
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_1

    goto/16 :goto_0

    .line 561
    :catch_1
    move-exception v0

    .line 562
    const-string v1, "mr_sheets_import_bad_file"

    new-array v2, v7, [Ljava/lang/Object;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    aput-object v0, v2, v6

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto/16 :goto_0

    .line 542
    :catchall_1
    move-exception v1

    :try_start_7
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 543
    throw v1
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 11

    .prologue
    const/4 v10, 0x1

    const/4 v9, -0x2

    const/high16 v8, 0x3f800000    # 1.0f

    const/4 v7, -0x1

    const/4 v2, 0x0

    .line 79
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 80
    const-string v0, "mr_sheets_screen"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v6

    .line 81
    const-string v0, "subtitle"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    .line 82
    const-string v0, "list"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    .line 83
    const-string v0, "new_btn"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    .line 86
    const/4 v0, 0x2

    const-string v1, "mr_ui_text"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v1

    const/16 v3, 0x28

    const-string v4, "mr_sheets_back"

    new-array v5, v2, [Ljava/lang/Object;

    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {p0, v0, v1, v3, v4}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 87
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$1;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 92
    const-string v1, "back_slot"

    invoke-direct {p0, v6, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 94
    const-string v0, "mr_ui_text"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v0

    const/16 v1, 0x28

    const-string v3, "mr_sheets_more"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p0, v10, v0, v1, v3}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 95
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$2;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$2;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 100
    const-string v1, "more_slot"

    invoke-direct {p0, v6, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v7, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 104
    const-string v0, "lock"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 105
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/16 v3, 0xf

    const-string v4, "mr_ui_text3"

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v4

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-direct {v1, p0, v3, v4, v5}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 108
    const-string v0, "option_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSheetOpt;->row(Landroid/content/Context;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 110
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$3;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 117
    const-string v0, "io_row"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 118
    const/16 v3, 0xa

    const-string v4, "mr_ui_mint"

    const-string v5, "mr_sheets_export_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 119
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$4;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$4;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 124
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v9, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 125
    const/high16 v4, 0x41000000    # 8.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-virtual {v3, v2, v2, v4, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 126
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 127
    const/16 v3, 0xb

    const-string v4, "mr_ui_cyan"

    const-string v5, "mr_sheets_import_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 128
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$5;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$5;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 133
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v9, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 135
    const-string v0, "restore_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 136
    const/16 v3, 0xc

    const-string v4, "mr_ui_danger"

    const-string v5, "mr_sheets_restore_all"

    move-object v0, p0

    move v2, v10

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 137
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$6;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$6;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 142
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 144
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->setContentView(Landroid/view/View;)V

    .line 145
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 149
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 150
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 151
    invoke-static {}, Lcom/mrkeyboard/app/SheetStore;->consumeCorruptRecoveryFlag()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 152
    const-string v0, "mr_sheets_corrupt"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 154
    :cond_0
    return-void
.end method
