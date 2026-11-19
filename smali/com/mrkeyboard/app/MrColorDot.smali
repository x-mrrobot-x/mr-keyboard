.class final Lcom/mrkeyboard/app/MrColorDot;
.super Landroid/view/View;
.source "MrColorDot.java"


# static fields
.field private static final RAINBOW:[I

.field static final SIZE_DP:I = 0x28


# instance fields
.field private final mColor:I

.field private final mDensity:F

.field private final mPaint:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 18
    const/4 v0, 0x7

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrColorDot;->RAINBOW:[I

    return-void

    nop

    :array_0
    .array-data 4
        -0xb2b3
        -0x37c3
        -0xc22369
        -0xb25c01
        -0x588401
        -0xa02e
        -0xb2b3
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;I)V
    .locals 2

    .prologue
    .line 25
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 20
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    .line 26
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    .line 27
    if-nez p2, :cond_0

    const/4 v0, 0x0

    :goto_0
    iput v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mColor:I

    .line 28
    return-void

    .line 27
    :cond_0
    const/high16 v0, -0x1000000

    or-int/2addr v0, p2

    goto :goto_0
.end method


# virtual methods
.method color()I
    .locals 1

    .prologue
    .line 32
    iget v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mColor:I

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 12

    .prologue
    const/4 v11, 0x0

    const/high16 v4, 0x40000000    # 2.0f

    const v7, 0x3ee66666    # 0.45f

    .line 43
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorDot;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrColorDot;->getHeight()I

    move-result v1

    .line 44
    if-lez v0, :cond_0

    if-gtz v1, :cond_1

    .line 65
    :cond_0
    :goto_0
    return-void

    .line 45
    :cond_1
    int-to-float v2, v0

    div-float v9, v2, v4

    int-to-float v2, v1

    div-float/2addr v2, v4

    .line 46
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    div-float/2addr v0, v4

    const/high16 v1, 0x3fc00000    # 1.5f

    iget v3, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    mul-float/2addr v1, v3

    sub-float v10, v0, v1

    .line 47
    const/high16 v0, 0x40a00000    # 5.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    mul-float/2addr v0, v1

    sub-float v6, v10, v0

    .line 48
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v11}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 49
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 50
    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    iget v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mColor:I

    if-eqz v0, :cond_3

    iget v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mColor:I

    :goto_1
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 51
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v9, v2, v6, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 52
    iget v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mColor:I

    if-nez v0, :cond_2

    .line 53
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 54
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    mul-float/2addr v1, v4

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 55
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 56
    mul-float v0, v6, v7

    sub-float v1, v9, v0

    mul-float v0, v6, v7

    add-float v3, v9, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v4, v2

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 57
    mul-float v0, v6, v7

    sub-float v5, v2, v0

    mul-float v0, v6, v7

    add-float v7, v2, v0

    iget-object v8, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    move-object v3, p1

    move v4, v9

    move v6, v9

    invoke-virtual/range {v3 .. v8}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 59
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 60
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x40200000    # 2.5f

    iget v3, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    mul-float/2addr v1, v3

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 61
    iget-object v8, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LinearGradient;

    sub-float v1, v9, v10

    add-float v3, v9, v10

    sget-object v5, Lcom/mrkeyboard/app/MrColorDot;->RAINBOW:[I

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    move v4, v2

    move-object v6, v11

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v8, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 62
    iget v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    sub-float v0, v10, v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v9, v2, v0, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 63
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v11}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 64
    iget-object v0, p0, Lcom/mrkeyboard/app/MrColorDot;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0

    .line 50
    :cond_3
    const v0, -0xe4dfd0

    goto :goto_1
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 37
    const/high16 v0, 0x42200000    # 40.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrColorDot;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 38
    invoke-virtual {p0, v0, v0}, Lcom/mrkeyboard/app/MrColorDot;->setMeasuredDimension(II)V

    .line 39
    return-void
.end method
