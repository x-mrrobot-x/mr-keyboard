.class final Lcom/mrkeyboard/app/MrStyleDot;
.super Landroid/view/View;
.source "MrStyleDot.java"


# static fields
.field private static final RAINBOW:[I

.field static final SIZE_DP:I = 0x28


# instance fields
.field private final mChosen:Z

.field private final mDensity:F

.field private final mOwn:I

.field private final mOwn2:I

.field private final mPaint:Landroid/graphics/Paint;

.field private final mRing:I

.field private final mStyle:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    const/4 v0, 0x7

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrStyleDot;->RAINBOW:[I

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

.method constructor <init>(Landroid/content/Context;IZI)V
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 33
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v6, v5

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZIII)V

    .line 34
    return-void
.end method

.method constructor <init>(Landroid/content/Context;IZIII)V
    .locals 2

    .prologue
    .line 37
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 22
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    .line 38
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    .line 39
    iput p2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    .line 40
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    .line 41
    iput p4, p0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    .line 42
    iput p5, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    .line 43
    iput p6, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    .line 44
    return-void
.end method

.method private ownColours(I)[I
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 131
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 134
    :goto_0
    return-object v0

    .line 132
    :cond_0
    if-eq p1, v5, :cond_1

    new-array v0, v4, [I

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    aput v1, v0, v3

    goto :goto_0

    .line 133
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    .line 134
    :goto_1
    const/4 v1, 0x3

    new-array v1, v1, [I

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    aput v2, v1, v3

    iget v2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrKeyLook;->middle(II)I

    move-result v2

    aput v2, v1, v4

    aput v0, v1, v5

    move-object v0, v1

    goto :goto_0

    .line 133
    :cond_2
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->partner(I)I

    move-result v0

    goto :goto_1
.end method


# virtual methods
.method chosen()Z
    .locals 1

    .prologue
    .line 58
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 16

    .prologue
    .line 69
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrStyleDot;->getWidth()I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrStyleDot;->getHeight()I

    move-result v2

    .line 70
    if-lez v1, :cond_0

    if-gtz v2, :cond_1

    .line 127
    :cond_0
    :goto_0
    return-void

    .line 71
    :cond_1
    int-to-float v3, v1

    const/high16 v4, 0x40000000    # 2.0f

    div-float v12, v3, v4

    int-to-float v3, v2

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    .line 72
    invoke-static {v1, v2}, Ljava/lang/Math;->min(II)I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    const/high16 v2, 0x3fc00000    # 1.5f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    sub-float v13, v1, v2

    .line 73
    const/high16 v1, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v2

    sub-float v14, v13, v1

    .line 74
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v15

    .line 75
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    .line 76
    if-eqz v15, :cond_4

    move-object/from16 v0, p0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrStyleDot;->ownColours(I)[I

    move-result-object v9

    .line 77
    :goto_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 79
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 80
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const v4, -0xe4dfd0

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 81
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 82
    if-nez v9, :cond_5

    .line 84
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 85
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 86
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 87
    const v1, 0x3ee66666    # 0.45f

    mul-float/2addr v1, v14

    sub-float v2, v12, v1

    const v1, 0x3ee66666    # 0.45f

    mul-float/2addr v1, v14

    add-float v4, v12, v1

    move-object/from16 v0, p0

    iget-object v6, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    move v5, v3

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 88
    const v1, 0x3ee66666    # 0.45f

    mul-float/2addr v1, v14

    sub-float v6, v3, v1

    const v1, 0x3ee66666    # 0.45f

    mul-float/2addr v1, v14

    add-float v8, v3, v1

    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v4, p1

    move v5, v12

    move v7, v12

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 111
    :goto_2
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 112
    if-eqz v15, :cond_2

    .line 114
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 115
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 116
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/LinearGradient;

    sub-float v2, v12, v13

    add-float v4, v12, v13

    sget-object v6, Lcom/mrkeyboard/app/MrStyleDot;->RAINBOW:[I

    const/4 v7, 0x0

    sget-object v8, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    move v5, v3

    invoke-direct/range {v1 .. v8}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v9, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 117
    const/high16 v1, 0x40200000    # 2.5f

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v2

    add-float/2addr v1, v14

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 118
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 120
    :cond_2
    move-object/from16 v0, p0

    iget-boolean v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    if-eqz v1, :cond_3

    .line 121
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 122
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 123
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 124
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v13, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 126
    :cond_3
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0

    .line 76
    :cond_4
    sget-object v2, Lcom/mrkeyboard/app/MrBackdrop;->STYLE_COLORS:[[I

    const/4 v4, 0x0

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    const/16 v6, 0xe

    invoke-static {v5, v6}, Ljava/lang/Math;->min(II)I

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->max(II)I

    move-result v4

    aget-object v9, v2, v4

    goto/16 :goto_1

    .line 89
    :cond_5
    if-nez v1, :cond_8

    .line 90
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    aget v4, v9, v1

    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    if-nez v1, :cond_6

    const v1, 0x3e99999a    # 0.3f

    :goto_3
    invoke-static {v4, v1}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v1

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 91
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 92
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 93
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 94
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    aget v4, v9, v1

    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    if-nez v1, :cond_7

    const v1, 0x3f0ccccd    # 0.55f

    :goto_4
    invoke-static {v4, v1}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v1

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 95
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    sub-float v1, v14, v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto/16 :goto_2

    .line 90
    :cond_6
    const v1, 0x3f0ccccd    # 0.55f

    goto :goto_3

    .line 94
    :cond_7
    const/high16 v1, 0x3f400000    # 0.75f

    goto :goto_4

    .line 96
    :cond_8
    const/4 v2, 0x1

    if-ne v1, v2, :cond_9

    .line 97
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    aget v2, v9, v2

    const v4, 0x3df5c28f    # 0.12f

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 98
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 99
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 100
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 101
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    aget v2, v9, v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 102
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v1, v14, v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto/16 :goto_2

    .line 104
    :cond_9
    new-instance v4, Landroid/graphics/LinearGradient;

    sub-float v5, v12, v14

    const v1, 0x3ecccccd    # 0.4f

    mul-float/2addr v1, v14

    sub-float v6, v3, v1

    add-float v7, v12, v14

    const v1, 0x3ecccccd    # 0.4f

    mul-float/2addr v1, v14

    add-float v8, v3, v1

    const/4 v10, 0x0

    sget-object v11, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v4 .. v11}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    .line 105
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 106
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v5

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 107
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 108
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v1, v14, v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 109
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    goto/16 :goto_2
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 63
    const/high16 v0, 0x42200000    # 40.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 64
    invoke-virtual {p0, v0, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setMeasuredDimension(II)V

    .line 65
    return-void
.end method

.method own()I
    .locals 1

    .prologue
    .line 48
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    return v0
.end method

.method style()I
    .locals 1

    .prologue
    .line 53
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    return v0
.end method
