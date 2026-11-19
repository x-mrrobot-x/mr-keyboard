.class final Lcom/mrkeyboard/app/MrThemePreview;
.super Landroid/view/View;
.source "MrThemePreview.java"


# static fields
.field static final BAR_SHARE:F = 0.17f

.field static final CORNER_DP:F = 12.0f

.field static final ROWS:[Ljava/lang/String;

.field static final WORDS:[F


# instance fields
.field private mAccent:Landroid/graphics/drawable/Drawable;

.field private mBg:Landroid/graphics/Bitmap;

.field private mBgKey:Ljava/lang/String;

.field private mCheck:I

.field private mChecked:Z

.field private final mDensity:F

.field private mDrawn:I

.field private mFace:Landroid/graphics/drawable/Drawable;

.field private mFaceTag:Ljava/lang/String;

.field private mImage:Landroid/graphics/Bitmap;

.field private mKeyWidthPx:I

.field private final mMetrics:Landroid/graphics/Paint$FontMetrics;

.field private final mPaint:Landroid/graphics/Paint;

.field private mPlus:Z

.field private mPlusFill:I

.field private mPlusInk:I

.field private mPlusLine:I

.field private mRing:I

.field private mSoft:I

.field private mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field private mTag:Ljava/lang/String;

.field private final mText:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    .prologue
    const/4 v3, 0x3

    .line 23
    new-array v0, v3, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "QWERTYUIOP"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "ASDFGHJKL"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "ZXCVBNM"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    .line 28
    new-array v0, v3, [F

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    return-void

    :array_0
    .array-data 4
        0x3e4ccccd    # 0.2f
        0x3e0f5c29    # 0.14f
        0x3e3851ec    # 0.18f
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 53
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 30
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    .line 31
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    .line 32
    new-instance v0, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 36
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 40
    const v0, -0xb07301

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 54
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    .line 56
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 57
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    .line 58
    return-void
.end method

.method private background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V
    .locals 9

    .prologue
    const/4 v8, 0x0

    const v7, -0xdfdfe0

    const/4 v6, 0x0

    .line 157
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v1, 0x3

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_1

    .line 158
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 181
    :goto_0
    return-void

    .line 161
    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrBackdrop$Spec;->format()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p5}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "x"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "|"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    invoke-static {v1}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 162
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 164
    :cond_2
    :try_start_0
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p3, p4, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 165
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 166
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    invoke-static {v2, v3, p3, p4, v4}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 167
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    invoke-static {v3, v4, p5, v5}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdropDrawable;->veilOver(Lcom/mrkeyboard/app/MrBackdrop$Look;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 168
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    .line 169
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    .line 176
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-nez v0, :cond_4

    .line 177
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    goto/16 :goto_0

    .line 170
    :catch_0
    move-exception v0

    .line 171
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 172
    :catch_1
    move-exception v0

    .line 173
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 180
    :cond_4
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1, v6, v6, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v2, Landroid/graphics/Rect;

    invoke-direct {v2, v6, v6, p3, p4}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto/16 :goto_0
.end method

.method private badge(Landroid/graphics/Canvas;II)V
    .locals 12

    .prologue
    const/high16 v8, 0x40c00000    # 6.0f

    const v11, 0x3eb851ec    # 0.36f

    const v10, 0x3df5c28f    # 0.12f

    const/high16 v9, 0x40000000    # 2.0f

    .line 311
    const/high16 v0, 0x40200000    # 2.5f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v1

    .line 312
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 313
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 314
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 315
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 316
    const/high16 v1, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v1, v2

    .line 317
    div-float v1, v0, v9

    div-float v2, v0, v9

    int-to-float v3, p2

    div-float v4, v0, v9

    sub-float/2addr v3, v4

    int-to-float v4, p3

    div-float/2addr v0, v9

    sub-float/2addr v4, v0

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 318
    const/high16 v0, 0x41100000    # 9.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v0, v1

    .line 319
    int-to-float v0, p2

    sub-float/2addr v0, v6

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v8

    sub-float v7, v0, v1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v8

    add-float v8, v6, v0

    .line 320
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 321
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 322
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, v8, v6, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 323
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 324
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v9

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 325
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 326
    const v0, 0x3ee66666    # 0.45f

    mul-float/2addr v0, v6

    sub-float v1, v7, v0

    const v0, 0x3ca3d70a    # 0.02f

    mul-float/2addr v0, v6

    add-float v2, v8, v0

    mul-float v0, v6, v10

    sub-float v3, v7, v0

    mul-float v0, v6, v11

    add-float v4, v8, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 327
    mul-float v0, v6, v10

    sub-float v1, v7, v0

    mul-float v0, v6, v11

    add-float v2, v8, v0

    const v0, 0x3ef5c28f    # 0.48f

    mul-float/2addr v0, v6

    add-float v3, v7, v0

    const v0, 0x3eae147b    # 0.34f

    mul-float/2addr v0, v6

    sub-float v4, v8, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 328
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 329
    return-void
.end method

.method private bar(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 15

    .prologue
    .line 185
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    move-object/from16 v0, p2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->ink(Landroid/content/Context;Ljava/lang/String;)I

    move-result v10

    .line 186
    const/4 v1, 0x0

    const v2, 0x3e2e147b    # 0.17f

    mul-float v11, p4, v2

    .line 187
    add-float/2addr v1, v11

    const/high16 v2, 0x40000000    # 2.0f

    div-float v12, v1, v2

    .line 188
    const v1, 0x3e6147ae    # 0.22f

    mul-float v13, v11, v1

    .line 189
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 190
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 191
    const v1, 0x3db851ec    # 0.09f

    mul-float v2, p3, v1

    .line 192
    const/4 v1, 0x0

    move v9, v1

    :goto_0
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    if-ge v9, v1, :cond_1

    .line 193
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    aget v1, v1, v9

    mul-float v14, p3, v1

    .line 194
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const v3, 0x3f333333    # 0.7f

    invoke-static {v10, v3}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 195
    const/high16 v1, 0x40000000    # 2.0f

    div-float v1, v13, v1

    sub-float v3, v12, v1

    add-float v4, v2, v14

    const/high16 v1, 0x40000000    # 2.0f

    div-float v1, v13, v1

    add-float v5, v12, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v6, v13, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v7, v13, v1

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 196
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    add-float/2addr v1, v14

    add-float v7, v2, v1

    .line 197
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    if-ge v9, v1, :cond_0

    .line 198
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x3e800000    # 0.25f

    invoke-static {v10, v2}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 199
    const v1, 0x3d6147ae    # 0.055f

    mul-float v1, v1, p3

    sub-float v1, v7, v1

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float v2, v1, v2

    const v1, 0x3e8f5c29    # 0.28f

    mul-float v3, v11, v1

    const v1, 0x3d6147ae    # 0.055f

    mul-float v1, v1, p3

    sub-float v1, v7, v1

    const/high16 v4, 0x3f800000    # 1.0f

    add-float/2addr v4, v1

    const v1, 0x3f3851ec    # 0.72f

    mul-float v5, v11, v1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 192
    :cond_0
    add-int/lit8 v1, v9, 0x1

    move v9, v1

    move v2, v7

    goto :goto_0

    .line 202
    :cond_1
    return-void
.end method

.method private static corner(Landroid/graphics/Path;FFFFI)V
    .locals 8

    .prologue
    .line 351
    const/4 v0, 0x1

    :goto_0
    if-gt v0, p5, :cond_0

    .line 352
    float-to-double v2, p4

    const-wide v4, 0x4056800000000000L    # 90.0

    int-to-double v6, v0

    mul-double/2addr v4, v6

    int-to-double v6, p5

    div-double/2addr v4, v6

    add-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 353
    invoke-static {v2, v3}, Ljava/lang/Math;->cos(D)D

    move-result-wide v4

    double-to-float v1, v4

    mul-float/2addr v1, p3

    add-float/2addr v1, p1

    invoke-static {v2, v3}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    double-to-float v2, v2

    mul-float/2addr v2, p3

    add-float/2addr v2, p2

    invoke-virtual {p0, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 351
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 355
    :cond_0
    return-void
.end method

.method private static face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 298
    if-nez p1, :cond_1

    .line 305
    :cond_0
    :goto_0
    return-object v0

    .line 300
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 301
    if-eqz v1, :cond_0

    .line 302
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v2

    .line 303
    if-nez v2, :cond_2

    :goto_1
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    goto :goto_0

    :cond_2
    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable()Landroid/graphics/drawable/Drawable;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    goto :goto_1

    .line 304
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private faces(Landroid/content/Context;)V
    .locals 2

    .prologue
    .line 291
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    if-nez v0, :cond_2

    .line 295
    :cond_0
    :goto_0
    return-void

    .line 291
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 292
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    .line 293
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    .line 294
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const/4 v1, 0x1

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v0

    invoke-static {p1, v0}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    goto :goto_0
.end method

.method private flat(Landroid/graphics/Canvas;IIZ)V
    .locals 9

    .prologue
    .line 275
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 276
    if-eqz p4, :cond_0

    const-string v0, "key_acc_normal_"

    .line 278
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "fill"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "top"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const v6, -0xc5c0b9

    invoke-static {v1, v4, v5, v6}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v4

    invoke-static {v1, v2, v3, v4}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v8

    .line 279
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "lip"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "bottom"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v4, v0, v8}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-static {v1, v2, v3, v0}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    .line 280
    const/high16 v1, 0x40400000    # 3.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    const/high16 v2, 0x41000000    # 8.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v2, v3

    .line 281
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 282
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 283
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 284
    int-to-float v0, p2

    sub-float v3, v0, v1

    int-to-float v0, p3

    sub-float v4, v0, v1

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 285
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, v8}, Landroid/graphics/Paint;->setColor(I)V

    .line 286
    int-to-float v0, p2

    sub-float v3, v0, v1

    int-to-float v0, p3

    sub-float/2addr v0, v1

    const/high16 v2, 0x40000000    # 2.0f

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v2, v4

    sub-float v4, v0, v2

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 287
    return-void

    .line 276
    :cond_0
    const-string v0, "key_normal_"

    goto/16 :goto_0
.end method

.method private key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V
    .locals 5

    .prologue
    .line 251
    const/4 v0, 0x1

    invoke-static {p4}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    const/4 v0, 0x1

    invoke-static {p5}, Ljava/lang/Math;->round(F)I

    move-result v2

    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 252
    if-eqz p6, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    .line 253
    :goto_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 254
    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 255
    if-eqz v0, :cond_2

    .line 256
    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, v3, v4, v1, v2}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 257
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/KeyStyle;->prepare(Landroid/graphics/drawable/Drawable;IILandroid/content/Context;)V

    .line 258
    invoke-static {v0, p1, v1, v2}, Lcom/mrkeyboard/app/KeyStyle;->drawKey(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;II)V

    .line 262
    :goto_1
    invoke-virtual {p7}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_0

    .line 263
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v0, p8}, Landroid/graphics/Paint;->setColor(I)V

    .line 264
    const/4 v0, 0x0

    cmpl-float v0, p10, v0

    if-lez v0, :cond_3

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v0, p10, v3, v4, p9}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    .line 266
    :goto_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {v0, v3}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 267
    int-to-float v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    int-to-float v1, v2

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v2, v2, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v3, v3, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr v2, v3

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    sub-float/2addr v1, v2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {p1, p7, v0, v1, v2}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 268
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->clearShadowLayer()V

    .line 270
    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 271
    return-void

    .line 252
    :cond_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    goto :goto_0

    .line 260
    :cond_2
    invoke-direct {p0, p1, v1, v2, p6}, Lcom/mrkeyboard/app/MrThemePreview;->flat(Landroid/graphics/Canvas;IIZ)V

    goto :goto_1

    .line 265
    :cond_3
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_2
.end method

.method private keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 35

    .prologue
    .line 205
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->faces(Landroid/content/Context;)V

    .line 206
    const v2, 0x3e2e147b    # 0.17f

    mul-float v30, p4, v2

    .line 207
    const v2, 0x3c03126f    # 0.008f

    mul-float v4, p3, v2

    .line 208
    sub-float v2, p4, v30

    const/high16 v3, 0x40800000    # 4.0f

    div-float v7, v2, v3

    .line 209
    const/high16 v2, 0x40000000    # 2.0f

    mul-float/2addr v2, v4

    sub-float v2, p3, v2

    const/high16 v3, 0x41200000    # 10.0f

    div-float v31, v2, v3

    .line 210
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v3, "text"

    const/4 v5, -0x1

    move-object/from16 v0, p2

    invoke-static {v0, v2, v3, v5}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v10

    .line 211
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v3, "accent_text"

    move-object/from16 v0, p2

    invoke-static {v0, v2, v3, v10}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v32

    .line 213
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v3, "glow"

    move-object/from16 v0, p2

    invoke-static {v0, v2, v3}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v11

    .line 214
    if-nez v11, :cond_1

    const/4 v12, 0x0

    .line 215
    :goto_0
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 216
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    const v3, 0x3ed70a3d    # 0.42f

    mul-float/2addr v3, v7

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 217
    const/4 v2, 0x0

    move/from16 v29, v2

    :goto_1
    const/4 v2, 0x4

    move/from16 v0, v29

    if-ge v0, v2, :cond_4

    .line 218
    move/from16 v0, v29

    int-to-float v2, v0

    mul-float/2addr v2, v7

    add-float v5, v30, v2

    .line 219
    const/4 v2, 0x3

    move/from16 v0, v29

    if-ge v0, v2, :cond_2

    .line 220
    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    aget-object v24, v2, v29

    .line 221
    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v2

    int-to-float v2, v2

    mul-float v2, v2, v31

    .line 222
    const/high16 v3, 0x41200000    # 10.0f

    mul-float v3, v3, v31

    sub-float/2addr v3, v2

    const/high16 v6, 0x40000000    # 2.0f

    div-float/2addr v3, v6

    add-float v25, v4, v3

    .line 223
    const/4 v3, 0x2

    move/from16 v0, v29

    if-ne v0, v3, :cond_0

    .line 225
    const/high16 v3, 0x41200000    # 10.0f

    mul-float v3, v3, v31

    sub-float v2, v3, v2

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    const v3, 0x3dcccccd    # 0.1f

    mul-float v3, v3, v31

    sub-float v6, v2, v3

    .line 226
    const/4 v8, 0x0

    const-string v9, "\u21e7"

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-direct/range {v2 .. v12}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 227
    const/high16 v2, 0x41200000    # 10.0f

    mul-float v2, v2, v31

    add-float/2addr v2, v4

    sub-float v15, v2, v6

    const/16 v19, 0x0

    const-string v20, "\u232b"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v16, v5

    move/from16 v17, v6

    move/from16 v18, v7

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 229
    :cond_0
    const/4 v2, 0x0

    :goto_2
    invoke-virtual/range {v24 .. v24}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_3

    .line 230
    int-to-float v3, v2

    mul-float v3, v3, v31

    add-float v15, v25, v3

    const/16 v19, 0x0

    move-object/from16 v0, v24

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v20

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v16, v5

    move/from16 v17, v31

    move/from16 v18, v7

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 229
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    .line 214
    :cond_1
    const/high16 v2, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v12, v2, v3

    goto/16 :goto_0

    .line 233
    :cond_2
    const v2, 0x3fa66666    # 1.3f

    mul-float v6, v31, v2

    const/high16 v2, 0x3f800000    # 1.0f

    mul-float v17, v31, v2

    const v2, 0x3fd9999a    # 1.7f

    mul-float v33, v31, v2

    .line 234
    const/high16 v2, 0x41200000    # 10.0f

    mul-float v2, v2, v31

    sub-float/2addr v2, v6

    const/high16 v3, 0x40000000    # 2.0f

    mul-float v3, v3, v17

    sub-float/2addr v2, v3

    sub-float v34, v2, v33

    .line 236
    const/4 v8, 0x0

    const-string v9, "?123"

    move-object/from16 v2, p0

    move-object/from16 v3, p1

    invoke-direct/range {v2 .. v12}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 237
    add-float v15, v4, v6

    .line 238
    const/16 v19, 0x0

    const-string v20, ","

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v16, v5

    move/from16 v18, v7

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 239
    add-float v20, v15, v17

    .line 240
    const/16 v24, 0x0

    const-string v25, ""

    move-object/from16 v18, p0

    move-object/from16 v19, p1

    move/from16 v21, v5

    move/from16 v22, v34

    move/from16 v23, v7

    move/from16 v26, v10

    move/from16 v27, v11

    move/from16 v28, v12

    invoke-direct/range {v18 .. v28}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 241
    add-float v15, v20, v34

    .line 242
    const/16 v19, 0x0

    const-string v20, "."

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v16, v5

    move/from16 v18, v7

    move/from16 v21, v10

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 243
    add-float v15, v15, v17

    .line 244
    const/16 v19, 0x1

    const-string v20, "\u23ce"

    move-object/from16 v13, p0

    move-object/from16 v14, p1

    move/from16 v16, v5

    move/from16 v17, v33

    move/from16 v18, v7

    move/from16 v21, v32

    move/from16 v22, v11

    move/from16 v23, v12

    invoke-direct/range {v13 .. v23}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 217
    :cond_3
    add-int/lit8 v2, v29, 0x1

    move/from16 v29, v2

    goto/16 :goto_1

    .line 247
    :cond_4
    return-void
.end method

.method private plus(Landroid/graphics/Canvas;II)V
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/high16 v8, 0x40000000    # 2.0f

    .line 137
    const/high16 v0, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v0, v2

    .line 138
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 139
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 140
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 141
    int-to-float v3, p2

    int-to-float v4, p3

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 142
    const/high16 v0, 0x3f800000    # 1.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 143
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 144
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 145
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 146
    div-float v1, v0, v8

    div-float v2, v0, v8

    int-to-float v3, p2

    div-float v4, v0, v8

    sub-float/2addr v3, v4

    int-to-float v4, p3

    div-float/2addr v0, v8

    sub-float/2addr v4, v0

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 147
    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const v1, 0x3e2e147b    # 0.17f

    mul-float v6, v0, v1

    .line 148
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x40200000    # 2.5f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 149
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 150
    int-to-float v0, p2

    div-float/2addr v0, v8

    sub-float v1, v0, v6

    int-to-float v0, p3

    div-float v2, v0, v8

    int-to-float v0, p2

    div-float/2addr v0, v8

    add-float v3, v0, v6

    int-to-float v0, p3

    div-float v4, v0, v8

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 151
    int-to-float v0, p2

    div-float v1, v0, v8

    int-to-float v0, p3

    div-float/2addr v0, v8

    sub-float v2, v0, v6

    int-to-float v0, p2

    div-float v3, v0, v8

    int-to-float v0, p3

    div-float/2addr v0, v8

    add-float v4, v0, v6

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 152
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 153
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    .line 154
    :cond_0
    return-void
.end method

.method static roundRect(FFF)Landroid/graphics/Path;
    .locals 12

    .prologue
    .line 333
    invoke-static {p0, p1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    invoke-static {p2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 334
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    .line 335
    const/16 v5, 0x8

    .line 336
    const/4 v1, 0x0

    invoke-virtual {v0, v2, v1}, Landroid/graphics/Path;->moveTo(FF)V

    .line 337
    sub-float v1, p0, v2

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 338
    sub-float v1, p0, v2

    const/high16 v4, -0x3d4c0000    # -90.0f

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 339
    sub-float v1, p1, v2

    invoke-virtual {v0, p0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 340
    sub-float v7, p0, v2

    sub-float v8, p1, v2

    const/4 v10, 0x0

    move-object v6, v0

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 341
    invoke-virtual {v0, v2, p1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 342
    sub-float v8, p1, v2

    const/high16 v10, 0x42b40000    # 90.0f

    move-object v6, v0

    move v7, v2

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 343
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 344
    const/high16 v4, 0x43340000    # 180.0f

    move v1, v2

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 345
    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    .line 346
    return-object v0
.end method

.method static withAlpha(IF)I
    .locals 2

    .prologue
    .line 358
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


# virtual methods
.method checked()Z
    .locals 1

    .prologue
    .line 92
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    return v0
.end method

.method drawn()I
    .locals 1

    .prologue
    .line 97
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 8

    .prologue
    .line 108
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getHeight()I

    move-result v4

    .line 109
    if-lez v3, :cond_0

    if-gtz v4, :cond_1

    .line 131
    :cond_0
    :goto_0
    return-void

    .line 110
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    .line 111
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 112
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    if-eqz v0, :cond_2

    .line 113
    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->plus(Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 116
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrThemeColors;->dark(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    .line 117
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 118
    int-to-float v0, v3

    int-to-float v1, v4

    const/high16 v6, 0x41400000    # 12.0f

    iget v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v6, v7

    invoke-static {v0, v1, v6}, Lcom/mrkeyboard/app/MrThemePreview;->roundRect(FFF)Landroid/graphics/Path;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;)Z

    move-object v0, p0

    move-object v1, p1

    .line 119
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V

    .line 121
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    int-to-float v0, v0

    .line 122
    const v1, 0x4019999a    # 2.4f

    div-float v1, v0, v1

    .line 123
    int-to-float v5, v3

    div-float/2addr v5, v0

    .line 124
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 125
    invoke-virtual {p1, v5, v5}, Landroid/graphics/Canvas;->scale(FF)V

    .line 126
    invoke-direct {p0, p1, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->bar(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    .line 127
    invoke-direct {p0, p1, v2, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    .line 128
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 129
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 130
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    goto :goto_0
.end method

.method protected onMeasure(II)V
    .locals 3

    .prologue
    .line 102
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    .line 103
    int-to-float v1, v0

    const v2, 0x4019999a    # 2.4f

    div-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->setMeasuredDimension(II)V

    .line 104
    return-void
.end method

.method setChecked(ZII)V
    .locals 0

    .prologue
    .line 84
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    .line 85
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    .line 86
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 87
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 88
    return-void
.end method

.method show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V
    .locals 1

    .prologue
    .line 65
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 66
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    .line 67
    if-nez p2, :cond_0

    sget-object p2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 68
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    .line 69
    iput p4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    .line 70
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 71
    return-void
.end method

.method showPlus(III)V
    .locals 1

    .prologue
    .line 75
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 76
    iput p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    .line 77
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    .line 78
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    .line 79
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 80
    return-void
.end method
