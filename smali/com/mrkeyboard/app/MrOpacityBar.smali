.class final Lcom/mrkeyboard/app/MrOpacityBar;
.super Landroid/view/View;
.source "MrOpacityBar.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrOpacityBar$Listener;
    }
.end annotation


# static fields
.field static final BAR_DP:I = 0x1e

.field static final CHECK_DP:F = 6.0f


# instance fields
.field private mColor:I

.field private final mDensity:F

.field private mListener:Lcom/mrkeyboard/app/MrOpacityBar$Listener;

.field private final mMax:I

.field private final mPaint:Landroid/graphics/Paint;

.field private final mReference:I

.field private mValue:I


# direct methods
.method constructor <init>(Landroid/content/Context;II)V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 37
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 29
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    .line 33
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    .line 38
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    .line 39
    invoke-static {v1, p2}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    .line 40
    const/4 v0, 0x0

    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    invoke-static {v1, p3}, Ljava/lang/Math;->min(II)I

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mReference:I

    .line 41
    return-void
.end method

.method private clamp(I)I
    .locals 1

    .prologue
    .line 74
    if-gez p1, :cond_1

    const/4 p1, 0x0

    :cond_0
    :goto_0
    return p1

    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    if-le p1, v0, :cond_0

    iget p1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    goto :goto_0
.end method


# virtual methods
.method color()I
    .locals 1

    .prologue
    .line 66
    iget v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    return v0
.end method

.method drag(F)V
    .locals 3

    .prologue
    .line 84
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->getWidth()I

    move-result v0

    .line 85
    if-gtz v0, :cond_1

    .line 92
    :cond_0
    :goto_0
    return-void

    .line 86
    :cond_1
    const/4 v1, 0x0

    const/high16 v2, 0x3f800000    # 1.0f

    int-to-float v0, v0

    div-float v0, p1, v0

    invoke-static {v2, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(FF)F

    move-result v0

    .line 87
    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    int-to-float v1, v1

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    invoke-direct {p0, v0}, Lcom/mrkeyboard/app/MrOpacityBar;->clamp(I)I

    move-result v0

    .line 88
    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mValue:I

    if-eq v0, v1, :cond_0

    .line 89
    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mValue:I

    .line 90
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->invalidate()V

    .line 91
    iget-object v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mListener:Lcom/mrkeyboard/app/MrOpacityBar$Listener;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mListener:Lcom/mrkeyboard/app/MrOpacityBar$Listener;

    invoke-interface {v1, v0}, Lcom/mrkeyboard/app/MrOpacityBar$Listener;->onOpacity(I)V

    goto :goto_0
.end method

.method max()I
    .locals 1

    .prologue
    .line 70
    iget v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 13

    .prologue
    .line 111
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->getWidth()I

    move-result v8

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->getHeight()I

    move-result v9

    .line 112
    if-lez v8, :cond_0

    if-gtz v9, :cond_1

    .line 151
    :cond_0
    :goto_0
    return-void

    .line 114
    :cond_1
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 115
    int-to-float v0, v8

    int-to-float v1, v9

    int-to-float v2, v9

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    invoke-static {v0, v1, v2}, Lcom/mrkeyboard/app/MrThemePreview;->roundRect(FFF)Landroid/graphics/Path;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->clipPath(Landroid/graphics/Path;)Z

    .line 116
    const/high16 v0, 0x40c00000    # 6.0f

    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float v10, v0, v1

    .line 117
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 118
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 119
    int-to-float v0, v9

    div-float/2addr v0, v10

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int v11, v0

    int-to-float v0, v8

    div-float/2addr v0, v10

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v0

    double-to-int v12, v0

    .line 120
    const/4 v0, 0x0

    move v7, v0

    :goto_1
    if-ge v7, v11, :cond_4

    .line 121
    const/4 v0, 0x0

    move v6, v0

    :goto_2
    if-ge v6, v12, :cond_3

    .line 122
    iget-object v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    add-int v0, v7, v6

    and-int/lit8 v0, v0, 0x1

    if-nez v0, :cond_2

    const/4 v0, -0x1

    :goto_3
    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 123
    int-to-float v0, v6

    mul-float v1, v0, v10

    int-to-float v0, v7

    mul-float v2, v0, v10

    add-int/lit8 v0, v6, 0x1

    int-to-float v0, v0

    mul-float v3, v0, v10

    add-int/lit8 v0, v7, 0x1

    int-to-float v0, v0

    mul-float v4, v0, v10

    iget-object v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 121
    add-int/lit8 v0, v6, 0x1

    move v6, v0

    goto :goto_2

    .line 122
    :cond_2
    const v0, -0x3b3b3c

    goto :goto_3

    .line 120
    :cond_3
    add-int/lit8 v0, v7, 0x1

    move v7, v0

    goto :goto_1

    .line 126
    :cond_4
    iget-object v10, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/LinearGradient;

    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, v8

    const/4 v4, 0x0

    iget v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    const v6, 0xffffff

    and-int/2addr v5, v6

    iget v6, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    sget-object v7, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    invoke-direct/range {v0 .. v7}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    invoke-virtual {v10, v0}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 127
    const/4 v1, 0x0

    const/4 v2, 0x0

    int-to-float v3, v8

    int-to-float v4, v9

    iget-object v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 128
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 129
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 131
    iget v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mReference:I

    int-to-float v0, v0

    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    int-to-float v1, v8

    mul-float v6, v0, v1

    .line 132
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/high16 v1, 0x66000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 133
    const/high16 v0, 0x3fc00000    # 1.5f

    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v0, v1

    sub-float v1, v6, v0

    int-to-float v0, v9

    const v2, 0x3e3851ec    # 0.18f

    mul-float/2addr v2, v0

    const/high16 v0, 0x3fc00000    # 1.5f

    iget v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v0, v3

    add-float v3, v6, v0

    int-to-float v0, v9

    const v4, 0x3f51eb85    # 0.82f

    mul-float/2addr v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 134
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const v1, -0x33000001    # -1.3421772E8f

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 135
    const/high16 v0, 0x3f400000    # 0.75f

    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v0, v1

    sub-float v1, v6, v0

    int-to-float v0, v9

    const v2, 0x3e3851ec    # 0.18f

    mul-float/2addr v2, v0

    const/high16 v0, 0x3f400000    # 0.75f

    iget v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v0, v3

    add-float v3, v6, v0

    int-to-float v0, v9

    const v4, 0x3f51eb85    # 0.82f

    mul-float/2addr v4, v0

    iget-object v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 137
    int-to-float v0, v9

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v1, v2

    sub-float/2addr v0, v1

    .line 138
    iget v1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mValue:I

    int-to-float v1, v1

    iget v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mMax:I

    int-to-float v2, v2

    div-float/2addr v1, v2

    int-to-float v2, v8

    mul-float/2addr v1, v2

    .line 139
    const/high16 v2, 0x40000000    # 2.0f

    iget v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v2, v3

    add-float/2addr v2, v0

    int-to-float v3, v8

    sub-float/2addr v3, v0

    const/high16 v4, 0x40000000    # 2.0f

    iget v5, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v4, v5

    sub-float/2addr v3, v4

    invoke-static {v3, v1}, Ljava/lang/Math;->min(FF)F

    move-result v1

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 140
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 141
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    iget v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 142
    int-to-float v2, v9

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v0, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 143
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 144
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/high16 v3, 0x40200000    # 2.5f

    iget v4, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v3, v4

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 145
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 146
    int-to-float v2, v9

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v0, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 147
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    iget v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 148
    iget-object v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    const/high16 v3, 0x66000000

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 149
    int-to-float v2, v9

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v2, v3

    const/high16 v3, 0x3fc00000    # 1.5f

    iget v4, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v3, v4

    add-float/2addr v0, v3

    iget-object v3, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v2, v0, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 150
    iget-object v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    goto/16 :goto_0
.end method

.method protected onMeasure(II)V
    .locals 3

    .prologue
    .line 79
    invoke-static {p1}, Landroid/view/View$MeasureSpec;->getSize(I)I

    move-result v0

    const/high16 v1, 0x41f00000    # 30.0f

    iget v2, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mDensity:F

    mul-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/mrkeyboard/app/MrOpacityBar;->setMeasuredDimension(II)V

    .line 80
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 96
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v1

    .line 97
    if-nez v1, :cond_0

    .line 98
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->getParent()Landroid/view/ViewParent;

    move-result-object v2

    .line 99
    if-eqz v2, :cond_0

    invoke-interface {v2, v0}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 101
    :cond_0
    if-eqz v1, :cond_1

    const/4 v2, 0x2

    if-ne v1, v2, :cond_3

    .line 102
    :cond_1
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrOpacityBar;->drag(F)V

    .line 106
    :cond_2
    :goto_0
    return v0

    .line 105
    :cond_3
    if-eq v1, v0, :cond_2

    const/4 v2, 0x3

    if-eq v1, v2, :cond_2

    .line 106
    invoke-super {p0, p1}, Landroid/view/View;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    goto :goto_0
.end method

.method setColor(I)V
    .locals 1

    .prologue
    .line 49
    const/high16 v0, -0x1000000

    or-int/2addr v0, p1

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mColor:I

    .line 50
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->invalidate()V

    .line 51
    return-void
.end method

.method setListener(Lcom/mrkeyboard/app/MrOpacityBar$Listener;)V
    .locals 0

    .prologue
    .line 44
    iput-object p1, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mListener:Lcom/mrkeyboard/app/MrOpacityBar$Listener;

    .line 45
    return-void
.end method

.method setValue(I)V
    .locals 1

    .prologue
    .line 55
    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrOpacityBar;->clamp(I)I

    move-result v0

    iput v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mValue:I

    .line 56
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrOpacityBar;->invalidate()V

    .line 57
    return-void
.end method

.method value()I
    .locals 1

    .prologue
    .line 61
    iget v0, p0, Lcom/mrkeyboard/app/MrOpacityBar;->mValue:I

    return v0
.end method
