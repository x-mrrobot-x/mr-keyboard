.class public Lcom/mrkeyboard/app/SheetEditorActivity;
.super Landroid/app/Activity;
.source "SheetEditorActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;
    }
.end annotation


# static fields
.field public static final EXTRA_SHEET_ID:Ljava/lang/String; = "sheet_id"


# instance fields
.field private mAddRowBtn:Landroid/widget/TextView;

.field private mAllSheets:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private mBadgeChip:Landroid/widget/TextView;

.field private mGridView:Lcom/mrkeyboard/app/SheetGridView;

.field private mScrollView:Landroid/widget/ScrollView;

.field private mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field private mSubtitleView:Landroid/widget/TextView;

.field private mTestInput:Landroid/widget/EditText;

.field private mTestLiveBadge:Landroid/widget/TextView;

.field private mTitleView:Landroid/widget/TextView;

.field private mUndoBtn:Landroid/widget/TextView;

.field private final mUndoStack:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .registers 2

    .line 32
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 37
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->performUndo()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V
    .registers 5

    .line 32
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->handleKeyDragMove(IIII)V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;II)V
    .registers 3

    .line 32
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->openKeyEditor(II)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->duplicateCurrentSheet()V

    return-void
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmDeleteCurrentSheet()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I
    .registers 2

    .line 32
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result p0

    return p0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;ZZ)Landroid/widget/TextView;
    .registers 4

    .line 32
    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/SheetEditorActivity;->makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/view/View;)V
    .registers 2

    .line 32
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->showOverflowMenu(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;
    .registers 1

    .line 32
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;
    .registers 1

    .line 32
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    return-object p0
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 1

    .line 32
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object p0
.end method

.method static synthetic access$502(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .registers 2

    .line 32
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object p1
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .registers 1

    .line 32
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showManageRowsDialog()V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/SheetEditorActivity;I)V
    .registers 2

    .line 32
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->addNewKeyToRow(I)V

    return-void
.end method

.method private addNewKeyToRow(I)V
    .registers 10

    .line 584
    if-ltz p1, :cond_5c

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_d

    goto :goto_5c

    .line 585
    :cond_d
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 586
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ne p1, v1, :cond_26

    const/16 p1, 0x9

    goto :goto_28

    :cond_26
    const/16 p1, 0xa

    .line 587
    :goto_28
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v1, p1, :cond_41

    .line 588
    const-string p1, "Esta fileira j\u00e1 atingiu o limite de teclas."

    const-string v0, "This row reached its key limit."

    invoke-static {p0, p1, v0}, Lcom/mrkeyboard/app/SheetStrings;->tr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 589
    return-void

    .line 591
    :cond_41
    new-instance v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string p1, "text"

    const/high16 v1, 0x3f800000    # 1.0f

    const-string v3, ""

    invoke-direct {v2, v3, p1, v3, v1}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    .line 592
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$16;

    invoke-direct {v7, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$16;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;)V

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    invoke-static/range {v0 .. v7}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 604
    return-void

    .line 584
    :cond_5c
    :goto_5c
    return-void
.end method

.method private buildQuickTestCard(Z)Landroid/view/View;
    .registers 19

    .line 288
    move-object/from16 v9, p0

    const/high16 v0, 0x41800000    # 16.0f

    invoke-static {v9, v0}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v8

    .line 289
    const/high16 v0, 0x41600000    # 14.0f

    invoke-static {v9, v0}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v4

    .line 290
    const/high16 v1, 0x3f800000    # 1.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    const/4 v3, 0x1

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v6

    .line 291
    const/high16 v2, 0x3fc00000    # 1.5f

    invoke-direct {v9, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    const/4 v5, 0x2

    invoke-static {v5, v2}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 293
    new-instance v10, Landroid/widget/LinearLayout;

    invoke-direct {v10, v9}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 294
    invoke-virtual {v10, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 295
    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    const/high16 v7, 0x41400000    # 12.0f

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v12

    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    invoke-virtual {v10, v2, v11, v12, v13}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 296
    const v2, -0xf0e9df

    const v11, -0xe5dacb

    invoke-static {v2, v8, v6, v11}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v2

    invoke-virtual {v10, v2}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 297
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v11, -0x1

    const/4 v12, -0x2

    invoke-direct {v2, v11, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 298
    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    iput v13, v2, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 299
    invoke-virtual {v10, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 302
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v9}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 303
    const/4 v13, 0x0

    invoke-virtual {v2, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 304
    const/16 v14, 0x10

    invoke-virtual {v2, v14}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 306
    new-instance v15, Landroid/widget/TextView;

    invoke-direct {v15, v9}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 307
    if-eqz p1, :cond_76

    const-string v16, "CAMPO DE TESTE R\u00c1PIDO"

    goto :goto_78

    :cond_76
    const-string v16, "QUICK TEST FIELD"

    :goto_78
    move-object/from16 v0, v16

    invoke-virtual {v15, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 308
    const v0, -0xd63a0a

    invoke-virtual {v15, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 309
    const/high16 v11, 0x41380000    # 11.5f

    invoke-virtual {v15, v11}, Landroid/widget/TextView;->setTextSize(F)V

    .line 310
    sget-object v11, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v15, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 311
    const v11, 0x3d75c28f    # 0.06f

    invoke-virtual {v15, v11}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 312
    invoke-virtual {v2, v15}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 314
    new-instance v11, Landroid/widget/TextView;

    invoke-direct {v11, v9}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v11, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    .line 315
    iget-object v11, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    invoke-virtual {v11, v0}, Landroid/widget/TextView;->setTextColor(I)V

    .line 316
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    const/high16 v11, 0x41280000    # 10.5f

    invoke-virtual {v0, v11}, Landroid/widget/TextView;->setTextSize(F)V

    .line 317
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    sget-object v11, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, v11}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 318
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    const/high16 v11, 0x41000000    # 8.0f

    invoke-direct {v9, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    const/high16 v7, 0x40200000    # 2.5f

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v14

    invoke-direct {v9, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    invoke-virtual {v0, v15, v14, v1, v7}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 319
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    const/high16 v1, 0x42c80000    # 100.0f

    invoke-static {v9, v1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v7

    const v14, 0x4d29c5f6    # 1.78020192E8f

    const v15, 0x2429c5f6

    invoke-static {v15, v7, v6, v14}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v0, v7}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 320
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v12, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 321
    invoke-direct {v9, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    iput v7, v0, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 322
    iget-object v7, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    invoke-virtual {v2, v7, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 324
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, v9}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 325
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v14, 0x3f800000    # 1.0f

    invoke-direct {v7, v13, v3, v14}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 327
    new-instance v14, Landroid/widget/LinearLayout;

    invoke-direct {v14, v9}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 328
    invoke-virtual {v14, v13}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 329
    const/16 v0, 0x10

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 330
    const/high16 v0, 0x41100000    # 9.0f

    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v0

    const/high16 v3, 0x40800000    # 4.0f

    invoke-direct {v9, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    const/high16 v15, 0x41200000    # 10.0f

    invoke-direct {v9, v15}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-direct {v9, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    invoke-virtual {v14, v0, v7, v11, v15}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 331
    invoke-static {v9, v1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v0

    const v1, 0x3329c5f6

    const v7, -0xf5efe8

    const v11, -0xd5c4ac

    invoke-static {v7, v0, v6, v11, v1}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 332
    const/16 v0, 0x8

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 334
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, v9}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 335
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/16 v15, 0xe

    const/high16 v7, 0x41400000    # 12.0f

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    const v13, -0x6c5c46

    invoke-direct {v1, v9, v15, v13, v11}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 336
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-direct {v9, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    invoke-direct {v1, v11, v15}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 337
    invoke-direct {v9, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 338
    invoke-virtual {v14, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 340
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, v9}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 341
    if-eqz p1, :cond_174

    const-string v1, "Limpar"

    goto :goto_176

    :cond_174
    const-string v1, "Clear"

    :goto_176
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 342
    invoke-virtual {v0, v13}, Landroid/widget/TextView;->setTextColor(I)V

    .line 343
    const/high16 v1, 0x41380000    # 11.5f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 344
    sget-object v1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 345
    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 346
    invoke-virtual {v2, v14}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 348
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v10, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 351
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, v9}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 352
    const/4 v0, 0x0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 353
    const/16 v0, 0x10

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 354
    const/high16 v0, 0x42580000    # 54.0f

    invoke-direct {v9, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setMinimumHeight(I)V

    .line 355
    const v0, -0xd5c4ac

    const v1, -0xf5efe8

    invoke-static {v1, v4, v6, v0}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v0

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 356
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 357
    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    iput v2, v0, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 358
    invoke-virtual {v10, v3, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 360
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/4 v0, 0x3

    const/high16 v1, 0x41b00000    # 22.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    const v11, -0x907f67

    invoke-direct {v2, v9, v0, v11, v7}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 361
    new-instance v0, Landroid/widget/ImageView;

    invoke-direct {v0, v9}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    .line 362
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 363
    sget-object v7, Landroid/widget/ImageView$ScaleType;->CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v7}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 364
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    invoke-direct {v7, v13, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 365
    const/high16 v1, 0x41600000    # 14.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    iput v13, v7, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 366
    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    iput v1, v7, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 367
    invoke-virtual {v3, v0, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 369
    new-instance v0, Landroid/widget/EditText;

    invoke-direct {v0, v9}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    iput-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    .line 370
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 371
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    if-eqz p1, :cond_21a

    .line 372
    const-string v1, "Toque aqui para abrir o teclado e testar esta folha ao vivo..."

    goto :goto_21c

    .line 373
    :cond_21a
    const-string v1, "Tap here to open the keyboard and test this sheet live..."

    .line 371
    :goto_21c
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 374
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    invoke-virtual {v0, v11}, Landroid/widget/EditText;->setHintTextColor(I)V

    .line 375
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const v1, -0x160f07

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextColor(I)V

    .line 376
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/high16 v1, 0x41700000    # 15.0f

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setTextSize(F)V

    .line 377
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/high16 v1, 0x41400000    # 12.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    const/high16 v13, 0x41600000    # 14.0f

    invoke-direct {v9, v13}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    const/4 v15, 0x0

    invoke-virtual {v0, v15, v7, v13, v1}, Landroid/widget/EditText;->setPadding(IIII)V

    .line 378
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setMaxLines(I)V

    .line 379
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const v1, 0xa0001

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setInputType(I)V

    .line 380
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/high16 v1, 0x12000000

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setImeOptions(I)V

    .line 381
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x3f800000    # 1.0f

    const/4 v13, 0x0

    invoke-direct {v1, v13, v12, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v3, v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 383
    new-instance v0, Lcom/mrkeyboard/app/SheetEditorActivity$10;

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity$10;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v3, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 396
    iget-object v12, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v13, Lcom/mrkeyboard/app/SheetEditorActivity$11;

    move-object v0, v13

    move-object/from16 v1, p0

    move-object v7, v10

    invoke-direct/range {v0 .. v8}, Lcom/mrkeyboard/app/SheetEditorActivity$11;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetUi$IconDrawable;Landroid/widget/LinearLayout;FIILandroid/widget/LinearLayout;F)V

    invoke-virtual {v12, v13}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 423
    iget-object v0, v9, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$12;

    invoke-direct {v1, v9, v14}, Lcom/mrkeyboard/app/SheetEditorActivity$12;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 432
    new-instance v0, Lcom/mrkeyboard/app/SheetEditorActivity$13;

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity$13;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v14, v0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 440
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, v9}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 441
    if-eqz p1, :cond_29d

    .line 442
    const-string v1, "As edi\u00e7\u00f5es s\u00e3o aplicadas na hora \u2022 Troque para esta folha no teclado para testar."

    goto :goto_29f

    .line 443
    :cond_29d
    const-string v1, "Edits apply instantly \u2022 Switch to this sheet on the keyboard to test."

    .line 441
    :goto_29f
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 444
    invoke-virtual {v0, v11}, Landroid/widget/TextView;->setTextColor(I)V

    .line 445
    const/high16 v1, 0x41380000    # 11.5f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 446
    const/high16 v1, 0x40000000    # 2.0f

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x41000000    # 8.0f

    invoke-direct {v9, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    invoke-direct {v9, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    const/4 v4, 0x0

    invoke-virtual {v0, v2, v3, v1, v4}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 447
    invoke-virtual {v10, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 449
    return-object v10
.end method

.method private confirmDeleteCurrentSheet()V
    .registers 6

    .line 556
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 557
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    .line 562
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 563
    if-eqz v0, :cond_29

    const-string v3, "Excluir folha?"

    goto :goto_2b

    :cond_29
    const-string v3, "Delete sheet?"

    :goto_2b
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 564
    if-eqz v0, :cond_39

    const-string v4, "Tem certeza que deseja excluir \""

    goto :goto_3b

    :cond_39
    const-string v4, "Are you sure you want to delete \""

    :goto_3b
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\"?"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 565
    if-eqz v0, :cond_5a

    const-string v3, "Excluir"

    goto :goto_5c

    :cond_5a
    const-string v3, "Delete"

    :goto_5c
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$15;

    invoke-direct {v4, p0, v1, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$15;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/util/ArrayList;Z)V

    invoke-virtual {v2, v3, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 579
    if-eqz v0, :cond_6a

    const-string v0, "Cancelar"

    goto :goto_6c

    :cond_6a
    const-string v0, "Cancel"

    :goto_6c
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 580
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 581
    return-void
.end method

.method private confirmRestoreDefault()V
    .registers 5

    .line 682
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 683
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 684
    if-eqz v0, :cond_e

    const-string v2, "Restaurar folha padr\u00e3o?"

    goto :goto_10

    :cond_e
    const-string v2, "Restore default sheet?"

    :goto_10
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 685
    if-eqz v0, :cond_19

    .line 686
    const-string v2, "Todas as edi\u00e7\u00f5es feitas nesta folha voltar\u00e3o ao layout original de f\u00e1brica."

    goto :goto_1b

    .line 687
    :cond_19
    const-string v2, "All edits made to this sheet will revert to factory defaults."

    .line 685
    :goto_1b
    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 688
    if-eqz v0, :cond_24

    const-string v2, "Restaurar"

    goto :goto_26

    :cond_24
    const-string v2, "Restore"

    :goto_26
    new-instance v3, Lcom/mrkeyboard/app/SheetEditorActivity$18;

    invoke-direct {v3, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$18;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Z)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 700
    if-eqz v0, :cond_34

    const-string v0, "Cancelar"

    goto :goto_36

    :cond_34
    const-string v0, "Cancel"

    :goto_36
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 701
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 702
    return-void
.end method

.method private dp(F)I
    .registers 2

    .line 55
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result p1

    return p1
.end method

.method private duplicateCurrentSheet()V
    .registers 9

    .line 529
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 530
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    .line 531
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/16 v3, 0xc

    const/4 v4, 0x0

    if-lt v2, v3, :cond_20

    .line 532
    if-eqz v0, :cond_16

    const-string v0, "Limite m\u00e1ximo de 12 folhas atingido."

    goto :goto_18

    :cond_16
    const-string v0, "Maximum of 12 sheets reached."

    :goto_18
    invoke-static {p0, v0, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 533
    return-void

    .line 535
    :cond_20
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    .line 536
    const-string v3, "copy"

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 537
    iput-boolean v4, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 538
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    if-eqz v0, :cond_42

    const-string v5, " (c\u00f3pia)"

    goto :goto_44

    :cond_42
    const-string v5, " (copy)"

    :goto_44
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v3, v5}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iput-object v3, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 539
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v3

    .line 540
    move v5, v4

    :goto_5b
    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v6

    if-ge v5, v6, :cond_79

    .line 541
    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v6, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v7, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v7, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v6, v7}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_76

    .line 542
    add-int/lit8 v3, v5, 0x1

    .line 543
    goto :goto_79

    .line 540
    :cond_76
    add-int/lit8 v5, v5, 0x1

    goto :goto_5b

    .line 546
    :cond_79
    :goto_79
    invoke-virtual {v1, v3, v2}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 547
    invoke-static {p0, v1}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 548
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->clear()V

    .line 549
    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 550
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v1

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 551
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 552
    if-eqz v0, :cond_98

    const-string v0, "Folha duplicada! Editando a nova c\u00f3pia."

    goto :goto_9a

    :cond_98
    const-string v0, "Sheet duplicated! Editing new copy."

    :goto_9a
    invoke-static {p0, v0, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 553
    return-void
.end method

.method private handleKeyDragMove(IIII)V
    .registers 8

    .line 657
    if-ltz p1, :cond_a4

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_a4

    if-ltz p3, :cond_a4

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p3, v0, :cond_1a

    goto/16 :goto_a4

    .line 658
    :cond_1a
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 659
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 660
    if-ltz p2, :cond_a3

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lt p2, v2, :cond_39

    goto :goto_a3

    .line 662
    :cond_39
    const/4 v2, 0x0

    if-ne p1, p3, :cond_67

    .line 663
    if-le p4, p2, :cond_40

    add-int/lit8 p4, p4, -0x1

    .line 664
    :cond_40
    iget-object p1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    add-int/lit8 p1, p1, -0x1

    invoke-static {p1, p4}, Ljava/lang/Math;->min(II)I

    move-result p1

    invoke-static {v2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    .line 665
    if-ne p1, p2, :cond_53

    return-void

    .line 666
    :cond_53
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 667
    iget-object p3, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p3, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 668
    iget-object p3, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p3, p1, p2}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 669
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 670
    goto :goto_a2

    .line 671
    :cond_67
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    add-int/lit8 p1, p1, -0x1

    if-ne p3, p1, :cond_76

    const/16 p1, 0x9

    goto :goto_78

    :cond_76
    const/16 p1, 0xa

    .line 672
    :goto_78
    iget-object p3, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p3}, Ljava/util/ArrayList;->size()I

    move-result p3

    if-lt p3, p1, :cond_81

    return-void

    .line 673
    :cond_81
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 674
    iget-object p1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p1, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 675
    iget-object p2, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    invoke-static {p2, p4}, Ljava/lang/Math;->min(II)I

    move-result p2

    invoke-static {v2, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 676
    iget-object p3, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {p3, p2, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 677
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 679
    :goto_a2
    return-void

    .line 660
    :cond_a3
    :goto_a3
    return-void

    .line 657
    :cond_a4
    :goto_a4
    return-void
.end method

.method private makeMiniRowBtn(Ljava/lang/String;ZZ)Landroid/widget/TextView;
    .registers 9

    .line 470
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 471
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 472
    const/high16 p1, 0x41600000    # 14.0f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 473
    sget-object v1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 474
    const/16 v1, 0x11

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setGravity(I)V

    .line 475
    const/high16 v1, 0x41000000    # 8.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    const/high16 v3, 0x40a00000    # 5.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    invoke-virtual {v0, v2, v4, v1, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 476
    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 477
    if-nez p2, :cond_3a

    .line 478
    const p1, -0xc5b6a2

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_5d

    .line 479
    :cond_3a
    if-eqz p3, :cond_4d

    .line 480
    const p2, -0x48e7b

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 481
    const p2, 0x24fb7185

    invoke-static {p0, p2, p1}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_5d

    .line 483
    :cond_4d
    const p2, -0xd63a0a

    invoke-virtual {v0, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 484
    const p2, 0x3329c5f6

    invoke-static {p0, p2, p1}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 486
    :goto_5d
    return-object v0
.end method

.method private makeToolbarPill(Ljava/lang/String;Z)Landroid/widget/TextView;
    .registers 7

    .line 453
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 454
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 455
    const/high16 p1, 0x41480000    # 12.5f

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextSize(F)V

    .line 456
    sget-object p1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 457
    const/high16 p1, 0x41500000    # 13.0f

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v1

    const/high16 v2, 0x41000000    # 8.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result p1

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    invoke-virtual {v0, v1, v3, p1, v2}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 458
    const/high16 p1, 0x42c80000    # 100.0f

    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result p1

    .line 459
    if-eqz p2, :cond_46

    .line 460
    const p2, -0xd63a0a

    const v1, 0x3304141c

    const/4 v2, 0x0

    invoke-static {p2, p1, v2, v2, v1}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 461
    const p1, -0xfbebe4

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_67

    .line 463
    :cond_46
    const/high16 p2, 0x3f800000    # 1.0f

    invoke-direct {p0, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result p2

    const/4 v1, 0x1

    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    const v1, -0xd5c4ac

    const v2, 0x3329c5f6

    const v3, -0xf0e9df

    invoke-static {v3, p1, p2, v1, v2}, Lcom/mrkeyboard/app/SheetUi;->rippleSurface(IFIII)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 464
    const p1, -0x160f07

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 466
    :goto_67
    return-object v0
.end method

.method private openKeyEditor(II)V
    .registers 15

    .line 607
    if-ltz p1, :cond_71

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_e

    goto/16 :goto_71

    .line 608
    :cond_e
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    move-object v3, v0

    check-cast v3, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 609
    if-ltz p2, :cond_70

    iget-object v0, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p2, v0, :cond_24

    goto :goto_70

    .line 610
    :cond_24
    iget-object v0, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 611
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x1

    sub-int/2addr v1, v2

    if-ne p1, v1, :cond_3b

    const/16 v1, 0x9

    goto :goto_3d

    :cond_3b
    const/16 v1, 0xa

    .line 612
    :goto_3d
    iget-object v4, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v4

    const/4 v5, 0x0

    if-ge v4, v1, :cond_48

    move v9, v2

    goto :goto_49

    :cond_48
    move v9, v5

    .line 613
    :goto_49
    iget-object v7, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-lez p2, :cond_4f

    move v8, v2

    goto :goto_50

    :cond_4f
    move v8, v5

    :goto_50
    iget-object v1, v3, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    sub-int/2addr v1, v2

    if-ge p2, v1, :cond_5b

    move v10, v2

    goto :goto_5c

    :cond_5b
    move v10, v5

    :goto_5c
    new-instance v11, Lcom/mrkeyboard/app/SheetEditorActivity$17;

    move-object v1, v11

    move-object v2, p0

    move v4, p2

    move v5, p1

    move-object v6, v0

    invoke-direct/range {v1 .. v6}, Lcom/mrkeyboard/app/SheetEditorActivity$17;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;IILcom/mrkeyboard/app/SheetModel$KeySpec;)V

    const/4 p1, 0x1

    move-object v4, p0

    move-object v5, v7

    move v7, v8

    move v8, v10

    move v10, p1

    invoke-static/range {v4 .. v11}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    .line 654
    return-void

    .line 609
    :cond_70
    :goto_70
    return-void

    .line 607
    :cond_71
    :goto_71
    return-void
.end method

.method private performUndo()V
    .registers 5

    .line 864
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 865
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1c

    .line 866
    if-eqz v0, :cond_12

    const-string v0, "Nada para desfazer."

    goto :goto_14

    :cond_12
    const-string v0, "Nothing to undo."

    :goto_14
    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 867
    return-void

    .line 869
    :cond_1c
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    add-int/lit8 v3, v3, -0x1

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 870
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 871
    if-eqz v0, :cond_36

    const-string v0, "Altera\u00e7\u00e3o desfeita."

    goto :goto_38

    :cond_36
    const-string v0, "Undone."

    :goto_38
    invoke-static {p0, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 872
    return-void
.end method

.method private persistAndRefresh()V
    .registers 2

    .line 875
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->updateSingleSheet(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z

    .line 876
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 877
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 878
    return-void
.end method

.method private pushUndoSnapshot()V
    .registers 3

    .line 857
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x14

    if-lt v0, v1, :cond_10

    .line 858
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 860
    :cond_10
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 861
    return-void
.end method

.method private refreshUi()V
    .registers 8

    .line 881
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 882
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v2, "123"

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 883
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 884
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 885
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v2

    .line 886
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x6

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    .line 887
    if-eqz v0, :cond_45

    const-string v6, " fileiras \u2022 "

    goto :goto_47

    :cond_45
    const-string v6, " rows \u2022 "

    :goto_47
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 889
    if-eqz v0, :cond_54

    const-string v4, " teclas"

    goto :goto_56

    :cond_54
    const-string v4, " keys"

    :goto_56
    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 886
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 890
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v3

    const/high16 v4, 0x3f800000    # 1.0f

    if-eqz v3, :cond_71

    const v3, 0x3ecccccd    # 0.4f

    goto :goto_72

    :cond_71
    move v3, v4

    :goto_72
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setAlpha(F)V

    .line 891
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v3, v5, :cond_82

    goto :goto_85

    :cond_82
    const v4, 0x3ee66666    # 0.45f

    :goto_85
    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setAlpha(F)V

    .line 892
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    if-eqz v2, :cond_a9

    .line 893
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v0, :cond_98

    const-string v0, "AO VIVO \u2022 "

    goto :goto_9a

    :cond_98
    const-string v0, "LIVE \u2022 "

    :goto_9a
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 895
    :cond_a9
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V

    .line 896
    return-void
.end method

.method private showManageRowsDialog()V
    .registers 8

    .line 705
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 706
    new-instance v1, Landroid/widget/ScrollView;

    invoke-direct {v1, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 707
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 708
    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 709
    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    .line 710
    const/high16 v5, 0x41200000    # 10.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x40c00000    # 6.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v6

    invoke-virtual {v2, v4, v5, v4, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 711
    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 713
    new-instance v4, Landroid/app/AlertDialog$Builder;

    invoke-direct {v4, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 714
    if-eqz v0, :cond_34

    const-string v5, "Gerenciar fileiras edit\u00e1veis"

    goto :goto_36

    :cond_34
    const-string v5, "Manage editable rows"

    :goto_36
    invoke-virtual {v4, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v4

    .line 715
    invoke-virtual {v4, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 716
    if-eqz v0, :cond_43

    const-string v4, "Fechar"

    goto :goto_45

    :cond_43
    const-string v4, "Close"

    :goto_45
    const/4 v5, 0x0

    invoke-virtual {v1, v4, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 717
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 719
    new-array v3, v3, [Ljava/lang/Runnable;

    .line 720
    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$19;

    invoke-direct {v4, p0, v2, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity$19;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;Z[Ljava/lang/Runnable;)V

    const/4 v0, 0x0

    aput-object v4, v3, v0

    .line 804
    aget-object v0, v3, v0

    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    .line 805
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 806
    return-void
.end method

.method private showOverflowMenu(Landroid/view/View;)V
    .registers 14

    .line 490
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 491
    new-instance v5, Ljava/util/ArrayList;

    const/4 v1, 0x5

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 492
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_11

    const-string v3, "Renomear nome e selo"

    goto :goto_13

    :cond_11
    const-string v3, "Rename name & badge"

    :goto_13
    const/4 v4, 0x1

    invoke-direct {v2, v4, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 493
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_21

    const-string v2, "Gerenciar fileiras..."

    goto :goto_23

    :cond_21
    const-string v2, "Manage rows..."

    :goto_23
    const/4 v3, 0x2

    const/16 v6, 0x9

    invoke-direct {v1, v3, v6, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 494
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-eqz v1, :cond_4c

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/16 v2, 0xc

    if-ge v1, v2, :cond_4c

    .line 495
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_41

    const-string v2, "Duplicar esta folha"

    goto :goto_43

    :cond_41
    const-string v2, "Duplicate this sheet"

    :goto_43
    const/4 v3, 0x3

    const/16 v6, 0x8

    invoke-direct {v1, v3, v6, v2}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 497
    :cond_4c
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v1, :cond_69

    .line 498
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_59

    const-string v9, "Restaurar padr\u00e3o desta folha"

    goto :goto_5b

    :cond_59
    const-string v9, "Restore sheet default"

    :goto_5b
    const/4 v10, 0x1

    const/4 v11, 0x1

    const/4 v7, 0x4

    const/16 v8, 0xc

    move-object v6, v1

    invoke-direct/range {v6 .. v11}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 500
    :cond_69
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    if-eqz v0, :cond_7c

    const-string v0, "Excluir esta folha"

    goto :goto_7e

    :cond_7c
    const-string v0, "Delete this sheet"

    :goto_7e
    move-object v9, v0

    const/4 v10, 0x2

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    xor-int/lit8 v11, v0, 0x1

    const/4 v7, 0x5

    const/16 v8, 0xd

    move-object v6, v1

    invoke-direct/range {v6 .. v11}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 503
    :goto_8b
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "123"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 504
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v6, Lcom/mrkeyboard/app/SheetEditorActivity$14;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$14;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    move-object v1, p0

    move-object v2, p1

    invoke-static/range {v1 .. v6}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 526
    return-void
.end method

.method private showRenameDialog()V
    .registers 12

    .line 809
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v0

    .line 810
    new-instance v1, Landroid/widget/LinearLayout;

    invoke-direct {v1, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 811
    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 812
    const/high16 v3, 0x41a00000    # 20.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    .line 813
    const/high16 v4, 0x41400000    # 12.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v5

    const/high16 v6, 0x40800000    # 4.0f

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v6

    invoke-virtual {v1, v3, v5, v3, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 815
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 816
    if-eqz v0, :cond_2c

    const-string v5, "Nome da folha:"

    goto :goto_2e

    :cond_2c
    const-string v5, "Sheet name:"

    :goto_2e
    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 817
    const v5, -0x6c5c46

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 818
    const/high16 v6, 0x41480000    # 12.5f

    invoke-virtual {v3, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 819
    sget-object v7, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 820
    const/high16 v7, 0x40c00000    # 6.0f

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    const/4 v9, 0x0

    invoke-virtual {v3, v9, v9, v9, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 821
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 823
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p0, v3, v2}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v3

    .line 824
    iget-object v8, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v8, v8, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v3, v8}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 825
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 827
    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 828
    if-eqz v0, :cond_6a

    const-string v10, "Selo curto no teclado (1 a 5 caracteres):"

    goto :goto_6c

    :cond_6a
    const-string v10, "Short badge on keyboard (1\u20135 chars):"

    :goto_6c
    invoke-virtual {v8, v10}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 829
    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTextColor(I)V

    .line 830
    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextSize(F)V

    .line 831
    sget-object v5, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 832
    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v5

    invoke-virtual {v8, v9, v4, v9, v5}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 833
    invoke-virtual {v1, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 835
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p0, v4, v2}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v4

    .line 836
    new-array v2, v2, [Landroid/text/InputFilter;

    new-instance v5, Landroid/text/InputFilter$LengthFilter;

    const/4 v6, 0x5

    invoke-direct {v5, v6}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v5, v2, v9

    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    .line 837
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v4, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 838
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 840
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 841
    if-eqz v0, :cond_b1

    const-string v5, "Renomear folha"

    goto :goto_b3

    :cond_b1
    const-string v5, "Rename sheet"

    :goto_b3
    invoke-virtual {v2, v5}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 842
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 843
    if-eqz v0, :cond_c0

    const-string v2, "Salvar"

    goto :goto_c2

    :cond_c0
    const-string v2, "Save"

    :goto_c2
    new-instance v5, Lcom/mrkeyboard/app/SheetEditorActivity$20;

    invoke-direct {v5, p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity$20;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/EditText;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 852
    if-eqz v0, :cond_d0

    const-string v0, "Cancelar"

    goto :goto_d2

    :cond_d0
    const-string v0, "Cancel"

    :goto_d2
    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 853
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 854
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .registers 2

    .line 51
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object p1

    invoke-super {p0, p1}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 52
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .registers 24

    .line 60
    move-object/from16 v0, p0

    invoke-super/range {p0 .. p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 61
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v1

    .line 63
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    if-eqz v2, :cond_1a

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    const-string v3, "sheet_id"

    invoke-virtual {v2, v3}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1b

    :cond_1a
    const/4 v2, 0x0

    .line 64
    :goto_1b
    invoke-static/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v3

    iput-object v3, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 65
    if-eqz v2, :cond_29

    .line 66
    invoke-static {v0, v2}, Lcom/mrkeyboard/app/SheetStore;->getSheetCopyById(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iput-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 68
    :cond_29
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    const/4 v3, 0x0

    if-nez v2, :cond_44

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_44

    .line 69
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v2

    iput-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 71
    :cond_44
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v2, :cond_4c

    .line 72
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 73
    return-void

    .line 76
    :cond_4c
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 77
    const/4 v4, 0x1

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 78
    const v5, -0xf7f3ee

    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 81
    new-instance v5, Landroid/widget/LinearLayout;

    invoke-direct {v5, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 82
    invoke-virtual {v5, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 83
    const/16 v6, 0x10

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 84
    const v7, -0xf4efe8

    invoke-virtual {v5, v7}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 85
    const/high16 v7, 0x41000000    # 8.0f

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v9

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v10

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-virtual {v5, v8, v9, v10, v11}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 86
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x1

    const/4 v10, -0x2

    invoke-direct {v8, v9, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v5, v8}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 88
    if-eqz v1, :cond_92

    const-string v8, "Voltar"

    goto :goto_94

    :cond_92
    const-string v8, "Back"

    :goto_94
    const/4 v11, 0x2

    const v12, -0x160f07

    const/16 v13, 0x28

    invoke-static {v0, v11, v12, v13, v8}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v8

    .line 89
    new-instance v11, Lcom/mrkeyboard/app/SheetEditorActivity$1;

    invoke-direct {v11, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v8, v11}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 95
    new-instance v11, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v14, 0x42200000    # 40.0f

    invoke-direct {v0, v14}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    invoke-direct {v0, v14}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v9

    invoke-direct {v11, v15, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v8, v11}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 97
    new-instance v8, Landroid/widget/LinearLayout;

    invoke-direct {v8, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 98
    invoke-virtual {v8, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 99
    invoke-virtual {v8, v6}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 100
    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v9

    const/high16 v11, 0x40800000    # 4.0f

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v6

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v14

    invoke-virtual {v8, v9, v15, v6, v14}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 101
    const v6, 0x3329c5f6

    const/high16 v9, 0x41400000    # 12.0f

    invoke-static {v0, v6, v9}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object v14

    invoke-virtual {v8, v14}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 102
    new-instance v14, Lcom/mrkeyboard/app/SheetEditorActivity$2;

    invoke-direct {v14, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$2;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v8, v14}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 109
    new-instance v14, Landroid/widget/TextView;

    invoke-direct {v14, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    .line 110
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    const v15, -0xfbebe4

    invoke-virtual {v14, v15}, Landroid/widget/TextView;->setTextColor(I)V

    .line 111
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-virtual {v14, v9}, Landroid/widget/TextView;->setTextSize(F)V

    .line 112
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    sget-object v15, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v14, v15}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 113
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    const/16 v15, 0x11

    invoke-virtual {v14, v15}, Landroid/widget/TextView;->setGravity(I)V

    .line 114
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    const/high16 v9, 0x40600000    # 3.5f

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v6

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v9

    invoke-virtual {v14, v11, v13, v6, v9}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 115
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    const v9, -0xd63a0a

    const/high16 v11, 0x40e00000    # 7.0f

    invoke-static {v0, v11}, Lcom/mrkeyboard/app/SheetUi;->dpf(Landroid/content/Context;F)F

    move-result v13

    invoke-static {v9, v13, v3, v3}, Lcom/mrkeyboard/app/SheetUi;->roundRect(IFII)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v9

    invoke-virtual {v6, v9}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 116
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-virtual {v8, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 118
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 119
    invoke-virtual {v6, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 120
    const/high16 v9, 0x41200000    # 10.0f

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v13

    invoke-virtual {v6, v13, v3, v3, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 122
    new-instance v13, Landroid/widget/TextView;

    invoke-direct {v13, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    .line 123
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    invoke-virtual {v13, v12}, Landroid/widget/TextView;->setTextColor(I)V

    .line 124
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    const/high16 v14, 0x41800000    # 16.0f

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setTextSize(F)V

    .line 125
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    sget-object v14, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 126
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    invoke-virtual {v13, v4}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 127
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    sget-object v14, Landroid/text/TextUtils$TruncateAt;->END:Landroid/text/TextUtils$TruncateAt;

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setEllipsize(Landroid/text/TextUtils$TruncateAt;)V

    .line 128
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    invoke-virtual {v6, v13}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 130
    new-instance v13, Landroid/widget/TextView;

    invoke-direct {v13, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    .line 131
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    const v14, -0x6c5c46

    invoke-virtual {v13, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 132
    iget-object v13, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    const/high16 v7, 0x41380000    # 11.5f

    invoke-virtual {v13, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 133
    iget-object v7, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    invoke-virtual {v7, v4}, Landroid/widget/TextView;->setSingleLine(Z)V

    .line 134
    iget-object v7, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 136
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v13, 0x3f800000    # 1.0f

    invoke-direct {v7, v3, v10, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v8, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 137
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v6, v3, v10, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v5, v8, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 139
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    .line 140
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    if-eqz v1, :cond_1b8

    const-string v7, "\u21b6 Desfazer"

    goto :goto_1ba

    :cond_1b8
    const-string v7, "\u21b6 Undo"

    :goto_1ba
    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 141
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    invoke-virtual {v6, v12}, Landroid/widget/TextView;->setTextColor(I)V

    .line 142
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    const/high16 v7, 0x41480000    # 12.5f

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 143
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    sget-object v7, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 144
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    invoke-virtual {v6, v15}, Landroid/widget/TextView;->setGravity(I)V

    .line 145
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v15

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-virtual {v6, v7, v8, v15, v11}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 146
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    const v7, 0x3329c5f6

    invoke-static {v0, v7, v9}, Lcom/mrkeyboard/app/SheetUi;->borderlessCircleRipple(Landroid/content/Context;IF)Landroid/graphics/drawable/Drawable;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 147
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$3;

    invoke-direct {v7, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$3;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 153
    iget-object v6, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 155
    if-eqz v1, :cond_20a

    const-string v6, "Mais op\u00e7\u00f5es"

    goto :goto_20c

    :cond_20a
    const-string v6, "More options"

    :goto_20c
    const/16 v7, 0x28

    invoke-static {v0, v4, v12, v7, v6}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v6

    .line 156
    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$4;

    invoke-direct {v7, v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity$4;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/ImageView;)V

    invoke-virtual {v6, v7}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 162
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v8, 0x42200000    # 40.0f

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    invoke-direct {v7, v11, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 164
    new-instance v5, Landroid/view/View;

    invoke-direct {v5, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 165
    const v6, -0xe5dacb

    invoke-virtual {v5, v6}, Landroid/view/View;->setBackgroundColor(I)V

    .line 166
    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v13}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    invoke-static {v4, v7}, Ljava/lang/Math;->max(II)I

    move-result v7

    const/4 v8, -0x1

    invoke-direct {v6, v8, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 169
    new-instance v5, Landroid/widget/ScrollView;

    invoke-direct {v5, v0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    iput-object v5, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    .line 170
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    invoke-virtual {v5, v4}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 171
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    new-instance v6, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v7, -0x1

    invoke-direct {v6, v7, v3, v13}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 173
    new-instance v5, Landroid/widget/LinearLayout;

    invoke-direct {v5, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 174
    invoke-virtual {v5, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 175
    const/high16 v6, 0x41400000    # 12.0f

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    .line 176
    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    .line 177
    const/high16 v6, 0x41a00000    # 20.0f

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v6

    .line 178
    invoke-virtual {v5, v7, v8, v7, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 179
    iget-object v11, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    invoke-virtual {v11, v5}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 181
    sget v11, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v12, 0x1e

    if-lt v11, v12, :cond_29b

    .line 182
    iget-object v11, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    new-instance v12, Lcom/mrkeyboard/app/SheetEditorActivity$5;

    invoke-direct {v12, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$5;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    move-object/from16 v16, v11

    move-object/from16 v17, v5

    move/from16 v18, v7

    move/from16 v19, v8

    move/from16 v20, v6

    move-object/from16 v21, v12

    invoke-static/range {v16 .. v21}, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;->attach(Landroid/view/View;Landroid/view/View;IIILjava/lang/Runnable;)V

    .line 197
    :cond_29b
    new-instance v6, Landroid/widget/TextView;

    invoke-direct {v6, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 198
    if-eqz v1, :cond_2a5

    .line 199
    const-string v7, "Toque em uma tecla para editar \u2022 Segure e arraste para mover \u2022 Toque em \'+\' para adicionar"

    goto :goto_2a7

    .line 200
    :cond_2a5
    const-string v7, "Tap a key to edit \u2022 Hold & drag to move \u2022 Tap \'+\' to add"

    .line 198
    :goto_2a7
    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 201
    invoke-virtual {v6, v14}, Landroid/widget/TextView;->setTextColor(I)V

    .line 202
    const/high16 v7, 0x41400000    # 12.0f

    invoke-virtual {v6, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 203
    const/high16 v7, 0x40800000    # 4.0f

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v11

    invoke-virtual {v6, v8, v3, v7, v11}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 204
    invoke-virtual {v5, v6}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 207
    new-instance v6, Landroid/widget/LinearLayout;

    invoke-direct {v6, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 208
    invoke-virtual {v6, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 209
    const/16 v7, 0x10

    invoke-virtual {v6, v7}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 210
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x1

    invoke-direct {v7, v8, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 211
    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v8

    iput v8, v7, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 212
    invoke-virtual {v5, v6, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 214
    if-eqz v1, :cond_2e7

    const-string v7, "+ Nova fileira"

    goto :goto_2e9

    :cond_2e7
    const-string v7, "+ Add row"

    :goto_2e9
    invoke-direct {v0, v7, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->makeToolbarPill(Ljava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v4

    iput-object v4, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    .line 215
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$6;

    invoke-direct {v7, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$6;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Z)V

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 231
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    invoke-virtual {v6, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 233
    if-eqz v1, :cond_303

    const-string v4, "\u21c5 Fileiras"

    goto :goto_305

    :cond_303
    const-string v4, "\u21c5 Rows"

    :goto_305
    invoke-direct {v0, v4, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->makeToolbarPill(Ljava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v4

    .line 234
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 235
    const/high16 v8, 0x41000000    # 8.0f

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v9

    iput v9, v7, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 236
    new-instance v8, Lcom/mrkeyboard/app/SheetEditorActivity$7;

    invoke-direct {v8, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$7;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 242
    invoke-virtual {v6, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 244
    if-eqz v1, :cond_326

    const-string v4, "\u270e Nome/Selo"

    goto :goto_328

    :cond_326
    const-string v4, "\u270e Name/Badge"

    :goto_328
    invoke-direct {v0, v4, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->makeToolbarPill(Ljava/lang/String;Z)Landroid/widget/TextView;

    move-result-object v3

    .line 245
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 246
    const/high16 v7, 0x41000000    # 8.0f

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v7

    iput v7, v4, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 247
    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$8;

    invoke-direct {v7, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$8;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 253
    invoke-virtual {v6, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 256
    new-instance v3, Lcom/mrkeyboard/app/SheetGridView;

    invoke-direct {v3, v0}, Lcom/mrkeyboard/app/SheetGridView;-><init>(Landroid/content/Context;)V

    iput-object v3, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    .line 257
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$9;

    invoke-direct {v4, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$9;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Z)V

    invoke-virtual {v3, v4}, Lcom/mrkeyboard/app/SheetGridView;->setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V

    .line 278
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    invoke-direct {v4, v6, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v5, v3, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 281
    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->buildQuickTestCard(Z)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v5, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 283
    invoke-virtual {v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->setContentView(Landroid/view/View;)V

    .line 284
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 285
    return-void
.end method
