.class final Lcom/mrkeyboard/app/MrPage;
.super Landroid/widget/ScrollView;
.source "MrPage.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mrkeyboard/app/MrPage$Pager;
    }
.end annotation


# static fields
.field static final QUIET_MS:I = 0x320


# instance fields
.field private mPager:Lcom/mrkeyboard/app/MrPage$Pager;

.field private mPin:I

.field private mProbe:Landroid/widget/OverScroller;

.field private mQuietUntil:J

.field private mTouching:Z

.field private mWaiting:I


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 1

    .prologue
    .line 44
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 37
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 45
    return-void
.end method

.method static synthetic access$000(Lcom/mrkeyboard/app/MrPage;)I
    .locals 1

    .prologue
    .line 26
    iget v0, p0, Lcom/mrkeyboard/app/MrPage;->mWaiting:I

    return v0
.end method

.method static synthetic access$002(Lcom/mrkeyboard/app/MrPage;I)I
    .locals 0

    .prologue
    .line 26
    iput p1, p0, Lcom/mrkeyboard/app/MrPage;->mWaiting:I

    return p1
.end method

.method static synthetic access$100(Lcom/mrkeyboard/app/MrPage;)Z
    .locals 1

    .prologue
    .line 26
    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    return v0
.end method

.method private distance(I)I
    .locals 9

    .prologue
    const/4 v1, 0x0

    .line 120
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mProbe:Landroid/widget/OverScroller;

    if-nez v0, :cond_0

    new-instance v0, Landroid/widget/OverScroller;

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/widget/OverScroller;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mProbe:Landroid/widget/OverScroller;

    .line 121
    :cond_0
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mProbe:Landroid/widget/OverScroller;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/widget/OverScroller;->forceFinished(Z)V

    .line 122
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mProbe:Landroid/widget/OverScroller;

    const/high16 v7, -0x80000000

    const v8, 0x7fffffff

    move v2, v1

    move v3, v1

    move v4, p1

    move v5, v1

    move v6, v1

    invoke-virtual/range {v0 .. v8}, Landroid/widget/OverScroller;->fling(IIIIIIII)V

    .line 123
    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mProbe:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->getFinalY()I

    move-result v0

    return v0
.end method

.method private floor()I
    .locals 4

    .prologue
    const/4 v0, 0x0

    .line 96
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPage;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 97
    if-nez v1, :cond_0

    .line 98
    :goto_0
    iget v1, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    return v0

    .line 97
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
    .line 102
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
    .line 83
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 84
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

    .line 70
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    .line 71
    if-nez v0, :cond_1

    .line 72
    iput-boolean v1, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    .line 73
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->release()V

    .line 77
    :cond_0
    :goto_0
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 74
    :cond_1
    if-eq v0, v1, :cond_2

    const/4 v1, 0x3

    if-ne v0, v1, :cond_0

    .line 75
    :cond_2
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    goto :goto_0
.end method

.method public fling(I)V
    .locals 1

    .prologue
    .line 144
    if-lez p1, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mPager:Lcom/mrkeyboard/app/MrPage$Pager;

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/mrkeyboard/app/MrPage;->mTouching:Z

    if-nez v0, :cond_0

    invoke-virtual {p0, p1}, Lcom/mrkeyboard/app/MrPage;->reachesEnd(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mrkeyboard/app/MrPage;->mPager:Lcom/mrkeyboard/app/MrPage$Pager;

    invoke-interface {v0}, Lcom/mrkeyboard/app/MrPage$Pager;->more()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 145
    iput p1, p0, Lcom/mrkeyboard/app/MrPage;->mWaiting:I

    .line 146
    new-instance v0, Lcom/mrkeyboard/app/MrPage$1;

    invoke-direct {v0, p0}, Lcom/mrkeyboard/app/MrPage$1;-><init>(Lcom/mrkeyboard/app/MrPage;)V

    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPage;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 157
    :goto_0
    return-void

    .line 156
    :cond_0
    invoke-super {p0, p1}, Landroid/widget/ScrollView;->fling(I)V

    goto :goto_0
.end method

.method isQuiet()Z
    .locals 4

    .prologue
    .line 58
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
    .locals 2

    .prologue
    .line 165
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v0

    .line 166
    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 167
    const/16 v1, 0x320

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrPage;->quiet(I)V

    .line 168
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 169
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v1

    if-ge v1, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollX()I

    move-result v1

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/MrPage;->scrollTo(II)V

    .line 170
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrPage$2;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPage$2;-><init>(Lcom/mrkeyboard/app/MrPage;I)V

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrPage;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 177
    return-void
.end method

.method protected onOverScrolled(IIZZ)V
    .locals 1

    .prologue
    .line 114
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->pinned()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result v0

    if-ge p2, v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result p2

    .line 115
    :cond_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/ScrollView;->onOverScrolled(IIZZ)V

    .line 116
    return-void
.end method

.method quiet(I)V
    .locals 4

    .prologue
    .line 54
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    int-to-long v2, p1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    .line 55
    return-void
.end method

.method reachesEnd(I)Z
    .locals 5

    .prologue
    const/4 v0, 0x0

    .line 131
    invoke-virtual {p0, v0}, Lcom/mrkeyboard/app/MrPage;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 132
    if-nez v1, :cond_1

    .line 135
    :cond_0
    :goto_0
    return v0

    .line 133
    :cond_1
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getHeight()I

    move-result v2

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getPaddingTop()I

    move-result v3

    sub-int/2addr v2, v3

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getPaddingBottom()I

    move-result v3

    sub-int/2addr v2, v3

    .line 134
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v3

    invoke-direct {p0, p1}, Lcom/mrkeyboard/app/MrPage;->distance(I)I

    move-result v4

    add-int/2addr v3, v4

    add-int/2addr v3, v2

    .line 135
    div-int/lit8 v2, v2, 0x2

    add-int/2addr v2, v3

    invoke-virtual {v1}, Landroid/view/View;->getHeight()I

    move-result v1

    if-le v2, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0
.end method

.method release()V
    .locals 2

    .prologue
    .line 63
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    .line 64
    const/4 v0, -0x1

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mPin:I

    .line 65
    const/4 v0, 0x0

    iput v0, p0, Lcom/mrkeyboard/app/MrPage;->mWaiting:I

    .line 66
    return-void
.end method

.method public requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z
    .locals 1

    .prologue
    .line 90
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 91
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
    .line 107
    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->pinned()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result v0

    if-ge p2, v0, :cond_0

    invoke-direct {p0}, Lcom/mrkeyboard/app/MrPage;->floor()I

    move-result p2

    .line 108
    :cond_0
    invoke-super {p0, p1, p2}, Landroid/widget/ScrollView;->scrollTo(II)V

    .line 109
    return-void
.end method

.method setPager(Lcom/mrkeyboard/app/MrPage$Pager;)V
    .locals 0

    .prologue
    .line 49
    iput-object p1, p0, Lcom/mrkeyboard/app/MrPage;->mPager:Lcom/mrkeyboard/app/MrPage$Pager;

    .line 50
    return-void
.end method
