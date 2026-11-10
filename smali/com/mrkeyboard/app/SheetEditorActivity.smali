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

.field private static final UNDO_LIMIT:I = 0x14


# instance fields
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

.field private mGridView:Lcom/mrkeyboard/app/SheetGridView;

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

.field private mUndoBtn:Landroid/widget/TextView;

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
    .line 39
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 48
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showRenameDialog()V

    return-void
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->performUndo()V

    return-void
.end method

.method static synthetic access$1000(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    return-void
.end method

.method static synthetic access$1100(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    return-void
.end method

.method static synthetic access$1200(Lcom/mrkeyboard/app/SheetEditorActivity;I)I
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v0

    return v0
.end method

.method static synthetic access$1300(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/EditText;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$1500(Lcom/mrkeyboard/app/SheetEditorActivity;F)I
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v0

    return v0
.end method

.method static synthetic access$1600(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ImageView;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$1700(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;)I
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->drawable(Ljava/lang/String;)I

    move-result v0

    return v0
.end method

.method static synthetic access$1800(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$1900(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestCard:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/view/View;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->showOverflowMenu(Landroid/view/View;)V

    return-void
.end method

.method static synthetic access$2000(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/widget/ScrollView;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    return-object v0
.end method

.method static synthetic access$2100(Lcom/mrkeyboard/app/SheetEditorActivity;)Landroid/view/View;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$2200(Lcom/mrkeyboard/app/SheetEditorActivity;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 1

    .prologue
    .line 39
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object v0
.end method

.method static synthetic access$2202(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Sheet;)Lcom/mrkeyboard/app/SheetModel$Sheet;
    .locals 0

    .prologue
    .line 39
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    return-object p1
.end method

.method static synthetic access$2300(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/LinearLayout;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->renderRows(Landroid/widget/LinearLayout;)V

    return-void
.end method

.method static synthetic access$2400(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->duplicateCurrentSheet()V

    return-void
.end method

.method static synthetic access$2500(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmRestoreDefault()V

    return-void
.end method

.method static synthetic access$2600(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->confirmDeleteCurrentSheet()V

    return-void
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->addRow()V

    return-void
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetEditorActivity;)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->showManageRowsDialog()V

    return-void
.end method

.method static synthetic access$500(Lcom/mrkeyboard/app/SheetEditorActivity;I)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->addNewKeyToRow(I)V

    return-void
.end method

.method static synthetic access$600(Lcom/mrkeyboard/app/SheetEditorActivity;IIII)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/SheetEditorActivity;->handleKeyDragMove(IIII)V

    return-void
.end method

.method static synthetic access$700(Lcom/mrkeyboard/app/SheetEditorActivity;II)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->openKeyEditor(II)V

    return-void
.end method

.method static synthetic access$800(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    .prologue
    .line 39
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$900(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/lang/String;Z)V
    .locals 0

    .prologue
    .line 39
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    return-void
.end method

.method private addNewKeyToRow(I)V
    .locals 8

    .prologue
    const/4 v6, 0x0

    const/4 v3, 0x0

    .line 245
    if-ltz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt p1, v0, :cond_1

    .line 268
    :cond_0
    :goto_0
    return-void

    .line 246
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 247
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v2

    if-lt v1, v2, :cond_2

    .line 248
    const-string v0, "mr_sheet_ed_row_limit"

    new-array v1, v3, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 252
    :cond_2
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    new-instance v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    const-string v4, "text"

    const/high16 v5, 0x3f800000    # 1.0f

    invoke-direct {v2, v6, v4, v6, v5}, Lcom/mrkeyboard/app/SheetModel$KeySpec;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;F)V

    new-instance v7, Lcom/mrkeyboard/app/SheetEditorActivity$9;

    invoke-direct {v7, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$9;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;)V

    move-object v0, p0

    move v4, v3

    move v5, v3

    move v6, v3

    invoke-static/range {v0 .. v7}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    goto :goto_0
.end method

.method private addRow()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 204
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x6

    if-ge v0, v1, :cond_0

    .line 205
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 206
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    new-instance v1, Lcom/mrkeyboard/app/SheetModel$Row;

    invoke-direct {v1}, Lcom/mrkeyboard/app/SheetModel$Row;-><init>()V

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 207
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 211
    :goto_0
    return-void

    .line 210
    :cond_0
    const-string v0, "mr_sheet_ed_rows_limit"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private bindGrid(Landroid/view/View;)V
    .locals 5

    .prologue
    .line 216
    new-instance v0, Lcom/mrkeyboard/app/SheetGridView;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/SheetGridView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    .line 217
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$8;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$8;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V

    .line 234
    const-string v0, "grid_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 235
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x1

    const/4 v4, -0x2

    invoke-direct {v2, v3, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 237
    return-void
.end method

.method private bindHeader(Landroid/view/View;)V
    .locals 7

    .prologue
    const/16 v6, 0x28

    const/4 v5, 0x0

    .line 150
    const-string v0, "back_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 151
    const/4 v1, 0x2

    const-string v2, "mr_ui_text"

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "mr_sheet_ed_back"

    new-array v4, v5, [Ljava/lang/Object;

    .line 152
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 151
    invoke-static {p0, v1, v2, v6, v3}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v1

    .line 153
    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$1;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$1;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 158
    invoke-static {}, Lcom/mrkeyboard/app/SheetEditorActivity;->fill()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 161
    const-string v0, "header_pill"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    .line 162
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$2;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$2;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 168
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$3;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$3;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 174
    const-string v0, "more_slot"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 175
    const/4 v1, 0x1

    const-string v2, "mr_ui_text"

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v2

    const-string v3, "mr_sheet_ed_more"

    new-array v4, v5, [Ljava/lang/Object;

    .line 176
    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 175
    invoke-static {p0, v1, v2, v6, v3}, Lcom/mrkeyboard/app/SheetUi;->makeIconButton(Landroid/content/Context;IIILjava/lang/String;)Landroid/widget/ImageView;

    move-result-object v1

    .line 177
    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$4;

    invoke-direct {v2, p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity$4;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/ImageView;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 182
    invoke-static {}, Lcom/mrkeyboard/app/SheetEditorActivity;->fill()Landroid/widget/LinearLayout$LayoutParams;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 183
    return-void
.end method

.method private bindTestCard(Landroid/view/View;)V
    .locals 7

    .prologue
    const/high16 v5, 0x41400000    # 12.0f

    .line 341
    const-string v0, "test_card"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestCard:Landroid/view/View;

    .line 342
    const-string v0, "test_field_row"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    .line 343
    const-string v0, "test_clear"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    .line 344
    const-string v0, "test_field_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    .line 345
    const-string v0, "test_input"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    .line 346
    const-string v0, "test_badge"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    .line 348
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldIcon:Landroid/widget/ImageView;

    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/4 v2, 0x3

    const-string v3, "mr_ui_text3"

    .line 349
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    const/high16 v4, 0x41b00000    # 22.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {v1, p0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 348
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 350
    const-string v0, "test_clear_icon"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 351
    new-instance v1, Lcom/mrkeyboard/app/SheetUi$IconDrawable;

    const/16 v2, 0xe

    const-string v3, "mr_ui_text3"

    .line 352
    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v3

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->dp(F)I

    move-result v4

    invoke-direct {v1, p0, v2, v3, v4}, Lcom/mrkeyboard/app/SheetUi$IconDrawable;-><init>(Landroid/content/Context;III)V

    .line 351
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 354
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestFieldRow:Landroid/view/View;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$11;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$11;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 366
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$12;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$12;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 381
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$13;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$13;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 390
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestClear:Landroid/view/View;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$14;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$14;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 398
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    .line 399
    const-string v0, "content"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/LinearLayout;

    .line 400
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

    .line 412
    :cond_0
    return-void
.end method

.method private bindToolbar(Landroid/view/View;)V
    .locals 2

    .prologue
    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$5;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$5;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 191
    const-string v0, "rows_btn"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$6;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$6;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 196
    const-string v0, "name_btn"

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$7;

    invoke-direct {v1, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$7;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 201
    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 74
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

    .line 596
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    .line 597
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheet_ed_delete_title"

    new-array v3, v5, [Ljava/lang/Object;

    .line 598
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

    .line 599
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const-string v2, "mr_sheet_ed_delete"

    new-array v3, v5, [Ljava/lang/Object;

    .line 600
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    new-instance v3, Lcom/mrkeyboard/app/SheetEditorActivity$22;

    invoke-direct {v3, p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity$22;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Ljava/util/ArrayList;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v5, [Ljava/lang/Object;

    .line 613
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 614
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 615
    return-void
.end method

.method private confirmRestoreDefault()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 618
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "mr_sheet_ed_restore_title"

    new-array v2, v3, [Ljava/lang/Object;

    .line 619
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_restore_msg"

    new-array v2, v3, [Ljava/lang/Object;

    .line 620
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_restore"

    new-array v2, v3, [Ljava/lang/Object;

    .line 621
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/mrkeyboard/app/SheetEditorActivity$23;

    invoke-direct {v2, p0}, Lcom/mrkeyboard/app/SheetEditorActivity$23;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v3, [Ljava/lang/Object;

    .line 632
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 633
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 634
    return-void
.end method

.method private dp(F)I
    .locals 1

    .prologue
    .line 88
    invoke-static {p0, p1}, Lcom/mrkeyboard/app/SheetUi;->dp(Landroid/content/Context;F)I

    move-result v0

    return v0
.end method

.method private drawable(Ljava/lang/String;)I
    .locals 3

    .prologue
    .line 84
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
    const/4 v2, 0x0

    .line 570
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v4

    .line 571
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0xc

    if-lt v0, v1, :cond_0

    .line 572
    const-string v0, "mr_sheet_ed_limit_sheets"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 593
    :goto_0
    return-void

    .line 575
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v5

    .line 576
    const-string v0, "copy"

    invoke-static {v4, v0}, Lcom/mrkeyboard/app/SheetModel;->makeUniqueId(Ljava/util/List;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    .line 577
    iput-boolean v2, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    .line 578
    const-string v0, "mr_sheet_ed_copy_suffix"

    const/4 v1, 0x1

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

    .line 579
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v3

    move v1, v2

    .line 580
    :goto_1
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_2

    .line 581
    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    iget-object v6, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v6, v6, Lcom/mrkeyboard/app/SheetModel$Sheet;->id:Ljava/lang/String;

    invoke-virtual {v0, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 582
    add-int/lit8 v0, v1, 0x1

    .line 586
    :goto_2
    invoke-virtual {v4, v0, v5}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 587
    invoke-static {p0, v4}, Lcom/mrkeyboard/app/SheetStore;->save(Landroid/content/Context;Ljava/util/List;)Z

    .line 588
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 589
    invoke-virtual {v5}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 590
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 591
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 592
    const-string v0, "mr_sheet_ed_duplicated"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0

    .line 580
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

    .line 96
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v1, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    return-object v0
.end method

.method private handleKeyDragMove(IIII)V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 318
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

    .line 336
    :cond_0
    :goto_0
    return-void

    .line 319
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 320
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 321
    if-ltz p2, :cond_0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge p2, v2, :cond_0

    .line 322
    if-ne p1, p3, :cond_3

    .line 324
    if-le p4, p2, :cond_2

    add-int/lit8 p4, p4, -0x1

    .line 325
    :cond_2
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-static {v1, p4}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 326
    if-eq v1, p2, :cond_0

    .line 327
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 328
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    invoke-virtual {v2, v1, v0}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 329
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    goto :goto_0

    .line 332
    :cond_3
    iget-object v2, v1, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    invoke-direct {p0, p3}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v3

    if-ge v2, v3, :cond_0

    .line 333
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->pushUndoSnapshot()V

    .line 334
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

    .line 335
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    goto :goto_0
.end method

.method private inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    .prologue
    .line 78
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "layout"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

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

.method private maxKeysOfRow(I)I
    .locals 1

    .prologue
    .line 241
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

.method private openKeyEditor(II)V
    .locals 11

    .prologue
    const/4 v0, 0x0

    const/4 v9, 0x1

    .line 271
    if-ltz p1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt p1, v1, :cond_1

    .line 314
    :cond_0
    :goto_0
    return-void

    .line 272
    :cond_1
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 273
    if-ltz p2, :cond_0

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge p2, v1, :cond_0

    .line 274
    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 275
    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->maxKeysOfRow(I)I

    move-result v3

    if-ge v1, v3, :cond_2

    move v8, v9

    .line 276
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
    new-instance v0, Lcom/mrkeyboard/app/SheetEditorActivity$10;

    move-object v1, p0

    move v3, p2

    move v4, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetEditorActivity$10;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Lcom/mrkeyboard/app/SheetModel$Row;IILcom/mrkeyboard/app/SheetModel$KeySpec;)V

    move-object v3, p0

    move-object v4, v10

    move-object v10, v0

    invoke-static/range {v3 .. v10}, Lcom/mrkeyboard/app/KeyEditDialog;->show(Landroid/content/Context;Ljava/util/List;Lcom/mrkeyboard/app/SheetModel$KeySpec;ZZZZLcom/mrkeyboard/app/KeyEditDialog$OnKeyActionListener;)V

    goto :goto_0

    :cond_2
    move v8, v0

    .line 275
    goto :goto_1

    :cond_3
    move v6, v0

    .line 276
    goto :goto_2

    :cond_4
    move v7, v0

    goto :goto_3
.end method

.method private performUndo()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 646
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 647
    const-string v0, "mr_sheet_ed_nothing_undo"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    .line 653
    :goto_0
    return-void

    .line 650
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

    .line 651
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->persistAndRefresh()V

    .line 652
    const-string v0, "mr_sheet_ed_undone"

    new-array v1, v2, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->toast(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method private persistAndRefresh()V
    .locals 1

    .prologue
    .line 656
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->updateSingleSheet(Landroid/content/Context;Lcom/mrkeyboard/app/SheetModel$Sheet;)Z

    .line 657
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 658
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    .line 659
    return-void
.end method

.method private pushUndoSnapshot()V
    .locals 2

    .prologue
    .line 639
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x14

    if-lt v0, v1, :cond_0

    .line 640
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 642
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 643
    return-void
.end method

.method private refreshUi()V
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v6, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    .line 662
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v2, "123"

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 663
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 664
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 665
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    const-string v3, "mr_sheet_ed_subtitle"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v5, v5, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v5}, Lcom/mrkeyboard/app/SheetModel$Sheet;->countKeys()I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-direct {p0, v3, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 666
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoStack:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_2

    const v0, 0x3ecccccd    # 0.4f

    :goto_0
    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setAlpha(F)V

    .line 667
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x6

    if-lt v3, v4, :cond_0

    const v1, 0x3ee66666    # 0.45f

    :cond_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setAlpha(F)V

    .line 668
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    if-eqz v0, :cond_1

    .line 669
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestLiveBadge:Landroid/widget/TextView;

    const-string v1, "mr_sheet_ed_live"

    new-array v3, v7, [Ljava/lang/Object;

    aput-object v2, v3, v6

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 671
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mGridView:Lcom/mrkeyboard/app/SheetGridView;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V

    .line 672
    return-void

    :cond_2
    move v0, v1

    .line 666
    goto :goto_0
.end method

.method private renderRows(Landroid/widget/LinearLayout;)V
    .locals 9

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 456
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->removeAllViews()V

    move v2, v3

    .line 457
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v2, v0, :cond_4

    .line 459
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 460
    const-string v1, "mr_sheet_ed_row_item"

    invoke-direct {p0, v1, p1}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v5

    .line 461
    const-string v1, "label"

    invoke-virtual {v5, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const-string v6, "mr_sheet_ed_row_line"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    add-int/lit8 v8, v2, 0x1

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v3

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    aput-object v0, v7, v4

    invoke-direct {p0, v6, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 463
    const-string v1, "up"

    if-lez v2, :cond_0

    move v0, v4

    :goto_1
    invoke-direct {p0, v5, v1, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v0

    .line 464
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$17;

    invoke-direct {v1, p0, v2, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$17;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 475
    const-string v1, "down"

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    if-ge v2, v0, :cond_1

    move v0, v4

    :goto_2
    invoke-direct {p0, v5, v1, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v0

    .line 476
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$18;

    invoke-direct {v1, p0, v2, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$18;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 487
    const-string v1, "dup"

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v6, 0x6

    if-ge v0, v6, :cond_2

    move v0, v4

    :goto_3
    invoke-direct {p0, v5, v1, v0, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v0

    .line 488
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$19;

    invoke-direct {v1, p0, v2, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$19;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 499
    const-string v1, "del"

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-le v0, v4, :cond_3

    move v0, v4

    :goto_4
    invoke-direct {p0, v5, v1, v0, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->rowButton(Landroid/view/View;Ljava/lang/String;ZZ)Landroid/widget/TextView;

    move-result-object v0

    .line 500
    new-instance v1, Lcom/mrkeyboard/app/SheetEditorActivity$20;

    invoke-direct {v1, p0, v2, p1}, Lcom/mrkeyboard/app/SheetEditorActivity$20;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;ILandroid/widget/LinearLayout;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 511
    invoke-virtual {p1, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 457
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto/16 :goto_0

    :cond_0
    move v0, v3

    .line 463
    goto :goto_1

    :cond_1
    move v0, v3

    .line 475
    goto :goto_2

    :cond_2
    move v0, v3

    .line 487
    goto :goto_3

    :cond_3
    move v0, v3

    .line 499
    goto :goto_4

    .line 513
    :cond_4
    return-void
.end method

.method private rowButton(Landroid/view/View;Ljava/lang/String;ZZ)Landroid/widget/TextView;
    .locals 2

    .prologue
    .line 517
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    .line 518
    invoke-virtual {v0, p3}, Landroid/widget/TextView;->setEnabled(Z)V

    .line 519
    if-nez p3, :cond_0

    .line 520
    const-string v1, "mr_ui_text_dis"

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 521
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 525
    :goto_0
    return-object v0

    .line 523
    :cond_0
    if-eqz p4, :cond_1

    const-string v1, "mr_ui_danger"

    :goto_1
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->color(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_0

    :cond_1
    const-string v1, "mr_ui_cyan"

    goto :goto_1
.end method

.method private showManageRowsDialog()V
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x0

    .line 444
    const-string v0, "mr_sheet_ed_dialog_rows"

    invoke-direct {p0, v0, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 445
    const-string v0, "rows_list"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    .line 446
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetEditorActivity;->renderRows(Landroid/widget/LinearLayout;)V

    .line 447
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v2, "mr_sheet_ed_rows_title"

    new-array v3, v4, [Ljava/lang/Object;

    .line 448
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 449
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_close"

    new-array v2, v4, [Ljava/lang/Object;

    .line 450
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 451
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 452
    return-void
.end method

.method private showOverflowMenu(Landroid/view/View;)V
    .locals 11

    .prologue
    const/16 v2, 0xc

    const/4 v10, 0x2

    const/4 v9, 0x5

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 531
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7, v9}, Ljava/util/ArrayList;-><init>(I)V

    .line 532
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const-string v1, "mr_sheet_ed_menu_rename"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v4, v9, v1}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 533
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v1, 0x9

    const-string v3, "mr_sheet_ed_menu_rows"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v0, v10, v1, v3}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 534
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge v0, v2, :cond_0

    .line 535
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x3

    const/16 v3, 0x8

    const-string v5, "mr_sheet_ed_menu_duplicate"

    new-array v8, v6, [Ljava/lang/Object;

    invoke-direct {p0, v5, v8}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v1, v3, v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 537
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-eqz v0, :cond_1

    .line 538
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/4 v1, 0x4

    const-string v3, "mr_sheet_ed_menu_restore"

    new-array v5, v6, [Ljava/lang/Object;

    invoke-direct {p0, v3, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    move v5, v4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 541
    :cond_1
    new-instance v0, Lcom/mrkeyboard/app/SheetUi$MenuEntry;

    const/16 v2, 0xd

    const-string v1, "mr_sheet_ed_menu_delete"

    new-array v3, v6, [Ljava/lang/Object;

    invoke-direct {p0, v1, v3}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-boolean v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->builtin:Z

    if-nez v1, :cond_2

    move v5, v4

    :goto_0
    move v1, v9

    move v4, v10

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetUi$MenuEntry;-><init>(IILjava/lang/String;IZ)V

    invoke-virtual {v7, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 543
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

    .line 567
    return-void

    :cond_2
    move v5, v6

    .line 541
    goto :goto_0
.end method

.method private showRenameDialog()V
    .locals 8

    .prologue
    const/4 v7, 0x0

    const/4 v4, 0x1

    const/4 v6, 0x0

    .line 417
    const-string v0, "mr_sheet_ed_dialog_fields"

    invoke-direct {p0, v0, v7}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1

    .line 418
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-static {p0, v0, v4}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v2

    .line 419
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->name:Ljava/lang/String;

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 420
    const-string v0, "name_slot"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 421
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-static {p0, v0, v4}, Lcom/mrkeyboard/app/SheetUi;->makeEditText(Landroid/content/Context;Ljava/lang/String;Z)Landroid/widget/EditText;

    move-result-object v3

    .line 422
    new-array v0, v4, [Landroid/text/InputFilter;

    new-instance v4, Landroid/text/InputFilter$LengthFilter;

    const/4 v5, 0x5

    invoke-direct {v4, v5}, Landroid/text/InputFilter$LengthFilter;-><init>(I)V

    aput-object v4, v0, v6

    invoke-virtual {v3, v0}, Landroid/widget/EditText;->setFilters([Landroid/text/InputFilter;)V

    .line 423
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    invoke-virtual {v3, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 424
    const-string v0, "badge_slot"

    invoke-virtual {v1, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 426
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v4, "mr_sheet_ed_rename_title"

    new-array v5, v6, [Ljava/lang/Object;

    .line 427
    invoke-direct {p0, v4, v5}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 428
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_save"

    new-array v4, v6, [Ljava/lang/Object;

    .line 429
    invoke-direct {p0, v1, v4}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    new-instance v4, Lcom/mrkeyboard/app/SheetEditorActivity$16;

    invoke-direct {v4, p0, v2, v3}, Lcom/mrkeyboard/app/SheetEditorActivity$16;-><init>(Lcom/mrkeyboard/app/SheetEditorActivity;Landroid/widget/EditText;Landroid/widget/EditText;)V

    invoke-virtual {v0, v1, v4}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "mr_sheet_ed_cancel"

    new-array v2, v6, [Ljava/lang/Object;

    .line 437
    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, v7}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 438
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 439
    return-void
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 68
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getPackageName()Ljava/lang/String;

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
    .line 92
    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 93
    return-void

    .line 92
    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 104
    invoke-static {p1}, Lcom/mrkeyboard/app/UiLocale;->wrap(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-super {p0, v0}, Landroid/app/Activity;->attachBaseContext(Landroid/content/Context;)V

    .line 105
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .prologue
    const/4 v1, 0x0

    .line 109
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 110
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v2, "sheet_id"

    invoke-virtual {v0, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 111
    :goto_0
    invoke-static {p0}, Lcom/mrkeyboard/app/SheetStore;->getEditableCopy(Landroid/content/Context;)Ljava/util/ArrayList;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    .line 112
    if-eqz v0, :cond_0

    .line 113
    invoke-static {p0, v0}, Lcom/mrkeyboard/app/SheetStore;->getSheetCopyById(Landroid/content/Context;Ljava/lang/String;)Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 115
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 116
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAllSheets:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Sheet;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/SheetModel$Sheet;->deepCopy()Lcom/mrkeyboard/app/SheetModel$Sheet;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 118
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v0, :cond_3

    .line 119
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->finish()V

    .line 139
    :goto_1
    return-void

    :cond_2
    move-object v0, v1

    .line 110
    goto :goto_0

    .line 123
    :cond_3
    const-string v0, "mr_sheet_ed_screen"

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetEditorActivity;->inflate(Ljava/lang/String;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .line 124
    const-string v0, "badge"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mBadgeChip:Landroid/widget/TextView;

    .line 125
    const-string v0, "title"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTitleView:Landroid/widget/TextView;

    .line 126
    const-string v0, "subtitle"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mSubtitleView:Landroid/widget/TextView;

    .line 127
    const-string v0, "undo"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mUndoBtn:Landroid/widget/TextView;

    .line 128
    const-string v0, "add_row"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mAddRowBtn:Landroid/widget/TextView;

    .line 129
    const-string v0, "scroll"

    invoke-virtual {v2, v0}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ScrollView;

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mScrollView:Landroid/widget/ScrollView;

    .line 131
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindHeader(Landroid/view/View;)V

    .line 132
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindToolbar(Landroid/view/View;)V

    .line 133
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindGrid(Landroid/view/View;)V

    .line 134
    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->bindTestCard(Landroid/view/View;)V

    .line 136
    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/SheetEditorActivity;->setContentView(Landroid/view/View;)V

    .line 137
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->restore(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 138
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetEditorActivity;->refreshUi()V

    goto :goto_1
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    .prologue
    .line 143
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 144
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetEditorActivity;->mTestInput:Landroid/widget/EditText;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrScreenIme;->save(Landroid/os/Bundle;Landroid/widget/EditText;Landroid/widget/EditText;)V

    .line 145
    return-void
.end method
