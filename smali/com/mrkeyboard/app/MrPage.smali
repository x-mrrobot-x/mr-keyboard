.class final Lcom/mrkeyboard/app/MrPage;
.super Landroid/widget/ScrollView;
.source "MrPage.java"


# static fields
.field static final QUIET_MS:I = 0x190


# instance fields
.field private mQuietUntil:J


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 0

    .prologue
    .line 24
    invoke-direct {p0, p1}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 25
    return-void
.end method


# virtual methods
.method isQuiet()Z
    .locals 4

    .prologue
    .line 33
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
    .line 48
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v0

    .line 49
    const/16 v1, 0x190

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrPage;->quiet(I)V

    .line 50
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    .line 51
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollY()I

    move-result v1

    if-ge v1, v0, :cond_0

    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->getScrollX()I

    move-result v1

    invoke-virtual {p0, v1, v0}, Lcom/mrkeyboard/app/MrPage;->scrollTo(II)V

    .line 52
    :cond_0
    new-instance v1, Lcom/mrkeyboard/app/MrPage$1;

    invoke-direct {v1, p0, v0}, Lcom/mrkeyboard/app/MrPage$1;-><init>(Lcom/mrkeyboard/app/MrPage;I)V

    invoke-virtual {p0, v1}, Lcom/mrkeyboard/app/MrPage;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V

    .line 59
    return-void
.end method

.method quiet(I)V
    .locals 4

    .prologue
    .line 29
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    int-to-long v2, p1

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/mrkeyboard/app/MrPage;->mQuietUntil:J

    .line 30
    return-void
.end method

.method public requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z
    .locals 1

    .prologue
    .line 39
    invoke-virtual {p0}, Lcom/mrkeyboard/app/MrPage;->isQuiet()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    .line 40
    :goto_0
    return v0

    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroid/widget/ScrollView;->requestChildRectangleOnScreen(Landroid/view/View;Landroid/graphics/Rect;Z)Z

    move-result v0

    goto :goto_0
.end method
