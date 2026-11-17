.class final Lcom/mrkeyboard/app/MrRainDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "MrRainDrawable.java"


# static fields
.field static final BASE:Ljava/lang/String; = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ=+-*/<>:."

.field static final HEAD_ALPHA:F = 0.7f

.field static final HEAD_LIGHT:F = 0.55f

.field static final KANA:Ljava/lang/String; = "\uff71\uff72\uff73\uff74\uff75\uff76\uff77\uff78\uff79\uff7a\uff7b\uff7c\uff7d\uff7e\uff7f\uff80\uff81\uff82\uff83\uff84\uff85\uff86\uff87\uff88\uff89\uff8a\uff8b\uff8c\uff8d\uff8e\uff8f\uff90\uff91\uff92\uff93\uff94\uff95\uff96\uff97\uff98\uff99\uff9a\uff9b\uff9c\uff9d"

.field static final LEVELS:I = 0xc

.field static final STEP_MS:J = 0x50L

.field static final TEXT_DP:F = 15.0f

.field static final TRAIL_ALPHA:F = 0.3f


# instance fields
.field private final mBackground:I

.field private final mBeat:Ljava/lang/Runnable;

.field private mCellH:F

.field private mCellW:F

.field private final mGlyphs:[Ljava/lang/String;

.field private final mHead:I

.field private mHeight:I

.field private final mPaint:Landroid/graphics/Paint;

.field private final mRain:Lcom/mrkeyboard/app/MrRain;

.field private mScheduled:Z

.field private final mTextPx:F

.field private final mTrail:[I

.field private mWidth:I


# direct methods
.method constructor <init>(IIF)V
    .locals 4

    .prologue
    const/4 v2, -0x1

    .line 63
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 43
    const/16 v0, 0xd

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTrail:[I

    .line 45
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    .line 51
    iput v2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mWidth:I

    .line 52
    iput v2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mHeight:I

    .line 54
    new-instance v0, Lcom/mrkeyboard/app/MrRainDrawable$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrRainDrawable$1;-><init>(Lcom/mrkeyboard/app/MrRainDrawable;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mBeat:Ljava/lang/Runnable;

    .line 64
    iput p1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mBackground:I

    .line 65
    const/4 v0, 0x0

    :goto_0
    const/16 v1, 0xc

    if-gt v0, v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTrail:[I

    const v2, 0x3e99999a    # 0.3f

    int-to-float v3, v0

    mul-float/2addr v2, v3

    const/high16 v3, 0x41400000    # 12.0f

    div-float/2addr v2, v3

    invoke-static {p2, v2}, Lcom/mrkeyboard/app/MrRainDrawable;->withAlpha(IF)I

    move-result v2

    aput v2, v1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 66
    :cond_0
    const v0, 0x3f0ccccd    # 0.55f

    invoke-static {p2, v0}, Lcom/mrkeyboard/app/MrRainDrawable;->lighter(IF)I

    move-result v0

    const v1, 0x3f333333    # 0.7f

    invoke-static {v0, v1}, Lcom/mrkeyboard/app/MrRainDrawable;->withAlpha(IF)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mHead:I

    .line 67
    const/high16 v0, 0x41700000    # 15.0f

    mul-float/2addr v0, p3

    iput v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTextPx:F

    .line 68
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 69
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTextPx:F

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 70
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 71
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-static {v0}, Lcom/mrkeyboard/app/MrRainDrawable;->glyphs(Landroid/graphics/Paint;)[Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mGlyphs:[Ljava/lang/String;

    .line 72
    new-instance v0, Lcom/mrkeyboard/app/MrRain;

    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mGlyphs:[Ljava/lang/String;

    array-length v1, v1

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-direct {v0, v1, v2, v3}, Lcom/mrkeyboard/app/MrRain;-><init>(IJ)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    .line 73
    return-void
.end method

.method static synthetic access$002(Lcom/mrkeyboard/app/MrRainDrawable;Z)Z
    .locals 0

    .prologue
    .line 24
    iput-boolean p1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mScheduled:Z

    return p1
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrRainDrawable;)Lcom/mrkeyboard/app/MrRain;
    .locals 1

    .prologue
    .line 24
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    return-object v0
.end method

.method private fit(II)V
    .locals 4

    .prologue
    const/high16 v2, 0x3f800000    # 1.0f

    .line 126
    iget v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mWidth:I

    if-ne p1, v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mHeight:I

    if-ne p2, v0, :cond_0

    .line 132
    :goto_0
    return-void

    .line 127
    :cond_0
    iput p1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mWidth:I

    .line 128
    iput p2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mHeight:I

    .line 129
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    const-string v1, "0"

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;)F

    move-result v0

    const v1, 0x3f866666    # 1.05f

    mul-float/2addr v0, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellW:F

    .line 130
    iget v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTextPx:F

    const v1, 0x3f933333    # 1.15f

    mul-float/2addr v0, v1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellH:F

    .line 131
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    int-to-float v1, p1

    iget v2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellW:F

    div-float/2addr v1, v2

    float-to-double v2, v1

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v1, v2

    int-to-float v2, p2

    iget v3, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellH:F

    div-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v2

    double-to-int v2, v2

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/mrkeyboard/app/MrRain;->resize(II)V

    goto :goto_0
.end method

.method static glyphs(Landroid/graphics/Paint;)[Ljava/lang/String;
    .locals 7

    .prologue
    const/4 v1, 0x0

    .line 77
    const-string v4, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ=+-*/<>:.\uff71\uff72\uff73\uff74\uff75\uff76\uff77\uff78\uff79\uff7a\uff7b\uff7c\uff7d\uff7e\uff7f\uff80\uff81\uff82\uff83\uff84\uff85\uff86\uff87\uff88\uff89\uff8a\uff8b\uff8c\uff8d\uff8e\uff8f\uff90\uff91\uff92\uff93\uff94\uff95\uff96\uff97\uff98\uff99\uff9a\uff9b\uff9c\uff9d"

    .line 78
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v0

    new-array v5, v0, [Ljava/lang/String;

    move v0, v1

    move v2, v1

    .line 80
    :goto_0
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v0, v3, :cond_2

    .line 81
    invoke-virtual {v4, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v6

    .line 82
    const-string v3, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ=+-*/<>:."

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-lt v0, v3, :cond_0

    invoke-virtual {p0, v6}, Landroid/graphics/Paint;->hasGlyph(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    add-int/lit8 v3, v2, 0x1

    aput-object v6, v5, v2

    move v2, v3

    .line 80
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 84
    :cond_2
    new-array v0, v2, [Ljava/lang/String;

    .line 85
    invoke-static {v5, v1, v0, v1, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 86
    return-object v0
.end method

.method static lighter(IF)I
    .locals 4

    .prologue
    .line 96
    shr-int/lit8 v0, p0, 0x10

    and-int/lit16 v0, v0, 0xff

    shr-int/lit8 v1, p0, 0x8

    and-int/lit16 v1, v1, 0xff

    and-int/lit16 v2, p0, 0xff

    .line 97
    rsub-int v3, v0, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p1

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    add-int/2addr v0, v3

    .line 98
    rsub-int v3, v1, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p1

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    add-int/2addr v1, v3

    .line 99
    rsub-int v3, v2, 0xff

    int-to-float v3, v3

    mul-float/2addr v3, p1

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v3

    add-int/2addr v2, v3

    .line 100
    const/high16 v3, -0x1000000

    shl-int/lit8 v0, v0, 0x10

    or-int/2addr v0, v3

    shl-int/lit8 v1, v1, 0x8

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    return v0
.end method

.method static withAlpha(IF)I
    .locals 2

    .prologue
    .line 90
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

    .line 91
    shl-int/lit8 v0, v0, 0x18

    const v1, 0xffffff

    and-int/2addr v1, p0

    or-int/2addr v0, v1

    return v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 8

    .prologue
    .line 105
    iget v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mBackground:I

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 106
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrRainDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    .line 107
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v0

    invoke-direct {p0, v1, v0}, Lcom/mrkeyboard/app/MrRainDrawable;->fit(II)V

    .line 108
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    invoke-virtual {v1}, Lcom/mrkeyboard/app/MrRain;->cols()I

    move-result v1

    if-ge v0, v1, :cond_3

    .line 109
    int-to-float v1, v0

    iget v2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellW:F

    mul-float/2addr v1, v2

    iget v2, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellW:F

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    add-float v3, v1, v2

    .line 110
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrRain;->last(I)I

    move-result v4

    .line 111
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    invoke-virtual {v1, v0}, Lcom/mrkeyboard/app/MrRain;->first(I)I

    move-result v1

    move v2, v1

    :goto_1
    if-gt v2, v4, :cond_2

    .line 112
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    invoke-virtual {v1, v0, v2}, Lcom/mrkeyboard/app/MrRain;->level(II)F

    move-result v1

    .line 113
    const/4 v5, 0x0

    cmpg-float v5, v1, v5

    if-gtz v5, :cond_0

    .line 111
    :goto_2
    add-int/lit8 v1, v2, 0x1

    move v2, v1

    goto :goto_1

    .line 114
    :cond_0
    iget-object v5, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    const/high16 v6, 0x3f800000    # 1.0f

    cmpl-float v6, v1, v6

    if-ltz v6, :cond_1

    iget v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mHead:I

    :goto_3
    invoke-virtual {v5, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 115
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mGlyphs:[Ljava/lang/String;

    iget-object v5, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mRain:Lcom/mrkeyboard/app/MrRain;

    invoke-virtual {v5, v0, v2}, Lcom/mrkeyboard/app/MrRain;->glyphAt(II)I

    move-result v5

    aget-object v1, v1, v5

    add-int/lit8 v5, v2, 0x1

    int-to-float v5, v5

    iget v6, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellH:F

    mul-float/2addr v5, v6

    iget v6, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mCellH:F

    const v7, 0x3e6147ae    # 0.22f

    mul-float/2addr v6, v7

    sub-float/2addr v5, v6

    iget-object v6, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v3, v5, v6}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    goto :goto_2

    .line 114
    :cond_1
    iget-object v6, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mTrail:[I

    const/high16 v7, 0x41400000    # 12.0f

    mul-float/2addr v1, v7

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    aget v1, v6, v1

    goto :goto_3

    .line 108
    :cond_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 118
    :cond_3
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mScheduled:Z

    if-nez v0, :cond_4

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrRainDrawable;->isVisible()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 119
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mScheduled:Z

    .line 120
    iget-object v0, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mBeat:Ljava/lang/Runnable;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x50

    add-long/2addr v2, v4

    invoke-virtual {p0, v0, v2, v3}, Lcom/mrkeyboard/app/MrRainDrawable;->scheduleSelf(Ljava/lang/Runnable;J)V

    .line 122
    :cond_4
    return-void
.end method

.method public getOpacity()I
    .locals 1

    .prologue
    .line 155
    const/4 v0, -0x1

    return v0
.end method

.method public setAlpha(I)V
    .locals 0

    .prologue
    .line 148
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 0

    .prologue
    .line 151
    return-void
.end method

.method public setVisible(ZZ)Z
    .locals 2

    .prologue
    .line 137
    invoke-super {p0, p1, p2}, Landroid/graphics/drawable/Drawable;->setVisible(ZZ)Z

    move-result v0

    .line 138
    if-nez p1, :cond_1

    .line 139
    iget-object v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mBeat:Ljava/lang/Runnable;

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrRainDrawable;->unscheduleSelf(Ljava/lang/Runnable;)V

    .line 140
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrRainDrawable;->mScheduled:Z

    .line 144
    :cond_0
    :goto_0
    return v0

    .line 141
    :cond_1
    if-eqz v0, :cond_0

    .line 142
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrRainDrawable;->invalidateSelf()V

    goto :goto_0
.end method
