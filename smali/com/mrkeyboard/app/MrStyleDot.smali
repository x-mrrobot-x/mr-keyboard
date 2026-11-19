.class final Lcom/mrkeyboard/app/MrStyleDot;
.super Landroid/view/View;
.source "MrStyleDot.java"


# static fields
.field static final SIZE_DP:I = 0x28


# instance fields
.field private final mChosen:Z

.field private final mDensity:F

.field private final mPaint:Landroid/graphics/Paint;

.field private final mRing:I

.field private final mStyle:I


# direct methods
.method constructor <init>(Landroid/content/Context;IZI)V
    .locals 2

    .prologue
    .line 26
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 19
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    .line 27
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    .line 28
    iput p2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    .line 29
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    .line 30
    iput p4, p0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    .line 31
    return-void
.end method


# virtual methods
.method chosen()Z
    .locals 1

    .prologue
    .line 40
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 13

    .prologue
    const v1, 0x3f0ccccd    # 0.55f

    const v7, 0x3ecccccd    # 0.4f

    const/4 v6, 0x0

    const/4 v4, 0x0

    const/high16 v12, 0x40000000    # 2.0f

    .line 51
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrStyleDot;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrStyleDot;->getHeight()I

    move-result v2

    .line 52
    if-lez v0, :cond_0

    if-gtz v2, :cond_1

    .line 93
    :cond_0
    :goto_0
    return-void

    .line 53
    :cond_1
    int-to-float v3, v0

    div-float v8, v3, v12

    int-to-float v3, v2

    div-float v9, v3, v12

    .line 54
    invoke-static {v0, v2}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, v12

    const/high16 v2, 0x3fc00000    # 1.5f

    iget v3, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v3

    sub-float v10, v0, v2

    .line 55
    const/high16 v0, 0x40a00000    # 5.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v0, v2

    sub-float v11, v10, v0

    .line 56
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    sget v3, Lcom/mrkeyboard/app/MrBackdrop;->STYLES:I

    add-int/lit8 v3, v3, -0x1

    invoke-static {v2, v3}, Ljava/lang/Math;->min(II)I

    move-result v2

    invoke-static {v4, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    aget-object v5, v0, v2

    .line 57
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v0

    .line 58
    iget-object v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v6}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 60
    iget-object v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 61
    iget-object v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const v3, -0xe4dfd0

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 62
    iget-object v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v11, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 63
    if-nez v0, :cond_5

    .line 64
    iget-object v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    aget v3, v5, v4

    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    if-nez v0, :cond_3

    const v0, 0x3e99999a    # 0.3f

    :goto_1
    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v0

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 65
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v11, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 66
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 67
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 68
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    aget v2, v5, v4

    iget v3, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    if-nez v3, :cond_4

    :goto_2
    invoke-static {v2, v1}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 69
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    div-float/2addr v0, v12

    sub-float v0, v11, v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 85
    :goto_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v6}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 86
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    if-eqz v0, :cond_2

    .line 87
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 88
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v12

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 89
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 90
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v10, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 92
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0

    :cond_3
    move v0, v1

    .line 64
    goto :goto_1

    .line 68
    :cond_4
    const/high16 v1, 0x3f400000    # 0.75f

    goto :goto_2

    .line 70
    :cond_5
    const/4 v1, 0x1

    if-ne v0, v1, :cond_6

    .line 71
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    aget v1, v5, v4

    const v2, 0x3df5c28f    # 0.12f

    invoke-static {v1, v2}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 72
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v11, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 73
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 74
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v12

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 75
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    aget v1, v5, v4

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 76
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v0, v11, v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto :goto_3

    .line 78
    :cond_6
    new-instance v0, Landroid/graphics/LinearGradient;

    sub-float v1, v8, v11

    mul-float v2, v11, v7

    sub-float v2, v9, v2

    add-float v3, v8, v11

    mul-float v4, v11, v7

    add-float/2addr v4, v9

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    .line 79
    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 80
    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v12

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 81
    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 82
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v0, v11, v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v8, v9, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 83
    iget-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v6}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    goto/16 :goto_3
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 45
    const/high16 v0, 0x42200000    # 40.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 46
    invoke-virtual {p0, v0, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setMeasuredDimension(II)V

    .line 47
    return-void
.end method

.method style()I
    .locals 1

    .prologue
    .line 35
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    return v0
.end method
