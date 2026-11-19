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
.field static final CIRCUIT:I = 0x2

.field static final COUNT:I = 0x9

.field static final HEX:I = 0x8

.field static final HOLOGRAM:I = 0x5

.field static final NEON_CITY:I = 0x0

.field static final NETWORK:I = 0x3

.field static final ORBIT:I = 0x4

.field static final STREAMS:I = 0x6

.field static final SYNTHWAVE:I = 0x1

.field static final WAVES:I = 0x7


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static alpha(IF)I
    .locals 2

    .prologue
    .line 99
    const/4 v0, 0x0

    const/high16 v1, 0x3f800000    # 1.0f

    invoke-static {v1, p1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    const/high16 v1, 0x437f0000    # 255.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method private static band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V
    .locals 8

    .prologue
    const/4 v1, 0x0

    .line 48
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 49
    new-instance v0, Landroid/graphics/LinearGradient;

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    move v2, p2

    move v3, v1

    move v4, p3

    move-object v5, p5

    move-object v6, p6

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFF[I[FLandroid/graphics/Shader$TileMode;)V

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 50
    int-to-float v3, p4

    move-object v0, p0

    move v2, p2

    move v4, p3

    move-object v5, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 51
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 52
    return-void
.end method

.method private static box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V
    .locals 6

    .prologue
    .line 71
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 72
    invoke-virtual {p1, p6}, Landroid/graphics/Paint;->setColor(I)V

    move-object v0, p0

    move v1, p2

    move v2, p3

    move v3, p4

    move v4, p5

    move-object v5, p1

    .line 73
    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 74
    return-void
.end method

.method private static circuit(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 22

    .prologue
    .line 233
    move/from16 v0, p3

    int-to-float v4, v0

    const/high16 v5, 0x42c80000    # 100.0f

    div-float v14, v4, v5

    .line 234
    const/4 v6, 0x0

    move/from16 v0, p3

    int-to-float v7, v0

    const/4 v4, 0x3

    new-array v9, v4, [I

    fill-array-data v9, :array_0

    const/4 v10, 0x0

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move/from16 v8, p2

    invoke-static/range {v4 .. v10}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 235
    move/from16 v0, p2

    int-to-float v4, v0

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float v6, v4, v5

    move/from16 v0, p3

    int-to-float v4, v0

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float v7, v4, v5

    move/from16 v0, p3

    int-to-float v4, v0

    const v5, 0x3f666666    # 0.9f

    mul-float v8, v4, v5

    const v9, 0x3300e5ff

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-static/range {v4 .. v9}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 236
    const/high16 v4, 0x40c00000    # 6.0f

    move/from16 v0, p3

    int-to-float v5, v0

    const/high16 v6, 0x41200000    # 10.0f

    div-float/2addr v5, v6

    invoke-static {v4, v5}, Ljava/lang/Math;->max(FF)F

    move-result v15

    .line 237
    new-instance v16, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v4, 0x1f

    move-object/from16 v0, v16

    invoke-direct {v0, v4, v5}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 238
    move/from16 v0, p2

    int-to-float v4, v0

    div-float/2addr v4, v15

    float-to-int v4, v4

    add-int/lit8 v17, v4, 0x1

    move/from16 v0, p3

    int-to-float v4, v0

    div-float/2addr v4, v15

    float-to-int v4, v4

    add-int/lit8 v18, v4, 0x1

    .line 239
    const/4 v4, 0x0

    move v13, v4

    :goto_0
    const/16 v4, 0x16

    if-ge v13, v4, :cond_6

    .line 240
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    move/from16 v0, v17

    int-to-float v5, v0

    mul-float/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v4, v4

    mul-float v12, v4, v15

    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    move/from16 v0, v18

    int-to-float v5, v0

    mul-float/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Math;->round(F)I

    move-result v4

    int-to-float v4, v4

    mul-float v10, v4, v15

    .line 241
    new-instance v19, Landroid/graphics/Path;

    invoke-direct/range {v19 .. v19}, Landroid/graphics/Path;-><init>()V

    .line 242
    move-object/from16 v0, v19

    invoke-virtual {v0, v12, v10}, Landroid/graphics/Path;->moveTo(FF)V

    .line 244
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    const/high16 v5, 0x3f000000    # 0.5f

    cmpg-float v4, v4, v5

    if-gez v4, :cond_0

    const/4 v4, 0x1

    .line 245
    :goto_1
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v5

    const/high16 v6, 0x40400000    # 3.0f

    mul-float/2addr v5, v6

    float-to-int v5, v5

    add-int/lit8 v20, v5, 0x3

    .line 246
    const/4 v5, 0x0

    move v7, v5

    move v8, v4

    move v9, v10

    move v11, v12

    :goto_2
    move/from16 v0, v20

    if-ge v7, v0, :cond_5

    .line 247
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    const/high16 v5, 0x40800000    # 4.0f

    mul-float/2addr v4, v5

    float-to-int v4, v4

    add-int/lit8 v4, v4, 0x2

    int-to-float v4, v4

    mul-float v21, v4, v15

    .line 248
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    const/high16 v5, 0x3f000000    # 0.5f

    cmpg-float v4, v4, v5

    if-gez v4, :cond_1

    const/high16 v4, -0x40800000    # -1.0f

    .line 249
    :goto_3
    invoke-virtual/range {v16 .. v16}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v5

    const/high16 v6, 0x3f000000    # 0.5f

    cmpg-float v5, v5, v6

    if-gez v5, :cond_2

    const/high16 v5, -0x40800000    # -1.0f

    move v6, v5

    .line 250
    :goto_4
    if-eqz v8, :cond_3

    .line 251
    mul-float v5, v4, v21

    add-float/2addr v5, v11

    .line 252
    move-object/from16 v0, v19

    invoke-virtual {v0, v5, v9}, Landroid/graphics/Path;->lineTo(FF)V

    .line 253
    mul-float/2addr v4, v15

    const v11, 0x3f333333    # 0.7f

    mul-float/2addr v4, v11

    add-float/2addr v5, v4

    .line 254
    mul-float v4, v6, v15

    const v6, 0x3f333333    # 0.7f

    mul-float/2addr v4, v6

    add-float/2addr v4, v9

    .line 261
    :goto_5
    move-object/from16 v0, v19

    invoke-virtual {v0, v5, v4}, Landroid/graphics/Path;->lineTo(FF)V

    .line 262
    if-nez v8, :cond_4

    const/4 v6, 0x1

    .line 246
    :goto_6
    add-int/lit8 v7, v7, 0x1

    move v8, v6

    move v9, v4

    move v11, v5

    goto :goto_2

    .line 244
    :cond_0
    const/4 v4, 0x0

    goto :goto_1

    .line 248
    :cond_1
    const/high16 v4, 0x3f800000    # 1.0f

    goto :goto_3

    .line 249
    :cond_2
    const/high16 v5, 0x3f800000    # 1.0f

    move v6, v5

    goto :goto_4

    .line 256
    :cond_3
    mul-float v5, v4, v21

    add-float/2addr v5, v9

    .line 257
    move-object/from16 v0, v19

    invoke-virtual {v0, v11, v5}, Landroid/graphics/Path;->lineTo(FF)V

    .line 258
    mul-float/2addr v4, v15

    const v9, 0x3f333333    # 0.7f

    mul-float/2addr v4, v9

    add-float/2addr v4, v5

    .line 259
    mul-float v5, v6, v15

    const v6, 0x3f333333    # 0.7f

    mul-float/2addr v5, v6

    add-float/2addr v5, v11

    goto :goto_5

    .line 262
    :cond_4
    const/4 v6, 0x0

    goto :goto_6

    .line 264
    :cond_5
    const v4, 0x3f8ccccd    # 1.1f

    mul-float/2addr v4, v14

    const v5, -0x55d21901

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, v19

    invoke-static {v0, v1, v2, v4, v5}, Lcom/mrkeyboard/app/MrScenes;->tube(Landroid/graphics/Canvas;Landroid/graphics/Paint;Landroid/graphics/Path;FI)V

    .line 265
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static {v0, v1, v12, v10, v14}, Lcom/mrkeyboard/app/MrScenes;->pad(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFF)V

    .line 266
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static {v0, v1, v11, v9, v14}, Lcom/mrkeyboard/app/MrScenes;->pad(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFF)V

    .line 239
    add-int/lit8 v4, v13, 0x1

    move v13, v4

    goto/16 :goto_0

    .line 269
    :cond_6
    move/from16 v0, p2

    int-to-float v4, v0

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float v13, v4, v5

    move/from16 v0, p3

    int-to-float v4, v0

    const/high16 v5, 0x3f000000    # 0.5f

    mul-float v15, v4, v5

    move/from16 v0, p3

    int-to-float v4, v0

    const v5, 0x3e99999a    # 0.3f

    mul-float v16, v4, v5

    move/from16 v0, p3

    int-to-float v4, v0

    const v5, 0x3e6147ae    # 0.22f

    mul-float v17, v4, v5

    .line 270
    const/4 v4, 0x0

    move v12, v4

    :goto_7
    const/4 v4, 0x7

    if-ge v12, v4, :cond_7

    .line 271
    const/high16 v4, -0x40c00000    # -0.75f

    int-to-float v5, v12

    const/high16 v6, 0x3e800000    # 0.25f

    mul-float/2addr v5, v6

    add-float v18, v4, v5

    .line 272
    mul-float v4, v18, v16

    add-float v6, v13, v4

    sub-float v7, v15, v17

    mul-float v4, v18, v16

    add-float v8, v13, v4

    sub-float v4, v15, v17

    move/from16 v0, p3

    int-to-float v5, v0

    const v9, 0x3d8f5c29    # 0.07f

    mul-float/2addr v5, v9

    sub-float v9, v4, v5

    const v4, 0x3f99999a    # 1.2f

    mul-float v10, v14, v4

    const v11, -0x33d21901    # -4.5587452E7f

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-static/range {v4 .. v11}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 273
    mul-float v4, v18, v16

    add-float v6, v13, v4

    add-float v7, v15, v17

    mul-float v4, v18, v16

    add-float v8, v13, v4

    add-float v4, v15, v17

    move/from16 v0, p3

    int-to-float v5, v0

    const v9, 0x3d8f5c29    # 0.07f

    mul-float/2addr v5, v9

    add-float v9, v4, v5

    const v4, 0x3f99999a    # 1.2f

    mul-float v10, v14, v4

    const v11, -0x33d21901    # -4.5587452E7f

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-static/range {v4 .. v11}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 270
    add-int/lit8 v4, v12, 0x1

    move v12, v4

    goto :goto_7

    .line 275
    :cond_7
    sub-float v6, v13, v16

    sub-float v7, v15, v17

    add-float v8, v13, v16

    add-float v9, v15, v17

    const v10, -0xffbe4dc

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-static/range {v4 .. v10}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 276
    sget-object v4, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 277
    const/high16 v4, 0x3f800000    # 1.0f

    const v5, 0x3f666666    # 0.9f

    mul-float/2addr v5, v14

    invoke-static {v4, v5}, Ljava/lang/Math;->max(FF)F

    move-result v4

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 278
    const v4, -0x33d21901    # -4.5587452E7f

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 279
    sub-float v5, v13, v16

    sub-float v6, v15, v17

    add-float v7, v13, v16

    add-float v8, v15, v17

    move-object/from16 v4, p0

    move-object/from16 v9, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 280
    const v4, 0x3f0ccccd    # 0.55f

    mul-float v4, v4, v16

    sub-float v5, v13, v4

    const/high16 v4, 0x3f000000    # 0.5f

    mul-float v4, v4, v17

    sub-float v6, v15, v4

    const v4, 0x3f0ccccd    # 0.55f

    mul-float v4, v4, v16

    add-float v7, v13, v4

    const/high16 v4, 0x3f000000    # 0.5f

    mul-float v4, v4, v17

    add-float v8, v15, v4

    move-object/from16 v4, p0

    move-object/from16 v9, p1

    invoke-virtual/range {v4 .. v9}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 281
    sget-object v4, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v4}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 282
    const v4, 0x3f666666    # 0.9f

    mul-float v8, v17, v4

    const v9, 0x6600e5ff

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    move v6, v13

    move v7, v15

    invoke-static/range {v4 .. v9}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 283
    return-void

    .line 234
    nop

    :array_0
    .array-data 4
        -0xfcefe8
        -0xf9dbd5
        -0xfce7e0
    .end array-data
.end method

.method private static disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V
    .locals 1

    .prologue
    .line 65
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 66
    invoke-virtual {p1, p5}, Landroid/graphics/Paint;->setColor(I)V

    .line 67
    invoke-virtual {p0, p2, p3, p4, p1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 68
    return-void
.end method

.method static draw(Landroid/graphics/Canvas;III)V
    .locals 2

    .prologue
    .line 28
    if-eqz p0, :cond_0

    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 42
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
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->neonCity(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 32
    :pswitch_1
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->synthwave(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 33
    :pswitch_2
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->circuit(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 34
    :pswitch_3
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->network(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 35
    :pswitch_4
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->orbit(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 36
    :pswitch_5
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->hologram(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 37
    :pswitch_6
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->streams(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 38
    :pswitch_7
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->waves(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

    goto :goto_0

    .line 39
    :pswitch_8
    invoke-static {p0, v0, p2, p3}, Lcom/mrkeyboard/app/MrScenes;->hex(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V

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
        :pswitch_6
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

.method private static ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V
    .locals 8

    .prologue
    const/high16 v1, 0x3f000000    # 0.5f

    .line 391
    cmpg-float v0, p4, v1

    if-lez v0, :cond_0

    cmpg-float v0, p5, v1

    if-gtz v0, :cond_1

    .line 406
    :cond_0
    :goto_0
    return-void

    .line 392
    :cond_1
    new-instance v1, Landroid/graphics/Path;

    invoke-direct {v1}, Landroid/graphics/Path;-><init>()V

    .line 393
    const/16 v2, 0x30

    .line 394
    const/4 v0, 0x0

    :goto_1
    if-gt v0, v2, :cond_3

    .line 395
    const-wide v4, 0x401921fb54442d18L    # 6.283185307179586

    int-to-double v6, v0

    mul-double/2addr v4, v6

    int-to-double v6, v2

    div-double/2addr v4, v6

    .line 396
    invoke-static {v4, v5}, Ljava/lang/Math;->cos(D)D

    move-result-wide v6

    double-to-float v3, v6

    mul-float/2addr v3, p4

    add-float/2addr v3, p2

    invoke-static {v4, v5}, Ljava/lang/Math;->sin(D)D

    move-result-wide v4

    double-to-float v4, v4

    mul-float/2addr v4, p5

    add-float/2addr v4, p3

    .line 397
    if-nez v0, :cond_2

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 394
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 398
    :cond_2
    invoke-virtual {v1, v3, v4}, Landroid/graphics/Path;->lineTo(FF)V

    goto :goto_2

    .line 400
    :cond_3
    invoke-virtual {v1}, Landroid/graphics/Path;->close()V

    .line 401
    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 402
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p6}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 403
    invoke-virtual {p1, p7}, Landroid/graphics/Paint;->setColor(I)V

    .line 404
    invoke-virtual {p0, v1, p1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 405
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto :goto_0
.end method

.method private static glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V
    .locals 7

    .prologue
    const/4 v3, 0x2

    .line 56
    const/4 v0, 0x0

    cmpg-float v0, p4, v0

    if-gtz v0, :cond_0

    .line 62
    :goto_0
    return-void

    .line 57
    :cond_0
    const v0, 0xffffff

    and-int v1, p5, v0

    .line 58
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 59
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

    .line 60
    invoke-virtual {p0, p2, p3, p4, p1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 61
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    goto :goto_0

    .line 59
    nop

    :array_0
    .array-data 4
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method private static hex(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 20

    .prologue
    .line 452
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v9, v2, v3

    .line 453
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x2

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v8, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 454
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x3f800000    # 1.0f

    mul-float v6, v2, v3

    const v7, 0x3300c8ff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 455
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e19999a    # 0.15f

    mul-float v5, v2, v3

    .line 456
    const v2, 0x3fddb3d7

    mul-float v6, v5, v2

    const/high16 v2, 0x3fc00000    # 1.5f

    mul-float v7, v5, v2

    .line 457
    new-instance v8, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v2, 0x65

    invoke-direct {v8, v2, v3}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 458
    const/4 v2, -0x1

    move v4, v2

    :goto_0
    int-to-float v2, v4

    mul-float/2addr v2, v7

    move/from16 v0, p3

    int-to-float v3, v0

    add-float/2addr v3, v5

    cmpg-float v2, v2, v3

    if-gez v2, :cond_5

    .line 459
    const/4 v2, -0x1

    move v3, v2

    :goto_1
    int-to-float v2, v3

    mul-float/2addr v2, v6

    move/from16 v0, p2

    int-to-float v10, v0

    add-float/2addr v10, v6

    cmpg-float v2, v2, v10

    if-gez v2, :cond_4

    .line 460
    int-to-float v2, v3

    mul-float/2addr v2, v6

    and-int/lit8 v10, v4, 0x1

    int-to-float v10, v10

    mul-float/2addr v10, v6

    const/high16 v11, 0x40000000    # 2.0f

    div-float/2addr v10, v11

    add-float/2addr v10, v2

    int-to-float v2, v4

    mul-float v11, v2, v7

    .line 461
    new-instance v12, Landroid/graphics/Path;

    invoke-direct {v12}, Landroid/graphics/Path;-><init>()V

    .line 462
    const/4 v2, 0x0

    :goto_2
    const/4 v13, 0x6

    if-ge v2, v13, :cond_1

    .line 463
    const-wide/high16 v14, 0x403e000000000000L    # 30.0

    const-wide/high16 v16, 0x404e000000000000L    # 60.0

    int-to-double v0, v2

    move-wide/from16 v18, v0

    mul-double v16, v16, v18

    add-double v14, v14, v16

    invoke-static {v14, v15}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v14

    .line 464
    const v13, 0x3f75c28f    # 0.96f

    mul-float/2addr v13, v5

    invoke-static {v14, v15}, Ljava/lang/Math;->cos(D)D

    move-result-wide v16

    move-wide/from16 v0, v16

    double-to-float v0, v0

    move/from16 v16, v0

    mul-float v13, v13, v16

    add-float/2addr v13, v10

    const v16, 0x3f75c28f    # 0.96f

    mul-float v16, v16, v5

    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v14, v14

    mul-float v14, v14, v16

    add-float/2addr v14, v11

    .line 465
    if-nez v2, :cond_0

    invoke-virtual {v12, v13, v14}, Landroid/graphics/Path;->moveTo(FF)V

    .line 462
    :goto_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 466
    :cond_0
    invoke-virtual {v12, v13, v14}, Landroid/graphics/Path;->lineTo(FF)V

    goto :goto_3

    .line 468
    :cond_1
    invoke-virtual {v12}, Landroid/graphics/Path;->close()V

    .line 469
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v13, 0x3f000000    # 0.5f

    mul-float/2addr v2, v13

    sub-float v2, v10, v2

    move/from16 v0, p3

    int-to-float v10, v0

    const/high16 v13, 0x3f000000    # 0.5f

    mul-float/2addr v10, v13

    sub-float v10, v11, v10

    .line 470
    const/high16 v11, 0x3f800000    # 1.0f

    const/high16 v13, 0x3f800000    # 1.0f

    mul-float/2addr v2, v2

    mul-float/2addr v10, v10

    add-float/2addr v2, v10

    float-to-double v14, v2

    invoke-static {v14, v15}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v14

    double-to-float v2, v14

    move/from16 v0, p3

    int-to-float v10, v0

    const/high16 v14, 0x3fc00000    # 1.5f

    mul-float/2addr v10, v14

    div-float/2addr v2, v10

    invoke-static {v13, v2}, Ljava/lang/Math;->min(FF)F

    move-result v2

    sub-float v10, v11, v2

    .line 471
    invoke-virtual {v8}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const v11, 0x3e2e147b    # 0.17f

    cmpg-float v2, v2, v11

    if-gez v2, :cond_2

    .line 472
    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 473
    invoke-virtual {v8}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const/high16 v11, 0x3f000000    # 0.5f

    cmpg-float v2, v2, v11

    if-gez v2, :cond_3

    const v2, -0xd02901

    :goto_4
    const v11, 0x3e0f5c29    # 0.14f

    const v13, 0x3e6147ae    # 0.22f

    invoke-virtual {v8}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v14

    mul-float/2addr v13, v14

    add-float/2addr v11, v13

    invoke-static {v2, v11}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 474
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v12, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 476
    :cond_2
    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 477
    const/high16 v2, 0x3f800000    # 1.0f

    const v11, 0x3f19999a    # 0.6f

    mul-float/2addr v11, v9

    invoke-static {v2, v11}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 478
    const v2, -0xa65701

    const v11, 0x3dcccccd    # 0.1f

    const v13, 0x3e99999a    # 0.3f

    mul-float/2addr v10, v13

    add-float/2addr v10, v11

    invoke-static {v2, v10}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 479
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v12, v1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 480
    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 459
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto/16 :goto_1

    .line 473
    :cond_3
    const v2, -0x75a301

    goto :goto_4

    .line 458
    :cond_4
    add-int/lit8 v2, v4, 0x1

    move v4, v2

    goto/16 :goto_0

    .line 483
    :cond_5
    return-void

    .line 453
    nop

    :array_0
    .array-data 4
        -0xfbf8ea
        -0xf5efd0
    .end array-data
.end method

.method private static hologram(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 16

    .prologue
    .line 362
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v14, v2, v3

    .line 363
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x3

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v8, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 364
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3ec28f5c    # 0.38f

    mul-float v15, v2, v3

    .line 365
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f59999a    # 0.85f

    mul-float v6, v2, v3

    const v7, 0x5500c8ff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 368
    const/4 v2, -0x3

    :goto_0
    const/4 v3, 0x3

    if-gt v2, v3, :cond_0

    .line 369
    int-to-double v6, v2

    const-wide/high16 v8, 0x4036000000000000L    # 22.0

    mul-double/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v6

    .line 370
    float-to-double v8, v15

    invoke-static {v6, v7}, Ljava/lang/Math;->cos(D)D

    move-result-wide v10

    mul-double/2addr v8, v10

    double-to-float v10, v8

    .line 371
    float-to-double v8, v15

    invoke-static {v6, v7}, Ljava/lang/Math;->sin(D)D

    move-result-wide v6

    mul-double/2addr v6, v8

    double-to-float v3, v6

    add-float v9, v5, v3

    const v3, 0x3e6147ae    # 0.22f

    mul-float v11, v10, v3

    const v3, 0x3f333333    # 0.7f

    mul-float v12, v14, v3

    const v13, 0x77e0fbff

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move v8, v4

    invoke-static/range {v6 .. v13}, Lcom/mrkeyboard/app/MrScenes;->ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 368
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 374
    :cond_0
    const/4 v2, 0x0

    move v10, v2

    :goto_1
    const/4 v2, 0x6

    if-ge v10, v2, :cond_1

    .line 375
    int-to-double v2, v10

    const-wide/high16 v6, 0x403e000000000000L    # 30.0

    mul-double/2addr v2, v6

    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 376
    float-to-double v6, v15

    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Math;->abs(D)D

    move-result-wide v2

    mul-double/2addr v2, v6

    double-to-float v6, v2

    const v2, 0x3f333333    # 0.7f

    mul-float v8, v14, v2

    const v9, 0x77e0fbff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move v7, v15

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 374
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_1

    .line 378
    :cond_1
    const v2, 0x3f99999a    # 1.2f

    mul-float v8, v14, v2

    const v9, -0x33841701    # -6.6036732E7f

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move v6, v15

    move v7, v15

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 380
    const v2, 0x3f9c28f6    # 1.22f

    mul-float/2addr v2, v15

    add-float v9, v5, v2

    const v2, 0x3faccccd    # 1.35f

    mul-float v10, v15, v2

    const v2, 0x3e4ccccd    # 0.2f

    mul-float v11, v15, v2

    const v2, 0x3f666666    # 0.9f

    mul-float v12, v14, v2

    const v13, -0x77841701

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    move v8, v4

    invoke-static/range {v6 .. v13}, Lcom/mrkeyboard/app/MrScenes;->ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 381
    const v2, 0x3f9c28f6    # 1.22f

    mul-float/2addr v2, v15

    add-float/2addr v5, v2

    const v2, 0x3f733333    # 0.95f

    mul-float v6, v15, v2

    const v2, 0x3e051eb8    # 0.13f

    mul-float v7, v15, v2

    const v2, 0x3f333333    # 0.7f

    mul-float v8, v14, v2

    const v9, 0x557be8ff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->ellipse(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 383
    const/high16 v2, 0x40400000    # 3.0f

    const v3, 0x4019999a    # 2.4f

    mul-float/2addr v3, v14

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v9

    .line 384
    const/4 v5, 0x0

    :goto_2
    move/from16 v0, p3

    int-to-float v2, v0

    cmpg-float v2, v5, v2

    if-gez v2, :cond_2

    const/4 v4, 0x0

    move/from16 v0, p2

    int-to-float v6, v0

    const/high16 v2, 0x3f800000    # 1.0f

    add-float v7, v5, v2

    const v8, 0xa8fe8ff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    add-float/2addr v5, v9

    goto :goto_2

    .line 385
    :cond_2
    new-instance v9, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v2, 0x13

    invoke-direct {v9, v2, v3}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 386
    const/4 v2, 0x0

    move v8, v2

    :goto_3
    const/16 v2, 0x28

    if-ge v8, v2, :cond_3

    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    move/from16 v0, p2

    int-to-float v3, v0

    mul-float v4, v2, v3

    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    move/from16 v0, p3

    int-to-float v3, v0

    mul-float v5, v2, v3

    const v2, 0x3f333333    # 0.7f

    const v3, 0x3ee66666    # 0.45f

    mul-float/2addr v3, v14

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v6

    const v2, -0x470b01

    const/high16 v3, 0x3e800000    # 0.25f

    const/high16 v7, 0x3f000000    # 0.5f

    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v10

    mul-float/2addr v7, v10

    add-float/2addr v3, v7

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v7

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_3

    .line 387
    :cond_3
    return-void

    .line 363
    nop

    :array_0
    .array-data 4
        -0xfef4ee
        -0xfddfd2
        -0xfef4ee
    .end array-data
.end method

.method private static lerp(IIF)I
    .locals 4

    .prologue
    const/high16 v3, 0x3f800000    # 1.0f

    .line 104
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    sub-float v1, v3, p2

    mul-float/2addr v0, v1

    shr-int/lit8 v1, p1, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    mul-float/2addr v1, p2

    add-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 105
    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    sub-float v2, v3, p2

    mul-float/2addr v1, v2

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    mul-float/2addr v2, p2

    add-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 106
    and-int/lit16 v2, p0, 0xff

    int-to-float v2, v2

    sub-float/2addr v3, p2

    mul-float/2addr v2, v3

    and-int/lit16 v3, p1, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p2

    add-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 107
    const/high16 v3, -0x1000000

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v3

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method private static line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V
    .locals 6

    .prologue
    .line 78
    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 79
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p6}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 80
    invoke-virtual {p1, p7}, Landroid/graphics/Paint;->setColor(I)V

    move-object v0, p0

    move v1, p2

    move v2, p3

    move v3, p4

    move v4, p5

    move-object v5, p1

    .line 81
    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 82
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 83
    return-void
.end method

.method private static neonCity(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 15

    .prologue
    .line 160
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v14, v2, v3

    .line 161
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x4

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v2, 0x4

    new-array v8, v2, [F

    fill-array-data v8, :array_1

    move-object v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 162
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3f3d70a4    # 0.74f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e99999a    # 0.3f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f0ccccd    # 0.55f

    mul-float v6, v2, v3

    const v7, 0x66ff7ad9

    move-object v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 163
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3f3d70a4    # 0.74f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e99999a    # 0.3f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3dae147b    # 0.085f

    mul-float v6, v2, v3

    const/16 v7, -0x1905

    move-object v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 164
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3f3d70a4    # 0.74f

    mul-float/2addr v2, v3

    move/from16 v0, p3

    int-to-float v3, v0

    const v4, 0x3ccccccd    # 0.025f

    mul-float/2addr v3, v4

    sub-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e99999a    # 0.3f

    mul-float/2addr v2, v3

    move/from16 v0, p3

    int-to-float v3, v0

    const v5, 0x3c75c28f    # 0.015f

    mul-float/2addr v3, v5

    sub-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d99999a    # 0.075f

    mul-float v6, v2, v3

    const v7, 0x33c07ad8

    move-object v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 165
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f6b851f    # 0.92f

    mul-float v7, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3ed70a3d    # 0.42f

    mul-float v8, v2, v3

    const/16 v9, 0x11

    const-wide/16 v10, 0x6

    const v12, -0xd4f0ab

    const/4 v13, 0x0

    move-object v3, p0

    move-object/from16 v4, p1

    move/from16 v5, p2

    move/from16 v6, p3

    invoke-static/range {v3 .. v13}, Lcom/mrkeyboard/app/MrScenes;->towers(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V

    .line 166
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f828f5c    # 1.02f

    mul-float v7, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f0ccccd    # 0.55f

    mul-float v8, v2, v3

    const/16 v9, 0xc

    const-wide/16 v10, 0x8

    const v12, -0xf5fbe0

    const/4 v13, 0x1

    move-object v3, p0

    move-object/from16 v4, p1

    move/from16 v5, p2

    move/from16 v6, p3

    invoke-static/range {v3 .. v13}, Lcom/mrkeyboard/app/MrScenes;->towers(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V

    .line 168
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f70a3d7    # 0.94f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x2

    new-array v7, v2, [I

    fill-array-data v7, :array_2

    const/4 v8, 0x0

    move-object v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 169
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f7851ec    # 0.97f

    mul-float v5, v2, v3

    move/from16 v0, p2

    int-to-float v6, v0

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f7851ec    # 0.97f

    mul-float v7, v2, v3

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v8, v14, v2

    const v9, 0x55ff8ad8

    move-object v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 170
    return-void

    .line 161
    nop

    :array_0
    .array-data 4
        -0xf8fce0
        -0xd5f5a6
        -0x75e086
        -0xb075
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3ee66666    # 0.45f
        0x3f400000    # 0.75f
        0x3f6147ae    # 0.88f
    .end array-data

    .line 168
    :array_2
    .array-data 4
        0xff4f8b
        0x55ff4f8b
    .end array-data
.end method

.method private static network(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 17

    .prologue
    .line 296
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v12, v2, v3

    .line 297
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x3

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v8, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 298
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3ea3d70a    # 0.32f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3ed70a3d    # 0.42f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f666666    # 0.9f

    mul-float v6, v2, v3

    const v7, 0x331f6bff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 299
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3f47ae14    # 0.78f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f1eb852    # 0.62f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f4ccccd    # 0.8f

    mul-float v6, v2, v3

    const v7, 0x30a04dff    # 1.16637E-9f

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 300
    new-instance v3, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v4, 0x39

    invoke-direct {v3, v4, v5}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 301
    const/16 v13, 0x2c

    .line 302
    new-array v14, v13, [F

    new-array v15, v13, [F

    .line 303
    const/4 v2, 0x0

    :goto_0
    if-ge v2, v13, :cond_0

    .line 304
    const v4, 0x3ca3d70a    # 0.02f

    const v5, 0x3f75c28f    # 0.96f

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v6

    mul-float/2addr v5, v6

    add-float/2addr v4, v5

    move/from16 v0, p2

    int-to-float v5, v0

    mul-float/2addr v4, v5

    aput v4, v14, v2

    .line 305
    const v4, 0x3d23d70a    # 0.04f

    const v5, 0x3f6b851f    # 0.92f

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v6

    mul-float/2addr v5, v6

    add-float/2addr v4, v5

    move/from16 v0, p3

    int-to-float v5, v0

    mul-float/2addr v4, v5

    aput v4, v15, v2

    .line 303
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 307
    :cond_0
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f0ccccd    # 0.55f

    mul-float v16, v2, v3

    .line 308
    const/4 v2, 0x0

    move v11, v2

    :goto_1
    if-ge v11, v13, :cond_3

    .line 309
    add-int/lit8 v2, v11, 0x1

    move v10, v2

    :goto_2
    if-ge v10, v13, :cond_2

    .line 310
    aget v2, v14, v11

    aget v3, v14, v10

    sub-float/2addr v2, v3

    aget v3, v15, v11

    aget v4, v15, v10

    sub-float/2addr v3, v4

    .line 311
    mul-float/2addr v2, v2

    mul-float/2addr v3, v3

    add-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-float v2, v2

    .line 312
    cmpg-float v3, v2, v16

    if-gez v3, :cond_1

    aget v4, v14, v11

    aget v5, v15, v11

    aget v6, v14, v10

    aget v7, v15, v10

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v8, v12, v3

    const v3, -0xa53701

    const/high16 v9, 0x3f800000    # 1.0f

    div-float v2, v2, v16

    sub-float v2, v9, v2

    const v9, 0x3f19999a    # 0.6f

    mul-float/2addr v2, v9

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v9

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 309
    :cond_1
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_2

    .line 308
    :cond_2
    add-int/lit8 v2, v11, 0x1

    move v11, v2

    goto :goto_1

    .line 315
    :cond_3
    const/4 v2, 0x0

    move v10, v2

    :goto_3
    if-ge v10, v13, :cond_9

    .line 316
    rem-int/lit8 v2, v10, 0x7

    if-nez v2, :cond_4

    const/4 v2, 0x1

    move v9, v2

    .line 317
    :goto_4
    if-eqz v9, :cond_5

    const v2, -0x4b7301

    move v8, v2

    .line 318
    :goto_5
    aget v4, v14, v10

    aget v5, v15, v10

    if-eqz v9, :cond_6

    const/high16 v2, 0x40e00000    # 7.0f

    :goto_6
    mul-float v6, v12, v2

    if-eqz v9, :cond_7

    const v2, 0x3f0ccccd    # 0.55f

    :goto_7
    invoke-static {v8, v2}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v7

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 319
    aget v4, v14, v10

    aget v5, v15, v10

    if-eqz v9, :cond_8

    const v2, 0x3ff33333    # 1.9f

    :goto_8
    mul-float v6, v12, v2

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move v7, v8

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 315
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_3

    .line 316
    :cond_4
    const/4 v2, 0x0

    move v9, v2

    goto :goto_4

    .line 317
    :cond_5
    const v2, -0x601901

    move v8, v2

    goto :goto_5

    .line 318
    :cond_6
    const/high16 v2, 0x40800000    # 4.0f

    goto :goto_6

    :cond_7
    const v2, 0x3eb33333    # 0.35f

    goto :goto_7

    .line 319
    :cond_8
    const/high16 v2, 0x3f800000    # 1.0f

    goto :goto_8

    .line 321
    :cond_9
    return-void

    .line 297
    :array_0
    .array-data 4
        -0xfbf5e2
        -0xf5e5c0
        -0xecf0c6
    .end array-data
.end method

.method private static orbit(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 16

    .prologue
    .line 324
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v15, v2, v3

    .line 325
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

    .line 326
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f47ae14    # 0.78f

    mul-float v6, v2, v3

    const/16 v7, 0x5a

    const-wide/16 v8, 0x29

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v4, p2

    move/from16 v5, p3

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->stars(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFIJ)V

    .line 327
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3fd9999a    # 1.7f

    mul-float v13, v2, v3

    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float/2addr v3, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v4, 0x3f3851ec    # 0.72f

    mul-float/2addr v2, v4

    add-float v4, v2, v13

    move/from16 v0, p3

    int-to-float v2, v0

    const v5, 0x3e6147ae    # 0.22f

    mul-float v9, v2, v5

    .line 329
    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 330
    new-instance v2, Landroid/graphics/RadialGradient;

    add-float v5, v13, v9

    const/4 v6, 0x4

    new-array v6, v6, [I

    fill-array-data v6, :array_2

    const/4 v7, 0x4

    new-array v7, v7, [F

    const/4 v8, 0x0

    const/4 v10, 0x0

    aput v10, v7, v8

    const/4 v8, 0x1

    const v10, 0x3f4ccccd    # 0.8f

    mul-float/2addr v10, v9

    sub-float v10, v13, v10

    add-float v11, v13, v9

    div-float/2addr v10, v11

    aput v10, v7, v8

    const/4 v8, 0x2

    add-float v10, v13, v9

    div-float v10, v13, v10

    aput v10, v7, v8

    const/4 v8, 0x3

    const/high16 v10, 0x3f800000    # 1.0f

    aput v10, v7, v8

    sget-object v8, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v2 .. v8}, Landroid/graphics/RadialGradient;-><init>(FFF[I[FLandroid/graphics/Shader$TileMode;)V

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 332
    add-float v2, v13, v9

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v3, v4, v2, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 333
    const/4 v2, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 335
    move/from16 v0, p2

    int-to-float v2, v0

    const v5, 0x3f3d70a4    # 0.74f

    mul-float v7, v2, v5

    const/4 v2, 0x0

    mul-float v5, v13, v13

    sub-float v6, v7, v3

    sub-float v8, v7, v3

    mul-float/2addr v6, v8

    sub-float/2addr v5, v6

    invoke-static {v2, v5}, Ljava/lang/Math;->max(FF)F

    move-result v2

    float-to-double v8, v2

    invoke-static {v8, v9}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v8

    double-to-float v2, v8

    sub-float v8, v4, v2

    .line 336
    move/from16 v0, p3

    int-to-float v2, v0

    const v5, 0x3ed70a3d    # 0.42f

    mul-float v9, v2, v5

    const v10, -0x66001d48

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 337
    const v14, -0xfcf7ec

    move-object/from16 v9, p0

    move-object/from16 v10, p1

    move v11, v3

    move v12, v4

    invoke-static/range {v9 .. v14}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 338
    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 339
    const/high16 v2, 0x3f800000    # 1.0f

    const v5, 0x3fa66666    # 1.3f

    mul-float/2addr v5, v15

    invoke-static {v2, v5}, Ljava/lang/Math;->max(FF)F

    move-result v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 340
    const v2, -0x33702b01    # -7.54094E7f

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 341
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-virtual {v0, v3, v4, v13, v1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 342
    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 343
    move/from16 v0, p3

    int-to-float v2, v0

    const v5, 0x3dcccccd    # 0.1f

    mul-float v9, v2, v5

    const/4 v10, -0x1

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 345
    new-instance v11, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v6, 0x5

    invoke-direct {v11, v6, v7}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 346
    const/4 v2, 0x0

    :goto_0
    const/16 v5, 0x46

    if-ge v2, v5, :cond_1

    .line 347
    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v5

    move/from16 v0, p2

    int-to-float v6, v0

    mul-float v7, v5, v6

    move/from16 v0, p3

    int-to-float v5, v0

    const v6, 0x3f47ae14    # 0.78f

    mul-float/2addr v5, v6

    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v6

    move/from16 v0, p3

    int-to-float v8, v0

    mul-float/2addr v6, v8

    const v8, 0x3e6147ae    # 0.22f

    mul-float/2addr v6, v8

    add-float v8, v5, v6

    .line 348
    sub-float v5, v7, v3

    sub-float v6, v8, v4

    .line 349
    mul-float/2addr v5, v5

    mul-float/2addr v6, v6

    add-float/2addr v5, v6

    const/high16 v6, 0x40800000    # 4.0f

    mul-float/2addr v6, v15

    sub-float v6, v13, v6

    const/high16 v9, 0x40800000    # 4.0f

    mul-float/2addr v9, v15

    sub-float v9, v13, v9

    mul-float/2addr v6, v9

    cmpg-float v5, v5, v6

    if-gez v5, :cond_0

    const v5, 0x3f333333    # 0.7f

    const/high16 v6, 0x3f000000    # 0.5f

    mul-float/2addr v6, v15

    invoke-static {v5, v6}, Ljava/lang/Math;->max(FF)F

    move-result v9

    const/16 v5, -0x3995

    const v6, 0x3eb33333    # 0.35f

    const/high16 v10, 0x3f000000    # 0.5f

    invoke-virtual {v11}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v12

    mul-float/2addr v10, v12

    add-float/2addr v6, v10

    invoke-static {v5, v6}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v10

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 346
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 352
    :cond_1
    move/from16 v0, p2

    int-to-float v2, v0

    const v3, 0x3e4ccccd    # 0.2f

    mul-float v10, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e99999a    # 0.3f

    mul-float v11, v2, v3

    .line 353
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d4ccccd    # 0.05f

    mul-float/2addr v2, v3

    sub-float v4, v10, v2

    const v2, 0x3f99999a    # 1.2f

    mul-float/2addr v2, v15

    sub-float v5, v11, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d4ccccd    # 0.05f

    mul-float/2addr v2, v3

    add-float v6, v10, v2

    const v2, 0x3f99999a    # 1.2f

    mul-float/2addr v2, v15

    add-float v7, v11, v2

    const v8, -0x756b58

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 354
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e2e147b    # 0.17f

    mul-float/2addr v2, v3

    sub-float v4, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    sub-float v5, v11, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d8f5c29    # 0.07f

    mul-float/2addr v2, v3

    sub-float v6, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    add-float v7, v11, v2

    const v8, -0xd3b576

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 355
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d8f5c29    # 0.07f

    mul-float/2addr v2, v3

    add-float v4, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    sub-float v5, v11, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e2e147b    # 0.17f

    mul-float/2addr v2, v3

    add-float v6, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    add-float v7, v11, v2

    const v8, -0xd3b576

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 356
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v2, v3

    sub-float v4, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    sub-float v5, v11, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v2, v3

    sub-float v6, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    add-float v7, v11, v2

    const v2, 0x3ecccccd    # 0.4f

    mul-float v8, v15, v2

    const v9, -0x906c28

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 357
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v2, v3

    add-float v4, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    sub-float v5, v11, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v2, v3

    add-float v6, v10, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3d75c28f    # 0.06f

    mul-float/2addr v2, v3

    add-float v7, v11, v2

    const v2, 0x3ecccccd    # 0.4f

    mul-float v8, v15, v2

    const v9, -0x906c28

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 358
    const v2, 0x3f99999a    # 1.2f

    mul-float/2addr v2, v15

    sub-float v5, v11, v2

    const/high16 v2, 0x3f800000    # 1.0f

    const v3, 0x3f333333    # 0.7f

    mul-float/2addr v3, v15

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v6

    const v7, -0xb2b3

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move v4, v10

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 359
    return-void

    .line 325
    nop

    :array_0
    .array-data 4
        -0xfefcf6
        -0xfbf4dc
        -0xf5e2b6
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f19999a    # 0.6f
        0x3f800000    # 1.0f
    .end array-data

    .line 330
    :array_2
    .array-data 4
        0x5ab8ff
        0x5ab8ff
        -0x33a54701    # -5.7336828E7f
        0x5ab8ff
    .end array-data
.end method

.method private static pad(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFF)V
    .locals 7

    .prologue
    const v6, 0x400ccccd    # 2.2f

    .line 287
    mul-float v4, p4, v6

    const v5, -0xfce7e0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 288
    sget-object v0, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 289
    const/high16 v0, 0x3f800000    # 1.0f

    const v1, 0x3f666666    # 0.9f

    mul-float/2addr v1, p4

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 290
    const v0, -0x590901

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 291
    mul-float v0, p4, v6

    invoke-virtual {p0, p2, p3, v0, p1}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 292
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 293
    return-void
.end method

.method private static ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFI)V
    .locals 8

    .prologue
    .line 136
    new-instance v2, Landroid/graphics/Path;

    invoke-direct {v2}, Landroid/graphics/Path;-><init>()V

    .line 137
    const/16 v3, 0x30

    .line 138
    const/4 v1, 0x0

    int-to-float v4, p3

    invoke-virtual {v2, v1, v4}, Landroid/graphics/Path;->moveTo(FF)V

    .line 139
    const/4 v1, 0x0

    :goto_0
    if-gt v1, v3, :cond_0

    .line 140
    int-to-float v4, v1

    int-to-float v5, v3

    div-float/2addr v4, v5

    .line 141
    const/high16 v5, 0x3f800000    # 1.0f

    mul-float v6, v4, p6

    add-float/2addr v6, p7

    invoke-static {v6}, Lcom/mrkeyboard/app/MrScenes;->tri(F)F

    move-result v6

    sub-float/2addr v5, v6

    const/high16 v6, 0x3f800000    # 1.0f

    mul-float v7, v4, p8

    add-float v7, v7, p9

    invoke-static {v7}, Lcom/mrkeyboard/app/MrScenes;->tri(F)F

    move-result v7

    sub-float/2addr v6, v7

    .line 142
    int-to-float v7, p2

    mul-float/2addr v4, v7

    const v7, 0x3f1eb852    # 0.62f

    mul-float/2addr v5, v7

    const v7, 0x3ec28f5c    # 0.38f

    mul-float/2addr v6, v7

    add-float/2addr v5, v6

    mul-float/2addr v5, p5

    sub-float v5, p4, v5

    invoke-virtual {v2, v4, v5}, Landroid/graphics/Path;->lineTo(FF)V

    .line 139
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 144
    :cond_0
    int-to-float v1, p2

    int-to-float v3, p3

    invoke-virtual {v2, v1, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 145
    invoke-virtual {v2}, Landroid/graphics/Path;->close()V

    .line 146
    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 147
    move/from16 v0, p10

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 148
    invoke-virtual {p0, v2, p1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 149
    return-void
.end method

.method private static stars(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFIJ)V
    .locals 12

    .prologue
    .line 123
    new-instance v9, Lcom/mrkeyboard/app/MrScenes$Seq;

    move-wide/from16 v0, p6

    invoke-direct {v9, v0, v1}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 124
    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x43b40000    # 360.0f

    div-float v10, v2, v3

    .line 125
    const/4 v2, 0x0

    move v8, v2

    :goto_0
    move/from16 v0, p5

    if-ge v8, v0, :cond_0

    .line 126
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    int-to-float v3, p2

    mul-float v4, v2, v3

    .line 127
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    mul-float v5, v2, p4

    .line 128
    const/high16 v2, 0x3f000000    # 0.5f

    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v3

    const v6, 0x3f8ccccd    # 1.1f

    mul-float/2addr v3, v6

    add-float/2addr v2, v3

    mul-float/2addr v2, v10

    .line 129
    invoke-virtual {v9}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v3

    const/high16 v6, 0x43070000    # 135.0f

    mul-float/2addr v3, v6

    float-to-int v3, v3

    add-int/lit8 v3, v3, 0x78

    .line 130
    const v6, 0x3f19999a    # 0.6f

    invoke-static {v6, v2}, Ljava/lang/Math;->max(FF)F

    move-result v6

    shl-int/lit8 v2, v3, 0x18

    const v3, 0xffffff

    or-int v7, v2, v3

    move-object v2, p0

    move-object v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 125
    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_0

    .line 132
    :cond_0
    return-void
.end method

.method private static streams(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 17

    .prologue
    .line 409
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x2

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v8, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 410
    const/high16 v2, 0x40a00000    # 5.0f

    move/from16 v0, p3

    int-to-float v3, v0

    const/high16 v4, 0x41600000    # 14.0f

    div-float/2addr v3, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v11

    .line 411
    new-instance v12, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v2, 0x49

    invoke-direct {v12, v2, v3}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 412
    move/from16 v0, p2

    int-to-float v2, v0

    div-float/2addr v2, v11

    float-to-int v2, v2

    add-int/lit8 v13, v2, 0x1

    .line 413
    const/4 v2, 0x0

    move v10, v2

    :goto_0
    if-ge v10, v13, :cond_5

    .line 414
    int-to-float v2, v10

    mul-float v14, v2, v11

    .line 415
    invoke-virtual {v12}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const v3, 0x3e99999a    # 0.3f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_0

    .line 413
    :goto_1
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_0

    .line 416
    :cond_0
    invoke-virtual {v12}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    move/from16 v0, p3

    int-to-float v3, v0

    mul-float/2addr v2, v3

    const v3, 0x3f933333    # 1.15f

    mul-float v15, v2, v3

    .line 417
    invoke-virtual {v12}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const/high16 v3, 0x41200000    # 10.0f

    mul-float/2addr v2, v3

    float-to-int v2, v2

    add-int/lit8 v16, v2, 0x6

    .line 418
    const/4 v2, 0x0

    move v9, v2

    :goto_2
    move/from16 v0, v16

    if-ge v9, v0, :cond_4

    .line 419
    int-to-float v2, v9

    mul-float/2addr v2, v11

    sub-float v2, v15, v2

    .line 420
    invoke-virtual {v12}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v3

    const v4, 0x3e0f5c29    # 0.14f

    cmpg-float v3, v3, v4

    if-ltz v3, :cond_1

    neg-float v3, v11

    cmpg-float v3, v2, v3

    if-ltz v3, :cond_1

    move/from16 v0, p3

    int-to-float v3, v0

    cmpl-float v3, v2, v3

    if-lez v3, :cond_2

    .line 418
    :cond_1
    :goto_3
    add-int/lit8 v2, v9, 0x1

    move v9, v2

    goto :goto_2

    .line 421
    :cond_2
    const/high16 v3, 0x3f800000    # 1.0f

    int-to-float v4, v9

    move/from16 v0, v16

    int-to-float v5, v0

    div-float/2addr v4, v5

    sub-float/2addr v3, v4

    .line 422
    if-nez v9, :cond_3

    const v8, -0x260017

    .line 423
    :goto_4
    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v3, v11

    add-float v4, v14, v3

    const v3, 0x3df5c28f    # 0.12f

    mul-float/2addr v3, v11

    add-float v5, v2, v3

    const v3, 0x3f6147ae    # 0.88f

    mul-float/2addr v3, v11

    add-float v6, v14, v3

    const v3, 0x3f6147ae    # 0.88f

    mul-float/2addr v3, v11

    add-float v7, v2, v3

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    goto :goto_3

    .line 422
    :cond_3
    const v4, -0xff0064

    const v5, 0x3e19999a    # 0.15f

    const/high16 v6, 0x3f400000    # 0.75f

    mul-float/2addr v3, v6

    add-float/2addr v3, v5

    invoke-static {v4, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v8

    goto :goto_4

    .line 425
    :cond_4
    const/high16 v2, 0x3f000000    # 0.5f

    mul-float/2addr v2, v11

    add-float v4, v14, v2

    const v2, 0x400ccccd    # 2.2f

    mul-float v6, v11, v2

    const v7, 0x4400ff9c

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move v5, v15

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    goto/16 :goto_1

    .line 427
    :cond_5
    return-void

    .line 409
    :array_0
    .array-data 4
        -0xfff5fa
        -0xffe7f1
    .end array-data
.end method

.method private static synthwave(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 18

    .prologue
    .line 203
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v16, v2, v3

    .line 204
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f19999a    # 0.6f

    mul-float v17, v2, v3

    .line 205
    const/4 v4, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    add-float v5, v17, v2

    const/4 v2, 0x4

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v2, 0x4

    new-array v8, v2, [F

    fill-array-data v8, :array_1

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 206
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3ca3d70a    # 0.02f

    mul-float/2addr v2, v3

    sub-float v5, v17, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e99999a    # 0.3f

    mul-float v13, v2, v3

    .line 207
    const/high16 v2, 0x40000000    # 2.0f

    mul-float v6, v13, v2

    const v7, 0x77ff4fa0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 209
    const/16 v14, 0x18

    .line 210
    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v14, :cond_1

    .line 211
    int-to-float v2, v3

    int-to-float v6, v14

    div-float v6, v2, v6

    .line 212
    sub-float v2, v5, v13

    const/high16 v7, 0x40000000    # 2.0f

    mul-float/2addr v7, v13

    mul-float/2addr v7, v6

    add-float v9, v2, v7

    sub-float v2, v5, v13

    const/high16 v7, 0x40000000    # 2.0f

    mul-float/2addr v7, v13

    add-int/lit8 v8, v3, 0x1

    int-to-float v8, v8

    mul-float/2addr v7, v8

    int-to-float v8, v14

    div-float/2addr v7, v8

    add-float/2addr v7, v2

    .line 213
    add-float v2, v9, v7

    const/high16 v8, 0x40000000    # 2.0f

    div-float/2addr v2, v8

    sub-float/2addr v2, v5

    .line 214
    const/4 v8, 0x0

    mul-float v10, v13, v13

    mul-float/2addr v2, v2

    sub-float v2, v10, v2

    invoke-static {v8, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    float-to-double v10, v2

    invoke-static {v10, v11}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v10

    double-to-float v10, v10

    .line 215
    const v2, 0x3eeb851f    # 0.46f

    cmpl-float v2, v6, v2

    if-lez v2, :cond_0

    const/high16 v2, 0x3f800000    # 1.0f

    const v8, 0x3eeb851f    # 0.46f

    sub-float v8, v6, v8

    const v11, 0x3f0a3d71    # 0.54f

    div-float/2addr v8, v11

    const v11, 0x3f51eb85    # 0.82f

    mul-float/2addr v8, v11

    sub-float/2addr v2, v8

    .line 216
    :goto_1
    sub-float v8, v4, v10

    add-float/2addr v10, v4

    sub-float/2addr v7, v9

    mul-float/2addr v2, v7

    add-float v11, v9, v2

    const/16 v2, -0x1ba2

    const v7, -0xd178

    invoke-static {v2, v7, v6}, Lcom/mrkeyboard/app/MrScenes;->lerp(IIF)I

    move-result v12

    move-object/from16 v6, p0

    move-object/from16 v7, p1

    invoke-static/range {v6 .. v12}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 210
    add-int/lit8 v2, v3, 0x1

    move v3, v2

    goto :goto_0

    .line 215
    :cond_0
    const/high16 v2, 0x3f800000    # 1.0f

    goto :goto_1

    .line 218
    :cond_1
    const v2, 0x3f19999a    # 0.6f

    mul-float v2, v2, v16

    add-float v9, v17, v2

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3e051eb8    # 0.13f

    mul-float v10, v2, v3

    const v11, 0x40466666    # 3.1f

    const v12, 0x3e4ccccd    # 0.2f

    const v13, 0x40e9999a    # 7.3f

    const v14, 0x3f19999a    # 0.6f

    const v15, -0xe5fac0

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    move/from16 v7, p2

    move/from16 v8, p3

    invoke-static/range {v5 .. v15}, Lcom/mrkeyboard/app/MrScenes;->ridge(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFFFFFI)V

    .line 219
    move/from16 v0, p3

    int-to-float v8, v0

    const/4 v2, 0x2

    new-array v10, v2, [I

    fill-array-data v10, :array_2

    const/4 v11, 0x0

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    move/from16 v7, v17

    move/from16 v9, p2

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 220
    const/4 v7, 0x0

    const v2, 0x3f4ccccd    # 0.8f

    mul-float v2, v2, v16

    sub-float v8, v17, v2

    move/from16 v0, p2

    int-to-float v9, v0

    const v2, 0x3f4ccccd    # 0.8f

    mul-float v2, v2, v16

    add-float v10, v17, v2

    const v2, -0x8528

    const v3, 0x3f59999a    # 0.85f

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v11

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 221
    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3ee66666    # 0.45f

    mul-float v6, v2, v3

    const v7, 0x44ff7ad8

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v5, v17

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 223
    const/4 v2, 0x1

    move v10, v2

    :goto_2
    const/16 v2, 0x9

    if-gt v10, v2, :cond_2

    .line 224
    int-to-float v2, v10

    const/high16 v3, 0x41100000    # 9.0f

    div-float/2addr v2, v3

    .line 225
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v3, v0

    sub-float v3, v3, v17

    mul-float/2addr v3, v2

    mul-float/2addr v3, v2

    add-float v5, v17, v3

    move/from16 v0, p2

    int-to-float v6, v0

    move/from16 v0, p3

    int-to-float v3, v0

    sub-float v3, v3, v17

    mul-float/2addr v3, v2

    mul-float/2addr v3, v2

    add-float v7, v17, v3

    const v3, 0x3eb33333    # 0.35f

    const v8, 0x3f19999a    # 0.6f

    mul-float/2addr v8, v2

    add-float/2addr v3, v8

    mul-float v8, v16, v3

    const v3, -0xc137

    const v9, 0x3eb33333    # 0.35f

    const/high16 v11, 0x3f000000    # 0.5f

    mul-float/2addr v2, v11

    add-float/2addr v2, v9

    invoke-static {v3, v2}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v9

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 223
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_2

    .line 227
    :cond_2
    const/16 v2, -0xe

    move v10, v2

    :goto_3
    const/16 v2, 0xe

    if-gt v10, v2, :cond_3

    .line 228
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float/2addr v2, v3

    mul-int v3, v10, p2

    int-to-float v3, v3

    const v4, 0x3c83126f    # 0.016f

    mul-float/2addr v3, v4

    add-float v4, v2, v3

    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float/2addr v2, v3

    mul-int v3, v10, p2

    int-to-float v3, v3

    const v5, 0x3e2e147b    # 0.17f

    mul-float/2addr v3, v5

    add-float v6, v2, v3

    move/from16 v0, p3

    int-to-float v7, v0

    const v2, 0x3f19999a    # 0.6f

    mul-float v8, v16, v2

    const v2, -0xc137

    const v3, 0x3f0ccccd    # 0.55f

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v9

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v5, v17

    invoke-static/range {v2 .. v9}, Lcom/mrkeyboard/app/MrScenes;->line(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFFI)V

    .line 227
    add-int/lit8 v2, v10, 0x1

    move v10, v2

    goto :goto_3

    .line 230
    :cond_3
    return-void

    .line 205
    nop

    :array_0
    .array-data 4
        -0xf2ffd0
        -0xb5f588
        -0x2cdc76
        -0x85a7
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3f000000    # 0.5f
        0x3f6147ae    # 0.88f
        0x3f800000    # 1.0f
    .end array-data

    .line 219
    :array_2
    .array-data 4
        -0xc5f59d
        -0xefffd6
    .end array-data
.end method

.method private static towers(Landroid/graphics/Canvas;Landroid/graphics/Paint;IIFFIJIZ)V
    .locals 19

    .prologue
    .line 174
    new-instance v13, Lcom/mrkeyboard/app/MrScenes$Seq;

    move-wide/from16 v0, p7

    invoke-direct {v13, v0, v1}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 175
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v14, v2, v3

    .line 176
    move/from16 v0, p2

    int-to-float v2, v0

    move/from16 v0, p6

    int-to-float v3, v0

    div-float v15, v2, v3

    .line 177
    const/4 v2, 0x0

    move v12, v2

    :goto_0
    move/from16 v0, p6

    if-ge v12, v0, :cond_8

    .line 178
    const v2, 0x3f59999a    # 0.85f

    const/high16 v3, 0x3f000000    # 0.5f

    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    mul-float v16, v15, v2

    .line 179
    const v2, 0x3e99999a    # 0.3f

    const v3, 0x3f333333    # 0.7f

    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v4

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    mul-float v17, p5, v2

    .line 180
    int-to-float v2, v12

    mul-float/2addr v2, v15

    const v3, 0x3dcccccd    # 0.1f

    mul-float/2addr v3, v15

    sub-float v4, v2, v3

    .line 181
    sub-float v5, p4, v17

    add-float v6, v4, v16

    move/from16 v0, p3

    int-to-float v7, v0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v8, p9

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 182
    if-nez p10, :cond_1

    .line 177
    :cond_0
    add-int/lit8 v2, v12, 0x1

    move v12, v2

    goto :goto_0

    .line 183
    :cond_1
    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const v3, 0x3ee66666    # 0.45f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_2

    .line 184
    const v2, 0x3da3d70a    # 0.08f

    const v3, 0x3dcccccd    # 0.1f

    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v5

    mul-float/2addr v3, v5

    add-float/2addr v2, v3

    mul-float v2, v2, p5

    .line 185
    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v3, v3, v16

    add-float/2addr v3, v4

    const v5, 0x3ecccccd    # 0.4f

    mul-float/2addr v5, v14

    sub-float v7, v3, v5

    sub-float v3, p4, v17

    sub-float v8, v3, v2

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v3, v3, v16

    add-float/2addr v3, v4

    const v5, 0x3ecccccd    # 0.4f

    mul-float/2addr v5, v14

    add-float v9, v3, v5

    sub-float v10, p4, v17

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    move/from16 v11, p9

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 186
    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v3, v3, v16

    add-float v7, v4, v3

    sub-float v3, p4, v17

    sub-float v8, v3, v2

    const v3, 0x3f99999a    # 1.2f

    const v5, 0x3f666666    # 0.9f

    mul-float/2addr v5, v14

    invoke-static {v3, v5}, Ljava/lang/Math;->max(FF)F

    move-result v9

    const v10, -0xc495

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 187
    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v3, v3, v16

    add-float v7, v4, v3

    sub-float v3, p4, v17

    sub-float v8, v3, v2

    const/high16 v2, 0x40800000    # 4.0f

    mul-float v9, v14, v2

    const v10, -0x7700c495

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v10}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 189
    :cond_2
    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    const/high16 v3, 0x3f000000    # 0.5f

    cmpg-float v2, v2, v3

    if-gez v2, :cond_4

    const v2, -0xca0f01

    .line 190
    :goto_1
    add-float v3, v4, v16

    const v5, 0x3f666666    # 0.9f

    mul-float/2addr v5, v14

    sub-float v7, v3, v5

    sub-float v8, p4, v17

    add-float v9, v4, v16

    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v3, v14

    sub-float v10, p4, v3

    const v3, 0x3f59999a    # 0.85f

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v11

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 191
    add-float v3, v4, v16

    const/high16 v5, 0x40400000    # 3.0f

    mul-float/2addr v5, v14

    sub-float v7, v3, v5

    sub-float v8, p4, v17

    add-float v9, v4, v16

    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v3, v14

    sub-float v10, p4, v3

    const v3, 0x3df5c28f    # 0.12f

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v11

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 192
    const/high16 v2, 0x40400000    # 3.0f

    const v3, 0x40266666    # 2.6f

    mul-float/2addr v3, v14

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v3

    .line 193
    sub-float v2, p4, v17

    add-float v8, v2, v3

    :goto_2
    const/high16 v2, 0x40000000    # 2.0f

    mul-float/2addr v2, v3

    sub-float v2, p4, v2

    cmpg-float v2, v8, v2

    if-gez v2, :cond_0

    .line 194
    const v2, 0x3f4ccccd    # 0.8f

    mul-float/2addr v2, v3

    add-float v7, v4, v2

    :goto_3
    const v2, 0x3f4ccccd    # 0.8f

    mul-float/2addr v2, v3

    add-float/2addr v2, v7

    add-float v5, v4, v16

    const/high16 v6, 0x40000000    # 2.0f

    mul-float/2addr v6, v14

    sub-float/2addr v5, v6

    cmpg-float v2, v2, v5

    if-gez v2, :cond_7

    .line 195
    invoke-virtual {v13}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    .line 196
    const v5, 0x3ecccccd    # 0.4f

    cmpg-float v5, v2, v5

    if-gez v5, :cond_3

    const v5, 0x3f4ccccd    # 0.8f

    mul-float/2addr v5, v3

    add-float v9, v7, v5

    const v5, 0x3f666666    # 0.9f

    mul-float/2addr v5, v3

    add-float v10, v8, v5

    const v5, 0x3e3851ec    # 0.18f

    cmpg-float v5, v2, v5

    if-gez v5, :cond_5

    const v2, -0xca0f01

    :goto_4
    const v5, 0x3f59999a    # 0.85f

    invoke-static {v2, v5}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v11

    move-object/from16 v5, p0

    move-object/from16 v6, p1

    invoke-static/range {v5 .. v11}, Lcom/mrkeyboard/app/MrScenes;->box(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFFI)V

    .line 194
    :cond_3
    const v2, 0x3fcccccd    # 1.6f

    mul-float/2addr v2, v3

    add-float/2addr v7, v2

    goto :goto_3

    .line 189
    :cond_4
    const v2, -0xb028

    goto/16 :goto_1

    .line 196
    :cond_5
    const v5, 0x3ea3d70a    # 0.32f

    cmpg-float v2, v2, v5

    if-gez v2, :cond_6

    const v2, -0xb028

    goto :goto_4

    :cond_6
    const/16 v2, -0x2d86

    goto :goto_4

    .line 193
    :cond_7
    const v2, 0x3ff33333    # 1.9f

    mul-float/2addr v2, v3

    add-float/2addr v8, v2

    goto :goto_2

    .line 200
    :cond_8
    return-void
.end method

.method private static tri(F)F
    .locals 2

    .prologue
    .line 153
    float-to-double v0, p0

    invoke-static {v0, v1}, Ljava/lang/Math;->floor(D)D

    move-result-wide v0

    double-to-float v0, v0

    sub-float v0, p0, v0

    .line 154
    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    const/high16 v1, 0x3f800000    # 1.0f

    sub-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    return v0
.end method

.method private static tube(Landroid/graphics/Canvas;Landroid/graphics/Paint;Landroid/graphics/Path;FI)V
    .locals 2

    .prologue
    .line 87
    const/high16 v0, 0x2a000000

    const v1, 0xffffff

    and-int/2addr v1, p4

    or-int/2addr v0, v1

    .line 88
    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 89
    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 90
    const/high16 v0, 0x40000000    # 2.0f

    const/high16 v1, 0x40800000    # 4.0f

    mul-float/2addr v1, p3

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 91
    invoke-virtual {p0, p2, p1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 92
    invoke-virtual {p1, p4}, Landroid/graphics/Paint;->setColor(I)V

    .line 93
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {v0, p3}, Ljava/lang/Math;->max(FF)F

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 94
    invoke-virtual {p0, p2, p1}, Landroid/graphics/Canvas;->drawPath(Landroid/graphics/Path;Landroid/graphics/Paint;)V

    .line 95
    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 96
    return-void
.end method

.method private static waves(Landroid/graphics/Canvas;Landroid/graphics/Paint;II)V
    .locals 22

    .prologue
    .line 430
    move/from16 v0, p3

    int-to-float v2, v0

    const/high16 v3, 0x42c80000    # 100.0f

    div-float v9, v2, v3

    .line 431
    const/4 v4, 0x0

    move/from16 v0, p3

    int-to-float v5, v0

    const/4 v2, 0x3

    new-array v7, v2, [I

    fill-array-data v7, :array_0

    const/4 v8, 0x0

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    move/from16 v6, p2

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrScenes;->band(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFI[I[F)V

    .line 432
    move/from16 v0, p2

    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v4, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f0ccccd    # 0.55f

    mul-float v5, v2, v3

    move/from16 v0, p3

    int-to-float v2, v0

    const v3, 0x3f666666    # 0.9f

    mul-float v6, v2, v3

    const v7, 0x33704dff

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->glow(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    .line 433
    const/4 v2, 0x6

    new-array v4, v2, [I

    fill-array-data v4, :array_1

    .line 434
    const/4 v2, 0x0

    :goto_0
    array-length v3, v4

    if-ge v2, v3, :cond_2

    .line 435
    new-instance v5, Landroid/graphics/Path;

    invoke-direct {v5}, Landroid/graphics/Path;-><init>()V

    .line 436
    move/from16 v0, p3

    int-to-float v3, v0

    const v6, 0x3e99999a    # 0.3f

    const v7, 0x3db851ec    # 0.09f

    int-to-float v8, v2

    mul-float/2addr v7, v8

    add-float/2addr v6, v7

    mul-float/2addr v6, v3

    move/from16 v0, p3

    int-to-float v3, v0

    const v7, 0x3d8f5c29    # 0.07f

    const v8, 0x3c449ba6    # 0.012f

    int-to-float v10, v2

    mul-float/2addr v8, v10

    add-float/2addr v7, v8

    mul-float/2addr v7, v3

    .line 437
    const/16 v8, 0x48

    .line 438
    const/4 v3, 0x0

    :goto_1
    if-gt v3, v8, :cond_1

    .line 439
    int-to-float v10, v3

    int-to-float v11, v8

    div-float/2addr v10, v11

    .line 440
    float-to-double v12, v10

    const-wide/high16 v14, 0x4000000000000000L    # 2.0

    mul-double/2addr v12, v14

    const-wide v14, 0x400921fb54442d18L    # Math.PI

    mul-double/2addr v12, v14

    .line 441
    const-wide v14, 0x3ff4cccccccccccdL    # 1.3

    const-wide/high16 v16, 0x3fd0000000000000L    # 0.25

    int-to-double v0, v2

    move-wide/from16 v18, v0

    mul-double v16, v16, v18

    add-double v14, v14, v16

    mul-double/2addr v14, v12

    int-to-double v0, v2

    move-wide/from16 v16, v0

    const-wide v18, 0x3ff199999999999aL    # 1.1

    mul-double v16, v16, v18

    add-double v14, v14, v16

    invoke-static {v14, v15}, Ljava/lang/Math;->sin(D)D

    move-result-wide v14

    double-to-float v11, v14

    mul-float/2addr v11, v7

    add-float/2addr v11, v6

    const v14, 0x3ee66666    # 0.45f

    mul-float/2addr v14, v7

    const-wide v16, 0x4008cccccccccccdL    # 3.1

    const-wide v18, 0x3fd999999999999aL    # 0.4

    int-to-double v0, v2

    move-wide/from16 v20, v0

    mul-double v18, v18, v20

    add-double v16, v16, v18

    mul-double v12, v12, v16

    int-to-double v0, v2

    move-wide/from16 v16, v0

    const-wide v18, 0x4002666666666666L    # 2.3

    mul-double v16, v16, v18

    add-double v12, v12, v16

    invoke-static {v12, v13}, Ljava/lang/Math;->sin(D)D

    move-result-wide v12

    double-to-float v12, v12

    mul-float/2addr v12, v14

    add-float/2addr v11, v12

    .line 442
    if-nez v3, :cond_0

    const/4 v10, 0x0

    invoke-virtual {v5, v10, v11}, Landroid/graphics/Path;->moveTo(FF)V

    .line 438
    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 443
    :cond_0
    move/from16 v0, p2

    int-to-float v12, v0

    mul-float/2addr v10, v12

    invoke-virtual {v5, v10, v11}, Landroid/graphics/Path;->lineTo(FF)V

    goto :goto_2

    .line 445
    :cond_1
    const/high16 v3, 0x3f800000    # 1.0f

    const v6, 0x3df5c28f    # 0.12f

    int-to-float v7, v2

    mul-float/2addr v6, v7

    add-float/2addr v3, v6

    mul-float/2addr v3, v9

    aget v6, v4, v2

    const v7, 0x3f666666    # 0.9f

    invoke-static {v6, v7}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v6

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-static {v0, v1, v5, v3, v6}, Lcom/mrkeyboard/app/MrScenes;->tube(Landroid/graphics/Canvas;Landroid/graphics/Paint;Landroid/graphics/Path;FI)V

    .line 434
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    .line 447
    :cond_2
    new-instance v10, Lcom/mrkeyboard/app/MrScenes$Seq;

    const-wide/16 v2, 0x58

    invoke-direct {v10, v2, v3}, Lcom/mrkeyboard/app/MrScenes$Seq;-><init>(J)V

    .line 448
    const/4 v2, 0x0

    move v8, v2

    :goto_3
    const/16 v2, 0x2d

    if-ge v8, v2, :cond_3

    invoke-virtual {v10}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    move/from16 v0, p2

    int-to-float v3, v0

    mul-float v4, v2, v3

    invoke-virtual {v10}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v2

    move/from16 v0, p3

    int-to-float v3, v0

    mul-float v5, v2, v3

    const v2, 0x3f333333    # 0.7f

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float/2addr v3, v9

    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v6

    const/4 v2, -0x1

    const v3, 0x3e4ccccd    # 0.2f

    const/high16 v7, 0x3f000000    # 0.5f

    invoke-virtual {v10}, Lcom/mrkeyboard/app/MrScenes$Seq;->next()F

    move-result v11

    mul-float/2addr v7, v11

    add-float/2addr v3, v7

    invoke-static {v2, v3}, Lcom/mrkeyboard/app/MrScenes;->alpha(IF)I

    move-result v7

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-static/range {v2 .. v7}, Lcom/mrkeyboard/app/MrScenes;->disc(Landroid/graphics/Canvas;Landroid/graphics/Paint;FFFI)V

    add-int/lit8 v2, v8, 0x1

    move v8, v2

    goto :goto_3

    .line 449
    :cond_3
    return-void

    .line 431
    :array_0
    .array-data 4
        -0xf7fce1
        -0xe5f5b6
        -0xf5f9d0
    .end array-data

    .line 433
    :array_1
    .array-data 4
        -0xca0f01
        -0x4c9401
        -0xb028
        -0xb26401
        -0xca0f01
        -0x4c9401
    .end array-data
.end method
