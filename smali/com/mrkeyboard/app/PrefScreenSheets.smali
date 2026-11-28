.class public Lcom/mrkeyboard/app/PrefScreenSheets;
.super Landroid/app/Activity;
.source "PrefScreenSheets.java"


# static fields
.field static final IMPORT_MAX_BYTES:I = 0x100000

.field private static final REQ_EXPORT_JSON:I = 0x1005

.field private static final REQ_IMPORT_JSON:I = 0x1006

.field static final TAP_GAP_MS:J = 0x2bcL


# instance fields
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

    .line 60
    const-wide/16 v0, -0x2bc

    iput-wide v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->showNewSheetTemplatePicker()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameAbcDialog(Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateAbc(Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmRestoreAbc()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    return-void
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V

    return-void
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startImportJson()V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;
    .locals 1

    .prologue
    .line 46
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/PrefScreenSheets;)Z
    .locals 1

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    return v0
.end method

.method static synthetic access$2202(Lcom/mrkeyboard/app/PrefScreenSheets;J)J
    .locals 1

    .prologue
    .line 46
    iput-wide p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    return-wide p1
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->showAbcMenu(Landroid/view/View;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 0

    .prologue
    .line 46
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method private actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;
    .locals 4

    .prologue
    .line 291
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 292
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 293
    if-eqz p4, :cond_1

    const-string v1, "mr_ui_text2"

    :goto_0
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v1

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {v2, p0, p3, v1, v3}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 292
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 294
    invoke-virtual {v0, p5}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 295
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 296
    if-nez p4, :cond_0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 297
    :cond_0
    return-object v0

    .line 293
    :cond_1
    const-string v1, "mr_ui_text_dis"

    goto :goto_0
.end method

.method private buildAbcCard()Landroid/view/View;
    .locals 12

    .prologue
    const/4 v2, 0x0

    const/4 v3, 0x1

    const/4 v11, 0x0

    .line 214
    :try_start_0
    const-string v0, "mr_sheets_main_title"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->load(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/MrAbcKeys$Model;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v6

    .line 218
    iget-object v4, v6, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 219
    const-string v0, "mr_sheet_card"

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 220
    const-string v0, "badge"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v5, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v7, "ABC"

    invoke-static {v5, v7}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 221
    const-string v0, "name"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v5, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 222
    const-string v0, "info"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const-string v5, "mr_sheets_card_info"

    const/4 v7, 0x3

    new-array v7, v7, [Ljava/lang/Object;

    iget-object v8, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v11

    .line 223
    invoke-virtual {v4}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v3

    const/4 v8, 0x2

    const-string v9, "mr_sheets_builtin"

    new-array v10, v11, [Ljava/lang/Object;

    invoke-direct {p0, v9, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    .line 222
    invoke-direct {p0, v5, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 224
    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$6;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$6;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 230
    const-string v0, "up"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/16 v5, 0x8

    invoke-virtual {v0, v5}, Landroid/view/View;->setVisibility(I)V

    .line 231
    const-string v0, "down"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 232
    new-instance v5, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/16 v7, 0xf

    const-string v8, "mr_ui_text3"

    invoke-direct {p0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v8

    const/high16 v9, 0x41a00000    # 20.0f

    invoke-direct {p0, v9}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    invoke-direct {v5, p0, v7, v8, v9}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 233
    const-string v5, "mr_sheets_abc_locked_desc"

    new-array v7, v11, [Ljava/lang/Object;

    invoke-direct {p0, v5, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 234
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 235
    invoke-virtual {v0, v11}, Landroid/widget/ImageView;->setClickable(Z)V

    .line 236
    invoke-virtual {v0}, Landroid/widget/ImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    .line 237
    if-eqz v2, :cond_0

    .line 238
    const/high16 v5, 0x42a00000    # 80.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    iput v5, v2, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 239
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 241
    :cond_0
    const-string v2, "more"

    const-string v0, "mr_sheets_options_desc"

    new-array v5, v3, [Ljava/lang/Object;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v4, v5, v11

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v0, p0

    move v4, v3

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->actionIcon(Landroid/view/View;Ljava/lang/String;IZLjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v0

    .line 242
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$7;

    invoke-direct {v2, p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets$7;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 247
    :goto_0
    return-object v1

    .line 215
    :catch_0
    move-exception v0

    move-object v1, v2

    .line 216
    goto :goto_0
.end method

.method private buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;
    .locals 9

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 251
    const-string v0, "mr_sheet_card"

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 252
    const-string v0, "badge"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v3, "123"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 253
    const-string v0, "name"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 254
    iget-boolean v0, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_2

    const-string v0, "mr_sheets_builtin"

    :goto_0
    new-array v2, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 255
    const-string v0, "info"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const-string v3, "mr_sheets_card_info"

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    .line 256
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

    .line 255
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 257
    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$8;

    invoke-direct {v0, p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$8;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 263
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

    .line 264
    if-lez p1, :cond_0

    .line 265
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$9;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$9;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 271
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge p1, v0, :cond_4

    move v4, v6

    .line 272
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

    .line 273
    if-eqz v4, :cond_1

    .line 274
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$10;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$10;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 280
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

    .line 281
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$11;

    invoke-direct {v2, p0, v0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$11;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 286
    return-object v1

    .line 254
    :cond_2
    const-string v0, "mr_sheets_custom"

    goto/16 :goto_0

    :cond_3
    move v4, v7

    .line 263
    goto :goto_1

    :cond_4
    move v4, v7

    .line 271
    goto :goto_2
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 72
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

    .line 531
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 544
    :cond_0
    :goto_0
    return-void

    .line 532
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_delete_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 533
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 534
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_delete"

    new-array v2, v4, [Ljava/lang/Object;

    .line 535
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$20;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$20;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 542
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 543
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmResetAll()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 563
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 577
    :goto_0
    return-void

    .line 564
    :cond_0
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_reset_all_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 565
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_all_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 566
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_all_ok"

    new-array v2, v3, [Ljava/lang/Object;

    .line 567
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$22;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$22;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 575
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 576
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 547
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_reset_one_title"

    new-array v2, v4, [Ljava/lang/Object;

    .line 548
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_msg"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    .line 549
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_ok"

    new-array v2, v4, [Ljava/lang/Object;

    .line 550
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$21;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$21;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 558
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 559
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 560
    return-void
.end method

.method private confirmRestoreAbc()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 381
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_abc_restore_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 382
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_abc_restore_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 383
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_reset_one_ok"

    new-array v2, v3, [Ljava/lang/Object;

    .line 384
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$15;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$15;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 391
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 392
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 393
    return-void
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 81
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    return v0
.end method

.method private duplicateAbc(Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 370
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 378
    :goto_0
    return-void

    .line 371
    :cond_0
    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 372
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    const-string v2, "copy"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 373
    iput-boolean v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 374
    const-string v1, "mr_sheets_copy_name"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    iget-object v3, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1, v4, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 376
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 377
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 421
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 429
    :goto_0
    return-void

    .line 422
    :cond_0
    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    .line 423
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    const-string v2, "copy"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 424
    iput-boolean v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 425
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

    .line 426
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    add-int/lit8 v2, p1, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 427
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 428
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private exportTo(Landroid/net/Uri;)V
    .locals 5

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 638
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->exportJsonString(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->addToBackup(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 639
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v1

    .line 640
    if-nez v1, :cond_0

    .line 641
    const-string v0, "mr_sheets_export_failed"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 654
    :goto_0
    return-void

    .line 645
    :cond_0
    :try_start_1
    const-string v2, "UTF-8"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    .line 646
    invoke-virtual {v1}, Ljava/io/OutputStream;->flush()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 648
    :try_start_2
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 650
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

    .line 651
    :catch_0
    move-exception v0

    .line 652
    const-string v0, "mr_sheets_export_failed"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 648
    :catchall_0
    move-exception v0

    :try_start_3
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V

    .line 649
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

    .line 659
    :try_start_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object v0

    .line 660
    if-nez v0, :cond_0

    .line 661
    const-string v0, "mr_sheets_import_bad"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 706
    :goto_0
    return-void

    .line 665
    :cond_0
    const/high16 v2, 0x100000

    :try_start_1
    invoke-static {v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->readCapped(Ljava/io/InputStream;I)Ljava/lang/String;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-result-object v2

    .line 667
    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 673
    if-nez v2, :cond_1

    .line 674
    const-string v0, "mr_sheets_import_too_big"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 667
    :catchall_0
    move-exception v1

    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V

    .line 668
    throw v1
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    .line 669
    :catch_0
    move-exception v0

    .line 670
    const-string v0, "mr_sheets_import_bad"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 679
    :cond_1
    :try_start_4
    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1

    move-result-object v0

    .line 683
    :goto_1
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 685
    :cond_2
    const-string v0, "mr_sheets_import_bad_file"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 680
    :catch_1
    move-exception v0

    move-object v0, v1

    .line 681
    goto :goto_1

    .line 688
    :cond_3
    new-instance v3, Landroid/app/AlertDialog$Builder;

    invoke-direct {v3, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "mr_sheets_import_title"

    new-array v5, v7, [Ljava/lang/Object;

    .line 689
    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v3

    const-string v4, "mr_sheets_import_msg"

    new-array v5, v6, [Ljava/lang/Object;

    .line 690
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

    .line 691
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v4, Lcom/mrkeyboard/app/PrefScreenSheets$23;

    invoke-direct {v4, p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets$23;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V

    invoke-virtual {v0, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v2, "mr_sheets_cancel"

    new-array v3, v7, [Ljava/lang/Object;

    .line 704
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 705
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto/16 :goto_0
.end method

.method private inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    .prologue
    .line 76
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 77
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

    .line 413
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt v2, v4, :cond_0

    .line 414
    const-string v2, "mr_sheets_limit"

    new-array v3, v0, [Ljava/lang/Object;

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v1

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {p0, v2, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 417
    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private moveSheet(II)V
    .locals 2

    .prologue
    .line 398
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

    .line 403
    :cond_0
    :goto_0
    return-void

    .line 399
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 400
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1, p2, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 402
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    goto :goto_0
.end method

.method private openEditor(Ljava/lang/String;)V
    .locals 2

    .prologue
    .line 406
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 410
    :goto_0
    return-void

    .line 407
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 408
    const-string v1, "sheet_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 409
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivity(Landroid/content/Intent;)V

    goto :goto_0
.end method

.method private pickExistingSheetToCopy()V
    .locals 9

    .prologue
    const/4 v2, 0x0

    .line 452
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 453
    if-gtz v3, :cond_0

    .line 468
    :goto_0
    return-void

    .line 454
    :cond_0
    new-array v4, v3, [Ljava/lang/CharSequence;

    move v1, v2

    .line 455
    :goto_1
    if-ge v1, v3, :cond_1

    .line 456
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 457
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

    .line 455
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 459
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheets_copy_title"

    new-array v3, v2, [Ljava/lang/Object;

    .line 460
    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$17;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$17;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 461
    invoke-virtual {v0, v4, v1}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v2, [Ljava/lang/Object;

    .line 466
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 467
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 11

    .prologue
    const/4 v2, 0x1

    const/4 v4, 0x0

    .line 474
    if-ne p1, v2, :cond_0

    .line 475
    const-string v0, "mr_sheets_default_numpad"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 476
    const-string v3, "NUM"

    .line 488
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

    new-instance v0, Lcom/mrkeyboard/app/PrefScreenSheets$18;

    move-object v1, p0

    move v4, p1

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets$18;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    move-object v4, p0

    move-object v5, v8

    move-object v8, v2

    move-object v9, v3

    move-object v10, v0

    invoke-static/range {v4 .. v10}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    .line 516
    return-void

    .line 477
    :cond_0
    const/4 v0, 0x2

    if-ne p1, v0, :cond_1

    .line 478
    const-string v0, "mr_sheets_default_nav"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 479
    const-string v3, "NAV"

    goto :goto_0

    .line 480
    :cond_1
    if-eqz p2, :cond_2

    .line 481
    const-string v0, "mr_sheets_copy_name"

    new-array v1, v2, [Ljava/lang/Object;

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v2, v1, v4

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 482
    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    goto :goto_0

    .line 484
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    .line 485
    const-string v1, "mr_sheets_default_name"

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 486
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

    .line 612
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 613
    new-array v1, v1, [B

    .line 615
    :goto_0
    invoke-virtual {p0, v1}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    .line 616
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v3

    add-int/2addr v3, v2

    if-le v3, p1, :cond_0

    const/4 v0, 0x0

    .line 619
    :goto_1
    return-object v0

    .line 617
    :cond_0
    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3, v2}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 619
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

    .line 187
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 188
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 189
    :cond_0
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

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v0, v6, :cond_3

    move v0, v1

    .line 191
    :goto_0
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    if-eqz v0, :cond_4

    const-string v1, "mr_sheets_new"

    new-array v4, v2, [Ljava/lang/Object;

    invoke-direct {p0, v1, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 192
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    if-eqz v0, :cond_5

    const/high16 v0, 0x3f800000    # 1.0f

    :goto_2
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setAlpha(F)V

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 195
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildAbcCard()Landroid/view/View;

    move-result-object v0

    .line 196
    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 197
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    .line 198
    if-nez v1, :cond_6

    .line 199
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    const-string v1, "mr_sheet_empty"

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 205
    :cond_2
    return-void

    :cond_3
    move v0, v2

    .line 190
    goto :goto_0

    .line 191
    :cond_4
    const-string v4, "mr_sheets_new_full"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v1, v2

    invoke-direct {p0, v4, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 192
    :cond_5
    const v0, 0x3ee66666    # 0.45f

    goto :goto_2

    .line 202
    :cond_6
    :goto_3
    if-ge v2, v1, :cond_2

    .line 203
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0, v2, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 202
    add-int/lit8 v2, v2, 0x1

    goto :goto_3
.end method

.method private secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;
    .locals 5

    .prologue
    .line 177
    if-eqz p2, :cond_0

    const-string v0, "mr_sheet_button_danger"

    :goto_0
    invoke-direct {p0, v0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 178
    const-string v0, "icon"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 179
    invoke-direct {p0, p4}, Lcom/mrkeyboard/app/PrefScreenSheets;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {v2, p0, p3, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 178
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 180
    const-string v0, "label"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-direct {p0, p5, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 181
    return-object v1

    .line 177
    :cond_0
    const-string v0, "mr_sheet_button"

    goto :goto_0
.end method

.method private showAbcMenu(Landroid/view/View;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 10

    .prologue
    const/16 v2, 0xc

    const/4 v9, 0x2

    const/4 v4, 0x1

    const/4 v8, 0x5

    const/4 v7, 0x0

    .line 334
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v8}, Ljava/util/ArrayList;-><init>(I)V

    .line 335
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x4

    const-string v3, "mr_sheets_menu_edit"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v4, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 336
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v1, "mr_sheets_menu_rename"

    new-array v3, v7, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v9, v8, v1}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 337
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v0, v2, :cond_0

    .line 338
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v1, 0x8

    const-string v3, "mr_sheets_menu_duplicate"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v8, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 340
    :cond_0
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x6

    const-string v3, "mr_abc_menu_restore"

    new-array v5, v7, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-static {p2}, Lcom/mrkeyboard/app/MrAbcKeys;->edited(Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z

    move-result v5

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 341
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x7

    const/16 v2, 0xd

    const-string v3, "mr_sheets_menu_delete"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v4, v9

    move v5, v7

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 342
    iget-object v0, p2, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "ABC"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v0, p2, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$13;

    invoke-direct {v5, p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$13;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v6

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 354
    return-void
.end method

.method private showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 10

    .prologue
    const/4 v8, 0x4

    const/4 v9, 0x2

    const/4 v1, 0x6

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 303
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 304
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v2, "mr_sheets_menu_edit"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v4, v8, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 305
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const-string v3, "mr_sheets_menu_rename"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v9, v2, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 306
    if-lez p2, :cond_0

    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x3

    const-string v3, "mr_sheets_menu_up"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v2, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 307
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

    .line 308
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v2, 0xc

    if-ge v0, v2, :cond_2

    .line 309
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v2, 0x5

    const/16 v3, 0x8

    const-string v5, "mr_sheets_menu_duplicate"

    new-array v8, v6, [Ljava/lang/Object;

    invoke-direct {p0, v5, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v2, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 311
    :cond_2
    iget-boolean v0, p3, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_3

    .line 312
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xc

    const-string v3, "mr_sheets_menu_restore"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 314
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

    .line 315
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

    .line 330
    return-void

    :cond_4
    move v5, v6

    .line 314
    goto :goto_0
.end method

.method private showNewSheetTemplatePicker()V
    .locals 7

    .prologue
    const/4 v1, 0x3

    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 432
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->limitReached()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_1

    .line 449
    :cond_0
    :goto_0
    return-void

    .line 433
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    move v2, v3

    .line 434
    :goto_1
    if-eqz v2, :cond_4

    const/4 v0, 0x4

    :goto_2
    new-array v0, v0, [Ljava/lang/CharSequence;

    .line 435
    const-string v5, "mr_sheets_tpl_blank"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v4

    .line 436
    const-string v5, "mr_sheets_tpl_numpad"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 437
    const/4 v3, 0x2

    const-string v5, "mr_sheets_tpl_nav"

    new-array v6, v4, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v3

    .line 438
    if-eqz v2, :cond_2

    const-string v2, "mr_sheets_tpl_copy"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    .line 439
    :cond_2
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheets_tpl_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 440
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$16;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$16;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 441
    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheets_cancel"

    new-array v2, v4, [Ljava/lang/Object;

    .line 447
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 448
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    goto :goto_0

    :cond_3
    move v2, v4

    .line 433
    goto :goto_1

    :cond_4
    move v0, v1

    .line 434
    goto :goto_2
.end method

.method private showRenameAbcDialog(Lcom/mrkeyboard/app/MrAbcKeys$Model;)V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 357
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

    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v0, p1, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    new-instance v6, Lcom/mrkeyboard/app/PrefScreenSheets$14;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$14;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/MrAbcKeys$Model;)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    .line 366
    return-void
.end method

.method private showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 519
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

    new-instance v6, Lcom/mrkeyboard/app/PrefScreenSheets$19;

    invoke-direct {v6, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$19;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    .line 528
    return-void
.end method

.method private slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;
    .locals 1

    .prologue
    .line 172
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    return-object v0
.end method

.method private startExportJson()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 582
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 592
    :goto_0
    return-void

    .line 584
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 585
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 586
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 587
    const-string v1, "android.intent.extra.TITLE"

    const-string v2, "mr-keyboard-sheets.json"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 588
    const/16 v1, 0x1005

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 589
    :catch_0
    move-exception v0

    .line 590
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

    .line 595
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->firstTap()Z

    move-result v0

    if-nez v0, :cond_0

    .line 605
    :goto_0
    return-void

    .line 597
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 598
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 599
    const-string v1, "*/*"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 600
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

    .line 601
    const/16 v1, 0x1006

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 602
    :catch_0
    move-exception v0

    .line 603
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
    .line 66
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 67
    if-nez v0, :cond_0

    .line 68
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
    .line 85
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 86
    return-void

    .line 85
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 100
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 101
    return-void
.end method

.method firstTap()Z
    .locals 6

    .prologue
    .line 90
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 91
    iget-wide v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    sub-long v2, v0, v2

    const-wide/16 v4, 0x2bc

    cmp-long v2, v2, v4

    if-gez v2, :cond_0

    const/4 v0, 0x0

    .line 93
    :goto_0
    return v0

    .line 92
    :cond_0
    iput-wide v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mLastOpen:J

    .line 93
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    .prologue
    .line 624
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 625
    const/4 v0, -0x1

    if-ne p2, v0, :cond_0

    if-nez p3, :cond_1

    .line 633
    :cond_0
    :goto_0
    return-void

    .line 626
    :cond_1
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v0

    .line 627
    if-eqz v0, :cond_0

    .line 628
    const/16 v1, 0x1005

    if-ne p1, v1, :cond_2

    .line 629
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->exportTo(Landroid/net/Uri;)V

    goto :goto_0

    .line 630
    :cond_2
    const/16 v1, 0x1006

    if-ne p1, v1, :cond_0

    .line 631
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

    .line 105
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 106
    const-string v0, "mr_sheets_screen"

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v6

    .line 107
    const-string v0, "subtitle"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    .line 108
    const-string v0, "list"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    .line 109
    const-string v0, "new_btn"

    invoke-virtual {v6, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    .line 112
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

    .line 113
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$1;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$1;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 118
    const-string v1, "back_slot"

    invoke-direct {p0, v6, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 123
    const-string v0, "option_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v0

    invoke-static {p0}, Lcom/mrkeyboard/app/MrSheetOpt;->row(Landroid/content/Context;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 125
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$2;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 132
    const-string v0, "io_row"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 133
    const/16 v3, 0xa

    const-string v4, "mr_ui_mint"

    const-string v5, "mr_sheets_export_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 134
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$3;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$3;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 139
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 140
    const/high16 v4, 0x41000000    # 8.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-virtual {v3, v2, v2, v4, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    .line 141
    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 142
    const/16 v3, 0xb

    const-string v4, "mr_ui_cyan"

    const-string v5, "mr_sheets_import_btn"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 143
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$4;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$4;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 148
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v2, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 150
    const-string v0, "restore_slot"

    invoke-direct {p0, v6, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->slot(Landroid/view/View;Ljava/lang/String;)Landroid/widget/LinearLayout;

    move-result-object v1

    .line 151
    const/4 v2, 0x1

    const/16 v3, 0xc

    const-string v4, "mr_ui_danger"

    const-string v5, "mr_sheets_restore_all"

    move-object v0, p0

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->secondaryButton(Landroid/view/ViewGroup;ZILjava/lang/String;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    .line 152
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$5;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$5;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 157
    invoke-virtual {v1, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 159
    invoke-virtual {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->setContentView(Landroid/view/View;)V

    .line 160
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 164
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 165
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 166
    invoke-static {}, Lcom/mrkeyboard/app/SheetStore;->consumeCorruptRecoveryFlag()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 167
    const-string v0, "mr_sheets_corrupt"

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->toast(Ljava/lang/String;Z)V

    .line 169
    :cond_0
    return-void
.end method
