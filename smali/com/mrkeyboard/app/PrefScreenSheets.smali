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
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private mSubtitleView:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 26
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;)V
    .registers 2

    .line 26
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showHeaderMenu(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->showNewSheetTemplatePicker()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 2

    .line 26
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 3

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/PrefScreenSheets;)Ljava/util/ArrayList;
    .registers 1

    .line 26
    iget-object p0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    return-object p0
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->pickExistingSheetToCopy()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 3

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startExportJson()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startImportJson()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/PrefScreenSheets;)V
    .registers 1

    .line 26
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->confirmResetAll()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;)V
    .registers 2

    .line 26
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->openEditor(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/PrefScreenSheets;II)V
    .registers 3

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->moveSheet(II)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 4

    .line 26
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets;->showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 2

    .line 26
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets;->showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/PrefScreenSheets;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 3

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    return-void
.end method

.method private buildFixedAbcCard(Z)Landroid/view/View;
    .registers 13

    .line 203
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 204
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 205
    const/16 v2, 0x10

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 206
    const/high16 v2, 0x41600000    # 14.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    const/high16 v4, 0x41400000    # 12.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-virtual {v0, v3, v5, v2, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 207
    const/high16 v2, 0x41800000    # 16.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v2

    const/high16 v3, 0x3f800000    # 1.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    const/4 v6, 0x1

    invoke-static {v6, v5}, Ljava/lang/Math;->max(II)I

    move-result v5

    const v7, -0xe5dacb

    const v8, -0xf5efe8

    invoke-static {v8, v2, v5, v7}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 209
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 210
    const-string v5, "ABC"

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 211
    const v5, -0x6c5c46

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 212
    sget-object v5, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 213
    const/high16 v5, 0x41480000    # 12.5f

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setTextSize(F)V

    .line 214
    const/16 v5, 0x11

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setGravity(I)V

    .line 215
    const/high16 v5, 0x42400000    # 48.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 216
    const/high16 v5, 0x41200000    # 10.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v7

    const/high16 v8, 0x40c00000    # 6.0f

    invoke-direct {p0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-direct {p0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    invoke-virtual {v2, v7, v9, v5, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 217
    const/high16 v5, 0x41000000    # 8.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v7

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    invoke-static {v6, v8}, Ljava/lang/Math;->max(II)I

    move-result v8

    const v9, -0xd5c4ac

    const v10, -0xf0e9df

    invoke-static {v10, v7, v8, v9}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v2, v7}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 218
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 220
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 221
    invoke-virtual {v2, v6}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 222
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-virtual {v2, v6, v1, v5, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 224
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 225
    if-eqz p1, :cond_bd

    const-string v6, "Teclado principal (fixo)"

    invoke-static/range {v6 .. v6}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_bf

    :cond_bd
    const-string v6, "Main keyboard (fixed)"

    :goto_bf
    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 226
    const v6, -0x160f07

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 227
    const/high16 v6, 0x41700000    # 15.0f

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 228
    sget-object v6, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 229
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 231
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 232
    if-eqz p1, :cond_df

    const-string p1, "Layout alfab\u00e9tico padr\u00e3o do idioma ativo"

    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_e1

    :cond_df
    const-string p1, "Standard alphabetic layout for the active language"

    :goto_e1
    invoke-virtual {v5, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 233
    const p1, -0x907f67

    invoke-virtual {v5, p1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 234
    invoke-virtual {v5, v4}, Landroid/widget/TextView;->setTextSize(F)V

    .line 235
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 237
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v5, -0x2

    invoke-direct {v4, v1, v5, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 239
    new-instance v1, Landroid/widget/ImageView;

    invoke-direct {v1, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 240
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    const/16 v4, 0xf

    const p1, -0x674f32

    invoke-direct {v2, p0, v4, p1, v3}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 241
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v2, 0x41c00000    # 24.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    invoke-direct {p1, v3, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 242
    return-object v0
.end method

.method private buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;Z)Landroid/view/View;
    .registers 15

    .line 246
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 247
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 248
    const/16 v2, 0x10

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 249
    const/high16 v2, 0x41600000    # 14.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    const/high16 v3, 0x41400000    # 12.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    const/high16 v5, 0x40c00000    # 6.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v7

    invoke-virtual {v0, v2, v4, v6, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 250
    nop

    .line 252
    const/high16 v2, 0x41800000    # 16.0f

    invoke-static {p0, v2}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v2

    .line 253
    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    const/4 v7, 0x1

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 250
    const v8, -0xf0e9df

    const v9, -0xe5dacb

    const v10, 0x3329c5f6

    invoke-static {v8, v2, v6, v9, v10}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 257
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/4 v8, -0x2

    invoke-direct {v2, v6, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 258
    const/high16 v6, 0x41000000    # 8.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    iput v9, v2, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 259
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 261
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 262
    iget-object v9, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v10, "123"

    invoke-static {v9, v10}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 263
    const v9, -0xd63a0a

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setTextColor(I)V

    .line 264
    sget-object v9, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 265
    const/16 v9, 0x11

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setGravity(I)V

    .line 266
    const/high16 v9, 0x42400000    # 48.0f

    invoke-direct {p0, v9}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setMinWidth(I)V

    .line 267
    const/high16 v9, 0x41480000    # 12.5f

    invoke-virtual {v2, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 268
    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-virtual {v2, v9, v10, v6, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 269
    nop

    .line 271
    const/high16 v5, 0x41100000    # 9.0f

    invoke-static {p0, v5}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v5

    .line 272
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 269
    const v9, -0xfbefd8

    const v10, 0x4d29c5f6    # 1.78020192E8f

    invoke-static {v9, v5, v6, v10}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 275
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 277
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 278
    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 279
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    const/high16 v6, 0x40800000    # 4.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-virtual {v2, v5, v1, v6, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 281
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 282
    iget-object v6, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 283
    const v6, -0x160f07

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextColor(I)V

    .line 284
    const/high16 v6, 0x41780000    # 15.5f

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 285
    sget-object v6, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 286
    invoke-virtual {v5, v7}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 287
    sget-object v6, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v5, v6}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 288
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 290
    iget-boolean v5, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v5, :cond_101

    if-eqz p3, :cond_fe

    const-string v5, "Padr\u00e3o"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_108

    :cond_fe
    const-string v5, "Built-in"

    goto :goto_108

    :cond_101
    if-eqz p3, :cond_106

    const-string v5, "Personalizada"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_108

    :cond_106
    const-string v5, "Custom"

    .line 291
    :goto_108
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v9, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v9}, Ljava/util/ArrayList;->size()I

    move-result v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 292
    if-eqz p3, :cond_11c

    const-string v9, " fileiras \u2022 "

    invoke-static/range {v9 .. v9}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    goto :goto_11e

    :cond_11c
    const-string v9, " rows \u2022 "

    :goto_11e
    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 293
    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v9

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 294
    if-eqz p3, :cond_12f

    const-string p3, " teclas \u2022 "

    invoke-static/range {p3 .. p3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    goto :goto_131

    :cond_12f
    const-string p3, " keys \u2022 "

    :goto_131
    invoke-virtual {v6, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    .line 296
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 297
    invoke-virtual {v5, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 298
    const p3, -0x6c5c46

    invoke-virtual {v5, p3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 299
    invoke-virtual {v5, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 300
    invoke-virtual {v5, v7}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 301
    sget-object p3, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v5, p3}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 302
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 304
    new-instance p3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p3, v1, v8, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v0, v2, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 305
    new-instance p3, Lcom/mrkeyboard/app/PrefScreenSheets$7;

    invoke-direct {p3, p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$7;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v0, p3}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 312
    if-lez p1, :cond_16d

    move p3, v7

    goto :goto_16e

    :cond_16d
    move p3, v1

    .line 313
    :goto_16e
    const/4 v2, 0x6

    invoke-direct {p0, v2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeCardActionIcon(IZ)Landroid/widget/ImageView;

    move-result-object v2

    .line 314
    if-eqz p3, :cond_17d

    .line 315
    new-instance p3, Lcom/mrkeyboard/app/PrefScreenSheets$8;

    invoke-direct {p3, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$8;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {v2, p3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 322
    :cond_17d
    new-instance p3, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v3, 0x42080000    # 34.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    const/high16 v5, 0x42100000    # 36.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-direct {p3, v4, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2, p3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 324
    iget-object p3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result p3

    sub-int/2addr p3, v7

    if-ge p1, p3, :cond_19b

    move v1, v7

    .line 325
    :cond_19b
    const/4 p3, 0x7

    invoke-direct {p0, p3, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeCardActionIcon(IZ)Landroid/widget/ImageView;

    move-result-object p3

    .line 326
    if-eqz v1, :cond_1aa

    .line 327
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$9;

    invoke-direct {v1, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$9;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {p3, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 334
    :cond_1aa
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {v1, v2, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 336
    invoke-direct {p0, v7, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeCardActionIcon(IZ)Landroid/widget/ImageView;

    move-result-object p3

    .line 337
    new-instance v1, Lcom/mrkeyboard/app/PrefScreenSheets$10;

    invoke-direct {v1, p0, p3, p1, p2}, Lcom/mrkeyboard/app/PrefScreenSheets$10;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {p3, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 343
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result p2

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v1

    invoke-direct {p1, p2, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, p3, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 344
    return-object v0
.end method

.method private confirmDeleteSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 7

    .line 508
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 509
    if-ltz p1, :cond_ret_oob

    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p1, v1, :cond_ret_oob

    goto :goto_1d

    :cond_ret_oob
    return-void

    .line 513
    :goto_1d
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 514
    if-eqz v0, :cond_27

    const-string v2, "Excluir folha?"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_29

    :cond_27
    const-string v2, "Delete sheet?"

    :goto_29
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 515
    if-eqz v0, :cond_37

    const-string v3, "Tem certeza que deseja excluir \""

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_39

    :cond_37
    const-string v3, "Are you sure you want to delete \""

    :goto_39
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object p2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v2, "\"?"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p2

    .line 516
    if-eqz v0, :cond_56

    const-string v1, "Excluir"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_58

    :cond_56
    const-string v1, "Delete"

    :goto_58
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$13;

    invoke-direct {v2, p0, p1}, Lcom/mrkeyboard/app/PrefScreenSheets$13;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;I)V

    invoke-virtual {p2, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 524
    if-eqz v0, :cond_66

    const-string p2, "Cancelar"

    invoke-static/range {p2 .. p2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_68

    :cond_66
    const-string p2, "Cancel"

    :goto_68
    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 525
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 526
    return-void
.end method

.method private confirmResetAll()V
    .registers 5

    .line 547
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 548
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 549
    if-eqz v0, :cond_e

    const-string v2, "Restaurar todas as folhas?"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_10

    :cond_e
    const-string v2, "Restore all sheets?"

    :goto_10
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 550
    if-eqz v0, :cond_19

    .line 551
    const-string v2, "Isso restaurar\u00e1 as 4 folhas originais (123, TSK, HTML, FRS) e remover\u00e1 folhas personalizadas. Dica: voc\u00ea pode exportar um backup JSON antes."

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1b

    .line 552
    :cond_19
    const-string v2, "This will restore the 4 built-in sheets (123, TSK, HTML, FRS) and remove custom sheets."

    .line 550
    :goto_1b
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 553
    if-eqz v0, :cond_24

    const-string v2, "Restaurar tudo"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_26

    :cond_24
    const-string v2, "Restore all"

    :goto_26
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$15;

    invoke-direct {v3, p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$15;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Z)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 562
    if-eqz v0, :cond_34

    const-string v0, "Cancelar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_36

    :cond_34
    const-string v0, "Cancel"

    :goto_36
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 563
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 564
    return-void
.end method

.method private confirmResetSingleBuiltin(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 6

    .line 529
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 530
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 531
    if-eqz v0, :cond_e

    const-string v2, "Restaurar folha padr\u00e3o?"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_10

    :cond_e
    const-string v2, "Restore default sheet?"

    :goto_10
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 532
    if-eqz v0, :cond_1e

    const-string v3, "Restaurar \""

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_20

    :cond_1e
    const-string v3, "Restore \""

    :goto_20
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v0, :cond_2f

    const-string v3, "\" ao layout original?"

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_31

    :cond_2f
    const-string v3, "\" to its original layout?"

    :goto_31
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 533
    if-eqz v0, :cond_42

    const-string v2, "Restaurar"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_44

    :cond_42
    const-string v2, "Restore"

    :goto_44
    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$14;

    invoke-direct {v3, p0, p1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$14;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;Z)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 542
    if-eqz v0, :cond_52

    const-string v0, "Cancelar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_54

    :cond_52
    const-string v0, "Cancel"

    :goto_54
    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 543
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 544
    return-void
.end method

.method private dp(F)I
    .registers 2

    .line 41
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    return p1
.end method

.method private duplicateSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 8

    .line 487
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 488
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/16 v2, 0xc

    const/4 v3, 0x0

    if-lt v1, v2, :cond_1e

    .line 489
    if-eqz v0, :cond_14

    const-string p1, "Limite m\u00e1ximo de 12 folhas atingido."

    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_16

    :cond_14
    const-string p1, "Maximum of 12 sheets reached."

    :goto_16
    invoke-static {p0, p1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 490
    return-void

    .line 492
    :cond_1e
    invoke-virtual {p2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    .line 493
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    const-string v4, "copy"

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 494
    iput-boolean v3, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 495
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    if-eqz v0, :cond_3e

    const-string v0, " (c\u00f3pia)"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_40

    :cond_3e
    const-string v0, " (copy)"

    :goto_40
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object p2, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v0, p2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 496
    iget-object p2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    add-int/lit8 p1, p1, 0x1

    invoke-virtual {p2, p1, v1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 497
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 498
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 499
    return-void
.end method

.method private makeCardActionIcon(IZ)Landroid/widget/ImageView;
    .registers 8

    .line 348
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 349
    if-eqz p2, :cond_b

    const v1, -0x6c5c46

    goto :goto_e

    :cond_b
    const v1, -0xc5b6a2

    .line 350
    :goto_e
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/high16 v3, 0x41900000    # 18.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {v2, p0, p1, v1, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 351
    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 352
    invoke-virtual {v0, p2}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 353
    if-eqz p2, :cond_30

    .line 354
    const p1, 0x3329c5f6

    invoke-static {p0, p1, v3}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 356
    :cond_30
    return-object v0
.end method

.method private makeSecondaryButton(IILjava/lang/String;Z)Landroid/view/View;
    .registers 12

    .line 360
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 361
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 362
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 363
    const/high16 v1, 0x41400000    # 12.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v1

    invoke-virtual {v0, v2, v3, v4, v1}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 364
    const/high16 v1, 0x41600000    # 14.0f

    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v1

    .line 365
    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    const/4 v3, 0x1

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 366
    const v4, -0xf0e9df

    if-eqz p4, :cond_47

    .line 367
    const v5, 0x4dfb7185    # 5.27315104E8f

    const v6, 0x24fb7185

    invoke-static {v4, v1, v2, v5, v6}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_54

    .line 369
    :cond_47
    const v5, -0xd5c4ac

    const v6, 0x3329c5f6

    invoke-static {v4, v1, v2, v5, v6}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 372
    :goto_54
    new-instance v1, Landroid/widget/ImageView;

    invoke-direct {v1, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 373
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-direct {v2, p0, p1, p2, v5}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 374
    new-instance p1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result p2

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v2

    invoke-direct {p1, p2, v2}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 375
    const/high16 p2, 0x41000000    # 8.0f

    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result p2

    iput p2, p1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 376
    invoke-virtual {v0, v1, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 378
    new-instance p1, Landroid/widget/TextView;

    invoke-direct {p1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 379
    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 380
    const/high16 p2, 0x41500000    # 13.0f

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextSize(F)V

    .line 381
    sget-object p2, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 382
    if-eqz p4, :cond_97

    const p2, -0x48e7b

    goto :goto_9a

    :cond_97
    const p2, -0x160f07

    :goto_9a
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 383
    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 384
    invoke-virtual {v0, p1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 385
    return-object v0
.end method

.method private moveSheet(II)V
    .registers 4

    .line 478
    if-ltz p1, :cond_29

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_29

    if-ltz p2, :cond_29

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p2, v0, :cond_29

    .line 479
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 480
    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v0, p2, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 481
    iget-object p1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 482
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 484
    :cond_29
    return-void
.end method

.method private openEditor(Ljava/lang/String;)V
    .registers 4

    .line 502
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/mrkeyboard/app/SheetEditorActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 503
    const-string v1, "sheet_id"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 504
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivity(Landroid/content/Intent;)V

    .line 505
    return-void
.end method

.method private pickExistingSheetToCopy()V
    .registers 7

    .line 595
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 596
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-gtz v1, :cond_has_copy_src

    return-void

    :cond_has_copy_src
    new-array v1, v1, [Ljava/lang/CharSequence;

    .line 597
    const/4 v2, 0x0

    :goto_d
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_43

    .line 598
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 599
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "] "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v2

    .line 597
    add-int/lit8 v2, v2, 0x1

    goto :goto_d

    .line 601
    :cond_43
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 602
    if-eqz v0, :cond_4d

    const-string v3, "Copiar teclas de qual folha?"

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_4f

    :cond_4d
    const-string v3, "Copy keys from which sheet?"

    :goto_4f
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$17;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$17;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 603
    invoke-virtual {v2, v1, v3}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 609
    if-eqz v0, :cond_61

    const-string v0, "Cancelar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_63

    :cond_61
    const-string v0, "Cancel"

    :goto_63
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 610
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 611
    return-void
.end method

.method private promptNameForNewSheet(ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 16

    .line 614
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 617
    const/4 v1, 0x1

    if-ne p1, v1, :cond_13

    .line 618
    if-eqz v0, :cond_c

    const-string v2, "Num\u00e9rico"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_e

    :cond_c
    const-string v2, "Numpad"

    .line 619
    :goto_e
    const-string v3, "NUM"

    move-object v7, v2

    move-object v9, v3

    goto :goto_72

    .line 620
    :cond_13
    const/4 v2, 0x2

    if-ne p1, v2, :cond_22

    .line 621
    if-eqz v0, :cond_1b

    const-string v2, "Navega\u00e7\u00e3o"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1d

    :cond_1b
    const-string v2, "Nav"

    .line 622
    :goto_1d
    const-string v3, "NAV"

    move-object v7, v2

    move-object v9, v3

    goto :goto_72

    .line 623
    :cond_22
    if-eqz p2, :cond_3e

    .line 624
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, " 2"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 625
    iget-object v3, p2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    move-object v7, v2

    move-object v9, v3

    goto :goto_72

    .line 627
    :cond_3e
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    add-int/2addr v2, v1

    .line 628
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v0, :cond_4f

    const-string v4, "Folha "

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_51

    :cond_4f
    const-string v4, "Sheet "

    :goto_51
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 629
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "F"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v9, v2

    move-object v7, v3

    .line 632
    :goto_72
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 633
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 634
    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    .line 635
    const/high16 v4, 0x41400000    # 12.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    const/high16 v6, 0x40800000    # 4.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-virtual {v2, v3, v5, v3, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 637
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 638
    if-eqz v0, :cond_99

    const-string v5, "Nome da folha:"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_9b

    :cond_99
    const-string v5, "Sheet name:"

    :goto_9b
    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 639
    const v5, -0x6c5c46

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 640
    const/high16 v6, 0x41480000    # 12.5f

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 641
    sget-object v8, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v3, v8}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 642
    const/high16 v8, 0x40c00000    # 6.0f

    invoke-direct {p0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    const/4 v11, 0x0

    invoke-virtual {v3, v11, v11, v11, v10}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 643
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 645
    invoke-static {p0, v7, v1}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v3

    .line 646
    invoke-virtual {v3, v7}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 647
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 649
    new-instance v10, Landroid/widget/TextView;

    invoke-direct {v10, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 650
    if-eqz v0, :cond_cf

    const-string v12, "Selo curto no bot\u00e3o (1 a 5 caracteres):"

    invoke-static/range {v12 .. v12}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    goto :goto_d1

    :cond_cf
    const-string v12, "Short button badge (1\u20135 chars):"

    :goto_d1
    invoke-virtual {v10, v12}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 651
    invoke-virtual {v10, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 652
    invoke-virtual {v10, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 653
    sget-object v5, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v10, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 654
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {p0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-virtual {v10, v11, v4, v11, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 655
    invoke-virtual {v2, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 657
    invoke-static {p0, v9, v1}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v8

    .line 658
    new-array v1, v1, [Landroid/text/InputFilter;

    new-instance v4, Landroid/text/InputFilter$LengthFilter;

    const/4 v5, 0x5

    invoke-direct {v4, v5}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v4, v1, v11

    invoke-virtual {v8, v1}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    .line 659
    invoke-virtual {v8, v9}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 660
    invoke-virtual {v2, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 662
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 663
    if-eqz v0, :cond_10e

    const-string v4, "Nova folha"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_110

    :cond_10e
    const-string v4, "New sheet"

    :goto_110
    invoke-virtual {v1, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 664
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 665
    if-eqz v0, :cond_11d

    const-string v2, "Criar e editar"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_11f

    :cond_11d
    const-string v2, "Create & edit"

    :goto_11f
    new-instance v12, Lcom/mrkeyboard/app/PrefScreenSheets$18;

    move-object v4, v12

    move-object v5, p0

    move-object v6, v3

    move v10, p1

    move-object v11, p2

    invoke-direct/range {v4 .. v11}, Lcom/mrkeyboard/app/PrefScreenSheets$18;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/EditText;Ljava/lang/String;Landroid/widget/EditText;Ljava/lang/String;ILcom/mrkeyboard/app/SheetModel$Sheet;)V

    invoke-virtual {v1, v2, v12}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 691
    if-eqz v0, :cond_132

    const-string p2, "Cancelar"

    invoke-static/range {p2 .. p2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_134

    :cond_132
    const-string p2, "Cancel"

    :goto_134
    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 692
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 693
    return-void
.end method

.method private reloadAndRender()V
    .registers 6

    .line 466
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 467
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    .line 468
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0xc

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 469
    if-eqz v0, :cond_2c

    const-string v4, " folhas \u2022 Toque para editar teclas"

    invoke-static/range {v4 .. v4}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    goto :goto_2e

    :cond_2c
    const-string v4, " sheets \u2022 Tap to edit keys"

    :goto_2e
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 468
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 470
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v2, v3, :cond_46

    const/high16 v2, 0x3f800000    # 1.0f

    goto :goto_49

    :cond_46
    const v2, 0x3ee66666    # 0.45f

    :goto_49
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setAlpha(F)V

    .line 471
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 472
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-nez v1, :cond_render_cards

    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    if-eqz v0, :cond_empty_en

    const-string v0, "Nenhuma folha ativa (apenas o teclado principal ABC).\nToque em \"+ Nova folha\" ou em \u22ee \u2192 \"Restaurar todas para o padr\u00e3o\"."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_empty_txt

    :cond_empty_en
    const-string v0, "No active sheets (main ABC keyboard only).\nTap \"+ New sheet\" or \u22ee \u2192 \"Restore all to default\"."

    :goto_empty_txt
    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v0, -0x907f67

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v0, 0x41500000    # 13.0f

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTextSize(F)V

    const/16 v0, 0x11

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setGravity(I)V

    const/high16 v0, 0x41800000    # 16.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v0

    invoke-virtual {v1, v0, v0, v0, v0}, Landroid/widget/TextView;->setPadding(IIII)V

    iget-object v0, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-void

    :cond_render_cards
    const/4 v2, 0x0

    :goto_58
    if-ge v2, v1, :cond_6e

    .line 473
    iget-object v3, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    iget-object v4, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-direct {p0, v2, v4, v0}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildSheetCard(ILcom/mrkeyboard/app/SheetModel$Sheet;Z)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 472
    add-int/lit8 v2, v2, 0x1

    goto :goto_58

    .line 475
    :cond_6e
    return-void
.end method

.method private showCardContextMenu(Landroid/view/View;ILcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 23

    .line 389
    move-object/from16 v6, p0

    move/from16 v0, p2

    move-object/from16 v1, p3

    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v2

    .line 390
    new-instance v4, Ljava/util/ArrayList;

    const/4 v3, 0x6

    invoke-direct {v4, v3}, Ljava/util/ArrayList;-><init>(I)V

    .line 391
    new-instance v5, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_17

    const-string v7, "Editar teclas"

    invoke-static/range {v7 .. v7}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_19

    :cond_17
    const-string v7, "Edit keys"

    :goto_19
    const/4 v8, 0x1

    const/4 v9, 0x4

    invoke-direct {v5, v8, v9, v7}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 392
    new-instance v5, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_28

    const-string v7, "Renomear nome e selo"

    invoke-static/range {v7 .. v7}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_2a

    :cond_28
    const-string v7, "Rename name & badge"

    :goto_2a
    const/4 v10, 0x2

    const/4 v11, 0x5

    invoke-direct {v5, v10, v11, v7}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 393
    if-lez v0, :cond_44

    .line 394
    new-instance v5, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_3b

    const-string v7, "Mover para cima"

    invoke-static/range {v7 .. v7}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_3d

    :cond_3b
    const-string v7, "Move up"

    :goto_3d
    const/4 v10, 0x3

    invoke-direct {v5, v10, v3, v7}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 396
    :cond_44
    iget-object v3, v6, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    sub-int/2addr v3, v8

    if-ge v0, v3, :cond_5d

    .line 397
    new-instance v3, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_54

    const-string v5, "Mover para baixo"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_56

    :cond_54
    const-string v5, "Move down"

    :goto_56
    const/4 v7, 0x7

    invoke-direct {v3, v9, v7, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 399
    :cond_5d
    new-instance v3, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_64

    const-string v5, "Duplicar folha"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_66

    :cond_64
    const-string v5, "Duplicate sheet"

    :goto_66
    const/16 v7, 0x8

    invoke-direct {v3, v11, v7, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 400
    iget-boolean v3, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v3, :cond_89

    .line 401
    new-instance v3, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_79

    const-string v10, "Restaurar padr\u00e3o"

    invoke-static/range {v10 .. v10}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    goto :goto_7b

    :cond_79
    const-string v10, "Restore default"

    :goto_7b
    const/4 v11, 0x1

    const/4 v12, 0x1

    const/4 v8, 0x6

    const/16 v9, 0xc

    move-object v7, v3

    invoke-direct/range {v7 .. v12}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 403
    :cond_89
    new-instance v3, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v2, :cond_90

    const-string v2, "Excluir folha"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_92

    :cond_90
    const-string v2, "Delete sheet"

    :goto_92
    move-object/from16 v16, v2

    const/16 v17, 0x2

    iget-boolean v2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    xor-int/lit8 v18, v2, 0x1

    const/4 v14, 0x7

    const/16 v15, 0xd

    move-object v13, v3

    invoke-direct/range {v13 .. v18}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 406
    :goto_a2
    iget-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v3, "123"

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 407
    iget-object v3, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$11;

    invoke-direct {v5, v6, v1, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$11;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;I)V

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 435
    return-void
.end method

.method private showHeaderMenu(Landroid/view/View;)V
    .registers 14

    .line 438
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 439
    new-instance v5, Ljava/util/ArrayList;

    const/4 v1, 0x3

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 440
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_11

    const-string v2, "Exportar folhas (JSON)"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_13

    :cond_11
    const-string v2, "Export sheets (JSON)"

    :goto_13
    const/4 v3, 0x1

    const/16 v4, 0xa

    invoke-direct {v1, v3, v4, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 441
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_23

    const-string v2, "Importar folhas (JSON)"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_25

    :cond_23
    const-string v2, "Import sheets (JSON)"

    :goto_25
    const/4 v3, 0x2

    const/16 v4, 0xb

    invoke-direct {v1, v3, v4, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 442
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_35

    const-string v2, "Restaurar todas para o padr\u00e3o"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_37

    :cond_35
    const-string v2, "Restore all to default"

    :goto_37
    move-object v9, v2

    const/4 v10, 0x1

    const/4 v11, 0x1

    const/4 v7, 0x3

    const/16 v8, 0xc

    move-object v6, v1

    invoke-direct/range {v6 .. v11}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 444
    nop

    .line 448
    if-eqz v0, :cond_4a

    const-string v0, "Backup e restaura\u00e7\u00e3o"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_4c

    :cond_4a
    const-string v0, "Backup & restore"

    :goto_4c
    move-object v4, v0

    new-instance v6, Lcom/mrkeyboard/app/PrefScreenSheets$12;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$12;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 444
    const-string v3, "JSON"

    move-object v1, p0

    move-object v2, p1

    invoke-static/range {v1 .. v6}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 463
    return-void
.end method

.method private showNewSheetTemplatePicker()V
    .registers 5

    .line 567
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 568
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/16 v2, 0xc

    const/4 v3, 0x0

    if-lt v1, v2, :cond_1e

    .line 569
    if-eqz v0, :cond_14

    const-string v0, "Limite m\u00e1ximo de 12 folhas atingido."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_16

    :cond_14
    const-string v0, "Maximum of 12 sheets reached."

    :goto_16
    invoke-static {p0, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 570
    return-void

    .line 572
    :cond_1e
    iget-object v1, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_four_tpl

    const/4 v1, 0x3

    goto :goto_alloc_tpl

    :cond_four_tpl
    const/4 v1, 0x4

    :goto_alloc_tpl
    new-array v1, v1, [Ljava/lang/CharSequence;

    .line 573
    if-eqz v0, :cond_26

    const-string v2, "Em branco (3 fileiras vazias)"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_28

    :cond_26
    const-string v2, "Blank (3 empty rows)"

    :goto_28
    aput-object v2, v1, v3

    .line 574
    if-eqz v0, :cond_2f

    const-string v2, "Teclado num\u00e9rico (Numpad)"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_31

    :cond_2f
    const-string v2, "Numeric keypad (Numpad)"

    :goto_31
    const/4 v3, 0x1

    aput-object v2, v1, v3

    .line 575
    if-eqz v0, :cond_39

    const-string v2, "Setas + Edi\u00e7\u00e3o (Home/End/PgUp/PgDn/Tab/Esc)"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_3b

    :cond_39
    const-string v2, "Arrows + Editing (Home/End/PgUp/PgDn/Tab/Esc)"

    :goto_3b
    const/4 v3, 0x2

    aput-object v2, v1, v3

    .line 576
    iget-object v2, p0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSheets:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_skip_copy_tpl

    if-eqz v0, :cond_43

    const-string v2, "Copiar de folha existente..."

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_45

    :cond_43
    const-string v2, "Copy from existing sheet..."

    :goto_45
    const/4 v3, 0x3

    aput-object v2, v1, v3

    :cond_skip_copy_tpl

    .line 578
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 579
    if-eqz v0, :cond_52

    const-string v3, "Modelo da nova folha"

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_54

    :cond_52
    const-string v3, "New sheet template"

    :goto_54
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/PrefScreenSheets$16;

    invoke-direct {v3, p0}, Lcom/mrkeyboard/app/PrefScreenSheets$16;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    .line 580
    invoke-virtual {v2, v1, v3}, Landroid/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 590
    if-eqz v0, :cond_66

    const-string v0, "Cancelar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_68

    :cond_66
    const-string v0, "Cancel"

    :goto_68
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 591
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 592
    return-void
.end method

.method private showRenameSheetDialog(Lcom/mrkeyboard/app/SheetModel$Sheet;)V
    .registers 13

    .line 696
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 697
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 698
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 699
    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v3

    .line 700
    const/high16 v4, 0x41400000    # 12.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    const/high16 v6, 0x40800000    # 4.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    invoke-virtual {v1, v3, v5, v3, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 702
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 703
    if-eqz v0, :cond_2c

    const-string v5, "Nome da folha:"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_2e

    :cond_2c
    const-string v5, "Sheet name:"

    :goto_2e
    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 704
    const v5, -0x6c5c46

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 705
    const/high16 v6, 0x41480000    # 12.5f

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 706
    sget-object v7, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 707
    const/high16 v7, 0x40c00000    # 6.0f

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    const/4 v9, 0x0

    invoke-virtual {v3, v9, v9, v9, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 708
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 710
    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p0, v3, v2}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v3

    .line 711
    iget-object v8, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v3, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 712
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 714
    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 715
    if-eqz v0, :cond_66

    const-string v10, "Selo curto no bot\u00e3o (at\u00e9 5 caracteres):"

    invoke-static/range {v10 .. v10}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    goto :goto_68

    :cond_66
    const-string v10, "Short button badge (up to 5 chars):"

    :goto_68
    invoke-virtual {v8, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 716
    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 717
    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 718
    sget-object v5, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 719
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v5

    invoke-virtual {v8, v9, v4, v9, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 720
    invoke-virtual {v1, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 722
    iget-object v4, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p0, v4, v2}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v4

    .line 723
    new-array v2, v2, [Landroid/text/InputFilter;

    new-instance v5, Landroid/text/InputFilter$LengthFilter;

    const/4 v6, 0x5

    invoke-direct {v5, v6}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v5, v2, v9

    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    .line 724
    iget-object v2, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 725
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 727
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 728
    if-eqz v0, :cond_a9

    const-string v5, "Renomear folha"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_ab

    :cond_a9
    const-string v5, "Rename sheet"

    :goto_ab
    invoke-virtual {v2, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 729
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 730
    if-eqz v0, :cond_b8

    const-string v2, "Salvar"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_ba

    :cond_b8
    const-string v2, "Save"

    :goto_ba
    new-instance v5, Lcom/mrkeyboard/app/PrefScreenSheets$19;

    invoke-direct {v5, p0, p1, v3, v4}, Lcom/mrkeyboard/app/PrefScreenSheets$19;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Lcom/mrkeyboard/app/SheetModel$Sheet;Landroid/widget/EditText;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 739
    if-eqz v0, :cond_c8

    const-string v0, "Cancelar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_ca

    :cond_c8
    const-string v0, "Cancel"

    :goto_ca
    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 740
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 741
    return-void
.end method

.method private startExportJson()V
    .registers 4

    .line 745
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.CREATE_DOCUMENT"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 746
    const-string v1, "android.intent.category.OPENABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 747
    const-string v1, "application/json"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 748
    const-string v1, "android.intent.extra.TITLE"

    const-string v2, "mr-keyboard-sheets.json"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 749
    const/16 v1, 0x1005

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_1d
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_1d} :catch_1e

    .line 752
    goto :goto_2f

    .line 750
    :catch_1e
    move-exception v0

    .line 751
    const-string v0, "N\u00e3o foi poss\u00edvel abrir o seletor de arquivos."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Could not open file picker."

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/SheetStrings;->tr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 753
    :goto_2f
    return-void
.end method

.method private startImportJson()V
    .registers 7

    .line 757
    const/4 v0, 0x0

    :try_start_1
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.OPEN_DOCUMENT"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 758
    const-string v2, "android.intent.category.OPENABLE"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 759
    const-string v2, "*/*"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 760
    const-string v2, "android.intent.extra.MIME_TYPES"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/String;

    const-string v4, "application/json"

    aput-object v4, v3, v0

    const-string v4, "text/plain"

    const/4 v5, 0x1

    aput-object v4, v3, v5

    const-string v4, "application/octet-stream"

    const/4 v5, 0x2

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[Ljava/lang/String;)Landroid/content/Intent;

    .line 761
    const/16 v2, 0x1006

    invoke-virtual {p0, v1, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_2d
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_2d} :catch_2e

    .line 764
    goto :goto_3e

    .line 762
    :catch_2e
    move-exception v1

    .line 763
    const-string v1, "N\u00e3o foi poss\u00edvel abrir o seletor de arquivos."

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Could not open file picker."

    invoke-static {p0, v1, v2}, Lcom/mrkeyboard/app/SheetStrings;->tr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 765
    :goto_3e
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .registers 2

    .line 37
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object p1

    invoke-super {p0, p1}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 38
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .registers 8

    .line 769
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V

    .line 770
    const/4 v0, -0x1

    if-ne p2, v0, :cond_117

    if-eqz p3, :cond_117

    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    if-nez p2, :cond_10

    goto/16 :goto_117

    .line 773
    :cond_10
    invoke-virtual {p3}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object p2

    .line 774
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result p3

    .line 776
    const/16 v0, 0x1005

    const/4 v1, 0x1

    if-ne p1, v0, :cond_77

    .line 778
    :try_start_1d
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->exportJsonString(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    .line 779
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object p2
    :try_end_29
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_29} :catch_51

    .line 780
    if-nez p2, :cond_2c

    return-void

    .line 782
    :cond_2c
    :try_start_2c
    const-string v0, "UTF-8"

    invoke-virtual {p1, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/io/OutputStream;->write([B)V

    .line 783
    invoke-virtual {p2}, Ljava/io/OutputStream;->flush()V
    :try_end_38
    .catchall {:try_start_2c .. :try_end_38} :catchall_4c

    .line 785
    :try_start_38
    invoke-virtual {p2}, Ljava/io/OutputStream;->close()V

    .line 786
    nop

    .line 787
    if-eqz p3, :cond_41

    const-string p1, "Folhas exportadas com sucesso!"

    invoke-static/range {p1 .. p1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    goto :goto_43

    :cond_41
    const-string p1, "Sheets exported successfully!"

    :goto_43
    const/4 p2, 0x0

    invoke-static {p0, p1, p2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_75

    .line 785
    :catchall_4c
    move-exception p1

    invoke-virtual {p2}, Ljava/io/OutputStream;->close()V

    .line 786
    throw p1
    :try_end_51
    .catch Ljava/lang/Exception; {:try_start_38 .. :try_end_51} :catch_51

    .line 788
    :catch_51
    move-exception p1

    .line 789
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p3, :cond_5c

    const-string p3, "Erro ao exportar: "

    invoke-static/range {p3 .. p3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    goto :goto_5e

    :cond_5c
    const-string p3, "Export failed: "

    :goto_5e
    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 790
    :goto_75
    goto/16 :goto_116

    .line 791
    :cond_77
    const/16 v0, 0x1006

    if-ne p1, v0, :cond_116

    .line 793
    :try_start_7b
    invoke-virtual {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p1
    :try_end_83
    .catch Ljava/lang/Exception; {:try_start_7b .. :try_end_83} :catch_f2

    .line 794
    if-nez p1, :cond_86

    return-void

    .line 797
    :cond_86
    :try_start_86
    invoke-static {p1}, Lcom/mrkeyboard/app/SheetStore;->readStreamUtf8(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object p2
    :try_end_8a
    .catchall {:try_start_86 .. :try_end_8a} :catchall_ed

    .line 799
    :try_start_8a
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 800
    nop

    .line 801
    invoke-static {p2}, Lcom/mrkeyboard/app/SheetModel;->parseSheets(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object p1

    .line 802
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 803
    if-eqz p3, :cond_9c

    const-string v2, "Importar folhas do arquivo?"

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_9e

    :cond_9c
    const-string v2, "Import sheets from file?"

    :goto_9e
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    .line 804
    if-eqz p3, :cond_ac

    const-string v3, "Foram encontradas "

    invoke-static/range {v3 .. v3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_ae

    :cond_ac
    const-string v3, "Found "

    :goto_ae
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 805
    if-eqz p3, :cond_bf

    const-string v2, " folha(s) v\u00e1lidas. Elas substituir\u00e3o a lista atual."

    invoke-static/range {v2 .. v2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_c1

    :cond_bf
    const-string v2, " valid sheet(s). They will replace your current sheets."

    :goto_c1
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 804
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 806
    if-eqz p3, :cond_d2

    const-string v0, "Importar"

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_d4

    :cond_d2
    const-string v0, "Import"

    :goto_d4
    new-instance v2, Lcom/mrkeyboard/app/PrefScreenSheets$20;

    invoke-direct {v2, p0, p2, p3}, Lcom/mrkeyboard/app/PrefScreenSheets$20;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Ljava/lang/String;Z)V

    invoke-virtual {p1, v0, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 818
    if-eqz p3, :cond_e2

    const-string p2, "Cancelar"

    invoke-static/range {p2 .. p2}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_e4

    :cond_e2
    const-string p2, "Cancel"

    :goto_e4
    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object p1

    .line 819
    invoke-virtual {p1}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 822
    goto :goto_116

    .line 799
    :catchall_ed
    move-exception p2

    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 800
    throw p2
    :try_end_f2
    .catch Ljava/lang/Exception; {:try_start_8a .. :try_end_f2} :catch_f2

    .line 820
    :catch_f2
    move-exception p1

    .line 821
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p3, :cond_fd

    const-string p3, "Arquivo JSON inv\u00e1lido: "

    invoke-static/range {p3 .. p3}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    goto :goto_ff

    :cond_fd
    const-string p3, "Invalid JSON file: "

    :goto_ff
    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 824
    :cond_116
    :goto_116
    return-void

    .line 771
    :cond_117
    :goto_117
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 18

    .line 46
    move-object/from16 v0, p0

    invoke-super/range {p0 .. p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 47
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v1

    .line 49
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 50
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 51
    const v4, -0xf7f3ee

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 54
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 55
    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 56
    const/16 v6, 0x10

    invoke-virtual {v4, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 57
    const v6, -0xf4efe8

    invoke-virtual {v4, v6}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 58
    const/high16 v6, 0x41000000    # 8.0f

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v7

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v9

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    invoke-virtual {v4, v7, v8, v9, v10}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 59
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x1

    const/4 v9, -0x2

    invoke-direct {v7, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 61
    if-eqz v1, :cond_50

    const-string v7, "Voltar"

    invoke-static/range {v7 .. v7}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_52

    :cond_50
    const-string v7, "Back"

    :goto_52
    const/4 v10, 0x2

    const v11, -0x160f07

    const/16 v12, 0x28

    invoke-static {v0, v10, v11, v12, v7}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v7

    .line 62
    new-instance v10, Lcom/mrkeyboard/app/PrefScreenSheets$1;

    invoke-direct {v10, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$1;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v7, v10}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 68
    new-instance v10, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v13, 0x42200000    # 40.0f

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v14

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v15

    invoke-direct {v10, v14, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v7, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 70
    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 71
    invoke-virtual {v7, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 72
    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v14

    invoke-virtual {v7, v10, v5, v14, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 74
    new-instance v10, Landroid/widget/TextView;

    invoke-direct {v10, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 75
    if-eqz v1, :cond_93

    const-string v14, "Folhas do teclado"

    invoke-static/range {v14 .. v14}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    goto :goto_95

    :cond_93
    const-string v14, "Keyboard sheets"

    :goto_95
    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 76
    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setTextColor(I)V

    .line 77
    const/high16 v14, 0x41900000    # 18.0f

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTextSize(F)V

    .line 78
    sget-object v14, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 79
    invoke-virtual {v10, v3}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 80
    invoke-virtual {v7, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 82
    new-instance v10, Landroid/widget/TextView;

    invoke-direct {v10, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    .line 83
    iget-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    const v14, -0x6c5c46

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 84
    iget-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    const/high16 v14, 0x41400000    # 12.0f

    invoke-virtual {v10, v14}, Landroid/widget/TextView;->setTextSize(F)V

    .line 85
    iget-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    invoke-virtual {v10, v3}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 86
    iget-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mSubtitleView:Landroid/widget/TextView;

    invoke-virtual {v7, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 87
    new-instance v10, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v14, 0x3f800000    # 1.0f

    invoke-direct {v10, v5, v9, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v4, v7, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 89
    if-eqz v1, :cond_da

    const-string v7, "Mais op\u00e7\u00f5es"

    invoke-static/range {v7 .. v7}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    goto :goto_dc

    :cond_da
    const-string v7, "More options"

    :goto_dc
    invoke-static {v0, v3, v11, v12, v7}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v7

    .line 90
    new-instance v10, Lcom/mrkeyboard/app/PrefScreenSheets$2;

    invoke-direct {v10, v0, v7}, Lcom/mrkeyboard/app/PrefScreenSheets$2;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;Landroid/widget/ImageView;)V

    invoke-virtual {v7, v10}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 96
    new-instance v10, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v11

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v12

    invoke-direct {v10, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v7, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 98
    new-instance v4, Landroid/view/View;

    invoke-direct {v4, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 99
    const v7, -0xe5dacb

    invoke-virtual {v4, v7}, Landroid/view/View;->setBackgroundColor(I)V

    .line 100
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v14}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    invoke-static {v3, v10}, Ljava/lang/Math;->max(II)I

    move-result v10

    invoke-direct {v7, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 103
    new-instance v4, Landroid/widget/ScrollView;

    invoke-direct {v4, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 104
    invoke-virtual {v4, v3}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 105
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v8, v5, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 107
    new-instance v7, Landroid/widget/LinearLayout;

    invoke-direct {v7, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 108
    invoke-virtual {v7, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 109
    const/high16 v10, 0x41800000    # 16.0f

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v11

    const/high16 v12, 0x41600000    # 14.0f

    invoke-direct {v0, v12}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v13

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v15

    const/high16 v14, 0x41c00000    # 24.0f

    invoke-direct {v0, v14}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v14

    invoke-virtual {v7, v11, v13, v15, v14}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 110
    invoke-virtual {v4, v7}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 112
    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/PrefScreenSheets;->buildFixedAbcCard(Z)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    # v1.69: "Return to main sheet when typing" (MrSheetOpt)
    invoke-static {v0}, Lcom/mrkeyboard/app/MrSheetOpt;->row(Landroid/content/Context;)Landroid/view/View;

    move-result-object v4

    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 115
    if-eqz v1, :cond_158

    const-string v11, "FOLHAS EDIT\u00c1VEIS (ORDEM DO CICLO)"

    invoke-static/range {v11 .. v11}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    goto :goto_15a

    :cond_158
    const-string v11, "EDITABLE SHEETS (CYCLE ORDER)"

    :goto_15a
    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 116
    const v11, -0xd63a0a

    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setTextColor(I)V

    .line 117
    const/high16 v13, 0x41380000    # 11.5f

    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setTextSize(F)V

    .line 118
    sget-object v13, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 119
    const v13, 0x3d75c28f    # 0.06f

    invoke-virtual {v4, v13}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 120
    const/high16 v13, 0x40800000    # 4.0f

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v14

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v15

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v13

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    invoke-virtual {v4, v14, v15, v13, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 121
    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 123
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    iput-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    .line 124
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 125
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mListContainer:Landroid/widget/LinearLayout;

    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 127
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    .line 128
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    if-eqz v1, :cond_1aa

    const-string v8, "+ Nova folha"

    invoke-static/range {v8 .. v8}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    goto :goto_1ac

    :cond_1aa
    const-string v8, "+ New sheet"

    :goto_1ac
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 129
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    const v8, -0xfbebe4

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setTextColor(I)V

    .line 130
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    const/high16 v8, 0x41700000    # 15.0f

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setTextSize(F)V

    .line 131
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    sget-object v8, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 132
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    const/16 v8, 0x11

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setGravity(I)V

    .line 133
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v8

    invoke-direct {v0, v12}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v13

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v14

    invoke-direct {v0, v12}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v12

    invoke-virtual {v4, v8, v13, v14, v12}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 134
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    invoke-static {v0, v10}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v8

    const v10, 0x3304141c

    invoke-static {v11, v8, v5, v5, v10}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v8

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 135
    iget-object v4, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    new-instance v8, Lcom/mrkeyboard/app/PrefScreenSheets$3;

    invoke-direct {v8, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$3;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 141
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x1

    invoke-direct {v4, v8, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 142
    const/high16 v8, 0x41200000    # 10.0f

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v10

    iput v10, v4, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 143
    iget-object v10, v0, Lcom/mrkeyboard/app/PrefScreenSheets;->mNewSheetBtn:Landroid/widget/TextView;

    invoke-virtual {v7, v10, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 145
    new-instance v4, Landroid/widget/LinearLayout;

    invoke-direct {v4, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 146
    invoke-virtual {v4, v5}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 147
    new-instance v10, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v12, -0x1

    invoke-direct {v10, v12, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 148
    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v12

    iput v12, v10, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 150
    if-eqz v1, :cond_227

    const-string v12, "Exportar JSON"

    invoke-static/range {v12 .. v12}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v12

    goto :goto_229

    :cond_227
    const-string v12, "Export JSON"

    :goto_229
    const/16 v13, 0xa

    const v14, -0xcb2c67

    invoke-direct {v0, v13, v14, v12, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeSecondaryButton(IILjava/lang/String;Z)Landroid/view/View;

    move-result-object v12

    .line 151
    new-instance v13, Lcom/mrkeyboard/app/PrefScreenSheets$4;

    invoke-direct {v13, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$4;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v12, v13}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 157
    new-instance v13, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v14, 0x3f800000    # 1.0f

    invoke-direct {v13, v5, v9, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 158
    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v6

    iput v6, v13, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 159
    invoke-virtual {v4, v12, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 161
    if-eqz v1, :cond_24f

    const-string v6, "Importar JSON"

    invoke-static/range {v6 .. v6}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    goto :goto_251

    :cond_24f
    const-string v6, "Import JSON"

    :goto_251
    const/16 v12, 0xb

    invoke-direct {v0, v12, v11, v6, v5}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeSecondaryButton(IILjava/lang/String;Z)Landroid/view/View;

    move-result-object v6

    .line 162
    new-instance v11, Lcom/mrkeyboard/app/PrefScreenSheets$5;

    invoke-direct {v11, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$5;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v6, v11}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 168
    new-instance v11, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v12, 0x3f800000    # 1.0f

    invoke-direct {v11, v5, v9, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v4, v6, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 169
    invoke-virtual {v7, v4, v10}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 171
    if-eqz v1, :cond_271

    const-string v1, "Restaurar todas para o padr\u00e3o"

    invoke-static/range {v1 .. v1}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_273

    :cond_271
    const-string v1, "Restore all to default"

    :goto_273
    const/16 v4, 0xc

    const v5, -0x48e7b

    invoke-direct {v0, v4, v5, v1, v3}, Lcom/mrkeyboard/app/PrefScreenSheets;->makeSecondaryButton(IILjava/lang/String;Z)Landroid/view/View;

    move-result-object v1

    .line 172
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v4, -0x1

    invoke-direct {v3, v4, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 173
    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/PrefScreenSheets;->dp(F)I

    move-result v4

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 174
    new-instance v4, Lcom/mrkeyboard/app/PrefScreenSheets$6;

    invoke-direct {v4, v0}, Lcom/mrkeyboard/app/PrefScreenSheets$6;-><init>(Lcom/mrkeyboard/app/PrefScreenSheets;)V

    invoke-virtual {v1, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 180
    invoke-virtual {v7, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 182
    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/PrefScreenSheets;->setContentView(Landroid/view/View;)V

    .line 183
    return-void
.end method

.method protected onResume()V
    .registers 3

    .line 187
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 188
    invoke-direct {p0}, Lcom/mrkeyboard/app/PrefScreenSheets;->reloadAndRender()V

    .line 189
    invoke-static {}, Lcom/mrkeyboard/app/SheetStore;->consumeCorruptRecoveryFlag()Z

    move-result v0

    if-eqz v0, :cond_1d

    .line 190
    nop

    .line 192
    const-string v0, "O arquivo de folhas estava corrompido; os padr\u00f5es foram restaurados (backup salvo em sheets.json.bak)."

    invoke-static/range {v0 .. v0}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "Sheets file was corrupted; defaults were restored (backup saved as sheets.json.bak)."

    invoke-static {p0, v0, v1}, Lcom/mrkeyboard/app/SheetStrings;->tr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 190
    const/4 v1, 0x1

    invoke-static {p0, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    .line 198
    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 200
    :cond_1d
    return-void
.end method
