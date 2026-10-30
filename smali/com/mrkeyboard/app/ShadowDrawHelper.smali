.class final Lcom/mrkeyboard/app/ShadowDrawHelper;
.super Ljava/lang/Object;
.source "ShadowDrawHelper.java"


# static fields
.field private static final sBlurPaint:Landroid/graphics/Paint;

.field private static sCachedRadius:F

.field private static final sColorPaint:Landroid/graphics/Paint;

.field private static final sOffset:[I

.field private static final sTmpCanvas:Landroid/graphics/Canvas;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 11
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    .line 12
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    .line 13
    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0}, Landroid/graphics/Canvas;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    .line 14
    const/4 v0, 0x2

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    .line 15
    const/high16 v0, -0x40800000    # -1.0f

    sput v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static draw(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V
    .registers 9

    .line 20
    iget v0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    .line 21
    iget p2, p2, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    .line 22
    if-lez v0, :cond_80

    if-lez p2, :cond_80

    const/4 v1, 0x0

    cmpg-float v1, p3, v1

    if-gtz v1, :cond_e

    goto :goto_80

    .line 25
    :cond_e
    sget v1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    cmpl-float v1, p3, v1

    if-eqz v1, :cond_22

    .line 26
    sget-object v1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    new-instance v2, Landroid/graphics/BlurMaskFilter;

    sget-object v3, Landroid/graphics/BlurMaskFilter$Blur;->OUTER:Landroid/graphics/BlurMaskFilter$Blur;

    invoke-direct {v2, p3, v3}, Landroid/graphics/BlurMaskFilter;-><init>(FLandroid/graphics/BlurMaskFilter$Blur;)V

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setMaskFilter(Landroid/graphics/MaskFilter;)Landroid/graphics/MaskFilter;

    .line 27
    sput p3, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    .line 29
    :cond_22
    sget-object p3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, p2, p3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p2

    .line 30
    nop

    .line 32
    const/4 p3, 0x0

    :try_start_2a
    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {v0, p2}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    .line 33
    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {p1, v0}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 34
    sget-object p1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {p1, p3}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    .line 35
    sget-object p1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    invoke-virtual {p2, p1, v0}, Landroid/graphics/Bitmap;->extractAlpha(Landroid/graphics/Paint;[I)Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_41
    .catchall {:try_start_2a .. :try_end_41} :catchall_76

    .line 37
    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {v0, p3}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    .line 38
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->recycle()V

    .line 39
    nop

    .line 40
    if-eqz p1, :cond_75

    .line 42
    :try_start_4c
    sget-object p2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    invoke-virtual {p2, p4}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 43
    sget-object p2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    const/4 p4, 0x0

    aget p2, p2, p4

    int-to-float p2, p2

    sget-object p4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    const/4 v0, 0x1

    aget p4, p4, v0

    int-to-float p4, p4

    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    invoke-virtual {p0, p1, p2, p4, v0}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V
    :try_end_62
    .catchall {:try_start_4c .. :try_end_62} :catchall_6b

    .line 45
    sget-object p0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    invoke-virtual {p0, p3}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 46
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    .line 47
    goto :goto_75

    .line 45
    :catchall_6b
    move-exception p0

    sget-object p2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    invoke-virtual {p2, p3}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 46
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    .line 47
    throw p0

    .line 49
    :cond_75
    :goto_75
    return-void

    .line 37
    :catchall_76
    move-exception p0

    sget-object p1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {p1, p3}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    .line 38
    invoke-virtual {p2}, Landroid/graphics/Bitmap;->recycle()V

    .line 39
    throw p0

    .line 23
    :cond_80
    :goto_80
    return-void
.end method
