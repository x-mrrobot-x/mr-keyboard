.class public Lcom/mrkeyboard/app/PrefScreenSheets;
.super Landroid/app/Activity;
.source "PrefScreenSheets.java"


# static fields
.field static final IMPORT_MAX_BYTES:I = 0x100000

.field private static final REQ_EXPORT_JSON:I = 0x1005

.field private static final REQ_IMPORT_JSON:I = 0x1006

.field static final TAP_GAP_MS:J = 0x2bcL


# instance fields
.field private mAbcDesc:Landroid/widget/TextView;

.field private mLastOpen:J

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
    .locals 2

    .prologue
    .line 46
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 62
    const-wide/16 v0, -0x2bc

    iput-wide v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->showNewSheetTemplatePicker()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 46
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)Z
    .locals 1

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    return v0
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    return-void
.end method

.method static synthetic access$1602(Lcom/mrkeyboard/app/PrefScreenSheets;J)J
    .locals 1

    .prologue
    .line 46
    iput-wide p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    return-wide p1
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startImportJson()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/PrefScreenSheets;II)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method private actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;
    .locals 4

    .prologue
    .line 262
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 263
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 264
    if-eqz p4, :cond_1

    const-string v1, "mr_ui_text2"

    :goto_0
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v1

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {v2, p0, p3, v1, v3}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 263
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 265
    invoke-virtual {v0, p5}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 266
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 267
    if-nez p4, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 268
    :cond_0
    return-object v0

    .line 264
    :cond_1
    const-string v1, "mr_ui_text_dis"

    goto :goto_0
.end method

.method private buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;
    .locals 9

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 222
    const-string v0, "mr_sheet_card"

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 223
    const-string v0, "badge"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v3, "123"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 224
    const-string v0, "name"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 225
    iget-boolean v0, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_2

    const-string v0, "mr_sheets_builtin"

    :goto_0
    new-array v2, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 226
    const-string v0, "info"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const-string v3, "mr_sheets_card_info"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 227
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    const/4 v5, 0x2

    aput-object v2, v4, v5

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 226
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 228
    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$7;

    invoke-direct {v0, p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$7;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 234
    const-string v2, "up"

    const/4 v3, 0x6

    if-lez p1, :cond_3

    move v4, v6

    :goto_1
    const-string v0, "mr_sheets_up_desc"

    new-array v5, v6, [Ljava/lang/Object;

    iget-object v8, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v8, v5, v7

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 235
    if-lez p1, :cond_0

    .line 236
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$8;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$8;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 242
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge p1, v0, :cond_4

    move v4, v6

    .line 243
    :goto_2
    const-string v2, "down"

    const/4 v3, 0x7

    const-string v0, "mr_sheets_down_desc"

    new-array v5, v6, [Ljava/lang/Object;

    iget-object v8, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v8, v5, v7

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 244
    if-eqz v4, :cond_1

    .line 245
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$9;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$9;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 251
    :cond_1
    const-string v2, "more"

    const-string v0, "mr_sheets_options_desc"

    new-array v3, v6, [Ljava/lang/Object;

    iget-object v4, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v4, v3, v7

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v0, p0

    move v3, v6

    move v4, v6

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 252
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$10;

    invoke-direct {v2, p0, v0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$10;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 257
    return-object v1

    .line 225
    :cond_2
    const-string v0, "mr_sheets_custom"

    goto/16 :goto_0

    :cond_3
    move v4, v7

    .line 234
    goto :goto_1

    :cond_4
    move v4, v7

    .line 242
    goto :goto_2
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 74
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

    .line 439
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 452
    :cond_0
    :goto_0
    return-void

    .line 440
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_delete_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 441
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 442
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete"

    new-array v2, v4, [Ljava/lang/Object;

    .line 443
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$16;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$16;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 450
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 451
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmResetAll()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 471
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 485
    :goto_0
    return-void

    .line 472
    :cond_0
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

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$18;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$18;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

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

    goto :goto_0
.end method

.method private confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 455
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_reset_one_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 456
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 457
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_ok"

    new-array v2, v4, [Ljava/lang/Object;

    .line 458
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$17;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$17;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 466
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 467
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 468
    return-void
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 83
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    return v0
.end method

.method private duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 329
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 337
    :goto_0
    return-void

    .line 330
    :cond_0
    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 331
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    const-string v2, "copy"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 332
    iput-boolean v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 333
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

    .line 334
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    add-int/lit8 v2, p1, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 335
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 336
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private exportTo(Landroid/net/Uri;)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 546
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->exportJsonString(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->addToBackup(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 547
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v1

    .line 548
    if-nez v1, :cond_0

    .line 549
    const-string v0, "mr_sheets_export_failed"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 562
    :goto_0
    return-void

    .line 553
    :cond_0
    :try_start_1
    const-string v2, "UTF-8"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 554
    invoke-virtual {v1}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 556
    :try_start_2
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 558
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

    .line 559
    :catch_0
    move-exception v0

    .line 560
    const-string v0, "mr_sheets_export_failed"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 556
    :catchall_0
    move-exception v0

    :try_start_3
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 557
    throw v0
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
.end method

.method private importFrom(Landroid/net/Uri;)V
    .locals 8

    .prologue
    const/4 v1, 0x0

    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 567
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    .line 568
    if-nez v0, :cond_0

    .line 569
    const-string v0, "mr_sheets_import_bad"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 614
    :goto_0
    return-void

    .line 573
    :cond_0
    const/high16 v2, 0x100000

    :try_start_1
    invoke-static {v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->readCapped(Ljava/io/InputStream;I)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v2

    .line 575
    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 581
    if-nez v2, :cond_1

    .line 582
    const-string v0, "mr_sheets_import_too_big"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 575
    :catchall_0
    move-exception v1

    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 576
    throw v1
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 577
    :catch_0
    move-exception v0

    .line 578
    const-string v0, "mr_sheets_import_bad"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 587
    :cond_1
    :try_start_4
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v0

    .line 591
    :goto_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 593
    :cond_2
    const-string v0, "mr_sheets_import_bad_file"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 588
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 589
    goto :goto_1

    .line 596
    :cond_3
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "mr_sheets_import_title"

    new-array v5, v7, [Ljava/lang/Object;

    .line 597
    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    const-string v4, "mr_sheets_import_msg"

    new-array v5, v6, [Ljava/lang/Object;

    .line 598
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v6, 0xc

    invoke-static {v0, v6}, Ljava/lang/Math;->min(II)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v5, v7

    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v3, "mr_sheets_import"

    new-array v4, v7, [Ljava/lang/Object;

    .line 599
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/PrefScreenSheets$19;

    invoke-direct {v4, p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets$19;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    invoke-virtual {v0, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "mr_sheets_cancel"

    new-array v3, v7, [Ljava/lang/Object;

    .line 612
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 613
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0
.end method

.method private inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    .prologue
    .line 78
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 79
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

    .line 321
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt v2, v4, :cond_0

    .line 322
    const-string v2, "mr_sheets_limit"

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v1

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 325
    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private moveSheet(II)V
    .locals 2

    .prologue
    .line 306
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

    .line 311
    :cond_0
    :goto_0
    return-void

    .line 307
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 308
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1, p2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 309
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 310
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private openEditor(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 314
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 318
    :goto_0
    return-void

    .line 315
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 316
    const-string v1, "sheet_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 317
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivity(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private pickExistingSheetToCopy()V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 360
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 361
    if-gtz v3, :cond_0

    .line 376
    :goto_0
    return-void

    .line 362
    :cond_0
    new-array v4, v3, [Ljava/lang/CharSequence;

    move v1, v2

    .line 363
    :goto_1
    if-ge v1, v3, :cond_1

    .line 364
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 365
    const-string v5, "mr_key_ed_target_sheet"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    iget-object v7, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v8, "123"

    invoke-static {v7, v8}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    aput-object v7, v6, v2

    const/4 v7, 0x1

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v0, v6, v7

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    aput-object v0, v4, v1

    .line 363
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 367
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_copy_title"

    new-array v3, v2, [Ljava/lang/Object;

    .line 368
    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$13;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$13;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 369
    invoke-virtual {v0, v4, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v2, [Ljava/lang/Object;

    .line 374
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 375
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 11

    .prologue
    const/4 v2, 0x1

    const/4 v4, 0x0

    .line 382
    if-ne p1, v2, :cond_0

    .line 383
    const-string v0, "mr_sheets_default_numpad"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 384
    const-string v3, "NUM"

    .line 396
    :goto_0
    const-string v0, "mr_sheets_new_title"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    const-string v0, "mr_sheets_create_edit"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    const-string v0, "mr_sheets_cancel"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$14;

    move-object v1, p0

    move v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets$14;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    move-object v4, p0

    move-object v5, v8

    move-object v8, v2

    move-object v9, v3

    move-object v10, v0

    invoke-static/range {v4 .. v10}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    .line 424
    return-void

    .line 385
    :cond_0
    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    .line 386
    const-string v0, "mr_sheets_default_nav"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 387
    const-string v3, "NAV"

    goto :goto_0

    .line 388
    :cond_1
    if-eqz p2, :cond_2

    .line 389
    const-string v0, "mr_sheets_copy_name"

    new-array v1, v2, [Ljava/lang/Object;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v2, v1, v4

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 390
    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    goto :goto_0

    .line 392
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 393
    const-string v1, "mr_sheets_default_name"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 394
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "F"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_0
.end method

.method static readCapped(Ljava/io/InputStream;I)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .prologue
    const/16 v1, 0x2000

    .line 520
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 521
    new-array v1, v1, [B

    .line 523
    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    .line 524
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v3

    add-int/2addr v3, v2

    if-le v3, p1, :cond_0

    const/4 v0, 0x0

    .line 527
    :goto_1
    return-object v0

    .line 525
    :cond_0
    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 527
    :cond_1
    const-string v1, "UTF-8"

    invoke-virtual {v0, v1}, Ljava/io/ByteArrayOutputStream;->toString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private reloadAndRender()V
    .locals 7

    .prologue
    const/16 v6, 0xc

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 200
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mAbcDesc:Landroid/widget/TextView;

    if-eqz v0, :cond_0

    .line 201
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->count(Landroid/content/Context;)I

    move-result v0

    .line 202
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mAbcDesc:Landroid/widget/TextView;

    if-nez v0, :cond_3

    const-string v0, "mr_sheets_main_desc"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 204
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 205
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 206
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    const-string v3, "mr_sheets_subtitle"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v2

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v1

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 207
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v0, v6, :cond_4

    move v0, v1

    .line 208
    :goto_1
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    if-eqz v0, :cond_5

    const-string v1, "mr_sheets_new"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-direct {p0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 209
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    if-eqz v0, :cond_6

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_3
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    .line 210
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 211
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 212
    if-nez v1, :cond_7

    .line 213
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    const-string v1, "mr_sheet_empty"

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 219
    :cond_2
    return-void

    .line 202
    :cond_3
    const-string v4, "mr_sheets_main_edited"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v5, v2

    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_4
    move v0, v2

    .line 207
    goto :goto_1

    .line 208
    :cond_5
    const-string v4, "mr_sheets_new_full"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v1, v2

    invoke-direct {p0, v4, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    .line 209
    :cond_6
    const v0, 0x3ee66666    # 0.45f

    goto :goto_3

    .line 216
    :cond_7
    :goto_4
    if-ge v2, v1, :cond_2

    .line 217
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0, v2, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 216
    add-int/lit8 v2, v2, 0x1

    goto :goto_4
.end method

.method private secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;
    .locals 5

    .prologue
    .line 190
    if-eqz p2, :cond_0

    const-string v0, "mr_sheet_button_danger"

    :goto_0
    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 191
    const-string v0, "icon"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 192
    invoke-direct {p0, p4}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {v2, p0, p3, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 191
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 193
    const-string v0, "label"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {p0, p5, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 194
    return-object v1

    .line 190
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

    .line 274
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 275
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v2, "mr_sheets_menu_edit"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v4, v8, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 276
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const-string v3, "mr_sheets_menu_rename"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v9, v2, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 277
    if-lez p2, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x3

    const-string v3, "mr_sheets_menu_up"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 278
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

    .line 279
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0xc

    if-ge v0, v2, :cond_2

    .line 280
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const/16 v3, 0x8

    const-string v5, "mr_sheets_menu_duplicate"

    new-array v8, v6, [Ljava/lang/Object;

    invoke-direct {p0, v5, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v2, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 282
    :cond_2
    iget-boolean v0, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_3

    .line 283
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xc

    const-string v3, "mr_sheets_menu_restore"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 285
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x7

    const/16 v2, 0xd

    const-string v3, "mr_sheets_menu_delete"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-boolean v5, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-nez v5, :cond_4

    move v5, v4

    :goto_0
    move v4, v9

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 286
    iget-object v0, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "123"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$11;

    invoke-direct {v5, p0, p3, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$11;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;I)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v7

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 301
    return-void

    :cond_4
    move v5, v6

    .line 285
    goto :goto_0
.end method

.method private showNewSheetTemplatePicker()V
    .locals 7

    .prologue
    const/4 v1, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 340
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_1

    .line 357
    :cond_0
    :goto_0
    return-void

    .line 341
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    move v2, v3

    .line 342
    :goto_1
    if-eqz v2, :cond_4

    const/4 v0, 0x4

    :goto_2
    new-array v0, v0, [Ljava/lang/CharSequence;

    .line 343
    const-string v5, "mr_sheets_tpl_blank"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v4

    .line 344
    const-string v5, "mr_sheets_tpl_numpad"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 345
    const/4 v3, 0x2

    const-string v5, "mr_sheets_tpl_nav"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 346
    if-eqz v2, :cond_2

    const-string v2, "mr_sheets_tpl_copy"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    .line 347
    :cond_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheets_tpl_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 348
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$12;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$12;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 349
    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 355
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 356
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    :cond_3
    move v2, v4

    .line 341
    goto :goto_1

    :cond_4
    move v0, v1

    .line 342
    goto :goto_2
.end method

.method private showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 427
    const-string v0, "mr_sheets_rename_title"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v0, "mr_sheets_save"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v0, "mr_sheets_cancel"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v5, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    new-instance v6, Lcom/mrkeyboard/app/PrefScreenSheets$15;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$15;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    .line 436
    return-void
.end method

.method private slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 185
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private startExportJson()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 490
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 500
    :goto_0
    return-void

    .line 492
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 493
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 494
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 495
    const-string v1, "android.intent.extra.TITLE"

    const-string v2, "mr-keyboard-sheets.json"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 496
    const/16 v1, 0x1005

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 497
    :catch_0
    move-exception v0

    .line 498
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
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 513
    :goto_0
    return-void

    .line 505
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 506
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 507
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 508
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

    .line 509
    const/16 v1, 0x1006

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 510
    :catch_0
    move-exception v0

    .line 511
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
    .line 68
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 69
    if-nez v0, :cond_0

    .line 70
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
    .line 87
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 88
    return-void

    .line 87
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 102
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 103
    return-void
.end method

.method firstTap()Z
    .locals 6

    .prologue
    .line 92
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 93
    iget-wide v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0x2bc

    cmp-long v2, v2, v4

    if-gez v2, :cond_0

    const/4 v0, 0x0

    .line 95
    :goto_0
    return v0

    .line 94
    :cond_0
    iput-wide v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    .line 95
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    .prologue
    .line 532
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 533
    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 541
    :cond_0
    :goto_0
    return-void

    .line 534
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 535
    if-eqz v0, :cond_0

    .line 536
    const/16 v1, 0x1005

    if-ne p1, v1, :cond_2

    .line 537
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->exportTo(Landroid/net/Uri;)V

    goto :goto_0

    .line 538
    :cond_2
    const/16 v1, 0x1006

    if-ne p1, v1, :cond_0

    .line 539
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->importFrom(Landroid/net/Uri;)V

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 10

    .prologue
    const/4 v9, -0x1

    const/4 v8, -0x2

    const/high16 v7, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    .line 107
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 108
    const-string v0, "mr_sheets_screen"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v6

    .line 109
    const-string v0, "subtitle"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    .line 110
    const-string v0, "list"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    .line 111
    const-string v0, "new_btn"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    .line 114
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

    .line 115
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$1;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 120
    const-string v1, "back_slot"

    invoke-direct {p0, v6, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    const-string v0, "edit_icon"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 125
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/4 v3, 0x5

    const-string v4, "mr_ui_text3"

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v4

    const/high16 v5, 0x41900000    # 18.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-direct {v1, p0, v3, v4, v5}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 126
    const-string v0, "abc_desc"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mAbcDesc:Landroid/widget/TextView;

    .line 127
    const-string v0, "abc_card"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 128
    const-string v1, "mr_sheets_abc_edit_desc"

    new-array v3, v2, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 129
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$2;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 136
    const-string v0, "option_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSheetOpt;->row(Landroid/content/Context;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$3;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 145
    const-string v0, "io_row"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 146
    const/16 v3, 0xa

    const-string v4, "mr_ui_mint"

    const-string v5, "mr_sheets_export_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 147
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$4;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$4;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 152
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 153
    const/high16 v4, 0x41000000    # 8.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-virtual {v3, v2, v2, v4, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 154
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 155
    const/16 v3, 0xb

    const-string v4, "mr_ui_cyan"

    const-string v5, "mr_sheets_import_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 156
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$5;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$5;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 161
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 163
    const-string v0, "restore_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 164
    const/4 v2, 0x1

    const/16 v3, 0xc

    const-string v4, "mr_ui_danger"

    const-string v5, "mr_sheets_restore_all"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 165
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$6;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$6;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 170
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 172
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->setContentView(Landroid/view/View;)V

    .line 173
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 177
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 178
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 179
    invoke-static {}, Lcom/mrkeyboard/app/SheetStore;->consumeCorruptRecoveryFlag()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 180
    const-string v0, "mr_sheets_corrupt"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 182
    :cond_0
    return-void
.end method
