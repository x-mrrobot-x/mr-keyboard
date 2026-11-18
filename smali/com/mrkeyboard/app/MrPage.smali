.class final Lcom/mrkeyboard/app/MrPage;
.super Landroid/widget/ScrollView;
.source "MrPage.java"


# static fields
.field static final FRESH_MS:I = 0x64

.field static final MIN_SPEED:F = 120.0f

.field static final QUIET_MS:I = 0x320


# instance fields
.field private mMovedAt:J

.field private mPin:I

.field private mQuietUntil:J

.field private mSpeed:F

.field private mTouching:Z


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 38
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 32
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 39
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrPage;)Z
    .locals 1

    .prologue
    .line 24
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    return v0
.end method

.method private floor()I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 108
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPage;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 109
    if-nez v1, :cond_0

    .line 110
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0

    .line 109
    :cond_0
    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v1

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getHeight()I

    move-result v2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getPaddingTop()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getPaddingBottom()I

    move-result v3

    sub-int/2addr v2, v3

    sub-int/2addr v1, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    goto :goto_0
.end method

.method private pinned()Z
    .locals 1

    .prologue
    .line 114
    iget v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    if-ltz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method


# virtual methods
.method protected computeScrollDeltaToGetChildRectOnScreen(Landroid/graphics/Rect;)I
    .locals 1

    .prologue
    .line 95
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 96
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->computeScrollDeltaToGetChildRectOnScreen(Landroid/graphics/Rect;)I

    move-result v0

    goto :goto_0
.end method

.method public dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 59
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 60
    if-nez v0, :cond_1

    .line 61
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    .line 62
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->release()V

    .line 66
    :cond_0
    :goto_0
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 63
    :cond_1
    if-eq v0, v1, :cond_2

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 64
    :cond_2
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    goto :goto_0
.end method

.method flingSpeed()F
    .locals 1

    .prologue
    .line 89
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->flinging()Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method flinging()Z
    .locals 4

    .prologue
    .line 84
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    if-nez v0, :cond_0

    iget v0, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    const/high16 v1, 0x42f00000    # 120.0f

    cmpl-float v0, v0, v1

    if-lez v0, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrPage;->mMovedAt:J

    sub-long/2addr v0, v2

    const-wide/16 v2, 0x64

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method isQuiet()Z
    .locals 4

    .prologue
    .line 47
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method keepPosition(Ljava/lang/Runnable;)V
    .locals 3

    .prologue
    .line 136
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v0

    .line 137
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->flingSpeed()F

    move-result v1

    .line 138
    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 139
    const/16 v2, 0x320

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrPage;->quiet(I)V

    .line 140
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 141
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v2

    if-ge v2, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollX()I

    move-result v2

    invoke-virtual {p0, v2, v0}, Lcom/mrkeyboard/app/MrPage;->scrollTo(II)V

    .line 142
    :cond_0
    new-instance v2, Lcom/mrkeyboard/app/MrPage$1;

    invoke-direct {v2, p0, v0, v1}, Lcom/mrkeyboard/app/MrPage$1;-><init>(Lcom/mrkeyboard/app/MrPage;IF)V

    invoke-virtual {p0, v2}, Lcom/mrkeyboard/app/MrPage;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 150
    return-void
.end method

.method protected onOverScrolled(IIZZ)V
    .locals 1

    .prologue
    .line 126
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->pinned()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result v0

    if-ge p2, v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result p2

    .line 127
    :cond_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onOverScrolled(IIZZ)V

    .line 128
    return-void
.end method

.method protected onScrollChanged(IIII)V
    .locals 10

    .prologue
    const-wide/16 v8, 0x64

    const/high16 v7, 0x3f000000    # 0.5f

    .line 71
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onScrollChanged(IIII)V

    .line 72
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    .line 73
    iget-wide v2, p0, Lcom/mrkeyboard/app/MrPage;->mMovedAt:J

    sub-long v2, v0, v2

    .line 74
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-lez v4, :cond_1

    cmp-long v4, v2, v8

    if-gez v4, :cond_1

    .line 75
    iget v4, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    mul-float/2addr v4, v7

    sub-int v5, p2, p4

    int-to-float v5, v5

    const/high16 v6, 0x447a0000    # 1000.0f

    mul-float/2addr v5, v6

    long-to-float v2, v2

    div-float v2, v5, v2

    mul-float/2addr v2, v7

    add-float/2addr v2, v4

    iput v2, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    .line 79
    :cond_0
    :goto_0
    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mMovedAt:J

    .line 80
    return-void

    .line 76
    :cond_1
    cmp-long v2, v2, v8

    if-ltz v2, :cond_0

    .line 77
    const/4 v2, 0x0

    iput v2, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    goto :goto_0
.end method

.method quiet(I)V
    .locals 4

    .prologue
    .line 43
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    int-to-long v2, p1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    .line 44
    return-void
.end method

.method release()V
    .locals 2

    .prologue
    .line 52
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    .line 53
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 54
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mSpeed:F

    .line 55
    return-void
.end method

.method public requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z
    .locals 1

    .prologue
    .line 102
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 103
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/widget/ScrollView;->requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z

    move-result v0

    goto :goto_0
.end method

.method public scrollTo(II)V
    .locals 1

    .prologue
    .line 119
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->pinned()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result v0

    if-ge p2, v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result p2

    .line 120
    :cond_0
    invoke-super {p0, p1, p2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 121
    return-void
.end method
