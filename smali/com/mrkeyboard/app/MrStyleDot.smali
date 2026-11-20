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

.field private mSwatch:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 32
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

    .line 35
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v6, v5

    invoke-direct/range {v0 .. v6}, Lcom/mrkeyboard/app/MrStyleDot;-><init>(Landroid/content/Context;IZIII)V

    .line 36
    return-void
.end method

.method constructor <init>(Landroid/content/Context;IZIII)V
    .locals 2

    .prologue
    .line 39
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 22
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    .line 40
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    .line 41
    iput p2, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    .line 42
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    .line 43
    iput p4, p0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    .line 44
    iput p5, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    .line 45
    iput p6, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    .line 46
    return-void
.end method

.method private ownColours(I)[I
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 144
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 147
    :goto_0
    return-object v0

    .line 145
    :cond_0
    if-eq p1, v5, :cond_1

    new-array v0, v4, [I

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    aput v1, v0, v3

    goto :goto_0

    .line 146
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    if-eqz v0, :cond_2

    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn2:I

    .line 147
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

    .line 146
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
    .line 71
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    return v0
.end method

.method isSwatch()Z
    .locals 1

    .prologue
    .line 56
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mSwatch:Z

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 16

    .prologue
    .line 82
    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrStyleDot;->getWidth()I

    move-result v1

    invoke-virtual/range {p0 .. p0}, Lcom/mrkeyboard/app/MrStyleDot;->getHeight()I

    move-result v2

    .line 83
    if-lez v1, :cond_0

    if-gtz v2, :cond_1

    .line 140
    :cond_0
    :goto_0
    return-void

    .line 84
    :cond_1
    int-to-float v3, v1

    const/high16 v4, 0x40000000    # 2.0f

    div-float v12, v3, v4

    int-to-float v3, v2

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    .line 85
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

    .line 86
    const/high16 v1, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v2

    sub-float v14, v13, v1

    .line 87
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwnStyle(I)Z

    move-result v15

    .line 88
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->kindOf(I)I

    move-result v1

    .line 89
    if-eqz v15, :cond_4

    move-object/from16 v0, p0

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrStyleDot;->ownColours(I)[I

    move-result-object v9

    .line 90
    :goto_1
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 92
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 93
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const v4, -0xe4dfd0

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 94
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 95
    if-nez v9, :cond_5

    .line 97
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 98
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 99
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, -0x1

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 100
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

    .line 101
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

    .line 124
    :goto_2
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 125
    if-eqz v15, :cond_2

    move-object/from16 v0, p0

    iget-boolean v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mSwatch:Z

    if-nez v1, :cond_2

    .line 127
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 128
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 129
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

    .line 130
    const/high16 v1, 0x40200000    # 2.5f

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v1, v2

    add-float/2addr v1, v14

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 131
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 133
    :cond_2
    move-object/from16 v0, p0

    iget-boolean v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mChosen:Z

    if-eqz v1, :cond_3

    .line 134
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 135
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 136
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mRing:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 137
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v13, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 139
    :cond_3
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0

    .line 89
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

    .line 102
    :cond_5
    if-nez v1, :cond_8

    .line 103
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

    .line 104
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 105
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 106
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p0

    iget v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 107
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

    .line 108
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

    .line 103
    :cond_6
    const v1, 0x3f0ccccd    # 0.55f

    goto :goto_3

    .line 107
    :cond_7
    const/high16 v1, 0x3f400000    # 0.75f

    goto :goto_4

    .line 109
    :cond_8
    const/4 v2, 0x1

    if-ne v1, v2, :cond_9

    .line 110
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    aget v2, v9, v2

    const v4, 0x3df5c28f    # 0.12f

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 111
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v14, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 112
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 113
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v4

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 114
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    aget v2, v9, v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 115
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v1, v14, v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto/16 :goto_2

    .line 117
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

    .line 118
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 119
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x40000000    # 2.0f

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v2, v5

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 120
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 121
    move-object/from16 v0, p0

    iget v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    sub-float v1, v14, v1

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v0, p1

    invoke-virtual {v0, v12, v3, v1, v2}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 122
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/mrkeyboard/app/MrStyleDot;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    goto/16 :goto_2
.end method

.method protected onMeasure(II)V
    .locals 2

    .prologue
    .line 76
    const/high16 v0, 0x42200000    # 40.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrStyleDot;->mDensity:F

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 77
    invoke-virtual {p0, v0, v0}, Lcom/mrkeyboard/app/MrStyleDot;->setMeasuredDimension(II)V

    .line 78
    return-void
.end method

.method own()I
    .locals 1

    .prologue
    .line 61
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mOwn:I

    return v0
.end method

.method style()I
    .locals 1

    .prologue
    .line 66
    iget v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mStyle:I

    return v0
.end method

.method swatch()Lcom/mrkeyboard/app/MrStyleDot;
    .locals 1

    .prologue
    .line 50
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrStyleDot;->mSwatch:Z

    .line 51
    return-object p0
.end method
