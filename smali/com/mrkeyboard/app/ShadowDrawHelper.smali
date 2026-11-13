.class final Lcom/mrkeyboard/app/ShadowDrawHelper;
.super Ljava/lang/Object;
.source "ShadowDrawHelper.java"

# Blurred outline of an icon (the dark outline of the icons on dark themes, the light of the icons on neon themes, MrGlow.icon).
#
# The blur (a BlurMaskFilter through Bitmap.extractAlpha) used to be made again on every frame, for every icon key: a bitmap of
# the key, the icon drawn into it, the blur, the drawing and the recycling of both bitmaps. Now the blurred alpha of each icon is
# kept in one of SLOTS (24) places, found again by what decides its shape: the drawable that is really drawn (getCurrent: the
# child of a state list), the size of the key, the bounds, alpha and level of the drawable, and the radius. The colour is not
# part of it: the shadow is only alpha, coloured at drawing time by the filter of the call. When the places are full the oldest
# is replaced (round robin). A kept bitmap is not recycled while drawing: a frame drawn later by the render thread may still
# use it. Stage 4 of docs/plan-performance.md adds the explicit release at the safe moments (window hidden, view replaced,
# onTrimMemory); until then the replaced ones go to the garbage collector. Stage 1; test: docs/tools/test_shadow_cache.py.


# static fields
.field static final SLOTS:I = 0x18

.field private static final sBlurPaint:Landroid/graphics/Paint;

.field private static sCachedRadius:F

.field private static final sColorPaint:Landroid/graphics/Paint;

.field private static final sOffset:[I

.field private static final sTmpCanvas:Landroid/graphics/Canvas;

# the drawable (getCurrent) of each place; null = empty
.field private static final sDraw:[Landroid/graphics/drawable/Drawable;

# 8 ints per place: width and height of the key, left, top, right, bottom, alpha and level of the drawable
.field private static final sKey:[I

# radius of the blur of each place
.field private static final sRad:[F

# the blurred alpha of each place
.field private static final sBmp:[Landroid/graphics/Bitmap;

# 2 ints per place: where the blurred alpha is drawn, from the corner of the key (what extractAlpha returned)
.field private static final sOff:[I

# the 8 ints of the icon being drawn (probe)
.field private static final sProbe:[I

# next place to fill
.field private static sNext:I

# how many shadows were blurred since the process started (tests)
.field static sBuilt:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0}, Landroid/graphics/Canvas;-><init>()V

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    const/4 v0, 0x2

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    const/high16 v0, -0x40800000    # -1.0f

    sput v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    const/16 v0, 0x18

    new-array v0, v0, [Landroid/graphics/drawable/Drawable;

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sDraw:[Landroid/graphics/drawable/Drawable;

    const/16 v0, 0xc0

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sKey:[I

    const/16 v0, 0x18

    new-array v0, v0, [F

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sRad:[F

    const/16 v0, 0x18

    new-array v0, v0, [Landroid/graphics/Bitmap;

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBmp:[Landroid/graphics/Bitmap;

    const/16 v0, 0x30

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOff:[I

    const/16 v0, 0x8

    new-array v0, v0, [I

    sput-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sProbe:[I

    const/4 v0, 0x0

    sput v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sNext:I

    sput v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBuilt:I

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# Fills sProbe with what decides the shape of the shadow of d on a key of w by h.
.method private static probe(Landroid/graphics/drawable/Drawable;II)V
    .locals 3

    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sProbe:[I

    const/4 v1, 0x0

    aput p1, v0, v1

    const/4 v1, 0x1

    aput p2, v0, v1

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    iget v2, v1, Landroid/graphics/Rect;->left:I

    const/4 p1, 0x2

    aput v2, v0, p1

    iget v2, v1, Landroid/graphics/Rect;->top:I

    const/4 p1, 0x3

    aput v2, v0, p1

    iget v2, v1, Landroid/graphics/Rect;->right:I

    const/4 p1, 0x4

    aput v2, v0, p1

    iget v2, v1, Landroid/graphics/Rect;->bottom:I

    const/4 p1, 0x5

    aput v2, v0, p1

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getAlpha()I

    move-result v2

    const/4 p1, 0x6

    aput v2, v0, p1

    invoke-virtual {p0}, Landroid/graphics/drawable/Drawable;->getLevel()I

    move-result v2

    const/4 p1, 0x7

    aput v2, v0, p1

    return-void
.end method

# The place that already has the shadow of cur (with sProbe and radius), or -1.
.method private static find(Landroid/graphics/drawable/Drawable;F)I
    .locals 10

    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sDraw:[Landroid/graphics/drawable/Drawable;

    sget-object v1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sRad:[F

    sget-object v2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sKey:[I

    sget-object v3, Lcom/mrkeyboard/app/ShadowDrawHelper;->sProbe:[I

    const/4 v4, 0x0

    :goto_slot
    const/16 v5, 0x18

    if-ge v4, v5, :cond_none

    aget-object v5, v0, v4

    if-ne v5, p0, :cond_next

    aget v5, v1, v4

    cmpl-float v5, v5, p1

    if-nez v5, :cond_next

    mul-int/lit8 v5, v4, 0x8

    const/4 v6, 0x0

    :goto_field
    const/16 v7, 0x8

    if-ge v6, v7, :cond_found

    aget v7, v3, v6

    add-int v8, v5, v6

    aget v8, v2, v8

    if-ne v7, v8, :cond_next

    add-int/lit8 v6, v6, 0x1

    goto :goto_field

    :cond_found
    return v4

    :cond_next
    add-int/lit8 v4, v4, 0x1

    goto :goto_slot

    :cond_none
    const/4 v0, -0x1

    return v0
.end method

# Blurs the alpha of d (drawn at its bounds on a bitmap of the key, sProbe[0] by sProbe[1]) and keeps it in the next place,
# under cur, sProbe and radius. Returns the place, or -1 when extractAlpha gave nothing.
.method private static build(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;F)I
    .locals 8

    sget v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    cmpl-float v0, p2, v0

    if-eqz v0, :cond_paint_ok

    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    new-instance v1, Landroid/graphics/BlurMaskFilter;

    sget-object v2, Landroid/graphics/BlurMaskFilter$Blur;->OUTER:Landroid/graphics/BlurMaskFilter$Blur;

    invoke-direct {v1, p2, v2}, Landroid/graphics/BlurMaskFilter;-><init>(FLandroid/graphics/BlurMaskFilter$Blur;)V

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setMaskFilter(Landroid/graphics/MaskFilter;)Landroid/graphics/MaskFilter;

    sput p2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sCachedRadius:F

    :cond_paint_ok
    sget-object v0, Lcom/mrkeyboard/app/ShadowDrawHelper;->sProbe:[I

    const/4 v1, 0x0

    aget v1, v0, v1

    const/4 v2, 0x1

    aget v2, v0, v2

    sget-object v3, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v2, v3}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    const/4 v2, 0x0

    :try_start_blur
    sget-object v3, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {v3, v1}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    invoke-virtual {p0, v3}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    invoke-virtual {v3, v2}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    sget-object v3, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBlurPaint:Landroid/graphics/Paint;

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    invoke-virtual {v1, v3, v4}, Landroid/graphics/Bitmap;->extractAlpha(Landroid/graphics/Paint;[I)Landroid/graphics/Bitmap;

    move-result-object v3
    :try_end_blur
    .catchall {:try_start_blur .. :try_end_blur} :catchall_blur

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {v4, v2}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    if-nez v3, :cond_have

    const/4 v0, -0x1

    return v0

    :cond_have
    sget v1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sNext:I

    add-int/lit8 v4, v1, 0x1

    const/16 v5, 0x18

    if-lt v4, v5, :cond_wrap_ok

    const/4 v4, 0x0

    :cond_wrap_ok
    sput v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sNext:I

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sDraw:[Landroid/graphics/drawable/Drawable;

    aput-object p1, v4, v1

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sRad:[F

    aput p2, v4, v1

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBmp:[Landroid/graphics/Bitmap;

    aput-object v3, v4, v1

    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sKey:[I

    mul-int/lit8 v5, v1, 0x8

    const/4 v6, 0x0

    const/16 v7, 0x8

    :goto_copy
    if-ge v6, v7, :cond_copied

    aget v2, v0, v6

    add-int v3, v5, v6

    aput v2, v4, v3

    add-int/lit8 v6, v6, 0x1

    goto :goto_copy

    :cond_copied
    sget-object v4, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOff:[I

    mul-int/lit8 v5, v1, 0x2

    sget-object v6, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOffset:[I

    const/4 v7, 0x0

    aget v2, v6, v7

    aput v2, v4, v5

    add-int/lit8 v5, v5, 0x1

    const/4 v7, 0x1

    aget v2, v6, v7

    aput v2, v4, v5

    sget v2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBuilt:I

    add-int/lit8 v2, v2, 0x1

    sput v2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBuilt:I

    return v1

    :catchall_blur
    move-exception v0

    sget-object v3, Lcom/mrkeyboard/app/ShadowDrawHelper;->sTmpCanvas:Landroid/graphics/Canvas;

    invoke-virtual {v3, v2}, Landroid/graphics/Canvas;->setBitmap(Landroid/graphics/Bitmap;)V

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    throw v0
.end method

# Draws the shadow of the icon d of key k (d already has its bounds, the canvas is at the corner of the key), blurred with
# radius and coloured with filter. Nothing for a key with no size or a radius of 0 or less.
.method static draw(Landroid/graphics/Canvas;Landroid/graphics/drawable/Drawable;Lcom/mrkeyboard/app/Keyboard$Key;FLandroid/graphics/ColorFilter;)V
    .locals 5

    iget v0, p2, Lcom/mrkeyboard/app/Keyboard$Key;->width:I

    iget v1, p2, Lcom/mrkeyboard/app/Keyboard$Key;->height:I

    if-lez v0, :cond_ret

    if-lez v1, :cond_ret

    const/4 v2, 0x0

    cmpg-float v2, p3, v2

    if-lez v2, :cond_ret

    invoke-static {p1, v0, v1}, Lcom/mrkeyboard/app/ShadowDrawHelper;->probe(Landroid/graphics/drawable/Drawable;II)V

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getCurrent()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-static {v2, p3}, Lcom/mrkeyboard/app/ShadowDrawHelper;->find(Landroid/graphics/drawable/Drawable;F)I

    move-result v0

    if-gez v0, :cond_have

    invoke-static {p1, v2, p3}, Lcom/mrkeyboard/app/ShadowDrawHelper;->build(Landroid/graphics/drawable/Drawable;Landroid/graphics/drawable/Drawable;F)I

    move-result v0

    if-ltz v0, :cond_ret

    :cond_have
    sget-object v1, Lcom/mrkeyboard/app/ShadowDrawHelper;->sBmp:[Landroid/graphics/Bitmap;

    aget-object v1, v1, v0

    sget-object v2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sOff:[I

    mul-int/lit8 v3, v0, 0x2

    aget v4, v2, v3

    int-to-float v4, v4

    add-int/lit8 v3, v3, 0x1

    aget v3, v2, v3

    int-to-float v3, v3

    sget-object v2, Lcom/mrkeyboard/app/ShadowDrawHelper;->sColorPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, p4}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    const/4 v0, 0x0

    :try_start_draw
    invoke-virtual {p0, v1, v4, v3, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V
    :try_end_draw
    .catchall {:try_start_draw .. :try_end_draw} :catchall_draw

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    :cond_ret
    return-void

    :catchall_draw
    move-exception v1

    invoke-virtual {v2, v0}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    throw v1
.end method
