.class final Lcom/mrkeyboard/app/MrGlow;
.super Ljava/lang/Object;
.source "MrGlow.java"


# static fields
.field static final DASH_DP:F = 3.0f

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

.field private static sEnd:I

.field private static sFaceFilter:[Landroid/graphics/ColorFilter;

.field private static sGlow:I

.field private static sHue:[I

.field private static sIconGlowColor:I

.field private static sIconGlowFilter:Landroid/graphics/ColorFilter;

.field private static sInk:I

.field private static sInkFilter:Landroid/graphics/ColorFilter;

.field private static sInkFilterColor:I

.field private static sKeyGlow:I

.field private static sMatrix:[[F

.field private static sMid:I

.field private static sSpectrum:Z

.field private static sStart:I

.field private static sStep:I

.field private static sTag:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 62
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 64
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bloom(Landroid/graphics/Canvas;Ljava/lang/String;FFLandroid/graphics/Paint;)V
    .locals 7

    .prologue
    const/4 v6, 0x0

    .line 168
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 169
    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    if-nez p4, :cond_1

    .line 175
    :cond_0
    :goto_0
    return-void

    .line 170
    :cond_1
    invoke-virtual {p4}, Landroid/graphics/Paint;->getTextSize()F

    move-result v1

    .line 171
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 172
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

    .line 173
    invoke-virtual {p0, p1, p2, p3, p4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 174
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

    .line 363
    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result v1

    .line 364
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
    .line 353
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
    .locals 8

    .prologue
    const/4 v1, 0x1

    const/4 v2, 0x0

    const/4 v7, 0x0

    const v6, 0xffffff

    .line 220
    if-nez p0, :cond_0

    .line 234
    :goto_0
    return-void

    .line 221
    :cond_0
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    if-nez v0, :cond_1

    .line 222
    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_0

    .line 225
    :cond_1
    invoke-virtual {p0}, Landroid/graphics/Paint;->getColor()I

    move-result v3

    .line 226
    and-int v0, v3, v6

    sget v4, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    and-int/2addr v4, v6

    if-ne v0, v4, :cond_2

    move v0, v1

    .line 227
    :goto_1
    and-int v4, v3, v6

    sget v5, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    and-int/2addr v5, v6

    if-ne v4, v5, :cond_3

    .line 228
    :goto_2
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-ltz v2, :cond_5

    if-nez v1, :cond_5

    .line 229
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    aget-object v1, v1, v2

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v1

    .line 230
    invoke-virtual {p0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 232
    :goto_3
    if-eqz v0, :cond_4

    invoke-virtual {p0}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_0

    :cond_2
    move v0, v2

    .line 226
    goto :goto_1

    :cond_3
    move v1, v2

    .line 227
    goto :goto_2

    .line 233
    :cond_4
    const/high16 v0, 0x40400000    # 3.0f

    sget v2, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    mul-float/2addr v0, v2

    invoke-virtual {p0, v0, v7, v7, v1}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    goto :goto_0

    :cond_5
    move v1, v3

    goto :goto_3
.end method

.method private static density(Landroid/view/View;)F
    .locals 2

    .prologue
    .line 345
    :try_start_0
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    .line 346
    const/4 v1, 0x0

    cmpl-float v1, v0, v1

    if-lez v1, :cond_0

    .line 348
    :goto_0
    return v0

    .line 346
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    goto :goto_0

    .line 347
    :catch_0
    move-exception v0

    .line 348
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    goto :goto_0
.end method

.method static drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 150
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 151
    if-ltz v0, :cond_0

    if-nez p0, :cond_1

    .line 152
    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 161
    :goto_0
    return-void

    .line 155
    :cond_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->faceFilter(I)Landroid/graphics/ColorFilter;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 157
    :try_start_0
    invoke-static {p0, p1, p2, p3}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 159
    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    goto :goto_0

    :catchall_0
    move-exception v0

    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    .line 160
    throw v0
.end method

.method static edge(Landroid/graphics/Paint;)V
    .locals 6

    .prologue
    const/4 v5, 0x0

    .line 183
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 184
    if-eqz v0, :cond_0

    if-nez p0, :cond_1

    .line 187
    :cond_0
    :goto_0
    return-void

    .line 185
    :cond_1
    sget v1, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 186
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

.method private static faceFilter(I)Landroid/graphics/ColorFilter;
    .locals 9

    .prologue
    const/4 v8, 0x3

    const/4 v7, 0x2

    const/4 v6, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 293
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v0, p0

    .line 294
    if-nez v0, :cond_0

    .line 295
    sget-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    aget-object v1, v0, p0

    .line 296
    new-instance v0, Landroid/graphics/ColorMatrixColorFilter;

    const/16 v2, 0x14

    new-array v2, v2, [F

    aget v3, v1, v4

    aput v3, v2, v4

    aget v3, v1, v6

    aput v3, v2, v6

    aget v3, v1, v7

    aput v3, v2, v7

    aput v5, v2, v8

    const/4 v3, 0x4

    aput v5, v2, v3

    const/4 v3, 0x5

    aget v4, v1, v8

    aput v4, v2, v3

    const/4 v3, 0x6

    const/4 v4, 0x4

    aget v4, v1, v4

    aput v4, v2, v3

    const/4 v3, 0x7

    const/4 v4, 0x5

    aget v4, v1, v4

    aput v4, v2, v3

    const/16 v3, 0x8

    aput v5, v2, v3

    const/16 v3, 0x9

    aput v5, v2, v3

    const/16 v3, 0xa

    const/4 v4, 0x6

    aget v4, v1, v4

    aput v4, v2, v3

    const/16 v3, 0xb

    const/4 v4, 0x7

    aget v4, v1, v4

    aput v4, v2, v3

    const/16 v3, 0xc

    const/16 v4, 0x8

    aget v1, v1, v4

    aput v1, v2, v3

    const/16 v1, 0xd

    aput v5, v2, v1

    const/16 v1, 0xe

    aput v5, v2, v1

    const/16 v1, 0xf

    aput v5, v2, v1

    const/16 v1, 0x10

    aput v5, v2, v1

    const/16 v1, 0x11

    aput v5, v2, v1

    const/16 v1, 0x12

    const/high16 v3, 0x3f800000    # 1.0f

    aput v3, v2, v1

    const/16 v1, 0x13

    aput v5, v2, v1

    invoke-direct {v0, v2}, Landroid/graphics/ColorMatrixColorFilter;-><init>([F)V

    .line 301
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    aput-object v0, v1, p0

    .line 303
    :cond_0
    return-object v0
.end method

.method static fade(IF)I
    .locals 3

    .prologue
    .line 358
    ushr-int/lit8 v0, p0, 0x18

    int-to-float v0, v0

    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    invoke-static {p1, v1, v2}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    .line 359
    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method

.method static hint(Landroid/graphics/Paint;I)V
    .locals 2

    .prologue
    .line 144
    if-eqz p0, :cond_0

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    if-gez v0, :cond_1

    .line 146
    :cond_0
    :goto_0
    return-void

    .line 145
    :cond_1
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

    .line 369
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

    .line 370
    invoke-static {v2, v3}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v0, v4}, Ljava/lang/Math;->max(FF)F

    move-result v4

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v5

    invoke-static {v0, v5}, Ljava/lang/Math;->min(FF)F

    move-result v5

    .line 371
    sub-float v5, v4, v5

    .line 372
    cmpg-float v6, v5, v1

    if-gtz v6, :cond_1

    move v0, v1

    .line 376
    :goto_0
    cmpg-float v2, v0, v1

    if-gez v2, :cond_0

    const/high16 v2, 0x43b40000    # 360.0f

    add-float/2addr v0, v2

    .line 377
    :cond_0
    const/4 v2, 0x0

    aput v0, p1, v2

    .line 378
    const/4 v2, 0x1

    cmpg-float v0, v4, v1

    if-gtz v0, :cond_4

    move v0, v1

    :goto_1
    aput v0, p1, v2

    .line 379
    const/4 v0, 0x2

    aput v4, p1, v0

    .line 380
    return-void

    .line 373
    :cond_1
    cmpl-float v6, v4, v0

    if-nez v6, :cond_2

    sub-float v0, v2, v3

    div-float/2addr v0, v5

    const/high16 v2, 0x40c00000    # 6.0f

    rem-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 374
    :cond_2
    cmpl-float v6, v4, v2

    if-nez v6, :cond_3

    sub-float v0, v3, v0

    div-float/2addr v0, v5

    const/high16 v2, 0x40000000    # 2.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 375
    :cond_3
    sub-float/2addr v0, v2

    div-float/2addr v0, v5

    const/high16 v2, 0x40800000    # 4.0f

    add-float/2addr v0, v2

    mul-float/2addr v0, v7

    goto :goto_0

    .line 378
    :cond_4
    div-float v0, v5, v4

    goto :goto_1
.end method

.method static icon(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V
    .locals 3

    .prologue
    .line 191
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 192
    if-nez v0, :cond_0

    .line 193
    invoke-static {p0, p1, p2, p3, p4}, Lcom/mrkeyboard/app/ShadowDrawHelper;->draw(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V

    .line 201
    :goto_0
    return-void

    .line 196
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    if-eq v1, v0, :cond_2

    .line 197
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sIconGlowColor:I

    .line 198
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 200
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
    .line 205
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 206
    if-nez v0, :cond_0

    .line 211
    :goto_0
    return-object p0

    .line 207
    :cond_0
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    if-eqz v1, :cond_1

    sget v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    if-eq v1, v0, :cond_2

    .line 208
    :cond_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInkFilterColor:I

    .line 209
    new-instance v1, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v1, v0, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 211
    :cond_2
    sget-object p0, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    goto :goto_0
.end method

.method static key(Landroid/view/View;Lcom/mrkeyboard/app/Keyboard$Key;ZLandroid/graphics/Paint;)V
    .locals 4

    .prologue
    const/4 v1, 0x0

    const/high16 v3, 0x3f000000    # 0.5f

    .line 118
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 119
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 120
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-nez v0, :cond_1

    .line 121
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 136
    :cond_0
    :goto_0
    return-void

    .line 124
    :cond_1
    invoke-static {p0}, Lcom/mrkeyboard/app/MrGlow;->density(Landroid/view/View;)F

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 125
    if-eqz p2, :cond_2

    sget v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    :goto_1
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 126
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v0, :cond_0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 127
    iget v0, p1, Lcom/mrkeyboard/app/Keyboard$Key;->x:I

    int-to-float v0, v0

    iget v1, p1, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    int-to-float v1, v1

    mul-float/2addr v1, v3

    add-float/2addr v0, v1

    iget v1, p1, Lcom/mrkeyboard/app/Keyboard$Key;->y:I

    int-to-float v1, v1

    iget v2, p1, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    int-to-float v2, v2

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v2

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v3

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->step(FFII)I

    move-result v0

    .line 128
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->matrix(I)[F

    move-result-object v1

    .line 129
    if-eqz v1, :cond_0

    .line 130
    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 131
    sget v2, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    const/high16 v3, -0x1000000

    and-int/2addr v2, v3

    sget-object v3, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aget v0, v3, v0

    const v3, 0xffffff

    and-int/2addr v0, v3

    or-int/2addr v0, v2

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 132
    if-eqz p3, :cond_0

    .line 133
    invoke-virtual {p3}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 134
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    invoke-virtual {p3, v0}, Landroid/graphics/Paint;->setColor(I)V

    goto :goto_0

    .line 125
    :cond_2
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    goto :goto_1
.end method

.method private static load(Ljava/lang/String;)V
    .locals 3

    .prologue
    const/16 v2, 0x31

    const/4 v1, 0x0

    .line 80
    sput-object p0, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 81
    const-string v0, "glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    .line 82
    const-string v0, "accent_glow"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sAccentGlow:I

    .line 83
    const-string v0, "modifier_indicator_off"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashOff:I

    .line 84
    const-string v0, "modifier_indicator_lock"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDashLock:I

    .line 85
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->spectrum()Z

    move-result v0

    sput-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    .line 86
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 87
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 88
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 89
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sIconGlowFilter:Landroid/graphics/ColorFilter;

    .line 90
    sput-object v1, Lcom/mrkeyboard/app/MrGlow;->sInkFilter:Landroid/graphics/ColorFilter;

    .line 91
    sget-boolean v0, Lcom/mrkeyboard/app/MrGlow;->sSpectrum:Z

    if-eqz v0, :cond_0

    .line 92
    const-string v0, "spectrum_start"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    .line 93
    const-string v0, "spectrum_mid"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    .line 94
    const-string v0, "spectrum_end"

    invoke-static {v0}, Lcom/mrkeyboard/app/MrTheme;->color(Ljava/lang/String;)I

    move-result v0

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    .line 95
    new-array v0, v2, [[F

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 96
    new-array v0, v2, [Landroid/graphics/ColorFilter;

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sFaceFilter:[Landroid/graphics/ColorFilter;

    .line 97
    new-array v0, v2, [I

    sput-object v0, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    .line 99
    :cond_0
    return-void
.end method

.method static map([FI)I
    .locals 6

    .prologue
    .line 333
    if-nez p0, :cond_0

    .line 335
    :goto_0
    return p1

    .line 334
    :cond_0
    shr-int/lit8 v0, p1, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-float v0, v0

    shr-int/lit8 v1, p1, 0x8

    and-int/lit16 v1, v1, 0xff

    int-to-float v1, v1

    and-int/lit16 v2, p1, 0xff

    int-to-float v2, v2

    .line 335
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

    .line 336
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

    .line 337
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

    .line 338
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->byteOf(F)I

    move-result v0

    or-int p1, v3, v0

    .line 335
    goto :goto_0
.end method

.method private static matrix(I)[F
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 279
    sget-object v2, Lcom/mrkeyboard/app/MrGlow;->sMatrix:[[F

    .line 280
    if-eqz v2, :cond_0

    if-ltz p0, :cond_0

    const/16 v0, 0x30

    if-le p0, v0, :cond_2

    :cond_0
    move-object v0, v1

    .line 289
    :cond_1
    :goto_0
    return-object v0

    .line 281
    :cond_2
    aget-object v0, v2, p0

    .line 282
    if-nez v0, :cond_1

    .line 283
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sStart:I

    sget v3, Lcom/mrkeyboard/app/MrGlow;->sMid:I

    sget v4, Lcom/mrkeyboard/app/MrGlow;->sEnd:I

    int-to-float v5, p0

    const/high16 v6, 0x42400000    # 48.0f

    div-float/2addr v5, v6

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v3

    .line 284
    sget v0, Lcom/mrkeyboard/app/MrGlow;->sKeyGlow:I

    invoke-static {v0, v3}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v0

    .line 285
    if-nez v0, :cond_3

    move-object v0, v1

    goto :goto_0

    .line 286
    :cond_3
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sHue:[I

    aput v3, v1, p0

    .line 287
    aput-object v0, v2, p0

    goto :goto_0
.end method

.method static preview(Landroid/widget/TextView;)V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 238
    if-nez p0, :cond_1

    .line 243
    :cond_0
    :goto_0
    return-void

    .line 239
    :cond_1
    invoke-static {}, Lcom/mrkeyboard/app/MrGlow;->sync()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 242
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

    .line 257
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p3, v9, v0}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v0

    .line 258
    const/4 v1, 0x3

    new-array v2, v1, [F

    const/4 v1, 0x3

    new-array v3, v1, [F

    .line 260
    const/high16 v1, 0x3f000000    # 0.5f

    cmpg-float v1, v0, v1

    if-gez v1, :cond_4

    .line 261
    invoke-static {p0, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 262
    invoke-static {p1, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 263
    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    .line 269
    :goto_0
    aget v1, v3, v6

    aget v4, v2, v6

    sub-float/2addr v1, v4

    .line 270
    const/high16 v4, 0x43340000    # 180.0f

    cmpl-float v4, v1, v4

    if-lez v4, :cond_0

    sub-float/2addr v1, v5

    .line 271
    :cond_0
    const/high16 v4, -0x3ccc0000    # -180.0f

    cmpg-float v4, v1, v4

    if-gez v4, :cond_1

    add-float/2addr v1, v5

    .line 272
    :cond_1
    aget v4, v2, v6

    mul-float/2addr v1, v0

    add-float/2addr v1, v4

    .line 273
    cmpg-float v4, v1, v9

    if-gez v4, :cond_2

    add-float/2addr v1, v5

    .line 274
    :cond_2
    cmpl-float v4, v1, v5

    if-ltz v4, :cond_3

    sub-float/2addr v1, v5

    .line 275
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

    .line 265
    :cond_4
    invoke-static {p1, v2}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 266
    invoke-static {p2, v3}, Lcom/mrkeyboard/app/MrGlow;->hsv(I[F)V

    .line 267
    const/high16 v1, 0x3f000000    # 0.5f

    sub-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    goto :goto_0
.end method

.method static remap(II)[F
    .locals 20

    .prologue
    .line 313
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

    .line 314
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

    .line 316
    sub-float v7, v2, v3

    sub-float v8, v3, v1

    sub-float v9, v1, v2

    .line 318
    sub-float v10, v9, v8

    sub-float v11, v7, v9

    sub-float v12, v8, v7

    .line 319
    mul-float v13, v1, v10

    mul-float v14, v2, v11

    add-float/2addr v13, v14

    mul-float v14, v3, v12

    add-float/2addr v13, v14

    .line 320
    invoke-static {v13}, Ljava/lang/Math;->abs(F)F

    move-result v14

    const v15, 0x38d1b717    # 1.0E-4f

    cmpg-float v14, v14, v15

    if-gez v14, :cond_0

    const/4 v1, 0x0

    .line 325
    :goto_0
    return-object v1

    .line 321
    :cond_0
    div-float/2addr v10, v13

    div-float/2addr v11, v13

    div-float/2addr v12, v13

    .line 322
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

    .line 323
    sub-float v17, v2, v3

    div-float v17, v17, v13

    sub-float/2addr v3, v1

    div-float/2addr v3, v13

    sub-float/2addr v1, v2

    div-float v2, v1, v13

    .line 325
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
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 103
    sput-object v2, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    .line 104
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sGlow:I

    .line 105
    const/4 v0, -0x1

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sStep:I

    .line 106
    sput v1, Lcom/mrkeyboard/app/MrGlow;->sInk:I

    .line 107
    const/high16 v0, 0x3f800000    # 1.0f

    sput v0, Lcom/mrkeyboard/app/MrGlow;->sDensity:F

    .line 108
    invoke-static {v2}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 109
    return-void
.end method

.method static rgb(FFF)I
    .locals 8

    .prologue
    const/high16 v6, 0x40000000    # 2.0f

    const/high16 v5, 0x437f0000    # 255.0f

    const/high16 v4, 0x3f800000    # 1.0f

    const/4 v0, 0x0

    .line 384
    mul-float v2, p2, p1

    .line 385
    const/high16 v1, 0x43b40000    # 360.0f

    rem-float v1, p0, v1

    const/high16 v3, 0x42700000    # 60.0f

    div-float v3, v1, v3

    .line 386
    rem-float v1, v3, v6

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    sub-float v1, v4, v1

    mul-float/2addr v1, v2

    .line 388
    cmpg-float v4, v3, v4

    if-gez v4, :cond_0

    move v3, v2

    .line 394
    :goto_0
    sub-float v2, p2, v2

    .line 395
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

    .line 389
    :cond_0
    cmpg-float v4, v3, v6

    if-gez v4, :cond_1

    move v3, v1

    move v1, v2

    goto :goto_0

    .line 390
    :cond_1
    const/high16 v4, 0x40400000    # 3.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_2

    move v3, v0

    move v0, v1

    move v1, v2

    goto :goto_0

    .line 391
    :cond_2
    const/high16 v4, 0x40800000    # 4.0f

    cmpg-float v4, v3, v4

    if-gez v4, :cond_3

    move v3, v0

    move v0, v2

    goto :goto_0

    .line 392
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

    .line 393
    goto :goto_0
.end method

.method static step(FFII)I
    .locals 5

    .prologue
    const/16 v1, 0x30

    const/4 v0, 0x0

    .line 249
    if-lez p2, :cond_0

    if-gtz p3, :cond_1

    .line 252
    :cond_0
    :goto_0
    return v0

    .line 250
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

    .line 251
    const/4 v3, 0x0

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-static {v2, v3, v4}, Lcom/mrkeyboard/app/MrGlow;->clamp(FFF)F

    move-result v2

    const/high16 v3, 0x42400000    # 48.0f

    mul-float/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 252
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
    .line 73
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->glow()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x0

    .line 76
    :goto_0
    return v0

    .line 74
    :cond_0
    invoke-static {}, Lcom/mrkeyboard/app/MrTheme;->tag()Ljava/lang/String;

    move-result-object v0

    .line 75
    if-nez v0, :cond_2

    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    if-eqz v1, :cond_1

    :goto_1
    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->load(Ljava/lang/String;)V

    .line 76
    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    .line 75
    :cond_2
    sget-object v1, Lcom/mrkeyboard/app/MrGlow;->sTag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    goto :goto_1
.end method
