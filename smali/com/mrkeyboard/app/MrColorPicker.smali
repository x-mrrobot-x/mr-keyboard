.class final Lcom/mrkeyboard/app/MrColorPicker;
.super Landroid/view/View;
.source "MrColorPicker.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrColorPicker$Listener;
    }
.end annotation


# static fields
.field static final BAR_DP:I = 0x1e

.field static final GAP_DP:I = 0xe

.field private static final HUES:[I

.field static final SQUARE_DP:I = 0x96


# instance fields
.field private final mDensity:F

.field private final mHsv:[F

.field private mListener:Lcom/mrkeyboard/app/MrColorPicker$Listener;

.field private final mPaint:Landroid/graphics/Paint;

.field private mPart:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 26
    const/4 v0, 0x7

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrColorPicker;->HUES:[I

    return-void

    nop

    :array_0
    .array-data 4
        -0x10000
        -0x100
        -0xff0100
        -0xff0001
        -0xffff01
        -0xff01
        -0x10000
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 36
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 28
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    .line 30
    const/4 v0, 0x3

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    .line 37
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    .line 38
    return-void

    .line 30
    :array_0
    .array-data 4
        0x43520000    # 210.0f
        0x3f19999a    # 0.6f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private barH()I
    .locals 2

    .prologue
    .line 69
    const/high16 v0, 0x41f00000    # 30.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method private barTop()I
    .locals 3

    .prologue
    .line 65
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->squareH()I

    move-result v0

    const/high16 v1, 0x41600000    # 14.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    add-int/2addr v0, v1

    return v0
.end method

.method private knob(Landroid/graphics/Canvas;FFIF)V
    .locals 3

    .prologue
    .line 137
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p4}, Landroid/graphics/Paint;->setColor(I)V

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3, p5, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 141
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x40200000    # 2.5f

    iget v2, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 142
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 143
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3, p5, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 144
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 145
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x66000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 146
    const/high16 v0, 0x3fc00000    # 1.5f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v0, v1

    add-float/2addr v0, p5

    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2, p3, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 147
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 148
    return-void
.end method

.method private squareH()I
    .locals 2

    .prologue
    .line 61
    const/high16 v0, 0x43160000    # 150.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method


# virtual methods
.method color()I
    .locals 4

    .prologue
    .line 52
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v2, 0x1

    aget v1, v1, v2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v3, 0x2

    aget v2, v2, v3

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    return v0
.end method

.method drag(IFF)V
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v2, 0x0

    const/high16 v3, 0x3f800000    # 1.0f

    .line 80
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->getWidth()I

    move-result v0

    .line 81
    if-gtz v0, :cond_1

    .line 94
    :cond_0
    :goto_0
    return-void

    .line 82
    :cond_1
    int-to-float v0, v0

    div-float v0, p2, v0

    invoke-static {v3, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 83
    if-ne p1, v4, :cond_2

    .line 84
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->squareH()I

    move-result v1

    int-to-float v1, v1

    div-float v1, p3, v1

    invoke-static {v3, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 85
    iget-object v2, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    aput v0, v2, v4

    .line 86
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    sub-float v1, v3, v1

    aput v1, v0, v5

    .line 92
    :goto_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->invalidate()V

    .line 93
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mListener:Lcom/mrkeyboard/app/MrColorPicker$Listener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mListener:Lcom/mrkeyboard/app/MrColorPicker$Listener;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->color()I

    move-result v1

    invoke-interface {v0, v1}, Lcom/mrkeyboard/app/MrColorPicker$Listener;->onColor(I)V

    goto :goto_0

    .line 87
    :cond_2
    if-ne p1, v5, :cond_0

    .line 88
    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v2, 0x0

    const v3, 0x43b3feb8    # 359.99f

    mul-float/2addr v0, v3

    aput v0, v1, v2

    goto :goto_1
.end method

.method hue()F
    .locals 2

    .prologue
    .line 57
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 15

    .prologue
    .line 118
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->getWidth()I

    move-result v8

    .line 119
    if-gtz v8, :cond_0

    .line 133
    :goto_0
    return-void

    .line 120
    :cond_0
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->squareH()I

    move-result v9

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->barTop()I

    move-result v10

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->barH()I

    move-result v11

    .line 121
    const/high16 v0, 0x41000000    # 8.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float v12, v0, v1

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 124
    iget-object v13, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LinearGradient;

    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, v8

    const/4 v4, 0x0

    const/4 v5, -0x1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v7, 0x0

    aget v6, v6, v7

    const/high16 v7, 0x3f800000    # 1.0f

    const/high16 v14, 0x3f800000    # 1.0f

    invoke-static {v6, v7, v14}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v6

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v13, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 125
    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, v8

    int-to-float v4, v9

    iget-object v7, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v5, v12

    move v6, v12

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 126
    iget-object v13, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LinearGradient;

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    int-to-float v4, v9

    const/4 v5, 0x0

    const/high16 v6, -0x1000000

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v13, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 127
    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, v8

    int-to-float v4, v9

    iget-object v7, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    move v5, v12

    move v6, v12

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 128
    iget-object v12, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LinearGradient;

    const/4 v1, 0x0

    int-to-float v2, v10

    int-to-float v3, v8

    int-to-float v4, v10

    sget-object v5, Lcom/mrkeyboard/app/MrColorPicker;->HUES:[I

    const/4 v6, 0x0

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v12, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 129
    const/4 v1, 0x0

    int-to-float v2, v10

    int-to-float v3, v8

    add-int v0, v10, v11

    int-to-float v4, v0

    int-to-float v0, v11

    const/high16 v5, 0x40000000    # 2.0f

    div-float v5, v0, v5

    int-to-float v0, v11

    const/high16 v6, 0x40000000    # 2.0f

    div-float v6, v0, v6

    iget-object v7, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 130
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v1, 0x1

    aget v0, v0, v1

    int-to-float v1, v8

    mul-float v2, v0, v1

    const/high16 v0, 0x3f800000    # 1.0f

    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v3, 0x2

    aget v1, v1, v3

    sub-float/2addr v0, v1

    int-to-float v1, v9

    mul-float v3, v0, v1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->color()I

    move-result v4

    const/high16 v0, 0x41300000    # 11.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float v5, v0, v1

    move-object v0, p0

    move-object/from16 v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrColorPicker;->knob(Landroid/graphics/Canvas;FFIF)V

    .line 132
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    const v1, 0x43b3feb8    # 359.99f

    div-float/2addr v0, v1

    int-to-float v1, v8

    mul-float v2, v0, v1

    int-to-float v0, v10

    int-to-float v1, v11

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v1, v3

    add-float v3, v0, v1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    const/4 v1, 0x0

    aget v0, v0, v1

    const/high16 v1, 0x3f800000    # 1.0f

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v0, v1, v4}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v4

    int-to-float v0, v11

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v1, v5

    sub-float v5, v0, v1

    move-object v0, p0

    move-object/from16 v1, p1

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrColorPicker;->knob(Landroid/graphics/Canvas;FFIF)V

    goto/16 :goto_0
.end method

.method protected onMeasure(II)V
    .locals 3

    .prologue
    .line 74
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    .line 75
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->barTop()I

    move-result v1

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->barH()I

    move-result v2

    add-int/2addr v1, v2

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrColorPicker;->setMeasuredDimension(II)V

    .line 76
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 9

    .prologue
    const/4 v2, 0x2

    const/4 v3, 0x0

    const/high16 v8, 0x41600000    # 14.0f

    const/high16 v7, 0x40000000    # 2.0f

    const/4 v1, 0x1

    .line 98
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v4

    .line 99
    if-nez v4, :cond_0

    .line 100
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v0

    .line 101
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->squareH()I

    move-result v5

    int-to-float v5, v5

    iget v6, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v6, v8

    div-float/2addr v6, v7

    add-float/2addr v5, v6

    cmpg-float v5, v0, v5

    if-gtz v5, :cond_2

    move v0, v1

    :goto_0
    iput v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPart:I

    .line 102
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    .line 103
    if-eqz v0, :cond_0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 105
    :cond_0
    if-eqz v4, :cond_1

    if-ne v4, v2, :cond_4

    .line 106
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPart:I

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-virtual {p0, v0, v2, v3}, Lcom/mrkeyboard/app/MrColorPicker;->drag(IFF)V

    .line 113
    :goto_1
    return v1

    .line 101
    :cond_2
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrColorPicker;->barTop()I

    move-result v5

    int-to-float v5, v5

    iget v6, p0, Lcom/mrkeyboard/app/MrColorPicker;->mDensity:F

    mul-float/2addr v6, v8

    div-float/2addr v6, v7

    sub-float/2addr v5, v6

    cmpl-float v0, v0, v5

    if-ltz v0, :cond_3

    move v0, v2

    goto :goto_0

    :cond_3
    move v0, v3

    goto :goto_0

    .line 109
    :cond_4
    if-eq v4, v1, :cond_5

    const/4 v0, 0x3

    if-ne v4, v0, :cond_6

    .line 110
    :cond_5
    iput v3, p0, Lcom/mrkeyboard/app/MrColorPicker;->mPart:I

    goto :goto_1

    .line 113
    :cond_6
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v1

    goto :goto_1
.end method

.method setColor(I)V
    .locals 1

    .prologue
    .line 46
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorPicker;->mHsv:[F

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 47
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorPicker;->invalidate()V

    .line 48
    return-void
.end method

.method setListener(Lcom/mrkeyboard/app/MrColorPicker$Listener;)V
    .locals 0

    .prologue
    .line 41
    iput-object p1, p0, Lcom/mrkeyboard/app/MrColorPicker;->mListener:Lcom/mrkeyboard/app/MrColorPicker$Listener;

    .line 42
    return-void
.end method
