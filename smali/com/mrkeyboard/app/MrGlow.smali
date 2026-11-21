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

.field private static sHidden:Landroid/graphics/ColorFilter;

.field private static sHue:[I

.field private static sIconGlowColor:I

.field private static sIconGlowFilter:Landroid/graphics/ColorFilter;

.field private static sInk:I

.field private static sInkFilter:Landroid/graphics/ColorFilter;

.field private static sInkFilterColor:I

.field private static sKeyGlow:I

.field private static final sLinePaint:Landroid/graphics/Paint;

.field private static final sLineRect:Landroid/graphics/RectF;

.field private static sLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private static sLookTag:Ljava/lang/String;

.field private static sLookVersion:I

.field private static sMatrix:[[F

.field private static sMid:I

.field private static sOverOff:I

.field private static sPopup:Z

.field private static sSpectrum:Z

.field private static sStart:I

.field private static sStep:I

.field private static sTag:Ljava/lang/String;

.field private static sText:I

.field private static sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, -0x1

    .line 72
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 73
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 75
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 76
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 82
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 84
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 316
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    .line 317
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bloom(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 383
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 384
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-nez p4, :cond_1

    .line 390
    :cond_0
    :goto_0
    return-void

    .line 385
    :cond_1
    invoke-virtual {p4}, Landroid/graphics/Paint;->getTextSize()F

    move-result v1

    .line 386
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 387
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

    .line 388
    invoke-virtual {p0, p1, p2, p3, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 389
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

    .line 603
    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 604
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
    .line 587
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

    .line 432
    if-nez p0, :cond_1

    .line 451
    :cond_0
    :goto_0
    return-void

    .line 433
    :cond_1
    invoke-virtual {p0}, Landroid/graphics/Paint;->getColor()I

    move-result v4

    .line 435
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    if-ltz v0, :cond_2

    and-int v0, v4, v7

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    if-ne v0, v3, :cond_2

    move v0, v1

    .line 436
    :goto_1
    sget v3, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    if-nez v3, :cond_3

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-gez v3, :cond_3

    .line 437
    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    .line 438
    if-eqz v0, :cond_0

    invoke-static {v4}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 435
    goto :goto_1

    .line 441
    :cond_3
    and-int v3, v4, v7

    sget v5, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    and-int/2addr v5, v7

    if-ne v3, v5, :cond_6

    move v3, v1

    .line 442
    :goto_2
    and-int v5, v4, v7

    sget v6, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    and-int/2addr v6, v7

    if-ne v5, v6, :cond_7

    .line 443
    :goto_3
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-ltz v2, :cond_a

    if-nez v1, :cond_a

    .line 444
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    aget-object v1, v1, v2

    invoke-static {v1, v4}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v1

    .line 445
    if-nez v3, :cond_4

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    invoke-virtual {v2, v1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->ink(I)I

    move-result v1

    .line 447
    :cond_4
    :goto_4
    if-eqz v0, :cond_9

    invoke-static {v1}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    .line 448
    :goto_5
    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 449
    if-nez v3, :cond_5

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    if-nez v1, :cond_8

    :cond_5
    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_0

    :cond_6
    move v3, v2

    .line 441
    goto :goto_2

    :cond_7
    move v1, v2

    .line 442
    goto :goto_3

    .line 450
    :cond_8
    const/high16 v1, 0x40400000    # 3.0f

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {p0, v1, v8, v8, v0}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    goto :goto_0

    :cond_9
    move v0, v1

    goto :goto_5

    :cond_a
    move v1, v4

    goto :goto_4
.end method

.method private static density(Landroid/view/View;)F
    .locals 2

    .prologue
    .line 579
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 580
    const/4 v1, 0x0

    cmpl-float v1, v0, v1

    if-lez v1, :cond_0

    .line 582
    :goto_0
    return v0

    .line 580
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0

    .line 581
    :catch_0
    move-exception v0

    .line 582
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    goto :goto_0
.end method

.method static drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)V
    .locals 10

    .prologue
    .line 288
    const/4 v7, 0x0

    const/4 v8, 0x0

    const/high16 v9, 0x3f800000    # 1.0f

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object/from16 v6, p6

    invoke-static/range {v0 .. v9}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;IFF)V

    .line 289
    return-void
.end method

.method static drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;IFF)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 298
    if-nez p0, :cond_0

    .line 299
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 313
    :goto_0
    return-void

    .line 302
    :cond_0
    if-eqz p5, :cond_5

    .line 303
    if-eqz p6, :cond_2

    if-eqz p7, :cond_1

    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->hidden()Landroid/graphics/ColorFilter;

    move-result-object p6

    :cond_1
    invoke-static {p0, p5, p6}, Lcom/mrkeyboard/app/MrGlow;->splitFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)Z

    move-result v0

    if-nez v0, :cond_3

    :cond_2
    invoke-virtual {p0, p5}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 308
    :cond_3
    :goto_1
    :try_start_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 309
    if-eqz p7, :cond_4

    invoke-static {p0, p1, p7, p8, p9}, Lcom/mrkeyboard/app/MrGlow;->strokeFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IFF)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 311
    :cond_4
    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_0

    .line 304
    :cond_5
    if-eqz p4, :cond_3

    .line 305
    invoke-virtual {p0, p4}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_1

    .line 311
    :catchall_0
    move-exception v0

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 312
    throw v0
.end method

.method static drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    .locals 11

    .prologue
    const/4 v5, 0x0

    .line 253
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sPopup:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    .line 256
    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->popupFilter()Landroid/graphics/PorterDuffColorFilter;

    move-result-object v0

    .line 257
    if-eqz v0, :cond_0

    .line 258
    invoke-virtual {p0, v0}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 260
    :try_start_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 262
    invoke-virtual {p0, v5}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 280
    :goto_0
    return-void

    .line 262
    :catchall_0
    move-exception v0

    invoke-virtual {p0, v5}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 263
    throw v0

    .line 267
    :cond_0
    sget v1, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 268
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKeyLook;->faceTuned()Z

    move-result v2

    .line 269
    if-eqz p0, :cond_1

    if-gez v1, :cond_1

    if-nez v2, :cond_1

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-object v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F

    if-eqz v0, :cond_1

    .line 271
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrAdapt$Tone;->seeFilter()Landroid/graphics/ColorFilter;

    move-result-object v4

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move-object v6, v5

    invoke-static/range {v0 .. v6}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)V

    goto :goto_0

    .line 274
    :cond_1
    if-eqz p0, :cond_2

    if-gez v1, :cond_3

    if-nez v2, :cond_3

    .line 275
    :cond_2
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 278
    :cond_3
    if-gez v1, :cond_4

    move-object v4, v5

    :goto_1
    if-eqz v2, :cond_5

    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->fillFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v0

    move-object v10, v0

    :goto_2
    if-eqz v2, :cond_6

    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->edgeFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v6

    .line 279
    :goto_3
    if-eqz v2, :cond_7

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v7, v0, Lcom/mrkeyboard/app/MrKeyLook;->line:I

    :goto_4
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v0}, Lcom/mrkeyboard/app/MrKeyLook;->lineAlpha()F

    move-result v8

    sget v9, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v3, p3

    move-object v5, v10

    .line 278
    invoke-static/range {v0 .. v9}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;IFF)V

    goto :goto_0

    :cond_4
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->faceFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v4

    goto :goto_1

    :cond_5
    move-object v10, v5

    goto :goto_2

    :cond_6
    move-object v6, v5

    goto :goto_3

    .line 279
    :cond_7
    const/4 v7, 0x0

    goto :goto_4
.end method

.method static edge(Landroid/graphics/Paint;)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 398
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 399
    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 402
    :cond_0
    :goto_0
    return-void

    .line 400
    :cond_1
    sget v1, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 401
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
    .line 372
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    if-nez v0, :cond_0

    const/16 v0, 0x32

    new-array v0, v0, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 373
    :cond_0
    if-gez p0, :cond_2

    const/16 v0, 0x31

    .line 374
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    aget-object v1, v1, v0

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    if-gez p0, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F

    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v1

    aput-object v1, v2, v0

    .line 375
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v1, v0

    return-object v0

    :cond_2
    move v0, p0

    .line 373
    goto :goto_0

    .line 374
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v1, v1, p0

    goto :goto_1
.end method

.method private static faceFilter(I)Landroid/graphics/ColorFilter;
    .locals 2

    .prologue
    .line 511
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v0, p0

    .line 512
    if-nez v0, :cond_0

    .line 513
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v0, v0, p0

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->filter([F)Landroid/graphics/ColorFilter;

    move-result-object v0

    .line 514
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aput-object v0, v1, p0

    .line 516
    :cond_0
    return-object v0
.end method

.method static fade(IF)I
    .locals 3

    .prologue
    .line 592
    ushr-int/lit8 v0, p0, 0x18

    int-to-float v0, v0

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {p1, v1, v2}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 593
    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method private static fillFilter(I)Landroid/graphics/ColorFilter;
    .locals 5

    .prologue
    .line 365
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    if-nez v0, :cond_0

    const/16 v0, 0x32

    new-array v0, v0, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 366
    :cond_0
    if-gez p0, :cond_2

    const/16 v0, 0x31

    .line 367
    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    aget-object v1, v1, v0

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    if-gez p0, :cond_3

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-object v1, v1, Lcom/mrkeyboard/app/MrAdapt$Tone;->see:[F

    :goto_1
    sget-object v3, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v3, v3

    const/high16 v4, 0x42c80000    # 100.0f

    div-float/2addr v3, v4

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v1

    aput-object v1, v2, v0

    .line 368
    :cond_1
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v1, v0

    return-object v0

    :cond_2
    move v0, p0

    .line 366
    goto :goto_0

    .line 367
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v1, v1, p0

    goto :goto_1
.end method

.method static filter([F)Landroid/graphics/ColorFilter;
    .locals 1

    .prologue
    .line 521
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

    .line 526
    if-nez p0, :cond_0

    .line 527
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

    .line 533
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

.method private static hidden()Landroid/graphics/ColorFilter;
    .locals 2

    .prologue
    .line 321
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sHidden:Landroid/graphics/ColorFilter;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v0

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sHidden:Landroid/graphics/ColorFilter;

    .line 322
    :cond_0
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sHidden:Landroid/graphics/ColorFilter;

    return-object v0
.end method

.method static hint(Landroid/graphics/Paint;I)V
    .locals 2

    .prologue
    .line 237
    if-nez p0, :cond_0

    .line 245
    :goto_0
    return-void

    .line 238
    :cond_0
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    if-eqz v0, :cond_1

    .line 239
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    const v1, 0x3f333333    # 0.7f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    .line 242
    :cond_1
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-ltz v0, :cond_3

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    aget-object v0, v0, v1

    invoke-static {v0, p1}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result p1

    .line 244
    :cond_2
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    invoke-virtual {v0, p1}, Lcom/mrkeyboard/app/MrAdapt$Tone;->ink(I)I

    move-result v0

    invoke-virtual {p0, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    .line 243
    :cond_3
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-nez v0, :cond_2

    goto :goto_0
.end method

.method static hsv(I[F)V
    .locals 8

    .prologue
    const/high16 v4, 0x437f0000    # 255.0f

    const/high16 v7, 0x42700000    # 60.0f

    const/4 v1, 0x0

    .line 609
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

    .line 610
    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v5

    invoke-static {v0, v5}, Ljava/lang/Math;->min(FF)F

    move-result v5

    .line 611
    sub-float v5, v4, v5

    .line 612
    cmpg-float v6, v5, v1

    if-gtz v6, :cond_1

    move v0, v1

    .line 616
    :goto_0
    cmpg-float v2, v0, v1

    if-gez v2, :cond_0

    const/high16 v2, 0x43b40000    # 360.0f

    add-float/2addr v0, v2

    .line 617
    :cond_0
    const/4 v2, 0x0

    aput v0, p1, v2

    .line 618
    const/4 v2, 0x1

    cmpg-float v0, v4, v1

    if-gtz v0, :cond_4

    move v0, v1

    :goto_1
    aput v0, p1, v2

    .line 619
    const/4 v0, 0x2

    aput v4, p1, v0

    .line 620
    return-void

    .line 613
    :cond_1
    cmpl-float v6, v4, v0

    if-nez v6, :cond_2

    sub-float v0, v2, v3

    div-float/2addr v0, v5

    const/high16 v2, 0x40c00000    # 6.0f

    rem-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 614
    :cond_2
    cmpl-float v6, v4, v2

    if-nez v6, :cond_3

    sub-float v0, v3, v0

    div-float/2addr v0, v5

    const/high16 v2, 0x40000000    # 2.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 615
    :cond_3
    sub-float/2addr v0, v2

    div-float/2addr v0, v5

    const/high16 v2, 0x40800000    # 4.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 618
    :cond_4
    div-float v0, v5, v4

    goto :goto_1
.end method

.method static icon(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V
    .locals 3

    .prologue
    .line 406
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 407
    if-nez v0, :cond_0

    .line 413
    :goto_0
    return-void

    .line 408
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    if-eq v1, v0, :cond_2

    .line 409
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    .line 410
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 412
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
    .line 417
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 418
    if-nez v0, :cond_0

    .line 423
    :goto_0
    return-object p0

    .line 419
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    if-eq v1, v0, :cond_2

    .line 420
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    .line 421
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 423
    :cond_2
    sget-object p0, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    goto :goto_0
.end method

.method static key(Landroid/view/View;Lcom/mrkeyboard/app/Keyboard$Key;ZLandroid/graphics/Paint;)V
    .locals 6

    .prologue
    const/4 v1, 0x1

    const/high16 v5, 0x3f000000    # 0.5f

    const/4 v2, 0x0

    .line 194
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 195
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 196
    if-eqz p0, :cond_2

    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_2

    move v0, v1

    :goto_0
    sput-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sPopup:Z

    .line 197
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-nez v0, :cond_3

    .line 198
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 218
    :cond_0
    :goto_1
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    if-eqz v0, :cond_8

    .line 219
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 220
    if-eqz p3, :cond_1

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 229
    :cond_1
    :goto_2
    return-void

    :cond_2
    move v0, v2

    .line 196
    goto :goto_0

    .line 200
    :cond_3
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGlow;->density(Landroid/view/View;)F

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 201
    if-eqz p2, :cond_6

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    :goto_3
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 202
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    ushr-int/lit8 v0, v0, 0x18

    if-eqz v0, :cond_7

    .line 203
    :goto_4
    if-nez v1, :cond_4

    sput v2, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 204
    :cond_4
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 205
    iget v0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    int-to-float v0, v0

    iget v3, p1, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v3, v3

    mul-float/2addr v3, v5

    add-float/2addr v0, v3

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

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->step(FFII)I

    move-result v0

    .line 206
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->matrix(I)[F

    move-result-object v3

    .line 207
    if-eqz v3, :cond_0

    .line 208
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 209
    if-eqz v1, :cond_5

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    const/high16 v2, -0x1000000

    and-int/2addr v1, v2

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aget v0, v2, v0

    const v2, 0xffffff

    and-int/2addr v0, v2

    or-int v2, v1, v0

    :cond_5
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 210
    if-eqz p3, :cond_0

    .line 211
    invoke-virtual {p3}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 212
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_1

    .line 201
    :cond_6
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    goto :goto_3

    :cond_7
    move v1, v2

    .line 202
    goto :goto_4

    .line 221
    :cond_8
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-eqz v0, :cond_1

    if-eqz p3, :cond_1

    .line 223
    invoke-virtual {p3}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrAdapt$Tone;->ink(I)I

    move-result v1

    .line 224
    if-eq v1, v0, :cond_1

    .line 225
    invoke-virtual {p3, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 226
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    goto/16 :goto_2
.end method

.method private static load(Ljava/lang/String;)V
    .locals 3

    .prologue
    const/16 v2, 0x31

    const/4 v1, 0x0

    .line 124
    sput-object p0, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 125
    const-string v0, "glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    .line 126
    const-string v0, "accent_glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    .line 127
    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    .line 128
    const-string v0, "modifier_indicator_lock"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    .line 129
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->spectrum()Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    .line 130
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 131
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 132
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 133
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 134
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 135
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v0, :cond_1

    .line 136
    const-string v0, "spectrum_start"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    .line 137
    const-string v0, "spectrum_mid"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    .line 138
    const-string v0, "spectrum_end"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    .line 139
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v0

    .line 140
    if-eqz v0, :cond_0

    .line 141
    const/4 v1, 0x0

    aget v1, v0, v1

    sput v1, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    .line 142
    const/4 v1, 0x1

    aget v1, v0, v1

    sput v1, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    .line 143
    const/4 v1, 0x2

    aget v0, v0, v1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    .line 145
    :cond_0
    new-array v0, v2, [[F

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 146
    new-array v0, v2, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 147
    new-array v0, v2, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 149
    :cond_1
    return-void
.end method

.method static map([FI)I
    .locals 6

    .prologue
    .line 567
    if-nez p0, :cond_0

    .line 569
    :goto_0
    return p1

    .line 568
    :cond_0
    shr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    shr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    and-int/lit16 v2, p1, 0xff

    int-to-float v2, v2

    .line 569
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

    .line 570
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

    .line 571
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

    .line 572
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v0

    or-int p1, v3, v0

    .line 569
    goto :goto_0
.end method

.method private static matrix(I)[F
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 497
    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 498
    if-eqz v2, :cond_0

    if-ltz p0, :cond_0

    const/16 v0, 0x30

    if-le p0, v0, :cond_2

    :cond_0
    move-object v0, v1

    .line 507
    :cond_1
    :goto_0
    return-object v0

    .line 499
    :cond_2
    aget-object v0, v2, p0

    .line 500
    if-nez v0, :cond_1

    .line 501
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    sget v4, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    int-to-float v5, p0

    const/high16 v6, 0x42400000    # 48.0f

    div-float/2addr v5, v6

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v3

    .line 502
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v0

    .line 503
    if-nez v0, :cond_3

    move-object v0, v1

    goto :goto_0

    .line 504
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aput v3, v1, p0

    .line 505
    aput-object v0, v2, p0

    goto :goto_0
.end method

.method static preview(Landroid/widget/TextView;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 455
    if-nez p0, :cond_1

    .line 461
    :cond_0
    :goto_0
    return-void

    .line 456
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 459
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    ushr-int/lit8 v0, v0, 0x18

    if-eqz v0, :cond_0

    .line 460
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

    .line 475
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p3, v9, v0}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v0

    .line 476
    const/4 v1, 0x3

    new-array v2, v1, [F

    const/4 v1, 0x3

    new-array v3, v1, [F

    .line 478
    const/high16 v1, 0x3f000000    # 0.5f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_4

    .line 479
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 480
    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 481
    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    .line 487
    :goto_0
    aget v1, v3, v6

    aget v4, v2, v6

    sub-float/2addr v1, v4

    .line 488
    const/high16 v4, 0x43340000    # 180.0f

    cmpl-float v4, v1, v4

    if-lez v4, :cond_0

    sub-float/2addr v1, v5

    .line 489
    :cond_0
    const/high16 v4, -0x3ccc0000    # -180.0f

    cmpg-float v4, v1, v4

    if-gez v4, :cond_1

    add-float/2addr v1, v5

    .line 490
    :cond_1
    aget v4, v2, v6

    mul-float/2addr v1, v0

    add-float/2addr v1, v4

    .line 491
    cmpg-float v4, v1, v9

    if-gez v4, :cond_2

    add-float/2addr v1, v5

    .line 492
    :cond_2
    cmpl-float v4, v1, v5

    if-ltz v4, :cond_3

    sub-float/2addr v1, v5

    .line 493
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

    .line 483
    :cond_4
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 484
    invoke-static {p2, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 485
    const/high16 v1, 0x3f000000    # 0.5f

    sub-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    goto :goto_0
.end method

.method static remap(II)[F
    .locals 20

    .prologue
    .line 547
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

    .line 548
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

    .line 550
    sub-float v7, v2, v3

    sub-float v8, v3, v1

    sub-float v9, v1, v2

    .line 552
    sub-float v10, v9, v8

    sub-float v11, v7, v9

    sub-float v12, v8, v7

    .line 553
    mul-float v13, v1, v10

    mul-float v14, v2, v11

    add-float/2addr v13, v14

    mul-float v14, v3, v12

    add-float/2addr v13, v14

    .line 554
    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    move-result v14

    const v15, 0x38d1b717    # 1.0E-4f

    cmpg-float v14, v14, v15

    if-gez v14, :cond_0

    const/4 v1, 0x0

    .line 559
    :goto_0
    return-object v1

    .line 555
    :cond_0
    div-float/2addr v10, v13

    div-float/2addr v11, v13

    div-float/2addr v12, v13

    .line 556
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

    .line 557
    sub-float v17, v2, v3

    div-float v17, v17, v13

    sub-float/2addr v3, v1

    div-float/2addr v3, v13

    sub-float/2addr v1, v2

    div-float v2, v1, v13

    .line 559
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
    const/4 v3, -0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 170
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 171
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    .line 172
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 173
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 174
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sText:I

    .line 175
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 176
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 177
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 178
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 179
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 180
    sput v3, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 181
    sput v2, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 182
    sput-boolean v2, Lcom/mrkeyboard/app/MrGlow;->sPopup:Z

    .line 183
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 184
    invoke-static {v1}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 185
    return-void
.end method

.method static rgb(FFF)I
    .locals 8

    .prologue
    const/high16 v6, 0x40000000    # 2.0f

    const/high16 v5, 0x437f0000    # 255.0f

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v0, 0x0

    .line 624
    mul-float v2, p2, p1

    .line 625
    const/high16 v1, 0x43b40000    # 360.0f

    rem-float v1, p0, v1

    const/high16 v3, 0x42700000    # 60.0f

    div-float v3, v1, v3

    .line 626
    rem-float v1, v3, v6

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    sub-float v1, v4, v1

    mul-float/2addr v1, v2

    .line 628
    cmpg-float v4, v3, v4

    if-gez v4, :cond_0

    move v3, v2

    .line 634
    :goto_0
    sub-float v2, p2, v2

    .line 635
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

    .line 629
    :cond_0
    cmpg-float v4, v3, v6

    if-gez v4, :cond_1

    move v3, v1

    move v1, v2

    goto :goto_0

    .line 630
    :cond_1
    const/high16 v4, 0x40400000    # 3.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_2

    move v3, v0

    move v0, v1

    move v1, v2

    goto :goto_0

    .line 631
    :cond_2
    const/high16 v4, 0x40800000    # 4.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_3

    move v3, v0

    move v0, v2

    goto :goto_0

    .line 632
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

    .line 633
    goto :goto_0
.end method

.method static scale(IF)I
    .locals 2

    .prologue
    .line 598
    ushr-int/lit8 v0, p0, 0x18

    int-to-float v0, v0

    const/4 v1, 0x0

    invoke-static {v1, p1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 599
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

    .line 354
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 355
    instance-of v2, v0, Landroid/graphics/drawable/LayerDrawable;

    if-nez v2, :cond_0

    move v0, v1

    .line 361
    :goto_0
    return v0

    .line 356
    :cond_0
    check-cast v0, Landroid/graphics/drawable/LayerDrawable;

    .line 357
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v2

    .line 358
    const/4 v3, 0x2

    if-ge v2, v3, :cond_1

    move v0, v1

    goto :goto_0

    .line 359
    :cond_1
    add-int/lit8 v1, v2, -0x2

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 360
    add-int/lit8 v1, v2, -0x1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    invoke-virtual {v0, p2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 361
    const/4 v0, 0x1

    goto :goto_0
.end method

.method static step(FFII)I
    .locals 5

    .prologue
    const/16 v1, 0x30

    const/4 v0, 0x0

    .line 467
    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 470
    :cond_0
    :goto_0
    return v0

    .line 468
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

    .line 469
    const/4 v3, 0x0

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v2

    const/high16 v3, 0x42400000    # 48.0f

    mul-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 470
    if-ltz v2, :cond_0

    if-le v2, v1, :cond_2

    move v0, v1

    goto :goto_0

    :cond_2
    move v0, v2

    goto :goto_0
.end method

.method private static strokeFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IFF)V
    .locals 11

    .prologue
    const/high16 v10, 0x3f800000    # 1.0f

    const/4 v2, 0x0

    const/high16 v9, 0x40000000    # 2.0f

    .line 330
    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 331
    instance-of v1, v0, Landroid/graphics/drawable/LayerDrawable;

    if-eqz v1, :cond_2

    .line 332
    check-cast v0, Landroid/graphics/drawable/LayerDrawable;

    .line 333
    invoke-virtual {v0}, Landroid/graphics/drawable/LayerDrawable;->getNumberOfLayers()I

    move-result v1

    .line 334
    if-nez v1, :cond_1

    .line 350
    :cond_0
    :goto_0
    return-void

    .line 335
    :cond_1
    const/4 v3, 0x2

    if-lt v1, v3, :cond_4

    add-int/lit8 v1, v1, -0x2

    :goto_1
    invoke-virtual {v0, v1}, Landroid/graphics/drawable/LayerDrawable;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    .line 337
    :cond_2
    if-eqz v0, :cond_0

    .line 338
    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    .line 339
    invoke-static {v10, p4}, Ljava/lang/Math;->max(FF)F

    move-result v3

    .line 340
    sget-object v4, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    iget v5, v1, Landroid/graphics/Rect;->left:I

    int-to-float v5, v5

    div-float v6, v3, v9

    add-float/2addr v5, v6

    iget v6, v1, Landroid/graphics/Rect;->top:I

    int-to-float v6, v6

    div-float v7, v3, v9

    add-float/2addr v6, v7

    iget v7, v1, Landroid/graphics/Rect;->right:I

    int-to-float v7, v7

    div-float v8, v3, v9

    sub-float/2addr v7, v8

    iget v1, v1, Landroid/graphics/Rect;->bottom:I

    int-to-float v1, v1

    div-float v8, v3, v9

    sub-float/2addr v1, v8

    invoke-virtual {v4, v5, v6, v7, v1}, Landroid/graphics/RectF;->set(FFFF)V

    .line 341
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->width()F

    move-result v1

    cmpg-float v1, v1, v3

    if-lez v1, :cond_0

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    invoke-virtual {v1}, Landroid/graphics/RectF;->height()F

    move-result v1

    cmpg-float v1, v1, v3

    if-lez v1, :cond_0

    .line 342
    instance-of v1, v0, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v1, :cond_5

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/GradientDrawable;->getCornerRadius()F

    move-result v0

    .line 343
    :goto_2
    cmpg-float v1, v0, v2

    if-gtz v1, :cond_3

    const/high16 v0, 0x41000000    # 8.0f

    mul-float/2addr v0, p4

    .line 344
    :cond_3
    div-float v1, v3, v9

    sub-float/2addr v0, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v5

    .line 345
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 346
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 347
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 348
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    invoke-static {p3, v2, v10}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    const/high16 v2, 0x437f0000    # 255.0f

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    shl-int/lit8 v1, v1, 0x18

    const v2, 0xffffff

    and-int/2addr v2, p2

    or-int/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 349
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    iget v1, v0, Landroid/graphics/RectF;->left:F

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    iget v2, v0, Landroid/graphics/RectF;->top:F

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    iget v3, v0, Landroid/graphics/RectF;->right:F

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLineRect:Landroid/graphics/RectF;

    iget v4, v0, Landroid/graphics/RectF;->bottom:F

    sget-object v7, Lcom/mrkeyboard/app/MrGlow;->sLinePaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    goto/16 :goto_0

    .line 335
    :cond_4
    const/4 v1, 0x0

    goto/16 :goto_1

    :cond_5
    move v0, v2

    .line 342
    goto :goto_2
.end method

.method private static sync()Z
    .locals 2

    .prologue
    .line 94
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->tuning()V

    .line 95
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->glow()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 98
    :goto_0
    return v0

    .line 96
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v0

    .line 97
    if-nez v0, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    if-eqz v1, :cond_1

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 98
    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    .line 97
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1
.end method

.method static toolHint(I)I
    .locals 1

    .prologue
    .line 165
    const v0, 0x3f333333    # 0.7f

    invoke-static {p0, v0}, Lcom/mrkeyboard/app/MrGlow;->fade(IF)I

    move-result v0

    return v0
.end method

.method static toolInk()I
    .locals 2

    .prologue
    .line 157
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->tuning()V

    .line 158
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    if-nez v0, :cond_0

    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    iget-boolean v0, v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->on:Z

    if-nez v0, :cond_1

    :cond_0
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    .line 160
    :goto_0
    return v0

    .line 159
    :cond_1
    const-string v0, "text"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    .line 160
    ushr-int/lit8 v1, v0, 0x18

    if-nez v1, :cond_2

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    const/high16 v1, -0x1000000

    or-int/2addr v0, v1

    goto :goto_0
.end method

.method private static tuning()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 103
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v1

    .line 104
    invoke-static {}, Lcom/mrkeyboard/app/MrKeyLook;->version()I

    move-result v0

    .line 105
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    if-ne v0, v2, :cond_2

    if-nez v1, :cond_1

    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    if-nez v2, :cond_2

    .line 121
    :cond_0
    :goto_0
    return-void

    .line 105
    :cond_1
    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 106
    :cond_2
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sLookTag:Ljava/lang/String;

    .line 107
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sLookVersion:I

    .line 108
    invoke-static {v1}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v2

    .line 109
    if-eqz v2, :cond_4

    sget-object v0, Lcom/mrkeyboard/app/MrTools;->sApp:Landroid/content/Context;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->current(Landroid/content/Context;)Lcom/mrkeyboard/app/MrKeyLook;

    move-result-object v0

    :goto_1
    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 110
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sText:I

    .line 111
    if-eqz v2, :cond_5

    invoke-static {}, Lcom/mrkeyboard/app/MrAdapt;->current()Lcom/mrkeyboard/app/MrAdapt$Tone;

    move-result-object v0

    :goto_2
    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sTone:Lcom/mrkeyboard/app/MrAdapt$Tone;

    .line 112
    if-eqz v2, :cond_6

    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    const v3, 0xffffff

    and-int/2addr v0, v3

    :goto_3
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sOverOff:I

    .line 113
    if-eqz v2, :cond_3

    .line 115
    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    .line 116
    const-string v0, "modifier_indicator_lock"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    .line 118
    :cond_3
    sput-object v4, Lcom/mrkeyboard/app/MrGlow;->sFillFilter:[Landroid/graphics/ColorFilter;

    .line 119
    sput-object v4, Lcom/mrkeyboard/app/MrGlow;->sEdgeFilter:[Landroid/graphics/ColorFilter;

    .line 120
    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->isOwn(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sput-object v4, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    goto :goto_0

    .line 109
    :cond_4
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    goto :goto_1

    .line 111
    :cond_5
    sget-object v0, Lcom/mrkeyboard/app/MrAdapt$Tone;->OFF:Lcom/mrkeyboard/app/MrAdapt$Tone;

    goto :goto_2

    .line 112
    :cond_6
    const/4 v0, -0x1

    goto :goto_3
.end method
