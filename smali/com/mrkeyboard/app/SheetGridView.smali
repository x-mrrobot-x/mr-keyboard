.class public Lcom/mrkeyboard/app/SheetGridView;
.super Landroid/view/View;
.source "SheetGridView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/SheetGridView$GridListener;,
        Lcom/mrkeyboard/app/SheetGridView$CellHit;
    }
.end annotation


# static fields
.field private static final BOTTOM_WEIGHTS:[F


# instance fields
.field private mAllSheets:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
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
            "Ljava/util/ArrayList<",
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

.field private final mRowHitsScratch:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
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
    .registers 1

    .line 19
    const/4 v0, 0x5

    new-array v0, v0, [F

    fill-array-data v0, :array_a

    sput-object v0, Lcom/mrkeyboard/app/SheetGridView;->BOTTOM_WEIGHTS:[F

    return-void

    nop

    :array_a
    .array-data 4
        0x3e4ccccd    # 0.2f
        0x3dcccccd    # 0.1f
        0x3ecccccd    # 0.4f
        0x3dcccccd    # 0.1f
        0x3e4ccccd    # 0.2f
    .end array-data
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .registers 10

    .line 61
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 27
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x48

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    .line 28
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    .line 29
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 31
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    .line 32
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    .line 33
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    .line 34
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    .line 35
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    .line 36
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    .line 37
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    .line 38
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    .line 39
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v0}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    .line 41
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    .line 42
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    .line 43
    new-instance v1, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v1}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 45
    new-instance v1, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    .line 54
    const/4 v1, -0x1

    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 55
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 56
    const/high16 v1, -0x40800000    # -1.0f

    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 57
    const/4 v1, 0x0

    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    .line 58
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    .line 62
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    .line 63
    invoke-static {p1}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    .line 65
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 66
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    const v2, -0xf5efe8

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 68
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 69
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 70
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    const v3, -0xe5dacb

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 72
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 73
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v2

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 75
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 76
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    const v2, 0x3f99999a    # 1.2f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 77
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    const v2, -0xc5b6a2

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 78
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    new-instance v2, Landroid/graphics/DashPathEffect;

    const/high16 v3, 0x40800000    # 4.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    const/high16 v4, 0x40400000    # 3.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v5

    const/4 v6, 0x2

    new-array v6, v6, [F

    const/4 v7, 0x0

    aput v3, v6, v7

    aput v5, v6, v0

    invoke-direct {v2, v6, v1}, Landroid/graphics/DashPathEffect;-><init>([FF)V

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setPathEffect(Landroid/graphics/PathEffect;)Landroid/graphics/PathEffect;

    .line 80
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 81
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    sget-object v0, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 83
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 84
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    const/high16 v0, 0x41080000    # 8.5f

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 85
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    sget-object v0, Lcom/mrkeyboard/app/SheetUi;->TF_MEDIUM:Landroid/graphics/Typeface;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 87
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    const v0, -0xd63a0a

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 88
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 89
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 91
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 92
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    const v0, -0x11ecd8c2

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Join;->ROUND:Landroid/graphics/Paint$Join;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeJoin(Landroid/graphics/Paint$Join;)V

    .line 94
    new-instance p1, Lcom/mrkeyboard/app/SheetGridView$1;

    invoke-direct {p1, p0}, Lcom/mrkeyboard/app/SheetGridView$1;-><init>(Lcom/mrkeyboard/app/SheetGridView;)V

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    .line 109
    return-void
.end method

.method private drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V
    .registers 14

    move-object v0, p1

    iget v6, p2, Landroid/graphics/RectF;->right:F

    const v1, 0x401ccccd    # 2.45f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    sub-float/2addr v6, v1

    const v1, 0x40f66666    # 7.7f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    sub-float v7, v6, v1

    const v1, 0x40766666    # 3.85f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    add-float v8, v7, v1

    iget v9, p2, Landroid/graphics/RectF;->top:F

    iget-object v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockShacklePaint:Landroid/graphics/Paint;

    const v1, -0x674f32

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setColor(I)V

    const v1, 0x3fa147ae    # 1.26f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    const v1, 0x4011999a    # 2.275f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v10

    sub-float v1, v8, v10

    const v2, 0x40066666    # 2.1f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    add-float v3, v8, v10

    const v4, 0x40d4cccd    # 6.65f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    add-float/2addr v4, v9

    iget-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    invoke-virtual {p2, v1, v2, v3, v4}, Landroid/graphics/RectF;->set(FFFF)V

    move-object v1, p2

    const/high16 v2, 0x43340000    # 180.0f

    const/high16 v3, 0x43340000    # 180.0f

    const/4 v4, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    const/high16 v2, 0x408c0000    # 4.375f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    const v4, 0x40ce147b    # 6.44f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    add-float/2addr v4, v9

    sub-float v1, v8, v10

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    add-float v1, v8, v10

    move v3, v1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    const v1, 0x40c51eb8    # 6.16f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    add-float/2addr v1, v9

    const v2, 0x413e6666    # 11.9f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    invoke-virtual {p2, v7, v1, v6, v2}, Landroid/graphics/RectF;->set(FFFF)V

    iget-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mLockBodyPaint:Landroid/graphics/Paint;

    const v1, -0x674f32

    invoke-virtual {v6, v1}, Landroid/graphics/Paint;->setColor(I)V

    const v1, 0x3fb33333    # 1.4f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v0, p2, v1, v1, v6}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    const v1, -0xf1ebe1

    invoke-virtual {v6, v1}, Landroid/graphics/Paint;->setColor(I)V

    const v2, 0x41066666    # 8.4f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    const/high16 v3, 0x3f600000    # 0.875f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-virtual {v0, v8, v2, v3, v6}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setColor(I)V

    const v1, 0x3f81eb85    # 1.015f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    move v1, v8

    const v2, 0x410ae148    # 8.68f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    add-float/2addr v2, v9

    move v3, v8

    const v4, 0x4126e148    # 10.43f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    add-float/2addr v4, v9

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/SheetGridView;)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .registers 1

    .line 18
    iget-object p0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    return-object p0
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/SheetGridView;)Z
    .registers 1

    .line 18
    iget-boolean p0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return p0
.end method

.method static synthetic access$102(Lcom/mrkeyboard/app/SheetGridView;Z)Z
    .registers 2

    .line 18
    iput-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    return p1
.end method

.method static synthetic access$200(Lcom/mrkeyboard/app/SheetGridView;)F
    .registers 1

    .line 18
    iget p0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    return p0
.end method

.method static synthetic access$300(Lcom/mrkeyboard/app/SheetGridView;)F
    .registers 1

    .line 18
    iget p0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    return p0
.end method

.method static synthetic access$400(Lcom/mrkeyboard/app/SheetGridView;FF)V
    .registers 3

    .line 18
    invoke-direct {p0, p1, p2}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    return-void
.end method

.method private computeDropTarget(FF)V
    .registers 14

    .line 351
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-eqz v0, :cond_11e

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_10

    goto/16 :goto_11e

    .line 352
    :cond_10
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x6

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 353
    const/high16 v1, 0x41200000    # 10.0f

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    .line 354
    const/high16 v3, 0x42400000    # 48.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    .line 355
    const/high16 v4, 0x40a00000    # 5.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    .line 357
    nop

    .line 358
    nop

    .line 359
    const/4 v5, 0x0

    const v6, 0x7f7fffff    # Float.MAX_VALUE

    move v7, v5

    move v8, v7

    :goto_37
    if-ge v7, v0, :cond_52

    .line 360
    int-to-float v9, v7

    add-float v10, v3, v4

    mul-float/2addr v9, v10

    add-float/2addr v9, v2

    const/high16 v10, 0x3f000000    # 0.5f

    mul-float/2addr v10, v3

    add-float/2addr v9, v10

    .line 361
    sub-float v9, p2, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(F)F

    move-result v9

    .line 362
    cmpg-float v10, v9, v6

    if-gez v10, :cond_4f

    .line 363
    nop

    .line 364
    move v8, v7

    move v6, v9

    .line 359
    :cond_4f
    add-int/lit8 v7, v7, 0x1

    goto :goto_37

    .line 368
    :cond_52
    add-int/lit8 v0, v0, -0x1

    if-ne v8, v0, :cond_59

    const/16 p2, 0x9

    goto :goto_5b

    :cond_59
    const/16 p2, 0xa

    .line 369
    :goto_5b
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 370
    iget-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v6, :cond_81

    iget-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v6, v6, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-eq v8, v6, :cond_81

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lt v0, p2, :cond_81

    .line 371
    const/4 p1, -0x1

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 372
    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 373
    const/high16 p1, -0x40800000    # -1.0f

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 374
    return-void

    .line 377
    :cond_81
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->clear()V

    .line 378
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    move v0, v5

    :goto_8d
    if-ge v0, p2, :cond_a7

    .line 379
    iget-object v6, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v6, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 380
    iget v7, v6, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v7, :cond_a4

    iget v7, v6, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-ne v7, v8, :cond_a4

    .line 381
    iget-object v7, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v7, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 378
    :cond_a4
    add-int/lit8 v0, v0, 0x1

    goto :goto_8d

    .line 385
    :cond_a7
    int-to-float p2, v8

    add-float/2addr v4, v3

    mul-float/2addr p2, v4

    add-float/2addr v2, p2

    iput v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    .line 386
    iget p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    add-float/2addr p2, v3

    iput p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    .line 387
    iput v8, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 389
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_c5

    .line 390
    iput v5, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 391
    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result p1

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 392
    return-void

    .line 395
    :cond_c5
    iget-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result p2

    .line 396
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    :goto_d1
    const/high16 v1, 0x40000000    # 2.0f

    if-ge v5, v0, :cond_f8

    .line 397
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 398
    iget-object v3, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v3}, Landroid/graphics/RectF;->centerX()F

    move-result v3

    cmpg-float v3, p1, v3

    if-gez v3, :cond_f5

    .line 399
    iget-object p1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->left:F

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result p2

    sub-float/2addr p1, p2

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 400
    nop

    .line 401
    move p2, v5

    goto :goto_f8

    .line 396
    :cond_f5
    add-int/lit8 v5, v5, 0x1

    goto :goto_d1

    .line 404
    :cond_f8
    :goto_f8
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-ne p2, p1, :cond_11b

    .line 405
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mRowHitsScratch:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object p1, p1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget p1, p1, Landroid/graphics/RectF;->right:F

    invoke-direct {p0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v0

    add-float/2addr p1, v0

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 407
    :cond_11b
    iput p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 408
    return-void

    .line 351
    :cond_11e
    :goto_11e
    return-void
.end method

.method private dp(F)F
    .registers 3

    .line 112
    iget v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDensity:F

    mul-float/2addr p1, v0

    return p1
.end method

.method private drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V
    .registers 8

    .line 334
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mFontMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {p4, v0}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 335
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

    .line 336
    invoke-virtual {p3}, Landroid/graphics/RectF;->centerX()F

    move-result p3

    invoke-virtual {p1, p2, p3, v0, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 337
    return-void
.end method

.method private ensureCellsBuilt()V
    .registers 35

    .line 150
    move-object/from16 v0, p0

    iget-boolean v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    if-nez v1, :cond_7

    .line 151
    return-void

    .line 153
    :cond_7
    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 154
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->clear()V

    .line 155
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    if-nez v2, :cond_14

    return-void

    .line 156
    :cond_14
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getWidth()I

    move-result v2

    .line 157
    if-gtz v2, :cond_1b

    return-void

    .line 159
    :cond_1b
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/SheetStrings;->isPt(Landroid/content/Context;)Z

    move-result v3

    .line 160
    const/high16 v4, 0x41000000    # 8.0f

    invoke-direct {v0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    .line 161
    const/high16 v5, 0x41200000    # 10.0f

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v6

    .line 162
    const/high16 v7, 0x40800000    # 4.0f

    invoke-direct {v0, v7}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v8

    .line 163
    const/high16 v9, 0x40a00000    # 5.0f

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v9

    .line 164
    const/high16 v10, 0x42400000    # 48.0f

    invoke-direct {v0, v10}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v10

    .line 165
    int-to-float v2, v2

    const/high16 v11, 0x40000000    # 2.0f

    mul-float/2addr v11, v4

    sub-float/2addr v2, v11

    invoke-static {v5, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    .line 166
    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v11, v11, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v11

    const/4 v12, 0x6

    invoke-static {v11, v12}, Ljava/lang/Math;->min(II)I

    move-result v11

    .line 168
    move v15, v1

    :goto_58
    if-ge v15, v11, :cond_1ff

    .line 169
    iget-object v12, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v12, v12, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v12, v15}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    move-object v14, v12

    check-cast v14, Lcom/mrkeyboard/app/SheetModel$Row;

    .line 170
    add-int/lit8 v12, v11, -0x1

    if-ne v15, v12, :cond_6c

    const/16 v19, 0x1

    goto :goto_6e

    :cond_6c
    move/from16 v19, v1

    .line 171
    :goto_6e
    if-eqz v19, :cond_73

    const/16 v12, 0x9

    goto :goto_75

    :cond_73
    const/16 v12, 0xa

    .line 172
    :goto_75
    iget-object v7, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    if-ge v7, v12, :cond_7f

    const/4 v7, 0x1

    goto :goto_80

    :cond_7f
    move v7, v1

    .line 173
    :goto_80
    if-eqz v7, :cond_8b

    const/high16 v12, 0x41f00000    # 30.0f

    invoke-direct {v0, v12}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v12

    move/from16 v20, v12

    goto :goto_8d

    :cond_8b
    const/16 v20, 0x0

    .line 174
    :goto_8d
    if-eqz v7, :cond_99

    sub-float v12, v2, v20

    sub-float/2addr v12, v8

    const/high16 v5, 0x41a00000    # 20.0f

    invoke-static {v5, v12}, Ljava/lang/Math;->max(FF)F

    move-result v5

    goto :goto_9a

    :cond_99
    move v5, v2

    .line 176
    :goto_9a
    nop

    .line 177
    iget-object v12, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    const/16 v16, 0x0

    :goto_a3
    if-ge v1, v12, :cond_b8

    .line 178
    iget-object v13, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v13, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    iget v13, v13, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v13}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v13

    add-float v16, v16, v13

    .line 177
    add-int/lit8 v1, v1, 0x1

    goto :goto_a3

    .line 180
    :cond_b8
    const/high16 v1, 0x3fc00000    # 1.5f

    if-eqz v19, :cond_c1

    .line 181
    add-float v16, v16, v1

    move/from16 v22, v16

    goto :goto_c3

    .line 180
    :cond_c1
    move/from16 v22, v16

    .line 184
    :goto_c3
    iget-object v12, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v12

    if-eqz v12, :cond_102

    if-nez v19, :cond_102

    .line 185
    new-instance v1, Landroid/graphics/RectF;

    add-float v5, v4, v2

    add-float v7, v6, v10

    invoke-direct {v1, v4, v6, v5, v7}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 186
    if-eqz v3, :cond_db

    const-string v5, "+ Adicionar tecla"

    invoke-static/range {v5 .. v5}, Lcom/mrkeyboard/app/SheetStrings;->p(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    goto :goto_dd

    :cond_db
    const-string v5, "+ Add key"

    :goto_dd
    move-object/from16 v18, v5

    .line 187
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v7, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/16 v16, 0x0

    const/16 v17, 0x0

    const/4 v13, 0x1

    move-object v12, v7

    move v14, v15

    move/from16 v23, v15

    move/from16 v15, v16

    move-object/from16 v16, v1

    invoke-direct/range {v12 .. v18}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v5, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 188
    move/from16 v24, v3

    move/from16 v30, v9

    move/from16 v25, v11

    const/16 v21, 0x0

    const/high16 v31, 0x41200000    # 10.0f

    goto/16 :goto_1ec

    .line 184
    :cond_102
    move/from16 v23, v15

    .line 189
    iget-object v12, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    add-int v12, v12, v19

    .line 190
    const/4 v13, 0x1

    sub-int/2addr v12, v13

    const/4 v15, 0x0

    invoke-static {v15, v12}, Ljava/lang/Math;->max(II)I

    move-result v12

    int-to-float v12, v12

    mul-float/2addr v12, v8

    sub-float/2addr v5, v12

    const/high16 v13, 0x41200000    # 10.0f

    invoke-static {v13, v5}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 191
    nop

    .line 192
    iget-object v12, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v12

    move v13, v4

    move v1, v15

    :goto_125
    if-ge v1, v12, :cond_189

    .line 193
    iget-object v15, v14, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v15, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 194
    move/from16 v24, v3

    iget v3, v15, Lcom/mrkeyboard/app/SheetModel$KeySpec;->width:F

    invoke-static {v3}, Lcom/mrkeyboard/app/SheetModel;->clampWidth(F)F

    move-result v3

    div-float v3, v3, v22

    mul-float/2addr v3, v5

    .line 195
    move/from16 v25, v11

    new-instance v11, Landroid/graphics/RectF;

    move/from16 v17, v12

    add-float v12, v13, v3

    move-object/from16 v18, v14

    add-float v14, v6, v10

    invoke-direct {v11, v13, v6, v12, v14}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 196
    iget-object v12, v0, Lcom/mrkeyboard/app/SheetGridView;->mAllSheets:Ljava/util/List;

    invoke-static {v15, v12}, Lcom/mrkeyboard/app/SheetKeyboardBuilder;->effectiveDisplayLabel(Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/util/List;)Ljava/lang/String;

    move-result-object v26

    .line 197
    iget-object v14, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v12, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/16 v27, 0x0

    move-object/from16 v29, v12

    move/from16 v28, v17

    move/from16 v30, v9

    move v9, v13

    const/high16 v31, 0x41200000    # 10.0f

    move/from16 v13, v27

    move-object/from16 v33, v14

    move-object/from16 v32, v18

    move/from16 v14, v23

    move-object/from16 v17, v15

    const/16 v21, 0x0

    move v15, v1

    move-object/from16 v16, v11

    move-object/from16 v18, v26

    invoke-direct/range {v12 .. v18}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    move-object/from16 v11, v33

    invoke-virtual {v11, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 198
    add-float/2addr v3, v8

    add-float v13, v9, v3

    .line 192
    add-int/lit8 v1, v1, 0x1

    move/from16 v15, v21

    move/from16 v3, v24

    move/from16 v11, v25

    move/from16 v12, v28

    move/from16 v9, v30

    move-object/from16 v14, v32

    goto :goto_125

    .line 200
    :cond_189
    move/from16 v24, v3

    move/from16 v30, v9

    move/from16 v25, v11

    move v9, v13

    move-object/from16 v32, v14

    move/from16 v21, v15

    const/high16 v31, 0x41200000    # 10.0f

    if-eqz v19, :cond_1c3

    .line 201
    const/high16 v1, 0x3fc00000    # 1.5f

    div-float v1, v1, v22

    mul-float/2addr v1, v5

    .line 202
    new-instance v3, Landroid/graphics/RectF;

    add-float v13, v9, v1

    add-float v1, v6, v10

    invoke-direct {v3, v9, v6, v13, v1}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 203
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-object/from16 v9, v32

    iget-object v11, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v15

    const/16 v17, 0x0

    const-string v18, "\u232b"

    const/4 v13, 0x2

    move-object v12, v5

    move/from16 v14, v23

    move-object/from16 v16, v3

    invoke-direct/range {v12 .. v18}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1c5

    .line 200
    :cond_1c3
    move-object/from16 v9, v32

    .line 205
    :goto_1c5
    if-eqz v7, :cond_1ec

    .line 206
    add-float v1, v4, v2

    .line 207
    new-instance v3, Landroid/graphics/RectF;

    sub-float v5, v1, v20

    add-float v7, v6, v10

    invoke-direct {v3, v5, v6, v1, v7}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 208
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v5, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v7, v9, Lcom/mrkeyboard/app/SheetModel$Row;->keys:Ljava/util/ArrayList;

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v15

    const/16 v17, 0x0

    const-string v18, "+"

    const/4 v13, 0x1

    move-object v12, v5

    move/from16 v14, v23

    move-object/from16 v16, v3

    invoke-direct/range {v12 .. v18}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 211
    :cond_1ec
    :goto_1ec
    add-float v9, v10, v30

    add-float/2addr v6, v9

    .line 168
    add-int/lit8 v15, v23, 0x1

    move/from16 v1, v21

    move/from16 v3, v24

    move/from16 v11, v25

    move/from16 v9, v30

    move/from16 v5, v31

    const/high16 v7, 0x40800000    # 4.0f

    goto/16 :goto_58

    .line 214
    :cond_1ff
    move/from16 v21, v1

    move/from16 v25, v11

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetModel$Sheet;->badge:Ljava/lang/String;

    const-string v3, "123"

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/SheetModel;->sanitizeBadge(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 215
    const-string v3, "."

    const-string v5, "\u23ce"

    const-string v7, ","

    const-string v9, "\u2423"

    filled-new-array {v1, v7, v9, v3, v5}, [Ljava/lang/String;

    move-result-object v1

    .line 216
    nop

    .line 217
    const/high16 v3, 0x40800000    # 4.0f

    mul-float v7, v8, v3

    sub-float/2addr v2, v7

    .line 218
    move/from16 v3, v21

    :goto_221
    const/4 v5, 0x5

    if-ge v3, v5, :cond_24d

    .line 219
    sget-object v5, Lcom/mrkeyboard/app/SheetGridView;->BOTTOM_WEIGHTS:[F

    aget v5, v5, v3

    mul-float/2addr v5, v2

    .line 220
    new-instance v7, Landroid/graphics/RectF;

    add-float v9, v4, v5

    add-float v11, v6, v10

    invoke-direct {v7, v4, v6, v9, v11}, Landroid/graphics/RectF;-><init>(FFFF)V

    .line 221
    iget-object v9, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    new-instance v11, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    const/16 v18, 0x0

    aget-object v19, v1, v3

    const/4 v14, 0x3

    move-object v13, v11

    move/from16 v15, v25

    move/from16 v16, v3

    move-object/from16 v17, v7

    invoke-direct/range {v13 .. v19}, Lcom/mrkeyboard/app/SheetGridView$CellHit;-><init>(IIILandroid/graphics/RectF;Lcom/mrkeyboard/app/SheetModel$KeySpec;Ljava/lang/String;)V

    invoke-virtual {v9, v11}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 222
    add-float/2addr v5, v8

    add-float/2addr v4, v5

    .line 218
    add-int/lit8 v3, v3, 0x1

    goto :goto_221

    .line 224
    :cond_24d
    return-void
.end method

.method private hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;
    .registers 7

    .line 340
    invoke-direct {p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 341
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_a
    if-ge v1, v0, :cond_20

    .line 342
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 343
    iget-object v3, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v3, p1, p2}, Landroid/graphics/RectF;->contains(FF)Z

    move-result v3

    if-eqz v3, :cond_1d

    .line 344
    return-object v2

    .line 341
    :cond_1d
    add-int/lit8 v1, v1, 0x1

    goto :goto_a

    .line 347
    :cond_20
    const/4 p1, 0x0

    return-object p1
.end method


# virtual methods
.method protected onDraw(Landroid/graphics/Canvas;)V
    .registers 19

    .line 228
    move-object/from16 v0, p0

    move-object/from16 v7, p1

    invoke-super/range {p0 .. p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 229
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->ensureCellsBuilt()V

    .line 231
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v1}, Landroid/graphics/Paint;->getStrokeWidth()F

    move-result v1

    const/high16 v8, 0x3f000000    # 0.5f

    mul-float/2addr v1, v8

    .line 232
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getWidth()I

    move-result v3

    int-to-float v3, v3

    sub-float/2addr v3, v1

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/SheetGridView;->getHeight()I

    move-result v4

    int-to-float v4, v4

    sub-float/2addr v4, v1

    invoke-virtual {v2, v1, v1, v3, v4}, Landroid/graphics/RectF;->set(FFFF)V

    .line 233
    const/high16 v9, 0x41600000    # 14.0f

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    .line 234
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mBgPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 235
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mBoundsRect:Landroid/graphics/RectF;

    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mTrayStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v1, v1, v3}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 237
    const/high16 v1, 0x40f00000    # 7.5f

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v10

    .line 238
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v3, 0x0

    :goto_45
    const-string v11, "\u2423"

    const v13, -0xd63a0a

    if-ge v3, v1, :cond_289

    .line 239
    iget-object v4, v0, Lcom/mrkeyboard/app/SheetGridView;->mCells:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 240
    iget-boolean v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    const/4 v6, 0x1

    if-nez v5, :cond_5f

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-ne v5, v4, :cond_5f

    move v5, v6

    goto :goto_60

    :cond_5f
    const/4 v5, 0x0

    .line 241
    :goto_60
    iget-boolean v14, v0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v14, :cond_7e

    iget-object v14, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v14, :cond_7e

    iget v14, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez v14, :cond_7e

    iget v14, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    iget-object v15, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v15, v15, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    if-ne v14, v15, :cond_7e

    iget v14, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    iget-object v15, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v15, v15, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    if-ne v14, v15, :cond_7e

    move v14, v6

    goto :goto_7f

    :cond_7e
    const/4 v14, 0x0

    .line 246
    :goto_7f
    iget v15, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/high16 v2, 0x41480000    # 12.5f

    if-ne v15, v6, :cond_cd

    .line 247
    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz v5, :cond_8d

    const v5, 0x3829c5f6

    goto :goto_90

    :cond_8d
    const v5, 0x2429c5f6

    :goto_90
    invoke-virtual {v11, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 248
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v11}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 249
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    const v11, 0x4d29c5f6    # 1.78020192E8f

    invoke-virtual {v5, v11}, Landroid/graphics/Paint;->setColor(I)V

    .line 250
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v11}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 251
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v13}, Landroid/graphics/Paint;->setColor(I)V

    .line 252
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    iget-object v11, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v11

    if-le v11, v6, :cond_b9

    goto :goto_bb

    :cond_b9
    const/high16 v2, 0x41880000    # 17.0f

    :goto_bb
    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-virtual {v5, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 253
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v7, v2, v4, v5}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    goto/16 :goto_281

    .line 254
    :cond_cd
    iget v15, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/high16 v6, 0x41100000    # 9.0f

    const/high16 v9, 0x40800000    # 4.0f

    const v12, -0x907f67

    if-nez v15, :cond_22b

    .line 255
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->spec:Lcom/mrkeyboard/app/SheetModel$KeySpec;

    .line 256
    const-string v15, "spacer"

    iget-object v8, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v15, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    const v15, -0xf0e9df

    if-eqz v8, :cond_118

    .line 257
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    if-eqz v14, :cond_ee

    const v15, -0xf7f3ee

    :cond_ee
    invoke-virtual {v2, v15}, Landroid/graphics/Paint;->setColor(I)V

    .line 258
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v10, v10, v5}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 259
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mDashedPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v10, v10, v5}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 260
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v12}, Landroid/graphics/Paint;->setColor(I)V

    .line 261
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v5, 0x41200000    # 10.0f

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v5

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 262
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v4, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v7, v11, v2, v4}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    goto/16 :goto_22a

    .line 264
    :cond_118
    const-string v8, "tasker"

    iget-object v11, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-nez v8, :cond_130

    const-string v8, "sheet"

    iget-object v11, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_12d

    goto :goto_130

    :cond_12d
    const/16 v16, 0x0

    goto :goto_132

    :cond_130
    :goto_130
    const/16 v16, 0x1

    .line 265
    :goto_132
    const-string v8, "special"

    iget-object v11, v2, Lcom/mrkeyboard/app/SheetModel$KeySpec;->type:Ljava/lang/String;

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    .line 266
    if-eqz v14, :cond_147

    .line 267
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v15}, Landroid/graphics/Paint;->setColor(I)V

    .line 268
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v13}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_18a

    .line 269
    :cond_147
    if-eqz v5, :cond_157

    .line 270
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    const v8, -0xe3d4be

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 271
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v13}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_18a

    .line 272
    :cond_157
    if-eqz v16, :cond_16a

    .line 273
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    const v8, -0xefdcc8

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 274
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    const v8, -0xe1a576

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_18a

    .line 275
    :cond_16a
    const v5, -0xd5c4ac

    if-eqz v8, :cond_17d

    .line 276
    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    const v11, -0xede4d6

    invoke-virtual {v8, v11}, Landroid/graphics/Paint;->setColor(I)V

    .line 277
    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v8, v5}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_18a

    .line 279
    :cond_17d
    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    const v11, -0xeae0d0

    invoke-virtual {v8, v11}, Landroid/graphics/Paint;->setColor(I)V

    .line 280
    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v8, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 282
    :goto_18a
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v8}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 283
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v8}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 285
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    .line 286
    const/4 v8, 0x2

    if-gt v5, v8, :cond_1a4

    const/high16 v5, 0x41680000    # 14.5f

    goto :goto_1ac

    :cond_1a4
    const/4 v8, 0x4

    if-gt v5, v8, :cond_1aa

    const/high16 v5, 0x41400000    # 12.0f

    goto :goto_1ac

    :cond_1aa
    const/high16 v5, 0x41280000    # 10.5f

    .line 287
    :goto_1ac
    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v5

    invoke-virtual {v8, v5}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 288
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    if-eqz v14, :cond_1ba

    goto :goto_1c3

    :cond_1ba
    if-eqz v16, :cond_1c0

    const v12, -0x822c04

    goto :goto_1c3

    :cond_1c0
    const v12, -0x160f07

    :goto_1c3
    invoke-virtual {v5, v12}, Landroid/graphics/Paint;->setColor(I)V

    .line 289
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    iget-object v8, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v11, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v7, v5, v8, v11}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 291
    invoke-virtual {v2}, Lcom/mrkeyboard/app/SheetModel$KeySpec;->hasAnyPopup()Z

    move-result v2

    if-eqz v2, :cond_1f3

    .line 292
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v13}, Landroid/graphics/Paint;->setColor(I)V

    .line 293
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v2, v2, Landroid/graphics/RectF;->right:F

    invoke-direct {v0, v9}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v5

    sub-float/2addr v2, v5

    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v5, v5, Landroid/graphics/RectF;->top:F

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v6

    add-float/2addr v5, v6

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    const-string v8, "\u2022\u2022\u2022"

    invoke-virtual {v7, v8, v2, v5, v6}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 295
    :cond_1f3
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    if-eqz v2, :cond_22a

    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->width()F

    move-result v2

    const/high16 v5, 0x41e00000    # 28.0f

    invoke-direct {v0, v5}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v5

    cmpl-float v2, v2, v5

    if-lez v2, :cond_22a

    .line 296
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    const v5, -0x6c5c46

    invoke-virtual {v2, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 297
    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->widthBadge:Ljava/lang/String;

    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v5, v5, Landroid/graphics/RectF;->right:F

    const/high16 v6, 0x40400000    # 3.0f

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v8

    sub-float/2addr v5, v8

    iget-object v4, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget v4, v4, Landroid/graphics/RectF;->bottom:F

    invoke-direct {v0, v6}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v6

    sub-float/2addr v4, v6

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetGridView;->mBadgePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v2, v5, v4, v6}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 300
    :cond_22a
    :goto_22a
    goto :goto_281

    .line 302
    :cond_22b
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    const v8, -0xf1ebe1

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 303
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v8}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 304
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    const v8, -0xe5dacb

    invoke-virtual {v5, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 305
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v5, v10, v10, v8}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 306
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v12}, Landroid/graphics/Paint;->setColor(I)V

    .line 307
    iget-object v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-virtual {v5, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 308
    iget-object v5, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    iget-object v8, v0, Lcom/mrkeyboard/app/SheetGridView;->mLockRect:Landroid/graphics/RectF;

    iget v6, v5, Landroid/graphics/RectF;->left:F

    iget v9, v5, Landroid/graphics/RectF;->top:F

    const/high16 v11, 0x40d00000    # 6.5f

    invoke-direct {v0, v11}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v11

    add-float/2addr v9, v11

    iget v11, v5, Landroid/graphics/RectF;->right:F

    iget v12, v5, Landroid/graphics/RectF;->bottom:F

    invoke-virtual {v8, v6, v9, v11, v12}, Landroid/graphics/RectF;->set(FFFF)V

    iget-object v2, v4, Lcom/mrkeyboard/app/SheetGridView$CellHit;->displayLabel:Ljava/lang/String;

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v7, v2, v8, v6}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 309
    invoke-direct {v0, v7, v5}, Lcom/mrkeyboard/app/SheetGridView;->drawLockIcon(Landroid/graphics/Canvas;Landroid/graphics/RectF;)V

    .line 238
    :goto_281
    add-int/lit8 v3, v3, 0x1

    const/high16 v8, 0x3f000000    # 0.5f

    const/high16 v9, 0x41600000    # 14.0f

    goto/16 :goto_45

    .line 314
    :cond_289
    iget-boolean v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz v1, :cond_320

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz v1, :cond_320

    .line 315
    iget v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    const/4 v2, 0x0

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_2a7

    .line 316
    iget v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineTop:F

    iget v4, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineBottom:F

    iget-object v6, v0, Lcom/mrkeyboard/app/SheetGridView;->mDropLinePaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 318
    :cond_2a7
    const/high16 v1, 0x42300000    # 44.0f

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v1

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->width()F

    move-result v2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(FF)F

    move-result v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float/2addr v1, v2

    .line 319
    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v2, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->height()F

    move-result v2

    .line 320
    iget-object v3, v0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget v4, v0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    sub-float/2addr v4, v1

    iget v5, v0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    const v6, 0x3f933333    # 1.15f

    mul-float/2addr v6, v2

    sub-float/2addr v5, v6

    iget v6, v0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    add-float/2addr v6, v1

    iget v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    const v8, 0x3e19999a    # 0.15f

    mul-float/2addr v2, v8

    sub-float/2addr v1, v2

    invoke-virtual {v3, v4, v5, v6, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 321
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mGhostFillPaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v10, v10, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 322
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v13}, Landroid/graphics/Paint;->setColor(I)V

    .line 323
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mKeyStrokePaint:Landroid/graphics/Paint;

    invoke-virtual {v7, v1, v10, v10, v2}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 324
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const v2, -0x160f07

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 325
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x41600000    # 14.0f

    invoke-direct {v0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 326
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    if-eqz v1, :cond_318

    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v1, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_318

    .line 327
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget-object v11, v1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->shortLabel:Ljava/lang/String;

    goto :goto_319

    .line 328
    :cond_318
    nop

    .line 329
    :goto_319
    iget-object v1, v0, Lcom/mrkeyboard/app/SheetGridView;->mGhostRect:Landroid/graphics/RectF;

    iget-object v2, v0, Lcom/mrkeyboard/app/SheetGridView;->mLabelPaint:Landroid/graphics/Paint;

    invoke-direct {v0, v7, v11, v1, v2}, Lcom/mrkeyboard/app/SheetGridView;->drawCenteredText(Landroid/graphics/Canvas;Ljava/lang/String;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 331
    :cond_320
    return-void
.end method

.method protected onMeasure(II)V
    .registers 8

    .line 137
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result p1

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    const/4 v1, 0x1

    if-eqz v0, :cond_21

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_21

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    iget-object v0, v0, Lcom/mrkeyboard/app/SheetModel$Sheet;->rows:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v2, 0x6

    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    goto :goto_22

    .line 140
    :cond_21
    move v0, v1

    .line 141
    :goto_22
    add-int/2addr v0, v1

    .line 142
    const/high16 v2, 0x42400000    # 48.0f

    invoke-direct {p0, v2}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v2

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 143
    const/high16 v3, 0x40a00000    # 5.0f

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v3

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    .line 144
    const/high16 v4, 0x41200000    # 10.0f

    invoke-direct {p0, v4}, Lcom/mrkeyboard/app/SheetGridView;->dp(F)F

    move-result v4

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    .line 145
    mul-int/lit8 v4, v4, 0x2

    mul-int/2addr v2, v0

    add-int/2addr v4, v2

    sub-int/2addr v0, v1

    mul-int/2addr v0, v3

    add-int/2addr v4, v0

    .line 146
    invoke-static {v4, p2}, Lcom/mrkeyboard/app/SheetGridView;->resolveSize(II)I

    move-result p2

    invoke-virtual {p0, p1, p2}, Lcom/mrkeyboard/app/SheetGridView;->setMeasuredDimension(II)V

    .line 147
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .registers 5

    .line 129
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    .line 130
    if-ne p1, p3, :cond_7

    if-eq p2, p4, :cond_a

    .line 131
    :cond_7
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 133
    :cond_a
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .registers 8

    .line 412
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    .line 413
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    .line 414
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x1

    packed-switch v2, :pswitch_data_116

    .line 495
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1

    .line 488
    :pswitch_17
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 489
    iput-boolean v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 490
    iput-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 491
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 492
    return v5

    .line 435
    :pswitch_26
    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 436
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 437
    iget-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-nez p1, :cond_52

    .line 438
    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float/2addr v0, p1

    .line 439
    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float/2addr v1, p1

    .line 440
    mul-float/2addr v0, v0

    mul-float/2addr v1, v1

    add-float/2addr v0, v1

    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    mul-int/2addr p1, v1

    int-to-float p1, p1

    cmpl-float p1, v0, p1

    if-lez p1, :cond_51

    .line 441
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 442
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz p1, :cond_51

    .line 443
    iput-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 444
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 447
    :cond_51
    goto :goto_58

    .line 448
    :cond_52
    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->computeDropTarget(FF)V

    .line 449
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 451
    :goto_58
    return v5

    .line 454
    :pswitch_59
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-virtual {p1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 455
    iget-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    if-eqz p1, :cond_89

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz p1, :cond_89

    .line 456
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget p1, p1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    .line 457
    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget v0, v0, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    .line 458
    iget v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 459
    iget v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 460
    iput-boolean v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 461
    iput-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 462
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 463
    if-ltz v1, :cond_dc

    if-ltz v2, :cond_dc

    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz v3, :cond_dc

    .line 464
    iget-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {v3, p1, v0, v1, v2}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyDragged(IIII)V

    goto :goto_dc

    .line 466
    :cond_89
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz p1, :cond_dc

    .line 467
    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    sub-float/2addr v0, p1

    .line 468
    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    sub-float/2addr v1, p1

    .line 469
    iget p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mTouchSlop:I

    int-to-float p1, p1

    const/high16 v2, 0x3fc00000    # 1.5f

    mul-float/2addr p1, v2

    .line 470
    iget-object v2, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 471
    iput-object v3, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 472
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 473
    mul-float/2addr v0, v0

    mul-float/2addr v1, v1

    add-float/2addr v0, v1

    mul-float/2addr p1, p1

    cmpg-float p1, v0, p1

    if-gtz p1, :cond_dd

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    if-eqz p1, :cond_dd

    .line 474
    iget p1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez p1, :cond_ba

    .line 475
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    iget v1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->keyIdx:I

    invoke-interface {p1, v0, v1}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onKeyTapped(II)V

    goto :goto_dd

    .line 476
    :cond_ba
    iget p1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-ne p1, v5, :cond_c6

    .line 477
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    iget v0, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->rowIdx:I

    invoke-interface {p1, v0}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onAddKeyTapped(I)V

    goto :goto_dd

    .line 478
    :cond_c6
    iget p1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v0, 0x2

    if-ne p1, v0, :cond_d1

    .line 479
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {p1, v5}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_dd

    .line 480
    :cond_d1
    iget p1, v2, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    const/4 v0, 0x3

    if-ne p1, v0, :cond_dd

    .line 481
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    invoke-interface {p1, v4}, Lcom/mrkeyboard/app/SheetGridView$GridListener;->onLockedKeyTapped(Z)V

    goto :goto_dd

    .line 466
    :cond_dc
    :goto_dc
    nop

    .line 485
    :cond_dd
    :goto_dd
    return v5

    .line 416
    :pswitch_de
    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownX:F

    .line 417
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownY:F

    .line 418
    iput v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveX:F

    .line 419
    iput v1, p0, Lcom/mrkeyboard/app/SheetGridView;->mMoveY:F

    .line 420
    iput-boolean v4, p0, Lcom/mrkeyboard/app/SheetGridView;->mDragging:Z

    .line 421
    const/4 p1, -0x1

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropRow:I

    .line 422
    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropIndex:I

    .line 423
    const/high16 p1, -0x40800000    # -1.0f

    iput p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDropLineX:F

    .line 424
    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/SheetGridView;->hitTest(FF)Lcom/mrkeyboard/app/SheetGridView$CellHit;

    move-result-object p1

    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    .line 425
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz p1, :cond_10d

    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    iget p1, p1, Lcom/mrkeyboard/app/SheetGridView$CellHit;->kind:I

    if-nez p1, :cond_10d

    .line 426
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mHandler:Landroid/os/Handler;

    iget-object v0, p0, Lcom/mrkeyboard/app/SheetGridView;->mLongPressRunnable:Ljava/lang/Runnable;

    invoke-static {}, Landroid/view/ViewConfiguration;->getLongPressTimeout()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 428
    :cond_10d
    iget-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mDownCell:Lcom/mrkeyboard/app/SheetGridView$CellHit;

    if-eqz p1, :cond_115

    .line 429
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 430
    return v5

    .line 432
    :cond_115
    return v4

    :pswitch_data_116
    .packed-switch 0x0
        :pswitch_de
        :pswitch_59
        :pswitch_26
        :pswitch_17
    .end packed-switch
.end method

.method public setData(Lcom/mrkeyboard/app/SheetModel$Sheet;Ljava/util/List;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            "Ljava/util/List<",
            "Lcom/mrkeyboard/app/SheetModel$Sheet;",
            ">;)V"
        }
    .end annotation

    .line 120
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mSheet:Lcom/mrkeyboard/app/SheetModel$Sheet;

    .line 121
    iput-object p2, p0, Lcom/mrkeyboard/app/SheetGridView;->mAllSheets:Ljava/util/List;

    .line 122
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mCellsDirty:Z

    .line 123
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->requestLayout()V

    .line 124
    invoke-virtual {p0}, Lcom/mrkeyboard/app/SheetGridView;->invalidate()V

    .line 125
    return-void
.end method

.method public setGridListener(Lcom/mrkeyboard/app/SheetGridView$GridListener;)V
    .registers 2

    .line 116
    iput-object p1, p0, Lcom/mrkeyboard/app/SheetGridView;->mListener:Lcom/mrkeyboard/app/SheetGridView$GridListener;

    .line 117
    return-void
.end method
