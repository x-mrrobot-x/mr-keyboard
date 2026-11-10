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
    .line 33
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
    const/4 v3, -0x1

    const/high16 v6, 0x40400000    # 3.0f

    const/high16 v2, 0x3f800000    # 1.0f

    const/4 v5, 0x1

    .line 121
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 56
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x48

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    .line 57
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    .line 58
    iput-boolean v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 74
    new-instance v0, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 75
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    .line 76
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    .line 77
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    .line 85
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 86
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 87
    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 122
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    .line 124
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    .line 125
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    .line 127
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cBg:I

    .line 128
    const-string v0, "mr_ui_stroke"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cTrayStroke:I

    .line 129
    const-string v0, "mr_ui_raised"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyFill:I

    .line 130
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyStroke:I

    .line 131
    const-string v0, "mr_ui_text"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    .line 132
    const-string v0, "mr_ui_stroke_strong"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cPressedFill:I

    .line 133
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cDragFill:I

    .line 134
    const-string v0, "mr_ui_blue_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetFill:I

    .line 135
    const-string v0, "mr_ui_blue_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetStroke:I

    .line 136
    const-string v0, "mr_ui_blue"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetLabel:I

    .line 137
    const-string v0, "mr_ui_violet_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialFill:I

    .line 138
    const-string v0, "mr_ui_violet_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialStroke:I

    .line 139
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerFill:I

    .line 140
    const-string v0, "mr_ui_bg"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerDragFill:I

    .line 141
    const-string v0, "mr_ui_text3"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    .line 142
    const-string v0, "mr_ui_text_dis"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cDashed:I

    .line 143
    const-string v0, "mr_ui_cyan"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    .line 144
    const-string v0, "mr_ui_cyan_soft"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddFill:I

    .line 145
    const-string v0, "mr_ui_cyan_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddPressedFill:I

    .line 146
    const-string v0, "mr_ui_cyan_line"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddStroke:I

    .line 147
    const-string v0, "mr_ui_faint"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedFill:I

    .line 148
    const-string v0, "mr_ui_stroke"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedStroke:I

    .line 149
    const-string v0, "mr_ui_text3"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedLabel:I

    .line 150
    const-string v0, "mr_ui_slate"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    .line 151
    const-string v0, "mr_ui_sunken"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    .line 152
    const-string v0, "mr_ui_raised"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cGhostFill:I

    .line 153
    const-string v0, "mr_ui_text2"

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->color(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cWidthBadge:I

    .line 155
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    .line 156
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    .line 157
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    .line 158
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    .line 159
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    .line 160
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    .line 161
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    .line 162
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    .line 163
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    .line 164
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    .line 165
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    .line 167
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 168
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cBg:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 170
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 171
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 172
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cTrayStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 174
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 175
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 178
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    const v1, 0x3f99999a    # 1.2f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 179
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cDashed:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 180
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

    .line 182
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 183
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 186
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41080000    # 8.5f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 187
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v1, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 189
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 190
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 191
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 193
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cGhostFill:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 196
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 197
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 198
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 199
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 201
    new-instance v0, Lcom/mrkeyboard/app/SheetGridView$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/SheetGridView$1;-><init>(Lcom/mrkeyboard/app/SheetGridView;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    .line 212
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .locals 1

    .prologue
    .line 31
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    return-object v0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetGridView;)Z
    .locals 1

    .prologue
    .line 31
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return v0
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/SheetGridView;Z)Z
    .locals 0

    .prologue
    .line 31
    iput-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return p1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetGridView;)F
    .locals 1

    .prologue
    .line 31
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    return v0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetGridView;)F
    .locals 1

    .prologue
    .line 31
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    return v0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetGridView;FF)V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    return-void
.end method

.method private color(Ljava/lang/String;)I
    .locals 4

    .prologue
    .line 218
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
    const/4 v12, -0x1

    const/high16 v11, 0x41200000    # 10.0f

    const/high16 v10, 0x40000000    # 2.0f

    const/4 v4, 0x0

    .line 511
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 570
    :cond_0
    :goto_0
    return-void

    .line 512
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x6

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v5

    .line 513
    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v6

    .line 514
    const/high16 v0, 0x42400000    # 48.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v7

    .line 515
    const/high16 v0, 0x40a00000    # 5.0f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v8

    .line 519
    const v1, 0x7f7fffff    # Float.MAX_VALUE

    move v2, v4

    move v3, v4

    .line 520
    :goto_1
    if-ge v2, v5, :cond_2

    .line 521
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

    .line 522
    cmpg-float v9, v0, v1

    if-gez v9, :cond_b

    move v1, v2

    .line 520
    :goto_2
    add-int/lit8 v2, v2, 0x1

    move v3, v1

    move v1, v0

    goto :goto_1

    .line 529
    :cond_2
    add-int/lit8 v0, v5, -0x1

    if-ne v3, v0, :cond_3

    const/16 v0, 0x9

    move v1, v0

    .line 530
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 531
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-eq v3, v2, :cond_4

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt v0, v1, :cond_4

    .line 532
    iput v12, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 533
    iput v12, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 534
    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    goto :goto_0

    .line 529
    :cond_3
    const/16 v0, 0xa

    move v1, v0

    goto :goto_3

    .line 538
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 539
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    move v1, v4

    .line 540
    :goto_4
    if-ge v1, v2, :cond_6

    .line 541
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 542
    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v5, :cond_5

    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-ne v5, v3, :cond_5

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v5, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 540
    :cond_5
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_4

    .line 545
    :cond_6
    int-to-float v0, v3

    add-float v1, v8, v7

    mul-float/2addr v0, v1

    add-float/2addr v0, v6

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    .line 546
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    add-float/2addr v0, v7

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    .line 547
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 549
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 550
    iput v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 551
    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    goto/16 :goto_0

    .line 556
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 557
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    move v1, v4

    .line 558
    :goto_5
    if-ge v1, v3, :cond_a

    .line 559
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 560
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v4}, Landroid/graphics/RectF;->centerX()F

    move-result v4

    cmpg-float v4, p1, v4

    if-gez v4, :cond_9

    .line 561
    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v0, v0, Landroid/graphics/RectF;->left:F

    invoke-direct {p0, v10}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    sub-float/2addr v0, v2

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 566
    :goto_6
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ne v1, v0, :cond_8

    .line 567
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

    invoke-direct {p0, v10}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v0, v2

    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 569
    :cond_8
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    goto/16 :goto_0

    .line 558
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

.method private dp(F)F
    .locals 1

    .prologue
    .line 228
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    mul-float/2addr v0, p1

    return v0
.end method

.method private drawAddCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZ)V
    .locals 3

    .prologue
    .line 382
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz p4, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddPressedFill:I

    :goto_0
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 383
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 384
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 385
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 386
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 387
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

    .line 388
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 389
    return-void

    .line 382
    :cond_0
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cAddFill:I

    goto :goto_0

    .line 387
    :cond_1
    const/high16 v0, 0x41480000    # 12.5f

    goto :goto_1
.end method

.method private drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V
    .locals 3

    .prologue
    .line 458
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {p4, v0}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 459
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

    .line 460
    invoke-virtual {p3}, Landroid/graphics/RectF;->centerX()F

    move-result v1

    invoke-virtual {p1, p2, v1, v0, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 461
    return-void
.end method

.method private drawKeyCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZZ)V
    .locals 6

    .prologue
    const/high16 v5, 0x40400000    # 3.0f

    .line 393
    iget-object v3, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 394
    const-string v0, "spacer"

    iget-object v1, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 395
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_1

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerDragFill:I

    :goto_0
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 396
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 397
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 398
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 399
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 400
    const-string v0, "\u2423"

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 441
    :cond_0
    :goto_1
    return-void

    .line 395
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerFill:I

    goto :goto_0

    .line 403
    :cond_2
    const-string v0, "tasker"

    iget-object v1, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_3

    const-string v0, "sheet"

    iget-object v1, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    :cond_3
    const/4 v0, 0x1

    .line 404
    :goto_2
    const-string v1, "special"

    iget-object v2, v3, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    .line 407
    if-eqz p5, :cond_6

    .line 408
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->cDragFill:I

    .line 409
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    .line 423
    :goto_3
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v4, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 424
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 425
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, p3, p3, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 426
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, p3, p3, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 428
    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    .line 429
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/4 v4, 0x2

    if-gt v1, v4, :cond_a

    const/high16 v1, 0x41680000    # 14.5f

    :goto_4
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 430
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    if-eqz p5, :cond_c

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpacerLabel:I

    :goto_5
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 431
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 433
    invoke-virtual {v3}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasAnyPopup()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 434
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 435
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

    .line 437
    :cond_4
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

    .line 438
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cWidthBadge:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 439
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    iget-object v1, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v1, v1, Landroid/graphics/RectF;->right:F

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    sub-float/2addr v1, v2

    iget-object v2, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->bottom:F

    invoke-direct {p0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    sub-float/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto/16 :goto_1

    .line 403
    :cond_5
    const/4 v0, 0x0

    goto/16 :goto_2

    .line 410
    :cond_6
    if-eqz p4, :cond_7

    .line 411
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->cPressedFill:I

    .line 412
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    goto/16 :goto_3

    .line 413
    :cond_7
    if-eqz v0, :cond_8

    .line 414
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetFill:I

    .line 415
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetStroke:I

    goto/16 :goto_3

    .line 416
    :cond_8
    if-eqz v1, :cond_9

    .line 417
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialFill:I

    .line 418
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cSpecialStroke:I

    goto/16 :goto_3

    .line 420
    :cond_9
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyFill:I

    .line 421
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyStroke:I

    goto/16 :goto_3

    .line 429
    :cond_a
    const/4 v4, 0x4

    if-gt v1, v4, :cond_b

    const/high16 v1, 0x41400000    # 12.0f

    goto/16 :goto_4

    :cond_b
    const/high16 v1, 0x41280000    # 10.5f

    goto/16 :goto_4

    .line 430
    :cond_c
    if-eqz v0, :cond_d

    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cSheetLabel:I

    goto/16 :goto_5

    :cond_d
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    goto/16 :goto_5
.end method

.method private drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V
    .locals 11

    .prologue
    const/high16 v2, 0x43340000    # 180.0f

    .line 465
    iget v0, p2, Landroid/graphics/RectF;->right:F

    const v1, 0x401ccccd    # 2.45f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    sub-float v6, v0, v1

    .line 466
    const v0, 0x40f66666    # 7.7f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    sub-float v7, v6, v0

    .line 467
    const v0, 0x40766666    # 3.85f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v8, v7, v0

    .line 468
    iget v9, p2, Landroid/graphics/RectF;->top:F

    .line 470
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 471
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    const v1, 0x3fa147ae    # 1.26f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 472
    const v0, 0x4011999a    # 2.275f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v10

    .line 473
    const v0, 0x40d4cccd    # 6.65f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float/2addr v0, v9

    .line 474
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    sub-float v3, v8, v10

    const v4, 0x40066666    # 2.1f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    add-float/2addr v4, v9

    add-float v5, v8, v10

    invoke-virtual {v1, v3, v4, v5, v0}, Landroid/graphics/RectF;->set(FFFF)V

    .line 475
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v2

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 477
    const/high16 v0, 0x408c0000    # 4.375f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v2, v0, v9

    .line 478
    const v0, 0x40ce147b    # 6.44f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float v4, v0, v9

    .line 479
    sub-float v1, v8, v10

    .line 480
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 481
    add-float v1, v8, v10

    .line 482
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 484
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

    .line 485
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockGlyph:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 486
    const v0, 0x3fb33333    # 1.4f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    .line 487
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 490
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 491
    const v0, 0x41066666    # 8.4f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float/2addr v0, v9

    const/high16 v1, 0x3f600000    # 0.875f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v0, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 492
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockHole:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 493
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    const v1, 0x3f81eb85    # 1.015f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 494
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

    .line 495
    return-void
.end method

.method private drawLockedCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;F)V
    .locals 5

    .prologue
    .line 445
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedFill:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 446
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 447
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedStroke:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 448
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, p3, p3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 449
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cLockedLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 450
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x41480000    # 12.5f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 452
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

    .line 453
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 454
    iget-object v0, p2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-direct {p0, p1, v0}, Lcom/mrkeyboard/app/SheetGridView;->drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V

    .line 455
    return-void
.end method

.method private ensureCellsBuilt()V
    .locals 26

    .prologue
    .line 264
    move-object/from16 v0, p0

    iget-boolean v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    if-nez v2, :cond_1

    .line 329
    :cond_0
    return-void

    .line 265
    :cond_1
    const/4 v2, 0x0

    move-object/from16 v0, p0

    iput-boolean v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 266
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 267
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v2, :cond_0

    .line 268
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getWidth()I

    move-result v3

    .line 269
    if-lez v3, :cond_0

    .line 271
    const/high16 v2, 0x41000000    # 8.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v13

    .line 272
    const/high16 v2, 0x41200000    # 10.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    .line 273
    const/high16 v4, 0x40800000    # 4.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v18

    .line 274
    const/high16 v4, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v19

    .line 275
    const/high16 v4, 0x42400000    # 48.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v20

    .line 276
    const/high16 v4, 0x41200000    # 10.0f

    int-to-float v3, v3

    const/high16 v5, 0x40000000    # 2.0f

    mul-float/2addr v5, v13

    sub-float/2addr v3, v5

    invoke-static {v4, v3}, Ljava/lang/Math;->max(FF)F

    move-result v10

    .line 277
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v3, v3, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x6

    invoke-static {v3, v4}, Ljava/lang/Math;->min(II)I

    move-result v21

    .line 279
    const/4 v4, 0x0

    move/from16 v17, v2

    :goto_0
    move/from16 v0, v21

    if-ge v4, v0, :cond_e

    .line 280
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v2, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    move-object v9, v2

    check-cast v9, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 281
    add-int/lit8 v2, v21, -0x1

    if-ne v4, v2, :cond_2

    const/4 v2, 0x1

    move/from16 v16, v2

    .line 282
    :goto_1
    if-eqz v16, :cond_3

    const/16 v2, 0x9

    .line 283
    :goto_2
    iget-object v3, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v3, v2, :cond_4

    const/4 v2, 0x1

    move v15, v2

    .line 284
    :goto_3
    if-eqz v15, :cond_5

    const/high16 v2, 0x41f00000    # 30.0f

    move-object/from16 v0, p0

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    move v14, v2

    .line 285
    :goto_4
    if-eqz v15, :cond_6

    const/high16 v2, 0x41a00000    # 20.0f

    sub-float v3, v10, v14

    sub-float v3, v3, v18

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move v3, v2

    .line 287
    :goto_5
    const/4 v5, 0x0

    .line 288
    const/4 v2, 0x0

    move v6, v5

    move v5, v2

    :goto_6
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v5, v2, :cond_7

    .line 289
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v2, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v2

    add-float/2addr v6, v2

    .line 288
    add-int/lit8 v2, v5, 0x1

    move v5, v2

    goto :goto_6

    .line 281
    :cond_2
    const/4 v2, 0x0

    move/from16 v16, v2

    goto :goto_1

    .line 282
    :cond_3
    const/16 v2, 0xa

    goto :goto_2

    .line 283
    :cond_4
    const/4 v2, 0x0

    move v15, v2

    goto :goto_3

    .line 284
    :cond_5
    const/4 v2, 0x0

    move v14, v2

    goto :goto_4

    :cond_6
    move v3, v10

    .line 285
    goto :goto_5

    .line 291
    :cond_7
    if-eqz v16, :cond_f

    const/high16 v2, 0x3fc00000    # 1.5f

    add-float/2addr v6, v2

    move v11, v6

    .line 293
    :goto_7
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_8

    if-eqz v16, :cond_d

    .line 294
    :cond_8
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-eqz v16, :cond_9

    const/4 v2, 0x1

    :goto_8
    add-int/2addr v2, v5

    .line 295
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

    .line 297
    const/4 v5, 0x0

    move v12, v13

    :goto_9
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v5, v2, :cond_a

    .line 298
    iget-object v2, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 299
    iget v2, v7, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v2}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v2

    div-float/2addr v2, v11

    mul-float v23, v2, v22

    .line 300
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

    .line 301
    invoke-static {v7, v8}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v8

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    .line 300
    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 302
    add-float v2, v23, v18

    add-float/2addr v2, v12

    .line 297
    add-int/lit8 v5, v5, 0x1

    move v12, v2

    goto :goto_9

    .line 294
    :cond_9
    const/4 v2, 0x0

    goto :goto_8

    .line 304
    :cond_a
    if-eqz v16, :cond_b

    .line 305
    const/high16 v2, 0x3fc00000    # 1.5f

    div-float/2addr v2, v11

    mul-float v7, v2, v22

    .line 306
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

    .line 309
    :cond_b
    if-eqz v15, :cond_c

    .line 310
    add-float v7, v13, v10

    .line 311
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

    .line 318
    :cond_c
    :goto_a
    add-float v2, v20, v19

    add-float v2, v2, v17

    .line 279
    add-int/lit8 v4, v4, 0x1

    move/from16 v17, v2

    goto/16 :goto_0

    .line 315
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

    .line 316
    move-object/from16 v0, p0

    invoke-direct {v0, v8}, Lcom/mrkeyboard/app/SheetGridView;->t(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-direct/range {v2 .. v8}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    .line 315
    invoke-virtual {v9, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_a

    .line 321
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

    .line 322
    const/high16 v2, 0x40800000    # 4.0f

    mul-float v2, v2, v18

    sub-float/2addr v10, v2

    .line 323
    const/4 v5, 0x0

    :goto_b
    const/4 v2, 0x5

    if-ge v5, v2, :cond_0

    .line 324
    sget-object v2, Lcom/mrkeyboard/app/SheetGridView;->BOTTOM_WEIGHTS:[F

    aget v2, v2, v5

    mul-float v11, v2, v10

    .line 325
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

    .line 327
    add-float v2, v11, v18

    add-float/2addr v13, v2

    .line 323
    add-int/lit8 v5, v5, 0x1

    goto :goto_b

    :cond_f
    move v11, v6

    goto/16 :goto_7
.end method

.method private hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .locals 4

    .prologue
    .line 500
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 501
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    .line 502
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    if-ge v1, v2, :cond_1

    .line 503
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 504
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v3, p1, p2}, Landroid/graphics/RectF;->contains(FF)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 506
    :goto_1
    return-object v0

    .line 502
    :cond_0
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 506
    :cond_1
    const/4 v0, 0x0

    goto :goto_1
.end method

.method private t(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .prologue
    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    const-string v1, "string"

    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    .line 224
    if-nez v0, :cond_0

    :goto_0
    return-object p1

    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRes:Landroid/content/res/Resources;

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

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

    .line 335
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 336
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 339
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v0

    mul-float/2addr v0, v10

    .line 340
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

    .line 341
    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    .line 342
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 343
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v0, v0, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 345
    const/high16 v0, 0x40f00000    # 7.5f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    .line 346
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v9

    move v8, v7

    .line 347
    :goto_0
    if-ge v8, v9, :cond_4

    .line 348
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 349
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-ne v0, v2, :cond_0

    move v4, v6

    .line 350
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

    .line 352
    :goto_2
    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-ne v0, v6, :cond_2

    .line 353
    invoke-direct {p0, p1, v2, v3, v4}, Lcom/mrkeyboard/app/SheetGridView;->drawAddCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZ)V

    .line 347
    :goto_3
    add-int/lit8 v0, v8, 0x1

    move v8, v0

    goto :goto_0

    :cond_0
    move v4, v7

    .line 349
    goto :goto_1

    :cond_1
    move v5, v7

    .line 350
    goto :goto_2

    .line 354
    :cond_2
    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v0, :cond_3

    move-object v0, p0

    move-object v1, p1

    .line 355
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/SheetGridView;->drawKeyCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;FZZ)V

    goto :goto_3

    .line 357
    :cond_3
    invoke-direct {p0, p1, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->drawLockedCell(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/SheetGridView$CellHit;F)V

    goto :goto_3

    .line 361
    :cond_4
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v0, :cond_6

    .line 362
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-ltz v0, :cond_5

    .line 363
    iget v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    iget v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    iget-object v9, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    move-object v4, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 366
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

    .line 367
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    .line 368
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

    .line 369
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v3, v3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 370
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cAccent:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 371
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v3, v3, v1}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 372
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->cKeyLabel:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 373
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 374
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_7

    .line 375
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    .line 376
    :goto_4
    iget-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 378
    :cond_6
    return-void

    .line 375
    :cond_7
    const-string v0, "\u2423"

    goto :goto_4
.end method

.method protected onMeasure(II)V
    .locals 4

    .prologue
    .line 253
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    .line 254
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

    .line 255
    :goto_0
    add-int/lit8 v0, v0, 0x1

    .line 256
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

    .line 257
    invoke-static {v0, p2}, Lcom/mrkeyboard/app/SheetGridView;->resolveSize(II)I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/SheetGridView;->setMeasuredDimension(II)V

    .line 258
    return-void

    .line 254
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method protected onSizeChanged(IIII)V
    .locals 1

    .prologue
    .line 247
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    .line 248
    if-ne p1, p3, :cond_0

    if-eq p2, p4, :cond_1

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 249
    :cond_1
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 7

    .prologue
    const/4 v5, -0x1

    const/4 v6, 0x0

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 574
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    .line 575
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    .line 576
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v4

    packed-switch v4, :pswitch_data_0

    .line 658
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    :cond_0
    :goto_0
    return v0

    .line 578
    :pswitch_0
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    .line 579
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    .line 580
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 581
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 582
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 583
    iput v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 584
    iput v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 585
    const/high16 v4, -0x40800000    # -1.0f

    iput v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 586
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object v2

    iput-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 587
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v2, :cond_1

    .line 588
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v4

    int-to-long v4, v4

    invoke-virtual {v2, v3, v4, v5}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 590
    :cond_1
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v2, :cond_0

    .line 591
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    move v0, v1

    .line 592
    goto :goto_0

    .line 595
    :pswitch_1
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v4, v5}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 596
    iget-boolean v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v4, :cond_3

    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v4, :cond_3

    .line 598
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    .line 599
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v3, v3, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    .line 600
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 601
    iget v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 602
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 603
    iput-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 604
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 605
    if-ltz v4, :cond_2

    if-ltz v5, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v0, :cond_2

    .line 606
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v0, v2, v3, v4, v5}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyDragged(IIII)V

    :cond_2
    :goto_1
    move v0, v1

    .line 628
    goto :goto_0

    .line 608
    :cond_3
    iget-object v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v4, :cond_2

    .line 610
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float/2addr v2, v4

    .line 611
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float/2addr v3, v4

    .line 612
    iget v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    int-to-float v4, v4

    const/high16 v5, 0x3fc00000    # 1.5f

    mul-float/2addr v4, v5

    .line 613
    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 614
    iput-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 615
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 616
    mul-float/2addr v2, v2

    mul-float/2addr v3, v3

    add-float/2addr v2, v3

    mul-float v3, v4, v4

    cmpg-float v2, v2, v3

    if-gtz v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v2, :cond_2

    .line 617
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v2, :cond_4

    .line 618
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    iget v3, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    invoke-interface {v0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyTapped(II)V

    goto :goto_1

    .line 619
    :cond_4
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-ne v2, v1, :cond_5

    .line 620
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    invoke-interface {v0, v2}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onAddKeyTapped(I)V

    goto :goto_1

    .line 621
    :cond_5
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v3, 0x2

    if-ne v2, v3, :cond_6

    .line 622
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_1

    .line 623
    :cond_6
    iget v2, v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_2

    .line 624
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v2, v0}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_1

    .line 631
    :pswitch_2
    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 632
    iput v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 633
    iget-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-nez v0, :cond_8

    .line 634
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float v0, v2, v0

    .line 635
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float v2, v3, v2

    .line 636
    mul-float/2addr v0, v0

    mul-float/2addr v2, v2

    add-float/2addr v0, v2

    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    iget v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    mul-int/2addr v2, v3

    int-to-float v2, v2

    cmpl-float v0, v0, v2

    if-lez v0, :cond_7

    .line 638
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v0, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 639
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v0, :cond_7

    .line 640
    iput-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 641
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    :cond_7
    :goto_2
    move v0, v1

    .line 648
    goto/16 :goto_0

    .line 645
    :cond_8
    invoke-direct {p0, v2, v3}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    .line 646
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    goto :goto_2

    .line 651
    :pswitch_3
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 652
    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 653
    iput-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 654
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    move v0, v1

    .line 655
    goto/16 :goto_0

    .line 576
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method public setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V
    .locals 1
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
    .line 238
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 239
    iput-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mAllSheets:Ljava/util/List;

    .line 240
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 241
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->requestLayout()V

    .line 242
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 243
    return-void
.end method

.method public setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V
    .locals 0

    .prologue
    .line 234
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    .line 235
    return-void
.end method
