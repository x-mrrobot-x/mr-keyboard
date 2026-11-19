.class final Lcom/mrkeyboard/app/MrGlow;
.super Ljava/lang/Object;
.source "MrGlow.java"


# static fields
.field static final DASH_DP:F = 3.0f

.field static final HINT_SHARE:F = 0.7f

.field static final ICON_DP:F = 3.25f

.field static final MID:F = 0.16f

.field static final MID_MAX:F = 4.0f

.field static final MID_MIN:F = 2.0f

.field static final PREVIEW_DP:F = 6.0f

.field static final STEPS:I = 0x30

.field static final TIGHT:F = 0.085f

.field static final TIGHT_MAX:F = 2.5f

.field static final TIGHT_MIN:F = 1.25f

.field static final TILT:F = 0.22f

.field static final WIDE:F = 0.3f

.field static final WIDE_ALPHA:F = 0.75f

.field static final WIDE_MAX:F = 7.0f

.field static final WIDE_MIN:F = 3.0f

.field private static sAccentGlow:I

.field private static sDashLock:I

.field private static sDashOff:I

.field private static sDensity:F

.field private static sEdgeFilter:[Landroid/graphics/ColorFilter;

.field private static sEnd:I

.field private static sFaceFilter:[Landroid/graphics/ColorFilter;

.field private static sFillFilter:[Landroid/graphics/ColorFilter;

.field private static sGlow:I

.field private static sHue:[I

.field private static sIconGlowColor:I

.field private static sIconGlowFilter:Landroid/graphics/ColorFilter;

.field private static sInk:I

.field private static sInkFilter:Landroid/graphics/ColorFilter;

.field private static sInkFilterColor:I

.field private static sKeyGlow:I

.field private static sLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private static sLookTag:Ljava/lang/String;

.field private static sLookVersion:I

.field private static sMatrix:[[F

.field private static sMid:I

.field private static sOverOff:I

.field private static sSpectrum:Z

.field private static sStart:I

.field private static sStep:I

.field private static sTag:Ljava/lang/String;

.field private static sText:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 69
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 70
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 72
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 78
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 80
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bloom(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 276
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 277
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-nez p4, :cond_1

    .line 283
    :cond_0
    :goto_0
    return-void

    .line 278
    :cond_1
    invoke-virtual {p4}, Landroid/graphics/Paint;->getTextSize()F

    move-result v1

    .line 279
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 280
    const v3, 0x3e99999a    # 0.3f

    mul-float/2addr v3, v1

    const/high16 v4, 0x40400000    # 3.0f

    mul-float/2addr v4, v2

    const/high16 v5, 0x40e00000    # 7.0f

    mul-float/2addr v5, v2

    invoke-static {v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v3

    const/high16 v4, 0x3f400000    # 0.75f

    invoke-static {v0, v4}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v4

    invoke-virtual {p4, v3, v6, v6, v4}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    .line 281
    invoke-virtual {p0, p1, p2, p3, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 282
    const v3, 0x3dae147b    # 0.085f

    mul-float/2addr v1, v3

    const/high16 v3, 0x3fa00000    # 1.25f

    mul-float/2addr v3, v2

    const/high16 v4, 0x40200000    # 2.5f

    mul-float/2addr v2, v4

    invoke-static {v1, v3, v2}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    invoke-virtual {p4, v1, v6, v6, v0}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    goto :goto_0
.end method

.method private static byteOf(F)I
    .locals 2

    .prologue
    const/16 v0, 0xff

    .line 493
    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 494
    if-gez v1, :cond_1

    const/4 v0, 0x0

    :cond_0
    :goto_0
    return v0

    :cond_1
    if-gt v1, v0, :cond_0

    move v0, v1

    goto :goto_0
.end method

.method static clamp(FFF)F
    .locals 1

    .prologue
    .line 477
    cmpg-float v0, p0, p1

    if-gez v0, :cond_0

    :goto_0
    return p1

    :cond_0
    cmpl-float v0, p0, p2

    if-lez v0, :cond_1

    move p1, p2

    goto :goto_0

    :cond_1
    move p1, p0

    goto :goto_0
.end method

.method static dash(Landroid/graphics/Paint;)V
    .locals 9

    .prologue
    const/4 v8, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    const v7, 0xffffff

    .line 325
    if-nez p0, :cond_1

    .line 341
    :cond_0
    :goto_0
    return-void

    .line 326
    :cond_1
    invoke-virtual {p0}, Landroid/graphics/Paint;->getColor()I

    move-result v4

    .line 328
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    if-ltz v0, :cond_2

    and-int v0, v4, v7

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    if-ne v0, v3, :cond_2

    move v0, v1

    .line 329
    :goto_1
    sget v3, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    if-nez v3, :cond_3

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-gez v3, :cond_3

    .line 330
    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    .line 331
    if-eqz v0, :cond_0

    invoke-static {v4}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 328
    goto :goto_1

    .line 334
    :cond_3
    and-int v3, v4, v7

    sget v5, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    and-int/2addr v5, v7

    if-ne v3, v5, :cond_5

    move v3, v1

    .line 335
    :goto_2
    and-int v5, v4, v7

    sget v6, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    and-int/2addr v6, v7

    if-ne v5, v6, :cond_6

    .line 336
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-ltz v2, :cond_9

    if-nez v1, :cond_9

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    aget-object v1, v1, v2

    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v1

    .line 337
    :goto_4
    if-eqz v0, :cond_8

    invoke-static {v1}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    .line 338
    :goto_5
    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 339
    if-nez v3, :cond_4

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    if-nez v1, :cond_7

    :cond_4
    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_0

    :cond_5
    move v3, v2

    .line 334
    goto :goto_2

    :cond_6
    move v1, v2

    .line 335
    goto :goto_3

    .line 340
    :cond_7
    const/high16 v1, 0x40400000    # 3.0f

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {p0, v1, v8, v8, v0}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    goto :goto_0

    :cond_8
    move v0, v1

    goto :goto_5

    :cond_9
    move v1, v4

    goto :goto_4
.end method

.method private static density(Landroid/view/View;)F
    .locals 2

    .prologue
    .line 469
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 470
    const/4 v1, 0x0

    cmpl-float v1, v0, v1

    if-lez v1, :cond_0

    .line 472
    :goto_0
    return v0

    .line 470
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0

    .line 471
    :catch_0
    move-exception v0

    .line 472
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    goto :goto_0
.end method

.method static drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 229
    if-nez p0, :cond_0

    .line 230
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 243
    :goto_0
    return-void

    .line 233
    :cond_0
    if-eqz p5, :cond_3

    .line 234
    if-eqz p6, :cond_1

    invoke-static {p0, p5, p6}, Lcom/mrkeyboard/app/MrGlow;->splitFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)Z

    move-result v0

    if-nez v0, :cond_2

    :cond_1
    invoke-virtual {p0, p5}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 239
    :cond_2
    :goto_1
    :try_start_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 241
    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_0

    .line 235
    :cond_3
    if-eqz p4, :cond_2

    .line 236
    invoke-virtual {p0, p4}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_1

    .line 241
    :catchall_0
    move-exception v0

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 242
    throw v0
.end method

.method static drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 214
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 215
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrKeyLook;->faceTuned()Z

    move-result v1

    .line 216
    if-eqz p0, :cond_0

    if-gez v0, :cond_1

    if-nez v1, :cond_1

    .line 217
    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 221
    :goto_0
    return-void

    .line 220
    :cond_1
    if-gez v0, :cond_3

    move-object v4, v6

    :goto_1
    if-eqz v1, :cond_4

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->fillFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v5

    :goto_2
    if-eqz v1, :cond_2

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->edgeFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v6

    :cond_2
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)V

    goto :goto_0

    :cond_3
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->faceFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v4

    goto :goto_1

    :cond_4
    move-object v5, v6

    goto :goto_2
.end method

.method static edge(Landroid/graphics/Paint;)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 291
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 292
    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 295
    :cond_0
    :goto_0
    return-void

    .line 293
    :cond_1
    sget v1, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 294
    invoke-virtual {p0}, Landroid/graphics/Paint;->getTextSize()F

    move-result v2

    const v3, 0x3e23d70a    # 0.16f

    mul-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v3, v1

    const/high16 v4, 0x40800000    # 4.0f

    mul-float/2addr v1, v4

    invoke-static {v2, v3, v1}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    invoke-virtual {p0, v1, v5, v5, v0}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    goto :goto_0
.end method

.method private static edgeFilter(I)Landroid/graphics/ColorFilter;
    .locals 5

    .prologue
    .line 265
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    if-nez v0, :cond_0

    const/16 v0, 0x32

    new-array v0, v0, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 266
    :cond_0
    if-gez p0, :cond_2

    const/16 v0, 0x31

    .line 267
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    aget-object v1, v1, v0

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    if-gez p0, :cond_3

    const/4 v1, 0x0

    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v1

    aput-object v1, v2, v0

    .line 268
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v1, v0

    return-object v0

    :cond_2
    move v0, p0

    .line 266
    goto :goto_0

    .line 267
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v1, v1, p0

    goto :goto_1
.end method

.method private static faceFilter(I)Landroid/graphics/ColorFilter;
    .locals 2

    .prologue
    .line 401
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v0, p0

    .line 402
    if-nez v0, :cond_0

    .line 403
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v0, v0, p0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->filter([F)Landroid/graphics/ColorFilter;

    move-result-object v0

    .line 404
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aput-object v0, v1, p0

    .line 406
    :cond_0
    return-object v0
.end method

.method static fade(IF)I
    .locals 3

    .prologue
    .line 482
    ushr-int/lit8 v0, p0, 0x18

    int-to-float v0, v0

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {p1, v1, v2}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 483
    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method private static fillFilter(I)Landroid/graphics/ColorFilter;
    .locals 5

    .prologue
    .line 258
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    if-nez v0, :cond_0

    const/16 v0, 0x32

    new-array v0, v0, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 259
    :cond_0
    if-gez p0, :cond_2

    const/16 v0, 0x31

    .line 260
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    aget-object v1, v1, v0

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    if-gez p0, :cond_3

    const/4 v1, 0x0

    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v1

    aput-object v1, v2, v0

    .line 261
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v1, v0

    return-object v0

    :cond_2
    move v0, p0

    .line 259
    goto :goto_0

    .line 260
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v1, v1, p0

    goto :goto_1
.end method

.method static filter([F)Landroid/graphics/ColorFilter;
    .locals 1

    .prologue
    .line 411
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v0

    return-object v0
.end method

.method static filter([FF)Landroid/graphics/ColorFilter;
    .locals 8

    .prologue
    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    const/high16 v3, 0x3f800000    # 1.0f

    const/4 v4, 0x0

    .line 416
    if-nez p0, :cond_0

    .line 417
    new-instance v0, Landroid/graphics/ColorMatrixColorFilter;

    const/16 v1, 0x14

    new-array v1, v1, [F

    aput v3, v1, v5

    aput v4, v1, v6

    aput v4, v1, v7

    const/4 v2, 0x3

    aput v4, v1, v2

    const/4 v2, 0x4

    aput v4, v1, v2

    const/4 v2, 0x5

    aput v4, v1, v2

    const/4 v2, 0x6

    aput v3, v1, v2

    const/4 v2, 0x7

    aput v4, v1, v2

    const/16 v2, 0x8

    aput v4, v1, v2

    const/16 v2, 0x9

    aput v4, v1, v2

    const/16 v2, 0xa

    aput v4, v1, v2

    const/16 v2, 0xb

    aput v4, v1, v2

    const/16 v2, 0xc

    aput v3, v1, v2

    const/16 v2, 0xd

    aput v4, v1, v2

    const/16 v2, 0xe

    aput v4, v1, v2

    const/16 v2, 0xf

    aput v4, v1, v2

    const/16 v2, 0x10

    aput v4, v1, v2

    const/16 v2, 0x11

    aput v4, v1, v2

    const/16 v2, 0x12

    aput p1, v1, v2

    const/16 v2, 0x13

    aput v4, v1, v2

    invoke-direct {v0, v1}, Landroid/graphics/ColorMatrixColorFilter;-><init>([F)V

    .line 423
    :goto_0
    return-object v0

    :cond_0
    new-instance v0, Landroid/graphics/ColorMatrixColorFilter;

    const/16 v1, 0x14

    new-array v1, v1, [F

    aget v2, p0, v5

    aput v2, v1, v5

    aget v2, p0, v6

    aput v2, v1, v6

    aget v2, p0, v7

    aput v2, v1, v7

    const/4 v2, 0x3

    aput v4, v1, v2

    const/4 v2, 0x4

    aput v4, v1, v2

    const/4 v2, 0x5

    const/4 v3, 0x3

    aget v3, p0, v3

    aput v3, v1, v2

    const/4 v2, 0x6

    const/4 v3, 0x4

    aget v3, p0, v3

    aput v3, v1, v2

    const/4 v2, 0x7

    const/4 v3, 0x5

    aget v3, p0, v3

    aput v3, v1, v2

    const/16 v2, 0x8

    aput v4, v1, v2

    const/16 v2, 0x9

    aput v4, v1, v2

    const/16 v2, 0xa

    const/4 v3, 0x6

    aget v3, p0, v3

    aput v3, v1, v2

    const/16 v2, 0xb

    const/4 v3, 0x7

    aget v3, p0, v3

    aput v3, v1, v2

    const/16 v2, 0xc

    const/16 v3, 0x8

    aget v3, p0, v3

    aput v3, v1, v2

    const/16 v2, 0xd

    aput v4, v1, v2

    const/16 v2, 0xe

    aput v4, v1, v2

    const/16 v2, 0xf

    aput v4, v1, v2

    const/16 v2, 0x10

    aput v4, v1, v2

    const/16 v2, 0x11

    aput v4, v1, v2

    const/16 v2, 0x12

    aput p1, v1, v2

    const/16 v2, 0x13

    aput v4, v1, v2

    invoke-direct {v0, v1}, Landroid/graphics/ColorMatrixColorFilter;-><init>([F)V

    goto :goto_0
.end method

.method static hint(Landroid/graphics/Paint;I)V
    .locals 2

    .prologue
    .line 199
    if-nez p0, :cond_1

    .line 206
    :cond_0
    :goto_0
    return-void

    .line 200
    :cond_1
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    if-eqz v0, :cond_2

    .line 201
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    const v1, 0x3f333333    # 0.7f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    .line 204
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-ltz v0, :cond_0

    .line 205
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    aget-object v0, v0, v1

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0
.end method

.method static hsv(I[F)V
    .locals 8

    .prologue
    const/high16 v4, 0x437f0000    # 255.0f

    const/high16 v7, 0x42700000    # 60.0f

    const/4 v1, 0x0

    .line 499
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    div-float/2addr v0, v4

    shr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    div-float/2addr v2, v4

    and-int/lit16 v3, p0, 0xff

    int-to-float v3, v3

    div-float/2addr v3, v4

    .line 500
    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v5

    invoke-static {v0, v5}, Ljava/lang/Math;->min(FF)F

    move-result v5

    .line 501
    sub-float v5, v4, v5

    .line 502
    cmpg-float v6, v5, v1

    if-gtz v6, :cond_1

    move v0, v1

    .line 506
    :goto_0
    cmpg-float v2, v0, v1

    if-gez v2, :cond_0

    const/high16 v2, 0x43b40000    # 360.0f

    add-float/2addr v0, v2

    .line 507
    :cond_0
    const/4 v2, 0x0

    aput v0, p1, v2

    .line 508
    const/4 v2, 0x1

    cmpg-float v0, v4, v1

    if-gtz v0, :cond_4

    move v0, v1

    :goto_1
    aput v0, p1, v2

    .line 509
    const/4 v0, 0x2

    aput v4, p1, v0

    .line 510
    return-void

    .line 503
    :cond_1
    cmpl-float v6, v4, v0

    if-nez v6, :cond_2

    sub-float v0, v2, v3

    div-float/2addr v0, v5

    const/high16 v2, 0x40c00000    # 6.0f

    rem-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 504
    :cond_2
    cmpl-float v6, v4, v2

    if-nez v6, :cond_3

    sub-float v0, v3, v0

    div-float/2addr v0, v5

    const/high16 v2, 0x40000000    # 2.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 505
    :cond_3
    sub-float/2addr v0, v2

    div-float/2addr v0, v5

    const/high16 v2, 0x40800000    # 4.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 508
    :cond_4
    div-float v0, v5, v4

    goto :goto_1
.end method

.method static icon(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V
    .locals 3

    .prologue
    .line 299
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 300
    if-nez v0, :cond_0

    .line 306
    :goto_0
    return-void

    .line 301
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    if-eq v1, v0, :cond_2

    .line 302
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    .line 303
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 305
    :cond_2
    const/high16 v0, 0x40500000    # 3.25f

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    mul-float/2addr v0, v1

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    invoke-static {p0, p1, p2, v0, v1}, Lcom/mrkeyboard/app/ShadowDrawHelper;->draw(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V

    goto :goto_0
.end method

.method static iconFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;
    .locals 3

    .prologue
    .line 310
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 311
    if-nez v0, :cond_0

    .line 316
    :goto_0
    return-object p0

    .line 312
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    if-eq v1, v0, :cond_2

    .line 313
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    .line 314
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 316
    :cond_2
    sget-object p0, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    goto :goto_0
.end method

.method static key(Landroid/view/View;Lcom/mrkeyboard/app/Keyboard$Key;ZLandroid/graphics/Paint;)V
    .locals 6

    .prologue
    const/high16 v5, 0x3f000000    # 0.5f

    const/4 v1, 0x0

    .line 164
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 165
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 166
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-nez v0, :cond_2

    .line 167
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 187
    :cond_0
    :goto_0
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    if-eqz v0, :cond_1

    .line 188
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 189
    if-eqz p3, :cond_1

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 191
    :cond_1
    return-void

    .line 169
    :cond_2
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGlow;->density(Landroid/view/View;)F

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 170
    if-eqz p2, :cond_4

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 171
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    ushr-int/lit8 v0, v0, 0x18

    if-eqz v0, :cond_5

    const/4 v0, 0x1

    .line 172
    :goto_2
    if-nez v0, :cond_3

    sput v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 173
    :cond_3
    sget-boolean v2, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v2, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 174
    iget v2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    int-to-float v2, v2

    iget v3, p1, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v3, v3

    mul-float/2addr v3, v5

    add-float/2addr v2, v3

    iget v3, p1, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    int-to-float v3, v3

    iget v4, p1, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    int-to-float v4, v4

    mul-float/2addr v4, v5

    add-float/2addr v3, v4

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v5

    invoke-static {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->step(FFII)I

    move-result v2

    .line 175
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGlow;->matrix(I)[F

    move-result-object v3

    .line 176
    if-eqz v3, :cond_0

    .line 177
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 178
    if-eqz v0, :cond_6

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    const/high16 v1, -0x1000000

    and-int/2addr v0, v1

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aget v1, v1, v2

    const v2, 0xffffff

    and-int/2addr v1, v2

    or-int/2addr v0, v1

    :goto_3
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 179
    if-eqz p3, :cond_0

    .line 180
    invoke-virtual {p3}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 181
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    .line 170
    :cond_4
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    goto :goto_1

    :cond_5
    move v0, v1

    .line 171
    goto :goto_2

    :cond_6
    move v0, v1

    .line 178
    goto :goto_3
.end method

.method private static load(Ljava/lang/String;)V
    .locals 3

    .prologue
    const/16 v2, 0x31

    const/4 v1, 0x0

    .line 113
    sput-object p0, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 114
    const-string v0, "glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    .line 115
    const-string v0, "accent_glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    .line 116
    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    .line 117
    const-string v0, "modifier_indicator_lock"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    .line 118
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->spectrum()Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    .line 119
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 120
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 121
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 122
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 123
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 124
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v0, :cond_1

    .line 125
    const-string v0, "spectrum_start"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    .line 126
    const-string v0, "spectrum_mid"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    .line 127
    const-string v0, "spectrum_end"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    .line 128
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v0

    .line 129
    if-eqz v0, :cond_0

    .line 130
    const/4 v1, 0x0

    aget v1, v0, v1

    sput v1, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    .line 131
    const/4 v1, 0x1

    aget v1, v0, v1

    sput v1, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    .line 132
    const/4 v1, 0x2

    aget v0, v0, v1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    .line 134
    :cond_0
    new-array v0, v2, [[F

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 135
    new-array v0, v2, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 136
    new-array v0, v2, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 138
    :cond_1
    return-void
.end method

.method static map([FI)I
    .locals 6

    .prologue
    .line 457
    if-nez p0, :cond_0

    .line 459
    :goto_0
    return p1

    .line 458
    :cond_0
    shr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    shr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    and-int/lit16 v2, p1, 0xff

    int-to-float v2, v2

    .line 459
    const/high16 v3, -0x1000000

    and-int/2addr v3, p1

    const/4 v4, 0x0

    aget v4, p0, v4

    mul-float/2addr v4, v0

    const/4 v5, 0x1

    aget v5, p0, v5

    mul-float/2addr v5, v1

    add-float/2addr v4, v5

    const/4 v5, 0x2

    aget v5, p0, v5

    mul-float/2addr v5, v2

    add-float/2addr v4, v5

    .line 460
    invoke-static {v4}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v4

    shl-int/lit8 v4, v4, 0x10

    or-int/2addr v3, v4

    const/4 v4, 0x3

    aget v4, p0, v4

    mul-float/2addr v4, v0

    const/4 v5, 0x4

    aget v5, p0, v5

    mul-float/2addr v5, v1

    add-float/2addr v4, v5

    const/4 v5, 0x5

    aget v5, p0, v5

    mul-float/2addr v5, v2

    add-float/2addr v4, v5

    .line 461
    invoke-static {v4}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v4

    shl-int/lit8 v4, v4, 0x8

    or-int/2addr v3, v4

    const/4 v4, 0x6

    aget v4, p0, v4

    mul-float/2addr v0, v4

    const/4 v4, 0x7

    aget v4, p0, v4

    mul-float/2addr v1, v4

    add-float/2addr v0, v1

    const/16 v1, 0x8

    aget v1, p0, v1

    mul-float/2addr v1, v2

    add-float/2addr v0, v1

    .line 462
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v0

    or-int p1, v3, v0

    .line 459
    goto :goto_0
.end method

.method private static matrix(I)[F
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 387
    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 388
    if-eqz v2, :cond_0

    if-ltz p0, :cond_0

    const/16 v0, 0x30

    if-le p0, v0, :cond_2

    :cond_0
    move-object v0, v1

    .line 397
    :cond_1
    :goto_0
    return-object v0

    .line 389
    :cond_2
    aget-object v0, v2, p0

    .line 390
    if-nez v0, :cond_1

    .line 391
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    sget v4, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    int-to-float v5, p0

    const/high16 v6, 0x42400000    # 48.0f

    div-float/2addr v5, v6

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v3

    .line 392
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v0

    .line 393
    if-nez v0, :cond_3

    move-object v0, v1

    goto :goto_0

    .line 394
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aput v3, v1, p0

    .line 395
    aput-object v0, v2, p0

    goto :goto_0
.end method

.method static preview(Landroid/widget/TextView;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 345
    if-nez p0, :cond_1

    .line 351
    :cond_0
    :goto_0
    return-void

    .line 346
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 349
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    ushr-int/lit8 v0, v0, 0x18

    if-eqz v0, :cond_0

    .line 350
    const/high16 v0, 0x40c00000    # 6.0f

    invoke-static {p0}, Lcom/mrkeyboard/app/MrGlow;->density(Landroid/view/View;)F

    move-result v1

    mul-float/2addr v0, v1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    invoke-virtual {p0, v0, v2, v2, v1}, Landroid/widget/TextView;->setShadowLayer(FFFI)V

    goto :goto_0
.end method

.method static ramp(IIIF)I
    .locals 10

    .prologue
    const/4 v9, 0x0

    const/4 v8, 0x2

    const/4 v7, 0x1

    const/4 v6, 0x0

    const/high16 v5, 0x43b40000    # 360.0f

    .line 365
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p3, v9, v0}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v0

    .line 366
    const/4 v1, 0x3

    new-array v2, v1, [F

    const/4 v1, 0x3

    new-array v3, v1, [F

    .line 368
    const/high16 v1, 0x3f000000    # 0.5f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_4

    .line 369
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 370
    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 371
    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    .line 377
    :goto_0
    aget v1, v3, v6

    aget v4, v2, v6

    sub-float/2addr v1, v4

    .line 378
    const/high16 v4, 0x43340000    # 180.0f

    cmpl-float v4, v1, v4

    if-lez v4, :cond_0

    sub-float/2addr v1, v5

    .line 379
    :cond_0
    const/high16 v4, -0x3ccc0000    # -180.0f

    cmpg-float v4, v1, v4

    if-gez v4, :cond_1

    add-float/2addr v1, v5

    .line 380
    :cond_1
    aget v4, v2, v6

    mul-float/2addr v1, v0

    add-float/2addr v1, v4

    .line 381
    cmpg-float v4, v1, v9

    if-gez v4, :cond_2

    add-float/2addr v1, v5

    .line 382
    :cond_2
    cmpl-float v4, v1, v5

    if-ltz v4, :cond_3

    sub-float/2addr v1, v5

    .line 383
    :cond_3
    aget v4, v2, v7

    aget v5, v3, v7

    aget v6, v2, v7

    sub-float/2addr v5, v6

    mul-float/2addr v5, v0

    add-float/2addr v4, v5

    aget v5, v2, v8

    aget v3, v3, v8

    aget v2, v2, v8

    sub-float v2, v3, v2

    mul-float/2addr v0, v2

    add-float/2addr v0, v5

    invoke-static {v1, v4, v0}, Lcom/mrkeyboard/app/MrGlow;->rgb(FFF)I

    move-result v0

    return v0

    .line 373
    :cond_4
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 374
    invoke-static {p2, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 375
    const/high16 v1, 0x3f000000    # 0.5f

    sub-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    goto :goto_0
.end method

.method static remap(II)[F
    .locals 20

    .prologue
    .line 437
    shr-int/lit8 v1, p0, 0x10

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    const/high16 v2, 0x437f0000    # 255.0f

    div-float/2addr v1, v2

    shr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    int-to-float v2, v2

    const/high16 v3, 0x437f0000    # 255.0f

    div-float/2addr v2, v3

    move/from16 v0, p0

    and-int/lit16 v3, v0, 0xff

    int-to-float v3, v3

    const/high16 v4, 0x437f0000    # 255.0f

    div-float/2addr v3, v4

    .line 438
    shr-int/lit8 v4, p1, 0x10

    and-int/lit16 v4, v4, 0xff

    int-to-float v4, v4

    const/high16 v5, 0x437f0000    # 255.0f

    div-float/2addr v4, v5

    shr-int/lit8 v5, p1, 0x8

    and-int/lit16 v5, v5, 0xff

    int-to-float v5, v5

    const/high16 v6, 0x437f0000    # 255.0f

    div-float/2addr v5, v6

    move/from16 v0, p1

    and-int/lit16 v6, v0, 0xff

    int-to-float v6, v6

    const/high16 v7, 0x437f0000    # 255.0f

    div-float/2addr v6, v7

    .line 440
    sub-float v7, v2, v3

    sub-float v8, v3, v1

    sub-float v9, v1, v2

    .line 442
    sub-float v10, v9, v8

    sub-float v11, v7, v9

    sub-float v12, v8, v7

    .line 443
    mul-float v13, v1, v10

    mul-float v14, v2, v11

    add-float/2addr v13, v14

    mul-float v14, v3, v12

    add-float/2addr v13, v14

    .line 444
    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    move-result v14

    const v15, 0x38d1b717    # 1.0E-4f

    cmpg-float v14, v14, v15

    if-gez v14, :cond_0

    const/4 v1, 0x0

    .line 449
    :goto_0
    return-object v1

    .line 445
    :cond_0
    div-float/2addr v10, v13

    div-float/2addr v11, v13

    div-float/2addr v12, v13

    .line 446
    mul-float v14, v3, v8

    mul-float v15, v2, v9

    sub-float/2addr v14, v15

    div-float/2addr v14, v13

    mul-float v15, v1, v9

    mul-float v16, v3, v7

    sub-float v15, v15, v16

    div-float/2addr v15, v13

    mul-float v16, v2, v7

    mul-float v17, v1, v8

    sub-float v16, v16, v17

    div-float v16, v16, v13

    .line 447
    sub-float v17, v2, v3

    div-float v17, v17, v13

    sub-float/2addr v3, v1

    div-float/2addr v3, v13

    sub-float/2addr v1, v2

    div-float v2, v1, v13

    .line 449
    const/16 v1, 0x9

    new-array v1, v1, [F

    const/4 v13, 0x0

    mul-float v18, v4, v10

    add-float v18, v18, v14

    mul-float v19, v7, v17

    add-float v18, v18, v19

    aput v18, v1, v13

    const/4 v13, 0x1

    mul-float v18, v4, v11

    add-float v18, v18, v15

    mul-float v19, v7, v3

    add-float v18, v18, v19

    aput v18, v1, v13

    const/4 v13, 0x2

    mul-float/2addr v4, v12

    add-float v4, v4, v16

    mul-float/2addr v7, v2

    add-float/2addr v4, v7

    aput v4, v1, v13

    const/4 v4, 0x3

    mul-float v7, v5, v10

    add-float/2addr v7, v14

    mul-float v13, v8, v17

    add-float/2addr v7, v13

    aput v7, v1, v4

    const/4 v4, 0x4

    mul-float v7, v5, v11

    add-float/2addr v7, v15

    mul-float v13, v8, v3

    add-float/2addr v7, v13

    aput v7, v1, v4

    const/4 v4, 0x5

    mul-float/2addr v5, v12

    add-float v5, v5, v16

    mul-float v7, v8, v2

    add-float/2addr v5, v7

    aput v5, v1, v4

    const/4 v4, 0x6

    mul-float v5, v6, v10

    add-float/2addr v5, v14

    mul-float v7, v9, v17

    add-float/2addr v5, v7

    aput v5, v1, v4

    const/4 v4, 0x7

    mul-float v5, v6, v11

    add-float/2addr v5, v15

    mul-float/2addr v3, v9

    add-float/2addr v3, v5

    aput v3, v1, v4

    const/16 v3, 0x8

    mul-float v4, v6, v12

    add-float v4, v4, v16

    mul-float/2addr v2, v9

    add-float/2addr v2, v4

    aput v2, v1, v3

    goto :goto_0
.end method

.method static reset()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, -0x1

    const/4 v1, 0x0

    .line 142
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 143
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    .line 144
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 145
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 146
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sText:I

    .line 147
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 148
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 149
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 150
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 151
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 152
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 153
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 154
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 155
    return-void
.end method

.method static rgb(FFF)I
    .locals 8

    .prologue
    const/high16 v6, 0x40000000    # 2.0f

    const/high16 v5, 0x437f0000    # 255.0f

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v0, 0x0

    .line 514
    mul-float v2, p2, p1

    .line 515
    const/high16 v1, 0x43b40000    # 360.0f

    rem-float v1, p0, v1

    const/high16 v3, 0x42700000    # 60.0f

    div-float v3, v1, v3

    .line 516
    rem-float v1, v3, v6

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    sub-float v1, v4, v1

    mul-float/2addr v1, v2

    .line 518
    cmpg-float v4, v3, v4

    if-gez v4, :cond_0

    move v3, v2

    .line 524
    :goto_0
    sub-float v2, p2, v2

    .line 525
    const/high16 v4, -0x1000000

    add-float/2addr v3, v2

    mul-float/2addr v3, v5

    invoke-static {v3}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v3

    shl-int/lit8 v3, v3, 0x10

    or-int/2addr v3, v4

    add-float/2addr v1, v2

    mul-float/2addr v1, v5

    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v1

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v1, v3

    add-float/2addr v0, v2

    mul-float/2addr v0, v5

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v0

    or-int/2addr v0, v1

    return v0

    .line 519
    :cond_0
    cmpg-float v4, v3, v6

    if-gez v4, :cond_1

    move v3, v1

    move v1, v2

    goto :goto_0

    .line 520
    :cond_1
    const/high16 v4, 0x40400000    # 3.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_2

    move v3, v0

    move v0, v1

    move v1, v2

    goto :goto_0

    .line 521
    :cond_2
    const/high16 v4, 0x40800000    # 4.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_3

    move v3, v0

    move v0, v2

    goto :goto_0

    .line 522
    :cond_3
    const/high16 v4, 0x40a00000    # 5.0f

    cmpg-float v3, v3, v4

    if-gez v3, :cond_4

    move v3, v1

    move v1, v0

    move v0, v2

    goto :goto_0

    :cond_4
    move v3, v2

    move v7, v0

    move v0, v1

    move v1, v7

    .line 523
    goto :goto_0
.end method

.method static scale(IF)I
    .locals 2

    .prologue
    .line 488
    ushr-int/lit8 v0, p0, 0x18

    int-to-float v0, v0

    const/4 v1, 0x0

    invoke-static {v1, p1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 489
    const/16 v1, 0xff

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method private static splitFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)Z
    .locals 4

    .prologue
    const/4 v1, 0x0

    .line 247
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 248
    instance-of v2, v0, Landroid/graphics/drawable/LayerDrawable;

    if-nez v2, :cond_0

    move v0, v1

    .line 254
    :goto_0
    return v0

    .line 249
    :cond_0
    check-cast v0, Landroid/graphics/drawable/LayerDrawable;

    .line 250
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v2

    .line 251
    const/4 v3, 0x2

    if-ge v2, v3, :cond_1

    move v0, v1

    goto :goto_0

    .line 252
    :cond_1
    add-int/lit8 v1, v2, -0x2

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 253
    add-int/lit8 v1, v2, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 254
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static step(FFII)I
    .locals 5

    .prologue
    const/16 v1, 0x30

    const/4 v0, 0x0

    .line 357
    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 360
    :cond_0
    :goto_0
    return v0

    .line 358
    :cond_1
    int-to-float v2, p2

    div-float v2, p0, v2

    const v3, 0x3f47ae14    # 0.78f

    mul-float/2addr v2, v3

    int-to-float v3, p3

    div-float v3, p1, v3

    const v4, 0x3e6147ae    # 0.22f

    mul-float/2addr v3, v4

    add-float/2addr v2, v3

    .line 359
    const/4 v3, 0x0

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v2

    const/high16 v3, 0x42400000    # 48.0f

    mul-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 360
    if-ltz v2, :cond_0

    if-le v2, v1, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    move v0, v2

    goto :goto_0
.end method

.method private static sync()Z
    .locals 2

    .prologue
    .line 89
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->tuning()V

    .line 90
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->glow()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 93
    :goto_0
    return v0

    .line 91
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v0

    .line 92
    if-nez v0, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    if-eqz v1, :cond_1

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 93
    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    .line 92
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1
.end method

.method private static tuning()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 98
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v1

    .line 99
    invoke-static {}, Lcom/mrkeyboard/app/MrKeyLook;->version()I

    move-result v0

    .line 100
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    if-ne v0, v2, :cond_2

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    if-nez v2, :cond_2

    .line 110
    :cond_0
    :goto_0
    return-void

    .line 100
    :cond_1
    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 101
    :cond_2
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    .line 102
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 103
    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v2

    .line 104
    if-eqz v2, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 105
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    .line 106
    if-eqz v2, :cond_4

    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const v2, 0xffffff

    and-int/2addr v0, v2

    :goto_2
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 107
    sput-object v3, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 108
    sput-object v3, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 109
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sput-object v3, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    goto :goto_0

    .line 104
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_1

    .line 106
    :cond_4
    const/4 v0, -0x1

    goto :goto_2
.end method
