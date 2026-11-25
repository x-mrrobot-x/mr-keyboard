.class public Lcom/mrkeyboard/app/SheetGridView;
.super Landroid/view/View;
.source "SheetGridView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SheetGridView$CellHit;,
        Lcom/mrkeyboard/app/SheetGridView$GridListener;
    }
.end annotation


# static fields
.field private static final BOTTOM_WEIGHTS:[F


# instance fields
.field private final cAccent:I

.field private final cAddFill:I

.field private final cAddPressedFill:I

.field private final cAddStroke:I

.field private final cBg:I

.field private final cDashed:I

.field private final cDragFill:I

.field private final cGhostFill:I

.field private final cKeyFill:I

.field private final cKeyLabel:I

.field private final cKeyStroke:I

.field private final cLockGlyph:I

.field private final cLockHole:I

.field private final cLockedFill:I

.field private final cLockedLabel:I

.field private final cLockedStroke:I

.field private final cPressedFill:I

.field private final cSheetFill:I

.field private final cSheetLabel:I

.field private final cSheetStroke:I

.field private final cSpacerDragFill:I

.field private final cSpacerFill:I

.field private final cSpacerLabel:I

.field private final cSpecialFill:I

.field private final cSpecialStroke:I

.field private final cTaskerFill:I

.field private final cTaskerLabel:I

.field private final cTaskerStroke:I

.field private final cTrayStroke:I

.field private final cWidthBadge:I

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

.field private final mBadgePaint:Landroid/graphics/Paint;

.field private final mBgPaint:Landroid/graphics/Paint;

.field private final mBoundsRect:Landroid/graphics/RectF;

.field private final mCells:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetGridView$CellHit;",
            ">;"
        }
    .end annotation
.end field

.field private mCellsDirty:Z

.field private final mDashedPaint:Landroid/graphics/Paint;

.field private final mDensity:F

.field private mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

.field private mDownX:F

.field private mDownY:F

.field private mDragging:Z

.field private mDropIndex:I

.field private mDropLineBottom:F

.field private final mDropLinePaint:Landroid/graphics/Paint;

.field private mDropLineTop:F

.field private mDropLineX:F

.field private mDropRow:I

.field private final mFontMetrics:Landroid/graphics/Paint$FontMetrics;

.field private final mGhostFillPaint:Landroid/graphics/Paint;

.field private final mGhostRect:Landroid/graphics/RectF;

.field private final mHandler:Landroid/os/Handler;

.field private final mKeyFillPaint:Landroid/graphics/Paint;

.field private final mKeyStrokePaint:Landroid/graphics/Paint;

.field private final mLabelPaint:Landroid/graphics/Paint;

.field private mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

.field private final mLockBodyPaint:Landroid/graphics/Paint;

.field private final mLockRect:Landroid/graphics/RectF;

.field private final mLockShacklePaint:Landroid/graphics/Paint;

.field private final mLongPressRunnable:Ljava/lang/Runnable;

.field private mMoveX:F

.field private mMoveY:F

.field private mRefusedRow:I

.field private final mRes:Landroid/content/res/Resources;

.field private final mRowHitsScratch:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Lcom/mrkeyboard/app/SheetGridView$CellHit;",
            ">;"
        }
    .end annotation
.end field

.field private mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

.field private final mTouchSlop:I

.field private final mTrayStrokePaint:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 38
    const/4 v0, 0x5

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/SheetGridView;->BOTTOM_WEIGHTS:[F

    return-void

    nop

    :array_0
    .array-data 4
        0x3e4ccccd    # 0.2f
        0x3dcccccd    # 0.1f
        0x3ecccccd    # 0.4f
        0x3dcccccd    # 0.1f
        0x3e4ccccd    # 0.2f
    .end array-data
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 7

    .prologue
    const/high16 v6, 0x40400000    # 3.0f

    const/4 v3, -0x1

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v5, 0x1

    .line 134
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 64
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x48

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    .line 65
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    .line 66
    iput-boolean v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 82
    new-instance v0, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 83
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    .line 84
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    .line 85
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    .line 93
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 94
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 96
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    .line 97
    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 135
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    .line 136
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    .line 137
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    .line 138
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    .line 140
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cBg:I

    .line 141
    const-string v0, "mr_ui_stroke"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTrayStroke:I

    .line 142
    const-string v0, "mr_ui_raised"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyFill:I

    .line 143
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyStroke:I

    .line 144
    const-string v0, "mr_ui_text"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    .line 145
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cPressedFill:I

    .line 146
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cDragFill:I

    .line 147
    const-string v0, "mr_ui_blue_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetFill:I

    .line 148
    const-string v0, "mr_ui_blue_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetStroke:I

    .line 149
    const-string v0, "mr_ui_blue"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetLabel:I

    .line 150
    const-string v0, "mr_ui_amber_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerFill:I

    .line 151
    const-string v0, "mr_ui_amber_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerStroke:I

    .line 152
    const-string v0, "mr_ui_amber"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerLabel:I

    .line 153
    const-string v0, "mr_ui_violet_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialFill:I

    .line 154
    const-string v0, "mr_ui_violet_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialStroke:I

    .line 155
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerFill:I

    .line 156
    const-string v0, "mr_ui_bg"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerDragFill:I

    .line 157
    const-string v0, "mr_ui_text3"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    .line 158
    const-string v0, "mr_ui_text_dis"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cDashed:I

    .line 159
    const-string v0, "mr_ui_cyan"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    .line 160
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddFill:I

    .line 161
    const-string v0, "mr_ui_cyan_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddPressedFill:I

    .line 162
    const-string v0, "mr_ui_cyan_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddStroke:I

    .line 163
    const-string v0, "mr_ui_faint"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedFill:I

    .line 164
    const-string v0, "mr_ui_stroke"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedStroke:I

    .line 165
    const-string v0, "mr_ui_text3"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedLabel:I

    .line 166
    const-string v0, "mr_ui_slate"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    .line 167
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    .line 168
    const-string v0, "mr_ui_raised"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cGhostFill:I

    .line 169
    const-string v0, "mr_ui_text2"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cWidthBadge:I

    .line 171
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    .line 172
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    .line 173
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    .line 174
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    .line 175
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    .line 176
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    .line 177
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    .line 178
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    .line 179
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    .line 180
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    .line 181
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    .line 183
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 184
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cBg:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 188
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cTrayStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    const v1, 0x3f99999a    # 1.2f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 195
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cDashed:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 196
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/DashPathEffect;

    const/4 v2, 0x2

    new-array v2, v2, [F

    const/4 v3, 0x0

    const/high16 v4, 0x40800000    # 4.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    aput v4, v2, v3

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    aput v3, v2, v5

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Landroid/graphics/DashPathEffect;-><init>([FF)V

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 199
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 201
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 202
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41080000    # 8.5f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 203
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 205
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 206
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 207
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 209
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 210
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cGhostFill:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 212
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 213
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 214
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 215
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 217
    new-instance v0, Lcom/mrkeyboard/app/SheetGridView$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/SheetGridView$1;-><init>(Lcom/mrkeyboard/app/SheetGridView;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    .line 228
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .locals 1

    .prologue
    .line 36
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    return-object v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetGridView;)Z
    .locals 1

    .prologue
    .line 36
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return v0
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/SheetGridView;Z)Z
    .locals 0

    .prologue
    .line 36
    iput-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return p1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetGridView;)F
    .locals 1

    .prologue
    .line 36
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    return v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetGridView;)F
    .locals 1

    .prologue
    .line 36
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    return v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetGridView;FF)V
    .locals 0

    .prologue
    .line 36
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 234
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    const-string v2, "color"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, p1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getColor(I)I

    move-result v0

    return v0
.end method

.method private computeDropTarget(FF)V
    .locals 13

    .prologue
    const/high16 v12, 0x41200000    # 10.0f

    const/high16 v11, 0x40000000    # 2.0f

    const/4 v10, -0x1

    const/4 v4, 0x0

    .line 547
    iput v10, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    .line 548
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 608
    :cond_0
    :goto_0
    return-void

    .line 549
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x6

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 550
    invoke-direct {p0, v12}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v6

    .line 551
    const/high16 v0, 0x42400000    # 48.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v7

    .line 552
    const/high16 v0, 0x40a00000    # 5.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v8

    .line 556
    const v1, 0x7f7fffff    # Float.MAX_VALUE

    move v2, v4

    move v3, v4

    .line 557
    :goto_1
    if-ge v2, v5, :cond_2

    .line 558
    int-to-float v0, v2

    add-float v9, v7, v8

    mul-float/2addr v0, v9

    add-float/2addr v0, v6

    const/high16 v9, 0x3f000000    # 0.5f

    mul-float/2addr v9, v7

    add-float/2addr v0, v9

    sub-float v0, p2, v0

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    .line 559
    cmpg-float v9, v0, v1

    if-gez v9, :cond_b

    move v1, v2

    .line 557
    :goto_2
    add-int/lit8 v2, v2, 0x1

    move v3, v1

    move v1, v0

    goto :goto_1

    .line 566
    :cond_2
    add-int/lit8 v0, v5, -0x1

    if-ne v3, v0, :cond_3

    const/16 v0, 0x9

    move v1, v0

    .line 567
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 568
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-eq v3, v2, :cond_4

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt v0, v1, :cond_4

    .line 569
    iput v10, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 570
    iput v10, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 571
    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 572
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    goto :goto_0

    .line 566
    :cond_3
    const/16 v0, 0xa

    move v1, v0

    goto :goto_3

    .line 576
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 577
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    move v1, v4

    .line 578
    :goto_4
    if-ge v1, v2, :cond_6

    .line 579
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 580
    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v5, :cond_5

    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-ne v5, v3, :cond_5

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 578
    :cond_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_4

    .line 583
    :cond_6
    int-to-float v0, v3

    add-float v1, v8, v7

    mul-float/2addr v0, v1

    add-float/2addr v0, v6

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    .line 584
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    add-float/2addr v0, v7

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    .line 585
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 587
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 588
    iput v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 589
    invoke-direct {p0, v12}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    goto/16 :goto_0

    .line 594
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 595
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    move v1, v4

    .line 596
    :goto_5
    if-ge v1, v3, :cond_a

    .line 597
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 598
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v4}, Landroid/graphics/RectF;->centerX()F

    move-result v4

    cmpg-float v4, p1, v4

    if-gez v4, :cond_9

    .line 599
    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->left:F

    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    sub-float/2addr v0, v2

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 604
    :goto_6
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ne v1, v0, :cond_8

    .line 605
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->right:F

    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v0, v2

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 607
    :cond_8
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    goto/16 :goto_0

    .line 596
    :cond_9
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    :cond_a
    move v1, v2

    goto :goto_6

    :cond_b
    move v0, v1

    move v1, v3

    goto/16 :goto_2
.end method

.method private static countKeys(Lcom/mrkeyboard/app/SheetModel$Sheet;)I
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 272
    move v1, v0

    move v2, v0

    .line 273
    :goto_0
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v1, v0, :cond_0

    const/4 v0, 0x6

    if-ge v1, v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/2addr v2, v0

    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 274
    :cond_0
    return v2
.end method

.method private dp(F)F
    .locals 1

    .prologue
    .line 250
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    mul-float/2addr v0, p1

    return v0
.end method

.method private drawAddCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZ)V
    .locals 3

    .prologue
    .line 414
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz p4, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddPressedFill:I

    :goto_0
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 415
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 416
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 417
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 418
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 419
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v2, 0x1

    if-gt v0, v2, :cond_1

    const/high16 v0, 0x41880000    # 17.0f

    :goto_1
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 420
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 421
    return-void

    .line 414
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddFill:I

    goto :goto_0

    .line 419
    :cond_1
    const/high16 v0, 0x41480000    # 12.5f

    goto :goto_1
.end method

.method private drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V
    .locals 3

    .prologue
    .line 494
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {p4, v0}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 495
    invoke-virtual {p3}, Landroid/graphics/RectF;->centerY()F

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v1, v1, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v2, v2, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr v1, v2

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float/2addr v1, v2

    sub-float/2addr v0, v1

    .line 496
    invoke-virtual {p3}, Landroid/graphics/RectF;->centerX()F

    move-result v1

    invoke-virtual {p1, p2, v1, v0, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 497
    return-void
.end method

.method private drawKeyCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZZ)V
    .locals 7

    .prologue
    const/high16 v6, 0x40400000    # 3.0f

    .line 425
    iget-object v2, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 426
    const-string v0, "spacer"

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 427
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerDragFill:I

    :goto_0
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 428
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 429
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 430
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 431
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 432
    const-string v0, "\u2423"

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 477
    :cond_0
    :goto_1
    return-void

    .line 427
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerFill:I

    goto :goto_0

    .line 435
    :cond_2
    const-string v0, "sheet"

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    .line 436
    const-string v0, "tasker"

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    .line 437
    const-string v0, "special"

    iget-object v1, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    .line 440
    if-eqz p5, :cond_4

    .line 441
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cDragFill:I

    .line 442
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    .line 459
    :goto_2
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 460
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 461
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 462
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 464
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 465
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/4 v5, 0x2

    if-gt v0, v5, :cond_9

    const/high16 v0, 0x41680000    # 14.5f

    :goto_3
    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 466
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_b

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    :goto_4
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 467
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v3}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 469
    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasAnyPopup()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 470
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 471
    const-string v0, "\u2022\u2022\u2022"

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->right:F

    const/high16 v2, 0x40800000    # 4.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    sub-float/2addr v1, v2

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->top:F

    const/high16 v3, 0x41100000    # 9.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    add-float/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 473
    :cond_3
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v0}, Landroid/graphics/RectF;->width()F

    move-result v0

    const/high16 v1, 0x41e00000    # 28.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    .line 474
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cWidthBadge:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 475
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->right:F

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    sub-float/2addr v1, v2

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->bottom:F

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    sub-float/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto/16 :goto_1

    .line 443
    :cond_4
    if-eqz p4, :cond_5

    .line 444
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cPressedFill:I

    .line 445
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    goto/16 :goto_2

    .line 446
    :cond_5
    if-eqz v3, :cond_6

    .line 447
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetFill:I

    .line 448
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetStroke:I

    goto/16 :goto_2

    .line 449
    :cond_6
    if-eqz v4, :cond_7

    .line 450
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerFill:I

    .line 451
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerStroke:I

    goto/16 :goto_2

    .line 452
    :cond_7
    if-eqz v0, :cond_8

    .line 453
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialFill:I

    .line 454
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialStroke:I

    goto/16 :goto_2

    .line 456
    :cond_8
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyFill:I

    .line 457
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyStroke:I

    goto/16 :goto_2

    .line 465
    :cond_9
    const/4 v5, 0x4

    if-gt v0, v5, :cond_a

    const/high16 v0, 0x41400000    # 12.0f

    goto/16 :goto_3

    :cond_a
    const/high16 v0, 0x41280000    # 10.5f

    goto/16 :goto_3

    .line 466
    :cond_b
    if-eqz v3, :cond_c

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetLabel:I

    goto/16 :goto_4

    :cond_c
    if-eqz v4, :cond_d

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTaskerLabel:I

    goto/16 :goto_4

    :cond_d
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    goto/16 :goto_4
.end method

.method private drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V
    .locals 11

    .prologue
    const/high16 v2, 0x43340000    # 180.0f

    .line 501
    iget v0, p2, Landroid/graphics/RectF;->right:F

    const v1, 0x401ccccd    # 2.45f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    sub-float v6, v0, v1

    .line 502
    const v0, 0x40f66666    # 7.7f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    sub-float v7, v6, v0

    .line 503
    const v0, 0x40766666    # 3.85f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v8, v7, v0

    .line 504
    iget v9, p2, Landroid/graphics/RectF;->top:F

    .line 506
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 507
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    const v1, 0x3fa147ae    # 1.26f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 508
    const v0, 0x4011999a    # 2.275f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v10

    .line 509
    const v0, 0x40d4cccd    # 6.65f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float/2addr v0, v9

    .line 510
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    sub-float v3, v8, v10

    const v4, 0x40066666    # 2.1f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    add-float/2addr v4, v9

    add-float v5, v8, v10

    invoke-virtual {v1, v3, v4, v5, v0}, Landroid/graphics/RectF;->set(FFFF)V

    .line 511
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v2

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 513
    const/high16 v0, 0x408c0000    # 4.375f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v2, v0, v9

    .line 514
    const v0, 0x40ce147b    # 6.44f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v4, v0, v9

    .line 515
    sub-float v1, v8, v10

    .line 516
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 517
    add-float v1, v8, v10

    .line 518
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 520
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    const v1, 0x40c51eb8    # 6.16f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    add-float/2addr v1, v9

    const v2, 0x413e6666    # 11.9f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    invoke-virtual {v0, v7, v1, v6, v2}, Landroid/graphics/RectF;->set(FFFF)V

    .line 521
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 522
    const v0, 0x3fb33333    # 1.4f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    .line 523
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 526
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 527
    const v0, 0x41066666    # 8.4f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float/2addr v0, v9

    const/high16 v1, 0x3f600000    # 0.875f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v0, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 528
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 529
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    const v1, 0x3f81eb85    # 1.015f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 530
    const v0, 0x410ae148    # 8.68f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v2, v0, v9

    const v0, 0x4126e148    # 10.43f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v4, v0, v9

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v1, v8

    move v3, v8

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 531
    return-void
.end method

.method private drawLockedCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;F)V
    .locals 5

    .prologue
    .line 481
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedFill:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 482
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 483
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 484
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 485
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 486
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41480000    # 12.5f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 488
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->left:F

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->top:F

    const/high16 v3, 0x40d00000    # 6.5f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    add-float/2addr v2, v3

    iget-object v3, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v3, v3, Landroid/graphics/RectF;->right:F

    iget-object v4, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/graphics/RectF;->set(FFFF)V

    .line 489
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 490
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-direct {p0, p1, v0}, Lcom/mrkeyboard/app/SheetGridView;->drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V

    .line 491
    return-void
.end method

.method private ensureCellsBuilt()V
    .locals 26

    .prologue
    .line 296
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    if-nez v2, :cond_1

    .line 361
    :cond_0
    return-void

    .line 297
    :cond_1
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 298
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 299
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v2, :cond_0

    .line 300
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getWidth()I

    move-result v3

    .line 301
    if-lez v3, :cond_0

    .line 303
    const/high16 v2, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v13

    .line 304
    const/high16 v2, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    .line 305
    const/high16 v4, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v18

    .line 306
    const/high16 v4, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v19

    .line 307
    const/high16 v4, 0x42400000    # 48.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v20

    .line 308
    const/high16 v4, 0x41200000    # 10.0f

    int-to-float v3, v3

    const/high16 v5, 0x40000000    # 2.0f

    mul-float/2addr v5, v13

    sub-float/2addr v3, v5

    invoke-static {v4, v3}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 309
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x6

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v21

    .line 311
    const/4 v4, 0x0

    move/from16 v17, v2

    :goto_0
    move/from16 v0, v21

    if-ge v4, v0, :cond_e

    .line 312
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    move-object v9, v2

    check-cast v9, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 313
    add-int/lit8 v2, v21, -0x1

    if-ne v4, v2, :cond_2

    const/4 v2, 0x1

    move/from16 v16, v2

    .line 314
    :goto_1
    if-eqz v16, :cond_3

    const/16 v2, 0x9

    .line 315
    :goto_2
    iget-object v3, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v3, v2, :cond_4

    const/4 v2, 0x1

    move v15, v2

    .line 316
    :goto_3
    if-eqz v15, :cond_5

    const/high16 v2, 0x41f00000    # 30.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    move v14, v2

    .line 317
    :goto_4
    if-eqz v15, :cond_6

    const/high16 v2, 0x41a00000    # 20.0f

    sub-float v3, v10, v14

    sub-float v3, v3, v18

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move v3, v2

    .line 319
    :goto_5
    const/4 v5, 0x0

    .line 320
    const/4 v2, 0x0

    move v6, v5

    move v5, v2

    :goto_6
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v5, v2, :cond_7

    .line 321
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v2

    add-float/2addr v6, v2

    .line 320
    add-int/lit8 v2, v5, 0x1

    move v5, v2

    goto :goto_6

    .line 313
    :cond_2
    const/4 v2, 0x0

    move/from16 v16, v2

    goto :goto_1

    .line 314
    :cond_3
    const/16 v2, 0xa

    goto :goto_2

    .line 315
    :cond_4
    const/4 v2, 0x0

    move v15, v2

    goto :goto_3

    .line 316
    :cond_5
    const/4 v2, 0x0

    move v14, v2

    goto :goto_4

    :cond_6
    move v3, v10

    .line 317
    goto :goto_5

    .line 323
    :cond_7
    if-eqz v16, :cond_f

    const/high16 v2, 0x3fc00000    # 1.5f

    add-float/2addr v6, v2

    move v11, v6

    .line 325
    :goto_7
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_8

    if-eqz v16, :cond_d

    .line 326
    :cond_8
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-eqz v16, :cond_9

    const/4 v2, 0x1

    :goto_8
    add-int/2addr v2, v5

    .line 327
    const/high16 v5, 0x41200000    # 10.0f

    const/4 v6, 0x0

    add-int/lit8 v2, v2, -0x1

    invoke-static {v6, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-float v2, v2

    mul-float v2, v2, v18

    sub-float v2, v3, v2

    invoke-static {v5, v2}, Ljava/lang/Math;->max(FF)F

    move-result v22

    .line 329
    const/4 v5, 0x0

    move v12, v13

    :goto_9
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v5, v2, :cond_a

    .line 330
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 331
    iget v2, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v2

    div-float/2addr v2, v11

    mul-float v23, v2, v22

    .line 332
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    move-object/from16 v24, v0

    new-instance v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/4 v3, 0x0

    new-instance v6, Landroid/graphics/RectF;

    add-float v8, v12, v23

    add-float v25, v17, v20

    move/from16 v0, v17

    move/from16 v1, v25

    invoke-direct {v6, v12, v0, v8, v1}, Landroid/graphics/RectF;-><init>(FFFF)V

    move-object/from16 v0, p0

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mAllSheets:Ljava/util/List;

    .line 333
    invoke-static {v7, v8}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v8

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    .line 332
    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 334
    add-float v2, v23, v18

    add-float/2addr v2, v12

    .line 329
    add-int/lit8 v5, v5, 0x1

    move v12, v2

    goto :goto_9

    .line 326
    :cond_9
    const/4 v2, 0x0

    goto :goto_8

    .line 336
    :cond_a
    if-eqz v16, :cond_b

    .line 337
    const/high16 v2, 0x3fc00000    # 1.5f

    div-float/2addr v2, v11

    mul-float v7, v2, v22

    .line 338
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/4 v3, 0x2

    iget-object v5, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-instance v6, Landroid/graphics/RectF;

    add-float/2addr v7, v12

    add-float v8, v17, v20

    move/from16 v0, v17

    invoke-direct {v6, v12, v0, v7, v8}, Landroid/graphics/RectF;-><init>(FFFF)V

    const/4 v7, 0x0

    const-string v8, "\u232b"

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v11, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 341
    :cond_b
    if-eqz v15, :cond_c

    .line 342
    add-float v7, v13, v10

    .line 343
    move-object/from16 v0, p0

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/4 v3, 0x1

    iget-object v5, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    new-instance v6, Landroid/graphics/RectF;

    sub-float v8, v7, v14

    add-float v9, v17, v20

    move/from16 v0, v17

    invoke-direct {v6, v8, v0, v7, v9}, Landroid/graphics/RectF;-><init>(FFFF)V

    const/4 v7, 0x0

    const-string v8, "+"

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v11, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 350
    :cond_c
    :goto_a
    add-float v2, v20, v19

    add-float v2, v2, v17

    .line 311
    add-int/lit8 v4, v4, 0x1

    move/from16 v17, v2

    goto/16 :goto_0

    .line 347
    :cond_d
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/4 v3, 0x1

    const/4 v5, 0x0

    new-instance v6, Landroid/graphics/RectF;

    add-float v7, v13, v10

    add-float v8, v17, v20

    move/from16 v0, v17

    invoke-direct {v6, v13, v0, v7, v8}, Landroid/graphics/RectF;-><init>(FFFF)V

    const/4 v7, 0x0

    const-string v8, "mr_grid_add_key"

    .line 348
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/SheetGridView;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    .line 347
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_a

    .line 353
    :cond_e
    const/4 v2, 0x5

    new-array v9, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v4, "123"

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v9, v2

    const/4 v2, 0x1

    const-string v3, ","

    aput-object v3, v9, v2

    const/4 v2, 0x2

    const-string v3, "\u2423"

    aput-object v3, v9, v2

    const/4 v2, 0x3

    const-string v3, "."

    aput-object v3, v9, v2

    const/4 v2, 0x4

    const-string v3, "\u23ce"

    aput-object v3, v9, v2

    .line 354
    const/high16 v2, 0x40800000    # 4.0f

    mul-float v2, v2, v18

    sub-float/2addr v10, v2

    .line 355
    const/4 v5, 0x0

    :goto_b
    const/4 v2, 0x5

    if-ge v5, v2, :cond_0

    .line 356
    sget-object v2, Lcom/mrkeyboard/app/SheetGridView;->BOTTOM_WEIGHTS:[F

    aget v2, v2, v5

    mul-float v11, v2, v10

    .line 357
    move-object/from16 v0, p0

    iget-object v12, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/4 v3, 0x3

    new-instance v6, Landroid/graphics/RectF;

    add-float v4, v13, v11

    add-float v7, v17, v20

    move/from16 v0, v17

    invoke-direct {v6, v13, v0, v4, v7}, Landroid/graphics/RectF;-><init>(FFFF)V

    const/4 v7, 0x0

    aget-object v8, v9, v5

    move/from16 v4, v21

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v12, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 359
    add-float v2, v11, v18

    add-float/2addr v13, v2

    .line 355
    add-int/lit8 v5, v5, 0x1

    goto :goto_b

    :cond_f
    move v11, v6

    goto/16 :goto_7
.end method

.method private hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .locals 4

    .prologue
    .line 536
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 537
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 538
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_1

    .line 539
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 540
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v3, p1, p2}, Landroid/graphics/RectF;->contains(FF)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 542
    :goto_1
    return-object v0

    .line 538
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 542
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private t(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 239
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 240
    if-nez v0, :cond_0

    :goto_0
    return-object p1

    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method

.method private varargs t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 245
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 246
    if-nez v0, :cond_0

    :goto_0
    return-object p1

    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v1, v0, p2}, Landroid/content/res/Resources;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    goto :goto_0
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 12

    .prologue
    const/high16 v11, 0x41600000    # 14.0f

    const/high16 v10, 0x3f000000    # 0.5f

    const/4 v6, 0x1

    const/4 v7, 0x0

    .line 367
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 368
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 371
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v0

    mul-float/2addr v0, v10

    .line 372
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getWidth()I

    move-result v2

    int-to-float v2, v2

    sub-float/2addr v2, v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getHeight()I

    move-result v3

    int-to-float v3, v3

    sub-float/2addr v3, v0

    invoke-virtual {v1, v0, v0, v2, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 373
    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    .line 374
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 375
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 377
    const/high16 v0, 0x40f00000    # 7.5f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    .line 378
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v9

    move v8, v7

    .line 379
    :goto_0
    if-ge v8, v9, :cond_4

    .line 380
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 381
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-ne v0, v2, :cond_0

    move v4, v6

    .line 382
    :goto_1
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v0, :cond_1

    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v0, :cond_1

    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-ne v0, v1, :cond_1

    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    if-ne v0, v1, :cond_1

    move v5, v6

    .line 384
    :goto_2
    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-ne v0, v6, :cond_2

    .line 385
    invoke-direct {p0, p1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetGridView;->drawAddCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZ)V

    .line 379
    :goto_3
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_0

    :cond_0
    move v4, v7

    .line 381
    goto :goto_1

    :cond_1
    move v5, v7

    .line 382
    goto :goto_2

    .line 386
    :cond_2
    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v0, :cond_3

    move-object v0, p0

    move-object v1, p1

    .line 387
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetGridView;->drawKeyCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZZ)V

    goto :goto_3

    .line 389
    :cond_3
    invoke-direct {p0, p1, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->drawLockedCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;F)V

    goto :goto_3

    .line 393
    :cond_4
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v0, :cond_6

    .line 394
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_5

    .line 395
    iget v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    iget v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    iget-object v9, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    move-object v4, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 398
    :cond_5
    const/high16 v0, 0x42300000    # 44.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    mul-float/2addr v0, v10

    .line 399
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    .line 400
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    sub-float/2addr v4, v0

    iget v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    const v6, 0x3f933333    # 1.15f

    mul-float/2addr v6, v1

    sub-float/2addr v5, v6

    iget v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    add-float/2addr v0, v6

    iget v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    const v7, 0x3e19999a    # 0.15f

    mul-float/2addr v1, v7

    sub-float v1, v6, v1

    invoke-virtual {v2, v4, v5, v0, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 401
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v3, v3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 402
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 403
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v3, v3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 404
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 405
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 406
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 407
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    .line 408
    :goto_4
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 410
    :cond_6
    return-void

    .line 407
    :cond_7
    const-string v0, "\u2423"

    goto :goto_4
.end method

.method protected onMeasure(II)V
    .locals 4

    .prologue
    .line 285
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    .line 286
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v2, 0x6

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 287
    :goto_0
    add-int/lit8 v0, v0, 0x1

    .line 288
    const/high16 v2, 0x41200000    # 10.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    mul-int/lit8 v2, v2, 0x2

    const/high16 v3, 0x42400000    # 48.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    mul-int/2addr v3, v0

    add-int/2addr v2, v3

    add-int/lit8 v0, v0, -0x1

    const/high16 v3, 0x40a00000    # 5.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    mul-int/2addr v0, v3

    add-int/2addr v0, v2

    .line 289
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/SheetGridView;->resolveSize(II)I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/SheetGridView;->setMeasuredDimension(II)V

    .line 290
    return-void

    .line 286
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected onSizeChanged(IIII)V
    .locals 1

    .prologue
    .line 279
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    .line 280
    if-ne p1, p3, :cond_0

    if-eq p2, p4, :cond_1

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 281
    :cond_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 9

    .prologue
    const/4 v8, 0x0

    const/4 v7, -0x1

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 612
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    .line 613
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    .line 614
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v4

    packed-switch v4, :pswitch_data_0

    .line 701
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    :cond_0
    :goto_0
    return v0

    .line 616
    :pswitch_0
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    .line 617
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    .line 618
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 619
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 620
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 621
    iput v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 622
    iput v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 623
    const/high16 v4, -0x40800000    # -1.0f

    iput v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 624
    iput v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    .line 625
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 626
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v2, :cond_1

    .line 627
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v4

    int-to-long v4, v4

    invoke-virtual {v2, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 629
    :cond_1
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_0

    .line 630
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    move v0, v1

    .line 631
    goto :goto_0

    .line 634
    :pswitch_1
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v4, v5}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 635
    iget-boolean v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v4, :cond_4

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v4, :cond_4

    .line 637
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    .line 638
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v3, v3, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    .line 639
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 640
    iget v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 641
    iget v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    .line 642
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 643
    iput-object v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 644
    iput v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mRefusedRow:I

    .line 645
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 646
    if-ltz v4, :cond_3

    if-ltz v5, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v0, :cond_3

    .line 647
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyDragged(IIII)V

    :cond_2
    :goto_1
    move v0, v1

    .line 671
    goto :goto_0

    .line 648
    :cond_3
    if-ltz v6, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v0, :cond_2

    .line 649
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v0, v6}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onDropRefused(I)V

    goto :goto_1

    .line 651
    :cond_4
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v4, :cond_2

    .line 653
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float/2addr v2, v4

    .line 654
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float/2addr v3, v4

    .line 655
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    int-to-float v4, v4

    const/high16 v5, 0x3fc00000    # 1.5f

    mul-float/2addr v4, v5

    .line 656
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 657
    iput-object v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 658
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 659
    mul-float/2addr v2, v2

    mul-float/2addr v3, v3

    add-float/2addr v2, v3

    mul-float v3, v4, v4

    cmpg-float v2, v2, v3

    if-gtz v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v2, :cond_2

    .line 660
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v2, :cond_5

    .line 661
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    iget v3, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    invoke-interface {v0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyTapped(II)V

    goto :goto_1

    .line 662
    :cond_5
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-ne v2, v1, :cond_6

    .line 663
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    invoke-interface {v0, v2}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onAddKeyTapped(I)V

    goto :goto_1

    .line 664
    :cond_6
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_7

    .line 665
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_1

    .line 666
    :cond_7
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_2

    .line 667
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v2, v0}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_1

    .line 674
    :pswitch_2
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 675
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 676
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-nez v0, :cond_9

    .line 677
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float v0, v2, v0

    .line 678
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float v2, v3, v2

    .line 679
    mul-float/2addr v0, v0

    mul-float/2addr v2, v2

    add-float/2addr v0, v2

    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    iget v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    mul-int/2addr v2, v3

    int-to-float v2, v2

    cmpl-float v0, v0, v2

    if-lez v0, :cond_8

    .line 681
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 682
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v0, :cond_8

    .line 683
    iput-object v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 684
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    :cond_8
    :goto_2
    move v0, v1

    .line 691
    goto/16 :goto_0

    .line 688
    :cond_9
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    .line 689
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    goto :goto_2

    .line 694
    :pswitch_3
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 695
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 696
    iput-object v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 697
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    move v0, v1

    .line 698
    goto/16 :goto_0

    .line 614
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            "Ljava/util/List",
            "<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)V"
        }
    .end annotation

    .prologue
    const/4 v5, 0x1

    .line 260
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 261
    iput-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mAllSheets:Ljava/util/List;

    .line 262
    iput-boolean v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 263
    if-eqz p1, :cond_0

    .line 264
    const-string v0, "mr_grid_desc"

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p1, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x6

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-static {p1}, Lcom/mrkeyboard/app/SheetGridView;->countKeys(Lcom/mrkeyboard/app/SheetModel$Sheet;)I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v5

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->t(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->setContentDescription(Ljava/lang/CharSequence;)V

    .line 266
    :cond_0
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->requestLayout()V

    .line 267
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 268
    return-void
.end method

.method public setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V
    .locals 0

    .prologue
    .line 256
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    .line 257
    return-void
.end method
