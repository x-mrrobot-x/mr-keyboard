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

.field static final ROW_PREVIEW_MAX:I = 0x30

.field static final UNDO_LIMIT:I = 0x14


# instance fields
.field private mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

.field private mAddRowBtn:Landroid/widget/TextView;

.field private mAllSheets:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field

.field private mBadgeChip:Landroid/widget/TextView;

.field private mDialog:Landroid/app/AlertDialog;

.field private mGridView:Lcom/mrkeyboard/app/SheetGridView;

.field private mLegend:Landroid/widget/TextView;

.field private mScrollView:Landroid/widget/ScrollView;

.field private mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field private mSubtitleView:Landroid/widget/TextView;

.field private mTestCard:Landroid/view/View;

.field private mTestClear:Landroid/view/View;

.field private mTestFieldIcon:Landroid/widget/ImageView;

.field private mTestFieldRow:Landroid/view/View;

.field private mTestInput:Landroid/widget/EditText;

.field private mTestLiveBadge:Landroid/widget/TextView;

.field private mTitleView:Landroid/widget/TextView;

.field private mUndoBtn:Landroid/widget/ImageView;

.field private final mUndoStack:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 70
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->performUndo()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;I)I
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v0

    return v0
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    return-void
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    return-void
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/SheetEditorActivity;F)I
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v0

    return v0
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ImageView;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->drawable(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/view/View;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->showOverflowMenu(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestCard:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    return-object v0
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object v0
.end method

.method static synthetic access$2402(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 0

    .prologue
    .line 56
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object p1
.end method

.method static synthetic access$2500(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->renderRows(Landroid/widget/LinearLayout;)V

    return-void
.end method

.method static synthetic access$2600(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->duplicateCurrentSheet()V

    return-void
.end method

.method static synthetic access$2700(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V

    return-void
.end method

.method static synthetic access$2800(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmDeleteCurrentSheet()V

    return-void
.end method

.method static synthetic access$2900(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreAbc()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->addRow()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showManageRowsDialog()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/SheetEditorActivity;I)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->addNewKeyToRow(I)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->handleKeyDragMove(IIII)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/MrAbcKeys$Model;
    .locals 1

    .prologue
    .line 56
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    return-object v0
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/SheetEditorActivity;II)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->openAbcKeyEditor(II)V

    return-void
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/SheetEditorActivity;II)V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->openKeyEditor(II)V

    return-void
.end method

.method private addNewKeyToRow(I)V
    .locals 8

    .prologue
    const/4 v6, 0x0

    const/4 v3, 0x0

    .line 311
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-nez v0, :cond_0

    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 334
    :cond_0
    :goto_0
    return-void

    .line 312
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 313
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v2

    if-lt v1, v2, :cond_2

    .line 314
    const-string v0, "mr_sheet_ed_row_limit"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 318
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    new-instance v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v4, "text"

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v4, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$8;

    invoke-direct {v7, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$8;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;)V

    move-object v0, p0

    move v4, v3

    move v5, v3

    move v6, v3

    invoke-static/range {v0 .. v7}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private addRow()V
    .locals 4

    .prologue
    const/4 v2, 0x6

    const/4 v3, 0x0

    .line 257
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v0, v2, :cond_0

    .line 258
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 259
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 260
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 264
    :goto_0
    return-void

    .line 263
    :cond_0
    const-string v0, "mr_sheet_ed_rows_limit"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private bindGrid(Landroid/view/View;)V
    .locals 5

    .prologue
    .line 269
    new-instance v0, Lcom/mrkeyboard/app/SheetGridView;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/SheetGridView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    .line 270
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$7;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$7;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V

    .line 299
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrAbcKeys$Model;->lockedMap()[[Z

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->setFixed([[Z)V

    .line 300
    :cond_0
    const-string v0, "grid_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 301
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 303
    return-void
.end method

.method private bindHeader(Landroid/view/View;)V
    .locals 7

    .prologue
    const/16 v6, 0x28

    const/4 v5, 0x0

    .line 200
    const-string v0, "back_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 201
    const/4 v1, 0x2

    const-string v2, "mr_ui_text"

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "mr_sheet_ed_back"

    new-array v4, v5, [Ljava/lang/Object;

    .line 202
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 201
    invoke-static {p0, v1, v2, v6, v3}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v1

    .line 203
    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 208
    invoke-static {}, Lcom/mrkeyboard/app/SheetEditorActivity;->fill()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 211
    const-string v0, "header_pill"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 212
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v1, :cond_0

    .line 214
    const-string v0, "edit_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 226
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/ImageView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$3;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 232
    const-string v0, "more_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 233
    const/4 v1, 0x1

    const-string v2, "mr_ui_text"

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "mr_sheet_ed_more"

    new-array v4, v5, [Ljava/lang/Object;

    .line 234
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 233
    invoke-static {p0, v1, v2, v6, v3}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v1

    .line 235
    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$4;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$4;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/ImageView;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 240
    invoke-static {}, Lcom/mrkeyboard/app/SheetEditorActivity;->fill()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 241
    return-void

    .line 216
    :cond_0
    const-string v1, "mr_sheet_ed_rename_desc"

    new-array v2, v5, [Ljava/lang/Object;

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 217
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$2;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 222
    const-string v0, "edit_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/4 v2, 0x5

    const-string v3, "mr_ui_text3"

    .line 223
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41800000    # 16.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {v1, p0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 222
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0
.end method

.method private bindLegend()V
    .locals 9

    .prologue
    const/4 v8, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 433
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mLegend:Landroid/widget/TextView;

    const/4 v1, 0x5

    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "mr_sheet_ed_legend_text"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v4

    const-string v2, "mr_sheet_ed_legend_tasker"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v5

    const-string v2, "mr_sheet_ed_legend_sheet"

    new-array v3, v4, [Ljava/lang/Object;

    .line 434
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v6

    const-string v2, "mr_sheet_ed_legend_special"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v7

    const-string v2, "mr_sheet_ed_legend_spacer"

    new-array v3, v4, [Ljava/lang/Object;

    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v8

    const/4 v2, 0x5

    new-array v2, v2, [I

    const-string v3, "mr_ui_text3"

    .line 435
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    aput v3, v2, v4

    const-string v3, "mr_ui_amber"

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    aput v3, v2, v5

    const-string v3, "mr_ui_blue"

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    aput v3, v2, v6

    const-string v3, "mr_ui_violet"

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    aput v3, v2, v7

    const-string v3, "mr_ui_text3"

    .line 436
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    aput v3, v2, v8

    .line 433
    invoke-static {v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->legend([Ljava/lang/String;[I)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 437
    return-void
.end method

.method private bindTestCard(Landroid/view/View;)V
    .locals 7

    .prologue
    const/high16 v5, 0x41400000    # 12.0f

    .line 458
    const-string v0, "test_card"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestCard:Landroid/view/View;

    .line 459
    const-string v0, "test_field_row"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    .line 460
    const-string v0, "test_clear"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    .line 461
    const-string v0, "test_field_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    .line 462
    const-string v0, "test_input"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    .line 463
    const-string v0, "test_badge"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    .line 466
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrSheetTest;->option(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setPrivateImeOptions(Ljava/lang/String;)V

    .line 468
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/4 v2, 0x3

    const-string v3, "mr_ui_text3"

    .line 469
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41b00000    # 22.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {v1, p0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 468
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 470
    const-string v0, "test_clear_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 471
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/16 v2, 0xe

    const-string v3, "mr_ui_text3"

    .line 472
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {v1, p0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 471
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 474
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$11;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$11;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 486
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$12;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$12;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 501
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$13;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$13;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 510
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$14;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$14;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 518
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_1

    .line 519
    const-string v0, "content"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    .line 520
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v2

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v5

    new-instance v6, Lcom/mrkeyboard/app/SheetEditorActivity$15;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$15;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetEditorActivity$Api30ImeHelper;->attach(Landroid/view/View;Landroid/view/View;IIIILjava/lang/Runnable;)V

    .line 532
    :cond_1
    return-void
.end method

.method private bindToolbar(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 244
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$5;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$5;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 249
    const-string v0, "rows_btn"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$6;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 254
    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 99
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const-string v2, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private confirmDeleteCurrentSheet()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 783
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 803
    :goto_0
    return-void

    .line 784
    :cond_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    .line 785
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheet_ed_delete_title"

    new-array v3, v5, [Ljava/lang/Object;

    .line 786
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_sheet_ed_delete_msg"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v4, v3, v5

    .line 787
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_sheet_ed_delete"

    new-array v3, v5, [Ljava/lang/Object;

    .line 788
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/SheetEditorActivity$24;

    invoke-direct {v3, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$24;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/util/ArrayList;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v5, [Ljava/lang/Object;

    .line 801
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 802
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmRestoreAbc()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 739
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-nez v0, :cond_1

    .line 753
    :cond_0
    :goto_0
    return-void

    .line 740
    :cond_1
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_abc_restore_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 741
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_abc_restore_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 742
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_restore"

    new-array v2, v3, [Ljava/lang/Object;

    .line 743
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$23;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$23;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 751
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 752
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private confirmRestoreDefault()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 806
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 823
    :goto_0
    return-void

    .line 807
    :cond_0
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheet_ed_restore_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 808
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_restore_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 809
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_restore"

    new-array v2, v3, [Ljava/lang/Object;

    .line 810
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$25;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$25;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 821
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 822
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 113
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    return v0
.end method

.method private drawable(Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 109
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "drawable"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method private duplicateCurrentSheet()V
    .locals 7

    .prologue
    const/16 v3, 0xc

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 756
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v4

    .line 757
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt v0, v3, :cond_0

    .line 758
    const-string v0, "mr_sheet_ed_limit_sheets"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 780
    :goto_0
    return-void

    .line 761
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v5

    .line 762
    const-string v0, "copy"

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 763
    iput-boolean v2, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 764
    const-string v0, "mr_sheet_ed_copy_suffix"

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeName(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    .line 765
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v3

    move v1, v2

    .line 766
    :goto_1
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 767
    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v6, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v6, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 768
    add-int/lit8 v0, v1, 0x1

    .line 772
    :goto_2
    invoke-virtual {v4, v0, v5}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 773
    invoke-static {p0, v4}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 774
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 775
    invoke-virtual {v5}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 776
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 777
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 778
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->retargetTestField()V

    .line 779
    const-string v0, "mr_sheet_ed_duplicated"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 766
    :cond_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    :cond_2
    move v0, v3

    goto :goto_2
.end method

.method private static fill()Landroid/widget/LinearLayout$LayoutParams;
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 121
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    return-object v0
.end method

.method private handleKeyDragMove(IIII)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 406
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge p1, v0, :cond_0

    if-ltz p3, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p3, v0, :cond_1

    .line 427
    :cond_0
    :goto_0
    return-void

    .line 407
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 408
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 409
    if-ltz p2, :cond_0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge p2, v2, :cond_0

    .line 410
    if-ne p1, p3, :cond_3

    .line 412
    if-le p4, p2, :cond_2

    add-int/lit8 p4, p4, -0x1

    .line 413
    :cond_2
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {v1, p4}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 414
    if-eq v1, p2, :cond_0

    .line 415
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 416
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2, v1, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 417
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    goto :goto_0

    .line 420
    :cond_3
    iget-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v3

    if-lt v2, v3, :cond_4

    .line 421
    const-string v0, "mr_sheet_ed_row_limit"

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v4

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 424
    :cond_4
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 425
    iget-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-static {v1, p4}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2, v1, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 426
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    goto/16 :goto_0
.end method

.method private inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    .prologue
    .line 103
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 104
    invoke-static {p0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, p2, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method static legend([Ljava/lang/String;[I)Ljava/lang/CharSequence;
    .locals 6

    .prologue
    .line 444
    new-instance v2, Landroid/text/SpannableStringBuilder;

    new-instance v0, Ljava/lang/String;

    invoke-direct {v0}, Ljava/lang/String;-><init>()V

    invoke-direct {v2, v0}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    .line 445
    const/4 v0, 0x0

    :goto_0
    array-length v1, p0

    if-ge v0, v1, :cond_2

    .line 446
    if-lez v0, :cond_0

    const-string v1, "    "

    invoke-virtual {v2, v1}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 447
    :cond_0
    invoke-virtual {v2}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v3

    .line 448
    array-length v1, p0

    add-int/lit8 v1, v1, -0x1

    if-ne v0, v1, :cond_1

    const-string v1, "\u25cb"

    :goto_1
    invoke-virtual {v2, v1}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 449
    new-instance v1, Landroid/text/style/ForegroundColorSpan;

    aget v4, p1, v0

    invoke-direct {v1, v4}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    add-int/lit8 v4, v3, 0x1

    const/16 v5, 0x21

    invoke-virtual {v2, v1, v3, v4, v5}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 450
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u00a0"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    aget-object v3, p0, v0

    const/16 v4, 0x20

    const/16 v5, 0xa0

    invoke-virtual {v3, v4, v5}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    .line 445
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 448
    :cond_1
    const-string v1, "\u25cf"

    goto :goto_1

    .line 452
    :cond_2
    return-object v2
.end method

.method private maxKeysOfRow(I)I
    .locals 1

    .prologue
    .line 307
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ne p1, v0, :cond_0

    const/16 v0, 0x9

    :goto_0
    return v0

    :cond_0
    const/16 v0, 0xa

    goto :goto_0
.end method

.method private openAbcKeyEditor(II)V
    .locals 4

    .prologue
    .line 384
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-virtual {v0, p1, p2}, Lcom/mrkeyboard/app/MrAbcKeys$Model;->locked(II)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 402
    :cond_0
    :goto_0
    return-void

    .line 385
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 386
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p2, v1, :cond_0

    .line 387
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    new-instance v3, Lcom/mrkeyboard/app/SheetEditorActivity$10;

    invoke-direct {v3, p0, v0, p2}, Lcom/mrkeyboard/app/SheetEditorActivity$10;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;I)V

    invoke-static {p0, v2, v1, v3}, Lcom/mrkeyboard/app/KeyEditDialog;->showForFixedKey(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;Lcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private openKeyEditor(II)V
    .locals 11

    .prologue
    const/4 v0, 0x0

    const/4 v9, 0x1

    .line 337
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v1

    if-nez v1, :cond_0

    if-ltz p1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt p1, v1, :cond_1

    .line 380
    :cond_0
    :goto_0
    return-void

    .line 338
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 339
    if-ltz p2, :cond_0

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p2, v1, :cond_0

    .line 340
    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 341
    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v3

    if-ge v1, v3, :cond_2

    move v8, v9

    .line 342
    :goto_1
    iget-object v10, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-lez p2, :cond_3

    move v6, v9

    :goto_2
    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    if-ge p2, v1, :cond_4

    move v7, v9

    :goto_3
    new-instance v0, Lcom/mrkeyboard/app/SheetEditorActivity$9;

    move-object v1, p0

    move v3, p2

    move v4, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetEditorActivity$9;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;IILcom/mrkeyboard/app/SheetModel$KeySpec;)V

    move-object v3, p0

    move-object v4, v10

    move-object v10, v0

    invoke-static/range {v3 .. v10}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0

    :cond_2
    move v8, v0

    .line 341
    goto :goto_1

    :cond_3
    move v6, v0

    .line 342
    goto :goto_2

    :cond_4
    move v7, v0

    goto :goto_3
.end method

.method private performUndo()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 835
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 836
    const-string v0, "mr_sheet_ed_nothing_undo"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 842
    :goto_0
    return-void

    .line 839
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 840
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 841
    const-string v0, "mr_sheet_ed_undone"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private persistAndRefresh()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 845
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_1

    .line 846
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object v1, v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 847
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrAbcKeys;->save(Landroid/content/Context;Lcom/mrkeyboard/app/MrAbcKeys$Model;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "mr_abc_save_failed"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 851
    :cond_0
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 852
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 853
    return-void

    .line 849
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->updateSingleSheet(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z

    goto :goto_0
.end method

.method private pushUndoSnapshot()V
    .locals 2

    .prologue
    .line 828
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x14

    if-lt v0, v1, :cond_0

    .line 829
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 831
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrAbcKeys;->copySheet(Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    :goto_0
    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 832
    return-void

    .line 831
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    goto :goto_0
.end method

.method private refreshUi()V
    .locals 10

    .prologue
    const/4 v9, 0x6

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 856
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_2

    const-string v0, "ABC"

    .line 857
    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 858
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v1, :cond_4

    .line 859
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    const-string v5, "mr_sheets_main_title"

    new-array v6, v3, [Ljava/lang/Object;

    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 860
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {v1, v5}, Lcom/mrkeyboard/app/MrAbcKeys;->diff(Lcom/mrkeyboard/app/MrAbcKeys$Model;Lcom/mrkeyboard/app/SheetModel$Sheet;)Ljava/util/Map;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map;->size()I

    move-result v1

    .line 861
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    if-nez v1, :cond_3

    const-string v1, "mr_abc_ed_none"

    new-array v6, v3, [Ljava/lang/Object;

    invoke-direct {p0, v1, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    :goto_1
    invoke-virtual {v5, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 867
    :goto_2
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_5

    move v1, v2

    .line 868
    :goto_3
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/ImageView;

    invoke-virtual {v5, v1}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 869
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/ImageView;

    if-eqz v1, :cond_6

    move v1, v4

    :goto_4
    invoke-virtual {v5, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 870
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lt v5, v9, :cond_0

    const v4, 0x3ee66666    # 0.45f

    :cond_0
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setAlpha(F)V

    .line 871
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    .line 872
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    const-string v4, "mr_sheet_ed_live"

    new-array v2, v2, [Ljava/lang/Object;

    aput-object v0, v2, v3

    invoke-direct {p0, v4, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 874
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V

    .line 875
    return-void

    .line 856
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "123"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 861
    :cond_3
    const-string v6, "mr_abc_ed_count"

    new-array v7, v2, [Ljava/lang/Object;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v7, v3

    invoke-direct {p0, v6, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 863
    :cond_4
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 864
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    const-string v5, "mr_sheet_ed_subtitle"

    const/4 v6, 0x3

    new-array v6, v6, [Ljava/lang/Object;

    iget-object v7, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v7, v7, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v3

    .line 865
    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v2

    const/4 v7, 0x2

    iget-object v8, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v8}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    .line 864
    invoke-direct {p0, v5, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto/16 :goto_2

    :cond_5
    move v1, v3

    .line 867
    goto/16 :goto_3

    .line 869
    :cond_6
    const v1, 0x3eb33333    # 0.35f

    goto/16 :goto_4
.end method

.method private renderRows(Landroid/widget/LinearLayout;)V
    .locals 10

    .prologue
    .line 600
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 601
    const/4 v0, 0x0

    move v8, v0

    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v8, v0, :cond_4

    .line 603
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 604
    const-string v1, "mr_sheet_ed_row_item"

    invoke-direct {p0, v1, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 605
    const-string v2, "label"

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    const-string v3, "mr_sheet_ed_row_line"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    add-int/lit8 v6, v8, 0x1

    .line 606
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x1

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v6}, Ljava/util/ArrayList;->size()I

    move-result v6

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v4, v5

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 605
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 607
    const-string v2, "keys"

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    const-string v4, "mr_sheet_ed_row_empty"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowPreview(Lcom/mrkeyboard/app/SheetModel$Row;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 608
    add-int/lit8 v0, v8, 0x1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    .line 610
    const-string v2, "up"

    const/4 v3, 0x6

    if-lez v8, :cond_0

    const/4 v4, 0x1

    :goto_1
    const/4 v5, 0x0

    const-string v0, "mr_sheet_ed_row_up"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v9, v6, v7

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$17;

    invoke-direct {v7, p0, v8, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$17;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;IZZLjava/lang/String;Landroid/view/View$OnClickListener;)V

    .line 622
    const-string v2, "down"

    const/4 v3, 0x7

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge v8, v0, :cond_1

    const/4 v4, 0x1

    :goto_2
    const/4 v5, 0x0

    const-string v0, "mr_sheet_ed_row_down"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v9, v6, v7

    .line 623
    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$18;

    invoke-direct {v7, p0, v8, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$18;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    move-object v0, p0

    .line 622
    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;IZZLjava/lang/String;Landroid/view/View$OnClickListener;)V

    .line 634
    const-string v2, "dup"

    const/16 v3, 0x8

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v4, 0x6

    if-ge v0, v4, :cond_2

    const/4 v4, 0x1

    :goto_3
    const/4 v5, 0x0

    const-string v0, "mr_sheet_ed_row_dup"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v9, v6, v7

    .line 635
    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$19;

    invoke-direct {v7, p0, v8, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$19;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    move-object v0, p0

    .line 634
    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;IZZLjava/lang/String;Landroid/view/View$OnClickListener;)V

    .line 646
    const-string v2, "del"

    const/16 v3, 0xd

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v4, 0x1

    if-le v0, v4, :cond_3

    const/4 v4, 0x1

    :goto_4
    const/4 v5, 0x1

    const-string v0, "mr_sheet_ed_row_del"

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object v9, v6, v7

    invoke-direct {p0, v0, v6}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$20;

    invoke-direct {v7, p0, v8, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$20;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;IZZLjava/lang/String;Landroid/view/View$OnClickListener;)V

    .line 661
    invoke-virtual {p1, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 601
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto/16 :goto_0

    .line 610
    :cond_0
    const/4 v4, 0x0

    goto/16 :goto_1

    .line 622
    :cond_1
    const/4 v4, 0x0

    goto :goto_2

    .line 634
    :cond_2
    const/4 v4, 0x0

    goto :goto_3

    .line 646
    :cond_3
    const/4 v4, 0x0

    goto :goto_4

    .line 663
    :cond_4
    return-void
.end method

.method private retargetTestField()V
    .locals 2

    .prologue
    .line 536
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    if-nez v0, :cond_1

    .line 544
    :cond_0
    :goto_0
    return-void

    .line 537
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrSheetTest;->option(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setPrivateImeOptions(Ljava/lang/String;)V

    .line 538
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 540
    :try_start_0
    const-string v0, "input_method"

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 541
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/view/inputmethod/InputMethodManager;->restartInput(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 542
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private rowButton(Landroid/view/View;Ljava/lang/String;IZZLjava/lang/String;Landroid/view/View$OnClickListener;)V
    .locals 4

    .prologue
    .line 668
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 669
    new-instance v2, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    .line 670
    if-nez p4, :cond_0

    const-string v1, "mr_ui_text_dis"

    :goto_0
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v1

    const/high16 v3, 0x41900000    # 18.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v3

    invoke-direct {v2, p0, p3, v1, v3}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 669
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 671
    invoke-virtual {v0, p6}, Landroid/widget/ImageView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 672
    invoke-virtual {v0, p4}, Landroid/widget/ImageView;->setEnabled(Z)V

    .line 673
    if-eqz p4, :cond_2

    .line 674
    invoke-virtual {v0, p7}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 678
    :goto_1
    return-void

    .line 670
    :cond_0
    if-eqz p5, :cond_1

    const-string v1, "mr_ui_danger"

    goto :goto_0

    :cond_1
    const-string v1, "mr_ui_cyan"

    goto :goto_0

    .line 676
    :cond_2
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1
.end method

.method static rowPreview(Lcom/mrkeyboard/app/SheetModel$Row;Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$Row;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/String;"
        }
    .end annotation

    .prologue
    const/16 v6, 0x30

    const/4 v2, 0x0

    .line 584
    if-eqz p0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 595
    :cond_0
    :goto_0
    return-object p2

    .line 585
    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move v1, v2

    .line 586
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_7

    .line 587
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 588
    const-string v4, "spacer"

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    const-string v0, "\u2423"

    .line 589
    :goto_2
    if-eqz v0, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_3

    :cond_2
    const-string v0, "\u2423"

    .line 590
    :cond_3
    const/16 v4, 0xa

    const/16 v5, 0x21b5

    invoke-virtual {v0, v4, v5}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    .line 591
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->length()I

    move-result v4

    if-lez v4, :cond_4

    const-string v4, "  "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 592
    :cond_4
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 593
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->length()I

    move-result v0

    if-le v0, v6, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2, v6}, Ljava/lang/StringBuilder;->substring(II)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\u2026"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    .line 588
    :cond_5
    invoke-static {v0, p1}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    .line 586
    :cond_6
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 595
    :cond_7
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    goto :goto_0
.end method

.method private showAbcMenu(Landroid/view/View;)V
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v1, 0x1

    .line 728
    new-instance v6, Ljava/util/ArrayList;

    invoke-direct {v6, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 729
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xc

    const-string v3, "mr_abc_menu_restore"

    new-array v4, v7, [Ljava/lang/Object;

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v4, v1

    move v5, v1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 730
    const-string v2, "ABC"

    const-string v0, "mr_sheets_main_title"

    new-array v1, v7, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Lcom/mrkeyboard/app/SheetEditorActivity$22;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$22;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v6

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    .line 735
    return-void
.end method

.method private showManageRowsDialog()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 568
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 577
    :goto_0
    return-void

    .line 569
    :cond_0
    const-string v0, "mr_sheet_ed_dialog_rows"

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 570
    const-string v0, "rows_list"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 571
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->renderRows(Landroid/widget/LinearLayout;)V

    .line 572
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheet_ed_rows_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 573
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 574
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_close"

    new-array v2, v4, [Ljava/lang/Object;

    .line 575
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 576
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private showOverflowMenu(Landroid/view/View;)V
    .locals 11

    .prologue
    const/16 v2, 0xc

    const/4 v10, 0x2

    const/4 v9, 0x5

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 683
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 724
    :goto_0
    return-void

    .line 684
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_1

    .line 685
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->showAbcMenu(Landroid/view/View;)V

    goto :goto_0

    .line 688
    :cond_1
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v9}, Ljava/util/ArrayList;-><init>(I)V

    .line 689
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v1, "mr_sheet_ed_menu_rename"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v4, v9, v1}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 690
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v1, 0x9

    const-string v3, "mr_sheet_ed_menu_rows"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v10, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 691
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v0, v2, :cond_2

    .line 692
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x3

    const/16 v3, 0x8

    const-string v5, "mr_sheet_ed_menu_duplicate"

    new-array v8, v6, [Ljava/lang/Object;

    invoke-direct {p0, v5, v8}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v1, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 694
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_3

    .line 695
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x4

    const-string v3, "mr_sheet_ed_menu_restore"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 698
    :cond_3
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xd

    const-string v1, "mr_sheet_ed_menu_delete"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-nez v1, :cond_4

    move v5, v4

    :goto_1
    move v1, v9

    move v4, v10

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 700
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v1, "123"

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    new-instance v5, Lcom/mrkeyboard/app/SheetEditorActivity$21;

    invoke-direct {v5, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$21;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    move-object v0, p0

    move-object v1, p1

    move-object v4, v7

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi;->showPopupMenu(Landroid/content/Context;Landroid/view/View;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Lcom/mrkeyboard/app/SheetUi$OnMenuSelect;)V

    goto/16 :goto_0

    :cond_4
    move v5, v6

    .line 698
    goto :goto_1
.end method

.method private showRenameDialog()V
    .locals 7

    .prologue
    const/4 v3, 0x0

    .line 549
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->busy()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 563
    :goto_0
    return-void

    .line 550
    :cond_0
    const-string v0, "mr_sheets_rename_title"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v0, "mr_sheets_save"

    new-array v2, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v0, "mr_sheet_ed_cancel"

    new-array v3, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    new-instance v6, Lcom/mrkeyboard/app/SheetEditorActivity$16;

    invoke-direct {v6, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$16;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/SheetNameDialog;->show(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/mrkeyboard/app/SheetNameDialog$OnNamed;)Landroid/app/AlertDialog;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    goto :goto_0
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 93
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 94
    if-nez v0, :cond_0

    .line 95
    :goto_0
    return-object p1

    :cond_0
    array-length v1, p2

    if-nez v1, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    :goto_1
    move-object p1, v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_1
.end method

.method private toast(Ljava/lang/String;Z)V
    .locals 1

    .prologue
    .line 117
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 118
    return-void

    .line 117
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 134
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 135
    return-void
.end method

.method busy()Z
    .locals 1

    .prologue
    .line 127
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mDialog:Landroid/app/AlertDialog;

    invoke-virtual {v0}, Landroid/app/AlertDialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    const/4 v1, 0x0

    .line 139
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 140
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "sheet_id"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 141
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 142
    const-string v2, "abc"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 144
    :try_start_0
    invoke-static {p0}, Lcom/mrkeyboard/app/MrAbcKeys;->load(Landroid/content/Context;)Lcom/mrkeyboard/app/MrAbcKeys$Model;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    .line 145
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAbcKeys$Model;->sheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    .line 161
    :cond_0
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v0, :cond_4

    .line 162
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 189
    :goto_2
    return-void

    :cond_1
    move-object v0, v1

    .line 140
    goto :goto_0

    .line 146
    :catch_0
    move-exception v0

    .line 147
    iput-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    .line 148
    iput-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    goto :goto_1

    .line 150
    :cond_2
    if-eqz v0, :cond_3

    .line 151
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCopyById(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 152
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v0, :cond_0

    .line 154
    const-string v0, "mr_sheet_ed_gone"

    new-array v1, v4, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 155
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    goto :goto_2

    .line 158
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    .line 159
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    goto :goto_1

    .line 166
    :cond_4
    const-string v0, "mr_sheet_ed_screen"

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .line 167
    const-string v0, "badge"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    .line 168
    const-string v0, "title"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    .line 169
    const-string v0, "subtitle"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    .line 170
    const-string v0, "undo"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/ImageView;

    .line 171
    const-string v0, "add_row"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    .line 172
    const-string v0, "legend"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mLegend:Landroid/widget/TextView;

    .line 173
    const-string v0, "scroll"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    .line 175
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAbc:Lcom/mrkeyboard/app/MrAbcKeys$Model;

    if-eqz v0, :cond_5

    .line 177
    const-string v0, "hint"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const-string v3, "mr_abc_ed_hint"

    new-array v4, v4, [Ljava/lang/Object;

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 178
    const-string v0, "tools_row"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    .line 180
    :cond_5
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindHeader(Landroid/view/View;)V

    .line 181
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindToolbar(Landroid/view/View;)V

    .line 182
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindGrid(Landroid/view/View;)V

    .line 183
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindLegend()V

    .line 184
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindTestCard(Landroid/view/View;)V

    .line 186
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->setContentView(Landroid/view/View;)V

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 188
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    goto/16 :goto_2
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .prologue
    .line 193
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 195
    return-void
.end method
