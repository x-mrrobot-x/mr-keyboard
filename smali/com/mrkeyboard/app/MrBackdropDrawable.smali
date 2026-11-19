.class final Lcom/mrkeyboard/app/MrBackdropDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "MrBackdropDrawable.java"


# instance fields
.field private mCache:Landroid/graphics/Bitmap;

.field private final mContext:Landroid/content/Context;

.field private final mDark:Z

.field private mFailed:Z

.field private final mFallback:I

.field private final mPaint:Landroid/graphics/Paint;

.field private final mSoft:I

.field private final mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;


# direct methods
.method private constructor <init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;ZII)V
    .locals 2

    .prologue
    .line 29
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 25
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mPaint:Landroid/graphics/Paint;

    .line 30
    iput-object p1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mContext:Landroid/content/Context;

    .line 31
    iput-object p2, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    .line 32
    iput-boolean p3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mDark:Z

    .line 33
    iput p4, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSoft:I

    .line 34
    iput p5, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFallback:I

    .line 35
    return-void
.end method

.method static create(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;ZII)Lcom/mrkeyboard/app/MrBackdropDrawable;
    .locals 6

    .prologue
    const/4 v0, 0x0

    .line 39
    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    if-nez v1, :cond_1

    .line 41
    :cond_0
    :goto_0
    return-object v0

    .line 40
    :cond_1
    iget v1, p1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_2

    invoke-static {p0}, Lcom/mrkeyboard/app/MrBackdrop;->hasImage(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 41
    :cond_2
    new-instance v0, Lcom/mrkeyboard/app/MrBackdropDrawable;

    move-object v1, p0

    move-object v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/mrkeyboard/app/MrBackdropDrawable;-><init>(Landroid/content/Context;Lcom/mrkeyboard/app/MrBackdrop$Spec;ZII)V

    goto :goto_0
.end method

.method private render(II)V
    .locals 7

    .prologue
    const/4 v0, 0x0

    .line 58
    .line 60
    :try_start_0
    iget-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 61
    :cond_0
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    .line 62
    iget-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget v1, v1, Lcom/mrkeyboard/app/MrBackdrop$Spec;->kind:I

    const/4 v2, 0x3

    if-ne v1, v2, :cond_2

    .line 63
    iget-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mContext:Landroid/content/Context;

    invoke-static {v1}, Lcom/mrkeyboard/app/MrBackdrop;->load(Landroid/content/Context;)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    .line 64
    if-nez v0, :cond_2

    .line 65
    const/4 v1, 0x1

    :try_start_1
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFailed:Z
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 79
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    .line 81
    :cond_1
    :goto_0
    return-void

    .line 69
    :cond_2
    :try_start_2
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, p2, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    .line 70
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 71
    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    invoke-static {v2, v3, p1, p2, v0}, Lcom/mrkeyboard/app/MrBackdrop;->draw(Landroid/graphics/Canvas;Lcom/mrkeyboard/app/MrBackdrop$Spec;IILandroid/graphics/Bitmap;)V

    .line 72
    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSpec:Lcom/mrkeyboard/app/MrBackdrop$Spec;

    iget-boolean v4, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mDark:Z

    iget v5, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mSoft:I

    invoke-static {v3, v0, v4, v5}, Lcom/mrkeyboard/app/MrBackdrop;->look(Lcom/mrkeyboard/app/MrBackdrop$Spec;Landroid/graphics/Bitmap;ZI)Lcom/mrkeyboard/app/MrBackdrop$Look;

    move-result-object v3

    invoke-static {v3}, Lcom/mrkeyboard/app/MrBackdropDrawable;->veilOver(Lcom/mrkeyboard/app/MrBackdrop$Look;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 73
    iput-object v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;
    :try_end_2
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 79
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    .line 74
    :catch_0
    move-exception v1

    .line 75
    const/4 v1, 0x1

    :try_start_3
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFailed:Z
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 79
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    .line 76
    :catch_1
    move-exception v1

    .line 77
    const/4 v1, 0x1

    :try_start_4
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFailed:Z
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    .line 79
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V

    goto :goto_0

    :catchall_0
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    :goto_1
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/graphics/Bitmap;->recycle()V

    .line 80
    :cond_3
    throw v0

    .line 79
    :catchall_1
    move-exception v1

    move-object v6, v1

    move-object v1, v0

    move-object v0, v6

    goto :goto_1
.end method

.method static veilOver(Lcom/mrkeyboard/app/MrBackdrop$Look;)I
    .locals 3

    .prologue
    .line 85
    if-eqz p0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilAlpha:I

    if-gtz v0, :cond_1

    :cond_0
    const/4 v0, 0x0

    .line 86
    :goto_0
    return v0

    :cond_1
    iget v0, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilAlpha:I

    shl-int/lit8 v0, v0, 0x18

    iget v1, p0, Lcom/mrkeyboard/app/MrBackdrop$Look;->veilColor:I

    const v2, 0xffffff

    and-int/2addr v1, v2

    or-int/2addr v0, v1

    goto :goto_0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 46
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrBackdropDrawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    .line 47
    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v1

    invoke-virtual {v0}, Landroid/graphics/Rect;->height()I

    move-result v2

    .line 48
    if-lez v1, :cond_0

    if-gtz v2, :cond_1

    .line 55
    :cond_0
    :goto_0
    return-void

    .line 49
    :cond_1
    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    if-ne v3, v1, :cond_2

    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    if-eq v3, v2, :cond_3

    :cond_2
    iget-boolean v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFailed:Z

    if-nez v3, :cond_3

    invoke-direct {p0, v1, v2}, Lcom/mrkeyboard/app/MrBackdropDrawable;->render(II)V

    .line 50
    :cond_3
    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    if-nez v3, :cond_4

    .line 51
    iget v0, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mFallback:I

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawColor(I)V

    goto :goto_0

    .line 54
    :cond_4
    iget-object v3, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mCache:Landroid/graphics/Bitmap;

    new-instance v4, Landroid/graphics/Rect;

    invoke-direct {v4, v5, v5, v1, v2}, Landroid/graphics/Rect;-><init>(IIII)V

    new-instance v1, Landroid/graphics/Rect;

    iget v2, v0, Landroid/graphics/Rect;->left:I

    iget v5, v0, Landroid/graphics/Rect;->top:I

    iget v6, v0, Landroid/graphics/Rect;->right:I

    iget v0, v0, Landroid/graphics/Rect;->bottom:I

    invoke-direct {v1, v2, v5, v6, v0}, Landroid/graphics/Rect;-><init>(IIII)V

    iget-object v0, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v3, v4, v1, v0}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    goto :goto_0
.end method

.method public getOpacity()I
    .locals 1

    .prologue
    .line 96
    const/4 v0, -0x1

    return v0
.end method

.method public setAlpha(I)V
    .locals 1

    .prologue
    .line 91
    iget-object v0, p0, Lcom/mrkeyboard/app/MrBackdropDrawable;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 92
    return-void
.end method
