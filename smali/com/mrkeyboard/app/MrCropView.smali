.class final Lcom/mrkeyboard/app/MrCropView;
.super Landroid/view/View;
.source "MrCropView.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrCropView$Listener;
    }
.end annotation


# static fields
.field private static final OUTSIDE:I = -0x67000000


# instance fields
.field private final mDensity:F

.field private final mDest:Landroid/graphics/Rect;

.field private mDx:I

.field private mDy:I

.field private mImage:Landroid/graphics/Bitmap;

.field private mLastX:F

.field private mLastY:F

.field private mListener:Lcom/mrkeyboard/app/MrCropView$Listener;

.field private final mPaint:Landroid/graphics/Paint;

.field private mPinching:Z

.field private mScale:F

.field private mStartDistance:F

.field private mStartZoom:I

.field private mZoom:I


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 40
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 26
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    .line 29
    const/16 v0, 0x64

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    .line 32
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    .line 33
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    .line 41
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDensity:F

    .line 42
    return-void
.end method

.method private changed()V
    .locals 1

    .prologue
    .line 193
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->invalidate()V

    .line 194
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mListener:Lcom/mrkeyboard/app/MrCropView$Listener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mListener:Lcom/mrkeyboard/app/MrCropView$Listener;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrCropView$Listener;->changed()V

    .line 195
    :cond_0
    return-void
.end method

.method private static distance(Landroid/view/MotionEvent;)F
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 166
    invoke-virtual {p0, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v0

    invoke-virtual {p0, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    sub-float/2addr v0, v1

    invoke-virtual {p0, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v1

    invoke-virtual {p0, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    sub-float/2addr v1, v2

    .line 167
    mul-float/2addr v0, v0

    mul-float/2addr v1, v1

    add-float/2addr v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-float v0, v0

    return v0
.end method

.method private drag(FF)V
    .locals 11

    .prologue
    const/4 v10, 0x1

    const/4 v9, 0x0

    .line 172
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    const/4 v1, 0x0

    cmpg-float v0, v0, v1

    if-gtz v0, :cond_1

    .line 178
    :cond_0
    :goto_0
    return-void

    .line 173
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {}, Lcom/mrkeyboard/app/MrCropView;->shapeW()I

    move-result v2

    const/16 v3, 0x64

    iget v4, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    iget v5, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    iget v6, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    iget v7, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    div-float v7, p1, v7

    iget v8, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    div-float v8, p2, v8

    invoke-static/range {v0 .. v8}, Lcom/mrkeyboard/app/MrBackdrop;->shift(IIIIIIIFF)[I

    move-result-object v0

    .line 174
    aget v1, v0, v9

    iget v2, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    if-ne v1, v2, :cond_2

    aget v1, v0, v10

    iget v2, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    if-eq v1, v2, :cond_0

    .line 175
    :cond_2
    aget v1, v0, v9

    iput v1, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    .line 176
    aget v0, v0, v10

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    .line 177
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCropView;->changed()V

    goto :goto_0
.end method

.method private pinch(F)V
    .locals 8

    .prologue
    const/16 v3, 0x64

    const/high16 v1, 0x3f800000    # 1.0f

    .line 182
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mStartDistance:F

    cmpg-float v0, v0, v1

    if-ltz v0, :cond_0

    cmpg-float v0, p1, v1

    if-gez v0, :cond_1

    .line 190
    :cond_0
    :goto_0
    return-void

    .line 183
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mStartZoom:I

    int-to-float v0, v0

    iget v1, p0, Lcom/mrkeyboard/app/MrCropView;->mStartDistance:F

    mul-float/2addr v0, v1

    div-float/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    const/16 v1, 0x190

    invoke-static {v0, v3, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v7

    .line 184
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    if-eq v7, v0, :cond_0

    .line 185
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {}, Lcom/mrkeyboard/app/MrCropView;->shapeW()I

    move-result v2

    iget v4, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    iget v5, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    iget v6, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    invoke-static/range {v0 .. v7}, Lcom/mrkeyboard/app/MrBackdrop;->rezoom(IIIIIIII)[I

    move-result-object v0

    .line 186
    iput v7, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    .line 187
    const/4 v1, 0x0

    aget v1, v0, v1

    iput v1, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    .line 188
    const/4 v1, 0x1

    aget v0, v0, v1

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    .line 189
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrCropView;->changed()V

    goto :goto_0
.end method

.method private place(II)V
    .locals 6

    .prologue
    const/4 v5, 0x1

    .line 76
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    .line 77
    int-to-float v2, p1

    int-to-float v3, v0

    div-float/2addr v2, v3

    int-to-float v3, p2

    int-to-float v4, v1

    div-float/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    .line 78
    int-to-float v0, v0

    iget v2, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    int-to-float v1, v1

    iget v2, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v5, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 79
    sub-int v2, p1, v0

    div-int/lit8 v2, v2, 0x2

    sub-int v3, p2, v1

    div-int/lit8 v3, v3, 0x2

    .line 80
    iget-object v4, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    add-int/2addr v0, v2

    add-int/2addr v1, v3

    invoke-virtual {v4, v2, v3, v0, v1}, Landroid/graphics/Rect;->set(IIII)V

    .line 81
    return-void
.end method

.method private static shapeW()I
    .locals 1

    .prologue
    .line 85
    const/high16 v0, 0x432a0000    # 170.0f

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method


# virtual methods
.method dx()I
    .locals 1

    .prologue
    .line 62
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    return v0
.end method

.method dy()I
    .locals 1

    .prologue
    .line 66
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    return v0
.end method

.method frame()Landroid/graphics/Rect;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 90
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getWidth()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getHeight()I

    move-result v0

    if-gtz v0, :cond_1

    :cond_0
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0, v1, v1, v1, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 93
    :goto_0
    return-object v0

    .line 91
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getHeight()I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/mrkeyboard/app/MrCropView;->place(II)V

    .line 92
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    invoke-static {}, Lcom/mrkeyboard/app/MrCropView;->shapeW()I

    move-result v2

    const/16 v3, 0x64

    iget v4, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    iget v5, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    iget v6, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrBackdrop;->crop(IIIIIII)Landroid/graphics/Rect;

    move-result-object v1

    .line 93
    new-instance v0, Landroid/graphics/Rect;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v2, v2, Landroid/graphics/Rect;->left:I

    iget v3, v1, Landroid/graphics/Rect;->left:I

    int-to-float v3, v3

    iget v4, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v3, v4

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    add-int/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->top:I

    iget v4, v1, Landroid/graphics/Rect;->top:I

    int-to-float v4, v4

    iget v5, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    add-int/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->left:I

    iget v5, v1, Landroid/graphics/Rect;->right:I

    int-to-float v5, v5

    iget v6, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v5, v6

    .line 94
    invoke-static {v5}, Ljava/lang/Math;->round(F)I

    move-result v5

    add-int/2addr v4, v5

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->top:I

    iget v1, v1, Landroid/graphics/Rect;->bottom:I

    int-to-float v1, v1

    iget v6, p0, Lcom/mrkeyboard/app/MrCropView;->mScale:F

    mul-float/2addr v1, v6

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    add-int/2addr v1, v5

    invoke-direct {v0, v2, v3, v4, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    goto :goto_0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 9

    .prologue
    const/4 v4, 0x0

    const/high16 v8, 0x40000000    # 2.0f

    .line 99
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getHeight()I

    move-result v1

    .line 100
    iget-object v2, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    if-eqz v2, :cond_0

    if-lez v0, :cond_0

    if-gtz v1, :cond_1

    .line 117
    :cond_0
    :goto_0
    return-void

    .line 101
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->frame()Landroid/graphics/Rect;

    move-result-object v6

    .line 102
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 103
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setFilterBitmap(Z)V

    .line 104
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    new-instance v1, Landroid/graphics/Rect;

    iget-object v2, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    invoke-direct {v1, v4, v4, v2, v3}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v2, Landroid/graphics/Rect;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v3, v3, Landroid/graphics/Rect;->left:I

    iget-object v4, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v4, v4, Landroid/graphics/Rect;->top:I

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v5, v5, Landroid/graphics/Rect;->right:I

    iget-object v7, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v7, v7, Landroid/graphics/Rect;->bottom:I

    invoke-direct {v2, v3, v4, v5, v7}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 106
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, -0x67000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 107
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->top:I

    int-to-float v2, v0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    int-to-float v3, v0

    iget v0, v6, Landroid/graphics/Rect;->top:I

    int-to-float v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 108
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v0

    iget v0, v6, Landroid/graphics/Rect;->bottom:I

    int-to-float v2, v0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    int-to-float v3, v0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    int-to-float v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 109
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->left:I

    int-to-float v1, v0

    iget v0, v6, Landroid/graphics/Rect;->top:I

    int-to-float v2, v0

    iget v0, v6, Landroid/graphics/Rect;->left:I

    int-to-float v3, v0

    iget v0, v6, Landroid/graphics/Rect;->bottom:I

    int-to-float v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 110
    iget v0, v6, Landroid/graphics/Rect;->right:I

    int-to-float v1, v0

    iget v0, v6, Landroid/graphics/Rect;->top:I

    int-to-float v2, v0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDest:Landroid/graphics/Rect;

    iget v0, v0, Landroid/graphics/Rect;->right:I

    int-to-float v3, v0

    iget v0, v6, Landroid/graphics/Rect;->bottom:I

    int-to-float v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 111
    const/high16 v0, 0x3f800000    # 1.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrCropView;->mDensity:F

    const v2, 0x3f99999a    # 1.2f

    mul-float/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 112
    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 113
    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 114
    iget-object v1, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 115
    iget v1, v6, Landroid/graphics/Rect;->left:I

    int-to-float v1, v1

    div-float v2, v0, v8

    add-float/2addr v1, v2

    iget v2, v6, Landroid/graphics/Rect;->top:I

    int-to-float v2, v2

    div-float v3, v0, v8

    add-float/2addr v2, v3

    iget v3, v6, Landroid/graphics/Rect;->right:I

    int-to-float v3, v3

    div-float v4, v0, v8

    sub-float/2addr v3, v4

    iget v4, v6, Landroid/graphics/Rect;->bottom:I

    int-to-float v4, v4

    div-float/2addr v0, v8

    sub-float/2addr v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 116
    iget-object v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 71
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    invoke-static {p2}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrCropView;->setMeasuredDimension(II)V

    .line 72
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 4

    .prologue
    const/4 v3, 0x2

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 123
    iget-object v2, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    if-eqz v2, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getWidth()I

    move-result v2

    if-lez v2, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->getHeight()I

    move-result v2

    if-gtz v2, :cond_2

    :cond_0
    move v1, v0

    .line 161
    :cond_1
    :goto_0
    return v1

    .line 124
    :cond_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v2

    .line 125
    packed-switch v2, :pswitch_data_0

    :pswitch_0
    move v1, v0

    .line 161
    goto :goto_0

    .line 127
    :pswitch_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrCropView;->mLastX:F

    .line 128
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrCropView;->mLastY:F

    .line 129
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    goto :goto_0

    .line 132
    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-lt v0, v3, :cond_1

    .line 133
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    .line 134
    invoke-static {p1}, Lcom/mrkeyboard/app/MrCropView;->distance(Landroid/view/MotionEvent;)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mStartDistance:F

    .line 135
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mStartZoom:I

    goto :goto_0

    .line 139
    :pswitch_3
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v2

    if-gt v2, v3, :cond_1

    .line 141
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    .line 142
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v2

    if-nez v2, :cond_3

    move v0, v1

    .line 143
    :cond_3
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrCropView;->mLastX:F

    .line 144
    invoke-virtual {p1, v0}, Landroid/view/MotionEvent;->getY(I)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mLastY:F

    goto :goto_0

    .line 148
    :pswitch_4
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    if-eqz v0, :cond_4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-lt v0, v3, :cond_4

    .line 149
    invoke-static {p1}, Lcom/mrkeyboard/app/MrCropView;->distance(Landroid/view/MotionEvent;)F

    move-result v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrCropView;->pinch(F)V

    goto :goto_0

    .line 150
    :cond_4
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    if-nez v0, :cond_1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-lt v0, v1, :cond_1

    .line 151
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iget v2, p0, Lcom/mrkeyboard/app/MrCropView;->mLastX:F

    sub-float/2addr v0, v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    iget v3, p0, Lcom/mrkeyboard/app/MrCropView;->mLastY:F

    sub-float/2addr v2, v3

    invoke-direct {p0, v0, v2}, Lcom/mrkeyboard/app/MrCropView;->drag(FF)V

    .line 152
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mLastX:F

    .line 153
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mLastY:F

    goto/16 :goto_0

    .line 158
    :pswitch_5
    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrCropView;->mPinching:Z

    goto/16 :goto_0

    .line 125
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_5
        :pswitch_4
        :pswitch_5
        :pswitch_0
        :pswitch_2
        :pswitch_3
    .end packed-switch
.end method

.method set(Landroid/graphics/Bitmap;III)V
    .locals 3

    .prologue
    const/16 v2, -0x64

    const/16 v1, 0x64

    .line 46
    iput-object p1, p0, Lcom/mrkeyboard/app/MrCropView;->mImage:Landroid/graphics/Bitmap;

    .line 47
    const/16 v0, 0x190

    invoke-static {p2, v1, v0}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    .line 48
    invoke-static {p3, v2, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDx:I

    .line 49
    invoke-static {p4, v2, v1}, Lcom/mrkeyboard/app/MrBackdrop;->clamp(III)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrCropView;->mDy:I

    .line 50
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrCropView;->invalidate()V

    .line 51
    return-void
.end method

.method setListener(Lcom/mrkeyboard/app/MrCropView$Listener;)V
    .locals 0

    .prologue
    .line 54
    iput-object p1, p0, Lcom/mrkeyboard/app/MrCropView;->mListener:Lcom/mrkeyboard/app/MrCropView$Listener;

    .line 55
    return-void
.end method

.method zoom()I
    .locals 1

    .prologue
    .line 58
    iget v0, p0, Lcom/mrkeyboard/app/MrCropView;->mZoom:I

    return v0
.end method
