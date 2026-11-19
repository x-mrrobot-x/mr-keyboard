.class final Lcom/mrkeyboard/app/MrThemePreview;
.super Landroid/view/View;
.source "MrThemePreview.java"


# static fields
.field private static final ATTR_ACTIVE:I = 0x10100a2

.field private static final ATTR_CHECKABLE:I = 0x101009f

.field private static final ATTR_CHECKED:I = 0x10100a0

.field static final BAR_SHARE:F = 0.17f

.field static final CORNER_DP:F = 12.0f

.field static final DASH_LOCK:I = 0x3

.field static final DASH_NONE:I = 0x0

.field static final DASH_OFF:I = 0x1

.field static final DASH_ON:I = 0x2

.field static final FACE_GAP_DP:F = 3.0f

.field static final FACE_LOCK:I = 0x2

.field static final FACE_NORMAL:I = 0x0

.field static final FACE_ON:I = 0x1

.field static final FULL_ASPECT:F = 1.7f

.field static final FULL_BAR_SHARE:F = 0.12f

.field private static final MOD_KEYS:[Z

.field private static final MOD_LABELS:[Ljava/lang/String;

.field private static final MOD_WIDTHS:[F

.field static final ROWS:[Ljava/lang/String;

.field private static final STATE_LOCK:[I

.field private static final STATE_MOD:[I

.field private static final STATE_NORMAL:[I

.field private static final STATE_ON:[I

.field static final WORDS:[F

.field static final WORD_GAP:F = 0.11f


# instance fields
.field private mAccent:Landroid/graphics/drawable/Drawable;

.field private mAreaH:F

.field private mAreaTop:F

.field private mAreaW:F

.field private mBg:Landroid/graphics/Bitmap;

.field private mBgKey:Ljava/lang/String;

.field private mCheck:I

.field private mChecked:Z

.field private mCurrent:[F

.field private mCurrentFilter:Landroid/graphics/ColorFilter;

.field private mCurrentHue:I

.field private final mDensity:F

.field private mDrawn:I

.field private mEnd:I

.field private mFace:Landroid/graphics/drawable/Drawable;

.field private mFaceTag:Ljava/lang/String;

.field private mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private mFilter:[Landroid/graphics/ColorFilter;

.field private mFrom:I

.field private mFull:Z

.field private mImage:Landroid/graphics/Bitmap;

.field private mKeyWidthPx:I

.field private mLook:Lcom/mrkeyboard/app/MrKeyLook;

.field private mMatrix:[[F

.field private final mMetrics:Landroid/graphics/Paint$FontMetrics;

.field private mMid:I

.field private final mPaint:Landroid/graphics/Paint;

.field private mPlus:Z

.field private mPlusFill:I

.field private mPlusInk:I

.field private mPlusLine:I

.field private mRing:I

.field private mSoft:I

.field private mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

.field private mStart:I

.field private mTag:Ljava/lang/String;

.field private final mText:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .prologue
    const/16 v6, 0x8

    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x3

    const/4 v2, 0x0

    .line 32
    new-array v0, v3, [Ljava/lang/String;

    const-string v1, "QWERTYUIOP"

    aput-object v1, v0, v2

    const-string v1, "ASDFGHJKL"

    aput-object v1, v0, v4

    const-string v1, "ZXCVBNM"

    aput-object v1, v0, v5

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    .line 45
    new-array v0, v2, [I

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_NORMAL:[I

    .line 46
    new-array v0, v4, [I

    const v1, 0x101009f

    aput v1, v0, v2

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_MOD:[I

    .line 47
    new-array v0, v5, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_ON:[I

    .line 48
    new-array v0, v3, [I

    fill-array-data v0, :array_1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->STATE_LOCK:[I

    .line 50
    new-array v0, v3, [F

    fill-array-data v0, :array_2

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    .line 337
    new-array v0, v6, [F

    fill-array-data v0, :array_3

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    .line 338
    new-array v0, v6, [Ljava/lang/String;

    const-string v1, "Ctrl"

    aput-object v1, v0, v2

    const-string v1, "Alt"

    aput-object v1, v0, v4

    const-string v1, "\u21b9"

    aput-object v1, v0, v5

    const-string v1, "<>"

    aput-object v1, v0, v3

    const/4 v1, 0x4

    const-string v2, "\u2190"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "\u2193"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "\u2192"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "{"

    aput-object v2, v0, v1

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_LABELS:[Ljava/lang/String;

    .line 340
    new-array v0, v6, [Z

    fill-array-data v0, :array_4

    sput-object v0, Lcom/mrkeyboard/app/MrThemePreview;->MOD_KEYS:[Z

    return-void

    .line 47
    nop

    :array_0
    .array-data 4
        0x101009f
        0x10100a0
    .end array-data

    .line 48
    :array_1
    .array-data 4
        0x10100a2
        0x101009f
        0x10100a0
    .end array-data

    .line 50
    :array_2
    .array-data 4
        0x3e4ccccd    # 0.2f
        0x3e0f5c29    # 0.14f
        0x3e3851ec    # 0.18f
    .end array-data

    .line 337
    :array_3
    .array-data 4
        0x41633333    # 14.2f
        0x41533333    # 13.2f
        0x4154cccd    # 13.3f
        0x41233333    # 10.2f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x4151999a    # 13.1f
        0x41233333    # 10.2f
    .end array-data

    .line 340
    :array_4
    .array-data 1
        0x1t
        0x1t
        0x1t
        0x0t
        0x1t
        0x1t
        0x1t
        0x0t
    .end array-data
.end method

.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 90
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 52
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    .line 53
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    .line 54
    new-instance v0, Landroid/graphics/Paint$FontMetrics;

    invoke-direct {v0}, Landroid/graphics/Paint$FontMetrics;-><init>()V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    .line 59
    sget-object v0, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 60
    sget-object v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 65
    const v0, -0xb07301

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 91
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    .line 93
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 94
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    .line 95
    return-void
.end method

.method private area(FFF)V
    .locals 1

    .prologue
    .line 550
    iput p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaW:F

    .line 551
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaTop:F

    .line 552
    sub-float v0, p3, p2

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaH:F

    .line 553
    return-void
.end method

.method private background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V
    .locals 9

    .prologue
    const/4 v8, 0x0

    const v7, -0xdfdfe0

    const/4 v6, 0x0

    .line 232
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v0, v0, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrBackdrop;->needsBitmap(Lcom/mrkeyboard/app/MrBackdrop$Spec;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    if-nez v0, :cond_1

    .line 233
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 256
    :goto_0
    return-void

    .line 236
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

    .line 237
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 239
    :cond_2
    :try_start_0
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p3, p4, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 240
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 241
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    invoke-static {v2, v3, p3, p4, v4}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 242
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    invoke-static {v3, v4, p5, v5}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdropDrawable;->veilOver(Lcom/mrkeyboard/app/MrBackdrop$Look;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 243
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    .line 244
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBgKey:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1

    .line 251
    :cond_3
    :goto_1
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    if-nez v0, :cond_4

    .line 252
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v1, "kbd_bg"

    invoke-static {p2, v0, v1, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    goto/16 :goto_0

    .line 245
    :catch_0
    move-exception v0

    .line 246
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 247
    :catch_1
    move-exception v0

    .line 248
    iput-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mBg:Landroid/graphics/Bitmap;

    goto :goto_1

    .line 255
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

    .line 588
    const/high16 v0, 0x40200000    # 2.5f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v1

    .line 589
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 590
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 591
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 592
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 593
    const/high16 v1, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v1, v2

    .line 594
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

    .line 595
    const/high16 v0, 0x41100000    # 9.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v0, v1

    .line 596
    int-to-float v0, p2

    sub-float/2addr v0, v6

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v8

    sub-float v7, v0, v1

    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v0, v8

    add-float v8, v6, v0

    .line 597
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 598
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 599
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v7, v8, v6, v0}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 600
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 601
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v9

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 602
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 603
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

    .line 604
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

    .line 605
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 606
    return-void
.end method

.method private bar(Landroid/graphics/Canvas;Landroid/content/Context;FFF)V
    .locals 15

    .prologue
    .line 268
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    move-object/from16 v0, p2

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrThemeColors;->ink(Landroid/content/Context;Ljava/lang/String;)I

    move-result v10

    .line 269
    mul-float v11, p4, p5

    .line 270
    const/high16 v1, 0x40400000    # 3.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    add-float/2addr v1, v11

    const/high16 v2, 0x40000000    # 2.0f

    div-float v12, v1, v2

    .line 271
    const v1, 0x3e6147ae    # 0.22f

    mul-float v13, v11, v1

    .line 272
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    sget-object v2, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v2, v2

    add-int/lit8 v2, v2, -0x1

    int-to-float v2, v2

    mul-float/2addr v2, v1

    .line 273
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v4, v3

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v4, :cond_0

    aget v5, v3, v1

    mul-float v5, v5, p3

    add-float/2addr v2, v5

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 274
    :cond_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 275
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 276
    sub-float v1, p3, v2

    const/high16 v2, 0x40000000    # 2.0f

    div-float v2, v1, v2

    .line 277
    const/4 v1, 0x0

    move v9, v1

    :goto_1
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    if-ge v9, v1, :cond_2

    .line 278
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    aget v1, v1, v9

    mul-float v14, p3, v1

    .line 279
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const v3, 0x3f333333    # 0.7f

    invoke-static {v10, v3}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 280
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

    .line 281
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    add-float/2addr v1, v14

    add-float v7, v2, v1

    .line 282
    sget-object v1, Lcom/mrkeyboard/app/MrThemePreview;->WORDS:[F

    array-length v1, v1

    add-int/lit8 v1, v1, -0x1

    if-ge v9, v1, :cond_1

    .line 283
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v2, 0x3e800000    # 0.25f

    invoke-static {v10, v2}, Lcom/mrkeyboard/app/MrThemePreview;->withAlpha(IF)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 284
    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    sub-float v1, v7, v1

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float v2, v1, v2

    const v1, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v11

    sub-float v3, v12, v1

    const v1, 0x3de147ae    # 0.11f

    mul-float v1, v1, p3

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v1, v4

    sub-float v1, v7, v1

    const/high16 v4, 0x3f800000    # 1.0f

    add-float/2addr v4, v1

    const v1, 0x3e6147ae    # 0.22f

    mul-float/2addr v1, v11

    add-float v5, v12, v1

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object/from16 v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 277
    :cond_1
    add-int/lit8 v1, v9, 0x1

    move v9, v1

    move v2, v7

    goto :goto_1

    .line 287
    :cond_2
    return-void
.end method

.method private static corner(Landroid/graphics/Path;FFFFI)V
    .locals 8

    .prologue
    .line 628
    const/4 v0, 0x1

    :goto_0
    if-gt v0, p5, :cond_0

    .line 629
    float-to-double v2, p4

    const-wide v4, 0x4056800000000000L    # 90.0

    int-to-double v6, v0

    mul-double/2addr v4, v6

    int-to-double v6, p5

    div-double/2addr v4, v6

    add-double/2addr v2, v4

    invoke-static {v2, v3}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v2

    .line 630
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

    .line 628
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 632
    :cond_0
    return-void
.end method

.method private dash(Landroid/graphics/Canvas;III)V
    .locals 8

    .prologue
    const/4 v4, 0x3

    const/high16 v7, 0x40000000    # 2.0f

    .line 457
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 458
    if-ne p4, v4, :cond_2

    const-string v0, "modifier_indicator_lock"

    .line 459
    :goto_0
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const v3, -0x7f7f80

    invoke-static {v1, v2, v0, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v0

    .line 460
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    if-eqz v1, :cond_0

    if-eq p4, v4, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v0

    .line 461
    :cond_0
    const/4 v1, 0x1

    if-ne p4, v1, :cond_1

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {v0}, Lcom/mrkeyboard/app/MrKeyLook;->dashOff(I)I

    move-result v0

    .line 462
    :cond_1
    const/high16 v1, 0x41600000    # 14.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    int-to-float v2, p2

    const v3, 0x3e99999a    # 0.3f

    mul-float/2addr v2, v3

    invoke-static {v1, v2}, Ljava/lang/Math;->min(FF)F

    move-result v3

    const/high16 v1, 0x40400000    # 3.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v1, v2

    .line 463
    int-to-float v1, p3

    const/high16 v2, 0x41000000    # 8.0f

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v2, v4

    sub-float v4, v1, v2

    .line 464
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 465
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 466
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 467
    int-to-float v0, p2

    div-float/2addr v0, v7

    div-float v1, v3, v7

    sub-float v1, v0, v1

    sub-float v2, v4, v6

    int-to-float v0, p2

    div-float/2addr v0, v7

    div-float/2addr v3, v7

    add-float/2addr v3, v0

    div-float v5, v6, v7

    div-float/2addr v6, v7

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 468
    return-void

    .line 458
    :cond_2
    const/4 v0, 0x2

    if-ne p4, v0, :cond_3

    const-string v0, "modifier_indicator_on"

    goto :goto_0

    :cond_3
    const-string v0, "modifier_indicator_off"

    goto :goto_0
.end method

.method private static face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 575
    if-nez p1, :cond_1

    .line 582
    :cond_0
    :goto_0
    return-object v0

    .line 577
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    .line 578
    if-eqz v1, :cond_0

    .line 579
    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v2

    .line 580
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

    .line 581
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private faces(Landroid/content/Context;)V
    .locals 6

    .prologue
    const/16 v5, 0x31

    const/4 v3, 0x1

    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 519
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    if-nez v2, :cond_3

    :cond_0
    move v2, v3

    .line 520
    :goto_0
    if-nez v2, :cond_1

    .line 521
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    .line 522
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {p1, v4, v0}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v4

    invoke-static {p1, v4}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    .line 523
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {p1, v4, v3}, Lcom/mrkeyboard/app/MrThemeColors;->keyDrawable(Landroid/content/Context;Ljava/lang/String;Z)I

    move-result v4

    invoke-static {p1, v4}, Lcom/mrkeyboard/app/MrThemePreview;->face(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    iput-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    .line 524
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 526
    :cond_1
    if-eqz v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    if-ne v2, v4, :cond_4

    .line 540
    :goto_1
    return-void

    .line 519
    :cond_2
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFaceTag:Ljava/lang/String;

    invoke-virtual {v2, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    :cond_3
    move v2, v0

    goto :goto_0

    .line 527
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iput-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFacesLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 528
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_start"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    .line 529
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_mid"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    .line 530
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "spectrum_end"

    invoke-static {p1, v2, v4}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    .line 531
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v2

    if-eqz v2, :cond_6

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-static {v2, v4}, Lcom/mrkeyboard/app/MrKeyLook;->spectrum(Ljava/lang/String;Lcom/mrkeyboard/app/MrKeyLook;)[I

    move-result-object v2

    .line 532
    :goto_2
    if-eqz v2, :cond_5

    .line 533
    aget v4, v2, v0

    iput v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    .line 534
    aget v3, v2, v3

    iput v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    .line 535
    const/4 v3, 0x2

    aget v2, v2, v3

    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    .line 537
    :cond_5
    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    if-nez v2, :cond_7

    :goto_3
    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    .line 538
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-nez v0, :cond_8

    move-object v0, v1

    :goto_4
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    .line 539
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-nez v0, :cond_9

    :goto_5
    iput-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    goto :goto_1

    :cond_6
    move-object v2, v1

    .line 531
    goto :goto_2

    .line 537
    :cond_7
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v2, "glow"

    invoke-static {p1, v0, v2}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    goto :goto_3

    .line 538
    :cond_8
    new-array v0, v5, [[F

    goto :goto_4

    .line 539
    :cond_9
    new-array v1, v5, [Landroid/graphics/ColorFilter;

    goto :goto_5
.end method

.method private flat(Landroid/graphics/Canvas;IIZI)V
    .locals 12

    .prologue
    .line 472
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v6

    .line 473
    const/4 v1, 0x2

    move/from16 v0, p5

    if-ne v0, v1, :cond_1

    const-string v1, "lock"

    move-object v5, v1

    .line 474
    :goto_0
    if-eqz p4, :cond_3

    const-string v1, "key_acc_normal_"

    move-object v2, v1

    .line 475
    :goto_1
    if-eqz p4, :cond_4

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "key_acc_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 477
    :goto_2
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v7, "fill"

    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "top"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const v9, -0xc5c0b9

    invoke-static {v6, v7, v8, v9}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v7

    invoke-static {v6, v3, v4, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    .line 478
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "lip"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v9, "bottom"

    invoke-virtual {v2, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v6, v8, v2, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    invoke-static {v6, v4, v7, v2}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v2

    .line 479
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "fill"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "top"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v6, v8, v9, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    invoke-static {v6, v4, v7, v3}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v3

    .line 480
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v8, "lip"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v9, "bottom"

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    if-nez p5, :cond_5

    move v1, v2

    :goto_3
    invoke-static {v6, v8, v9, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v1

    invoke-static {v6, v4, v7, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v4

    .line 482
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz p4, :cond_6

    const-string v1, "key_acc_"

    :goto_4
    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v5, "_edge"

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v6, v2, v1}, Lcom/mrkeyboard/app/MrThemeColors;->own(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 483
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    if-eqz v1, :cond_c

    .line 484
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v3}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v1

    .line 485
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v3, v4}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v3

    .line 486
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v4, v2}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result v2

    move v4, v1

    .line 488
    :goto_5
    if-ne v3, v4, :cond_7

    ushr-int/lit8 v1, v4, 0x18

    const/16 v5, 0xff

    if-eq v1, v5, :cond_7

    const/4 v1, 0x1

    .line 489
    :goto_6
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v5

    if-eqz v5, :cond_b

    .line 491
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v4, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v4

    .line 492
    if-eqz v1, :cond_8

    move v3, v4

    .line 493
    :goto_7
    if-nez v2, :cond_9

    const/4 v2, 0x0

    :goto_8
    move v9, v2

    move v10, v4

    .line 495
    :goto_9
    const/high16 v2, 0x40400000    # 3.0f

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v2, v4

    const/high16 v4, 0x41000000    # 8.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v6, v4, v5

    .line 496
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 497
    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v5, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 498
    if-eqz v1, :cond_a

    .line 500
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v10}, Landroid/graphics/Paint;->setColor(I)V

    .line 501
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 502
    if-eqz v9, :cond_0

    .line 503
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 504
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 505
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v9}, Landroid/graphics/Paint;->setColor(I)V

    .line 506
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 507
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 515
    :cond_0
    :goto_a
    return-void

    .line 473
    :cond_1
    const/4 v1, 0x1

    move/from16 v0, p5

    if-ne v0, v1, :cond_2

    const-string v1, "on"

    move-object v5, v1

    goto/16 :goto_0

    :cond_2
    const-string v1, "normal"

    move-object v5, v1

    goto/16 :goto_0

    .line 474
    :cond_3
    const-string v1, "key_normal_"

    move-object v2, v1

    goto/16 :goto_1

    .line 475
    :cond_4
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "key_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto/16 :goto_2

    :cond_5
    move v1, v3

    .line 480
    goto/16 :goto_3

    .line 482
    :cond_6
    const-string v1, "key_"

    goto/16 :goto_4

    .line 488
    :cond_7
    const/4 v1, 0x0

    goto/16 :goto_6

    .line 492
    :cond_8
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v3, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v3

    goto/16 :goto_7

    .line 493
    :cond_9
    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    int-to-float v5, v5

    const/high16 v6, 0x42c80000    # 100.0f

    div-float/2addr v5, v6

    invoke-static {v2, v5}, Lcom/mrkeyboard/app/MrGlow;->scale(IF)I

    move-result v2

    goto/16 :goto_8

    .line 511
    :cond_a
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 512
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float v5, v1, v2

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 513
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v10}, Landroid/graphics/Paint;->setColor(I)V

    .line 514
    int-to-float v1, p2

    sub-float v4, v1, v2

    int-to-float v1, p3

    sub-float/2addr v1, v2

    const/high16 v3, 0x40000000    # 2.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v3, v5

    sub-float v5, v1, v3

    iget-object v8, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v1, p1

    move v3, v2

    move v7, v6

    invoke-virtual/range {v1 .. v8}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    goto/16 :goto_a

    :cond_b
    move v9, v2

    move v10, v4

    goto/16 :goto_9

    :cond_c
    move v11, v4

    move v4, v3

    move v3, v11

    goto/16 :goto_5
.end method

.method private fullKeys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 53

    .prologue
    .line 348
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->faces(Landroid/content/Context;)V

    .line 349
    const v3, 0x3df5c28f    # 0.12f

    mul-float v6, p4, v3

    .line 350
    move-object/from16 v0, p0

    move/from16 v1, p3

    move/from16 v2, p4

    invoke-direct {v0, v1, v6, v2}, Lcom/mrkeyboard/app/MrThemePreview;->area(FFF)V

    .line 351
    const v3, 0x3c03126f    # 0.008f

    mul-float v30, p3, v3

    .line 352
    sub-float v3, p4, v6

    const/high16 v4, 0x40c00000    # 6.0f

    div-float v8, v3, v4

    .line 353
    const/high16 v3, 0x40000000    # 2.0f

    mul-float v3, v3, v30

    sub-float v52, p3, v3

    .line 354
    const/high16 v3, 0x41200000    # 10.0f

    div-float v18, v52, v3

    .line 355
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "text"

    const/4 v5, -0x1

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4, v5}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v22

    .line 356
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "accent_text"

    move-object/from16 v0, p2

    move/from16 v1, v22

    invoke-static {v0, v3, v4, v1}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v36

    .line 357
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v3, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-eqz v3, :cond_0

    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v3, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    move/from16 v36, v0

    move/from16 v22, v36

    .line 358
    :cond_0
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v4, "glow"

    move-object/from16 v0, p2

    invoke-static {v0, v3, v4}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v12

    .line 359
    if-nez v12, :cond_1

    const/4 v13, 0x0

    .line 360
    :goto_0
    const v3, 0x3ed70a3d    # 0.42f

    mul-float v27, v8, v3

    const v3, 0x3e99999a    # 0.3f

    mul-float v51, v8, v3

    .line 361
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    sget-object v4, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v3, v4}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 363
    const/4 v4, 0x0

    .line 364
    sget-object v5, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    array-length v7, v5

    const/4 v3, 0x0

    move/from16 v19, v4

    :goto_1
    if-ge v3, v7, :cond_2

    aget v4, v5, v3

    add-float v4, v4, v19

    add-int/lit8 v3, v3, 0x1

    move/from16 v19, v4

    goto :goto_1

    .line 359
    :cond_1
    const/high16 v3, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v13, v3, v4

    goto :goto_0

    .line 366
    :cond_2
    const/4 v3, 0x0

    move/from16 v17, v3

    move/from16 v5, v30

    :goto_2
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    array-length v3, v3

    move/from16 v0, v17

    if-ge v0, v3, :cond_6

    .line 367
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->MOD_WIDTHS:[F

    aget v3, v3, v17

    mul-float v3, v3, v52

    div-float v7, v3, v19

    .line 368
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->MOD_KEYS:[Z

    aget-boolean v9, v3, v17

    .line 369
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->MOD_LABELS:[Ljava/lang/String;

    aget-object v10, v3, v17

    .line 371
    if-eqz v9, :cond_3

    move/from16 v11, v36

    :goto_3
    const/4 v14, 0x0

    .line 372
    const/4 v3, 0x2

    move/from16 v0, v17

    if-ge v0, v3, :cond_4

    const/4 v15, 0x1

    :goto_4
    invoke-virtual {v10}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_5

    if-eqz v9, :cond_5

    const/4 v3, 0x2

    move/from16 v0, v17

    if-ge v0, v3, :cond_5

    move/from16 v16, v51

    :goto_5
    move-object/from16 v3, p0

    move-object/from16 v4, p1

    .line 371
    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 373
    add-float/2addr v5, v7

    .line 366
    add-int/lit8 v3, v17, 0x1

    move/from16 v17, v3

    goto :goto_2

    :cond_3
    move/from16 v11, v22

    .line 371
    goto :goto_3

    .line 372
    :cond_4
    const/4 v15, 0x0

    goto :goto_4

    :cond_5
    move/from16 v16, v27

    goto :goto_5

    .line 376
    :cond_6
    const-string v4, "1234567890"

    .line 377
    const/4 v3, 0x0

    :goto_6
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v3, v5, :cond_7

    .line 378
    int-to-float v5, v3

    mul-float v5, v5, v18

    add-float v16, v30, v5

    add-float v17, v6, v8

    const/16 v20, 0x0

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v21

    const/16 v25, 0x0

    const/16 v26, 0x0

    move-object/from16 v14, p0

    move-object/from16 v15, p1

    move/from16 v19, v8

    move/from16 v23, v12

    move/from16 v24, v13

    invoke-direct/range {v14 .. v27}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 377
    add-int/lit8 v3, v3, 0x1

    goto :goto_6

    .line 380
    :cond_7
    const/4 v3, 0x0

    move v5, v3

    :goto_7
    const/4 v3, 0x3

    if-ge v5, v3, :cond_a

    .line 381
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    aget-object v7, v3, v5

    .line 382
    add-int/lit8 v3, v5, 0x2

    int-to-float v3, v3

    mul-float/2addr v3, v8

    add-float v31, v6, v3

    .line 383
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v3

    int-to-float v3, v3

    mul-float v3, v3, v18

    .line 384
    const/high16 v4, 0x41200000    # 10.0f

    mul-float v4, v4, v18

    sub-float v3, v4, v3

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    add-float v3, v3, v30

    .line 385
    const/4 v4, 0x2

    if-ne v5, v4, :cond_8

    .line 387
    const v3, 0x3e19999a    # 0.15f

    mul-float v32, v52, v3

    .line 388
    const/16 v34, 0x1

    const-string v35, "\u21e7"

    const/16 v39, 0x0

    const/16 v40, 0x1

    move-object/from16 v28, p0

    move-object/from16 v29, p1

    move/from16 v33, v8

    move/from16 v37, v12

    move/from16 v38, v13

    move/from16 v41, v27

    invoke-direct/range {v28 .. v41}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 389
    add-float v3, v30, v52

    sub-float v39, v3, v32

    const/16 v43, 0x1

    const-string v44, "\u232b"

    const/16 v48, 0x0

    const/16 v49, 0x0

    move-object/from16 v37, p0

    move-object/from16 v38, p1

    move/from16 v40, v31

    move/from16 v41, v32

    move/from16 v42, v8

    move/from16 v45, v36

    move/from16 v46, v12

    move/from16 v47, v13

    move/from16 v50, v27

    invoke-direct/range {v37 .. v50}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 390
    add-float v3, v30, v32

    .line 392
    :cond_8
    const/4 v4, 0x0

    :goto_8
    invoke-virtual {v7}, Ljava/lang/String;->length()I

    move-result v9

    if-ge v4, v9, :cond_9

    .line 393
    int-to-float v9, v4

    mul-float v9, v9, v18

    add-float v16, v3, v9

    const/16 v20, 0x0

    invoke-virtual {v7, v4}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v21

    const/16 v25, 0x0

    const/16 v26, 0x0

    move-object/from16 v14, p0

    move-object/from16 v15, p1

    move/from16 v17, v31

    move/from16 v19, v8

    move/from16 v23, v12

    move/from16 v24, v13

    invoke-direct/range {v14 .. v27}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 392
    add-int/lit8 v4, v4, 0x1

    goto :goto_8

    .line 380
    :cond_9
    add-int/lit8 v3, v5, 0x1

    move v5, v3

    goto/16 :goto_7

    .line 397
    :cond_a
    const/high16 v3, 0x40a00000    # 5.0f

    mul-float/2addr v3, v8

    add-float/2addr v6, v3

    .line 398
    const v3, 0x3e4ccccd    # 0.2f

    mul-float v7, v52, v3

    const v3, 0x3ecccccd    # 0.4f

    mul-float v17, v52, v3

    .line 400
    const/4 v9, 0x1

    const-string v10, "123"

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v5, v30

    move/from16 v11, v36

    move/from16 v16, v51

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 401
    add-float v30, v30, v7

    .line 402
    const/16 v34, 0x1

    const-string v35, "F1"

    const/16 v39, 0x0

    const/16 v40, 0x0

    move-object/from16 v28, p0

    move-object/from16 v29, p1

    move/from16 v31, v6

    move/from16 v32, v18

    move/from16 v33, v8

    move/from16 v37, v12

    move/from16 v38, v13

    move/from16 v41, v51

    invoke-direct/range {v28 .. v41}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 403
    add-float v39, v30, v18

    .line 404
    const/16 v43, 0x0

    const-string v44, ""

    const/16 v48, 0x0

    const/16 v49, 0x0

    move-object/from16 v37, p0

    move-object/from16 v38, p1

    move/from16 v40, v6

    move/from16 v41, v17

    move/from16 v42, v8

    move/from16 v45, v22

    move/from16 v46, v12

    move/from16 v47, v13

    move/from16 v50, v27

    invoke-direct/range {v37 .. v50}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 405
    add-float v16, v39, v17

    .line 406
    const/16 v20, 0x0

    const-string v21, "."

    const/16 v25, 0x0

    const/16 v26, 0x0

    move-object/from16 v14, p0

    move-object/from16 v15, p1

    move/from16 v17, v6

    move/from16 v19, v8

    move/from16 v23, v12

    move/from16 v24, v13

    invoke-direct/range {v14 .. v27}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 407
    add-float v5, v16, v18

    .line 408
    const/4 v9, 0x1

    const-string v10, "\u23ce"

    const/4 v14, 0x0

    const/4 v15, 0x0

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move/from16 v11, v36

    move/from16 v16, v27

    invoke-direct/range {v3 .. v16}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 409
    return-void
.end method

.method private key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V
    .locals 14

    .prologue
    .line 413
    const/4 v11, 0x0

    const/4 v12, 0x0

    const/4 v13, 0x0

    move-object v0, p0

    move-object v1, p1

    move/from16 v2, p2

    move/from16 v3, p3

    move/from16 v4, p4

    move/from16 v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    invoke-direct/range {v0 .. v13}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V

    .line 414
    return-void
.end method

.method private key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIFIIF)V
    .locals 9

    .prologue
    .line 421
    const/4 v2, 0x1

    invoke-static {p4}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v4

    const/4 v2, 0x1

    invoke-static {p5}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->max(II)I

    move-result v5

    .line 422
    if-eqz p6, :cond_6

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAccent:Landroid/graphics/drawable/Drawable;

    .line 424
    :goto_0
    invoke-direct {p0, p2, p3, p4, p5}, Lcom/mrkeyboard/app/MrThemePreview;->spectrum(FFFF)V

    .line 425
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 426
    if-eqz v3, :cond_2

    .line 427
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v6

    if-eqz v6, :cond_0

    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v6, v6, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-nez v6, :cond_1

    :cond_0
    move/from16 v0, p8

    invoke-static {v3, v0}, Lcom/mrkeyboard/app/MrGlow;->map([FI)I

    move-result p8

    .line 428
    :cond_1
    const/4 v3, 0x0

    cmpl-float v3, p10, v3

    if-lez v3, :cond_2

    const/high16 v3, -0x1000000

    and-int v3, v3, p9

    iget v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentHue:I

    const v7, 0xffffff

    and-int/2addr v6, v7

    or-int p9, v3, v6

    .line 430
    :cond_2
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 431
    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 432
    if-eqz v2, :cond_d

    .line 433
    const/4 v3, 0x0

    const/4 v6, 0x0

    invoke-virtual {v2, v3, v6, v4, v5}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 435
    const/4 v3, 0x2

    move/from16 v0, p11

    if-ne v0, v3, :cond_7

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_LOCK:[I

    :goto_1
    invoke-virtual {v2, v3}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 436
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v2, v4, v5, v3}, Lcom/mrkeyboard/app/KeyStyle;->prepare(Landroid/graphics/drawable/Drawable;IILandroid/content/Context;)V

    .line 437
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v3

    if-eqz v3, :cond_a

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    invoke-virtual {v3}, Lcom/mrkeyboard/app/MrKeyLook;->faceTuned()Z

    move-result v3

    if-eqz v3, :cond_a

    const/4 v3, 0x1

    .line 438
    :goto_2
    iget-object v6, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    if-eqz v3, :cond_b

    const/4 v7, 0x1

    invoke-direct {p0, v7}, Lcom/mrkeyboard/app/MrThemePreview;->opacityFilter(Z)Landroid/graphics/ColorFilter;

    move-result-object v7

    :goto_3
    if-eqz v3, :cond_c

    const/4 v3, 0x0

    invoke-direct {p0, v3}, Lcom/mrkeyboard/app/MrThemePreview;->opacityFilter(Z)Landroid/graphics/ColorFilter;

    move-result-object v8

    :goto_4
    move-object v3, p1

    invoke-static/range {v2 .. v8}, Lcom/mrkeyboard/app/MrGlow;->drawFace(Landroid/graphics/drawable/Drawable;Landroid/graphics/Canvas;IILandroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;Landroid/graphics/ColorFilter;)V

    .line 442
    :goto_5
    if-eqz p12, :cond_3

    move/from16 v0, p12

    invoke-direct {p0, p1, v4, v5, v0}, Lcom/mrkeyboard/app/MrThemePreview;->dash(Landroid/graphics/Canvas;III)V

    .line 443
    :cond_3
    invoke-virtual/range {p7 .. p7}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_5

    .line 444
    const/4 v2, 0x0

    cmpl-float v2, p13, v2

    if-lez v2, :cond_4

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move/from16 v0, p13

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 445
    :cond_4
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move/from16 v0, p8

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 446
    const/4 v2, 0x0

    cmpl-float v2, p10, v2

    if-lez v2, :cond_e

    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    const/4 v3, 0x0

    const/4 v6, 0x0

    move/from16 v0, p10

    move/from16 v1, p9

    invoke-virtual {v2, v0, v3, v6, v1}, Landroid/graphics/Paint;->setShadowLayer(FFFI)V

    .line 448
    :goto_6
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->getFontMetrics(Landroid/graphics/Paint$FontMetrics;)F

    .line 449
    int-to-float v2, v4

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    int-to-float v3, v5

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v4, v4, Landroid/graphics/Paint$FontMetrics;->ascent:F

    iget-object v5, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMetrics:Landroid/graphics/Paint$FontMetrics;

    iget v5, v5, Landroid/graphics/Paint$FontMetrics;->descent:F

    add-float/2addr v4, v5

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v4, v5

    sub-float/2addr v3, v4

    iget-object v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    move-object/from16 v0, p7

    invoke-virtual {p1, v0, v2, v3, v4}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 450
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->clearShadowLayer()V

    .line 452
    :cond_5
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 453
    return-void

    .line 422
    :cond_6
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFace:Landroid/graphics/drawable/Drawable;

    goto/16 :goto_0

    .line 435
    :cond_7
    const/4 v3, 0x1

    move/from16 v0, p11

    if-ne v0, v3, :cond_8

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_ON:[I

    goto/16 :goto_1

    :cond_8
    if-eqz p12, :cond_9

    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_MOD:[I

    goto/16 :goto_1

    :cond_9
    sget-object v3, Lcom/mrkeyboard/app/MrThemePreview;->STATE_NORMAL:[I

    goto/16 :goto_1

    .line 437
    :cond_a
    const/4 v3, 0x0

    goto/16 :goto_2

    .line 438
    :cond_b
    const/4 v7, 0x0

    goto/16 :goto_3

    :cond_c
    const/4 v8, 0x0

    goto :goto_4

    :cond_d
    move-object v2, p0

    move-object v3, p1

    move v6, p6

    move/from16 v7, p11

    .line 440
    invoke-direct/range {v2 .. v7}, Lcom/mrkeyboard/app/MrThemePreview;->flat(Landroid/graphics/Canvas;IIZI)V

    goto/16 :goto_5

    .line 447
    :cond_e
    iget-object v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    invoke-virtual {v2}, Landroid/graphics/Paint;->clearShadowLayer()V

    goto :goto_6
.end method

.method private keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V
    .locals 37

    .prologue
    .line 290
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-direct {v0, v1}, Lcom/mrkeyboard/app/MrThemePreview;->faces(Landroid/content/Context;)V

    .line 291
    const v4, 0x3e2e147b    # 0.17f

    mul-float v33, p4, v4

    .line 292
    move-object/from16 v0, p0

    move/from16 v1, p3

    move/from16 v2, v33

    move/from16 v3, p4

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrThemePreview;->area(FFF)V

    .line 293
    const v4, 0x3c03126f    # 0.008f

    mul-float v6, p3, v4

    .line 294
    sub-float v4, p4, v33

    const/high16 v5, 0x40800000    # 4.0f

    div-float v9, v4, v5

    .line 295
    const/high16 v4, 0x40000000    # 2.0f

    mul-float/2addr v4, v6

    sub-float v4, p3, v4

    const/high16 v5, 0x41200000    # 10.0f

    div-float v34, v4, v5

    .line 296
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v5, "text"

    const/4 v7, -0x1

    move-object/from16 v0, p2

    invoke-static {v0, v4, v5, v7}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v12

    .line 297
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v5, "accent_text"

    move-object/from16 v0, p2

    invoke-static {v0, v4, v5, v12}, Lcom/mrkeyboard/app/MrThemeColors;->colorOr(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;I)I

    move-result v4

    .line 298
    invoke-direct/range {p0 .. p0}, Lcom/mrkeyboard/app/MrThemePreview;->tuned()Z

    move-result v5

    if-eqz v5, :cond_5

    move-object/from16 v0, p0

    iget-object v5, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v5, v5, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    if-eqz v5, :cond_5

    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v4, v4, Lcom/mrkeyboard/app/MrKeyLook;->text:I

    move/from16 v31, v4

    move v12, v4

    .line 300
    :goto_0
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    const-string v5, "glow"

    move-object/from16 v0, p2

    invoke-static {v0, v4, v5}, Lcom/mrkeyboard/app/MrThemeColors;->declared(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v13

    .line 301
    if-nez v13, :cond_1

    const/4 v14, 0x0

    .line 302
    :goto_1
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    sget-object v5, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 303
    move-object/from16 v0, p0

    iget-object v4, v0, Lcom/mrkeyboard/app/MrThemePreview;->mText:Landroid/graphics/Paint;

    const v5, 0x3ed70a3d    # 0.42f

    mul-float/2addr v5, v9

    invoke-virtual {v4, v5}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 304
    const/4 v4, 0x0

    move/from16 v32, v4

    :goto_2
    const/4 v4, 0x4

    move/from16 v0, v32

    if-ge v0, v4, :cond_4

    .line 305
    move/from16 v0, v32

    int-to-float v4, v0

    mul-float/2addr v4, v9

    add-float v7, v33, v4

    .line 306
    const/4 v4, 0x3

    move/from16 v0, v32

    if-ge v0, v4, :cond_2

    .line 307
    sget-object v4, Lcom/mrkeyboard/app/MrThemePreview;->ROWS:[Ljava/lang/String;

    aget-object v26, v4, v32

    .line 308
    invoke-virtual/range {v26 .. v26}, Ljava/lang/String;->length()I

    move-result v4

    int-to-float v4, v4

    mul-float v4, v4, v34

    .line 309
    const/high16 v5, 0x41200000    # 10.0f

    mul-float v5, v5, v34

    sub-float/2addr v5, v4

    const/high16 v8, 0x40000000    # 2.0f

    div-float/2addr v5, v8

    add-float v27, v6, v5

    .line 310
    const/4 v5, 0x2

    move/from16 v0, v32

    if-ne v0, v5, :cond_0

    .line 312
    const/high16 v5, 0x41200000    # 10.0f

    mul-float v5, v5, v34

    sub-float v4, v5, v4

    const/high16 v5, 0x40000000    # 2.0f

    div-float/2addr v4, v5

    const v5, 0x3dcccccd    # 0.1f

    mul-float v5, v5, v34

    sub-float v8, v4, v5

    .line 313
    const/4 v10, 0x0

    const-string v11, "\u21e7"

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-direct/range {v4 .. v14}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 314
    const/high16 v4, 0x41200000    # 10.0f

    mul-float v4, v4, v34

    add-float/2addr v4, v6

    sub-float v17, v4, v8

    const/16 v21, 0x0

    const-string v22, "\u232b"

    move-object/from16 v15, p0

    move-object/from16 v16, p1

    move/from16 v18, v7

    move/from16 v19, v8

    move/from16 v20, v9

    move/from16 v23, v12

    move/from16 v24, v13

    move/from16 v25, v14

    invoke-direct/range {v15 .. v25}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 316
    :cond_0
    const/4 v4, 0x0

    :goto_3
    invoke-virtual/range {v26 .. v26}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v4, v5, :cond_3

    .line 317
    int-to-float v5, v4

    mul-float v5, v5, v34

    add-float v17, v27, v5

    const/16 v21, 0x0

    move-object/from16 v0, v26

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-static {v5}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v22

    move-object/from16 v15, p0

    move-object/from16 v16, p1

    move/from16 v18, v7

    move/from16 v19, v34

    move/from16 v20, v9

    move/from16 v23, v12

    move/from16 v24, v13

    move/from16 v25, v14

    invoke-direct/range {v15 .. v25}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 316
    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    .line 301
    :cond_1
    const/high16 v4, 0x40a00000    # 5.0f

    move-object/from16 v0, p0

    iget v5, v0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v14, v4, v5

    goto/16 :goto_1

    .line 320
    :cond_2
    const v4, 0x3fa66666    # 1.3f

    mul-float v8, v34, v4

    const/high16 v4, 0x3f800000    # 1.0f

    mul-float v19, v34, v4

    const v4, 0x3fd9999a    # 1.7f

    mul-float v35, v34, v4

    .line 321
    const/high16 v4, 0x41200000    # 10.0f

    mul-float v4, v4, v34

    sub-float/2addr v4, v8

    const/high16 v5, 0x40000000    # 2.0f

    mul-float v5, v5, v19

    sub-float/2addr v4, v5

    sub-float v36, v4, v35

    .line 323
    const/4 v10, 0x0

    const-string v11, "?123"

    move-object/from16 v4, p0

    move-object/from16 v5, p1

    invoke-direct/range {v4 .. v14}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 324
    add-float v17, v6, v8

    .line 325
    const/16 v21, 0x0

    const-string v22, ","

    move-object/from16 v15, p0

    move-object/from16 v16, p1

    move/from16 v18, v7

    move/from16 v20, v9

    move/from16 v23, v12

    move/from16 v24, v13

    move/from16 v25, v14

    invoke-direct/range {v15 .. v25}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 326
    add-float v22, v17, v19

    .line 327
    const/16 v26, 0x0

    const-string v27, ""

    move-object/from16 v20, p0

    move-object/from16 v21, p1

    move/from16 v23, v7

    move/from16 v24, v36

    move/from16 v25, v9

    move/from16 v28, v12

    move/from16 v29, v13

    move/from16 v30, v14

    invoke-direct/range {v20 .. v30}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 328
    add-float v17, v22, v36

    .line 329
    const/16 v21, 0x0

    const-string v22, "."

    move-object/from16 v15, p0

    move-object/from16 v16, p1

    move/from16 v18, v7

    move/from16 v20, v9

    move/from16 v23, v12

    move/from16 v24, v13

    move/from16 v25, v14

    invoke-direct/range {v15 .. v25}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 330
    add-float v17, v17, v19

    .line 331
    const/16 v21, 0x1

    const-string v22, "\u23ce"

    move-object/from16 v15, p0

    move-object/from16 v16, p1

    move/from16 v18, v7

    move/from16 v19, v35

    move/from16 v20, v9

    move/from16 v23, v31

    move/from16 v24, v13

    move/from16 v25, v14

    invoke-direct/range {v15 .. v25}, Lcom/mrkeyboard/app/MrThemePreview;->key(Landroid/graphics/Canvas;FFFFZLjava/lang/String;IIF)V

    .line 304
    :cond_3
    add-int/lit8 v4, v32, 0x1

    move/from16 v32, v4

    goto/16 :goto_2

    .line 334
    :cond_4
    return-void

    :cond_5
    move/from16 v31, v4

    goto/16 :goto_0
.end method

.method private opacityFilter(Z)Landroid/graphics/ColorFilter;
    .locals 2

    .prologue
    .line 544
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->key:I

    :goto_0
    int-to-float v0, v0

    const/high16 v1, 0x42c80000    # 100.0f

    div-float/2addr v0, v1

    .line 545
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    invoke-static {v1, v0}, Lcom/mrkeyboard/app/MrGlow;->filter([FF)Landroid/graphics/ColorFilter;

    move-result-object v0

    return-object v0

    .line 544
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    iget v0, v0, Lcom/mrkeyboard/app/MrKeyLook;->edge:I

    goto :goto_0
.end method

.method private plus(Landroid/graphics/Canvas;II)V
    .locals 9

    .prologue
    const/4 v1, 0x0

    const/high16 v8, 0x40000000    # 2.0f

    .line 212
    const/high16 v0, 0x41400000    # 12.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float v5, v0, v2

    .line 213
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 214
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 215
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    invoke-virtual {v0, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 216
    int-to-float v3, p2

    int-to-float v4, p3

    iget-object v7, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    move v2, v1

    move v6, v5

    invoke-virtual/range {v0 .. v7}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 217
    const/high16 v0, 0x3f800000    # 1.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    invoke-static {v0, v1}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 218
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 219
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 220
    iget-object v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 221
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

    .line 222
    invoke-static {p2, p3}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const v1, 0x3e2e147b    # 0.17f

    mul-float v6, v0, v1

    .line 223
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x40200000    # 2.5f

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDensity:F

    mul-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 224
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 225
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

    .line 226
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

    .line 227
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 228
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, p2, p3}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    .line 229
    :cond_0
    return-void
.end method

.method static roundRect(FFF)Landroid/graphics/Path;
    .locals 12

    .prologue
    .line 610
    invoke-static {p0, p1}, Ljava/lang/Math;->min(FF)F

    move-result v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    invoke-static {p2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 611
    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    .line 612
    const/16 v5, 0x8

    .line 613
    const/4 v1, 0x0

    invoke-virtual {v0, v2, v1}, Landroid/graphics/Path;->moveTo(FF)V

    .line 614
    sub-float v1, p0, v2

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3}, Landroid/graphics/Path;->lineTo(FF)V

    .line 615
    sub-float v1, p0, v2

    const/high16 v4, -0x3d4c0000    # -90.0f

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 616
    sub-float v1, p1, v2

    invoke-virtual {v0, p0, v1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 617
    sub-float v7, p0, v2

    sub-float v8, p1, v2

    const/4 v10, 0x0

    move-object v6, v0

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 618
    invoke-virtual {v0, v2, p1}, Landroid/graphics/Path;->lineTo(FF)V

    .line 619
    sub-float v8, p1, v2

    const/high16 v10, 0x42b40000    # 90.0f

    move-object v6, v0

    move v7, v2

    move v9, v2

    move v11, v5

    invoke-static/range {v6 .. v11}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 620
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/graphics/Path;->lineTo(FF)V

    .line 621
    const/high16 v4, 0x43340000    # 180.0f

    move v1, v2

    move v3, v2

    invoke-static/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->corner(Landroid/graphics/Path;FFFFI)V

    .line 622
    invoke-virtual {v0}, Landroid/graphics/Path;->close()V

    .line 623
    return-object v0
.end method

.method private spectrum(FFFF)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    const/high16 v1, 0x40000000    # 2.0f

    .line 557
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 558
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    .line 559
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    if-nez v0, :cond_1

    .line 572
    :cond_0
    :goto_0
    return-void

    .line 560
    :cond_1
    div-float v0, p3, v1

    add-float/2addr v0, p1

    div-float v1, p4, v1

    add-float/2addr v1, p2

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaTop:F

    sub-float/2addr v1, v2

    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaW:F

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mAreaH:F

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    invoke-static {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrGlow;->step(FFII)I

    move-result v1

    .line 561
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    aget-object v0, v0, v1

    .line 562
    iget v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mStart:I

    iget v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMid:I

    iget v4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mEnd:I

    int-to-float v5, v1

    const/high16 v6, 0x42400000    # 48.0f

    div-float/2addr v5, v6

    invoke-static {v2, v3, v4, v5}, Lcom/mrkeyboard/app/MrGlow;->ramp(IIIF)I

    move-result v2

    .line 563
    if-nez v0, :cond_2

    .line 564
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFrom:I

    invoke-static {v0, v2}, Lcom/mrkeyboard/app/MrGlow;->remap(II)[F

    move-result-object v0

    .line 565
    if-eqz v0, :cond_0

    .line 566
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mMatrix:[[F

    aput-object v0, v3, v1

    .line 567
    iget-object v3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrGlow;->filter([F)Landroid/graphics/ColorFilter;

    move-result-object v4

    aput-object v4, v3, v1

    .line 569
    :cond_2
    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrent:[F

    .line 570
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFilter:[Landroid/graphics/ColorFilter;

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentFilter:Landroid/graphics/ColorFilter;

    .line 571
    iput v2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCurrentHue:I

    goto :goto_0
.end method

.method private tuned()Z
    .locals 1

    .prologue
    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrThemeColors;->hidden(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method static withAlpha(IF)I
    .locals 2

    .prologue
    .line 635
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
    .line 166
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    return v0
.end method

.method drawn()I
    .locals 1

    .prologue
    .line 171
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    return v0
.end method

.method full()Z
    .locals 1

    .prologue
    .line 144
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    return v0
.end method

.method look()Lcom/mrkeyboard/app/MrKeyLook;
    .locals 1

    .prologue
    .line 118
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    return-object v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 11

    .prologue
    .line 182
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getHeight()I

    move-result v4

    .line 183
    if-lez v3, :cond_0

    if-gtz v4, :cond_1

    .line 206
    :cond_0
    :goto_0
    return-void

    .line 184
    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mDrawn:I

    .line 185
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 186
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    if-eqz v0, :cond_2

    .line 187
    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->plus(Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 190
    :cond_2
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    invoke-static {v2, v0}, Lcom/mrkeyboard/app/MrThemeColors;->dark(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v5

    .line 191
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 192
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

    .line 193
    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrThemePreview;->background(Landroid/graphics/Canvas;Landroid/content/Context;IIZ)V

    .line 195
    iget v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mKeyWidthPx:I

    int-to-float v8, v0

    .line 196
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_3

    const v0, 0x3fd9999a    # 1.7f

    :goto_1
    div-float v9, v8, v0

    .line 197
    int-to-float v0, v3

    div-float/2addr v0, v8

    .line 198
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 199
    invoke-virtual {p1, v0, v0}, Landroid/graphics/Canvas;->scale(FF)V

    .line 200
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_4

    const v10, 0x3df5c28f    # 0.12f

    :goto_2
    move-object v5, p0

    move-object v6, p1

    move-object v7, v2

    invoke-direct/range {v5 .. v10}, Lcom/mrkeyboard/app/MrThemePreview;->bar(Landroid/graphics/Canvas;Landroid/content/Context;FFF)V

    .line 201
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_5

    invoke-direct {p0, p1, v2, v8, v9}, Lcom/mrkeyboard/app/MrThemePreview;->fullKeys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    .line 203
    :goto_3
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 204
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 205
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    if-eqz v0, :cond_0

    invoke-direct {p0, p1, v3, v4}, Lcom/mrkeyboard/app/MrThemePreview;->badge(Landroid/graphics/Canvas;II)V

    goto :goto_0

    .line 196
    :cond_3
    const v0, 0x4019999a    # 2.4f

    goto :goto_1

    .line 200
    :cond_4
    const v10, 0x3e2e147b    # 0.17f

    goto :goto_2

    .line 202
    :cond_5
    invoke-direct {p0, p1, v2, v8, v9}, Lcom/mrkeyboard/app/MrThemePreview;->keys(Landroid/graphics/Canvas;Landroid/content/Context;FF)V

    goto :goto_3
.end method

.method protected onMeasure(II)V
    .locals 3

    .prologue
    .line 176
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v1

    .line 177
    int-to-float v2, v1

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-eqz v0, :cond_0

    const v0, 0x3fd9999a    # 1.7f

    :goto_0
    div-float v0, v2, v0

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/MrThemePreview;->setMeasuredDimension(II)V

    .line 178
    return-void

    .line 177
    :cond_0
    const v0, 0x4019999a    # 2.4f

    goto :goto_0
.end method

.method setChecked(ZII)V
    .locals 0

    .prologue
    .line 149
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mChecked:Z

    .line 150
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mRing:I

    .line 151
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mCheck:I

    .line 152
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 153
    return-void
.end method

.method setFull(Z)V
    .locals 1

    .prologue
    .line 137
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    if-ne v0, p1, :cond_0

    .line 141
    :goto_0
    return-void

    .line 138
    :cond_0
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mFull:Z

    .line 139
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->requestLayout()V

    .line 140
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    goto :goto_0
.end method

.method setLook(Lcom/mrkeyboard/app/MrKeyLook;)V
    .locals 0

    .prologue
    .line 112
    if-nez p1, :cond_0

    sget-object p1, Lcom/mrkeyboard/app/MrKeyLook;->NONE:Lcom/mrkeyboard/app/MrKeyLook;

    :cond_0
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mLook:Lcom/mrkeyboard/app/MrKeyLook;

    .line 113
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 114
    return-void
.end method

.method show(Ljava/lang/String;Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;I)V
    .locals 1

    .prologue
    .line 102
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 103
    iput-object p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    .line 104
    if-nez p2, :cond_0

    sget-object p2, Lcom/mrkeyboard/app/MrBackdrop$Spec;->NO:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    :cond_0
    iput-object p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 105
    iput-object p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mImage:Landroid/graphics/Bitmap;

    .line 106
    iput p4, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSoft:I

    .line 107
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 108
    return-void
.end method

.method showPlus(III)V
    .locals 1

    .prologue
    .line 128
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlus:Z

    .line 129
    iput p1, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusFill:I

    .line 130
    iput p2, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusLine:I

    .line 131
    iput p3, p0, Lcom/mrkeyboard/app/MrThemePreview;->mPlusInk:I

    .line 132
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrThemePreview;->invalidate()V

    .line 133
    return-void
.end method

.method spec()Lcom/mrkeyboard/app/MrBackdrop$Spec;
    .locals 1

    .prologue
    .line 161
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    return-object v0
.end method

.method tag()Ljava/lang/String;
    .locals 1

    .prologue
    .line 157
    iget-object v0, p0, Lcom/mrkeyboard/app/MrThemePreview;->mTag:Ljava/lang/String;

    return-object v0
.end method
