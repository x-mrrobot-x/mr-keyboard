.class final Lcom/mrkeyboard/app/MrScenes;
.super Ljava/lang/Object;
.source "MrScenes.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrScenes$Seq;
    }
.end annotation


# static fields
.field static final AURORA:I = 0x4

.field static final CITY:I = 0x5

.field static final COUNT:I = 0x6

.field static final DUNES:I = 0x1

.field static final DUSK:I = 0x0

.field static final FOREST:I = 0x3

.field static final SEA:I = 0x2


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static aurora(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 20

    .prologue
    .line 192
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x3

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v2, 0x3

    new-array v8, v2, [F

    fill-array-data v8, :array_1

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 193
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f19999a    # 0.6f

    mul-float v6, v2, v3

    const/16 v7, 0x37

    const-wide/16 v8, 0x17

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->stars(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFIJ)V

    .line 194
    const/4 v2, 0x3

    new-array v11, v2, [I

    fill-array-data v11, :array_2

    .line 195
    const/4 v2, 0x3

    new-array v12, v2, [F

    fill-array-data v12, :array_3

    .line 196
    const/4 v2, 0x0

    move v10, v2

    :goto_0
    array-length v2, v11

    if-ge v10, v2, :cond_2

    .line 197
    move/from16 v0, p3

    int-to-float v2, v0

    aget v3, v12, v10

    mul-float v6, v2, v3

    .line 198
    new-instance v13, Landroid/graphics/Path;

    invoke-direct {v13}, Landroid/graphics/Path;-><init>()V

    .line 199
    const/16 v3, 0x1e

    .line 200
    const/4 v2, 0x0

    invoke-virtual {v13, v2, v6}, Landroid/graphics/Path;->moveTo(FF)V

    .line 201
    const/4 v2, 0x0

    :goto_1
    if-gt v2, v3, :cond_0

    .line 202
    int-to-float v4, v2

    int-to-float v5, v3

    div-float/2addr v4, v5

    .line 203
    move/from16 v0, p2

    int-to-float v5, v0

    mul-float/2addr v5, v4

    move/from16 v0, p3

    int-to-float v7, v0

    const v8, 0x3d8f5c29    # 0.07f

    mul-float/2addr v7, v8

    float-to-double v8, v4

    const-wide/high16 v14, 0x4014000000000000L    # 5.0

    mul-double/2addr v8, v14

    int-to-double v14, v10

    const-wide v16, 0x3ffb333333333333L    # 1.7

    mul-double v14, v14, v16

    add-double/2addr v8, v14

    invoke-static {v8, v9}, Ljava/lang/Math;->sin(D)D

    move-result-wide v8

    double-to-float v8, v8

    mul-float/2addr v7, v8

    add-float/2addr v7, v6

    move/from16 v0, p3

    int-to-float v8, v0

    const v9, 0x3cf5c28f    # 0.03f

    mul-float/2addr v8, v9

    float-to-double v14, v4

    const-wide/high16 v16, 0x4026000000000000L    # 11.0

    mul-double v14, v14, v16

    int-to-double v0, v10

    move-wide/from16 v16, v0

    add-double v14, v14, v16

    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v4, v14

    mul-float/2addr v4, v8

    add-float/2addr v4, v7

    invoke-virtual {v13, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 201
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 205
    :cond_0
    move/from16 v0, p3

    int-to-float v2, v0

    const v4, 0x3eae147b    # 0.34f

    const v5, 0x3d23d70a    # 0.04f

    int-to-float v7, v10

    mul-float/2addr v5, v7

    sub-float/2addr v4, v5

    mul-float v7, v2, v4

    move v2, v3

    .line 206
    :goto_2
    if-ltz v2, :cond_1

    .line 207
    int-to-float v4, v2

    int-to-float v5, v3

    div-float/2addr v4, v5

    .line 208
    move/from16 v0, p2

    int-to-float v5, v0

    mul-float/2addr v5, v4

    add-float v8, v6, v7

    move/from16 v0, p3

    int-to-float v9, v0

    const v14, 0x3d75c28f    # 0.06f

    mul-float/2addr v9, v14

    float-to-double v14, v4

    const-wide/high16 v16, 0x4010000000000000L    # 4.0

    mul-double v14, v14, v16

    int-to-double v0, v10

    move-wide/from16 v16, v0

    const-wide v18, 0x4002666666666666L    # 2.3

    mul-double v16, v16, v18

    add-double v14, v14, v16

    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v4, v14

    mul-float/2addr v4, v9

    add-float/2addr v4, v8

    invoke-virtual {v13, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 206
    add-int/lit8 v2, v2, -0x1

    goto :goto_2

    .line 210
    :cond_1
    invoke-virtual {v13}, Landroid/graphics/Path;->close()V

    .line 211
    new-instance v2, Landroid/graphics/LinearGradient;

    const/4 v3, 0x0

    move/from16 v0, p3

    int-to-float v4, v0

    const v5, 0x3d4ccccd    # 0.05f

    mul-float/2addr v4, v5

    sub-float v4, v6, v4

    const/4 v5, 0x0

    add-float/2addr v6, v7

    const/4 v7, 0x3

    new-array v7, v7, [I

    const/4 v8, 0x0

    aget v9, v11, v10

    or-int/lit8 v9, v9, 0x0

    aput v9, v7, v8

    const/4 v8, 0x1

    const/high16 v9, -0x67000000

    aget v14, v11, v10

    or-int/2addr v9, v14

    aput v9, v7, v8

    const/4 v8, 0x2

    aget v9, v11, v10

    or-int/lit8 v9, v9, 0x0

    aput v9, v7, v8

    const/4 v8, 0x3

    new-array v8, v8, [F

    fill-array-data v8, :array_4

    sget-object v9, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v2 .. v9}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 213
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v13, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 214
    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 196
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto/16 :goto_0

    .line 216
    :cond_2
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f5c28f6    # 0.86f

    mul-float v6, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e3851ec    # 0.18f

    mul-float v7, v2, v3

    const v8, 0x3fe66666    # 1.8f

    const v9, 0x3e4ccccd    # 0.2f

    const v10, 0x408ccccd    # 4.4f

    const v11, 0x3f19999a    # 0.6f

    const v12, 0x3dcccccd    # 0.1f

    const v13, -0xf3e5c6

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    invoke-static/range {v2 .. v13}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 217
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f7ae148    # 0.98f

    mul-float v6, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3df5c28f    # 0.12f

    mul-float v7, v2, v3

    const v8, 0x3f99999a    # 1.2f

    const v9, 0x3f333333    # 0.7f

    const v10, 0x40466666    # 3.1f

    const v11, 0x3e99999a    # 0.3f

    const v12, 0x3e99999a    # 0.3f

    const v13, -0xf9f2de

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    invoke-static/range {v2 .. v13}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 218
    return-void

    .line 192
    :array_0
    .array-data 4
        -0xfaf9f1
        -0xf5edce
        -0xeddfbc
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f19999a    # 0.6f
        0x3f800000    # 1.0f
    .end array-data

    .line 194
    :array_2
    .array-data 4
        0x3cffb0
        0x4d9bff
        0xb36bff
    .end array-data

    .line 195
    :array_3
    .array-data 4
        0x3e0f5c29    # 0.14f
        0x3e75c28f    # 0.24f
        0x3eae147b    # 0.34f
    .end array-data

    .line 211
    :array_4
    .array-data 4
        0x0
        0x3eb33333    # 0.35f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 45
    new-instance v0, Landroid/graphics/LinearGradient;

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    move v2, p2

    move v3, v1

    move v4, p3

    move-object v5, p5

    move-object v6, p6

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 46
    int-to-float v3, p4

    move-object v0, p0

    move v2, p2

    move v4, p3

    move-object v5, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 47
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 48
    return-void
.end method

.method private static city(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 12

    .prologue
    const/4 v0, 0x3

    const v8, 0x3ee66666    # 0.45f

    const v7, 0x3e8f5c29    # 0.28f

    .line 221
    const/4 v2, 0x0

    int-to-float v3, p3

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    new-array v6, v0, [F

    fill-array-data v6, :array_1

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 222
    int-to-float v0, p2

    mul-float v2, v0, v7

    int-to-float v0, p3

    mul-float v3, v0, v8

    int-to-float v0, p3

    const v1, 0x3ec28f5c    # 0.38f

    mul-float v4, v0, v1

    const v5, 0x66ffd0e0

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 223
    int-to-float v0, p2

    mul-float v2, v0, v7

    int-to-float v0, p3

    mul-float v3, v0, v8

    int-to-float v0, p3

    const v1, 0x3d6147ae    # 0.055f

    mul-float v4, v0, v1

    const/16 v5, -0xf0b

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 224
    int-to-float v0, p3

    const v1, 0x3f4ccccd    # 0.8f

    mul-float v5, v0, v1

    int-to-float v0, p3

    const v1, 0x3e99999a    # 0.3f

    mul-float v6, v0, v1

    const/16 v7, 0xf

    const-wide/16 v8, 0x4

    const v10, -0xc5e3a6

    const/4 v11, 0x0

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v1 .. v11}, Lcom/mrkeyboard/app/MrScenes;->skyline(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V

    .line 225
    int-to-float v0, p3

    const/high16 v1, 0x3f800000    # 1.0f

    mul-float v5, v0, v1

    int-to-float v0, p3

    const v1, 0x3eb851ec    # 0.36f

    mul-float v6, v0, v1

    const/16 v7, 0xb

    const-wide/16 v8, 0x8

    const v10, -0xecf5da

    const/4 v11, 0x1

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v1 .. v11}, Lcom/mrkeyboard/app/MrScenes;->skyline(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V

    .line 226
    return-void

    .line 221
    :array_0
    .array-data 4
        -0xe5f4c3
        -0x95d586
        -0x906f
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f000000    # 0.5f
        0x3f47ae14    # 0.78f
    .end array-data
.end method

.method private static disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V
    .locals 0

    .prologue
    .line 59
    invoke-virtual {p1, p5}, Landroid/graphics/Paint;->setColor(I)V

    .line 60
    invoke-virtual {p0, p2, p3, p4, p1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 61
    return-void
.end method

.method static draw(Landroid/graphics/Canvas;III)V
    .locals 2

    .prologue
    .line 28
    if-eqz p0, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 39
    :cond_0
    :goto_0
    return-void

    .line 29
    :cond_1
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    .line 30
    packed-switch p1, :pswitch_data_0

    goto :goto_0

    .line 31
    :pswitch_0
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->dusk(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 32
    :pswitch_1
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->dunes(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 33
    :pswitch_2
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->sea(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 34
    :pswitch_3
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->forest(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 35
    :pswitch_4
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->aurora(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 36
    :pswitch_5
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->city(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 30
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
    .end packed-switch
.end method

.method private static dunes(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 12

    .prologue
    .line 130
    const/4 v2, 0x0

    int-to-float v3, p3

    const/4 v0, 0x3

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    const/4 v0, 0x3

    new-array v6, v0, [F

    fill-array-data v6, :array_1

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 131
    int-to-float v0, p2

    const v1, 0x3e99999a    # 0.3f

    mul-float v2, v0, v1

    int-to-float v0, p3

    const v1, 0x3eeb851f    # 0.46f

    mul-float v3, v0, v1

    int-to-float v0, p3

    const v1, 0x3ecccccd    # 0.4f

    mul-float v4, v0, v1

    const v5, -0x77001f50    # -1.5400078E-33f

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 132
    int-to-float v0, p2

    const v1, 0x3e99999a    # 0.3f

    mul-float v2, v0, v1

    int-to-float v0, p3

    const v1, 0x3eeb851f    # 0.46f

    mul-float v3, v0, v1

    int-to-float v0, p3

    const v1, 0x3d6147ae    # 0.055f

    mul-float v4, v0, v1

    const/16 v5, -0x1331

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 133
    int-to-float v0, p3

    const v1, 0x3f28f5c3    # 0.66f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3df5c28f    # 0.12f

    mul-float v5, v0, v1

    const v6, 0x3f8ccccd    # 1.1f

    const v7, 0x3dcccccd    # 0.1f

    const/high16 v8, 0x40000000    # 2.0f

    const v9, 0x3f0ccccd    # 0.55f

    const/high16 v10, 0x3f800000    # 1.0f

    const v11, -0x368bb1

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 134
    int-to-float v0, p3

    const v1, 0x3f47ae14    # 0.78f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3e0f5c29    # 0.14f

    mul-float v5, v0, v1

    const v6, 0x3f666666    # 0.9f

    const v7, 0x3f333333    # 0.7f

    const v8, 0x3fcccccd    # 1.6f

    const v9, 0x3e4ccccd    # 0.2f

    const/high16 v10, 0x3f800000    # 1.0f

    const v11, -0x63b5c6

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 135
    int-to-float v0, p3

    const v1, 0x3f666666    # 0.9f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3e0f5c29    # 0.14f

    mul-float v5, v0, v1

    const v6, 0x3f99999a    # 1.2f

    const v7, 0x3eb33333    # 0.35f

    const v8, 0x40133333    # 2.3f

    const v9, 0x3f4ccccd    # 0.8f

    const/high16 v10, 0x3f800000    # 1.0f

    const v11, -0x94d2cd

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 136
    int-to-float v0, p3

    const/high16 v1, 0x3f800000    # 1.0f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3dcccccd    # 0.1f

    mul-float v5, v0, v1

    const v6, 0x3f4ccccd    # 0.8f

    const v7, 0x3d4ccccd    # 0.05f

    const v8, 0x3ff33333    # 1.9f

    const v9, 0x3ee66666    # 0.45f

    const/high16 v10, 0x3f800000    # 1.0f

    const v11, -0xc2e5d4

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 137
    return-void

    .line 130
    :array_0
    .array-data 4
        -0xc5e38f
        -0x289289
        -0x5085
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f051eb8    # 0.52f
        0x3f59999a    # 0.85f
    .end array-data
.end method

.method private static dusk(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 12

    .prologue
    .line 120
    const/4 v2, 0x0

    int-to-float v3, p3

    const/4 v0, 0x4

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    const/4 v0, 0x4

    new-array v6, v0, [F

    fill-array-data v6, :array_1

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 121
    int-to-float v0, p2

    const v1, 0x3f2e147b    # 0.68f

    mul-float v2, v0, v1

    int-to-float v0, p3

    const v1, 0x3f19999a    # 0.6f

    mul-float v3, v0, v1

    int-to-float v0, p3

    const v1, 0x3ed70a3d    # 0.42f

    mul-float v4, v0, v1

    const v5, -0x55002765

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 122
    int-to-float v0, p2

    const v1, 0x3f2e147b    # 0.68f

    mul-float v2, v0, v1

    int-to-float v0, p3

    const v1, 0x3f19999a    # 0.6f

    mul-float v3, v0, v1

    int-to-float v0, p3

    const v1, 0x3d8f5c29    # 0.07f

    mul-float v4, v0, v1

    const/16 v5, -0x1c5d

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 123
    int-to-float v0, p3

    const v1, 0x3f333333    # 0.7f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3e4ccccd    # 0.2f

    mul-float v5, v0, v1

    const v6, 0x40133333    # 2.3f

    const v7, 0x3dcccccd    # 0.1f

    const v8, 0x40a33333    # 5.1f

    const v9, 0x3ecccccd    # 0.4f

    const/4 v10, 0x0

    const v11, -0x85b584

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 124
    int-to-float v0, p3

    const v1, 0x3f47ae14    # 0.78f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3e4ccccd    # 0.2f

    mul-float v5, v0, v1

    const v6, 0x3fd9999a    # 1.7f

    const v7, 0x3f19999a    # 0.6f

    const v8, 0x4089999a    # 4.3f

    const v9, 0x3e19999a    # 0.15f

    const/4 v10, 0x0

    const v11, -0xb2d29d

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 125
    int-to-float v0, p3

    const v1, 0x3f6147ae    # 0.88f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3e23d70a    # 0.16f

    mul-float v5, v0, v1

    const v6, 0x4039999a    # 2.9f

    const v7, 0x3e99999a    # 0.3f

    const v8, 0x40d66666    # 6.7f

    const v9, 0x3f333333    # 0.7f

    const v10, 0x3e19999a    # 0.15f

    const v11, -0xd5e8bb

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 126
    int-to-float v0, p3

    const v1, 0x3f7ae148    # 0.98f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3dcccccd    # 0.1f

    mul-float v5, v0, v1

    const v6, 0x3fa66666    # 1.3f

    const v7, 0x3f59999a    # 0.85f

    const v8, 0x4079999a    # 3.9f

    const/high16 v9, 0x3e800000    # 0.25f

    const/high16 v10, 0x3f000000    # 0.5f

    const v11, -0xebf4da

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 127
    return-void

    .line 120
    :array_0
    .array-data 4
        -0xd4e4b3
        -0x71c492
        -0xd87b5
        -0x3c8f
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3ed70a3d    # 0.42f
        0x3f333333    # 0.7f
        0x3f51eb85    # 0.82f
    .end array-data
.end method

.method private static forest(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 12

    .prologue
    const/4 v0, 0x3

    const v9, 0x3f428f5c    # 0.76f

    const v11, 0x3e99999a    # 0.3f

    const v8, 0x3e4ccccd    # 0.2f

    .line 158
    const/4 v2, 0x0

    int-to-float v3, p3

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    new-array v6, v0, [F

    fill-array-data v6, :array_1

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 159
    int-to-float v0, p3

    const v1, 0x3f0ccccd    # 0.55f

    mul-float v4, v0, v1

    const/16 v5, 0x46

    const-wide/16 v6, 0xb

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v7}, Lcom/mrkeyboard/app/MrScenes;->stars(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFIJ)V

    .line 160
    int-to-float v0, p2

    mul-float v2, v0, v9

    int-to-float v0, p3

    mul-float v3, v0, v8

    int-to-float v0, p3

    mul-float v4, v0, v11

    const v5, 0x55cfe2ff

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 161
    int-to-float v0, p2

    mul-float v2, v0, v9

    int-to-float v0, p3

    mul-float v3, v0, v8

    int-to-float v0, p3

    const v1, 0x3d8f5c29    # 0.07f

    mul-float v4, v0, v1

    const v5, -0xd0901

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 162
    int-to-float v0, p3

    const v1, 0x3f47ae14    # 0.78f

    mul-float v5, v0, v1

    int-to-float v0, p3

    mul-float v6, v0, v8

    const/16 v7, 0xe

    const-wide/16 v8, 0x3

    const v10, -0xedcfc6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v1 .. v10}, Lcom/mrkeyboard/app/MrScenes;->trees(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJI)V

    .line 163
    int-to-float v0, p3

    const v1, 0x3f666666    # 0.9f

    mul-float v5, v0, v1

    int-to-float v0, p3

    const v1, 0x3e851eb8    # 0.26f

    mul-float v6, v0, v1

    const/16 v7, 0xa

    const-wide/16 v8, 0x5

    const v10, -0xf4ddd7

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v1 .. v10}, Lcom/mrkeyboard/app/MrScenes;->trees(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJI)V

    .line 164
    int-to-float v0, p3

    const/high16 v1, 0x3f800000    # 1.0f

    mul-float v5, v0, v1

    int-to-float v0, p3

    mul-float v6, v0, v11

    const/4 v7, 0x7

    const-wide/16 v8, 0x9

    const v10, -0xf9ebe6

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    invoke-static/range {v1 .. v10}, Lcom/mrkeyboard/app/MrScenes;->trees(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJI)V

    .line 165
    return-void

    .line 158
    nop

    :array_0
    .array-data 4
        -0xf4efda
        -0xe4d5b7
        -0xd2b595
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f0ccccd    # 0.55f
        0x3f666666    # 0.9f
    .end array-data
.end method

.method private static glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V
    .locals 7

    .prologue
    const/4 v3, 0x2

    .line 52
    const v0, 0xffffff

    and-int v1, p5, v0

    .line 53
    new-instance v0, Landroid/graphics/RadialGradient;

    new-array v4, v3, [I

    const/4 v2, 0x0

    aput p5, v4, v2

    const/4 v2, 0x1

    aput v1, v4, v2

    new-array v5, v3, [F

    fill-array-data v5, :array_0

    sget-object v6, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    move v1, p2

    move v2, p3

    move v3, p4

    invoke-direct/range {v0 .. v6}, Landroid/graphics/RadialGradient;-><init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 54
    invoke-virtual {p0, p2, p3, p4, p1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 55
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 56
    return-void

    .line 53
    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V
    .locals 14

    .prologue
    .line 86
    new-instance v3, Landroid/graphics/Path;

    invoke-direct {v3}, Landroid/graphics/Path;-><init>()V

    .line 87
    const/16 v4, 0x30

    .line 88
    const/4 v2, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    invoke-virtual {v3, v2, v5}, Landroid/graphics/Path;->moveTo(FF)V

    .line 89
    const/4 v2, 0x0

    :goto_0
    if-gt v2, v4, :cond_0

    .line 90
    mul-int v5, p2, v2

    int-to-float v5, v5

    int-to-float v6, v4

    div-float/2addr v5, v6

    .line 91
    int-to-float v6, v2

    int-to-float v7, v4

    div-float/2addr v6, v7

    .line 92
    const/high16 v7, 0x3f800000    # 1.0f

    mul-float v8, v6, p6

    add-float v8, v8, p7

    invoke-static {v8}, Lcom/mrkeyboard/app/MrScenes;->tri(F)F

    move-result v8

    sub-float/2addr v7, v8

    .line 93
    const/high16 v8, 0x3f800000    # 1.0f

    mul-float v9, v6, p8

    add-float v9, v9, p9

    invoke-static {v9}, Lcom/mrkeyboard/app/MrScenes;->tri(F)F

    move-result v9

    sub-float/2addr v8, v9

    .line 94
    const v9, 0x3f1eb852    # 0.62f

    mul-float/2addr v7, v9

    const v9, 0x3ec28f5c    # 0.38f

    mul-float/2addr v8, v9

    add-float/2addr v7, v8

    .line 95
    const/high16 v8, 0x3f000000    # 0.5f

    const/high16 v9, 0x3f000000    # 0.5f

    mul-float v10, v6, p6

    add-float v10, v10, p7

    float-to-double v10, v10

    const-wide/high16 v12, 0x4000000000000000L    # 2.0

    mul-double/2addr v10, v12

    const-wide v12, 0x400921fb54442d18L    # Math.PI

    mul-double/2addr v10, v12

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    double-to-float v10, v10

    mul-float/2addr v9, v10

    const v10, 0x3f1eb852    # 0.62f

    mul-float/2addr v9, v10

    add-float/2addr v8, v9

    const v9, 0x3e428f5c    # 0.19f

    mul-float v6, v6, p8

    add-float v6, v6, p9

    float-to-double v10, v6

    const-wide/high16 v12, 0x4000000000000000L    # 2.0

    mul-double/2addr v10, v12

    const-wide v12, 0x400921fb54442d18L    # Math.PI

    mul-double/2addr v10, v12

    invoke-static {v10, v11}, Ljava/lang/Math;->sin(D)D

    move-result-wide v10

    double-to-float v6, v10

    mul-float/2addr v6, v9

    add-float/2addr v6, v8

    .line 96
    const/high16 v8, 0x3f800000    # 1.0f

    sub-float v8, v8, p10

    mul-float/2addr v7, v8

    mul-float v6, v6, p10

    add-float/2addr v6, v7

    .line 97
    mul-float v6, v6, p5

    sub-float v6, p4, v6

    invoke-virtual {v3, v5, v6}, Landroid/graphics/Path;->lineTo(FF)V

    .line 89
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 99
    :cond_0
    move/from16 v0, p2

    int-to-float v2, v0

    move/from16 v0, p3

    int-to-float v4, v0

    invoke-virtual {v3, v2, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 100
    invoke-virtual {v3}, Landroid/graphics/Path;->close()V

    .line 101
    move/from16 v0, p11

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 102
    invoke-virtual {p0, v3, p1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 103
    return-void
.end method

.method private static sea(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 12

    .prologue
    .line 140
    int-to-float v0, p3

    const v1, 0x3f19999a    # 0.6f

    mul-float v3, v0, v1

    .line 141
    const/4 v2, 0x0

    const/4 v0, 0x3

    new-array v5, v0, [I

    fill-array-data v5, :array_0

    const/4 v0, 0x3

    new-array v6, v0, [F

    fill-array-data v6, :array_1

    move-object v0, p0

    move-object v1, p1

    move v4, p2

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 142
    int-to-float v0, p2

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float v2, v0, v1

    int-to-float v0, p3

    const v1, 0x3ee66666    # 0.45f

    mul-float v4, v0, v1

    const v5, -0x66004c76

    move-object v0, p0

    move-object v1, p1

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 143
    int-to-float v0, p2

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float v6, v0, v1

    int-to-float v0, p3

    const v1, 0x3ca3d70a    # 0.02f

    mul-float/2addr v0, v1

    sub-float v7, v3, v0

    int-to-float v0, p3

    const v1, 0x3d99999a    # 0.075f

    mul-float v8, v0, v1

    const/16 v9, -0x1939

    move-object v4, p0

    move-object v5, p1

    invoke-static/range {v4 .. v9}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 144
    int-to-float v4, p3

    const/4 v0, 0x3

    new-array v6, v0, [I

    fill-array-data v6, :array_2

    const/4 v0, 0x3

    new-array v7, v0, [F

    fill-array-data v7, :array_3

    move-object v1, p0

    move-object v2, p1

    move v5, p2

    invoke-static/range {v1 .. v7}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 146
    new-instance v1, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v4, 0x7

    invoke-direct {v1, v4, v5}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 147
    const/4 v0, 0x0

    :goto_0
    const/16 v2, 0x9

    if-ge v0, v2, :cond_0

    .line 148
    int-to-float v2, p3

    const v4, 0x3c75c28f    # 0.015f

    const v5, 0x3ecccccd    # 0.4f

    int-to-float v6, v0

    mul-float/2addr v5, v6

    const/high16 v6, 0x41100000    # 9.0f

    div-float/2addr v5, v6

    add-float/2addr v4, v5

    mul-float/2addr v2, v4

    add-float v6, v3, v2

    .line 149
    int-to-float v2, p2

    const v4, 0x3e4ccccd    # 0.2f

    const v5, 0x3c449ba6    # 0.012f

    int-to-float v7, v0

    mul-float/2addr v5, v7

    sub-float/2addr v4, v5

    mul-float/2addr v2, v4

    const v4, 0x3f19999a    # 0.6f

    const v5, 0x3ecccccd    # 0.4f

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v7

    mul-float/2addr v5, v7

    add-float/2addr v4, v5

    mul-float/2addr v2, v4

    .line 150
    mul-int/lit8 v4, v0, 0xf

    rsub-int v4, v4, 0xaa

    .line 151
    shl-int/lit8 v4, v4, 0x18

    const v5, 0xffd9b0

    or-int/2addr v4, v5

    invoke-virtual {p1, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 152
    int-to-float v4, p2

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float/2addr v4, v5

    sub-float v5, v4, v2

    int-to-float v4, p2

    const/high16 v7, 0x3f000000    # 0.5f

    mul-float/2addr v4, v7

    add-float v7, v4, v2

    const/high16 v2, 0x3f800000    # 1.0f

    int-to-float v4, p3

    const v8, 0x3c449ba6    # 0.012f

    mul-float/2addr v4, v8

    invoke-static {v2, v4}, Ljava/lang/Math;->max(FF)F

    move-result v2

    add-float v8, v6, v2

    move-object v4, p0

    move-object v9, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 147
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 154
    :cond_0
    int-to-float v0, p3

    const v1, 0x3f1eb852    # 0.62f

    mul-float v4, v0, v1

    int-to-float v0, p3

    const v1, 0x3d0f5c29    # 0.035f

    mul-float v5, v0, v1

    const v6, 0x400ccccd    # 2.2f

    const v7, 0x3ecccccd    # 0.4f

    const/high16 v8, 0x40b00000    # 5.5f

    const v9, 0x3dcccccd    # 0.1f

    const v10, 0x3e4ccccd    # 0.2f

    const v11, -0xe4e9cd

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v11}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFFI)V

    .line 155
    return-void

    .line 141
    nop

    :array_0
    .array-data 4
        -0xebe1d0
        -0xcab883
        -0x81a1
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f19999a    # 0.6f
        0x3f800000    # 1.0f
    .end array-data

    .line 144
    :array_2
    .array-data 4
        -0x26a09a
        -0xb5d09d
        -0xf4ecd5
    .end array-data

    :array_3
    .array-data 4
        0x0
        0x3eb33333    # 0.35f
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static skyline(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V
    .locals 15

    .prologue
    .line 230
    new-instance v11, Lcom/mrkeyboard/app/MrScenes$Seq;

    move-wide/from16 v0, p7

    invoke-direct {v11, v0, v1}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 231
    move/from16 v0, p2

    int-to-float v2, v0

    move/from16 v0, p6

    int-to-float v3, v0

    div-float v12, v2, v3

    .line 232
    const/4 v2, 0x0

    move v10, v2

    :goto_0
    move/from16 v0, p6

    if-ge v10, v0, :cond_4

    .line 233
    const v2, 0x3f4ccccd    # 0.8f

    const/high16 v3, 0x3f000000    # 0.5f

    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    mul-float v13, v12, v2

    .line 234
    const v2, 0x3eb33333    # 0.35f

    const v3, 0x3f266666    # 0.65f

    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    mul-float v8, p5, v2

    .line 235
    int-to-float v2, v10

    mul-float v3, v2, v12

    .line 236
    move-object/from16 v0, p1

    move/from16 v1, p9

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 237
    sub-float v4, p4, v8

    add-float v5, v3, v13

    move/from16 v0, p3

    int-to-float v6, v0

    move-object v2, p0

    move-object/from16 v7, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 238
    if-nez p10, :cond_1

    .line 232
    :cond_0
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_0

    .line 239
    :cond_1
    const/high16 v2, 0x40400000    # 3.0f

    invoke-static/range {p2 .. p3}, Ljava/lang/Math;->min(II)I

    move-result v4

    int-to-float v4, v4

    const/high16 v5, 0x42100000    # 36.0f

    div-float/2addr v4, v5

    invoke-static {v2, v4}, Ljava/lang/Math;->max(FF)F

    move-result v2

    .line 240
    sub-float v4, p4, v8

    add-float v6, v4, v2

    :goto_1
    sub-float v4, p4, v2

    cmpg-float v4, v6, v4

    if-gez v4, :cond_0

    .line 241
    const v4, 0x3f333333    # 0.7f

    mul-float/2addr v4, v2

    add-float v5, v3, v4

    :goto_2
    const v4, 0x3f4ccccd    # 0.8f

    mul-float/2addr v4, v2

    add-float/2addr v4, v5

    add-float v7, v3, v13

    cmpg-float v4, v4, v7

    if-gez v4, :cond_3

    .line 242
    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    const v7, 0x3ee66666    # 0.45f

    cmpg-float v4, v4, v7

    if-gez v4, :cond_2

    .line 243
    const v4, -0x33002d86

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 244
    const v4, 0x3f4ccccd    # 0.8f

    mul-float/2addr v4, v2

    add-float v7, v5, v4

    const v4, 0x3f666666    # 0.9f

    mul-float/2addr v4, v2

    add-float v8, v6, v4

    move-object v4, p0

    move-object/from16 v9, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 241
    :cond_2
    const v4, 0x3fcccccd    # 1.6f

    mul-float/2addr v4, v2

    add-float/2addr v5, v4

    goto :goto_2

    .line 240
    :cond_3
    const v4, 0x3ff33333    # 1.9f

    mul-float/2addr v4, v2

    add-float/2addr v6, v4

    goto :goto_1

    .line 249
    :cond_4
    return-void
.end method

.method private static stars(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFIJ)V
    .locals 12

    .prologue
    .line 106
    new-instance v9, Lcom/mrkeyboard/app/MrScenes$Seq;

    move-wide/from16 v0, p6

    invoke-direct {v9, v0, v1}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 107
    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x43b40000    # 360.0f

    div-float v10, v2, v3

    .line 108
    const/4 v2, 0x0

    move v8, v2

    :goto_0
    move/from16 v0, p5

    if-ge v8, v0, :cond_0

    .line 109
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    int-to-float v3, p2

    mul-float v4, v2, v3

    .line 110
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    mul-float v5, v2, p4

    .line 111
    const/high16 v2, 0x3f000000    # 0.5f

    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v3

    const v6, 0x3f8ccccd    # 1.1f

    mul-float/2addr v3, v6

    add-float/2addr v2, v3

    mul-float/2addr v2, v10

    .line 112
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v3

    const/high16 v6, 0x43070000    # 135.0f

    mul-float/2addr v3, v6

    float-to-int v3, v3

    add-int/lit8 v3, v3, 0x78

    .line 113
    const v6, 0x3f19999a    # 0.6f

    invoke-static {v6, v2}, Ljava/lang/Math;->max(FF)F

    move-result v6

    shl-int/lit8 v2, v3, 0x18

    const v3, 0xffffff

    or-int v7, v2, v3

    move-object v2, p0

    move-object v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 108
    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_0

    .line 115
    :cond_0
    return-void
.end method

.method private static trees(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJI)V
    .locals 15

    .prologue
    .line 169
    new-instance v8, Lcom/mrkeyboard/app/MrScenes$Seq;

    move-wide/from16 v0, p7

    invoke-direct {v8, v0, v1}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 170
    move-object/from16 v0, p1

    move/from16 v1, p9

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 171
    const/4 v3, 0x0

    const v2, 0x3df5c28f    # 0.12f

    mul-float v2, v2, p5

    sub-float v4, p4, v2

    move/from16 v0, p2

    int-to-float v5, v0

    move/from16 v0, p3

    int-to-float v6, v0

    move-object v2, p0

    move-object/from16 v7, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 172
    move/from16 v0, p2

    int-to-float v2, v0

    move/from16 v0, p6

    int-to-float v3, v0

    div-float v4, v2, v3

    .line 173
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    add-int/lit8 v2, p6, 0x1

    if-ge v3, v2, :cond_1

    .line 174
    int-to-float v2, v3

    mul-float/2addr v2, v4

    invoke-virtual {v8}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v5

    const/high16 v6, 0x3f000000    # 0.5f

    sub-float/2addr v5, v6

    mul-float/2addr v5, v4

    const/high16 v6, 0x3f000000    # 0.5f

    mul-float/2addr v5, v6

    add-float/2addr v5, v2

    .line 175
    const v2, 0x3f19999a    # 0.6f

    const v6, 0x3ecccccd    # 0.4f

    invoke-virtual {v8}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v7

    mul-float/2addr v6, v7

    add-float/2addr v2, v6

    mul-float v6, p5, v2

    .line 176
    const v2, 0x3eeb851f    # 0.46f

    mul-float v7, v6, v2

    .line 177
    new-instance v9, Landroid/graphics/Path;

    invoke-direct {v9}, Landroid/graphics/Path;-><init>()V

    .line 178
    const/4 v2, 0x0

    :goto_1
    const/4 v10, 0x3

    if-ge v2, v10, :cond_0

    .line 179
    sub-float v10, p4, v6

    const v11, 0x3e99999a    # 0.3f

    mul-float/2addr v11, v6

    int-to-float v12, v2

    mul-float/2addr v11, v12

    add-float/2addr v10, v11

    .line 180
    const/high16 v11, 0x3f000000    # 0.5f

    mul-float/2addr v11, v6

    add-float/2addr v11, v10

    .line 181
    const v12, 0x3ecccccd    # 0.4f

    const v13, 0x3e99999a    # 0.3f

    int-to-float v14, v2

    mul-float/2addr v13, v14

    add-float/2addr v12, v13

    mul-float/2addr v12, v7

    const v13, 0x3fb33333    # 1.4f

    div-float/2addr v12, v13

    .line 182
    invoke-virtual {v9, v5, v10}, Landroid/graphics/Path;->moveTo(FF)V

    .line 183
    add-float v10, v5, v12

    invoke-virtual {v9, v10, v11}, Landroid/graphics/Path;->lineTo(FF)V

    .line 184
    sub-float v10, v5, v12

    invoke-virtual {v9, v10, v11}, Landroid/graphics/Path;->lineTo(FF)V

    .line 185
    invoke-virtual {v9}, Landroid/graphics/Path;->close()V

    .line 178
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 187
    :cond_0
    move-object/from16 v0, p1

    invoke-virtual {p0, v9, v0}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 173
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_0

    .line 189
    :cond_1
    return-void
.end method

.method private static tri(F)F
    .locals 2

    .prologue
    .line 77
    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->floor(D)D

    move-result-wide v0

    double-to-float v0, v0

    sub-float v0, p0, v0

    .line 78
    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f800000    # 1.0f

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    return v0
.end method
